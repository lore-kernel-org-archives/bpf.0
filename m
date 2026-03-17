Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB428314C
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726772; cv=none; b=XsGCI70mqx2d1wwa0//4PEiehZq52DeD3KFemJ0hkAZG/5fepngFRvlwDBDdH/MxDDkutbigbYD1MRWANWMPH3nUY7Mh2xlTfSWpsi2u7w6MZlTu1L3wmzD0yU7mrRadGEMJHqTC22ajO50o9uwRy3zBbC043L3IWLeDkexAGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726772; c=relaxed/simple;
	bh=BYShKtIlZLoapNRrwjYyPl406/OxxJPd7cpKvPsyovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTglYeu9KnW82aoNPnLCmom/njfVgb+ms2cpyisTaSOZfqQCmZ7BZMgKm54JGwOLrw24ALnvPUxZOIt3wmwSavtpvgf100C6sTGiYvdlJW9O2GdGXG7ngxMVUkFfZKRJ8d2pJ4UqbSIV/gmrGj/3jxlky4CfnmJtyuBNLzwhmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=clRd5OEU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="clRd5OEU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-482f454be5bso3608765e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773726769; x=1774331569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z8cPk/MLLIQRjCnroNQPaQM0klL76NxXOB2Kjbl/arI=;
        b=clRd5OEUt47Pclw+bn4zaGMGD2vj1bvQ+foSTpMbbnVtrtBFabxTegSZ47Te1MQrFA
         cyFmNjjAGClVZgYeqBrn9/1OzQrLx7vVRxOrL9QamMQEQfqshuQc3yQHLZZ2+DQdSVfU
         EZLVXrQXaxVPplUGdMsZQCFoVLsoyDPDoQ8sf9hEAPw37pwEhknaEYn2LBQLaqgypi8S
         yieC2MgE1ICTDfhUOWxNRabJfT7Wb1aX7B6i5UXLMdKijc7/rI+KTDzMn8dikBDlVHr9
         eWFubrhke73Uh5s9cXMHcJjWbb2FlgLkYT2IiLIhUncR+SNDWXmIn7ZIUDP4K+FUABbC
         p7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726769; x=1774331569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8cPk/MLLIQRjCnroNQPaQM0klL76NxXOB2Kjbl/arI=;
        b=isdX8aJDM+MrV+6+jzNHOqj9EEUg74NZPuBAIek9SAxS34629ATNee7Y57TFw0O/Mm
         PrRXsw3v/Rnv3Ky/Z2RHDm1nfYvLgnw/U/+R45MSusk4z6Ln+1+zTh86dpM2em10eI0p
         zmohfhtoxaXVg9GHJ7MNCe8L17O1p0wZ4Qq0DtNP0T3NCPtitx02DFES2hPTXxVzOkly
         t2G7yG2FxoUMC5F777EVsTZtD7bct1lpTt0N8jd7ZFaXaAZReC2HhOAGKuEw49iyiG/O
         kcFG1FUheauOlObAUBbtYKW2SLJvecJ72VBGp4N273dtmTodSKe3ovokErRk46Bz3Xx7
         Zkcw==
X-Forwarded-Encrypted: i=1; AJvYcCUb6ttBtpWlsJbzJ1TDnab6NtRngGUy0bhSftTxSQZATYnmjf9eBXHt8MiA2zAZbSviGlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9t6o2CiGcskozeyBmO/cx8Nb9uA4KWecBvTYhP53dON4qkmG
	AWLpJij1go9n93fPE+smq4PPHcdZAcmEOd3e+K7fDukkOs0HHs0R9PPbVllsq4OPIOo=
