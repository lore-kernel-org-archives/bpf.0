Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB31E1024
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830044; cv=none; b=ViVN/qymb2TekAPX+FNNlC4wOSO2sk/mwjxkz15JYEvUwyVGLl/ccwdgNEl2ohUVWmcA3miJpblPScKtnkac6j9A7v0QO4JzV8GlwMBx0WHuR9MHc9b7BwlOv/EkJ3qvTo4Ct1a/04kcbgmiZPnPLSCodVUScCZoEJ9iwGLhSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830044; c=relaxed/simple;
	bh=diTjtOZSBlDuVlorgqO7QcZenfW6uXu61u+k+JiCeag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK70K3ArT4rqMl1iNJbYxSeTa3H/TVMovuvHHW6bMur0STrUW0e+qaCjr16FshajnMXD5jBUSEyZMXkA0Q0KASr/AWIzLTRmEX+CfUCDpn9Acj0/Brdq3rGZYuhaNd12D+tbB5wf8EiqI0JN0xjqykQ2pM0NE9Pa9mxqKuM3Os4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3V5wYOl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3V5wYOl"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-835b78c3797so153838b3a.2
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777830043; x=1778434843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=58YBnKX0CXwlWfu0ur+QCTQDeRBv2oh4WTxZbJK9nG0=;
        b=M3V5wYOlEgjq8iYIWKn9CDI7NQHKyp6F4xGNjmXR2ooqRXgTgiVlV/qXZmSGo6i62+
         xxVjeqrDx3ZsVAzFNFiPkg5Ro+pzJgqDmTj5Fm/uDFkU97zr7eUc15wxmghIa2Tq7uPz
         Vf1LlZWWI1MQPHJET7b/MCqG1gc20jUvHwxp/rFA7QDd7O5iQk+CcwWs8iJsqS/VVl+q
         gIymrytR9ohU2JCaUp13uSKd4RyWe3Fua/IzjCywe/mA1AvNpMm1F7luEohX5+LuEIxV
         go/suds8J9gm7yBpYxIW3Td8rYZRVqqW2z++Hc6dEX27344kS3ne8I9PozPBUao3qZMH
         E/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777830043; x=1778434843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58YBnKX0CXwlWfu0ur+QCTQDeRBv2oh4WTxZbJK9nG0=;
        b=QsGvn+o1jPnIhtJcvLvnb58JU228M7JUMaLi0m7ZdehSzvKrw+3sPvvv6mcx2UVNYk
         aQtStqiixvIO1byQQ0+tF/bbDEkQYGmnzZEjlrblu+F2QWVEJb7vrQYPJMcX3NMLeCkR
         88hSVtxkJbMGhsL5xaiQskKrjSw6wSBnsG+osrWpx0q1dBL00HSDvy2p8RBXxpSsKRGe
         nG98z3xhhOKWxV5wc+gMOv2AoAgS2EpYfgp1LwyVBRYaIVK+uuxDtUpf1oFObvgKyZ07
         waYng7jBhR2B97Hig7XOG6fyREgf3JY4n/OAGLcElmlhvcFytIsBJa1nV3eD8bGXvnTg
         ziSw==
X-Gm-Message-State: AOJu0Yxsj5ZmTpZJjW/BQ2Bipv3Gl0DAbSo7YFrpKfGfJ46g63ftrYGo
	mdhsUvBp8fZ/zsur+kTkLTB/abpVbuszj82azFu8o+Fx/ud0eD/rlxRZ
X-Gm-Gg: AeBDietSD9IUTYZ0+o5KQxLCT2q34coDmoXMFNlrGFev3myPEyrHcYy78uz4UjeiGwi
	cxA0IutwRtLSLw9y7xhGK2q5nbCpQrKdEsXKmlILPJVtvA+huM74ODQSnMcKf9OV7oJaQCQFPDs
	QdCqG1/oPGk/K512nJ9Kma1piKCXbm5hvqxQ1hvy0gmQKwv/FI0/fZ/NoWhdI5osJtugxvve0gN
	SUa1fqCgTHcOPDj16gVq1utmiOktOARVTqQhNQlpFkPe4Azzr5CL08kDONG/5BVELcq0+FpPKde
	1ZGWxWwBu0FNJRmVqcO3MEjjI1bmV3Yjlw+1Axu9o2o6Ojgxq3+DeIUZCS4MXnOt4ylcWn0WyKU
	l1oCE6Cc4ktgIkgKwd2SO2b5N4tEZQi4DUXm3F01bJximAXFRRGmy/3fng2PYI5r54zUrfH/T82
	xkedsqKa7jcJe7GtNT8yMcfgF6c3vTBNgj8Ol+tdKvF3sww8dRGfYtsXEKK4j9gYiy3tXl0PcpG
	MVIf5DH
