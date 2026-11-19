Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051783;
	b=3sL3tMu6Ls3wDTJ1C+JCER+VP99FfwQLa+2U1VzsFUgl47eRUPITXv6HID9Gd6akgz/d
	 OqMXocy5JE9enw3kkBMy4XHMJ2mHsmKbA2htEtX1j/elOOzbyhbMUN3Yni9CieK0pf8zf
	 7lZDFK6gVKOfVXcr16yupBA/rf0akMO2B7eNA9cWnCgv3SilsPDmRITWFVQMLY26ASywY
	 nL3yUWGyR4LMKSjfnwAcaX86thfsoS8TBiGgBOGnPme1+L1IVfuzkKvCzchYUzBUNrLEd
	 BQGc3851TIv5S8uNWjucKHjUiFaDwbcPeczXgJfXtg3jPLsoVJARY0fI7cIKxLE8v0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bKWDXGcZ+IWPbLmfaNnSEgoUNf+dPSDB9zSuraYct+M=;
	b=XRqZElZWt2bfiIM/SSniItu/0CnB5D9w+jg4iFq5JehtN5WEmgtcxoFzxNZXKOxEkJMD
	 AHXdSDZAK16spUGcbl0iwcitYmUKWP1ZV2TVeFVmFnwZRhoIwGEX67VnHeKhAqBwQDi4+
	 cjaM8siNGGCcbiqR/y97gUW9L23s9SYbB208xKC7O9Pk51GbfLKN0onkb+yLdFFio5Oof
	 vxkwJgYY7EGP26j/rXHpY4ok3lJVjaQwVASLMny9+ZJKrkL6auwddRBubHd7IhyVepzxj
	 xr/B3tnf+7myXGrOB5frfx5Vk0vdZN6Lbx3J+BHbszyOrlb2bklojJ8wAzEyaj+59gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dX3xe5Vd;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FB606A31C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 086FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dX3xe5Vd
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2efcf92af4fso6892835ad.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051782; x=1795656582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKWDXGcZ+IWPbLmfaNnSEgoUNf+dPSDB9zSuraYct+M=;
        b=dX3xe5VdQkDGk7Z84WwxBOpM7VSSIGrHu+gGsX59QTFyIW0aa8Bh1MYwSY+VXRd9pG
         VhiG0Wa8ORg3qLimob33jJVMoJQa0u3hiaGFsso6xUnx0nd2phDMv7Sra+kROviSg7pZ
         tOWQMfBfJjLSwQwgKAxaUnLXlOqmwf+rOwjWcL7yb+0KwrVNslWvOOJAPyKjDNl5qrOQ
         nrwXO9CmdOnBnggcJyFlCxgYo+5sKwsyMjoVB8h4geczh9ocJwT6WWZ3RCV673Mkl8yf
         GVrJsLwsep3cDDlWqou8Zy9XDG2TF4ESxQUoqz7tMIzNoCqo5iX9Gtgm9jD4XbJgPNMP
         KCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051782; x=1795656582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKWDXGcZ+IWPbLmfaNnSEgoUNf+dPSDB9zSuraYct+M=;
        b=m/SzwaseBh2cCUd7wdcnGgORNYDKG3sfAqPHNI4dJlKHf2MWv2By97GWrEPsEon6lG
         3R/rtm0cx4R4/TK0z/FgmeepVf+krJzgaV7Vzo6Zy4XEZEeXHqiXzB7Ej/YOmWHO2NlW
         wPj+vHwJUAdJktQtuBEzk9eL+MpnKkWvRXzH++1plCk677pRUfs0TyVyyZ26eMPae+Ge
         dTgtpkmobes17NOXnqBzUCzwPpwLqJAWBLcw9WiOtMIV6VStwKlw9pX8R8M/y+sQK2I5
         hzqzMOKDkC5rMbK4yuo8XflCdfoVVkGoW1e6OFpwyWD8g/15FCZMNN8VBcyCXe8pfg2F
         DQkg==
X-Gm-Message-State: APuU4Z9k9BdlKn8KFdk9bi4yWdS129Oktx1zcj4qkzpgRffZQrI2vVrV
	H8VPQVo3hMtJiVl6hE6fvpsBWzTIzLugagBulf5yE/E42s94wpVWGXCYVqK/oQ==
