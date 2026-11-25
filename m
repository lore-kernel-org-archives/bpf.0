Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601813;
	b=uy3IrtQ/jz2qFXrajo31Qme8vFJ92tLKeGVVRrihLIzrAl0OWEUgKVZt6khhyjd7Wpy0
	 Iqu8Kfz3FdDBkksAFWWioxBGX+4ryX8qZ4pRDIk1oslv0ibUw+DY5E9qo8Md5KQoT4P+y
	 BYXL7VhLEiU+EfAf7NAPmTMCJLl6cCEZ59SK9dnjHG/B+VzfJ39YF0oRNNfzd4FZTWqp1
	 QxlHVZv2cwLXeM9q8MsDOw5znhiLn1MzX0fTKy7WAV4DVZ3M/tdo/SD9O4ZdgjrHumf4q
	 SBIe6HWhptN/H1wvmn/7GPRlciBSQx6mKPyfqZ5f/rPaaACFCdq6jaPEW90sYxhTd2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gwuYbcf0S9r2sXGONvPKKNcYrCofnj72DonTSrXPeY0=;
	b=uEP7lYM8GAZoKmFCy+tJKg4NVLc6ZScgO33iHno0f/yaT6pvJbGgdmP00HloubKNMC8G
	 RO8EvFZBiNNd2hqz1t5+klWkLQ26Pfyr35+vsWNpzYvtD3kWwMW06KXUIaV4tzTLgWlpP
	 I/drFG4Ca6JeFNwzFYDfRc74hjcDU0Kc/ZcY+/gcQLT9lVcCWBAZ/sHUE+Y95GgZUNTkA
	 68cFVMXs18DRxg38R4na4Uwpu4n4KO7mteh+apFHVwOm7Vbm8j3OScVpCkbvj7LJ255gI
	 TOqFO56ercbjw9dXqHAw30+oXWnev1SjI5iqV58rh67bLVMDAakjAGVq3Bf4uGRYVUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvF89Wzh;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF54606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EF54606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvF89Wzh
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e47347279so3338241f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601812; x=1796206612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwuYbcf0S9r2sXGONvPKKNcYrCofnj72DonTSrXPeY0=;
        b=VvF89WzhJK+Cdrzr6DfL/nNWQlZL6qi1lUXkLz7vzx9qnLZ3zuLPwhNqEM/YFfWKyV
         wFAX3eMUYaW9ExNKAhUk9mnx/dOZnGGz7SMw8vTn288XjsFINxvRFV+PVLSsUlEXHFY6
         ZBWQPfhfzGX+LTg6dSb7PymaFo5XvnDgdzO4oX79XC/yxRlI+h6SXZL3nk1D6ETiwPyD
         rXMJRBa/eEsuBIvhoU7GA2j5P7aoiU15RFtTTbwxrtBmJ/ZXlXg+lKGJGyF+vFu/nQTY
         l9VBdGwK+FdRUyxg59/xKUVLGyL/6LNTarGvu/dVvbEfSgJYYukCIxjQzOrIk70jELRL
         aOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601812; x=1796206612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwuYbcf0S9r2sXGONvPKKNcYrCofnj72DonTSrXPeY0=;
        b=1i53qaTGL+3fymgNa49yqlB+gLppG5t4m0N2aO/0iW48JiA/H78T7GTgH+palezm8n
         /LRvy44GbFiMciNf8tx14tYAhAPTCeDdsPkH38aIbsh2ILTTpryhLBYOYx5ZN2K/gGQq
         RedYOGbWxJJrtWTKbfOlg7XKgSrFYxLko9ROgtazCjV2r//CnnbzBZps2eAcfrQN+QBZ
         d6am/9Gf5nVzFqhRaKAY4NsmN7mUtRAVUtgU39OFw13PleYtyz//hBUUPhlzccgoIYX8
         AJ+YXHCwTTx6pbYx7NnqUdQScL9XgiAh+H8a/z1TPXtHFO2SV3SW36pvTW4DwKYQZ/7f
         FXUA==
X-Forwarded-Encrypted: i=1; AL+hErGqhnlERMqCBbUuykj5Z8cOmeubAXTY1nVLyRz7wuuu+mi354VcgL90sscy3fWI4dTiV0g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bNztSRV1AFzsmjnwwUlPowl/iomu6/NoLLmgoVecG4tmd0N6Y
	lGbrohGvhN/Nnk8slrvZFa2ngD1NM1jHr1t6Bj+qh7UMfLsMsk0ih4Hb
