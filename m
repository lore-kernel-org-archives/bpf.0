Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4581227603C
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782257457; cv=none; b=foiat03W43RQQKGgq4JM5Y+qoYPwmVUD4rkHWetGtS5Biif8YKvHtnj5ouVwRb9aQUM3hqaBFIBMRc2XimQyRoei9tt5dXYDp9Pwrf58/ZeQKmmME7Es+4IhlzIgvHRp3DRblYBkGaz5R0CaMmZfGdkko7hBGMjWs1nCPWehDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782257457; c=relaxed/simple;
	bh=MuoTGTyBvl7N37oZril/y5lELoVRXxF0v05PzdfesTs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DrLpmqWIhYz2KVqp4urs+K1eY1NYhOuucgl0S9jEPUKf2J43wZJQGqtO2rYdcMTKOKSU+2nuXmNMwOAgU+s5CfyW6/cH7jaKmBzRH64AYUq04tgk+EaLCLZoHyIRf2s6gpFohzoiqBm7/kPF1YkSfXLmWAH5Kwdx6I9NQJGsKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cHaLU9sa; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cHaLU9sa"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so809375eec.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782257455; x=1782862255; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHHcOKPTPmjQ53dCLW+k/ZKx8znLPlDdweDSxdM511E=;
        b=cHaLU9sak1ZjRkHMKBXAt2Ty2MjX6gLOs2O5/r2XTn1d6d06M3aB28VkjpbIcRETTy
         sQsRpWgeLqQ/5tm0ROkshZVGGaUtFR3B59TN2df1842nTqbrkrgn5z1jQ3/vEHiphk2a
         Ou29k5atBzxgYB1HPMlSWKp8MKCs+1oMYkT549g9pdG6ZU3TZWVZmyY4SV7NSz2O0Qu/
         IP+7Ci+sZTTeoZE364Yp3pJ1tOJ98UFs1jHj5xdBaGeyPz203MxyuEbErm2+8oNdnJGP
         Gecqyt/eI+m8PumyP52uUfGDjFjtAEGA9jkCNznuPR7svSxGrGZztYcJoKVC1nMWzVmm
         Ob5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782257455; x=1782862255;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHHcOKPTPmjQ53dCLW+k/ZKx8znLPlDdweDSxdM511E=;
        b=qyYB1VvMnSfmTafMYhojqAXJOv6BRIhj9uj8yqx68SK7jGtuj0kt0Vi3E4DJZTdJ/E
         sEWvtER/+4GjQhB6SaQpjuvXho5h9OwRISoQ5xAa6pQJd5TwGlVDsI/tu2QEuf0Erp/b
         SPZ71hpfRU6wgFrLU1DoR/zzo0sLsk/EA1B3XTAfN0a1SpEsfGOLcMpRGKh551WoWO21
         Ch/wigs+uEgz8qGGA+TWbhntIUEFYWEcZEBFqykov+fC1JDaZ/JBrjYyDl+cNSzHSpio
         0z9Jy34Uqo+rMehafgzzWpHvBaiU08R5lB4prkCvFlPbSMFS35pA5dspFc7jrXnrzPPX
         EvPw==
X-Gm-Message-State: AOJu0Yy6YUoETGd8Eaqo818fazh5wkE+HTJRYxj9pfkzHlcN0eItOqqX
	AhupUcZmIvrUp6f2TZJDWQL105VLwmZ8kNfN4LtkfSIEWserBLhEgkixJyYpiSe/Kr8=
X-Gm-Gg: AfdE7ckypY4l3PqFbN8i1oyU9nATr0tuxzVme7K+PEyR4T/zkiLTu3+ts7WpGiZAors
	AtHJY4ndCqmZIvAe243YVIvYAYyoF3wc7EjVndEARU3TZc7hOwG0qpQj39uWc5nRD0+urNmp0S3
	0qgHufUgXWaJmZvZdqOKXF1TD42LgFWNcCBoqg/GqLaaCD+NGludZjAD5YjA9A+qL4yEQgaNHjF
	+W3N0MmLTX9OZV9uG2zNWjhxjuaAO7rf112nfAPZ3fX3560tRUmIcGAq9gbz4sMR5XfJQeKXhdK
	isvTf6lZhQbCn1SuIOnp52GYWibxso/JbOFU6PcN3MAd5JMHdEMpaxpJMDgMS0vV0I5w8w4t3A6
	JqaogqfymPhIXJZXdsWDCWhCXBY/Yacp4WLiPgf3v0OPcN8GtOqXYRGqCZBbMqZpceX//dQ==
