Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0530BBAE
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291725; cv=pass; b=qOTtZ9eI70GKAVblFzhxk+pzwjmCIbVy9U3Dgjk/RziH2VFqTGn4E2g6KdJakW/QcO+GCcG5sPnlZQ/T/8zHxKggCIzAQfwUciuhjFNcnYlle3iZTY0ZTJZhf7Q0WREq8ohRHC/Q5n08//6LYGbiNf4NOqcnqLeQkXYZVYl9aIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291725; c=relaxed/simple;
	bh=PBbH4u/pktwkzzAmIYFi1Z2PyDMyzJnLpwEcNDyPPKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuYmWDtUKbd9GeoYYKAF6PPefaNiz/CszKItSSoh/ulTvtRVseXX4ibG+Bf81HQu+pVXkTDXkYk5ZGkU95b/OcicHdRbu6MtnQvbS2NyAzifoEPKPo/+vA3jjh4JGAlxlMaUXqb7tID7U9huFl6jNZHddmm04K+Ci8IaFM1L2c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPcdDQM3; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPcdDQM3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-827270d50d4so9052445b3a.3
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 05:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777291723; cv=none;
        d=google.com; s=arc-20240605;
        b=W+Y84HaFsV/T7D63AqiZu9HanLjIwVPk2byubFzg0EqhaRPLQLJcLh4++Veo2v23m7
         LdSMPvF6d8iuTxI1lfGQwgvHozy1xwl1Jf0FcUvYLX40WFkXNq3Zw/KDgGvXxv9nNsXX
         TCRvDKe0hyzEJwiR9YWnejLBAcdnEYvnmDyguJu6Jpz1tt2dggXOv9D1Mr9lS2j/iJ1R
         mEik+fnzVXiXMD+PvCgayDjr0fNo5jFmPhrffSqpNnyqD7cosAyDpSfdspKixt1GMJH4
         qKzmY0AvgwNxrVrZhqOHIMajNu9D6FQj5qopTM4nkL5TumgqixNEhXdSWNp4TaVxMblz
         7xrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KTTBNg3JjJPZzuR3ltBH7conCn/tJdSFB+vshOOqyNk=;
        fh=2vcMt9UgHtkwXwptNriEyIGPh8blswQ/HZVdLHNm6Ow=;
        b=GosAusfzshKqLkFOlbNRuktH/pAcLUGCEWZTrdluQk6rGSVgvCPliOHg64qkV66l2j
         LMhbr7Q+teMZgKJBumBlU1cCRWH9wFd7x83N5hQD8kfEDLhyHK1cgdkEioRmSL8cEKZ/
         EBxQykRW7j8dwI3UpP5ZVIceH0ZOSQqUHIB0/cwNsUhiguUFJvr+ipcOypVYpHbUTyvY
         XnEpdJj+sRsO3p3gCXPO74iUWUOVW0CV4okUjnbAl1IzpJceCxKhc+Krhx5faOHX9MbT
         cka4tGQ30h54Zd2WDx2wOsVotu7sjp4GKst/3xv2eIgsAKjsCTqDuwv61m0LVZZcfHVj
         wPNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777291723; x=1777896523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTTBNg3JjJPZzuR3ltBH7conCn/tJdSFB+vshOOqyNk=;
        b=LPcdDQM34wRbMIZRu7i/p0IxXf9B7mo3GiCkbZxlw5dYR3s3fFPikvKw7rm6xTx5QL
         Ico3k08K9VxKyibXiz/CEsXaKUAvz90fljoRFvSihWDZfRvgwF7C54HZuC6w28ct7Xc8
         DQNem95kuB5ziL1BRTBA6VPDZmtobyszB76WceGc+Gkyu7RvczWsLcfV/Eb/FersyN2R
         kJ3i+RuyzCux2LygQ5AS4CEPGyyzY976QvAjVh/VbEkXv07Zp9V2QjNGqjXbmX7B5g1T
         XOGLAtNaq25LMbzM0m7oQNIUK7HPotE73Hnts9Qz7jfqjk/It0qFUYRW/HdNHMvIWiv+
         EEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777291723; x=1777896523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTTBNg3JjJPZzuR3ltBH7conCn/tJdSFB+vshOOqyNk=;
        b=ocj1zBDrB1Nr2H4CKoOXomZOajSdo0kc9v7kYIIEsXEEVAStAI1Feupe+9Nf+v+QVz
         TgPXOIcMmm+osT5vyCW1mT8Vg6zp7lCPVQdMZBpX+xvzoIZMorDfDCvCfYuwkzSjevwd
         BaBQ2RUJhO7fuqPY4gOXRMKFyUXBq+Da3kOtbBmjnhgOZWC3yuwgWBoEpkobl6LiYyEq
         V9iKYloKeefYWivvTlLAIHdQ+INKgEJZ2h9LWRdkYQA5RiGGSU7YP7VKPtAZzpPnj8an
         IhXcK83jzapfQjxYYC0JNKiBes6nTiK88fxZWthGL6IYSlAFVKyQ7DPVhweoLxmRb0k1
         ZHQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t4d4OQidH+z0CA0h7q7ujZXtP31JvYXTA5FxTzc73841GzqkbsM1+s2ZWa3Wj5uiD4GU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+S/DEixsckWHAyVqOXlMkvmvLTzwL6gZhCvuuw8aHM9+dEd/
	RSgMMowTpR8hSYpIXLBTphiNEPlkV/hPSe6jFsON1ZEnXL0opvK2mS/jvEfDyn8sM2iWRJ2eaI0
	UPlkYXITQviOTGACO9Y5/LWBFilDfrOU=
