Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7D3E5EE4
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336280; cv=none; b=c++nPgJGqUF5MVsf0wetTekPXAEQmZmbahLJmayEJuW+nTPvoP7Gtci5SPHmCKh/mw9f/2JbZyR31yDNPQewOo0jKizfgmeFg8ZgO7VULRIPWhH7Bn5H1JJyKA+WjliZLDnbbR92th8rUMRu9YYHa5Qb+swIcWMxjmD/Zb/Zyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336280; c=relaxed/simple;
	bh=y+ShFzs+RXqKpIY9cXh90uSbgR0j1DIeIBw6/koHYYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjgG/B3L47zIp/dTLr7t4bHgTdHgYGQW2CfkhKFC5VQYN5RyRFYQ5EzefjD3bZEEva9WxoQbxsYMg3TDBAlF9+pRJirqltBU46kV/1BkISczGH4ln2q+Jlz+wRM84Z/RvRjEUwlvV8K9eodQ0l08U3497YSxFReCEofBnkD2fJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=xfrTP7bn; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="xfrTP7bn"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30c653644c2so68754eec.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1782336278; x=1782941078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9qy78JVdJS0JviIaHpH8wQzx7QFTkc+Yb1dqLLUC1A=;
        b=xfrTP7bnU2K8CJzGvrImTlIAm7xpdqPTY3qe1hvJgAgpqTsPzo0wIyFZ/BLvC3W9fJ
         x47Ao86a0XeinE75mrJi8/4h8kj6kEqKmCibRTsTEY6NCXdrRzloACn2t/PTYOoOnKx0
         /M8t5eqw6vGZtE/dHVGbOUYuW/53gx7R9bUSYJQJEHJxYD16Or0RWevZ21CO6aw5Iq2q
         KvjDND1JOm40VZjobUYOzALpw0RBAfQ6VZJXRlf2BlExTDinjVOUEmRYb1KkaKqKWtyf
         07MWwE3Fsb2jjkw10Ig5dCM+E6PeVoJ3kvFnAktHB9DZXlfh1BFvI4NMSs8YBnylh2Gp
         /1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336278; x=1782941078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9qy78JVdJS0JviIaHpH8wQzx7QFTkc+Yb1dqLLUC1A=;
        b=NmzPVMsq/nB8U4TsqlTpQyRA4BHEuyFDTjj4yGilY9Zucmrr4b3obo4AcEGIlcpLgm
         f/ApW1OmVxPIpkaDiTtHQkb/NENHaXXspYYQ2JAFH0mDOX45GulM27xTOOCb0T0MXCwf
         Gj4/D3fMWjjBY1CQna2YZ6NCwY1BX5usej05bUo+TuwzAjPivCHXQIb4zJ43NEYk9gpj
         HlfHJwxaPyl9ly6j1BL7/PB59nN+ofGXmwuZq2iBHElYFJt14nai4H7yPeUvofZO6RO2
         al0NO8D77groE1nXhmK8O+lSWzbJIsih0GcaPgfhC4P5aVA1K16CJ8Zl/reQ4CwEhRKZ
         ZzoQ==
X-Gm-Message-State: AOJu0YyoDdU+pu7FYniaLkxOCnruMngoWnT4uXsPzziwOFq01bDOdQpK
	T84/YTtr3ZyjTfrXXYUTiOK28I+FAEgBrG8Su9JqDTkHstlVhFuuDR72ZDf3Z8fEWdk=
