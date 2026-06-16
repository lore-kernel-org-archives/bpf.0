Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A843D3331
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589113; cv=none; b=bO2FjAvD9jWuvEgAKUz5BHTuOwTpEE0HUgkGM3iBQtB4uDJk6cjEEk6wft8dyg0RpnQKAzhVh50zMMK61GlW6hHy/u698vYLJ6/2O2X8ZTHpharFc2ELyPNHrPbKLS+uWZOvkSDLXeLSLUUe1OFCaLvTSX+FMGUT5Bo9tNIG9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589113; c=relaxed/simple;
	bh=7BG2QmmZRLh5N3+eiC64oaFFvrrLDzoLyfL/lriehHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0IV11KFO+3nHTMbjvIfYfnC//VJbqLfU+Q4lr/o0c40szUbDDMsSqRCY/SUvIvQrMTjwPgJgTavsMFLsgKwiFibkYfCEfJZW2/T+MgYBNKFHoAjfgCRujEH7vZY9VWj9HMwkiHaMvFroNanfy269CQHfd3fMuZrlGpNgZtICsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QxDfpumc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QxDfpumc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso52216665e9.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781589109; x=1782193909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pn+WbxeK/3ieMZ9WvMfWf1pVnmuN4tJPxKr7sK9EIcY=;
        b=QxDfpumcliIkLkFyq2V538vW9GarjHCMoWbjN4HO8T6s/IiDNpncAa0mI5H4wdn/e0
         2wJQDN0duell/pBFWpiRxlH/rx95giBgzcgD2VZ7/Xx6pXrTa5qEJIhfuN/TWR4EbWU8
         pD1dM+RTYz9kjj8R6jAHI9PCvEmMvrnZy9qnsy6SNI8eMC83e4bZhq6PcZtpS4hRHmMW
         fuRAnjH3iBxl/p7geKLZs9qwBBPfgIWIxvSSuosapzeO18oKP41Gc9WUig5HXSYSz+En
         xdZ0j7pZdcayL5dGVLvPUfSL0b9imeKgdXiNL+RsMhqo6X1lko2slE4zbQt7HZ1564xR
         rBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589109; x=1782193909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn+WbxeK/3ieMZ9WvMfWf1pVnmuN4tJPxKr7sK9EIcY=;
        b=SOWsd43DkZUSGlCEryG5btghyoWZ3sh393Mer2h1nGZC8Dmczwu1UJ4l26QWvIgsWa
         cmE5/0ifmofsr1Vc1YuaAYZElFi9DexJR8zsVnTHx3SKmyqEA3g1jnMGgt0nH1hZd1g1
         rhaI3aajhfvu5RPbBTNFqNBeNRed4kveh3SdZmgw5mDMnaAiSZMUjfTwWB+sE3VdaZGC
         O+LqI85Vdvr+55OpSSW7fTGwJ/y4NY+j9skOPHz3k9in6aEd8cLBml7a9fgZZFBGDvVf
         Akl6s77HHNhs/Cik1jGc4PZP9gsCz1Oykq3U/6pPo/KPycIASo20a8ctw/6zOA58JHKi
         kcmQ==
X-Gm-Message-State: AOJu0YxrXpnFnClH3ZmuLeEec/OvYNbFewuCTfSqZdUeTqseTFZfGHm4
	44iO642SFQiE1R2W3XU4WMDTHL/Dz9e0ewMwb0biHsYCnkGGFUrSYapj3d3ivg0geqIJL+2ycuj
	KFjSw
X-Gm-Gg: Acq92OH0KybGY89uuC5Ogha6dLarMVThx+VT+GVt9ByVxj/XdTmPhCAMz0hC8mYCbOc
	YB5HSeql+acDa07VSIbmVyVl49wkuYCZUpEmnsHk1fBeIqYVOvqBPuxaYGXTf56RKHctH318UPS
	MO1c4UwiEwypz2DAbJFex4rRxZqs9l2uJVgHeV3Dljvey/OsFmKjXKNkL8w0L0HfV23sjW9E8Pg
	1fONOfbWX5fjmLkNQbLYmBY+/IF5dH0p1ap23zt5TfUgg10sY06f7OoAdR3/JhDwvZTxk86iDdf
	1/iMqzhc563jZl2kqlCO542Pi7oYZpE6OL4KakY69NpLXMie2CPYguesGIt6nXYevzxagoOnCND
	KOnaO7uNtkB7btBCyr5S4qUPYVwposJXa/CRb8Olkw+/2zPaK6CaNTDtp4/njt0kygPRtjw8tDi
	Ph3uC7ti9sls5k6TiY5Nt/PPtumrsqHS6pgEapQhKXlaYPgQ==
X-Received: by 2002:a05:600c:1f8c:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-492200768abmr192521925e9.15.1781589109336;
        Mon, 15 Jun 2026 22:51:49 -0700 (PDT)
Received: from u94a (39-12-139-247.adsl.fetnet.net. [39.12.139.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30b6191bf9asm12009774eec.31.2026.06.15.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:51:48 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:51:39 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org, 
	Hao Sun <sunhao.th@gmail.com>
Subject: Re: [PATCH stable 6.6.y v3 1/4] bpf: Track equal scalars history on
 per-instruction level
Message-ID: <ajDiLjjSYPp5p7KF@u94a>
References: <cover.1781194510.git.jt26wzz@gmail.com>
 <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>

On Mon, Jun 15, 2026 at 12:58:38AM +0800, Zhenzhong Wu wrote:
[...]
> +/* For all R being scalar registers or spilled scalar registers
> + * in verifier state, save R in linked_regs if R->id == id.
> + * If there are too many Rs sharing same id, reset id for leftover Rs.
> + */
> +static void collect_linked_regs(struct bpf_verifier_state *vstate, u32 id,
> +				struct linked_regs *linked_regs)
> +{
> +	struct bpf_func_state *func;
>  	struct bpf_reg_state *reg;
> +	int i, j;
>  
> -	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id) {
> +	for (i = vstate->curframe; i >= 0; i--) {
> +		func = vstate->frame[i];
> +		for (j = 0; j < BPF_REG_FP; j++) {
> +			reg = &func->regs[j];
> +			__collect_linked_regs(linked_regs, reg, id, i, j, true);
> +		}
> +		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
> +			if (!is_spilled_reg(&func->stack[j]))
> +				continue;
> +			reg = &func->stack[j].spilled_ptr;
> +			__collect_linked_regs(linked_regs, reg, id, i, j, false);
> +		}
> +	}
> +
> +	if (linked_regs->cnt == 1)
> +		linked_regs->cnt = 0;

This part seems new, not found on the original commit, and also not in
bpf-next. Can you add some more explaining (in the notes before your
signed-off-by) regarding why this is needed?

> +}
[...]
> @@ -14704,6 +14899,21 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  		return 0;
>  	}
>  
> +	/* Push scalar registers sharing same ID to jump history,
> +	 * do this before creating 'other_branch', so that both
> +	 * 'this_branch' and 'other_branch' share this history
> +	 * if parent state is created.
> +	 */
> +	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
> +		collect_linked_regs(this_branch, src_reg->id, &linked_regs);
> +	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
> +		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
> +	if (linked_regs.cnt > 0) {

Same here, the original commit and bpf-next has the '> 1' conditional,
where as your has '> 0'. Can you also added some explanation on this
part?

> +		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
> +		if (err)
> +			return err;
> +	}
> +
...
