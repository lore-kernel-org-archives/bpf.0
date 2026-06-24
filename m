Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD213E5EFA
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336293; cv=none; b=NonmXKGhHBCVYKZBaLfQ/YIvtoxGACTPqbwAJYNDaZV30Rm9s/utFtdjiFN4BR5oYYLk7HelNR19QerjgO2gyIKv1n9lYy/1IcW8ZAF/Tbr06nFMi8cBGWONnxobOJS/KtoEwqggpdWhQ9uQ+PiFzhXKF7v6NCPFfoF0mD6Orzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336293; c=relaxed/simple;
	bh=izWwFUKloUgpc59zVRxwkJbZz9JWP5RCk/V85wrA0Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw6+v0ApIOHYi/SYQ5qK5SEzLZRwfFsuXBOsFCNfyur/bov/xPefdUMhsB6aQFuj3ew/vaF2EAbZG9IrE7MqezyJPyqjbJCCkFbmBq/nIya/bvWDfxjyXZuwgvgZ2S+L8Pglku91ojQGOZ9ipsVHF4ak2tQWYxaxjZVeHYX+KTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=Xj9sq87m; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="Xj9sq87m"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c4fb17ebfso122628eec.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1782336291; x=1782941091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AHa5UJj9hZK/L+JI2aEbp5Fi1DwX1ds80lPnuPpkejk=;
        b=Xj9sq87mbL+Ui7rutMKbsC/ENfd0SBFpi4QkUAP0fB7augN2mgvq6mbMhhU5r2UuPM
         6u1XTRZCeFWWAmJj3cdh7zF7O1wJ1Imx9xLKiKTljB9dqY1/FmdGNLrT+U1Wiqw2wvHf
         o2bwE6qCjvdkJsgrtdXfJmS0i5dTCK6Kq24pqasXZE/tHMqrX8eXmuJ/289+ViBo7uxE
         wGFMoznE/+j11i6D4vPouM9QNVK1JIybLvC2xctchSaCDtnlXCjZxsiaOrh20HXGIkKW
         mrOWKwhJwW1PoPwzR3FtM2tIkswOtN/u0/Qpf1i6oTejJBH0/vVxM8shAuF7ST8+pA2B
         n3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336291; x=1782941091;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHa5UJj9hZK/L+JI2aEbp5Fi1DwX1ds80lPnuPpkejk=;
        b=h4CHw5GJov3k5cZRpyNERaW83nBzfLbYdcXgYa7J6gChiy250YUlqx05VacUt2usvX
         V+pAQzQbjw7AcQVjJn9S5y0QkKCGWIsxQV6M8Z3NJkR5m/gG5a+IbPY1Y73n9lfKFynJ
         xGW/9T0X0DqZfYXrajMV4598xSpz6c5PKHmfG8JU3FVFidiR7L5ISr4vy5Lqr6rDbHi0
         AAGgpWtVtflTHf4mN2rwF7wJgkiZv3WL3OLyMy2JN8cKVat9/d4UZHIbpABhaHwUf0kA
         kH8le3KcK506LVcu14hJd5riNAStnBwxS9uZcw43CRCtRIyXRgMGCcMbTYFN9X4C/2MY
         4HZg==
X-Gm-Message-State: AOJu0YzTzTdoegE77bZ6hZIRbYRyXqzb2T32q0LTW9OsSbU4iOORKCxd
	etWOSqqonA6hduxkbWkcn86PQjH70KG5NkVm7BOOwfrGLvNLc7D16EfJueLzkE8Lz9E=
X-Gm-Gg: AfdE7cm/crIGaw/Qw3gXHFVBMNTjk2Q+RmQrn5xBx+Su2AVbbmTUgOMKZml/imsZNoQ
	REnpvMn8GoQRgzR1af7ynqRUHmvnK++EN2lKdbJQqxenf+/eyLLG7JAJXYOuuhGWKdN3pPRBRFM
	Wa0czBT8W5MnSluh8/a0qx129u6SF906bmwd5iQybTFP/w2hVj/KbK7QgJMhzi7wYalRwMAcRK8
	p+c8M3KomEQCPE97WqCFH13yKKZcwcrm0YZ/0nKLj6o4hYJRbAY2lyu0s1oXRSLXK3nZPE0zJen
	4Fo72frL+zdnMJo2VYP0tfY93PpNb6JB6ObI3xvgnEvHF9L6D8ekRJW6wWtAirfkhudlngoH14p
	NOMkUjOlaHXzNhvP8vtVj953fTBbWRstlvDhWFJLwuQ8ebnSvpSueyj5E5JFhRntFUpe8fxAfdk
	z7EKw=
