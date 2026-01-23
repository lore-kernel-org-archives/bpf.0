Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A593388843
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136939; cv=none; b=blWr5z4Fqwjec3+hWcHcT4LPIKa7mnsNinIa5/K+W/chX5iH5TNEwnLje50yYG7sKXYIE8B+B8P2BrLjO5hKHk6pHvZSDk25sosXjoVGXZPvXy26OnENl/m/LnhjEyEmtqdjWf4kTEt882aSNAwlSv4TWb5mRmXDMlbRv5caFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136939; c=relaxed/simple;
	bh=eTKCk+zmw3hyWw2X9FIF9rz9BGCpyfOuEVFrxzsCTEY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=LMXBdXjSdytLUwOQn62V/SrlKaLKDgwJDVPTXZ0UsmC3wC0m9PVPSLtJYIPO5hR8OdvdSxrGd4WgYRVNoZ6DZcYhjSBvr2ECwlIleNzpdwA3q08Xpd6DhGrS+eqXvLkC7s9fFi0r2bh2seLy//jQoEDwR8WNcuTJO8KkAmmLhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=tOuF7cW0; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="tOuF7cW0"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88ffcb14e11so32150326d6.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769136933; x=1769741733; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GTE7C5Gjv9kLwWxOiz+RqSwes3LIaw/84aycTQbuGU=;
        b=tOuF7cW09pI5LxLaDbW895hMilkt5zfsCov2rpu/t9kHIsvXXJCNh4Wmpplev/UqMb
         K9PJ6MOK+Ad3AK8No0PvAL7q9k+XKm8YUBR3lrcla4dYZ0uorbbTmaC+bWeyW6eGwinz
         m9A42JYVSM9fJcu6XHgBQPCfIe6mbwkIccbjlpfbMeQTu9I1+q16R6wgFL+nAm/LG3BC
         7ob6nWLR1f98wWeDHB8So55i6kpxmqjSergNSvqBSy2v8L4FuI6Ew0CnMbqW59sGKPDu
         wTF5L8RdRlfG6lVUxFJQ0Yj5+/TUcM4GI9Oo6o99NggH8uwuW2dpjnHQMFWNevuiH3Dq
         U+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769136933; x=1769741733;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GTE7C5Gjv9kLwWxOiz+RqSwes3LIaw/84aycTQbuGU=;
        b=BZuc1EpympfksUdK3Qm7MTXigfi5ACEItX9Km2Tp1mmDKf5/MQfkxLHl4jviBWfBLo
         deSCBMVJ9IqhWYiyUDyNh5PgBcrVqUN+DHy44yzQ7Ac/62oBxjFvZiOkj+PRQFu/49GT
         5u7wfxWejjgefw2bYcQ92jcieWz9ic5ogX4s8LseRm2UOMk0B5Wg2sx5bwfbfyMjvnKe
         V2fpHLBI1vyvfZr9Q1ksylSnNIYS6KN6pgmd2jwzb5ZGJ6mHE2yhWEMYvJzKVkQjNe4c
         9QNmiO+2A7jTVqmBYvhRZMniNT9tVM5Km9hSsFYh3Lrm4yl9bJbgOHHun3mHFjS9O7jT
         OIEg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ukutMjAqXFs8L9HZjPrBcXf3qUtzUB8KcQvBhMw/OkUkEk0uyCY9fTtgLhFAAVng/Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5+6PbjAfK832SiQWO3kv82Z5845XuSjC/euQndPL55kmZBnc
	OX4kgHVd+0NAoCwaDCvDAdavsGOudXaJbxm4Moft263QcXkm/HwXFAEJF+dFwdiD+5Y=
X-Gm-Gg: AZuq6aKUj/clIMAQzTjVRfSffEljv4WCXVrCHKP+gX2ry6WQChb8LAyysh0Um0lzfd+
	jPSv1e2BntxZ01ZSqso4q8DLuSh/hBGRnyOFRj/GymTi4dd2N1crJZxNwjIhgeRMZPzURtDLpTl
	Rud+zMEnhIITD/DxVXU4RtwJwBV+wXqkQA2w103xa8l5OULvW00C/OzoRk7ltqPamAdnuX/Wxs2
	Z4bE+JP0pUxRFrFodj+iCwOOydWp7mUFpbruAm9u+AInjM7btx+Eprift0DQiNE46O42dL9CN2h
	jfTbxA92HX7hT1egfXLGGMUdF80xq6Oa9/PvQnoJAb40woMgsB49ljwXw/UOiJAKH/WR3u6ODDk
	sDA/4uP31Ym5MEj85T2bkgcP5190WtUZdnhso8zohAyGHF1ePE5FjK5R0g9gpGkDGq06QwmEU0K
	OBcLLppxWSP74=
X-Received: by 2002:a05:6214:f21:b0:894:2f04:eb14 with SMTP id 6a1803df08f44-894901eafcamr26334716d6.45.1769136932627;
        Thu, 22 Jan 2026 18:55:32 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949191ed9csm7589256d6.38.2026.01.22.18.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 18:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 21:55:30 -0500
