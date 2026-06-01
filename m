Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6743DA7F8
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327093; cv=none; b=lPNitCwaFUySx6RuqFrJECEp4spvh8V83FjNPOMCSW/fwncF6mp7dEbFbZvaGQ5l535G8LaELQChp2KHRHP9ZdVlaDCu8hlhYdXlC+EGac8QqqFOj1ag68O5UuRR9a7t8m5NXgfjKu6RqhOFBGkx8qOhu8Tc5O9cFcP1hc+vkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327093; c=relaxed/simple;
	bh=cDh6l7Is6S329yS7GAHsLnYONeADZnUGckriUzKIPT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g01fOSgfzc3rqUxmmq3BMmwR191ePq4Hms1CeTTG3xDYG0zkG2FxVLcE+GsVU9pWRLCURiyV6XuWZrZQSfGLS1SFfdgMozBGTd1yRRaPzOTefzNgNhyeQe/lRgeAQH7gYoAi2Gti97D342kab2V3aK8Lp0ZeAVsvGXhIN9uxDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emgk7B87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emgk7B87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BCF1F00893;
	Mon,  1 Jun 2026 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780327090;
	bh=KqHwW6W0G5k8593E/bHp92tAsgJ78bDjKHYF63+A0fA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=emgk7B87zUGYiFzO8asfiE9i6nArbPfANCU3PLsvTRPJjryvgDY6JsOl5d240JBoC
	 SqZQd4HEDBGDg1oSz+AM16QK1DYMaL7FoYYT0K75YbPoMqXS8WQdE6/5QcMhK8UjaK
	 fAOxESyXk/VVu2CAg5H448ACkH6rqUrgcQbsW9yBkwDnR57IKhxoMIEcUCs/L00LqS
	 CQj962uk73P4mipZfIwH+W5fLHTLHg53q6dSuw4fdoVRUMR3GhBRHF0HAOUPIfOa1K
	 crOln7MSxpe8YAg7c631q4Xp+6Ws+wwR5aq2XeX0MJ5n7un2fWrrBtvyUCQmkr3+Fa
	 EBRHV3tdJrZbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Reject exclusive maps as inner
 maps in map-in-map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601150248.394863-2-daniel@iogearbox.net>
References: <20260601150248.394863-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 15:18:09 +0000
Message-Id: <20260601151810.68BCF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] BPF iterators bypass map exclusivity (`excl_prog_sha`) and map=
 freezing (`map->frozen`) protections, allowing arbitrary modification of s=
ecure maps.
--

commit 94f0db1114c682145008741a58e7ea931a088e25
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Reject exclusive maps as inner maps in map-in-map

This commit prevents an exclusive map from being inserted into a
map-of-maps. This addresses an issue where unrelated programs could
bypass exclusivity guarantees by accessing the map at runtime.

> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 645bd30bc9a9d..d2cbab4bdf644 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -20,7 +20,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>  	/* Does not support >1 level map-in-map */
>  	if (inner_map->inner_map_meta)
>  		return ERR_PTR(-EINVAL);
> -
> +	if (inner_map->excl_prog_sha)
> +		return ERR_PTR(-ENOTSUPP);

[Severity: Critical]
This is a pre-existing issue, but while this patch closes the map-in-map
bypass for exclusive maps, does a similar bypass still exist through BPF
iterators?

Looking at bpf_iter_attach_map() in kernel/bpf/map_iter.c, when a BPF map
iterator is attached via BPF_LINK_CREATE:

	map =3D bpf_map_get_with_uref(linfo->map.map_fd);
	if (IS_ERR(map))
		return PTR_ERR(map);

// [...]

	if (key_acc_size > key_size || value_acc_size > value_size) {
		err =3D -EACCES;
		goto put_map;
	}

This function retrieves the target map but appears to lack checks against
map->excl_prog_sha, map->frozen, and BPF_F_RDONLY_PROG.

Furthermore, the iterator context defined in bpf_map_elem_reg_info() sets
up the value argument without the MEM_RDONLY flag:

		{ offsetof(struct bpf_iter__bpf_map_elem, value),
		  PTR_TO_BUF | PTR_MAYBE_NULL },

Because MEM_RDONLY is omitted, the verifier permits BPF programs to perform
direct memory writes to ctx->value.

Could this allow a program to locate the FD of an exclusive, frozen map via
its ID, attach a custom BPF map iterator, and arbitrarily overwrite the
contents of the protected map?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601150248.3948=
63-1-daniel@iogearbox.net?part=3D1