X-Gm-Gg: AZFdTZcYaSNVS+1bf8AIik7+tW5LLsVBO5ACeFfg+iAu2PmonCTFn3zvGq4wjfsW/Fd
	JuV0UGz1Qm2hn/7vEmwwoPOGnhewnPOT54TyIZFxX65katQdltBNv9BAIUtQaW8pPKvVWjUHKkv
	CBc4lQdJVUvoPFD3WfUuS0d3KmUX+3W5ePX5ZiOjLa1pxF6HoFNzL6BKNBUCvjLUS9PlCUMzE4k
	MXFByXhbn3pUoeDCnhnu58Fxs/miWfgsGW2/qB7MFGdEUq7hBamusaYKZumbScjmnIgzVSogTYE
	QszeWsK/aIGhOnTezdTTDHqsilhPe/X9/eDI9WKPioujt8cTeH8hnsi1NgJU3+tsYc6FJbEBrkR
	zb/8KT6CExAlajFwhx66DgwWYNs/HJU+Gm1+YkIom9Ebnu6f3dUee5UaA1py7rjqdlVR8QxxNuA
	RS16gAqv6rkWh0tavFIM31bYQubtE/aqf2Ia2bAQTO4Ty4OFhBCORuKDkYEl6nzBSXely7mqQmT
	cKf1knwv7A6dQRhUFpjN4hglDvCK15TAQ7tvgj0j8gnbjXAakMF72JXcd8xCNTYlnGDKsumm1ro
	9wmCR8RrhPA0zSM6jdDrA2y2SSp4Y7lRUESRqAiE5I6YfBdTh02WmAktN+CKqHJmYE/oIzRoVWt
	6PXIMvHyBzm7pwwQPVewoA2a+WfLwaDAaiTmIGXT37YM0KVNR8Av93v306kvg51bVpyJ0vwV9WF
	IVssnrn6QT7Y7AS5hxkqKN
X-Received: by 2002:a17:902:cf4c:b0:2dd:b6e7:ac1b with SMTP id d9443c01a7336-2eff72051femr43744945ad.2.1795051782169;
        Wed, 18 Nov 2026 17:29:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62842absm20469925ad.61.2026.11.18.17.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:29:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/5] selftests/bpf: Test the width of the value of an fmod_ret program
Date: Thu, 19 Nov 2026 01:29:09 +0000
Message-ID: <20261119012909.3657417-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
References: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
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

Two fmod_ret programs return the same 64-bit value, one for a function
that returns int, one for a function that returns bool. The test looks at
what the trampoline makes of it:

	value           int function        bool function
	1 << 32         called              called
	0x100           skipped, 0x100      called
	2               skipped, 2          skipped, 1
	-EINVAL         skipped, -EINVAL    skipped, 1
	(u32)-EINVAL    skipped, -EINVAL    skipped, 1

fexit programs read the value with bpf_get_func_ret(). The side effect of
bpf_modify_return_test() tells whether it was called. bpf_testmod gets
the bool function, which returns false.

The test runs on x86-64 and arm64. Also update the comment of a test that
described the trampoline.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/modify_return.c  | 51 +++++++++++++++++++
 .../selftests/bpf/progs/fmodret_retval.c      |  2 +-
 .../selftests/bpf/progs/modify_return_width.c | 39 ++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  9 ++++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return_width.c

diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index 15681b49f86f..2417030f104a 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -7,6 +7,7 @@
 #include <test_progs.h>
 #include <unistd.h>
 #include "modify_return.skel.h"
+#include "modify_return_width.skel.h"
 
 #define LOWER(x) ((x) & 0xffff)
 #define UPPER(x) ((x) >> 16)
@@ -66,6 +67,56 @@ void test_modify_return(void)
 		 -EINVAL * 2 /* want_ret */);
 }
 
