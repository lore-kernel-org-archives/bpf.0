Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043D20E702
	for <bpf@vger.kernel.org>; Sun,  5 Jul 2026 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783222714; cv=none; b=iwiwZzuYjFxeqNZGTjwazGl8KNJdfV8fBQ0oM1pyAOHwUzSM6KgToYou2z4ZpNjN4h0rzBIL17uUG+gPjl/JQgQp++U3aVPAplplwkUaDX7uAWJvmLPHjWdZkKW6X0h8bxhgwW4GW/BLUPX0W+C85Tv/nzOPCR9k1q2V9yBzgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783222714; c=relaxed/simple;
	bh=e8EEZlGDcmwZkM2GdoxIpG+OGGkbF8m1pVHt29bVLmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bYmsZOGaqY/vkwpuxkD1XIxf1KwPuF7qWNLO59NTrQ/Z+0EeoMJ44Rb1Yzd7uN5aE9ZS/IG7Vyk+5lBJwk8zRXX/x/3bSePnbhTygeK0/DYhk7u2Vc3Jfb/pL9tgrZ16QlPAZe59l4IldjxtwMhtfdtI5rlEELqmLedqWn0OhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdB4E2tb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdB4E2tb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84101F000E9;
	Sun,  5 Jul 2026 03:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783222713;
	bh=ikUa5AK5iQagcQWdtZEKJ598dG0s9Iz2609jKUOtmHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hdB4E2tbQapxUAeZQOO1jvVTwyG7YVX7/eMCYaQvVj1xxyxDxQVO3+Ok/RvXZu273
	 zmyrUqVTZ/kSAl1ust8lL9pn/UBuke7XhTUMCLmwZ+Vlh0lWHSNeUo7qUueE/doAGR
	 4+BtDxqimveXD7FrjpfxtTXZ6haiI7cvXsdRWlWQYF1KjqU7t0G2i0ewglbqk0r8aF
	 4Z3jEE1WZc/F8KAW06oeUu1nUryOPW4EMelWD1dAg9OE45cNjfVVu3YhKzkAa/6kc3
	 o9K1Sit3GFGMZR6OmAX6J5oz/aAAFbR8S056iTL5nvFMXfpsHtshFpEQe2MNUw5Fbl
	 9BcgqWCHaxazg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: Check full backing type size for bitfield dump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260705032603.275766-1-lgs201920130244@gmail.com>
References: <20260705032603.275766-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 03:38:32 +0000
Message-Id: <20260705033832.C84101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The stricter bounds check using `t->size` incorrectly rejects vali=
d narrow bitfields in packed structs, causing a false positive `-E2BIG` fai=
lure.
- [Medium] The bounds check for bitfields was updated in `btf_dump_get_bitf=
ield_value` to use `t->size`, but the early bounds check in `btf_dump_type_=
data_check_overflow` was left unpatched, causing inconsistent behavior.
- [Low] Unused local variables `start_bit` and `nr_bytes` are left behind a=
fter the patch.
--

commit dcf1121c5988139c35dcd52cf31ce52003f38d43
Author: Guangshuo Li <lgs201920130244@gmail.com>

libbpf: Check full backing type size for bitfield dump

This patch updates the bounds check in btf_dump_get_bitfield_value() to use
the full backing type size instead of just the bitfield span. This prevents
out-of-bounds reads when constructing bitfield values from narrow data
buffers.

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index cc1ba65bb6c5a..a49790e356a83 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1771,7 +1771,7 @@ static int btf_dump_get_bitfield_value(struct btf_d=
ump *d,
>  	nr_bytes =3D (start_bit + bit_sz + 7) / 8;

[Severity: Low]
Are start_bit and nr_bytes now unused variables? Since the bounds check
below was updated to use t->size instead of nr_bytes, it looks like these
calculations are dead code and might trigger compiler warnings.

> =20
>  	/* Bound check */
> -	if (data + nr_bytes > d->typed_dump->data_end)
> +	if (data + t->size > d->typed_dump->data_end)

[Severity: High]
Will this stricter bounds check reject valid narrow bitfields in packed
structs? If a user dumps a 1-byte packed struct containing an int
bitfield (e.g., int a:8), the backing type size (t->size) will be 4, but
the valid data size is only 1 byte. Could this cause the libbpf BTF dump
API to fail with -E2BIG for valid structs?

[Severity: Medium]
Does this change create an inconsistency with the early bounds check in
btf_dump_type_data_check_overflow()?

Looking at btf_dump_type_data_check_overflow() in the same file:

	if (btf_is_bitfield(t)) {
		...
		return data + nr_bytes > d->typed_dump->data_end ? -E2BIG : nr_bytes;
	}

Since that function still uses nr_bytes, could it succeed while this
function fails, resulting in partial and malformed output where the dump
prints the struct member prefix but fails during value retrieval?

>  		return -E2BIG;
> =20
>  	/* Maximum supported bitfield size is 64 bits */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705032603.2757=
66-1-lgs201920130244@gmail.com?part=3D1
