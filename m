Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D673093CF
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681219; cv=none; b=jy+YS3d7NW7t3AjmWHL4p8B+BX3TdBbLY77cnDT9lsnK+PR1yG274HhoiEn7VDbG6ozQETGwalifKsG93lYqiS6vfT8sA1XwHhw/8Vw0pAAWZZUhF3lqOZ5mDl+kJgfZRaR6v4EN/YCAzlvcNSj0sT2Z5FyEfZ3b2+M4D2kPun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681219; c=relaxed/simple;
	bh=Sh6sOF1RPzaT0lrZ9cMJPnJiJVDSdzKtYVjSuIh8YI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkPglJ8MFH1y4ks4eN5+OovocaKnpgNBKHEH9mMGyUm9j3Nwz/8+3sMFN+zBceakCfGn91DK2kF1IYjHYO5tDPFF6skbnoxwkzWAvVuLn/s3a/954BD5MLWsnVgNapUNzVGEUdDXi2lXqVRjiwpdPhlZT7KGUZlzDgPPebm80qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lub1ecpq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lub1ecpq"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bcd0111ea98so548415366b.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778681217; x=1779286017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMhytqxRju8iVqhDQbq4QxMEhzThIu1e2R1K5jgIlDw=;
        b=Lub1ecpqgCPjOX8najuQ2WLo9zjyWqlNJRyt6JQtiQkwVX/XgjM1yPwigE0HvsvpBv
         ms2TKIku05aQrvQIHQ3hiBzTYfmPlN1sEqhK+ihFZmhFit5dESn3LZF7fjsUPPtCsyhM
         p0dPwqbuChj5U0uatjUVZ3wtHJp77MoGj5VC7Kx3yy4QKc8WozWWOfBuG03eXD/ppxgq
         UywqowYoqFnPMNW/Xm656u9eegjQJF7fjyxoTHI2Hzr4AqFD7SjmgU4wz2KoUr/pygfM
         RNIlj5Aw9uLB0uJPymuM9Z2jYe9f89+Tv6jRi/HpvRFiskR67nOhCLP3mrB9NJqw3Uvd
         Ej5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778681217; x=1779286017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMhytqxRju8iVqhDQbq4QxMEhzThIu1e2R1K5jgIlDw=;
        b=gRwVs+mo79tb+D1/f28GYGy9BvKRy3F0GX2HhFQVw85x2atCQZyL3vzgsJsY9C/V0j
         uQtT+HzpCp4kZcqyiwx/vqc7Ssz092n17R8T7tDhLfUvNTMPVLEXS9OPnNkav/1NCFk4
         I4hlK8v5Xgct0M1+ITPcJwyWo1DjwbvsVe5YmughCU1LHC/38T3HtpIPRMEoQ0/ujn0W
         cIJ4vl+pPfyNHcGi15lFbmpa1P91BGcLviaNgADpOhIn+bKqgvl9brtk0qc4jU6RRt73
         I3f4AHkLKAJeDVexiLltSRcmDQw/3bN1Cocle5+4urODHkrOT/wijjFtbF10j16R2KTE
         zLng==
X-Gm-Message-State: AOJu0YwO/7kK1zrbuw893CqrRjtCH51E+0ylRkKaLyVBW/BhUsaHAWPE
	KOsWfMl5VU7dzQ5FYViOeX4RQ04TsUeRkHPLLQIp9VTU6+oMmxW5j9aIRpzb0g==
