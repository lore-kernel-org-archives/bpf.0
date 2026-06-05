Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749763FA5F0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684555; cv=none; b=YrSWJASE0oyzN+DWzNeWvL47EcFHFTc+DdjTGXdwaJO4FldQww20WIL6BuZHtKi4MWsNLJOgCiAiFgLnIngrg6DPTYzvyIghT2+fFZJN2k0qFHXFtOTXGgkF1LCPrvEySOYkkiQ6dD0bsOOgdH7PKPS10cWhpvn2/+S7GGBUC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684555; c=relaxed/simple;
	bh=VKa1p6dcOvuI2DFfe1gs5QWC1H4dbHxEPdSpJFQaEaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaXG6r2idOapvyL9p/7If+72ZhHlqthWTn6UTKizkcv9zW8nN8rcrZ2BmQZj6YTwr24QneiLobrD8xf6UhMVmSqJhISvAQi7PEbwVIj5vutC4/LZs0C4i6YIuyLnJYC0FG8zv6fbNRJd5pplwmism2BC+MRBzw6nFd2tzbPabLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3ps2j6/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3ps2j6/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c3546924so15566125ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684554; x=1781289354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9A8Nis1U71TWs13OCltH/HpVgGML0i1G++ntwFggfE=;
        b=T3ps2j6/jTHDPB6kEp1oGdtIoGSRAwAmf6dfnLGf6P9Si14FqGK/rme8u1f5PPb0av
         PKr0NL+4zhdd9MO+w9gbcMbib6F6mGJvTC/KMqMk1t0VQLSJvkBjhrfH2zNz5EhPAHCN
         +zH+iQQk7b1bSYbVGgHFJG2nFSMuGKz8v04y7SfaI3nHoQUwW+8muTo26Tw6U+5BpBT8
         lkuYud1VfOYfAJJpstqNQo1wWG41KXkG3nrlV0OjoAv3n+RomnoMCLUCbmLLsPDqyj0l
         ILW6g63Q1vazmePf9u9u+qNoLNRrNgaoV5tknHGdVCNgw8Sf8QGKP8iMO4037XgwGezo
         b8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684554; x=1781289354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9A8Nis1U71TWs13OCltH/HpVgGML0i1G++ntwFggfE=;
        b=WsLBm5SqDk8Ej/SYLoKifoelaoNzWbBQ8/e22rfynAIfV0VULoNghPbLPu8AZUaMxb
         AzgnzHePFY+hpbe4gaxu9a1hLhdvcqn0lPJFx7bxL58Cm48nPhrrdIGrwSu2hELRTyj5
         qHS/HGa8Ys0mfTYggSYvoxJfxK0fgDJJWXODJYhzT3lzBlyNSrGYSlKO2UpRFUJfcfmQ
         dWP51hBUukB3JzJSBC2qW2ViCraSdXOTVOgv6tPNuWILgN3fNQIeRimkiu4imRzRO/hK
         uXOBRMhF72TNQgn9MZOTap2MLv2rQG29WOcWx2vi2V5t+Hxn4dyV24tL10ZixC9Jy50C
         yQmQ==
X-Gm-Message-State: AOJu0YzkxU7X/dK6nVFcksQyjNPL/5C05/UKXRy7BhgHwI6bldDTTx4Y
	vGZhBJtJfDYYfWc1imVBVkIM8C4cSQPST91g3jSvpbttFJWmuye78Ccdlfam8Q==
X-Gm-Gg: Acq92OG3u06SgnwBVRLvKL8t4k1Ttl7reZ/ndcpkQ9NOYzv7FKelKduXGXMOjHLnFCj
	o4f/ZMngFRp09BHuUXtb4+Oa0V+dXoHFdT8rlWNKBz6EKX03QF/LK3Yzh8MayG/X0Ftw1AwEKSY
	DrzmXdAUvLVuOzYmnjo3Hy/5KbVsFwL2vdiTCdOorOBgRtpvrKI/hzkjaHBYnKqHXyASKAOJLgH
	OfcxmkRp6X/8wBN3Ot9syqiN2wp4vwBbKHeNcYdWqVUq9rJLYHXCHSUcBhP7Y0k+mscz/cxAJ++
	3YJj5UQVQ+GzWDd/pbSNaDwKVCp2yWQM8B+atEdXJUXjB/lX9CUbDDxZ9rarE/LQicJVmXrr4Tr
	IbGS3ar8+qUX0mqSNUvUc5NWR3Ja/Z/46BeCIPIxUrtF9P/rXC5e2q8iY75/OatXq0OLGU/Z8JD
	ABN/AZYZ6S5/Mud99KlWFMMO4=
X-Received: by 2002:a17:903:2a84:b0:2c0:c389:d99c with SMTP id d9443c01a7336-2c1e8332a7cmr54352795ad.15.1780684553679;
        Fri, 05 Jun 2026 11:35:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649293esm102838365ad.68.2026.06.05.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/5] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
Date: Fri,  5 Jun 2026 11:35:47 -0700
Message-ID: <20260605183551.969144-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acquire_reference() returns a signed int that may be a negative errno
but was converted to unsigned, which makes the subsequent error check
deadcode. Fix it by declaring 'id' as int so the error path is taken
correctly.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..6446db9628ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
-	u32 i, nargs, ptr_type_id, id;
 	const struct btf_param *args;
+	u32 i, nargs, ptr_type_id;
 	struct btf *desc_btf;
+	int id;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
-- 
2.53.0-Meta

