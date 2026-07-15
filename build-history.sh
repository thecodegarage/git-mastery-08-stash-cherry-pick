#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "🚀 Building stash/cherry-pick practice environment..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if src/ directory already exists
if [ -d "src" ]; then
    echo -e "${YELLOW}⚠️  Warning: Practice environment already exists${NC}"
    read -p "Delete and rebuild? This will reset all practice work. (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting. Run script again when ready to reset."
        exit 1
    fi
    
    echo -e "${BLUE}🧹 Cleaning up existing practice environment...${NC}"
    git reset --hard origin/master 2>/dev/null || git reset --hard HEAD~10 2>/dev/null || true
    git branch | grep -v "^\*" | grep -v "master" | grep -v "main" | xargs -r git branch -D 2>/dev/null || true
    rm -rf src/
    echo -e "${GREEN}✅ Cleanup complete${NC}"
    echo ""
fi

echo -e "${BLUE}📁 Creating project structure...${NC}"
mkdir -p src lib utils

# Multi-developer scenario for stash and cherry-pick
export GIT_AUTHOR_NAME="Dev Team"
export GIT_AUTHOR_EMAIL="dev@team.com"
export GIT_COMMITTER_NAME="Dev Team"
export GIT_COMMITTER_EMAIL="dev@team.com"

# Create 40 commits with various changes
for i in {1..40}; do
    export GIT_AUTHOR_DATE="2024-01-$(printf "%02d" $((i/2+1)))T$(printf "%02d" $((i%24))):00:00"
    export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
    
    case $i in
        1)
            cat > src/main.js << 'EOF'
const app = { name: 'Stash Demo' };
module.exports = app;
EOF
            git add src/main.js
            git commit -m "Initial application setup"
            ;;
        2|3|4|5|6)
            echo "// Core feature $i" >> src/main.js
            git add src/main.js
            git commit -m "Core: Add feature $i"
            ;;
        7)
            cat > src/auth.js << 'EOF'
module.exports = { login: () => true };
EOF
            git add src/auth.js
            git commit -m "Add authentication module"
            ;;
        8|9|10|11|12)
            echo "// Auth improvement $i" >> src/auth.js
            git add src/auth.js
            git commit -m "Auth: Enhancement $i"
            ;;
        13)
            cat > lib/database.js << 'EOF'
class Database {
    connect() {}
}
module.exports = Database;
EOF
            git add lib/database.js
            git commit -m "Add database layer"
            ;;
        14|15|16|17|18)
            echo "// DB feature $i" >> lib/database.js
            git add lib/database.js
            git commit -m "Database: Feature $i"
            ;;
        19)
            cat > utils/helpers.js << 'EOF'
module.exports = {
    format: (x) => x.toString()
};
EOF
            git add utils/helpers.js
            git commit -m "Add utility helpers"
            ;;
        20|21|22|23|24)
            echo "// Helper $i" >> utils/helpers.js
            git add utils/helpers.js
            git commit -m "Util: Add helper $i"
            ;;
        25)
            cat > src/api.js << 'EOF'
module.exports = {
    get: () => ({}),
    post: () => ({})
};
EOF
            git add src/api.js
            git commit -m "Add API client"
            ;;
        26|27|28|29|30)
            echo "// API method $i" >> src/api.js
            git add src/api.js
            git commit -m "API: Add method $i"
            ;;
        31)
            cat > src/cache.js << 'EOF'
class Cache {
    set(k, v) {}
    get(k) {}
}
module.exports = Cache;
EOF
            git add src/cache.js
            git commit -m "Add caching system"
            ;;
        32|33|34|35|36)
            echo "// Cache update $i" >> src/cache.js
            git add src/cache.js
            git commit -m "Cache: Update $i"
            ;;
        37|38|39)
            echo "// Final touch $i" >> src/main.js
            git add src/main.js
            git commit -m "Polish: Improvement $i"
            ;;
        40)
            cat > README.md << 'EOF'
# Stash and Cherry-Pick Demo

Practice stashing work and cherry-picking specific commits.
EOF
            git add README.md
            git commit -m "Add README"
            ;;
    esac
done

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo -e "${BLUE}📊 Created 40 commits for stash/cherry-pick practice${NC}"
echo ""
echo "Next steps:"
echo "  1. Verify: git log --oneline"
echo "  2. Start exercises: open EXERCISES.md"
echo ""
echo "To reset and start over, just run ./build-history.sh again"
