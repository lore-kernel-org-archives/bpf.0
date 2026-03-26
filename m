Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CADA39B963
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774499146; cv=none; b=kIb+MQImfgLBhV9DBeZ1cfme/TpBtBGycOQyaanmAQx5mDUU89gM/Jg6mZV/E87nTsOE5jUAqHkF2wzfT3Q+bi3aUcByzbxs6HfUyPEOUXsnvXcwsujhIr445eBpV3BwPdWau5GMZ9gj+YizUErhC2vzoYgL3lhvQ5YKKlkaQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774499146; c=relaxed/simple;
	bh=0EQ5A1y7IduXMFUSvbTcMnliNRqhvOxBbaothkwbgvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rolZq1rJKs1iQhmtheDG40VQm/tvo5tAgR0i6Af8OY7H/NWD4NwiegtXxcyVTadSsK2amChjb3WJRPP7030z037c0hB8IKtFIR3pU/2HMX5Zl3Owl2bhp/A8T9wPNl4FRZF/gFgWgjImKQkI+qatihf4h7Kit22cyC2QRHokhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ePBy21MR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ePBy21MR"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso5047065e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774499143; x=1775103943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6QOYTpdTlEIxoS/jtRGK2shguUNebLSVH602cSGio8=;
        b=ePBy21MRuP64r2dSByFS5M6jdRb9SLmPm1LS8cP+fNNwj6PmZpI1JdwmWSv9eKQxyl
         37rg3NbDrspUD/1mXWqPyIQFIRAJJcJjIIxObU1Y9CRkJRQpNS0jW5uPpRQgIgMEQB+h
         VajTFoQFHwtMXDqUNNq8+QQ09lQHkGsSdkTCzofklMqDVqN+P9xhmrLFD37GA0UMH2d1
         MvKY7+oiPHj80WNl45n66eUxAzeHbcxJh3b1VGnzZ4pt3qvkqzt/HVNGjX/uD0dK3X7J
         84FjX9Omxa0kZxsEMJgo6npFgyLhFahcwq1hAdj/dRMqpED96irXbb7NMmDGQKAkFd6P
         HUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774499143; x=1775103943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6QOYTpdTlEIxoS/jtRGK2shguUNebLSVH602cSGio8=;
        b=B8k9ltvUH64fRl3xrqwVR19LxQvubj+2zi0JW4e22cERt8bfmX9WtL9rDPXCeqcs/x
         AWqk7VwwbKpC1RqmM/dw50/ZodJDTiIbhppIYD5IzB0FITkFPtj9pQjWyHbrOP+qpMh3
         qv+EjAjqVptj/iPqOI5L3TLu6LM56CpWgxpysUbYopjyc8Ih4lEE45JdMuS9flomk2Yt
         +VJlDQb9I0aOuHsHZgH7aiWQZU+d2WHg5EvQmks61Zocp69g0E8z/0bXe3FQlPM/qetB
         X0lggXXfx7qnlbKY7NJnk4k83UWiVCzZ+CWWZ6fO8ZPqpG2ZfsukyzKq2Q7g6J4L5vK6
         Usdw==
X-Gm-Message-State: AOJu0YyBiWtcuCVto8Kmw0IbQno2ew9R9Yf9iAOfCT2UmaFIwDMhkibU
	gvhhtScyLRFuf8lO74a8efaq78bW/hxl8A4wgRUDW1KlbTIHBjofdKXIntFA1PUJfYw=
X-Gm-Gg: ATEYQzwrEH2r28ZSEA9geFsODrpLP/lIkTlzY3XoACbUQwd7CQrfX8SGa22x6sE67+u
	6XLd4Z8xfopBNuTeCoC/FBY1OmBIOKqCN3z2sAuSGMQ0U2GVxdgbYQLBZUJ8pBliUmDINDKt92S
	q8rBaLtc98ZtF0yUGUh8pm3fG+4N8YaYynytMtQ+Tm/iNtlng7m1udzo5skat7Ikf6SOX0JS0Hv
	1mFBb+Kv/S/24nbxpNhJpF2mOy+n7u2HXVYvn0T/Hh5pXy+9MU22Qsoj/rzDwiuvRJf5NTTK/3o
	QTQRrxUyYmJ+V8Liu9PPFcJwy/HR1huSkDyqMHvLjXdjyxsRpNRhfSCppwVMu1X42gBzz2w2PEf
	P8xI0zqDJLZOulEvu3rDKRh92KPIW3nWdytRvSYQLPaRjzAn4h14lYV9tzlh/czaq40SXEtMUN9
	2uLFdFKBGYHfo5PTaUQnI=
