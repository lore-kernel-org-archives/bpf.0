Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529B2D0C94
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791815; cv=none; b=vD1IwRwaX7hcsY+UIGc/F+pa+QnuzA+AiJkuQQKiKMexsoA7RMhM4fHnZjAxCAGn9jjrEOzLj0Av97cx5SX+qpDBEh9OjgoJVoyDhvC066Rg4kWcvjQxxjbqpdbyW/tLKj8pxYWlxM9CiCo3wwCnye1N7D7uR/P04BKlbwiUjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791815; c=relaxed/simple;
	bh=HkaOrVB+icneXl2VyC1e2LLU7u3Nj8k0HG+W0gyMrME=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WNjwhSd1JXPuYRQQB5wdBzQltJK8Rd79ppCECxgQaIcZUMwEI2YzCxK4MDls+d+KO1B7drue0bRrFLKk/KO6pQsY53oEIkpG77KaoAB0jV7HRp629oAK5wYfhjMUCxZb8osCkEzktCxH3WmzDRmJZaXtmRvs3BCpwA2+5QYluAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RabV+NZW; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RabV+NZW"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-479d593a0c3so1650044b6e.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791812; x=1777396612; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbZGTiUGK56hlDZGLjgVp0C4rtQ9/wdu/iN7cEObj38=;
        b=RabV+NZWr4jSW7mW8FPXpTdR/m4hSmdd64ZNnd85SKO/vsS3A0fzS2It3VnbEofbA4
         vEvcODO297lxDWfk5U1Rl13wDCcEWYNlC8TOOa/8rnyeYiQlHExNzk3fH3wXaLx0xeoz
         pp2s3pnP3wpR+hVOnGXmrTHkSWfDg4BaGBkAhExJAFpfhjCXyMbS9+mDFdI2MzfKnIpX
         1Ff2sBt/O9aHUEVAeuHY/Jf8uH95nGVjVlj+6qxxGHOGP0Xu/ULkCnHsqkczLfPIigNl
         ZmC561piYfAB7VHmlFn6rqNm9VHRoNmAh9WLG98rimOhPwZJ26HJpHGSOsbRdq8egp7z
         lfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791812; x=1777396612;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbZGTiUGK56hlDZGLjgVp0C4rtQ9/wdu/iN7cEObj38=;
        b=M+L20EsX9W/a2No8JXf7+Vj6AgIsqBjp9be22nZoJXv+GwWfF3b3/zvqqbvIbrYVxN
         xIOxvM77pIIRSifbH+HojBYgZFjzsU8ram34FXqEK2Lkk0SWM1+6mpQUEyPqWqmYRPmI
         GH/OBTxeROADpZUPHtt0NTtBtMFRbcpaT/vYuSnjMntKY54y2LB600vSBmLVHaVwCRMv
         Ub7OIfng1Kxgp4hT6pzSHflkwuuwqlpfXjVHlhM0ce07Oqs87rSLdnsPeMtxyQ5gOcoU
         c+5DmeqcP+sUwPTiUOiUhyLd73P2w58LpvElmlUV+RIRUJAUNF7+pn6Sy+3U2nWdQBJy
         tkHA==
X-Forwarded-Encrypted: i=1; AFNElJ/tsjqIQ2nUs9eXXcOsYoiEwIrArpMZGZjAt4h3E0oxETXkv4r3ekJLHndIEu5OGRRG6Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmzwa7RzKYJ1E4tIBIy+THWhrRv8Bom2V4qJ0Ml+eVkEYVnumq
	eRbBINFOS/ZEnPai/EOpkLKMmSxn9RXlD8rKUuIsTnxjFhM8kqlrqdBF
X-Gm-Gg: AeBDieuGKdhCunwTM1DIKrc0j+N62sJenMixvQKeO41HG33am4GICUOyhN5nkP7YhMG
	EAAjd4G2svfsiPB9H17D8BC/Spmhc++jQ8cPJDtFhv9cvOjAegRLUJLmyx0120M+nee4Zy7mZsn
	+Oe5bR1CP7Da9g4d2c3NcCIQ2Wc4KO0Kjglj2ugfgEEDDOQ8zkE0tPYtbe2iGdZRVpF2CO3hlCR
	f2RJTV1JfeA+zSfUIV+ekQUY+c07MRxiWG5EZBIb3hk0Chg32X1WgcWa9e2Qq65qksV3EtjUaGp
	51FK4O1TMukylb6Q3bp6HikvExR0ZdDeLkadf/Dh/zQuPht1vQhm8EDo0Cvywnh2xo8LlSPLM/6
	/+b72/ZQ8DHUl0j1IAazOpJr455NrZQRGRAuuWKD7DnlVSWDWdB8QwWtRj3dYtPrXOAQhiUTylE
	kXuWPSEn2n4w03O7SkCnAC6I1r/qvLURo3KoS52qQGMrYZ8Kmrg99oHlLMp4sTZ7e70KhxszgUO
	Pi8wIa2bQnInJdtRO8UQIkGhEjAas+avrBegA==
