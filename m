Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E7C10F0E
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 01:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519252084B
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 01:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csNYiMwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfDPB0O (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:26:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39839 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfDPB0N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 21:26:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so9515406pfo.6;
        Mon, 15 Apr 2019 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bE81yBo48jYXoOEWPFsHaKQUg1ivyPI6HZ82kI6jNRM=;
        b=csNYiMwR6CKaiUyAmCncjtdvn8KWteTngpX/M0EJ5cf8B3mugihv/ZdrhdHKFpJKST
         vm/05jOliq0IFHOEWgC9HhSypn32N17yilHgJgAXV3PtVSnlB/I2917Ha4V6ezOOzkNS
         MeEJotSeyEpMujtoV9dKomby/22tTXne4/ALOEWT5N3cHnwGXTU5bKDSWZ4wBX3w71z3
         wLoXKohCbLSS/oqWcS6HYL9RIiyV7tOPcvSbDfGN73923yRJCBR2F2rli0AGZb2Ju/Dv
         Qnp/Lk+iiSBhrl7oS53wlO6c7sR6PPWWHaX2R9hFlBvgmYkEr9+KtW1UN64KCtzxPBUq
         OJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bE81yBo48jYXoOEWPFsHaKQUg1ivyPI6HZ82kI6jNRM=;
        b=MxlfhPAkZlMTQP9JDcj+yCIPiQqcSmDxPObstpHSR0m1y9CQoPnU7RC9LSkzvK2HB4
         vavp6OoG4Kc0PoBdGNKWhDPSRmCrviToMhDaJoJDANOgJvVanlNSiIowTV/BvtEoAby0
         3SPQzrFt1t04nMmB7A70gJ/mswSNh/B7DHkrRy7SK5NL6Lk2I7Y2J0KB5N5kGBAIpWbV
         tHYHN69WF5Ot8T3gMn9ExNRt5shfto6NpgwZrR0MY4Fnvg3n1GCRgiKGxFf85+vMFmOm
         ZyIkrH3Ni5uN1MztiFb3N5Zb5LHAT/HPNyGw2c2U7LU0OZObaQd2P/K3IZolR4oGOnrn
         V5XQ==
X-Gm-Message-State: APjAAAXqbhrST8T1wVU9BaLUNTqaBZl0nNKqV1kGGa5xR/y3SOJU72+B
        1RB4CFds8zPndb6UcUELPOk=
X-Google-Smtp-Source: APXvYqzvC69+re5jXCjlccu3fkvvHsK0p09gYLHbDE+AlrwONLnrwdym5aJ/ZZJpWBbq2vfuwkah7g==
X-Received: by 2002:a63:403:: with SMTP id 3mr68822893pge.335.1555377972814;
        Mon, 15 Apr 2019 18:26:12 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:ee09])
        by smtp.gmail.com with ESMTPSA id j9sm67860865pfc.43.2019.04.15.18.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 18:26:11 -0700 (PDT)
Date:   Mon, 15 Apr 2019 18:26:10 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: split read liveness into
 REG_LIVE_READ64 and REG_LIVE_READ32
Message-ID: <20190416012608.2iahgakw5uqobv6z@ast-mbp.dhcp.thefacebook.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
 <1555349185-12508-2-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555349185-12508-2-git-send-email-jiong.wang@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 15, 2019 at 06:26:11PM +0100, Jiong Wang wrote:
