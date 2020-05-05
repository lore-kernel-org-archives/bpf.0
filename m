Return-Path: <SRS0=Qn19=6T=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D1C47256
	for <bpf@archiver.kernel.org>; Tue,  5 May 2020 09:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B573720721
	for <bpf@archiver.kernel.org>; Tue,  5 May 2020 09:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="thMnOyiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgEEJaT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 May 2020 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEJaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 May 2020 05:30:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5368C061A0F
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 02:30:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so1828994wro.12
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Bya+NTSIs6K7NSmY4ktKq4dWPLC0X3o+d74CxBau3qU=;
        b=thMnOyiVBWdp2xjMXqfsZbnh0jFuAZJinEN4NrNHiYASVJZvvO8k7wz0+vZyOW7fNk
         aOoTIvrUfw3hoaI70+iXYGJ2LzuEWZsgk4fJ94SMuUVy9V1FK513V6KpmSa9bVTtULcy
         PtMQZq9EHz93PuHgnO3TnWhVURj8EoOSQMSiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Bya+NTSIs6K7NSmY4ktKq4dWPLC0X3o+d74CxBau3qU=;
        b=gITMKzeDKPU3f01sfcdhSq1k2IywigZMK5G7nmbiXf9twIdQPw5nN6Q9CDQURrAnz6
         ljszxWvOekUU3pSpyeIeBJvKxulm+wYHmYGDUwREs78zkj9JN5fMWo1z5rABAuzi6A36
         EqydnVzCUURu5uPKUDtSOpmSCRsAxR4cspVszU2HMb2S+xX6sGXvIgw+hVR8E2nL0w+T
         hOBvS4YvP+LtuYMUY+E5TuOf13YFDl0wVzai2CulUWxVvfP50kCQ2f53mlEfXkrskxTj
         /SP97TkDbW+u+SBgGUkUWgE5XO1XX0kRVRK3OTnOH6MTh1L7NccUkbpJBp/sinj6gfXW
         yoUw==
X-Gm-Message-State: AGi0PubJ9B7UWutX2rS656wrf8/bWcg9NGh/8U8jxn1Xh/xwlWaViKYa
        +zMKk12T5jSvimDFP0ZBt4cwkw==
X-Google-Smtp-Source: APiQypJHzrGi6UPSlT5gFHZbBbg9tNHDDWBz80cjzTa/xce3Ok+BffT47xJw+8iY2hmwoWcGdvkmEg==
X-Received: by 2002:adf:f684:: with SMTP id v4mr2599388wrp.218.1588671016351;
        Tue, 05 May 2020 02:30:16 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id u7sm3090065wmg.41.2020.05.05.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:30:15 -0700 (PDT)
References: <158861271707.14306.15853815339036099229.stgit@john-Precision-5820-Tower>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org
Subject: Re: [PATCH 0/2] sockmap, fix for some error paths with helpers
In-reply-to: <158861271707.14306.15853815339036099229.stgit@john-Precision-5820-Tower>
Date:   Tue, 05 May 2020 11:30:14 +0200
Message-ID: <87ftcevie1.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 04, 2020 at 07:21 PM CEST, John Fastabend wrote:
> In these two cases sk_msg layout was getting confused with some helper
> sequences.
>
> I found these while cleaning up test_sockmap to do a better job covering
> the different scenarios. Those patches will go to bpf-next and include
> tests that cover these two cases.
>
> ---
>
> John Fastabend (2):
>       bpf: sockmap, msg_pop_data can incorrecty set an sge length
>       bpf: sockmap, bpf_tcp_ingress needs to subtract bytes from sg.size

Both of these LGTM. Looking forward to revamped test_sockmap.

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
