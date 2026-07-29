Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37F3B0588;
	Wed, 29 Jul 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339828; cv=none; b=Da+GO8U2tmkdBMrlDWDTlXH0l+R3Kg6ZObGd3VdW23GpfE/73FpPWSj0wFfBytqdR0MB8YNfcW7UQDvrbmL3jNMbN6UI6wXxY+NkPEP/JYvAaxOAVcWRV2MgVBo80UQ3+gBxNuatVXnAhZP8hjYRC9beIiOlH3GoMuGBkDaI/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339828; c=relaxed/simple;
	bh=n+OIYeEljDWlRl0C6Am1X/IEiYXD24oHIXdVO6kiqhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qc/t+iNysBPnel4zGGFJgxQEtPbvGRIKkwpKkpoxgyxvL7OoOWzNBc69uipJofq8sTUwkolmdiuYhvyUIduLk8mqp4apJmgKh4CvmzzgN8H01u1RQSt7yx+Hw4/Om4oo5mkp/zYY4OGUB6l59bR5fzR4loilJs9Pub+rKY6cIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4h9GZf4tnSz1r76q;
	Wed, 29 Jul 2026 17:33:46 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4h9GZd5PxKz1r76N;
	Wed, 29 Jul 2026 17:33:45 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4h9GZc6bK4z1qqlR;
	Wed, 29 Jul 2026 17:33:44 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id 2RfyXQOV-4tV; Wed, 29 Jul 2026 17:33:42 +0200 (CEST)
X-Auth-Info: VCaU+Zseds5u9u17y8N+aMLm8e/BxzICWNOqLIomY/S/yBOX39UsP47/EU2cR1FB
Received: from igel.home (aftr-62-216-202-129.dynamic.mnet-online.de [62.216.202.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 29 Jul 2026 17:33:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 741042C0B95; Wed, 29 Jul 2026 17:33:41 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  eddyz87@gmail.com,  memxor@gmail.com,
  martin.lau@linux.dev,  song@kernel.org,  yonghong.song@linux.dev,
  jolsa@kernel.org,  jserv@ccns.ncku.edu.tw,  eleanor15x@gmail.com,
  marscheng@google.com,  linux-kernel@vger.kernel.org,
  linux-m68k@lists.linux-m68k.org,  bpf@vger.kernel.org,  Daniel Palmer
 <daniel@thingy.jp>
Subject: Re: [PATCH bpf-next v4 RESEND] m68k, bpf: Add initial BPF JIT
 compiler support
In-Reply-To: <20260729002737.1008358-1-visitorckw@gmail.com>
References: <20260729002737.1008358-1-visitorckw@gmail.com>
Date: Wed, 29 Jul 2026 17:33:41 +0200
Message-ID: <871pclresq.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jul 29 2026, Kuan-Wei Chiu wrote:

> +static void emit_alu32_k(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
> +	const s8 *dst = bpf2m68k[insn->dst_reg];
> +	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
> +	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
> +	s8 d_reg;
> +
> +	d_reg = bpf_get_reg32(dst[1], tmp1[1], ctx);
> +
> +	switch (BPF_OP(insn->code)) {
> +	case BPF_MOV:
> +		emit_16(ctx, 0x203c | (d_reg << 9));		/* move.l #imm, dst */
> +		emit_32(ctx, insn->imm);
> +		break;
> +	case BPF_ADD:
> +		emit_16(ctx, 0x0680 | d_reg);			/* addi.l #imm, dst */
> +		emit_32(ctx, insn->imm);
> +		break;
> +	case BPF_SUB:
> +		emit_16(ctx, 0x0480 | d_reg);			/* subi.l #imm, dst */
> +		emit_32(ctx, insn->imm);
> +		break;
> +	case BPF_AND:
> +		emit_16(ctx, 0x0280 | d_reg);			/* andi.l #imm, dst */
> +		emit_32(ctx, insn->imm);
> +		break;
> +	case BPF_OR:
> +		emit_16(ctx, 0x0080 | d_reg);			/* ori.l #imm, dst */
> +		emit_32(ctx, insn->imm);
> +		break;
> +	case BPF_XOR:
> +		emit_16(ctx, 0x0a80 | d_reg);			/* eori.l #imm, dst */
> +		emit_32(ctx, insn->imm);
> +		break;
> +	case BPF_LSH:
> +	case BPF_RSH:
> +	case BPF_ARSH:
> +		emit_16(ctx, 0x203c | (tmp2[1] << 9));		/* move.l #imm, count */
> +		emit_32(ctx, insn->imm & 0x1f);

That can be moveq.  Also, for the other cases, if imm is in the range of
moveq it is worthwhile to load it into a temporary register.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
