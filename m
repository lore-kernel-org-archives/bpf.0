Return-Path: <SRS0=1cax=SP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A3C10F0E
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 00:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A979520869
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 00:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcuBxPnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDMAMq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:12:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41306 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfDMAMq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 20:12:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so5914882pgs.8;
        Fri, 12 Apr 2019 17:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ODDCw3aFwIP752Xr2LuKUG87VPJm2qyWdyT5hNEK1g=;
        b=IcuBxPnhA6eBQReGujFm25NCFLxmjuK6DTFawTfzY0dv/jaaYQOdhZm/CtzzTafpnE
         VDJmjRccttwErWjlM7n7Oz5yeoyz39DjUDSEdW8Mqo1gY+7ap2do+iH5W13OVVUJ/Syt
         0Pk+cm19RAdFvaa83yutg2y9B0k6GJXChB6C9ASa2KpecnkptGXDS7mSZDTpuTYY3mz4
         mabzkb3HMVE+CKwvay/zAwkzdeTb3IyPxr+uaUYOHLtmPce/LULBT/5oIZD6tAmL9Sio
         1M37Ge9rRdvac4aFoEb6cCsdyocY1VpuIa50YgtTVUv7e6d+oh6OehoyrpGe6SjmOO6F
         bG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ODDCw3aFwIP752Xr2LuKUG87VPJm2qyWdyT5hNEK1g=;
        b=ci5M/c5R2IPxlmHx4bcWpod+YhChnJX+aG+kYQIuZ9yrlNka6KHkQHlPtVr4yrevZr
         v3sLK0Ilcn4oz9aaQB2RK40xnsZSXVbDypbhmXEbdz82w6S/zWJfKB1Bai/yrNjBn/IA
         PaP5iNS5cXiE7Tt7X9HtG4kuCihvguugNxQ5Emd9rJkG+JHG1/o7MhZPr1a202/U1lng
         yAEvwSMDcNxUp3gm5yAkf8xy159LwmAu8mdZyz1UdjK787vZ5HLV5y0A6RQPtLZqUHEE
         epB/e6nzhQB5EHiiSUWY50YYR5uleNbWz/DSADChPt4sr7Gye61iIKf0bDvMH/xk4xXv
         8pNA==
X-Gm-Message-State: APjAAAUDuhXIjmwh3JwkW+f1JUyYmhXTtf7kviAa7/AmvkgxF+txQHf+
        NFub0+zKMovcj5Gkqiyb4lfDSHe4
X-Google-Smtp-Source: APXvYqw4vzjJkuhlOlbEvT2ib/yeZP3to24Vz1bnFqwULRG2ZThcIkg25vdSnSV5paRYAxg4/mGE4g==
X-Received: by 2002:a63:5ec2:: with SMTP id s185mr57200972pgb.27.1555114365181;
        Fri, 12 Apr 2019 17:12:45 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:e505])
        by smtp.gmail.com with ESMTPSA id x16sm96363922pge.27.2019.04.12.17.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 17:12:44 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:12:43 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v3 bpf-next 04/19] bpf: refactor "check_reg_arg" to
 eliminate code redundancy
Message-ID: <20190413001241.fiuiyd64l7vuntz5@ast-mbp.dhcp.thefacebook.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
 <1555106392-20117-5-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555106392-20117-5-git-send-email-jiong.wang@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 12, 2019 at 10:59:37PM +0100, Jiong Wang wrote:
> There are a few "regs[regno]" here are there across "check_reg_arg", this
> patch factor it out into a simple "reg" pointer. The intention is to
> simplify code indentation and make the later patches in this set look
> cleaner.
> 
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>

The first 4 patches look great, so I've applied them to bpf-next.

The rest needs more careful review that we'll do soon.

