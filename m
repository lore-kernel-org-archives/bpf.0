Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932EDC43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 00:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BCE20651
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 00:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BXGnY8ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfBWAJT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:09:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33792 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBWAJS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 19:09:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id l5so3055214lje.1
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 16:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfPdBRc9tHlVx4731kzoTxYm9oHOsR9CfjKri/wmKro=;
        b=BXGnY8uguxJoyc8/1beXM666q65BcuL7j71qhPOZoQUyrJTsEoBKigunyokVuT5Sla
         4ZSIiA9wLPQk8l0PVwcbkAN6IHjqJgRLEWbiMC6B1kscR3ZELS9Pz/ujsOgRDUjwp2jT
         E29kxlYkUCPPjzT/j1SLuTWgPw6Jk+sZ74gY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfPdBRc9tHlVx4731kzoTxYm9oHOsR9CfjKri/wmKro=;
        b=fw8F7xjtVzLXc9boY4ZKCdSeD/nzE7ikMuyGfnulwHHwQa4koG/3HqgFeqwl0C+UoD
         xjpVEYUaWIbPw2UJq/9+S6WmTxBcRGyzPRz2XhfpaURRd8sRAMDiSOgeBPZqenBjRpf9
         HJL2YXPYubNSy+hiUz1i89YfzHS5POV7cVO5Z9glMIbZI6oXyMPK0LoBmm/Y+yYi93uE
         7JQOxbUqdZGOUsDoeJ6pyVYhUuHki3bW9TQiRhH+uSH3XS+pJdzs/l4KPnt5SJuWta7S
         +FVk8hXlyFwC1aLNBW8J875HlwCwGiH83LtefJVNHFJbOxHOXPaDy210ysNG0NKgak0Y
         q1JQ==
X-Gm-Message-State: AHQUAuafxdY5CxB7+7j7etaTHakHiXsw/jb1A83TLKE4/lqnVwpx8xBo
        XSg5NjJ0gTtcNdLubJ/TZqHEB0My+YA=
X-Google-Smtp-Source: AHgI3IaDIbX12p0H6s7gaforz9f/AjwZXVwVT2zpmlSwG9cQJmne9mVa6fn38ZuWZimlfu8/m36clw==
X-Received: by 2002:a2e:2007:: with SMTP id g7mr3819635ljg.93.1550880556746;
        Fri, 22 Feb 2019 16:09:16 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b17sm876566lff.62.2019.02.22.16.09.16
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:09:16 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id v16so3002535ljg.13
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 16:09:16 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr3689553lji.125.1550880555567;
 Fri, 22 Feb 2019 16:09:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net> <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
 <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com> <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 16:08:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whu_iwv4TQP5Xd62bTfWW-uswVecUbFeiSCuTWnH1xgPg@mail.gmail.com>
Message-ID: <CAHk-=whu_iwv4TQP5Xd62bTfWW-uswVecUbFeiSCuTWnH1xgPg@mail.gmail.com>
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

On Fri, Feb 22, 2019 at 3:56 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> It will preserve existing bpf_probe_read() behavior on x86.

... but that's the worst possible situation.

It appears that people haven't understood that kernel and user
addresses are distinct, and may have written programs that are
fundamentally buggy.

And we _want_ to make it clear that they are buggy on x86-64, exactly
because x86-64 is the one that gets the most testing - by far.

So if x86-64 continues working for buggy programs, then that only
means that those bugs never get fixed.

It would be much better to try to get those things fixed, and make the
x86-64 implementation stricter, exactly so that people end up
_realizing_ that they can't just think "a pointer is a pointer, and
the context doesn't matter".

From a pure functional safety standpoint, I thought bpf already knew
what kind of a pointer it had?

                   Linus
