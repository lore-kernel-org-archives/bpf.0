Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1412C11FE
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776378783; cv=none; b=dnDS4gqDmaT+sK43RRHD8trIYgBljZJim5LvY0dFxVYmySF67QDnz2A7dzIX2/9vGPdoEZ3i4RBTY22K/4P8pZVLoMf3ulsDqpJtkcymEjvH1WVKTGpT4wj2b1vznb3HHtmgjbfA7oeR+KxIP4ooXR9iIbwdM0nwdWMKNaKnNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776378783; c=relaxed/simple;
	bh=zwcKXQQKgqFPxnBxhciEX6uVWC2qf3NQtqPHlame3CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtjDZRkA+AMI6i/LCMahmGOpocXBHJchEGS/cNZwebBAaB2hqRtWnYKj5jXnfkN4Z1w/BZm8eoLG/4xr+kDxEVqpLrkmPvDPnUhpEUjWwqNnQpONEHsR2TVHDmJzBtBAkNnUJdo0ryAqWZ4qHGv3RwL4vrCTyRMprtslLCzFyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnroYPVu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnroYPVu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso423475e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776378780; x=1776983580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5FNguffAPKF5P3I5sG9RhA2iDwLlj2SxIOFT8Wt1Ks=;
        b=bnroYPVum/ICbR9ZIupVjoqZVc8yNJQMl08f0e+IRPXr/gOiXdQddMsvxFbH4BrlEW
         E01hY2Px0SnRMW9uWv7mm4iruh/d5B4zpZK10ERe/7HM/Yd0xyFRusvtwRIA+wVfhY+Z
         WTB1PC9Pki/aqj8k8Qy9kkIyqe07P/tCy1ygwgzzO5y9g/OlcPfvvg3SQ5uzvTGD6YDt
         hjYFlR8ZbNfvfIqXBgrcDbntkns2yHyRKrnPa/K7urlH9BNxsMAhZTVMUti2D8pIyjwV
         ZBq0IONKmXdAthyRml0rB12c1HB/ijMWN4bSQifQciucqQJw/bHzRmaC9/VYbOHQTe/+
         N5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776378780; x=1776983580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5FNguffAPKF5P3I5sG9RhA2iDwLlj2SxIOFT8Wt1Ks=;
        b=YcPAlaxzkFuLf+Dk4UUKNlSNr2JS87VmwtXmtMyn2PgOJQmhrcnDOQ2+FlMz6Q1ZVC
         HxK7qIL9zyEZSSv8HZeiV8QReSqPbzESpYBcZtJA+tuk65bZ5zKGTdxCmh8/nOHOAq4b
         lZ6w0M8pk7PgFDfsvClD7QBJxieGid1vwa+Gz5ucNx7vSk6pJvHCJvdA6L0HiXrwMJk/
         Dgq/RXgEtw5Fgb5geygJ4+WhumaYS+siq9t73zEgRCNkgE/2GATKjmAKcbqmx7c9OCqh
         pPk91gouHaytU26AAnlyjDNvSsbyFmgfN9JtIeAupFZh3DOBMGBuvqfm3we06iHYOZNN
         8r9Q==
X-Gm-Message-State: AOJu0Yz7Bgeqqr6EvxNwI4z6epuPutMCh1S9w+zalwNc4h3zQH10wfyZ
	Yc2uSGe419jIyrOn3BSPT0mPEY+ok8AhX4eyEsrlvbLjO6HvpS+jE0Mo
X-Gm-Gg: AeBDievpL6OsLiRjxl40qZXgdPfmLMQInylEP+c4kW/94BADxjGPqLBkwx5wBbZNQh0
	g4CY4oYRTuXakaiKe3ml0k0nZfepE/kRGL9gQPIyNZJ8We0FGRrutofrAtpdB/fzIu23bsuHlnK
	VcXE/QB5m8qsvjUW7RwrMGI6q1lBOGycHjv+jkyZXecvZHhaJjJyJSI0bEIbA/N/66jirNGUvD2
	Mv/eOazJswrWWD2C27NflAQfSu8k3V1+/YViMrbs23Tz3BdHHAOVwAGTAcxmukhfC3rbZgwatOZ
	RN1+AaifkTmkOs0KC0NaAAd1lAmnGY/c5Btb/qn212gbR6ZbIqBvSwfs5QTSOUt8Ve2ps36RxkH
	jYzMQoLtzu1k4vek6z0aybDc1MeInIvYO5bgTHOjpZqpnS/dUP48RnIfKxLMkLgT5bDBU7j0gKI
	vbAllfqvp+ivLw4mY1kneB6MEL87DXpH17PhV06QVVLccwNt38/pJqQ1lZOuxEuP89hIlOHwwQU
	Fo2Tz/qltxLZ8b+tJ7TTxy4AIG7anQnJGZINpEQWoVtFwvulVtekf+lUwl0Z9a93oXCqQM1A1sR
	AR26zNgF5GbbHijwegqknmivOPwVPNjOQNiOfvwXfRLTjZPG4X0GKQ==
