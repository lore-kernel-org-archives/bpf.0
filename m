Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F5284B3B
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607590; cv=none; b=mllL74zgXtAiRSIVLo8Y3MC14S6y2JB9YM73h+8QKkDH/mVNZgc6Q6NDIWNgtt9M7PfeB1vrf7AMcpJ2HLNLKJsx08vkMp/sxSLcvblHXlfIKS2LR7V31qFG9ulHDxOQ9qMrs5fRwKZ5RlMx4ReVDuZi2K6MXQy15qfLFEuWs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607590; c=relaxed/simple;
	bh=XZ+eZfMd/SnAmbewnOLdKyCjJDAOtlJ9whQCdCnF9tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L38liDAR/AioMiyQMWzrcInraB2VCfWd405uJ3YuGEtkkGEnD0V34kQbJecX2RuxRSeD3sKcQtt16hVKGS6Sj6jBcdibH8HRGXCOiZaiKNLZD+EK6ta8Y4jgzijRBg4bFt8igTsQveZyCuf2Yvm2IkKgrd55DTSy66plo4vTfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tt7UnFG6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tt7UnFG6"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso2359396a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780607587; x=1781212387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpmTXOSXfXdpm1jna+TOnmqAtRm7jGoWeJJF098zmuA=;
        b=tt7UnFG6GCrTKCbliQKkdHAfsTQxnHvybIfLWBNwtu3amuIY9zRHKUVcNgiMq74O+N
         9xZWra6e1VbL7lfDJUtkEtu3NjaIydoekjuYjYknvgGhpzR4mh/EGUtmmFxTFKlStiYJ
         eFPx5lTo2wYkq6dEquTHllmd9tRe0C9EZ3kmtX74sQBBkfqFqXvu/KP4WYra+yQXy13l
         hFdTalhYlINMHwJLkEwmUX4mIkdFPLNLy7D4UOM6aj5d4rGMlFlCpUyllRhmlvBwah39
         Hg51hrOdwlU0eelpSwXXrxdDAgJfFjPj3sKUOIbOp/Qk8JA1G3iLNbwemRdRD8EB1WNp
         UP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780607587; x=1781212387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpmTXOSXfXdpm1jna+TOnmqAtRm7jGoWeJJF098zmuA=;
        b=EOgXM6d48I6xByfm90+Jkwr36dhhhVquBPrv3EmrTUeLkd1RyoA9/Mwytfuw/E8Bln
         N6MIQHwa+9bvPAdGPKZUDNLFIDHu4dDrG5vBUEIlC7zZdSbkOnww+HBSE8/8/3n1CMW2
         QgSwMX72FMa/vIxCu5SWpH5dHqUnpzzJp4Kn6I1XtUpV6UYlLQttIRoO9EHXx5Bmyxfo
         +32w2q/Hg1Hc1KZC7dBkRuVGRjO853PhIyETsYhQMD1hBqIO3CayvLG2KRLWwu7ifGA5
         uFgrcPKCGXY+sKYnMpgFpb+4a3p4gfWMZxDmo5SZcMRRmzvrFsIzqkIGca1nYIHCmAYU
         xamw==
X-Gm-Message-State: AOJu0Ywix3w4B2+fbkwwkd2aRWzy+x74JBwWXeseuJm2INjK3tI9uLih
	bAB8gbEaldIEtgY4L34EqURSAl9N7mbyqpX9IdxphszX1+vc6Rfom3pN6EofaGtXqw==
X-Gm-Gg: Acq92OEnYv9mFEQs0CrQoEBnYA7l4oNm5oNftBpFlivHMxigy7qpIJ2WTyAKAZa+gmp
	x6ISKpvlgMjDBgeSdRgkJHjsz6YZg9UNkpOKjZMeMwaGnOjzmSfL2aq9nAMV4W5jhCGE9RfrStc
	JpaXJn1tR/CLoSb/abiniR0Ue7wyYgs6qczmVoV7XBpM7GYC2dCDgyzHqNiBlRLbz5Qhvl5FyKV
	Y0ry6l27H/s6rpizVc1WM/0oOqFXhzFquc1h0moOZLzzu78HVfWv/WJXgf2uQTzHJKy1A9wHe1c
	aFXIkdkTxJ8xtwq1g7ZaDtIiMAlAGvKl9s9HMKWUGAIfMvVcVNZ/b+VeI7+ofpZ0BiO62pzMezd
	2fgTqCdnko+31UxlgsQu0+T88mTD4+XRiMwlSvvB6+2GNQ/bvkfaB/SyihPe0TT9xEMGwTdiJxJ
	jrzV0IwuMtkkF8UgNAOBSkyLIstnLD9gkNgYVYM+Oyd4ODft3KhCSA4GdxmCuamDZNA7KAGxFTs
	Mjq
X-Received: by 2002:a17:907:6d11:b0:bec:2d7f:fe03 with SMTP id a640c23a62f3a-bf370a65b91mr17838766b.17.1780607586468;
        Thu, 04 Jun 2026 14:13:06 -0700 (PDT)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e0280asm348461566b.33.2026.06.04.14.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:13:05 -0700 (PDT)
