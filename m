Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAFBC433B4
	for <bpf@archiver.kernel.org>; Fri, 30 Apr 2021 19:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC036147E
	for <bpf@archiver.kernel.org>; Fri, 30 Apr 2021 19:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhD3T6m (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 30 Apr 2021 15:58:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52964 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhD3T6i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 15:58:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcZGl-00CbjW-SR; Fri, 30 Apr 2021 13:57:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcZGk-006rml-TA; Fri, 30 Apr 2021 13:57:47 -0600
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
        <m1czud6krk.fsf@fess.ebiederm.org>
        <20210430184757.mez7ujmyzm43g6z2@revolver>
Date:   Fri, 30 Apr 2021 14:57:43 -0500
In-Reply-To: <20210430184757.mez7ujmyzm43g6z2@revolver> (Liam Howlett's
        message of "Fri, 30 Apr 2021 18:48:08 +0000")
Message-ID: <m1y2cztuiw.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcZGk-006rml-TA;;;mid=<m1y2cztuiw.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX193jyYvw9ExaIXEwhjbHkEscuNo2S9lCZ8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/3] arm64: signal: sigreturn() and rt_sigreturn() sometime returns the wrong signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Liam Howlett <liam.howlett@oracle.com> writes:

> This is way out of scope for what I'm doing.  I'm trying to fix a call
> to the wrong mm API.  I was trying to clean up any obvious errors in
> calling functions which were exposed by fixing that error.  If you want
> this fixed differently, then please go ahead and tackle the problems you
> see.

I was asked by the arm maintainers to describe what the code should be
doing here.  I hope I have done that.

What is very interesting is that the code in __do_page_fault does not
use find_vma_intersection it uses find_vma.  Which suggests that
find_vma_intersection may not be the proper mm api.

The logic is:

From __do_page_fault:
	struct vm_area_struct *vma = find_vma(mm, addr);

	if (unlikely(!vma))
		return VM_FAULT_BADMAP;

	/*
	 * Ok, we have a good vm_area for this memory access, so we can handle
	 * it.
	 */
	if (unlikely(vma->vm_start > addr)) {
		if (!(vma->vm_flags & VM_GROWSDOWN))
			return VM_FAULT_BADMAP;
		if (expand_stack(vma, addr))
			return VM_FAULT_BADMAP;
	}

	/*
	 * Check that the permissions on the VMA allow for the fault which
	 * occurred.
	 */
	if (!(vma->vm_flags & vm_flags))
		return VM_FAULT_BADACCESS;

From do_page_fault:

	arm64_force_sig_fault(SIGSEGV,
			      fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR,
			      far, inf->name);


Hmm.  If the expand_stack step is skipped. Does is the logic equivalent
to find_vma_intersection?

	static inline struct vm_area_struct *find_vma_intersection(
        	struct mm_struct * mm,
                unsigned long start_addr,
                unsigned long end_addr)
	{
		struct vm_area_struct * vma = find_vma(mm,start_addr);
	
		if (vma && end_addr <= vma->vm_start)
			vma = NULL;
		return vma;
	}

Yes. It does look that way.  VM_FAULT_BADMAP is returned when a vma
covering the specified address is not found.  And VM_FAULT_BADACCESS is
returned when there is a vma and there is a permission problem.

There are also two SIGBUS cases that arm64_notify_segfault does not
handle.

So it appears changing arm64_notify_segfault to use
find_vma_intersection instead of find_vma would be a correct but
incomplete fix.

I don't see a point in changing sigerturn or rt_sigreturn.

Eric
