Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6F232395
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555107; cv=none; b=E+zLdQMAulk46pwWCeDJlj0UEoyEKlqRHpKHtLJlY12SWj+gfNDEntpv1GhQXgXJdOsGtE23ehOYjmLv1dodVhckm/a5googaCfnoANk0E+iqLgmLhY9vUdYo5WWwXqYVv5Pa80XXN2VecYak1H1aQHrnJlSiH/O2AFE3s+8lsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555107; c=relaxed/simple;
	bh=FdW76xjgTxvfORhJkVh48XAHy7DSlcCxObVVQxEN1xM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RuXe7RlGNd3+ID2R2cLeiFrvW9aAK6Kz7UI3EPDSglk2wrMB9JnhyHdR+DVvQBx01Dn/6ZaQtDvCkfpXvkY3RQTejUFbctswg2cB6U8UWIICnIyq3v1N7CJueVNvndBR5iZzEwqufx2kzAgC2kx45BK2f16oAMBZv79Pn66p84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkZpRjVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkZpRjVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7838A1F000E9;
	Sat, 23 May 2026 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779555105;
	bh=5qW7p+a1MBi05Xx0g6iy9scYXNJ4Kvtyo0Y+duVw8HA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fkZpRjVdrOI+X+xn5SYXoapriGFcfZIU5/OvjqEftG5J+Fuf88rfyqeWaamjOIv9Y
	 QJ09o88YF0Ww2re3G7DMBe87ArFgbjzbetmv2AFZVkduMmkzuswwkQbbBbdmTYcx0Y
	 bfyZSIg1JnJVlmsqC84Aj6EnEe36idkO82x3KWiMs9TUh38cEMz4bcHCYYWL6quMQ6
	 EVB2GjZWWp/CUAbAnXdR5rWvx213CuPmHVGkebmFCMUoaQME8F5Ft7110vHKX8cUJk
	 aJJRwOWvEWTiu4rYrzyCueso9ffpccQpdvSXFdk9cn+X2royZnemQ6nvBsWIre3HDO
	 p+LJ52IfcwujQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] libbpf: fix UAF in strset__add_str()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carlos Llamas" <cmllamas@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260523162722.2718940-1-cmllamas@google.com>
References: <20260523162722.2718940-1-cmllamas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 16:51:45 +0000
Message-Id: <20260523165145.7838A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the BPF subsystem kernel style gu=
idelines.
--

commit 85499e76a5baa5992df9be7379523577757796bf
Author: Carlos Llamas <cmllamas@google.com>

libbpf: fix UAF in strset__add_str()

This commit fixes a use-after-free issue where strset_add_str_mem()
reallocation could cause the string pointer to become dangling if it
pointed into the old buffer. It refactors the logic into a new helper
function strset_str_append() that reconstructs the pointer when necessary.

> diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> index 2464bcbd04e03..b9faca828f09a 100644
> --- a/tools/lib/bpf/strset.c
> +++ b/tools/lib/bpf/strset.c
> @@ -107,6 +107,38 @@ static void *strset_add_str_mem(struct strset *set, =
size_t add_sz)

[ ... ]

> +static long strset_str_append(struct strset *set, const char *s)
> +{
> +	uintptr_t old_data =3D (uintptr_t)set->strs_data;
> +	uintptr_t old_s =3D (uintptr_t)s;
> +	long len =3D strlen(s) + 1;
> +	void *p;
> +
> +	/* Hashmap keys are always offsets within set->strs_data, so to even

[Severity: Low]
This isn't a bug, but the BPF subsystem prefers the modern kernel multi-line
comment style which requires the opening /* to be on its own line. Could
this be updated to match the BPF style guidelines?

> +	 * look up some string from the "outside", we need to first append it
> +	 * at the end, so that it can be addressed with an offset. Luckily,
> +	 * until set->strs_data_len is incremented, that string is just a piece
> +	 * of garbage for the rest of the code, so no harm, no foul. On the
> +	 * other hand, if the string is unique, it's already appended and
> +	 * ready to be used, only a simple set->strs_data_len increment away.
> +	 */
> +	p =3D strset_add_str_mem(set, len);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	/* The set->strs_data might have reallocated and if 's' pointed

[Severity: Low]
This isn't a bug either, but this comment also doesn't follow the preferred
BPF subsystem multi-line comment style with the opening /* on its own line.

> +	 * to an internal string within the old buffer, then it became
> +	 * dangling and needs to be reconstructed before the copy.
> +	 */
> +	if (old_data && old_data !=3D (uintptr_t)set->strs_data &&
> +	    old_s >=3D old_data && old_s < old_data + set->strs_data_len)
> +		s =3D set->strs_data + (old_s - old_data);
> +
> +	memcpy(p, s, len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523162722.2718=
940-1-cmllamas@google.com?part=3D1