X-Received: by 2002:a05:6808:1449:b0:470:d1f:de69 with SMTP id 5614622812f47-4799bfdf093mr8187940b6e.26.1776791812139;
        Tue, 21 Apr 2026 10:16:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcdbef352bsm1534151a34.10.2026.04.21.10.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 10:16:50 -0700
Message-Id: <DHZ04PGE9D6Y.356RPW2LMPPIT@gmail.com>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <shung-hsi.yu@suse.com>,
 <paul.chaignon@gmail.com>, <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
X-Mailer: aerc
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
 <DHYYZHXEVG03.VESM7HY6A8ON@gmail.com>
 <3b97c3523aa50ac1b5cab89c817dda3e07e22190.camel@gmail.com>
In-Reply-To: <3b97c3523aa50ac1b5cab89c817dda3e07e22190.camel@gmail.com>

On Tue Apr 21, 2026 at 9:48 AM PDT, Eduard Zingerman wrote:
> On Tue, 2026-04-21 at 09:23 -0700, Alexei Starovoitov wrote:
>> On Tue Apr 21, 2026 at 3:28 AM PDT, Eduard Zingerman wrote:
>> > =20
>> >  static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
>> > @@ -14119,7 +13548,6 @@ static void scalar32_min_max_udiv(struct bpf_r=
eg_state *dst_reg,
>> >  			 reg_u32_max(dst_reg) / src_val);
>> > =20
>> >  	/* Reset other ranges/tnum to unbounded/unknown. */
>> > -	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>> >  	reset_reg64_and_tnum(dst_reg);
>> >  }
>>=20
>> div/mod don't need special cnum_div ?
>
> There is an algorithm for that in the paper, but it turned out to be
> unnecessary for our verification purposes. At-least for the corpora of
> programs I used for testing. I didn't try the "dumb" multiplication
> version, expect it to fail for cross sign-domains cases.
>
>>=20
>> > @@ -15861,38 +15209,54 @@ static void regs_refine_cond_op(struct bpf_r=
eg_state *reg1, struct bpf_reg_state
>> >  		break;
>> >  	case BPF_JLE:
>> >  		if (is_jmp32) {
>> > -			reg_set_urange32(reg1, reg_u32_min(reg1), min(reg_u32_max(reg1), r=
eg_u32_max(reg2)));
>> > -			reg_set_urange32(reg2, max(reg_u32_min(reg1), reg_u32_min(reg2)), =
reg_u32_max(reg2));
>> > +			lo32 =3D cnum32_from_urange(0, reg_u32_max(reg2));
>> > +			hi32 =3D cnum32_from_urange(reg_u32_min(reg1), U32_MAX);
>> > +			reg1->r32 =3D cnum32_intersect(reg1->r32, lo32);
>> > +			reg2->r32 =3D cnum32_intersect(reg2->r32, hi32);
>> >  		} else {
>> > -			reg_set_urange64(reg1, reg_umin(reg1), min(reg_umax(reg1), reg_uma=
x(reg2)));
>> > -			reg_set_urange64(reg2, max(reg_umin(reg1), reg_umin(reg2)), reg_um=
ax(reg2));
>> > +			lo =3D cnum64_from_urange(0, reg_umax(reg2));
>> > +			hi =3D cnum64_from_urange(reg_umin(reg1), U64_MAX);
>> > +			reg1->r64 =3D cnum64_intersect(reg1->r64, lo);
>> > +			reg2->r64 =3D cnum64_intersect(reg2->r64, hi);
>>=20
>> Maybe a helper like:
>> cnum64_intersect_with_range(&reg1->r64, 0, reg_umax(reg2));
>> ?
>>=20
>> Also I found only one case:
>> dst_reg->r64 =3D cnum64_intersect(u, s);
>>=20
>> all others dst and src are the same.
>> So maybe:
>> cnum64_intersect(&dst_reg->r64, ..);
>> as a main helper and __cnum64_intersect(r->r64, ...) as a subhelper that=
 returns cnum?
>
> Are you concerned about machine code inefficiencies from struct cnum
> being passed around as a temporary/parameter/return value? Since cnum
> functions are in a separate compilation unit, I'd guess there won't be
> much optimization outside LTO builds.
> Or do you just like the &r->r64 notation more?

The latter. Just less verbose and less error prone.
While looking at the diff I kept comparing both sides of '=3D'.
Just unnecessary mental overhead.
