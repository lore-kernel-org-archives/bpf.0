Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDE4340A7D
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139198; cv=none; b=iYVDyUN/FzqFkMQcsRLVe2OC93YMdcGvSuFNyV5TvcmcpS3JFNnSrj3v8MLxPL4GAwJuA50jIDXKq4H9dyKd1CgSgt1uTbRA4QXAjsThqshHR58m2VKe6r0Zw6/I+/JCH/wVu9msQscF/6/Yn15ASFcS2kv/zHSXmIL0WyiaaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139198; c=relaxed/simple;
	bh=UynYnHhtqrNA4eF5yZjesCpgsIKgtpf+dvKOxyDLvoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txaXcMQxnzAKHLZtVtj+3yWYYkVizea9Vn0MlgjD3zYrTcDybVtKGAd9g0GMtdUPVF0f/ACTMkX2IqOfrjoIvOgBbZwwugMvEnze7o0BZh9w/b2ujg5xWG1OsMOsGIYcOaJFjsw173cjLNwW3OqF9406YNHJ6x5+EBtlDsEl9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bQptTkIk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bQptTkIk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so67664765e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 20:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776139181; x=1776743981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9IBRabjOdZ1ovlAsFCvtBMhJQ8fnNOQwDdqpwrXeCY=;
        b=bQptTkIkwTgJ3Gg9ugJcdfUVIYFHTJQC6fnxSakfJpRyjxv9b2yVXYkrY3NBUp039t
         jNx2pqJJvlIyOt0dvu6lt5zUI9KCGimmpgWNkBCwuSSg9UzqIihzoCn+14t7QeaBfuEI
         HXGSkmrIqqdk0nUWqfW+Ik1XB3GwUEPI12K6Cls4s+HuR+F1m0+LJjnPI8xlC6lq9ioC
         r2Fjmk0hpv7MKR82vWNrwDri72jxLmxL0mXTyb1qEF6Ba87MjGAqRIiVoQYlckLRcNcN
         /Dy6jV6Ab9CNHcBEjtwDOWard4e6jYZTA0Nj+zEx8+Mqj21kzLooDaY4R6096SThgdmN
         KIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776139181; x=1776743981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9IBRabjOdZ1ovlAsFCvtBMhJQ8fnNOQwDdqpwrXeCY=;
        b=YnsawBrNYwE8m52M/HHn/AlR+PU0woW2ir6CfNk0MLdefTmnjGgc1rmHmNrT3krY1F
         g0fs//+w5cgk90VXwqqK+WQQ69FULbYKXUkXCtT+WkXZf/fyr2sL71pEj4578vGg6b0s
         RswtEtvuNyVrlUemuTYbZ0mdoHa4ojn5FN+B/0URS9iIlNQd8Xa6aXiyXBvAVQFF8tzK
         yleY5DE1PthRWx/FoStMIoLl06vawa8aUAKk2y/lz8QlTPqHP9tDlyBP1cu0cIqzGyux
         vg6rMEXav1902/OM9I6WqgIlIla6Cju8aVnOeZ5LyZ1D4vKVJ6k+poxOh/jgeUTN9ioL
         l0Lw==
X-Gm-Message-State: AOJu0YxsHnZOA5nt3mPRVcRzmwz5DQlqkUotGecPDmuCslimPfP5DMrX
	nGz7aSTjepmBpjqsrV35usm4VhihQeIo87yCUSPs84lsrrzVeQTJsipPuu2zgDIEF+Q=
X-Gm-Gg: AeBDiesXUDaRRtw4+RnMO0blaYw84I/hiF8OZA3vvgRt6si1WsahhGg1fsfTl2OArAq
	mwDtU3NMgjousillDXp1xu+97KNy6+PM4EDWTqDbPjs5lK07Hho0Fy7rXvfQ8SR3j2mVtcVGI1+
	yP8lQOUEgYoxc/NmOF45QmZVskQCCGudCocIGMQR08+OZdMwtf527IUZ3Lu0xa2uffY10VBpq5h
	9h6yYQ943/+s8NhLEmNU4IPsTG+NlwE+I9PAUfnEypBwNc37Kbb1fDn4X0NSWo350a/bhyNYLcc
	sUH1vVEWw1o03CQ+sSpBnIdjFrgvda27IBu9DqAFaVxoYpfot95xy4VWZKZ1S/T2ZVE2LBGQvrQ
	v5KDxAtxtSDjsU6CELJldoWWFnCMjIRdHHAax74lNXjFawyw2jtjdLPDP8YW7CnuqKemiXT3uHG
	0t8zjUh0wh1k+hppEkc9ZNjgKeOUG2K9AgSGEAp7C/nsg=
