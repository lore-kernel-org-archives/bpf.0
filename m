Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEC39527D
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445762; cv=none; b=Rybaya+UySbUm8oxPR96FzVUU9U/pOdfx7zYumb8iUJYFr1jNiiLLrv4Le/cp1SU2rVUqxd/0eA5+IsmjZG4S7r24qkYFb5BFU3dqCQ/kkgiMa6KomGlnIustLrpcIE4ykrYqGApvdBUaYrocRumPrEgFkLyr94C7xtIi7E8S1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445762; c=relaxed/simple;
	bh=NIYHq2fI/Nnd6KvTmjKQB5oLNxpLVvK2ePSTu9K5RsQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joe9GAMe+QHceF0wt9B+9hRdprpINdelEz6KVU9otNH3iqnU7zZK22xvvT2LF59W0BQbX9UggzqMnvWPbi72yeQdIYHhEfxs5pUmQJrsMZOw5b1ejsLa4cLIEMgUPUzmrtujgZio+EruGpR64gMVTKvwCxb3jnev0pszD8RwuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPCtahYx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPCtahYx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48371119eacso53080625e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772445759; x=1773050559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZyBLvMkGew0ok4xTWt/X8AfGCSa7L5Et7GfpZ7AGBk=;
        b=aPCtahYxPex/NOVZ9oeMaLGMs/Vo6GbaW81Fh/9xBrGhiCCcotI+eWOzqcT5Jluyjz
         ySbPZyBfCKLQNm/KN4IGFnDSHDgKpBIVeeLTY1Cnt0/hJy39LNCtNKy2+3a7DL9O4/jx
         cNbtEGd8BdWdu1H3nb3YNvqCF/xlBbcSCwoIva+aIUbdqYLooDvkA8Hk1ONYJGVLvzfb
         Li/LMGTUacWdvlgu6X9NhG413doLlquQ1jAsDgf1j0xcjiNMjqz+1YLNeh/sqvWTgK+A
         s1gYEMfRxFQD1dH9SlRjRe+aqPiC2+vXe2FmMSeE91Fdc8Eun9aeWFWaZ3m6P5SHQV26
         /rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445759; x=1773050559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZyBLvMkGew0ok4xTWt/X8AfGCSa7L5Et7GfpZ7AGBk=;
        b=eU1vWS/xA/Nm0djB3TVvtc22zAWweQoatdk7oNQvwObS4QOag6orwP1vCbcbzcgrpL
         9AvgnqD6NVANpMrK7zhlpyNAWzX8Rvtb9/yGOPFlViVphtajCKGKmOdQMgvzJZcFj3gd
         wjovWj2u7ijedfjSYrUQynuIL942Rk/NcRb6Iab1FD7qJb3a2A45QSWvFVw4wuNz8ITc
         R5mOtSKZp1LuxZD0pEmsYXiWzWWmWVjcFMsa1BG9AtvhpNdOAtKRkVdrtrtyUOPUpwZv
         6DeoBXGI580HuBF6MPJV1OBQONsROl5swAo9oT6/pvdd3I2sZMuu5QxL47njgBS7fPxD
         kDhw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Q/vJ/WCJAbcXbbNC9G60QFvq9mLKhTvo/acGwbee39QvH9TrVMREYsDTvUmwtN7yIrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPfQsQ2ckRfmZZ0Y4kCPSWAR9yRTjb/03Jtvff1bxVB8rTDuD
	4va6O1fbybqIE+NwbXQnNTxpeA08SdWTLOE1Kom6j0pYB1B6g8eqhb+u
X-Gm-Gg: ATEYQzwPBmQdlorm3DWhUIYYch9fwSH1/vOenGp6PKzQaVAQSjl0bdsd8u9jJmuh/QD
	qgB1OP1HPBpBkYeSmFN5jrle6aVyc+8HFoYImTD/rgtqQoyS7Fpv3iYSHslzrDy0mSJ3++oH/Dk
	KAbsk2zRI0iaIM52dHWJwW8yZbpQilE5LBi6ZHOOT4JIyZGjSUSao21TxEYkMHaHgx2W7bw3BIJ
	cv1JqUHCiataNNGrQvi4KkWh/sGBS11O0X1eDEfAnmE2odD18dXbybtt9RjXx+1CPsjfWmSvws4
	vyeJkkFjQgyMlO0rJO4bYWbf42Pij+Pg7xz+qJvZe1JO1iC7yvrN4JQG3k1F5Su0QtLLcQ2Ww8n
	Nn2MsOXm31cLwj7bkvw/i0iekqJFo0rB3xpDea8fEpyhZoi9SvcaOHbDWkVnHAqMZwMDJFcCBqn
	gb6qmFDC0=
X-Received: by 2002:a05:600c:1f95:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-483c9c0bb23mr194470505e9.22.1772445758827;
        Mon, 02 Mar 2026 02:02:38 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm418417725e9.11.2026.03.02.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:02:38 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Mar 2026 11:02:36 +0100
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/bpf: bpf_cookie: skip kprobe_multi
 tests without bpf_testmod
Message-ID: <aaVgPM5quBz-H3Yb@krava>
References: <20260228074555.122950-1-sun.jian.kdev@gmail.com>
 <20260228074555.122950-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228074555.122950-2-sun.jian.kdev@gmail.com>

On Sat, Feb 28, 2026 at 03:45:54PM +0800, Sun Jian wrote:
> The kprobe_multi subtests rely on bpf_testmod fentry ksyms.
> 
> When bpf_testmod isn't available, libbpf fails to resolve
> bpf_testmod_fentry_test* and skeleton load fails with -ESRCH, causing
> false failures.
> 
> Skip these subtests when env.has_testmod is false.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

please include bpf-next in the subject, other than that:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> ---
> Changes in v2:
> 
> No functional change.
> 
> Drop the unrelated perf_event_open() argument change from this patch
> (moved to patch 2/2).
> 
> v1: <https://lore.kernel.org/lkml/20260227164037.84110-1-sun.jian.kdev@gmail.com/>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 75f4dff7d042..b7643a5bf7ad 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -105,6 +105,11 @@ static void kprobe_multi_link_api_subtest(void)
>  	unsigned long long addrs[8];
>  	__u64 cookies[8];
>  
> +	if (!env.has_testmod) {
> +		test__skip();
> +		return;
> +	}
> +
>  	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
>  		goto cleanup;
>  
> @@ -192,6 +197,11 @@ static void kprobe_multi_attach_api_subtest(void)
>  	};
>  	__u64 cookies[8];
>  
> +	if (!env.has_testmod) {
> +		test__skip();
> +		return;
> +	}
> +
>  	skel = kprobe_multi__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
>  		goto cleanup;
> -- 
> 2.43.0
> 
> 
