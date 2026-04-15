Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60018324B2C
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250009; cv=none; b=QONxVHqWiXJNe2gD+dgvIQqhu+bpQ5HrV9hHX8aI8VWTQLC8ZdPB6PtHgx/Ya8RCPfqOzDbEATOpEoW6dCBQN8pbPS+baM5T3l8nbFfaZF2oC/ZHri5L3Iehvtspd/sxkDT5hfVYSLpEd+wjf2pdATklnYySHU8puCfImRRTVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250009; c=relaxed/simple;
	bh=9m8LLVuekoZrUqDaJL5KIFdzYu7go3oFy6RBNSSWIPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osB72T5IoNVwr/oAFLEmMqMdiZRumRUKVbvuII8IFtq1iel+HZDJH+8QLESy3PYDaJv4dKghvQbxbDbwwTWhTCPO+ODk1RQzafrFVpSbC5Ii/AlXHHkRSTkUT699dHPEmD/KfHsmcqA4AoTpDwG8RaPF41ue+/JMC3ozgvYFYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvn+m0ym; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvn+m0ym"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b150559bso51952975e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776250006; x=1776854806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vWB95ECdNaqG8R3w9ufXZEWrwCnsaXtoCFDXx5Xjens=;
        b=cvn+m0ymHKpAdNgC+IFTXWuyS6IvZAOkSYAk8VVUhUn2xJSUkM0BPHBkAZG5h5RmaK
         +eu3k1Rc1afBzqlWBS41xAVuFMc0RPnvT9q5/qCQl4z72MNZpI1oHj44hCct9bDd4YVP
         vl5WpdDiCgEbuRYiC9G1ZrSSCzGLRFVFcffbfpclIlQBjabkM5YhTxyj8bU7tqdkag6f
         nYmRoby/MPBvvS2+SdcsfNEuWBd7DQ8aRHPYZkUIQ9sR3WEb78jkVpOxrVWa1IxM9hf8
         rikcaP8OUpjsvhzdMvbHtrTLXx1q4kumsOAmjEbVt0fD96vxlpgKlIGiHlzr9GiiQkON
         1/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776250006; x=1776854806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWB95ECdNaqG8R3w9ufXZEWrwCnsaXtoCFDXx5Xjens=;
        b=UBIOGr+TcCFnKFjFYUp4cOtZT5mvJ5/zaP/XrZgyN0GNlrMIl0KCHV9Y2q5fv13Tae
         J1nu9Xm5bL3dR9Bb8vdi4p+vjpn0V1pufMAyHJU1+3kAWbrAbYWNxkPJ3jjaXFahr3aP
         lNeBiB+WXqOe4os40OSyuyMD/lw12vt7e4U2Cl1R1MDSNYhkgW91f0MNHHV9ma1kRUzg
         owM6zZLjQ0hwKkAz9M9m/KA1YqCvnnfOb9NfHwWJZsKXcuHeo2D3AUNliLLBDdSv22qp
         d1zGuXRQPNkAN63ngoKvgpNhLpVzDd487lZCZzRYoBJSVB/ep/zw/aaiDscW92lvpfR1
         M4gQ==
X-Gm-Message-State: AOJu0YwMt3qmWDxgRJevvNBOOYt4e4kG8lqDcGumvLNI3ydhKbGlgkXp
	EXAH5OyfQ22WrTz/qE7waIOiENVS127bU3KPNgobzGgzU/SauVErwztM
X-Gm-Gg: AeBDievizwWv+3bG+9tApdPs/nfwYtPACwbxeXFXZ0TenaDQ+cnbtfVvjEVDgvYMTVC
	soP+h87EWNat658UvNMEB3G3Pyuc+YTkwONpfXUwf8EqFDj8ka/G5xnobQhqSN0ykRBqsFCWYHV
	//d98+dPpbXh/OUnzy+teYtcxHRRmdin4A+gg6uY5BlbuJKNWZJMfeAUvFhDgjQVZOF8Xwx9/YB
	52nF3VJn84CqqIVSu2glc77+d76MskIEAOGMqLMivQlyv1rvCqps+R8YygDl/2RqLsW46Qu4FR0
	5qNhnHyoMfKVABf181YRsgejEkboU8T5OH7GCSvB7gMB5DSX0wYOVHJ5F+Yv05f89W/ixb/YGLO
	jxVl+v0LiKCgMy+kDUKq46FBtdqc4Ey5c6DwFx0tgheJBRWOeNV54CNWoOM1SgSO5MxSRlKcDIc
	uSURWQo9w9jqMDGVbIbjjzwT2uk5/3gNu/7j3fAWWGhuAyBbW9qbERIxIJtW4Y6pWM6GL/ONI5Z
	U20YspYDcKIJqSpijt4H6sCmjbnKYpbrKDCryOtGnio/WyBOmy1U77uFZFgbFMQUyLg45PEGC6p
	dlVpp1CJxS+llv7RrKZmmMweXVP0srIC11j0pxwgq/Ir4nEWXz2qZB6KXl9MVAjS
