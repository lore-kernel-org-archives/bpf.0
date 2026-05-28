Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30336C581
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780008942; cv=none; b=XEBHvFuvk4D2KDLGBcYbNNF0P5fYmUBklj96eHcxwLNfiP6TwFaQjBGFb458dzO5C+c7Nwvv6lqThhnLxx+RTwVSFt1Ujmb8jsHyV60p8gf2MHj6xUMXnO8UYMiLZqORIxCZI7Ji4hEosVPeITv0NR/uyahl+HtsWao967VHlOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780008942; c=relaxed/simple;
	bh=yF+t/MxA8C1202gDEuqnLcAowiuRvjX0RRxo5GBhxRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSw8xClp0MZZB8Eq19DjuFiTe+p9guljdBbrqvww8v976Hm+IKOFxfEhu/2E5jFjYG0i4oXRTI2y0yZq7CqqJqb8A+JY177iaPyjO+FM5txZoqNmXkSUz+2z+xEcVpNqX1otXH6iqhScu9GW77I2o6H/7G3PUyJ4/oUAdzLnaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=y2KJP44t; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="y2KJP44t"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304dc707bfbso107580eec.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1780008940; x=1780613740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hYbf4kzlnIJc0DIgLjb8FNPQMjUNGbaxH90ljGYoYU=;
        b=y2KJP44t5bXoV+K2ct+ssYDNnzdqZK7cYWeHxpUhmS4VY9Di+M80zxjMoEe4TcArdy
         BG9n3DVGj+Y0oEpWbpMp5KkReFqQkAiT4XbYkX0oo6pNK1fcoTrMHNSbOzLeTTWFA/A0
         DlXkhDm/+fo0L8Ne3wXmFQxPYBvBgfD7S5HJ6MSyEqN7i2D2+DeJBCs4vCIoKKJt3ovA
         MmYu0SkbT72u/tV39hUMywlg+EPpUU96JROSNjWjaLmiy4JYQoE261+f1YoQpL+eIbPO
         QpRGAdJBQIHbVHHNMl2JxIisikxqkcLyNJdyrT6VF019vINDLR1S2axzH3DAuDEz9HmO
         jgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780008940; x=1780613740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hYbf4kzlnIJc0DIgLjb8FNPQMjUNGbaxH90ljGYoYU=;
        b=szyzI3QIURKCpH9rCy1DbaXbakLPZ2YApjr094KyzJ4kIJ1qKDf8VUCKHwOpD1aWp/
         te+U6HBvU2wPHzWdpmchLvGvvPHtLJZKIrsiiKUXFdSGboX93eD3APbKYT7rP82ivdRW
         RkT9ISHdifH/WBG5M2cLp80ZNMODbzUv6FWDuPduQA8nUibEtvzouEDRAP1sSSJHuJ2j
         VKlkoy8vUTRfZOVYNAO3WAZAIPMudTXRVCIik2vzlv0DabdVtP4l6gR7aEVIF2Ccyrb0
         vxgmvP/lkieusDlg5O1dkO7n8p/o955uqpv6juskgWjm4QvnTBlzs9iOVvj/gP5WOx5L
         i9OQ==
X-Gm-Message-State: AOJu0YzEAdDwo5eoh3gwNJ6ehOqugY0qaiuzczpRhLxHA6P+bxeSkmh4
	wQVqJ4F2I9G/JLw2MlyY7/q4lrp9vt5nNNmCX9GSWdUCWRG1K6cQfKadVgBCrhJj4+o=
X-Gm-Gg: Acq92OGYaz6CDhznQ5+80p7vOQQ3fpn8NHqPea+rGZ/ujUow2EVa1E30NPi5X/LwxgJ
	Cwhz6kiWN69mZ7nGreaUnn599rGdaH4gmBmba755xHRggD+que9vdJeu5XWupBMmEbK9CgOvka2
	/4QpxiJLrTFjwevsZId0+OmKH84BQ4RNGZgQb8L4WmDNAQI37X0gPzjQ1RlfzMeGGKYdiLlEGJt
	9/4lN3eFzP+JKeGPUy2Sbo0CteV3gUbFQQprCA3E3r2lB9ADbOAk4I6LY5hBX4bZ98WpoFei0ME
	Tt4xIjOQS8DtvYzGj3f2JleV1szY62mjZcKy3HXqMiaOBczdHKdSnmN5fB1lPMbxW2xDVyTfZPU
	nY+YLMp1nRkt9s1ILogtpFNpTKmciWgydjU06Npw6IE+4/9uFAWIfQInJqC6t+vM2B9ER//G1z9
	OHS+hNSVbTrVdnW0KSNgOCtYIk
X-Received: by 2002:a05:7300:72c5:b0:304:e327:aef8 with SMTP id 5a478bee46e88-304eb0d0400mr88891eec.2.1780008939657;
        Thu, 28 May 2026 15:55:39 -0700 (PDT)
