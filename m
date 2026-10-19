Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D54F5DE7
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416160; cv=none; b=dVaChmoJ01uQvV1iVVe9HVgTXU9f6HMu7eW9FlkDC713Zh7pkahi0ngw/Ng0W8SaVyXpoZ74ojazo6sxbHHCl33ktEmN/kJ04zIlkFrpzDMhvvQ2F/FOZaoh0hRDW4X4WE1lY6FUOLXwwWGstioscBAaY60qdmStZxC9jzs88/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416160; c=relaxed/simple;
	bh=0QlVLxG7VGXXIGlqNeeuex6yzlL/165avtau86Co90M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH07nU4GHgcL2Bc12XFB6kt5MKyYo3GxJTf60IWZ5fHYvk3g+uSdSIocMp5InshdOFFC6cdOW59Fix3J3stXSEVXtYiDI4fXru0Lwkw1BVMRk6teAuQkAKnKxhPXwaiBZ51acwgf5/VoGW0F/FP2pKxJeJXU6rmUVXC5gAbmIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6uZ0Pru; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6uZ0Pru"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so1263325fac.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416157; x=1793020957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5JNJiZ/4PPAKsQPee7m171aiI+ghGpdz6y2XFAg9x0A=;
        b=q6uZ0Pru0QajL1THfG//TbG3ePdgaECX0wO+zr6gConKHY1xScnIcnsttJ07jCQpkY
         ma7sJiDLrLq670Ktxr51sqy3v68C4wqSLoyKrrrppZalaxmaNkgYMJUmeLyIcgas+bl7
         /MdSgKh9hqJpvqEivn+KR3b1DYau61lMN9CmKZosenSocFphgVL/sDLCQEn/pQ+xgIGr
         tFPX1F2PRousci/VH/pjh/eGiBPPAy9I0DoGUE2ZqxQq5TnjH7Pkyyf1nox24SlUPw4w
         FVsuyV6HaOuXjI+S6WFxnQ3N6PcKOWZMJp6DOTnQ25MIr84sSTbO+yKww2Bg+pMGi2CL
         1lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416157; x=1793020957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5JNJiZ/4PPAKsQPee7m171aiI+ghGpdz6y2XFAg9x0A=;
        b=ViYO6ufmUA1cNfYtvBN/8mqe4fay9BS6i0WLidVQLZwG1wjeGSk5CHVt8ab1Vi8P/u
         KXpm6DQ2DHoLzkvd+NlffFVUW7TSydHIaJ2Qc/KxpJoC5T0n/TRt/u+DFxpKI44GMajI
         BA7uAcj7R+wl5QPNrKnpwXKMLr74Ac58xUeSSO3i4zq5Qh2aXvgVC3CtaoZQuzhjA4sL
         1YKPHWBrF4wb3xJ9h/cxYq4S29euhrDXQCquLHqbL+o0eeA3xz/O/1LP6Wo7IAGxqbXg
         MWFaJd76uNOwsNxDkQaUFDZ+IA5WEV8Gw1cU5xhNcqrlq5nlop3WHZrwzFyNDrYMx/cz
         ffGA==
X-Gm-Message-State: AFq9FYIrRJicd+ALCi6S1z92OE9ZIU19G2TKYpLhdIPAYZOk6ZPXaVck
	LiroOlSChCuriS+PX8x+ddMtVkbz33rmxJYVDGAZKsKc37uwYLqd0uv9wv1U+JXJdhs=
X-Gm-Gg: AYBFou3oWl7KGdrqpjhSh2r2uD3j5/sGmqxDsgqPNnmygQYZwmEMxl9wCdMsVo9FfKX
	NjmgMo1Cwsxy9K42nDGFA1SMrobQjFzTvhYGACQ2rRuh4o+Q9Zf1HzLdjFhzICc+A8ybFe3Ajyb
	fr5aZICDHm23zq15BnpjJ16qfFWFnSOeNKW8bmtonjTxCfeAZBuwIFrTPoT3D0z+Ro6lXVqF4Mf
	s53TfhScWvMPjlvhqvOL/O1FTIVF1IR3AZLsqgTLTiHZlPjBzSlxMepLJMZlJR5/l1nung/0sio
	/l91o8ohG/LvyPyePZIOT18sD9T7hFz0rvY+c6kcV08V5EkOPDRL8u5zKpCcwpCZPhQBMsstP/o
	S5o0bKt+2Ha9YAd0LDPT5SUT+FZ+h4fzmPICxQJ2frH9jcV3Hr6yJQdtiSipgjBqY95cfjuYd81
	hqlspJ17fD2T8e0thsJPsvnCcwBTFrBQhxufZfhB2l4zr2gPpXjVFFYbpViUbDefocxbsv/387u
	MYMezHU5Ati4zAHzVYwNnYx+kqmc9zKMHIhtQdPgqIUlwcAOHFZ2DcRGMwAnws9kV/Qs7YEeOpX
	QDQ1UQ==
