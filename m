Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FA2C187
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252881; cv=none; b=VXHazeEPxyJ0/RSzZZSukPkvbLFSjm5lNUGqBtTx83VBEX6ZxcngAFb9sRgBgYf+L+nNRNmEAo+sEk58CprjQwwuNcZ9Oqyg7D5wbfLiXLlkW444L4blQEK7CrefP9zXdE4Aq4lrgTmImmfqllNRypa4Z4cqqh5rKQGJSw5+cHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252881; c=relaxed/simple;
	bh=wI7bnwtIDMYsryRsIL98GKclIOEeDqav3Ec/RIvvEQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/FAEdrH/dbp7Or0bM9CGUoOfU197cX641CKgZGJpeGN3tkOA03wxLDHeY9UN6hOugvE16fvkpIq2hN8IW1bXVaFOs4wDhb3n2csM3jWgKBWKPl8rOE9KdS3R7n4f75A3x1mOcG7Ao3/AMfrS7330kTIJx+eoYoFMfDHMMhvYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BHUROZSg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BHUROZSg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48704db565eso14938905e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774252878; x=1774857678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWFD+VJv0fRFmKKydPECC0WFBkvMNojk8YeNTwqcOjI=;
        b=BHUROZSgOznXFLmX4XifvNGS+XeOMftgyDYf1ekUG6dl5Ilv/U8LlJednyhJgG9MR4
         jEKCSkCQRbzAnb80pmBRCE6lu3mcfiIT5PvsVW+6a55wkThv0Wjvmm+f1y+da6VORAN5
         Qi7ppZU+0iD/Bbbp6yy9Zlt6DbwuxKzEqkL9lAQy9VMNtpzAUXsZxyfqKp/EIMQXXHl/
         YW3YbkN/XaIojqK5gWnwDzXBPLuw792SJhFLjTXYTK459wQpccvvNjFLfwgBKHx2FAg7
         VNOc97GlFeXGinlMC+RvR4DMKu8v3DLwOq010E+z9XsK/xVJ2st2jXKZoWofHnHjULKd
         pNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774252878; x=1774857678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWFD+VJv0fRFmKKydPECC0WFBkvMNojk8YeNTwqcOjI=;
        b=J8vh6SEooCbuhpGcouvEjj5Zi5Pv/cpH/0t3pMaKsx2iz03vwPJIVFkLKcZHl69TS8
         0t8eGFgVfhI6oYvrfzy56paPhdUPwxkW/BU9LRgUi2tEcGZ033CvP4NXON3JQQnb9j9j
         +YIGyj9TZmi55pV+XUeagS3DaTqF6OM8TW1WM+EcaQOqmaOp24xenWi5EnPvRDrBUO6d
         iv582QjVsuJ514kAdjFblkCTTmWnK2WRrhZm32RgNdheU16+LV9xlAK9CIIwS5H21N7T
         fi90TFze0qFNEhBtUE8YefS/YgeNaomaxd7mzkNRr9ceG4LfiE9vx4+lQubSYVoh38CD
         8Reg==
X-Gm-Message-State: AOJu0YyK2KPKo8+8l5RFu1XFP+IkgLlWNelnE3Opvp1X7SLeHt8FyHV0
	DhWsOCw21nqiHKjPFu2L1NtGP7/op0boBUskQBF6C4BahFgE0vWfgSc52H9ZCKROxeg=
X-Gm-Gg: ATEYQzyGNoTpIPK+yweYg8mWq7FCUVI1Yh/Q2sEqxC9E0HLfWv78w0Nibsa/BL/spNE
	bcbXZV2s5Ten1Dop9Hta5mhD+IIJF9feqx7r3CTaNQMUr0QvVOqzCXKeNcga3hBZI9MCOXByeKw
	MY6/7S8r4vHVyM3m4mZJo6KpbLjTnDlzUDEHCUtPuZ5PTW/aiiq8sKtfjJ2/bdXsL9CF4ws+ryB
	AY4YkfP2mllwSe+8+Ecl3U3MRxJHSy5KhKgKAFGQxv7kbO7DcMYsiJu8Ogv5VKhqJAUOfYSTFJc
	h25ZjXFfpWUn/yZpvlYViD/lUByrUrWphKWfm7MLHAJDoUWuCI3YqisGGivFx2SqMIu059ysEFH
	597SWV+b+zzmlaeQ+JgkHPwupr/vtSllMgfuhqFPXoD9qnFvQOnE/UkXY0a9/hmhigxn+rwmVAx
	E+FqSfi7d7EQ0j0Nu9vw==
X-Received: by 2002:a05:600c:181b:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-486ff9264f0mr86943545e9.6.1774252877995;
        Mon, 23 Mar 2026 01:01:17 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:239:b1f1:37bf:4abb:cbeb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm98425875ad.26.2026.03.23.01.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:01:16 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:01:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: Refactor reg_bounds_sanity_check
Message-ID: <c42gw5k2iilesbmijguyngep7ti5dvaich6awb4bppiqax2jxq@5jrnqxqnb7dp>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <d328e04c67b520973e295d0f1c2fd88715a6390e.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d328e04c67b520973e295d0f1c2fd88715a6390e.1774025082.git.paul.chaignon@gmail.com>

On Fri, Mar 20, 2026 at 05:47:45PM +0100, Paul Chaignon wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> 
> This commit refactors reg_bounds_sanity_check to factor out the logic
> that performs the sanity check from the logic that does the reporting.
> 
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

> ---
>  kernel/bpf/verifier.c | 50 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 15 deletions(-)
...
> +static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state *reg)
> +{
>  	if (tnum_is_const(reg->var_off)) {
>  		u64 uval = reg->var_off.value;
>  		s64 sval = (s64)uval;
>  
>  		if (reg->umin_value != uval || reg->umax_value != uval ||
>  		    reg->smin_value != sval || reg->smax_value != sval) {
> -			msg = "const tnum out of sync with range bounds";
> -			goto out;
> +			return true;

Off topic: despite I acked the addition of these check, I can no longer
recall the exact rational. This now just seems to me to report when the
bounds have not converge (in reg_bounds_sync?).

Anyway, good to keep it as-is for now.

...
