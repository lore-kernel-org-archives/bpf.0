Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67595C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 16:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CB72082F
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 16:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trkOAUSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfC0QfJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:35:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40940 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfC0QfJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 12:35:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so10179423pgo.7;
        Wed, 27 Mar 2019 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6jHg8Zc9oA4ImwCHws9l8N+YT23p/v70upnm1qqJ9CU=;
        b=trkOAUSyC+3FY7qv/McUf9TTA52IKfrx19qG7eS/0JK5c9aAYCyFOMzyWiVD1WyY6B
         ODCw13tzoJYBvdjypezfC5KMKGY2/euZIRaOP7oqD47Jq9XfoHfKnza+4GmVeLdIecrL
         bn9xaZ/JdzQXiFL/c2piLVJr14tHqnleO37iPcm+N9wYBxPOBKfkDe493ogRc5IL1Yra
         u0P8thB41tFddb7BcsAwnYxnb+kV4hiXM7zaXxjNNp01nt99RRQ67rROr8a5+6uKPpsg
         pvjj6kGdm7tnbVVACuSZUFYVtMyCH6yqsaahy8BSZYROOVD9rhabfao0LNlJvuZGzLSc
         9gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6jHg8Zc9oA4ImwCHws9l8N+YT23p/v70upnm1qqJ9CU=;
        b=jY/r409PJ5I/yZshOBuNw9WgbFqLRXP/f+V6BTIjShnPAHgk1oo+mDcqnTKID+ADjE
         DOXhn+JaU6gyXSg5XuT6QX8uiN607w04TkfUnUrLWNcLSto0KLrY8tK50m24XIj00pA6
         q9MGE09uITDkQINT0o+IkzfEKAd2aB1UT5kgpxMFc6dIg8btQp4c3oHdd90eU7oG2l1k
         +0s+xzg9II5XWkk+/Jc9x8y5ZKlRUeqWUBcIc67FpiIizmRx8EF5j5Gnw5THsiQc4mLK
         J61ymCtrQGz3xMgG3LwIDEpmyBHchwh/rm6mTBqQ8aKCsNEm0auADY8LTsaojlaVWBhk
         HIzg==
X-Gm-Message-State: APjAAAUeyrvMg8T7R1KMMQNYacnjuSJ/Udq7FDQT0Sn4qwbMrRRPlYUg
        f/6izCfNcg64FYVbtxzSr7A=
X-Google-Smtp-Source: APXvYqxTlvv6+ODCXbAbE5wLsRciGlD3AtaqPj3K2ebhOFT+w5LaVJM0rRJ0RYa4cv+PaZV0AsaxoQ==
X-Received: by 2002:aa7:8443:: with SMTP id r3mr35765040pfn.143.1553704508364;
        Wed, 27 Mar 2019 09:35:08 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::ca40])
        by smtp.gmail.com with ESMTPSA id l187sm27298136pgl.75.2019.03.27.09.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:35:07 -0700 (PDT)
Date:   Wed, 27 Mar 2019 09:35:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 02/16] bpf: refactor propagate_live
 implementation
Message-ID: <20190327163504.7ueecpetrwohkbmd@ast-mbp>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-3-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553623539-15474-3-git-send-email-jiong.wang@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 06:05:25PM +0000, Jiong Wang wrote:
> Some code inside current implementation of "propagate_liveness" is a little
> bit verbose.
> 
> This patch refactor them so the code looks more simple and more clear.
> 
> The redundant usage of "vparent->frame[vstate->curframe]" is removed as we
> are here. It is safe to do this because "state_equal" has guaranteed that
> vstate->curframe must be equal with vparent->curframe.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6cc8c38..245bb3c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6050,6 +6050,22 @@ static bool states_equal(struct bpf_verifier_env *env,
>  	return true;
>  }
>  
> +static int propagate_liveness_reg(struct bpf_verifier_env *env,
> +				  struct bpf_reg_state *reg,
> +				  struct bpf_reg_state *parent_reg, u8 flag)
> +{
> +	int err;
> +
> +	if (parent_reg->live & flag || !(reg->live & flag))
> +		return 0;
> +
> +	err = mark_reg_read(env, reg, parent_reg);
> +	if (err)
> +		return err;
> +
> +	return 1;
> +}

what is the difference between 1 and 0 ? it doesn't seem to be used.

> +
>  /* A write screens off any subsequent reads; but write marks come from the
>   * straight-line code between a state and its parent.  When we arrive at an
>   * equivalent state (jump target or such) we didn't arrive by the straight-line
> @@ -6061,8 +6077,9 @@ static int propagate_liveness(struct bpf_verifier_env *env,
>  			      const struct bpf_verifier_state *vstate,
>  			      struct bpf_verifier_state *vparent)
>  {
> -	int i, frame, err = 0;
> +	struct bpf_reg_state *regs, *parent_regs;
>  	struct bpf_func_state *state, *parent;
> +	int i, frame, err = 0;
>  
>  	if (vparent->curframe != vstate->curframe) {
>  		WARN(1, "propagate_live: parent frame %d current frame %d\n",
> @@ -6071,16 +6088,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
>  	}
>  	/* Propagate read liveness of registers... */
>  	BUILD_BUG_ON(BPF_REG_FP + 1 != MAX_BPF_REG);
> +	parent_regs = vparent->frame[vparent->curframe]->regs;
> +	regs = vstate->frame[vstate->curframe]->regs;


may be do:
frame = vstate->curframe;
if (vparent->curframe != frame) { WARN...
parent_regs = vparent->frame[frame]->regs;
regs = vstate->frame[frame]->regs;

?

>  	/* We don't need to worry about FP liveness because it's read-only */
>  	for (i = 0; i < BPF_REG_FP; i++) {
> -		if (vparent->frame[vparent->curframe]->regs[i].live & REG_LIVE_READ)
> -			continue;
> -		if (vstate->frame[vstate->curframe]->regs[i].live & REG_LIVE_READ) {
> -			err = mark_reg_read(env, &vstate->frame[vstate->curframe]->regs[i],
> -					    &vparent->frame[vstate->curframe]->regs[i]);
> -			if (err)
> -				return err;
> -		}
> +		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i]);
> +		if (err < 0)
> +			return err;
>  	}
>  
>  	/* ... and stack slots */
> @@ -6089,11 +6103,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
>  		parent = vparent->frame[frame];
>  		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE &&
>  			    i < parent->allocated_stack / BPF_REG_SIZE; i++) {
> -			if (parent->stack[i].spilled_ptr.live & REG_LIVE_READ)
> -				continue;
> -			if (state->stack[i].spilled_ptr.live & REG_LIVE_READ)
> -				mark_reg_read(env, &state->stack[i].spilled_ptr,
> -					      &parent->stack[i].spilled_ptr);
> +			struct bpf_reg_state *parent_reg, *reg;
> +
> +			parent_reg = &parent->stack[i].spilled_ptr;
> +			reg = &state->stack[i].spilled_ptr;
> +			err = propagate_liveness_reg(env, reg, parent_reg);
> +			if (err < 0)
> +				return err;
>  		}
>  	}
>  	return err;
> -- 
> 2.7.4
> 
