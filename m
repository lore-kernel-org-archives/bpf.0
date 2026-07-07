Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606B1684BE
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383667; cv=none; b=EObIP1yq7x8N5SgTvB/bVaLb+26ovYbJZ5rQ+EoaPJ4hIloYNkUU3u/AiDhq+1Q5aVFYgBzDmIZDSxf4nINbn0I+C4Xh4jiK/pM/0tXcE8peb15TrKTugBz6Bk2XnG5nT/nhACICbMH1TfSHwVVyEpgAMsRa/sbUSEhTc+6PhTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383667; c=relaxed/simple;
	bh=miE+Y3WH60BzchHqGCDajC/ToVfvReRugfPL1D/wSno=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dqzA9CIERqH/tCKOo/4wUwILjvukngs48pQIdtUKC99CRfcwNCZGnVNYgRaBtAUjfGfgvoTRxr10FisVs7gQJW1pJQRG05OQZb1DOkOp6b2QoM+aBu129ziIM9UELeUiP2rDEy8n34sbSAluxUMzOpNG7mNQ6g6s9SSnWZppEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Skd6aLEV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Skd6aLEV"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-842338c18e0so2931165b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783383665; x=1783988465; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4KanqF3ysTPoeu0lvcWR2n04d9CNPHluxwpkP6XXJRY=;
        b=Skd6aLEVJXWzdJJ6/ktE8A1ndNPrYJ5821pDiPDkZa9k5kJX/4HhKrzT+3qmPbPGKU
         DO/JomHl/q7zBw5q1Kkcs4Y7Qf3QtosNWGwpglJzXzTeiTqkCjpUWCGbJxRqP9l/812R
         4PeNHJGP+03bxGqQS850wV/LfKf7VEoBC+r5KTHXBCVrRFqKTSHUh+E5uEAlBk1yGgKN
         N8N79vLYv9p5GjAgu1PVgNM+kxVFjUpiZ3BN5RkQ1QR5oB6sPcTNGLHkPo8yfJZ7teaT
         BobkCRUZGlM++LtySI1NVch6gVSZaB/6npYrevqmgmYJDwUPG0iMTXEFF8LGt+7hvCx3
         ZTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783383665; x=1783988465;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KanqF3ysTPoeu0lvcWR2n04d9CNPHluxwpkP6XXJRY=;
        b=Oyu31vqIn6JRVIk0uq8dywnzJ6XTPcR+0OMDZhAwxJvy9t91zbkdt7Ll62bhFJBHyx
         7XC6K7JlW4hUFMDqSSCf3Dnll6T8lFgp2pjGA3IvmjT3/ur1iFaTCnZ0BHpAb/PH3ucH
         LjNb7NaOu9HjIo3sE3NaCuOzCYnJX0kMc1R8TuTBbVJ8u4s8GNB/JSfyAU8fJJ6MU25x
         3DA9CVMr+ULpsqWb32+IOCvAecMGarnB1xKr6LGZt/003OH+UaGVZTajFAp1NQZ23D1M
         lsKK9+9V4kRk4SPfJ/2EFlgqHn3Q3vmk4YAQHEemUL+UQi2oVutr81eJ1CYJ/1zhWmv1
         XZtQ==
X-Gm-Message-State: AOJu0YxAOpiLLIrbRnxKqsiZGLeN96zccOKh3u2yVENwlgQLmHGFen9o
	aKN8ryexR2sMEX/+KSJlAGcYc+DJtMACmBczcs6Wn6/gmH0AuaSbA9YP66S2rz91aFQ=
X-Gm-Gg: AfdE7cmfBMzDHxomvZ6TTUcxgh2xi8jZsbydN3NOlXu1jgLY20aQ0uI8HwaOrqCBqxk
	z34kojUhQ5NX8s9eDj6ZtYHDQwSKTU1FpQrVLaqo2lqaUtcRvUkBWQJDh/saqa2WPnMKrr8iOqI
	dyKu+hDMLp2GLOLDwd++zLPKqU50wIIMErx6k5ovKoYFgkDDE/OYDDWOSKYWKyCWcHTMBDRTdzp
	uQuIV2Erp0jBpRTp3uTLVNB0Q4z2bs9hvKjPxgILCcdH7GTYJ4562t6qQddVtA1gjLkd2rk8d8n
	DXG8/nvMasTWk+/eFwWBfGFYeO57y89KFtDBq9nJCQ2TDC3qVOZDQpqlz5kmrd9I+PmbsFMTk/0
	y4+K6ocNdmx73gOB0FWxL0MgRReVInvRpjYPSJlvDH8dA6EfM9LjYm21vhYAPBNq2tBxpVxVJm5
	8wYgcbVwr6KnW3QYb3tbMmRGzVEPcyWebw+1G54UQ/qA==
