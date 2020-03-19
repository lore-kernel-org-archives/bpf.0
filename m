Return-Path: <SRS0=cKI0=5E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43DFC4332B
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 05:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD14F2072D
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 05:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7ZATe69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCSF1n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Mar 2020 01:27:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33195 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSF1m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 01:27:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id c20so592517lfb.0;
        Wed, 18 Mar 2020 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/iKqoxWaZ+Tkks580ZgQreSF47JyquklZOAbcKvE+0=;
        b=i7ZATe696JfpmC5Se4TMQM5EfN1jCMLVKl9zKk/30WYniXfC/KjodFDUq4WNeg4E3I
         5ApAl57gYYf+Tqrc/A2ElSw1b+YLcSIzEHuwNtEu7lmtYyeeT0iKT2Sw25ZhLq2yfuZJ
         XoF5ytnrY2QWiX+zgt49nMrgX1Uf5WDpYWUCQSpwBA7mugiWawYiHko2c3MvPmyGVJi2
         ZRRep1J+TfbP/Vp6kLiqK4IDwyTS7gNiH+ooh0g9q7QqiSVkAKBbM4Bdxve1jbc5ZQm2
         5mLI6WMBHzmMYNhWCImOlCQf/aK35whjkvoazbcDRMvfYqt7ULeCUJ6jNTIlzO/snUS3
         61Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/iKqoxWaZ+Tkks580ZgQreSF47JyquklZOAbcKvE+0=;
        b=Oi01KOtf/Ntc8lMQrpaNzL4EQOKMwN8wD5eaRYfRzAu/YS5KEiKAVSOMrMjGAygDIl
         4LERexM3SqLyoppuERoD90Skcg2goCsHnaZwgWJ73oIpj3nL5rlfBOmNsFHVJ4/JhOYc
         RcKv9dP0y4JVKuSPv/v2zJK8EsOss5Ka6+q4m9D77mdKkUlbdXZYlEFvQOoPgih3iXa8
         LJPqPC/gnkjB04+HYi0pSbQFPdBxP/8wX0SQHO9KFqfPE6RVyZsf2mOCJlAQX0NxiypU
         m28rQn/o5q+zuckAriJd3FbNsgbVNB1iccZsuw69uAc6RVlqHjgG4xoq6rFidGh+nwB9
         1ibA==
X-Gm-Message-State: ANhLgQ0ULB3/MCovAmskolguh5NnEYCJ7HuO0CX9VPmcA9g6iSvmFxXv
        he9IZWlUg7OmBwgnebYVq1bBFZksVvgRhNhsXw8=
X-Google-Smtp-Source: ADFU+vvhVCDWyEVnXCmwPD4XzhHK3C5uf8Wgv8zRkF0h382PkmGGmgSe+R198UtCb8XR6Pq6Hy9a+L5QPBOQ2GBvNWY=
X-Received: by 2002:ac2:46d9:: with SMTP id p25mr982593lfo.174.1584595659830;
 Wed, 18 Mar 2020 22:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200317213222.421100128@goodmis.org>
In-Reply-To: <20200317213222.421100128@goodmis.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 18 Mar 2020 19:27:28 -1000
Message-ID: <CAADnVQ+hpVnsfKUNNeJWs8X0ogvsR8uNKrEzz5CK2XRdqn+80A@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/11] ring-buffer/tracing: Remove disabling of ring
 buffer while reading trace file
To:     Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 17, 2020 at 11:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> When the ring buffer was first written for ftrace, there was two
> human readable files to read it. One was a standard "producer/consumer"
> file (trace_pipe), which would consume data from the ring buffer as
> it read it, and the other was a "static iterator" that would not
> consume the events, such that the file could be read multiple times
> and return the same output each time.
>
> The "static iterator" was never meant to be read while there was an
> active writer to the ring buffer. If writing was enabled, then it
> would disable the writer when the trace file was opened.
>
> There has been some complaints about this by the BPF folks, that did
> not realize this little bit of information and it was requested that
> the "trace" file does not stop the writing to the ring buffer.
>
> This patch series attempts to satisfy that request, by creating a
> temporary buffer in each of the per cpu iterators to place the
> read event into, such that it can be passed to users without worrying
> about a writer to corrupt the event while it was being written out.
> It also uses the fact that the ring buffer is broken up into pages,
> where each page has its own timestamp that gets updated when a
> writer crosses over to it. By copying it to the temp buffer, and
> doing a "before and after" test of the time stamp with memory barriers,
> can allow the events to be saved.

Awesome. Thank you so much for working on it.
Looks like it addresses all the issues bpf folks reported.
cc-ing bpf list for visibility.
