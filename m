Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FBBC10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A5720818
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LWlAf387"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDLWI2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:08:28 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43469 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfDLWI2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:08:28 -0400
Received: by mail-wr1-f43.google.com with SMTP id k17so9077475wrx.10
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVm0DqR96Gg1YBU4i7IsCddSxmOzs9cLlm0qkr9LC1Y=;
        b=LWlAf387ca9v9jlZyhLkAxu9MT3zftaoIBw1TpUiwSdJfvimDz24pGMdkxPhJHJoDn
         sO62tC1pN5Smc1l7E0L+qfDanXi6IClKe8ZwaMfIitn3Uy2INCgbwSw3fsdpRJuTziSM
         0dkQdbRaf39wWjr1wn3b7bSs/MP43nw+9EjUPPwluHI3z8FOoSwLqDrj8oVO89Vu2crY
         Hf//24EXn/rcX8r4V1mzLSkFxHUqc+SHZokKLP/nU/9RX61f5ITAV7MTzfslQYF3X6iO
         Z9v76Ybb9YpH4Jq2Ki8TPVvMY4VIx6pwCaBHpTodSQx1bVDIfXI1PnWgEvQPhWBIqlpx
         +Ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVm0DqR96Gg1YBU4i7IsCddSxmOzs9cLlm0qkr9LC1Y=;
        b=GRwOnJ+LPOrfatevvf1L2b0nEy39lH4OmwP9AQeDJgoR5+x/mMdFVWLcM74mUWLo2/
         ma6fRj0MXIdQDsB80zxHK/CaL5xNllyUur0NjAWeJiNrjo9VYbUVYcpf/7UWYdSKXfjF
         svGYtFi5+zvZXFnil8rg55mhaXBNQ64E6Y60/PTAHRgB8OcYnD9u9oB1/pUgh4QYUbdw
         VOs5lO8IVv78g4U4+xRQUeHlVbVOLukqQ58KnoR8MjWHg4emjKQxzqoZQBD7f60/xkt0
         R4yeyiIXOzBxL1s3+h21XEz/8n9suj8i7cAOaVTIK5SAMZTlxyGUSi4YE0tl/Y7hj0ly
         N+9Q==
X-Gm-Message-State: APjAAAUXmFDPzq78n3gzSLosPMWpFHYLvskEWBDa9TyWYguMh69PvbFq
        7xJcNBBGIgvw3GfQD/FAfbt4CYPdRB2xqkYKKuAk4A==
X-Google-Smtp-Source: APXvYqx8oHRmyu6SEI0ZT52F2eFnZ52iHMxb1t8lAFER5AAXl3vzqEe5lYwCevX7eOxVgtLMTmpOYXi9WsfWJQ8oGL4=
X-Received: by 2002:a5d:6889:: with SMTP id h9mr14244803wru.12.1555106906478;
 Fri, 12 Apr 2019 15:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
 <1554925833-7333-12-git-send-email-jiong.wang@netronome.com>
 <20190410201913.44dbf536@cakuba.netronome.com> <ECEC6F69-18BE-43C8-A5A7-818631F98D52@netronome.com>
 <AE6C1BDB-0491-4471-BBA8-7DA3989D4E1E@netronome.com>
In-Reply-To: <AE6C1BDB-0491-4471-BBA8-7DA3989D4E1E@netronome.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Date:   Fri, 12 Apr 2019 23:08:11 +0100
Message-ID: <CAMsOgNC=WmrrKfF2w6JxZj98dvNN05VyjLHBGA6kjFXog4rxzg@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 bpf-next 11/19] libbpf: new global variable "libbpf_test_mode"
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> If we want a more clean change in libbpf, it is more about how to offer clean API to
> pass "prog_flags" when load file/obj/raw_insn,

I followed this path a little bit further:
  - naturally allow specify prog_flags through *_attr structure.
  - set high 32-bit randomization prog_flags through macro direct.

Now, the global variable in libbpf removed, all tests in selftests are
still enabled
with hi32 randomization and the code changes on testsuites also is little.

Not sure if the idea is good, changes included in v3.

Regards,
Jiong