X-Received: by 2002:a05:600c:a404:b0:488:bfc3:ef3 with SMTP id 5b1f17b1804b1-488d6671271mr197493275e9.0.1776139181045;
        Mon, 13 Apr 2026 20:59:41 -0700 (PDT)
Received: from u94a (27-53-106-10.adsl.fetnet.net. [27.53.106.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459faa7sm19615691c88.2.2026.04.13.20.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 20:59:39 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:59:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, paul.chaignon@gmail.com, harishankar.vishwanathan@gmail.com, 
	Helen Koike <koike@igalia.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: implement __reg_deduce_bounds()
 using wrapped intervals
Message-ID: <gvmhprcx6an4iumk7cno35azyseqpcbu634c6dvl4twshjtcse@4jdndkvxalsc>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
 <qfwof7nyxz2amrzbjxolhc7m2nvzzqpnwglafk4tuetdyuiixu@tlbntm5jgswg>
 <69e94f86bf1d620b92b4128c0205ec0e29327d8e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e94f86bf1d620b92b4128c0205ec0e29327d8e.camel@gmail.com>

On Thu, Mar 26, 2026 at 10:50:31AM -0700, Eduard Zingerman wrote:
> On Thu, 2026-03-26 at 12:25 +0800, Shung-Hsi Yu wrote:
> > On Wed, Mar 18, 2026 at 09:28:57AM -0700, Eduard Zingerman wrote:
> > > Use wrapped intervals representation [1] to express range-based
> > > deductions. Such representation allows to express these deductions in
> > > a more mathematically rigorous way:
> > > - {32,64}-bit signed -> unsigned, unsigned -> signed deduction infers
> > >   improved bounds from an intersection of signed and unsigned arcs.
> > > - 32-bit -> 64-bit and 32-bit -> 64 bit deduction infer improved
> > >   bounds from projections of 32-bit arcs onto 64-bit space and
> > >   vice-versa.
> > > 
> > > Reformulating 32-bit -> 64-bit deduction in such terms allowed to find
> > > two cases currently not handled by deduce_bounds_64_from_32().
> > > See patch #3 for details.
> > > 
> > > This RFC argues that wrapped interval based implementation for
> > > __reg_deduce_bounds() is easier to understand and maintain.
> > > An alternative to this RFC would be to update
> > > deduce_bounds_64_from_32() in a same way patch #3 modifies
> > > reg_bounds.c selftest, in order to handle newly identified cases.
> > 
> > I think introducing wrapper interval for purpose of improving &
> > simplification of __reg_deduce_bounds() alone might not be enough. That
> > said, I still want to push wrapper interval integration forward, but
> > that will be addressed in a separate follow-up email.
> > 
...
> > That said, we do pay some price as cnum is more mind bending and not as
> > straightforward to grasp. Cognitive complexity cannot factor in the
> > background knowledge required.
> > 
> > I do think there are more reason to push cnum/wrapped interval forward
> > beyond using it __reg_deduce_bounds though. Will try to write a
> > follow-up to this email.

Trying to pursue this line of thought further.

Ideally we just have cnum in 'struct bpf_reg_state', and get rid of
signed & unsigned tracking, and __reg_deduce_bounds would be the perfect
place to start. Though as you have pointed out in [1], it will be less
precise for cases where signed & unsigned's overlap in two ranges.

That said, the paper also states that cnum and reduced product of signed
and unsigned domains are incomparable, which I take as cnum is not
strictly less precise. And given the reg_bounds.c test you ran into is
added specifically for ldsx[2], perhaps some special case would be
enough.

But I suppose we'll just have to get to the full implementation and see
whether Cilium, scx, and Meta's BPF programs pass to now for sure.

If that fails we still have the much less elegant way of dealing with
cases of split range with 
 a. forking verifier state (like "Recognize special arithmetic shift in
    the verifier")
 b. use two cnum instead of one

Last of all we could keep sign and unsigned ranges, but convert them
into cnum for all operations, then converting them back as this patchset
does, spread to all operations beyond __reg_deduce_bounds; we should
still get some simplification, just not sure if I am trying too hard at
this point.

> Hi Shung-Hsi,
> 
> Thank you for taking a look.  I have a work-in-progress branch [1]
> which implements union and multiplication operators for wrapped intervals domain.
> I'll plug it into the verifier and share the results in this thread.

Thanks! Looking forward to the result.

Shung-Hsi

1: https://lore.kernel.org/bpf/bff0a144925370ba4c34be610f910a8ca0f91efb.camel@gmail.com/
2: https://lore.kernel.org/all/20240723162940.2732171-1-yonghong.song@linux.dev/

> Thanks,
> Eduard
> 
> [1] https://github.com/eddyz87/cnum-verif/tree/arithm-ops
