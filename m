Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B549233924
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230724; cv=none; b=IFUeaTlvBDHFE2YAJgzdrmtuN1H6hV1cSdaB6wQknWSjq87QP8HKzX+gharwI0jYTLHEyT3H5gM8tcaLm/EwNFQT3K1pKIl4pFhCE3uoWfwUhx5G1i0v1IjD343afRP5fWROzd0lh16/eyivLoPz6yqFH95goiUtJNSCjL2sPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230724; c=relaxed/simple;
	bh=nxOgNMxLXP8+78+DhmMGi1GFy58/mGhPgIgBvV+wXko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSiMrtE35QX+d5mjpROu4kUpREeDUHbxwj3H3vMbzPmjrsaXemwQiAw71byfwDKAGhfms7Moqn0nNmxJrmkCanPLh/RqroW4Xhl16qPbajA2J1VWcNhBmf2GpsBx5H31kRHu1yAR/2XHYVuAxJgPgUILAxwfEdKDX+jjuwULG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkNm9LnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkNm9LnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0941F000E9;
	Tue, 19 May 2026 22:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779230722;
	bh=6wrbGqg4nYlyV+LVOv6fwhfU5dAT4M/y8QqFyWzxDIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkNm9LnW0JxKotpb9iRGNHHkmjQpARaKPO+6LWqT/qWztK3mD0084dxM/ECtBPoSZ
	 /myRHqqiOW4UBRA2hR6mA9hoItYYt2qu0tRArJ+EzGdwP3WO3+wN00oBRKM10/NjgZ
	 57UAKqws78DHGPYWkS+swkwlX7hBuCRDM5Cs2/jk+JyssdaVYwfm07JbNXp0tQXrD5
	 oUglH1ODemXKAIOBLxmPsSsWfEixpk+XBgH5KmF02qgO0KOqtv1mFlC2/tjKH+k0ui
	 FXnp8P1IEpQOs7zytuPkJvscT3sHVsC+GQizzhnvSf+ME+m/r+m0gRtoZ0dHDvSWBv
	 PLzQQxyox0mDQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 08/12] bpf: Add a few bpf_cgroup_array_*
 helper functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519215841.2984970-9-martin.lau@linux.dev>
References: <20260519215841.2984970-9-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 22:45:21 +0000
Message-Id: <20260519224522.6B0941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] bpf_cgroup_array_copy_to_user() incorrectly returns -ENOSPC when t=
he requested count is zero.

Pre-existing issues:
- [Critical] purge_effective_progs() calculates linear indices that do not =
account for BPF_F_PREORDER physical reordering, leading to Use-After-Free.
--

commit 23e774d89cf8101cef3b2e8789a63f7fb930be02
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Add a few bpf_cgroup_array_* helper functions

This patch adds bpf_cgroup_array_*() helper functions to prepare for
supporting struct_ops maps in the cgroup bpf array. These helpers currently
skip the dummy_bpf_prog, which is the same as the existing behavior.
The callers are changed to use these new helpers as a no-op change.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b5769f5401e64..a033aa479ab6e 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> +static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
> +					 __u32 __user *prog_ids, int cnt,
> +					 enum cgroup_bpf_attach_type atype)
> +{
> +	struct bpf_prog_array_item *item;
> +	int i =3D 0;
> +	u32 id;
> +
> +	for (item =3D array->items; item->prog && i < cnt; item++) {
> +		if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))
> +			continue;
> +		id =3D item->prog->aux->id;
> +		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
> +			return -EFAULT;
> +		i++;
> +	}
> +	return item->prog ? -ENOSPC : 0;
> +}

[Severity: High]
If cnt is 0 (which happens if the attach type only has dummy programs,
causing bpf_cgroup_array_length() to return 0), the loop condition i < cnt
will fail immediately. At this point, item->prog still points to a dummy
program (which is not NULL).

Does this incorrectly return -ENOSPC instead of 0?

If this occurs during __cgroup_bpf_query(), it looks like the entire
syscall could fail with -ENOSPC even when the user provided a large enough
buffer.

[ ... ]

> @@ -1124,7 +1185,7 @@ static void purge_effective_progs(struct cgroup *cg=
rp, struct bpf_prog *prog,
>  				lockdep_is_held(&cgroup_mutex));
> =20
>  		/* Remove the program from the array */
> -		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
> +		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),

[Severity: Critical]
This is a pre-existing issue, but does pos correctly reflect the program's
physical index in the effective array?

When building the effective program array, compute_effective_progs() places
programs with BPF_F_PREORDER at the beginning of the array. However,
purge_effective_progs() calculates pos by sequentially iterating through
the hierarchy's hlists, which does not account for this reordering.

If update_effective_progs() fails (for example, due to OOM) during detach,
purge_effective_progs() is called as a fallback.

With the incorrect pos, could bpf_cgroup_array_delete_safe_at() overwrite
the wrong program with a dummy, leaving the intended program in the
effective array?

Since __cgroup_bpf_detach() subsequently calls bpf_prog_put() on the
detached program, the effective array would be left holding a dangling
pointer to a freed bpf_prog, which could result in a use-after-free when
the cgroup hook runs.

>  			  "Failed to purge a prog from array at index %d", pos);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519215841.2984=
970-1-martin.lau@linux.dev?part=3D8
