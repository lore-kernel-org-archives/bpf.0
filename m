Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC853ED117
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010326; cv=none; b=NtqLU+JdV68hv+AjiGEWvcWT5+RLtRRFjS81ld44RAMES0q7dnZtdG6QpKtvShO9yV8KNWXyyWQKdn9QA2fBDgiNSFK2Sb7pEYG29pcWNzNNOM39sY43BBU8QrpUSY7e0/RxiVeLQVb2us4wxvdkVqtn4EtX4EqqpD9bQhAcNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010326; c=relaxed/simple;
	bh=Pt5CLMX5wFaSXWP0weaSGI5HqllHKzI7+89DjHdg2MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ycd4y3dX2fBJSBGk/1O2gGsSfrQ8VKbsMWaujz+4JGksj5X2jYZ2NPZaN3QnfxUGdjcwx+j3YM1XG2mxFp+Hw8owmM0oOMIPJRwZ3SV+mEd585BHGAVhZRzGVgqwFhe+v6r8A36Z83rMoLSiVpRiS/63/RwAt4ILH5iBxuMiw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqDiDcVG; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqDiDcVG"
Message-ID: <214f9680-b4ce-4c20-85f1-3560624fb49c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769010312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt5CLMX5wFaSXWP0weaSGI5HqllHKzI7+89DjHdg2MU=;
	b=RqDiDcVGShipHFDgtOK2F354x6Y+09+LaixFwK0WQU2vRqj6KgUHFpEs8ySV5Je6oaH83H
	Ro/zdXYrqLEAT9VZlbwZ5LCZVJMOZzQ76N/LMx4MBzrcYfLhzbRzX+ePMW1vo37oUGfvJo
	u/Fb5t9ZeQ9IeDjLaIRpcciAi1dSxRU=
Date: Wed, 21 Jan 2026 07:45:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: Fix resource leak in serial_test_wq on
 attach failure
Content-Language: en-GB
To: Kery Qi <qikeyu2017@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, shuah@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, yatsenko@meta.com, bentiss@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260121094114.1801-3-qikeyu2017@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260121094114.1801-3-qikeyu2017@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/21/26 1:41 AM, Kery Qi wrote:
> When wq__attach() fails, serial_test_wq() returns early without calling
> wq__destroy(), leaking the skeleton resources allocated by
> wq__open_and_load(). This causes ASAN leak reports in selftests runs.
>
> Fix this by jumping to a common clean_up label that calls wq__destroy()
> on all exit paths after successful open_and_load.
>
> Note that the early return after wq__open_and_load() failure is correct
> and doesn't need fixing, since that function returns NULL on failure
> (after internally cleaning up any partial allocations).
>
> Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

