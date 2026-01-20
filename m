Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799503EFD11
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924095; cv=none; b=nfRBNLkfC/NqICGnV1GhAEp0CcGSsHEBxiaRvPmAIZp3JGoMZSqzsZiOHVtc0dwYeQsOnLM2FuSnSoxreZkVzTda0PIqPRP0b53w+KtIIX5G2LNChOjJ9xlqlY26fmJZBaFlebJYQH4/QiNG3pIiNFcKfRMWRlmG55EcOsvPN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924095; c=relaxed/simple;
	bh=Efu9caATgXLsnG+9j/C3/ytQq8Ix1LHJrzl/rE9RVPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYGDcvezVNBhuyrbj3xp2/4UYMcJ9O1BzLAU6vPdsun6ywM4yn6S+yMVJnfLxT5CB/wWsAWxkuoobC+UzVJjyKytxXWIg0qrvY+6ZCzDXcCcJ3IEgOhrm8jNjFrUAXZEayFM3kj/csLDXpBLmg/UUZtJ2Hgl+d9dqI1yd17Gxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kJx9a01k; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kJx9a01k"
Message-ID: <922f96dc-9093-4f7a-9cbb-32c230856247@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768924091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGRMdJEJX/Nxz+Z5wRxBL43/VPYWLg/rSnSKU0WFCrw=;
	b=kJx9a01kJWJL99iS05+GEUVKQ/5c9+C+ZkwVXqC/NwfY5jzLJ46ptOWwl9jKpemOTOHJnu
	T+K3b3ys0xEat+CzayH7K6zQcTppoa6C0naJJWzzpfXTuO15rxZ3ImhpGv6WZ9byKQPEzo
	XlHH5kdssIR4zLTRibdDQbpxfFULq10=
Date: Tue, 20 Jan 2026 07:48:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: wq: fix skel leak in serial_test_wq()
Content-Language: en-GB
To: Kery Qi <qikeyu2017@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, shuah@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, yatsenko@meta.com, bentiss@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260120091201.1718-2-qikeyu2017@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260120091201.1718-2-qikeyu2017@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/20/26 1:12 AM, Kery Qi wrote:
> When wq__attach() fails, serial_test_wq() returns early without calling
> wq__destroy(), leaking the skeleton resources allocated by
> wq__open_and_load().
>
> Fix this by jumping to a common clean_up label that calls wq__destroy()
> on all exit paths after successful open_and_load.
>
> Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/wq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
> index 1dcdeda84853..b32e22876492 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -17,11 +17,11 @@ void serial_test_wq(void)
>   
>   	wq_skel = wq__open_and_load();
>   	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
> -		return;
> +		goto clean_up;

This is incorrect. Just doing 'return' is correct. Probably
rename "wq_skel_load" to "wq__open_and_load".

>   
>   	err = wq__attach(wq_skel);
>   	if (!ASSERT_OK(err, "wq_attach"))
> -		goto clean_up
> +		goto clean_up;

Your patch is not on top of latest bpf-next.

>   
>   	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
>   	err = bpf_prog_test_run_opts(prog_fd, &topts);

