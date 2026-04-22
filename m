Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAA367F25
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892323; cv=none; b=PwoFkl03CvcZcc1jbEP5mpXDRtwnohfjR9kPx2Ki0t7KIUWnQn0Gcn8f6+bGQqGxrfoWfbeV15k+xt2myFw0ZfFitqCKA/Oa6pLRlSvJj858FcyRgr57bkXit5on3t0W0Z2DdSAuTUScveFbwyXzZdt6ZNI2pee3FeXIkzzKoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892323; c=relaxed/simple;
	bh=v7U75NKiCPYtTdQcEnkj2wpWyCLF3eSW0cslj4j/1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc5rthnuxDwHP/llqkf7SLhSySwLhYL29CRvoBTb0Qp0tweMF63eIM7xdDqDT4S6ecz9XMbX+7hiu3lbCEayVul7KgQKTHyeXrABH6veNBHNFvha5S+z+YKnbmQQK5QAGAk7IT+zypW0zFdYvCXLNwYabA2E2SFdWvyEYmc1c/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J257CulQ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J257CulQ"
Date: Wed, 22 Apr 2026 14:11:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776892310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEandxuFafG0C/7810R/J7c3UrG1zSU4EJVrzgVn8Pc=;
	b=J257CulQuZDOKAP+hzxI5m1x/1f7RRcZvINwLvEqjQYq4bjPPs5X0QpCTGoLcWmFqADdLp
	GK6KMC54APkAvW4xZ1bw6YlSpPubaIXn9c1ptGPMxwjkj1KVROaqnB5SZe3HDHwn5aKCGn
	0M7OTrg6f0N7RExaee2KtNlWER+8oEQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Werner Kasselman <werner@verivus.ai>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: cover same-reg sock_ops
 rtt_min request_sock access
Message-ID: <202642221444.tUNv.martin.lau@linux.dev>
References: <20260417023119.3830723-1-werner@verivus.com>
 <20260420230030.2802408-1-werner@verivus.com>
 <20260420230030.2802408-3-werner@verivus.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420230030.2802408-3-werner@verivus.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 20, 2026 at 11:00:37PM +0000, Werner Kasselman wrote:
> Add a tcpbpf sock_ops selftest that forces a same-register ctx->rtt_min read on request_sock-backed callbacks and verifies the observed value is zero.
> 
> This covers the dst_reg == src_reg path that the previous ctx_rewrite-only test did not exercise.

Same formatting issue.

> 
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  .../testing/selftests/bpf/prog_tests/tcpbpf_user.c |  4 ++++
>  .../testing/selftests/bpf/progs/test_tcpbpf_kern.c | 14 ++++++++++++++
>  tools/testing/selftests/bpf/test_tcpbpf.h          |  2 ++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> index 7e8fe1bad03f..1b08e49327d0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> @@ -42,6 +42,10 @@ static void verify_result(struct tcpbpf_globals *result)
>  	/* check getsockopt for window_clamp */
>  	ASSERT_EQ(result->window_clamp_client, 9216, "window_clamp_client");
>  	ASSERT_EQ(result->window_clamp_server, 9216, "window_clamp_server");
> +
> +	/* check same-reg rtt_min read on request_sock-backed callbacks */
> +	ASSERT_NEQ(result->rtt_min_req_seen, 0, "rtt_min_req_seen");
> +	ASSERT_EQ(result->rtt_min_req_nonzero, 0, "rtt_min_req_nonzero");
>  }
>  
>  static void run_test(struct tcpbpf_globals *result)
> diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> index 6935f32eeb8f..a488b282b5dd 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> @@ -33,6 +33,7 @@ int bpf_testcb(struct bpf_sock_ops *skops)
>  {
>  	char header[sizeof(struct ipv6hdr) + sizeof(struct tcphdr)];
>  	struct bpf_sock_ops *reuse = skops;
> +	long rtt_min = (long)skops;

It is overly smart to test the same dst_reg == src_reg.
A new test has just been added to test it in a cleaner way.

pw-bot: cr

You haven't spent time to take a look of the patches first.
Please don't post again. I will stop reviewing your patches from now.