X-Gm-Gg: AfdE7ckGeMBqPy6ETQJupqrMotreF9ZtH10WWYrZQqE80um3WlB81AijDCvXqUj3eFK
	H8aLaW1bE2ZzkxqchuuKjze3fyBofoMUCfP54Hhvu28lZ+GPs6f7svc7F+mpJ6z/ZpB3+9ulgfP
	uZ8GhuYlMGxYX8VVQEpDLfKHFxjxH+CGUH7xgwzJebEvmT9gTWvm2mixlm7IyVzHdEyLIAkh5PR
	2Q0eJPEcNOEQrOMfFEiWRPcxTPuHEjLdXD1AJxq4MamADjRrg6xpTz4zqJc9NVYM1nShPssltLS
	4qslXxHZO43EAWFu2lt3yswmwuVGyx6iWecKH7f2wFys6UPANigRQ7757aX5kejmD0Hm64a2YP6
	vzzeLQvW4j62mS65JHbNHBZ90cYxIlCYiMj92j51o4cQoW28a77dyej2ccpEo7ew36N2w6c8o0y
	5kLWM=
X-Received: by 2002:a05:7300:6c9f:b0:304:f860:3ae3 with SMTP id 5a478bee46e88-30c17b65060mr8165765eec.1.1782336278445;
        Wed, 24 Jun 2026 14:24:38 -0700 (PDT)
