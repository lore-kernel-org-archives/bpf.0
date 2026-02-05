Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89293612E0
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281643; cv=none; b=RYasoiOH4Es4smTXRN0zllxBMhdVnVx5Iv5+ocnHKjQ7LOybxx8EPiejb7Vq1+q6sNz0KEWlvxIlE3VM4TfXSxxj99N0T8rE7jA7KXQjBLfcO6xYoPGCo4bdEUxIP2h9xkfwWq9yeUFshXusGGij0WgVCBF4f7VhvaaB5B5q/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281643; c=relaxed/simple;
	bh=8Ud5KZqbUXkKx9YEHMMR1n4ewjTIPhDWsP0iGDJn2h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHAtlVdu8WM5mqxQSWHlMBf8u37XLG4ESOwfV8PIBTf/bUEsgTmvN2U2zSs0vYJgwwZgLZBKKba6yks9ccKwDmPHcyjWcx+hKDBs3xWNZVxPyBJd1ZI1jsU3nw9B9oXE36DxUlANGMGP5O8xjxvfesxzMx/32B70h5DuCDZhTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SLHPrE0v; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SLHPrE0v"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359a316d89so566155f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770281641; x=1770886441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WU7C8rJBZ4r5s92pw84UJSyynxDDIXXSUn6SFXmn01U=;
        b=SLHPrE0v9hoFddecXZuUfFwkCrSk+ryl046M7oEspcwVqlaAud984kz5SqEOHc0zyg
         fUc0oQAMa5PXWFQMGjFWsygJtx0L8+5nIqFIs2YXdc0bcql6STl6Cw6AYVUZnDFgjHWy
         efyEph50Z9N0r45A6XAn2fCSsP61sebzAjFVnt73hYl/W6wHkeG4Ok3ZkoxkC+BNIjFr
         FIxy8oBf6Sd+jrNsGHHU0ufqiZ4KnjdB95a5kU+l19938vRhvSZOOa6sUY9MnCv6PxVR
         kuoPsBoHyivlk+96UB85qeeD8XSyqGvKQfcogMsEGs6+IIxAgvOsdqx3sIoa4gY7f45S
         8Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281641; x=1770886441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU7C8rJBZ4r5s92pw84UJSyynxDDIXXSUn6SFXmn01U=;
        b=EKZQyyRYo+/w1ZNLWa6ozo6OWq5ZD84PnjRYj1Ix6Ob9SIoUS584D0KqEt7PvRaCKP
         CmR/V5lNiR6UF4o0r3oC7+CkTnrl7eL5B4i52LgCjzm3bK7qJblypw93f+EvdPIEorDz
         vOjj5Fqjs7hMDses2AVZ6Ic1mEcKtAB6aT7MYMMPNtEs42A7XxT8K7+eLdXOEj/qfrRg
         PYJKdWRqzPtbzzLWeL1Qbasx5nPKi2Qkl9NLGTi/3nMJ8pXrPMIT+if88FBGNTRMIc5B
         //Bjrt9ztNByNAEA+06zghSKHFKu59xg22WKoLV758YTIjIK6hqQC0zDeCztHjzI4OjT
         xo9A==
X-Forwarded-Encrypted: i=1; AJvYcCUXDnSnc7fbQF6tlCvgF5lkR2ZSt+N9k4EPvHijWErPu2KYeej7jYe4IPFVd9hWHnYNADQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzis6WzmJ8dBci8cm5MyadCmNK2BhrVNThqUdcnjT8YXRRpTMgF
	GjzRR6YrcI5GORvElnZDHeMwgjrNpgf8o+kBPJABhlRfk+JUD7JPpGGcYhP+JMNxpEs=
