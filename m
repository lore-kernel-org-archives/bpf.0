Return-Path: <SRS0=Rhtb=SI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F202FC282DC
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 06:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3FC20879
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 06:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Dts4o8yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfDFG4f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:56:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDFG4e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Apr 2019 02:56:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so10375828wro.5
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2019 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RmfFzPkhMMdHZTyrtfpr77+FK0/WwqMtR5blehpY71k=;
        b=Dts4o8yVuaxazHtSf+tV8yhbavz6QFKPxHhAKgtdEjC83gCHjihG4HcRo5tYjDhIsC
         uLMh9JLvoeXOkZzm4VPGKjxoh4hhRzSjgolUENkDey9yvBx/gkV06oekNZG3UEoXPiMe
         0y5sgrRenDvEiSxmB/pnxboXrhBO4CyRlX1ki8TVRkcH8MYjpfmnTvUpy3mIqJws36Z9
         AedOvj4PpEv1dGs4dh3F9+N1wgT2s12gn9i+Ka5jcA8prjIg7el4US18rbxBQSwhTYgF
         8/x25r47ULVMx8THZYyNV2PkcJ1GunRNE8G5TrebM45D2OeejuoYs9g2RKDb2MndnKVc
         4SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RmfFzPkhMMdHZTyrtfpr77+FK0/WwqMtR5blehpY71k=;
        b=WG4dBmvt+8NzbPzm5a6BTc9lARp4oORnzDgLUBEeRdi80LIoZNnXefQIbOi2K87a10
         TI2BthH5Z/G04GUlsgU9fZWaxL7iNDXhdF9IlojGpCossdoNX78TiUTL2dYSV9GUuYRw
         X4JduKomuxf9BBK94vDfX54n6jJty2ZJpC1I3FYCV0diYwcjc/VF10R8Q0y+a6id8Xl8
         grAN1ZSQNB9xAbHLx2QcnUlzX9Zvouz/UaaqTDss/33FkLVXwxwDy3SvPvBDrRIIaQGW
         bIeb4Ir75UMQfzK01QsLFwsTmCHe5iGQyCaRLPMxK8fOWLCPJuOV4WgbGpSUEInS8lw9
         ldrg==
X-Gm-Message-State: APjAAAWkx/PnsumuBa2uuLDpfLVnDu3udxhBxDZcJmN9cFdeGMwxr9ww
        6W0V2R986aqiOQ3zw0vsy2pppA==
