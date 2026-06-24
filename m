Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E23E5EF5
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336301; cv=none; b=TBxPRZImUu/krGIOPnlxQI2hmJTLLkzjhFaeK84zXmqiJA3NoE2biXhCArdv3W/r+FmU7fQTtqjaT/d+poneCBOpfZ5u72aH7ulJ+f/zZeOehe3TKYy16EhRtohcvMbteptW7U6SALcVD704nfCl7yxlTmMwX/AF/z5ppJy3yY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336301; c=relaxed/simple;
	bh=cq4zd81AMxHk938AVKnCzyvHbj0vjBktb97QwSKltYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9LJ0cCG2Aps+HzdfAT+LvIvUxeYvonNKFk67ZVpt0oVJIWzVFWPDlkS77BZ+F4IiQLqKQe+4io92GKHGTcaWy+6edRQna1ZgwXvRyTJqjcW6cJgYR1998djVcrU5BTwgos7jLeoUzbENMxaeXAwzuMiwq3O0/OHJmOiBjGEgpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=yQf26Rao; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="yQf26Rao"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c4fb17ebfso122633eec.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1782336300; x=1782941100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5oyYiJG5H8+TiDgZ6FvP82HxJDK2JA3/cBMLyp22+Os=;
        b=yQf26RaoYwi9m+jI+xL0jTUfCIDOFShXIAM9SYzwbVGrRSykbwZ1lbuOqYzlvOu1se
         RA//8wJEZBM3Qg9z64BrFvDQZPaR/PNNvw5qMPKS4W3tYKjndH7GnmjZyLRsn+b8h2Qn
         pmrpNOv2lWDgak+SE6/EHIBMicj51kPi6mKExHNdwOsRvuHSmF0Hfo3iIRmFzpb6f2Vq
         mJYtr9BdBqC4yoCxnH+kNKvUzKrt8jYD+9NI3SttRrq6T1BEINm2dC9PoSRroUE4YbnM
         E6+fkJKOH1S+lTj69/bYG+0TDeAwkR27Ql1xILQaHhNFUH+o8dpEktvgi/nkYYijv4cG
         AyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336300; x=1782941100;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5oyYiJG5H8+TiDgZ6FvP82HxJDK2JA3/cBMLyp22+Os=;
        b=ZBNyhSQABaVIkvaizNfKjZVsmN5Ip/gBh9o+lhJLu8jsr7ud+HZ0kCUznzaf9YZ5HK
         3ms4AhE0Md2NuMxIRQpiV8MWdRqFKePmfvd7aMnbjlcyTJFG/O9YiNtWSektf2ldA5u7
         Z4JizaSr4HU6yxbkh/I8pDqgjvtqkY6JDrqrEAPus9420JYur1oFLSxjqLPo436Fb0MZ
         gvbXxu9xrg9qdpCoph6/XgEZ09p8OHs+Z/knfe+JpJDRihcoLJIJT15awQkcsI7lFCje
         7LYLOzVapZKEM9DwmYs1SIphz+ryUbR7AJ+H1fQcJvg7XlkWONc7fPItw5ONIvmDVm7S
         6+vw==
X-Gm-Message-State: AOJu0Yz9Tw3VVEO8fK4wzjIFbXl9z27qPF9kHnkXxTj9PMXZqYp7es0I
	c9o04zwP3b7THGUzbUJ7BoOiNADCWLP7Hmk11IJXN2W52S71SmAPXegjCQ63FtuA7nk=
X-Gm-Gg: AfdE7ckop3mw/lxOnPMYJnRIkWjDbSPXff2WF09a7qFBmkJmDYjOSc1HSARAU17JUVq
	b0X0Hur7oY/bGwyPvI/aWGH6K8lCodguiXcsy+uKh/3KsS9MsPDFdkNFUF9tHj9a7JobeA4POgH
	XoUt8zQgIu9Vm+9JlyxdWZcR85W/B/Baw65wqqaA+cZSpazOQkYBlbpjoO1TJXan0TI3dy0A2SS
	ntb0u4UDmkwHfY6SnOk3jC8kKmbAXcs8uY4PrZMmICnxIGj22XaD7li6nTho7T/21sHbYylOOUM
	Y7Rk09ImDG0b8UMgemCLJbtK2SrWnqMxv//KVZu614jr2KDO7hA0Fi99PNs8CN/k0n7mLmXDK+I
	Notx1Hnn3k+hORb8IN7nwPGbGnL3HOhgRncq39gfFhMgy9cpOkRxyDXFgvh9qnAAuRKsQyTgYUv
	sao8c=
X-Received: by 2002:a05:7301:fa08:b0:30c:8119:f385 with SMTP id 5a478bee46e88-30c8119fa43mr184920eec.5.1782336299694;
        Wed, 24 Jun 2026 14:24:59 -0700 (PDT)
Received: from m2 ([83.171.251.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e220bsm1623297eec.21.2026.06.24.14.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:24:59 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:24:57 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com
Subject: Re: [PATCH bpf-next v9 5/5] selftests/bpf: add bpf_icmp_send no
 route test
Message-ID: <vg3675kdlojzxlmambram4ymwoawdlj3r4wqd4eo7rpq7zwx43@jzuzswadusrz>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
 <20260624185554.362555-6-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624185554.362555-6-mahe.tardy@gmail.com>

On Wed, Jun 24, 2026 at 06:55:54PM +0000, Mahe Tardy wrote:
> For normal live cgroup_skb paths, the skb should already be routed. The
> exception is for test run via BPF_PROG_TEST_RUN with packets created
> via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
> would quietly fail by returning early.
> 
> This test exercises this and makes sure the kfunc returns -ENETUNREACH.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index bb532aa0d158..ffaf0fe1880b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -169,6 +169,29 @@ static void run_icmp_test(struct icmp_send *skel, int af, const char *ip,
>  	}
>  }
> 
> +static void run_icmp_no_route_test(struct icmp_send *skel)
> +{
> +	struct ipv4_packet pkt = pkt_v4;
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.data_in = &pkt,
> +		.data_size_in = sizeof(pkt),
> +	);
> +	int err;
> +
> +	pkt.iph.version = 4;
> +	pkt.iph.daddr = inet_addr("127.0.0.1");
> +	pkt.tcp.dest = htons(80);
> +	skel->bss->server_port = 80;
> +	skel->bss->unreach_type = ICMP_DEST_UNREACH;
> +	skel->bss->unreach_code = ICMP_HOST_UNREACH;
> +	skel->data->kfunc_ret = KFUNC_RET_UNSET;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.egress), &opts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		return;
> +	ASSERT_EQ(skel->data->kfunc_ret, -ENETUNREACH, "kfunc_ret_no_route");
> +}
> +
>  void test_icmp_send_unreach_cgroup(void)
>  {
>  	struct icmp_send *skel;
> @@ -193,6 +216,9 @@ void test_icmp_send_unreach_cgroup(void)
>  	if (test__start_subtest("ipv6"))
>  		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);
> 
> +	if (test__start_subtest("no_route"))
> +		run_icmp_no_route_test(skel);
> +
>  cleanup:
>  	icmp_send__destroy(skel);
>  	if (cgroup_fd >= 0)
> --
> 2.34.1
> 

Reviewed-by: Jordan Rife <jordan@jrife.io>
