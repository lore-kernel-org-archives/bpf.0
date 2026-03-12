Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6CC1B4F1F
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297958; cv=none; b=dPs5LZJ1Zuxzz1Xqxx2v26oFjsCDpWoSCEHQtCh9VLHg+yHTTDoQlNVCkiUXmc6+PRQfdNrnmJsXxhdOe3lZD1Ub++4yTRxOmNDdayc+izv6dl5b6sXMtJYN/dGw38OeT85CfD39kFKo+0Bw0aqVyWVFXxlI1TaJFfiIOoma2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297958; c=relaxed/simple;
	bh=ECFyOrlzRXIolP3InoCIBE+r6ZPmytUDBEW3lZKOZoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG2KS0Lbtc+nasGXjyBGVWwwwI6bqIYdiDQKpsb39tS7ntZ07bP4X2Im07RJImGEBSOA+W6HIKlaJJA1X0LK3HxJGllBYzEDzTvJImKjZPHTmDqlq15cCgdmpm2b77VOc9HFCR6dMx75wFqQ5cW9BqWj4cSrVX0PBA7Dl4nqqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dLzNcMAM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dLzNcMAM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853aec185aso4958625e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773297955; x=1773902755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7QFQf2IHb8f0TdCkVhZUSu8p15WgosKW0MpH4S4ifI=;
        b=dLzNcMAM3Q24MxREARGIOO01owfrZtHtuwYJhUki+ATl423UyppIB13uYL7lXtFGzP
         UPXzmEtyRu8mXgcQYAXqmZS8m3IeKwMsX4MofS2moPTyjYHTQtlD+UamBnM5QouFA3ID
         pCFIHelU512tmbrIbpB+wklF+ho6SttIJ/plU60BF8DtB0lDVZ+wlZjcmV6Ze/2j7frC
         MRkKTw7Uqi8wVxNp3zAkiKgmN8vTyx/J8Znr3H63gAT2m8iESHVbBCmeZLz0zcDPjWop
         20fF0AByUpPEWQN8L6XMst3Bwv7xhp/rNiZVwXkPh5/iR1mUeHNEPr6EFwIefsxtUoTV
         EhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773297955; x=1773902755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7QFQf2IHb8f0TdCkVhZUSu8p15WgosKW0MpH4S4ifI=;
        b=HboHbhmQe4E7okt9pX8DbAWJ0+LRMBQzNxFA4mUFpiF0jYO50LgbTClK12TWEtFe0G
         w7DracyP3mv06KvLP/AmYs4yprjlUMaPsNIM7x0qy0/kMxSVYYJ0M/MbfNBrm8Rj68z5
         A/deq3jYdGdjJ/yFjphJdARW5A+pKdXMYo/y5QJmnj+4xT8IYraxR+5rOF+G815MnmXk
         IJSrIVb20O0gG8Neu6YVSSSH03ENs0bbu1Dshr+DP/2qTg06uzTxkbfNxlVc3zYMIcj6
         7PGqg151aAPXMbNEImWiMTsJHK+ODhXdNRFHkq8S+7FAaSejFXPlz2g+DrrtfF1klxzO
         ANKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxpEGHGlq+XU03ZHAAwnpP3ZzPLt8iI4d0oszEmQeRur9Pum/Fux2Mht598gz9K4yQTjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfcnf6S0pR/m7xIdMvrjGDnmF+ybOkBehSV1U4VM8qyN73j4W
	AoubtWDPqFr9n33PSRivOUo39Y+YhDYFXcExolVMXiuSF1PGgEF8GZkVl/R5/T3E0oI=
X-Gm-Gg: ATEYQzwHZSHYpdY3ODVMAhuMv/Ud00JHnZDKT1hrmXeF2JY14zHNbahs+cidKPaFGyd
	1QJe8m79O2XSUdIbFkpuIbvOsJ4bZx2ZytKMArxVypj82W8ttX9hHa6i4DEj8m3HA0z3+8gaag4
	pL8ZQaCtcwDCwkzwVoh66EcsgZAYZp5ehpY3uIxBJ/Vs8+DE+gb7VV15JIa5HlqBnbBLkndTXK1
	wXruYNLWYkNYz+0yd7cYDqUBaRhHmnUEy4wUpIs0gJOsRu/pX//srJakLxmChBRUVe2D7LTtPSr
	wxq1lBjd5av9t6TDb+Ckqsb0HFlAjtSkJonHMmda5jydPo3TLGnyU7BugVHkYWJNIRdtXeSzlK/
	eNrC+T/n6qrNr83mOldJQFLKLFZBtjwVGABPr1mnsGQeDACvLpfJR4niLdEmwyXBk4Nl+8fnMGO
	Bbq9sUPjOnt10mQS6QwxE=
X-Received: by 2002:a05:600c:a44:b0:485:3692:e8f7 with SMTP id 5b1f17b1804b1-4854b11212bmr80287175e9.25.1773297955276;
        Wed, 11 Mar 2026 23:45:55 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:7358:55be:6563:4437:e6fe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a00332df4sm2548163a91.1.2026.03.11.23.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 23:45:54 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:45:47 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <bnw5mn5vwgezvhvzotrqcxfq5xixczjgzc2gj42565vnod5aai@rbwkdbuz5t3d>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
 <aaocJ3gJr7019urU@Tunnel>
 <fd6a7d7fc0eee70b0b3053b1db34e9e986b2a067.camel@gmail.com>
 <aaoevIcblUpMyN3U@Tunnel>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaoevIcblUpMyN3U@Tunnel>

On Fri, Mar 06, 2026 at 01:24:28AM +0100, Paul Chaignon wrote:
> On Thu, Mar 05, 2026 at 04:18:42PM -0800, Eduard Zingerman wrote:
> > On Fri, 2026-03-06 at 01:13 +0100, Paul Chaignon wrote:
> > > On Thu, Mar 05, 2026 at 11:48:22AM -0800, Eduard Zingerman wrote:
> 
> [...]
> 
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe28b99e4ad2682742e 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > @@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct range x)
> 
> [...]
> 
> > > Don't we usually put changes to this file in a separate commit, as for
> > > test changes in general?
> > 
> > W/o this change the reg_bounds.c tests would fail.
> > So far we tried to keep selftests passing for every commit,
> > to help with any potential bisecting.

Similarly we have stable AUTOSEL tends to just pick up kernel/bpf/
changes and not the selftests ones. e.g. both 76e954155b45 ("bpf:
Introduce tnum_step to step through tnum's members") and efc11a667878
("bpf: Improve bounds when tnum has a single possible value") got picked
for 6.18.17-rc1, but not 024cea2d647e "selftests/bpf: Avoid
simplification of crafted bounds test".

> Ah, I didn't know that. Definitely makes sense for bisecting.
> I probably broke it at least once :(
> 
> [...]
> 
