Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D781C84AB
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623466; cv=none; b=sQpUQX+AjziFWlzV7fmriHM6qioon/fw/WmYTcMPCo31GFVqD6fn8A61wH2xxuZe/IQOeCSPqloRe0qUvrQ/ddrDxIq4b/m9U9pgyuLXgwQ65yBtZ4OeksSjD5OGmIEFhM+cnqrkOY6UD//dUmHAxU324KM4bjPyUHKMaVAEvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623466; c=relaxed/simple;
	bh=4BP01x/Nn5kraMGXyig7U8DEbw5IZxrqUhyGpRTxi+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meInXFVXQpN92LU6GTYFmGcnpwKlbnbC7JFKOVoPj088eKe6eQMk9AkIvsuse32k6M6eF7Z+avxYidahxSSEJu0ovXA652x/V2UYPhkIBvjdMEQ9et4ISuRbbEScY0FQH0VRDgIA+QkUOtJwCxnsVespzn6XepAdfB4b18P2hcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GemdBqVB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GemdBqVB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48379a42f76so55885365e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 03:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772623463; x=1773228263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yNT5n5DhF68AeSX9KVEwEFmbIkkUqzIjuiTWXrjq2U=;
        b=GemdBqVBTraj+go9pnYtEThEdr9sKaOzUNCwS/1gYIFd7mG3N8HuxwHXk4DC55A7sB
         5J5eTuIJvtsycu7frxCmu0rWjBie40FlkNBWKToL6ifGlpGrINvo2gCSm106E4Sc8Tmt
         +oRZUjejsezXLNISPTQ0O1o3UuM5URI86X3vEK4OU3ZzjVUFmL8ii7Wws10oZ+RKJYA5
         2wUNiDdZ5PYMU6GvUb9GXTQfP14y7HtQtkEC3qzQDiP5n90ywmW1sexBFRE3bAWsMaYi
         WXWr5IIyDgAbMXaNA+mdr3N0oKx198L3hEImRhd3cIExvgJPjPR048XlKcb0oXwa9a1W
         gNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772623463; x=1773228263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yNT5n5DhF68AeSX9KVEwEFmbIkkUqzIjuiTWXrjq2U=;
        b=pvWZ3YhiQxmYt1p9OdtVVBmWTIpZ5pFGgFGXubO0VDNTCIKZ7Jwmg/pqAONI/JMqDZ
         wyXSDpjuiu71TWW9pFtK50sFFsW+ujfVQqJtzj1M7wtazLNXi+MtNWwg2MX48oPC07Qj
         bdhxSRTuXz6kxwpxKgqQEx7sRdLMhTzIVN95Y9Km6H2bf0RwrGvWaJUWW8Zz/dzq1t5g
         eN3CaazEL0gfoRpvozWQwi9FOGrIieU4Vdc8UtL7IKgVXmCYvVzBY+4eEG7EbBeFUO2P
         g8xUw2GvtE1hyr5b3tKO2MoMs66F1nXH80Gsl5zJGkqO1lJwrjAErmU6Ya45qxphdShN
         WsBw==
X-Forwarded-Encrypted: i=1; AJvYcCUGYhf8cFOKiTzVvSjHA7k4dRuuARMuj+LtOYi3lEXF5H05Ey2V8K7BTIxtqQWMLfluQRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwriYwHIJtVXQRMtd+BLuJJ7xPQ6m+Zz6a7gFCApwqMHkLkvRiy
	awnoUTKXCcVRdc3/7uQMxlXXjZF6rMOajemy5YB00trpKL7K7LFF90cR
