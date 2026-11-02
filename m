Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648517;
	b=A8epctif47enHsCUxa71rdb61ofHSUIPFGXZu/Fij+9Iblu64ocsHBrUi0f//MylzXhS
	 4WzveTjjiUXGq8u08MYWvhnpqwGfmBpjU/WisY6PsqdhA/MwfKs69nMTCNU3eLrlT+CWn
	 vPyUcYx4u6dyMARTWM/9RuSRDSVysMpbGhxJivXD+oG+aQ/Ns/0/ogeOANPMlZSBKipvr
	 n10N75Z9f+D18njdM3IB+thxVjUyOyAu2BWEEzieVdIh+8niFtuXuBi02rkLnkbDG8LRM
	 mDr4lpQpMWVmLrpzLvIQK3O0pMpGQCiRVXXBpBqQzez7mCA694nLRadl+IZQRNwd9Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6kh38ixGlcMYvSMO0Cs+3boaaPdMbwOiDcXF3MCXi/8=;
	b=dVfJjiDUPUredj2lHALR9cmeJv2Ei2bFSrxhwfmywgU1RKLX3PY7VvwwDdmPiSgwAH8c
	 /jfMX/5LbO0sFUlrXc+JzjfD5hrYo3tz+cAApqWsQtRpM+d63pjzZgaIS3+/t0z4rJAnq
	 gjK6PRFBujpnwyzdFvHe8Q0XmBdWHOcQ7yojmb6v4dD3ZK9M/nvcQZZz8koqa676YuydZ
	 2M4XSMQCyPzncNuzwixYdxnam0WDxyZQpkLHOXwzuPYO1yXcRxBwbsumnhdP3OiPnFLtb
	 Pdaey3+IURaKcl0kfi76+6npyPfcVKM5GJwLDhDkusP6RJx/j6Tkc3kjqUEARNFZ4UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMXiY0Ux;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95E606EE98
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB95E606EE98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMXiY0Ux
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so28582065e9.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 11:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648515; x=1794253315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kh38ixGlcMYvSMO0Cs+3boaaPdMbwOiDcXF3MCXi/8=;
        b=ZMXiY0UxckHKiYUkSbMmtuJNifVY3O1sRQ5KrcrwqONncNToBiPJeHV7Lr8YZiquta
         l9/UAHqZkEYPXlO2vG3PtYIIRVgftJTE4nqQzskaU66Bw4L8ILveYj7pxRTVhXrzJG+E
         BFgZjNU+MQo/m4OyiMkMDixuKcUuwt9vHd4QWxVuEgNtnx/xUEQqfgh5pbvGRbkZPegg
         /RiueflA1UOXMOdcCqiEif0E1/28VbDXWk4JutTLbOpjbbs4qaP34pCJJHTtuHkkEC7+
         eFYmZlB2jOb6Lvy2KgExln+uYGvali4EGTPXZ8Je8waSwERgAkSv8oL1+9lrBeQ5PM4I
         LaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648515; x=1794253315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kh38ixGlcMYvSMO0Cs+3boaaPdMbwOiDcXF3MCXi/8=;
        b=GKZEY2u45D0t9GGw+mghv7Ahbz5vu+MDcjSkizL3if9av13IPguO4q8BD1bPf0J9bj
         XCUc+djAAP6nyHbxm4nc/61mXfH48cseEeC9+JC61halJYoTBH9brXDIZ+KpaVC7KVv8
         IHZoVR8bKNhQHj8m3qL6mmb//UHCuFJCSzBAb+zU0SXALoHoPrwvUa0fj6cVbagFkGeZ
         5L2d/J/FtDcTFlvcuX1CVP7NnqmGFPltnE1ZOqXv3NEXO41My1fqn7saoBqYG2rbO706
         PCV6E8g8mlIZCAqf5cbGEKqI/ctKLdgr3lQ7xBwVSbARnfz35C4qziJlPRO0+Uodu1Ck
         vntg==
X-Gm-Message-State: AFq9FYI/fKg+8OIVU24MIeY5sUriWhEl0dTSLib7t56y7n4xs1joiA1w
	b7FPT1Lt4rD5GAQenFkBVFAf7/NEBcRPEuhLOz9p+oNt+nVQDerbOUKIPr0ZqOmSFrUb8A==
