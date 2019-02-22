Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335A3C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 21:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000E8206BA
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 21:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bXmUUeQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfBVVVW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:21:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45925 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBVVVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 16:21:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id h10so2752924lfc.12
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 13:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4euBrx1amh8VREzowpOlG7HHzKY/P+3+k2m8hYpWdo=;
        b=bXmUUeQZYn3iYoo+sp7inmFd8U3YD0j+FUYXbPRwuqVT4OxQs6EK3W7jhv8rXcDou0
         ogSmrUHQkbEZBmlsLhN7prfCeGa1EuG26VbI13BLg+YM9t7fCrelLo96koDr2rLexMAd
         qFlXWgpdDTepvhP6unSCoKh7GNU0oNRJ0myZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4euBrx1amh8VREzowpOlG7HHzKY/P+3+k2m8hYpWdo=;
        b=TFcnHejTzeAuXj3Eol0Mw8kSIoGFgGYBdql4EE+3y6XHC6X+IOAVasg5tO1lSXdsyT
         kevHPJtqbi4iOeB/tLjY8dpUmL7Tg2PuAOzrUdd/8Fw4Ep0OjSpkmr39mAeXjQfYGecr
         3vbtjUFH9GXHlVKu+1X/rd6DVSL1mQXaa+j2pIHrdz0yDaDnMUlcozhx3cqqXP3SWC/b
         Ye9gzV7BUUFJfWEpkoujfzltIxrgZ7eGPZjPel0W2MCzbq19E4/c6ldseOi0nyveCgeJ
         dCPza/kaWZPbdcOP9DYVig8qvJC/ck2ym4DB7yEHWxogRmIyWPoOQscPi8WyMXN56QTo
         g4yg==
X-Gm-Message-State: AHQUAuYzSu26wFjKcQ0lkF6E/bBRlR99j6+HgBZHLbyrtw8KQCRehoO5
        j1bDTOoyksd0jFjtfB0lW9pcFl2swQI=
X-Google-Smtp-Source: AHgI3IZqjk1mSnwQdZwLBey/9nSzXOJOSC22/J6UxWAnXg/HfIxKwZ2jhaLxFa1TjUDm68I2sIFZFw==
X-Received: by 2002:ac2:4243:: with SMTP id m3mr3612728lfl.5.1550870477312;
        Fri, 22 Feb 2019 13:21:17 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x18sm708775ljc.67.2019.02.22.13.21.15
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:21:15 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id j13-v6so2811916ljc.2
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 13:21:15 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr3093456lji.79.1550870474949;
 Fri, 22 Feb 2019 13:21:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 13:20:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
Message-ID: <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 22, 2019 at 11:27 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
> and users pass both user and kernel addresses into it and expect
> that the helper will actually try to read from that address.

As mentioned earlier in the thread, that's actually fundamentally broken.

There are architectures that have physically separate address spaces,
with the same pointer value in both kernel and user space.

They are rare, but they exist. At least sparc32 and the old 4G:4G split x86.

So a pointer really should always unambiguously always be explicitly
_either_ a kernel pointer, or a user pointer. You can't have "this is
a pointer", and then try to figure it out by looking at the value.
That may happen to work on x86-64, but it's literally a "happen to
work on the most common architectures", not a design thing.

                Linus