> Register liveness infrastructure doesn't track register read width at the
> moment, while the width information will be needed for the later 32-bit
> safety analysis pass.
> 
> This patch take the first step to split read liveness into REG_LIVE_READ64
> and REG_LIVE_READ32.
> 
> Liveness propagation code are updated accordingly. They are taught to
> understand how to propagate REG_LIVE_READ64 and REG_LIVE_READ32 at the same
> propagation iteration. For example, "mark_reg_read" now propagate "flags"
> which could be multiple read bits instead of the single REG_LIVE_READ64.
> 
> A write still screen off all width of reads.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  include/linux/bpf_verifier.h |   8 +--
>  kernel/bpf/verifier.c        | 119 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 115 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b3ab61f..fba0ebb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -36,9 +36,11 @@
>   */
>  enum bpf_reg_liveness {
>  	REG_LIVE_NONE = 0, /* reg hasn't been read or written this branch */
> -	REG_LIVE_READ, /* reg was read, so we're sensitive to initial value */
> -	REG_LIVE_WRITTEN, /* reg was written first, screening off later reads */
> -	REG_LIVE_DONE = 4, /* liveness won't be updating this register anymore */
> +	REG_LIVE_READ32 = 0x1, /* reg was read, so we're sensitive to initial value */
> +	REG_LIVE_READ64 = 0x2, /* likewise, but full 64-bit content matters */
> +	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
> +	REG_LIVE_WRITTEN = 0x4, /* reg was written first, screening off later reads */
> +	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
>  };
>  
>  struct bpf_reg_state {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c722015..5784b279 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1135,7 +1135,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>   */
>  static int mark_reg_read(struct bpf_verifier_env *env,
>  			 const struct bpf_reg_state *state,
> -			 struct bpf_reg_state *parent)
> +			 struct bpf_reg_state *parent, u8 flags)
>  {
>  	bool writes = parent == state->parent; /* Observe write marks */
>  	int cnt = 0;
> @@ -1150,17 +1150,23 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>  				parent->var_off.value, parent->off);
>  			return -EFAULT;
>  		}
> -		if (parent->live & REG_LIVE_READ)
> +		/* The first condition is much more likely to be true than the
> +		 * second, make it checked first.
> +		 */
> +		if ((parent->live & REG_LIVE_READ) == flags ||
> +		    parent->live & REG_LIVE_READ64)
>  			/* The parentage chain never changes and
>  			 * this parent was already marked as LIVE_READ.
>  			 * There is no need to keep walking the chain again and
>  			 * keep re-marking all parents as LIVE_READ.
>  			 * This case happens when the same register is read
>  			 * multiple times without writes into it in-between.
> +			 * Also, if parent has REG_LIVE_READ64 set, then no need
> +			 * to set the weak REG_LIVE_READ32.
>  			 */
>  			break;
>  		/* ... then we depend on parent's value */
> -		parent->live |= REG_LIVE_READ;
> +		parent->live |= flags;
>  		state = parent;
>  		parent = state->parent;
>  		writes = true;
> @@ -1172,12 +1178,95 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +/* This function is supposed to be used by the following 32-bit optimization
> + * code only. It returns TRUE if the source or destination register operates
> + * on 64-bit, otherwise return FALSE.
> + */
> +static bool is_reg64(struct bpf_insn *insn, u32 regno,
> +		     struct bpf_reg_state *reg, enum reg_arg_type t)
> +{
> +	u8 code, class, op;
> +

why is it called for case when t != SRC_OP ?
this patch is using the return value only in t == SRC_OP case
and other patches don't use is_reg64() at all.

> +	code = insn->code;
> +	class = BPF_CLASS(code);
> +	op = BPF_OP(code);
> +	if (class == BPF_JMP) {
> +		/* BPF_EXIT will reach here because of return value readability
> +		 * test for "main" which has s32 return value.
> +		 */
> +		if (op == BPF_EXIT)
> +			return false;

That's not incorrect. bpf2bpf calls return 64-bit values.
bpf abi is such that all bpf progs return 64-bit values.
Historically we truncate to 32-bit in BPF_PROG_RUN,
but some future bpf hook might use all 64 bits of return value.

> +		if (op == BPF_CALL) {
> +			/* BPF to BPF call will reach here because of marking
> +			 * caller saved clobber with DST_OP_NO_MARK for which we
> +			 * don't care the register def because they are anyway
> +			 * marked as NOT_INIT already.
> +			 */

the comment doesn't seem to match the code. why return anything here?
The return value won't be used anyway.

If is_reg64() is inside check_reg_arg() under if (t == SRC_OP)
all these corner cases wouldn't cause review headaches and can be converted
to WARN_ONCE.

What am I missing?

