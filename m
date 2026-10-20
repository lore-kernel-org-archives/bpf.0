Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538406;
	b=XPJVKpTuWnBIdcYB9/uwBDCE6/hLaxJ3JTk9pFwkKD2oWrOuhJNsOVggqffMpaJWAzeU
	 kAqUiV1dqfIuT7jAv8v5VdpMdKd5L6bMzCp6v21UoxvpsZcjUBQSvHaic7nZ0Ns0e275W
	 tzXD5yQHWQ7jur8AFvEmYICffYlK3iWKQnY7e0o7pU8CvmjC17JYtFF8uIUupqPSVrQxr
	 JX6rGpemBL053IW7j11zisxjkZbSLM4hcsWf1gLcHfhZvXPMT22qS0KzcCf7aMqBvnPzL
	 B49A5B9dCE7QnJsBJEIVh428td7aArsWjhcRZJknwMWQguG1wPFtfuKpxzinxSdrc1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mWBgAx/GtvfNtJMzkPqKkE8splQeTWoiNRw0vydgdUs=;
	b=xnSiA3Em3X/M4NfTdLJZp9u+J9UhaI3ptOONcqOtFxi7ONjJ+MbSSBPrt7aHFXV7J8xu
	 tL9fDL4MQkf70jBASxXcymdBo4zTLNJ+ixGC1a/X7TL2tmJUEF5UPbz8W4SjJeo2YbsyY
	 bYZNPlMavlrCA3f/cJC8y5U02jB9/83NRER/4Wb4QVTobprC/Xmtkhf3H2yQw7GAX2Hr3
	 ILpG3nuOeV2GjUS+nn3eBW9uWPCvOewfPB+Y+7xDfNRSwjnzzB7rfXGUpthCWJ4VvUJ6n
	 qbsp/umGOc6TwNz9JV7JrZH0Gksr6g2nPvXTctJQy99Ty91vWprZXCxiEgjAV3YtJBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="gk/Bq8z/";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9F606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C9F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gk/Bq8z/
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e7e742a2c7so1045345ad.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792538405; x=1793143205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mWBgAx/GtvfNtJMzkPqKkE8splQeTWoiNRw0vydgdUs=;
        b=gk/Bq8z/Yovmw6hZKbHlIb+gHzs3uS0iisKA2ui2ihWeMSjbj0be75Wti+W+KaQ91t
         +l+phTjgajKIN3SV6mrPbiw/BIwFIpM5sJ9W6xrW+jsiRSUTCuicmPXziRtZFkS/P5Xv
         ZRjgCp8tp9JeD264e919HyPkyDdsw+QWrguFZD0BOwc0e8KxncbOLbXS9rf5ckKvvqe4
         hRbAqiOKoEk9yLRiElTZsaT4e88jm/4R/9JCSQ3FRr3sbs9K4V3Ogi9T1a+XbiJuvkWh
         gh0/9uoS5BPlzVI+xKyHIhfTgtatmctSJD9m/wBz/XuXiIpN3cIx35MQkRBbtKZ6uLoT
         1cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538405; x=1793143205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mWBgAx/GtvfNtJMzkPqKkE8splQeTWoiNRw0vydgdUs=;
        b=vIPRMkKybbzG3gpMoR1QZIYRKtFXxMe9IfNgHBWzXhBuHEAmN9gayKnRNHCGAOr+4t
         iPX89bnedAKIv4O7a1vuaLzNIkRprgyqkKO633/w94EtYrwfattWRTruiIUTHE6Vr+Tk
         VvAZn9RB2vRB1mIqSaO/wCJks5erC/+XUCykF3dxRSz29fA07CJmS06YW/ClutQ5sEV3
         FxH7c3bR4BdIpaw+Cd5na+3dAj6F2a6nH+7EfFnJ+PViYmo198rQapuocvlpGgqvR/zv
         T0PzfVZrK2d8Ml88aAqezzr9WZbjXAtSNM5CfNkuJ5pfYcqesBSTaFBU0ISwSFnZVWSA
         +K0w==
