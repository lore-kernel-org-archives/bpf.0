Return-Path: <SRS0=ocPE=4W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB83C3F2D1
	for <bpf@archiver.kernel.org>; Thu,  5 Mar 2020 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46BC208C3
	for <bpf@archiver.kernel.org>; Thu,  5 Mar 2020 12:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GIH9MsCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgCEMD6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:03:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35704 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCEMD6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 07:03:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id r7so6712063wro.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=hT7S6vvpnxA0ApcPEejqGxLVzm717a4KSHt7eOw1Bck=;
        b=GIH9MsCPmG16v2K7zrrevmV3g6eLk1wIcKUD9XnRWZuoOJXK1GkdfQGkFYZ928xMmM
         Y3PnJAK/ssHCHqBUqfr96FgMu1N8MTdKO8DxCL5bgs/ODGHWiEnA4ZrWrxCmnB0Qk4kj
         5csGyslb48TLPEaGgGdrIKegAW9qV+4WV2Iu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=hT7S6vvpnxA0ApcPEejqGxLVzm717a4KSHt7eOw1Bck=;
        b=VAbLouCs+7VUmF0y6uyIRV0vqdrG+QqXe18jrlZMRo8AqgGAHAYhkUxIaOrPiXR1tw
         FZZ+wFbxpq0G3qvGIjWP9DuWutBcVDDAVEaZvd9UKvZP/iyvwubOjAEnx/dGPWQyTcNB
         q5TDMSGZsCEJLO86S1ZtTJg63XtpyQgK2Irmmv1gT+Dmkf1WLfkGK7kImQVk5rsjqZNk
         1FyAhQjIv48WGfstnTHxRbl6LRhS7Hbe002oOBU0M9FqwhaVlqLZo0UMOJvHtVcxdsCk
         kbBzcHidobHFkDL45QzQkePNC+HoqUfZA3qOUdRiMiHTLXSs/4P9mHWHJvAF8ttfPBZc
         HejA==
X-Gm-Message-State: ANhLgQ0ZTMm1AMnJzLsjkHY/ygmLRFwrKS36AGY4OfK/Tpy0vOo1/PVQ
        JLEuRE5n53q/llNmeN9klKlpgQ==
X-Google-Smtp-Source: ADFU+vucLtTgYNewten9hKmRyZyvNiBAi0eWwE91eSAbKxv50uEY0RkR+AYp55iwZRNYjSqE2Bq4mg==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr9660460wrv.318.1583409836025;
        Thu, 05 Mar 2020 04:03:56 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id b186sm9170588wmb.40.2020.03.05.04.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:03:54 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-3-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 02/12] skmsg: update saved hooks only once
In-reply-to: <20200304101318.5225-3-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:03:53 +0100
Message-ID: <87ftenypna.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Only update psock->saved_* if psock->sk_proto has not been initialized
> yet. This allows us to get rid of tcp_bpf_reinit_sk_prot.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
