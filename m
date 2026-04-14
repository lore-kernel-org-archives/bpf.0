Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF932222CC
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202744; cv=none; b=OoMeN0LBd5J4qIDh7saukLQo1lnYbiPo7mH5sW/YtbC/U5DmYem0QDZOUk++oZ4JcuCUFB7Gl3gJVUzwaF8mtftohH7vSDwhLdihvbx7mH6FshqnTgKAkN7OCoEAo1052WGPAcgJCq6otZPbSkBqNn+L9uZRp3s3M3rev39EFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202744; c=relaxed/simple;
	bh=M+Br6OSA1taz7IcIfNI2MARPi9t1CpjmTPfh5fY3u7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZg5S57Sqf5fVIoflZ80o0x9URwQtFXg7dt9bP0hMACfE7tY56ts/ZsE0XvqEz5TRiUys8lCPUrar7f2r0GdM+w7VO8ZZ2/R+59RrYFVZlcRiZP1fFkCWeA3RPFSGqQEBjmS2vY8SbTBqx5QcPVSALzdkxUC0zbfbKrGe+VI9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo6QxWEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo6QxWEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FA9C19425;
	Tue, 14 Apr 2026 21:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776202743;
	bh=M+Br6OSA1taz7IcIfNI2MARPi9t1CpjmTPfh5fY3u7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Qo6QxWEgCPhvqnqR6yqbz12TIqsrSi0EWIsAnhauq4vQ+xdJP2MfrgzwOp7A7isSR
	 MqgvpsBCik9JgQUzeL2pMKASR1Zy/hQzhAjurmvlvj2ujUbf3QncPknssvd2smnwMD
	 5Rlu73hg+tFsN6QAcbL5V9Tg3MDnMUYnckNh+DuwfrqYAqxS5d2g16lo5YGKmmjgys
	 XocQ8a/v5hWQTbVWOdSPANGCk3Ep1nD2fzEanJZauNwaU763WrV4WJqB/fjkqvx2EU
	 1IkGh7J7K19f3dUh21qigq0J/UTJdIDk03s7qz9u+E8ZUmXXqIslyJgndNYpmbk98D
	 m6pi3icUgiQtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/6] libbpf: Adjust btf_vlen() to return a
 __u32
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414195019.684531-3-alan.maguire@oracle.com>
References: <20260414195019.684531-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:39:03 +0000
Message-Id: <20260414213903.B2FA9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Expansion of vlen from 16-bit to 24-bit introduces severe O(N^2) c=
omplexity issues in CO-RE relocation matching.
- [High] Lack of bounds checking in `btf_type_inc_vlen` corrupts the BTF ty=
pe kind field upon overflow.
--

commit 05dfc0fce969915cd3d509a4e34a33558181e95d
Author: Alan Maguire <alan.maguire@oracle.com>

    libbpf: Adjust btf_vlen() to return a __u32
   =20
    Now that vlen is 24 bits, btf_vlen() must return a __u32.
    Adjust use cases in libbpf accordingly.

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 0ccc8f548cbaa..6ae3f2a15ad0c 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
[ ... ]
> @@ -1457,8 +1457,8 @@ static bool bpf_core_names_match(const struct btf *=
local_btf, size_t local_name_
>  static int bpf_core_enums_match(const struct btf *local_btf, const struc=
t btf_type *local_t,
>  				const struct btf *targ_btf, const struct btf_type *targ_t)
>  {
> -	__u16 local_vlen =3D btf_vlen(local_t);
> -	__u16 targ_vlen =3D btf_vlen(targ_t);
> +	__u32 local_vlen =3D btf_vlen(local_t);
> +	__u32 targ_vlen =3D btf_vlen(targ_t);
>  	int i, j;

Can this widened vlen boundary create performance issues during CO-RE
relocation?

Looking at bpf_core_enums_match() and bpf_core_composites_match(), they
iterate over both local and target BTF type members using nested loops. With
the previous 16-bit limit, the worst-case was ~4.29 billion iterations. By
expanding vlen to 24 bits (max 16.7 million), the worst-case iterations
expand to ~281 trillion.

Could a crafted BTF payload stall the libbpf parser and consuming user-space
daemons for a significant amount of time?

Since vlen has been expanded to 24 bits, could we also overflow the kind
field when adding elements to a BTF type?

tools/lib/bpf/btf.c:btf_type_inc_vlen() {
	t->info =3D btf_type_info(btf_kind(t), btf_vlen(t) + 1, btf_kflag(t));
}

tools/lib/bpf/libbpf_internal.h:btf_type_info() {
	return (kflag << 31) | (kind << 24) | vlen;
}

If a program dynamically builds a BTF type and exceeds 16,777,215 elements,
vlen reaches 1 << 24. Since the vlen and kind fields are contiguous, does
this mutate the structure's type kind rather than safely rejecting the
overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414195019.6845=
31-1-alan.maguire@oracle.com?part=3D2
