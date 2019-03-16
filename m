Return-Path: <SRS0=MJ0i=RT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC23C43381
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 00:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F934218AC
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 00:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfCPAbT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 20:31:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:38266 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCPAbT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 20:31:19 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h4xDu-00077H-6y; Sat, 16 Mar 2019 01:30:50 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h4xDu-000VZ9-0t; Sat, 16 Mar 2019 01:30:50 +0100
Subject: Re: [PATCH] powerpc: bpf: Fix generation of load/store DW
 instructions
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20190315145119.2776-1-naveen.n.rao@linux.vnet.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <acd52bd9-eef1-fd0b-f81d-83b653535839@iogearbox.net>
Date:   Sat, 16 Mar 2019 01:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190315145119.2776-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25389/Fri Mar 15 08:52:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/15/2019 03:51 PM, Naveen N. Rao wrote:
> Yauheni Kaliuta pointed out that PTR_TO_STACK store/load verifier test
> was failing on powerpc64 BE, and rightfully indicated that the PPC_LD()
> macro is not masking away the last two bits of the offset per the ISA,
> resulting in the generation of 'lwa' instruction instead of the intended
> 'ld' instruction.
> 
> Segher also pointed out that we can't simply mask away the last two bits
> as that will result in loading/storing from/to a memory location that
> was not intended.
> 
> This patch addresses this by using ldx/stdx if the offset is not
> word-aligned. We load the offset into a temporary register (TMP_REG_2)
> and use that as the index register in a subsequent ldx/stdx. We fix
> PPC_LD() macro to mask off the last two bits, but enhance PPC_BPF_LL()
> and PPC_BPF_STL() to factor in the offset value and generate the proper
> instruction sequence. We also convert all existing users of PPC_LD() and
> PPC_STD() to use these macros. All existing uses of these macros have
> been audited to ensure that TMP_REG_2 can be clobbered.
> 
> Fixes: 156d0e290e96 ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> Cc: stable@vger.kernel.org # v4.9+
> 
> Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied, thanks!