X-Gm-Gg: ATEYQzzRXmxuXTrJhjXqbEoSRPCR1N4EzgGX5aSUJNOI9I30U68CXpCjSSfzZI6CsdM
	dWskqjjoI70WT6aiguTqSXH9HgkCitf2e6FXT4cGQ9v+hpdjwlGk+26lMNwX9tfCark3AbnxHh5
	4WNT/qsalSiGJWhPJPTOvTD51Y54QjTrs+uUrASjF7QRgLUVw/ry8a6c6Tydsi4v1t0v1ZQQqbU
	Sj/Ljxzws+ei1fFsPSJV52jjN9///aSRQgn9+SayLp7UZkVwye7rvpZY+rzcLjToNdKieOYFnlO
	wd8sLTAOyb53pG8JklskvnNfM1ev0wK27X5NH4xCBOjRRjeXDq9oPr2jJCBMV9c4qFNgZzJlOdE
	7a3mNCIT7+bW9/0bgniYqmodksq2Jd6vUme25bXVjGdKhyFAsRQHEq7zttL1a7DICDBR2iKcyux
	T+WmZzNUZanJJ9Wb6zRJI=
X-Received: by 2002:a05:600c:2250:b0:485:4f11:aabc with SMTP id 5b1f17b1804b1-4856eaebb24mr25122185e9.15.1773726768673;
        Mon, 16 Mar 2026 22:52:48 -0700 (PDT)
Received: from u94a ([2401:e180:8d6c:7ab0:11ab:2f6c:191f:b326])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b05d95796asm41580745ad.52.2026.03.16.22.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 22:52:47 -0700 (PDT)
Date: Tue, 17 Mar 2026 13:52:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
Message-ID: <xnbo4affetx5z4e5apzwv4wnqcy4jskbky7oe4gw4rux3smz6q@44ruzrvfdfpm>
References: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
 <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
 <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
 <cc228139101e28d2bc76beb371a2c3f89eed75f3.camel@gmail.com>
 <abMHY2sCSe6xEKR3@mail.gmail.com>
 <wficveatl5cscfiaasqanow72ejlzifrcatj7z3r4dtu6nul77@bpfukkbrhml6>
 <72d8c8ab082d67c75bfd3d47f3a57f4b25a837db.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72d8c8ab082d67c75bfd3d47f3a57f4b25a837db.camel@gmail.com>

On Thu, Mar 12, 2026 at 09:54:19PM -0700, Eduard Zingerman wrote:
> On Fri, 2026-03-13 at 10:17 +0800, Shung-Hsi Yu wrote:
> 
> [...]
> 
> > The problem is that I'm operating on a simplified assumption of "not
> > being able to converage to a fix-point is bad because it could lead to
> > bound invariant violation". So taking this chance to ask, does that all
> > ties back to is_scalar_branch_taken and reg_set_min_max (or was it
> > regs_refine_cond_op) difference?
> > 
> > Also, when we fail to reach a fix-point, it does not become a problem
> > immediately, but only becomes a invariant violation some where down the
> > line when we again do bound deduction?
> > 
> > I haven't actually look into an invariant violation myself, so details
> > are rather hazy. 
> 
> I don't think failing to reach fixed point causes invariant violation.
> The root cause for invariant violation is that decisions in
> is_scalar_branch_taken() for e.g. >=, <= are taken based on ranges,
> but additional information in tnum is not taken into account.
> Later reg_set_min_max() will call reg_bounds_sync() and it might turn
> out that updated ranges do not intersect with tnums.
> The inverse might happen for tnum based decisions in
> is_scalar_branch_taken().
> 
> So, if we don't reach fixed point in reg_bounds_sync() we just leave
> some precision on the table w/o other negative consequences,
> as far as I understand.

Understood. Then my assumption was wrong.

> One solution for invariants violation looks as follows:
> - Adjust is_scalar_branch_taken():
>   - Do not make predictions directly, instead apply range and tnum
>     changes corresponding to the operation (e.g. for true branch of
>     the `rX <= 0` operation intersect `rX` range with [-∞, 0]).
>   - Call reg_set_min_max() and check if resulting registers are in a
>     valid state. If they are for some branch but not another a
>     prediction can be made.
> - Adjust check_cond_jmp_op() to use registers computed by
>   is_scalar_branch_taken() for true and false verifier states.
> - Adjust reg_bounds_sync() to consistently bail out if invariants
>   violation is encountered. I think it has a few places with implicit
>   assumption that ranges/tnums must overlap.

Thanks for the explanations! I did see Paul and Harishankar had a
patchset that tackles, will look into that.

> I have a stale branch with these changes, need to pull my act together
> and finish with those changes.
