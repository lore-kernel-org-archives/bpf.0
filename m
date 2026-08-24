Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442BD339362
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583645; cv=none; b=Rd/RyJNCH2ISBzs+4xOHryGMstAxWPwuEL+/2PyrkQsHkfyd6qkZBRmpNcF7Lg07oynEAglz1jaUhfI3PjnVthOV6upyudM9d3HYpe47QcgYESrA5x2kAWim/vfIyGW3kscuUWavIjxSW6lBJ/J9FDmj7ffqOqUlT1pNK0x9zoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583645; c=relaxed/simple;
	bh=id191i0KsmpcpNYBhEN4ILrWyfgvmRAHjZXynQ2dnRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FS1+LkZho1vS1MdzS1C63HZ947dJJH1b8cVh2kHOK4tGZUb0DIRBkbiDBsPmUmDl/LFxLqgDBr2qFrtoYIuTADtVp5zTWhFgj80rEQaLox9b9CHM4O1IPSlYofJQJBOzo8PYjsA1KxCXyNW3ZwfeRYAOqKtYC/G+3iKcYExDbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm4eqepQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm4eqepQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00701F000E9;
	Mon, 24 Aug 2026 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583644;
	bh=Ao/KUwXVEEifOBaLSuCwJ/oUeqeWJ7zjGTItZA9lVfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qm4eqepQ4NBt9ppBQl9JDZ1ZaNBEolN+vM+rU8xZDkIgFS2F8rTABRQ7DS3DjKGRv
	 p/+M/d6WG8R29TkabwPmjJtXZ8jtZ6szvfb2VGIv3USuJGLmwum/rfo/CWzb188BdK
	 b4liWYWkgmZTY7w43E1xRDmWw+nxfrqzSqYoPI20W/WlIsfoQgNx/kd8i0dXzW50BX
	 jkYs+bJNLEpXhI2S2Qw7FOshKt4QjtOnhLgq/pnLqHelmyCQ/RUFhFIjAHlQ8g71Io
	 yf0OB/jdGBnRDSpzHwkLJzYbqcGCfuJcUVF3HCUYLKsmnfsa1IMxJg3ZPbDF06/X17
	 FbaltPV7pUxFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] bpf: Cancel special fields in resizable hashtab on
 recycle
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824143621.2098856-2-chenyuan_fl@163.com>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
 <20260824143621.2098856-1-chenyuan_fl@163.com>
 <20260824143621.2098856-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:00:43 +0000
Message-Id: <20260824150043.E00701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `bpf_obj_free_fields()` in map updates, directly violati=
ng BPF-001 guidelines.
--

--- Patch [1]: [PATCH 1/4] bpf: Cancel special fields in resizable hashtab =
on recycle ---
commit 6f12e4dc235993c2415d956e168783cb133ed13a
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf: Cancel special fields in resizable hashtab on recycle

This commit updates the resizable hashtab recycle paths to cancel only
NMI-safe fields instead of fully freeing all fields. This is intended to
prevent kptr destructors from running in NMI contexts during map updates or
deletions, delaying their destruction until the element is actually freed.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -3022,10 +3064,11 @@ static long rhtab_map_update_existing(struct bpf_=
map *map, struct rhtab_elem *el
>  	 * BPF_F_LOCK, matching arraymap semantics.
>  	 *
>  	 * copy_map_value() skips special-field offsets, so old timers/
> -	 * kptrs/etc. still sit in the slot. Cancel them after the copy
> -	 * to match arraymap's update semantics.
> +	 * kptrs/etc. still sit in the slot. Cancel the NMI-safe ones after
> +	 * the copy to match arraymap's update semantics; referenced kptrs
> +	 * stay attached and are destroyed by rhtab_mem_dtor().
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	rhtab_cancel_fields(rhtab, elem);

[Severity: Medium]
Does this bypass the required resource cleanup for overwritten map values?

The BPF subsystem guidelines mandate that when overwriting an existing map
value using copy_map_value(), bpf_obj_free_fields() must be called to relea=
se
resources held by the old value before or after the copy overwrites them.

Since rhtab_cancel_fields() is used here instead of bpf_obj_free_fields(),
could this leak kptrs or other resources when the old value is overwritten
during a map update?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824143621.2098=
856-1-chenyuan_fl@163.com?part=3D1
