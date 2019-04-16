Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE703C10F14
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 20:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648AF20684
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 20:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="w0OyMQe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfDPUTz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:19:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPUTy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 16:19:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so607201wml.4
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 13:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=25Q/69VpTaIt4MLdom89c8x5p5970jgm4uaZO0w8N90=;
        b=w0OyMQe3WGL080SPamxNCrgwnbJw151HBCB4+8mKyrq+I3agRGVOKoACx30U8qnCkY
         w5TkRxeLzfNaIe+tNa/S3lqPWll2gBapc4SJKNENnz0h3QPVXAiQmTuKpjj56+TwU8tX
         gu1VTjJAzpZrs7HwgxayQOHYdLfs2B3j/hbu/Wbqzzhfbwv8FNphHQg3Q/Rgk/6kZvAf
         LPQcaL/GvVB1w8m4Ehv85R4eQETOU8ZMSIc5jiK1uWIyT2gWDmHXNqU7ttecWZFgrhIy
         Pbu7gtz7K608l+inDOqXWgceITCbbH1eADYC5U3FhO+AdVI5/je8KVMnJ7eoPh48k5l2
         /DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=25Q/69VpTaIt4MLdom89c8x5p5970jgm4uaZO0w8N90=;
        b=LsOS6RjJ7sNtDJG8iF9APeke6Idgmj/VGEzm+rq+rtJay+kPGqWsLxgoCZRB27QOsh
         +2p7/E6hK41gfannpigXmUmNV6Aqlyt+ydE1oepnn8mncpkAjn5H0Gqcr11TqlWb5iVy
         CbpURVQhZiHT15JWn36TM7FBdLXTbL7Ef5lpccgBqgkSgedmY3ltKOv5qzx5kUNREkUH
         vekdypIuzhiTnIu7oI+65lpBDvLXNc6e1LCY6qiuJTvFdPbEBKHuBPhBhiz6xw053a3X
         ktw7Wohf/qNVqUdmEMnPRHyZuFVUcez8UQ8Cnj0WANAqHawhyNfqgv8Tgp8xN6IZ7qny
         GfuA==
X-Gm-Message-State: APjAAAUW1maLw8OOBJkeyGI3pkBEdZR7zGLPcUt3GWIOBomyj3FJrxRA
        +0JiubMOLoSv0HIvX3E/hka3fw==
X-Google-Smtp-Source: APXvYqx/HLnSaJf4131vx9f+PtNjo85DzkNMSKkgcp7LmLblDhcqzgJ9nlR8hTC8aqoEwdXdPMFO8Q==
X-Received: by 2002:a1c:ca07:: with SMTP id a7mr27933979wmg.104.1555445991845;
        Tue, 16 Apr 2019 13:19:51 -0700 (PDT)
