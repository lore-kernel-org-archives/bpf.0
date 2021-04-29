Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E23C433ED
	for <bpf@archiver.kernel.org>; Thu, 29 Apr 2021 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FF161405
	for <bpf@archiver.kernel.org>; Thu, 29 Apr 2021 17:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbhD2RxZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Apr 2021 13:53:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38708 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbhD2RxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 13:53:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcAq4-00Aa8v-FA; Thu, 29 Apr 2021 11:52:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcAq3-0005kg-Mk; Thu, 29 Apr 2021 11:52:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>
References: <20210420165001.3790670-1-Liam.Howlett@Oracle.com>
        <20210420165001.3790670-2-Liam.Howlett@Oracle.com>
        <20210422124849.GA1521@willie-the-truck>
        <m1v98egoxf.fsf@fess.ebiederm.org>
        <20210422192349.ekpinkf3wxnmywe3@revolver>
        <m1y2d8dfx8.fsf@fess.ebiederm.org>
        <20210423200126.otleormmjh22joj3@revolver>
Date:   Thu, 29 Apr 2021 12:52:31 -0500
In-Reply-To: <20210423200126.otleormmjh22joj3@revolver> (Liam Howlett's
        message of "Fri, 23 Apr 2021 20:03:17 +0000")
Message-ID: <m1czud6krk.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcAq3-0005kg-Mk;;;mid=<m1czud6krk.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19EXfnu02KZWm8B3o5WSHeiqcMyaK11Fy8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/3] arm64: signal: sigreturn() and rt_sigreturn() sometime returns the wrong signals
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


This entire discussion seems to come down to what are the expected
semantics of arm64_notify_segfault.  The use of this helper in
swp_handler and user_cache_main_handler is clearly for the purposes of
instruction emulation.  With instruction emulation it is a bug if the
emulated instruction behaves differently than a real instruction in
the same circumstances.

To properly fix the instruction emulation in arm64_notify_segfault it
looks to me that the proper solution is to call __do_page_fault or
handle_mm_fault the way do_page_fault does and them parse the VM_FAULT
code for which signal to generate.

I would probably rename arm64_notify_segfault to arm64_emulate_fault, or
possibly arm64_notify_fault while fixing the emulation so that it
can return different signals and so that people don't have to guess
what the function is supposed to do.

For the specific case of sigreturn and rt_sigreturn it looks sufficient
to use the fixed arm64_notify_segfault.  As it appears the that the code
is attempting to act like it is emulating an instruction that does not
exist.


There is an argument that sigreturn and rt_sigreturn do a poor enough
job of acting like the fault was caused by an instruction, as well
as failing for other reasons it might make more sense to just have
sigreturn and rt_sigreturn call "force_sig(SIGSEGV);"  But that seems
out of scope of what you are trying to fix right now so I would not
worry about it.

Eric
