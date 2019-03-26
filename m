Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237EBC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03326206DF
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbfCZSoX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:44:23 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:34296 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732424AbfCZSoX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Mar 2019 14:44:23 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 514B86C0085;
        Tue, 26 Mar 2019 18:44:21 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 26 Mar
 2019 11:44:17 -0700
Subject: Re: [PATCH/RFC bpf-next 04/16] bpf: mark sub-register writes that
 really need zero extension to high bits
To:     Jiong Wang <jiong.wang@netronome.com>
CC:     <alexei.starovoitov@gmail.com>, <daniel@iogearbox.net>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <oss-drivers@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <4a397d16-2ee4-e58e-0091-9df7a20b07b9@solarflare.com>
Date:   Tue, 26 Mar 2019 18:44:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24512.005
X-TM-AS-Result: No-16.860000-4.000000-10
X-TMASE-MatchedRID: byfwvk+IcRmi6/VcDv9f0Bn0UD4GU5IqjLOy13Cgb4+qvcIF1TcLYMHt
        HEmxq9+Y+CYVwGU1gvtdi52T8vo0tAEzlKcqjzGclUgQqGVMqmwZKp0SZ4P+ddvpj5+dNlQvv6b
        dYEGVmBlYcsSFpEziFQy0hjrIfynujPNWW0qddWgOrlBkQa9qFsdvO1Rp+sgmRTck7NznBP+7oc
        5+QkIZgZqPaFiUZHVXJ05geZ8ORjKOUvUSGKdRPlVN8laWo90MQPCWRE0Lo8JzudJS0nma3sLNB
        p33aCfIwOalMNNoWHb9WmOXRY9537sl8Gv1eXkKY1bQMCMvmn6y4iyjvVWTomHZ+cd7VyKXcNio
        SkggDzl9DsRKD0Q+rMJYQmX94n8B+g3TEidc8f9gHklFeVzHAH0tCKdnhB581B0Hk1Q1KyLUZxE
        AlFPo8/cUt5lc1lLgoGRyAacnhaaxsybimQfSz8LS5wS+noFLsTqwwCY+F9SCfSXYYLKsYn7cGd
        19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.860000-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24512.005
X-MDID: 1553625861-y_LDQ1wdx46F
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/03/2019 18:05, Jiong Wang wrote:
> eBPF ISA specification requires high 32-bit cleared when low 32-bit
> sub-register is written. This applies to destination register of ALU32 etc.
> JIT back-ends must guarantee this semantic when doing code-gen.
>
> x86-64 and arm64 ISA has the same semantic, so the corresponding JIT
> back-end doesn't need to do extra work. However, 32-bit arches (arm, nfp
> etc.) and some other 64-bit arches (powerpc, sparc etc), need explicit zero
> extension sequence to meet such semantic.
>
> This is important, because for code the following:
>
>   u64_value = (u64) u32_value
>   ... other uses of u64_value
>
> compiler could exploit the semantic described above and save those zero
> extensions for extending u32_value to u64_value. Hardware, runtime, or BPF
> JIT back-ends, are responsible for guaranteeing this. Some benchmarks show
> ~40% sub-register writes out of total insns, meaning ~40% extra code-gen (
> could go up to more for some arches which requires two shifts for zero
> extension) because JIT back-end needs to do extra code-gen for all such
> instructions.
>
> However this is not always necessary in case u32_value is never cast into
> a u64, which is quite normal in real life program. So, it would be really
> good if we could identify those places where such type cast happened, and
> only do zero extensions for them, not for the others. This could save a lot
> of BPF code-gen.
>
> Algo:
>  - Record indices of instructions that do sub-register def (write). And
>    these indices need to stay with function state so path pruning and bpf
>    to bpf function call could be handled properly.
>
>    These indices are kept up to date while doing insn walk.
>
>  - A full register read on an active sub-register def marks the def insn as
>    needing zero extension on dst register.
>
>  - A new sub-register write overrides the old one.
>
>    A new full register write makes the register free of zero extension on
>    dst register.
>
>  - When propagating register read64 during path pruning, it also marks def
>    insns whose defs are hanging active sub-register, if there is any read64
>    from shown from the equal state.
>
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  include/linux/bpf_verifier.h |  4 +++
>  kernel/bpf/verifier.c        | 85 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 84 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 27761ab..0ae9a3f 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -181,6 +181,9 @@ struct bpf_func_state {
>  	 */
>  	u32 subprogno;
>  
> +	/* tracks subreg definition. */
Ideally this comment should mention that the stored value is the insn_idx
 of the writing insn.  Perhaps also that this is safe because patching
 (bpf_patch_insn_data()) only happens after main verification completes.

-Ed
