Return-Path: <SRS0=/C52=4N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBBC35DFB
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 09:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC08C20714
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 09:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgBYJvE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:51:04 -0500
Received: from ms.lwn.net ([45.79.88.28]:52976 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbgBYJvE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 04:51:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3505738;
        Tue, 25 Feb 2020 09:51:00 +0000 (UTC)
Date:   Tue, 25 Feb 2020 02:50:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stephen Kitt <steve@sk2.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: sysctl/kernel: document BPF entries
Message-ID: <20200225025055.7fd1d069@lwn.net>
In-Reply-To: <CAADnVQKb-3fzx1xKLwms8pcPiJNLsmFsHyj_gnsE8DKVp1jhYQ@mail.gmail.com>
References: <20200221165801.32687-1-steve@sk2.org>
        <CAADnVQ+QNxFk97fnsY1NL1PQWykdok_ha_KajCc68bRT1BLp2A@mail.gmail.com>
        <20200224205028.0f283991@heffalump.sk2.org>
        <CAADnVQKb-3fzx1xKLwms8pcPiJNLsmFsHyj_gnsE8DKVp1jhYQ@mail.gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 24 Feb 2020 21:43:33 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Sorry, I forgot to include the base commit information; this is against
> > 8f21f54b8a95 in docs-next.
> >
> > I’ll wait for that to make it to Linus’ tree and re-submit the patch (with
> > the fix above).  
> 
> Please use bpf-next tree as a base for your patch.

It seems that folks want to take this through the BPF tree, so I'll
assume it's not my problem :)

Thanks,

jon