+/*
+ * The trampoline fits what an fmod_ret program returns to the return type of
+ * the function: int for bpf_modify_return_test(), bool for the one of bpf_testmod.
+ * Serial: get_func_args_test modifies the value of the first one for each task.
+ */
+void serial_test_modify_return_width(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__)
+	static const struct {
+		__u64 value;			/* The fmod_ret programs return it */
+		bool int_called;		/* Is bpf_modify_return_test() called? */
+		__u64 int_ret, bool_ret;	/* The fexit programs read it */
+	} tests[] = {
+		{ 1ULL << 32,		true,  4,       0 },
+		{ 0x100,		false, 0x100,   0 },
+		{ 2,			false, 2,       1 },
+		{ -EINVAL,		false, -EINVAL, 1 },
+		{ (__u32)-EINVAL,	false, -EINVAL, 1 },
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct modify_return_width *skel;
+	int i;
+
+	skel = modify_return_width__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	skel->bss->pid = getpid();
+	if (!ASSERT_OK(modify_return_width__attach(skel), "attach"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		skel->bss->value = tests[i].value;
+		skel->bss->int_ret = -1;
+		skel->bss->bool_ret = -1;
+		ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.mod_int), &topts),
+			  "test_run");
+		ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
+		/* bpf_modify_return_test2() has the other side effect */
+		ASSERT_EQ(UPPER(topts.retval), 1 + tests[i].int_called, "int_called");
+		ASSERT_EQ(skel->bss->int_ret, tests[i].int_ret, "int_ret");
+		ASSERT_EQ(skel->bss->bool_ret, tests[i].bool_ret, "bool_ret");
+	}
+out:
+	modify_return_width__destroy(skel);
+#else
+	test__skip();
+#endif
+}
+
 void test_modify_return_graph(void)
 {
 	char instance[MAX_INSTANCE_PATH_LEN];
diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval.c b/tools/testing/selftests/bpf/progs/fmodret_retval.c
index 1045462a4ec7..112f1575ce1f 100644
--- a/tools/testing/selftests/bpf/progs/fmodret_retval.c
+++ b/tools/testing/selftests/bpf/progs/fmodret_retval.c
@@ -85,7 +85,7 @@ __naked void negated_bool(void)
 	::: __clobber_all);
 }
 
-/* Not 0, so the function is not called, but the caller would see 0 */
+/* 0 for the trampoline and for the caller, but not one of the 64-bit values of the list */
 SEC("fmod_ret/bpf_testmod_retval_called")
 __failure __msg("R0 should be 0 or one of -27,-22")
 __naked void high_bits(void)
diff --git a/tools/testing/selftests/bpf/progs/modify_return_width.c b/tools/testing/selftests/bpf/progs/modify_return_width.c
new file mode 100644
index 000000000000..add9e80e6a43
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/modify_return_width.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* See serial_test_modify_return_width() */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+__u64 value;			/* The fmod_ret programs return it */
+__u64 int_ret, bool_ret;	/* The fexit programs read it */
+
+SEC("fmod_ret/bpf_modify_return_test")
+long BPF_PROG(mod_int, int a, int *b, int ret)
+{
+	return bpf_get_current_pid_tgid() >> 32 == pid ? value : 0;
+}
+
+SEC("fexit/bpf_modify_return_test")
+int BPF_PROG(exit_int, int a, int *b, int ret)
+{
+	if (bpf_get_current_pid_tgid() >> 32 == pid)
+		bpf_get_func_ret(ctx, &int_ret);
+	return 0;
+}
+
+SEC("fmod_ret/bpf_testmod_modify_return_bool")
+long BPF_PROG(mod_bool, bool ret)
+{
+	return bpf_get_current_pid_tgid() >> 32 == pid ? value : 0;
+}
+
+SEC("fexit/bpf_testmod_modify_return_bool")
+int BPF_PROG(exit_bool, bool ret)
+{
+	if (bpf_get_current_pid_tgid() >> 32 == pid)
+		bpf_get_func_ret(ctx, &bool_ret);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 58846056f667..1fbc0061cc24 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -767,6 +767,13 @@ noinline void bpf_testmod_stacktrace_test_1(void)
 
 int bpf_testmod_fentry_ok;
 
+noinline bool bpf_testmod_modify_return_bool(void)
+{
+	asm volatile ("");
+	return false;
+}
+ALLOW_ERROR_INJECTION(bpf_testmod_modify_return_bool, TRUE);
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,
@@ -856,6 +863,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 			21, 22, 23, 24, 25, 26) != 231)
 		goto out;
 
+	(void)bpf_testmod_modify_return_bool();
+
 	bpf_testmod_stacktrace_test_1();
 
 	bpf_testmod_fentry_ok = 1;
-- 
2.55.0

