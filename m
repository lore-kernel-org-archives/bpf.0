Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A153AFD06
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352899; cv=none; b=prfwBECIEqQfTbKBDAj8fLqHd0pzr/OjGuveB1nU3qf5CR91e19jXBdzH8O2azXx+eyP7lHj8q0nQQbg0vaOQ0P76eMwmUoh7vmfeD25GKG9yPkKgHwZ+y7RvTPiMIV+j6baajVj9OeCLQ4eznhHFiQDjzM8Sr48SRb0kl2SYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352899; c=relaxed/simple;
	bh=WtdS2Li9xdf9VdqeWPxFgfobm82WvYQjCAwciK4fzGo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyqkSLR+YFrUCVFtgMIW8Epfm8/mAgZSBFIbLm9Tc6ZKZMW27spnRAHtIjuIF044gMG1lNxql8lihkcVFO18Aes08+TF2pANV77VXhxzWJMRj+dPkhDvLSHckla/TDrSEmDZPHIw1TMvLPsbVRrzXb+ApeGsww2Jbdo+jQnDOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=QcKntdBl; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="QcKntdBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785352885; x=1785612085;
	bh=f8GQiFPeNGLMMFvkMsXfFB70VMTDduncNDJ9Qa4FRmM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QcKntdBlRfq7Xjswd/H/I3cJcK+tgKXmT7FaOyRmEVYq0NNnb5tKFBNkFg6UpHbec
	 MN1NF8amaZC5XsX0H1yNgk7cYMDiiDa9Q2oPcNIbYkTelIvPITvQAK8HLDyj89kn/g
	 DaU3DGVhiQCmPKMk7NYwdAcS3Ut5NY3qyduKn2Vi4ppOA6QKCacrux3s/KORRTdL23
	 VFSvUcCZ3qqtS7AePmalxD4fkwsGqvc+mdEkbOXk/OqGf5EXA+fRAWyTKzQBJ67tNa
	 bTowfy0uIM6o2RNXne2KVvs3GLEPZ4vJqOQY2z4teSRjVfEFD3VQxIIuzvs8wYNKk1
	 98wwI3ML9ruSw==
Date: Wed, 29 Jul 2026 19:21:19 +0000
To: shung-hsi.yu@suse.com
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, shenghaoyuan0928@163.com, song@kernel.org, tangyazhou518@outlook.com, vldsampaio@pm.me, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 2/2] bpf: Avoid redundant min()/max() in cnum signed bounds
Message-ID: <20260729192144.276697-1-vldsampaio@pm.me>
In-Reply-To: <ammvMH-I4088A3AX@u94a>
References: <20260728015601.1567098-1-vldsampaio@pm.me> <20260728015601.1567098-3-vldsampaio@pm.me> <ammvMH-I4088A3AX@u94a>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 1bd7a2874f1fb4e2059cb687d8f775fbd7fdb62e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Nit: if we are adding these it would perhaps be helpful to add similar
> comment to {u,s}range_overflow as well. AFAICT
> {u,s}{min,max,range_overflow} should be the only cnum function that is
> not expected to take on an empty cnum.
>=20
> Thought I'd prefer something along the lines of
>=20
>   caller should ensure !is_empty(cnum) holds when calling

I'll change the comment to match what you've suggested and add it to
{u,s}range_overflow then. Thanks for the review and Acked-by.

