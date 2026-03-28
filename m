Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA023A1A2B
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714851; cv=none; b=DAy0bElWj0iWzSokgizBg3qbCtfn0x+t4CyR6/fsVAbwpjki0216jgDpmUXOBiJP3Q7NL/HwEbUtGX08XgtFKaOVm51geSil4aQgZI1TkUTrQZBHV2J5iDpmVTvOYS6ZmeYMIgDCujV+tr5DRVjvSyNC+QOMjOWwZ0dlIxwWxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714851; c=relaxed/simple;
	bh=ISmPtlm+i0yyz3eM9k0oGnw88uP7rfl5EchddrxV0T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuvqJgPXG302XkblY7OW0yfnztEeJXSANvVIh6qZmKh2HUrPiIG8WgT+BofJUOb3cdUslQqYLtR5Eiesk9w6fksbxBsAhYtzy5bNET3ERwyzdnV9EWUE/kKH5pV+KmC/76et/x/jSO2l+s3W/MJrv4PvbSaX965pOV8u+Jf1NoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+0d61wb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+0d61wb"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b87970468so2847572f8f.3
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774714848; x=1775319648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaiHU0PYN8PTs2PGhaMeeOAkkhQQNal4ajbtCASg2r8=;
        b=U+0d61wbs4/rhd9Lo4Ab8WVOXcxAyZg/NwOYMGDFfNH2bAdxfCTIlwR68HhA+RVLWn
         LzbHKpp0HjfHMNgXAbVzryOFMzuTbL7yvKFb70oBwYWAVL5GfRd+I1jU6jk4I5pJ28mX
         wl/oz4yDhIYGu00bt15t3Lxp9+8q9xnAYIGrrG5y+kFElVRHR2Xu817oY01ECgEVgXrz
         AGl5zFetk4gHGuTfXFq1qFQyz2QJ7I2P/XFhvq7IxNOnHXv9GCyZF40yG+V+Qdud2NSa
         24TJUAeNk0zb2jPeCU/M3BOVCTSSaz/CBd2fG8zsORGfYCg3iw81Uo9wP0t7SuHQKTGy
         quew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774714848; x=1775319648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaiHU0PYN8PTs2PGhaMeeOAkkhQQNal4ajbtCASg2r8=;
        b=K/HrkLoh1KrVVa8IQ7GelbyEij4yes8QOklLeGXsagIfzNzFwrJF3TPR/Rv2sA9e5Y
         4i24qWoEohQ72ylC1smRifvdy+e5n4c2SoUO4HziImq/piIKwp/TLvMY7gSL+3i+rqIy
         FutJdshOi82TpVjRy2oSP4VYaE+CR1Qol1deyaLVCrMr5jSqlfKfwprTf9xev+vNcu6i
         UlJm8/3CfVzTBpPacAyGyLcwSzGtyclkV/9sx8Uk/fPRtS++5O/1DzyPJINySXq3CGjF
         +iE2nXaGGFt7PNq3pmFCoxRwOqvVcathUjMzYKhp/SaSe9I54/1otQHt6gtBw3zRffr7
         gbdg==
X-Gm-Message-State: AOJu0YxHYmC7//sSNCl/NVjw8LCwuB/u1uMnLKFjjyFgCfeM5+d8+cUv
	Lp0f4nqE7SeprlrWNwHdk38M9cnF4EPuKMEuh6LEgsDgEmxFlecm9eKp
