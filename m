Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D940DFA7
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180369; cv=none; b=SPpUx3I6WlyB/oHOLNjK/z4AaRNwdmaCNi9d5DX+lPxs7KF0UEJ+k9nmGSUxPdXOCYfkCcVcsNYxbhSXX8jS+P34xeAfuUPQBCMLDbJE/N8yAw9WxGlyDqeQ9v70MgDK/Kcoz7Qk1ZHP6ED1bxM1db8Fzh6Oa7vagp+E1cLc6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180369; c=relaxed/simple;
	bh=BqLjmjt93qTdBgGkC6yjJjjdQGRrcRtGjCClSimgoZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NecoUbJjPnBJ/+so7729HVhGAlQj1y4Qm9YGeAYhGAQc7A1Re5QPfjhfjjFq9qkjlszKfzf3fuOoGF+m3wwyB3lQe5xHoAp1eKln7gzb4BSBJlfxmGmHc9tWjtuFEJEgipUHoB4oIAvUhPxJVrT+eHyHdZyYY1dI9xhWkk9XhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ept8qdxj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ept8qdxj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso54380975e9.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776180365; x=1776785165; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9tUKxGMHC0UDPNw0oVjzyTegsE8nihYWyTCLi91CQkQ=;
        b=Ept8qdxjZY60mO/ysRPbb/E8OfSiF51NJUCzMDA0N4Nvwx30Lc85htjpsXed5aZhUo
         NTMjyMWdJbvru1bi6BDXZZDjjNVvNAWzAUhe3oAFYt938qQCarFAfHwsMo5NJ6a60Khh
         HBqpR0qaICJhu/mbV4/Xvl/a/xKUiCTDGvHus67yU1SZOdvh73XVEf5z9r449xp6o2t9
         VQ9iX/XVuZeedAxCGyu1moUsO3nfgQ4ZLaGfTPonqAC/4EFkZTTQ3JMx9tYoDfmaXEOk
         IHBAFq6pL/5XnxAFLi7/ziXVVGEprm+YnC5SuDyV2WYqvZQvKmwK/Ryfy/CpJ6Cfz2Fd
         Xbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180365; x=1776785165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tUKxGMHC0UDPNw0oVjzyTegsE8nihYWyTCLi91CQkQ=;
        b=NQTAokH3/Q3P/w99tcfkhx+VFHsRZC1ODEgTx0nriZI6EV+SpmWogA5h3zKb+3gfMT
         MHUJFGZ6+h78hL6hTojpkRVv3KRFOtUrF/FdecoI7A0GbbQmE7U+4zCNlh+Xp42w5ayP
         7fz/FINbZKUVQTpzW7rHv+heSbxKfAOW/+YREavdKXBDVUCMnr1AeqC4Xlj6d5FjHlGH
         o/PLWRFJmBzvNN5oma0adcaaWtCwAEbVjQ88AvKG0xC4k7vK4F7IhxA3DNhlg5A3ilLM
         7rTEefFsycZEgZq0soK9x9tb2U+GuV6IvH1jDSe6EShgrbIaVPb5GVIkKIodn+aHmeoP
         yRcw==
X-Forwarded-Encrypted: i=1; AFNElJ/GFqxbhgN39L3i2COdE0+wz50CSvX2ljX2cJFAFK6FDfrcyaM6ivVGSr8zgxE77rDGSww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4Sd9FdhAHwi35ifIAmALr0xMSDvGe4D1Uxh67pP3ZLH0v0ft
	QEGhWu84YUqG6+QpDz5/UIt7vcNd1wLi6PJZGDOHHPg5bz2b6FQUQt4x
X-Gm-Gg: AeBDiesxVXZBVrP0oemRnClL+GVJ/sArWLLp8WUqPmK18rRIg4q5zKM76JEHWwu+BwC
	bTXr02ff/mWKK2fB/uys+aH7ytEWo1HG/sFbq7PFsA+DgnXdyL5gsczQn7jMJo9kICWMCR30iuH
	5M7krQzJCKn1iZsdZdEXWbXafuJNRnxuKWwH4vSoZE01ag5t3qqMeQxvkpaBg+GSfRJSP8wRBae
	vuApmg8dITM/NEtPpp+EC7m7ms1ksKupBbHuXc7U+/0xfnRK/CF/x95lT+xbXzMoTc6vcOjPWaD
	NBmdqUGiAMsqni1UaEbVx8LjZdIN06McDLO5cgRGCzc2CNtwINRksYMGzUn3wfKDYN+tTSs+ZpN
	zRzjQECqnoApILSQz4zZB+lpfxsA1eHtGj4wQmKEVslNImgzMldtkTxL79gxbN+76vB5h9+4VgR
	4yZSYqp1Bks2aYsazc+FN6NiZnPnwuInYdqze7QM1DsdraufTnnRQ/+n7VfLseme/2b8LfFVx43
	2RAVH+XxIFxDOV5R+I9oi9rHL1tJ3qe0phkM967YgvjS4+8WiMk9imJviPpKb2FF5uFi915zZDF
	QNBF4hC0WJNdRgRalwlwZSGgoLsZySeLWE7i2HZssO0=
X-Received: by 2002:a05:600c:314b:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-488d687c076mr214204155e9.26.1776180365151;
        Tue, 14 Apr 2026 08:26:05 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e002e3feaf8ac5b1b0d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2e3f:eaf8:ac5b:1b0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee049333sm58589345e9.15.2026.04.14.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:26:04 -0700 (PDT)
