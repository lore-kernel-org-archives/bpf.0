Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66D3290C5
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776230015; cv=pass; b=mkdgyHf+YQ7J2b9c5gGiL+gujXLSKxQQ0ND+0RGfiyul2Yw4WaYw0f03YMNX6dC1bwoW29PBTBXKEV7BMWG8UAgRab8J+K6f7UyN0grR6K2NcXGgUS6uGZslnFIfFpcPnmYlXCAsJXnKZnHQWSrFjBjLMOltQKNHANZFFDXSxlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776230015; c=relaxed/simple;
	bh=5w89Q0XOHlzS1NFudSxF+ltlOgfP2MP8QdfvJ6SCblw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJFrZhIJfUUxG/jq+RCm+fHVbrFA74KMmvk6jg2pBzqFIHm2aGYMNkdhdQOF1nI81uSt4ip985F17iS8LI8xlr6NFhviw3w0CI630GwMvLqEr8yrZbX01A2U9CA24yYgeNRVOQgaNswX0T7heP2O0LR+DNdM2ITwodb71+vWM4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHyACHL6; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHyACHL6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d75312379so1984440f8f.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776230012; cv=none;
        d=google.com; s=arc-20240605;
        b=aro0vsfZJA+YefYGTk1zINb1P0rOlUv0tgct7VWB/9RDnhvymbJ5m/Of/2vo2INJqS
         OqjI1mKveuj1IBRFg/lBhcSpQ/sTfEojOzXs18qC4sWmyJYLlKDOwPx7mJwmBgruvJXJ
         cXcvbk/94FtcskjhsLnJ2z7ZkkJJVdSNoqSsH0MWjAvfYRMBq/TzIjkDRWaffBIFteD2
         FpXP3LGiTSJrPATRvQMBKzJ2wrYWwEUiw3db/7j2Zbzs0HveLT7xWX2bzPkv6rvBf8k/
         WBSrM0AzxjAbeULkweyG145+rizsQG3YQlA9uyoLP3sN0Yu9KXjmJxbLHcjhbVVjkWu+
         Y4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0zOfagUaJ2MmtHZMfunbqEI5hLbnQ9HWv5EAjG5Nxto=;
        fh=nOFWMC+woKIOlRK6dururYf0HmUa7rHjjxkmDlvs08k=;
        b=MqOg98crgsBDD+8O4h9KqPNfWBv88Q3ECe32qQ5aUbKqraqwCzgD0NdBYe1FPdX+Il
         6Vnlhz1xcb/naJUpy0u9Xl4KZ1e8nRdik089HKOrMJcylPhx4voS9+ruHaXz4EUU0x2V
         20D9y0sezuxUR7RAdfKd9VmgM9mP2haIoOYceIfMpzsDII4rCjIFvAthQxrl4BwuF5f7
         UuxLtYjFK+C3cnTMo8Yh8gWTa3VXprFLEB9SClDOmo5wIZz4wbikqEBUHI9ylI+ZwiCV
         /WoUnnzDfbxM6F7a1Cl9vbbo9pqoiwQ/iyzIUZLq2RkodrLMKTkYTuTX9BfUWvUOTCka
         aoHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776230012; x=1776834812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zOfagUaJ2MmtHZMfunbqEI5hLbnQ9HWv5EAjG5Nxto=;
        b=eHyACHL6GjbO4O0k+wlFZv3n5RLln5JCe0M1y3wUelYM7J7jZu36xups0R9blnl76n
         Ro744ba/U+QQe7K6aq/bcQ9C218dvUUUhYPk6Yi0vhGAOtvNs7wCPBRJeZ3ht5t8Bnz7
         S6w2Xs8dbSxSn0ztvu5BEryEiBakyBOHA0gPjMo/hk2WSrnw8gEsWM29VfsUQBbjdmzi
         FimobnnVprn46fLDYnPMv68IafrEmjSZN+D6uSvB7wmmUQ9Dlil8/4K/5lel1bu38F/K
         AmAx3S4ycoO40NbSWpVdCYVVEEVT8l+3CFyHMuPXhf8fhkofVH+IVHBJFra9UO/1YAyg
         89Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776230012; x=1776834812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zOfagUaJ2MmtHZMfunbqEI5hLbnQ9HWv5EAjG5Nxto=;
        b=P2tHCSn7UqgZwUsuYOD4/vDFH69G+myVu1YcxRnsIaLQsu9DWJ5ru0pI0CM7HLXWgj
         KSr2w5X57LS2abTMK0S5P3xwBu4pCB6V77Yp1+6eg1AxW9zGynznrsn6Z3oj4bLanja3
         Xb+scDwZUa/JIdncsjvLmIWkOZEYxA7c8M8BJi7xaC1E4Tumj7/Nel2+Jlr81I14jzR/
         f7iiFIeAiSXR5T33ZDi04nf24utfXlLyJlx/q76yq8E4A/85gyE6riPvYiNhrpbnkFLv
         vC3jayW7OvjtkgyHaptyyJ8fW7bqQWNWxJCdHOGd7A0DXUhvsYcvmkY1xwcaj+WZckdi
         n3aQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sHhpcGM44Emb4kB0lpfeBfcO8U7L2NbmNr1Q8LFhqekG6LJLYFCg9UYOdRj2ChJLpsyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjRATxOoDnFYAe+n4tZCLnAMDMRC+8FCuJRRyjpjpxVyo1Rtm
	hMg7auzWFa/UdnWFoi9SVlBFe0nTzxAeRqV0wg1BqJbjXuk4qQX0vSmWI6HLSrTgqyOW3KfW4vk
	zKGDMF989VTCjuhQFGbVJwKuDjOqIXG8=
