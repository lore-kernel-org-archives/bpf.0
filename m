Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4F34E746
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788585; cv=none; b=ljzlqf28jecl8lPMbD3uU2Ep3310RSDzWHMXi2Ehy7yXyJljuXBg8W1Fj2Gv3w3NPghBhObqADJRIUFZ83uqpJDbhoT0lv+3pPcGgtOH5GArhA7v5rPYthDDTZf9N10vPy5i8D7KFoi6ZxyOvJvj8V9tku3uzIk4H+WXLzj+/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788585; c=relaxed/simple;
	bh=FluqA9Z1585luOqKpG6brmlNk0SxUiT15guNdVL6v6k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=A3taR6dcIRNi5wMfH1oHJDNHDLvUye2YzwCMNMXrTOlNKj5PJUGLaG4JCcGrGHdarVgRukubU3YRln9VvGcA4zd+3toQXRv2ucN+PEbSd4Pfvuemv/zTszvLfntdwtQYlhlOgCDEZvzrj60E83yhyt90gXMDrfreFSVnX7r2IkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2AZfj8p; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2AZfj8p"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-404254ffe8aso3075245fac.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776788583; x=1777393383; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYXSGEWsmPfO4gVweI3GLIYXxe1T9Z2+cDZaQRslPGk=;
        b=X2AZfj8pmJcFL0xFxI6rAljJFiq72dAnHPPNbQucvaVmVFfooR4JcdeBQpQgRnfQv8
         Q9yx3IBsiVfzjvjIkCqoB54n9/N0PwQCJShoJKU2hZxzBqNhbLnssqFmlfOJ9sE2B2rc
         tBaANmnRKXaNASLxrxwwCXEW1scW2weJNyc64+1PiJ3saUfnkBnQGMV8BDPtx45Ls5J1
         zfrWvMLpaYOBvEcO6g8f9mAha5HA5JNKGiGrLgOQtKfWdh0G8EQ+2IZHZ+iuI6HxXjVz
         NG5c+eEurZuzss+uyuEMid4RtjXgYUZ4zhRBKDvS93uCQVePnDuGghsci7U0suCGBvCq
         /lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776788583; x=1777393383;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYXSGEWsmPfO4gVweI3GLIYXxe1T9Z2+cDZaQRslPGk=;
        b=RW9WnyGMSS9hwtiT9N1XiFcX6yKb7lUSswM0dinE3F5s65zy+FZ7TnjjSSL2rwNECC
         guqkEFCeI/NKMw2HM/PPJPimwOFdW/v7LuuDyC78r88hgYs+PG1+pBr9pahT8rfpIUdu
         TWD0v3rpdHZxUkaYX93Ywc5drGePTtNBp+Jsb5tRWubU0se7Hs4AjoQWpWl7u5lMUwK0
         4KYos6djw3mFGQRg39Rfx7yW7VKn8F9kLQvECoNVOb/EsyWivM728iTy2KJ11kBux4l7
         kJnXlcSnvhKxUCymTrau7rc7qIKXz2y9Cczo7Z5sjcDeAXHf9LOt7bGLzQe8yjDFWzZH
         CCYw==
X-Forwarded-Encrypted: i=1; AFNElJ9a2D9AP1fBv1NBVaalPZxIpfBMNCBs7SG3LvDZJmbf5yKu4oP8f5T3Jmtx4K3vKSTPVsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/H2SwmgucGe4qMQEl2rT+jCYCCpEdxkCdWiTy9hyqDOhBLcgj
	iW9PuTX6E5xG9V9fCZUyMKGLghKy/oUfKA6TjeFwi2Is6NUftk6Rgbpr