Date: Thu, 4 Jun 2026 21:13:01 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: clean up btf_scan_decl_tags()
Message-ID: <aiHqXT-0xUAbBQ0x@google.com>
References: <20260603201822.770596-1-mattbobrowski@google.com>
 <DJ0E1ER599F1.36FPRHEE3YZAP@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ0E1ER599F1.36FPRHEE3YZAP@etsalapatis.com>

On Thu, Jun 04, 2026 at 11:59:26AM -0400, Emil Tsalapatis wrote:
> On Wed Jun 3, 2026 at 4:18 PM EDT, Matt Bobrowski wrote:
> > Refactor the newly introduced btf_scan_decl_tags() to improve
> > readability and maintainability. The current implementation uses a
> > manual if-else chain and a magic number offset to strip the "arg:"
> > prefix from declaration tags.
> >
> > Replace the if-else logic with a table-driven approach using a static
> > const array. This separates the tag data from the scanning logic, making
> > the helper more extensible for future tags. Additionally, replace the
> > magic number '4' with a sizeof-based calculation on the prefix string to
> > ensure the offset remains synchronized with the search key.
> >
> > Finally, optimize the loop by moving the is_global check to the top of
> > the block. This allows the verifier to fail-fast on static subprograms
> > without performing unnecessary BTF string and type lookups.
> >
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> We can also modify the new btf_scan_type_tags() to conform to the same
> pattern. It currently recognizes a single type tag, so if anything it
> would be more code, but we don't want it to slowly end up looking like
> the if-else chain we're replacing below.

OK, I'll also take a look at btf_scan_type_tags() and if so adapt it
and send a patch through.

> > ---
> >  kernel/bpf/btf.c | 46 ++++++++++++++++++++++++++++++----------------
> >  1 file changed, 30 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 68921d9172b5..55aa3ba1b1e0 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7808,14 +7808,28 @@ static int btf_scan_decl_tags(struct bpf_verifier_env *env,
> >  			      u32 arg_idx, bool is_global, u32 *tags)
> >  {
> >  	int id = btf_named_start_id(btf, false) - 1;
> > +	const char tag_key[] = "arg:";
> > +	static const struct {
> > +		const char *tag_value;
> > +		enum btf_arg_tag arg_tag;
> > +	} tag_values[] = {
> > +		{ "ctx", ARG_TAG_CTX },
> > +		{ "trusted", ARG_TAG_TRUSTED },
> > +		{ "untrusted", ARG_TAG_UNTRUSTED },
> > +		{ "nonnull", ARG_TAG_NONNULL },
> > +		{ "nullable", ARG_TAG_NULLABLE },
> > +		{ "arena", ARG_TAG_ARENA },
> > +	};
> >  
> >  	/*
> >  	 * The 'arg:<tag>' decl_tag takes precedence over the derivation
> >  	 * of the register type from the BTF type itself.
> >  	 */
> > -	while ((id = btf_find_next_decl_tag(btf, fn_t, arg_idx, "arg:", id)) > 0) {
> > -		const struct btf_type *tag_t = btf_type_by_id(btf, id);
> > -		const char *tag = __btf_name_by_offset(btf, tag_t->name_off) + 4;
> > +	while ((id = btf_find_next_decl_tag(btf, fn_t, arg_idx, tag_key, id)) > 0) {
> > +		const struct btf_type *tag_t;
> > +		const char *tag;
> > +		int i;
> > +		bool found;
> >  
> >  		/* disallow arg tags in static subprogs */
> >  		if (!is_global) {
> > @@ -7825,19 +7839,19 @@ static int btf_scan_decl_tags(struct bpf_verifier_env *env,
> >  			return -EOPNOTSUPP;
> >  		}
> >  
> > -		if (strcmp(tag, "ctx") == 0) {
> > -			*tags |= ARG_TAG_CTX;
> > -		} else if (strcmp(tag, "trusted") == 0) {
> > -			*tags |= ARG_TAG_TRUSTED;
> > -		} else if (strcmp(tag, "untrusted") == 0) {
> > -			*tags |= ARG_TAG_UNTRUSTED;
> > -		} else if (strcmp(tag, "nonnull") == 0) {
> > -			*tags |= ARG_TAG_NONNULL;
> > -		} else if (strcmp(tag, "nullable") == 0) {
> > -			*tags |= ARG_TAG_NULLABLE;
> > -		} else if (strcmp(tag, "arena") == 0) {
> > -			*tags |= ARG_TAG_ARENA;
> > -		} else {
> > +		tag_t = btf_type_by_id(btf, id);
> > +		tag = __btf_name_by_offset(btf, tag_t->name_off) + (sizeof(tag_key) - 1);
> > +
> > +		found = false;
> > +		for (i = 0; i < ARRAY_SIZE(tag_values); ++i) {
> > +			if (!strcmp(tag, tag_values[i].tag_value)) {
> > +				*tags |= tag_values[i].arg_tag;
> > +				found = true;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (!found) {
> >  			bpf_log(&env->log, "arg#%d has unsupported set of tags\n", arg_idx);
> >  			return -EOPNOTSUPP;
> >  		}
> 
