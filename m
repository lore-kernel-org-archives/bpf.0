Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F335A39F
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783961; cv=none; b=ths8YmtEvy+E2hv3QjwkM8aim8KoEjKAaX7KWPKVmQ423k1kbtN497icHxDMGuheNxM2ZBBWEYCGFw7EXaxecAucmr1EieKsOR/+OUF8ju3BiM8TLeKhdsqdN7YQ2sXIC2Kl5HBlienAJ6nV6bfsjdcSHfjb5KoIkZTRAH5sSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783961; c=relaxed/simple;
	bh=VZ1xLmoHmA/GZka2t1HsgohbquNga/6PsqItSxVcfqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3+Hz9M4baBvJtse4EMV0KqS2frO8077iYWFjfERKwtCM1+K9jjrPzTUmk1zl5wfPJg4/C6f1gevHIALpFykTTF9DXBLn3yLIoZzXc79WlC8lYnGAO1zb8WA89ZmznLbgQ28XEXqz7EUZVtf+X7xsGInftsm3lSFn1BraQk/NzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D84mfVS1; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D84mfVS1"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-133362c30cfso20c88.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778783959; x=1779388759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xyoK6RbsaezwMoF/eYHV3i96uwAfiWW7vUcLVu1RGs=;
        b=D84mfVS1K7QTob9ZCMzKSAymRWDrBu6y3zrQ0KJIK0cuc6T2zOYLa7fZhPaArFOdJ9
         k1e9wEz1lW5+VtnK3uhR47F4qVCkt31ZYoUVW85/fMrrUzexIj88vt3As8xeeMN3fPPD
         mbGa4G0xemo7kSr2P6EEg5Z6A4wdrRsDIJTZXV3KaMomtAR4d02dpetNOPV1SMuujqNH
         V9rlatXOBhEqcp8mW/4VipCYmrLhLKoxq+xHU7XX2eax9pB2UENQpapoQMbyVEKLsdQF
         DNY17kDQu5bF9EeEQcs+3C3TyZ+BtelI/MCx6ax9MeSTVO+s/m0mHNRr91B+z0UWIXIK
         PBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783959; x=1779388759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xyoK6RbsaezwMoF/eYHV3i96uwAfiWW7vUcLVu1RGs=;
        b=fZulcU5araQYBQA0wzGqP8QAymMKIlN0ugsHkalYAHeS2gqUuyvWfqg6Ke83jcCKFJ
         arPRIOIJDDF8NthG2BdkvAz1Vqojwo6t0AEZLIP2Ggke8smX1I8U5G/Z2XpSZeTDJ9gH
         5htkTMfJMwWvvAB7tbTFb6D/ynIvRsJj0B4TdETrmeRdouMGOsJq52yed+VThycTVh+w
         DyFe/xdI+dx+hQ6EKt9rQfhGXZJiGmUleLcPMaam0YwVb4blfXt0GSrxXCmc6Dkcm2eb
         7l2B+CuBMJUWktUwXm0H9HJljSmQbNR7D5dT8ybMyisUNlKzvgsULiO7Oau7UNptlHHV
         Ga8A==
X-Forwarded-Encrypted: i=1; AFNElJ8iDqDNAGbGEVgXijdsoyoK6sQnUBuT4UXeG7zywegXLM0b/vFgx3BMV8Gwj1VwGPHWQ5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0TbOVHUi1EniY3RVN+ij5WCpdcY/3OP9Kgs5fvakQ4JiNz/S
	q87HYM3GpLHAtUSk5eqk+jXIKhFqmFvbF+aMf7QuoBDE0MkZ5ySJXqhPeMzUsiGFcA==
X-Gm-Gg: Acq92OGHhu5te5rm7xCxE1satskZnpVaQaS4eusv9UcUATBPohnJBZMtXIv44XZ+ih3
	7huE5OpAD9dTDyCrCjEvDI423tEC3D+w4D419T/A19Jy7krKmFY9QtuV2571YffNJEkGdhtPSCo
	Zkfwf8ztnzIDKm47J7kLfhS+RTs2JOXu2/EFnXZkePRU+L7M8BE4KBYQwpcqyBT8+0Ed8Ava8eQ
	4Zy3LQeStwL+zJvQ5S7FiEBmqvI3Pmw//HqOubs9LCoT4DqdrnTmga8RtU69qdRphxjLnwPD3DK
	nu4NKwGNbIx/SSZI5Y3r77SPhfHCiV7sSL+1l5KTcjEnjF90KA3J93IgYs/IIk8WAyUDyjR3A+J
	wgO2TOx3cVsx/JTUWIzm2Ci2c+WU9iNz/0sR87YzzDO2mwQwT6kgpJmZOYI1AKa3k2GD5UAJubU
	i38pLT3DQ13GF3sDcvW8t2MWZE/hmHjTLjfyLYE6MJKz27E9Kdswdic0mEkX/NSevJx9WJPu90Z
	777uW5ciNolIiMQB4rODJlKLrQamDzs8MhPUwcnWe99BWG/VwonhNrU