X-Gm-Gg: AeBDievgKgc8PsUfsBFAqOXDbaPWRKnXFU0n1PXNB0GR63GbDsrI8YhGYCnk/Q7hP1j
	q3GiC/abRfTjqolpMFs4DGUzilCc2mafOjR0dTrRD1CsW1wHDu/Wy+VvTNKi75uj1zk4WoTYilB
	qvri+W3LFRmC1AZwr4NAGvqmYM/29HFxIYpWCdYe5vuKi0Xaj+VOiDE9aI2K2eFJ8sq7sLA2Pbk
	T5g7VztYpNUif7plQavBjECaKs4f+ukXDPWiwNMoqIH31/3fXXYhAObRYAWhm9gCFv0+VtX+aVP
	UluIsOUA6uLWZfIdK/dhgSElZq3oXprArxDAvZz8phYeM7M+Fz2rV684BRCm6NM/WnE6sRpNcHR
	7Im0uGffCyAq33NJvM+hRs1qb+lhGQpQVLX7eoK0rCemiUrtxaPwxe1KV/d/lv2aUp6ZSXLN/yv
	TEgRZseePkpBFBUGe3YqomVY0mBDYi4vKqH1XRNqGSidqbyZQ5lccRpJ5H/LvA4H/lJi7X1r6Cl
	ssnMf3pcYxBVnm1ni7/sXZO9IX/YVXPbgU=
X-Received: by 2002:a05:6871:d207:b0:3e8:9b72:5cda with SMTP id 586e51a60fabf-42a99890765mr9825186fac.11.1776788582894;
        Tue, 21 Apr 2026 09:23:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b93048e4dsm10842986fac.2.2026.04.21.09.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 09:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 09:23:01 -0700
Message-Id: <DHYYZHXEVG03.VESM7HY6A8ON@gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <shung-hsi.yu@suse.com>,
 <paul.chaignon@gmail.com>, <harishankar.vishwanathan@gmail.com>
X-Mailer: aerc
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
In-Reply-To: <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>

On Tue Apr 21, 2026 at 3:28 AM PDT, Eduard Zingerman wrote:
> =20
>  static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
> @@ -14119,7 +13548,6 @@ static void scalar32_min_max_udiv(struct bpf_reg_=
state *dst_reg,
>  			 reg_u32_max(dst_reg) / src_val);
> =20
>  	/* Reset other ranges/tnum to unbounded/unknown. */
> -	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>  	reset_reg64_and_tnum(dst_reg);
>  }

div/mod don't need special cnum_div ?

> @@ -15861,38 +15209,54 @@ static void regs_refine_cond_op(struct bpf_reg_=
state *reg1, struct bpf_reg_state
>  		break;
>  	case BPF_JLE:
>  		if (is_jmp32) {
> -			reg_set_urange32(reg1, reg_u32_min(reg1), min(reg_u32_max(reg1), reg_=
u32_max(reg2)));
> -			reg_set_urange32(reg2, max(reg_u32_min(reg1), reg_u32_min(reg2)), reg=
_u32_max(reg2));
> +			lo32 =3D cnum32_from_urange(0, reg_u32_max(reg2));
> +			hi32 =3D cnum32_from_urange(reg_u32_min(reg1), U32_MAX);
> +			reg1->r32 =3D cnum32_intersect(reg1->r32, lo32);
> +			reg2->r32 =3D cnum32_intersect(reg2->r32, hi32);
>  		} else {
> -			reg_set_urange64(reg1, reg_umin(reg1), min(reg_umax(reg1), reg_umax(r=
eg2)));
> -			reg_set_urange64(reg2, max(reg_umin(reg1), reg_umin(reg2)), reg_umax(=
reg2));
> +			lo =3D cnum64_from_urange(0, reg_umax(reg2));
> +			hi =3D cnum64_from_urange(reg_umin(reg1), U64_MAX);
> +			reg1->r64 =3D cnum64_intersect(reg1->r64, lo);
> +			reg2->r64 =3D cnum64_intersect(reg2->r64, hi);

Maybe a helper like:
cnum64_intersect_with_range(&reg1->r64, 0, reg_umax(reg2));
?

Also I found only one case:
dst_reg->r64 =3D cnum64_intersect(u, s);

all others dst and src are the same.
So maybe:
cnum64_intersect(&dst_reg->r64, ..);
as a main helper and __cnum64_intersect(r->r64, ...) as a subhelper that re=
turns cnum?

