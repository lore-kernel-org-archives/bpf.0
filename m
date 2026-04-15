Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54182348469
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249905; cv=none; b=O5FA7b/f9DziE66RWxAIHA7gjSiG9Y3cbU2De8hspfcIabiKAwUY2uAW98a6LWJmQsATcfX4brffi4rzPY+wQIuCtOrOVv1zV7GWC/1nSB8m18jzvDRBYZ9z6ChSOYpaS+rf6ZLex9cCCZljfadHgM4MaJtx88qgomyAhknSZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249905; c=relaxed/simple;
	bh=OM6mZ44WWK3DfAZjMgCt5VOj2tdbsaEa/tQ78TBhg6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRF4wfuqBXPP6kkdTrlgx66snOKQMxhkqztL3xytJcwn5fdmzm/VX5jQtNvE/xrX8SyH+6CJ8cPhi46SUmXf+gxfZG6Hh+J7V+bfoM7WulN7ZQWcWfu88WPphAa1MK5avOCRLTZ0gFv4IjEAdWTBruyhV1snXLz/f0OsmD/F6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+Yq6GaN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+Yq6GaN"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d77f6092eso2288840f8f.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776249903; x=1776854703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTbZrZtimuJtSt35YQw8j+gArP0pbT19vrg90Wj6L9c=;
        b=f+Yq6GaN+8/7aqoXNwFd0AlfwLdPBFZvMdylPELB8mhTpS75OXyozztRwLYAAK09Ko
         wVzzFnRvc/8pQISXoVEWDYn9Ej4gPUE5iIE2NkOtrgAFJR7leSmMPvTvMyk8pYTF8pEe
         dPkjk7ynOXYVWp4oXNt9RcPGu31zAWqP3BnKsPLr2Y4ueyJazLU3/TrD5NEPA9Vb2c45
         icxwbv4GtAuitCTuNq1Cv8JldZIaeChksn8HWxuCj6Sz2zK5soqZtIIiIiHRZDm1ON/G
         QLKLmfBlr4R2FhEjwGGBhc0ACYFWmn/9FqjhnOIAMx/lFyixjQwubEYmwL0rTtI8GIVQ
         NMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249903; x=1776854703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTbZrZtimuJtSt35YQw8j+gArP0pbT19vrg90Wj6L9c=;
        b=nkcv2Eqo7nP2pvJfxSwVQbWGzxFsLOMREV3NIhxA8V7iJhcPviD87IGQ8zvllpvT2Z
         4exwVkI5skjTLBOVX8CeT2EzZWRivy50JF690VumNDbky0lm4gH9VTk2MAGmoQO543Be
         6LEfsjOdYwEMt/HQlvMnV1YSTMnNS6JjmBxmyrEjlVbUlSqQcVYX3wwtWuklK2RUAIN7
         wyjbRV13SgOFMJh2Tv6KFm+MxHxsh3rZyjalw55sf20+llqeZk0BX12teQ+l6NZefwfR
         y+LTsi1ElJk9qy0bhze5g+urIOfIHvyuKi4s0nj2XBY9FJkqfeizlbOdJey8yFsrdrVN
         ffyA==
X-Gm-Message-State: AOJu0YxxQF/QnRU7b5oWxlr8NLc3y4b12R4jD3LwiyVPr3tY41aMDAj8
	zJB8ixLZCsgOhghGhkaneNMN6CGhTrG2ddquuln8811gnAmkJF69n27x
X-Gm-Gg: AeBDieu9hh8pQH4/NlFohC5w0uDTb6uky4ZbA9XqfX9mfn7p+n3HiJyYXF9HvuuEVfv
	HcjJcyTJx1+hWto8w/sQfV1jQCj37wzMV7wmAFHjF/KWBJfN9SlMQfvF10IuTMR2TbuXy4X3uYF
	Am8acIV4I2XC0P40OSl4ORxzqLkZEyl5Yq/UZSl40ZI9qpFwNqjlMCcR4O0sWDbTpXIHgcrIDK1
	CDYdfr9z53NzRpcRQT8RgWcvZQf8KfGMXuJrytiqwC2xPGWuE/4CkqQo9/zcOb9ZjYd6EsSJW8w
	P0SiTo7g+2WBY5N61L0zKKkHhoYCftlmk3U0vxM+moYOIJwn/OQ0ikyfKi2JmCLFaRb379J7YZ9
	oxQU8uuWTAEMdl5ucCjXWY5xaRbgKvMiKMengtsN95xrObOoMG4RUlHL1u6LjGprqzhu49wlgSU
	uHHeluld3ZtZ7VmgAR+bsA592YzJe3ORt8IGbuV3Iks0UzLUWIWs6VdQ9VfGa1vJAtDdjJojZx+
	JHCsb7JOsGMdVxidOlsTRcECgKIw9KkepuPG1Mux4sh8ZSEdoENewe/yIww3n5AIIaw8LylYbq9
	TKSNCcXWUF2sFFvEJiSo4g3fNv3iQkaWZe9CJ8hmOsbxAV83D4r1zCFLlaAQa8BB
X-Received: by 2002:a05:6000:144b:b0:43d:76d8:5797 with SMTP id ffacd0b85a97d-43d76d858b5mr18674254f8f.51.1776249902441;
        Wed, 15 Apr 2026 03:45:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e002eae79bbf3d352f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2eae:79bb:f3d3:52f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5c8fsm4384790f8f.19.2026.04.15.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:45:01 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:44:59 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
	alan.maguire@oracle.com, kernel@uniontech.com
Subject: Re: [PATCH bpf v2 1/2] bpf: allow UTF-8 literals in
 bpf_bprintf_prepare()
Message-ID: <ad9sKyzvsYqgu_yY@mail.gmail.com>
References: <20260415032126.1096299-1-dingyihan@uniontech.com>
 <20260415032126.1096299-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415032126.1096299-2-dingyihan@uniontech.com>

On Wed, Apr 15, 2026 at 11:21:25AM +0800, Yihan Ding wrote:
> bpf_bprintf_prepare() only needs ASCII parsing for conversion
> specifiers. Plain text can safely carry bytes >= 0x80, so allow
> UTF-8 literals outside '%' sequences while keeping ASCII control
> bytes rejected and format specifiers ASCII-only.
> 
> This keeps existing parsing rules for format directives unchanged,
> while allowing helpers such as bpf_trace_printk() to emit UTF-8
> literal text.
> 
> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
> Suggested-by: Paul Chaignon <paul.chaignon@gmail.com>

I don't think this tag is appropriate here. If you want to give credit
for changes made after reviews, you can do so in the Changelogs of the
cover letter :)

> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
>  kernel/bpf/helpers.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6eb6c82ed2ee..6319b39c92f9 100644
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
> +		 * Permit bytes >= 0x80 in plain text so UTF-8 literals can pass
> +		 * through unchanged, while still rejecting ASCII control bytes.
> +		 */
> +		if (isascii(c) && !isprint(c) && !isspace(c)) {
>  			err = -EINVAL;
>  			goto out;
>  		}
> @@ -867,6 +873,14 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>  		 * always access fmt[i + 1], in the worst case it will be a 0
>  		 */
>  		i++;
> +		/*
> +		 * The format parser below only understands ASCII conversion
> +		 * specifiers and modifiers, so reject non-ASCII after '%'.
> +		 */
> +		if (!isascii((unsigned char)fmt[i])) {
> +			err = -EINVAL;
> +			goto out;
> +		}

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

>  
>  		/* skip optional "[0 +-][num]" width formatting field */
>  		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> -- 
> 2.20.1
