Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E40C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88CF2190C
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 07:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfBOHQo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:16:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfBOHQo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 02:16:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so9149643wrp.7;
        Thu, 14 Feb 2019 23:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7Xiq6iPobB1Ore4uNf9Q4l8sh1VSL9wxUqrNSS6YJ0=;
        b=KbCb6tVHWY/0I1LwaJEIweuu/hffnVZyCqtsAZuWYqrSIMLLPnET3MLUKhACQC509X
         NuaZvQlW4MGqRdQtog/3Q+eKj/m5FXPLb/+FOK1/+m5OQEdGkp/VafHa1yoPX3nNZU4Y
         34mMvvgEvASOgGFSxWiTj4BZIRXApsuSKmH5wICyqsQSI/LGWpfNFz1g2d6p/qVinqD2
         qtV9/IK0P+KdBq54NNbWElw7e4avGjpAsMeYZuMLsEEivY4QW3xpGWlo6EyL7jfvC/C7
         pQsH5gRBRWQO+OqBFxvsElb31+WvZih9KirThn4MRy4+/hNoZz8GF+zpWZvmB73UgYN5
         Ok8A==
X-Gm-Message-State: AHQUAuYBwp0wpAI9qMqTPBK+WejufMAtQD3/fT+C85TleCm6MN4anayx
        WnrKHLyil4lTSdvXGZiBUAlxRr2j0sj6Dn6Avnc=
X-Google-Smtp-Source: AHgI3IbTYdbF1eLOkft1XlqhF0ZLAWICJmXMpm/IMncEfZ0DH86bNwcCsPAVbmIrFwsvGmK5foA73D11SfYPRfI04g8=
X-Received: by 2002:adf:b7c1:: with SMTP id t1mr5434574wre.248.1550215002499;
 Thu, 14 Feb 2019 23:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20190212004729.535-1-joe@wand.net.nz> <20190212004729.535-3-joe@wand.net.nz>
 <CAH3MdRVU5ayEm6eb9Fz53Q5gjA60vadyJ+0_meCkWBo+t+XXYA@mail.gmail.com>
In-Reply-To: <CAH3MdRVU5ayEm6eb9Fz53Q5gjA60vadyJ+0_meCkWBo+t+XXYA@mail.gmail.com>
From:   Joe Stringer <joe@wand.net.nz>
Date:   Thu, 14 Feb 2019 23:16:30 -0800
Message-ID: <CAOftzPjFbBHabG2SR=QrC053Y8cC+Gi1LvK19oLEvDvR6LSLkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: Support 32-bit static data loads
To:     Y Song <ys114321@gmail.com>
Cc:     Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 14 Feb 2019 at 21:39, Y Song <ys114321@gmail.com> wrote:
>
> On Mon, Feb 11, 2019 at 4:48 PM Joe Stringer <joe@wand.net.nz> wrote:
> >
> > Support loads of static 32-bit data when BPF writers make use of
> > convenience macros for accessing static global data variables. A later
> > patch in this series will demonstrate its usage in a selftest.
> >
> > As of LLVM-7, this technique only works with 32-bit data, as LLVM will
> > complain if this technique is attempted with data of other sizes:
> >
> >     LLVM ERROR: Unsupported relocation: try to compile with -O2 or above,
> >     or check your static variable usage
>
> A little bit clarification from compiler side.
> The above compiler error is to prevent people use static variables since current
> kernel/libbpf does not handle this. The compiler only warns if .bss or
> .data section
> has more than one definitions. The first definition always has section offset 0
> and the compiler did not warn.

Ah, interesting. I observed that warning when I attempted to define
global variables of multiple sizes, and I thought also with sizes
other than 32-bit. This clarifies things a bit, thanks.

For the .bss my observation was that if you had a definition like:

static int a = 0;

Then this will be placed into .bss, hence why I looked into the
approach from this patch for patch 3 as well.

> The restriction is a little strange. To only work with 32-bit data is
> not a right
> statement. The following are some examples.
>
> The following static variable definitions will succeed:
> static int a; /* one in .bss */
> static long b = 2;  /* one in .data */
>
> The following definitions will fail as both in .bss.
> static int a;
> static int b;
>
> The following definitions will fail as both in .data:
> static char a = 2;
> static int b = 3;

Are there type restrictions or something? I've been defining multiple
static uint32_t and using them per the approach in this patch series
without hitting this compiler assertion.

> Using global variables can prevent compiler errors.
> maps are defined as globals and the compiler does not
> check whether a particular global variable is defining a map or not.
>
> If you just use static variable like below
> static int a = 2;
> without potential assignment to a, the compiler will replace variable
> a with 2 at compile time.
> An alternative is to define like below
> static volatile int a = 2;
> You can get a "load" for variable "a" in the bpf load even if there is
> no assignment to a.

I'll take a closer look at this too.

> Maybe now is the time to remove the compiler assertions as
> libbpf/kernel starts to
> handle static variables?

I don't understand why those assertions exists in this form. It
already allows code which will not load with libbpf (ie generate any
.data/.bss), does it help prevent unexpected situations for
developers?
