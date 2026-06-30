Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7CE3E0C55
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843616; cv=none; b=I7Gb1WTtxyzXC9EWQXTi5fjj/HTIo2EoP8MQJpRlyhcXjGlL9U6bYywHBEYXy/fX0GloWDBpihT2K8Kw+XvREVb3tyagrActdcZ3gdU8R2oyPVe0wJAWLXPizP6UNzpb3yTgAIuTiwG5eVNfPPAZuGIgcc09bgFwxSBCt6WmCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843616; c=relaxed/simple;
	bh=3MWWgnBNxcNxcJyS1JYLu2pwY6mLlM3CWAfqQAGyALo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6ZPno8phQq3O0hXhEqRaUR6NsDltlMCKJPqHTgUrYLSM2SUVTKpzA42QR0Bikk/wwEax4nlKGcafjlOKrfMTgGjd2b0wr+ZKkq7OycghsUIjGf9Ow+187HKgnwTwCvRQsXdxyY+WhF/Y6ZmLeWuEATxkzPbUZTJnN4A7z3qlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC0TjlMx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC0TjlMx"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4728c12ba97so2244463f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843614; x=1783448414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wX3a5DZftWQLzIO2gAwJsDiCFshv0dUhsjO14dVAZWo=;
        b=NC0TjlMx5QVcSNBYh1WpSYEKY/ltfDKLQj+X6H2EPA+g0+QsF1xtnvMX0ChlndY/xE
         58drb7SeoH2zPcQT3lDN8sdDdnUXicuQyNqhd/DQDHXKmzjhRBpQDwWWSU6QxQd6O4uz
         jaeLwWJVM5kERczFK+YMePOeclAhe0qsaQKSMlmlMqbl8eJUnEe9HMn/yahZnNsfSew9
         rwqaohlkXqnFE8Qr/8tiK+f7i4KFAApSdkoCtpTK4PV5B8PMWfqwTgvO7O9DxaNwzq/k
         6pnxluf+ekhBzRHL4ydZP74mGetoM9qd4g786uF+o+TbKI2T32FSyxNaZe67R5uC/Vyd
         SErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843614; x=1783448414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wX3a5DZftWQLzIO2gAwJsDiCFshv0dUhsjO14dVAZWo=;
        b=rlQWw9KimGjmZLz5ADYfBHrhRueDdgyUwn6EXJ6gpZA566osfV319MIElSvaiw7Ujy
         DTEB7dEvNxnpSOtATdAd1/dj+PBbQRtNUsCOIRVRe+e1WcxBsN9E2LU9Gzmj/jGkusuo
         vol+zenKhZtQxKbq/F10/bq0VtQTA9hy5V8gZ3Re9MnewI78wgfttx7ZZfrR8Si4HNBc
         dGw4PFpsx7D4lJOtUU6BZVgGsAPtazg9H0S80Vb+TWREXyPsVDTqOAsCLwhKd4nSAgC+
         p0qyz2szsscOc16Nn7Dqo8I9k3xAMirLZ+7dzKyzYF3AMFu3zTEE8h1Y2lOs9FGLw0hB
         9+KQ==
X-Forwarded-Encrypted: i=1; AFNElJ+J5F0SoCkvlqSY9YZXcP46LL6NXaQ9XALIOrn3JFW24dYRRHLPXqWbvQ5ZhteXG/nLV14=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoz9UgX8ysU90Ey0WzrGRIAI6GqoPRKhjJH+ENOM05LKxifCg3
	4RHjdwAAFsZsm+2ruVMFKMzaajgSWI4uAgOw47Ocd0mVKKoNkM7uk9B5
X-Gm-Gg: AfdE7cmNS3bu+73zgiU/tmJ0llQhoxgWo1fzh99ic8guPN30tq8aFHxhBrEej3+5XI7
	UGLCXxk/Z6H23Um2hZP12vIDI7NnBEUurrY1vs8lJkbNkl1UyW0KdYSIsZxNgM4+UEgVde2g6gv
	5Gf8WkFtczSvO5gM+qie7rFNgDrJdkrE8cvFsqcV8qrS3rGk8nE2QCWhDrNpudkpWbITmVAbUoz
	oZZWxpv+HpGnqv4PIa8Mz5hDwJfYtSI4LW3svFHf/kbufGJiBAmsW69clW+Ov6J+equYoPDi9t8
	pQSlPtLWsl1uLRRIun8QnVuXq9QP+yzG+EF9/EGi8Y875KE6hks2LoOgI4n1G5S4yFttgKIlnvl
	TkSbyaVFPQdFZKcK+Wo4qv1OpwSLhG/3MmUq1fTPRxNNR6WyjQVGlqj0xVhfV6s8guwgbPULraD
	cvAG5eG572fl2154Wfgg1uipvs4lmfMr4u