Date: Tue, 14 Apr 2026 17:26:02 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@uniontech.com
Subject: Re: [PATCH bpf] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
Message-ID: <ad5ciqi7KAq0C9A3@mail.gmail.com>
References: <20260414014001.814324-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414014001.814324-1-dingyihan@uniontech.com>

On Tue, Apr 14, 2026 at 09:40:01AM +0800, Yihan Ding wrote:
> bpf_bprintf_prepare() currently rejects any non-ASCII byte in the format
> string, such as UTF-8 Chinese text.
> 
> All BPF formatted output helpers that go through bpf_bprintf_prepare(),
> such as bpf_trace_printk(), bpf_seq_printf() and bpf_snprintf(), only
> need ASCII parsing for conversion specifiers. Plain text does not need
> that restriction, but today any byte >= 0x80 makes the format fail
> validation.
> 
> As a result, UTF-8 text literals are rejected even when they are not part
> of a format specifier. In practice, an ASCII-only bpf_trace_printk()
> format works, while the same format with UTF-8 literal text produces no
> trace output.
> 
> Allow non-ASCII bytes in plain text while keeping the existing control
> character checks and keeping format specifiers ASCII-only. This preserves
> the current parsing rules for '%' sequences and allows valid UTF-8 text
> to be emitted.

Nice! I can finally print proper French from BPF :)

> 
> Extend the trace_printk selftest accordingly by emitting both ASCII and
> UTF-8 strings and verifying that both appear in the trace output.
> 
> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>

Not sure if this should go to bpf or bpf-next. I'll let the maintainers
decide.

> ---
> Testing:
> - Reproduced on x86_64 without this patch: ASCII trace output works, while
>    UTF-8 literal text in bpf_trace_printk() is rejected and produces no trace
>    output.
> - Verified with tools/testing/selftests/bpf: ./test_progs -t trace_printk
> 
>  kernel/bpf/helpers.c                          | 21 +++++++++++++-----
>  .../selftests/bpf/prog_tests/trace_printk.c   | 22 ++++++++++++++-----
>  .../selftests/bpf/progs/trace_printk.c        |  5 +++++
>  3 files changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6eb6c82ed2ee..e2f103297e4a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -845,7 +845,13 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>  		data->buf = buffers->buf;
>  
>  	for (i = 0; i < fmt_size; i++) {
> -		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
> +		unsigned char c = fmt[i];
> +
> +		/*
> +		 * Permit non-ASCII bytes in plain text so UTF-8 messages can be
> +		 * emitted, while keeping format specifiers ASCII-only.
> +		 */
> +		if (isascii(c) && !isprint(c) && !isspace(c)) {
>  			err = -EINVAL;
>  			goto out;
>  		}
> @@ -867,6 +873,10 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>  		 * always access fmt[i + 1], in the worst case it will be a 0
>  		 */
>  		i++;
> +		if (!isascii((unsigned char)fmt[i])) {
> +			err = -EINVAL;
> +			goto out;
> +		}
>  
>  		/* skip optional "[0 +-][num]" width formatting field */
>  		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> @@ -881,8 +891,9 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>  		if (fmt[i] == 'p') {
>  			sizeof_cur_arg = sizeof(long);
>  
> -			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
> -			    ispunct(fmt[i + 1])) {
> +			if (fmt[i + 1] == 0 ||
> +			    isspace((unsigned char)fmt[i + 1]) ||
> +			    ispunct((unsigned char)fmt[i + 1])) {

Why is this change needed? isspace and ispunct already cast to unsigned
char.

>  				if (tmp_buf)
>  					cur_arg = raw_args[num_spec];
>  				goto nocopy_fmt;
> @@ -958,8 +969,8 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>  			fmt_ptype = fmt[i];
>  fmt_str:
>  			if (fmt[i + 1] != 0 &&
> -			    !isspace(fmt[i + 1]) &&
> -			    !ispunct(fmt[i + 1])) {
> +			    !isspace((unsigned char)fmt[i + 1]) &&
> +			    !ispunct((unsigned char)fmt[i + 1])) {

Same here.

>  				err = -EINVAL;
>  				goto out;
>  			}
> diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> index e56e88596d64..f7b03dc4eaf4 100644
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
> @@ -46,11 +49,20 @@ void serial_test_trace_printk(void)
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
> index 6695478c2b25..97afe8b149b0 100644
> --- a/tools/testing/selftests/bpf/progs/trace_printk.c
> +++ b/tools/testing/selftests/bpf/progs/trace_printk.c
> @@ -10,13 +10,18 @@ char _license[] SEC("license") = "GPL";
>  
>  int trace_printk_ret = 0;
>  int trace_printk_ran = 0;
> +int trace_printk_utf8_ret = 0;
> +int trace_printk_utf8_ran = 0;
>  
> -const char fmt[] = "Testing,testing %d\n";
> +static const char fmt[] = "Testing,testing %d\n";
> +static const char utf8_fmt[] = "中文,测试 %d\n";

The build is failing because you made these static.

>  
>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>  int sys_enter(void *ctx)
>  {
>  	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
>  					    ++trace_printk_ran);
> +	trace_printk_utf8_ret = bpf_trace_printk(utf8_fmt, sizeof(utf8_fmt),
> +						 ++trace_printk_utf8_ran);
>  	return 0;
>  }

Please put the selftest coverage extensions in a second patch.

pw-bot: cr

> -- 
> 2.20.1
> 
