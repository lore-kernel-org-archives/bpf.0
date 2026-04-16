Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC082C21C7
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368196; cv=none; b=XFb0Jf+MlYgQ+lCdft3jQo0XGy8aXQ5ct5TzFrytyBYOEQDdRKreYOY8PDD+W/gEMnub8l5Ur+xFtcyYbe+INsRIyGHc9yXcQTm0oHsU/T1u+2zQD35Dxlo2Dz4CYr6r+CrCOGkoJzwIaiXcOFbsOFAdiwXNFBqG5/UfnBS7avI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368196; c=relaxed/simple;
	bh=vAp2r7S1HRJcm6iegyKfdxvhELqTs3+AMnoUOC9IGxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iiYmh/MoZG2wRMUhXnb+yg8zxgxErxZ5sPb4ADHj6tEOZXj+Moh7Iol1bRq+0+YAJd7e0dWNRX+lcc3YrV+foYKv1XmybGiuzav+QRx3zhswy9JWkq78vEqbmSGhFO7nMTg5QdRLqDPMzTcFOGoSKOK2qvNCrGcdEkT/BDy8k4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3zHhfd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3zHhfd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33459C2BCB0;
	Thu, 16 Apr 2026 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776368196;
	bh=vAp2r7S1HRJcm6iegyKfdxvhELqTs3+AMnoUOC9IGxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=S3zHhfd8I864lUwR7DXIoxVnUUHlw+KjOzDXLfgwtzkCYKvQfTCShR3ayOW1nFPfV
	 32GSTKQnQxa+LA8ZaNnS0l6lDhWfDtie482PIVxKyl9RrgSieQZoSGim0oFzdQ3vdF
	 R1z988kbiup9YvL7Oddbo3AC1c04iZQ6tkug8iLE3gXoqAOuNXXf3JFOjgyQoO/0Au
	 jIBCDc9Mv9M7tNMwFqB6nYQBWvyInZxsDU9CI1o1+ao3NrH21zKPVIent5PfOkntw5
	 zY3zPxEUYvPX/m1DVp2iXNgsGb4UTjyCxeuRMj+Iy6w8EawbctFW+Ou3bNWMSTHsPu
	 xJbUzYjiNyeMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 2/8] libbpf: Adjust btf_vlen() to return a
 __u32
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416143904.1220662-3-alan.maguire@oracle.com>
References: <20260416143904.1220662-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:36:35 +0000
Message-Id: <20260416193636.33459C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] btf__add_field() manually increments vlen without checking for BTF=
_MAX_VLEN overflow, leading to silent BTF type corruption.
--

commit bc2a5650478dca79064a34b0022bfd5fa6e2da77
Author: Alan Maguire <alan.maguire@oracle.com>

    libbpf: Adjust btf_vlen() to return a __u32
   =20
    Now that vlen is 24 bits, btf_vlen() must return a __u32.
    Adjust use cases in libbpf accordingly.  Also add error
    handling to avoid vlen overflow in btf_type_inc_vlen().

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
[ ... ]
> @@ -2121,9 +2121,12 @@ static void *btf_add_type_mem(struct btf *btf, siz=
e_t add_sz)
>  			      btf->hdr.type_len, UINT_MAX, add_sz);
>  }
> =20
> -static void btf_type_inc_vlen(struct btf_type *t)
> +static int btf_type_inc_vlen(struct btf_type *t)
>  {
> +	if (btf_vlen(t) =3D=3D BTF_MAX_VLEN)
> +		return -ENOSPC;
>  	t->info =3D btf_type_info(btf_kind(t), btf_vlen(t) + 1, btf_kflag(t));
> +	return 0;
>  }

Does btf__add_field() also need to check for BTF_MAX_VLEN overflow?

It looks like btf__add_field() manually increments the length without using
btf_type_inc_vlen() to preserve the kflag:

	t =3D btf_last_type(btf);
	/* update parent type's vlen and kflag */
	t->info =3D btf_type_info(btf_kind(t), btf_vlen(t) + 1, is_bitfield || btf=
_kflag(t));

If a struct or union exceeds the maximum number of members, could this
increment overflow into the kind bits and corrupt the BTF type boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416143904.1220=
662-1-alan.maguire@oracle.com?part=3D2