X-Gm-Gg: AeBDievuSwOEBSv+a6MCPVd88675S+RuHjWNFoKqWGM1m58xmU0Qz+WfJk3kQDKauuX
	Edt3qE1y6Zv/IQGXn33mTTt4XYfn2RHo0Jpd3rzzMzIfiihzlA+JK/WFdk677JW4u5Jds/lLa+F
	hqMKQiR7MAvJVLU4IRvrR5AN90xrjB10lyRSf5D3bKEkLJSG8CRFSH1YzEuCGqKezq9rick+MLL
	TkMnwcSRRI11luScY7Bjvsrxk70Wg3XZqdhNs/Yj9e0YFWZVdepC7up19h3hLLleCpvxBRO/0Wa
	EioRtXee0QlMK/uEjI4iR7e5tddZfV1sbWwGuCharARXLGhVQVVeqds2GgNRYw/So7V2/SiJxzf
	gzVMICSfXLgivBV1GOHoED4Ke4WclXpu9DMdh
X-Received: by 2002:a05:6000:1865:b0:43d:7c0f:b305 with SMTP id
 ffacd0b85a97d-43d7c0fb3e5mr14453435f8f.7.1776230012057; Tue, 14 Apr 2026
 22:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
In-Reply-To: <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 22:13:21 -0700
X-Gm-Features: AQROBzAvHfQ2drH-B9QtOKWVL-NNO1CE8EzwcQtnADN6gZWVdV3XVPXyGK0BiZE
Message-ID: <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 8:27=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Wed, Apr 08, 2026 at 08:10:05AM -0700, Mykyta Yatsenko wrote:
> >
> >       rhashtable: Add rhashtable_walk_enter_from()
>
> Rhashtable walking is strongly discouraged because there is no
> way to provide a consistent walk on a hash table that can be resized
> or rehashed during the walk.
>
> So the question is why do you need to be able to walk through the
> hash table, and do you need consistency guarantees such as walking
> through every entry once and once only?

No need for such guarantees. It's best-effort only.
If the walk skips entries it's fine.
As long as it terminates eventually it's good.
Nothing grabs the locks, so elements are added/deleted in parallel.
