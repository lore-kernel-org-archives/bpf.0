Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD79481FC2
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710007; cv=none; b=f62Vpui0KCQDs2eYJCsifDMcRoeYxz2GEl92AW6NqVpW3lHjhAYiYmGqQzuo2xKtdNzBcWYKW7AofmUsJqRty2fqc41XPwy5oMJermUlbHA6k4kOstJTz0nbVhwzGaFH7SLO4TyGowDQVd4A5+H0EwVOjJzCPAZFAIj0rIHyhd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710007; c=relaxed/simple;
	bh=Gi8PdX/xJefeuMRnuMFLwGXlOOxXOnK+PMGm+0kb+q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fncC6M98sWjcQTzv1haAprFlsGi3aKfCxPKqbYdIYjp1RAQz8HFoOGXpI3hDIEX9AVo31GCMxHAnwoS/6/BuV42W5ZKs9u8fhEpvAPxUspihGlk8/K2GqPXbZ5CPkgAKR+/tCGVEKEhuRb9bIVmThO2FRutMNKyUPJ+pKTejBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WeAFf94H; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WeAFf94H"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so1159060766b.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784710002; x=1785314802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eGY5z0oJYZbmuykBUwttVGRAF86RZolhsRiuz0vNo4=;
        b=WeAFf94HrbFRJmEkkCOazlhlNvfMscdqyty7/0/XkT9Y77MXaeoHDe6eUJhByZc3+s
         G1hHZmfKOve28eBJOFjc1FUOEafmadBTjqBkAqyt+DOhGWXeteKe2RzLU8fr2YegnNxh
         xT9EIZ7cYgc2pgUGcc9JJJEroiHpx4gwQpoeY8cvxMXdXa31yZ/y3fqlCohEVHLMO+Sz
         pdLfooiHRXhsXrFCWDz8h1EetzUM7Yh0xnVYXEoZTIXyodpcK113B4QsnaLpK0vyRWnM
         OgpovIb5eJ8e+UQeyXMY2zrV/09xNjTTHXH0WfM9E9+XSJKDqG7JPWv5eZpT9D1vsZIf
         ZTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710002; x=1785314802;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eGY5z0oJYZbmuykBUwttVGRAF86RZolhsRiuz0vNo4=;
        b=goGeU1HSmn81zWRNgKHH9skYsnpQnxkTIl14DS0I6UXqEBYrlZY9c5V3CxXsoekE9c
         N3jxrK+6NaVp/5y2g1/UGXQiv0VkUH/9m/Nhu1fz/pBNpqieV896wqFf/t0E0DoIKcII
         Ttk5lrzx/DM4FIUr7F2f1z0zn+bmt25vTeeVLQakUs6xHFk+LoAN39LxeT5At19WYuEq
         /0Ys4QYKTgmHii3s5nVw/sOhst2sPoR73hVxKisJVQI7ylsnuGG9WfmiG3qzL840tSSc
         64/MNZuZzz5XCnHNFlLs29pUQvQvDSHmGG56gtvTZrEY24nGBZa4fnIB3pc9MHUsrSKn
         GNaA==
X-Forwarded-Encrypted: i=1; AHgh+RqMfl9TIX+SCeyKnGSFREjy3nBlwMPqTNxbWgViWNUT+PKsQZnCZkZV49iq2QmxTHKZ4LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBAVIv4qCYeA78gHM+3UufVbOLQQrN2OSGfMgpAG2m2rC8OeX
	3SmGXmZY22Ij4GHJbnxZi/IEpQFa+gFyGJsAtQja1qeD/L0l624nNl0K7pZsG8B/gFM=
