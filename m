Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276DB409121
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191326; cv=none; b=tGXEf8W1IolKSzxN+XpJGvHbZ6yZG8pp/W0vl9HvALozrTJbb2cGPn6k1T40t99cOOJ3at3sn4gDBAuVpQAdvZrv5uiUlTVzq8DcJE0yBVQtcEm32gqCa1Au1Oyj4HnAC3LApwO+7aoYi1bo7Jlp6ZWqrWhHZNWQwI//mU/zRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191326; c=relaxed/simple;
	bh=reYEi9Hc3ygMzPH1mQ56OfhEhSTUZ10u1yPCDYFJlwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OxD0d89q4VBK6q3rUxgiVqn7sxRkDnDuVFKZqRFaIQM8bOedpXjvy47Kpx6wlminRca7zTv8oZ23OoCKdvO9M2CgSXFIf7iSJCyMe8fRiAAWvNTwGElvFlt8cDLvFT2DZ0C2QOc8VO3rb8HN+zCwGGrtAxVcLjdokZtQoUnmyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZPfVy04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZPfVy04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD6D1F0089A;
	Thu, 11 Jun 2026 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191323;
	bh=LpzOmHuilOGOX8JMSblwKnl+09OmkHrq1nOvwouu61k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZPfVy04wQZvfcxhhAWqBGTD3suH4tnDPFCvsAUPSUpaZGque+V7AlcRUJWzFb7hb
	 SzmWiCN3rVDRL0YEuYu665LIgZWz0dLDJOCglSN33mWunj2GIK9vuvYpkaiQWkySn0
	 MMVRs3+J99TKcndCnH/J1cSqee1VhKbb9oZN/TfLUk3tQpXlPYMokVuxfNE+UIrM2H
	 uMvz3pYZVUt7b566d2sstu15ESnXYZXSYSFZKQfVRmMaEIB9PUSozsri5hV2clRNSy
	 i0GV8Co63Zn4y7xq6VPJ5KgEUxFv0UVmQ25c3tVQJiMcbpHzhgWNMRXJgbv/0FCAnM
	 CPkC8NWChvIQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftsets/bpf: Retry map update on
 helper_fill_hashmap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611150704.95133-1-gmonaco@redhat.com>
References: <20260611150704.95133-1-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:22:03 +0000
Message-Id: <20260611152203.6AD6D1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `can_retry` function incorrectly uses exact equality instead=
 of a bitwise AND to check for `BPF_F_NO_PREALLOC` in `map_opts.map_flags`,=
 preventing retries when other flags are present.
- [Low] The patch modifies a deprecated `CHECK()` macro call without migrat=
ing it to modern `ASSERT_*()` macros.
--

commit 39b0e917600bcb89279f4b9e224c7a51b913c4fb
Author: Gabriele Monaco <gmonaco@redhat.com>

selftsets/bpf: Retry map update on helper_fill_hashmap()

This commit enables retrying map updates in helper_fill_hashmap() to handle
transient ENOMEM errors on PREEMPT_RT kernels. It does this by moving the
can_retry() logic up in the file and updating the update loop.

> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
> index ccc5acd55ff9d..c32da7bd8be27 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -260,6 +260,16 @@ static void test_hashmap_percpu(unsigned int task, v=
oid *data)
>  	close(fd);
>  }
> =20
> +#define MAP_RETRIES 20
> +
> +static bool can_retry(int err)
> +{
> +	return (err =3D=3D EAGAIN || err =3D=3D EBUSY ||
> +		((err =3D=3D ENOMEM || err =3D=3D E2BIG) &&
> +		 map_opts.map_flags =3D=3D BPF_F_NO_PREALLOC));
> +}

[Severity: Medium]
Will this exact equality check prevent retries if other bitmask flags are s=
et?

When helper_fill_hashmap() is called by test_hashmap_zero_seed(),
map_opts.map_flags is explicitly modified to include BPF_F_ZERO_SEED.=20

This causes the equality check to evaluate to false even when BPF_F_NO_PREA=
LLOC
is actively set, which bypasses the retry mechanism for this test and
leaves it vulnerable to transient ENOMEM failures on PREEMPT_RT.

Could this be updated to use a bitwise AND instead?

> +
> +
>  #define VALUE_SIZE 3
>  static int helper_fill_hashmap(int max_entries)
>  {
> @@ -274,10 +284,11 @@ static int helper_fill_hashmap(int max_entries)
> =20
>  	for (i =3D 0; i < max_entries; i++) {
>  		key =3D i; value[0] =3D key;
> -		ret =3D bpf_map_update_elem(fd, &key, value, BPF_NOEXIST);
> +		ret =3D map_update_retriable(fd, &key, value, BPF_NOEXIST,
> +					   MAP_RETRIES, can_retry);
>  		CHECK(ret !=3D 0,
>  		      "can't update hashmap",
> -		      "err: %s\n", strerror(ret));
> +		      "err: %s\n", strerror(-ret));

[Severity: Low]
Since this error checking logic and format arguments are being actively
modified, should this deprecated CHECK() macro be migrated to a modern
ASSERT_OK() macro instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611150704.9513=
3-1-gmonaco@redhat.com?part=3D1
