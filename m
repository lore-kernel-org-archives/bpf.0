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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0912C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D352087C
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 15:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL5JKfU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfC0PoP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:44:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34982 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfC0PoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 11:44:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id p19so3501851plo.2;
        Wed, 27 Mar 2019 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QTwBodjDbe+gO9iqCwNKADSLIIMSRb1ne/kP/6gw4CM=;
        b=ZL5JKfU8XVxz7UTu6vLkNQnTXIWpY2/TY6j7eBMkshj0jrX8dlHKnSxrZWp4izdxZE
         jmZZarDpDbsW4vk7dtubASXQV4+WUPY6K1d8KGUEiUAVq3SqIWp1V8oSC77AFdV3zhaE
         2T9aKPeUhcClatJ9LjLmK3A98gORMxdfHQ9pU0fWdt5J8g9U0FtdwI3B15r53+yen3ho
         FNuDl4EMCCuXvR0DSpa/DIBjy4uiOq6TfrvvwqSBxEpkFK4Q1oRwfw0mHpnvwXr5Mmr3
         Hjp5EgoiHt9IUJxt1cOktDv+rHDhJ2i/5hP30ReGrQKwgLjMXBQJT5IFfKo8cVMNiTVr
         FBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QTwBodjDbe+gO9iqCwNKADSLIIMSRb1ne/kP/6gw4CM=;
        b=l4wJWVm0r9z1Gs0O1gwIxjnhsdUdPu5H8VPOswZ0SqpFlmIUeqh66IDXlkc0Llv90s
         eFcEELrBDMw9o+OA7mCC7ijNUJkGNog7HVXLamEM4PIgFbX4siPVYXVO5ze0NdY+iqKx
         CIshVTgUjdeyMyPXiS/qvbC3ghHLo2isYuCZg5qx8hp7b22oB49liKqOBTZaKZgnmxo8
         xh58llCtTUK0qMMbpFIPUd+FxP5QI2ZYN/FCc+eR2dtnSChvosMGBhrCnx/45AoQbaS0
         swxxWIH5yPFb2jXzVTU+f0X75miejPohcjlXWIkXFoRvHqojQaLkkUat9lo7XLeRWHnW
         nvLg==
X-Gm-Message-State: APjAAAU54dJHHxf2GKDE4fhBna4P+MTNaIm6FZSclWxQ24THAFB550m1
        Lh/SatLycLByHTP4xS8HWdI=
X-Google-Smtp-Source: APXvYqz0idH5JSyZSVEMFhOMD2tr/hvzqjpSqqKc1s5Gjvz9ODZjWVHIwbo6YQ/TDZ2V/w0UZeqzrw==
X-Received: by 2002:a17:902:8d93:: with SMTP id v19mr37914370plo.271.1553701454765;
        Wed, 27 Mar 2019 08:44:14 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::ca40])
        by smtp.gmail.com with ESMTPSA id 138sm45890510pfz.18.2019.03.27.08.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 08:44:13 -0700 (PDT)
Date:   Wed, 27 Mar 2019 08:44:12 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 01/16] bpf: turn "enum bpf_reg_liveness"
 into bit representation
Message-ID: <20190327154410.zpeeal6nh6qbvg7f@ast-mbp>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-2-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553623539-15474-2-git-send-email-jiong.wang@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 06:05:24PM +0000, Jiong Wang wrote:
> "enum bpf_reg_liveness" is actually used as bit instead of integer. For
> example:
> 
>         if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN | REG_LIVE_DONE))
> 
> Using enum to represent bit is error prone, better to use explicit bit
> macros.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  include/linux/bpf_verifier.h | 16 +++++++++-------
>  kernel/bpf/verifier.c        |  5 ++---
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7d8228d..f03c86a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -34,12 +34,14 @@
>   * but of the link between it and its parent.  See mark_reg_read() and
>   * mark_stack_slot_read() in kernel/bpf/verifier.c.
>   */
> -enum bpf_reg_liveness {
> -	REG_LIVE_NONE = 0, /* reg hasn't been read or written this branch */
> -	REG_LIVE_READ, /* reg was read, so we're sensitive to initial value */
> -	REG_LIVE_WRITTEN, /* reg was written first, screening off later reads */
> -	REG_LIVE_DONE = 4, /* liveness won't be updating this register anymore */
> -};

yes. it is enum that is used as a bitfield, but I prefer to keep it as enum
because clang -Wassign-enum can do at least some type checking.
I also find it easier to review the code when it has
'enum bpf_reg_liveness' instead of 'u8'

