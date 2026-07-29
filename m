Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE729BD91
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369493; cv=none; b=OV1CJJmdkCD9EZlxxDGiePl/uRRhEZhgU7r5S1c/RvZr3muPBpcb571itk6eeJJBub2t5vnJgd2mJdkfmYNXwG2FxqC1Z5F/JKdbfA5wCDPj1o1LZEPB3BaOxYM/V2VtCtr+KOASLlgsOlAMenFskrsOQH1eTJJMQ2xMPTG2zeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369493; c=relaxed/simple;
	bh=mITtomBLnwQIO2MC4PVSup2YEZqji23r2xvfeNuOs6A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbp+bNno/+luTzNo293TCMnKS4HkUtLY71WxEXd1Q8uwGEQuhnm+SAT89H3mf09BriNTYVaiKZAaUX/RoZQvP0FiGGZ7wIn+21EqyvcdNPrHnNEouMRY2m7a8vY2HCAnpOrwOe5Qp88MLA0KWdEXJzfUgVMO2UZrektGNn0o26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OSXfmLyU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OSXfmLyU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785369490; x=1785628690;
	bh=mITtomBLnwQIO2MC4PVSup2YEZqji23r2xvfeNuOs6A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OSXfmLyU5nhzS8uvUq6zRtV4xzxyzcBOMM7/YDWcABGyLOV1Gsl1XhuB85mu3UoLD
	 QRNx7wX4f/Nsj3dqng1wjdgWOC0onE97ewl4sA9aPM4bI2mJEKeb3aEZsk0BNSYhsB
	 pxKP4zJVr6/ic8Vk6TdT7uRGvcl/mf7EM6HPSGlqWPFeTg35AkWOWp75oiJayRvg8R
	 vKYUEeFwPwALUjrtXco/MoqsaSp2k7a9WiCtPzdpPR0ID3dA1nd9zo4of7FfeOZp5D
	 HlMfmAy2/irwwcfQL+fN61YHf46mEJrpYUg7iGcX9+Wptm4ODgWOrUZiDU0k2aoiVr
	 dRYOcZ6vhvuQg==
Date: Wed, 29 Jul 2026 23:58:07 +0000
To: sashiko-bot@kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: bpf@vger.kernel.org, sashiko-reviews@lists.linux.dev, vldsampaio@pm.me
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Avoid redundant min()/max() in cnum signed bounds
Message-ID: <20260729235833.376494-1-vldsampaio@pm.me>
In-Reply-To: <20260729200108.BA70A1F000E9@smtp.kernel.org>
References: <20260729194932.292368-1-vldsampaio@pm.me> <20260729194932.292368-4-vldsampaio@pm.me> <20260729200108.BA70A1F000E9@smtp.kernel.org>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 03057c5192427db9c8d103b227cd364b84c9ded4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> [Severity: Low]
> This isn't a bug, but should the opening '/*' be on its own line to align
> with the preferred BPF subsystem multi-line comment style?

Yes, it does, I'll fix that.

> [Severity: Low]
> This isn't a bug, but similar to the comment above, would it be better
> to place the opening '/*' on its own line here as well?

Yes!

