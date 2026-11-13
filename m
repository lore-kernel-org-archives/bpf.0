Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546605;
	b=MqZx/YC3C+v5zx+nNsaeZuG7vlNgyLiAEIDL8unbVRaLd9DPv9PAjBORRI5j2PJNhp8G
	 aKIQAxd551Umfp6FlHjKd5RbxrGkJ4i54X9SRgL2s7rKG+SwthHyL9p7QEsJlWUrpyCTv
	 rEQBk8J5y9OeW6ZMYSKkziWl4V4+LrMzimJKrNSU7GVNc+eDPpgeJWUeKkrPv14kNFaU2
	 EENcZqgR18KSQC1SMjla+r/9xKiFcIjj68MwJh36tH5qSfn8qSb7n0wedQDnU6QBISccg
	 TtzYr76ykcQ6jq4GWPdQNWcjWndiGb/wuJvthS2bSPU+ZkRZL7z/ACYOcw6gDe3h6Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=byyx349U8dcIHGR+dn3tb2Cip4odN2kNKOGDrECZEmQ=;
	b=TRbpQNj77QTusXLTm2znPhQyUBqWxy6U+Xl1eFFzYyLusb0sHsrZ8enZXr7GRqQggZrj
	 zCn/Ajc/o20ZU1+8hvWGTdYsxyAr9wPOeM0QKuwT6or6i99zd9SsvNLqi9N2axHjKnTJg
	 alkHtJ8cKgcGQz6jqKi6oKUbsjhinIt3zEeMnm73EtV9+dvmFDDU/nBV35EZtiezhXcSl
	 wRZSpRBtcCltfsgE2zWVqEaeMUvdN7MtUaOTG+gEagBN/O8BSkBxpFvuHV5qkCCVTd5vA
	 WxK3UiAbFr3ZH3fIsqQbgLTR5mukh/uG+AfJMiYUqi57jVC+hbrnjDe0iRh0w2+JDQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMU7fyoA;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AF606A31C
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA3AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMU7fyoA
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso193069a12.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546604; x=1795151404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=byyx349U8dcIHGR+dn3tb2Cip4odN2kNKOGDrECZEmQ=;
        b=EMU7fyoAYLWo6WueDXMd42DVnTvvbmmS2OygNwXzXl82vdWRv4SzOTz2eQY/CfAyWf
         s/uhqTbkj4hg8WQsxhPavMXZ6pwJOkEx+AI/8NBaxjLFWc3Re470p4/Ok42k2MiAnCqo
         rMFRhUhmjO8S1I0ShECTIfv+EPXsFZIxF+ddwvKB0sG4N8sRuHvI2q+PGy29RMtxRX7A
         cZXlI2oBAF9j1c0D9dXg3pN3a5qu17dodYHqxsax5H4E6k8hFC4QgkhwuwHHYp1iSmWb
         /srSDCNk4aeUlq55Dk3KSAKmT8Odncw7STGww1PQf4Q9U9N6DUZKMJo2l2Ms+mu5eRXi
         AgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546604; x=1795151404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=byyx349U8dcIHGR+dn3tb2Cip4odN2kNKOGDrECZEmQ=;
        b=qaaxSmkI090izyyJXKL8+Pcvd2aC2KoaAd62055aJM3CZ87IUDHoZym3tEiJOHO0bN
         e515rsca9w/AJ+ArAabbul7EVxRSdL3FR/bDHKeF6kzI/1eRPgt1iALjtYdkesg2B/8j
         l13kOyhekCkqTKT2jTX7jey2MGXGvafjmswkK7/DXDr9UDk1TtZ2IB+XvcY/4tg7HRYq
         z5pH5myOvU7DboaIDlH2pmEOKWzfA7gT3qj4a583fkHUD+XOIJs9lXMEHQljmYrePeWR
         k2Mb0vsOOIIkU75XI2rrbBvXPxOl5GoEWHQLYtAgva88lu4ezR0OY5CkNu+6Mesj+BHn
         7oMw==