X-Received: by 2002:a05:693c:37c3:b0:30c:689b:c59d with SMTP id 5a478bee46e88-30c689bce4amr1362727eec.5.1782257455025;
        Tue, 23 Jun 2026 16:30:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c5c1056f8sm7379882eec.15.2026.06.23.16.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 16:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 19:30:53 -0400
Message-Id: <DJGTJF17UY7P.VAHCYNC312A7@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add arena-based bitmap data
 structure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-5-emil@etsalapatis.com>
 <20260618090824.02DB01F000E9@smtp.kernel.org>
In-Reply-To: <20260618090824.02DB01F000E9@smtp.kernel.org>

On Thu Jun 18, 2026 at 5:08 AM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] The `struct bitmap` uses a `u64` array, but bitwise helper macro=
s rely on `sizeof(long)`, causing a severe memory layout and indexing misma=
tch between 64-bit BPF and 32-bit user-space.
> - [High] `bmp_set_bit` and `bmp_clear_bit` perform non-atomic read-modify=
-write operations, leading to lost updates under concurrent access.
> - [High] `bmp_alloc` incorrectly rejects bitmap sizes that are not exact =
multiples of `BITS_PER_LONG`, completely breaking allocations for standard =
cpumask sizes.
> --
>
> commit e05abd6424c958e46d415ca79df966bf83a06a24
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> selftests/bpf: Add arena-based bitmap data structure
>
> This commit adds an arena-based word-aligned bitmap data structure.
> The structure is intended to be used as a building block for features
> like sched-ext to represent cpumask structures.
>
>> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitma=
p.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
>> new file mode 100644
>> index 0000000000000..11623a82e66a5
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
>> @@ -0,0 +1,31 @@
>> +#pragma once
>> +
>> +#define BITS_PER_BYTE		8
>> +#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
>> +
>> +#define BITS_PER_LONG		(sizeof(long) * BITS_PER_BYTE)
>> +#define BITS_TO_LONGS(nr)	(((nr) + BITS_PER_LONG - 1) / BITS_PER_LONG)
>> +#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
>> +#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
>> +
>> +struct bitmap {
>> +	u64 bits[0];
>> +};
>
> [Severity: High]
> Since struct bitmap defines its storage as a fixed-width u64 array, will
> using sizeof(long) and 1UL in BIT_WORD and BIT_MASK cause a mismatch betw=
een
> 32-bit user-space and 64-bit BPF?
>
> On a 32-bit user-space process, BITS_PER_LONG is 32. Accessing bit 32 wou=
ld
> compute BIT_WORD(32) =3D 1, pointing to bits 64-127 of the u64 array, whi=
le
> the 64-bit BPF program would correctly calculate BIT_WORD(32) =3D 0.
>
> Should these macros use fixed-width indexing constants like sizeof(u64) *=
 8
> and 1ULL instead to maintain the shared memory contract?
>

Ack, should be BITS_PER_LONG_LONG. We are not prioritizing 32-bit here.

> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/bitmap.bpf.c
>> new file mode 100644
>> index 0000000000000..a8ca814aa0c85
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
> [ ... ]
>> +__weak
>> +struct bitmap __arena *bmp_alloc(size_t bits)
>> +{
>> +	struct bitmap __arena *bmp;
>> +	size_t size =3D BITS_TO_LONGS(bits) * sizeof(bmp->bits[0]);
>> +
>> +	/* Assume long-aligned masks. */
>> +	if (bits % BITS_PER_LONG)
>> +		return NULL;
>
> [Severity: High]
> Does this logic artificially reject valid unaligned bit counts, preventin=
g
> its use for standard cpumask sizes where nr_cpu_ids is not a multiple of =
64?
>
> The allocation size is already safely rounded up to the nearest word
> boundary via BITS_TO_LONGS(bits), and trailing bits seem to be handled cl=
eanly
> by operations like bmp_last_word_mask.
>
> Could this check be removed so callers aren't forced to artificially roun=
d up
> requested bits?
>

This is a deliberate design choice. The space savings we'd get by
handling unaligned cpumasks are relatively small so we don't worry
about it unless it proves to be a real issue.

> [ ... ]
>
>> +__weak
>> +void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
>> +{
>> +	bmp->bits[BIT_WORD(bit)] |=3D BIT_MASK(bit);
>> +}
>> +
>> +__weak
>> +void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
>> +{
>> +	bmp->bits[BIT_WORD(bit)] &=3D ~BIT_MASK(bit);
>> +}
>
> [Severity: High]
> Will these non-atomic read-modify-write operations race if multiple CPUs
> concurrently set or clear different bits within the same 64-bit word?
>
> Since the bitmap is intended for concurrent structures like sched-ext
> cpumasks, updates could be silently clobbered.
>
> Should these functions use atomic built-ins such as __sync_fetch_and_or
> and __sync_fetch_and_and?

Ack.
