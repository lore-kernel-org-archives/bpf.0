Return-Path: <SRS0=1cax=SP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E41C10F11
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 07:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BB52084E
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 07:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="iR0x19fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfDMHBI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:01:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41549 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfDMHBI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Apr 2019 03:01:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so14676733wrq.8
        for <bpf@vger.kernel.org>; Sat, 13 Apr 2019 00:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=thjMR0EyiW9LFv1xwKYp6fxWicZp5zGMpl4OYWQWltM=;
        b=iR0x19fp0GC2L61GzBp8uhMeE7EyWxvHVuwoj7SiJA7gLzqLmEiDRuXXAYrpRqpR5c
         IQ4O8BnFEHNJ41ZMaL9nfnasa+bcugYe32zbDVMANyRxdCkUZ69vcpQOVKnlFjKHsiA9
         wnv1JbQ8O2HibhTTmEJ5RoXz+3wCLuuErN32eXspWYGm8SoaPimjTjpk11ZWofU8Lj2p
         ATpy8binRpi4XfQcN59Gl8Gdj8evUPyFjNj4ZYfonwOf4xcb50ggqkjtySDIWflcWBeN
         Tx3IgQC0TCGcBFhUL1UeWh70oqxOZwza6jMu08nqFzrYngd1vdUTbkAZaTK9ZcWUrx9y
         DN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=thjMR0EyiW9LFv1xwKYp6fxWicZp5zGMpl4OYWQWltM=;
        b=YjDLKlTPGSrEYT6b1x/iJnMOLTzUkyxPYRlaIGdT6X5mi02wFNQs52WsuVMziBqq1z
         idh+f4iPB9zcicu005fnYptVBomJ6+i8AxFlEk+bIqg3Mh9Tmd8AWNnzUYXxN/raRkHU
         ZCfrUtFxPcvcDf2wkAl/Nzh7c+Svy9q4+o0p67AmWDU3M3ohTEe/kgxuVVdHVjGOnh8O
         l7++8678AskdGww6KbwO+3Mwq2UL5HFdeZSka4cGXFYcEsbrwkoDX7vdLWspTKyPyPdY
         ZLB25KsFxC6wjED1xbGebgwujxQA8K65f1Xv9NGgZVePMoAek/ZkBaMW5061uQUcZ/aS
         W52Q==
X-Gm-Message-State: APjAAAV51jWv9qkYvFD2nagns4nP/jLgAu6ecKv1gO0O9QdvjapcJGB2
        JgEgH+QH23Sc2zxvCYXMagYUmA==
X-Google-Smtp-Source: APXvYqyeWNcV56d48pH22mwVWTA743iDImd2viklUPIZyFthNwiHeTBqQg3Y2+VvpKxY3GLbdGAu6w==
X-Received: by 2002:adf:f451:: with SMTP id f17mr40963993wrp.272.1555138866513;
        Sat, 13 Apr 2019 00:01:06 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id 204sm16633413wmc.1.2019.04.13.00.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 00:01:05 -0700 (PDT)
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com> <1555106392-20117-5-git-send-email-jiong.wang@netronome.com> <20190413001241.fiuiyd64l7vuntz5@ast-mbp.dhcp.thefacebook.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v3 bpf-next 04/19] bpf: refactor "check_reg_arg" to eliminate code redundancy
In-reply-to: <20190413001241.fiuiyd64l7vuntz5@ast-mbp.dhcp.thefacebook.com>
Date:   Sat, 13 Apr 2019 08:00:59 +0100
Message-ID: <87ftqmfkyc.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Fri, Apr 12, 2019 at 10:59:37PM +0100, Jiong Wang wrote:
>> There are a few "regs[regno]" here are there across "check_reg_arg", this
>> patch factor it out into a simple "reg" pointer. The intention is to
>> simplify code indentation and make the later patches in this set look
>> cleaner.
>> 
>> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>
> The first 4 patches look great, so I've applied them to bpf-next.

Thanks.

> The rest needs more careful review that we'll do soon.

No problem and agree they need very careful review. I understand once
landed the optimization will be always on for a couple of targets like Arm,
PowerPC and SPARC etc, so the correctness is critical.

Patch 5 has two comments from Jakub not addressed, they are not about
correctness so should not affect the review, I will fix them together with
the other new comments.

One good thing is high 32-bit randomization does catch a couple of corner
case bugs so prove to be very powerful and efficient for exposing bugs. In
v3, it is enabled on all possible tests under bpf selftests, and I haven't
noticed regressions (my local machine configure may caused some tests
skipped, but majority of the testsuite, especially all tests under
test_progs/test_progs_32/test_verifier ran without failure), this is a good
assurance of correctness.

Thanks.

Regards,
Jiong
