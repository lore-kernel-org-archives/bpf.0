Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C1396D25
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386985; cv=none; b=I/HcPCh9n6NtumNuKmrpuG7q4R4Hme+SpvT8K6f31oiXyA/C8Bcz4zwLSXDnTY90DxOvCJToMcXhyYyBXunIk/j83hI150VDQ2LZml3tH+fw+r3Wq1zC/cL00cHBHNOODaIQ+RcdbhLh5erz7G9FvuZpb9swbqSImWbuq41oQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386985; c=relaxed/simple;
	bh=tfzHi55/go+W4AdlklCIR8z+nSLp9SEHanKFw9mlfRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ENDJ465vTq3I7jLrruEmW8HYrS3znGfg0A9wn41FM2E1bnw2N7xM99R5sQpzc7cl5fGzfOH29v/k/raneLCUj5VLt/XE/C1u2Zax+9BNmRRITvCRHNeWIOPhbUV8i+Sl0KdD5LAS7gk/ijnnoY+YMvD5SyHfjOdPnq5i0rm3LH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGGYxhNb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGGYxhNb"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2333621a91.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386984; x=1786991784; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SyVVG6h7kn5YtPcRolL8sZ5gFjw6P8nBLJanWwBROZ4=;
        b=NGGYxhNbHzrQcso8+H/LeL9b2w0+SVKAfMvm6Y8U7O2D0l4t0E5dbhnUSNt4PLPsoo
         hw4E12CdU62sg1PszHFVxpM5vG+za6O1S1nrkxPu7Cuxpz9SNEBJu1VxrVHTde/H+Aq6
         jkFLqzm5n9DFTgq8hRTcYMRAQ5kh3LpM23xNoMXWtwJ+pviZOQlkN8hMWU75rxOstPuT
         wnvZ1It34oWuE4Arp3AVzAi61Eud/5trSEb6IwknwBcXWU2gp578ePmbc7+/bEKzGoWo
         90GRVHzjUKtbj2sVkNqkyLqnwyibZ+t4lGfGlh6OUyMR3fTsSNhguHzC1i9JALwG+mEN
         e63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386984; x=1786991784;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyVVG6h7kn5YtPcRolL8sZ5gFjw6P8nBLJanWwBROZ4=;
        b=NLHnLjFXtL3cQ/EbYcPcIEkVrGAwljgUgr8M2WzV79094h9I1OthBvJEwdJHd+vVnj
         ksv4KaclQ9wL/Nch824P8WDyHMTSoR3u0a8PztGO7MSgu+tePXQ14FDEOx6mORfH82On
         lKeCy85zm9ZqJqAbWE/7J3c4nSxVyDujEGSozwiHDpb3liAvItFP1Bh1x2greT9x+nxA
         rMsmeH9h2f0f/z/+10lLUCONqJBo2spMqKI6HmcBGnub40QjCRfVKcjwGP+GbhP/oSWi
         +If/kNRCMb89VEtqUtgAPwNU9BTD2n4vFBlr1NCRVkjkhNLd+CzYSq3mLEv0ophcQxNF
         wBow==
X-Gm-Message-State: AOJu0Yzxq7DJXMHrmB1Ag8kDL3uQHVYiVfJctsESbjgiG5j1ARmDqDBI
	4wh3hFav9n+EiwmUb9wBLfaOFb8f1H5XK7GuPLB3iOw0N+2jn5W4VcZm
X-Gm-Gg: AR+sD13dR6JcMvfDN/hon/2hBSCSN6WNAN4nXsvf4DmrufhZCfFfJxitTtoboNwyVOa
	kxrShmj1QVPIX6EjlzlROz2JnwNEmLArzfhG0g75mS1V4ad0ZzGDkThFSGFk1ABv9U5JZXhWlm1
	t9FFsxAA1aRhqbQrUP65N2HWeacK7uHVDlqECgYYiQdMDII6Fg+KtlJetRCaUWaEnzv9bynZSTj
	sXRSLMbro4zbVNP1EBi2hKAu1LQ3ArRW4CpyyrIo9Naylgxo4GUQA+FIJnjMfY7QPtSw/ZlmTCB
	Q31gkXWIyDOp5eJshUf5CWmX/2egAg9fmG+XmDrUb19uQI2mQHU9S691N5UWfx7T79gu7gt+iH5
	8dlNeaKuACSK6UVMoEVMUSg0NeIOqNNGy1p4oLp96gc5w6LyFYvf8TYBtdw+wIbH5mIFT8aR0fE
	htkECL/fvJKEjv/tQTzpDWq/N1Hrt5kMPwsHTn9vjjybhZzJoQlnEiIfFZmVipwWAT0nzSVS3ow
	PfhhnAo/LKto6DG
X-Received: by 2002:a17:90b:3985:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-3903c5f41ccmr36440881a91.16.1786386983758;
        Mon, 10 Aug 2026 11:36:23 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b345b841sm6755420a91.3.2026.08.10.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:36:22 -0700 (PDT)
Message-ID: <022333c52308f90c17dfb82e0c33fd4bd01716dc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf, arm64: Clear fetch destination on
 faulting arena atomic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, 	memxor@gmail.com
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 10 Aug 2026 11:36:19 -0700
In-Reply-To: <m2wltxj09w.fsf@kernel.org>
References: <20260810134346.466004-1-daniel@iogearbox.net>
	 <20260810134346.466004-4-daniel@iogearbox.net>
	 <7778fb7a81005f982f4073472f0435bc63a9287c.camel@gmail.com>
	 <m2wltxj09w.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 19:30 +0100, Puranjay Mohan wrote:

...

> > > =C2=A0arch/arm64/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++---=
-------
> > > =C2=A01 file changed, 26 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_c=
omp.c
> > > index d14d297ebb96..796ff9193cfb 100644
> > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > +++ b/arch/arm64/net/bpf_jit_comp.c
> >=20
> > ...
> >=20
> > > @@ -1183,13 +1187,25 @@ static int add_exception_handler(const struct=
 bpf_insn *insn,
> > > =C2=A0	 * dst_reg like a BPF_LDX does, hence it must not be treated a=
s a store
> > > =C2=A0	 * here.
> > > =C2=A0	 */
> > > -	if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(i=
nsn))
> > > -		dst_reg =3D DONT_CLEAR;
> > > +	if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(i=
nsn)) {
> > > +		/*
> > > +		 * A store has no destination register to clear, except for a
> > > +		 * read-modify-write with BPF_FETCH, which also reads the old
> > > +		 * value into src_reg, or into r0 for a BPF_CMPXCHG. Either way
> > > +		 * the access is still reported as a write.
> > > +		 */
> > > +		int load_reg =3D bpf_atomic_load_reg(insn);
> >=20
> > Nit: I think it would be more in line with the current arm64 jit organi=
zation
> > =C2=A0=C2=A0=C2=A0=C2=A0 if bpf_atomic_load_reg() call is moved to the =
add_exception_handler()
> > =C2=A0=C2=A0=C2=A0=C2=A0 callsite in the build_insn(), where it handles=
 BPF_PROBE_ATOMIC.
> >=20
>=20
> Wouldn't that cause more code churn?

Having 'dst' both passed as a parameter and passed from the callsite
is somewhat inconsistent.
