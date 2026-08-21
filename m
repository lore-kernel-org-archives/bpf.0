Received: from mail-ej2-f11.google.com (mail-ej2-f11.google.com [74.125.228.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1B435A9E
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355336; cv=none; b=M7sO3QJVtH7sF9/YHacQ1DFO2Hw8yqqVA/IkzZlUm5fW+3Jq3XVWZLJ2XZZBjwN6IToKsX0LHML8bJ34+Ghxz6Nq6dZ7ZKXge314ElQcOcDtH79CXwl5tzdas/JYXolIwa0q1qpngXlV1dMrEOuHGHrPIloPjKxZ9d1Pnqm9CGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355336; c=relaxed/simple;
	bh=CwZsf3ZfWJo3J8X8dBsEHiedn/Z9J3bcszOLVChSSh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3zuYOEwGeb41z3lRQk3NBX/YZM/0SRi7bq1zbnEOHDp2LiWwrAa1ZxbkYa/t5ixuxPpeM6sEwvM8d/RChr4d7m+dPQmk025krCKFDQeLJEwvLcVJu+zj1ECL6GUhuAPNJrrSg4VsehgvWtNfjaNTIpyDEqGBcqDr1XkKoxnj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kw+SjBTK; arc=none smtp.client-ip=74.125.228.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw+SjBTK"
Received: by mail-ej2-f11.google.com with SMTP id a640c23a62f3a-c213511f779so88818566b.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355333; x=1787960133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tUloXQLApL2SAFzFCnIA7xLfNEwgLiz1XR6jLv/RmMQ=;
        b=kw+SjBTKlE/h97dN+S2XRwCA7kszxU/EFCiahRfWXxWTJzFtptFEomOuoedZo20mx3
         k40Vf9mUggDQzAce4K4e+CeA1IhBZnkIjhaNBX3U3AcmBmjT4HJO1vrcTioTQjtYNBVK
         4kMzGPYjtYLLR2BpW+rAx+c65E1e/OcqMk5wqLvoY9RgowgxpfAAq9MbAt+GR15lk76H
         XQk252MlOC0yyQ+Gth1x+lezwsMepJ9entCMuF9sloRbMermOnRgJkKCvu1EJVk1hN+U
         dL9hJjTHs5IaGDNKoPF66WGpN4C8GaC0E6g7/WvI272DiPvfF1JzvJK1mFJaj0KM1wJV
         o3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355333; x=1787960133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tUloXQLApL2SAFzFCnIA7xLfNEwgLiz1XR6jLv/RmMQ=;
        b=nNATPCozz+s+WkWHQq0ygSJCGZ5HpCXxXtWeo9c+9GakDP6X3RRuG57OP5ZCec84Z5
         ajxJNBrFEUuE18WODPeneXMZI6FOebnVWBeQs8UaPzevhYL3CFqTyCGiYlkXzwDRQMsj
         1SM+NJaRIWt13wDv2vxQaoPA0qgB43W36LKJ+LbewNg4quoksRqpQSymd0xfaHUUQKbk
         wDbbXmQBcCztBi6iixP2sUJqucyNOE1EmjdeWDBkCjwc0oN8qddIhXtTejD/ZX4OdAlU
         Wq1zakKJI85fnvIvVAuQcj1WaBhp5/1V6AraaLhNo5s5RfcYhA1Agf9+RPHt8v9gWSI+
         iNiw==
X-Gm-Message-State: AFuF++mvyPFo2oqR8szXJ/bPO2pDoacroFqoGlJb8rOP/QynUhxImaQR
	sGu1TjQk61ooRpcZIeoiqaHT4nWq81AsAgOZ+g6le3suTgMXXRLtM9jTvGB0gAC/
X-Gm-Gg: AR+sD1115ZeqJRHrHnG1HrRaFDXFTPuUNzFW7IDs/f8qcrKE2Zghq5Cr8t/AG7TTxTL
	uzvO0gwCEgLJH3y37eG5Dm9NijglAu9VYdnFLsv7PnvinmvZ+izG/ZQMIQOFLegPL5FWR5WhZSN
	IZ5s1rtsKTiB6Lm6x8YmLy8QljRRQ195SH1/z8WYE/N+d09kxBd8ZAL+EOFcG6Mz1QpMjSFRjcN
	dEUJD4d+4w2NmzBEs3iGiwazAH8jNarCMQckz3oJe3YPfMT2VaSCR+lqZLDXjcSkbhIS7CMCp8u
	FdfJd5N9c2jIyVsSrWkLTD8fwzZ8W1ZbTHKhtNTqabgS4hFfISrpwcauOQDA3fPOdrGVQ25Ql34
	/UcgKW9iUYtB12Rt7XwbUBbMb4q8xKXGv1NZl7UHNA7wLOPMXwEKkoGSYF9x4dgA50+saK+Ftx2
	ST5mqpzIs6LLs/2rGQHZgdy943mjAbz+lhNNXlR8rTlwbn3UV/hWPlb23G1DdjQBQFE/WiR54GT
	Q9JXZxS75mRJpqlb/ueATAKRZaV+3BgUYgklguInucdYwEUWKaGWqxYPtuegqMy7wF4DaH015hw
	UVrBxfgIl0CNM02wMkWKHVK3Swg=
X-Received: by 2002:a17:907:934c:b0:c15:f65a:43a8 with SMTP id a640c23a62f3a-c246a604950mr1028081566b.12.1787355333103;
        Fri, 21 Aug 2026 16:35:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496295632sm52488366b.18.2026.08.21.16.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	"Naveen N. Rao" <naveen@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/14] bpf, powerpc: JIT arena kfunc argument rebasing
Date: Sat, 22 Aug 2026 01:35:04 +0200
Message-ID: <20260821233516.3426127-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=memxor@gmail.com; h=from:subject; bh=CwZsf3ZfWJo3J8X8dBsEHiedn/Z9J3bcszOLVChSSh8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQV/eRIWbL34+X2iZptKbNnHOxXeH9m1VnPbJxNP4r vSzrtgvHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIHjOGv5KGc0yOGHHM3TqX i8G/TESeb97dm5dcugu/5bafvBuVrsLI8OrXPibro7fqBaUOX5vE+2TCl5gFCfrLPFWNrzvYuq4 OZQEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kfunc parameters annotated with __arena carry a 32-bit arena offset in a
BPF register. The kernel function expects a directly dereferenceable
kernel address, so the JIT must add the arena kernel mapping base before
making the call. Nullable parameters must preserve offset zero as NULL.

PowerPC64 already keeps the arena kernel base in r26 for arena memory
accesses. Reuse it in the kfunc ABI preparation path: zero-extend each
arena argument to 32 bits, skip the addition for nullable zero, and
otherwise add r26. Advertise the kfunc-argument capability on PowerPC64
so arena allocation kfuncs can move to suffix annotations without losing
PowerPC support.

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Christophe Leroy <chleroy@kernel.org>
Cc: Naveen N. Rao <naveen@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp.c   |  5 +++++
 arch/powerpc/net/bpf_jit_comp64.c | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7b07b43575f1..911088cbabb9 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -527,6 +527,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return IS_ENABLED(CONFIG_PPC64);
 }
 
