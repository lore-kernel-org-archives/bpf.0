Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031C2E7F0A
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773705; cv=none; b=EeDW0V83PyxYYS0yG6mtNDmZMRZCUQFAfRj8wyHYeTUVjDOlTdRPkvDw+PInmKYh5HcPotDepBzCIGfDLmT7rBDljRwA3VQxDe8QxyrGXf3ZbtbHw8oixxLHZDB8h26MmLx2DLKNn1ubLoomqdLyJBSiv0ewmtbr0kKj9+nrQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773705; c=relaxed/simple;
	bh=C99umUBPJspkm8C5NGH4XHRea0NHhGOL9DstH+Fj04Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRo5xTvh3rTQRX2ghFtsTK2oVHafmlQSOOxCFH/I/rADvPAs9oBZAHwAT3YIcfgcoWo8ij0TSenbpcHYEN8naeFh0WKjCgIqC18TW+axlzC1lUe6R+2CrsOiXGZ4n7OpGmx3ke+AZm5uyGSzse4LyAIu1q5s6/PBSn7eq3M51Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV09IS1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV09IS1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DB01F000E9;
	Thu, 18 Jun 2026 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773704;
	bh=ZWEBJrLZgTB6fkz2S/6miB9NF6Gzp9Cg9qopyyIi0kU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kV09IS1spVTIW+OtkpLQCVT3Qd5BtzAYQSEAeCTpcVk92akk43R7jOM0uW2mumjYb
	 7wLAlVpkqrp4/TSR/RYg3mETs42ERDPUF7NQK61lsvc8lOCQt/iKq5jbtfY50ZyZKf
	 vuX+hZtPCZDR3i2Y8K8AX44lUeVEk6q0rFi/kD7A8k4FeQKnLeaQWhlKEPVl7/zD1H
	 Gi2qz3NUAT14y0XhL6IDy+sE0Qc+9nWG6xtYyaglbBqhG+mYQEGaucdFzpEqBlAar/
	 WpapoSIjXtPBE8DdXUoZbDpwbm9VH2Cej8h0iYjiRDYrwWldVvTni29s/YnuVmX/H+
	 mdiaMozMjzTkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add arena-based bitmap data
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618085626.19633-5-emil@etsalapatis.com>
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:08:23 +0000
Message-Id: <20260618090824.02DB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `struct bitmap` uses a `u64` array, but bitwise helper macros =
rely on `sizeof(long)`, causing a severe memory layout and indexing mismatc=
h between 64-bit BPF and 32-bit user-space.
- [High] `bmp_set_bit` and `bmp_clear_bit` perform non-atomic read-modify-w=
rite operations, leading to lost updates under concurrent access.
- [High] `bmp_alloc` incorrectly rejects bitmap sizes that are not exact mu=
ltiples of `BITS_PER_LONG`, completely breaking allocations for standard cp=
umask sizes.
--

commit e05abd6424c958e46d415ca79df966bf83a06a24
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add arena-based bitmap data structure

This commit adds an arena-based word-aligned bitmap data structure.
The structure is intended to be used as a building block for features
like sched-ext to represent cpumask structures.

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> new file mode 100644
> index 0000000000000..11623a82e66a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> @@ -0,0 +1,31 @@
> +#pragma once
> +
> +#define BITS_PER_BYTE		8
> +#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
> +
> +#define BITS_PER_LONG		(sizeof(long) * BITS_PER_BYTE)
> +#define BITS_TO_LONGS(nr)	(((nr) + BITS_PER_LONG - 1) / BITS_PER_LONG)
> +#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> +#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> +
> +struct bitmap {
> +	u64 bits[0];
> +};

[Severity: High]
Since struct bitmap defines its storage as a fixed-width u64 array, will
using sizeof(long) and 1UL in BIT_WORD and BIT_MASK cause a mismatch between
32-bit user-space and 64-bit BPF?

On a 32-bit user-space process, BITS_PER_LONG is 32. Accessing bit 32 would
compute BIT_WORD(32) =3D 1, pointing to bits 64-127 of the u64 array, while
the 64-bit BPF program would correctly calculate BIT_WORD(32) =3D 0.

Should these macros use fixed-width indexing constants like sizeof(u64) * 8
and 1ULL instead to maintain the shared memory contract?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/bitmap.bpf.c
> new file mode 100644
> index 0000000000000..a8ca814aa0c85
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
[ ... ]
> +__weak
> +struct bitmap __arena *bmp_alloc(size_t bits)
> +{
> +	struct bitmap __arena *bmp;
> +	size_t size =3D BITS_TO_LONGS(bits) * sizeof(bmp->bits[0]);
> +
> +	/* Assume long-aligned masks. */
> +	if (bits % BITS_PER_LONG)
> +		return NULL;

[Severity: High]
Does this logic artificially reject valid unaligned bit counts, preventing
its use for standard cpumask sizes where nr_cpu_ids is not a multiple of 64?

The allocation size is already safely rounded up to the nearest word
boundary via BITS_TO_LONGS(bits), and trailing bits seem to be handled clea=
nly
by operations like bmp_last_word_mask.

Could this check be removed so callers aren't forced to artificially round =
up
requested bits?

[ ... ]

> +__weak
> +void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	bmp->bits[BIT_WORD(bit)] |=3D BIT_MASK(bit);
> +}
> +
> +__weak
> +void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	bmp->bits[BIT_WORD(bit)] &=3D ~BIT_MASK(bit);
> +}

[Severity: High]
Will these non-atomic read-modify-write operations race if multiple CPUs
concurrently set or clear different bits within the same 64-bit word?

Since the bitmap is intended for concurrent structures like sched-ext
cpumasks, updates could be silently clobbered.

Should these functions use atomic built-ins such as __sync_fetch_and_or
and __sync_fetch_and_and?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618085626.1963=
3-1-emil@etsalapatis.com?part=3D4
