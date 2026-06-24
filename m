Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C4233721
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296582; cv=none; b=PP0Ge0lWiFbrqR1LVRL+gl9qRLO9UxnMHFWzxRW0fXbHdQspCZCGO0Ql4ARKFaS5NrF5O+vYyxq6YN70gpCt9YuzkBt5ggRhsiTt8D/0yFQ8cXRlaxMAoc8oPpoVaNsOtm92jD8H+LKfBP0xA1xC70lslLsIcGVsVgQoJNmj7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296582; c=relaxed/simple;
	bh=6BYrXEOW44ShFGnkT7y5nNlrjApm/O6HewVU9BVHYTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shwDbT2bEzqMwDcQJbcC9DCqrvXDybET+0w0JJRtmXKsWl9Dn8bBVr/t5eGmpiwr+Ox6s9qX7IL/eKx0TLHBxszInFzXa2ftOkIMOkKvOqvoW2oZLSA+rQGKLaA9cdUxqoFjDVk+SOj3HNl9AUj5LU46XZOPQoiSUXx+ijcJdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSt6YPOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSt6YPOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8401F00A3D;
	Wed, 24 Jun 2026 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782296581;
	bh=LAJO0ztFDQN5McTgT2eyAN6lbpRLOPy2gkWD8WP6SHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSt6YPOVX3bOw0fVBmtNDB6wfiPH0D5PQzGNSULJak5HpTKqt7rTLTOscQkgDz1vc
	 fLbHg75xw03Y6cisgrsXEcofdjjtzSD1WG84H2KikXjOZXYTQCMXzGH6PZRJD4AtTw
	 iOWQBC3N2j+zu1n9CIWzNpzJ03r0YlyCxnELCb7w2XqeloSXs+M2bH5S71ZAjkbUFD
	 fp0S6LcUUDIpvD+3IqTS3r7fm41ZRK3gXX+gd4P9dh/IUkBTVqRjz4/r3z/H2KmYg9
	 czdHPuIVkaTFzAGdMAUmzN0+sGPQqnd4yFkRffdgY8nR0KqFXYsShlt8unl0o3/nL5
	 e8bfyrJhg2J1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] libbpf: bounds-check float size in
 btf_dump_float_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <178229582410.80761.16669701451820050202@digiscrypt.com>
References: <CAEf4BzaxKLJAEaZR7VBjT5N_jeWVJ=bRviP19viGaSGQ=44dRg@mail.gmail.com>
 <178229582410.80761.16669701451820050202@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 10:23:00 +0000
Message-Id: <20260624102301.2B8401F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious BTF can bypass size checks by defining a FLOAT or PTR =
member with a bitfield size, leading to an out-of-bounds memory read.
- [High] A mismatch between the target BTF alignment and the host architect=
ure alignment requirements can cause an unaligned memory access crash when =
reading floats.
--

commit 8b775a18b4de3665e91e05ddb075a75dc6ae1b43
Author: Naveed Khan <naveed@digiscrypt.com>
Subject: libbpf: bounds-check float size in btf_dump_float_data()

This commit fixes a stack buffer overflow in btf_dump_float_data() by
validating the float size before copying it into an on-stack buffer. It also
changes the buffer to be 16-byte aligned so that valid long double floats
are always accepted.

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index cc1ba65bb6c5a..dc26f3a160305 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1980,13 +1980,18 @@ static int btf_dump_float_data(struct btf_dump *d,
[ ... ]
>  	/* handle unaligned data; copy to local buffer */
>  	if (!ptr_is_aligned(d->btf, type_id, data)) {
> -		memcpy(&fl, data, sz);
> -		flp =3D &fl;
> +		memcpy(buf, data, sz);

[Severity: High]
This isn't a bug introduced by this patch, but could a malicious BTF bypass
size checks here by defining a FLOAT or PTR member with a bitfield size?

Looking at btf_dump_type_data_check_overflow(), it short-circuits the full
size bounds check against data_end when bit_sz !=3D 0, checking only the
bitfield size:

    if (bit_sz) {
        __u8 nr_bytes =3D (bits_offset + bit_sz + 7) / 8;
        return data + nr_bytes > d->typed_dump->data_end ? -E2BIG : nr_byte=
s;
    }

However, we unconditionally read t->size bytes from data via memcpy
above, which could lead to an out-of-bounds heap read if the actual
data buffer is smaller than t->size.

> +		flp =3D (void *)buf;
>  	}
> =20
>  	switch (sz) {

[Severity: High]
This is a pre-existing issue, but could this cause an unaligned memory
access crash on certain architectures when reading 16-byte floats?

ptr_is_aligned() checks alignment against the BTF target requirements,
which caps at 8 bytes. If the host architecture requires 16-byte
alignment for a 16-byte long double, and the data pointer is only
8-byte aligned, ptr_is_aligned() returns true and bypasses the local
buffer copy.

Later in the switch statement:

    case 16:
        btf_dump_type_values(d, "%Lf", flp->ld);

Casting that 8-byte aligned data pointer to union float_data and accessing
flp->ld could cause an unaligned memory access trap.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178229582410.80761.=
16669701451820050202@digiscrypt.com?part=3D1
