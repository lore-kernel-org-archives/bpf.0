Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A54501C
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985377; cv=none; b=URU457TAk5LPzq2P1PX1KL55mCt0bLqKtd9dDiOWyQfM6r1SyRJvIBJsctLdI1Uc31Wd276JDfwYqbP1gGEGCidTCpJkC3A5nZlOKEMZgdpD7OJuX+P7CEOrpzJF8yXC7aWwgJAEe15TiRpOpmQq9I5BF38V4wjoc9avgPfaN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985377; c=relaxed/simple;
	bh=ESNh8ZC0bNuTICLqr4QzKNCC2XVA1QdD/0JDwDJQz30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4MZ99At9qHv4PN+KiVyRJKRmVWRNSkazaewAbWBGugmeRib+LMPrODYJhM3dyfPU5ES3bylqH450b1rWND0XlXnX95FsFPIdC454YBz16XckFSoCEtB2vlFCKn/aEfGWH69+mLlN5iie8uutyOIVQp3H1w4RvsHv7hNutzBcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aXwutG+m; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aXwutG+m"
Message-ID: <e4ff18ca-bf80-4209-a032-28916ed2feda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711985372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEl/c7iGwiWA9SmhOVAiCfTtgK3356Ys6nUW4ArfR5A=;
	b=aXwutG+mGLDjRIBx0gCsDZZcX2naKt7olkrlgw3uGa4X96+cEcPIVOeOk79As8svsrhp3I
	4z7MoAxXc2DkuHMkeQq+oNrYIOsZTGeWI5q2eaIk0PiRHhWpCLoGU2Bcuj2E42e+jWiQKd
	xIBUKjFwq+grNQPawJyNbQnoawwIevI=
Date: Mon, 1 Apr 2024 08:29:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip test when perf_event_open
 returns EOPNOTSUPP
Content-Language: en-GB
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240401123336.1124715-1-pulehui@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240401123336.1124715-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/1/24 5:33 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> For the bpf selftest, the semantics of perf_event_open returning ENOENT
> and EOPNOTSUPP imply that continuing the test is meaningless. Let’s skip
> test when perf_event_open returns EOPNOTSUPP, which has already been
> skipped in other test cases.

Could you explain when EOPNOTSUPP is returned for these two tests?
Is this riscv specific? If the EOPNOTSUPP is returned due to missing
config in tools/testing/selftests/bpf/config, we should add that to
ensure the test can execute properly.

>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/send_signal.c            | 2 +-
>   .../testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index b15b343ebb6b..920aee41bd58 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -179,7 +179,7 @@ static void test_send_signal_nmi(bool signal_thread)
>   	pmu_fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */,
>   			 -1 /* cpu */, -1 /* group_fd */, 0 /* flags */);
>   	if (pmu_fd == -1) {
> -		if (errno == ENOENT) {
> +		if (errno == ENOENT || errno == EOPNOTSUPP) {
>   			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
>   			       __func__);
>   			test__skip();
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> index 5db9eec24b5b..0832fd787457 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> @@ -35,7 +35,7 @@ void test_stacktrace_build_id_nmi(void)
>   	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
>   			 0 /* cpu 0 */, -1 /* group id */,
>   			 0 /* flags */);
> -	if (pmu_fd < 0 && errno == ENOENT) {
> +	if (pmu_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
>   		printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>   		test__skip();
>   		goto cleanup;
