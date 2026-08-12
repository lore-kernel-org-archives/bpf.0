Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CED399377
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516701; cv=none; b=TW2j6mLUBZcCj50mOZnMBP1RRID1aSuQlghjavgBe0jQK7oYSAzEDKD4kS83G4nTv7zsb9nESrCFeOPwVRE8gOcqQD4r2mQqSVnKE1XBsBoaBJOQHNPfCZZ53ueo816gkBkfUtJSNMiSZIhxinvc3/+w+OSuIHnVhDhL4BzeuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516701; c=relaxed/simple;
	bh=lVxznVhkrCbkHdlT2FVZX+i2M7vpn8tN1TYulKsNnpE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=j13cRAUyKwdR19UXeqjHH39jqhJm1bWBIkAEh3gGnFyighLswhzvyDjA1Zu6itLDTgXHVyl0wDsufIMRo1AyBIm7pnYiZlRrVG1NUSO1YNM1cdKJnlZZeLY2jqa+aPiDJh5bem2M30lbA+3nDIvz5Z8FdqoCJ87hz9bvl3UFVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8fD5qa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8fD5qa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577311F000E9;
	Wed, 12 Aug 2026 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786516700;
	bh=+irEMEqb4QZCbxsGwwnmMv9ctJsiLxPIErcLCS74hl0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e8fD5qa8K6M+SDaUZjp5w+whfSllmSGx1Y6oBM4R0ZwtS+/ZMfzw5eClU3bJD0u9v
	 UjeyYq9FeuuCHpP6Gvrl0UsMbxWFFDiA7HnnwUNhR0B5OAWpvD7uLNYYkQDXwI5G9Y
	 w8Q/UukKiXZdB/XD/58IBCRJxLntKCknUBDPkJXL5SA0IVzklUORDHa2QmA0aUsQJu
	 bduuC9L82I7TvWfJyYlwVrs5A79CWeHqb7+CtbwyDtYxJ14qiSg0i5odeQYiB1goIF
	 XVS81hlJPAMh8wDOIWKZfQNPOHhzPF9rZUUKrCNyKEj8c9RWMkBo5fN+EngvcARNVq
	 g0REawSgZ8ksg==
Content-Type: multipart/mixed; boundary="===============1139615389914824238=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec185c8e45f1b63372288201a550c1f921d3ce86ccad25cc52cbda221620499e@mail.kernel.org>
In-Reply-To: <20260811-veristat-filter-fix-v2-1-6c234c4cd6ef@gmail.com>
References: <20260811-veristat-filter-fix-v2-1-6c234c4cd6ef@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: fix for veristat file/prog filters processing
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 06:38:19 +0000 (UTC)

--===============1139615389914824238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: fix for veristat file/prog filters processing
>
> At the moment veristat filtering behaves unexpectedly for the
> following filter expression:
>
>   -f !file/prog
>
> The expression rejects all programs with name 'prog', and all programs
> in a file with name 'file'. This commit fixes the expression to
> exclude only a program 'prog' from a file 'file'. Additionally,
> the commit makes empty filters like '-f ""' or '-f "/"' and error.

This isn't a bug, but should "and error" here read "an error"? It's the
sentence that documents the new -EINVAL for empty filters.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31569226955
--===============1139615389914824238==--
