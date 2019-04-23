Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF55C282E1
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0B2175B
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDfmyW5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfDWQTm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:19:42 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33081 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfDWQTl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 12:19:41 -0400
Received: by mail-yw1-f65.google.com with SMTP id q11so1691909ywb.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4y96b5dnaZEDi764Jucw2JwqDBnZIFzaEPwS4fO1tc=;
        b=SDfmyW5whcvoXfS4OFDuSwd6qkgGpfk92LoBZGdvX8tOU6WpprXycDDQiKesXGDQXm
         4E/g8eNYfMrPKwsWcLmHFU5K51Q0xgGe4JbrsrGHUqnpFOoLjK48cbFzxu9YJfkGU+OU
         tvmI64J9yRi5TTdJUDqJjCR57pi2IK6lSpbYWxKuBuRPCmlu8Yso1y50UrVTcOBQ4mcm
         ZIRHtwL8SDpHpz/LCUpjinethLvOtZSBv9j7sUNOZqAGAfUhuSXpLLcd2y41a1GIsEuH
         l4zBu3BPIUdT4/IeMQ4fjYj095bKJWcV05GuBxUY/jMiiGsxoOAQ35xQhviTbd3XClbf
         D/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4y96b5dnaZEDi764Jucw2JwqDBnZIFzaEPwS4fO1tc=;
        b=J2AuKWnbH/XGVVmzaxEwy8B8LubLSdWvI3dDlRjXiYNqv8gUzGeIBZKagmTE/MuxyL
         raYDZvu2mjx4pjrmLnIr0ImziBNXIQ3lUn2laC0CkBlhZ9AjKHxbbyQw6BrgpHR0IhVm
         Wi7hQNov/IHANFg0OKn0J5mWdu28UCo9OxDburdpTctmBFX54g+o10cY5NVmpaH2fyfQ
         rdMrJi3n+aah/KzQu9L98L6e3etVV2A0bynESEslPEM3vHf2QfvyfeJKYQtzk9IzJHpn
         5cwJpsPLPmM0cO9ny8ZAon1Fg/P/OUE/fjg7LtuiKwAtSDCTKYD7wX8+qYKXVLEV4qFb
         DODQ==
X-Gm-Message-State: APjAAAW8eze7uxW8urjCXyAaCdq3T7X5BGAQJGvtBpHk6sYctcVwGyYn
        2sUJPYPyzftGWijH3dnZawkThqxt/9k28tgrgFwuUQ==
X-Google-Smtp-Source: APXvYqwIsALBtw/3bY8N0H29PO6fCWx6q7itwliaIrV7+GPGwoU0iWm+3ZjLagRjylYTxAFlSIcaIH7+AzL/gZfyv1s=
X-Received: by 2002:a81:993:: with SMTP id 141mr10294826ywj.441.1556036379895;
 Tue, 23 Apr 2019 09:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com> <20190423041503.np4dlso7c6qw3wfv@ast-mbp>
 <CANn89i+WFCQYxi-efjEBaAHY3rorornJ5dhGgQegBTkgwm1ZOQ@mail.gmail.com>
In-Reply-To: <CANn89i+WFCQYxi-efjEBaAHY3rorornJ5dhGgQegBTkgwm1ZOQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 23 Apr 2019 09:19:28 -0700
Message-ID: <CANn89iJY3jYqanGGLgbR43ucTNYYu7bhgF=uaJCHgLg8_KEHsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/9] net: flow_dissector: trigger BPF hook
 when called from eth_get_headlen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 23, 2019 at 9:00 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Apr 22, 2019 at 9:15 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>
> > Eric and Willem, could you please take a look as well
> > and hopefully ack it ?
>
> Sure, I am taking a look.

For the series :

Acked-by: Eric Dumazet <edumazet@google.com>

Thanks
