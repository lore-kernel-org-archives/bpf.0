Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12289C10F11
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 02:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E7C217D9
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 02:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="sSqZtiNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfDKCwY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:52:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35061 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKCwY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 22:52:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so5468521qte.2
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 19:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=l/7NFFlvqjaEahN3kp1cIZPpsXeFPj99mdIzt9Ul1SU=;
        b=sSqZtiNHUcW1jqBT8dq1mwatmXdMljeTEokVwEAJIIS7UKdAJEn59NNoP/x9YlRjco
         jUyPap0NPAzpXg4VHoQiR+QJomPHnnOriBpah0wYGhrj7QBQad/kOPrHWkW5OMAYh3a+
         gtJH5xcgbwgXzE+wRdUGwGWIRy62FtYzeNxab35l6kOF/a0gKqpZV4Gjj8+QWzE19xIG
         ktap7bu1jVw9uTir8/bVbc0aO/CqRJTfQcQDIznhWUS0etxz41SdqABQ+UPdOnS4B2Xv
         gHxLzW8M6SOM3PuN2ApgCyFydYDzCSJXeJKS36QwoEjF9ZyhJlfKSIwwlPLcnV2Pnp2m
         mQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=l/7NFFlvqjaEahN3kp1cIZPpsXeFPj99mdIzt9Ul1SU=;
        b=cYeGO9tR4BMgq2iADvzH5xPCH1C4c2GXqAgnE6WvDbxAaAjl2Jg1mcC5zBXH9ShJ5k
         nypfrkx8zn5lU6isFB7X9IhyIE0e7To9vipiM0/n1IIy7aQkpBqMgEcn4hmqXav7gXu/
         VBzxbTRN7oMO4hMzKt7HFZ8gxTr7kt2gVA6xcGfMbbBV9cTG+8c9hskqI8QSKGn/hCrj
         rcbjmH0TEaghCv3vDaedwc2HSRHL/+NnNC74CybgV9AuSV9d5GGYHJajDpXzXD0tq7Bv
         01L88Rq3WqUaHRzJ/j9m478pdttiirNECqKN8FYNwKB3ACE/4c99n4ddwbyyI1/YeKXG
         TZ8A==
X-Gm-Message-State: APjAAAX20XBaaX2tLFj8FYjvHTdz9g86cvQoJkbVKOAgdqgYslm1ek66
        /XqaTi/H29UVdjrMLNFL8myoKQ==
X-Google-Smtp-Source: APXvYqxc6ki4kQqFCn0fyQEj1gheKJqcYZIXEH1jHmUjWDxygrGAIL8F1+U/T9pB6kk7J8g2TqXyRw==
X-Received: by 2002:ac8:7607:: with SMTP id t7mr37410072qtq.28.1554951142549;
        Wed, 10 Apr 2019 19:52:22 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s17sm23896287qtc.15.2019.04.10.19.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 19:52:22 -0700 (PDT)
Date:   Wed, 10 Apr 2019 19:52:18 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC v2 bpf-next 05/19] bpf: split read liveness into
 REG_LIVE_READ64 and REG_LIVE_READ32
Message-ID: <20190410195218.303d4a6c@cakuba.netronome.com>
In-Reply-To: <1554925833-7333-6-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
        <1554925833-7333-6-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 20:50:19 +0100, Jiong Wang wrote:
> Register liveness infrastructure doesn't track register read width at the
> moment, while the width information will be needed for the later 32-bit
> safety analysis pass.
> 
> This patch take the first step to split read liveness into REG_LIVE_READ64
> and REG_LIVE_READ32.
> 
> Liveness propagation code are updated accordingly. They are taught to
> understand how to propagate REG_LIVE_READ64 and REG_LIVE_READ32 at the same
> propagation iteration. For example, "mark_reg_read" now propagate "flags"
> which could be multiple read bits instead of the single REG_LIVE_READ64.
> 
> A write still screen off all width of reads.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  include/linux/bpf_verifier.h |   8 +--
>  kernel/bpf/verifier.c        | 119 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 113 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b3ab61f..fba0ebb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -36,9 +36,11 @@
>   */
>  enum bpf_reg_liveness {
>  	REG_LIVE_NONE = 0, /* reg hasn't been read or written this branch */
> -	REG_LIVE_READ, /* reg was read, so we're sensitive to initial value */
> -	REG_LIVE_WRITTEN, /* reg was written first, screening off later reads */
> -	REG_LIVE_DONE = 4, /* liveness won't be updating this register anymore */
> +	REG_LIVE_READ32 = 0x1, /* reg was read, so we're sensitive to initial value */
> +	REG_LIVE_READ64 = 0x2, /* likewise, but full 64-bit content matters */
> +	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
> +	REG_LIVE_WRITTEN = 0x4, /* reg was written first, screening off later reads */
> +	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
>  };
>  
>  struct bpf_reg_state {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bd30a65..44e4278 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1135,7 +1135,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>   */
>  static int mark_reg_read(struct bpf_verifier_env *env,
>  			 const struct bpf_reg_state *state,
> -			 struct bpf_reg_state *parent)
> +			 struct bpf_reg_state *parent, u8 flags)
>  {
>  	bool writes = parent == state->parent; /* Observe write marks */
>  	int cnt = 0;
> @@ -1150,17 +1150,17 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>  				parent->var_off.value, parent->off);
>  			return -EFAULT;
>  		}
> -		if (parent->live & REG_LIVE_READ)
> +		if ((parent->live & REG_LIVE_READ) == flags)
>  			/* The parentage chain never changes and
> -			 * this parent was already marked as LIVE_READ.
> +			 * this parent was already marked with all read bits.

Do we have to propagate all read bits?  Read64 is strictly stronger
than read32, as long as read64 is set on the parent we should be good?

>  			 * There is no need to keep walking the chain again and
> -			 * keep re-marking all parents as LIVE_READ.
> +			 * keep re-marking all parents with reads bits in flags.
>  			 * This case happens when the same register is read
>  			 * multiple times without writes into it in-between.
>  			 */
>  			break;
>  		/* ... then we depend on parent's value */
> -		parent->live |= REG_LIVE_READ;
> +		parent->live |= flags;
>  		state = parent;
>  		parent = state->parent;
>  		writes = true;

> @@ -6196,12 +6286,19 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
>  				  struct bpf_reg_state *reg,
>  				  struct bpf_reg_state *parent_reg)
>  {
> +	u8 parent_bits = parent_reg->live & REG_LIVE_READ;
> +	u8 bits = reg->live & REG_LIVE_READ;
> +	u8 bits_diff = parent_bits ^ bits;
> +	u8 bits_prop = bits_diff & bits;
>  	int err;
>  
> -	if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
> +	/* "reg" and "parent_reg" has the same read bits, or the bit doesn't
> +	 * belong to "reg".
> +	 */
> +	if (!bits_diff || !bits_prop)

bits_prop is a subset of bits_diff, no?  !bits_prop is always true
if !bits_diff is true, no need to check both.

>  		return 0;
> 
> -	err = mark_reg_read(env, reg, parent_reg);
> +	err = mark_reg_read(env, reg, parent_reg, bits_prop);
>  	if (err)
>  		return err;
>  

