Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6A4EE850
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370246; cv=none; b=q0rwbGva1+KglzyVFWOphBXn7HE/v12bqMGxUu9IZpC8P6Mkggx2ifbgocX5r/2pGvQsEfaqPV13xrctvLhC0itC5gskZtfAF5lWnB3ezvosQg9LR+CZS8nFiK0rrDPga9An9i0HlFoT1paGBh8LvxLgZOdCzRpIMV7n7AVDka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370246; c=relaxed/simple;
	bh=oDFcoy1voIAbJ/dIOfvzZnGVfZGVOYNAVHo3DJEz29w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZPA7QdvOYlTRSANhgSv49u5HCYrWUHZ+v/7neeEn2kPT0i+5DG/IZp5vEmPcWHM8/WSXzoYYgGrvmNLbiKYFFSBMj5Q6EtUlcjIT5QSBa1tZdQqMVyvSqvm3KZhPuCi3m4gvnAUFZDhtO/JKxv+5V7maOv0q4vlxItXKBxsgCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k127uC+T; arc=none smtp.client-ip=91.218.175.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k127uC+T"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oDFcoy1voIAbJ/dIOfvzZnGVfZGVOYNAVHo3DJEz29w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790370241; v=1; x=1790975041;
 b=k127uC+TWp+4gIABkBwpPUH2yi9X5kfV1Cj6/nnOjZnHl0zFx0BWICJYaiHI8MSpdPCQC5Qa
 GV4K+8jbU+d06y6Zk6TKiHTAbzaSasHyj6YlGUyoesCXXCYYHEC3xNlVOMI6JBdPk0RhUbIVO0Y
 mcLgMH7TgU87P95q/R0NTydg=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id bad3a27905a050d9;
	Fri, 25 Sep 2026 21:04:01 +0000
X-Mizu-Trace-ID: bad3a27905a050d9
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
Subject: [PATCH vfs v2] bpf: Allow bpf_d_path() from filp_close_sync()
Date: Fri, 25 Sep 2026 14:03:47 -0700
Message-ID: <20260925210347.1364191-1-ihor.solodrai@linux.dev>
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
c1ed65ea167b ("fs: make close_range() synchronous") switched
close_range() to filp_close_sync(), so the program still attaches but
is never called:

  test_d_path_basic:FAIL:close trampoline for filp_close was not called

With that series, close(), close_range() and the closes on exec and
exit all go through filp_close_sync(). Few paths still reach
filp_close(), dup2() being one of them, so a program on filp_close()
no longer sees most file closes.

Allow bpf_d_path() from filp_close_sync(), but only from fentry.
filp_close_sync() drops the last file reference inline, so by the time
an fexit program runs, file->f_path may already be freed, with no RCU
delay for NORCU dentries such as pipes and sockets.

Attach the selftest program to filp_close_sync() and keep triggering
it with close_range().

Add a test rejecting bpf_d_path() from fexit/filp_close_sync.

Assisted-by: LLM
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

v1->v2:
  * Allow bpf_d_path() from filp_close_sync() only for fentry (bpf-ci-bot)
  * Add a verifier test rejecting bpf_d_path() from fexit/filp_close_sync
v1: https://lore.kernel.org/bpf/20260924204226.190315-1-ihor.solodrai@linux.dev/

The issue was found by BPF CI when running on linux-next:
https://github.com/kernel-patches/bpf/actions/runs/35923662147/job/107398237366
---
 kernel/trace/bpf_trace.c                      | 16 ++++++++++++--
 .../testing/selftests/bpf/prog_tests/d_path.c |  7 ++++---
 .../testing/selftests/bpf/progs/test_d_path.c |  2 +-
 .../selftests/bpf/progs/verifier_d_path.c     | 21 +++++++++++++++++++
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..c3b869646bae 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -974,6 +974,10 @@ BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
 BTF_SET_END(btf_allowlist_d_path)
 
+BTF_SET_START(btf_allowlist_d_path_fentry)
+BTF_ID(func, filp_close_sync)
+BTF_SET_END(btf_allowlist_d_path_fentry)
+
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING &&
@@ -983,8 +987,16 @@ static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 	if (prog->type == BPF_PROG_TYPE_LSM)
 		return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
 
-	return btf_id_set_contains(&btf_allowlist_d_path,
-				   prog->aux->attach_btf_id);
+	if (btf_id_set_contains(&btf_allowlist_d_path,
+				prog->aux->attach_btf_id))
+		return true;
+
+	if (btf_id_set_contains(&btf_allowlist_d_path_fentry,
+				prog->aux->attach_btf_id))
+		return prog->expected_attach_type == BPF_TRACE_FENTRY ||
+		       prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI;
+
+	return false;
 }
 
 BTF_ID_LIST_SINGLE(bpf_d_path_btf_ids, struct, path)
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_d_path.c b/tools/testing/selftests/bpf/progs/verifier_d_path.c
index 87e51a215558..7ab9b6b1d589 100644
--- a/tools/testing/selftests/bpf/progs/verifier_d_path.c
+++ b/tools/testing/selftests/bpf/progs/verifier_d_path.c
@@ -45,4 +45,25 @@ __naked void d_path_reject(void)
 	: __clobber_all);
 }
 
+SEC("fexit/filp_close_sync")
+__description("d_path fexit reject")
+__failure __msg("helper call is not allowed in probe")
+__naked void d_path_fexit_reject(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + 0);				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r6 = 0;						\
+	*(u64*)(r2 + 0) = r6;				\
+	r3 = 8 ll;					\
+	call %[bpf_d_path];				\
+	r0 = 0;						\
+	exit;						\
+	"
+	:
+	: __imm(bpf_d_path)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

base-commit: 6b97d8b942960f55e821df4f618438e3da125887
-- 
2.55.0

