Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7C3932DB
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095435; cv=none; b=oNweJd5DWX43SYDGc3EtcK0j7Wir/fmVCtQcLOkJTkLoQ8h+qVp7eUCjR+RN5ODkk4Q46N/jNu/TxCkjc4CHpWBJyNtpE/wV90fMy4+ptx23MPpIgLSOFn54coNXVALXTeonEREXPTNQTeuP0jUDrRhfmp7zCGb2CnKU634mvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095435; c=relaxed/simple;
	bh=2FDIKeAwcudpohP9dUVsluJHSjP9qrsWtkzd83DNnTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iNq1ZyS8dYfyXh+KULoHDYWw88ARDyqx4/WlcidDGWxZMY9C/CH3l+CYPViW/gFHScOx4FeCo/rwDtXSrdpU+JDhMWSUGlIp/C6wrqY418I4rX+HCEjt9UfK8V3Pl41bTnjliGc28pqs2zgdB9keNwzzLYNnh1jTAW4TYnekNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHWV4K3Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHWV4K3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5891F000FF;
	Fri, 11 Sep 2026 02:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789095433;
	bh=yKD6Xt1+dKdBXStgN+fQi2fdtMH4svy/iQC5k2l+958=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NHWV4K3ZMiDYZBVLZNzm8VfOqbTL2OsRov8XeO/EiP9qqfte18XO4zJKi910g+e4+
	 DdE3vAZ0tVsRsYy+esfvQ4Hsp97MkEw6T9HI89atGCpyH51e3qvZsTeUcKJ4diB/rO
	 kXLeNsYpiad1NOYEcEwQvj7oOgMSovg03PqUON18MKnTqeYYm6IysWJULlMGfIrU8a
	 Ft42B9Z+LCHDMpBK8U2/ohZMPxcJdLpp95WhaEecZMDzoIZWpfAE5sxeWcGxWZ0H/V
	 gVluuj5zJWeOe2iNWHEhtutRM4edIjJUOzmSmEunuA6V/52ANdlikefxGjM5mTwh83
	 683fyE6bKbrBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3] selftests/bpf: Check returned keys in map batch
 validators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <diannaaav@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911025036.190487-1-diannaaav@gmail.com>
References: <20260911025036.190487-1-diannaaav@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 02:57:13 +0000
Message-Id: <20260911025713.AB5891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces new uses of the deprecated `CHECK()` macro for=
 assertions instead of migrating to the required `ASSERT_*()` macros.
--

commit ea80e2126710dbf0e0f3a1f8861acf3e34b2207d
Author: Tianyi Chen <hi@tychen.cc>

selftests/bpf: Check returned keys in map batch validators

This patch updates the hash, array and LPM trie batch validators to check
returned keys against the populated set, and indexes the visited array by
key. It aims to detect missing entries while preserving unordered results
and per-CPU value validation.

> diff --git a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c =
b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
> index b595556315bc3..76d3800a82af9 100644
> --- a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
> @@ -45,6 +45,9 @@ static void map_batch_verify(int *visited, __u32 max_en=
tries, int *keys,
> =20
>  	memset(visited, 0, max_entries * sizeof(*visited));
>  	for (i =3D 0; i < max_entries; i++) {
> +		CHECK(keys[i] < 0 || keys[i] >=3D max_entries, "key checking",
> +		      "error: i %d key %d out of range\n", i, keys[i]);
> +

[Severity: Low]
Does this new assertion use a deprecated macro?

According to the BPF selftest subsystem guidelines, the CHECK() macro is
deprecated and should be avoided in new tests or patches. Should we use the
modern ASSERT_*() family of macros (like ASSERT_GE and ASSERT_LT) here
instead?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b=
/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
> index 5da493b94ae25..430949f9691d7 100644
> --- a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
> @@ -50,6 +50,8 @@ static void map_batch_verify(int *visited, __u32 max_en=
tries,
> =20
>  	memset(visited, 0, max_entries * sizeof(*visited));
>  	for (i =3D 0; i < max_entries; i++) {
> +		CHECK(keys[i] < 1 || keys[i] > max_entries, "key checking",
> +		      "error: i %d key %d out of range\n", i, keys[i]);

[Severity: Low]
Could this assertion also be replaced with ASSERT_GE() and ASSERT_LE() to
follow current selftests standards?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops=
.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
> index fe3e19f962446..3b51670b3cd4b 100644
> --- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
> @@ -44,18 +44,19 @@ static void map_batch_update(int map_fd, __u32 max_en=
tries,
>  static void map_batch_verify(int *visited, __u32 max_entries,
>  			     struct test_lpm_key *keys, int *values)
>  {
> -	char buff[16] =3D { 0 };
> -	int lower_byte =3D 0;
> -	__u32 i;
> +	__u32 i, ipv4, key;
> =20
>  	memset(visited, 0, max_entries * sizeof(*visited));
>  	for (i =3D 0; i < max_entries; i++) {
> -		inet_ntop(AF_INET, &keys[i].ipv4, buff, 32);
> -		CHECK(sscanf(buff, "192.168.1.%d", &lower_byte) =3D=3D EOF,
> -		      "sscanf()", "error: i %d\n", i);
> -		CHECK(lower_byte !=3D values[i], "key/value checking",
> -		      "error: i %d key %s value %d\n", i, buff, values[i]);
> -		visited[i] =3D 1;
> +		ipv4 =3D ntohl(keys[i].ipv4.s_addr);
> +		key =3D ipv4 & 0xff;
> +		/* Expected keys are 192.168.1.1..max_entries with a /32 prefix. */
> +		CHECK(keys[i].prefix !=3D 32 || (ipv4 & 0xffffff00) !=3D 0xc0a80100 ||
> +		      key =3D=3D 0 || key > max_entries, "key checking",
> +		      "error: i %u prefix %u ipv4 %#x\n", i, keys[i].prefix, ipv4);

[Severity: Low]
Even though the surrounding code previously used CHECK() in this function, =
the
BPF guidelines indicate that we should avoid introducing new uses of it. Ca=
n we
upgrade these new assertions to use the modern ASSERT_*() macros instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911025036.1904=
87-1-diannaaav@gmail.com?part=3D1
