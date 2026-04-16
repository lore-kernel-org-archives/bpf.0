Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E724336D
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776378949; cv=none; b=DrkK4xca99d+YEZCE/JhYaJxa6CcNjnT7pFBEAkZ5MsVQBasjOjDpb3ZdYvx0Ik7QVOERiu+ye6SAtSk8PNMNAYBgjgvurCpFDDTdrT3vj2ihkdB2Gpi+fW+Y9Qw8x7lqCZGyvFDOXeDi/Blk9zX2oXESOOk4joj4fh25kntHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776378949; c=relaxed/simple;
	bh=QWfrlipXQsOy06lz6vFBWissQz/4ZX9aVwggQjyoGYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFlbXG/oVIbYM2vO1QnyM6A+l8o1/q5rDqAx0peWS6qOEWfNoWJ6VqSsXsztYO2CmShcsaOgJHEfgMtddf8uzhTN2UpBZ+2jerPVH3Z/UFw9s2SsgmM/drNKAWHbY/AYmo65JWJwhA1wBkX3ZeCGfVPx5sQ5WtO9XPsFFvQxbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMSqe8sS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMSqe8sS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so767435e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776378947; x=1776983747; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LQR71K9y6cyOEBCESH0pgQ7cpkLOqqoQKhR9kTbYgkg=;
        b=EMSqe8sS/fCwSglUHKoycTUsUERTMzxPdUCdrTlBpX2ZNTWMwnGGRxCTQnr8N5T+PG
         AIFq2ATqNubyRAanxIhGS8mHra8x6jy/aKQMq1YMh6C9UGv0kFz4tQHcS6dojTCr1vlt
         b9sGvBDGl1Wspe1kEhFpyWTFa6IpoyRcIBIpfuE+HpT46s/9wvsih7OQeCOm6s9bna/e
         JCu9xOJJUL+HqF7/KmQlU4Fun6rJkUQZRDfZTXGfCbNm4XcQHtnzkjxjVUyscBW75sA1
         DMxrX+Cgk5H3fOEITxWsS03y6hVDNYblCI5sdgjMgEY+g3liJueAdznqLuSZEUMO/73T
         +Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776378947; x=1776983747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQR71K9y6cyOEBCESH0pgQ7cpkLOqqoQKhR9kTbYgkg=;
        b=O/UQWwF/VghnPeEL3wX7prhrlvkeQa/+BCC0qlQwhrCMiCgnB0hz6vYepzf+ITvSc4
         uVWZ5STGL7Bm4NDPMQa5MilonPL3DKnxrv6bhML+vu/J1bNPC67aDymsLoOMou+5opae
         dz2WI3403xND7ORNeoNHcWJmVHsgR65oZqi3aE6TSQs4NpXWem22J4bs//XsnpP0WEW+
         Qr6Mx8skDBxyEqauZ7DnK8Jal9z2CBTXITnZiMjK8ZInWGLRnoYRqlnuSOOkDvkcSHim
         /yZGfqQlqZpJ9vTKLWaacKdy1CGU+WBznB6FFwMU3BwuVtjC1OvgF5CFCEYQ4TwvNkkf
         ToVQ==
X-Gm-Message-State: AOJu0YwalC5LT2GfCQrfJA7ewvQrS1mn7CPZB0HJaaZCiudMLFTAAlsi
	v1lASVO8a3oH3Yk7L5bxoo5Y/q+5tSZ/mst8FQqwMt7iKF0hJEpHYO+i
X-Gm-Gg: AeBDietPROGrtkYlKh8cuipXdUhig9ymb9YfB1ErrlzBDUT9hiwCjX+YxkWnvoAQmQB
	rht9JHYBgT0SdNiOt1+Z6SXY2TmfHwhnfk/xPzTWwIEMLcvxxZpET8UFgELQctWut/XtgNuitgR
	vwwWn0ig1tBqsACY5OGAXgAkJSSPGtc6KRwUv+irGuTD3dlYWojC3EvG4Znut6tmFrSS+qqCUxV
	Jc3oPZIabkpVfR7LDNy9MvHoxh5/5pknJGU4sBvWdL1Om8U/rF3IxdOoQbVrrjF7gajPPMKAtEF
	g+god/mJEPzvR448DZYxVGwGbR+yUeOavnw0RDG2LoblsX/KePPvJeQ6rPVC64Tc705aGW2gD/V
	Z5CaWvR4LpLfbUDIZF5Jx3tpIs3xjallEcysL/nDVnrwawRssvswAv5tlkrbhmwdy7qtVWPDYrA
	2VCYX2e06jAjMVMm+dyBqzTOtAPCMqz+TzrmG8+6MwY/aKGrwemzhCNiNbZb4FIkU6zgwZq4nD/
	a4sdBTnqmIxHzjEspmc41C2IXwBu3qWnuI4lJYe1RtQ7zzwRvrrTQCLD/HeztvK9Tb3W0rgt2/6
	vIpjkOpkdaZ/GhR+QC8UbfJGdXoBLwwADDFj+5/KWh2xvv4RzzexSw==
