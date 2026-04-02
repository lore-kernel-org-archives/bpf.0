Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708132C302
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118460; cv=none; b=WBpXqNwqdenwZN2aun2HwOKJCwQrJgKsTH0WefNEhuK0+KASXcEitgtp+MU5XjurDrGZp9io7qGGMb+/IMLFiGVCqlLyFWw/FhzExWfbAvWjviDoYLASxPpKNo0RStYGRTAoCWq7FxRWMJIyLPkMHrGBc7CZiByrwSomPYVUmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118460; c=relaxed/simple;
	bh=5WKXLY64F5RJb8v0TSZfJ1b4/07H2Kgd5EYDwANetr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsA1LINR1jaeHZlDTtWsVCA+fjYY16TYsKikRQmY5P4aANe+V04KMNRcyHwV85kC0W18slG7msg9UDOaRwwkHvbR/PoX8xYxAGZeeh9GJfIyXXoPJkONND65IDmN5wTqo+0SrYsDKmvbT954eRfmom3RRIcPenTj8ETGvNEblM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWe3l+Hp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWe3l+Hp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so5959585e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775118457; x=1775723257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMTR7t/mofhN1xznDniHdN6KL68L0HZyIyjnQeBS3tg=;
        b=dWe3l+Hp/73M1d1YA5Nh21ShU+BzxriPRWaLsRKpzKSo1I5QIFQ37hJBVlz3IxCj1k
         DsTni5o//4/fyBJl1KO59SIyBdTx9BmTvEx1qEX7eFn7jef3B+SdXpFOLyqKIYq7j8sh
         hCq+6fQ9lAd1R+Ru61hSDfvc6f7LWeuN9tZ+mkPbpMgFJ3pSVFgBzxu7NGhlKgrV4VSk
         eGwpi+EZoE+xzI+Djb/RUc8yvwtUtJ9WpKfIFvXgzyTUMgytYsIJEPmfQEY1PXP19VY0
         lp9+yVbohXhBL8lY/CxfIpuKZEGfOuXCQym48PaYkiHVhAQul1YGCdbtqAl4cNit9nLV
         gyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775118457; x=1775723257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMTR7t/mofhN1xznDniHdN6KL68L0HZyIyjnQeBS3tg=;
        b=PE9Mavo+sgOsxyUqrfbY7ipRAhij7ZdwCPXKFLsRfc5vz9WMC6KFLfaO6xNdN+tGGP
         j3ypsfvbvbHPyDuZdW0WgNJEDoKxAooHLBsDGHWhNJiPMFyVaSAaue25ediRzR1wL49d
         TFIfNWPW16u2xa7ckQDVIu4664XEuPWBVc0M6U1CPPXCe5CgsJlf+msPfUjjAGT/YGkz
         rRZFgntSennnBC3nKms5BcD9D/dsQ0fHZR4BEPJVHmH2oc6YcVwRrENgLahZ1/TIimF4
         g0QhTDlVnTum9bBjM9JV2r+pIe3urcwtUkfR3Q1HC7qHkNo97OW2er3iDNaMMSPOLFpF
         pE8g==
X-Gm-Message-State: AOJu0YxTdJRcd/BrIgCuQGpehkoMp5aXLEn4Q9wdr/TqLRv6VnV7axpT
	FEXVXhinO8DBIsCnZRcgoPE0ASfY2tRWEWCfqZYT0+FYUxox3OBWwH26