X-Gm-Gg: AZuq6aLnEvzylraemkZyP4q2Ld7BBRfHn/30YgixkNLTYMqQR4ZE63geDGuv2u4zXR0
	lDiD+6GHwGSJfET8q8U2n7KBNd8tbr4nhxAt5Uezc7+dudGrG2mpLQg/T1HK9ZuIiV0/tOg4+RF
	W4QsGgRuhb/IC9QRKOWKNlcJh3zuuLZ7q+evo61o3xGtq3imDLlppcnd+MxaQKhCRPWy9QCpaBm
	Sr2rEpc0732Wf9ZAF2i15pWgZeCUTyqmkexzWVN5a2kB6dT0V4eJv2ROZbZGRbLxExbwhR+p5Ch
	pwpMsy6+SvvEzI8jBgnWNiHtbaARwDuSsSiVlxTGinKHMdZpdbTwAP72tg4dq5mbt3vx/cSIVgJ
	OTBaN5i4ntAJqqWlpDPJiXY1jubL5O/QRG1zfFoXuPJFmtQ7euMUFxkT0T6wXk46I2VPY7V05bj
	JElMbYEQ1s/MDic9XwsABgsh6/
X-Received: by 2002:a05:6000:2011:b0:435:9950:ee1 with SMTP id ffacd0b85a97d-43617e37d52mr8503856f8f.3.1770281641118;
        Thu, 05 Feb 2026 00:54:01 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f25dsm13272553f8f.29.2026.02.05.00.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:54:00 -0800 (PST)
Date: Thu, 5 Feb 2026 09:53:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing
 functions
Message-ID: <aYRapf5K8wFGEO8v@pathway.suse.cz>
References: <20260204132643.1302967-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204132643.1302967-1-arnd@kernel.org>

On Wed 2026-02-04 14:26:23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The printf() format attributes are applied inconsistently for the binary
> printf helpers, which causes warnings for the bpf_trace code using
> them from functions that pass down format strings:
> 
>     kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
>     kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>       377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
>           |         ^~~
> 
> This can be addressed either by annotating all five callers in bpf code,
> or by removing the annotations on the callees that were added by Andy
> Shevchenko last year.
> 
> As Alexei Starovoitov points out, there are no callers in C code that
> would benefit from the __printf attributes, the only users are in BPF
> code or in the do_trace_printk() helper that already checks the arguments.
> 
> Drop all three of these annotations, reverting the earlierl commits that
> added these, in order to get a clean build with -Wsuggest-attribute=format.
> 
> Fixes: 6b2c1e30ad68 ("seq_file: Mark binary printing functions with __printf() attribute")
> Fixes: 7bf819aa992f ("vsnprintf: Mark binary printing functions with __printf() attribute")

From the commit message, it is not obvious why reverting these commits
won't bring back the warnings in the modified functions.

My understanding is that the warnings won't get back thanks to
the commit bd67c1c3c353b6560 ("vsnprintf: Silence false positive
GCC warning for va_format()") as explained by the original cover
letter, see
https://lore.kernel.org/all/20250321144822.324050-1-andriy.shevchenko@linux.intel.com/#t

It would be worth to mentionin this in the commit message.

> Link: https://lore.kernel.org/all/CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> For reference, three additional patches are required before we can drop
> the Makefile.warn line that currently hides these warnings:
> 
> https://lore.kernel.org/lkml/20260203162546.2254900-1-arnd@kernel.org/
> https://lore.kernel.org/lkml/20260203163440.2674340-1-arnd@kernel.org/
> https://lore.kernel.org/lkml/20260203164545.3174910-1-arnd@kernel.org/
> 
> Tested using randconfig builds on arm/arm64/x86
> ---
>  include/linux/seq_file.h | 1 -
>  include/linux/string.h   | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Otherwise, the change looks good to me. Feel free to use,
ideally with the updated commit message:

Acked-by: Petr Mladek <pmladek@suse.com>

I wonder who should take this patch. Should it go via
printk/bpf/tracing or another tree?
Does anyone has any preference, please?

Best Regards,
Petr
