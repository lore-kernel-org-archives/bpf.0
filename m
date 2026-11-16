Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808729;
	b=MjpZI1t6x5nP66TwyCdlNdQMncsDdAHCuEY+D74EdRJA9OvvErQSpj95sjK5g/mgnmj/
	 VDefBHq7n/Fo1Vwsqba2uOGig1fHjwPI5P9LLSNYku0fidhaCMgANisqO50o4ERjF3emr
	 7YfMmi/RFM4Inq8J7MW2F8/NdCaxiPrObnq2tF0yGghtEi3p+7oBMUh5O3pQr9cPZN62Z
	 vd/JR6bNEn3CKM4g+7VYMK8XKmCQzgaZGHNP8bSxcnEO3fwgcwUUEeOxlqP3+uy8V0Tfr
	 teVOFawguXmInoY9ZNCVi9/sdmWK5p6TFjAIp+xnlLjizdw7jNF8A0mzzWMfKF5fptg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Xn3Z7K1sMfj3CM/bpGKM2W2BrppNTiiFLyUVjyvDw4=;
	b=1f/Bie+wruWsAqC4B9HLtwaEBUlbDz2W4ieNUru8tIEFVeWizMDpVeIsOU4oAPzdz3CN
	 EcuyoyAMVsi9zmAC4dkHahSeZ9hToXNQTfxPwTcQ5401D+AdWpIsf09CaxMy5cmopTZeI
	 t0yPEE8F0yGYeuXkmOJc4GqymN5bYAiMtg2zfEm2lU9qEMghB4TzTYojtZwDP+imsD8Mu
	 USPJabswOurDZn2KlsDCXulbIj6hrh1EAXYzfoKII31pXVQ9fHbbjr8aXRxLRJzEb3sJK
	 ZDU9nO/EUlHvRoVzKke74xj10kAyW/0yOGsQRG2G97kw0qt6enILfodSke3aHPF39HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GEw+rGT;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06925606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06925606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GEw+rGT
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so2154001a91.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808728; x=1795413528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Xn3Z7K1sMfj3CM/bpGKM2W2BrppNTiiFLyUVjyvDw4=;
        b=0GEw+rGTFzJdG5Z1/VuK9z9ncsnGrGuuQdSRXtypJuf8ijmbVIodB8gy2tuxd/parF
         WsVLki0Ka29ITR8iJZV5WlO2xP/R6sD1+qe2XyCl9DAmeZhB5+i9UdilBV2BSQmFnJVM
         WOQRodFn7Tzn+Hs+Z7QeqLxhKA+1FUltSFohsxrAc9XmdWIKxWjOiXd0vlQnmY1/+UeJ
         nwd0DlrjLSEz5XrDafo+9usRgvaKxIpvFnaXp6avGasTSt9lSFLCKZJIAP4AeLDAz7TO
         8rmKZIK1CXDM7bpWsm1L3fIFH18R/5CJ5VgfvdF5FiHsFhGCOOf8ZcYv0EJkwNaB/d+2
         6XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808728; x=1795413528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Xn3Z7K1sMfj3CM/bpGKM2W2BrppNTiiFLyUVjyvDw4=;
        b=MHT0MqFVFO7bfmcIs2fHvTC0YXZXCqzO/qqyyJMgJBO8nF9AQWjvVjjhD+iuvuGFvV
         RWLFA0olY1EiRm4J2cmqPdEq649mxPMsvdx4Nxi9bd7FNhertY5TuVa5eM80KS19plZ6
         jQjHkD/1KcVehuLmcRI3S0GV30wvwycU/olCAGb8TcKljIFsGJPOdJsjG9/ZvkjhT3ZE
         kdUHPXC/vW48opzjqWBXCU6UYobKDS7XaE5SEYby8JObo0PZgTbdY29U/Nf4P9vPrwe1
         x1Il91tXnRtE78dZB72rk8EMQiCf6duZOwc25H3NaoBr+W7+iu7UFbqimvXug+AxN3XV
         x8PQ==
X-Gm-Message-State: APuU4Z+S4a4E+Ia81UbtE0COc9qnX0icWKi20+71AbishEf5jY4L7drM
	j2gn47MPSUUBaUKlCLc/zwIgES5996DFfbMqeNifiQ2mSIiKbfm8YOmJr59tsw==