X-Gm-Gg: ATEYQzysFo2dEGNw2/CXARGJSUlMHS13LDpwuu1VLG8ZJyGE+6LkRqo4m1X5/TlzF7g
	/d0t8KfYihLIpIc60CG7Mxwe5SzqwIaJm8HO4YArkRbSYVceRysh3UuXzSofn/wEA0B4tDytcAq
	InfjG9rp4kr3AtR6Hb6caHdYJDpEsQmmuCdTrY5Q4+H9lSWTRql2FZZw48TGgQ4Vr48RViDaG1J
	3afAlUQj1acvHlxRAVRVfNmliQ0q9XUltVws4qYk4ltRxdw1H5JQOeZE1dleC7aOxAY59SvzAxO
	sZKt3Lj2y8Ivwk6sa6Oqfa7x1BrCZ/frqzqhP5Mp4BfQ0gVrTG25WAFTwP1vG5dfkIzmnbxLLEg
	NSd/zrIKic2u9AixgL93fgsMogEQ7xI+zz6oX6R6yavyGlbMIAr3RogZbx7ot7kFoDJCJAlyUCf
	krI41Ea/zHm6K1Y1u1JFZcAEZ+NBUnTnBn0RGOZnATKoAxMcNlQeIC07MXACkrlS4FNxmByGpIU
	h9bbk58d71dC0ZucnEk8nMej/s0+L7Z6o/7T94aDYfYmh81+85sb7v2AFz5g+2zVV6rFE/jXkRk
	7rNsbAYi2w==
X-Received: by 2002:a05:600c:1c22:b0:483:b2a8:33ff with SMTP id 5b1f17b1804b1-48519837facmr28999105e9.4.1772623462344;
        Wed, 04 Mar 2026 03:24:22 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e00a157f2ce043226e6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a157:f2ce:432:26e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187c2ef2sm46719035e9.5.2026.03.04.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:24:21 -0800 (PST)
Date: Wed, 4 Mar 2026 12:24:19 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: skip verif_scale_pyperf600 on -E2BIG jump
 complexity limit
Message-ID: <aagWYyrrwUt-poL1@mail.gmail.com>
References: <20260302071434.311395-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302071434.311395-1-sun.jian.kdev@gmail.com>

On Mon, Mar 02, 2026 at 03:14:34PM +0800, Sun Jian wrote:
> verif_scale_pyperf600 loads pyperf600.bpf.o, a large scale case produced
> by partial LLVM unrolling.
> 
> On some kernel/toolchain combinations, the verifier rejects it with -E2BIG:
> 
>   The sequence of 8193 jumps is too complex.
> 
> This hits the verifier jump sequence complexity limit (8192).
> 
> Treat -E2BIG for this test as SKIP rather than FAIL. Other pyperf600
> variants are unaffected.

This is a known issue with LLVM 19+ [1] and this test is already
skipped in CI [2, 3]. I don't think ignoring the error is the proper
fix here.

1 - https://lore.kernel.org/all/c8c590b2-40b2-4cc0-9eb7-410dbd080a49@linux.dev/
2 - https://github.com/kernel-patches/vmtest/commit/da142df34750386cac2ba10283d15216d5c8d033
3 - https://github.com/libbpf/libbpf/commit/02b3ec9ffc1b7000afa2a9ccc3dfd37de3bad8cb

Paul

> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../bpf/prog_tests/bpf_verif_scale.c          | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> index 73f669014b69..181acdddea1c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> @@ -112,13 +112,33 @@ void test_verif_scale_pyperf180()
>  
>  void test_verif_scale_pyperf600()
>  {
> +	libbpf_print_fn_t old_print_fn = NULL;
> +	int err;
> +
>  	/* partial unroll. llvm will unroll loop ~150 times.
>  	 * C loop count -> 600.
>  	 * Asm loop count -> 4.
>  	 * 16k insns in loop body.
>  	 * Total of 5 such loops. Total program size ~82k insns.
>  	 */
> -	scale_test("pyperf600.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
> +
> +	if (env.verifier_stats) {
> +		test__force_log();
> +		old_print_fn = libbpf_set_print(libbpf_debug_print);
> +	}
> +
> +	err = check_load("pyperf600.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT);
> +
> +	if (env.verifier_stats)
> +		libbpf_set_print(old_print_fn);
> +
> +	if (err == -E2BIG) {
> +		test__skip();
> +		return;
> +	}
> +
> +	ASSERT_OK(err, "expect_success");
> +
>  }
>  
>  void test_verif_scale_pyperf600_bpf_loop(void)
> 
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> -- 
> 2.43.0
> 
> 
