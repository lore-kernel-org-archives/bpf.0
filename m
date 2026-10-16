Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30A322C88
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117782; cv=none; b=QNvSdRN8g232MPOpGTNv8OWUddij+bXobYaFfIP3AEt315rSChf4udk56fZUoqP8XSnkzX1bb5mEDaLzxrIe6ZVfd1hgQYRyQMQJKn/ZupE6T/7bf6stZsTTEVrVlnMuxhQBcXVwEWs77N5xq3pvNmt9D4sFeVNs3VNMoHvdRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117782; c=relaxed/simple;
	bh=lsxLilNNIzCC8+6prGZ5iKziybvNJHYV+ur5CW1xkAE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PCXFPValMpo8+ROvKLC10bCTVE4Fqo6F3QDu0RALIqTolyP+uf3jbrh9UDTWf+dBF8bzMFNNbZWi5uEXvObZ9Uig7bAVbsq7Ijd9f6Lf5Wv8u/wfdnVGZjNPSwfupw/aRN+2+X1vSiN0tB77nEGs1INXgplUhKAEh6mwTN+09So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsuymDR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsuymDR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6971F000C4;
	Fri, 16 Oct 2026 02:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792117780;
	bh=oTkU132A3n4dehqj2Jd0zmT9IdtWWbVeE8y2gxIGFsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsuymDR5U1nIRUN5efSvvJSomWO+qAzyjdeylyyYgCNhKo05kNtQiWzlOqGDyawRv
	 syMBb/zY4DLYgMO9U+uhga/qrH8gVsd+g5VvKaLvtSY6s0wCuArePJkqnFcjScPjbo
	 o69Gk1SKeYXb2fKub1NT+f4avJjLkAg0+IsQJQypmrlV7MVOduBP0uhzI/TR5FM5Ne
	 wH8o5cV0LsN8OooeB+BCyqPVGgM6IPP/wclCKglMz5VKmKMzh1rmFqGYGW+vpZv0TA
	 MQmwbOibF8N5cuOsM2NdnjF7eUn5bt4LaYJFErkxSk9slMDbeJvYtXNV+yp4cgdVB4
	 2xgTCOIN9Va3g==
Message-ID: <sashiko-outbox-173630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] bpf: Check the helper function is valid in
 get_helper_proto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261016022203.17034-1-artem@trailofbits.com>
References: <20261016022203.17034-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 02:29:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in bpf_tail_call_proto
--

commit f05c559892f9e9f36efa93c44d19d9d526404f49
Author: Jiri Olsa <olsajiri@gmail.com>

bpf: Check the helper function is valid in get_helper_proto

This commit adds a check in check_helper_call() to ensure the helper functi=
on
pointer is not NULL, preventing a verifier bug when config options are disa=
bled.
It also sets the unused tail_call helper function to BPF_PTR_POISON.

Link: https://lore.kernel.org/bpf/20250814200655.945632-1-jolsa@kernel.org

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 9fa984ee076bc..bec8876f12375 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2959,7 +2959,10 @@ EXPORT_SYMBOL_GPL(bpf_event_output);
> =20
>  /* Always built-in helper functions. */
>  const struct bpf_func_proto bpf_tail_call_proto =3D {
> -	.func		=3D NULL,
> +	/* func is unused for tail_call, we set it to pass the
> +	 * get_func_proto check
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem=
's
formatting rules? It seems the opening /* should be on its own line, with t=
he
comment text starting on the next line.

> +	.func		=3D BPF_PTR_POISON,
>  	.gpl_only	=3D false,
>  	.ret_type	=3D RET_VOID,
>  	.arg1_type	=3D ARG_PTR_TO_CTX,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016022203.1703=
4-1-artem@trailofbits.com?part=3D1
