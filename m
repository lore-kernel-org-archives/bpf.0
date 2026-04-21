Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125B303A04
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790128; cv=none; b=kcOl8tMj5b9+bLRbbPaE8aIfI9sA203fVQD72PMazcGtME2x17RYI0PdRYDesA3gPoaUM1DZg4m19p7csai3Sq4ddXwv3gOk56kwzv0iM5meDv2CTebB9w/s3+pgiuiNvelaMeQLvBy73r15W4xEx712VxbK1utf/QAgBeK1rVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790128; c=relaxed/simple;
	bh=IbBzTJ8rN1XJTlexSPpCKJM5V2j9F39mJsk1BU9+6Go=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YcXcVLIjtLRSim5zC8ClOkTXOcM+b2bn75iVMxdHNs+zKOGUn6W3eUfeVP0K/LfKi1o3k2V6XKIGouiF8uffn5ppBlOb07lQwz0Gtqn0yQqNm7163nsf4UbIdDzSPY9e9OcCRGrRKhNqE6R+FHWEBJhynY1KVWFgqw4V3Fqx4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y47iejJn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y47iejJn"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so2529251a91.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776790127; x=1777394927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DO9hcckIcpg35r24lgFk+MxUwRXBPB8/cJqxkMCWPQE=;
        b=Y47iejJnuBEkx7CiTK4RTL5SzQ9R7dII2lhBSd9oksjd2gE818dCwSwpSjDUthITGf
         fMzKPfB//1CRt46FRcSw6CSQ4KE06nm9hHpPCGdxnnK1Dm1O6Vexa6t5tcGbipQE7sdq
         BdQeMtiONuhfY8JCEKZhRUC6hQpQZESmVi1lAjHa4OF+nxlR5M8z8eZgQUjqjw2Sz8rg
         kp+qOWiRuceVMh/sbkpMIOlURN0mth56CUM7KpAMgxHj3VdE3j6EVjhhd54W7Bt7e6Bz
         z7ZpTBlGOaaCnmznp+pUT/zUQa0LnrXy8ajQwHe0SKiaIzMzNW2ubrraXELmxhMW7pqM
         VqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790127; x=1777394927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DO9hcckIcpg35r24lgFk+MxUwRXBPB8/cJqxkMCWPQE=;
        b=YcbdeZzIDEJ8Fmi4g/QGJS8hRYRaCDkVkrr3dD0LH1YhHoRtQGqPq7rpvlPmpC71i8
         gLkPvPKBsb8RBQI8Tlg2pU5eUiKAqleAcUxw5ykICFnyZ1oN07RGuR/P02eX1euO82YR
         l7YoAri+f/re4n337kryi1V9FWZ+diQMsK4ThU5NjDrpXb5yPMPcv1qnNkwE1sPrOczs
         te9SbdlCAM5H7O8aGwF26gCs8GYS/MBO3ehOH4y2hMbhAP2Vc+PHtcPw1rTWS7HcbFne
         rsEFbgyuUHNadsW6M1oKl0OXhzOtQZ1CMQ70w0GtPgyYbNoq37tif/6QrdwKLaf14RdX
         UBvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S4x9LBJJIVFblhOs7+AK3M7laamVQBUysiqsWsBYzCcin1DXcrIkJtwBfsAP8EZ9IGW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzykBA/MWMjQ0C2keSeP57lfXuPsyDxexCDn8sG10QAu4qCtnVg
	1ZA0CBxR0vN7GXQJEZ1+vpWnngoFrjfijjSI5/QmagtsKa4mi1APFz5A
X-Gm-Gg: AeBDiet18CuCYQ1iHPkisUXCpm4QpahC9V07VABVzCO3rCTFC4Wptgx3DGFD8MhBnSn
	MbllPn0lQSLMpBB67dOKnxBAgr2xJ3SvFKvqpL4FnXtY9vQ8pk0ly8HaUQl87wt5rDHo345+U9n
	lvmzHgmppSXkRpC8hpnoZEsso3ItcHhdsGwZaWv29FcyYTla3hlZAJG+405WaMO0uC1L6fwIa/6
	vQqgGLeTQcnS+u24G7KmEZG4pUVBk2WArWZvMA5ZLFp/2uWRYs7/lp5KX4a62wy57wERdvZTNU/
	QrGo3efWLpSvsx//RR4Rjf2k1eucZGdKj+IZND/zAmjKcK54MY0ALTUdHc/PorHtfgt4XhJ5ZSa
	7UZBLxyjcpbQoxebq6FmEe4lyqHeKDhrbzvtgQGziVzjhMp71s7MXIrHn3I+d2ED4xsf78/tQQq
	YsUtqSawi28UK0Tf7eyJe4vXxVhWXeDAtZasGCR6sTBOUSHUTqIpGdjhEKZ0XvaU4=
