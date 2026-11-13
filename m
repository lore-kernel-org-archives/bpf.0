Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570743;
	b=Ho79/Nq7+CW3udv5rfyeXKDUAeiF1dnqT6VWRAKxqU35YPRUmzBG/0j/GdyjjJ0g4ZpK
	 sH6LZAA8TDY4QYcGEc5IAifQVN5hQjkNDRQaRyX39TK3dOMT4sLJ1IybvzIQ1RikPgFxI
	 5KxXPGjK6IgmR8WIwbLs/3+W8NOb3QRsuUG7EbM5gLBVF3aAlq+zW1CQ+xv5cvfamEInG
	 cVrjil70kj5WB7AXMf6Oh6oAPhTASQ4to7yOxS1AH6RlZdk00rpqUOF9Y70+1P3Qrs+eh
	 QhMZiYseqgEPvdICLbicnDz8YEzCFESxXINDSoo27xvIwTdR4mPIg32MO0aayy1suMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Nxwcn/C0m/NpMzGHlhmtS3EuXEWZRUeIp4y6wUB9sRQ=;
	b=S3hCWQSD5SkNKhLmnI5K+Fmp+RFn6LHZj2sBSJZrLqXJYaoZAoMY6ejkyseVtKERo/nE
	 slNp2jEGlr7qBuMzzQNnbnyTE8nuSvf7N/z+uLL09AUVQTL1pi63Dt4ja39XAx3dhUE5V
	 oojf8VYh7sC1wG1DyDc8AKUwUnutnd7UqqJyWh454YNAQ/nzZ3EuM5IMj5ui0IxamuUV2
	 pBd3k57ofMjmmc093gT1Ih7cg7889gFvY2jixSGPt6gvdaG+Bh4uYhY4unLWxf7JgVzJ9
	 HbI3kQv3BJdbHCAwOKyRgef2JF0d5OoV9JMBfaqF9+xD3VmRU7WV1lTJP6e58qOidJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dr3vDkNv;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B379606A32D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B379606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dr3vDkNv
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490585eddfcso848637f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 03:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794570742; x=1795175542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nxwcn/C0m/NpMzGHlhmtS3EuXEWZRUeIp4y6wUB9sRQ=;
        b=Dr3vDkNvy8HgC1CCw3wL5yzaILA7nmq/ku0PNHeIo61UA+D2nORoPcaWhe+cSVvHjG
         gTqGWe0fUgwX1c1oBMk2p28TbK0I5NmtUevUYj+YuvnZWQP1JV3+K7GErril5Km3bjR5
         34EAon3zOv4HMLByF0l958HWCUt36O6obGx1+ACBwdbCpQLFoc6IHpXFPUQHG6k7BKg2
         IQ24ZXnsZtzi5beX/rADjRhbKxhWzRk/MbA/Xt8+cJK8bos7JLEr/kmNfhcKB5Y7m21w
         ML7f6/ge0lY9ZY1P5uyh/qHsDPpaApju7e1xrQblH5JA2lyiLZ0rAHCgwJKb4mTKB0yK
         GB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570742; x=1795175542;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nxwcn/C0m/NpMzGHlhmtS3EuXEWZRUeIp4y6wUB9sRQ=;
        b=YQXNsB7MwEYM4nXsXEJ9XCm6iZO8ajE65FF42xmVdJykd10KW26TrHLucqDGYICwSJ
         PsaAeKq9j3TgGFMN6IXBPBMtcPVjqLvc9Heu8e5c+oPDuyvMyMFSvcrBczd8kPnKUUV/
         5SbUupHD0NA0nuYn46ABDT1yHLU63ZOrJebbSWDnGFKzeRokJcERJiotQzHkFhUDn2Gf
         E8NUPZvGfh90BVgBK1eMTV7S4tFENY84xPaiv+XOIBiKlELtgoYHN6pl8dQ7KryzLJBE
         XtviJlEKmFCLFG1/sEyal7pTpbZasbi5jXUSDKKHt0kUYrmdC/cR71EilK5wcOq9mvnd
         Mypg==
