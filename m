Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39B24DCF6
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368802; cv=none; b=uxOS4qKeCuOxyrJrqnax78LlYxTBo58z7Nx80G8oHK63m94EfNiaPGRvMPKCAF2VeJKyYT2N0s7U+DfWfUEaFit1xAXjoCCEzE5VQGoKau8Jzs3pw8atIE4y/4sr6e+E5ZPKNcv3l9PZLyFaIWk9P44oQNH0O3FkYUkmP8Oe14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368802; c=relaxed/simple;
	bh=3bX1AlQ9+actuodNRWzQ0iapuaNo6l70NyQNvr+JeI4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDElbppcmtmzyvmdk3lY/AGqHZrnR4szhG9B2UCMFi7ZDBqF9LPaL/kLycGt65UlCp+/DavyThnVLm6AAzJSZfB8CD7+HjykP2kyJ/mjDfLLEiyJlmfJOMigtdJPKOm5wx/DyW5Po9c7m1Ge4GDR+cw4mr+DHcKzkhZFag7/HeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LRpqR8cL; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LRpqR8cL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785368789; x=1785627989;
	bh=3bX1AlQ9+actuodNRWzQ0iapuaNo6l70NyQNvr+JeI4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LRpqR8cLO9dR8WwQ7uDXKsZuplOeIbls8e+AN0dqE6BJl1PxJnB2QvQbXU7SsSj9R
	 v7iLOgOBwoBv1KEXTlBrMyaZhoDfYsivx4V6UZ3HPVSHYqBhuIE1Z3PYAAy7dFT9se
	 U/ig8eXOAp9uNSOIPXT68ZBESCwrSoyl8vTZI1epgJ+FWWQm2by1ZYF5MSlzwFCjfl
	 fgecUIzvcVp4Uitl6yjQolAyFumOnWUDoWn2ODuW3vOKJKKtuv2QGYlYW5fZjJbJ5U
	 XZxYld2UUsSd0jCwn9P3OhjlU4bJ/2RO9aMui6vdCX9MNU8ccjhdTDqWDcxFhCOxqy
	 WdCkWxQcA9Qmg==
Date: Wed, 29 Jul 2026 23:46:22 +0000
To: bot+bpf-ci@kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, martin.lau@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, shenghaoyuan0928@163.com, shung-hsi.yu@suse.com, song@kernel.org, tangyazhou518@outlook.com, vldsampaio@pm.me, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Simplify cnum contains() implementation
Message-ID: <20260729234645.370109-1-vldsampaio@pm.me>
In-Reply-To: <0e15ace88b847a4a307530925c47c092b8182c820ba512f48a1da3e9a463b3a6@mail.kernel.org>
References: <20260729194932.292368-2-vldsampaio@pm.me> <0e15ace88b847a4a307530925c47c092b8182c820ba512f48a1da3e9a463b3a6@mail.kernel.org>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: a9063638b2b0622b15250083ad86e92cd323bc95
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> This isn't a bug, but since the table shows the new form slower for the
> non-overflow and singleton cases, would it read better to describe this a=
s a
> simplification (one uniform branch-free predicate instead of a wrap/no-wr=
ap
> split) rather than an optimization?

Agree, I'll change that in the next patch.

> This isn't a bug, but could the changelog wording be tidied on the next s=
pin:
> 'a optimization' -> 'an optimization', 'a inclusive circular range' -> 'a=
n
> inclusive circular range', 'theses tests' -> 'these tests', and 'soundnes=
s
> of this operations' -> 'soundness of these operations'?

Ok! I'll fix that.

