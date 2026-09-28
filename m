Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423B34E74D
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592099; cv=none; b=M69rHdx7dQ3Abq5oecpxboYj/HZAN1efzJQe4ZnhEIaOuJ4ajxxzD4dG4KzXfi8DxnDFSa7HHjLHYzMjykXpCtx/0NjKpVciec9BAXs/mI5igWXvyn/s9ZC4aGOLU850sHxjXIYOywoUxDCxxoYoJNYAfn+LHpcQ7FKsDoVqFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592099; c=relaxed/simple;
	bh=u0GqmKtUH48e8WP+nkWYgRMm+S1GGNjZEpnVLGJg1mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cvwAwhcQRy3wG5pnDSisSjBFwWrzBDtam/MVLBo/5ZSlktJ9hVwdkgigFyBAQ/qBPnOqwt7nbAT3kEltc853Bcc5GJBaCiLin+k3byNTYQvgv/yTRJOy3emzPK36c+CNM+e5o07WSlw7h4bUb+6Nqxg3eZDUOtg7wi8SY6Zvg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxEUf4JZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxEUf4JZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9601F000FF;
	Mon, 28 Sep 2026 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790592097;
	bh=ayJL84Kfhf2rJg1fHgjwE28Gscg+JEb546DirfK8U34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NxEUf4JZVvFXZMBtsLkWl9T7awO3BlnD1GRr3/d1Vxzf+VQVxqW1F2Yd0iBgaRP+Q
	 dEHFGyQj13BPtx0EswVq5CmDdtvwuADc8633D15UScw0Zh9TSyqYwQalWwGu48FS0J
	 U/d6NbYJhNVd+lGB7aExJ1iY7ELGxZtpnll99fRzy0ldgNtXDQjYGobq3mG8mAz2HD
	 muhw4d0B3Z+xwTUzViXk91Cj7JKUfDstLhUNS8e+QWCoPum1+0bJjNWdk0nzIb5QtR
	 XNKbXFYdfwcCbJpggqHVUnMMvEc2bDljoDrUfZb8PGCrvqGpeB5LGUD3+NAOodRP8Y
	 iCJOlRQIjNvZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bpf: Fix incorrect handling of user flags by percpu
 map updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Masoud Aghasi" <maghasi@disroot.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928102821.995214-2-maghasi@disroot.org>
References: <20260928102821.995214-1-maghasi@disroot.org>
 <20260928102821.995214-2-maghasi@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 10:41:36 +0000
Message-Id: <20260928104137.2B9601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: bpf_percpu_array_update() misses validation for mutually exclu=
sive flags
--

commit 41d85d3576867a24ad9b52f72cd4c1d7b23504a6
Author: Masoud Aghasi <maghasi@disroot.org>

bpf: Fix incorrect handling of user flags by percpu map updates

This commit fixes incorrect handling of BPF_EXIST, BPF_NOEXIST, BPF_F_CPU,
and BPF_F_ALL_CPUS flag combinations in BPF_MAP_TYPE_PERCPU_HASH and
BPF_MAP_TYPE_PERCPU_ARRAY map updates.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 0ce26b538075e..463f43b19e5cd 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -438,7 +438,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void=
 *key, void *value,
>  	u32 size;
>  	int cpu, off =3D 0;
> =20
> -	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPU=
S))
> +	if (unlikely((u32)map_flags & ~(BPF_EXIST | BPF_NOEXIST | BPF_F_CPU | B=
PF_F_ALL_CPUS)))
>  		/* unknown flags */
>  		return -EINVAL;
> =20
> @@ -446,7 +446,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void=
 *key, void *value,
>  		/* all elements were pre-allocated, cannot insert a new one */
>  		return -E2BIG;
> =20
> -	if (unlikely(map_flags =3D=3D BPF_NOEXIST))
> +	if (unlikely(map_flags & BPF_NOEXIST))

[Severity: Low]
Does this validation correctly handle the case where both BPF_EXIST and
BPF_NOEXIST are passed together?

Since the mask check above allows this mutually exclusive combination throu=
gh,
evaluating `map_flags & BPF_NOEXIST` as true here will return -EEXIST inste=
ad
of the expected -EINVAL error code. Should an explicit check for the=20
combination of BPF_EXIST and BPF_NOEXIST be added here, similar to the one
added for hash maps in htab_map_check_update_flags() in this same patch?

>  		/* all elements already exist */
>  		return -EEXIST;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928102821.9952=
14-1-maghasi@disroot.org?part=3D1
