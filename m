Return-Path: <SRS0=OafG=EP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34EEC388F9
	for <bpf@archiver.kernel.org>; Mon,  9 Nov 2020 03:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60753206B6
	for <bpf@archiver.kernel.org>; Mon,  9 Nov 2020 03:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u38Pt2jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgKIDA1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 8 Nov 2020 22:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIDA0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Nov 2020 22:00:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5326C0613CF;
        Sun,  8 Nov 2020 19:00:26 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id i13so1016335pgm.9;
        Sun, 08 Nov 2020 19:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mAbqxyuutoMjA+7129crcN75xwRzKnibiiTAUcnQOzk=;
        b=u38Pt2jo5tPRF3T2JCgr28fzIvV45jyXmJ/lUgX8miqoklE75PNfSs/TiZrl5GffZ2
         IICjBz4OuZQwPil+aMcxJyXq/XUBUxVVB4n4VlJuKBWOGBQZUZo10soMHfe4csvOKIY6
         J36wkDDF4M7N9X8mZArZiWK47uL/GJyEtBaMC1ju/IkwfAA6GRCFZ21WjlG8TYn3eNcn
         Itijx2D5W4PIdDo6x2glwH2s+hspbovfAut8xv5I2RFab3VGdyiKHW3LZK5NucJqnIRz
         V4IdmKBNM3LnpBgBF+rVh4stT0+FlDvjaGMBZ1TQ3PipDYPYx1HDMfBlTcnZhCGMFj/W
         ye4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mAbqxyuutoMjA+7129crcN75xwRzKnibiiTAUcnQOzk=;
        b=otSbnZ3Z39HKqYbam3Hl4KqbjfDPiXUb9J/QzUmUJeOzBSl9i4cZX2Cc9pySTSpTNL
         YmHFiGozmdE2tkV5JI1xpbsIW9a0j7/D262dhyJGC+7cYBiPu8PpGlTgG5U5zI6+GM1c
         9MPc6gbW6HBflQDxpLClUe8z33aLkuSrx/+/7Kx43H520kia25+KYWUIKSgVoEYgfUdD
         sPMEUlDORTL3HKHU3Hmzj1msDiZyrkD1aLBEAAxnxh5M22eFJ3X8IRDZxdfDZhON3Z0Y
         Wr50j3yXx1oE0QijHWLHUSz/RtfuyA9ypVoNGd58de+hA4PBgih7SJ8jgnnr/Cnujh+v
         uy5A==
X-Gm-Message-State: AOAM531kE1c3SO8YEM5mTACYp0SV+oUaYvNBw7ycBymo44aCADnl6/Ll
        WOw6npU66N2gEw28r43UOuE=
X-Google-Smtp-Source: ABdhPJzVZOmpdkENE8jGy0wvLKk6WnILpdYmTUh3klfMNSUmEpwQ/uESS65FXewb+75qI1GJ+fhaWg==
X-Received: by 2002:a65:4945:: with SMTP id q5mr10517634pgs.83.1604890826102;
        Sun, 08 Nov 2020 19:00:26 -0800 (PST)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t26sm9936094pfl.72.2020.11.08.19.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 19:00:25 -0800 (PST)
Date:   Mon, 9 Nov 2020 11:00:15 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, William Tu <u9012063@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCHv2 net 1/2] selftest/bpf: add missed ip6ip6 test back
Message-ID: <20201109030015.GW2531@dhcp-12-153.nay.redhat.com>
References: <20201103042908.2825734-1-liuhangbin@gmail.com>
 <20201106090117.3755588-1-liuhangbin@gmail.com>
 <20201106090117.3755588-2-liuhangbin@gmail.com>
 <20201107021544.tajvaxcxnc3pmppe@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107021544.tajvaxcxnc3pmppe@kafai-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 06, 2020 at 06:15:44PM -0800, Martin KaFai Lau wrote:
> > -	if (iph->nexthdr == 58 /* NEXTHDR_ICMP */) {
> Same here. Can this check be kept?

Hi Martin,

I'm OK to keep the checking, then what about _ipip6_set_tunnel()? It also
doesn't have the ICMP checking.

Thanks
Hangbin
