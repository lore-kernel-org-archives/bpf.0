Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021BC10F00
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E43C2077B
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 21:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Po2mNkob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfBVV7e (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:59:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38342 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfBVV7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 16:59:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id j19so2861880ljg.5
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 13:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inGp63CnkQPGym5+zaHGFM1K173YzJRg3qyu/avVomA=;
        b=Po2mNkobwlHker/hG/WZJJNGd+vAIrgxgBuQa408gySq/P7Su/1AyIszKrUH/AWfWJ
         V7g3ut1/pzDwvsmIWtas1+dKpqGuzH3hvjjpTai4gEjacHpLTYoLLtKMNAw/2qmocFNk
         pA6VCjKTIuSGj0yWkT6srpr/n2/BU+GqWO/j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inGp63CnkQPGym5+zaHGFM1K173YzJRg3qyu/avVomA=;
        b=LB+zXw75x0jjs2sdVRNcwp5zZhqUMq9JrUHK5wOXVKrWMHOBskncGpKMXH5uMSBZfD
         doITv6g60P9zF/iOL0G50FxM2tu7AndRmReosXuvOGytOMMlqsADwSc5D1d8CnDvubNi
         KwgUTCiRDxZoR7UucebPOwT7R5hD9g2+9QPLE7Z70Xgqdr6DpzhK6OfxTBrbMDIjIw4Z
         l9HSrBCiuaE3GBPwc7c7AVex0fW8rkJCtQ+0oX8h60167zUXV3Q1LGCF64np1DAjBSYg
         WnKwl7UbkwRRw4fEieOGYlDKyaqzvRNCBVStJUZYczUCnIyDpucCctvR423OqWk6qZf3
         Ep3w==
X-Gm-Message-State: AHQUAuYnlstXWHSQPLDAgYtVF1Dme1wAMclWFCQ60YMWiEbq6MoqJIgy
        WK4j7EzeSwx7yySiEwdlEp4Q+ZytY5U=
X-Google-Smtp-Source: AHgI3IbuyV4aOtg/e0x/uBmLOsYvxiKOTOu4D4FJ8dOk7qIEHZwoLQT5h4Mh6kNF8m1g1MSjC1Ihdg==
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr3369155ljj.133.1550872770217;
        Fri, 22 Feb 2019 13:59:30 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id h12-v6sm734416ljb.80.2019.02.22.13.59.27
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:59:28 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id a17so2864591ljd.4
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 13:59:27 -0800 (PST)
X-Received: by 2002:a2e:6e09:: with SMTP id j9-v6mr3445351ljc.118.1550872766956;
 Fri, 22 Feb 2019 13:59:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com> <20190222.133842.1637029078039923178.davem@davemloft.net>
In-Reply-To: <20190222.133842.1637029078039923178.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 13:59:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
Message-ID: <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     David Miller <davem@davemloft.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 22, 2019 at 1:38 PM David Miller <davem@davemloft.net> wrote:
>
> Don't be surprised if we see more separation like this in the future too.

Yes, with the whole meltdown fiasco, there's actually more pressure to
add more support for separation of kernel/user address spaces. As Andy
pointed out, it's been discussed as a future wish-list for x86-64 too.

But yeah, right now the *common* architectures all distinguish kernel
and user space by pointers (ie x86-64, arm64 and powerpc).

                 Linus
