Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D06BC282E0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40CA2171F
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="OfMUaEXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfDSX1J (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:27:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38045 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDSX1J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 19:27:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id f14so7883605wrj.5
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=i6MtmAvs1Kx2IvlYguMR2zxJxkxHhcGCcD02j7nA/Ns=;
        b=OfMUaEXWTVBzO+wEV1LHXvI3oB5gIqk6Kdo/kOHiBxUe/+BTJYcZdzgrmDiWqDExxI
         BvE1bkAMlR6JDlw/vanz+KdCamCuKu/8KIle9UObpKGMj8MRScoJtu8jgdiqYrMnJtnX
         pqPWK3+SZzPWZF0U4EU4OMENu1HHUCjyHu2Rz1QU5c0DZtWWgL3/MQFZYqp2r1NrXTtr
         pw8jBN4KlnjGGBYZ5alJK0LxKf3ZPttQZzOydVW9xRu+h4cY7btRV7OMacda9EHq8V+s
         TpaMBJ7bD80VcdY95tH11AANxbpD/xdmKCojY+HasvZ8p/C5j7XOlyDWodUQe6u0jY1H
         6FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=i6MtmAvs1Kx2IvlYguMR2zxJxkxHhcGCcD02j7nA/Ns=;
        b=qGRh4Ikf9Li4NYC6fQda9GbLys2RGl+j2f3/2lg7qkpztDIT3lUVVDZyoZkoFBxbAU
         8ApNW/y9RIS2hOApFE4NBZmPr7ifspGN4jOtBUcMPj/1KxboncoV3wApmVTrwU/Kj24T
         zecjAGAM8TwGUNrYC5xlGWuMPa22SbBsJTgx39RB6A3xp+j9K+reCF/BtV/zt0oFcy0P
         cMQNl8Hj4ld6oIp0gXQpyN1oSY6VdkBRjWxxQAuGJZSpqX9w/I2vQzwA0qmoOkpZXjuR
         n765zCD8Z/dkeeRHA3liaY4Z4OhiBm/0mJDeda49fDZ3G/XqFPQdvzwGrvK9ZJCBguWa
         LygA==
X-Gm-Message-State: APjAAAX4yRZJY1at23ReFt7WckFSR0NOwNS7/Uq8RbSCaetoxbQvx4Wp
        SqjQzK3Bfz+u7+W4H1FBvHlZCA==
X-Google-Smtp-Source: APXvYqzSkCyhV5Xm1TwtGOgo5wMHnz27IjgHBFZgPKJqgKzbfB/BDj6uWIfNPTySSdbqYB6VJLkWHw==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr4380328wrs.5.1555716427464;
        Fri, 19 Apr 2019 16:27:07 -0700 (PDT)
Received: from cb-macbook ([2a02:c7f:8a73:c700:7884:e4ae:e845:5ffb])
        by smtp.gmail.com with ESMTPSA id a4sm1268379wrr.39.2019.04.19.16.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 16:27:06 -0700 (PDT)
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com> <1555349185-12508-3-git-send-email-jiong.wang@netronome.com> <20190418235747.jv4yocuf6fgwahli@ast-mbp.dhcp.thefacebook.com> <20190419134051.71eeea08@cakuba.netronome.com> <20190419211403.6iovh26bu6cg2x36@ast-mbp.dhcp.thefacebook.com> <20190419143310.6c749160@cakuba.netronome.com> <20190419214121.2rbmmms6qozmiuke@ast-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 02/15] bpf: mark lo32 writes that should be zero extended into hi32
In-reply-to: <20190419214121.2rbmmms6qozmiuke@ast-mbp.dhcp.thefacebook.com>
Date:   Sat, 20 Apr 2019 00:27:05 +0100
Message-ID: <ly8sw5bmpi.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Fri, Apr 19, 2019 at 02:33:10PM -0700, Jakub Kicinski wrote:
>> On Fri, 19 Apr 2019 14:14:05 -0700, Alexei Starovoitov wrote:
>> > > This reminds me, I'm not entirely clear on the need to propagate the
>> > > zext through stack slots...  Pointers are guaranteed to be 64bit, we
>> > > don't save parentage on scalars (AFAICT),  
>> > 
>> > scalars have parentage chain too.
>> > we don't track them precisely when they're spilled to stack.
>> > That actually caused an issue recently when valid program was rejected,
>> > so we might add a feature to track full contents of scalars in the stack.
>> 
>> Interesting..
>> 
>> > > why not pass REG_LIVE_READ
>> > > or READ64 to mark_reg_read() from stack_read?  
>> > 
>> > can we agree on only two states first ? ;)
>> 
>> Yess, the LIVE_READ was thought to be more of a mask for those accesses
>> that only care about "any read" being set, to be honest.  As you said
>> read64 is a strict superset of read32.  Keeping the name REG_LIVE_READ,
>> rather than REG_LIVE_READ_ANY or _MASK let us leave some of the
>> existing code untouched.
>> 
>> Jiong's original idea was to add a read32, and have read mean read64.
>> 
>> I think you said we should have read32 and read64 flags, but clear
>> read32 once read64 gets set?  SGTM!
>
> yep.
>
> any subsequent read64 means that earlier read32 marks are irrelevant
> from zext optimization pov.

OK, will split REG_LIVE_READ into REG_LIVE_READ64 and REG_LIVE_READ32, and
will let the prior override the latter early inside mark_reg_read. I feel
renaming parameter for propagate_liveness (the "parent" etc) could be a
following up patch? Let me know if you want it included in this set.

(I am travelling, will try to send out updated version around next Tuesday)

Regards,
Jiong
