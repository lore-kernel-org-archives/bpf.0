Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470937649B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789191; cv=none; b=kTgJ00DcXUJAU8MePTotpmfV6q/72P22tq+wKNTKqH6WoaKmq5LgtyruzaX6OmLytV/TPeOwje/QJB7FY6iuP2Jo3QiJwijhKmmPPjRWdxieWD+fHEzEm5G0L7n0v9cVSBUU0LO2e0ihSkWXaUVWdrFZB5yBy7a33C+SppkChvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789191; c=relaxed/simple;
	bh=/DnMv5jLUQeMWhOzoJWB2OVrEz8rOyFszqWQ0ldQHWA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6bILszA3rABY9ufUrmviVo8cgY5Eb6OHRstoVHelJWtYpUbz8ZN4cFZj81aenqb8VGVMFO4vc5qhHB4eBiHEG7zMZ1VD0sVTRPFRB/UkkyULlBxi+rb3G5sCaR/0WKpDe1alVJdX3BeSgdUQr5QaQPPxpnrI49IZp9cIfX8lY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMIZBxFy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMIZBxFy"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2959587a91.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776789190; x=1777393990; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nj7tOO1s3hi6CyC91SIBs4RccfALj6+5qr4s1uQVfNw=;
        b=NMIZBxFyh3+8FqBqsFNUvQwKWgO/qC2FXfR4tZc1BJUUG++FIal0em0FcBZtIPLybS
         k1yrjDq7GZTvioF5uYsxpOKX9EbozbIZTMnARXVKRyyT0b4TivabZ35CdhqtLXyAladA
         BZdRY4oxoi1nVjX7qtWd8wW1fxbxGaK3sU73mjtIQwGatcWbIyVkpTVFlsFSS1LK46r3
         hUerwXoNVvMM1sEKHpdmLv7CeHAYNFjLqsHhKuvUYPlM0X5Uo91MxzrVM/FqsvLqzT6r
         FxlThh6L9YOfWqg+wHdMiBZFgcrI032atSNE3Nbvo6qcZwxCsmi0A1snpA2D/6Jx+kcl
         Alqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776789190; x=1777393990;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nj7tOO1s3hi6CyC91SIBs4RccfALj6+5qr4s1uQVfNw=;
        b=VsviLeknxn3DAXZmBnPB1PzLnnfH5xcye4OiXKM7ERTp/lgJG0dc37YuRXMtL/On26
         YLH0apo8fzvQxMZaewEcV9HL9CEgaejAQhl+tK0OsfSiLpmWFO0oNBtBDN74haaRp/ZO
         VzwepfO85SS9RR6Drb/w61MNTRO9DKQ9vPqunuiyZFyU3vSlocBptUI05XmnBu94MltD
         8l4EFkIjlqa0MyAV9hetpPLiXqllR+x1K/1FrDtQ29nblEcT74YaLlA0peNyifiisr8L
         h/G4pJ/h0JzAncpYYbW9H83i0wMhSvfdKAla1WQjrTkXTHb29f4QB9aRFUGeUEWZ9she
         b76w==
X-Forwarded-Encrypted: i=1; AFNElJ8yH6AxPsoU+5ZkqUyv0+451f5xHl4lAWjgfedYwVE/xe1Jt8JWjOsIz4OTwbi+Nq6hf7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUu4R7wGTRWjK3EoFbyrzCzt05FyzSTPxGWlnvEyNCzVC8mGQJ
	WK8KRLykko8XjZkX7KNQWCoHeGwk09gTz3v8bI/CCphpbJWvJcDFS8Zu
