Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF4C3DB99C
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327778; cv=none; b=dPdb9c9kYI6JsqFPOT70ZvgmWX5+MvgKWr65GGkmZTtfKH21QM9Mu+R8PkFq7Rr0DVrNKg+G8As0hgVh8pFiVbaJNXLaVpbB8kEw3vTrkY/Ww87uzH8eDWViaL7aW49ixzRmhONnOw7c4z5SF2HE+7sQa6MlqAW/BoZGal7dEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327778; c=relaxed/simple;
	bh=fYFB57ozwJvKl5L/srTvP9X6NcwO2OcUntgyrVR3yS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CG6U7R0aMz0kGltE5TyE6jsbPwCAGZAzQqlmme4B8oHRXiQawt6PfVH1+kzE64gj+IPm+yMBJ3pTNFNIvBeuFsCmLaKlVDvrJzrG160v6DJikn3thUlOze2n9gD2U04GCGah45H1S7ANDEBeGW+5z7lx22AGC3wJk4QAYM6d54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEn7lLnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEn7lLnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E021F00893;
	Mon,  1 Jun 2026 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780327771;
	bh=KSWzzhQuJB6BJ7l6MeJttWmF1tZ/intH7Y8yil/YyNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEn7lLnTvpdZN1gVUHqzcbxZ1YRRmZ4T8zg17A+wvScRT8FtzQIeS8K/W0FB5m5M1
	 c6vGxe2DIcMSgjifcHC+avivLKFDW4tRbTWAHsDd2BcAxX+1vjjPpP5xAPndyFWvgP
	 ITSmS6rJYq4jFAAy1iINGYtBXXoqFHqRaHa3uL1wo6K5ArrPvXgv1Mv6dhloHBU8jM
	 YfIG4E5eoSh1v8YjBISahtXmuKetFnl0mui0CqkW3ePZ3U/uSmRB0Bb++iT17sG9gs
	 2ROpsPouSQkBWHC8yIq9ijuBlV2j5Y9ZCTwAqh/fQHB6i3oxK/GxnPfm04pdWyiTL+
	 4Ck4iiRngyQ0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Drop redundant hash_buf from
 map_get_hash operation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601150248.394863-3-daniel@iogearbox.net>
References: <20260601150248.394863-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 15:29:30 +0000
Message-Id: <20260601152930.F0E021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Computing the SHA-256 hash of a large frozen array map without sch=
eduling points can cause a prolonged CPU stall (soft lockup).
--

commit 5b323404e84282b52180b843142a5d52b5becb22
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Drop redundant hash_buf from map_get_hash operation

This commit simplifies the map_get_hash operation by dropping the unused
hash_buf_size argument and removing a redundant self-copy in
array_map_get_hash. The bpf_map_get_info_by_fd function is updated to invoke
it without passing the buffer.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[ ... ]

> -static int array_map_get_hash(struct bpf_map *map, u32 hash_buf_size,
> -			       void *hash_buf)
> +static int array_map_get_hash(struct bpf_map *map)
>  {
>  	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> =20
>  	sha256(array->value, (u64)array->elem_size * array->map.max_entries,
> -	       hash_buf);
> -	memcpy(array->map.sha, hash_buf, sizeof(array->map.sha));
> +	       array->map.sha);

[Severity: High]
This isn't a bug introduced by this patch, but could this sha256 call cause
a soft lockup for very large array maps?

BPF array maps can be allocated with very large sizes. Since sha256 process=
es
the data sequentially without yielding, computing it over a gigabyte-sized
array might take seconds of uninterrupted CPU time.

Because bpf_map_get_info_by_fd unconditionally triggers this computation wh=
en
a user requests the map hash, is there a risk that this could be used to
repeatedly stall the CPU, leading to RCU stalls or soft lockup warnings?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601150248.3948=
63-1-daniel@iogearbox.net?part=3D2
