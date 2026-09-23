Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599C3C65FD
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191446; cv=none; b=j4pQrZQMH8KSk4N8/ALM1WtK2skEj4dCEQFhnodGsaV2ziP8T/NkPHadELlbMEvytwon76K1F830BZ7eNPEFMz8wWMdN5SDLC+jA5KEE9UvG2n583s2BD6Dz2VUYGZpNz0gYEQF1nJrwa7/JaskZ6PBWNLVDuuI6qVvJ+DWcqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191446; c=relaxed/simple;
	bh=kNRhbnrvGd7D0T/Lk0PIDt5nOm1cOQBNOrkTKp5CTTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lEVw1/MzoRSj+ZFj9TkcyssYTrUbpkscII+pAd1csyyJbluYL4YaL8F3ZIfPEp3HRLFt8y7GfcqDWYQbKwMGckMrSjz8iM6kVmPHqRB7rpVwGuMn7GAt9D2uOVXtyz02cP4V+3dOVVA+nH1g/OGb69+ykdSpnHX4s4ysfTqTtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKdgbAJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKdgbAJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7E21F000FF;
	Wed, 23 Sep 2026 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790191445;
	bh=RDo3d8Bv4XWXqY/q68g1PTszqPJCtX2rXWIVshxWlA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKdgbAJiHdYRRb3/rpVk/2S1b88tgob8Q3g4wPNhQiM3k8QQyXoVCjolddraQ08ID
	 K+JOzOj2cXFKBbRjM8+ZAazJJ/uHMfGhhYGv45KKP+PDBRQEwuX4siGtBadTvX9kmI
	 GEvbZl551JKw/ygEf6wZW1GpZUovATMq5+aFDiP19g1qA+KjlQMYAj+fEKDngufAQF
	 5qk1ZwmJiH59rN/4ny8lrRUoY4jHtyH9uod+1Lo2jSNfIjTC7oyDB9s0BQF68uWeEH
	 4La7dExbhNPNzxHqwHwUMKYsBfpUB3CP5EXjpN4DMk+ARIKnPNvoft4/V8oAx32vB4
	 hvJCr6IDERIvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 08/18] bpf: Grow the verifier id scratch on
 demand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923191139.2816206-9-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
 <20260923191139.2816206-9-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 19:24:04 +0000
Message-Id: <20260923192404.EE7E21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: OOM in release_reference() triggers WARN_ON_ONCE and is imp=
roperly ignored in unmark_stack_slots_iter()
--

commit bdefbd593b54c82f98de0288f1f6f5e793ee9fbb
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Grow the verifier id scratch on demand

The id map used to compare the ids of two states, which also serves as
the id stack of release_reference() and as the id set of
bpf_clear_singular_ids(), is a fixed array embedded in struct
bpf_verifier_env and sized for the most registers and stack slots a
state can possibly hold. Turn the map and the set into arrays grown on
demand, starting at 64 entries and doubling, and free them with the env.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d8f43f3a89912..8641f1a8d017d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10136,8 +10136,9 @@ static int idstack_push(struct bpf_idmap *idmap, =
u32 id)
>  		if (idmap->map[i].old =3D=3D id)
>  			return 0;
> =20
> -	if (WARN_ON_ONCE(idmap->cnt >=3D BPF_ID_MAP_SIZE))
> -		return -EFAULT;
> +	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->c=
nt,
> +				    sizeof(*idmap->map)))
> +		return -ENOMEM;

[Severity: Medium]
With this change, idstack_push() can return -ENOMEM on a normal allocation
failure, which propagates up through release_reference().

However, in kernel/bpf/verifier.c:unmark_stack_slots_iter(), we have:

	for (i =3D 0; i < nr_slots; i++) {
		struct bpf_stack_state *slot =3D bpf_stack_slot(state, spi - i);
		struct bpf_reg_state *st =3D &slot->spilled_ptr;

		if (i =3D=3D 0)
			WARN_ON_ONCE(release_reference(env, st->id));

Does this mean a simple -ENOMEM during verification will trigger this
WARN_ON_ONCE splat? Since release_reference() can now legitimately fail und=
er
memory pressure, should this warning be removed, and should the -ENOMEM err=
or
be properly propagated here instead of discarded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923191139.2816=
206-1-memxor@gmail.com?part=3D8