X-Gm-Gg: AR+sD11SvF5oO1ovZRG+Ax7t6GyDKdiG59TheeLiagz5Zycifcc0/kswiLeVskv9ye5
	soeMYBSDiXbzXklm6kZc9IXZssR1R2ywUohTkG58InnOr+vOJOwBD8CZSUuf/D7p2O5RgZEwxIS
	I0Hu7ousE4koYiPCGd/Jk2gKAcD1DRyc1EG6laUtl3tMA/QYnHeC0v5DMYjRs98rXiAS8q8fHFc
	jWs3vYna/X/efWtGbC6Qh5Bw38FJ4myBvqNEsGDJSJ1E9sM6QafE6gYHD42SNrJ/JdEznnUOF+n
	jHuHeOnKeQyRvuaTztECahkTaTrQ6k7hVmxsc2EYijOXcen2tyi05zj9l9QmaZZM4StfEA8jxjE
	EiB93RQatJdjhqPnyzH88Cvvnp6c1cheyXI49frm9Ca8fh/gLE243vOoM9fSByCHRAy2xHYm1A+
	+fZjHvtxlp+KUtmp9K9wMHLznI
X-Received: by 2002:a17:906:eec8:b0:c16:1031:e729 with SMTP id a640c23a62f3a-c16b46caaabmr1001085766b.11.1784710002296;
        Wed, 22 Jul 2026 01:46:42 -0700 (PDT)
Received: from u94a (27-53-137-220.adsl.fetnet.net. [27.53.137.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f386c68sm10765705ad.74.2026.07.22.01.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:46:41 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:46:30 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: Preserve stack frame number for commuted
 arithmetic
Message-ID: <amB_My3Pg2hIxRG7@u94a>
References: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
 <a092a059781aad37b8d8ce3bb927052de5f73431.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
 <976ae2fbf6f2ead76622e39813bfda6a6981d382.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <976ae2fbf6f2ead76622e39813bfda6a6981d382.camel@gmail.com>

On Tue, Jul 21, 2026 at 05:12:14PM -0700, Eduard Zingerman wrote:
> On Tue, 2026-07-21 at 09:39 +0000, Yiyang Chen wrote:
> > When scalar += pointer is handled in adjust_ptr_min_max_vals(), the
> > destination register has to inherit the pointer register state from the
> > source pointer. Copying only selected fields is fragile because pointer
> > provenance is tracked by several bpf_reg_state fields.
> > 
> > For the commuted form, pass a temporary scalar offset register to the
> > common pointer arithmetic helper and copy the full pointer state before
> > applying pointer arithmetic. This preserves the frame number for
> > PTR_TO_STACK registers and keeps parent identity fields consistent.
> > 
> > Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")

This doesn't look right. Without bpf2bpf there is just one frame, hence
there isn't a bug at this point. I think the commit f4d7e40a5b71 ("bpf:
introduce function calls (verification)") the you mentioned in v1 should
be used here instead.

Ideally there should be a second tag for the missed parent_id
preservation issue for invalidating dynptr mentioned by Sashiko, too.
But it wasn't that obvious where that issue was introduced to me, and
f4d7e40a5b71 pre-dates dynptr anyway.

> > Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> > ---
> >  kernel/bpf/verifier.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 52be0a118cce0..3c0af83db4672 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13796,11 +13796,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> >  		return -EACCES;
> >  	}
> >  
> > -	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
> > -	 * The id may be overwritten later if we create a new variable offset.
> > +	/* For 'scalar += pointer', dst_reg inherits the complete pointer
> > +	 * register state. Individual fields may be adjusted later by pointer
> > +	 * arithmetic.
> >  	 */
> > -	dst_reg->type = ptr_reg->type;
> > -	dst_reg->id = ptr_reg->id;
> > +	if (ptr_reg != dst_reg)
> > +		*dst_reg = *ptr_reg;
> 
> Lot's of tests are failing on the CI, please investigate.

I think one reason is that this overwrites r64 and var_off, hence in the
scalar += pointer case, we're adding the existing offset in ptr_reg to
itself, equivalent to:

    dst_reg->r64 = cnum64_add(ptr_reg->r64, ptr_reg->r64);
    dst_reg->var_off = tnum_add(ptr_reg->var_off, ptr_reg->var_off);

[...]
