Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA63253F05
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770767973; cv=none; b=OeqHxV9uppN525nZ/zq0bqW0VaDq2dtCWGPwYFm2N41YfCnvrje8EWaj13VfDS94Oti/jO3qmzuxLd4RGshDEwwYxO1MWCLgL/VmWau7tHhAvat/MCzYx8pZLRFROmqDavV2ExRTRYkbF9qao4mALMqJ+y0lEb03JQIf2DN8I3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770767973; c=relaxed/simple;
	bh=0S7997k9/hugXluLfTc7wxEeSwCSJGMGlODugbTTiYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G68BDJfvOIH7Ijm0z26zJolUD+ARTvsR7HXwh13vTEf47IaJ1PwB0s4c/IZJgGl3GJ5cemVkdLSnMjFhoiPVpNtnfWbBaPlTwWpH+rEmlopx11lKpDIwAN50b4YNtAWa76e4QY6vbYsdlFezvYU5f4kRTKFXlsdZEiRkwL7tgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iAigVeGp; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iAigVeGp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770767959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AIOeSr2iKXtEdjvYZtwRC7mAPiVdCmPk1YFkkLr0eYc=;
	b=iAigVeGp8nxlSD2nHZgB0kJ90jp0QBab4qvoAzWJCe2ztvdB6dFrShc1JHQcn28Xa6ojVn
	NMv8WCC+U4qF8ZtayIWsko0ffPZ3FULDTwc/MpV0BF5+26MiNW5ZGs0BZUGRTxqgwk2bZY
	8OmOoe6hS36DEi2aekIPEbXPPDK373I=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Rename do_filp_open() to do_file_open()
Date: Tue, 10 Feb 2026 15:58:55 -0800
Message-ID: <20260210235855.215679-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

do_filp_open() was renamed (fixing typo) in commit
541003b576c3 ("rename do_filp_open() to do_file_open()")

This broke test_profiler, because it uses a kretprobe on that
function. Fix it by renaming accordingly.

Fixes: 541003b576c3 ("rename do_filp_open() to do_file_open()")
Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Closes: https://lore.kernel.org/bpf/djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw/
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/progs/profiler.h     | 2 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/profiler.h b/tools/testing/selftests/bpf/progs/profiler.h
index 3bac4fdd4bdf..637fbf2c2652 100644
--- a/tools/testing/selftests/bpf/progs/profiler.h
+++ b/tools/testing/selftests/bpf/progs/profiler.h
@@ -169,7 +169,7 @@ enum bpf_function_id {
 	profiler_bpf_sched_process_exec,
 	profiler_bpf_sched_process_exit,
 	profiler_bpf_sys_enter_kill,
-	profiler_bpf_do_filp_open_ret,
+	profiler_bpf_do_file_open_ret,
 	profiler_bpf_sched_process_fork,
 	profiler_bpf_vfs_link,
 	profiler_bpf_vfs_symlink,
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 813143b4985d..9044dd8aff11 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -751,11 +751,11 @@ int raw_tracepoint__sched_process_exec(struct bpf_raw_tracepoint_args* ctx)
 	return 0;
 }
 
-SEC("kretprobe/do_filp_open")
-int kprobe_ret__do_filp_open(struct pt_regs* ctx)
+SEC("kretprobe/do_file_open")
+int kprobe_ret__do_file_open(struct pt_regs *ctx)
 {
 	struct bpf_func_stats_ctx stats_ctx;
-	bpf_stats_enter(&stats_ctx, profiler_bpf_do_filp_open_ret);
+	bpf_stats_enter(&stats_ctx, profiler_bpf_do_file_open_ret);
 
 	struct file* filp = (struct file*)PT_REGS_RC_CORE(ctx);
 
-- 
2.53.0

