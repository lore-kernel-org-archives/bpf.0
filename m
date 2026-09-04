Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803A471255
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518552; cv=none; b=Fgj82YAYB7YcnyX0zFy/yltmYxPIsz+yTg1Y3a0QNyPoCrH3f0e/0/zFs9edhm1MHOoaKCaH+rz7n0WdBA4LYKzI+ETYFaJ/YkF2hE21v9sTZxFVgFbwfn3/me5C4a2Z6JcvxOtXn+TvB83XDN5fD9rRWvzpxP2a22xDzYws0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518552; c=relaxed/simple;
	bh=4OfrQK4hBwm7UyI0L0xGpXgEEMFxVwQqjggefU1UcbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afneeTlgppzPiKEw2K5TJhAWt1pu4vIh0/bhcXSWhD2uynZvfmFsAVhCGaBXrV+Bo9ZTwPOdTn4iQ3qo5ZMAGBFf7cmx+y10ZeKEdSImuFemuZItRPE1z3qNDn/rzlMCn831cQ6i+fyAC6b8GJJaDtVhvPdAY7zZaf8bbWzEDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sG3LZRDZ; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG3LZRDZ"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso3671735e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518545; x=1789123345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CdgWSQ+GT8ilvip1LiCQUPVcJL2Ok9w97PaItQWRYZk=;
        b=sG3LZRDZU8JorSp70/vAZjSNjGiO42pjcIsY6xXBdDE53ebGu4OSQZssWZHGScqvIC
         snocLaMy4v8he8aWrluDx3Jp3B3eOy7U+VnDirrL66xoA6XVMlniCXEhAqEymfvo3hdr
         tEVJgDVfN9dkhXCFFkUGvWKMTHjfrA4rbVYvW5jm/rr73c0Q0qqNl/JJz/7QCP7X3oRp
         qKNepGWGr2wM+6jfvLHZ3WSthVU6r4iap9JH6348VtEscJUFnIU3QrBkbWsv8EfXmNzi
         rMPNIFdqIoTd0yFLHJeOFecX4uBNkLsmzrkepTFF9pMWeK2JWKiL4MRKzB6P4w1TtNUq
         UvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518545; x=1789123345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CdgWSQ+GT8ilvip1LiCQUPVcJL2Ok9w97PaItQWRYZk=;
        b=nOFq1jjOAkbBTPDEqwhPDFkkW1ohpbm5YoELtKje/HGOlP9mqa/EJ9b6OWugBEJKCR
         vGRqdxdym05ZdTjZdGaJgiO5/ZgRzSphT17pWYq2el+ipfsKxex07HHRfb2+DABdlM7G
         OZja7IjRO6lvEgAaQxJ5VZa3VTupfEV7ndQ8MYjo6O6vThj7zPVF9MdLzTbleU3SuXdv
         SFMH2E0W5BSi1fr3K8LhpO4GjWIe+1Gte/7qub7GiAcmxvha1qV8tLac5Ym57G727TTu
         XzUI0vyBwKKD8nmA9dck35MG+DTVqkOhDYuCo8TVbE9t91K8X/4HR/5nwUkCA7yHtvQC
         ZW+w==
X-Gm-Message-State: AFuF++nIBDtM8k6KiOIuc85j86B3+dea95h+F1OpSEsLQZdltIK8eseP
	PcBbOIndU9p9dlXhf10h0HaCfypi0+Zlpob64iVEzZ2YPElwf8DMI6Rw5TRtCL+B
X-Gm-Gg: AYBFou2zIo+xdVIjuWn1iNpXBXtB4a1CNFTcLXTK7lRVxlKFUvenIZHqfpc+pnG+vWQ
	DAszypGpLJWrUiYdsmZw60RVH8LC+1+ym5LZTD9QxX7RirdKVnjLHPezV/YSQxelz1xggDZTIOd
	tfTXshdVaYSE+1AVsYujpZb9WvLHNrWfvL39bCnYmDwab1c1tQiTLmf4Hm4b9i0DC7MFjvu4GfU
	mHqTIwcKHZJaQuYICTjIIrZZvPDm0PjOACit1/wbHCImWV0cFnYp4zz0gHQ0wsMNcZ9oFHkIvHz
	UMVJEzF+gfInAoFl+61BJsHcJv2IJ5ut6RAuZEY4eDwNUMnG25dPGQLCYO3QWWxSTGNIBY1Egtc
	+F7Bnh8HZa7bSz5Bj90REy5Mbkm4IDNcIxqrXVWmf9nvn7rxU/H0sKMWaJOEoKvoeSL0p+yu6UT
	IabtcJnb26cXxEFVly5QlhUz7n9KTpNe8vrLJGwT8vMsjGMs3yEpx7QlD0Trn35i6D5zkJC06iD
	A5IvqJePIpfak7vHCjn6Gd+X6Nu+c2LpiaoEwCPXwsZqnFm2YOWQycigWNEcyiMSONAHsnkOdAy
	JiBoHm44+qaoHWTSSrOnYtpN0z4=
X-Received: by 2002:a05:600c:1c23:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49cf820a8e3mr57605575e9.3.1788518544552;
        Fri, 04 Sep 2026 03:42:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm20690625e9.3.2026.09.04.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 6/8] selftests/bpf: Test imprecise scalar kptr stores
Date: Fri,  4 Sep 2026 12:41:57 +0200
Message-ID: <20260904104203.345917-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=memxor@gmail.com; h=from:subject; bh=4OfrQK4hBwm7UyI0L0xGpXgEEMFxVwQqjggefU1UcbU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/HPtfxJvPU8/UCwb4vCJtSK57Zw1s9fllMmqIYeaN BtmSd3qKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwES2MDMyzMxREZermfsgOMA9 1vNmhfCkFpdzduyOLpe3h74VfV94lZHh9raOD7fWfQ5KUG7UmXomqkf7yqngW5865fg+prVMOCH GCQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier regression where an imprecise zero scalar reaches a kptr
store first and a nonzero scalar reaches the same instruction on a second
path.

Without the corresponding verifier fix, the second path is pruned and the
program is unexpectedly accepted. With the fix, the scalar range is
compared and the invalid store is rejected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/map_kptr_fail.c       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 5e25ca806060..eee35d203b66 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -409,4 +409,41 @@ int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__description("reject imprecise scalar store to kptr after state pruning")
+__failure __msg("invalid kptr access, R7 type=scalar")
+__naked void reject_imprecise_scalar_store_to_kptr(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u32 *)(r10 - 4) = r0;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[array_map] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto l2_%=;"
+		"r6 = r0;"
+		"r9 = *(u64 *)(r6 + 0);"
+		"if r9 != 0 goto l0_%=;"
+		"r7 = 0;"
+		".rept 10;"
+		"r5 = 1;"
+		".endr;"
+		"goto l1_%=;"
+	"l0_%=:"
+		"r7 = 0x4141414141414141 ll;"
+		".rept 10;"
+		"r5 = 1;"
+		".endr;"
+	"l1_%=:"
+		"*(u64 *)(r6 + 8) = r7;"
+	"l2_%=:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(array_map)
+		: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