X-Gm-Message-State: APuU4Z9IXx4SRRcZq+DnJium4USaNH6yWw+uPOQWaK4VFW8LgnyNhqhH
	pvXxAHxwum7byHV1I1+IgPNQYEbKM0HYFN/LCPKywhXZ/CyPeznVzm01
X-Gm-Gg: AYBFou2K2vkETki7c/c2FPJ818Ar7aWZs/Yl8v9Vs9WoqfdBiBSTRaba81EC99nJIeL
	TuaooLG0eG+/vs86b6JVltuhfdTIl2G+7s0KUXxIiuZPQArPmk0zPo0CHB7JkkACGyzP9WDZOSv
	Hc2KoPrNEJnwNgdGslWM2DaTguAV3iuo74MGTIYNQyy5sxEbvOlH9ytkryKMw/JGQLOEaBzyvCT
	FKzMcN0d/5ysKZZV28AhlSM+xULpqHPgIQNUMMbCHlhQHSa1qt2orWTn+uLQVYaMVutHUEBWdiN
	g1xQYw5fkgj+Q0Hh+XNAFlMm9wRinEp1/S1WLY6tHuydWTN0j7pezp9nfpspRRgVxFEJCWUzm5Z
	T+GCNLT7zytlpmNQuyXKCMa+Q00W10MuyeLM8f+9+rh7fVHXkmxBbY5MaWOIQwyf3hvP2D6fCxi
	SNDtcTY48kZkWVHsXwINtlruEGXIRT1bLRQRpJhwYcrS09QI2njzTrULqVR50Iz2Ja2Jqi3Dhx0
	OJRZBa2pl4dtnG//EP1iHWMAy12KIJ9yZB9kj+HDz/dAS4+BXvgiq9uOrTumevhOGq5bHjh86ND
	pRnIVPKSbtllgENzB8Iz1eEHFr1v6fnAjC4LhA==
X-Received: by 2002:a05:6000:2dca:b0:48b:1c:d6e1 with SMTP id ffacd0b85a97d-49c726da6d3mr6039605f8f.43.1794570741553;
        Fri, 13 Nov 2026 03:52:21 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e4a2asm5012590f8f.39.2026.11.13.03.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:52:21 -0800 (PST)
Date: Fri, 13 Nov 2026 12:03:58 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH v2 bpf-next 07/13] resolve_btfids: Say which registers an
 instruction reads
Message-ID: <avb8rvfYDksxC-Za@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
 <20261113050901.1399091-8-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113050901.1399091-8-alexei.starovoitov@gmail.com>

On 26/11/13 05:08AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> 	Ebusy:
> 		spin_unlock(&files->file_lock);
> 		return -EBUSY;
> 
> 	mov    %rdi,%r13                files, the first argument
> 	...
> 	lea    0xc0(%r13),%rdi          &files->file_lock
> 	call   _raw_spin_unlock
> 	mov    $0xfffffff0,%eax
> 
> do_dup2() unlocks an object of its caller before it returns the error. The
> next patch looks for that in the machine code: is the pointer in %rdi
> computed from an argument of do_dup2()? The decoder says which registers
> an instruction writes. It does not say from what.
> 
> 	text_insn.uses    the registers that the instruction reads: the
> 	                  operands behind the defs of MCInstrDesc, and its
> 	                  implicit uses
> 	text_insn.load    it reads memory: MCInstrDesc::mayLoad()
> 
> 	lea    0xc0(%r13),%rdi          uses r13: a pointer into *files
> 	mov    0xc0(%r13),%rdi          uses r13, load: another object
> 
> An opcode with hasUnmodeledSideEffects() reads all registers, as it writes
> all registers.
> 
> For LLVM "xor %edi,%edi" reads %edi. Compilers pass NULL in this way. The
> table of x86-64 gets a pattern for it: dst = 0.
> 
> A test instruction says what is read only if that is its point: four for
> x86-64, three for arm64.
> 
> No tag changes.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

>  [...]
