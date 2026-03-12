Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D485F3B960D
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307794; cv=none; b=p+KCYyHpvG8tAOhQsQdyXQH17G9e4BYwrzgUGG/TYFlnQldMLWSkMnvOSQsvWKTmVXf0Iw2dxNkH+WEsXas6vwYWRunwyC+dV2y952J5iutYwdz5B3nU1qjMkbJbuMVoF3cDda+THAMzxWyuk54II++zR805XAUGrQJDyzo0jpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307794; c=relaxed/simple;
	bh=q6MJzu5+YHTxdljkNnf4jYTKza5wayB6oEnOn3+6DDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ40tkVep1BYwB2o5zip6tDI2TkZhSS4bMWRJZdezwQ6TKQx9hG9o5cWSSJNrCuHFl6v+VGuxxVOQ0zSG0ujPxCjeL+QQw/AHC/Sg1KPcKMTAx9sriPjPtoYCdf4MB9Zs1EAS5TP7bsvzkJe+yG8mRusQ8D6uBWpmvz37PyDdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1sqqjZ8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1sqqjZ8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso9140565e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 02:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773307791; x=1773912591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=48ePxsccF8Uxw25h+Bp/9IWess/Z+mmqJesR4Y9xVUk=;
        b=C1sqqjZ8I76GesOi6bSahMnXcuAUhRFgEFKzx1VkmyNoqXzE/KH+JPefNJsqUO/xyn
         dvcUgdbxxsw2SzfTz84M+5OW7pSS7dqhkz6FF/S6/NMAbkWT7TMNRLHhnxEQ4A7YmMMW
         NDZFOo2eFNK8YXisbY2zeGvvTAVr5yDB+vm3BZf+8Y+LZkrf3Qo4wovAdy2c/HjD7MLh
         cMPVWTocIPJ4ETCxoXWpP2mNtH1+pkGI5YPsgVSk8l780NW928gXaUyExR27a9x/Sk8r
         mYXudArbtw2vjTESMa6boVd1IsOe/L6QNdv5hxXWDZD6ohmfT/zxiIfA46ekejMTVbZI
         NDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773307791; x=1773912591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48ePxsccF8Uxw25h+Bp/9IWess/Z+mmqJesR4Y9xVUk=;
        b=n+WGXOcUDzBJMHUvlqe1EVsOetAoq2IQBy+yNW9j7PHBQ9EuhYCOizksVfMvIVEb6/
         avmkX0GPfWsF2vWYrZDWeKsPmNhum5AjW3qh/Tolfux6KONaM3GfdKFZchnwk3BHzP8x
         bSuwoVpTzAwq1Y0OyKTp54DJE/7vZx+frYoYlQ0BK72ehuLSuyIu4xXDSZZMtlZs6UsH
         sS+gPia0o3r1yJRMiQK/G9xIY8N4PebGNRTfgKQiuX2xpgq3LG8HaaIuLpGmHYXV5IV0
         Eq+8j0gUlgZ13Va53tUIsv2F1iKLfBenNESrldm7Eo7J2GjkaIFsR9Z1OoRaUBba8/15
         3pAA==
X-Forwarded-Encrypted: i=1; AJvYcCURslRNjenJPXO5pwWsWjdnUfhaUtU9BBcTGkixki+yfu7bWFHJAJEBDzwONRLZJBIMus4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIksg9Sr66PqBn89kUOcpp9pgadgxMJEbmjvOMO3dB0vK8JAT9
	kjVmwjpHv0u03yGXnLNc3nIwgC/WXJ8TRO57fuWFzrj9uljdlh9pGQbW
X-Gm-Gg: ATEYQzwmn0oxVNDZYd/81d6a0lWDSmNroAjkTivtczd1T1DJ5tpN+TyM6mAURjzrquk
	y9bukr/R7WTaTVwJdfjHcz2BxtlNXY3cmuBkKgF3RsyRh7X6fBnjj2wWXe4Npm5mFZxM+HMmfuu
	mob6SjEhLloTC46sdhq+CdD4giqSWg0c7Q1txUtTPNFeOp4S6Mqw4JRKeq+faMChqXgvOHh5Ehc
	pIQ2HKhndgwQOK1NknxCy550nqZeL8OGoYCULlCkAFHDsj6XWPZhOJujGrdWa3IBX1G9F+RNtca
	wxcYa2o4uxUTW+AmPgMPLEqPgTJhs6GYVe3N/Sp0E7k3FoOeDQ1AW3cE2rcSw5KRL73swbUqkPM
	DCc4f9Bgw3w5UZbUzEGrJT99/lcSqU5ywlIYx0zG9ueo6YtH9a5yNw95lWVZIm+8rgGQuXAaggU
	sTqV/HYTxwVZbWj892RxwvMo2kaI9ZMEcy/HEKvckxkfOdET2oXh3URDvksO3+rDfCdFmaeNv2P
	Yd8ii6fA7AI6Xe9NRPgWOeHAQqGPspJW67JQ05tkueBZ5raybJyyK3LLBB8WF4NQAX5xDJ9m+JX
	0JgOUhPe1ZcVe9d9RBe+0g==
X-Received: by 2002:a05:600c:6090:b0:485:4278:24fb with SMTP id 5b1f17b1804b1-4854b13c02emr94171935e9.32.1773307790948;
        Thu, 12 Mar 2026 02:29:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00e621310b96d0fd4d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:e621:310b:96d0:fd4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2fd030sm70819185e9.2.2026.03.12.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 02:29:50 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:29:47 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Check alignment flag if
 expected result is REJECT
