Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F98279907
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035582; cv=none; b=jdnZxzWBU3BobWou3QRKB6h5ckq2ftVKb3HzzOOh3o9g90KPf7/MwUm8pb8aDmLzX/u56b7bnkVXVusXP0Rxzl0d1sVBY+Q1qTMwtyJgoGBpCf24wytrx5OG0Jp9gLwzNFOZtE67aDKAkxcqbXtZtmrX4PRLt+chjERi3Rvz7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035582; c=relaxed/simple;
	bh=kSk/KKj93iW1T2AkqQAIVNTC/O/93MGIBNplXPrm+P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvvsdEDCF2kN7ZOx9Gb+3uOFrJIJOdZ+/5Y4p/Wb0ysytCijW93E6kcIp5rOGTOpwbcP0V9torJYMUD80zSSX986v4SEWPRkmNhhp05Bw8lVRaKubpMzxn+OSdH3ceCkurKRd7vSg6xdr98GNTjAUBVuODDvQZDLxWdrXMow6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O3MH124l; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O3MH124l"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so16993045e9.2
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 22:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773035580; x=1773640380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c60oYkZrRir2frvYrI6ktYo9ZohOXqojqm7Gq5e+DKU=;
        b=O3MH124luVHNvqw+/6378QXawwluro5DJ7aZ3Z9PS4QtcPhLNjbApr6x7TErY4r+JU
         cqMIpZhS+lsU8NJQuk8rPXeiNtnXHO5KZmDJKEC94m4yfSJxSYyXTaUFb4InfRAnlsxg
         cl6qqVyGXNySFIwhwmJHINxFnlIKJ/4tmgL96gF5bVv21Om2OiTwn6ofJcNlWnV6uGVd
         T9Oi82LtoRzkF5jH20fRGepf/YUWqdZ2qsWycPu9xwvyEi7j2TUtt1MY0iDShiwCGAB1
         PJkKqCVDUd/+3z6cQHlto5hT9Pp3jEPU73zJezfanVr23WC87T0C6wYBlx/qkZfU6wPq
         ifYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773035580; x=1773640380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c60oYkZrRir2frvYrI6ktYo9ZohOXqojqm7Gq5e+DKU=;
        b=OrbYUidk5XP2dSwqBhh/4pBEpMuJMOVs6JORW0mMxfE3UdIUcPQ7BfO+OXW5yLlzmc
         GcigeWn5oqEBKWkPyw2sPzH4kzdK3b1V23WaGxqIEYjIX8yYw9gjJHYAqFka0lAci7gB
         7U5lx723xVig0jHUjCUvR0mhrrWfLhEKkfg8bG3A0HP1s7nM01C0teYPa6TOZXGbIQXM
         Gw3BOJgxyAev7GEVPW/MWA+ygdsvPcmRP2RdaWKHFu8CgWfrCJQBX6dVaW3SJPv+Qves
         z6bwOz8i66+g0+3qlx0lCgxVhVVkKXfKVz9BR3Rawofe7pcN6eLw5uvzWwGho/3RBhdB
         BMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaMOMe+QGGlMWaI5V2/Pl0bfTe8Je0Ohx+azZWHrReAbH4I+Vl1cF3vu0CSQZylpyrxxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUt52rl5kbg/VfmNx3xGlosaS4sF84bgsN1AjJqHtZ0t4dofQ
	xYT95B+UiTpZtQ5ml7ik6OpOW5i/CNqNq0H0sBStGUcDpt6L+FdBgSXTiwvhR22DGdA=
X-Gm-Gg: ATEYQzzpJ/05VCCIy7ojJoByNqfo1GIlH+PWrLauDNrFHvDKhfbdFvortS0g4bb6nAJ
	Xm8fcFexcJZjs09piej1vck57f5Yt55PEjocBCxej7LstMRl1WEhyt0flyf/1c93CqyGZmGN2Fz
	BbF6cMOEu9WcNHyKVrKMoWV+xus3x1KIrY9TSvWCfUfE5NwnbeMpGYmeQNH9OE4daRmS1t+6+N4
	BOyGAU28ANMfszAUcSPgSi9n8TRvp5lPHbNOqsQwjvn6A0EeCD5UOTJofL94VD1DcNR8nBgYRFS
	ZL5fO1gcJm4EiW0MwnOTztTS9tIWCCbOa+Hx0iSEOijjlNCT2H/m9BvtzqrR5dG/61jaD2OtQoE
	pz7Kb5BzMA8cvVdisB7x8F39+Zozv5Psd8f1rPPnH7IxdaByfMYTNNmBodSp0H5Usx4NiEWrKeG
	mTv9gsB61B6RkQGDDOJg==
X-Received: by 2002:a05:600c:a12:b0:482:eec4:758 with SMTP id 5b1f17b1804b1-48526967a7emr161519575e9.26.1773035579640;
        Sun, 08 Mar 2026 22:52:59 -0700 (PDT)
Received: from u94a ([2401:e180:8d01:1fb3:e42c:360:78fd:1fec])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82b78esm7889671eec.12.2026.03.08.22.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:52:58 -0700 (PDT)
Date: Mon, 9 Mar 2026 13:52:47 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, 
	Andrea Righi <arighi@nvidia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <6fze6gmkwsw7ph7moafjujufjpoyr5tyfupzcbdrk6bpqzoisa@dqohjosm7kas>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
 <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>
 <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>
 <ff92fa059a5f5427fec24be6758afa033ee43af2.camel@gmail.com>
 <aamB3iv2njtHWgPB@Tunnel>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aamB3iv2njtHWgPB@Tunnel>

Cc Andrea and Emil from the other thread:

  https://lore.kernel.org/all/20260220190736.230329-1-arighi@nvidia.com/t/#u

On Thu, Mar 05, 2026 at 02:15:10PM +0100, Paul Chaignon wrote:
> On Thu, Mar 05, 2026 at 03:10:00AM -0800, Eduard Zingerman wrote:
> > On Thu, 2026-03-05 at 14:54 +0800, Shung-Hsi Yu wrote:
> > > On Wed, Mar 04, 2026 at 04:48:43PM -0800, Ihor Solodrai wrote:
> > > > On 3/3/26 11:27 AM, Paul Chaignon wrote:
[...]
> > I'll probably continue playing with cnums at leisure pace.
> > 
> > [a] https://github.com/eddyz87/bpf/tree/cnum-sync-bounds
> > [b] https://github.com/eddyz87/bpf/tree/32-bit-range-overflow
> 
> IIUC, your current patch doesn't maintain a cnum domain alongside the
> existing abstract domain, but instead builds it only when needed, in
> is_scalar_branch_taken. Would your long-term goal still be to replace
> the existing four ranges with two cnum domains?

Borrowing upon the above, would like to about ask about the work on
"avoiding inconsistent state with is_scalar_branch_taken vs
reg_set_min_max difference". Is the current plan to address that once we
have the cnum domains?
