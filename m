Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3C331A63
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366401; cv=none; b=beIopbWkVRzJDcjucX3pg5KOZV+fVLXF/obxXLRbXkm1KQw7PH+1lCkq55twPyyIefh8WCeAssULzPyP2EV4EuA1jiq++KYX2gqyh8HWLatrsfW7BMPNfj9z4CT0IuCN1YZ0h2sIk0noCsvGZ2SmBABGDPLXeVPWshUgfRxyd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366401; c=relaxed/simple;
	bh=t2BU4POuNqnQHfs1v7jsAchuyRFNIXmVxb2kXc0/Yr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh4Mt1ZcBfwA/8PbVevQgwHQypHRdjLnL+tNAavbIDoVj7xMNmbiM2Nk1U+BCL9V9Rba6ScUOOXR5gxj5OovSWoSk7UaVBD45nw4/8rMKyUuuQU+D7j2CACdvbKyA/vKIPrFQCqKiI5wsMT1+Yqi47KxXkXtiVx/jpEsnab+BEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYpWJ3Av; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYpWJ3Av"
Date: Thu, 16 Apr 2026 12:06:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776366387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKcufqME6AclWOFSO2Pn6FBNuFdVFsZOL3F1tIQrun8=;
	b=uYpWJ3AvnglL9gowTEPCFHr5rS3M/bKDfOJc6Zt7jlmhEMLTVSQ1Kn1x+DyimYbmr615FE
	b4aoy+ytRdu1mZKA53vfSV5V/PnW2CBvxGXWtf5B0oe9AHL/DV4MDqAvfMgTGiJg3aDdNT
	wqbz7hytcBdUoegyOeZiNizyxMENf20=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, jiayuan.chen@linux.dev, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr
 opt callbacks
Message-ID: <2026416184330.-HAW.martin.lau@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
 <20260416112308.1820332-3-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416112308.1820332-3-kafai.wan@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 16, 2026 at 07:23:08PM +0800, KaFai Wan wrote:
> index 56685fc03c7e..2d738c0c4259 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> @@ -513,6 +513,59 @@ static void misc(void)
>  	bpf_link__destroy(link);
>  }
>  
> +static void hdr_sockopt(void)
> +{
> +	const char send_msg[] = "MISC!!!";
> +	char recv_msg[sizeof(send_msg)];
> +	const unsigned int nr_data = 2;
> +	struct bpf_link *link;
> +	struct sk_fds sk_fds;
> +	int i, ret, true_val = 1;
> +
> +	lport_linum_map_fd = bpf_map__fd(misc_skel->maps.lport_linum_map);
> +
> +	link = bpf_program__attach_cgroup(misc_skel->progs.misc_hdr_sockopt, cg_fd);
> +	if (!ASSERT_OK_PTR(link, "attach_cgroup(misc_hdr_sockopt)"))
> +		return;
> +
> +	if (sk_fds_connect(&sk_fds, false)) {
> +		bpf_link__destroy(link);
> +		return;
> +	}
> +
> +	ret = setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
> +	if (!ASSERT_OK(ret, "setsockopt(TCP_NODELAY) active"))
> +		goto check_linum;
> +
> +	ret = setsockopt(sk_fds.passive_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));

Why are these two setsockopt(TCP_NODELAY) calls needed?

Instead of creating a new "void hdr_sockopt(void)", can the test be done in the
existing "void misc(void)" by doing bpf_setsockopt(TCP_NODELAY) in the
misc_estab() bpf prog?

The PASSIVE_ESTABLISHED_CB can do the bpf_setsockopt(TCP_NODELAY, 0)
if it wants to keep the same expectation on Nagle. The
BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB
can do bpf_setsockopt(TCP_NODELAY, 1) to test recursion and
the error return value.

>  void test_tcp_hdr_options(void)
> diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> index d487153a839d..a8cf7c4e7ed2 100644
> --- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> +++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> @@ -28,6 +28,12 @@ unsigned int nr_data = 0;
>  unsigned int nr_syn = 0;
>  unsigned int nr_fin = 0;
>  unsigned int nr_hwtstamp = 0;
> +unsigned int nr_hdr_sockopt_estab = 0;
> +unsigned int nr_hdr_sockopt_estab_err = 0;
> +unsigned int nr_hdr_sockopt_len = 0;
> +unsigned int nr_hdr_sockopt_len_err = 0;
> +unsigned int nr_hdr_sockopt_write = 0;
> +unsigned int nr_hdr_sockopt_write_err = 0;

nr_hdr_sockopt_estab, nr_hdr_sockopt_len, and nr_hdr_sockopt_write
are unnecessary. These tests have already been covered in some ways.

Mostly a nit. The new counters are used in both connections. Note the
existing nr_xxx is exclusively used in either active or passive,
so there is no parallel counting in practice.

Instead of counting, just use a bool nodelay_est_ok,
nodelay_hdr_len_err, nodelay_write_err and assert them
to be true in userspace.