Message-ID: <abKHi9Pr5iUbIQZI@mail.gmail.com>
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-2-yangtiezhu@loongson.cn>
 <DH02R7I6EAUH.16649BMB7V1N8@etsalapatis.com>
 <fe04d981-fc83-0ba6-4dee-8fc0c953e09f@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe04d981-fc83-0ba6-4dee-8fc0c953e09f@loongson.cn>

On Thu, Mar 12, 2026 at 02:59:57PM +0800, Tiezhu Yang wrote:
> Hi Emil and Paul,

Hi Tiezhu,

> 
> On 2026/3/11 下午11:56, Emil Tsalapatis wrote:
> > On Tue Mar 10, 2026 at 2:45 AM EDT, Tiezhu Yang wrote:
> > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set unconditionally for the
> > > most archs such as x86_64, aarch64, ppc64el and s390x, but this config
> > > may be not set by users for riscv64 and loongarch64.
> > > 
> > > If CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set, the BPF verifier
> > > detects if a program has unaligned access and then rejects them. So it
> > > should also check the flag F_NEEDS_EFFICIENT_UNALIGNED_ACCESS if the
> > > expected result is REJECT and set alignment_prevented_execution as 1,
> > > then the message "(NOTE: not executed due to unknown alignment)" can
> > > be printed for some testcases of test_verifier to reflect the reality.
> > > 
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > >   tools/testing/selftests/bpf/test_verifier.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> > > index a8ae03c57bba..a1ae2f044e96 100644
> > > --- a/tools/testing/selftests/bpf/test_verifier.c
> > > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > > @@ -1640,6 +1640,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
> > >   			printf("FAIL\nUnexpected success to load!\n");
> > >   			goto fail_log;
> > >   		}
> > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > +		if (fd_prog < 0 &&
> > > +		    (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS))
> > > +			alignment_prevented_execution = 1;
> > > +#endif
> > 
> > This doesn't look like it's breaking anything, but it will cause all
> > tests with F_NEEDS_EFFICIENT_UNALIGNED ACCESS to be reported as failing
> > due to unaligned accesses even if they actually failed due to expected
> > errors at load time.
> > 
> > Which test programs is this fix targeted towards? Can't we just skip
> > those tests for riscv/loongarch instead of adding this workaround?
> 
> Thanks for your reviews.
> 
> It does not fix any failed testcases, the testcases passed without
> and with this patch. It only affects the output for some testcases
> such as test_verifier 14, 153, 190, 191, 193, 197, 200, 201, 202,
> 204, 255, 256, 295, 297, 298, 300, 301, 302, 307, 308, 331, 341,
> 342, 475, 477, 500, 512, 514, 515, 517, 520, 522, 523, 525.
> 
> For example, for the test_verifier 14,
> verifier/atomic_cmpxchg.c:215
> "Dest pointer in r0 - succeed, check 5",
> if remove ".flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,",

I think I'm missing something. Why would you remove this flag?

Are you trying to illustrate that this is a program that could be
rejected because of misaligned accesses? I agree, but here the flag is
set and this program is therefore rejected because of an invalid memory
access; the misalgined access check is skipped in the verifier.

> here is the test result if HAVE_EFFICIENT_UNALIGNED_ACCESS is not set:
> 
> $ sudo ./test_verifier 14
> #14/u Dest pointer in r0 - succeed, check 5 OK
> #14/p Dest pointer in r0 - succeed, check 5 FAIL
> Unexpected verifier log!
> EXP: R0 invalid mem access
> RES:
> FAIL
> Unexpected error message!
> 	EXP: R0 invalid mem access
> 	RES: misaligned access off (0x0; 0xffffffff)+-8 size 4
> verification time 27 usec
> stack depth 8
> processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> 
> misaligned access off (0x0; 0xffffffff)+-8 size 4
> verification time 27 usec
> stack depth 8
> processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> Summary: 1 PASSED, 0 SKIPPED, 1 FAILED
> 
> It seems that this is because the program has unaligned accesses,
> but the kernel sets CONFIG_ARCH_STRICT_ALIGN by default to enable
> -mstrict-align to prevent unaligned accesses.
> 
> So I think add "(NOTE: not executed due to unknown alignment)" to the
> output is reasonable. Something I missed?
> 
> Without this patch:
> 
>   sudo ./test_verifier > log.before
> 
> With this patch:
> 
>   sudo ./test_verifier > log.after
> 
> Here is the diff:
> 
> $ diff -uNr log.before log.after
> --- log.before	2026-03-12 14:19:04.119957887 +0800
> +++ log.after	2026-03-12 14:23:03.468251328 +0800
> @@ -26,7 +26,7 @@
>  #12/p Dest pointer in r0 - succeed, check 3 OK
>  #13/u Dest pointer in r0 - succeed, check 4 OK
>  #13/p Dest pointer in r0 - succeed, check 4 OK
> -#14/p Dest pointer in r0 - succeed, check 5 OK
> +#14/p Dest pointer in r0 - succeed, check 5 OK (NOTE: not executed due to
> unknown alignment)

As stated in my previous answer, this note would be incorrect: the
program was executed in test case #14 because it was rejected, not
because of unknown alignment.

[...]

