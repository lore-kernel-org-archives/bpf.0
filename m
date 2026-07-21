Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2340BCDA
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618278; cv=none; b=jhOjZ+/EIXwz/ydNzWWgLTtHVQ3sEYkjkRBI7HYgtS3EJ/lxlIDCi3F2KM69j1DE0Up6bJ+3P2J6sYpvyBy1zSx0lRmN7PFzSVqh21JFXV+8Q/PKQcdxf0NYtDOvbKU/PUazD491AE7h3+L1S8eyVD3hGu6Tu7/JZONxlF9o92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618278; c=relaxed/simple;
	bh=XbTPdkn2OHcjRJx0PXPNb3qicuhW/0JBtCfLEhVL0Y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qrj/k3SFnT/c43FEQ4Z0zjB9bwfPkA5ffNoR9J3vAaMJG6IYioBYlT276UNCzeHu4FhmvsqPWiPXNlAKTOWYiRp/+YLWtitUB3hwZCZT4RuuBVaZQxdRif/OiT7PAd/z/+ciuVJeBzZsJZCTc9FunhMLR8faOLAakhvZFclt9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjtgujxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjtgujxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEDA1F00A3A;
	Tue, 21 Jul 2026 07:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618276;
	bh=YkOlNdxhCh8Pfnc01Q+NIhinab1Gl6a0Obo1O2Zbs60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bjtgujxHSuiNM03GcGaAuWGimdI5eExyTtvjis4XUpiD+RGne685Cd4aTOhIwHsVz
	 Ri8rgDpvGwYRWcGnmU3pO+ThHzCrmuFoUtOc4Y5qqmHZeZq/LbgtdhsZwMJis2L5av
	 9Ku8FmOVFoMRQ50BsrHlbsk8OqIq/DOAZwcqzyrhr3wkHJFFKqr3BwSTzdMy7H2Bha
	 DTApi6QKWd1EPJotn4h0k86dwbHU8CrYyNbE1k7yJwjGOy/INN6OR2+rpiK9QIl8Md
	 p5XIn3SPrmU9EoFu74bWHhE29scOPYn8zjJd/nhEXqitJZjmgx3hpVgcOe0W8WIIBC
	 /RxtsX7FeMtsg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 05/13] bpf: offload: allow PERCPU_ARRAY
 maps for offloaded programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260719175857.4071636-6-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-6-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:17:56 +0000
Message-Id: <20260721071756.AEEDA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Permitting BPF_MAP_TYPE_PERCPU_ARRAY on the offload path introduce=
s a kernel heap buffer overflow (OOB write) and an uninitialized memory lea=
k during map lookups, because the offload driver API lacks the `flags` para=
meter required to determine the `value` buffer size.
- [Medium] User-triggerable WARN_ON in netdevsim driver when attempting to =
allocate an offloaded PERCPU_ARRAY map.

Pre-existing issues:
- [High] NULL pointer dereference in `prepare_seq_file` for offloaded maps =
due to incomplete `bpf_map_offload_ops`.
--

--- Patch [5]: [RFC PATCH net-next 05/13] bpf: offload: allow PERCPU_ARRAY =
maps for offloaded programs ---
commit 48af783b3fca05c679c6224bf05a40782d3679ed
Author: Taehee Yoo <ap420073@gmail.com>

bpf: offload: allow PERCPU_ARRAY maps for offloaded programs

The knod BPF offload keeps hot per-CPU statistics in a PERCPU_ARRAY
map that is mirrored into accelerator memory and aggregated back on the
host.  Permit this map type on the offload path.

> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 0d6f5569588c3..36e747a12cbe7 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -510,7 +510,8 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_a=
ttr *attr)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return ERR_PTR(-EPERM);
>  	if (attr->map_type !=3D BPF_MAP_TYPE_ARRAY &&
> -	    attr->map_type !=3D BPF_MAP_TYPE_HASH)
> +	    attr->map_type !=3D BPF_MAP_TYPE_HASH &&
> +	    attr->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)

[Severity: Medium]
Does this change trigger a WARN_ON in the netdevsim driver?

Looking at nsim_bpf_map_alloc() in drivers/net/netdevsim/bpf.c, there is an
explicit check that will panic if panic_on_warn is set:

drivers/net/netdevsim/bpf.c:nsim_bpf_map_alloc() {
    if (WARN_ON(offmap->map.map_type !=3D BPF_MAP_TYPE_ARRAY &&
                offmap->map.map_type !=3D BPF_MAP_TYPE_HASH))
        return -EINVAL;
}

Since BPF_MAP_TYPE_PERCPU_ARRAY is now allowed, could this assertion be hit
when creating an offloaded PERCPU_ARRAY map on a netdevsim device?


[Severity: High]
Can this lead to a buffer overflow or uninitialized memory disclosure during
map lookups?

When user-space calls bpf(BPF_MAP_LOOKUP_ELEM) on a PERCPU_ARRAY,
map_lookup_elem() dynamically allocates the value buffer size based on
whether BPF_F_CPU is passed:

kernel/bpf/syscall.c:map_lookup_elem() {
    ...
    value_size =3D bpf_map_value_size(map, attr->flags);
    err =3D -ENOMEM;
    value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
    ...
}

However, bpf_map_offload_lookup_elem() drops the flags argument entirely
when calling the driver's hook:

kernel/bpf/offload.c:bpf_map_offload_lookup_elem() {
    int bpf_map_offload_lookup_elem(struct bpf_map *map, void *key,
                                    void *value)
    {
        struct bpf_offloaded_map *offmap =3D map_to_offmap(map);
    ...
}

If a user specifies BPF_F_CPU, the allocated buffer is small. If the driver
returns full per-CPU data, could it overwrite the buffer? Alternatively, if
no flag is passed but the driver only returns one element, could the rest
of the uninitialized buffer be copied to user-space?


[Severity: High]
This isn't a bug introduced by this patch, but does allowing PERCPU_ARRAY
(as well as existing ARRAY and HASH maps) expose a NULL pointer dereference
in the BPF iterator code?

When calling open() on a BPF iterator file descriptor for an offloaded map,
prepare_seq_file() executes:

kernel/bpf/bpf_iter.c:prepare_seq_file() {
    const struct bpf_iter_seq_info *seq_info =3D __get_seq_info(link);
    ...
    total_priv_dsize =3D offsetof(struct bpf_iter_priv_data, target_private=
) +
                       seq_info->seq_priv_size;
    ...
}

Because bpf_map_offload_ops does not implement .iter_seq_info,
__get_seq_info() returns NULL:

kernel/bpf/bpf_iter.c:__get_seq_info() {
    if (link->aux.map) {
        seq_info =3D link->aux.map->ops->iter_seq_info;
        if (seq_info)
            return seq_info;
    }
    return link->tinfo->reg_info->seq_info;
}

Will this result in a direct NULL pointer dereference when accessing
seq_info->seq_priv_size since both sources of seq_info are NULL for
offloaded maps?

>  		return ERR_PTR(-EINVAL);
> =20
>  	offmap =3D bpf_map_area_alloc(sizeof(*offmap), NUMA_NO_NODE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D5
