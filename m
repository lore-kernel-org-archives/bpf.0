Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229783;
	b=tiI1jXguE+o9c020Zj3PRxojCQy5LPzhsxTex2nsGw/sFruJwfou8UNz0HFJbwESvTBm
	 TQywOuOXqexMankBU53QuD3C98tdoifjREOCOdnvV5lc+Xb+7F3Lap3eVTTkrpcUzXRNO
	 ppEcHOgjfVnKA3XKxwdyp81hTJHqQaK5tZJ5rv6pnHBJ4ascUO0Ni/O5PUtBWwSITtPWu
	 SZegsRb5BAXJr24r07U2uvw6zdAJxvoAdoUUy0PYHf5dzFgOYIDzrqtn6NziF/ngc4Mgx
	 GThyi4PT24tRCBpsFNwEMvIic6OUepF3SWzDakmC2wd/1gbykOZaRjUCv0RcNO+jiHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229783;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HJYo7eIphq1ef4xvgNDYz8prDUR3YfUTp15RCcmtrHg=;
	b=OvGZFlp3GPZDZ6ahsNTFIXtHZot0Uv6onIAELrO7A0+6T7trsjMEMlpXEjPxEOqiQX7C
	 5Jv1f3H+7ZZHOQygbP7Vf/bf0y1blZY1JDDH9WNm+WTPdAL/4gV5ErUDJ5zp9xf43UU1p
	 GJd8UV66swlzUNlRFFx++TjgCsZD1u3+v3fbvFdB0I4SqPsRrDcLoSRPQDLj+i/6gLhkg
	 qJ1dKwShaBol1MBVTHhxRZx5aB7oPXW+Rnc1i4uKgAmhjgc8Nla2W/zyT/MGe9p8v93ir
	 8D10WV449e0K1LoPd/nmC2UGy94BjlO43ccIDy1lf4t7l6KM1ukl/XOCx9wh27tIynQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d4kNOyyf;
	arc=none smtp.remote-ip=91.218.175.140
Received: from mta0.migadu.com (out-140.mta0.migadu.com [91.218.175.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B165606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B165606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d4kNOyyf
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AMi5+Myi2n9bPg1ZV9citIwC6fapgt1eH7rjRc1gRg8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794229780; v=1; x=1794834580;
 b=d4kNOyyfwYMelj/qPma/4HAQ2ppMWIR+Yu+9PtcebqFxfwTmuMb1eYohyHdzR/jjFDyxKta5
 //yzysTK/spQw+9/HetsGPKHSftER4nw1GMHRG2teREpsIrAgCzZcinSMx0fS25ZVzHgggK3kbc
 da4WmvpqUwZqtgs0TBWQZsyE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f740e18e3cd0a89c;
	Mon, 09 Nov 2026 13:09:40 +0000
X-Mizu-Trace-ID: f740e18e3cd0a89c
X-Migadu-Flow: FLOW_OUT
Message-ID: <230c0290-8e5a-461c-bb8e-42b198212140@linux.dev>
Date: Mon, 9 Nov 2026 21:09:31 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, bpf@vger.kernel.org, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Subject: Re: [RFC PATCH v13 3/4] selftests/bpf: add iocost cost model test
To: sashiko-reviews@lists.linux.dev
References: <20261106122356.3224638-1-cui.tao@linux.dev>
 <20261106122356.3224638-4-cui.tao@linux.dev>
 <sashiko-outbox-201410@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <sashiko-outbox-201410@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

在 2026/11/6 20:44, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] selftests/bpf: pread() in serial_test_iocost_model_streams()
>   hits page cache
Confirmed.  The initial buffered read() loop populates the page cache,
so the later pread() calls are served without issuing bios and don't
necessarily exercise the multi-stream path in iocost_ms_calc_cost().

I'll rework the test so the interleaved reads generate actual block
I/O instead of relying on cached pages.

Thanks,
Tao
> --
> 
> commit 371817062abb0b837764b9a93458f77eb2057dd2
> Author: Tao Cui <cuitao@kylinos.cn>
> 
> selftests/bpf: add iocost cost model test
> 
> This commit adds BPF selftests and two example struct_ops cost models for
> blk-iocost using a configfs-backed null_blk device.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
>> new file mode 100644
>> index 0000000000000..a714507c040e3
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
> [ ... ]
>> +void serial_test_iocost_model_streams(void)
>> +{
> [ ... ]
>> +		devfd = open(path, O_RDONLY);
>> +		if (ASSERT_OK(devfd < 0 ? -errno : 0, "open_dev_ms")) {
>> +			char iobuf[4096];
>> +			unsigned long long u1 = 0, u2 = 0;
>> +
>> +			ASSERT_OK(read_cost_usage("/iocost_ms",
>> +						  dev, &u1), "cost_usage_pre");
>> +			for (i = 0; i < 500; i++)
>> +				(void)read(devfd, iobuf, sizeof(iobuf));
>> +			/*
>> +			 * Two interleaved sequential streams: exercise the
>> +			 * stream table, not just a single cursor.
>> +			 */
>> +			for (i = 0; i < 200; i++) {
>> +				(void)pread(devfd, iobuf, sizeof(iobuf),
>> +									(i + 1) * sizeof(iobuf));
>> +				(void)pread(devfd, iobuf, sizeof(iobuf),
>> +									(1 << 20) +
>> +									(i + 1) * sizeof(iobuf));
>> +			}
> 
> [Severity: Medium]
> Do these interleaved pread() calls get satisfied from the block device page
> cache without reaching iocost_ms_calc_cost()?
> 
> Because devfd is opened without O_DIRECT, the preceding 500 sequential
> 4096-byte read() calls populate the page cache for bytes [0, 2048000).
> Both pread() streams read within that cached range ([4096, 823296) and
> [1052672, 1871872)), so no interleaved bios are submitted to the block
> layer and the multi-stream slot table is not exercised while the
> subsequent assertions pass from the initial read() loop alone.
> 

