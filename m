Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2253C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 03:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7D4218AC
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 03:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nviTUO2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCUD1T (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:27:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45904 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfCUD1S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 23:27:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so3361594pfm.12;
        Wed, 20 Mar 2019 20:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I+4xUEA9CCoeNdyRVaBxXKOnawVI/sRmIEm1GsiNLLk=;
        b=nviTUO2A3Abl6etcpGhk5j54PDTORjkT26Kqy5tfji0Yst6QC27Lz7dqQJXTtnx1mp
         FoV/cyW7cb6GxVStJwaGmh7e+bAmm52tSCnFjbluMaQi1LT/22TI99LY4zsBUgPS8A/2
         cMPZZUZffgu4CtQxs95vv6QgeGEspY6ykg+g8qyoJwk8Zbj+y/TjCahXU/BGKvAleBpK
         9D5DQ/UjU2tx/Z6bY74Z2gLbWynMTovgmJ/t8WickIhNQGdrDXyShyIqsHrbFyl/RqsK
         Fodbz80aOFnyxbS0VC9x020YEMVPnVEJxhS3TFkkLfFGOfMKQw756n11sGRMe/RyPUSf
         NFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I+4xUEA9CCoeNdyRVaBxXKOnawVI/sRmIEm1GsiNLLk=;
        b=TJCqeZ6SDQ0+cD0s9+rNuVZa+6pBnvSewK0SoM6xthiAcUN8Os3YmsSok0CSzBvNBQ
         P6gilq8f2x6UalWOpYOqB7WTpuhXUldl/5Gckt8YFuGwBmwP7uqtE7P7FZm4KMGiJN7E
         XnMr1sniZXYvDm6SvSVPXe08/btq0+jXa4S7D9eFdPwUWrUaHa90aB4V3640josnTC38
         lSdrNzzdxuQ5+FAfBogEnvNcb6ngKMeJSglEMTH/oKWOZr5eO08n1s4Nr1fnJ9zHPCGX
         pWTZcTYzc68587eYqmqho4eb7wNSqlwU/TEYhbeQOuUJDP9iIOLwgPJZViQKVInOZv3J
         RO6w==
X-Gm-Message-State: APjAAAUxPaX5VXEIVIa5qJYJAO5v4onjyUgmffn7Gqcnlrj6INCIWtgS
        b565UmIjK7fXlvWLMRnLCJI=
X-Google-Smtp-Source: APXvYqxZDa73O3lOgG5u1Q/dlhD9ItqwWfUB/fgDPPaAA5U1LWt/zthsE3/M1kFWYxRfaFtmGf5ApQ==
X-Received: by 2002:a63:4e4e:: with SMTP id o14mr1382118pgl.254.1553138837962;
        Wed, 20 Mar 2019 20:27:17 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::c891])
        by smtp.gmail.com with ESMTPSA id u15sm5512230pfm.163.2019.03.20.20.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 20:27:17 -0700 (PDT)
Date:   Wed, 20 Mar 2019 20:27:15 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lawrence Brakmo <brakmo@fb.com>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH bpf-next] bpf: make bpf_skb_ecn_set_ce callable from
 BPF_PROG_TYPE_SCHED_ACT
Message-ID: <20190321032714.7cnzxmuqb3jhu4zr@ast-mbp.dhcp.thefacebook.com>
References: <20190320070640.102721-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320070640.102721-1-posk@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 20, 2019 at 12:06:40AM -0700, Peter Oskolkov wrote:
> This helper is useful if a bpf tc filter sets skb->tstamp.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 647c63a7b25b..c6d016d9c4b8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5719,6 +5719,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_tcp_sock_proto;
>  	case BPF_FUNC_get_listener_sock:
>  		return &bpf_get_listener_sock_proto;
> +	case BPF_FUNC_skb_ecn_set_ce:
> +		return &bpf_skb_ecn_set_ce_proto;

makes sense, but I would like to see a selftest that it was tested properly.

