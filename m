Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F8376BC1
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135667; cv=none; b=r+qkEooCAApqcM0iMKdwhHBmHSPniEFW72h8ltVHyXYk07Zn8mFL1VNZdoHMdcQ3JOnOBzfn05FWjvij0WZ7EkA6wsIzzACh+PNxH82ZOs6/yN7lsVqXRUXlE/ZCxMnLKr95A9VzAJkEqqQtFQbHKanE2/bIG1nRVoynfhtxeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135667; c=relaxed/simple;
	bh=9Zh8ehr7ZmT8kJzXPckpS/44bZlqGF+TPHrJm2GwK5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkGUmmkw4ZfBB3Ym1o4iEW+PvuS1s8p/oM6+mG8EM3aa5/PxCTLnuLkqlA71hE8CMxcwt7t/UJy/7bNiqUi0wpDnM+7/CNvlq/Q0OmHQ12FOTdWFB7l368FS5bk4DuMr2Q7pThuVjfDDktXkiTKxW/dkBzqTExfq6fdx3iFsCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqeJ6cHS; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqeJ6cHS"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso473863a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790135666; x=1790740466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f9U/pFQTHOWeRRQzkf2u6G6d99P3xIeZZ+SRUGGgRIM=;
        b=GqeJ6cHSJxIq1ln2F+VY6Iql+VUfhSLylbC8GZz8saSFQ/UNuM31Vu2GPaNbTUDA0b
         P/2sXfvj+ITINBP7f/HZHhenV+jLEWBsbC8dYPv6liHyoEDsxWCdHi6lDhnQr+x7tycN
         kx5asT9FspZM43ilyYD3RyRH3fmMUZQWl/yTOzUas9arqCBxDwtuV9YM3PrP0LWcFALK
         o+60X1ty0aivQfAPvX2JrmVZsPNx9n1LwcVx2NdkaUVGMbw0xAvynK16G9fG+MlHTowu
         7CSb0pommc6nPBK52wUi2jcDc3OXMiCW3yg6Y/MSUOCC0uJirlavtIwaZ04UCHMxHbPh
         UiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790135666; x=1790740466;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9U/pFQTHOWeRRQzkf2u6G6d99P3xIeZZ+SRUGGgRIM=;
        b=kwfm/2MkVT8CAAth/A5ZpWOXRDo4ZAwOfe/UOPx/6ESDmE53epgebTbgatRAAwndBo
         d2BQqhA24aUPCXmL1dmrsWgy/2DdHCHfxk4ptlBMRi9SyWYN9DHxnl1D0a6NMNx9YePg
         AZuhSqH2EjvUHm5u2r3do5dXAzBX0daO13ijJNOK+RLL7WU02lCPLFPG7A15iUkwAKjH
         KYZaaZdEdAnIi7BNbdYfahEtgqyWliyy5Ee381Lz4rimFccVK17HexPonfOdMDbqyfij
         r3Phsf+CM0wZVCopcktIBHIRW6+rFzX1rHxzXKezQeiTyGXxF6vNJAYaLEhPjyF6ai2D
         8Dww==
X-Forwarded-Encrypted: i=1; AKwUvBy4JdX7x9h7uk1JPjF5ZUMm3uK1ZVsGWKAmpWwKvCg9aMdSXj22NgBQOEWHBjuKtNAX+3U=@vger.kernel.org
X-Gm-Message-State: AFuF++nUMYyuuKBioxlqKUnFm8myo3qozCBrLy9pZmsnj6/p+ol3rZ6V
	6L7FYeCmMaNhJsRRODThnYvle1XiLWGpYUfnzYIux7elW1ai9Z5RVQfs
X-Gm-Gg: AYBFou045jTTY4JYa370ivB/H/NSEOKOQiKoKMYbEV80Y4XPLx4g3dNrbhI6e2Y1FXo
	w7+c0YSrR1SMHcMazKXO9i40vtisiBYmHs64g9DYrtsbDvfDqNWqkdH9kNKT1fBNSr0h5UvYE6p
	1yzmdwrmKEmxynfAouKTnNPOEMPaHrun7v+rF0AgE79Q6KMfSIfrChuT/jW1Edjjuzh42CrCcGX
	yR2jZk64vtU3aiGOn18u4cK45IALTd+CxrSG1XeOLvC0kTEbRGAqoCiN+reWroPH4wdvN7TLabP
	OKthwcblNpZC3HoJdpGMtfyvRz1p1u8AcACplEN6olUOMbtTrZm0S1kjrbk6kLiP1SlQPfmXOTL
	k2tG3n/B8/WMVnk55PuFnNhywhbZjlgfO9e6t23DfQVHNkL0XEzUojLG5fKnPKFl01yR8kPSqRK
	UTjPzuRyWLS5Sx1mHTajE37W5SY4FAM5OgjmAvgU/6K+I+bhtCIlht4Jnm0Iidgksvcp5siT6zn
	JqjjW6n/UHdNW34yGXE73mwW40B9LQmcZYLqS7yHuz8sdY=
X-Received: by 2002:a05:6a21:7d06:b0:3dd:a006:559f with SMTP id adf61e73a8af0-3ddf8221880mr1471837637.45.1790135665654;
        Tue, 22 Sep 2026 20:54:25 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f4097aasm373865a12.31.2026.09.22.20.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 20:54:25 -0700 (PDT)
Message-ID: <2c2a6d6b41da4354b871bfcf42665fdd367e0614.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/20] bpf: Prepare for an exception cleanup
 table before the CFG walk
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 20:54:22 -0700
In-Reply-To: <e2905d50-0afd-49a3-818a-681bbd665f84@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210053.1717603-1-yonghong.song@linux.dev>
	 <8fd3e980749f4a5ac10ff5d3d1704e42c1bda643.camel@gmail.com>
	 <e2905d50-0afd-49a3-818a-681bbd665f84@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 20:07 -0700, Yonghong Song wrote:

...

> > > diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> > > index 4b3ac93e98c1..67af78baa558 100644
> > > --- a/kernel/bpf/exception.c
> > > +++ b/kernel/bpf/exception.c
> > > @@ -18,6 +18,66 @@ static bool insn_is_unwind_resume(const struct bpf=
_insn *insn)
> > > =C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insn->imm =3D=3D bp=
f_unwind_resume_id[0];
> > > =C2=A0 }
> > > =C2=A0=20
> > > +static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)
> > Nit: the 'cleanup_' prefix in function names triggers me a bit,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as it is usually used when there are som=
e cleanup actions are
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 taken by the function. Maybe drop or rew=
ord it a bit?
>=20
> Yes,=C2=A0I will try to avoid cleanup_ prefix then. For static functions,
> I will not have cleanup_ prefix or may use exc_ prefix.
> For global function, I will bpf_cleanup_ as prefix.

Yonghong, a wider naming question: should we use cleanup/cleanup_pad
or landing/landing_pad to name these things?
It appears both LLVM and GCC use landing pad.
