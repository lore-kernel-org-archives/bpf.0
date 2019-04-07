Return-Path: <SRS0=hr/i=SJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBF4C282DA
	for <bpf@archiver.kernel.org>; Sun,  7 Apr 2019 02:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1534A2171F
	for <bpf@archiver.kernel.org>; Sun,  7 Apr 2019 02:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ue3VLsDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDGCvd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 6 Apr 2019 22:51:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34611 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfDGCvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Apr 2019 22:51:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so5542221pfd.1;
        Sat, 06 Apr 2019 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q6n+yGxeOv6TDeSaZLNLoCXeT14MGMyKjlzRscTfaSQ=;
        b=ue3VLsDDz5mJVQOF7207OuXTs4VJ6H824TlE797xJgmRr/AcvZ5JvebMyedd+Z9Mex
         N+2Mf2TXyD4XaO40KGnmGv3uTe0V03mWs4c8t8fODe3i/f+bJIyW8krUUPyOWPm6gQxu
         yBGW0UEAtnvM8xgjwtK6LBsGUBG2ozR+cEgLGo0NVc7IaktFDD4SlnwgWU2nVFhr0RDl
         ZxwWO6zC92C3aCaM29i/kRxIX5JMXOET56xXqKNDPz5mPxKAO/CRrnQA4BbN7RzlwF9K
         jw5QfWBbyglte3o8W4RwlGJr8k+2YHYRyzLHBB/qhP8R++fLCok+8DFxHbtKVWN4Vdgo
         2+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q6n+yGxeOv6TDeSaZLNLoCXeT14MGMyKjlzRscTfaSQ=;
        b=FleBTghRj4OXEaouy7qVN5h5lBTBH1Tq9lsg4JyRL1GrzruZ08ikUJX3Im86LSMn2G
         XJUCm9f8coNqv2rtkOvY9UynoHBR0oca0McK6tPMs27EiuFMZuNQQ+Av+lSg0A31YCdm
         7StQ+tCok1Rxorg3UBf9yoYBznnWFghfcomvW/57YLOWi14MeS0tdJJ0z87QErXtQvpw
         nJh18gBAY0Omy30BT6bb534lvrxNm4JYGFL733t8Yd68hEV0JQpeeV3toL5mggMYOXnZ
         p4h3MSknSds5pKjR5+Oa2Wf/F8diKGBsV6HJDWZI+7MdQFweKUxuIb4u5YiadZpXtHU9
         gv/g==
X-Gm-Message-State: APjAAAW1j4+fZ/Gv/XukfktwGaGbye5OXcvo/ulBPVNL429FC92PgqkR
        +ZI0vttIxOKvZnByrCjBhkSQk1gL
X-Google-Smtp-Source: APXvYqw1+auDlzbc7xzjdvmm7tRJQj6qZaki9bmIrlRdIw0rG9FRJ+xakqccJq6f7/wUkuTy2W9TfQ==
X-Received: by 2002:a65:5941:: with SMTP id g1mr21276745pgu.51.1554605492335;
        Sat, 06 Apr 2019 19:51:32 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::ac9e])
        by smtp.gmail.com with ESMTPSA id 4sm34661243pfn.159.2019.04.06.19.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 19:51:31 -0700 (PDT)
Date:   Sat, 6 Apr 2019 19:51:29 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 04/16] bpf: mark sub-register writes that
 really need zero extension to high bits
Message-ID: <20190407025128.zeiyn2gslwy4ngxo@ast-mbp.dhcp.thefacebook.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
 <4a397d16-2ee4-e58e-0091-9df7a20b07b9@solarflare.com>
 <CF673672-983B-4848-B97C-1344309C1E8D@netronome.com>
 <20190406034110.o2qzjyl57ypzal3z@ast-mbp.dhcp.thefacebook.com>
 <87r2afd3l2.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2afd3l2.fsf@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 06, 2019 at 07:56:25AM +0100, Jiong Wang wrote:
> 
> Alexei Starovoitov writes:
> 
> > On Fri, Apr 05, 2019 at 09:44:49PM +0100, Jiong Wang wrote:
> >> 
> >> > On 26 Mar 2019, at 18:44, Edward Cree <ecree@solarflare.com> wrote:
> >> > 
> >> > On 26/03/2019 18:05, Jiong Wang wrote:
> >> >> eBPF ISA specification requires high 32-bit cleared when low 32-bit
> >> >> sub-register is written. This applies to destination register of ALU32 etc.
> >> >> JIT back-ends must guarantee this semantic when doing code-gen.
> >> >> 
> >> >> x86-64 and arm64 ISA has the same semantic, so the corresponding JIT
> >> >> back-end doesn't need to do extra work. However, 32-bit arches (arm, nfp
> >> >> etc.) and some other 64-bit arches (powerpc, sparc etc), need explicit zero
> >> >> extension sequence to meet such semantic.
> >> >> 
> >> >> This is important, because for code the following:
> >> >> 
> >> >>  u64_value = (u64) u32_value
> >> >>  ... other uses of u64_value
> >> >> 
> >> >> compiler could exploit the semantic described above and save those zero
> >> >> extensions for extending u32_value to u64_value. Hardware, runtime, or BPF
> >> >> JIT back-ends, are responsible for guaranteeing this. Some benchmarks show
> >> >> ~40% sub-register writes out of total insns, meaning ~40% extra code-gen (
> >> >> could go up to more for some arches which requires two shifts for zero
> >> >> extension) because JIT back-end needs to do extra code-gen for all such
> >> >> instructions.
> >> >> 
> >> >> However this is not always necessary in case u32_value is never cast into
> >> >> a u64, which is quite normal in real life program. So, it would be really
> >> >> good if we could identify those places where such type cast happened, and
> >> >> only do zero extensions for them, not for the others. This could save a lot
> >> >> of BPF code-gen.
> >> >> 
> >> >> Algo:
> >> >> - Record indices of instructions that do sub-register def (write). And
> >> >>   these indices need to stay with function state so path pruning and bpf
> >> >>   to bpf function call could be handled properly.
> >> >> 
> >> >>   These indices are kept up to date while doing insn walk.
> >> >> 
> >> >> - A full register read on an active sub-register def marks the def insn as
> >> >>   needing zero extension on dst register.
> >> >> 
> >> >> - A new sub-register write overrides the old one.
> >> >> 
> >> >>   A new full register write makes the register free of zero extension on
> >> >>   dst register.
> >> >> 
> >> >> - When propagating register read64 during path pruning, it also marks def
> >> >>   insns whose defs are hanging active sub-register, if there is any read64
> >> >>   from shown from the equal state.
> >> >> 
> >> >> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> >> >> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> >> >> ---
> >> >> include/linux/bpf_verifier.h |  4 +++
> >> >> kernel/bpf/verifier.c        | 85 +++++++++++++++++++++++++++++++++++++++++---
> >> >> 2 files changed, 84 insertions(+), 5 deletions(-)
> >> >> 
> >> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> >> >> index 27761ab..0ae9a3f 100644
> >> >> --- a/include/linux/bpf_verifier.h
> >> >> +++ b/include/linux/bpf_verifier.h
> >> >> @@ -181,6 +181,9 @@ struct bpf_func_state {
> >> >> 	 */
> >> >> 	u32 subprogno;
> >> >> 
> >> >> +	/* tracks subreg definition. */
> >> > Ideally this comment should mention that the stored value is the insn_idx
> >> >  of the writing insn.  Perhaps also that this is safe because patching
> >> >  (bpf_patch_insn_data()) only happens after main verification completes.
> >> 
> >> During full x86_64 host tests, found one new issue.                                    
> >>                                                                                          
> >> “convert_ctx_accesses” will change load size, A BPF_W load could be transformed          
> >> into BPF_DW or kept as BPF_W depending on the underlying ctx field size. And             
> >> “convert_ctx_accesses” happens after zero extension insertion.                           
> >>                                                                                          
> >> So, a BPF_W load could have been marked and zero extensions inserted after               
> >> it, however, the later happened “convert_ctx_accesses” then figured out it’s             
> >> transformed load size is actually BPF_DW then re-write to that. But the                  
> >> previously inserted zero extensions then break things, the high 32 bits are              
> >> wrongly cleared. For example:
> >> 
> >> 1: r2 = *(u32 *)(r1 + 80)                                                                
> >> 2: r1 = *(u32 *)(r1 + 76)                                                                
> >> 3: r3 = r1                                                                               
> >> 4: r3 += 14                                                                              
> >> 5: if r3 > r2 goto +35                                                                   
> >>                                                                                          
> >> insn 1 and 2 could be turned into BPF_DW load if they are loading xdp “data"
> >> and “data_end". There shouldn’t be zero-extension inserted after them will
> >> will destroy the pointer. However they are treated as 32-bit load initially,
> >> and later due to 64-bit use at insn 3 and 5, they are marked as needing zero
> >> extension.                                                                        
> >>                                                                                          
> >> I am thinking normally the field sizes in *_md inside uapi/linux/bpf.h are
> >> the same those in real underlying context, only when one field is pointer
> >> type, then it could be possible be a u32 to u64 conversion. So, I guess
> >> we just need to mark the dst register as a full 64-bit register write 
> >> inside check_mem_access when for PTR_TO_CTX, the reg type of the dust reg
> >> returned by check_ctx_access is ptr type.
> >
> > Since the register containing ctx->data was used later in the load insn and
> > it's type was pointer the analysis should have marked it as 64-bit access.
> >
> > It feels that there is an issue in propagating 64-bit access through
> > parentage chain. Since insn 5 above recognized r2 as 64-bit access
> > then how come insn 1 was still allowed to poison upper bits?
> 
> Guess my description was misleading. The high bits of insn 1 was not
> poisoned, they are truncated, the analysis pass is correct here.
> 
> It is a BPF_W (4-byte) load, so initially it is marked as a sub-register
> def and JIT compiler doesn't need to guarantee high 32-bit cleared. However
> later insn 5 found it has a 64-bit use (as 64-bit operand in the
> comparison), so it become mandatory to guarantee high 32-bit cleared, so
> sequence transformed into:
> 
> 1: r2 = *(u32 *)(r1 + 80)
> 2. r2 <<= 32
> 3. r2 >>= 32
> 4: r1 = *(u32 *)(r1 + 76)
> 5: r1 <<=  32
> 6: r1 >>= 32
> 5: r3 = r1                                                                               
> 6: r3 += 14                                                                              
> 7: if r3 > r2 goto +35
> 
> After the zero extension insertion, later in convert_ctx_access, it will
> be further transformed into something like:
> 
> 1: r2 = *(u64 *)(r1 + 80)
> 2. r2 <<= 32
> 3. r2 >>= 32
> 
> However, the inserted zero extension (insn 2/3) is still there and will
> clear the high 32-bit of the loaded 64-bit value.
> 
> This issue should have been exposed before. But as described in the cover
> letter, the opt is disabled on x86, my previous test methodology on x86 was
> forcing it on through sysctl for a couple of insn matching unit tests only,
> and was hoping other host arches like ppc could give it a full run on bpf
> selftest before which the correctness of the opt was not verified by full
> bpf selftest. I have done full run of some internal offload tests which
> could be a good coverage, but the offload handles PTR_TO_CTX in a different
> way so this issue was not caught.
> 
> Now as you suggested, the test methodology switched to poisoning high
> 32-bit on x86, so full test on bpf selftest is able to be enabled on x86
> test and this issue is caught.

Got it. Yes. checking that check_ctx_access returns ptr type will be enough.

