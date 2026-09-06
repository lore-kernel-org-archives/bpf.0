Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928DB3537FD
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788705925; cv=none; b=Jodn+398HXLqJXc8nxav2kTKQvPUL2RFtchpYLKpXxhgWh2F+1X2dMaLA75n2N/qVcG88J7ImhgOKW8s1KYbwmnEh0CqibZ6//e1PKJiaSMJu/42pNc5doKqv7OrrEK7gVcunOIlwqWF6Fob6BZfZMAqWxCLfjhN0fkmMpOwY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788705925; c=relaxed/simple;
	bh=gX8qcYzH+3XhWbd/iKY5bqceID7XqnypHmSBLAE4UYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bKH7A9w8MN06fRdexgj/hxMIqutKvT8wmy7Wm9/qcAUidLPAZqxV1Iy+2gFc+xS3hCcdFCApUB77neRk+bXIc0xr39HzrW/5yQbq+e2IVZzX/KCjmNNbAXVFVrGRHxcxVlLerQ62tqb3ecIu1RpYE65bxW/r0kz7G++xCYY3Nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lglGDFL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lglGDFL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCE91F00A3A;
	Sun,  6 Sep 2026 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788705924;
	bh=ZX1sjvb7r2y88z7WeHc4uPq/CAyy4fwQqmExKxT/vtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lglGDFL4jAKfL0MBHA3sstto+3kxt78+QRYHmXfWF1MnxzYmkumqHf5hX1h0mUAyi
	 H7R/yJiiQk9qSdgbUw0fHqbCOomhXV3a21ITVErtRF+D1YvsvtN9r8n8KotucCpUhN
	 45tIRY2XLkAJO9CjqHVxFF1jk0rga6D15I9jwbLX4qIn92dhlpy6lnEP0+rg/T8pWo
	 PtbxY9Mv1aQ1KwcxeIPjaB1Y/qb4+j+f17BgYRlkmlGAGQjTwuOsiETtmYRWahQewS
	 wzeUnxqTtRos1GxSYcxePHhSc+x4J+Iyrsk6VOaa3PuhTqzDSGS08pUId6RW75Xzah
	 1E7yuiKJP6+mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Check returned keys in map batch
 validators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260906143918.848536-1-hi@tychen.cc>
References: <20260906143918.848536-1-hi@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 14:45:23 +0000
Message-Id: <20260906144524.0DCE91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces new usages of the deprecated CHECK() macro ins=
tead of the modern ASSERT_*() macros, violating BPF subsystem selftest guid=
elines.
--

commit a52968798d334a652d5c678ee6009b5d4bc96738
Author: Tianyi Chen <hi@tychen.cc>

selftests/bpf: Check returned keys in map batch validators

This commit updates map batch validators for hash and array maps by
indexing the visited array by key and verifying that returned keys fall
within the valid range. This prevents duplicate keys with matching values
from hiding missing entries.

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
Could this use the modern ASSERT_*() macros instead of the deprecated
CHECK() macro?

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
Could this also use the modern ASSERT_*() macros rather than CHECK()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906143918.8485=
36-1-hi@tychen.cc?part=3D1
