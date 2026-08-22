Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895B2C08D0
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359593; cv=none; b=IRdTpsO2FT4Rrl7xj5nW3SpCcVNYIXzs1eQGrxoCzvXXvgStsl6ftbAv9s++ym5a/NhubchcrRg0CReStrje0nEKOTaQtIjOxoCfNzX88G8kny4Be7Sli0ccXm+qu3YiD0ntbSt9MObSnbpQOZe33BY33Kl+wF6TQPhOqzi4n7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359593; c=relaxed/simple;
	bh=8srW/NpLHXa+b+J7YZwdzk7dlrq7AT43oTwFl3Utqak=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UqYNinKVdPubDMaskrbaG/c58J9gPmpJgDU6k3B+33SQzmgPN8t+zG11pMPFFHLMzUS+QOElfqJSfKW+/Rxf6dFbcOlQHc3Us8BJxGi5TY8uV+LYqoifUbcGIytgY6/ig5XsNUpj0OuRPY4V0/ngjPeB+cArcj5MwCoqvIVFmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp4MBpzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp4MBpzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78C91F000E9;
	Sat, 22 Aug 2026 00:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359592;
	bh=8srW/NpLHXa+b+J7YZwdzk7dlrq7AT43oTwFl3Utqak=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Lp4MBpzjp3VqdJxvFX7gpd9RCf496Tu6KuJ4V91MPw+e9ocPJj+oOUeHWtZ58/nEM
	 k8axdGkfFooV5D8y5s2wdjkuiRV3ta4fVSwfD12ReKUFezBzpssy+6HgNVq6vdCYaC
	 b0QReyhaPqPvtyxpRK55GhXu1xMSG5f6fgkaTPITq49Nwtkh+qUYZoGhnlkF2rMUG/
	 m7Xcdt6Ou1mXm7HOyftle8QDtB8jlhhXF7Q9Dc9g1GaWLd7yuaz5rLwt7knCgGDTsy
	 HG3Q6lRkg18YlQ4oiZERIYrUUGX1Pck1kpSTll8Azb19vgsGMkA98E88Pt4Fu5y15S
	 r3ns+qjQ5kQWg==
Content-Type: multipart/mixed; boundary="===============5104913445266969279=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8cbc0a547ead611386fa44b6cf6b027dc371a3ffab68d8b0d6b6929d87288c55@mail.kernel.org>
In-Reply-To: <20260821233516.3426127-2-memxor@gmail.com>
References: <20260821233516.3426127-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/14] bpf: Split arena kfunc and struct_ops JIT capabilities
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 00:46:31 +0000 (UTC)

--===============5104913445266969279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Split arena kfunc and struct_ops JIT capabilities
>
> Arena pointer kfunc calls and struct_ops callbacks need different JIT
> support. The former rebases BPF arena offsets before a kfunc call, while
> the latter converts kernel pointers when an indirect trampoline builds a
> callback context.
>
> A single bpf_jit_supports_arena_args() hook forces an architecture to
> implement both paths at once. That ties bpf_arena_alloc_pages()
> conversion to struct_ops trampoline support and prevents the paths from
> being enabled and reviewed independently.
>
> Replace it with separate kfunc and struct_ops capability hooks. Make the
> verifier query the hook for the path it is checking, and have x86-64 and
> arm64 advertise both capabilities to preserve their current behavior.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This isn't a bug, but since bpf_arena_alloc_pages() still takes addr__ign
at this point in the series and only picks up the __arena__nullable suffix
in a later patch, would it read more clearly to phrase this as what the
split enables for the following patches, or to point at an argument that is
already suffixed today?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32538351576
--===============5104913445266969279==--
