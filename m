Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794945915;
	b=dGpHbzqo4ujpowy5vhHJCssZ0nfXJnUqDE6vQDgMTanL+R20y4pfH5XDw5+KuuElDnnB
	 pfwiYcjGMBmYdc0j2pcoC92Z8aZ0ASZZ84zJ33AM3EBGqTRMOYuB+PIgFvr6G63atkvjo
	 mbiGnjiXNC7TLs4+y07b7ZDl2w+mt1efI2ZX8qJ//itj2Y0ewUHVyDw5EUvcFki4GN8Dw
	 npj8Z93s6wExTOlidK3VTyewgBhXj3YWoyQeODkgdavQC56jBIhHZtQ8UFb92sRsttcxC
	 vECbT7ht9tKxMDqMmmty1NTz9KKNLapXaXvL/dFGLYJ08XuGUk83NwSInoXv0vWpRyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=JzrDAvcrn55p98SUG1RhKTfDk+AfV6k7ysrfw54Suxo=;
	b=sfDeVbMId23SsKS8OE5pRLGrV27lHt4euwBdGZGKh91w8iGirQsNmrWDtan52IZYn1uF
	 EfS3y1sBR2FoKRwY2S12gb7pfXqbYVpiqnEC5XZV+S7CocHiWnY81kBFGUosiG9YFPYIP
	 HOX7psHYnj43+1Pvqzt0spuv7s1zJGYcn8xARJeYE/ZPeBMrhfibz5amEQT+tFINccdOk
	 o0+7CVe34LhXbcX2RRwjDjAsOTUqTMGtBap006q+st94ofE5DnLPrFVif2E/asD/HjJrE
	 ZLr0BBchvpgTpP3zifL5FudPB2QVrcYWstJYNvbyC5/+BPA6Sx87CeM7pp9E5qz4spQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfjyOHF8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.136
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FBB60A5BD7
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 20:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9FBB60A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfjyOHF8
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4a77811be24so693975e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:05:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794945913; cv=none;
        d=google.com; s=arc-20260327;
        b=Qu/T26UjpPHH4beG83fk2tusMwMwMN1S/p5WcVXQfdI1h1DxEcYqrgawLJ9zWObklU
         yIQLJ45tZifqBwJcP5VHNOr1AXlleSVPetxdSA0tM+pHp5woPMMgb1w2pstVLKJp7A41
         wEPNpbeB3K7xlLGAk4ZGDOpuJiXQk3WKFcdpoEj85LXJpCJhbeM9AQ0Lfps1+LMTmmGE
         3t+t3d7TK4LtZ65U4Io2VRiWRSsgNm8vX38GoHZQ3L4/f+rma3rplqSqIMwspRa8F1Ck
         v3tSm4cHf9Ydkt3w3/Q+Pz6teG8qTWvc1k2VJQYd5ceS/MkW1+wEHDpCymlxhtWoJGvC
         e2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JzrDAvcrn55p98SUG1RhKTfDk+AfV6k7ysrfw54Suxo=;
        fh=h1+4BZy/nT1xMqFWAoQ+9v1BbUFhvmMIKJGENaKLNgw=;
        b=S7MRdbyklLXoKH9VHwg0/4ZMgqYp5jf8Od1CqTO1NwXa7S440r9O6ovZ+/Yzu/hvJx
         fL3XiNYRPope2GDS/AFo9E6ND7abXwCtm7XOXyeP87URIBe3N4iF5cxRhVDwTU2fE/3v
         8vBPPkqr0awOpEwkNda6pgLjYrGUkyqtjALoRIKlqIxSEwW0aW/PrafFfljpxv/2/x2/
         CAEbC5fZrLZmk642xIQwbccT65wUaN4XmVN6wu2jGRelW9El6UJ3In+Y9yLGiuN2y+np
         Y2Pa+XZ1SLNO8HHUJIWyLef9Y/e6ujL+YsMigAa2qp89yd1po3xIhlx7ta0wjNFDBYyh
         C6FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945913; x=1795550713; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JzrDAvcrn55p98SUG1RhKTfDk+AfV6k7ysrfw54Suxo=;
        b=lfjyOHF85aJyMSE2qlBxgE1IgV/+TKh/WFz12UqFKxpaP1X/kbPpQQUQRSL6qnaEHr
         KuSDL7ygOqIqr8l6ciC3SlvYnQPzZHGDz1eEp6M12EoGBHKW5Jb324oMLL5n8iIycmrI
         tqBchrGPKPAoukDF163SRLKkhslsOiAbMjn5KAyvqT0omSTrBumtzC3ZbSoaZHchB3V1
         /zHPITrSpPkMcM27V3y2J8kdTQHK10Ea92PKz/LVyUYNy5xXc41dnbpfOdoDJFvOMy3g
         5uSqmnf6vqsiAOHN4bVPvXKrRjtYWrrQhjPZoIaaiiqaqxgDn+kvjf6VR7jIiAXeXYMg
         ZxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945913; x=1795550713;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JzrDAvcrn55p98SUG1RhKTfDk+AfV6k7ysrfw54Suxo=;
        b=jfP59jyiWIZ764ZGan8vFT5yTjijdPSNtJrpfpoqWs9vX6JTFDgVtUHMIpXCH3CezY
         e76iqrdnRGbAayG7eoprXWa+OlWurI3yLHA2/0pp+SnTzt1P/4WF17c9p6i0luF6103F
         CADRg8me7S5ykOqi80Cs6wq10dpgO/X7GlUgYphiQXHovOPlV6iWp7A32/lezjQwEJjt
         eRJXr0xFoUVKIT4PctY9Q1DejgGcXSrjDCtVxhzhP3cPcxYgEDnLDPHXGo8qV6Wu/u04
         tzOI5VYHt2HdGr5h84FECVzCcS0kOofA+tKnSlNVFELnSbkqCDm13Io8dHMMwryAo/dm
         FO2A==