X-Gm-Gg: Acq92OGWGJC9qcO4KfveLApuk4Y9xjrCnaNrePXOw4R0LgVkXOzXoHN4r1PB2jrErwH
	3Enq+jn4hYTtY3fTIeBpM+jNHeW5NFgBeaaqaz/pszpSb6RcXbYJUaJfRVUJC/wfBQYT5zDUNQP
	IqCQJiEC0yT4sSoFjucsd1YCWkXAdVhhcUG3y1eAuRyUzfcBfTQufuEM6QRNQr9fPTFvANuV3U5
	XSAob2fPXnvt9dOfT5HYt97oNFPQUKNVyOkw2k1VWjqyY2YF5ZU7c4poyYqYJ3BXbjWLtB5+yz2
	jd4Sox7PzwHwMNSYbipye1PtQCwV0cp5g+7WFTFhIEKcEeG8NjEn2Y7fiDhRGe2c/EDIs5vAKxR
	UjHcSS9z4E5AdcvEcR7BgMxbMbygLIVFzi7C483CpGNewrdBAtZCQOiJTrGy+dZkp0n0EtGquHR
	WBhTgol4co1UnlKzG7AYnRpKL27Dj9SxIUrZr/S1Orgib7AxEIeDWIo3bRKlK8PX80ZnHyUHW5D
	A2wi3HVGsJtkdsEzJtZfyT3KjbxFt2lloiV79rZfja5L4jr6QMlmf3yLsT2SvMZvfB4aqqKsFzp
	Bq8VGsAW4UUysAOOwNxir0FzGr7z4uNAkAwhPoz+pnaPOxPcQ+IRGw==
X-Received: by 2002:a17:907:97ca:b0:bd1:c82b:8bae with SMTP id a640c23a62f3a-bd3c216eff4mr235967566b.45.1778681216337;
        Wed, 13 May 2026 07:06:56 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eab7sm40525453f8f.23.2026.05.13.07.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:06:55 -0700 (PDT)
Date: Wed, 13 May 2026 16:06:53 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Report maximum combined stack depth
Message-ID: <agSFfSBjRer5vyGi@mail.gmail.com>
References: <05f82d1180b68e856bb0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com>
 <2a6d16baade6d1d22ebda367c67f49ad9aeb4dc5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6d16baade6d1d22ebda367c67f49ad9aeb4dc5.camel@gmail.com>

On Tue, May 12, 2026 at 02:53:33PM -0700, Eduard Zingerman wrote:
> On Tue, 2026-05-12 at 19:19 +0200, Paul Chaignon wrote:

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 11054ad89c14..896dbb4515d7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5045,6 +5045,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
> >  		}
> >  	} else {
> >  		depth += subprog_depth;
> > +		if (depth > env->max_stack_depth)
> > +			env->max_stack_depth = depth;
> >  		if (depth > MAX_BPF_STACK) {
> >  			total = 0;
> >  			for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
> > @@ -5185,6 +5187,8 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
> >  	if (priv_stack_mode == PRIV_STACK_UNKNOWN)
> >  		priv_stack_mode = bpf_enable_priv_stack(env->prog);
> >  
> > +	env->max_stack_depth = env->subprog_info[0].stack_depth;
> > +
> 
> I think this line is redundant, the loop below would call
> check_max_stack_depth_subprog() for the main subprogram anyway.
> Additionally it does not round the value same way
> check_max_stack_depth_subprog() does. Also note that if main
> subprogram uses private stack it's depth is omitted in cumulative
> depth computation.

Yep, you're right. I had misread the loop below. I also need to update
env->max_stack_depth in the private-stack case in
check_max_stack_depth_subprog(). I'll add a selftest to cover that in
the v2.

> 
> >  	/* All async_cb subprogs use normal kernel stack. If a particular
> >  	 * subprog appears in both main prog and async_cb subtree, that
> >  	 * subprog will use normal kernel stack to avoid potential nesting.
> > @@ -18289,7 +18293,7 @@ static void print_verification_stats(struct bpf_verifier_env *env)
> >  		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> >  		for (i = 1; i < subprog_cnt; i++)
> >  			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> > -		verbose(env, "\n");
> > +		verbose(env, " max %d\n", env->max_stack_depth);
> >  		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
> >  		for (i = 1; i < subprog_cnt; i++)
> >  			if (bpf_subprog_is_global(env, i))
> 
> Maybe also add a veristat metric for this value?

Ack, makes sense.