X-Gm-Gg: AeBDieumcEqYKYa22BoXxp5FOU/hOSaaw+g01OPpWeaMx6TZsB71/rIVjxNC6vofMBO
	eiXdKJve+p8rjHt4/7qaqek3LvJKV/UZnCveAG8ZcGfM9MGzgJY/Bxf3UeiLuJdF+NUJ3+5m1gA
	Xv3q/fRvJ3SqtIeQTo4iILh2wnW972mitAbYuDR8ExDQ119bP6QDWrP+baHkYSUUptOH8ffaNTO
	nuxQGmtgIhAr1/iVV8wmV4k+GP+P7jrzGFrBGj+VYIN92z6i6oEK4/CL09XZTrQdEnmRf/FFrS/
	xzi5LF21F9VK1HN4Sb2AmN00bR4=
X-Received: by 2002:a05:6a00:2eaa:b0:82f:37:f590 with SMTP id
 d2e1a72fcca58-82f8c90d03bmr48149115b3a.42.1777291723217; Mon, 27 Apr 2026
 05:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427112205.1346733-1-alan.maguire@oracle.com>
In-Reply-To: <20260427112205.1346733-1-alan.maguire@oracle.com>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Mon, 27 Apr 2026 20:08:31 +0800
X-Gm-Features: AVHnY4KozKx0cXA49lln_n24ueKcvz4u91Zw4blL0r_ck5w1mACIDfyZBvyGVBs
Message-ID: <CAAWJmAbNAxJVviU_nY_TxcLXpW60U9MSi7M27EEs6OHz3GmPaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix undefined symbol references for module build
 post cnum changes
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:22=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Seeing the following on bpf-next:
>
>  DESCEND objtool
>   DESCEND bpf/resolve_btfids
>   INSTALL libsubcmd_headers
>   INSTALL libsubcmd_headers
>   MODPOST Module.symvers
> ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp.ko]=
 undefined!
> ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp.ko]=
 undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [bpf-next/Makefile:2089: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> Further investigation suggests nfp indeed does pull in those symbols,
> likely due to references in include/linux/bpf_verifier.h:
>
> static inline s64 reg_smax(const struct bpf_reg_state *reg)
> {
>         return cnum64_smax(reg->r64);
> }
>
> static inline u64 reg_umin(const struct bpf_reg_state *reg)
> {
>         return cnum64_umin(reg->r64);
> }
>
> ...
>
> Export symbols for these references.
>
> Reported-by: Kaitao Cheng <pilgrimtao@gmail.com>
> Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,64}=
")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/bpf/cnum_defs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> index 3ebd8f723dbb..7d992ee6a8a4 100644
> --- a/kernel/bpf/cnum_defs.h
> +++ b/kernel/bpf/cnum_defs.h
> @@ -6,6 +6,7 @@
>  #endif
>
>  #include <linux/cnum.h>
> +#include <linux/kernel.h>
>  #include <linux/limits.h>
>  #include <linux/minmax.h>
>  #include <linux/compiler_types.h>
> @@ -23,6 +24,7 @@ struct cnum_t FN(from_urange)(ut min, ut max)
>  {
>         return (struct cnum_t){ .base =3D min, .size =3D (ut)max - min };
>  }
> +EXPORT_SYMBOL_GPL(FN(from_urange));
>
>  struct cnum_t FN(from_srange)(st min, st max)
>  {
> @@ -31,6 +33,7 @@ struct cnum_t FN(from_srange)(st min, st max)
>
>         return (struct cnum_t){ .base =3D base, .size =3D size };
>  }
> +EXPORT_SYMBOL_GPL(FN(from_srange));
>
>  /* True if this cnum represents two unsigned ranges. */
>  static inline bool FN(urange_overflow)(struct cnum_t cnum)
> @@ -48,11 +51,13 @@ ut FN(umin)(struct cnum_t cnum)
>  {
>         return FN(urange_overflow)(cnum) ? 0 : cnum.base;
>  }
> +EXPORT_SYMBOL_GPL(FN(umin));
>
>  ut FN(umax)(struct cnum_t cnum)
>  {
>         return FN(urange_overflow)(cnum) ? UT_MAX : cnum.base + cnum.size=
;
>  }
> +EXPORT_SYMBOL_GPL(FN(umax));
>
>  /* True if this cnum represents two signed ranges. */
>  static inline bool FN(srange_overflow)(struct cnum_t cnum)
> @@ -71,6 +76,7 @@ st FN(smin)(struct cnum_t cnum)
>                ? ST_MIN
>                : min((st)cnum.base, (st)(cnum.base + cnum.size));
>  }
> +EXPORT_SYMBOL_GPL(FN(smin));
>
>  st FN(smax)(struct cnum_t cnum)
>  {
> @@ -78,6 +84,7 @@ st FN(smax)(struct cnum_t cnum)
>                ? ST_MAX
>                : max((st)cnum.base, (st)(cnum.base + cnum.size));
>  }
> +EXPORT_SYMBOL_GPL(FN(smax));
>
>  /*
>   * Returns a possibly empty intersection of cnums 'a' and 'b'.
> --
> 2.39.3
>

LGFM.

--=20
Yours,
Chengkaitao
