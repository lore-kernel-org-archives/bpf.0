Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C64343EB
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355333; cv=none; b=I8yeLr45Dbtv3ly0kjrai93of0ykPueqBydEidHnw2lvrGPIDYFfNkd0pSP1j0F3IbqvcN2GNi0J+r233lqz1WKTVrh6bKjAxasZ/hQKn0mP1T0LrlE792wUo8ogzW1kHTkbnaHTC9l9uBNVgRXiwVBz8EPvXHt4XIJHh5n2ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355333; c=relaxed/simple;
	bh=5ObQlTwLsTAcU3LRiGp794P70pdMVbrypjDre9HZV/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiDoWWdnbt01tb4kDkKFH6iRVwzY6slrMA8f85NdxZRJicy3l2C1VbQYyrPbeMqjwPrFTqi3ekSDDjiyd8CRgM5aY6iOOIq+ZUKrrLVRP/K/LdZqa5dUKCjzeoPQFc8pVFJlgu1Chh/kTOmsHxUsJp+4DxflBzrVJGOs93U+jyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPdqb3W6; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPdqb3W6"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15e0279316so67910666b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355330; x=1787960130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3PG3OV+JNTkDfPyKFQgySipTCwIIEQilH+uwrdehV4=;
        b=OPdqb3W6YeVBW/hit9nTMcr6Phsfpzk8pKzfwEBg1BvogsNbRpToz1KepK+RXIsqQY
         DVqnZ4UklYOL2XJkmXwCqSnp+EgC7Wo3RzwjrXiWmLSnMmA0CUENdaUxckthf+CIIEoO
         67xqcVtW87BDaMtTrnelAUA3siwR7SrbjO9P7LzbsyxRKNYr3Ux10+RfmGC+Z/GWRDak
         UbmHXMW2FNXuK8Q5Pw0zw9TOUt+U68Ivl9S5yvJTZWdXdMqfXY3FVwsIDqzMVf6w9zOz
         a3MUaJwcepv/uaFG1hld+uiBsrfsnWe3jhjyIvBROYEMm/Su+rWvvY0Uw2CtIrMMisU7
         WB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355330; x=1787960130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B3PG3OV+JNTkDfPyKFQgySipTCwIIEQilH+uwrdehV4=;
        b=BjAD4O+hHWueRFZJIs9Z4ybgHgmJKWe7BHh5NzSW/YR2wLiCki/AxUzQN8wM/Lmp8D
         Bbgen5MljB/IxQ4KfQrD+Z5Pxy9AlxlRDJcmUGqI7ZAKJmTWET07rcbrfDWVPc9+c6Tv
         X5b6jJmf9Y4VH5SpPM62NjWzW6q+WxELtMPAeJfYK5e6aCSCrF9FosyvRzg9nVkoWqjJ
         1mLN7UzDhkealYWf1HLjC9cmQO6nUWF6tF186XTbHRJwsmySitSaeWXQbPUqt2nX3pjv
         3WTFfsNo0mjs8cA3TF1HnEQIU72oyBcKckRW3KKPlzOBswCpa4otUgr+6nOx3deMMwXG
         7IYw==
X-Gm-Message-State: AFuF++lbgnQ9/7ZLIvVBGh9DrDq+DC3z1o+mdkLMOSvgavF/tmDb4lhy
	beZHsfRjw91R/71xzQV0NUdOV6Ab+E+iRj/sHKcjkUZCfmfeLKR/os/GKtaBUX2p
