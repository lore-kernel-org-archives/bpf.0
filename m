Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEFD415F22
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576888; cv=none; b=A6MvJvYIJ6/5o0QYVhAJ8VMsulYwmmcvopkgnqYUcvH3/E0LSSucYrIfbwNxTyb2g8YgPEHb25sphHr3utv6AbSIemcRbuqJm7cE+DRQkr3nPaHEkRO0dpuxZrH+32vqEE5F8Cqn36fVdMaORf4Lf116A9DW0v3KL9whLe8mG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576888; c=relaxed/simple;
	bh=qO+nkpzzNr9bzpu0Uj9zT6L4H3UWMK4DHmn5pYmoBHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RikCxoNfPeyjlKLTKVWACf5zzMYQ89pPEzKfEChfLaC4ZNkefpxWzlJpGdxWU/fWs/4TT9t+3TUHEriNqzBt4I/CxpDFMXbOQ7LHmQ66qvevI5AnY0iQuHL5TKH920/eRiDRJjRJsmDF5P9dapWi0hJn1eOEK16B4B8jTewWQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqyPSstG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqyPSstG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B591F000E9;
	Mon, 24 Aug 2026 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787576886;
	bh=tK+xgnlFdVlPIr7JXIcW65vEn30RRH2pE3VvoDzMn/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqyPSstGbTlFo192apJxn/r/nEjr+opMU+/5kTCRZhEtcS86T1swENaVDOmV57k5c
	 i9o0+myiptSe5XU+1huvUN4/7PXPFIKFxMpyqsPNAyNULnJo4u8Whpg9SvUeCeHhYY
	 +KG50DhLHdZbhwXYcmm+Li6hq63GHkpd/gd3F9MKQf6Qs+z4TA+zyG4vkaYjYYFngj
	 vLtyWVDljIspD18aMd9KKE8fCVNlHJQ/WSBuQgk5yayd/7U4phXQusZBXKOXrgEDXZ
	 uDe2gEIUf4lKx8XcR9v9HE6vd42h517MkgElrXYk52UlDRWSnsfFC1kFCRkU4NPQ/h
	 9PmqDqmklEHwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824125310.1384-2-zhaofuyu@vivo.com>
References: <20260824125310.1384-1-zhaofuyu@vivo.com>
 <20260824125310.1384-2-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:08:05 +0000
Message-Id: <20260824130806.51B591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Failure to short-circuit BTF loading when the requested module l=
ist is empty.
--

--- Patch [1]: [PATCH bpf-next v4 1/2] libbpf: support selective kernel mod=
ule BTF loading via bpf_object_open_opts ---
commit 45ee1cea8b0fa604bfa594a065030f18301877c5
Author: Fuyu Zhao <zhaofuyu@vivo.com>

libbpf: support selective kernel module BTF loading via bpf_object_open_opts

This commit adds btf_module_names and nr_btf_module_names to
bpf_object_open_opts, allowing selective loading of kernel module BTFs. Whe=
n a
list is provided, libbpf will skip module BTFs not in the list to reduce BPF
object loading time.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee0..d8ef6ecc6f5dd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5851,6 +5854,94 @@ int bpf_core_add_cands(struct bpf_core_cand *local=
_cand,

[ ... ]

> +static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
> +{
> +	return obj->btf_module_names &&
> +	       obj->nr_btf_module_names =3D=3D obj->btf_module_cnt;
> +}
> +
>  static int load_module_btfs(struct bpf_object *obj)
>  {

[Severity: Medium]
Could we short-circuit this function earlier when the requested module list=
 is
empty?

If a user passes a non-NULL btf_module_names with nr_btf_module_names =3D 0
(meaning no module BTFs should be loaded), this function still proceeds into
the while (true) loop, issuing system calls for every BTF object on the
system.

[ ... ]

> @@ -5915,6 +6006,11 @@ static int load_module_btfs(struct bpf_object *obj)
>  			continue;
>  		}
> =20
> +		if (!is_module_btf_needed(obj, name)) {
> +			close(fd);
> +			continue;
> +		}
> +

[Severity: Medium]
Does this continue bypass the early exit check when nr_btf_module_names is =
0?

When the requested list is empty, is_module_btf_needed() always returns fal=
se,
triggering this continue on every iteration. This skips the
all_needed_module_btfs_loaded() check at the bottom of the loop entirely,
causing the loop to exhaustively iterate all BTFs unnecessarily.

>  		btf =3D btf_get_from_fd(fd, obj->btf_vmlinux);
>  		err =3D libbpf_get_error(btf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125310.1384=
-1-zhaofuyu@vivo.com?part=3D1
