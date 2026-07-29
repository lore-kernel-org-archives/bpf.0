Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A93AEF5A
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352532; cv=none; b=LgxEy9R8z5HYMSrGECIENMj1+mPcjYOrjKQvE/nIlU1H94sVrCmXPhRp9CvsVn4tnrhd2kB4y7lFY9NabrjTAc6PUhP4IxKeMzk2l0U3H77HBTOJqiLlQTCNVD3Gi0y2WHn+j7/Ws4WmNnN7AbPadO17Fi2VqxUzMT7YXDEAGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352532; c=relaxed/simple;
	bh=2B1dM+OwAXcLq/+ZJdhX2Rq1qFGLFP83XO/PgWg0s7k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQS9uXxvYWPkJfguNxL8g33+unrJgHvviH3zu654wDBc65KKyAsXDruiGq5rFedUvWAF+s+nrUOoIh5Iz+uZ3d92+yVxHZC+wa98IcYSmTji3CCMDqdqkkSPpUJENr18BoJePnW0dgz7GlzPhswI8TnoMBQ/oUEa0JqR2DPYKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=AcvQLg7R; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="AcvQLg7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785352518; x=1785611718;
	bh=2B1dM+OwAXcLq/+ZJdhX2Rq1qFGLFP83XO/PgWg0s7k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AcvQLg7RWSsf26ng3BnAupxfW2IHgEEyym5tqjNvkuMZC481zLPBBsXGu/dC1n6Ff
	 GgnXmIOpbmZZBBTlaiy7nGuBwfo046aruQa7XCpDydoMOWBqSb1I0Syn5KDlHTgGmV
	 xYC8wYW49tjenpGsFPiepBIAYGT4edZhYhpF2XK4+xU2CcHPrGERLZIH07wrh1SK8i
	 /d9ZeBPjNxS3ciWiKKjuMQD5IDCmXJFp28f5dOs/x/Efqx1lKn25KcmMOdC7VfZi/g
	 zM+l9zy+yS/bSZStHUM1R5UABRsZL6bcC2RXSiEqBZhsq7danEw7C4b1wV5B57PV6L
	 13AKKYxc5Etjw==
Date: Wed, 29 Jul 2026 19:15:12 +0000
To: shung-hsi.yu@suse.com
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, shenghaoyuan0928@163.com, song@kernel.org, tangyazhou518@outlook.com, vldsampaio@pm.me, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: Simplify cnum contains() and normalize() implementation
Message-ID: <20260729191536.274062-1-vldsampaio@pm.me>
In-Reply-To: <ammWxQ-PiJ-Z0z67@u94a>
References: <20260728015601.1567098-1-vldsampaio@pm.me> <20260728015601.1567098-2-vldsampaio@pm.me> <ammWxQ-PiJ-Z0z67@u94a>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 0bc612a55f4800a3d96e42536c3ff8bc83fe0b83
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Nit: is there a reason these two optimizations need to land as a single
> commit?

No. I will split them into separate commits in v2.

> Could we go even further and also drop the `cnum.base !=3D 0`, just
> relying on the `cnum.size =3D=3D UT_MAX` guard solely?

Yes, assigning zero again is harmless. I will simplify this in v2.

Thanks for the review and the Acked-by.