Received: from m2 ([83.171.251.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ebcc77f3sm237240eec.22.2026.05.28.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:55:39 -0700 (PDT)
Date: Thu, 28 May 2026 15:55:37 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v7 7/7] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <3evosyl26zvnzhficgf73g4ecdgdrdlnabvt2423ku36qbovp7@ij6dxahqxlxt>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
 <20260526153708.279717-8-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153708.279717-8-mahe.tardy@gmail.com>

On Tue, May 26, 2026 at 03:37:08PM +0000, Mahe Tardy wrote:
> This test is similar to test_icmp_send_unreach_cgroup but checks that,
> in case of recursion, meaning that the BPF program calling the kfunc was
> re-triggered by the icmp_send done by the kfunc, the kfunc will stop
> early and return -EBUSY.
> 
> The test attaches to the root cgroup to ensure the ICMP packet generated
> by the kfunc re-triggers the BPF program. Since it's attached only for
> this recursion test, it should not disrupt the whole network.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 42 +++++++++++++++++-
>  tools/testing/selftests/bpf/progs/icmp_send.c | 44 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index 51f809ea6896..f48e1d41e3ed 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
>  #include <network_helpers.h>
> +#include <cgroup_helpers.h>
>  #include <linux/errqueue.h>
>  #include <poll.h>
>  #include "icmp_send.skel.h"
> @@ -10,6 +11,7 @@
>  #define ICMP_DEST_UNREACH 3
>  #define ICMPV6_DEST_UNREACH 1
> 
> +#define ICMP_HOST_UNREACH 1
>  #define ICMP_FRAG_NEEDED 4
>  #define NR_ICMP_UNREACH 15
>  #define ICMPV6_REJECT_ROUTE 6
> @@ -193,7 +195,6 @@ void test_icmp_send_unreach_tc(void)
> 
>  	if (test__start_subtest("ipv4"))
>  		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);
> -
>  	if (test__start_subtest("ipv6"))
>  		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);
> 
> @@ -201,3 +202,42 @@ void test_icmp_send_unreach_tc(void)
>  	bpf_link__destroy(link);
>  	icmp_send__destroy(skel);
>  }
> +
> +void test_icmp_send_unreach_recursion(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd = -1;
> +
> +	skel = icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	if (setup_cgroup_environment()) {
> +		fprintf(stderr, "Failed to setup cgroup environment\n");
> +		goto cleanup;
> +	}
> +
> +	cgroup_fd = get_root_cgroup();
> +	if (!ASSERT_GE(cgroup_fd, 0, "get_root_cgroup"))
> +		goto cleanup;
> +
> +	skel->links.recursion =
> +		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
> +		goto cleanup;
> +
> +	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET,
> +					"127.0.0.1");
> +
> +	/* Because there's recursion involved, the first call will return at
> +	 * index 1 since it will return the second, and the second call will
> +	 * return at index 0 since it will return the first.
> +	 */
> +	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
> +	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
> +
> +cleanup:
> +	cleanup_cgroup_environment();
> +	icmp_send__destroy(skel);
> +	close(cgroup_fd);

This will close(-1) if the first two `goto cleanup` branches are taken.
Not the end of the world, but most tests I've seen try to avoid it by
doing something like this:

if (cgroup_fd != -1)
	close(cgroup_fd);

> +}
> diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> index 5fa5467bdb70..c899fb7b28d2 100644
> --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> @@ -14,6 +14,9 @@ int unreach_type = 0;
>  int unreach_code = 0;
>  int kfunc_ret = -1;
> 
> +unsigned int rec_count = 0;
> +int rec_kfunc_rets[] = { -1, -1 };
> +
>  SEC("cgroup_skb/egress")
>  int egress(struct __sk_buff *skb)
>  {
> @@ -125,4 +128,45 @@ int tc_egress(struct __sk_buff *skb)
>  	return TCX_DROP;
>  }
> 
> +SEC("cgroup_skb/egress")
> +int recursion(struct __sk_buff *skb)
> +{
> +	void *data = (void *)(long)skb->data;
> +	void *data_end = (void *)(long)skb->data_end;
> +	struct tcphdr *tcph;
> +	struct iphdr *iph;
> +	int ret;
> +
> +	iph = data;
> +	if ((void *)(iph + 1) > data_end || iph->version != 4)
> +		return SK_PASS;
> +
> +	if (iph->daddr != bpf_htonl(SERVER_IP))
> +		return SK_PASS;
> +
> +	if (iph->protocol == IPPROTO_TCP) {
> +		tcph = (void *)iph + iph->ihl * 4;
> +		if ((void *)(tcph + 1) > data_end ||
> +		    tcph->dest != bpf_htons(server_port))
> +			return SK_PASS;
> +	} else if (iph->protocol != IPPROTO_ICMP) {
> +		return SK_PASS;
> +	}
> +
> +	/* This call will provoke a recursion: the ICMP packet generated by the
> +	 * kfunc will re-trigger this program since we are in the root cgroup in
> +	 * which the kernel ICMP socket belongs. However when re-entering the
> +	 * kfunc, it should return EBUSY.
> +	 */
> +	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
> +	rec_kfunc_rets[rec_count & 1] = ret;
> +	__sync_fetch_and_add(&rec_count, 1);
> +
> +	/* Let the first ICMP error message pass */
> +	if (iph->protocol == IPPROTO_ICMP)
> +		return SK_PASS;
> +
> +	return SK_DROP;
> +}
> +
>  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> --
> 2.34.1
> 