X-Gm-Gg: AZFdTZfH07ztKDsoX5B9q1AWqP1btqoIvPGEBAd+fue+d3u+V/0yE7aIgJ9FHzbaP+/
	ZVmbRbxqQmL0KIyX4YQGbm5FbTpocENMBXPYgix92vdRYLZw4Zq0/GcMI9xk4p+HGcMiBUqOtUU
	yeSqksa2OBC4GPOYkeYnnnkSml/5nyiyjME2iOextZ9kULPA32R3HTm1BwP2kXYyNoXgmoxxqYV
	uZxyX4T2KM80hT7nYD7Nt7SZWzcwXMVHzrhwwfcxEgmxAKpz7Bbjx8eicK5kVm98qBgfVX44PA0
	ESLv1INHJoPzGbUCIICC+D4cexSN/68ZIopamLUf22AFOUz2T4UrJA3Jxq8RdEV8c2Wq02yuo+E
	aAih1astLUSrXnCCs9S5EzBxda/bJ/zS6bPM57uIzE5oxP7P0hka9FcTjqYege8DawHsLOaGveG
	Lq4OdpFj9a4wIRRWW917a/kRdgw6eVBNZjo9QwqaEPrFhSCHPDYAZHJ1oWW7CwHZp7v08UKbRFx
	6YGtFX/EypUv7BCYzK7wpYVOnRMhEk/TyCS9uaz/Ngl3NOKJmQYMVqDsa+6419EuAUaWG/4y/lp
	eeSqT3hlyV/MFcf1hoiD0E0fmUo7xljlhnfcf0HVlkXvH9SGzNzaPv/3ujxKbn7ji6WFbK3cAvW
	9KhTsLD6aDTGInyBaa6qjt5Ts5RWxOIHIAM1MaQnjwB9okmrOZE7XssizAfATiOfZo+MdEOs1DA
	==
X-Received: by 2002:a17:90b:2e06:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b1b07e1cd4mr8790490a91.6.1794808728096;
        Sun, 15 Nov 2026 21:58:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm8259176a91.3.2026.11.15.21.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:58:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 21/21] selftests/bpf: Test limits of the load with raw programs
Date: Mon, 16 Nov 2026 05:56:38 +0000
Message-ID: <20261116055638.4171529-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A load under a timer signal, under the freezer and in a small memory
cgroup, the context of a syscall program, 33000 subprogs, a dump of more
than 4 MB, 300 kfuncs, loops of BTF types, long BTF names, a light
skeleton with 600 maps and 601 programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   2 +-
 .../selftests/bpf/prog_tests/no_limits.c      | 457 ++++++++++++++++++
 .../testing/selftests/bpf/progs/many_progs.c  |  36 ++
 3 files changed, 494 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/no_limits.c
 create mode 100644 tools/testing/selftests/bpf/progs/many_progs.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index b8eaecc7f429..45e4ce5dca4d 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -34,7 +34,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
-	test_ringbuf_overwrite.c callx_rodata.c
+	test_ringbuf_overwrite.c callx_rodata.c many_progs.c
 
 LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
