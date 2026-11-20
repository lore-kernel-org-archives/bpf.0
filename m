Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173137;
	b=x5QkEUfeo++OrxRMYWL/51o4v+3vNbqVZa4RsACrp+JAdQjj9Qg0OIHZnuTRqSzcJwrq
	 ES/q5cCnMbrJ5hu1m0Q5xeeTRwliWzIvVnBtmMg1JZL5h1s7UO1sMLOVyehiinBGfoOE/
	 F9UARwL3q0sPTXphK4uX3EwLUxRIlWwyjcKI/cpvcnW07cdO+eZZ7pnQPdM/7W9MkT0RG
	 KYxqfSl+h2ozcGkCl6B8hJ1knxo9lkm5Obcqr/bEm8MOlzQBVrmRMxXU5zwMmrLKKYCve
	 MU3zQJmvGCs15TFDhLmUqVBISDkdFQWBfwGdr8HaC28Dp4DIE1G+MJvfXHyccC2jJIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yZBmwqt8da4UFm+1d0QWKAzDHSPblHyqXKRR7IX1aMk=;
	b=kkbOIWIAc+moS2mb1lGTmsn77zPDIKat4tH8y+LjbEU1QR814DUC91sl0e9Vo0eR9DI2
	 gotwZxOnkxtW/Q/hCe+y87HZRbH8hqLDGY6H8IbGPJSgQBYbRmlLS+LHHXFiOkvKqXJl6
	 0/OJqgPFpoN8Q/xvy2xt8JY8M2HhC4/zc1pHsn5cp25Dq7vDfN07VrVijEDFhSyyxBs6v
	 ZNIsvwANvwGrRbaAlOMnFgCt7ZkDMSY0UMxU1jZ2DeAVubUxWzii/A+hFzOcOZ1jvKk6A
	 +gZh6JUXRZoPevc5gs9e3jTLRqKvzMp9OTvdyCFMrf3074fIuXQAo7kq427njf+4cCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKGQFwVY;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9460A382C
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E9460A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKGQFwVY
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b87a92c17eso1125102a12.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 03:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795173136; x=1795777936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZBmwqt8da4UFm+1d0QWKAzDHSPblHyqXKRR7IX1aMk=;
        b=SKGQFwVYX/8x5JrKdA/bzBuQ+pNkcYhbsPwLvOY6G++cpT6HgC9PTz0K4A7JCxpqsu
         9cbg1fIYw8ViL+g8I5WOKR1uZ/HhuZnCOeTmosIaZzbr18Wdqti3GrorHEPhuZWwWOfn
         6wQctVQ25nKRKzcXcbPqqSJC1pjTOZJnbK+OTGcOQVSGYsMT7s61H1JKL9ERBpkUgiyb
         QX/0eUx7G5unH9Vl7r2bVx1MMwC4FfFxls0i2WX7P/Oj2+syxuqJS9LDI9IvJqIXY5NO
         u1bwRfqOlhMc5Af2y7TpeoYxpkXM2P2dHSh9zw4oFildNocxiBtGSZj90fd9JqoM+0YO
         xBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173136; x=1795777936;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZBmwqt8da4UFm+1d0QWKAzDHSPblHyqXKRR7IX1aMk=;
        b=ARn+LuTXA+Rw51Q4E5DTet0X7kOaC3hKye+/sBjIBMSPJrKiDdqb9QCqGtY+lZFJV8
         UWErAgwAIRik5Ei/Ld31Uvx0kshnIXF1wZzwg23JOjjv0GL0/IgTg0Z4ar4PSpeLKdmM
         fW3lgs0Rl0dnQ08qu/9U2p6GhLtTwrbbiC5Ak62Aj3eskyR2RmXf/D1uqPDReXaCe/BM
         II4BlQJ77UlstPx4gwfUeE6v5MjHxAARqa4qCwSzMsxD71ZD0DGbElIcLUi71XXMyDbU
         wG9RcaBF8XBPR6i7pE+B3Vt9PqifosLNopxBQOzNINJFghoxdknKmOP3ZuIIgJPjqd7q
         gylg==
X-Forwarded-Encrypted: i=1; AL+hErH/iBfPO58NVEpup8p2W3NQlCtUl8igaLl0CgIIeU6CIrpBIyE7O3JIDecS0oys/AX6LIM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2UaBETW/e6eIROj4d6hfrvc88JOGmUU7VXEFlBILOQDssYZEi
	77E3HjkTPiNs+SMr4FWur3rRCMgQ+gFxqghqx9DZILB0VmAwhayTSj7fkCUV0NQQzc0=
