Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607043;
	b=dO55Htni1E7l4xHR6j5WYxDtkheMrZ19z3I92DXPS2bnv3vasTb127b04J0hLbZoGX7a
	 dzv7WwgiNje2kGI00tmlkPsO3ECLT/+NHAavU0GjOoohyjKkhjS5UJAz63MIYVD1vMtNb
	 cTKNwyWh1oOuEUNAjZrBwjgrQYEk0GjHAjfE+C4KZk1+tWQiOJBLsTxW5ugZ9zDrpk/b1
	 eRtRseXKaVzBsJrxaoWa+YCjdfFjgqboX85B7GkpVv5PJnOKsXK2WfbkXeRbxu2qU6Mq9
	 tLmCEFbZujzVKPKb4yV4cJQsNQzKgdPI0OD9179EvtsnCeGRMWRKjRUiROToS9KvlbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MEQGmHyCkD487pAn7zLxPEqhYYAlfzB5pbrnWC6Jd6w=;
	b=hjcIu5/8HMsd9xjwnBASlhZjEAdJQkuZIVjSU4XGj1ZZutoYsYMFdDV7qIB6ZPL1ta0I
	 5/dwRRE947runESNjDD1U/xAo5LrU0GMK8oDaS2/zfLOrpp5BKMbPcc6mK7SEUHuUIe/Z
	 1+wOqdlq3JJe+xLEULxBsQYn6KAolMymM49CVhTtansTijWywRTWgq7pslTfoCxbY8zvh
	 0ZYu/v+lIWmxB3jlkzNe1jN/bj23BKv8i93L6A+UyRznl7Io9jwhMvvGTP38WahTi2m4D
	 puuyWPPrC5QuwiIaGjjACGiLJ72fzgXZmkxNE8UFhX2sEG7bUI3XxmWF3GEbJ44bYzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNbIT4zo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6B606A327
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNbIT4zo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3541F000C4;
	Fri, 13 Nov 2026 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607043;
	bh=MEQGmHyCkD487pAn7zLxPEqhYYAlfzB5pbrnWC6Jd6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hNbIT4zoSEVqLto7v0r1ZW8aBXJ4OrPBkuICZRe3qyO+7fzZvnnXO/IAeXLSqucUu
	 7v5DW+/iX5prUf4ED3ZLQ1zJ1EiIXK5fcO40TjwAmvj0X73ceMAiEo52swx9VXcVS2
	 AsxrEeBtyDhobd1xairasQiY+qOF+BZQO36RJoKe1gXmtHzR3NoHzRHd3FU6I8kkvD
	 /LnYc4gr7zlq4Bpty4LYjcy0O6HJnJGOOeimd91w97SmeKPUch4Ezps8RxoI9Ixd4T
	 IOfs6HzjKI2zk5DyQgSQdHoYPudKaPDig3YqIVWLWzi1X7A6ebnNI1FxnlgcFbRmoU
	 Q+ZCfrCMElnDA==
Message-ID: <sashiko-outbox-213751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/6] bpf: Scope the bpf_for_each_map_elem()
 array key to the callback frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261113213921.1646681-6-ihor.solodrai@linux.dev>
References: <20261113213921.1646681-1-ihor.solodrai@linux.dev>
 <20261113213921.1646681-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:57:22 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: missing Fixes trailer for bpf_for_each_map_elem() array key
  fix
--

commit 96799b25d62e44bb557604554c52bc9deffd87cf
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

> bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
>
> bpf_for_each_map_elem() passes array and per-CPU array callbacks the
> address of a key on the helper's stack.
>
> A callback can save that pointer in its context and dereference it
> after the helper returns. Loads through PTR_TO_MAP_KEY are not
> fault-protected, allowing a four-byte read-only leak of reused kernel
> stack.
>
> The verifier tracks the pointer's type and key size, but does not tie
> its lifetime to the callback invocation.
>
> Scope R2 to the callback frame in the array map callback setup so the
> key and its copies are invalidated on callback return. Leave hash keys
> and map values unchanged, since their storage is not callback-local.
>
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

[Severity: Low]
Should this include a Fixes tag for the commit that added array map
support to bpf_for_each_map_elem()?

  Fixes: 06dcdcd4b9e8 ("bpf: Add arraymap support for bpf_for_each_map_elem=
() helper")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113213921.1646=
681-1-ihor.solodrai@linux.dev?part=3D5
