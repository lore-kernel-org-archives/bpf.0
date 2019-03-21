Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A0C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 01:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017B5218C3
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 01:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9rtkdHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCUB3B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:29:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33067 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCUB3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 21:29:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so3210817pfd.0;
        Wed, 20 Mar 2019 18:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xn7Xyru/wrNcYccez0gym0vrFFjgXTngubOrPZgTvWc=;
        b=D9rtkdHdbh/CfjqkfCsBnc2R05LK6qQ0LoX0+kRNaR6EIrb8YEL6wfCt2RcITfXxYQ
         bcWLRmkXbMKfkHrAd8uU74mT8lGo1l6o0MM4VCwAzXthhPTQWiI5BLWBlZDL2y9RGU+B
         /zw0Lb+w6dvmLaOYtzQ0Bv3QLeF2GVuOr3EXfdpY8wZb0lhsWH9S37p0f++kMDKz2+0C
         CFnmFmc3+Qz/sWC7+0opU2B50XLz9+C2uurx4OnHYrpDL9ud5013tyMwFc1NKR+ncqay
         TZz0RndahArP0oYO0qWZ6nDz2bJhUfKg/HZNPZW15esoosktafX5gkwGvO5XI5AuKtLb
         R7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xn7Xyru/wrNcYccez0gym0vrFFjgXTngubOrPZgTvWc=;
        b=E6q7/UK26oBpChhQijI/jZJl4Io0uJC2/oMzGvS1AP+7anK1fdvT1aLh3raPEClYoz
         7Z79cfYPvieOi83LDbCsh3iNQ7CVmIG1jGDE7+p2T2BquSVTml5owBqkm6RHuVM/wWuH
         JMql2y/baQbS8ppF7LGeD9zHdwinaz3h0+7cB24egjpyrxKjSoJozXfNKWcoF7/jNAc3
         IUvKLrknKTO/C1t3FrC9bYBPs87phmBIKtYBR7Au/LA8mMuZCkjhAkg8pJfWIUkLWFB2
         5rDcUkJ4qBG7XKW47oVZtNjXxK0xgNr/ha0VMmntJgT3wwe0+zmvfM2lr5riYT4t5sRU
         ovOQ==
X-Gm-Message-State: APjAAAW66ljezie6m4QLRzG55LmzEoP/mNvyswc+du1GB5Cuqs8QEVcU
        6YXIqdB3Rng+Hea6CCGF2EY=
X-Google-Smtp-Source: APXvYqzyhO6/ixYjNxGShp43fI2gMf+9c2B8p5AlOL3Ma2wMuRUJSC0qB4CPKzRhWrdLZEL0Wm3Z6g==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr902533plo.52.1553131740741;
        Wed, 20 Mar 2019 18:29:00 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::c891])
        by smtp.gmail.com with ESMTPSA id a2sm3976885pff.58.2019.03.20.18.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 18:28:59 -0700 (PDT)
Date:   Wed, 20 Mar 2019 18:28:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH bpf] bpf: Only print ref_obj_id for refcounted reg
Message-ID: <20190321012857.r4ojy3hkguzfubvo@ast-mbp.dhcp.thefacebook.com>
References: <20190318173713.1413282-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318173713.1413282-1-kafai@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 18, 2019 at 10:37:13AM -0700, Martin KaFai Lau wrote:
> Naresh reported that test_align fails because of the mismatch at the
> verbose printout of the register states.  The reason is due to the newly
> added ref_obj_id.
> 
> ref_obj_id is only useful for refcounted reg.  Thus, this patch fixes it
> by only printing ref_obj_id for refcounted reg.  While at it, it also uses
> comma instead of space to separate between "id" and "ref_obj_id".
> 
> Fixes: 1b986589680a ("bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue related to bpf_sk_release")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Applied, Thanks

