Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AE29D28F
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211784; cv=none; b=uoCWr6N1nOB9tc16kif1C6bOYfPpYG3c0fNPPM1KJUYA6p5Qm08OxXMB6AYAV4lAy1YxewbXzaYnjULcMmEH0o/ZZ1U23xBtWTyQVNiB0paY94JKDdfrKtqgrD8jIFcEoCipZZbt66axyRlbZDvJr86rGuLTHDSvW2AeBFZm74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211784; c=relaxed/simple;
	bh=3lQBs4ulGXX8bGcZi3QX1TqUr5YFr0oPGSGI4Gwfknk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJP6MZ1aOgBmptATB8h7fawMlFwO7tkcg7NsDPyM+DYxaGrEydjP/0v+duqfS/fjNhZP4btWf/HGWJAzTcfIV9i/80UWjgjpc0jVM/4NOtuUxzgcMBQnl00eiyc5HNWO1VmU4oTMqtucTnEJ4hX2s8WqGoEEMo2T1SvYekQZUzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1BK2ZiU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1BK2ZiU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4888375f735so14731285e9.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775211780; x=1775816580; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b5dZnPo99Ahf3Imv37Sc8IChQ262fqrmJ68c0dD4ENA=;
        b=k1BK2ZiUJ5FZaZBea2O274a0fL6h3XPF43GBmJBDghcntv4IdLJGdfqx1TuY9xm7yT
         X7eeMOsc8/o6E6uwG+uxnmcz9z1WHk0Q6lgxH4IEK9DO34UXV4tC7dG+8ZewfkZyCm/p
         hwUbzdX0Pn7/U9HSI3a94g/+bRps5K9L9tqGNowpGw6AlMc78a8zEHRNr27Kg3znHZgb
         0dPYwQISK8YjvO94MmhrjRwVRkVpn94JhRP543Dx0NP2O68Ctj1o7scrqLwD0AxrPccr
         VOl4hre1wFqWs6Vbd9lz6F8cuhVS61w7iQ/w4qmrIqUHmwQgHKOzDVbthxidsh14hAd9
         VUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775211780; x=1775816580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5dZnPo99Ahf3Imv37Sc8IChQ262fqrmJ68c0dD4ENA=;
        b=DmZSLBnJBw8f+riaeZX9orBlm/Gm96EnS4hdVB6np5cEisCDS/RxFRZwknS9hZ+G14
         HH6P01ZDE+XH+VBoIe9+73J+Xuc8y+2xUOvRhhcaUZRyZzeZv2qbJ01bi/gdVRCXw0lV
         3Fo8OFr6rcYyjsdgIMNi6TEF5L8h238XbiZEz/HZLQAFP3LdEewqAkC8O4txB9bd+8Z0
         mF24yZ972zrkkjs5kNTKSxHPDpDo5n2mpmNeqCzFXOF3mLh0Wxnym40DcWMQ0/6BQleS
         8f62iwCC8l4e1mprORghxNT88Sq8apSJvUKTkmHAfvw/LWRbZ54nRIBSQeE8Q8SMnCBh
         aF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe++4Dm/07QdHdToaVkJ4Gz1kGeOdh0bAwY4I7+kXQXvLqkA88s19vV2O9Gy4R9VfmDMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSdhJiQ2sI+uXZRlLx2KB8aDDvC6uDohDFbb1BAdfHVU/sDLp
	Mm7VWZ13kk5YtK8m2v1coNDj6HYKybIg2tIBfoBQ5bicQ4bF4h8iiMZI
X-Gm-Gg: ATEYQzwivMD0dMrGuU2W5GkMH/aHUv0TmQchFr7xTwjq9ZLpqHW7+Fv74LvY96l5d6u
	6T5liCaAFLPv4a4trQHRYuaF58Nuh1M1s0dP+nEjuBIh1YgG8a72D43tY8AsnU38xjDuDVVwSgu
	/I1dLZ0+1Xnv5sQmZJ6wAv6jvAl6yIGXQGmeTV0l9xtBvrS9/+i7sQDuyggOKiE0T1oUKLghriu
	DnEOtjPDTeMmLCCklMWS0ThpwUqPCN2/yaEWSi/9Z7bxqY8CmsH7S+QOw7bAwwUHgkL6IUzvRco
	K+1TVaOmk6FnkgdXTRrg9czrcrxzVapgXmQd25x65i8+B2IHYtbpk8TPP6r9CkYZTNEd4BpQyxM
	TDXQC/IA0c93m0zAzllTXcirNU9jxvL3ukTddJ0CBJAydZZsVxmhf3xjGby3RxHhKitzxveydO0
	/gXHE0+IbSWGjUm1ULEXo51YoR3+lmI8j5kiqTf68n1cAmxhNdD0dw0KlUj7dpSaPILB3BOduiG
	gZCpz6LL872QwzhLTe3vfIepfdc3kg2F1IA+vzP5pSwMiB0fgJanUUbYX6vPoyErEVTEvxnJhqS
	eLUHofKbML42LtDiQSiIfFbm9+8WABwl7H4lH02l78E=