X-Gm-Message-State: APuU4Z8i+nVaFQ0sStrLr2vP9OoNMkvaMU1F/W+6Xa4OnOzPN6WjZ1Ga
	k/D800Ib6+D5fxpSDauYo4gxSOpsvoBVyJkec6iH79BPTVhOGGZvEeVI0kKq1vLXkUKB26mw452
	tgVPMqgxbNCrzflqNhJKZR5wiFg5IQV4=
X-Gm-Gg: AYBFou3KQU30zLxt8g++5GvttgHbbeNvCEiYn5Kb+z1GcvdbsFnvMq1t0R+2u6Tj6J3
	oYZgBiVpvipl77gsbDoUY3Ne7BbUFfTPB4395H+nSTtzdJZrTv/6mDMWZlrh7cs1mTPO8JZbUl1
	2OGdnYGf6kMtGSdVbZ1ygbSNms0mWFWqJvTpxzAvnTjrH/t8Th9epV078k0Tx9lImCF0iXP6SKu
	G7zRz54dUpscThLJsV+RpfT9hJ5bFptyXD6WgrGK+iMSVy3+VHTkDs5mkg2IF5NTQxzDMJe8Ove
	1TY6wAQMxh418NZZ0yXP3QuaTz3m7k9gBDMVeZW2YQ6zqh6BDQSB2qjxDffH/ofKebA7xoh7ANW
	mxeYlAsl+797rRRh8IBh2Zjmd9J7qTPi+aTfpzdnds3dwSitNdQptYlWnUI53DnQ+nAXNw1QbUA
	KXdsnq6vDjHIMzWsaGTDb3cK/hSCkC77jey4bDofPJGqnxppkTbiW/jRME
X-Received: by 2002:a05:600c:45d4:b0:4a2:5ca:767f with SMTP id
 5b1f17b1804b1-4bb7d5d4ed2mr5617495e9.4.1794945912666; Tue, 17 Nov 2026
 12:05:12 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPUfTJPd27eD4=CjG9-1oCnVCYrUXiRrrcpPFz2K86W1e+Ytmw@mail.gmail.com>
In-Reply-To: <CAPUfTJPd27eD4=CjG9-1oCnVCYrUXiRrrcpPFz2K86W1e+Ytmw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Nov 2026 21:04:35 +0100
X-Gm-Features: Aa3M54r6S3r7P68pCdLjbLMYsjrFyu7ktVqEYmTsAkEhGAzdi83_ryyI1u-zr7I
Message-ID: <CAP01T77cWbL_LDNoT5sf3OFU247fm5XrTNcL6tHdkVCiZ0JxmA@mail.gmail.com>
Subject: Re: tracepoint programs can read ctx at negative offsets
To: Yalu Cai <yc1795@scarletmail.rutgers.edu>
Cc: bpf@vger.kernel.org, santosh.nagarakatte@cs.rutgers.edu
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 20:25, Yalu Cai <yc1795@scarletmail.rutgers.edu> wrote:
>
> Hi,
>
> As part of a research project, we have been trying to formally verify parts
> of the eBPF verifier. We found a bug that can read ctx at negative offsets.
> Below is the concrete description of the bug:
>
> tp_prog_is_valid_access() lets a tracepoint program read 8 bytes in front
> of its context. The read lands on the per-CPU trace buffer's neighbor. For
> a syscall tracepoint it lands on the kernel stack next to the record. The
> program can then read a kernel text address out of it. I found it in 7.4-rc3
> and bpf-next (ea80d2afd285).
>
> In kernel/trace/bpf_trace.c, the lower-bound check is
>
> static bool tp_prog_is_valid_access(int off, int size, ...)
> {
> if (off < sizeof(void *) || off >= PERF_MAX_TRACE_SIZE)
> return false;
> ...
> if (off % size != 0)
> return false;
>
> There is no explicit negative offset check. Since sizeof(void *) is unsigned,
> off = -8 passes this lower-bound check. The verifier accepts this access:
>
> SEC("tracepoint/syscalls/sys_exit_read")
> r0 = *(u64 *)(r1 - 8)
> r0 = 0
> exit
>
> The equivalent load at r1 + 0 is rejected with "invalid bpf_context access
> off=0 size=8". The negative-offset load is accepted.
>
> I attached a program to sys_exit_read that copies r1[-8] into an array map.
> On a 7.4-rc3 x86_64 guest, the map held 0xffffffffa477766a, which
> /proc/kallsyms resolves to perf_call_bpf_exit+0x6a. This reads a kernel text
> address and discloses it despite KASLR. The memory is mapped, so it does not
> crash.
>
> Loading a tracepoint program needs CAP_PERFMON, which also grants
> bpf_probe_read_kernel(). A program with that capability can already read
> kernel memory. The verifier issue is that it accepts a context access
> outside the context.
>
> The check should reject negative offsets, as the other tracing types do.
>
> if (off < 0 || off < sizeof(void *) || off >= PERF_MAX_TRACE_SIZE)
> return false;
>
> The check has been this way since 9fd82b610ba3 ("bpf: Add BPF_PROG_TYPE_
> TRACEPOINT", 2015).

Would it be possible to send 2 patches, one for the kernel side fix,
and the reproducer as a selftest? There are plenty of examples on the
mailing list.

>
> Thanks,
> Yalu