X-Gm-Gg: AZFdTZckOS+IlHg61F0cBKrFxkcv+BN4trh67DvOk71MLWHBHH/zvGfgTplrH67TGDH
	s66dFYEAVu0Xg2RE9n3DsaKm2rPFmuGdWcbGYvCQYISOBMnuipd+Z7wI4S4NVHX/JhtuaRVd+IU
	j3tEeLLuZmE2SWCXtmirBSVoJEGiO7zatKXoKVYYUywSn1DdwwcBFsNpItALS4xsu2KBpdmGuZs
	u6DaGU5Vut7B191KuEzQCR52O5h80g/11ttkT/ugpPVUdGKptspdZVWcn6cUoYut6w2o5hm8TZr
	GYz/PBDUIX8NhzoEAW+vaBSbFzHnftYQwlpz7wKBYkn0UxkyfhHN6wWookNvUpQOSUV/zNVCa3p
	6ceideC2eZ3ik4+7cSpSxV54mAeq8c65+gOHOR9ywypgFMD6WF1Sdohz+MIfpXdNF6zSjBNFP3p
	tfPEg05h8ZOsrGToE0Lvsswh5VrCCNMSB3wA3gcYBPWkyGoE+kl+6WzI6Am1XgO6NBw4Ps3NIVX
	Rj2ipAyvZrJ928LqtSAd0Kph5AMJAJFjLd3RUptAw039nkkBZEd1Y5h2oNrQLRolvnUs0NQO2PE
	V5XrhY0Q2Rz3WAntyZPPkYKRZ7OS4I6LQXvtkrqBH6mSvOs=
X-Received: by 2002:a05:6000:2b87:b0:487:13f:f612 with SMTP id ffacd0b85a97d-4abb6095d9bmr19979718f8f.37.1795601811921;
        Wed, 25 Nov 2026 02:16:51 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm34765938f8f.29.2026.11.25.02.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:16:51 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 6/7] resolve_btfids: Tag the functions that return ERR_PTR()
Date: Wed, 25 Nov 2026 10:28:03 +0000
Message-ID: <20261125102810.699464-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125102810.699464-1-a.s.protopopov@gmail.com>
References: <20261125102810.699464-1-a.s.protopopov@gmail.com>
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

A function that returns ERR_PTR(-EINVAL) fails in the same way as one
that returns -EINVAL. Its callers check the pointer with IS_ERR() and
get the error with PTR_ERR(). But resolve_btfids looks only at the
functions that return an integer.

Look at the functions that return a pointer too. A pointer has 8
bytes and its errors are sign extended as for a function that returns
long. NULL is not listed: a program that returns 0 lets the
trampoline call the function.

The verifier checks all 64 bits of the return value of a program on
such a function and requires the JIT for it, as for a function that
returns long.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index e1afdb6dedd5..db9794a88aef 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -29,8 +29,8 @@
 /* More than any arch has argument registers */
 #define MAX_PARAMS	16
 
-/* Return the size of the integer which FUNC returns, or 0 */
-static __u32 int_return_size(const struct btf *btf, const struct btf_type *func)
+/* Return the size of the integer or of the pointer which FUNC returns, or 0 */
+static __u32 return_size(const struct btf *btf, const struct btf_type *func)
 {
 	const struct btf_type *t = btf__type_by_id(btf, func->type);
 	int ret = t->type ? btf__resolve_type(btf, t->type) : -1;
@@ -38,6 +38,8 @@ static __u32 int_return_size(const struct btf *btf, const struct btf_type *func)
 	if (ret < 0)
 		return 0;
 	t = btf__type_by_id(btf, ret);
+	if (btf_is_ptr(t))
+		return 8;
 	return btf_is_int(t) || btf_is_any_enum(t) ? t->size : 0;
 }
 
@@ -80,7 +82,8 @@ static int cmp_error(const void *va, const void *vb)
 
 /*
  * Write the tag for a function which returns SIZE bytes, and in them one of the
- * NR VALUES of the return value register. In 8 bytes an error is sign extended.
+ * NR VALUES of the return value register. In 8 bytes an error is sign extended,
+ * as in ERR_PTR(). NULL is 0: no program can return it instead of the function.
  * Return false if there is nothing to tag.
  *
  * The machine code cannot tell the -EPERM of a permission check from the -1 of a
@@ -217,7 +220,7 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 		if (!btf_is_func(t))
 			continue;
 		nr_funcs++;
-		size = int_return_size(btf, t);
+		size = return_size(btf, t);
 		if ((size != 4 && size != 8) || !fits_trampoline(btf, t))
 			continue;
 		/* Init code is gone before a program can attach */
-- 
2.43.0