X-Received: by 2002:a05:600c:8b73:b0:487:1826:d89b with SMTP id 5b1f17b1804b1-488fb74a6b4mr5413775e9.9.1776378779908;
        Thu, 16 Apr 2026 15:32:59 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0092ca608f43e4326a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:92ca:608f:43e4:326a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818d70sm148044795e9.4.2026.04.16.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:32:59 -0700 (PDT)
Date: Fri, 17 Apr 2026 00:32:57 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, shuah@kernel.org, alan.maguire@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: allow UTF-8 literals in
 bpf_bprintf_prepare()
Message-ID: <aeFjma_GYKD23X88@mail.gmail.com>
References: <20260416120142.1420646-1-dingyihan@uniontech.com>
 <20260416120142.1420646-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416120142.1420646-2-dingyihan@uniontech.com>

On Thu, Apr 16, 2026 at 08:01:41PM +0800, Yihan Ding wrote:
> bpf_bprintf_prepare() only needs ASCII parsing for conversion
> specifiers. Plain text can safely carry bytes >= 0x80, so allow
> UTF-8 literals outside '%' sequences while keeping ASCII control
> bytes rejected and format specifiers ASCII-only.
> 
> This keeps existing parsing rules for format directives unchanged,
> while allowing helpers such as bpf_trace_printk() to emit UTF-8
> literal text.
> 
> Update test_snprintf_negative() in the same commit so selftests keep
> matching the new plain-text vs format-specifier split during bisection.
> 
> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
>  kernel/bpf/helpers.c                            | 17 ++++++++++++++++-
>  .../testing/selftests/bpf/prog_tests/snprintf.c |  3 ++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6eb6c82ed2ee..d51f1b612f1d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -845,7 +845,13 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>  		data->buf = buffers->buf;
>  
>  	for (i = 0; i < fmt_size; i++) {
> -		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
> +		unsigned char c = fmt[i];

I'm a bit unsure this extra variable is worth it, but it's probably not
worth sending a v4 just for that.

> +
> +		/*
> +		 * Permit bytes >= 0x80 in plain text so UTF-8 literals can pass
> +		 * through unchanged, while still rejecting ASCII control bytes.
> +		 */
> +		if (isascii(c) && !isprint(c) && !isspace(c)) {
>  			err = -EINVAL;
>  			goto out;
>  		}
> @@ -867,6 +873,15 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>  		 * always access fmt[i + 1], in the worst case it will be a 0
>  		 */
>  		i++;
> +		c = fmt[i];
> +		/*
> +		 * The format parser below only understands ASCII conversion
> +		 * specifiers and modifiers, so reject non-ASCII after '%'.
> +		 */
> +		if (!isascii(c)) {
> +			err = -EINVAL;
> +			goto out;
> +		}
>  
>  		/* skip optional "[0 +-][num]" width formatting field */
>  		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> index 594441acb707..4e4a82d54f79 100644
> --- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> @@ -114,7 +114,8 @@ static void test_snprintf_negative(void)
>  	ASSERT_ERR(load_single_snprintf("%--------"), "invalid specifier 5");
>  	ASSERT_ERR(load_single_snprintf("%lc"), "invalid specifier 6");
>  	ASSERT_ERR(load_single_snprintf("%llc"), "invalid specifier 7");
> -	ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
> +	ASSERT_OK(load_single_snprintf("\x80"), "non ascii plain text");
> +	ASSERT_ERR(load_single_snprintf("%\x80"), "non ascii in specifier");

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

>  	ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
>  	ASSERT_ERR(load_single_snprintf("%p%"), "invalid specifier 8");
>  	ASSERT_ERR(load_single_snprintf("%s%"), "invalid specifier 9");
> -- 
> 2.20.1
> 