X-Received: by 2002:a05:600c:a309:b0:488:dfbc:490c with SMTP id 5b1f17b1804b1-488fb765df6mr3363695e9.16.1776378946564;
        Thu, 16 Apr 2026 15:35:46 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0092ca608f43e4326a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:92ca:608f:43e4:326a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581d836sm79610725e9.7.2026.04.16.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:35:45 -0700 (PDT)
Date: Fri, 17 Apr 2026 00:35:44 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, shuah@kernel.org, alan.maguire@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: cover UTF-8 trace_printk output
Message-ID: <aeFkQND58p4BHdWS@mail.gmail.com>
References: <20260416120142.1420646-1-dingyihan@uniontech.com>
 <20260416120142.1420646-3-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416120142.1420646-3-dingyihan@uniontech.com>

On Thu, Apr 16, 2026 at 08:01:42PM +0800, Yihan Ding wrote:
> Extend trace_printk coverage to verify that UTF-8 literal text is
> emitted successfully and that '%' parsing still rejects non-ASCII
> bytes once format parsing starts.
> 
> Use an explicitly invalid format string for the negative case so the
> ASCII-only parser expectation is visible from the test code itself.
> 
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>

The test makes sense and I verified it fails as expected without the
fix.

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  .../selftests/bpf/prog_tests/trace_printk.c   | 28 +++++++++++++++----
>  .../selftests/bpf/progs/trace_printk.c        | 10 +++++++
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> index e56e88596d64..a5a8104c1ddd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> @@ -6,18 +6,21 @@
>  #include "trace_printk.lskel.h"
>  
>  #define SEARCHMSG	"testing,testing"
> +#define SEARCHMSG_UTF8	"中文,测试"
>  
>  static void trace_pipe_cb(const char *str, void *data)
>  {
>  	if (strstr(str, SEARCHMSG) != NULL)
> -		(*(int *)data)++;
> +		((int *)data)[0]++;
> +	if (strstr(str, SEARCHMSG_UTF8))
> +		((int *)data)[1]++;
>  }
>  
>  void serial_test_trace_printk(void)
>  {
>  	struct trace_printk_lskel__bss *bss;
>  	struct trace_printk_lskel *skel;
> -	int err = 0, found = 0;
> +	int err = 0, found[2] = {};
>  
>  	skel = trace_printk_lskel__open();
>  	if (!ASSERT_OK_PTR(skel, "trace_printk__open"))
> @@ -46,11 +49,24 @@ void serial_test_trace_printk(void)
>  	if (!ASSERT_GT(bss->trace_printk_ret, 0, "bss->trace_printk_ret"))
>  		goto cleanup;
>  
> -	/* verify our search string is in the trace buffer */
> -	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, &found, 1000),
> -		 "read_trace_pipe_iter");
> +	if (!ASSERT_GT(bss->trace_printk_utf8_ran, 0, "bss->trace_printk_utf8_ran"))
> +		goto cleanup;
> +
> +	if (!ASSERT_GT(bss->trace_printk_utf8_ret, 0, "bss->trace_printk_utf8_ret"))
> +		goto cleanup;
> +
> +	if (!ASSERT_LT(bss->trace_printk_invalid_spec_ret, 0,
> +		       "bss->trace_printk_invalid_spec_ret"))
> +		goto cleanup;
> +
> +	/* verify our search strings are in the trace buffer */
> +	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, found, 1000),
> +		  "read_trace_pipe_iter");
> +
> +	if (!ASSERT_EQ(found[0], bss->trace_printk_ran, "found"))
> +		goto cleanup;
>  
> -	if (!ASSERT_EQ(found, bss->trace_printk_ran, "found"))
> +	if (!ASSERT_EQ(found[1], bss->trace_printk_utf8_ran, "found_utf8"))
>  		goto cleanup;
>  
>  cleanup:
> diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
> index 6695478c2b25..f4c538ec3ebd 100644
> --- a/tools/testing/selftests/bpf/progs/trace_printk.c
> +++ b/tools/testing/selftests/bpf/progs/trace_printk.c
> @@ -10,13 +10,23 @@ char _license[] SEC("license") = "GPL";
>  
>  int trace_printk_ret = 0;
>  int trace_printk_ran = 0;
> +int trace_printk_invalid_spec_ret = 0;
> +int trace_printk_utf8_ret = 0;
> +int trace_printk_utf8_ran = 0;
>  
>  const char fmt[] = "Testing,testing %d\n";
> +static const char utf8_fmt[] = "中文,测试 %d\n";
> +/* Non-ASCII bytes after '%' must still be rejected. */
> +static const char invalid_spec_fmt[] = "%\x80\n";
>  
>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>  int sys_enter(void *ctx)
>  {
>  	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
>  					    ++trace_printk_ran);
> +	trace_printk_utf8_ret = bpf_trace_printk(utf8_fmt, sizeof(utf8_fmt),
> +						 ++trace_printk_utf8_ran);
> +	trace_printk_invalid_spec_ret = bpf_trace_printk(invalid_spec_fmt,
> +							 sizeof(invalid_spec_fmt));
>  	return 0;
>  }
> -- 
> 2.20.1
> 