X-Received: by 2002:a05:7022:1286:b0:12c:8f55:cd0d with SMTP id a92af1059eb24-13503ce1652mr15715c88.8.1778783958064;
        Thu, 14 May 2026 11:39:18 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm4071783eec.4.2026.05.14.11.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:39:17 -0700 (PDT)
Date: Thu, 14 May 2026 18:39:13 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix UAF in strset__add_str()
Message-ID: <agYW0bzWPkBipMkX@google.com>
References: <20260513232055.1681859-1-cmllamas@google.com>
 <20260514115711.133F4C2BCB3@smtp.kernel.org>
 <89d34016-cf82-4beb-989c-e4fc2e3cd29e@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d34016-cf82-4beb-989c-e4fc2e3cd29e@gmail.com>

On Thu, May 14, 2026 at 02:38:01PM +0100, Mykyta Yatsenko wrote:
> 
> 
> On 5/14/26 12:57 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > - [High] Unpatched Use-After-Free in strset__find_str()
> > - [High] Use-After-Free in BTF add APIs due to btf_ensure_modifiable() freeing raw_data
> > - [Medium] Early return in strset__add_str() breaks hash map deduplication invariants
> > --
> > 
> > commit 2a7bfcb093726b849608e340f9bda7c5e3f56ac2
> > Author: Carlos Llamas <cmllamas@google.com>
> > 
> > libbpf: fix UAF in strset__add_str()
> > 
> > This commit addresses a heap-use-after-free in strset__add_str() that occurs
> > when the provided string points into the internal strset data buffer.
> > It adds a boundary check to return the offset directly if the string is
> > already within the buffer, avoiding a dangling pointer during reallocation.
> > 
> > [ ... ]
> >>  |     #0 0x55d25155a2a7 in memcpy (tools/bpf/resolve_btfids/resolve_btfids+0xcf2a7)
> >>  |     #1 0x55d2515d708e in strset__add_str tools/lib/bpf/strset.c:162:2
> >>  |     #2 0x55d2515c730b in btf__add_str tools/lib/bpf/btf.c:2109:8
> >>  |     #3 0x55d2515c9020 in btf__add_func_param tools/lib/bpf/btf.c:3108:14
> > [ ... ]
> > 
> > Does btf__add_str() have another use-after-free when operating on a
> > non-modifiable BTF object?
> > 
> > If a user calls btf__add_str(btf, s) where s is a pointer returned by
> > btf__name_by_offset() (which points into btf->raw_data),
> > btf_ensure_modifiable(btf) is called.
> > 
> > btf_ensure_modifiable() allocates new buffers and calls
> > btf_invalidate_raw_data(btf), which frees btf->raw_data.
> > 
> > At this point, the argument s becomes a dangling pointer before
> > strset__add_str() is even called, making the boundary check added by this
> > patch evaluate against the freed raw_data.
> > 
> >> diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> >> index 2464bcbd04e03..7d2b2784172e5 100644
> >> --- a/tools/lib/bpf/strset.c
> >> +++ b/tools/lib/bpf/strset.c
> >> @@ -141,10 +141,15 @@ int strset__find_str(struct strset *set, const char *s)
> > 
> > Does strset__find_str() suffer from the same vulnerability being fixed here?
> > 
> > It follows the exact same pattern as strset__add_str(): it temporarily
> > appends s by calling strset_add_str_mem(set, len), which may realloc() the
> > internal buffer.
> > 
> > If s points into the internal buffer, the realloc() frees the old memory,
> > leaving s dangling before the memcpy() occurs.
> > 
> >>   */
> >>  int strset__add_str(struct strset *set, const char *s)
> >>  {
> >> +	const char *strs = strset__data(set);
> >>  	long old_off, new_off, len;
> >>  	void *p;
> >>  	int err;
> >>  
> >> +	/* Check whether 's' is already in the strset data buffer */
> >> +	if (strs && s >= strs && s < strs + set->strs_data_len)
> >> +		return s - strs;
> > 
> > Can this early return break hash map deduplication invariants if s is a
> > substring?
> > 
> > If a caller passes a pointer to a substring of an existing string, the
> > function returns the substring's offset but skips inserting it into
> > set->strs_hash.
> > 
> > Because the substring is never added to the hash map, subsequent lookups for
> > it via strset__find_str() will fail, and future additions from an external
> > pointer will duplicate the string.
> > 
> > Would it be safer to calculate the offset, perform the realloc(), and then
> > re-calculate the s pointer instead of returning early?
> > 
> 
> It looks like sashiko is right, addressing the same issue in strset__find_str()
> and handling substring case could be useful.

The substring case is interesting, it can save memory space I suppose.
Although it sounds like a brand new use-case, since users would need to
perform some pointer manipulation on 's' first e.g. strstr(). Also, per
the current logic doing so would still trigger the same UAF.

It does seem like more than just fixing the bug though. Would adding the
support for substrings still get backported to stable without a user?

Yeah, it seems strset__find_str() suffers from the same issue. In
general, it feels wrong to call these two APIs with a string that is
already present in the buffer.

Anyway, thanks for the feedback and the example. I'll send a v2 with the
suggestions.

--
Carlos Llamas
