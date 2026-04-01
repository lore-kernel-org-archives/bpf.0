Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426FB33FE02
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042156; cv=none; b=NcOxKr2tiGVUvc+bsH9JOsXN98OC/eP0h35zoKiPXNynSpusX/+8pXh2bg40cAGBUw9U4CELN+R0uz2iu8D7SkqFITTIVMbW+r4dgxttI9PvD8A++oPQFKMLgnFtrj3jegKj7uWhAm0/mTzpkR1F4MQ8PygZI5RMAgy9T4dwaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042156; c=relaxed/simple;
	bh=8mTYXRes3Yfdkzr/JUjuvw/y6b7+hTR3U862Qi4cdN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe/TBFGfb/BMeFWD1BV4qAQo1piRB0YskevJrmMUYR/YH4aYPTjXuuZKPZhDgvj9XFNXYe0GNXucwZ7YOWNY2BRLwQev8p/yTGJSBv3P3TGs91Sq0u6omUGE2Zx979A8owJ3/nlCDb/srTzKssZgxNEhdSsT9UXcup4+lyVicjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4lPn0aN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4lPn0aN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso60852515e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775042154; x=1775646954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vKD2ABhNjMN1YKUJCJDYgbNmSPYy+yYAHHJE4J921DA=;
        b=n4lPn0aN/uwOpyT0ziWImLPN857ebi4tgshatGCSclPoY7tmqcaQeGHxv2XXMjmtMU
         LSaGMMhXqm2LLwHVL/6YCLnjmduhetxFa5wWHFhU83xCWVXXhnBF+YwGhfMB80Mf4Qqj
         tMSCf9Gua/8Zamck/X7fN3aziawUKs4rILpPnFrXdxI/MfnCatfddnqkJ9kYSgmMs9m+
         +jRZE3FhczBQt9GugQiqOK9XY+vl1t8sRJ2u+xedQDWgJXh5gohlgroNQep2EwVSVD0y
         CQEEiprxInMJoBwf9mZpPJX5iztk3vdzLbk5u/mcxsNVBD9KgdSLAJnFQDevLeUaEwY3
         V3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775042154; x=1775646954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKD2ABhNjMN1YKUJCJDYgbNmSPYy+yYAHHJE4J921DA=;
        b=C+0hJliMvi6SWyC5XCPt0uDfzW7rf/WAygr2KXR2zCiETTD5DLEeftktVlVogkqIRi
         zavtH2PrxSgHjIzpKV+Uta+KNiHazRqQKVujc5W0A5crcfOJTwY4GZ9cKGIpf9mSKAGJ
         E2oFAk2Q2xtDSlcIHsExsxTKlvHnYXB4qlKWk73aMdJguXyyfKg9hvfCTv/2JS1R+5Nk
         gaeEsyTE7OanbZJ6wzU6thMZACszKA/PYYqjis3UYhJlJvHTSmHwB7oqP3iD3d692Wbt
         YCEVNWQ2ZiREtNE3VrSX155W6NCjRwOV+r3gohdko0qBOKNmpIj+dY56tccaCMafgkD9
         ETbg==
X-Forwarded-Encrypted: i=1; AJvYcCWrXDweq8iMnkKZ56FD+Qlhj6Jz/wN7CiRhkKjnBRb94igbP2wQdixUq5kNNu2JLfC5ZU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0mYOkdQV2E84z6ru7+z0LY9r3QhChZKGxY3B2RvP+KeX7j7M
	pgNPaoYiXAIdziSN21cD/AMDbUEy9yZLmRBn5V/iRf5alZlEb1j/F2V0
X-Gm-Gg: ATEYQzxQ9Ygi57xZBqA294lWH5QNweLflglwo2DZCjhMantAYt1ehIciVe2ZHe7pxHA
	NBLJ0J3v8t3BgOJ7RfCL3oiwu5FD1oL0GO4h7IV+Eqs7YAEJFsVcyCjE1ZmgwXsVH7FJePRkc3K
	y4goFc2yiUpOeEoXM04HReVpAJ1gIrb5Phy7du7VFXBMS2uVslO8cjPvX7YZt9LNBTl35pgL0Bt
	RCId64TOZ5TINkHclozEIJhUl3QzQLi6KaJ+kpNGRjUlyUj99sAtDQMv5Ybe3iyk8UtKFRntlNA
	T33ZYYczEqL2fxdyChu6TgvXQhF+sz65R37qgpYjiXZ7JtgP72zAS6c1xhCpESbyvMJy02doNFu
	uKjyw3fnHAgMWzOT351MqMI0mJTn2GuQueh7E+PeXCsEofXH2Uq42p6c8xX6H+K1H4cso9mQNEA
	mka8rYkSiXXMcCTQ3EpD2uyjCIUbEpAqbGGzk4z2y6lv0Uwvf4LtxQxH54TO27hOq2hJmEfU3pA
	+D3GgttCZDAAlqWRzhZ6L0WpeqgFKXuCZt+P5ynMichIKil2O8Cep2dc/pj0F5OZME0MAIHoAn/
	wKURATxK+vhpB0gSPo5WFAAMBScRRrmKpH4vNmcyyJ9HDsfsH1052A==
