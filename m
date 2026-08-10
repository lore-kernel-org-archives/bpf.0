Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D83B3BE1
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356371; cv=none; b=b0V2T7MhGK9uphloqbYDPBiRg3E6IEYBfthBpWMVGGXD/oEo/hkZNgzjgABh8WSt/VXpuPbNVnVFIbWMrthbSW9VlQAcmPlAvH2Ps04PzwzahLml0qtfrdhgVcS6C+GGrzwSdcqgmbE76ItupsqIapvNau5cplL3dW3d+74jpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356371; c=relaxed/simple;
	bh=aQHpiRjl0icNkVpp1P+G7C74NZmJcENImdYIpsFWJNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XApSoycr5AEE6uetzrAO/NkM0WVjYY+fhalMAWe6RXgGNty2kwbEbDLRxYjxCVDOCtXl3SFaXsm6zkiFjj6/esTBCafJM/6wSLY1JS8OHdXJWnbaFnwNgnVoPpA0D5qTjE1LXEFkMbO8QsMPldpdIwzHmi9MICPac5K4k/F9EV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpDn/PaX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpDn/PaX"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf50c6f235so17585615ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786356370; x=1786961170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0x+AUpFzadUQI8quUp3DhqqhtTFZGj3um66afBtdHw4=;
        b=bpDn/PaXL+2j62gWN6HeY5Z3gZgX4t15Ax1wio6D3S5HGjXm5E6sdUQ2AKOCMPZBcl
         Nmnf9pNx3oWjXKXLAEXewr37vgtGnmiVuQAzfpjhaQkFg399uDluqUix4Hq5FqpcYoi+
         JyvxcO/uXoK/sMz16hV4PHVmD630f1jdKTj2ty6ZVJ0kJ/UTrY7Kmvr8FlRYTwxF08by
         +AmJOuU0chCYDNVNBSs2thtOQbJpXwkkc8FjnkVRCpAuvD0J+aLI1cDq+7fm5UPyKNZC
         wY3PU168g3D21zymYspurrt3tFrn300E6VmE0YZSsnqk0NHCGXB64pg0gZpaQhOsuYxH
         YQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356370; x=1786961170;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0x+AUpFzadUQI8quUp3DhqqhtTFZGj3um66afBtdHw4=;
        b=sqWk2ARwOs6sSGpwI98w2rusLLtMRS9Do8SWunlEO0DnjKe4xzgc3/nTqbpyCjt112
         RMilsUBgwj43AT7o9NaxLieTc54PFZB9PFviKZp/KMBozo4cIcFlJahrmeWRxo/+ws+t
         vQD6pzMT56gRcKKrcYP8foCpqSIevBeXiM75UzYFTYZ/MR5J/RPEOynV5F7dOXKrML2h
         WDh7LgxVParqiM5uHqsRpybBsnp6Zb9swm8HhU7ROCNCXoJnMOuF/EeqOM30LGyOy1F9
         D+3SOGBNIJyDSZzgGIspC0gzYPx1z/mLTfipL+Wop2RnG8N+iz32Pss58jniEdpAinNS
         zQuA==
X-Forwarded-Encrypted: i=1; AHgh+RoTd7dt/GOpdlO+cby1fPg3nzkPoQiKlnEaAV2RCo/kKvASfZnBuY413+q/kB2VO2oP7AI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyydw3TkN4eDBqOGEldz+LMb0PEQRTimdyBIcPM8fR6Ln2mtKpw
	SEyuKCYxDjnHPGamF6v5nAMkz3fEn7q/ICywVuNJ8fJlwTHQ5YFp9GzW