X-Gm-Gg: AZFdTZfWe80TB23ua/6+m4uE5ZrD8IbWYZKPGpDCkhQuzsMSzIvRgoseUdFaUAINVjD
	/e2xMuxRt117iLH02TbvidE8xYR/5Gr1INK7Rgqi2jE/kuh0iarppmQ/IDITd4WU0j4JmBqBOLS
	aYK9RS89TuIqrWlFxlzJOB4TYXQV28VB8YhE3xXWVgSB7p/HniLZJDhsElVWtW1LXLMGiWZgzB5
	ZxpZsbHkaNcF1zcehw72Y/tl4l/X3gCJeUFVeE5Y9roDmYFOh9Chf7HoHQuomt9DJ+xgI3F+hyG
	i5jL1cGTMGQVPEGMmPnbNT1qE+BFhKbT2hMKOtk3t0j+LMuq/WfPwFtsyhhISRZcCeDZyadZCdK
	g/LoZvB3T8vdytn6Ciw0Md2N8rk6WRC0smmrtI+i/Y5kWCDzmAi/DYC8ELD3IQAb/AEjFgAaKDe
	yZOtkt1Q2DMqC0flYGxbTcQlIhwFsJDx03BisnSwRGX0zzukrvZv6gx6IiI79E+aclp8/PrH6jF
	u2i2cWJ94DpnfYmRHn5MbdwbaD84EmyND4x5shcxBkTld8CTM+zaGwlvbg2XI+zeRPySfVzNhKD
	W2jsxF+/ATkQ+7+Dlkr84mK4s1Od3EP8RUftdZv/CSWA6ICRQ4l+CJi2AzU2rffH/2yYY1/GcbN
	rRC5+c8N0xrcf
X-Received: by 2002:aa7:d155:0:b0:6b5:913f:4de6 with SMTP id 4fb4d7f45d1cf-6ba37c7c38fmr1291852a12.4.1795173135498;
        Fri, 20 Nov 2026 03:12:15 -0800 (PST)
Received: from ?IPV6:2a02:8109:a307:d900:2e59:c703:9195:689c? ([2a02:8109:a307:d900:2e59:c703:9195:689c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cbf42sm1010045a12.7.2026.11.20.03.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 03:12:14 -0800 (PST)
Message-ID: <1b146f18-a7b8-417d-90f3-3b0cdb3f9894@gmail.com>
Date: Fri, 20 Nov 2026 11:12:12 +0000
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
Subject: Re: [PATCH bpf-next v4 3/6] selftests/bpf: Test task work scheduling
 on a deleted value
To: Yun Lu <luyun_611@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org
References: <20261119033051.196177-1-luyun_611@163.com>
 <20261119033051.196177-4-luyun_611@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20261119033051.196177-4-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/26 3:30 AM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> Add a deleted-value case to task_work_stress. A syscall program looks up
> a HASH value, deletes it and schedules task work through the retained
> pointer. Assert that scheduling returns -ENOENT; positive step codes
> distinguish setup failures from the unfixed kernel's return value of 0.
> 
> Reuse process_work(), which only counts callbacks and does not dereference
> the old key or value.
> 
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>  .../bpf/prog_tests/task_work_stress.c          | 18 ++++++++++++++++++
>  .../selftests/bpf/progs/task_work_stress.c     | 17 +++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_work_stress.c b/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
> index 450d17d91a56..90d6d696537d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_work_stress.c
> @@ -121,8 +121,26 @@ cleanup:
>  	task_work_stress__destroy(skel);
>  }
>  
> +static void task_work_deleted(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct task_work_stress *skel;
> +	int err;
> +
> +	skel = task_work_stress__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.schedule_deleted_task_work),
> +				     &opts);
> +	if (ASSERT_OK(err, "schedule_deleted_task_work"))
> +		ASSERT_EQ((int)opts.retval, -ENOENT, "deleted schedule rejected");
> +	task_work_stress__destroy(skel);
> +}

This is not really a stress test, not sure if it's a good idea to have 
it in this file.
Maybe move to the test_task_work.c and ditch the userspace part, using 
__retval and RUN_TESTS

> +
>  void test_task_work_stress(void)
>  {
> +	if (test__start_subtest("deleted"))
> +		task_work_deleted();
>  	if (test__start_subtest("no_delete"))
>  		task_work_run(false);
>  	if (test__start_subtest("with_delete"))
> diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
> index 1d4378f351ef..5f47133ad308 100644
> --- a/tools/testing/selftests/bpf/progs/task_work_stress.c
> +++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
> @@ -71,3 +71,20 @@ int delete_task_work(void *ctx)
>  		__sync_fetch_and_add(&delete_success, 1);
>  	return 0;
>  }
> +
> +SEC("syscall")
> +int schedule_deleted_task_work(void *ctx)
> +{
> +	struct elem empty = {}, *value;
> +	int key = 0;
> +
> +	if (bpf_map_update_elem(&hmap, &key, &empty, BPF_NOEXIST))
> +		return 1;
> +	value = bpf_map_lookup_elem(&hmap, &key);
> +	if (!value)
> +		return 2;
> +	if (bpf_map_delete_elem(&hmap, &key))
> +		return 3;
> +	return bpf_task_work_schedule_signal(bpf_get_current_task_btf(),
> +					     &value->tw, &hmap, process_work);
> +}