+bool bpf_jit_supports_arena_kfunc_args(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
+
 bool bpf_jit_supports_private_stack(void)
 {
 	return IS_ENABLED(CONFIG_PPC64);
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index fc9db691e820..fc235fbfbeb9 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -624,8 +624,24 @@ static int prepare_for_kfunc_call(const struct bpf_prog *fp, u32 *image,
 	for (i = 0; i < m->nr_args; i++) {
 		/* Note that BPF ABI only allows up to 5 args for kfuncs */
 		u32 reg = bpf_to_ppc(BPF_REG_1 + i), size = m->arg_size[i];
+		u8 flags = m->arg_flags[i];
 
-		if (!(m->arg_flags[i] & BTF_FMODEL_SIGNED_ARG)) {
+		if (flags & BTF_FMODEL_ARENA_ARG) {
+			if (WARN_ON_ONCE(!ctx->arena_vm_start))
+				return -1;
+
+			/* rN = kern_vm_start + (u32)rN */
+			if (zero_extend(image, ctx, reg, reg, 4))
+				return -1;
+			if (flags & BTF_FMODEL_NULLABLE_ARG) {
+				EMIT(PPC_RAW_CMPLDI(reg, 0));
+				PPC_BCC_CONST_SHORT(COND_EQ, 8);
+			}
+			EMIT(PPC_RAW_ADD(reg, reg, bpf_to_ppc(ARENA_VM_START)));
+			continue;
+		}
+
+		if (!(flags & BTF_FMODEL_SIGNED_ARG)) {
 			if (zero_extend(image, ctx, reg, reg, size))
 				return -1;
 		} else {
-- 
2.53.0