X-Gm-Gg: AYBFou0qwdBpbysDOLYTOAJNyzcPMjDcA5VXws2PS5zHxyWYsk+zAm41wbqLf9SIEOs
	QQeg/C2LYQk/zoXiYxrCfVD3z2qce1I9bIdfpKQu5ZGE8twSRZSpj5YkcAidRHJFPfPJ1O05a4r
	pOie5fkkiWeBD09gz4ABNkkoXaZ6sEzskKTvpNfKsjs1NC2j3bv4uElIEW9hl2UZ6A4bd4KYZVO
	TKlS5a3X4R79TfsYFR6sofX5hqBAWUJIp/+bVQSWqf1zsMgveqKxLxfov8X4IyHGp6G52qbEhZC
	WuDGgWEpmtMwBPvnZCui+VtLLwalowJIBJsC6wrKS/F0pOw+1X0v79wRp616Q90P7ZrcZwyOyt3
	Z1G+FNWaoHrzRgPsc98ZaClX9EvQiTpW6nlRCxaXiu21N38U1TDpGYNqSXIEq3vCwrsminY5rdF
	yrlmwRZugU8rxuQwn2H9B3jNpqLrPYVS1YPJ8V8MSnAFImo0xJtLqAblDSK77srrfvYehn1Qinx
	raWxws+ZFS++H1PYgOj4bfDGa4JfvwP/JLpUyF2Tof3zrwpAvWjg/HfT500ijBqDlvW+csGhrBl
	aIHnXgDSuBlVIYcyIaZMl9/2wRXUokD4rPpXBrJaTA+XqqguRRfsmV7vaKJj5hAFBj2FSvpXsxw
	t
X-Received: by 2002:a05:600c:6089:b0:4a2:a8c:22b0 with SMTP id 5b1f17b1804b1-4ac14ec75fbmr242302055e9.1.1793648515119;
        Mon, 02 Nov 2026 11:41:55 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4ac0a0a3495sm231386345e9.4.2026.11.02.11.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:41:54 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Tianyi Chen <hi@tychen.cc>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Hui Su <sh_def@163.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Test gen loader attach
Date: Mon,  2 Nov 2026 19:41:44 +0000
Message-ID: <20261102194145.620210-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102194145.620210-1-mahe.tardy@gmail.com>
References: <20261102194145.620210-1-mahe.tardy@gmail.com>
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

Tests that nothing changes when only loading without attach, verifies
that unsupported program types return an error, and check that all
tracing program types successfully generate loader attach prog.

Then actually checks execution of the generated loader attach for two
LSM progs, verifying the links are correctly loading the appropriate
programs and that autoload=false and autoattach=false disable it.
Finally, checks that if one program out of many fails to attach, the
cleanup with detach is done correctly.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/gen_loader_attach.c        | 229 ++++++++++++++++++
 .../selftests/bpf/progs/gen_loader_attach.c   |  48 ++++
 2 files changed, 277 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/gen_loader_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/gen_loader_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/gen_loader_attach.c b/tools/testing/selftests/bpf/prog_tests/gen_loader_attach.c