X-Received: by 2002:a05:600c:871a:b0:488:a2ac:a34a with SMTP id 5b1f17b1804b1-488d67f4299mr311675515e9.10.1776250005451;
        Wed, 15 Apr 2026 03:46:45 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e002eae79bbf3d352f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2eae:79bb:f3d3:52f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9a77dsm17358825e9.18.2026.04.15.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:46:44 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:46:42 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
	alan.maguire@oracle.com, kernel@uniontech.com
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: cover UTF-8 trace_printk output
Message-ID: <ad9skjpRx5TB6DBr@mail.gmail.com>
References: <20260415032126.1096299-1-dingyihan@uniontech.com>
 <20260415032126.1096299-3-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260415032126.1096299-3-dingyihan@uniontech.com>

On Wed, Apr 15, 2026 at 11:21:26AM +0800, Yihan Ding wrote:
> Extend trace_printk coverage to verify that UTF-8 literal text is
> emitted successfully and that non-ASCII bytes are still rejected once
> parsing is inside a '%' format sequence.
> 
> Suggested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
>  .../selftests/bpf/prog_tests/trace_printk.c   | 26 +++++++++++++++----
>  .../selftests/bpf/progs/trace_printk.c        |  9 +++++++
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> index e56e88596d64..40499f01d228 100644
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
> +	if (strstr(str, SEARCHMSG_UTF8) != NULL)
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
> +	if (!ASSERT_GT(bss->trace_printk_utf8_ran, 0, "bss->trace_printk_utf8_ran"))
> +		goto cleanup;
> +
> +	if (!ASSERT_GT(bss->trace_printk_utf8_ret, 0, "bss->trace_printk_utf8_ret"))
> +		goto cleanup;
> +
> +	if (!ASSERT_LT(bss->trace_printk_utf8_spec_ret, 0,
> +		       "bss->trace_printk_utf8_spec_ret"))
> +		goto cleanup;
> +
> +	/* verify our search strings are in the trace buffer */
> +	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, found, 1000),
>  		 "read_trace_pipe_iter");
>  
> -	if (!ASSERT_EQ(found, bss->trace_printk_ran, "found"))
> +	if (!ASSERT_EQ(found[0], bss->trace_printk_ran, "found"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(found[1], bss->trace_printk_utf8_ran, "found_utf8"))
>  		goto cleanup;
>  
>  cleanup:
> diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
> index 6695478c2b25..62153d8c5eba 100644
> --- a/tools/testing/selftests/bpf/progs/trace_printk.c
> +++ b/tools/testing/selftests/bpf/progs/trace_printk.c
> @@ -10,13 +10,22 @@ char _license[] SEC("license") = "GPL";
>  
>  int trace_printk_ret = 0;
>  int trace_printk_ran = 0;
> +int trace_printk_utf8_spec_ret = 0;
> +int trace_printk_utf8_ret = 0;
> +int trace_printk_utf8_ran = 0;
>  
>  const char fmt[] = "Testing,testing %d\n";
> +static const char utf8_fmt[] = "中文,测试 %d\n";
> +static const char utf8_spec_fmt[] = "%中文\n";

What's the purpose of the second string here?

>  
>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>  int sys_enter(void *ctx)
>  {
>  	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
>  					    ++trace_printk_ran);
> +	trace_printk_utf8_ret = bpf_trace_printk(utf8_fmt, sizeof(utf8_fmt),
> +						 ++trace_printk_utf8_ran);
> +	trace_printk_utf8_spec_ret = bpf_trace_printk(utf8_spec_fmt,
> +						      sizeof(utf8_spec_fmt));
>  	return 0;
>  }
> -- 
> 2.20.1
> 
