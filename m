Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1D4CC262
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282566; cv=none; b=MbbPPT+ZqWerF4DJDqdkBt2+ySf/FuSTXhM5/lcVZO9gjpgS7j+JJfiH9LDhxeln6LJyhsUsHd7lvvIOMwxUFsxxRPUXoBcskuRBVj9FpmAqEqYiDKBfPLtAUjvfF8bwpRXyBPOeS7+FaYuu5E5STGA/N2ivKjmIBNmIf7gWB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282566; c=relaxed/simple;
	bh=Z82U3XRqT23tKBcS4svTG3IWK2zApncZW1pF4pyw0Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWk0paFBLrDQT9AooS6d+Ul59sKYV6334SnT1auYa4jMs+lTbxmdcOwymIOO9GfA3xOW8k25RyR5tJOhjWsY0WMnN48QH9ClR8IBctMqxyekSDit5hV2bcNI7Ng9L/2QCr8twWIP/FIlcfq0Ab3rSvVdKu/t1OBeM9Nr8bnPSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C4rDtznz; arc=none smtp.client-ip=91.218.175.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C4rDtznz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z82U3XRqT23tKBcS4svTG3IWK2zApncZW1pF4pyw0Fw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790282557; v=1; x=1790887357;
 b=C4rDtznzvhC4FzeARRXzWfxa+kcWq0N8oTbppJyImthDnAhfwxivbU/5aoB/14PodEwzmi9B
 RPDJfCW2Il6gK7dj3/ScJgybSMPfIdVLads9qyHwFLFhlmzY9nL/Qko3uVKDfCaJAcByeaG84Bz
 2rQtnQYlT+BuqjiISiAaS5rc=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2e7ab4009d700ec9;
	Thu, 24 Sep 2026 20:42:37 +0000
X-Mizu-Trace-ID: 2e7ab4009d700ec9
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH vfs v1] bpf: Allow bpf_d_path() from filp_close_sync()
Date: Thu, 24 Sep 2026 13:42:26 -0700
Message-ID: <20260924204226.190315-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The d_path selftest closes its descriptors with close_range() so that
its fentry program on filp_close() runs. The vfs commit
46ace7e4dc4b ("fs: make close_range() synchronous") switched
close_range() to filp_close_sync(), so the program still attaches but
is never called:

  test_d_path_basic:FAIL:close trampoline for filp_close was not called

With that series, close(), close_range() and the closes on exec and
exit all go through filp_close_sync(). Few paths still reach
filp_close(), dup2() being one of them, so a program on filp_close()
no longer sees most file closes.

Allow bpf_d_path() from filp_close_sync(). It takes the same arguments
as filp_close() and the program runs before the file is flushed and
its last reference is dropped, so file->f_path is still valid. Keep
filp_close() in the allowlist for existing programs.

Attach the selftest program to filp_close_sync() and keep triggering
it with close_range(), since filp_close_sync() may be inlined into
close().

Assisted-by: LLM
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

The issue was found by BPF CI when running on linux-next:
https://github.com/kernel-patches/bpf/actions/runs/35923662147/job/107398237366
---
 kernel/trace/bpf_trace.c                        | 1 +
 tools/testing/selftests/bpf/prog_tests/d_path.c | 7 ++++---
 tools/testing/selftests/bpf/progs/test_d_path.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..09a27810ca27 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -972,6 +972,7 @@ BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
 BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
+BTF_ID(func, filp_close_sync)
 BTF_SET_END(btf_allowlist_d_path)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 1a2a2f1abf03..7665e1d28a64 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -109,8 +109,9 @@ static int trigger_fstat_events(pid_t pid)
 	fstat(indicatorfd, &fileStat);
 
 out_close:
-	/* sys_close no longer triggers filp_close, but we can
-	 * call sys_close_range instead which still does
+	/*
+	 * filp_close_sync() may be inlined into close(2), so use
+	 * close_range(2), which calls it directly.
 	 */
 	syscall_close(pipefd[0]);
 	syscall_close(pipefd[1]);
@@ -165,7 +166,7 @@ static void test_d_path_basic(void)
 
 	if (CHECK(!bss->called_close,
 		  "close",
-		  "trampoline for filp_close was not called\n"))
+		  "trampoline for filp_close_sync was not called\n"))
 		goto cleanup;
 
 	for (int i = 0; i < MAX_FILES; i++) {
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 561b2f861808..edb5494a47f7 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -41,7 +41,7 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
 	return 0;
 }
 
-SEC("fentry/filp_close")
+SEC("fentry/filp_close_sync")
 int BPF_PROG(prog_close, struct file *file, void *id)
 {
 	pid_t pid = bpf_get_current_pid_tgid() >> 32;
-- 
2.55.0