X-Gm-Message-State: APuU4Z+c9cPzX7Drlf+CA+1FK0QUuwQ7lrInOXFvrAXap7D8NGm1XC7f
	5idPx3VymReByEbPvmNGKefpa1Qfh2ReOELL+iBm9+a+xgq0AiWx4J3nwsiI3Q==
X-Gm-Gg: AYBFou0CVIOaR91HMmJuJzLEDZ/2bvrU+0j9jTRTDnEmYysytapDSTQmYj0O3vBmrFf
	tS+UBNijlgCRLLl2NBSXEEIv/f2ou5w/I/DxRTuQ0MVkg5JEXZrgVfOF5GanO6rCNXxCIKv/4Tm
	mvpVy0vSTV7k2bW1XE96e64N9oP9uqgJYxLEifWxH9aaAl3uVKoJPUklCwNwvtaGyHsoqkNgXBN
	1QK2zy87WIdLg2fuGjbdwx0HCrA62Or/1KiNhrsH5rJfvgi3fDiH5EQa7gzzGN+covpKu3vHf2G
	fWVbu9xDUjfqJ0F+8o024rbTYCXcHfkzPzALdknX9t3mAxfxKKMwotPSSnuH/6X/qrySR4Dhgqd
	7CsFjkhJZ6GGqui+JR6tcdFduTNh0Er8USS8cccl2n30LqN7BfsVfdcdsDAcbzWh2Ia0NUg8jw+
	FF/v9qDbMYFCAX2quAN+QX9GeWT3+9ODiyadDMcTKJEgjgcTSqIf+Gq2wjpp/balhziz5VlLWpK
	D9JFRlc4OQQ+9qweFpfDpW/DxQ6vC9op+Z57ar1tH1JT1RZVVayDPRvOEJJkpd2Q4bszi7DzXOk
	bVRyoqTAQ7FZ+4NwhdEUQBVogpfNtlll34tr2b80+5maW2RlcQMqvAPZtLUCaui9NwoRgBcntGg
	VrDqjTbmmcajVVwQtJhYoxhga1T4Zpgj0NkZPB7zzPQvcNUVO7VNCTl+t++2A9unfAH8Ou+mcIw
	==
X-Received: by 2002:a17:90b:39ab:b0:3ae:8410:ae6a with SMTP id 98e67ed59e1d1-3b1b0a1eec0mr1254450a91.22.1794546603710;
        Thu, 12 Nov 2026 21:10:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae8be5adsm2559773a91.0.2026.11.12.21.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:10:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 10/13] selftests/bpf: Test fmod_ret on tagged functions
Date: Fri, 13 Nov 2026 05:08:58 +0000
Message-ID: <20261113050901.1399091-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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

From: Anton Protopopov <a.s.protopopov@gmail.com>

bpf_testmod gets functions for the rules of the tool. Subtest "tags"
compares their tags:

	bpf_testmod_retval_      returns                        tag
	called, long             two errors, int and long       both errors
	zero_extended, minus_one (u32)-EINVAL as u64, -1 alone  none
	eperm                    -1 and -ENOENT                 both errors
	denied                   -EACCES, -EAGAIN, -EMSGSIZE,   -13
	                         -EINPROGRESS, -512, -529
	effect, effect_late      -EINVAL, an unlock, -EBUSY     -22
	no_effect                trylock, unlock on one path    all errors
	err_ptr                  PTR_ERR(), inlined helper      both errors
	no_branch                sbb + and with GCC             -14
	pointer, argument, init  not an integer, an error that  none
	                         is an argument, init code

bpf_testmod.c includes the new file, so that bpf_testmod stays one object.

Subtest "run": bpf_testmod_test_write() calls bpf_testmod_retval_called().

	the program returns    the function    write() fails with
	0                      is called       -EFBIG, its own error
	-EINVAL                is skipped      -EINVAL

