Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5742366540;
	Tue, 20 Jan 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933253; cv=none; b=PoNbWhANaHWGgmjcczi7Sj5I8CzhwJA46gXPalupoVqcoZ8YuKJP1jnNj6XVqibAUfze6OUgFD88nR2uIK7cxqbwWO7KtAjPKRylA5XCUraqkUErE9j2EyIqZnkevGQQne3W+Ssvtjry6a3onSkbYqopursYgcFfkdiWrwaHCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933253; c=relaxed/simple;
	bh=rr573QidU3iAi/lvnpGtvA5TtBvZUkHLZPl7uHktzLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA3Sljtajm9DmEvOfWvYYOEvjZQBbthDK9kUSbDFWTpDStayiLhET3mvMFWNDoJccFlzbf61ZjeoU6pn7D51FUrN7HbLRPFfF1fywAMBdgGEH0jLujhu1a14NAE3LUYHQSLkK6WF4vlnXVO0SxabiC8nP898SXSp78z7EDY63dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRblidTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRblidTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C5EC16AAE;
	Tue, 20 Jan 2026 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768933253;
	bh=rr573QidU3iAi/lvnpGtvA5TtBvZUkHLZPl7uHktzLQ=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=sRblidTwtARRi2PQoc8ElNupT9MkusGhgZsxkCA2n/JZadoZlYh/1PWW2AdwnfLR4
	 fJfkPj9FB9jEnHWMgFgnzXWHkCKsS5xn6QmY2CWl8ERa0wMEsU+Ehap9SEVsLTfgth
	 0qcpacYVnNe50Zrz1ivaSrPV9amIeLooOqXba41IurQEZFcOTdoA5d5/jxm4mUVkPY
	 hi7LMzGU0YKQlIoFAouke+6kCYTbyPLP8l5kMTP2X5V0BxpgCyD7I+RnapI3ZhR19M
	 y7CcjK7CPao+LEL7NPC0R0wNoFb9E/uY6K56c4+OYWD72T5icLWSWc+2OnGw2LCuaX
	 tEXN34QOKlpBw==
From: Gary Guo <gary@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Gary Guo <gary@garyguo.net>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
Date: Tue, 20 Jan 2026 18:20:33 +0000
Message-ID: <20260120182034.3647092-1-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

NixOS only puts /usr/bin/env and /bin/sh at the standard location as
required by POSIX, but not other shells. Other program that kernel build
depends on is supplied via PATH, so shebang needs to use /usr/bin/env to
find them.

This has been done to a few other scripts already, e.g.
gen_test_kallsyms.sh or decode_stacktrace.sh.

Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 scripts/gen-btf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index be21ccee3487..4cd3159f2ddb 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
 #

base-commit: 053966c344dbd346e71305f530e91ea77916189f
-- 
2.51.2

