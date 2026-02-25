Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B638F955
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047907; cv=none; b=dIuhl43IrlEvFc8u3Rjv76IvOS5hlpqXIxpinp3Pj8v46yC3QbqxNkzlyUDyVVaYAoTdBkImd/mm36rVrv6j9AdNqPmF3kmXPmu6jcoxYgyieqLh/ead9WG6YstCK7h67Amw12xd3iIvCaZGZogqdbqA0lkutwBHmiWxxwtWzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047907; c=relaxed/simple;
	bh=M5vspAADnKD+PryBDq8V3PBIhucdgOKDl8XLKWFlNXY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Us/KzDuVH0cEqGVVBRgMVrHiUiB0eOWSfL5P393NDchplJo2bEVP1k59VXUMd06ZcA/HstcDtMwgNUKnFr0Zwjpelq43Q0uKJ0OJSxXypGwLN/Ytr7gK7tX+YObg/uXrg1q38i13zShqwHiOPpUZ1Lq1ImIm8M0UvNmeKrG4wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC8TZwKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC8TZwKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8656AC116D0;
	Wed, 25 Feb 2026 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772047906;
	bh=M5vspAADnKD+PryBDq8V3PBIhucdgOKDl8XLKWFlNXY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MC8TZwKD8yoyRT9CryhFv7Y53To4xg5OKWAeEL/1tAkYXy34dqHQpDY/d5bb4VGlL
	 vWjTIiBE3O3cTAVB4vUGHbHEqZlUc/+bDUw8+TYfE8OmrhAk81C6UZh/ZR2Pg+tYIe
	 DNnnXr7vEp4sjWeV8EBdmNgPtCosck+M86XuykSb5a32791o4PyhWSrnYt7Eb35ZOP
	 1YMSc0ua8sH6Jnm0AcUz/VmC9XXanFbabHfJ2lhEywAZgqJfp+pZMaFUXRLxYeF1Ey
	 0qjzyCQqHfG7nzJm2fxcvtzXMwnY1nfIbXicToni7/Of7XHMmkDbD4wY4tS6w4N+md
	 iJqD7P36qFitg==
Content-Type: multipart/mixed; boundary="===============0610971924005731258=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa7bb05738258324a4278d62e2abc58a603819587903a6a992157f999331732c@mail.kernel.org>
In-Reply-To: <20260225185121.2057388-3-memxor@gmail.com>
References: <20260225185121.2057388-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Delay freeing fields in local storage
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yatsenko@meta.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 19:31:45 +0000 (UTC)

--===============0610971924005731258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index b28f07d3a0db..0825a92dcd6d 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> +/* rcu callback for use_kmalloc_nolock == false */
> +static void __bpf_selem_free_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_local_storage_elem *selem;
> +
> +	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> +	/* bpf_selem_unlink_nofail may have already cleared smap and freed fields. */
> +	if (SDATA(selem)->smap)
> +		bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
> +	kfree(selem);
> +}

The smap field is declared __rcu in struct bpf_local_storage_data:

    struct bpf_local_storage_map __rcu *smap;

Should this use rcu_dereference_check() to be consistent with the
existing pattern in bpf_selem_free_rcu()?

    smap = rcu_dereference_check(SDATA(selem)->smap, 1);
    if (smap)
            bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);

As written, the pointer is loaded from memory twice (once for the if
check and once for the dereference) without READ_ONCE or a local
variable, and sparse would flag the direct access to an __rcu pointer.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22411606914

AI-authorship-score: low
AI-authorship-explanation: Focused, technically precise RCU bug fix by a well-known BPF maintainer showing deep subsystem expertise.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing rcu_dereference_check() for __rcu pointer access causes sparse warnings and double-loads the pointer, but no concurrent writer exists at callback time so functional impact is minimal.

--===============0610971924005731258==--
