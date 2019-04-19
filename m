Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1512C282E1
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 21:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791DB208C0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 21:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exGOSj9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfDSVOI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:14:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39915 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDSVOI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 17:14:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id l18so3004512pgj.6;
        Fri, 19 Apr 2019 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oB+JREFbcKFfSk3iVW4HcmicHYfGk27YJcdpU/hk6rw=;
        b=exGOSj9jqGnq/GrR9ARSiWdwNgFgMX30g1dnVFAIpQKgvcNkd1IXEoLB7SpKNQtdUY
         9wRlqDdjqvteiZ1OxnPwOlHAZhso+udrBacliJds+5aD4ByBBDnOuyiPCI/eHdL47P+U
         A3lg7u+hAKnPUYW7KA1ZNyyEvqid2fdyi9boGgJbWabP/mRg3mLM75+oY0tH5KpXdCSE
         b0+AWLWCaHMicxjmBQH3Aw7iBIVq39jxGfUvopFsC72pQf9H+qlSParxs1MXIPnsL2Ac
         pizgpDWk6Ci/mpuCAgkhOm1uyC3nBQJdMpVdH1Gdv+clxzJReHZQxfw4x4eEcwSRsqSF
         pOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oB+JREFbcKFfSk3iVW4HcmicHYfGk27YJcdpU/hk6rw=;
        b=J5veKDKWqB+wZFf9Ttmw/2YRcvAESwDwUs93wqrExLlpDe5mr1cRVhC6qsIfVVHrQ/
         lSac+lvrdRlfQWgqCjCC3H8lLoygDlfJI1Ir4c5xmoRa9edkPo5tdTxsLlA4SvTfuSvX
         1thw7h1n5t+m1OhizA0LODUp3wBzS0D8xxKYhKv2K9dWJM+NfUPxefZC2aBdkM1Dnfuu
         pwDpkVXgfOEdfQSicPMnUKV3lAoiHLjQAlFkXyj4xLWJxVHLNdZcI03sDJOFEzeQJUCH
         hQlTEDtfqzr6Wdpd5drUHZIRw1fLjvOPk2rbN5v3gvZElHeLIgE36xXXdg3sd7jG6Ypi
         L4qg==
X-Gm-Message-State: APjAAAUUSJre0YUTTes94jxIae34l6uVm4+y4xsNeEWGSrGuegUZXbDZ
        KfbQFR9auNpbOI6xhjUb9ps=
X-Google-Smtp-Source: APXvYqzqnqgXeLcBihuWDMNI0NDDAomn1+njl+P8OWZACGu+l6ZXL/o8ZMIIZ1+lRuXmuEHa9QhzLQ==
X-Received: by 2002:a63:115c:: with SMTP id 28mr5972113pgr.270.1555708447940;
        Fri, 19 Apr 2019 14:14:07 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::6f64])
        by smtp.gmail.com with ESMTPSA id z13sm6587532pgc.25.2019.04.19.14.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:14:06 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:14:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 02/15] bpf: mark lo32 writes that should be
 zero extended into hi32
Message-ID: <20190419211403.6iovh26bu6cg2x36@ast-mbp.dhcp.thefacebook.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
 <1555349185-12508-3-git-send-email-jiong.wang@netronome.com>
 <20190418235747.jv4yocuf6fgwahli@ast-mbp.dhcp.thefacebook.com>
 <20190419134051.71eeea08@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419134051.71eeea08@cakuba.netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 19, 2019 at 01:40:51PM -0700, Jakub Kicinski wrote:
> On Thu, 18 Apr 2019 16:57:50 -0700, Alexei Starovoitov wrote:
> > > @@ -6371,8 +6406,10 @@ static int propagate_liveness(struct bpf_verifier_env *env,
> > >  		for (i = frame < vstate->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++) {
> > >  			err = propagate_liveness_reg(env, &state_reg[i],
> > >  						     &parent_reg[i]);
> > > -			if (err)
> > > +			if (err < 0)
> > >  				return err;
> > > +			if (err & REG_LIVE_READ64)
> > > +				mark_insn_zext(env, &parent_reg[i]);  
> > 
> > I'm not quite following why it's parent_reg here instead of state_reg.
> 
> Perhaps we should rename the parameters to something else than parent
> here?  I always have to do some mental gymnastics looking at this code..
> "explored" and "current"?
> 
> The current state is parent, the "next" state that pruned the search
> is "state".  So we check if the reads under state X need 64bit, if so
> have to propagate back to writes on current (which is called parent
> here, even though it won't become state's parent, ugh.)

agree :)

> > If I understood the code the liveness can have all three states:
> > REG_LIVE_READ64 | REG_LIVE_READ32
> > REG_LIVE_READ64
> > REG_LIVE_READ32
> > whereas 2 is a superset of 3, so 1 should never be seen.
> > 
> > If so, why in propagate_liveness we have this dance:
> > +       u8 parent_bits = parent_reg->live & REG_LIVE_READ;
> > +       u8 bits = reg->live & REG_LIVE_READ;
> > +       u8 bits_diff = parent_bits ^ bits;
> > +       u8 bits_prop = bits_diff & bits;
> >         int err;
> > 
> > -       if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
> > +       /* No diff bit comes from "reg". */
> > +       if (!bits_prop)
> > 
> > I'm struggling to see through all 3 combinations in respect to above diff.
> > Shouldn't propagation of REG_LIVE_READ64 remove REG_LIVE_READ32 bit
> > and clear subreg_def during mark_reg_read() instead of
> > once in propagate_liveness() ?
> 
> This reminds me, I'm not entirely clear on the need to propagate the
> zext through stack slots...  Pointers are guaranteed to be 64bit, we
> don't save parentage on scalars (AFAICT),

scalars have parentage chain too.
we don't track them precisely when they're spilled to stack.
That actually caused an issue recently when valid program was rejected,
so we might add a feature to track full contents of scalars in the stack.

> why not pass REG_LIVE_READ
> or READ64 to mark_reg_read() from stack_read?

can we agree on only two states first ? ;)