X-Received: by 2002:a05:6820:180e:b0:6b7:8396:f3cf with SMTP id 006d021491bc7-70356392ca1mr4766447eaf.49.1792416157544;
        Mon, 19 Oct 2026 06:22:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b763339sm8376581fac.15.2026.10.19.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 10/16] selftests/bpf: Move the no-arena tests out of objects with an arena map
Date: Mon, 19 Oct 2026 15:21:52 +0200
Message-ID: <20261019132203.3034698-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4389; h=from:subject; bh=0QlVLxG7VGXXIGlqNeeuex6yzlL/165avtau86Co90M=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxNHYGTNu5fpo27yZejsmuVBvzYzFkvzNv0ojH6qKiSir 8TN3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLXJzEyzH1urx61P4VFRmIHl8djtu sxTZI31RXeZ7nOKWA2yPKeyMiw8+HRPyqzjyUzPV1t6biIaYqf2i5Fo+TYSK7qpc/NlB05AQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Two programs expect to fail for want of an arena while living next to
an arena map: the kfunc argument case in arena_kfunc.c and the scalar
access case in verifier_arena_scalar.c. Once libbpf binds the arena of
an object to every program in it, they would load. Move them to an
object without an arena map ahead of that change, where the kernel
checks still apply, so that the tests pass at every step.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 10 -----
 .../selftests/bpf/progs/arena_noarena.c       | 39 +++++++++++++++++++
 .../bpf/progs/verifier_arena_scalar.c         | 13 -------
 4 files changed, 41 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c69c0f7e9cc8..6df440d82675 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "arena_kfunc.skel.h"
+#include "arena_noarena.skel.h"
 #include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
 #include "cb_refs.skel.h"
@@ -193,6 +194,7 @@ static void run_tests_aux(const char *skel_name,
 } while (0)
 
 void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
+void test_arena_noarena(void)                 { RUN_TESTS(arena_noarena); }
 
 void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
 
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index 96f7aacf4d9f..a049d6371d09 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -192,16 +192,6 @@ int arena_arg_unpopulated(void *ctx)
 	return 0;
 }
 
-SEC("syscall")
-__arch_x86_64
-__arch_arm64
-__failure __msg("arena pointer requires a program with an associated arena")
-int arena_arg_no_arena(void *ctx)
-{
-	bpf_kfunc_arena_arg_test((u64 *)1);
-	return 0;
-}
-
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
diff --git a/tools/testing/selftests/bpf/progs/arena_noarena.c b/tools/testing/selftests/bpf/progs/arena_noarena.c
new file mode 100644
index 000000000000..edbd40cd5be8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_noarena.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/*
+ * Programs without an arena. They cannot share an object with an arena map,
+ * libbpf binds the arena of an object to every program in it.
+ */
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__failure __msg("arena pointer requires a program with an associated arena")
+int arena_arg_no_arena(void *ctx)
+{
+	bpf_kfunc_arena_arg_test((u64 *)1);
+	return 0;
+}
+
+SEC("syscall")
+__flag(BPF_F_ARENA_SCALAR)
+__arch_x86_64
+__arch_arm64
+__description("arena_scalar: no arena, no access through a number")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void no_arena(void)
+{
+	asm volatile ("					\
+	r6 = 0x100000000000 ll;				\
+	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
index ecfc6873ffa9..6f0efd9202ca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
@@ -991,19 +991,6 @@ __naked void no_flag(void)
 	: __clobber_all);
 }
 
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: no arena, no access through a number")
-__failure __msg("R6 invalid mem access 'scalar'")
-__naked void no_arena(void)
-{
-	asm volatile ("					\
-	r6 = 0x100000000000 ll;				\
-	r0 = *(u64 *)(r6 + 0);				\
-	exit;						\
-"	::: __clobber_all);
-}
-
 SEC("syscall")
 __arena_scalar
 __description("arena_scalar: pointer that is NULL is an address in arena")
-- 
2.53.0-Meta