X-Received: by 2002:a05:600c:3d90:b0:485:2a4b:7bc3 with SMTP id 5b1f17b1804b1-48715fc38f3mr86290975e9.4.1774499143380;
        Wed, 25 Mar 2026 21:25:43 -0700 (PDT)
Received: from u94a ([2401:e180:8df5:367c:7729:d191:ce82:e062])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76739345b2sm797239a12.17.2026.03.25.21.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:25:42 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:25:35 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, paul.chaignon@gmail.com, harishankar.vishwanathan@gmail.com
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: implement __reg_deduce_bounds()
 using wrapped intervals
Message-ID: <qfwof7nyxz2amrzbjxolhc7m2nvzzqpnwglafk4tuetdyuiixu@tlbntm5jgswg>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>

On Wed, Mar 18, 2026 at 09:28:57AM -0700, Eduard Zingerman wrote:
> Use wrapped intervals representation [1] to express range-based
> deductions. Such representation allows to express these deductions in
> a more mathematically rigorous way:
> - {32,64}-bit signed -> unsigned, unsigned -> signed deduction infers
>   improved bounds from an intersection of signed and unsigned arcs.
> - 32-bit -> 64-bit and 32-bit -> 64 bit deduction infer improved
>   bounds from projections of 32-bit arcs onto 64-bit space and
>   vice-versa.
> 
> Reformulating 32-bit -> 64-bit deduction in such terms allowed to find
> two cases currently not handled by deduce_bounds_64_from_32().
> See patch #3 for details.
> 
> This RFC argues that wrapped interval based implementation for
> __reg_deduce_bounds() is easier to understand and maintain.
> An alternative to this RFC would be to update
> deduce_bounds_64_from_32() in a same way patch #3 modifies
> reg_bounds.c selftest, in order to handle newly identified cases.

I think introducing wrapper interval for purpose of improving &
simplification of __reg_deduce_bounds() alone might not be enough. That
said, I still want to push wrapper interval integration forward, but
that will be addressed in a separate follow-up email.

If I understand it right, the newly identified case in patch #4 is not
something we encounter from compiler-generated BPF program (yet), and
thus not something that is needed currently, either this or the
alternative to update deduce_bounds_64_from_32() in a same way patch #3.

On the other hand, I do like the much cleaner code as well as better
modularity for reuse, and being more mistake-proof.

For a more objective metric, I gauged at the difference in terms of
cognitive complexity (which penalize nested conditional more compared to
cyclomatic complexity) through clang-tidy, and do find supporting
evidence:

  Before this patchset, congitive complexity is 88

    'deduce_bounds_32_from_64' has cognitive complexity of 42
    'deduce_bounds_32_from_32' has cognitive complexity of 20
    'deduce_bounds_64_from_64' has cognitive complexity of 20
    'deduce_bounds_64_from_32' has cognitive complexity of 6

  After this patchset, cognitive complexity is 49

    'cnum32_from_cnum64' has cognitive complexity of 2
    'cnum64_cnum32_intersect' has cognitive complexity of 13
    'cnumT_umin' has cognitive complexity of 1
    'cnumT_srange_overflow' has cognitive complexity of 1
    'cnumT_intersect' has cognitive complexity of 17
    'cnum_update_reg32_bounds' has cognitive complexity of 4
    'cnum_update_reg64_bounds' has cognitive complexity of 4
    'deduce_bounds_32_from_64' has cognitive complexity of 1
    'deduce_bounds_32_from_32' has cognitive complexity of 1
    'deduce_bounds_64_from_64' has cognitive complexity of 1
    'deduce_bounds_64_from_32' has cognitive complexity of 4

So there is indeed a net reduction of 41 (~46%) in terms of complexity
score. Supporting the easier to maintain claim, too.

That said, we do pay some price as cnum is more mind bending and not as
straightforward to grasp. Cognitive complexity cannot factor in the
background knowledge required.

I do think there are more reason to push cnum/wrapped interval forward
beyond using it __reg_deduce_bounds though. Will try to write a
follow-up to this email.

> [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
> 
> ---
> Eduard Zingerman (4):
>       bpf: representation and basic operations on circular numbers
>       bpf: cnum for 32->32, 64->64, 64->32 deductions in reg_bounds_sync
>       bpf: cnum 32->64 deductions in reg_bounds_sync
>       selftests/bpf: new cases handled by 32->64 range refinements
...