X-Gm-Message-State: AFq9FYIyoVLZwKcws+MMLIvPZcdoXsCsDd4ZOiBfV1HdiRls+ZXDuEPn
	idZW8VEJBnz9s9WpZFtHgjRJde8oqPyIiVhaRldpr1MtkJqO+GCsVtiX3SSDYg==
X-Gm-Gg: AYBFou3EtdNPeSGMiDyStRnSrqx+FU3fXQbi8SJazi/J3QpyzG+FevGW8QwBIQIKVVD
	J8kCn/+nn8mO/Tc+0cZD8BzOJH9skWFH6dgOXoon+dMm3qcDxTgtJ96iuPTKSNDz1dZ58Qwqbz6
	WJXt+XYfy9aQHThyF+mMuptRZy9G+KNCDE/DlglciQilVj1PjSuX76JBP94MvTpsC20/1aO8MvM
	XnrNmifqennD8ikVKtRvMrOWEME9/zQJTB6mwdYoGvCco9gcKGGhccxtJ1La0k9sbNFjdGkivUj
	IRVM0b9jcJyjaOJGZCicopEYlqLhhqt9+S/5tP8M1VD5/Hx8k9VwF3rqQhiSoZcFsJ+E6RKENXU
	5EXbtAW1jQoz9i08Mgv1GGpfOW1BZHtx/wR2U1/Ktx1C8d1sfyKoSEcAivHzMw3lG0bSAa0OQQ0
	OXYzakRnIQDaEtzL5eww8IQnxBKAwPSHrxfgxc+qZK5SYI37lLLAPkNgzhst5dWfiL3K1lGJrOO
	AEO5jIbztV7VmxN/eeLWPHkoEm2nKbfij2xNtOzu/yEybpi8lBswm5rH5tofKfoqmWpZwaHzG/7
	rkLfRduFe2POHQmkY4aIqn8+9uijbjMcbcswt0X6eXQtc9UM0QlXsf66+cHvbRr/IIYzsH9uhkh
	uUSdFrYJvmQ/Uh+Fk1s+UcwxN
X-Received: by 2002:a17:903:2312:b0:2e8:95d8:6423 with SMTP id d9443c01a7336-2ea1dda3937mr21487265ad.38.1792538404944;
        Tue, 20 Oct 2026 16:20:04 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4addfbsm3576445ad.74.2026.10.20.16.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:20:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test unwind_exit of an exception callback
Date: Tue, 20 Oct 2026 23:19:41 +0000
Message-ID: <20261020231942.2568163-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
References: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
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

In both tests the prog that throws returns to a call that unwind_goto
follows, and its exception callback ends with unwind_exit:
- An extension replaces a subprog that cannot unwind. unwind_goto after
  the call stays, since it shares the pad with a call of a subprog that
  can unwind.
- A subprog that can unwind does a tail call.

unwind_exit of the callback has to be exit. Without the fix the callers go
to the pad and return 2 instead of 3 and 42 instead of 7.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/unwind_attach.c  | 22 ++++++++++++--
 .../selftests/bpf/progs/unwind_attach.c       | 29 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_unwind.c     | 29 +++++++++++++++++++
 3 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_attach.c b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