The other programs are only loaded, one for each rule of the check:

	other_error              an error that is not in the list
	range                    [-27, -22]: only both ends are in the list
	two_paths                two errors on two paths to one exit
	negated_bool             [-1, 0] in the low 32 bits
	high_bits                1 << 32
	zero_extended            w0 = -14, the target returns long
	pointer                  R0 is not a scalar
	throws, exception_cb     the cookie, the exit of the callback
	tail_call, not_a_target  refused

Subtest "extension": what an extension returns is not checked against the
list, and an extension of the main program returns to the trampoline.
Existing checks refuse it. The subtest keeps it so: the extension must not
load, with a plain ctx and with __arg_ctx in either program.

The config of the selftests turns the option on. Without it, or without
LLVM on the build host, the test is skipped.

The selftests build their own resolve_btfids, without LLVM, and pass it to
kbuild for the test modules. kbuild runs it with the flags of the config
of the kernel, and --fmodret_scan fails: "no decoder for the code of ELF
machine 62". With the option on kbuild takes the resolve_btfids of the
kernel build: flags and tool belong together. BPF CI unpacks a kernel build
directory without the tool. kbuild makes it again.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/fmodret_retval.c | 152 ++++++++++++++++
 .../selftests/bpf/progs/fmodret_retval.c      | 168 ++++++++++++++++++
 .../selftests/bpf/progs/fmodret_retval_ext.c  |  18 ++
 .../testing/selftests/bpf/test_kmods/Makefile |  16 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   4 +-
 .../bpf/test_kmods/bpf_testmod_retval.c       | 131 ++++++++++++++
 7 files changed, 489 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/fmodret_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/fmodret_retval_ext.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 49dfe939467c..30b744844ef5 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -3,6 +3,7 @@ CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BPF=y
 CONFIG_BPF_EVENTS=y
+CONFIG_BPF_FMODRET_SCAN=y
 CONFIG_BPF_JIT=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_BPF_LIRC_MODE2=y
diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
new file mode 100644
index 000000000000..8139f007e306
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/* The functions which the build tags as fmod_ret targets, because they return errors */
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "fmodret_retval.skel.h"
+#include "fmodret_retval_ext.skel.h"
+
+#define TAG	"bpf_fmodret_retval:"
+
+/* The functions of test_kmods/bpf_testmod_retval.c and the errors in their tags */
+static const struct {
+	const char *func, *errors;
+} fixtures[] = {
+	{ "bpf_testmod_retval_called",		"-27,-22" },
+	{ "bpf_testmod_retval_long",		"-28,-14" },
+	{ "bpf_testmod_retval_zero_extended",	"" },
+	{ "bpf_testmod_retval_minus_one",	"" },
+	{ "bpf_testmod_retval_eperm",		"-2,-1" },
+	{ "bpf_testmod_retval_denied",		"-13" },
+	{ "bpf_testmod_retval_effect",		"-22" },
+	{ "bpf_testmod_retval_effect_late",	"-22" },
+	{ "bpf_testmod_retval_no_effect",	"-28,-22,-16" },
+	{ "bpf_testmod_retval_err_ptr",		"-34,-14" },
+	{ "bpf_testmod_retval_no_branch",	"-14" },
+	{ "bpf_testmod_retval_pointer",		"" },
+	{ "bpf_testmod_retval_argument",	"" },
+	{ "bpf_testmod_retval_init",		"" },
+};
+
+/* Return the errors in the tag of FUNC, or NULL */
+static const char *tagged_errors(const struct btf *btf, const char *func)
+{
+	int id, func_id = btf__find_by_name_kind(btf, func, BTF_KIND_FUNC);
+
+	if (!ASSERT_GT(func_id, 0, func))
+		return NULL;
+	for (id = btf__type_cnt(btf__base_btf(btf)); id < btf__type_cnt(btf); id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const char *name = btf__name_by_offset(btf, t->name_off);
+
+		if (btf_is_decl_tag(t) && t->type == func_id && !strncmp(name, TAG, strlen(TAG)))
+			return name + strlen(TAG);
+	}
+	return NULL;
+}
+
+static int write_errno(int len)
+{
+	int fd = open("/sys/kernel/bpf_testmod", O_WRONLY), err;
+	char buf[8] = {};
+
+	if (!ASSERT_GE(fd, 0, "open"))
+		return 0;
+	err = write(fd, buf, len) < 0 ? -errno : 0;
+	close(fd);
+	return err;
+}
+
+/* bpf_testmod_test_write() returns the error of the target, or -EIO */
+static void test_run(void)
+{
+	struct fmodret_retval *skel;
+	struct bpf_program *prog;
+
+	skel = fmodret_retval__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, prog == skel->progs.called);
+	if (!ASSERT_OK(fmodret_retval__load(skel), "load"))
+		goto out;
+	skel->bss->pid = getpid();
+
+	ASSERT_EQ(write_errno(7), -EFBIG, "before");
+	if (!ASSERT_OK(fmodret_retval__attach(skel), "attach"))
+		goto out;
+	ASSERT_EQ(write_errno(7), -EFBIG, "called");
+	skel->bss->deny = true;
+	ASSERT_EQ(write_errno(7), -EINVAL, "skipped");
+	fmodret_retval__detach(skel);
+	ASSERT_EQ(write_errno(7), -EFBIG, "after");
+out:
+	fmodret_retval__destroy(skel);
+}
+
+/*
+ * What an extension returns is not checked against the tag, and an extension of
+ * the main program would return to the trampoline. Today none has the type of
+ * the main program of a tracing program. Whatever the reason is, it must not load.
+ */
+static void test_extension(void)
+{
+	struct bpf_program *prog, *main_prog, *ext_prog;
+	struct fmodret_retval_ext *ext;
+	struct fmodret_retval *skel;
+	int i;
+
+	skel = fmodret_retval__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, prog == skel->progs.called ||
+						prog == skel->progs.tagged_ctx);
+	if (!ASSERT_OK(fmodret_retval__load(skel), "load"))
+		goto out;
+	for (i = 0; i < 4; i++) {
+		ext = fmodret_retval_ext__open();
+		if (!ASSERT_OK_PTR(ext, "open extension"))
+			break;
+		main_prog = i & 1 ? skel->progs.called : skel->progs.tagged_ctx;
+		ext_prog = i & 2 ? ext->progs.plain_ctx : ext->progs.arg_ctx;
+		bpf_object__for_each_program(prog, ext->obj)
+			bpf_program__set_autoload(prog, prog == ext_prog);
+		ASSERT_OK(bpf_program__set_attach_target(ext_prog, bpf_program__fd(main_prog),
+							 bpf_program__name(main_prog)),
+			  "set_attach_target");
+		ASSERT_ERR(fmodret_retval_ext__load(ext), "load extension");
+		fmodret_retval_ext__destroy(ext);
+	}
+out:
+	fmodret_retval__destroy(skel);
+}
+
+void test_fmodret_retval(void)
+{
+	struct btf *vmlinux_btf, *btf = NULL;
+	int i;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "btf__load_vmlinux_btf"))
+		return;
+	btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!ASSERT_OK_PTR(btf, "btf__load_module_btf"))
+		goto out;
+	if (!tagged_errors(btf, fixtures[0].func)) {
+		printf("%s:SKIP:no CONFIG_BPF_FMODRET_SCAN\n", __func__);
+		test__skip();
+		goto out;
+	}
+	if (test__start_subtest("tags"))
+		for (i = 0; i < ARRAY_SIZE(fixtures); i++)
+			ASSERT_STREQ(tagged_errors(btf, fixtures[i].func) ?: "", fixtures[i].errors,
+				     fixtures[i].func);
+	if (test__start_subtest("run"))
+		test_run();
+	if (test__start_subtest("extension"))
+		test_extension();
+	RUN_TESTS(fmodret_retval);
+out:
+	btf__free(btf);
+	btf__free(vmlinux_btf);
+}
diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval.c b/tools/testing/selftests/bpf/progs/fmodret_retval.c
new file mode 100644
index 000000000000..a15d1f638252
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fmodret_retval.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fmod_ret programs on functions of bpf_testmod which the build has tagged, see
+ * test_kmods/bpf_testmod_retval.c. They may return only 0 or the errors in the
+ * "bpf_fmodret_retval:" tag of their target.
+ */
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+bool deny;
+
+/* What write() to /sys/kernel/bpf_testmod returns tells whether the function was called */
+SEC("fmod_ret/bpf_testmod_retval_called")
+__success
+int BPF_PROG(called, size_t len, int ret)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+	return deny ? -EINVAL : 0;
+}
+
+/* For the extensions of fmodret_retval_ext.c: "called" has a plain ctx */
+SEC("fmod_ret/bpf_testmod_retval_called")
+__success
+int tagged_ctx(unsigned long long *ctx __arg_ctx)
+{
+	return 0;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_called")
+__failure __msg("At program exit the register R0 should be 0 or one of -27,-22")
+int BPF_PROG(other_error, size_t len, int ret)
+{
+	return -EPERM;
+}
+
+/* Each path to the exit has an allowed value, their join has not */
+SEC("fmod_ret/bpf_testmod_retval_called")
+__success
+__naked void two_paths(void)
+{
+	asm volatile (
+	"r2 = *(u64 *)(r1 + 0);"
+	"r0 = -27;"
+	"if r2 == 7 goto 1f;"
+	"r0 = -22;"
+"1:"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* Both ends of the range are in the list, the values between them are not */
+SEC("fmod_ret/bpf_testmod_retval_called")
+__failure __msg("R0 should be 0 or one of -27,-22")
+__naked void range(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"if r0 s< -27 goto 1f;"
+	"if r0 s> -22 goto 1f;"
+	"exit;"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The end of clang's "return a && b ? -EPERM : 0": [0, U32_MAX] in 64 bits, [-1, 0] in 32 */
+SEC("fmod_ret/bpf_testmod_retval_eperm")
+__success
+__naked void negated_bool(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"w0 &= 1;"
+	"w0 = -w0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* Not 0, so the function is not called, but the caller would see 0 */
+SEC("fmod_ret/bpf_testmod_retval_called")
+__failure __msg("R0 should be 0 or one of -27,-22")
+__naked void high_bits(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	"r0 <<= 32;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The function returns long, so all 64 bits count: this is 4294967282 */
+SEC("fmod_ret/bpf_testmod_retval_long")
+__failure __msg("R0 should be 0 or one of -28,-14")
+__naked void zero_extended(void)
+{
+	asm volatile (
+	"w0 = -14;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* A privileged program may return a pointer, but not here */
+SEC("fmod_ret/bpf_testmod_retval_called")
+__failure __msg("R0 is not a known value (ctx)")
+__naked void pointer(void)
+{
+	asm volatile (
+	"r0 = r1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The default exception callback returns the cookie */
+SEC("fmod_ret/bpf_testmod_retval_denied")
+__failure __msg("At program exit the register R1 should be 0 or one of -13")
+int BPF_PROG(throws, int a, int b, int c, int d, int ret)
+{
+	if (a)
+		bpf_throw(7);
+	return 0;
+}
+
+/* An exception callback returns for the program */
+__noinline int returns_eperm(u64 cookie)
+{
+	return -EPERM;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_called")
+__exception_cb(returns_eperm)
+__failure __msg("R0 should be 0 or one of -27,-22")
+int BPF_PROG(exception_cb, size_t len, int ret)
+{
+	if (len)
+		bpf_throw(0);
+	return 0;
+}
+
+SEC("fmod_ret/bpf_testmod_retval_minus_one")
+__failure __msg("bpf_testmod_retval_minus_one() is not modifiable")
+int BPF_PROG(not_a_target, int value, int ret)
+{
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("fmod_ret/bpf_testmod_retval_called")
+__failure __msg("tail calls are not allowed in fmod_ret programs with restricted return values")
+int BPF_PROG(tail_call, size_t len, int ret)
+{
+	bpf_tail_call(ctx, &jmp_table, 0);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval_ext.c b/tools/testing/selftests/bpf/progs/fmodret_retval_ext.c
new file mode 100644
index 000000000000..9f640fcabdb1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fmodret_retval_ext.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Extensions for the main program of an fmod_ret program, see prog_tests/fmodret_retval.c */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("freplace")
+int plain_ctx(unsigned long long *ctx)
+{
+	return 7;
+}
+
+SEC("freplace")
+int arg_ctx(unsigned long long *ctx __arg_ctx)
+{
+	return 7;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 031c7454ce65..4459a037b42b 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -12,6 +12,18 @@ KDIR ?= $(if $(KMOD_O_VALID),$(SRCTREE_KDIR), \
 	    $(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR), \
 		/lib/modules/$(shell uname -r)/build))
 
+# kbuild runs resolve_btfids with the flags which the config of the kernel asks
+# for, and --fmodret_scan needs a resolve_btfids which is linked with LLVM. The
+# one of the kernel build is. The one of the selftests, which bpf/Makefile passes
+# down, is not. A kernel build directory that comes out of an archive can lack
+# the tool: kbuild makes it again, in its place: not in the OUTPUT of kselftest.
+KMOD_OBJTREE := $(or $(KMOD_O_VALID),$(KDIR))
+KERNEL_RESOLVE_BTFIDS := $(KMOD_OBJTREE)/tools/bpf/resolve_btfids/resolve_btfids
+ifneq ($(shell grep -sx CONFIG_BPF_FMODRET_SCAN=y $(KMOD_OBJTREE)/include/config/auto.conf),)
+MAKEOVERRIDES := $(filter-out RESOLVE_BTFIDS=% OUTPUT=%,$(MAKEOVERRIDES))
+all: $(KERNEL_RESOLVE_BTFIDS)
+endif
+
 ifeq ($(V),1)
 Q =
 else
@@ -38,6 +50,10 @@ else ifneq ("$(wildcard $(KDIR))", "")
 		M=$(TEST_KMOD_DIR) modules
 endif
 
+$(KERNEL_RESOLVE_BTFIDS):
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID) KBUILD_OUTPUT=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		tools/bpf/resolve_btfids
+
 clean:
 ifneq ("$(wildcard $(KDIR))", "")
 	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID) KBUILD_OUTPUT=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 41ff36f0ca77..1f8bc0c99a71 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -879,6 +879,8 @@ static __always_inline size_t testmod_inline_len(size_t len)
 	return len;
 }
 
+#include "bpf_testmod_retval.c"
+
 noinline ssize_t
 bpf_testmod_test_write(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,
@@ -892,7 +894,7 @@ bpf_testmod_test_write(struct file *file, struct kobject *kobj,
 
 	trace_bpf_testmod_test_write_bare_tp(current, &ctx);
 
-	return -EIO; /* always fail */
+	return bpf_testmod_retval_called(len) ?: -EIO; /* always fail */
 }
 EXPORT_SYMBOL(bpf_testmod_test_write);
 ALLOW_ERROR_INJECTION(bpf_testmod_test_write, ERRNO);
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
new file mode 100644
index 000000000000..f2e4e21fe36f
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions for resolve_btfids --fmodret_scan, which tags the functions that
+ * return errors as fmod_ret targets. prog_tests/fmodret_retval.c has the tags
+ * which it expects. A part of bpf_testmod.c.
+ */
+
+/* bpf_testmod_test_write() calls it and returns what it gets */
+static noinline int bpf_testmod_retval_called(size_t len)
+{
+	if (len == 7)
+		return -EFBIG;
+	return len ? 0 : -EINVAL;
+}
+
+static __used noinline long bpf_testmod_retval_long(int value)
+{
+	return value ? -EFAULT : -ENOSPC;
+}
+
+/* 0xffffffea is not an error in 64 bits */
+static __used noinline u64 bpf_testmod_retval_zero_extended(int value)
+{
+	return value ? (u32)-EINVAL : 0;
+}
+
+/* -1 may be "less" or "none": it counts only next to another error */
+static __used noinline int bpf_testmod_retval_minus_one(int value)
+{
+	return value ? -1 : 0;
+}
+
+static __used noinline int bpf_testmod_retval_eperm(int value)
+{
+	if (value < 0)
+		return -EPERM;
+	return value > 8 ? -ENOENT : value;
+}
+
+/* Errors which tell the caller that something goes on are not listed */
+static __used noinline int bpf_testmod_retval_denied(int a, int b, int c, int d)
+{
+	if (a > 1)
+		return -EMSGSIZE;
+	if (a)
+		return -EACCES;
+	if (b)
+		return -EAGAIN;
+	if (c)
+		return -EINPROGRESS;
+	return d ? -ERESTARTSYS : -EIOCBQUEUED;
+}
+
+/* A caller which gets -EBUSY relies on the unlock */
+static __used noinline int bpf_testmod_retval_effect(struct mutex *lock, int value)
+{
+	if (value < 0)
+		return -EINVAL;
+	mutex_unlock(lock);
+	return value > 8 ? -EBUSY : value;
+}
+
+/* The errors are set before the unlock. The pointer moves to another register */
+static __used noinline int bpf_testmod_retval_effect_late(int value, struct mutex *lock)
+{
+	int err = 0;
+
+	if (value < 0)
+		return -EINVAL;
+	if (value == 1)
+		err = -EBUSY;
+	else if (value == 2)
+		err = -ENOSPC;
+	mutex_unlock(lock);
+	return err;
+}
+
+/* The callee can fail, the pointer is loaded, a path goes around the unlock */
+static __used noinline int bpf_testmod_retval_no_effect(struct mutex *lock, struct mutex **other,
+							int value)
+{
+	if (!mutex_trylock(lock))
+		return -EBUSY;
+	mutex_unlock(*other);
+	if (value < 0)
+		return -EINVAL;
+	if (value & 1)
+		mutex_unlock(lock);
+	return mutex_is_locked(lock) ? -ENOSPC : 0;
+}
+
+/* PTR_ERR() of the ERR_PTR() of an inlined helper */
+static __always_inline int *bpf_testmod_retval_slot(int *buf, int idx)
+{
+	if (idx < 0)
+		return ERR_PTR(-ERANGE);
+	return idx > 8 ? ERR_PTR(-EFAULT) : &buf[idx];
+}
+
+static __used noinline int bpf_testmod_retval_err_ptr(int *buf, int idx)
+{
+	int *slot = bpf_testmod_retval_slot(buf, idx);
+
+	if (IS_ERR(slot))
+		return PTR_ERR(slot);
+	*slot = 1;
+	return 0;
+}
+
+/* GCC for x86-64: neg, sbb, and */
+static __used noinline int bpf_testmod_retval_no_branch(unsigned long left)
+{
+	return left ? -EFAULT : 0;
+}
+
+/* Not an integer, and an error which is not returned */
+static __used noinline void *bpf_testmod_retval_pointer(int value)
+{
+	return value ? ERR_PTR(-EINVAL) : NULL;
+}
+
+static __used noinline int bpf_testmod_retval_argument(int value)
+{
+	return bpf_testmod_retval_minus_one(value ? -EINVAL : -ENOMEM) + 1;
+}
+
+/* Gone before a program can attach */
+static __used noinline __init int bpf_testmod_retval_init(int value)
+{
+	return value ? -EINVAL : -ENOMEM;
+}
-- 
2.55.0