Received: from m2 ([83.171.251.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c6c2sm1710572eec.10.2026.06.24.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:24:38 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:24:36 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com
Subject: Re: [PATCH bpf-next v9 3/5] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb IPv6 tests
Message-ID: <djuc5lxdgm6nhxgpeplud3jg6mdiqrteiwlvgxg5gkvbe2gxgi@zgymcbxsxzkw>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
 <20260624185554.362555-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624185554.362555-4-mahe.tardy@gmail.com>

On Wed, Jun 24, 2026 at 06:55:52PM +0000, Mahe Tardy wrote:
> This test extends the existing cgroup_skb tests with IPv6 support.
> 
> Note that we need to set IPV6_RECVERR on the socket for IPv6 in
> connect_to_fd_nonblock otherwise the error will be ignored even if we
> are in the middle of the TCP handshake. See in
> net/ipv6/datagram.c:ipv6_icmp_error for more details.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 91 +++++++++++++------
>  tools/testing/selftests/bpf/progs/icmp_send.c | 48 ++++++++--
>  2 files changed, 101 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index b8a98c90053e..bbb3c3d4509c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -8,9 +8,11 @@
>  #define TIMEOUT_MS 1000
> 
>  #define ICMP_DEST_UNREACH 3
> +#define ICMPV6_DEST_UNREACH 1
> 
>  #define ICMP_FRAG_NEEDED 4
>  #define NR_ICMP_UNREACH 15
> +#define ICMPV6_REJECT_ROUTE 6
> 
>  #define KFUNC_RET_UNSET -1
> 
> @@ -18,7 +20,7 @@ static int connect_to_fd_nonblock(int server_fd)
>  {
>  	struct sockaddr_storage addr;
>  	socklen_t len = sizeof(addr);
> -	int fd, err;
> +	int fd, err, on = 1;
> 
>  	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
>  		return -1;
> @@ -27,6 +29,12 @@ static int connect_to_fd_nonblock(int server_fd)
>  	if (fd < 0)
>  		return -1;
> 
> +	if (addr.ss_family == AF_INET6 &&
> +	    setsockopt(fd, IPPROTO_IPV6, IPV6_RECVERR, &on, sizeof(on)) < 0) {
> +		close(fd);
> +		return -1;
> +	}
> +
>  	err = connect(fd, (struct sockaddr *)&addr, len);
>  	if (err < 0 && errno != EINPROGRESS) {
>  		close(fd);
> @@ -36,8 +44,14 @@ static int connect_to_fd_nonblock(int server_fd)
>  	return fd;
>  }
> 
> -static void read_icmp_errqueue(int sockfd, int expected_code)
> +static void read_icmp_errqueue(int sockfd, int expected_code, int af)
>  {
> +	int expected_ee_type = (af == AF_INET) ? ICMP_DEST_UNREACH :
> +						 ICMPV6_DEST_UNREACH;
> +	int expected_origin = (af == AF_INET) ? SO_EE_ORIGIN_ICMP :
> +						SO_EE_ORIGIN_ICMP6;
> +	int expected_level = (af == AF_INET) ? IPPROTO_IP : IPPROTO_IPV6;
> +	int expected_type = (af == AF_INET) ? IP_RECVERR : IPV6_RECVERR;
>  	struct sock_extended_err *sock_err;
>  	char ctrl_buf[512];
>  	struct msghdr msg = {
> @@ -63,38 +77,43 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
>  		return;
> 
>  	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
> -		if (cm->cmsg_level != IPPROTO_IP || cm->cmsg_type != IP_RECVERR)
> +		if (cm->cmsg_level != expected_level ||
> +		    cm->cmsg_type != expected_type)
>  			continue;
> 
>  		sock_err = (struct sock_extended_err *)CMSG_DATA(cm);
> 
> -		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
> -			       "sock_err_origin_icmp"))
> +		if (!ASSERT_EQ(sock_err->ee_origin, expected_origin,
> +			       "sock_err_origin"))
>  			return;
> -		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
> +		if (!ASSERT_EQ(sock_err->ee_type, expected_ee_type,
>  			       "sock_err_type_dest_unreach"))
>  			return;
>  		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
>  		return;
>  	}
> 
> -	ASSERT_FAIL("no IP_RECVERR control message found");
> +	ASSERT_FAIL("no IP_RECVERR/IPV6_RECVERR control message found");
>  }
> 
> -static bool valid_unreach_code(int code)
> +static bool valid_unreach_code(int code, int af)
>  {
>  	if (code < 0)
>  		return false;
> 
> -	return code <= NR_ICMP_UNREACH && code != ICMP_FRAG_NEEDED;
> +	if (af == AF_INET)
> +		return code <= NR_ICMP_UNREACH && code != ICMP_FRAG_NEEDED;
> +
> +	return code <= ICMPV6_REJECT_ROUTE;
>  }
> 
> -static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
> +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code,
> +					    int af, const char *ip)
>  {
>  	int srv_fd = -1, client_fd = -1;
>  	int port;
> 
> -	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_MS);
> +	srv_fd = start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
>  	if (!ASSERT_OK_FD(srv_fd, "start_server"))
>  		return;
> 
> @@ -105,6 +124,8 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
>  	}
> 
>  	skel->bss->server_port = ntohs(port);
> +	skel->bss->unreach_type = (af == AF_INET) ? ICMP_DEST_UNREACH :
> +						    ICMPV6_DEST_UNREACH;
>  	skel->bss->unreach_code = code;
>  	skel->data->kfunc_ret = KFUNC_RET_UNSET;
> 
> @@ -114,13 +135,37 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
>  		return;
>  	}
> 
> -	if (valid_unreach_code(code))
> -		read_icmp_errqueue(client_fd, code);
> +	if (valid_unreach_code(code, af))
> +		read_icmp_errqueue(client_fd, code, af);
> 
>  	close(client_fd);
>  	close(srv_fd);
>  }
> 
> +static void run_icmp_test(struct icmp_send *skel, int af, const char *ip,
> +			  int max_code)
> +{
> +	for (int code = 0; code <= max_code; code++) {
> +		if (af == AF_INET && code == ICMP_FRAG_NEEDED)
> +			continue;
> +
> +		trigger_prog_read_icmp_errqueue(skel, code, af, ip);
> +		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
> +	}
> +
> +	/* Test invalid codes */
> +	trigger_prog_read_icmp_errqueue(skel, -1, af, ip);
> +	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> +
> +	trigger_prog_read_icmp_errqueue(skel, max_code + 1, af, ip);
> +	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> +
> +	if (af == AF_INET) {
> +		trigger_prog_read_icmp_errqueue(skel, ICMP_FRAG_NEEDED, af, ip);
> +		ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> +	}
> +}
> +
>  void test_icmp_send_unreach_cgroup(void)
>  {
>  	struct icmp_send *skel;
> @@ -139,23 +184,11 @@ void test_icmp_send_unreach_cgroup(void)
>  	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
>  		goto cleanup;
> 
> -	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
> -		if (code == ICMP_FRAG_NEEDED)
> -			continue;
> -
> -		trigger_prog_read_icmp_errqueue(skel, code);
> -		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
> -	}
> -
> -	/* Test invalid codes */
> -	trigger_prog_read_icmp_errqueue(skel, -1);
> -	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> +	if (test__start_subtest("ipv4"))
> +		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);
> 
> -	trigger_prog_read_icmp_errqueue(skel, NR_ICMP_UNREACH + 1);
> -	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> -
> -	trigger_prog_read_icmp_errqueue(skel, ICMP_FRAG_NEEDED);
> -	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> +	if (test__start_subtest("ipv6"))
> +		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);
> 
>  cleanup:
>  	icmp_send__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> index 6d0be0a9afe1..6e1ba539eeb0 100644
> --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> @@ -5,10 +5,11 @@
> 
>  /* 127.0.0.1 in host byte order */
>  #define SERVER_IP 0x7F000001
> -
> -#define ICMP_DEST_UNREACH 3
> +/* ::1 in host byte order (last 32-bit word) */
> +#define SERVER_IP6_LO 0x00000001
> 
>  __u16 server_port = 0;
> +int unreach_type = 0;
>  int unreach_code = 0;
>  int kfunc_ret = -1;
> 
> @@ -18,19 +19,48 @@ int egress(struct __sk_buff *skb)
>  	void *data = (void *)(long)skb->data;
>  	void *data_end = (void *)(long)skb->data_end;
>  	struct iphdr *iph;
> +	struct ipv6hdr *ip6h;
>  	struct tcphdr *tcph;
> +	__u8 version;
> 
> -	iph = data;
> -	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
> -	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
> +	if (data + 1 > data_end)
>  		return SK_PASS;
> 
> -	tcph = (void *)iph + iph->ihl * 4;
> -	if ((void *)(tcph + 1) > data_end ||
> -	    tcph->dest != bpf_htons(server_port))
> +	version = (*((__u8 *)data)) >> 4;
> +
> +	if (version == 4) {
> +		iph = data;
> +		if ((void *)(iph + 1) > data_end ||
> +		    iph->protocol != IPPROTO_TCP ||
> +		    iph->daddr != bpf_htonl(SERVER_IP))
> +			return SK_PASS;
> +
> +		tcph = (void *)iph + iph->ihl * 4;
> +		if ((void *)(tcph + 1) > data_end ||
> +		    tcph->dest != bpf_htons(server_port))
> +			return SK_PASS;
> +
> +	} else if (version == 6) {
> +		ip6h = data;
> +		if ((void *)(ip6h + 1) > data_end ||
> +		    ip6h->nexthdr != IPPROTO_TCP)
> +			return SK_PASS;
> +
> +		if (ip6h->daddr.in6_u.u6_addr32[0] != 0 ||
> +		    ip6h->daddr.in6_u.u6_addr32[1] != 0 ||
> +		    ip6h->daddr.in6_u.u6_addr32[2] != 0 ||
> +		    ip6h->daddr.in6_u.u6_addr32[3] != bpf_htonl(SERVER_IP6_LO))
> +			return SK_PASS;
> +
> +		tcph = (void *)(ip6h + 1);
> +		if ((void *)(tcph + 1) > data_end ||
> +		    tcph->dest != bpf_htons(server_port))
> +			return SK_PASS;
> +	} else {
>  		return SK_PASS;
> +	}
> 
> -	kfunc_ret = bpf_icmp_send(skb, ICMP_DEST_UNREACH, unreach_code);
> +	kfunc_ret = bpf_icmp_send(skb, unreach_type, unreach_code);
> 
>  	return SK_DROP;
>  }
> --
> 2.34.1
>

Reviewed-by: Jordan Rife <jordan@jrife.io>
