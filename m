Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C963CB
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610494; cv=none; b=rhjzX3LroWkO6+dXJlARXF9/+TMN6AFAddDZhMfu7u21DlvXSsmTYSr1l5neFsJYYyj5/AJWLPSpazzQPRZuqI3dFniNpB5bqwvAavArlKknrp8dsGDb64F7CjHwEUdj+yc60Dmw9UKt5e06NBuiS9MtnxrjCY2jp3IeK81n3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610494; c=relaxed/simple;
	bh=UTLQVDa4q8wnYvcLFJ2c2Lc2bBdurrIEWtd29R2fPbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZOSJv+Ps0YigMVhBSNBRL8mLjoe4Ly9VUWSaygUrrrKc85JNNfcFy0F5MLa1N64Xbo51ZsUZrZ/RFhmzrZ2dwtxZrsd1drByxcfuX0fg0aaHEHFr94fp963TcjIMmqyvIN+vr+dzXbhLKYeK7aLaLE1MB+6tRryWd3O8NXp8x1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3cqJln6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3cqJln6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D951F000FF;
	Thu, 17 Sep 2026 02:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610492;
	bh=QkWtvziCxrllvs+hRiUyPZZ9FmmLVdbAP8OXwszhrgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3cqJln6F60HKbIvsv2tHcDLUhax32CeDh/QXlKrkc7+WhVzWVtKzs06DQmcxxjoK
	 mWWyG+W/St4bivkZyXTF4pfh+IEzWGv0OoMdt587lDPV96LopDZJ1fFcF18xmU0ycw
	 w4l2LFZxq/Em3/sQDoB4R+CJjAzf6LkdPqEvK3Wk4/nrzoX2d6rzopkX/grHG7eAS5
	 rXxmJ527Q80OVHjRrQ4mU3jmf/Fqj9PdEiYvPy2HFO2tadx7hswLGA7HxNf0wzYb10
	 P/vTseE4RflBZciAj0AMh2C28lDAcCqgl1biDGzBkf4PZJjZ3DKb15CusgLfvlMGf5
	 q4EkM+0AI+anw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests: bpf: size the map in test_lru_sanity3 to
 whole refills
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eva Kurchatova" <eva.kurchatova@virtuozzo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917015605.2464043-2-eva.kurchatova@virtuozzo.com>
References: <20260917015605.2464043-1-eva.kurchatova@virtuozzo.com>
 <20260917015605.2464043-2-eva.kurchatova@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:01:31 +0000
Message-Id: <20260917020132.68D951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment opening '/*' is not on its own line
--

commit 8ef3f0915a719ad39da5bb2d44612274f4d4d332
Author: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

selftests: bpf: size the map in test_lru_sanity3 to whole refills

This commit fixes a test failure in test_lru_sanity3 that occurs on certain
CPU configurations, like six CPUs. It adjusts the map size so that target_f=
ree
divides evenly, preventing partial refills that prematurely evict elements.

> diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/s=
elftests/bpf/test_lru_map.c
> index 0921939532c6c..fc67a337d3c1b 100644
> --- a/tools/testing/selftests/bpf/test_lru_map.c
> +++ b/tools/testing/selftests/bpf/test_lru_map.c
> @@ -441,8 +441,18 @@ static void test_lru_sanity3(int map_type, int map_f=
lags, unsigned int tgt_free)
>  	assert(sched_next_online(0, &next_cpu) !=3D -1);
> =20
>  	batch_size =3D __tgt_size(tgt_free);
> +	if (!batch_size)
> +		batch_size =3D 1;
> +
> +	/* The local free list is refilled lru->target_free elements at a

[Severity: Low]
Does this newly added comment block in test_lru_sanity3 follow the BPF
subsystem's multi-line comment style?

The BPF subsystem guidelines prefer the opening '/*' to be placed on its
own line, rather than sharing the first line with the comment text.

> +	 * time, and a refill the global free list cannot satisfy in full
> +	 * shrinks the LRU list, which evicts elements that are still live.
> +	 * Size the map so that target_free divides it, otherwise filling it
> +	 * ends on a partial refill and evicts the elements referenced below.
> +	 */
> +	map_size =3D __map_size(batch_size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015605.2464=
043-1-eva.kurchatova@virtuozzo.com?part=3D2