X-Received: by 2002:a05:600c:37cf:b0:485:3fe6:21f5 with SMTP id 5b1f17b1804b1-4889974678emr39768445e9.10.1775211779694;
        Fri, 03 Apr 2026 03:22:59 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00e1e89335f46e29e8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:e1e8:9335:f46e:29e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fdd2cesm20956425e9.4.2026.04.03.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:22:59 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:22:57 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	ebpf@linuxfoundation.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: remove unused toggle in tc_tunnel
Message-ID: <ac-VAQEOh7dAUHl8@mail.gmail.com>
References: <20260403-tc_tunnel_cleanup-v1-1-4f1bb113d3ab@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403-tc_tunnel_cleanup-v1-1-4f1bb113d3ab@bootlin.com>

On Fri, Apr 03, 2026 at 09:52:06AM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> tc_tunnel test is based on a send_and_test_data function which takes a
> subtest configuration, and a boolean indicating whether the connection
> is supposed to fail or not. This boolean is systematically passed to
> true, and is a remnant from the first (not integrated) attempts to
> convert tc_tunnel to test_progs: those versions validated for
> example that a connection properly fails when only one side of the
> connection has tunneling enabled. This specific testing has not been
> integrated because it involved large timeouts which increased quite a
> lot the test duration, for little added value.
> 
> Remove the unused boolean from send_and_test_data to simplify the
> generic part of subtests.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

For reference, the discussion on the non-integrated version was at
https://lore.kernel.org/all/DDOOS5LR0GZH.ITEM5495FPOX@bootlin.com/.
Seems like a good bit of cleanup :)

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> index 23b5c522ea9f..1aa7c9463980 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> @@ -206,18 +206,13 @@ static void disconnect_client_from_server(struct subtest_cfg *cfg,
>  	free(conn);
>  }
>  
> -static int send_and_test_data(struct subtest_cfg *cfg, bool must_succeed)
> +static int send_and_test_data(struct subtest_cfg *cfg)
>  {
>  	struct connection *conn;
>  	int err, res = -1;
>  
>  	conn = connect_client_to_server(cfg);
> -	if (!must_succeed && !ASSERT_ERR_PTR(conn, "connection that must fail"))
> -		goto end;
> -	else if (!must_succeed)
> -		return 0;
> -
> -	if (!ASSERT_OK_PTR(conn, "connection that must succeed"))
> +	if (!ASSERT_OK_PTR(conn, "connect to server"))
>  		return -1;
>  
>  	err = send(conn->client_fd, tx_buffer, DEFAULT_TEST_DATA_SIZE, 0);
> @@ -391,7 +386,7 @@ static void run_test(struct subtest_cfg *cfg)
>  		goto fail;
>  
>  	/* Basic communication must work */
> -	if (!ASSERT_OK(send_and_test_data(cfg, true), "connect without any encap"))
> +	if (!ASSERT_OK(send_and_test_data(cfg), "connect without any encap"))
>  		goto fail;
>  
>  	/* Attach encapsulation program to client */
> @@ -403,7 +398,7 @@ static void run_test(struct subtest_cfg *cfg)
>  		if (!ASSERT_OK(configure_kernel_decapsulation(cfg),
>  					"configure kernel decapsulation"))
>  			goto fail;
> -		if (!ASSERT_OK(send_and_test_data(cfg, true),
> +		if (!ASSERT_OK(send_and_test_data(cfg),
>  			       "connect with encap prog and kern decap"))
>  			goto fail;
>  	}
> @@ -411,7 +406,7 @@ static void run_test(struct subtest_cfg *cfg)
>  	/* Replace kernel decapsulation with BPF decapsulation, test must pass */
>  	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decapsulation"))
>  		goto fail;
> -	ASSERT_OK(send_and_test_data(cfg, true), "connect with encap and decap progs");
> +	ASSERT_OK(send_and_test_data(cfg), "connect with encap and decap progs");
>  
>  fail:
>  	close_netns(nstoken);
> 
> ---
> base-commit: 9ebb4fa90266705741534924eac62d6f03895fea
> change-id: 20260403-tc_tunnel_cleanup-bf03af4f8c7c
> 
> Best regards,
> --  
> Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 
> 