X-Received: by 2002:a05:6a00:27ab:b0:83a:3135:edbd with SMTP id d2e1a72fcca58-84826d122cdmr2602693b3a.7.1783383665277;
        Mon, 06 Jul 2026 17:21:05 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b36448e7sm147757a12.23.2026.07.06.17.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 17:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 20:21:03 -0400
Message-Id: <DJRWQWKLMY87.5ING2IA83CYG@etsalapatis.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: veristat: Minimize map size
 during verification
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706225052.35543-1-emil@etsalapatis.com>
 <20260706230339.A8A981F000E9@smtp.kernel.org>
In-Reply-To: <20260706230339.A8A981F000E9@smtp.kernel.org>

On Mon Jul 6, 2026 at 7:03 PM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Setting `max_entries` to 1 for `BPF_MAP_TYPE_RHASH` maps cause=
s map creation to fail if `map_extra` > 1.
> --
>
> --- Patch [1]: [PATCH bpf-next] selftests/bpf: veristat: Minimize map siz=
e during verification ---
> commit a11623d3f77bb05764867d10c3ff357f2a8a1403
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> selftests/bpf: veristat: Minimize map size during verification
>
> The veristat tool loads objects and maps into the kernel to verify them.
> This patch expands veristat to resize maps whose max_entries are not
> relevant to verification to as low as possible to avoid -ENOMEM errors
> on smaller test machines.
>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/self=
tests/bpf/veristat.c
>> index a7db6f04f7e14..8d374e1406532 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
> [ ... ]
>> @@ -1248,6 +1263,37 @@ static void fixup_obj_maps(struct bpf_object *obj=
)
>> =20
>>  		/* fix up map size, if necessary */
>>  		switch (bpf_map__type(map)) {
>> +		/*
>> +		 * if the verifier doesn't use max_entries
>> +		 * then set to 1 to avoid -ENOMEM
>> +		 */
>> +		case BPF_MAP_TYPE_HASH:
>> +		case BPF_MAP_TYPE_PERCPU_HASH:
>> +		case BPF_MAP_TYPE_LRU_HASH:
>> +		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
>> +		case BPF_MAP_TYPE_HASH_OF_MAPS:
>> +		case BPF_MAP_TYPE_RHASH:
>> +		case BPF_MAP_TYPE_SOCKHASH:
>> +		case BPF_MAP_TYPE_DEVMAP_HASH:
>> +		case BPF_MAP_TYPE_LPM_TRIE:
>> +		case BPF_MAP_TYPE_QUEUE:
>> +		case BPF_MAP_TYPE_STACK:
>> +		case BPF_MAP_TYPE_BLOOM_FILTER:
>> +		case BPF_MAP_TYPE_STACK_TRACE:
>> +			bpf_map__set_max_entries(map, 1);
>> +			break;
>
> [Severity: Medium]
> Will setting max_entries to 1 cause map creation to fail for
> BPF_MAP_TYPE_RHASH maps that have map_extra set to greater than 1?
>
> The kernel's rhtab_map_alloc_check() enforces that map_extra must be less
> than or equal to max_entries. If a BPF program legitimately uses an RHASH
> map with a map_extra preallocation hint greater than 1, this unconditiona=
l
> minimization will cause an -EINVAL load failure, making veristat erroneou=
sly
> report a verification failure.
>
> Does veristat also need to adjust map_extra when reducing max_entries for
> RHASH maps?

The concern is valid, the fix imo is not. Rhashtable is resizable in the
first place, so we shouldn't be trying to reduce its maximum entries.
Same holds for LPM_TRIE and for arena (my worry was we do a memcg
reservation upfront but that's not the case). We can just remove all
three from the list to fix this issue and simplify the patch.