X-Received: by 2002:a05:6a00:339a:b0:835:685b:8e36 with SMTP id d2e1a72fcca58-835685b90dcmr2045072b3a.29.1777830042852;
        Sun, 03 May 2026 10:40:42 -0700 (PDT)
Received: from google.com (61-230-38-200.dynamic-ip.hinet.net. [61.230.38.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b87869sm9424990b3a.61.2026.05.03.10.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 10:40:42 -0700 (PDT)
Date: Mon, 4 May 2026 01:40:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler support
Message-ID: <afeImOJectVRN3Oa@google.com>
References: <20260429124046.3480827-1-visitorckw@gmail.com>
 <20260429131320.6F6DCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429131320.6F6DCC19425@smtp.kernel.org>

On Wed, Apr 29, 2026 at 01:13:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] The BPF JIT compiler for m68k suffers from a 16-bit integer overflow when emitting memory instructions for 64-bit values (BPF_DW), resulting in an out-of-bounds read or write by approximately -64KB.
> - [High] BPF-to-BPF function calls will crash the kernel because `emit_call` hardcodes `extra_pass` to `false`.
> --
> 
> commit 700ecd8180ff5bd538d3f6e6f0d7655894abb49b
> Author: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> m68k, bpf: Add initial BPF JIT compiler support
> 
> Add a BPF JIT compiler for the m68k architecture. Generating m68k machine
> code targeting m68020+ processors.
> 
> > --- /dev/null
> > +++ b/arch/m68k/net/bpf_jit_comp.c
> [ ... ]
> > +static void emit_ldx(const struct bpf_insn *insn, struct jit_ctx *ctx)
> > +{
> [ ... ]
> > +	switch (BPF_SIZE(insn->code)) {
> [ ... ]
> > +	case BPF_DW:
> > +		emit_16(ctx, 0x2028 | (d_hi << 9));		/* move.l d16(%a0), d_hi */
> > +		emit_16(ctx, insn->off);
> > +		emit_16(ctx, 0x2028 | (d_lo << 9));		/* move.l d16+4(%a0), d_lo */
> > +		emit_16(ctx, insn->off + 4);
> > +		break;
> > +	}
> 
> Could adding 4 to insn->off cause a 16-bit signed integer overflow here?
> 
> The BPF instruction offset (insn->off) is a signed 16-bit integer that can
> reach up to 32767 for large map accesses. If insn->off is between 32764 and
> 32767, insn->off + 4 evaluates to a value exceeding the 16-bit signed maximum
> (e.g., 32768, which becomes 0x8000).
> 
> Because m68k hardware sign-extends 16-bit displacements, would emitting
> 0x8000 result in a negative 32-bit displacement (-32768), leading to an
> out-of-bounds memory access roughly 64KB behind the intended safe offset?
> 
> This same pattern appears to be present in emit_stx() and emit_st() for the
> BPF_DW cases as well.

Ack.
Will fix this by emitting a lea 4(%a0), %a0 instruction before the
second memory access.

> 
> [ ... ]
> > +static int emit_call(const struct bpf_insn *insn, struct jit_ctx *ctx)
> > +{
> > +	const s8 arg_regs[] = { BPF_REG_5, BPF_REG_4, BPF_REG_3, BPF_REG_2, BPF_REG_1 };
> > +	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
> > +	u64 func_addr;
> > +	bool fixed;
> > +	int i, err;
> > +
> > +	err = bpf_jit_get_func_addr(ctx->prog, insn, false, &func_addr, &fixed);
> 
> Will this cause the JIT to emit jumps to address 0x0 for BPF-to-BPF function
> calls?
> 
> Calling bpf_jit_get_func_addr() with extra_pass hardcoded to false causes it
> to return a NULL function address for BPF-to-BPF pseudo-calls. Since the real
> addresses are not resolved, does this result in the JIT unconditionally
> emitting jsr (0), which would crash the kernel when executed?

Ack. Will fix this by passing ctx->target != NULL as the argument to
bpf_jit_get_func_addr().

Regards,
Kuan-Wei

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260429124046.3480827-1-visitorckw@gmail.com?part=1