X-Received: by 2002:a05:600c:4695:b0:493:aa24:792b with SMTP id 5b1f17b1804b1-493bda6fdc1mr26258915e9.22.1782843613521;
        Tue, 30 Jun 2026 11:20:13 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm12316055e9.9.2026.06.30.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:20:13 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:30:15 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Enforce gotox targets against
 subprog bounds
Message-ID: <akQLN49YynM4hf+H@mail.gmail.com>
References: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>
 <20260628-f01-03-gotox-bpf-next-v3-1-b744432e1361@mails.tsinghua.edu.cn>
 <20260628142401.80DC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260628142401.80DC21F000E9@smtp.kernel.org>

On 26/06/28 02:24PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] The patch adds a runtime bounds check to prevent `gotox` targets from jumping outside the current subprogram, but fails to ensure that dynamically observed targets were actually modeled during Control Flow Graph (CFG) construction. This allows an attacker to follow unmodeled control-flow edges and bypass static liveness-based state pruning.
> --
> 
> commit 5e0bdd5b4a7e2ce073913482349669d9387d6a32
> Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> 
> bpf: Enforce gotox targets against subprog bounds
> 
> During CFG construction, the verifier records the modeled gotox target set
> in insn_aux_data->jt. This patch adds a check to reject targets outside the
> calling subprogram bounds when check_indirect_jump() follows targets from
> the runtime PTR_TO_INSN register's actual INSN_ARRAY map.
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -17188,6 +17190,23 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
> >  		return -EINVAL;
> >  	}
> >  
> > +	subprog = bpf_find_containing_subprog(env, env->insn_idx);
> > +	if (verifier_bug_if(!subprog, env,
> > +			    "gotox insn %d is outside subprog bounds\n",
> > +			    env->insn_idx))
> > +		return -EFAULT;
> > +	subprog_start = subprog->start;
> > +	subprog_end = (subprog + 1)->start;
> > +
> > +	for (i = 0; i < n; i++) {
> > +		u32 target = env->gotox_tmp_buf->items[i];
> > +
> > +		if (target < subprog_start || target >= subprog_end) {
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this bounds check alone fully protect
> against unmodeled control-flow edges?
> 
> During CFG construction in kernel/bpf/cfg.c:jt_from_subprog(), if an
> INSN_ARRAY map's minimum offset falls outside the subprogram, the heuristic
> skips the map entirely:
> 
>     if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end) {
> 
> If an attacker creates an INSN_ARRAY map containing both an out-of-bounds
> offset (e.g., 0) and a valid in-bounds target Y, the CFG construction drops
> Y completely because items[0] is less than subprog_start.
> 
> Later at runtime, if the attacker restricts the bounds to index exactly Y,
> this check passes because Y is within subprog_start and subprog_end. The
> verifier then explores the gotox to Y edge that was never modeled in the
> CFG jump tables.

The robot is right here, the check should verify that the map was
actually checked during the config stage. I think the easiest way
to check this is do the same check: verify that the whole map fits
within the subprogram. (An optimization would be to cache this info
somehow.  Every jump table map can only lie within one subprog, so
subprog index cached is enough.)

Could you please address this and add a corresponding selftest?

You also have lost some acks for this patch from v2, please
don't forget to add them the next time.

> Because liveness analysis relies strictly on the statically modeled CFG,
> could traversing this unmodeled edge cause liveness to incorrectly assume
> registers are dead, allowing an unsound state pruning bypass?
> 
> Should this logic verify that the dynamic target is actually present in
> env->insn_aux_data[env->insn_idx].jt, rather than only verifying the target
> is within subprogram boundaries?
> 
> > +			verbose(env, "gotox target %u outside subprog\n", target);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn?part=1
