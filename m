Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2775318139
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615873; cv=none; b=QWGTj58BLlxTkeMAPtRKfVYUdoQRWgDKsznlGwW56na59uNfPVd9Y7D9KQu/H/TR0jAhJDjF1za2fN5kLA1XJNrl8dw611+ZMnLX1BzKdLrIWMEMOM286AXjt5w8No81mL069a1Cd0Gcm0geETZRp2hSrrhWflz0oPS/lLHGTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615873; c=relaxed/simple;
	bh=EGERGdCx2kYeS7W9iwSbT/bvqw0eSLVjuKRazBmEJAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN/sbh9ZoyCVdGr9v+TEYX0oVRxBDe/73Qj/P/QcISc+TwUD7X6G44mOKDUDw5BR7ntnDBwQSIIgsFbzW43R0bobrMJZdxZNOzp3q4iyY0mYGK3pWPlPLmK8FvziO4WjNyAVVTXlLdIUsq/r5r95ETxDcu3Q6WZXTIdRjVsVGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcS+eXT1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcS+eXT1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so43838055e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615867; x=1782220667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85JsgvYD1YLd3UTUsIZxYoHmTb8gB/2tl6mfyWcf1Bg=;
        b=gcS+eXT1DV6Kk1SiY7/E/IqA9dag6Mp38ZE4sRl4baYb2SXdnpMJTHsk/z8fXqLK7Z
         EI5aD0epiICHZNv4RDDf1g2UfWFLrLC/DfiYJ8mPQQ/B8EgN0zyWSQkkH5oLY7jBoByW
         9alOdozBbCr9yb6n8vWnoWKjZNZOlZZEvaaBKv5DKDgxhHzyOT0zlTyCj+5nsXSF/+vz
         A3XP4Qh0RRLDqimUZsgzLSjZ+Ez+5RrLXWl1kw8BzUkSQlVBOuxH3jPz3DX1j4PHPgZ+
         jH20l0y6fPrd1BMqRkTscinXjP1zrKAXoWa1ExUVEJT3aRBpqiJOLZDDXSFbB+5T4jIl
         3D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615867; x=1782220667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85JsgvYD1YLd3UTUsIZxYoHmTb8gB/2tl6mfyWcf1Bg=;
        b=l7Hsh4gCQQgxk9zgvXbasdqQTL/ANrYboonmmjFz+Trfo+PDqXxacym1YLK1x6RC7O
         gNe68l/2DVyU813yc7xyV0RsCFXdyog4/lln9ky0psNRJBeYqHpoJ4NLOX2O0tQdd1QM
         8oBOLBHnRCBzrbz/WKhKMVqrQzyjRqWchKdFrTy3/trsg4FfkhVcWxWUuofHXRgEasU1
         2NchdZgVNZ64yTDX8Y/SlbfkwraiI2sKg5XMe/6IBD/gqQPoqi9WzcewiRFZaZJXyl6q
         z+si6HgQh0N4ny2LUGbDwDn5hFfr0Uh6CAiL5TRgp/aPHswP/QiT6AXJFI1Wqm8pAnHN
         pgSQ==
X-Gm-Message-State: AOJu0Yw2lONu4mjiDtuaiIAxRi0s3aaEDLcS74n002K/j9jT8A3J4YpW
	bT0Bw0KMsqft4yfbKcEN9Cj5KQj2RxVvMs+PRLkeE0M+dlYEqzAHAy/k
X-Gm-Gg: Acq92OGPLm4lpZxBqNa2fZVUg5wA5JFCwaMmb7Ik07bNMgxZBBg1NvHv3pWUSX9Cwen
	gZEbowWtnJKN/IfN3adAIqvl68HjcfddFN9lxx/7u+Y1Ut2bcTTfS176Kzi6vEjHHu7tEyLGP7b
	o0iLLHstbk1a2vuzgTvmZEyGHjYZRU6qPhKFtd8lvjEHSnfYXqFKeKWzZF/ktpfXDMWDHqSVh+Q
	Ule4tdOJ4zUYicnD0zkkNFrrGMSShixeLLwQznm6h12Apju8vMS9Qah/UwWRDmzr0IL1Vr+v9Yi
	kJhpusCFDVIAIMVnIQPoHd7yEjsinYAo0rW/qdW8q/kaMMw/aud9sa6MvEELf5hyHC/5vKiBk03
	+q917LDNc5jlCWGf54FCQq+z+iqH7Jf39LLTECbiR2bGAiTdfFQtIvaiZ2lOyDvVvvsGGmh/l9c
	PYDpzHHQju6MBGzr1ahVaVeTEo5v2LX0UFIRa2uXkwwrORuLNp/yiarGn/UN5VifnhgLrDZUPgh
	AyEzjiUv6UYrg52BvTnotEdkLUHgh1nLR4mdg87Ioy0yCURR4Z6QJVZ9WfRXynYKDyOu4bPefbf
	0gFYihtpKcoL4tQE8dAmFDIwqNecc7tWpisUuGcJ+M0=
