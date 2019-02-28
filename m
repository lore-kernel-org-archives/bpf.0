Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B8FC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 08:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1FE218AE
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 08:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="T59rjdCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfB1IU5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:20:57 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42417 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfB1IU5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 03:20:57 -0500
Received: by mail-wr1-f48.google.com with SMTP id r5so20851497wrg.9
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 00:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TakRGy1bEodXqr0iqvpY55jBLe9dtJaWq8LsVpyzgt0=;
        b=T59rjdCIbZuhquADCkmcbfMgbRxKNSn7LIb0hNEYuK3hgJBSFEKm9Zl0dW/kWCzdNg
         hYf1vMcFp15+4/JawQGlebUJ6RzyZm6znlKeKGpQViCtSBN1WNI0SZKQ3WutK7jVWVQu
         aYv/HeMTgOl3QX33eVRYH6fPyWsT3Fr6vSmgMzfntljh/GuiHWxJ2WKz6JOuS2/JlYAx
         D/adyUbqCm4CCWKfT76zGowk4nKCgG77mHYuloKf1HGmOY3RoviB9tn2Yx16/QpqU32B
         9I05WIxXq+l2pEAxE2uR/1JSvBvmCgI2KscmF509xVkodhpr6CUiIGsNM9jlFZ6s3ZQd
         dI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TakRGy1bEodXqr0iqvpY55jBLe9dtJaWq8LsVpyzgt0=;
        b=WwlzB62ygJGAmjxyboNFBr+z/9sQmTPl1mZdBRkZtpkyVU2T6vthDOZJGi7u4l8VG9
         7J8rpNVdaMr6excKepEQHZ2iO2V74//Kagasgfd7dDOhLdP2lOzUjlcDvYZbkTbRZCPC
         aKY+Z8KhyTdQQTKgTdRmgJcphwEItDZkivG6S4T1foZNS8Pt4ql/+gKSn9smnXBplwxJ
         C+T9ZB50vZ+3OpW4XxDI5TYTXIJvUwtbjCprHnoIRSOreMLNpN0FjHX1+b3KIJFTr9WX
         A/+qKV+5Ap6O2jgHgroH5LVBjsULwQ5DQEjwT+Iak2IQRL3vU7FWsRU26cNvHf24oF0a
         Ioig==
X-Gm-Message-State: APjAAAWA8bFyRLiuU1XNP2axTxZnh9Ea3oBst5mv5FdHseNBaBUfqmpA
        yFyq0r53ellihRt8Gpbfix7oamGX2hUb7l/JSjmdag==
X-Google-Smtp-Source: APXvYqwLexi/8kKY3vBUU9uInqVAuargirn4FqNnyoIiVQ/f3lYM9uA7D610wGkxZgPrtqbr+ejsbVLZpyjHzMPOMo4=
X-Received: by 2002:a5d:6288:: with SMTP id k8mr5663444wru.173.1551342055413;
 Thu, 28 Feb 2019 00:20:55 -0800 (PST)
MIME-Version: 1.0
References: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
 <1551300641-1727-2-git-send-email-jiong.wang@netronome.com> <ace3663c-e493-2149-0fec-1fc9be6837b2@fb.com>
In-Reply-To: <ace3663c-e493-2149-0fec-1fc9be6837b2@fb.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Date:   Thu, 28 Feb 2019 08:20:42 +0000
Message-ID: <CAMsOgNAqEOWQ0rRFv5zwrd3K801f4rxERkx=UfF+6o8GWkJLLQ@mail.gmail.com>
Subject: Re: [PATCH LLVM 1/3] bpf: improve dead Defs check for XADD
To:     Yonghong Song <yhs@fb.com>
Cc:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 6:47 AM Yonghong Song <yhs@fb.com> wrote:
<snip>
> > +  // Otherwise, return true if any aliased SuperReg of GPR32 is not dead.
> > +  std::vector<unsigned>::iterator search_begin = GPR64DeadDefs.begin();
> > +  std::vector<unsigned>::iterator search_end = GPR64DeadDefs.end();
> > +  for (auto I : GPR32LiveDefs) {
> > +    bool ActuallyDead = true;
> > +
> > +    for (MCSuperRegIterator SR(I, TRI); SR.isValid(); ++SR) {
> > +       if (std::find(search_begin, search_end, *SR) == search_end) {
>
> maybe you can just return true here?

Good catch, yeah, simpler, will fix in v2.

Regards,
Jiong