X-Received: by 2002:a17:90b:524c:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-3614047a5d4mr19438890a91.20.1776790126553;
        Tue, 21 Apr 2026 09:48:46 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410b998fsm14400085a91.13.2026.04.21.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:48:46 -0700 (PDT)
Message-ID: <3b97c3523aa50ac1b5cab89c817dda3e07e22190.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com, 
	harishankar.vishwanathan@gmail.com
Date: Tue, 21 Apr 2026 09:48:43 -0700
In-Reply-To: <DHYYZHXEVG03.VESM7HY6A8ON@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
	 <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
	 <DHYYZHXEVG03.VESM7HY6A8ON@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 09:23 -0700, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 3:28 AM PDT, Eduard Zingerman wrote:
> > =20
> >  static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
> > @@ -14119,7 +13548,6 @@ static void scalar32_min_max_udiv(struct bpf_re=
g_state *dst_reg,
> >  			 reg_u32_max(dst_reg) / src_val);
> > =20
> >  	/* Reset other ranges/tnum to unbounded/unknown. */
> > -	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
> >  	reset_reg64_and_tnum(dst_reg);
> >  }
>=20
> div/mod don't need special cnum_div ?

There is an algorithm for that in the paper, but it turned out to be
unnecessary for our verification purposes. At-least for the corpora of
programs I used for testing. I didn't try the "dumb" multiplication
version, expect it to fail for cross sign-domains cases.

>=20
> > @@ -15861,38 +15209,54 @@ static void regs_refine_cond_op(struct bpf_re=
g_state *reg1, struct bpf_reg_state
> >  		break;
> >  	case BPF_JLE:
> >  		if (is_jmp32) {
> > -			reg_set_urange32(reg1, reg_u32_min(reg1), min(reg_u32_max(reg1), re=
g_u32_max(reg2)));
> > -			reg_set_urange32(reg2, max(reg_u32_min(reg1), reg_u32_min(reg2)), r=
eg_u32_max(reg2));
> > +			lo32 =3D cnum32_from_urange(0, reg_u32_max(reg2));
> > +			hi32 =3D cnum32_from_urange(reg_u32_min(reg1), U32_MAX);
> > +			reg1->r32 =3D cnum32_intersect(reg1->r32, lo32);
> > +			reg2->r32 =3D cnum32_intersect(reg2->r32, hi32);
> >  		} else {
> > -			reg_set_urange64(reg1, reg_umin(reg1), min(reg_umax(reg1), reg_umax=
(reg2)));
> > -			reg_set_urange64(reg2, max(reg_umin(reg1), reg_umin(reg2)), reg_uma=
x(reg2));
> > +			lo =3D cnum64_from_urange(0, reg_umax(reg2));
> > +			hi =3D cnum64_from_urange(reg_umin(reg1), U64_MAX);
> > +			reg1->r64 =3D cnum64_intersect(reg1->r64, lo);
> > +			reg2->r64 =3D cnum64_intersect(reg2->r64, hi);
>=20
> Maybe a helper like:
> cnum64_intersect_with_range(&reg1->r64, 0, reg_umax(reg2));
> ?
>=20
> Also I found only one case:
> dst_reg->r64 =3D cnum64_intersect(u, s);
>=20
> all others dst and src are the same.
> So maybe:
> cnum64_intersect(&dst_reg->r64, ..);
> as a main helper and __cnum64_intersect(r->r64, ...) as a subhelper that =
returns cnum?

Are you concerned about machine code inefficiencies from struct cnum
being passed around as a temporary/parameter/return value? Since cnum
functions are in a separate compilation unit, I'd guess there won't be
much optimization outside LTO builds.
Or do you just like the &r->r64 notation more?
