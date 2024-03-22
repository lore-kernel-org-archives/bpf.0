Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE194652D
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115382; cv=none; b=K68gLSssLPBWTL769/dyq+s3tMOZslevfmniGgLuNjRHfGvI5g5103KKHELz+XSsL2COUE2hQVg/E71YvhRpILCHAnlfGl25u7MLwbx1KpRCol2tcRsCh5loLQjDC3TilRbRt0e7kHSdeGYi+HB8Nnr+WQEK4q67jcFOgqXwNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115382; c=relaxed/simple;
	bh=qrLpwXZtTXA/dWoDWgczyg7OaT4LDC9uDn2PSyAkbfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUhWLW+c0hPGjWIY7fJg0cDPoXWoLFaT3CYb+YLc/X2gHD/O01ZPZIgLxPnY7obOfHLv/EwawbuTWYwn5yZ2GH+3l6HqpR8WchrDhaZrrKkXLXKhbd91v9ckoMNZecuSFcT/Wfkp2I5pxXQBbAGCByoG1xQp816aBoilNPpUqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfghduxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfghduxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEAEC433F1;
	Fri, 22 Mar 2024 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711115381;
	bh=qrLpwXZtTXA/dWoDWgczyg7OaT4LDC9uDn2PSyAkbfk=;
	h=From:To:Cc:Subject:Date:From;
	b=bfghduxOEw3vqOsf6/L9pjH+pWp6G+3CHrjfPNWGrHcXxAf1PIMZMIyecZ/z8Fx1F
	 zvaVea+BCvWQEK46NNLEzI6tIbvgHMwvBKw9sTB4zaJFho1EfWzpsL2UNiFKyHrlOP
	 o6Nu8jKbwUSlgn6Zy1ciH1f9uSpE4bM+e7oUJYPquTpNaTHUndqktpLHhGRoNaQ71U
	 AKiMkgf01Lvcy+4M6QxEvKPuqAkv7AK2amfAPl7ZHpiDEkcaa1oLczEQ2z47bQU2ZR
	 pGLhCfHJBwD4NWhIYoOOfk5RZa9KkZTHJ5Wxih1URst19aYtsuDdlGY4Oh5VTis1Us
	 yaPpj6vUDR34Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next] selftests/bpf: Mark uprobe trigger functions with nocf_check attribute
Date: Fri, 22 Mar 2024 14:49:36 +0100
Message-ID: <20240322134936.1075395-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distros seem to enable the -fcf-protection=branch by default,
which breaks our setup on first instruction of uprobe trigger
functions and place there endbr64 instruction.

Marking them with nocf_check attribute to skip that.

Ignoring unknown attribute warning in gcc for bench objects, because
nocf_check can be used only when -fcf-protection=branch is enabled,
otherwise we get a warning and break compilation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
  - posting separately from uretprobe syscall patchset
  - keep the attribute name __nocf_check [Andrii]

 tools/include/linux/compiler.h                     | 4 ++++
 tools/testing/selftests/bpf/benchs/bench_trigger.c | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 7b65566f3e42..8a63a9913495 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -58,6 +58,10 @@
 #define noinline
 #endif
 
+#ifndef __nocf_check
+#define __nocf_check __attribute__((nocf_check))
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index b7aea79495ba..c1f8fb8d2dca 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -9,6 +9,8 @@
 /* adjust slot shift in inc_hits() if changing */
 #define MAX_BUCKETS 256
 
+#pragma GCC diagnostic ignored "-Wattributes"
+
 /* BPF triggering benchmarks */
 static struct trigger_ctx {
 	struct trigger_bench *skel;
@@ -167,7 +169,7 @@ static void trigger_fmodret_setup(void)
  * GCC doesn't generate stack setup preample for these functions due to them
  * having no input arguments and doing nothing in the body.
  */
-__weak void uprobe_target_nop(void)
+__nocf_check __weak void uprobe_target_nop(void)
 {
 	asm volatile ("nop");
 }
@@ -176,7 +178,7 @@ __weak void opaque_noop_func(void)
 {
 }
 
-__weak int uprobe_target_push(void)
+__nocf_check __weak int uprobe_target_push(void)
 {
 	/* overhead of function call is negligible compared to uprobe
 	 * triggering, so this shouldn't affect benchmark results much
@@ -185,7 +187,7 @@ __weak int uprobe_target_push(void)
 	return 1;
 }
 
-__weak void uprobe_target_ret(void)
+__nocf_check __weak void uprobe_target_ret(void)
 {
 	asm volatile ("");
 }
-- 
2.44.0

