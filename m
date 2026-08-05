Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91935C1B2
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921770; cv=none; b=fWPmkhvH28IwnrDXhjmTszOlP0HRiUjkEViYT7xmo7cCr6PjIlOEKZUqwngmvxqRWWtb5e71OnSxrvOCqpasH6jLPc/H4PTwN9/03xMBaI+sEqk4v9v/T5AjXU+AZ8cUoj5Jt1eSuqgzDFB2nbO5yqlC93IAdPThgOr+tUsZw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921770; c=relaxed/simple;
	bh=avoC8K08j2pP/keGcjKdaeHNHLfSEzCe37F4cx3EnLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hstzrPnGtd+MVjF9SccFixS21BvYn8jANLaoqR5MD/5X0+UR2kPEsBzsso3GUMNhkvz4dKqeQjetNsQd9907yjAvyCFYxJZ4h66HPrM0j/NvVSkGJrjPFytVYjv4Ae4KiWpyZZgclLUC0CXy7exatnrYbGyl4nlu7ZiJ7ki3eDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVHY1cSp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVHY1cSp"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso734208a91.3
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 02:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785921767; x=1786526567; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=avoC8K08j2pP/keGcjKdaeHNHLfSEzCe37F4cx3EnLc=;
        b=ZVHY1cSpv6zB8Myy2ZOZcOH/CJxX98zheBsZui2DHDVYXSGOSaSj9b6gvHeRJx8bSH
         TeFRWkDbUe8/KL0aJeRkX9IedMuwq9v4yDingNebIVGoN+9K867H3TTy7TGGe8af0ykA
         ewrFwQEfZhhgA25ZvASPwYqpuhUSrSRCsP+LcO7yfHkVlCCzk8yl6+5Smj836woOdioH
         jv3IXP6qxZOJO9UUnGUfo2fJqREXK904DWkG4HHDMUhcNbXI4ShbtELk+xrhXOY3KrO2
         su9iPfECYpvpO+mW4grB9uIaBudROBnUxqdlNmm4WoFc0Qzu+9xhjsg1MYeLCbpv0Tit
         olwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921767; x=1786526567;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avoC8K08j2pP/keGcjKdaeHNHLfSEzCe37F4cx3EnLc=;
        b=cXbqIBbkpyMUoEuTj6rvW5svcfuiWxlcAamz/8pWmuyvzZ9iipizC4dr6/UdSQtnjF
         kyADX+IZO3PDrpjwlyktWZjRSiaCPR5Yr+BlDPOsvhnBx7+hRJpuaQr3wPZtsIqoI+Sp
         2qtTlT0NAcwZJv42AY1L6VTogaT6NlcQNaPVTTaMG0OLxBCVkO5dkoThYDz4DCByr0cK
         mCuNGKdyEZeG7bBh5OYNwfDIkHycLedd4kp4j3gMgXPA26r9BBjse1gtilMglcq7+RCr
         apygvluAzM9vW62PKpeXlhY9vwKyLpq0yyNpfKTuYLz2GI3K/2z11nBKRC0BMGAb07U4
         3DCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMENBGEP0sya2+akSQiuFwTWr0oZnCYK0FMxNeY611DXFy22owXB7ciJ3A4N6RTNbdENo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoGDTxf/pirdQ1ri771g2GKDBx0PMtxIl6/UMAiHWK8isyp3W
	ykiXkbb3XYmHsrgkvkUGwumxlePePmm7zn2oipoeBzbaY0UZiMnJ92au
X-Gm-Gg: AR+sD131ACXxrv6r6OFUX/wlrLDkfjJijsVo7n9802JZmFDkS0CCqFVrZc3dL/J/kxZ
	xgybGPh+Wv0kE6NAXaDg+bMCwcOXJl2Ed909bz/dLz2pP2XPz0htGUo6fRV1Eqb/X224eif0gDm
	dms05+3G4TGDchTnFMGMVW8SZZpCAth99Bl9BIYE1A+7AmzUxPVqdrJsk7KVvdcj499KGPOwdV3
	7k6PJ7nINlS+3nYoVB4stXKp5y+yGgBa3dVSEKPgRy4XY3Jt8kyGpxd7kTUWZVXnrJDdkANSheA
	QViiPb06Eq4KaOzW6V4/RWlVzFabWd4c2jX6FhvSFGUZJR1pNe8PJjPk57cuEu/4Uj6gdvfz2CL
	cSjxSDmy76E3FItCyNnNSV9y+vKLIRCX0a2Q5/hpThv2F0XKS60b0ST9LAi9bTkYyrMc5eCGW2b
	PB36BNDAIRO9meIhvfME+UzA+6vXhfGyRu9n0jVpbCR/9SkQYcgl9RRl1J5nYROxmC12bzf65yP
	hIxtamZ3YCdO0V/
X-Received: by 2002:a17:90b:5112:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-3903c5919c4mr5491602a91.12.1785921767505;
        Wed, 05 Aug 2026 02:22:47 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febffb349sm4087963a91.6.2026.08.05.02.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:22:47 -0700 (PDT)
Message-ID: <98a4faff20470fbfec71cb15336608d11d1a3cc2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Check load-acquire src ptr type
 before the load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, info@starlabs.sg, bpf@vger.kernel.org
Date: Wed, 05 Aug 2026 02:22:44 -0700
In-Reply-To: <20260804201917.253491-1-daniel@iogearbox.net>
References: <20260804201917.253491-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 22:19 +0200, Daniel Borkmann wrote:
> check_atomic_load() calls check_load_mem() before atomic_ptr_type_ok().
> For a load-acquire that fetches into its own source register (dst_reg =3D=
=3D
> src_reg), check_load_mem() overwrites src_reg's type with the type of the
> loaded value, so the subsequent atomic_ptr_type_ok() no longer sees the
> source pointer and fails to reject the disallowed types (ctx, pkt,
> flow_keys, sock).
>=20
> Since bpf_convert_ctx_accesses() does not rewrite atomic loads, the raw
> access to the underlying kernel object is left in place. The destination
> type is taken from the ctx access itself, so a load-acquire of the sk
> field of struct __sk_buff for example leaves the register typed as
> PTR_TO_SOCK_COMMON_OR_NULL, which type_is_sk_pointer() does not match
> either, while it actually holds unconverted struct sk_buff bytes. Once
> the NULL check has passed this is a type confusion, not just a leak of
> kernel data.
>=20
> Validate src_reg with check_reg_arg() and check the source pointer type
> with atomic_ptr_type_ok() before the load again, mirroring
> check_atomic_rmw(). Out-of-range register numbers are already rejected
> earlier by check_and_resolve_insns() (commit 503d21ef8eac ("bpf: Do
> register range validation early")), and the only exemption there,
> is_stack_arg_ldx(), requires BPF_LDX | BPF_MEM | BPF_DW and thus never
> matches a BPF_ATOMIC insn. atomic_ptr_type_ok() can therefore not
> dereference register state out of bounds, that is, the out-of-bounds
> read addressed by the Fixes commit below does not reappear (as proven
> also via selftest).
>=20
> Fixes: c03bb2fa327e ("bpf: Fix out-of-bounds read in check_atomic_load/st=
ore()")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
