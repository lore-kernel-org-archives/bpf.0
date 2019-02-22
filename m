Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68368C10F00
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398BE2070D
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z8RmPI2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfBVXQ4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:16:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36874 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVXQz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 18:16:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id z196so2262432lff.4
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbkNOJOWOEztY0V5oFI3crYnBu0yHTs4i1TRjvJWTnk=;
        b=Z8RmPI2oG03C9S+ZOdCOIl/Pr8NpV9R6t/ZeMxGfSr4B+ZkHiyBc2yvrG9i4Otkatk
         erfitGEiOAqqehH6AbUlzDJxNUFjj/rL5EmXsL3FAiMizVQq1qBzGeWQ7X3jmSg6XkON
         zing7Tgfl1Kl9mUlx4H2aKtNYu/VU4kgyM83s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbkNOJOWOEztY0V5oFI3crYnBu0yHTs4i1TRjvJWTnk=;
        b=iSrFIFFjbZ/7V28rmiy92dDextO+xyIDosbIbSlJW2K6zfJeCYlhXzSuxxVAdeXmC5
         21pI1oSFOe7n89ah2TyAJG7VxBc36pqO/EM2lRA8hRv8xRdf1ws6bMUqlWXtQinZTr8+
         RqEieRL/kfP2gOn5Oo0C/rBuDB/oWG/2XI9KzToHTDjA0yQ9RlpFksueht1g3SGxXMA8
         zi5TuHNjke31V1iSaJNVGt4S61soqWpFZPqjRjmb3K3JqGqNVuW77iINBxzBswfXK29H
         T/5II2vzSNZyyF/UsxrPjWVWnEWar9NEeYc376rEDEwD7Q4p34gHD/vgN7RURkLqEoj3
         DA4w==
X-Gm-Message-State: AHQUAuatm5mwU9Z/UWe9ygzR6wNvRUFT7q3DL3HbQD332v0z5l9A+No4
        0qNAYI4ShKjJ4O3traK+lRSdC0hLslM=
X-Google-Smtp-Source: AHgI3Ib/Inxahw66QWtgGVzeL1kDauSaUt0gi6wmSmtMpJRVWzHjxyeLEnrHwwPFzsiBaO8HDOijDQ==
X-Received: by 2002:ac2:4282:: with SMTP id m2mr3606841lfh.141.1550877413485;
        Fri, 22 Feb 2019 15:16:53 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z7sm779038ljk.34.2019.02.22.15.16.52
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:16:52 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id e27so2943798lfj.8
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:16:52 -0800 (PST)
X-Received: by 2002:ac2:415a:: with SMTP id c26mr4153706lfi.62.1550877412019;
 Fri, 22 Feb 2019 15:16:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net> <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
 <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 15:16:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com>
Message-ID: <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
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

On Fri, Feb 22, 2019 at 2:51 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> That's all fine. I'm missing rationale for making probe_kernel_read()
> fail on user addresses.

Because it already WON'T WORK in general!

> What is fundamentally wrong with a function probe_any_address_read() ?

What part of "the same pointer value can be a user address and a
kernel address" is not getting through?

The user address space and the kernel address space have separate page
tables on some architectures. We used to avoid it on x86, because
switching address spaces was expensive, but even on x86 some vendors
did it on 32-bit simply to get 4GB of user (and kernel) address space.
And now we end up doing it anyway just because of meltdown.

So a kernel pointer value of 0x12345678 could be a value kernel
pointer pointing to some random kmalloc'ed kernel memory, and a user
pointer value of 0x12345678 could be a valid _user_ pointer pointing
to some user mapping.

See?

If you access a user pointer, you need to use a user accessor function
(eg "get_user()"), while if you access a kernel pointer you need to
just dereference it directly (unless you can't trust it, in which case
you need to use a _different_ accessor function).

The fact that user and kernel pointers happen to be distinct on x86-64
(right now) is just a random implementation detail.

Really.

I didn't realize how many people seem to have been confused about
this. But it's always been true. It's just that the common
architectures have had that "one single address space for both kernel
and user pointers" in practice.

In fact, the *very* first kernel version had separate address spaces
for kernel and user mode even on x86 (using segments, not paging). So
it has literally been true since day one in Linux that a kernel
address can be indistinguishable from a user address from a pure value
standpoint.

                 Linus
