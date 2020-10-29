Return-Path: <SRS0=L8C4=EE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153FC4363A
	for <bpf@archiver.kernel.org>; Thu, 29 Oct 2020 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A377420735
	for <bpf@archiver.kernel.org>; Thu, 29 Oct 2020 07:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgJ2HYd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:24:33 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:46036 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgJ2HYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:24 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09T4F1CJ016347;
        Thu, 29 Oct 2020 05:15:01 +0100
Date:   Thu, 29 Oct 2020 05:15:01 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Alon, Liran" <liran@amazon.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dan Aloni <dan@kernelim.com>, bpf <bpf@vger.kernel.org>,
        security@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH] btf: Expose kernel BTF only to tasks with CAP_PERFMON
Message-ID: <20201029041501.GA16341@1wt.eu>
References: <20201028203853.2412751-1-dan@kernelim.com>
 <CAEf4BzZxabLCaNj0E5UEcnrEY25ujSLOzTbYRXneJy2HrY64JA@mail.gmail.com>
 <3bccbaac-ec63-bc06-0e4b-5501c0788822@amazon.com>
 <20201028230602.4g7guvb5nzgosgwb@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028230602.4g7guvb5nzgosgwb@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 28, 2020 at 04:06:02PM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 29, 2020 at 12:30:49AM +0200, Alon, Liran wrote:
> > > Guarding /sys/kernel/bpf/vmlinux behind CAP_PERFMON would break a lot
> > > of users relying on BTF availability to build their BPF applications.
> > True. If this patch is applied, would need to at least be behind an optin
> > knob. Similar to dmesg_restrict.
> 
> It's not going to be applied. If a file shouldn't be read by a user
> it should have appropriate file permissions instead of 444.
> Checking capable() in read() is very non-unix way to deal with permissions.

Not only it's a non-unix way, both don't achieve the same goals at all!

One checks for permissions at open() time and may for example allow a
process to drop its uid after opening, while the other one allows to
filter who can really read it, particularly in case the FD is inherited
between processes. With this said, I don't see why there would be a
special case for this one, it should definitely stick to file permissions
only.

Willy
