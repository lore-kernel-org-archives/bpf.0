Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B86EC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04AA20700
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 16:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y90wWajy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfC0QiR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:38:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42143 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfC0QiR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 12:38:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so9945634pfn.9;
        Wed, 27 Mar 2019 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0iF9Ep4w0E5F6i0ZGhNi65FR471vSaCqojLduDmDxLs=;
        b=Y90wWajyCyRHDtATKmxDrycSoPXhkYtGd4UgUJsmHrbQSotJ4mBmv4ZUg3FWB8J5yw
         aVsuYw7E6vFZVbm0d+Fz9KiZg/FRkVNfJMi9AxlL/WEtiFmDV28jfoHLhUeIE6OrW6LP
         Rvs8B0oPn1FhzlGyIRvDMkJFi17XryNZR+B9pcQBzD2yVDz0+nC7VRxQNcWQAEPvoxYy
         OH5gVJ5rpBxrK3sw2nxgt2xN85+2qnSczfh1vhkvnh5wcULJIYDvQqDnBcZ8ybC7IN7T
         0C1FSf7DIa/Yo8oPXzb2gtjZ3/7df/xZdVPH/1xPcq9YViti7yUCZrdXBIK7kNyEu3XK
         3J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0iF9Ep4w0E5F6i0ZGhNi65FR471vSaCqojLduDmDxLs=;
        b=HRJ8D459cfFPSZds8NHuTSb0oj4hKpqsg9BN1jYiHuuQqt6ifcd73sxfCKY/grZIvN
         LvBeXqwc8UQgZ1wO1+CxDPRmE2MDpaL/QKNV7lA1EAdiJjo+1YpH7UytItyRxxo/6I3M
         X1BawsOzdvsE5c6HcgpTZTetXRKrX0OBuPyMDjTX7NaH/JWc0jm8ANTt1ZB8RF70+Md5
         FqH6uXDTWI/dBN4wtuL1dvrmp6L/N+d4mis/ge2F9EaLywNsfqIy9Qu9NYMMFya2m6Rg
         RCarXT/yDFD2epLyMYVjecOhAGurSwTDqMs/Vr3Jm7U+iGHO/Pid2zXs/Ll1YtV382Qb
         +dxw==
X-Gm-Message-State: APjAAAXuLJvpySj63vkb0xQAFnp/nncWzO2vNk1wcQ3C4f8GIiL0xDeK
        kaVl9OOZtAvovdbrGoXtmyQ=
X-Google-Smtp-Source: APXvYqyZSeB6i54Gu+DOa6n5gT3ABfb8ZkUziVHXnJRXVzeG9lR/q1ZLfSWBkhYd4ygoNYhwwXoY9g==
X-Received: by 2002:a62:1b03:: with SMTP id b3mr32410298pfb.150.1553704695904;
        Wed, 27 Mar 2019 09:38:15 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::ca40])
        by smtp.gmail.com with ESMTPSA id k22sm28899302pfa.84.2019.03.27.09.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:38:15 -0700 (PDT)
Date:   Wed, 27 Mar 2019 09:38:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 03/16] bpf: split read liveness into
 REG_LIVE_READ64 and REG_LIVE_READ32