X-Received: by 2002:a05:7300:a2cd:b0:2be:298c:a11 with SMTP id 5a478bee46e88-30c523edb3bmr4134861eec.3.1782336290969;
        Wed, 24 Jun 2026 14:24:50 -0700 (PDT)
Received: from m2 ([83.171.251.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm1595399eec.19.2026.06.24.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:24:50 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:24:48 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com
Subject: Re: [PATCH bpf-next v9 4/5] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <53omno7xpamn5flhm3idwlzicpvoc5qnzoomczj2cgdmtyu2q5@3v5hcwgfakh2>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
 <20260624185554.362555-5-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624185554.362555-5-mahe.tardy@gmail.com>

On Wed, Jun 24, 2026 at 06:55:53PM +0000, Mahe Tardy wrote:
> This test is similar to test_icmp_send_unreach_cgroup but checks that,
> in case of recursion, meaning that the BPF program calling the kfunc was
> re-triggered by the icmp_send done by the kfunc, the kfunc will stop
> early and return -EBUSY.
> 
> The test attaches to the root cgroup to ensure the ICMP packet generated
> by the kfunc re-triggers the BPF program.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 46 ++++++++++++++++
>  tools/testing/selftests/bpf/progs/icmp_send.c | 55 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index bbb3c3d4509c..bb532aa0d158 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
>  #include <network_helpers.h>
> +#include <cgroup_helpers.h>
>  #include <linux/errqueue.h>
>  #include <poll.h>
> +#include <unistd.h>
>  #include "icmp_send.skel.h"
> 
>  #define TIMEOUT_MS 1000
> @@ -10,6 +12,7 @@
>  #define ICMP_DEST_UNREACH 3
>  #define ICMPV6_DEST_UNREACH 1
> 
> +#define ICMP_HOST_UNREACH 1
>  #define ICMP_FRAG_NEEDED 4
>  #define NR_ICMP_UNREACH 15
>  #define ICMPV6_REJECT_ROUTE 6
> @@ -195,3 +198,46 @@ void test_icmp_send_unreach_cgroup(void)
>  	if (cgroup_fd >= 0)
>  		close(cgroup_fd);
>  }
> +
> +void test_icmp_send_unreach_recursion(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd = -1;
> +	int err;
> +
> +	err = setup_cgroup_environment();
> +	if (!ASSERT_OK(err, "setup_cgroup_environment"))
> +		return;
> +
> +	skel = icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	cgroup_fd = get_root_cgroup();
> +	if (!ASSERT_OK_FD(cgroup_fd, "get_root_cgroup"))
> +		goto cleanup;
> +
> +	skel->data->target_pid = getpid();
> +	skel->links.recursion =
> +		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
> +		goto cleanup;
> +
> +	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET,
> +					"127.0.0.1");
> +
> +	/*
> +	 * Because there's recursion involved, the first call will return at
> +	 * index 1 since it will return the second, and the second call will
> +	 * return at index 0 since it will return the first.
> +	 */
> +	ASSERT_EQ(skel->bss->rec_count, 2, "rec_count");
> +	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
> +	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
> +
> +cleanup:
> +	icmp_send__destroy(skel);
> +	if (cgroup_fd >= 0)
> +		close(cgroup_fd);
> +	cleanup_cgroup_environment();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> index 6e1ba539eeb0..c642ccdf9fd5 100644
> --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> @@ -12,6 +12,10 @@ __u16 server_port = 0;
>  int unreach_type = 0;
>  int unreach_code = 0;
>  int kfunc_ret = -1;
> +int target_pid = -1;
> +
> +unsigned int rec_count = 0;
> +int rec_kfunc_rets[] = { -1, -1 };
> 
>  SEC("cgroup_skb/egress")
>  int egress(struct __sk_buff *skb)
> @@ -65,4 +69,55 @@ int egress(struct __sk_buff *skb)
>  	return SK_DROP;
>  }
> 
> +SEC("cgroup_skb/egress")
> +int recursion(struct __sk_buff *skb)
> +{
> +	void *data = (void *)(long)skb->data;
> +	void *data_end = (void *)(long)skb->data_end;
> +	struct icmphdr *icmph;
> +	struct tcphdr *tcph;
> +	struct iphdr *iph;
> +	int ret;
> +
> +	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
> +		return SK_PASS;
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
> +	} else if (iph->protocol == IPPROTO_ICMP) {
> +		icmph = (void *)iph + iph->ihl * 4;
> +		if ((void *)(icmph + 1) > data_end ||
> +		    icmph->type != unreach_type || icmph->code != unreach_code)
> +			return SK_PASS;
> +	} else {
> +		return SK_PASS;
> +	}
> +
> +	/*
> +	 * This call will provoke a recursion: the ICMP packet generated by the
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

Reviewed-by: Jordan Rife <jordan@jrife.io>
