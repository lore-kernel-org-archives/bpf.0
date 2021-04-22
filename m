Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D550C433ED
	for <bpf@archiver.kernel.org>; Thu, 22 Apr 2021 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1636144A
	for <bpf@archiver.kernel.org>; Thu, 22 Apr 2021 14:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhDVOZ1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 22 Apr 2021 10:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236398AbhDVOZ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 10:25:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622C661421;
        Thu, 22 Apr 2021 14:24:50 +0000 (UTC)
Date:   Thu, 22 Apr 2021 10:24:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Jesper Brouer <jbrouer@redhat.com>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCHv2 RFC bpf-next 0/7] bpf: Add support for ftrace probe
Message-ID: <20210422102448.03c12531@gandalf.local.home>
In-Reply-To: <YIB6kr1fb5VvK5H4@krava>
References: <20210415170007.31420132@gandalf.local.home>
        <20210417000304.fc987dc00d706e7551b29c04@kernel.org>
        <20210416124834.05862233@gandalf.local.home>
        <YH7OXrjBIqvEZbsc@krava>
        <CAADnVQK55WzR6_JfxkMzEfUnLJnX75bRHjCkaptcVF=nQ_gWfw@mail.gmail.com>
        <YH8GxNi5VuYjwNmK@krava>
        <CAADnVQLh3tCWi=TiWnJVaMrYhJ=j-xSrJ72+XnZDP8CMZM+1mQ@mail.gmail.com>
        <YIArVa6IE37vsazU@krava>
        <20210421100541.3ea5c3bf@gandalf.local.home>
        <CAEf4BzaYEOqVYBaxVSs8p6Nmy_giztaxTX9DtDk4N77NzsHbDQ@mail.gmail.com>
        <YIB6kr1fb5VvK5H4@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 21 Apr 2021 21:18:42 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> > 
> >   [0] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit#gid=883029154  
> 
> great, I can come

I'll attend as well, and so may some of my team.

-- Steve
