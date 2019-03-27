Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA9C10F00
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 16:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F410C206C0
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 16:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd44aY68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfC0QvC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:51:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37381 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfC0QvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 12:51:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so9981665pfr.4;
        Wed, 27 Mar 2019 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXsxhPH1L3ZwxCPMMKriBEHkrjXjM9tw5FpQyT5nJZI=;
        b=Pd44aY68UAFRUCr9y8LCpH2U7e2c/IiWyvD/h9ddZMg5lKd2vEi90uoOu6akjB5v3R
         92WH7T0+CjAXjIFVZRVnCHpek2Ui3th9rIu0vyhQz2OjneqLPANcvgeXV01Z1svTbIzG
         T8lK6Rg2cP9DFaSh0XX63HnpnXlyP71c0/usuFCl8Pw99hB0LqvvvlInDdN0uoD5eHTn
         FQO/JDfDTIEc2P/UAnVJrdYkpkzPIqwXPfDsTyhDtctIdRALGy7MQgn//YIpRrfl31vw
         T1X3beuHVHdj3MY8Sqy8J5CI2lgCKe2AsLejVqIYSEIQfJitff0X7F52NgER4Hyk/POH
         iaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXsxhPH1L3ZwxCPMMKriBEHkrjXjM9tw5FpQyT5nJZI=;
        b=cjSxpeQgEV/2QjcBOxMD005ZzhctF1nHRqtJZbDNUMdYPoA7HQcFCq87nB4P+l6rMZ
         I5qJv7FsOa/3Hj4+x5EwUqS+DYk93HwBfnLiPtS4K0ljyMbo3mrRo4Uu4L82f7V357ja
         xzmKYaFKifU8X6qJ8xnzxgK+N8NfOMJ+cjT1LEoLw2Oap+jXlNWkYPaUVDnGHJdxQrE4
         jWb8nidyhQcLK97vJEVTi84vjhJdIHQdBK6gqxrNjfg+zgWotq2Hpw68u2PIxdWeXKvf
         renmafu8sJa0Uj8NS1ffB6Ycxp9iQ0ZXS1GyoTOXvIUy0m0PldAdPPqGph96be+F7m/q
         OE7g==
X-Gm-Message-State: APjAAAVMTEeNcIjNeS2E40Gb0Wy/Sgtxicz/qEjCoEoxEBx6PqGausSd
        5yESUgosm0NhuM8oCH50qKFSNGs3
X-Google-Smtp-Source: APXvYqySsDEP4doZp8iUu5vF8bmR+4HFXmX6UQAFF5PvvfKAcDssdFpvW/hEW+I64gQRLzyRn+PK4A==
X-Received: by 2002:a65:6259:: with SMTP id q25mr7506350pgv.103.1553705461077;
        Wed, 27 Mar 2019 09:51:01 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::ca40])
        by smtp.gmail.com with ESMTPSA id k12sm28400482pfk.109.2019.03.27.09.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:51:00 -0700 (PDT)
Date:   Wed, 27 Mar 2019 09:50:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 04/16] bpf: mark sub-register writes that
 really need zero extension to high bits
Message-ID: <20190327165057.mzk52t5wedtyf7fl@ast-mbp>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 06:05:27PM +0000, Jiong Wang wrote:
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
> +	s32 subreg_def[MAX_BPF_REG];

Same comment as Ed and another question: why it's not part of bpf_reg_state ?