X-Gm-Gg: AR+sD13i57rhcwuUR11vIrP0UIUv63F+nplKZ6+vT54D+bmDZhzzEo0olG22D6t47fR
	xWYXmyWrjll5z6/g2nLB8aR9S2jaQK8DtmZpkzUMeuxpe3JP9J9Ojz/LoqiXNEAo/nDjd5unZ0+
	3Epamg8hqOCb1kM6bT+3sCRS1ye44/A2+jMwiP9Xn+Wi/A+BfAqzrXBrNbs0lJhYbwCt5FWB2Rk
	34E82z/f6oKVZCiMKosTqLgGr1b1jlrmS//fIaUvXmnPmb8/tw1KKk+3JSmjmCXgfgR3EyRt3+A
	CF6u31FRQia/vFThB8k2WkAe2yH9h30mYSBXLBMzX2XhCaning/U6xzE8Of70ek9paiv8v0638K
	noFNqKZeJaIyK+RAEXfSNIi4h+QsN+wPCQH7lu3KcGi84KGHQ0jAJsvON6QM1EqBtDC/yjAOFJY
	yXtio3jvcU5HR4sU5W7ZnqdhSlUFXbDwo80fi9uq/LNo/6GAtFXBNhyY/XVcTO2A==
X-Received: by 2002:a17:90b:528c:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3903c5448dcmr43485347a91.4.1786356369796;
        Mon, 10 Aug 2026 03:06:09 -0700 (PDT)
Received: from google.com ([103.137.210.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9f6asm14176805a91.7.2026.08.10.03.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:06:09 -0700 (PDT)
Date: Mon, 10 Aug 2026 18:05:58 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	marscheng@google.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: Re: [PATCH bpf-next v4 RESEND] m68k, bpf: Add initial BPF JIT
 compiler support
Message-ID: <anmihq6bmwufwTOs@google.com>
References: <20260729002737.1008358-1-visitorckw@gmail.com>
 <871pclresq.fsf@igel.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pclresq.fsf@igel.home>

Hi Andreas,

On Wed, Jul 29, 2026 at 05:33:41PM +0200, Andreas Schwab wrote:
> On Jul 29 2026, Kuan-Wei Chiu wrote:
> 
> > +static void emit_alu32_k(const struct bpf_insn *insn, struct jit_ctx *ctx)
> > +{
> > +	const s8 *dst = bpf2m68k[insn->dst_reg];
> > +	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
> > +	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
> > +	s8 d_reg;
> > +
> > +	d_reg = bpf_get_reg32(dst[1], tmp1[1], ctx);
> > +
> > +	switch (BPF_OP(insn->code)) {
> > +	case BPF_MOV:
> > +		emit_16(ctx, 0x203c | (d_reg << 9));		/* move.l #imm, dst */
> > +		emit_32(ctx, insn->imm);
> > +		break;
> > +	case BPF_ADD:
> > +		emit_16(ctx, 0x0680 | d_reg);			/* addi.l #imm, dst */
> > +		emit_32(ctx, insn->imm);
> > +		break;
> > +	case BPF_SUB:
> > +		emit_16(ctx, 0x0480 | d_reg);			/* subi.l #imm, dst */
> > +		emit_32(ctx, insn->imm);
> > +		break;
> > +	case BPF_AND:
> > +		emit_16(ctx, 0x0280 | d_reg);			/* andi.l #imm, dst */
> > +		emit_32(ctx, insn->imm);
> > +		break;
> > +	case BPF_OR:
> > +		emit_16(ctx, 0x0080 | d_reg);			/* ori.l #imm, dst */
> > +		emit_32(ctx, insn->imm);
> > +		break;
> > +	case BPF_XOR:
> > +		emit_16(ctx, 0x0a80 | d_reg);			/* eori.l #imm, dst */
> > +		emit_32(ctx, insn->imm);
> > +		break;
> > +	case BPF_LSH:
> > +	case BPF_RSH:
> > +	case BPF_ARSH:
> > +		emit_16(ctx, 0x203c | (tmp2[1] << 9));		/* move.l #imm, count */
> > +		emit_32(ctx, insn->imm & 0x1f);
> 
> That can be moveq.  Also, for the other cases, if imm is in the range of
> moveq it is worthwhile to load it into a temporary register.
> 
Thanks for the suggestions.
I will include these optimizations in v5.

Regards,
Kuan-Wei
