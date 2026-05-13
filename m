Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41344C77AA;
	Wed, 13 May 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685371; cv=none; b=CZ307URiwoud5mohpdXEBZQxRA90+gp6hLCqskhGAvvEKlTObSPYVIOGkmsB3fIlXMtIYpJBvvYkZLbvgFUKyK8DfaKa7r6AJ0tK7kpTVgGZtZg1lPuvWsuKGWOmREQVv2vmSJIR+VJjmcLcR3fveiM0vqNznjFtmGXxixTWNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685371; c=relaxed/simple;
	bh=Hu5tQPWosQEI+XoGE4kMQm/b0+rY+Biy/oOsFSciEaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9j+dh/h7LObpgZb2KGenSSWjAp6Z5G1eFUhVOBV2UO51cUBdGNYHeW1/vfX6uM8SmoW+UdWpC4A5acBCwTk9QmrKLl6Ck7N7zz8i16uH+EIBnvKpF2riHFk3UurAj1gpq0qNzi4d7gNVbrlFaAEOfVsLfoufFcFTgsD6aBAOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ4mg/KV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ4mg/KV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF58EC19425;
	Wed, 13 May 2026 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778685371;
	bh=Hu5tQPWosQEI+XoGE4kMQm/b0+rY+Biy/oOsFSciEaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQ4mg/KVaTOg1YIdGGnsS7AHcg0wrKaIx4Z5MJjWxzImtoMEnumX4MOM9P8bc1d/B
	 JowuKS8oRgM+O6vB2NxgB9aklGEHKTBVx7BrScvlEorZ4p9dnxtZSZ8K4Epl8h1mv6
	 hmqcm9KT9+lZRjU5Hq/Ptp+FnCqBZpiq4gzqjo4Es1PHg/PgbCSeJrGux7MQ73Ef3X
	 Ge702xiPY0xMuKk4wv/beyzH7L9UU9ZoscWNxkFlrtIyUTtmvF+KflGRAufUDtXwd/
	 NQMTrvQZ3C9PdwoTpUNZa5Z86ddKuG1Ym9T6Aw9QSpgdxEvcU6SOU28QhPkSiFjDE+
	 02WOOg5nohyNw==
Date: Wed, 13 May 2026 11:16:13 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Indu Bhagat <ibhagatgnu@gmail.com>, bpf@vger.kernel.org,
 sashiko@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v14 16/19] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
Message-ID: <20260513111613.372b6e47@gandalf.local.home>
In-Reply-To: <af040f1c-7bcf-402b-961c-f5fce2afd60e@linux.ibm.com>
References: <20260505121718.3572346-17-jremus@linux.ibm.com>
	<20260505185502.CB501C2BCB4@smtp.kernel.org>
	<fc085657-a79c-422d-afd5-4b5f2c55cec2@linux.ibm.com>
	<b76a0b89-3cef-4f72-90b1-7029b989cb63@gmail.com>
	<af040f1c-7bcf-402b-961c-f5fce2afd60e@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 15:50:29 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> >>
> >> @Indu:=C2=A0 Although the SFrame spec does only state "unused Unused b=
it." I
> >> think it would be good for the logic to reject any value other than ze=
ro
> >> as that could be used in future extensions of the SFrame format.=C2=A0=
 Do you
> >> agree?
> >> =20
> >=20
> > For unused bits, it will be ideal to not associate any "observable"
> > behaviour on the consumer side, before the bits find their use.=C2=A0 S=
o I
> > suggest the recommended way is to ignore the unused bits completely,
> > i.e., mask them out and not report any error (if they are set). =20
>=20
> I disagree.  Masking unused/reserved bits would cause the unwinder to
> ignore those even if they get assigned a meaning in the future that it
> needs to respect.  It could thus cause the unwinder to erroneously
> proceed with wrong results instead of stopping.

Correct. "reserved bits" should always be zero unless there is another way
to know when they will become used. For instance, if using these bits
requires a version change, then it would be OK to ignore them. But if they
can ever be used without some other way to inform the kernel that they are
to be ignored, then they must be zero.

-- Steve