index ada8b3273ccb..37e03b3e0ee8 100644
--- a/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
@@ -67,7 +67,7 @@ void test_unwind_attach(void)
 {
 	struct verifier_unwind *tgt;
 	struct bpf_program *prog;
-	int tgt_fd, plain_fd, err;
+	int tgt_fd, plain_fd, shared_fd, tail_fd, throws_fd, err, key = 0;
 
 	if (!is_jit_enabled()) {
 		printf("%s:SKIP:JIT is disabled\n", __func__);
@@ -79,7 +79,10 @@ void test_unwind_attach(void)
 		return;
 	bpf_object__for_each_program(prog, tgt->obj)
 		bpf_program__set_autoload(prog, prog == tgt->progs.calls_global_unwinds ||
-						prog == tgt->progs.calls_global_never_unwinds);
+						prog == tgt->progs.calls_global_never_unwinds ||
+						prog == tgt->progs.shared_pad ||
+						prog == tgt->progs.tail_call_in_subprog ||
+						prog == tgt->progs.exception_callback_unwinds);
 	err = verifier_unwind__load(tgt);
 	if (err == -ENOTSUPP) {
 		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
@@ -107,6 +110,21 @@ void test_unwind_attach(void)
 	attach(plain_fd, "global_never_unwinds", "freplace_unwinds",
 	       "Extension program can unwind, while original does not", 0);
 	ASSERT_EQ(run(tgt_fd), 15, "retval");
+
+	/*
+	 * An exception callback returns from the frame of the main prog. Here
+	 * that's a return to a call that unwind_goto follows. unwind_exit of
+	 * the callback has to be exit: the pad wasn't verified with it.
+	 */
+	shared_fd = bpf_program__fd(tgt->progs.shared_pad);
+	attach(shared_fd, "global_never_unwinds", "freplace_throws", NULL, 3);
+
+	tail_fd = bpf_program__fd(tgt->progs.tail_call_in_subprog);
+	throws_fd = bpf_program__fd(tgt->progs.exception_callback_unwinds);
+	err = bpf_map__update_elem(tgt->maps.prog_array, &key, sizeof(key),
+				   &throws_fd, sizeof(throws_fd), 0);
+	if (ASSERT_OK(err, "prog_array"))
+		ASSERT_EQ(run(tail_fd), 7, "retval");
 out:
 	verifier_unwind__destroy(tgt);
 }
diff --git a/tools/testing/selftests/bpf/progs/unwind_attach.c b/tools/testing/selftests/bpf/progs/unwind_attach.c
index df73c26c1ff4..9aff7c6bda23 100644
--- a/tools/testing/selftests/bpf/progs/unwind_attach.c
+++ b/tools/testing/selftests/bpf/progs/unwind_attach.c
@@ -7,6 +7,13 @@
 
 /* The targets are global_unwinds() and global_never_unwinds() in verifier_unwind.c */
 
+#define unwind_exit ".8byte %[insn_unwind_exit];"
+#define __imm_unwind_exit \
+	__imm_insn(insn_unwind_exit, \
+		   BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0))
+
+extern void bpf_throw(__u64 cookie) __ksym;
+
 int fentry_cnt;
 
 SEC("?fentry/global_unwinds")
@@ -33,11 +40,27 @@ __naked unsigned long freplace_unwinds(void)
 {
 	asm volatile (
 		"r0 = 3;"
-		".8byte %[unwind_exit];"
+		unwind_exit
 		:
-		: __imm_insn(unwind_exit,
-			     BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0))
+		: __imm_unwind_exit
 	);
 }
 
+/* Not naked: the argument has to have a name in BTF */
+__noinline int throws_cb(__u64 cookie)
+{
+	if (cookie)
+		asm volatile ("r0 = 3;" unwind_exit :: __imm_unwind_exit : "r0");
+	return 0;
+}
+
+/* It has no unwind_exit, so it can replace a subprog that cannot unwind */
+SEC("?freplace/global_never_unwinds")
+__attribute__((btf_decl_tag("exception_callback:throws_cb")))
+unsigned long freplace_throws(void)
+{
+	bpf_throw(1);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/testing/selftests/bpf/progs/verifier_unwind.c
index 0a75cb8af67f..5a21345c34d4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unwind.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
@@ -611,6 +611,35 @@ __naked int calls_global_never_unwinds(void)
 	);
 }
 
+/*
+ * The verifier gets to the pad from the first call only, with r6 = 1. The second
+ * unwind_goto stays, since the pad is not dead code.
+ */
+SEC("tc")
+__description("unwind: a pad shared with a call of a subprog that cannot unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int shared_pad(void)
+{
+	asm volatile (
+		"r6 = 1;"
+		"call global_returns;"
+		unwind_goto(4)
+		"r6 = 2;"
+		"call global_never_unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = r6;"
+		"exit;"
+		:
+		: __imm_unwind_goto(4),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
 SEC("tc")
 __description("unwind: no unwind_goto after a call of a global subprog")
 __arch_x86_64
-- 
2.55.0

