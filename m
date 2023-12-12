Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGtsPQEN"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DDAF
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 13:39:35 -0800 (PST)
Message-ID: <bff66df3-bd32-445a-89a8-b6208d87ae0c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702417173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtHkWtKDZIWRGM6nVH86yaMWVlRAw9f0SdqaAaLKyZA=;
	b=qGtsPQENdOH+G71L28+xdAbGkjR9UT4Nz9cSXDw3zPa/1KxeXgjJhx0UuAlkc2swA/4m0H
	Lz8Tm+CM+dw3292rpfWTedmYs7pVlIpjTroOhDHQdUcVoMh3/RKp6TtHl2GZieQWHThF9l
	8GeMFsd0HIE3vXX4hw0am7ujbKWe6Cw=
Date: Tue, 12 Dec 2023 13:39:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: Relax time_tai test for equal
 timestamps in tai_forward
Content-Language: en-GB
To: YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
 Kurt Kanzenbach <kurt@linutronix.de>
References: <20231212182911.3784108-1-zhuyifei@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231212182911.3784108-1-zhuyifei@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/12/23 10:29 AM, YiFei Zhu wrote:
> We're observing test flakiness on an arm64 platform which might not
> have timestamps as precise as x86. The test log looks like:
>
>    test_time_tai:PASS:tai_open 0 nsec
>    test_time_tai:PASS:test_run 0 nsec
>    test_time_tai:PASS:tai_ts1 0 nsec
>    test_time_tai:PASS:tai_ts2 0 nsec
>    test_time_tai:FAIL:tai_forward unexpected tai_forward: actual 1702348135471494160 <= expected 1702348135471494160
>    test_time_tai:PASS:tai_gettime 0 nsec
>    test_time_tai:PASS:tai_future_ts1 0 nsec
>    test_time_tai:PASS:tai_future_ts2 0 nsec
>    test_time_tai:PASS:tai_range_ts1 0 nsec
>    test_time_tai:PASS:tai_range_ts2 0 nsec
>    #199     time_tai:FAIL
>
> This patch changes ASSERT_GT to ASSERT_GE in the tai_forward assertion
> so that equal timestamps are permitted.
>
> Fixes: 64e15820b987 ("selftests/bpf: Add BPF-helper test for CLOCK_TAI access")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/time_tai.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/time_tai.c b/tools/testing/selftests/bpf/prog_tests/time_tai.c
> index a31119823666..f45af1b0ef2c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/time_tai.c
> +++ b/tools/testing/selftests/bpf/prog_tests/time_tai.c
> @@ -56,7 +56,7 @@ void test_time_tai(void)
>   	ASSERT_NEQ(ts2, 0, "tai_ts2");
>   
>   	/* TAI is moving forward only */
> -	ASSERT_GT(ts2, ts1, "tai_forward");
> +	ASSERT_GE(ts2, ts1, "tai_forward");

Can we guard the new change with arm64 specific macro?

>   
>   	/* Check for future */
>   	ret = clock_gettime(CLOCK_TAI, &now_tai);
