Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AD7C433DB
	for <bpf@archiver.kernel.org>; Wed, 13 Jan 2021 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217D5206EC
	for <bpf@archiver.kernel.org>; Wed, 13 Jan 2021 10:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbhAMKQ5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:16:57 -0500
Received: from foss.arm.com ([217.140.110.172]:33676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbhAMKQ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 05:16:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BE7D1042;
        Wed, 13 Jan 2021 02:16:10 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A343F66E;
        Wed, 13 Jan 2021 02:16:09 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:16:06 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] trace: bpf: Allow bpf to attach to bare
 tracepoints
Message-ID: <20210113101606.lpsn4scnsecdfxwr@e107158-lin>
References: <20210111182027.1448538-1-qais.yousef@arm.com>
 <20210111182027.1448538-2-qais.yousef@arm.com>
 <8ef6c8e8-c462-a780-b1ab-b7f2e4fa9836@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ef6c8e8-c462-a780-b1ab-b7f2e4fa9836@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/12/21 12:19, Yonghong Song wrote:
> I applied the patch to my local bpf-next repo, and got the following
> compilation error:

[...]

> 
> I dumped preprecessor result but after macro expansion, the code
> becomes really complex and I have not figured out why it failed.
> Do you know what is the possible reason?

Yeah I did a last minute fix to address a checkpatch.pl error and my
verification of the change wasn't good enough obviously.

If you're keen to try out I can send you a patch with the fix. I should send v2
by the weekend too.

Thanks for having a look.

Cheers

--
Qais Yousef