X-Gm-Gg: AeBDieuOOAxb63lvzM5hj2nPq2RWzqkdHbZFnmgqxHuHIjOIiWn+s1Xt3NXZI5akxs7
	uKW2k8yH6yRbLV+0VCxWYCNHQT3I2DIBrCmNpTgI/SBQbymotlzaU52r4H/GRlUBG4IDo8e/PKC
	ZrocWSK8DcWIEduKUQjEdVnNur7Y8gN5ZAFCA543ictqcdAHfzxwNXEj+SWJITc+xvYSWj8Vwad
	vGgit3Z1NxMkNbi/OSv9+2N0yuMMoYv69pZxuymKtAkjHwXtA/B/gVE5k+4sl+l3ux2T3d8Q74J
	710a1Zr10tW7MSOK7xJQGzyiiBu1bjZW+J9+gWyes48pGg1pRF6g8/BPhg8umkiqB4Cy94tBYsb
	Wjrpy2KJhVPMTMLFc7NCIe9OJkx/wcCfqmsOuHPY2VrmQhYDX2/HDrEHP3pdBIGR1cWmlr97wlr
	jex8Fxf8K3OvsJkZmjDqkjzFKYYFZ/GNrhGvuKpi8Uwv5l8puMe58U8eTpwuHGIUY=
X-Received: by 2002:a17:90b:384e:b0:35b:952c:43b9 with SMTP id 98e67ed59e1d1-3614040b2c7mr19596855a91.10.1776789189966;
        Tue, 21 Apr 2026 09:33:09 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410cc196sm14593972a91.17.2026.04.21.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:33:09 -0700 (PDT)
Message-ID: <b9b278f28ff94dc3207624d304be1080584603a7.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com, 
	harishankar.vishwanathan@gmail.com
Date: Tue, 21 Apr 2026 09:33:06 -0700
In-Reply-To: <DHYYQ6F0ZVAB.1FNAHDCF3WHKX@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
	 <DHYYQ6F0ZVAB.1FNAHDCF3WHKX@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 09:10 -0700, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 3:28 AM PDT, Eduard Zingerman wrote:
> >=20
> > Debug metrics
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > To understand the practical impact of the precision trade-offs,
> > two debug counters were added (here [3]):
> >=20
> > - isec_overapprox: counts how many times cnum_intersect() in
> >   conditional branch refinement had to collapse two disjoint arcs into
> >   one, losing precision that the signed/unsigned pair could represent.
> >=20
> > - crossing_poles: counts how many times an ALU operation produces a
> >   cnum that crosses both the unsigned (0/U_MAX) and signed
> >   (S_MAX/S_MIN) boundaries simultaneously. Such cnums cannot be
> >   represented as a pair of signed and unsigned ranges.
> >=20
> > Across 6683 programs:
> > - crossing_poles fires 551K times for 21% of programs.
> > - isec_overapprox fires 119K times for 12% of programs,
>=20
> so cnums win 551k times and lose 119k ?

Yes

> >   most programs have only 1-5 hits. The bulk comes from a few large
> >   sched_ext and profiling programs.
>=20
> and most losses are in sched_ext, yet overall it's a win:
>=20
>  scx_rusty.bpf.o  rusty_enqueue         39842      22053  -17789 (-44.65%=
)
>  scx_rusty.bpf.o  rusty_stopping        37738      19949  -17789 (-47.14%=
)
>  scx_wd40.bpf.o   wd40_stopping         37729      19880  -17849 (-47.31%=
)

Yes

> > - 801 programs have crossing_poles > 0 with isec_overapprox =3D 0.
> > - 202 programs have isec_overapprox > 0 with crossing_poles =3D 0.
>=20
> similar wins vs losses story ?

Yes, is similar to the ratio for win/loss.
But it was counted when general win/loss summary was computed.
I guess, the main takeaway is that crossing_poles happens more often
than isec_overapprox and it can lead to some overall performance wins.
I thought about forking additional states if an over-approximation
is about to happen, but didn't to the experiment.

>=20
> I think even without wins we have to adopt cnum-s mainly for memory
> savings. Once we move to model where do_check_insn() is a transfer
> function the memory savings will become more important.