X-Gm-Gg: ATEYQzwSRmhEEVdR7aN5XsSQ1/LHC/TmRtvJhJD1MtmBfdgxZY5VptTqfnJFmamw4eB
	5lNAnWfwtyMcGveYrL2w6azrwH6bHEyVp8aWYWreNoNAteZsDmFroPFBYRpNJW1oDgwO4j5eiRP
	V80j2B4QfTKWZH1L08m++qbBMMGorM2oNEAKDGmnt7G2kBfT3GIG/2iU9ZTfT+rRoVwT/ZlHJ7F
	IaqNTEw6JkIPitdEop7+mMsIp9XepFvGJoy6CgK9LU/xFRklmwuU0Y6bj8gBqs84fNhdSJt5tX8
	0C8Yi9vX7h9XN1g1F/FeR+9Vv6etVGX+0cRbYHmVk5Ml9AEg6B26qDMJL9iJ/FdpuCRgFMGSeR9
	A4oCNKeaA1b8iEjAAiTSkYD2qA0i7tJxhRnmq0LvyFOb97CTlYfkh3bN0ZulUTHydwmNnro9gCf
	ts2rbH+OAxkFvwVw59c51EJu6cDJv0jdK7
X-Received: by 2002:a05:600c:4f12:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-4888e0bfe43mr23695655e9.12.1775118457292;
        Thu, 02 Apr 2026 01:27:37 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm197583795e9.7.2026.04.02.01.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:27:36 -0700 (PDT)
Date: Thu, 2 Apr 2026 08:36:22 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not ignore offsets for loads from
 insn_arrays
Message-ID: <ac4qhjSHmfBj5eHh@mail.gmail.com>
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
 <20260401161529.681755-2-a.s.protopopov@gmail.com>
 <823cfd94-a35d-4f99-afa3-238fb1e9862d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823cfd94-a35d-4f99-afa3-238fb1e9862d@gmail.com>

On 26/04/01 11:47PM, Mykyta Yatsenko wrote:
> 
> 
> On 4/1/26 5:15 PM, Anton Protopopov wrote:
> > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > specify an offset inside the load instruction. This is a bug,
> > because while the verifier ignores the field, JITs are not.
> > So, patch the verifier to not ignore this field.
> > 
> > Reported-by: Jiyong Yang <ksur673@gmail.com>
> > Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >   kernel/bpf/verifier.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8c1cf2eb6cbb..f1b1c8e9dc26 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -212,6 +212,8 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
> >   static bool is_trusted_reg(const struct bpf_reg_state *reg);
> >   static inline bool in_sleepable_context(struct bpf_verifier_env *env);
> >   static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
> > +static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
> > +static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
> >   static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
> >   {
> > @@ -7735,6 +7737,20 @@ static bool get_func_retval_range(struct bpf_prog *prog,
> >   	return false;
> >   }
> > +static inline void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
> 
> Why does it need to be manually inlined?

No reason, thanks, fixed.

> Other than that the change looks good, the implementation of the
> add_scalar_to_reg() is similar to a piece of code in sync_linked_regs().

Thanks, I will send v2 today. Also will add a "if (!val) return"
check to skip adding 0.

Just in case, sashiko had some comments on this patch, all are
false-negative (for selftests it found same two issues as you).

> > +{
> > +	struct bpf_reg_state fake_reg;
> > +
> > +	fake_reg.type = SCALAR_VALUE;
> > +	__mark_reg_known(&fake_reg, val);
> > +
> > +	scalar32_min_max_add(dst_reg, &fake_reg);
> > +	scalar_min_max_add(dst_reg, &fake_reg);
> > +	dst_reg->var_off = tnum_add(dst_reg->var_off, fake_reg.var_off);
> > +
> > +	reg_bounds_sync(dst_reg);
> > +}
> > +
> >   /* check whether memory at (regno + off) is accessible for t = (read | write)
> >    * if t==write, value_regno is a register which value is stored into memory
> >    * if t==read, value_regno is a register which will receive the value from memory
> > @@ -7816,6 +7832,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >   					return -EACCES;
> >   				}
> >   				copy_register_state(&regs[value_regno], reg);
> > +				add_scalar_to_reg(&regs[value_regno], off);
> >   				regs[value_regno].type = PTR_TO_INSN;
> >   			} else {
> >   				mark_reg_unknown(env, regs, value_regno);
> 
