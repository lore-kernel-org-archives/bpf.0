Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47756378D87
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703936; cv=none; b=kmuG5fs1nb2r4D+JU4Sl0sLA15Lfn3JmFIxIxyhv7gZo/Fz0RHaEYkByMHUFUDsXfTlqvc3ctwkaA1Xv2ycvY51MwPGjkiC1oMlTSOhbbSw9yOy1/DZMgm3sDiXeZznOI9kkXUR+lkM6ZIQSXwX1x3QN7WQyfvUrw5IsnWONcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703936; c=relaxed/simple;
	bh=Kxi+WBS9YMy1saAUSaYtPzYaZTtXBUg1DFgRCzPc8ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XErpBRH62BmoPpcUQrZedVUJZa7HbXbatEZTDaiG+obMPNUh4tAzre3NUnwvf5JcpXZBUQq/+B3blKENvxxg5al/Hlf3sigJou1HRRsN2hVYhYKu60ta/gKzPp1lscohhXjEo6IL3ABIr4eujD5bRV5d35ahx3rXq07bXZBURjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrVUYNDz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrVUYNDz"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ad135063so26481205e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776703933; x=1777308733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7WVV2rXlZkPThmov5vqqJDurN8/X/UV4KgQra6/Gw8=;
        b=VrVUYNDzT9mAzVMIBiXkSuHzsGk8zvrEymZtR+ULtO3PDH3kkJmX1kSGN9VAL0+mpo
         Z/YoRwBTYeQ4covL8X1ewfWlmxi+TuEKKixKXzvLqU7ePkfeWUa7MoWSDwieSyVZbvPN
         vL3SRb7scVuXY6CEM5gVZZQ2Hj8XQIIE4rNJW+WyKOOGtiKb6VBpx8/LBlU4RqxlFO1T
         qtN2FWW7LG5Vq6m5o15mSjB2O6zJCVgn3ylXrzpWG/pBYHYTYp3S4pb9vPf0HbyK/xbz
         +7P1TKNCbumYoCElJZ+3f17sAw0Z+YuC1KtPuRsdm/PFWt/LqKryAOruuLAFU91Zi8ZH
         xUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776703933; x=1777308733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7WVV2rXlZkPThmov5vqqJDurN8/X/UV4KgQra6/Gw8=;
        b=DxC/V6j3ty8ttgjsa49Cwu1S95PEWdTn5F8goxmQoebMq046/OQM+MT8r8tillOEgy
         aIBUPAEcxPJZeV1ga/j33AIWaTWGUJSt4/rkE3MONT/QyWg6jmnmPfVC+miZj5YkhvBw
         /P30kqR3USsmBOnBq0zlmzPLqI92vSy2Y76wb06fOhHnq+6sbfkZvpORn7A0qtrlqcv8
         lhfvHEhWY4UXDQ6hE6CdfxS4OROjMk12m02SSrS4QzqvWIhwHw27EQJeTJFTivBpTcuH
         u+sTtmchSwJ2T5L52xQRd+GMcsfoTf1LjL1DI9RPCcsmaFAi1NZ4PmFoLkKvlSwwpJOf
         /RkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KU7Nc4NA3sT8P/ML2xgiY78CWhSE0Z5DJuvaep7PFHqkmnN+rD5s/K/WNBBIuF4jbo+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtKlxzZni1opezPQ2k5qSj8kQfuGkv597a04KI39lQnl9k6aV
	xpmQnEICEJQ+5CPofWpDhCH3mF4GjsXHA05Hzi1s2YIi2al6FpkchxMm
X-Gm-Gg: AeBDieuX72ZGxisExA4WfPGgvPCgGBNYCepb1UrsIUH1y8oZTjkexwgMh92e00RWhJc
	dancZMlooGxVXS+sTzXzxoiGDfYJNCeXisbWCm8gGXK1dKEdkaN/qkxjojXi5XqulPrBsQiXfW4
	AClpoSsHEfkVNBsEQvc1P3su3ig21c++kII9LxeF1wQiN7nouQO4b5qCqFy7rw17oBi8062I2fP
	yeNTafsCbQIB2KAW8hjengGGbAzaQ3SCy/lMsEU+ezSjgON+V5od4iHraKobxNN2LL4lH7tRUia
	fOTclUpnwyKnvC11pKcWWjL3Phy/OVcds3NaURcEX6WODXdtJSHQsx50Hj/PI8sBEyxPdSLP2/z
	yhF5kOCdM3MC1NIgeqdtY7SthqkHU1DWSrzS/GAy6gjmz78T+tBiGi2U1HAO8t01gNDD9aaWGGm
	mlMJ75UqFeghOgnuhmgz28xUqoiHRY9jBq8R6+kHpgIZiQZPxXmbUDax3jUavKRMg7hQ0PGw==