X-Gm-Gg: AR+sD10pt+9JZ/USDm2yrAsRGNpFPGqn2QCcJPYOaSGBojd7OI1DR92Zv8jevv/CSwr
	QX+gejv9xTDAVhOU0JDr1ameKlUNYQ8n280MWjqB3FstHZ5RI/nCB5kGw57q9k1FS0zjhwshR8X
	5sBozCNiVkBPjgWgGmBMYMaBxkrRbOzBhOUGHvuOmng6+1jhmTBqc7G2Ezb8x9iyHzZbCVVVeVn
	XenAtqTWw8MhAKZE7t4EVz4uyCvDRc3366M2thzxZHO/Cw8lIX+nUy6bmWQebDztljwqsc4pe1L
	Ey1ag/3QtiJnjkMgevlZZEVPieReuBAqKmRCOSrq4xlVr7pqMWwaRF8FicScPC+jnIe/P7YFwln
	H0GFgNDRxNICRizRxBGjAW0ED4RQM3TJPvLReBpERYhVzntIR9JUsS7lPk23+Dq5qSDP+5LBRS8
	Rn66jTZm86ZRitJ0uMJqYmowvw7WF6M2CzcsYoclTvgpqVEU50oQRBIuOYa8ciX9RCTUvxytX1k
	qXPbrzYcLV/ZV2obwmPNiSdi0hwtuvWazuHJXTGBmu1pqrIQOd1Gr46vfYZm1WJXguhmejAnvqC
	N+VixsqJceLxeACNqvGjMhNan+0=
X-Received: by 2002:a17:906:f049:b0:c1c:4db0:8314 with SMTP id a640c23a62f3a-c246a60c26cmr929684366b.13.1787355329854;
        Fri, 21 Aug 2026 16:35:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm41648966b.27.2026.08.21.16.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/14] bpf, loongarch: JIT arena kfunc argument rebasing
Date: Sat, 22 Aug 2026 01:35:02 +0200
Message-ID: <20260821233516.3426127-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=memxor@gmail.com; h=from:subject; bh=5ObQlTwLsTAcU3LRiGp794P70pdMVbrypjDre9HZV/k=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQZ/riQCv/nOrGP6tnqXeciiNaYnplBVPzP+tLt92R q2h8JtDRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbiX8/wh8veSO/X9hXeN7w/ l91doKNd9mlh9pUpH05++3LcfeHSJb8YGa5PCAjg8fGsNasvTApwl5y74tC0WwsqZn/+suWduMw jHUYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kfunc parameters marked with BTF_FMODEL_ARENA_ARG carry a 32-bit arena
offset in the BPF register, while the native kfunc expects a directly
dereferenceable kernel address. Without JIT conversion, moving arena
allocation kfuncs from KF_ARENA_ARGS to BTF argument metadata would make
LoongArch pass offsets to functions which dereference them.

The LoongArch JIT already keeps the arena kernel mapping base in s6 for
arena memory accesses. Reuse it while preparing a pseudo-kfunc call: clear
the upper 32 bits of each marked argument, preserve a nullable zero by
branching over the addition, and otherwise add the base in s6. Keep the
existing ABI extension path unchanged for ordinary kfunc arguments.

Advertise the kfunc-specific arena argument capability independently of
struct_ops trampoline conversion.

Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index d193293a0fd2..33cabaa7353f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -283,6 +283,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_kfunc_args(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_far_kfunc_call(void)
 {
 	return true;
@@ -1195,9 +1200,22 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 			for (i = 0; i < m->nr_args; i++) {
 				u8 reg = regmap[BPF_REG_1 + i];
-				bool sign = m->arg_flags[i] & BTF_FMODEL_SIGNED_ARG;
-
-				emit_abi_ext(ctx, reg, m->arg_size[i], sign);
+				u8 flags = m->arg_flags[i];
+
+				if (flags & BTF_FMODEL_ARENA_ARG) {
+					if (WARN_ON_ONCE(!ctx->arena_vm_start))
+						return -EINVAL;
+
+					/* rN = kern_vm_start + (u32)rN */
+					emit_zext_32(ctx, reg, true);
+					if (flags & BTF_FMODEL_NULLABLE_ARG)
+						emit_insn(ctx, beq, reg, LOONGARCH_GPR_ZERO, 2);
+					emit_insn(ctx, addd, reg, reg, REG_ARENA);
+					continue;
+				}
+
+				emit_abi_ext(ctx, reg, m->arg_size[i],
+					     flags & BTF_FMODEL_SIGNED_ARG);
 			}
 		}
 
-- 
2.53.0