Message-Id: <DFVMPA5US3UL.W4YJBEEMH2QS@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <etsal@meta.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
 <song@kernel.org>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH 09/13] selftests: bpf: Add libarena selftests for the
 bump allocator
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260122160131.2238331-10-etsal@meta.com>
 <aae3bad1567ae22ff12276f74cf960129c7aea8186be32a22f5ee465f99efc49@mail.kernel.org>
In-Reply-To: <aae3bad1567ae22ff12276f74cf960129c7aea8186be32a22f5ee465f99efc49@mail.kernel.org>

On Thu Jan 22, 2026 at 11:58 AM EST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump=
.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
>> new file mode 100644
>> index 000000000000..a8f0e6e01e4b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
>
> [ ... ]
>
>> +int asan_test_bump_blob_one(void)
>> +{
>> +	volatile struct blob __arena *blob;
>> +	const size_t alignment =3D 1;
>> +
>> +	blob =3D bump_alloc(sizeof(blob) - 1, alignment);
>                          ^^^^^^^^^^^^
>
> Is sizeof(blob) intended here? Since blob is declared as a pointer
> (volatile struct blob __arena *blob), sizeof(blob) returns the size of
> the pointer (8 bytes on 64-bit) rather than sizeof(struct blob) which
> is 60 bytes.
>
> This means the allocation is only 7 bytes, but the test later accesses
> blob->oob at offset 59. Should this be sizeof(*blob) - 1 instead?
>
> [ ... ]
>

Ack, the test is currently passing because we test only offsets 0 and
sizeof(*blob) + 1. Will fix.

>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.=
c b/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c
>> new file mode 100644
>> index 000000000000..99caae452343
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c
>
> [ ... ]
>
>> +#define ST_MAX_PAGES 8
>> +#define ST_MAX_BYTES (ST_MAX_PAGES * __PAGE_SIZE)
>
> [ ... ]
>
>> +static int bump_selftest_alloc_multiple(u64 bytes, u64 alignment)
>> +{
>> +	void __arena *mem1, *mem2;
>> +	int ret;
>> +
>> +	/* Initialize the allocator */
>> +	ret =3D bump_init(ST_MAX_PAGES);
>> +	if (ret) {
>> +		bpf_printk("bump_init failed with %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	mem1 =3D ALLOC_OR_FAIL(bytes, alignment);
>> +	st_memset(mem1, ST_PATTERN1, bytes);
>> +
>> +	mem2 =3D ALLOC_OR_FAIL(bytes, alignment);
>> +	st_memset(mem2, ST_PATTERN1, ST_PATTERN2);
>                         ^^^^^^^^^^^  ^^^^^^^^^^^
>
> The st_memset signature is st_memset(mem, byte, size). This call passes
> ST_PATTERN1 (0xAA) as the byte pattern and ST_PATTERN2 (0x55 =3D 85) as
> the size, but later CHECK_OR_FAIL(mem2, ST_PATTERN2, bytes) expects mem2
> to contain ST_PATTERN2.
>
> Should this be st_memset(mem2, ST_PATTERN2, bytes)?
>
> Note: This code is currently unreachable due to the loop condition issue
> described below.
>

Ack, will update.

> [ ... ]
>
>> +SEC("syscall")
>> +int bump_selftest(void)
>> +{
>> +	u64 bytes =3D 128;
>> +	u64 alignment =3D 1;
>> +
>> +	for (bytes =3D __PAGE_SIZE; bytes <=3D ST_MAX_PAGES && can_loop;
>                                   ^^^^^^^^^^^^^^^^^^^^^^^
>
> The loop condition compares bytes (in bytes, initialized to __PAGE_SIZE
> which is typically 4096) against ST_MAX_PAGES (8, a page count). Since
> 4096 > 8 is always true, the condition bytes <=3D ST_MAX_PAGES is always
> false and this loop never executes.
>
> Should this compare against ST_MAX_BYTES instead?
>

Ack, will use ST_MAX_PAGES * __PAGE_SIZE as the bound.

>> +	     bytes <<=3D 1) {
>> +		for (alignment =3D 1; alignment <=3D ST_MAX_ALIGNMENT && can_loop;
>> +		     alignment <<=3D 1) {
>> +			/* Each test manages its own allocator lifecycle */
>> +			BUMP_ALLOC_SELFTEST(alloc_single, bytes, alignment);
>> +			BUMP_ALLOC_SELFTEST(alloc_multiple, bytes, alignment);
>> +		}
>> +	}
>> +
>> +	BUMP_ALLOC_SELFTEST(alloc_aligned);
>> +
>> +	for (alignment =3D __PAGE_SIZE; bytes <=3D ST_MAX_PAGES && can_loop;
>             ^^^^^^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^
>> +	     bytes <<=3D 1)
>
> This loop initializes alignment but tests and advances bytes. The
> condition bytes <=3D ST_MAX_PAGES is false (bytes retains its value from
> the previous loop), so this loop also never executes.
>
> Was the intent to iterate over different alignment values? If so, both
> the condition and the increment should use alignment.
>

Ack, same issue and solution as above.

>> +		BUMP_ALLOC_SELFTEST(alloc_exhaustion,
>> +				    ST_MAX_PAGES * __PAGE_SIZE, alignment);
>> +
>> +	return 0;
>> +}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/212569=
73563

