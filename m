Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127EC282E2
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA036208C0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 20:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="eB+xPhCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfDSUk4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:40:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45107 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDSUk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 16:40:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so6543037qtv.12
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1XI5MijFbdUoBwKKN+708JO/+ViWWFaqhxvrhFYXz1E=;
        b=eB+xPhCfsgdpr9B0qWzEwryfBJESkr+ZBkNazqpVRaw8WBPMrheopdX0fVs0I27C0s
         77/6Cr4BMCLp3I8fGHn/Y0Ds+iQYgbksgf7vxt/VihFNjyAUrFT2phtoGqBVMf3ttBbx
         Qig99z7P0wbNPVokEXDMMaSkruV48MJhfX48IS9diaCZnhUZtJKOiowrSa+GTHmP+Pe9
         DpsvUE8m3y7i8+zERSlECH1pXXE+bv2p6syABlBAdCWBxjToQQFLHPLJJrzNvr7sbNGI
         Rds82zgYt5PB4ujG4g0/E6ewguZsQPk3ICa5+qGYC4tOGc7kIIAFUDhzP1K3Dk31Ps8v
         eZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1XI5MijFbdUoBwKKN+708JO/+ViWWFaqhxvrhFYXz1E=;
        b=m1iUvxM7rdNoeWUX6Sa60Au5vgIgmywjD9Om412H9DOYKuRYy2l5Tk2OEwuGdzJzWL
         lpxgMf77snnVP+Jj3ZC+m6TSiUf2wjjXAiXHIO/vgBwQ/NocEsfdPlg2XIH/RvK3vdT2
         ggVbGU91TewEJZigVS1cuVZZBR8hwW0f7doo8BHoxQtLe8pJ7T3pTDrdVz188+qq3Uwe
         pi3K0osXsXuBq3l1iegV2VCv4YPF/kdO1KMMniAuqXJhMhyeUED7C/2t8FGZZwYb2R2t
         XACFYmxPeoLZ724VzWbLGU5sOJybZ+iGv/JY8/HSDhmZOWr7H3CBHDinW4tVYdStgeJZ
         HnsA==
X-Gm-Message-State: APjAAAWyfv9F7FvVBanrhgcmp3NXAP50yJ+zKmShloiVnelQAWFS/Km2
        lqIArbIUg8VwNUZvBdVFm1K1kA==
X-Google-Smtp-Source: APXvYqwPUXEl3h+uAAGR/BGOtDNIU7i//AxJUi0RpTo/Do4l1/ZasygoOYI2/kd2Vtj+yOyGDjwfTQ==
X-Received: by 2002:ac8:19e5:: with SMTP id s34mr4977531qtk.385.1555706455322;
        Fri, 19 Apr 2019 13:40:55 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y34sm3737526qta.96.2019.04.19.13.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 13:40:55 -0700 (PDT)
Date:   Fri, 19 Apr 2019 13:40:51 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 02/15] bpf: mark lo32 writes that should be
 zero extended into hi32
Message-ID: <20190419134051.71eeea08@cakuba.netronome.com>
In-Reply-To: <20190418235747.jv4yocuf6fgwahli@ast-mbp.dhcp.thefacebook.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
        <1555349185-12508-3-git-send-email-jiong.wang@netronome.com>
        <20190418235747.jv4yocuf6fgwahli@ast-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 18 Apr 2019 16:57:50 -0700, Alexei Starovoitov wrote:
> > @@ -6371,8 +6406,10 @@ static int propagate_liveness(struct bpf_verifier_env *env,
> >  		for (i = frame < vstate->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++) {
> >  			err = propagate_liveness_reg(env, &state_reg[i],
> >  						     &parent_reg[i]);
> > -			if (err)
> > +			if (err < 0)
> >  				return err;
> > +			if (err & REG_LIVE_READ64)
> > +				mark_insn_zext(env, &parent_reg[i]);  
> 
> I'm not quite following why it's parent_reg here instead of state_reg.

Perhaps we should rename the parameters to something else than parent
here?  I always have to do some mental gymnastics looking at this code..
"explored" and "current"?

The current state is parent, the "next" state that pruned the search
is "state".  So we check if the reads under state X need 64bit, if so
have to propagate back to writes on current (which is called parent
here, even though it won't become state's parent, ugh.)

> If I understood the code the liveness can have all three states:
> REG_LIVE_READ64 | REG_LIVE_READ32
> REG_LIVE_READ64
> REG_LIVE_READ32
> whereas 2 is a superset of 3, so 1 should never be seen.
> 
> If so, why in propagate_liveness we have this dance:
> +       u8 parent_bits = parent_reg->live & REG_LIVE_READ;
> +       u8 bits = reg->live & REG_LIVE_READ;
> +       u8 bits_diff = parent_bits ^ bits;
> +       u8 bits_prop = bits_diff & bits;
>         int err;
> 
> -       if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
> +       /* No diff bit comes from "reg". */
> +       if (!bits_prop)
> 
> I'm struggling to see through all 3 combinations in respect to above diff.
> Shouldn't propagation of REG_LIVE_READ64 remove REG_LIVE_READ32 bit
> and clear subreg_def during mark_reg_read() instead of
> once in propagate_liveness() ?

This reminds me, I'm not entirely clear on the need to propagate the
zext through stack slots...  Pointers are guaranteed to be 64bit, we
don't save parentage on scalars (AFAICT), why not pass REG_LIVE_READ
or READ64 to mark_reg_read() from stack_read?