new file mode 100644
index 000000000000..1277709d7ef2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/gen_loader_attach.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+#include <test_progs.h>
+#include <dirent.h>
+#include <bpf/skel_internal.h>
+
+#define NR_PROGS 7
+
+enum execution_case {
+	ATTACH,
+	NO_AUTOLOAD,
+	NO_AUTOATTACH,
+	ROLLBACK,
+};
+
+static int link_create_attr_offset(const struct gen_loader_opts *opts, int index)
+{
+	const struct bpf_insn *insns = (const void *)opts->insns;
+	int i, count = opts->insns_sz / sizeof(*insns);
+
+	for (i = 4; i < count; i++) {
+		if (insns[i].code != (BPF_JMP | BPF_CALL) ||
+		    insns[i].imm != BPF_FUNC_sys_bpf ||
+		    insns[i - 4].code != (BPF_ALU64 | BPF_MOV | BPF_K) ||
+		    insns[i - 4].dst_reg != BPF_REG_1 ||
+		    insns[i - 4].imm != BPF_LINK_CREATE)
+			continue;
+		if (!index--)
+			return insns[i - 2].imm;
+	}
+	return -1;
+}
+
+static struct bpf_object *generate(struct gen_loader_opts *opts, enum execution_case test)
+{
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+
+	obj = bpf_object__open_file("gen_loader_attach.bpf.o", NULL);
+	if (!ASSERT_OK_PTR(obj, "open"))
+		return NULL;
+	prog = bpf_object__find_program_by_name(obj, "lsm_open");
+	bpf_program__set_autoload(prog, test != NO_AUTOLOAD);
+	bpf_program__set_autoattach(prog, test != NO_AUTOATTACH);
+	if (!ASSERT_OK(bpf_object__gen_loader(obj, opts), "gen_loader") ||
+	    !ASSERT_OK(bpf_object__load(obj), "generate"))
+		goto err_out;
+	return obj;
+
+err_out:
+	bpf_object__close(obj);
+	return NULL;
+}
+
+static void check_load_only(void)
+{
+	LIBBPF_OPTS(gen_loader_opts, opts);
+	struct bpf_object *obj;
+
+	obj = generate(&opts, ATTACH);
+	if (!obj)
+		return;
+	ASSERT_EQ(link_create_attr_offset(&opts, 0), -1, "no_link_create");
+	bpf_object__close(obj);
+}
+
+static void check_unsupported(void)
+{
+	LIBBPF_OPTS(gen_loader_opts, opts, .gen_attach = true);
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+
+	obj = bpf_object__open_file("gen_loader_attach.bpf.o", NULL);
+	if (!ASSERT_OK_PTR(obj, "open"))
+		return;
+	prog = bpf_object__find_program_by_name(obj, "socket");
+	bpf_program__set_autoload(prog, true);
+	if (ASSERT_OK(bpf_object__gen_loader(obj, &opts), "gen_loader"))
+		ASSERT_EQ(bpf_object__load(obj), -EOPNOTSUPP, "unsupported_attach");
+	bpf_object__close(obj);
+}
+
+static void check_tracing_generation(void)
+{
+	LIBBPF_OPTS(gen_loader_opts, opts, .gen_attach = true);
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	int index = 0;
+
+	obj = bpf_object__open_file("gen_loader_attach.bpf.o", NULL);
+	if (!ASSERT_OK_PTR(obj, "open"))
+		return;
+	bpf_object__for_each_program(prog, obj)
+		bpf_program__set_autoload(prog, bpf_program__type(prog) == BPF_PROG_TYPE_TRACING);
+	if (!ASSERT_OK(bpf_object__gen_loader(obj, &opts), "gen_loader") ||
+	    !ASSERT_OK(bpf_object__load(obj), "generate"))
+		goto out;
+	bpf_object__for_each_program(prog, obj) {
+		const union bpf_attr *attr;
+		int off;
+
+		if (!bpf_program__autoload(prog))
+			continue;
+		off = link_create_attr_offset(&opts, index++);
+		if (!ASSERT_GE(off, 0, bpf_program__name(prog)))
+			goto out;
+		attr = (const void *)(opts.data + off);
+		ASSERT_EQ(attr->link_create.attach_type,
+			  bpf_program__expected_attach_type(prog), bpf_program__name(prog));
+	}
+	ASSERT_EQ(link_create_attr_offset(&opts, index), -1, "link_count");
+out:
+	bpf_object__close(obj);
+}
+
+static int count_fds(void)
+{
+	struct dirent *entry;
+	int count = 0;
+	DIR *dir;
+
+	dir = opendir("/proc/self/fd");
+	if (!dir)
+		return -errno;
+	while ((entry = readdir(dir)))
+		if (entry->d_name[0] != '.')
+			count++;
+	closedir(dir);
+	return count;
+}
+
+static void check_execution(enum execution_case test)
+{
+	LIBBPF_OPTS(gen_loader_opts, gen, .gen_attach = true);
+	struct {
+		struct bpf_loader_ctx ctx;
+		struct bpf_prog_desc progs[NR_PROGS];
+		struct bpf_link_desc links[NR_PROGS];
+	} ctx = { .ctx.sz = sizeof(ctx) };
+	struct bpf_load_and_run_opts run = { .ctx = &ctx.ctx };
+	struct bpf_object *obj;
+	int i, off, err, before;
+
+	obj = generate(&gen, test);
+	if (!obj)
+		return;
+	run.insns = gen.insns;
+	run.insns_sz = gen.insns_sz;
+	run.data = gen.data;
+	run.data_sz = gen.data_sz;
+
+	if (test == ROLLBACK) {
+		off = link_create_attr_offset(&gen, 1);
+		if (!ASSERT_GE(off, 0, "second_link_attr"))
+			goto out;
+		/* Force the second attachment to fail after the first succeeded. */
+		((union bpf_attr *)(gen.data + off))->link_create.attach_type = BPF_TRACE_FENTRY;
+
+		before = count_fds();
+		if (!ASSERT_GE(before, 0, "count_fds"))
+			goto out;
+		ASSERT_EQ(bpf_load_and_run(&run), -EINVAL, "second_attach_failed");
+		ASSERT_EQ(count_fds(), before, "rollback_fds");
+		goto out;
+	}
+
+	err = bpf_load_and_run(&run);
+	if (!ASSERT_OK(err, "run_loader"))
+		goto out;
+
+	for (i = 0; i < NR_PROGS; i++) {
+		struct bpf_link_info link = {};
+		struct bpf_prog_info prog = {};
+		__u32 size;
+
+		/*
+		 * Only the first two programs load by default; NO_AUTOLOAD also
+		 * skips the first. NO_AUTOATTACH must still return its program FD.
+		 */
+		if (i >= 2 || (!i && test == NO_AUTOLOAD)) {
+			ASSERT_EQ(ctx.progs[i].prog_fd, 0, "skipped_program");
+		} else {
+			size = sizeof(prog);
+			if (!ASSERT_GT(ctx.progs[i].prog_fd, 0, "program_fd") ||
+			    !ASSERT_OK(bpf_prog_get_info_by_fd(ctx.progs[i].prog_fd, &prog, &size),
+				       "prog_info"))
+				continue;
+		}
+
+		/*
+		 * Unloaded programs have no link. NO_AUTOATTACH also leaves the
+		 * first program's link slot zero, even though its program is loaded.
+		 */
+		if (i >= 2 || (!i && (test == NO_AUTOLOAD || test == NO_AUTOATTACH))) {
+			ASSERT_EQ(ctx.links[i].link_fd, 0, "skipped_link");
+			continue;
+		}
+		/* Verify the link references the corresponding loaded program. */
+		size = sizeof(link);
+		if (!ASSERT_OK(bpf_link_get_info_by_fd(ctx.links[i].link_fd, &link, &size),
+			       "link_info"))
+			continue;
+		ASSERT_EQ(link.prog_id, prog.id, "attached_program");
+	}
+out:
+	for (i = 0; i < NR_PROGS; i++) {
+		skel_closenz(ctx.links[i].link_fd);
+		skel_closenz(ctx.progs[i].prog_fd);
+	}
+	bpf_object__close(obj);
+}
+
+void test_gen_loader_attach(void)
+{
+	if (test__start_subtest("load_only"))
+		check_load_only();
+	if (test__start_subtest("unsupported"))
+		check_unsupported();
+	if (test__start_subtest("tracing"))
+		check_tracing_generation();
+	if (test__start_subtest("execute"))
+		check_execution(ATTACH);
+	if (test__start_subtest("execute_no_autoload"))
+		check_execution(NO_AUTOLOAD);
+	if (test__start_subtest("execute_no_autoattach"))
+		check_execution(NO_AUTOATTACH);
+	if (test__start_subtest("rollback"))
+		check_execution(ROLLBACK);
+}
diff --git a/tools/testing/selftests/bpf/progs/gen_loader_attach.c b/tools/testing/selftests/bpf/progs/gen_loader_attach.c
new file mode 100644
index 000000000000..9a38fe4ac7bb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/gen_loader_attach.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+SEC("lsm/file_open")
+int lsm_open(void *ctx)
+{
+	return 0;
+}
+
+SEC("lsm/file_permission")
+int lsm_perm(void *ctx)
+{
+	return 0;
+}
+
+SEC("?socket")
+int socket(void *ctx)
+{
+	return 0;
+}
+
+SEC("?fentry/security_inode_getattr")
+int fentry(void *ctx)
+{
+	return 0;
+}
+
+SEC("?fexit/security_inode_getattr")
+int fexit(void *ctx)
+{
+	return 0;
+}
+
+SEC("?fmod_ret/security_inode_getattr")
+int fmod_ret(void *ctx)
+{
+	return 0;
+}
+
+SEC("?tp_btf/sys_enter")
+int tp_btf(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
--
2.43.0