X-Received: by 2002:a05:600c:a40a:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-4891ba85dc1mr67435325e9.21.1776703932396;
        Mon, 20 Apr 2026 09:52:12 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5432:2d05:ea5:f7f7? ([2620:10d:c092:500::6:8ffd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb11b4sm31219009f8f.2.2026.04.20.09.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 09:52:12 -0700 (PDT)
Message-ID: <f02fd939-85f7-414a-8b03-a9ebe56c7660@gmail.com>
Date: Mon, 20 Apr 2026 17:52:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Page out as late a possible in file_reader
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420134637.2513867-1-jmarchan@redhat.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260420134637.2513867-1-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/20/26 2:46 PM, Jerome Marchand wrote:
> The file_reader/on_open_expect_fault fails consistently on my system.
> It expects a page fault on first dynptr read of some range the exe
> file of the current process because it has paged out that page range
> earlier. However a lot can happen to that range (which depending on
> the actual memory layout could contain text section, data section,
> sections )related to dynamic linking...) between the moment it was
> paged out and the moment the bpf program expected to hit a pagefault
> actually run.
> 
> A bit of instrumentation with mincore() shows that pages from that
> range were accessed several times before the program is run. In
> particular the call of file_reader__load() seems to fault all the
> range in.
> 
> Move the call to madvise(MADV_PAGEOUT) to just before attaching the
> program to minimize the risk of having those page pulled back in from
> under our feet.
> 
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> ---

Thank you for the patch, the change looks good. Does it fail 
consistently on 4K page size?

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>   .../selftests/bpf/prog_tests/file_reader.c    | 22 +++++++++----------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
> index 5cde32b35da44..48aae7ea0e4bb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/file_reader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
> @@ -10,6 +10,7 @@
>   
>   const char *user_ptr = "hello world";
>   char file_contents[256000];
> +void *addr;
>   
>   void *get_executable_base_addr(void)
>   {
> @@ -26,8 +27,7 @@ void *get_executable_base_addr(void)
>   static int initialize_file_contents(void)
>   {
>   	int fd, page_sz = sysconf(_SC_PAGESIZE);
> -	ssize_t n = 0, cur, off;
> -	void *addr;
> +	ssize_t n = 0, cur;
>   
>   	fd = open("/proc/self/exe", O_RDONLY);
>   	if (!ASSERT_OK_FD(fd, "Open /proc/self/exe\n"))
> @@ -52,16 +52,6 @@ static int initialize_file_contents(void)
>   	/* page-align base file address */
>   	addr = (void *)((unsigned long)addr & ~(page_sz - 1));
>   
> -	/*
> -	 * Page out range 0..512K, use 0..256K for positive tests and
> -	 * 256K..512K for negative tests expecting page faults
> -	 */
> -	for (off = 0; off < sizeof(file_contents) * 2; off += page_sz) {
> -		if (!ASSERT_OK(madvise(addr + off, page_sz, MADV_PAGEOUT),
> -			       "madvise pageout"))
> -			return errno;
> -	}
> -
>   	return 0;
>   }
>   
> @@ -90,6 +80,14 @@ static void run_test(const char *prog_name)
>   	if (!ASSERT_OK(err, "file_reader__load"))
>   		goto cleanup;
>   
> +	/*
> +	 * Page out range 0..512K, use 0..256K for positive tests and
> +	 * 256K..512K for negative tests expecting page faults
> +	 */
> +	if (!ASSERT_OK(madvise(addr, sizeof(file_contents) * 2, MADV_PAGEOUT),
> +		       "madvise pageout"))
> +		goto cleanup;
> +
>   	err = file_reader__attach(skel);
>   	if (!ASSERT_OK(err, "file_reader__attach"))
>   		goto cleanup;