X-Gm-Gg: ATEYQzzq573gpwBh2E0+y5JiYD0a3zzGRS++15/OJTTA5WDvHZYYGxDXouteENKnA1n
	1cO031JZOlLE7+wyUGP9H1a2+XUTEYEEiD0xx8HG5+Y7h9aqK4n7H8KdpNfSfTrSY1jFP0986El
	pXRZ9cTMigYpOYorwuTa2f4gfa9Stfab6xZZK/nRNqfDG5TGHwdeVCZrVM/CetO7apPervPjy6F
	T3srerZeV62tnKmO6Dg/Etcpdsc9gjiqvnc+hZsJl6NgjW4D+utD0n7KOp9A6h8vZx4PEd5pgVr
	jyrmGuPO4bH0+jo1JJXpZPzLXxQhK06FLBdD6dVZFevFGnYpY3/WIk/GyskeQ6mtop0Idw28EwB
	0qIefw6F9+heJieAtHLZHia2vAzezgFfiKRrIFVI34ARY5QbKu0i/O1Gau2FIIKOqeemWPkgQ7T
	r3/GRd+ed/MlF3gqaXBzSWpyJ9piMMk+STE9crB920SKUxFCxJSc3RASpnKW6TejBbzD9JJaTJW
	vTi+pEz3Sr/U4FWs8qnW5zDh3tOAH7soNW/rCWUireCPefitNlX5CCdhaXrTqBvjydGVpkMBKM=
X-Received: by 2002:a05:6000:3106:b0:439:f64b:a82b with SMTP id ffacd0b85a97d-43b9ea1a1b0mr11245696f8f.6.1774714847732;
        Sat, 28 Mar 2026 09:20:47 -0700 (PDT)
Received: from Tunnel (2a01cb09b0419c777d428aa4583db37e.ipv6.abo.wanadoo.fr. [2a01:cb09:b041:9c77:7d42:8aa4:583d:b37e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21f1749sm5885241f8f.14.2026.03.28.09.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 09:20:47 -0700 (PDT)
Date: Sat, 28 Mar 2026 17:20:44 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 5/6] selftests/bpf: Cover invariant violation
 cases from syzbot
Message-ID: <acf_3HgkpATWYzs9@Tunnel>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <b82e9240f62200aae173a1c69c782f56ed7f8f21.1774025082.git.paul.chaignon@gmail.com>
 <87ikamjv5q.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikamjv5q.fsf@gmail.com>

On Mon, Mar 23, 2026 at 05:46:41PM +0000, Mykyta Yatsenko wrote:
> Paul Chaignon <paul.chaignon@gmail.com> writes:

[...]

> > +/* Last jump can be detected as always taken because the intersection of R5 and
> > + * R7 32bit tnums produces a constant that isn't within R7's s32 bounds.
> > + */
> > +SEC("socket")
> > +__description("dead branch: tnums give impossible constant if equal")
> > +__success
> > +__flag(BPF_F_TEST_REG_INVARIANTS)
> > +__naked void tnums_equal_impossible_constant(void *ctx)
> > +{
> > +	asm volatile("										\
> > +	call %[bpf_get_prandom_u32];								\
> > +	r5 = r0;										\
> > +	r5 &= 0xfffffffffffffffc;	/* var_off32=(0; 0xfffffffc) */				\
> > +	r7 = r0;										\
> > +	r7 &= 0x1;			/* var_off32=(0x0; 0x1) */				\
> > +	r7 += -43;			/* s32=[-43; -42] & var_off32=(0xffffffd4; 0x3) */	\
> > +	if w5 != w7 goto +1;		/* on fallthrough var_off32=-44, not in s32 */		\
> w5 has bits 0,1 zero, rest unknown
> w7 has top bits known as 0xffffffd4, and bits 0,1 unknown
> If w5 == w7, their tnums must intersect to a single
> value = 0xffffffd4(-44). Which is outside of w7's range [-43; 42]. So
> the r10 = 0 branch should be unreachable.
> I guess the comment should be updated to the kernel style as well.

Thanks for the review! We already have a lot of end-of-line comments on
the BPF assembly in selftests (including two tests above) so I assumed
that was fine.

(Unrelated: On some mail clients, your comments are hard to spot. It
might help if you could include a blank line before and after them :) )

> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> > +	r10 = 0;										\
> > +	exit;											\
> > +"	:
> > +	: __imm(bpf_get_prandom_u32)
> > +	: __clobber_all);
> > +}
> > +
> >  char _license[] SEC("license") = "GPL";
> > -- 
> > 2.43.0