X-Google-Smtp-Source: APXvYqz0D0mVH23n77z75SfUdcT6TpOLoZVMPqFPArXQ6KmP1W5V2+3LlyuEytGUlaZf8mgTy/u93g==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr10673163wrj.182.1554533792095;
        Fri, 05 Apr 2019 23:56:32 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id n13sm27677288wrw.67.2019.04.05.23.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:56:31 -0700 (PDT)
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com> <1553623539-15474-5-git-send-email-jiong.wang@netronome.com> <4a397d16-2ee4-e58e-0091-9df7a20b07b9@solarflare.com> <CF673672-983B-4848-B97C-1344309C1E8D@netronome.com> <20190406034110.o2qzjyl57ypzal3z@ast-mbp.dhcp.thefacebook.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 04/16] bpf: mark sub-register writes that really need zero extension to high bits
In-reply-to: <20190406034110.o2qzjyl57ypzal3z@ast-mbp.dhcp.thefacebook.com>
Date:   Sat, 06 Apr 2019 07:56:25 +0100
Message-ID: <87r2afd3l2.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Fri, Apr 05, 2019 at 09:44:49PM +0100, Jiong Wang wrote:
>> 
>> > On 26 Mar 2019, at 18:44, Edward Cree <ecree@solarflare.com> wrote:
>> > 
>> > On 26/03/2019 18:05, Jiong Wang wrote:
>> >> eBPF ISA specification requires high 32-bit cleared when low 32-bit
>> >> sub-register is written. This applies to destination register of ALU32 etc.
>> >> JIT back-ends must guarantee this semantic when doing code-gen.
>> >> 
>> >> x86-64 and arm64 ISA has the same semantic, so the corresponding JIT
>> >> back-end doesn't need to do extra work. However, 32-bit arches (arm, nfp
>> >> etc.) and some other 64-bit arches (powerpc, sparc etc), need explicit zero
>> >> extension sequence to meet such semantic.
>> >> 
>> >> This is important, because for code the following:
>> >> 
>> >>  u64_value = (u64) u32_value
>> >>  ... other uses of u64_value
>> >> 
>> >> compiler could exploit the semantic described above and save those zero
>> >> extensions for extending u32_value to u64_value. Hardware, runtime, or BPF
>> >> JIT back-ends, are responsible for guaranteeing this. Some benchmarks show
>> >> ~40% sub-register writes out of total insns, meaning ~40% extra code-gen (
>> >> could go up to more for some arches which requires two shifts for zero
>> >> extension) because JIT back-end needs to do extra code-gen for all such
>> >> instructions.
>> >> 
>> >> However this is not always necessary in case u32_value is never cast into
>> >> a u64, which is quite normal in real life program. So, it would be really
>> >> good if we could identify those places where such type cast happened, and
>> >> only do zero extensions for them, not for the others. This could save a lot
>> >> of BPF code-gen.
>> >> 
>> >> Algo:
>> >> - Record indices of instructions that do sub-register def (write). And
>> >>   these indices need to stay with function state so path pruning and bpf
>> >>   to bpf function call could be handled properly.
>> >> 
>> >>   These indices are kept up to date while doing insn walk.
>> >> 
>> >> - A full register read on an active sub-register def marks the def insn as
>> >>   needing zero extension on dst register.
>> >> 
>> >> - A new sub-register write overrides the old one.
>> >> 
>> >>   A new full register write makes the register free of zero extension on
>> >>   dst register.
>> >> 
>> >> - When propagating register read64 during path pruning, it also marks def
>> >>   insns whose defs are hanging active sub-register, if there is any read64
>> >>   from shown from the equal state.
>> >> 
>> >> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> >> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> >> ---
>> >> include/linux/bpf_verifier.h |  4 +++
>> >> kernel/bpf/verifier.c        | 85 +++++++++++++++++++++++++++++++++++++++++---
>> >> 2 files changed, 84 insertions(+), 5 deletions(-)
>> >> 
>> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> >> index 27761ab..0ae9a3f 100644
>> >> --- a/include/linux/bpf_verifier.h
>> >> +++ b/include/linux/bpf_verifier.h
>> >> @@ -181,6 +181,9 @@ struct bpf_func_state {
>> >> 	 */
>> >> 	u32 subprogno;
>> >> 
>> >> +	/* tracks subreg definition. */
>> > Ideally this comment should mention that the stored value is the insn_idx
>> >  of the writing insn.  Perhaps also that this is safe because patching
>> >  (bpf_patch_insn_data()) only happens after main verification completes.
>> 
>> During full x86_64 host tests, found one new issue.                                    
>>                                                                                          
>> “convert_ctx_accesses” will change load size, A BPF_W load could be transformed          
>> into BPF_DW or kept as BPF_W depending on the underlying ctx field size. And             
>> “convert_ctx_accesses” happens after zero extension insertion.                           
>>                                                                                          
>> So, a BPF_W load could have been marked and zero extensions inserted after               
>> it, however, the later happened “convert_ctx_accesses” then figured out it’s             
>> transformed load size is actually BPF_DW then re-write to that. But the                  
>> previously inserted zero extensions then break things, the high 32 bits are              
>> wrongly cleared. For example:
>> 
>> 1: r2 = *(u32 *)(r1 + 80)                                                                
>> 2: r1 = *(u32 *)(r1 + 76)                                                                
>> 3: r3 = r1                                                                               
>> 4: r3 += 14                                                                              
>> 5: if r3 > r2 goto +35                                                                   
>>                                                                                          
>> insn 1 and 2 could be turned into BPF_DW load if they are loading xdp “data"
>> and “data_end". There shouldn’t be zero-extension inserted after them will
>> will destroy the pointer. However they are treated as 32-bit load initially,
>> and later due to 64-bit use at insn 3 and 5, they are marked as needing zero
>> extension.                                                                        
>>                                                                                          
>> I am thinking normally the field sizes in *_md inside uapi/linux/bpf.h are
>> the same those in real underlying context, only when one field is pointer
>> type, then it could be possible be a u32 to u64 conversion. So, I guess
>> we just need to mark the dst register as a full 64-bit register write 
>> inside check_mem_access when for PTR_TO_CTX, the reg type of the dust reg
>> returned by check_ctx_access is ptr type.
>
> Since the register containing ctx->data was used later in the load insn and
> it's type was pointer the analysis should have marked it as 64-bit access.
>
> It feels that there is an issue in propagating 64-bit access through
> parentage chain. Since insn 5 above recognized r2 as 64-bit access
> then how come insn 1 was still allowed to poison upper bits?

Guess my description was misleading. The high bits of insn 1 was not
poisoned, they are truncated, the analysis pass is correct here.

It is a BPF_W (4-byte) load, so initially it is marked as a sub-register
def and JIT compiler doesn't need to guarantee high 32-bit cleared. However
later insn 5 found it has a 64-bit use (as 64-bit operand in the
comparison), so it become mandatory to guarantee high 32-bit cleared, so
sequence transformed into:

1: r2 = *(u32 *)(r1 + 80)
2. r2 <<= 32
3. r2 >>= 32
4: r1 = *(u32 *)(r1 + 76)
5: r1 <<=  32
6: r1 >>= 32
5: r3 = r1                                                                               
6: r3 += 14                                                                              
7: if r3 > r2 goto +35

After the zero extension insertion, later in convert_ctx_access, it will
be further transformed into something like:

1: r2 = *(u64 *)(r1 + 80)
2. r2 <<= 32
3. r2 >>= 32

However, the inserted zero extension (insn 2/3) is still there and will
clear the high 32-bit of the loaded 64-bit value.

This issue should have been exposed before. But as described in the cover
letter, the opt is disabled on x86, my previous test methodology on x86 was
forcing it on through sysctl for a couple of insn matching unit tests only,
and was hoping other host arches like ppc could give it a full run on bpf
selftest before which the correctness of the opt was not verified by full
bpf selftest. I have done full run of some internal offload tests which
could be a good coverage, but the offload handles PTR_TO_CTX in a different
way so this issue was not caught.

Now as you suggested, the test methodology switched to poisoning high
32-bit on x86, so full test on bpf selftest is able to be enabled on x86
test and this issue is caught.

Regards,
Jiong
