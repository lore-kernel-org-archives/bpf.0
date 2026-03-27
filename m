Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE2611E
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648839; cv=none; b=Md9nr11h7YvkkwwJEwoZE9kfB1Iu0Iwf/UYdiCs0mNw56djHroliPRqI1eaJEbKcjzPQB1UH6IBGe6uc/45nuQxucuxEhB6Q3IS25QyFH/6irqGECml4GwSaJdbF7Z4Uq5EHCwNdysVmACm7nMDsk//HHl5CY19v8D4QITJqfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648839; c=relaxed/simple;
	bh=wDrPopVN7ZRBjXbv74ikLpTMvaZ5zu8Uxfd7Qx5L+a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HllZCI9HIoiS49/5UBQAds/lX+rBZ7tEIwbKId0XRtwG3RgD9rnYpJRSng1d2ZuzfWMY8AvqO4DGj2ZB3ckgMSFAdK4+w5I0CzCQi+9jCz0rFbVU4YS15mJldebDlsO1Nqc/ryJkaSF5J4sPVO7WjD7sTw/0b4YvLXmdrPt65r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hhwcQgLB; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hhwcQgLB"
Message-ID: <53f77737-1d56-46ac-8408-32d7e411b0fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774648836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MA6AfImbqVXBReF/DjvTSEmqbZYrd50KMVMk6BrqHBo=;
	b=hhwcQgLB+exbZBAxv+Vu7hJfjsx4rTcK7C8cRQ8kQd4iuwdCfkAQk804IjRclUnuZtWO9q
	ulK6fxveg0tXACx9uTri6LAvv+mXJjYAhUolE+s4ib2oQz/9UzrgMl7dNo9ye+BjwAOBoH
	bQ/BdC0/HMovBzDwG3ovMGRX6Y9PxZw=
Date: Fri, 27 Mar 2026 15:00:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test
 decl_tags
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, cupertino.miranda@oracle.com
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/26/26 10:39 AM, Eduard Zingerman wrote:
> Impose global ordering for all decl tags used by test_loader.c based
> tests (__success, __failure, __msg, etc):
> - change every tag to expand as
>   __attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ...)))
> - change parse_test_spec() to collect all decl tags before
>   processing and sort them using strverscmp().
> 
> The ordering is necessary for gcc-bpf.
> Neither GCC nor the C standard defines the order in which function
> attributes are consumed. While Clang tends to preserve definition order,
> GCC may process them out of sequence. This inconsistency causes BPF
> tests with multiple __msg entries to fail when compiled with GCC.
> 
> Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++-----
>  tools/testing/selftests/bpf/test_loader.c    | 174 +++++++++++++++------------
>  2 files changed, 130 insertions(+), 104 deletions(-)

The change makes sense to me overall.

I am thinking with all this non-trivial parsing and sorting, maybe we
should have some smoke test for the test_loader itself?  Extend
prog_tests_framework.c maybe? And then make that run first on CI?

wdyt?


> 
> [...]
> 