diff --git a/tools/testing/selftests/bpf/prog_tests/no_limits.c b/tools/testing/selftests/bpf/prog_tests/no_limits.c
new file mode 100644
index 000000000000..2c9e5855f306
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/no_limits.c
@@ -0,0 +1,457 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Limits of the load that an ELF file cannot show, or shows at a high price */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <sys/param.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include "cgroup_helpers.h"
+#include "many_progs.lskel.h"
+
+static int load(struct bpf_insn *insns, int cnt)
+{
+	return bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, NULL, "GPL", insns, cnt, NULL);
+}
+
+static struct bpf_insn *straight_code(int cnt)
+{
+	struct bpf_insn *insns = calloc(cnt, sizeof(*insns));
+	int i;
+
+	if (!ASSERT_OK_PTR(insns, "insns"))
+		return NULL;
+	for (i = 0; i < cnt - 1; i++)
+		insns[i] = BPF_MOV64_IMM(BPF_REG_0, i);
+	insns[i] = BPF_EXIT_INSN();
+	return insns;
+}
+
+static void on_alarm(int sig)
+{
+}
+
+/* A signal that does not kill does not stop the load */
+static void test_signals(void)
+{
+	struct itimerval on = { { 0, 200 }, { 0, 200 } }, off = {};
+	struct sigaction sa = { .sa_handler = on_alarm }, old;
+	struct bpf_insn *insns = straight_code(20000);
+	int fd;
+
+	if (!insns)
+		return;
+	sigaction(SIGALRM, &sa, &old);
+	setitimer(ITIMER_REAL, &on, NULL);
+	fd = load(insns, 20000);
+	setitimer(ITIMER_REAL, &off, NULL);
+	sigaction(SIGALRM, &old, NULL);
+	if (ASSERT_OK_FD(fd, "load"))
+		close(fd);
+	free(insns);
+}
+
+static int exit_code(pid_t pid)
+{
+	int status;
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "wait") ||
+	    !ASSERT_TRUE(WIFEXITED(status), "exited"))
+		return -1;
+	return WEXITSTATUS(status);
+}
+
+/* The freezer does not wait for the end of the load. The load starts again after it. */
+static void test_freezer(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .attempts = 1);
+	struct bpf_insn *insns = straight_code(200000);
+	int cg = -1, pipes[2] = { -1, -1 }, fd;
+	char buf[64] = "";
+	pid_t pid;
+
+	if (!insns || !ASSERT_OK(setup_cgroup_environment(), "setup") ||
+	    !ASSERT_OK(pipe(pipes), "pipe"))
+		goto out;
+	cg = create_and_get_cgroup("/no_limits");
+	if (!ASSERT_OK_FD(cg, "cgroup"))
+		goto out;
+	pid = fork();
+	if (!pid) {
+		/* the fd that the prog gets */
+		if (join_parent_cgroup("/no_limits"))
+			_exit(1);
+		fd = dup(pipes[0]);
+		close(fd);
+		if (write(pipes[1], &fd, sizeof(fd)) != sizeof(fd))
+			_exit(2);
+		_exit(bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, NULL, "GPL", insns, 200000,
+				    &opts) != fd ? 3 : 0);
+	}
+	close(pipes[1]);
+	if (ASSERT_EQ(read(pipes[0], &fd, sizeof(fd)), sizeof(fd), "read")) {
+		usleep(10000);
+		ASSERT_OK(write_cgroup_file("/no_limits", "cgroup.freeze", "1"), "freeze");
+		while (!strstr(buf, "frozen 1") &&
+		       !read_cgroup_file("/no_limits", "cgroup.events", buf, sizeof(buf)))
+			usleep(1000);
+		snprintf(buf, sizeof(buf), "/proc/%d/fd/%d", pid, fd);
+		ASSERT_ERR(faccessat(AT_FDCWD, buf, F_OK, AT_SYMLINK_NOFOLLOW), "no prog yet");
+		ASSERT_OK(write_cgroup_file("/no_limits", "cgroup.freeze", "0"), "thaw");
+	}
+	ASSERT_OK(exit_code(pid), "load");
+out:
+	close(pipes[0]);
+	if (cg >= 0)
+		close(cg);
+	cleanup_cgroup_environment();
+	free(insns);
+}
+
+/* 4 * funcs + 1 insns */
+static struct bpf_insn *many_funcs(int funcs)
+{
+	struct bpf_insn *insns = calloc(4 * funcs + 1, sizeof(*insns)), *f;
+	int i;
+
+	if (!ASSERT_OK_PTR(insns, "insns"))
+		return NULL;
+	for (i = 0, f = insns + funcs + 1; i < funcs; i++) {
+		insns[i] = BPF_CALL_REL(f - &insns[i] - 1);
+		*f++ = BPF_MOV64_IMM(BPF_REG_0, i);
+		*f++ = BPF_MOV64_IMM(BPF_REG_2, 0);
+		*f++ = BPF_EXIT_INSN();
+	}
+	insns[funcs] = BPF_EXIT_INSN();
+	return insns;
+}
+
+static int load_in_memcg(struct bpf_insn *insns, int cnt)
+{
+	pid_t pid = fork();
+	int fd;
+
+	if (pid)
+		return exit_code(pid);
+	fd = join_parent_cgroup("/no_limits") ? -EINVAL : load(insns, cnt);
+	_exit(fd < 0 ? -fd : 0);
+}
+
+/* The load fails. The OOM killer leaves the loader alone. */
+static void test_memcg(void)
+{
+	struct bpf_insn *insns = straight_code(200000), *funcs = many_funcs(2000);
+	int cg = -1, mb, err;
+	char max[16];
+
+	if (!insns || !funcs || !ASSERT_OK(setup_cgroup_environment(), "setup"))
+		goto out;
+	cg = create_and_get_cgroup("/no_limits");
+	if (!ASSERT_OK_FD(cg, "cgroup"))
+		goto out;
+	if (write_cgroup_file("/no_limits", "memory.max", "16M")) {
+		test__skip();
+		goto out;
+	}
+	ASSERT_EQ(load_in_memcg(insns, 200000), ENOMEM, "errno");
+
+	/* some of these end in the JIT of the subprogs */
+	for (mb = 4; mb <= 24; mb += 2) {
+		snprintf(max, sizeof(max), "%dM", mb);
+		ASSERT_OK(write_cgroup_file("/no_limits", "memory.max", max), "max");
+		err = load_in_memcg(funcs, 4 * 2000 + 1);
+		ASSERT_TRUE(!err || err == ENOMEM, "errno");
+	}
+out:
+	if (cg >= 0)
+		close(cg);
+	cleanup_cgroup_environment();
+	free(insns);
+	free(funcs);
+}
+
+static int run(int fd)
+{
+	char pkt[64] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = pkt, .data_size_in = sizeof(pkt));
+
+	return bpf_prog_test_run_opts(fd, &opts) ?: opts.retval;
+}
+
+/* The target of a tail call reads the context at 'off'. The run passes 8 bytes. */
+static void check_syscall_target(int off, int expected)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags = BPF_F_SLEEPABLE);
+	int map = bpf_map_create(BPF_MAP_TYPE_PROG_ARRAY, NULL, 4, 4, 1, NULL);
+	struct bpf_insn first[] = {
+		BPF_LD_MAP_FD(BPF_REG_2, map),
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+		BPF_EMIT_CALL(BPF_FUNC_tail_call),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+	}, target[] = {
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, off),
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ctx[2] = { 5, 7 }, key = 0, fd, target_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, run_opts, .ctx_in = ctx, .ctx_size_in = sizeof(ctx));
+
+	fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", first, ARRAY_SIZE(first), &opts);
+	target_fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", target, ARRAY_SIZE(target),
+				  &opts);
+	if (ASSERT_OK_FD(fd, "load") && ASSERT_OK_FD(target_fd, "target"))
+		ASSERT_EQ(bpf_map_update_elem(map, &key, &target_fd, 0) ?:
+			  bpf_prog_test_run_opts(fd, &run_opts) ?: (int)run_opts.retval,
+			  expected, "result");
+	close(fd);
+	close(target_fd);
+	close(map);
+}
+
+static void test_syscall_ctx(void)
+{
+	int off;
+
+	check_syscall_target(4, 7);
+	for (off = 8; off < 65532; off += 4096)
+		check_syscall_target(off, 0);
+}
+
+/* The number of a subprog does not fit into s16 */
+static void test_subprogs(void)
+{
+	const int funcs = 33000, cnt = 4 * funcs + 1;
+	struct bpf_insn *insns = many_funcs(funcs);
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+	int fd;
+
+	if (!insns)
+		return;
+	fd = load(insns, cnt);
+	if (!ASSERT_OK_FD(fd, "load"))
+		goto out;
+	ASSERT_EQ(run(fd), funcs - 1, "retval");
+	info.xlated_prog_len = cnt * sizeof(*insns);
+	info.xlated_prog_insns = ptr_to_u64(insns);
+	if (ASSERT_OK(bpf_prog_get_info_by_fd(fd, &info, &len), "dump"))
+		ASSERT_EQ(insns[funcs - 1].imm, funcs, "subprog");
+	close(fd);
+out:
+	free(insns);
+}
+
+/* A division takes 4 insns. The dump has more than 4 MB. */
+static void test_dump(void)
+{
+	const int cnt = 140000;
+	struct bpf_insn *insns = straight_code(4 * cnt);
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+	int fd, i;
+
+	if (!insns)
+		return;
+	insns[0] = BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32);
+	insns[1] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+	for (i = 2; i < cnt - 1; i++)
+		insns[i] = BPF_ALU64_REG(BPF_DIV, BPF_REG_0, BPF_REG_1);
+	insns[i] = BPF_EXIT_INSN();
+
+	fd = load(insns, cnt);
+	if (ASSERT_OK_FD(fd, "load")) {
+		info.xlated_prog_len = 4 * cnt * sizeof(*insns);
+		info.xlated_prog_insns = ptr_to_u64(insns);
+		if (ASSERT_OK(bpf_prog_get_info_by_fd(fd, &info, &len), "dump"))
+			ASSERT_GT(info.xlated_prog_len, 4 << 20, "len");
+		close(fd);
+	}
+	free(insns);
+}
+
+/* Calls of all kfuncs that the verifier can describe, in dead code */
+static void test_kfuncs(void)
+{
+	struct btf *btf = btf__load_vmlinux_btf();
+	struct bpf_insn insns[1024], one[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+		BPF_EXIT_INSN(),
+	};
+	const struct btf_type *t;
+	int id, fd, cnt = 2;
+
+	if (!ASSERT_OK_PTR(btf, "btf"))
+		return;
+	for (id = 1; id < btf__type_cnt(btf) && cnt < 302; id++) {
+		t = btf__type_by_id(btf, id);
+		if (!btf_is_func(t) || strncmp(btf__name_by_offset(btf, t->name_off), "bpf_", 4))
+			continue;
+		one[2].imm = id;
+		fd = load(one, ARRAY_SIZE(one));
+		if (fd < 0)
+			continue;
+		close(fd);
+		insns[cnt++] = one[2];
+	}
+	btf__free(btf);
+	if (cnt < 302) {
+		test__skip();
+		return;
+	}
+	insns[0] = one[0];
+	insns[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, cnt - 2);
+	insns[cnt++] = one[3];
+	fd = load(insns, cnt);
+	if (ASSERT_OK_FD(fd, "load"))
+		close(fd);
+}
+
+/* Type 1 is int, type 'value' is the value of a map */
+static void check_btf(struct btf *btf, int value, int expected)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .btf_key_type_id = 1, .btf_value_type_id = value);
+	int fd;
+
+	if (ASSERT_EQ(btf__load_into_kernel(btf), expected, "load") && !expected) {
+		opts.btf_fd = btf__fd(btf);
+		fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 4, 1, &opts);
+		if (ASSERT_OK_FD(fd, "map"))
+			close(fd);
+	}
+	btf__free(btf);
+}
+
+static struct btf *new_btf(void)
+{
+	struct btf *btf = btf__new_empty();
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	return btf;
+}
+
+enum chain { STRUCTS, ARRAYS, TYPEDEFS, DAG };
+
+/* Type 2 holds type 3, ... The last one holds type 'last'. */
+static struct btf *btf_chain(enum chain kind, int cnt, int last)
+{
+	struct btf *btf = new_btf();
+	int i, next;
+
+	for (i = 2; i < cnt + 2; i++) {
+		next = i == cnt + 1 ? last : i + 1;
+		if (kind == ARRAYS) {
+			btf__add_array(btf, 1, next, 1);
+		} else if (kind == TYPEDEFS) {
+			btf__add_typedef(btf, "t", next);
+		} else {
+			btf__add_struct(btf, "s", 4);
+			btf__add_field(btf, "a", next, 0, 0);
+			if (kind != DAG)
+				continue;
+			btf__add_field(btf, "b", next, 0, 0);
+			btf__add_field(btf, "c", next, 0, 0);
+		}
+	}
+	return btf;
+}
+
+static void test_btf(void)
+{
+	static char name[4098];
+	struct btf *btf;
+	enum chain kind;
+	int i;
+
+	for (kind = STRUCTS; kind <= DAG; kind++) {
+		check_btf(btf_chain(kind, 30, 1), 2, 0);
+		check_btf(btf_chain(kind, 30, 2), 2, -EEXIST);
+	}
+
+	/* 1M kptrs in a struct that nobody can allocate */
+	btf = new_btf();
+	btf__add_struct(btf, "task_struct", 4);
+	btf__add_field(btf, "a", 1, 0, 0);
+	btf__add_type_tag(btf, "kptr", 2);
+	btf__add_ptr(btf, 3);
+	btf__add_array(btf, 1, 4, 1000000);
+	for (i = 0; i < 100; i++) {
+		btf__add_struct(btf, "s", 8000008);
+		btf__add_field(btf, "p", 4, 0, 0);
+		btf__add_field(btf, "a", 5, 64, 0);
+	}
+	check_btf(btf, 1, 0);
+
+	/* ptr -> typedef -> struct -> array -> typedef */
+	btf = new_btf();
+	btf__add_ptr(btf, 3);
+	btf__add_typedef(btf, "t", 4);
+	btf__add_struct(btf, "s", 4);
+	btf__add_field(btf, "a", 5, 0, 0);
+	btf__add_array(btf, 1, 3, 1);
+	check_btf(btf, 4, -EEXIST);
+
+	/* ptr -> typedef -> array -> typedef */
+	btf = new_btf();
+	btf__add_ptr(btf, 3);
+	btf__add_typedef(btf, "t", 4);
+	btf__add_array(btf, 1, 3, 1);
+	check_btf(btf, 4, -EEXIST);
+
+	memset(name, 'x', 4097);
+	btf = new_btf();
+	btf__add_typedef(btf, name, 1);
+	check_btf(btf, 2, -EINVAL);
+
+	name[4096] = 0;
+	btf = new_btf();
+	btf__add_typedef(btf, name, 1);
+	check_btf(btf, 2, 0);
+
+	name[4000] = 7;
+	btf = new_btf();
+	btf__add_typedef(btf, name, 1);
+	check_btf(btf, 2, -EINVAL);
+}
+
+/* 600 maps and 601 programs */
+static void test_lskel(void)
+{
+	struct rlimit old, new = { 4096, 4096 };
+	struct many_progs_lskel *skel;
+
+	getrlimit(RLIMIT_NOFILE, &old);
+	new.rlim_max = MAX(new.rlim_max, old.rlim_max);
+	setrlimit(RLIMIT_NOFILE, &new);
+	skel = many_progs_lskel__open_and_load();
+	setrlimit(RLIMIT_NOFILE, &old);
+	if (!ASSERT_OK_PTR(skel, "load"))
+		return;
+	ASSERT_EQ(run(skel->progs.prog699.prog_fd), 699, "retval");
+	ASSERT_EQ(run(skel->progs.last.prog_fd), 2, "weak ksym");
+	many_progs_lskel__destroy(skel);
+}
+
+void serial_test_no_limits(void)
+{
+	if (test__start_subtest("signals"))
+		test_signals();
+	if (test__start_subtest("freezer"))
+		test_freezer();
+	if (test__start_subtest("memcg"))
+		test_memcg();
+	if (test__start_subtest("syscall_ctx"))
+		test_syscall_ctx();
+	if (test__start_subtest("subprogs"))
+		test_subprogs();
+	if (test__start_subtest("dump"))
+		test_dump();
+	if (test__start_subtest("kfuncs"))
+		test_kfuncs();
+	if (test__start_subtest("btf"))
+		test_btf();
+	if (test__start_subtest("lskel"))
+		test_lskel();
+}
diff --git a/tools/testing/selftests/bpf/progs/many_progs.c b/tools/testing/selftests/bpf/progs/many_progs.c
new file mode 100644
index 000000000000..060f7b265258
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/many_progs.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#define REP10(M, p) M(p##0) M(p##1) M(p##2) M(p##3) M(p##4) M(p##5) M(p##6) M(p##7) M(p##8) M(p##9)
+#define REP100(M, p) REP10(M, p##0) REP10(M, p##1) REP10(M, p##2) REP10(M, p##3) REP10(M, p##4) \
+		     REP10(M, p##5) REP10(M, p##6) REP10(M, p##7) REP10(M, p##8) REP10(M, p##9)
+
+#define PROG(n)							\
+struct {							\
+	__uint(type, BPF_MAP_TYPE_ARRAY);			\
+	__uint(max_entries, 1);					\
+	__type(key, int);					\
+	__type(value, int);					\
+} map##n SEC(".maps");						\
+								\
+SEC("tc")							\
+int prog##n(void *ctx)						\
+{								\
+	int *v = bpf_map_lookup_elem(&map##n, &(int){ 0 });	\
+								\
+	return v ? *v + n : 0;					\
+}
+
+REP100(PROG, 1) REP100(PROG, 2) REP100(PROG, 3) REP100(PROG, 4) REP100(PROG, 5) REP100(PROG, 6)
+
+extern const void no_such_symbol __ksym __weak;
+
+/* The loader is more than 32768 insns away from its cleanup code */
+SEC("tc")
+int last(void *ctx)
+{
+	return &no_such_symbol ? 1 : 2;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