Received: from cb-macbook.local (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id a8sm330164wmf.33.2019.04.16.13.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 13:19:51 -0700 (PDT)
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com> <1555349185-12508-2-git-send-email-jiong.wang@netronome.com> <20190416012608.2iahgakw5uqobv6z@ast-mbp.dhcp.thefacebook.com> <lyimveo0ul.fsf@netronome.com> <20190416162022.wsymfdriull5srvo@ast-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
In-reply-to: <20190416162022.wsymfdriull5srvo@ast-mbp.dhcp.thefacebook.com>
Date:   Tue, 16 Apr 2019 21:19:49 +0100
Message-ID: <lyd0llog7u.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Tue, Apr 16, 2019 at 08:39:30AM +0100, Jiong Wang wrote:
>> 
>> Alexei Starovoitov writes:
>> 
>> > On Mon, Apr 15, 2019 at 06:26:11PM +0100, Jiong Wang wrote:
>> >> Register liveness infrastructure doesn't track register read width at the
>> >> moment, while the width information will be needed for the later 32-bit
>> >> safety analysis pass.
>> >> 
>> >> This patch take the first step to split read liveness into REG_LIVE_READ64
>> >> and REG_LIVE_READ32.
>> >> 
>> >> Liveness propagation code are updated accordingly. They are taught to
>> >> understand how to propagate REG_LIVE_READ64 and REG_LIVE_READ32 at the same
>> >> propagation iteration. For example, "mark_reg_read" now propagate "flags"
>> >> which could be multiple read bits instead of the single REG_LIVE_READ64.
>> >> 
>> >> A write still screen off all width of reads.
>> >> 
>> >> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> >> ---
>> >>  include/linux/bpf_verifier.h |   8 +--
>> >>  kernel/bpf/verifier.c        | 119 +++++++++++++++++++++++++++++++++++++++----
>> >>  2 files changed, 115 insertions(+), 12 deletions(-)
>> >> 
>> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> >> index b3ab61f..fba0ebb 100644
>> >> --- a/include/linux/bpf_verifier.h
>> >> +++ b/include/linux/bpf_verifier.h
>> >> @@ -36,9 +36,11 @@
>> >>   */
>> >>  enum bpf_reg_liveness {
>> >>  	REG_LIVE_NONE = 0, /* reg hasn't been read or written this branch */
>> >> -	REG_LIVE_READ, /* reg was read, so we're sensitive to initial value */
>> >> -	REG_LIVE_WRITTEN, /* reg was written first, screening off later reads */
>> >> -	REG_LIVE_DONE = 4, /* liveness won't be updating this register anymore */
>> >> +	REG_LIVE_READ32 = 0x1, /* reg was read, so we're sensitive to initial value */
>> >> +	REG_LIVE_READ64 = 0x2, /* likewise, but full 64-bit content matters */
>> >> +	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
>> >> +	REG_LIVE_WRITTEN = 0x4, /* reg was written first, screening off later reads */
>> >> +	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
>> >>  };
>> >>  
>> >>  struct bpf_reg_state {
>> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> >> index c722015..5784b279 100644
>> >> --- a/kernel/bpf/verifier.c
>> >> +++ b/kernel/bpf/verifier.c
>> >> @@ -1135,7 +1135,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>> >>   */
>> >>  static int mark_reg_read(struct bpf_verifier_env *env,
>> >>  			 const struct bpf_reg_state *state,
>> >> -			 struct bpf_reg_state *parent)
>> >> +			 struct bpf_reg_state *parent, u8 flags)
>> >>  {
>> >>  	bool writes = parent == state->parent; /* Observe write marks */
>> >>  	int cnt = 0;
>> >> @@ -1150,17 +1150,23 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>> >>  				parent->var_off.value, parent->off);
>> >>  			return -EFAULT;
>> >>  		}
>> >> -		if (parent->live & REG_LIVE_READ)
>> >> +		/* The first condition is much more likely to be true than the
>> >> +		 * second, make it checked first.
>> >> +		 */
>> >> +		if ((parent->live & REG_LIVE_READ) == flags ||
>> >> +		    parent->live & REG_LIVE_READ64)
>> >>  			/* The parentage chain never changes and
>> >>  			 * this parent was already marked as LIVE_READ.
>> >>  			 * There is no need to keep walking the chain again and
>> >>  			 * keep re-marking all parents as LIVE_READ.
>> >>  			 * This case happens when the same register is read
>> >>  			 * multiple times without writes into it in-between.
>> >> +			 * Also, if parent has REG_LIVE_READ64 set, then no need
>> >> +			 * to set the weak REG_LIVE_READ32.
>> >>  			 */
>> >>  			break;
>> >>  		/* ... then we depend on parent's value */
>> >> -		parent->live |= REG_LIVE_READ;
>> >> +		parent->live |= flags;
>> >>  		state = parent;
>> >>  		parent = state->parent;
>> >>  		writes = true;
>> >> @@ -1172,12 +1178,95 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>> >>  	return 0;
>> >>  }
>> >>  
>> >> +/* This function is supposed to be used by the following 32-bit optimization
>> >> + * code only. It returns TRUE if the source or destination register operates
>> >> + * on 64-bit, otherwise return FALSE.
>> >> + */
>> >> +static bool is_reg64(struct bpf_insn *insn, u32 regno,
>> >> +		     struct bpf_reg_state *reg, enum reg_arg_type t)
>> >> +{
>> >> +	u8 code, class, op;
>> >> +
>> >
>> > why is it called for case when t != SRC_OP ?
>> > this patch is using the return value only in t == SRC_OP case
>> > and other patches don't use is_reg64() at all.
>> 
>> It is used for case when t == DST*, in patch 2/15, please search "rw64" in
>> that patch.
>
> argh. such patch split didn't make it easy to review.

Was trying to make each patch smaller, and was thinking split READ into
READ64 and READ32 doesn't affect currect read check, so could be treated as
an independent first step.

On the other hand, zero-extension candidates are identified through from
read and write info, so perhaps merge them into one patch is more logically
sane, especially when reviews are done.

Will go ahead to merge patch 1 and 2 into a single patch in next version.

>> And "is_reg64" aims to return TRUE if it is 64-bit read when T == SRC_OP,
>> and return TRUE if it is 64-bit write when T = DST*. 
>> 
>> >> +	code = insn->code;
>> >> +	class = BPF_CLASS(code);
>> >> +	op = BPF_OP(code);
>> >> +	if (class == BPF_JMP) {
>> >> +		/* BPF_EXIT will reach here because of return value readability
>> >> +		 * test for "main" which has s32 return value.
>> >> +		 */
>> >> +		if (op == BPF_EXIT)
>> >> +			return false;
>> >
>> > That's not incorrect. bpf2bpf calls return 64-bit values.
>> 
>> bpf2bpf calls has all instructions exposed to insn walker, so the data-flow
>> is naturally tracked. For example:
>>   
>> callee:
>>   w0 = w2
>>   exit
>
> So then it needs to be different code? Like read32_maybe ?

Read this question several times, still can't get the meaning, could you
please be more clear on this?

>> caller:
>>   call callee2
>>   r2 = r0
>>   
>> insn walker should have marked REG_0 is a sub-register define in callee's
>> frame, and such marker is naturally propagetd back to caller's frame inside
>> "prepare_func_exit" which is doing:
>> 
>>   /* return to the caller whatever r0 had in the callee */                 
>>   caller->regs[BPF_REG_0] = *r0;
>> 
>> This copies parentage chain, and also copies the sub-register definition
>> information as we have merged it into reg state.
>> 
>> > bpf abi is such that all bpf progs return 64-bit values.
>> > Historically we truncate to 32-bit in BPF_PROG_RUN,
>> > but some future bpf hook might use all 64 bits of return value.
>> 
>> hmm, was thinking bpf main always return 32-bit, so safe to return FALSE
>> here. If we could have 64-bit main return, then perhaps for main, always do
>> zero-extension on r0 if it comes from sub-register def, this seems a little
>> bit unnecessary, given there is prog_type available during the check, using
>> which we can known whether whether return value is 64-bit or not.
>> 
>> thoughts?
>
> I think it's safer to go with read64 for now and optimize later
> if really necessary.

OK, will do in next version.

>> >> +		if (op == BPF_CALL) {
>> >> +			/* BPF to BPF call will reach here because of marking
>> >> +			 * caller saved clobber with DST_OP_NO_MARK for which we
>> >> +			 * don't care the register def because they are anyway
>> >> +			 * marked as NOT_INIT already.
>> >> +			 */
>> >
>> > the comment doesn't seem to match the code. why return anything here?
>> 
>> It is to handle the case like:
>> 
>>   check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
>> 
>> which is called inside "check_func_call" for call insn. I think for caller
>> saved register, return anything is fine. They must have new def inside
>> callee before used. And when returned to caller, they must be restored
>> before used otherwise the prog will be rejected due to their status is
>> marked as NOT_INIT.
>
> but neither this patch nor patch 2 is using the return value.

You mean "neither this patch nor patch 2 is using the return value of
"is_reg64" when we reached it from BPF_CALL insn through above caller saved
registr check, right?

patch 2 is using it inside check_reg_arg:

  reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx;

I think DST_OP_NO_MARK was mostly for customized value range calculation,
so when reg_arg_type is it, subreg_def will still be set.

And as explained, here for caller saved registers, return either TRUE or
FALSE from is_reg64 is fine. TRUE or FALSE will cause different marking for
sub-register def, but because caller saved registers have also been marked
as NOT_INIT, so there must be later restore instruction to override the
sub-register def to correct one.

Let me know if I am answering wrong question.

>> 
>> So, for all cases, they are tracked insn walker accurately.
>> 
>> > The return value won't be used anyway.
>> >
>> > If is_reg64() is inside check_reg_arg() under if (t == SRC_OP)
>> > all these corner cases wouldn't cause review headaches and can be converted
>> > to WARN_ONCE.
>> >
>> > What am I missing?
>> 
>> As explained, is_reg64 could be used by both t == SRC_OP and DST*. And is
>> will be called for instructions with implicit register usage for example
>> CALL, and we need to return access width for those implicitly used register
>> here as well.
>> 
>> Make sense?
>
> Kinda. I'll take a look again.

Thanks.

> My first reaction is that patch 1 and 2 should be one patch or split
> differently.

As replied, will merge patch 1 and patch 2.

Regards,
Jiong

