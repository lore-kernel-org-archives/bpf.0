Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380810;
	b=vNF4/JQrmtjFtFvO5VVkah7u615Wu+UW8ViGyBYnUnqhdbvqfNwCp7CmqbS4tqQo1D+q
	 0dc0i7+zMdm3lsWoM1uUPFb31DIAaN0FPzGZAj/9uFzJ2wW1Nr9Vxd2tBu/zZKJG19M6P
	 8F1zcHVwA1DaNNbD0UOumEwufJqWR51MdgDoDU0otj3CZjhVy0tenq/YMl4JzyTf+LdCJ
	 uakAeqtvmtZ84F4r2TR77supy2EA2Xko5el5TG8Ap9Cke7NFFdPwDIX27tjFnGIl6YJEP
	 COAuD8R58S9RTuBr77KFYt/5Vq4Zbahq5CFKRonlWz6KqG2Mtpi2g6hWg/6BTOYKcdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380810;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FQf3e6UsUEpoKZxpY2J3bbbHAco+jMTuGTbQVKk++Nk=;
	b=CpWKlFeGY/Z+Fr2/Q+CnYe35QAMEaLJjnIdwESr/RwovnPYrKxsl18pVsSgSjfPLN36+
	 PclmDKeTR4jyyz9WZsgaKkK0i6tfh5lXOz8wBbMBd6uM4ciOYjf9OxU720eGzPTRf9UP1
	 yExUfyi10aHYv6hHSf1CF2hE5xfGvaRabUX/AIhFhaYeFNVOAUxNNljSuH+QA48Vi5D+k
	 LK6NfeqS/KeUfUYLhgx0UKeutFTPGu3eWMmwNLSg1cmJi4SDYfNgCp06z9gd71UIm5nSM
	 e4zU6dvYFnBnzZM6e9z8oQ91YNWq8yP5MZvu4LlwDS+V2JbCOLoMoSWf7EDBM1MMUHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FK/IMJn8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDE606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FK/IMJn8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AD81F00A05;
	Wed, 11 Nov 2026 07:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794380810;
	bh=FQf3e6UsUEpoKZxpY2J3bbbHAco+jMTuGTbQVKk++Nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FK/IMJn8lfConZmyYNjqr6s8gnK4RucS8AaX6gxeTUSZh3DEXrs380qUoGQUL6LPI
	 GD0RleVAlpEqK8vCqu7SSgkTqZbL0D79Cif4lujlP/RGXmu3Tsc47zcqUmZnki00Wt
	 aA9rrA1yZueJRNfMGeUD4Nld855d4B92NGPvPJvk9PA/SPCZDDjG3hwf4FtxM9ZQer
	 67Tq/idVbfs0Iul/gsv/vnR28NDLDrjHKfmDMSGqCr8rHMod9R4yXk1+Uq0kWJYKPq
	 yp+GLRpvwn0Mi+gk8+VI+G7z039O4nzRE9yt+/1I20jpu6WHvDqwOyFwJgTg45/yW2
	 /g2D/bbvuNYLg==
Message-ID: <sashiko-outbox-208494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/bpf: Add bpf_mem_cgroup_memory_events_local() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongfu Li" <hongfu.li@linux.dev>, "Roman Gushchin" <roman.gushchin@linux.dev>, "JP
 Kobryn" <jp.kobryn@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, "Hongfu Li" <lihongfu@kylinos.cn>
In-Reply-To: <20261111-for-bpf_memctl-1111-v1-1-8b56784d9e5a@kylinos.cn>
References: <20261111-for-bpf_memctl-1111-v1-1-8b56784d9e5a@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 07:06:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] mm: out-of-bounds read in bpf_mem_cgroup_memory_events()
  [1]
--

commit 19b0cb61e45dc1f33944548e84f3a699079d3e85
Author: Hongfu Li <lihongfu@kylinos.cn>

mm/bpf: Add bpf_mem_cgroup_memory_events_local() kfunc

This commit adds the bpf_mem_cgroup_memory_events_local() kfunc to allow BPF
programs to read a memory cgroup's local memory event counters.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index d8f579c285600..826f711718dbe 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -133,6 +133,23 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_memory_even=
ts(struct mem_cgroup *memcg,
>  	return atomic_long_read(&memcg->memory_events[event]);
>  }
> =20
> +/**
> + * bpf_mem_cgroup_memory_events_local - Read memory cgroup's local memor=
y event
> + * @memcg: memory cgroup
> + * @event: memory event id
> + *
> + * Return: The current value of the local memory event counter.
> + */
> +__bpf_kfunc unsigned long
> +bpf_mem_cgroup_memory_events_local(struct mem_cgroup *memcg,
> +				   enum memcg_memory_event event)
> +{
> +	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
> +		return (unsigned long)-1;
> +
> +	return atomic_long_read(&memcg->memory_events_local[event]);
> +}

[Severity: Critical]
This problem wasn't introduced by this patch, but in the existing
bpf_mem_cgroup_memory_events() right above [1] (and in the new
bpf_mem_cgroup_memory_events_local() here), can a negative event value pass
the bounds check and read out of bounds of memory_events[]?

mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {
	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);
}

The BPF verifier does not enforce enum bounds on kfunc arguments, so a BPF
program can pass a negative value for event.  If enum memcg_memory_event is=
 a
signed type, event >=3D MEMCG_NR_MEMORY_EVENTS performs a signed comparison=
 that
evaluates to false for negative numbers, indexing before the start of
memcg->memory_events[] and disclosing adjacent kernel memory or crashing on=
 an
unmapped page.  Checking event < 0 || event >=3D MEMCG_NR_MEMORY_EVENTS (or
casting event to unsigned int) would reject negative values.

[1] https://sashiko.dev/#/bug/linux-77d600fe-b74d-4e53-9ee2-707d37cb8052

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-for-bpf_me=
mctl-1111-v1-1-8b56784d9e5a@kylinos.cn?part=3D1