Message-ID: <20190327163812.c4juci35zok6qo44@ast-mbp>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-4-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553623539-15474-4-git-send-email-jiong.wang@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 06:05:26PM +0000, Jiong Wang wrote:
> In previous patch, we have split register arg type for sub-register read,
> but haven't touch read liveness.
> 
> This patch further split read liveness into REG_LIVE_READ64 and
> REG_LIVE_READ32. Liveness propagation code are updated accordingly.
> 
> After this split, customized actions could be defined when propagating full
> register read (REG_LIVE_READ64) or sub-register read (REG_LIVE_READ32).
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  include/linux/bpf_verifier.h |  9 ++++++---
>  kernel/bpf/verifier.c        | 30 +++++++++++++++++++++---------
>  2 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f03c86a..27761ab 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -37,11 +37,14 @@
>  /* Reg hasn't been read or written this branch. */
>  #define REG_LIVE_NONE		0x0
>  /* Reg was read, so we're sensitive to initial value. */
> -#define REG_LIVE_READ		0x1
> +#define REG_LIVE_READ32		0x1
> +/* Likewise, but full 64-bit content matters. */
> +#define REG_LIVE_READ64		0x2
> +#define REG_LIVE_READ		(REG_LIVE_READ32 | REG_LIVE_READ64)
>  /* Reg was written first, screening off later reads. */
> -#define REG_LIVE_WRITTEN	0x2
> +#define REG_LIVE_WRITTEN	0x4
>  /* Liveness won't be updating this register anymore. */
> -#define REG_LIVE_DONE		0x4
> +#define REG_LIVE_DONE		0x8
>  
>  struct bpf_reg_state {
>  	/* Ordering of fields matters.  See states_equal() */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 245bb3c..b95c438 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1126,7 +1126,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>   */
>  static int mark_reg_read(struct bpf_verifier_env *env,
>  			 const struct bpf_reg_state *state,
> -			 struct bpf_reg_state *parent)
> +			 struct bpf_reg_state *parent, bool dw_read)
>  {
>  	bool writes = parent == state->parent; /* Observe write marks */
>  
> @@ -1141,7 +1141,7 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>  			return -EFAULT;
>  		}
>  		/* ... then we depend on parent's value */
> -		parent->live |= REG_LIVE_READ;
> +		parent->live |= dw_read ? REG_LIVE_READ64 : REG_LIVE_READ32;
>  		state = parent;
>  		parent = state->parent;
>  		writes = true;
> @@ -1170,7 +1170,7 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
>  		/* We don't need to worry about FP liveness because it's read-only */
>  		if (regno != BPF_REG_FP)
>  			return mark_reg_read(env, &regs[regno],
> -					     regs[regno].parent);
> +					     regs[regno].parent, true);
>  	} else {
>  		/* check whether register used as dest operand can be written to */
>  		if (regno == BPF_REG_FP) {
> @@ -1357,7 +1357,7 @@ static int check_stack_read(struct bpf_verifier_env *env,
>  			state->regs[value_regno].live |= REG_LIVE_WRITTEN;
>  		}
>  		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
> -			      reg_state->stack[spi].spilled_ptr.parent);
> +			      reg_state->stack[spi].spilled_ptr.parent, true);
>  		return 0;
>  	} else {
>  		int zeros = 0;
> @@ -1374,7 +1374,8 @@ static int check_stack_read(struct bpf_verifier_env *env,
>  			return -EACCES;
>  		}
>  		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
> -			      reg_state->stack[spi].spilled_ptr.parent);
> +			      reg_state->stack[spi].spilled_ptr.parent,
> +			      size == BPF_REG_SIZE);
>  		if (value_regno >= 0) {
>  			if (zeros == size) {
>  				/* any size read into register is zero extended,
> @@ -2220,7 +2221,8 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
>  		 * the whole slot to be marked as 'read'
>  		 */
>  		mark_reg_read(env, &state->stack[spi].spilled_ptr,
> -			      state->stack[spi].spilled_ptr.parent);
> +			      state->stack[spi].spilled_ptr.parent,
> +			      access_size == BPF_REG_SIZE);
>  	}
>  	return update_stack_depth(env, state, off);
>  }
> @@ -6059,7 +6061,7 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
>  	if (parent_reg->live & flag || !(reg->live & flag))
>  		return 0;
>  
> -	err = mark_reg_read(env, reg, parent_reg);
> +	err = mark_reg_read(env, reg, parent_reg, flag == REG_LIVE_READ64);
>  	if (err)
>  		return err;
>  
> @@ -6092,7 +6094,12 @@ static int propagate_liveness(struct bpf_verifier_env *env,
>  	regs = vstate->frame[vstate->curframe]->regs;
>  	/* We don't need to worry about FP liveness because it's read-only */
>  	for (i = 0; i < BPF_REG_FP; i++) {
> -		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i]);
> +		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i],
> +					     REG_LIVE_READ64);
> +		if (err < 0)
> +			return err;
> +		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i],
> +					     REG_LIVE_READ32);

so the parentage chain will be walked twice.
Please do it in one loop.
It's already slow.
I'm working on patches that speed up this walk, but doing it twice is wasteful regardless.