X-Received: by 2002:a05:600c:a016:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-4888359d87amr51826715e9.20.1775042153408;
        Wed, 01 Apr 2026 04:15:53 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0077853c1cf79fe628.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7785:3c1c:f79f:e628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e86ecf6sm115086735e9.14.2026.04.01.04.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:15:52 -0700 (PDT)
Date: Wed, 1 Apr 2026 13:15:51 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
Message-ID: <acz-Z3SeC8jxwpVp@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
 <33c006d7275cb443b5750f062cb78c38449a7537.camel@gmail.com>
 <acpnHDASo5QGw7BZ@mail.gmail.com>
 <d8129d6f3624bf6393952cfc5655701679478836.camel@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8129d6f3624bf6393952cfc5655701679478836.camel@linux.dev>

On Tue, Mar 31, 2026 at 10:28:06PM +0800, KaFai Wan wrote:
> On Mon, 2026-03-30 at 14:05 +0200, Paul Chaignon wrote:
> > On Mon, Mar 23, 2026 at 11:42:11AM -0700, Eduard Zingerman wrote:
> > > On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
> > 
> > [...]
> > 
> > > > @@ -17196,30 +17192,23 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
> > > >  	 * variable offset from the compare (unless they were a pointer into
> > > >  	 * the same object, but we don't bother with that).
> > > >  	 */
> > > > -	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
> > > > -		return 0;
> > > > -
> > > > -	/* We compute branch direction for same SCALAR_VALUE registers in
> > > > -	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_JSET)
> > > > -	 * on the same registers, we don't need to adjust the min/max values.
> > > > -	 */
> > > > -	if (false_reg1 == false_reg2)
> > > 
> > > A side note:
> > > 
> > > The above hunk was added as a part of [1] to mitigate some invariant
> > > violation errors. Surprisingly, none of the tests added in [1] fail
> > > on current master if above hunk is commented out. Probably due to
> > > recent improvements in bounds deduction. Should we remove these
> > > tests as a part of the series?
> > > 
> > > [1] https://lore.kernel.org/all/20251103063108.1111764-3-kafai.wan@linux.dev/
> > 
> > Nice catch! Out of those five new tests, the three "jset on same
> > register, scalar value unknown branch" never fail if you revert the
> > commit they were testing, even at the time they were added. I believe
> 
> the five tests in [1] were intended to test the code:
> 
> 	if (reg1 == reg2) {
> 		switch (opcode) {
> 		case BPF_JGE:
> 		case BPF_JLE:
> 		case BPF_JSGE:
> 		case BPF_JSLE:
> 		case BPF_JEQ:
> 			return 1;
> 		case BPF_JGT:
> 		case BPF_JLT:
> 		case BPF_JSGT:
> 		case BPF_JSLT:
> 		case BPF_JNE:
> 			return 0;
> 		case BPF_JSET:
> 			if (tnum_is_const(t1))
> 				return t1.value != 0;
> 			else
> 				return (smin1 <= 0 && smax1 >= 0) ? -1 : 1;
> 		default:
> 			return -1;
> 		}
> 	}
> 
> Indeed, the three "jset on same register, scalar value unknown branch" tests never fail. 
> We always know if the branch taken or not on BPF_JSET, and `regs_refine_cond_op` does not 
> adjust the min/max values on BPF_JSET as it does for BPF_JLT.

Ok, let's keep these tests then :)

> 
> > these three tests were intended to cover the above "false_reg1 ==
> > false_reg2" check and supposed to fail with an invariant violation when
> > the check is missing.
> > 
> > I believe this check was never actually needed. For an invariant
> 
> this check can skip the pointless work on the same registers as Alexei said in [3].

I see. So not intended to fix the invariant violation but just avoid
unnecessary work. That makes sense, thanks!

> 
> [3] https://lore.kernel.org/bpf/CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com/
> 
> > violation to happen, we need regs_refine_cond_op to refine a register
> > based on a incorrectly-detected branch being verified. For jset, that
> > can only happen if one of the two registers is constant. In our case,
> > that would mean both registers are constant. But if both registers are
> > constant, then is_scalar_branch_taken is always able to precisely
> > deduce the outcome of the jset. Hence, we wouldn't even reach this
> > "false_reg1 == false_reg2" check.
> > 
> > I think I'll remove this check in a preparatory commit, along with the
> > related selftests and an explanation why it's all not-needed. Cc'ing
> > KaFai Wan in case I missed something.
> > 
> > > 
> > > [...]
> 
> -- 
> Thanks,
> KaFai