X-Received: by 2002:a05:600c:810b:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-4922fac1214mr55599015e9.6.1781615866488;
        Tue, 16 Jun 2026 06:17:46 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004325bddd753d2e35.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4325:bddd:753d:2e35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4601esm67361305e9.1.2026.06.16.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:17:45 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:17:43 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
Message-ID: <ajFM97xoXuDAUsuw@mail.gmail.com>
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
 <20260616093103.471444-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616093103.471444-3-sun.jian.kdev@gmail.com>

On Tue, Jun 16, 2026 at 05:31:03PM +0800, Sun Jian wrote:
> prog_run_opts already verifies that BPF_PROG_TEST_RUN returns -ENOSPC
> for a short data_out buffer while still reporting the full output size
> through data_size_out.
> 
> Add the same coverage for non-linear test_run output. Use pass-through
> TC and XDP programs with a 9000-byte packet, a 64-byte linear data area,
> and a 100-byte data_out buffer. The expected output spans both the linear
> data and the first fragment.
> 
> Verify that test_run returns -ENOSPC, reports the full packet length
> through data_size_out, and copies the packet prefix into data_out for
> both non-linear skb and XDP frags paths.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/prog_run_opts.c  | 72 +++++++++++++++++++
>  .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> index 01f1d1b6715a..71af1ff02023 100644
> --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> @@ -4,6 +4,10 @@
>  
>  #include "test_pkt_access.skel.h"
>  
> +#define NONLINEAR_PKT_LEN 9000
> +#define NONLINEAR_LINEAR_DATA_LEN 64
> +#define SHORT_OUT_LEN 100
> +
>  static const __u32 duration;
>  
>  static void check_run_cnt(int prog_fd, __u64 run_cnt)
> @@ -20,6 +24,71 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
>  	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
>  }
>  
> +static void init_pkt(__u8 *pkt, size_t len)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < len; i++)
> +		pkt[i] = i & 0xff;
> +}
> +
> +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];
> +	struct __sk_buff skb = {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));

Can't we reuse pkt_v4 by reducing the linear area to ETH_HLEN?

> +	memset(out, 0xa5, sizeof(out));

Why is this needed?

> +
> +	skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in = pkt;
> +	topts.data_size_in = sizeof(pkt);
> +	topts.data_out = out;
> +	topts.data_size_out = sizeof(out);
> +	topts.ctx_in = &skb;
> +	topts.ctx_size_in = sizeof(skb);
> +
> +	prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "skb_nonlinear_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_nonlinear_partial_data_size_out");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_nonlinear_partial_data_out");
> +}
> +
> +static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];
> +	struct xdp_md ctx = {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));
> +	memset(out, 0xa5, sizeof(out));
> +
> +	ctx.data = 0;
> +	ctx.data_end = NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in = pkt;
> +	topts.data_size_in = sizeof(pkt);
> +	topts.data_out = out;
> +	topts.data_size_out = sizeof(out);
> +	topts.ctx_in = &ctx;
> +	topts.ctx_size_in = sizeof(ctx);
> +
> +	prog_fd = bpf_program__fd(skel->progs.xdp_frags_pass_prog);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "xdp_nonlinear_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_nonlinear_partial_data_size_out");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_nonlinear_partial_data_out");
> +}
> +
>  void test_prog_run_opts(void)
>  {
>  	struct test_pkt_access *skel;
> @@ -69,6 +138,9 @@ void test_prog_run_opts(void)
>  	run_cnt += topts.repeat;
>  	check_run_cnt(prog_fd, run_cnt);
>  
> +	test_skb_nonlinear_data_out_partial(skel);
> +	test_xdp_nonlinear_data_out_partial(skel);
> +
>  cleanup:
>  	if (skel)
>  		test_pkt_access__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> index bce7173152c6..cd284401eebd 100644
> --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
>  
>  	return TC_ACT_UNSPEC;
>  }
> +
> +SEC("tc")
> +int tc_pass_prog(struct __sk_buff *skb)
> +{
> +	return TC_ACT_OK;
> +}

Once we're reusing pkt_v4, maybe we can also reuse the existing BPF
program?

> +
> +SEC("xdp.frags")
> +int xdp_frags_pass_prog(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}
> -- 
> 2.43.0
> 
