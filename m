Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C453BCD15
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222995; cv=none; b=WdUsh8aOp1OIG6KzJsnxjQNYqem2m7yziuJY5jqEByzJKyIqyLZqve9NVakDF9brXmbzLdR9ZmsUwnhUSVYFAOH5W3IW3IHDso63fGbPs8gNMf0l6WXnmJpoMR9zNlOjdbUMLvfYq3u7Fd6xqptkLdwJwW+RaFvFLRIp+r5HHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222995; c=relaxed/simple;
	bh=z+b8oSAhGac0PPOEOgqAaY2KPvnFvX88FrL6kKbwnuM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlkRMqGY94CSGHuIuXMPYbzPbSnF8hd8dD2Lep87qHyYxsrkw23mVPk9OHuXjnzws6yDy1DxvIRPjCFrybQCQ4OhqtScVKqsE9YIVcUX24DtLRB2GOASyaFEejWX2ll9kXRyufaPnllJyoKwlO6KLzpFSBvxr/qsCKkaO6G0O0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnP0ockr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnP0ockr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso30214885e9.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779222992; x=1779827792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeVdBSMYoYIb7T6Hj+x3MKxdLQwgQrCjVyxD0/Djjko=;
        b=JnP0ockrLmqS8Xh+btdr4Oras0d/zIpTePOowjlNqJbdncptrl0OXxeSs8Nrp4XSBE
         vNHLBoVk4wID0wGG3Ed1Rxw8bUbM/UbE0qTM0qh7Rz5Lo1juyfxyH5ImjufJFOFVzhWK
         04J5IHBtlsbhVFG5wjoiW2uZ5JObnasUK4caQ6CY8CLUOVPkYjqqYgz1bOZpUoStdJQy
         pEvRNOD+2RtXX04J06Paf/LM/Bn/J990B38cWM7DjBli7Se3OC/s1Ur7YbcsIYscy9HP
         tEdPLTjTU1d50AnMDpbhQRQVfCWsXR42RwzZj0skwJtXkMB/U0Qrp2l+/fVhIZiX8SW7
         HiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222992; x=1779827792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeVdBSMYoYIb7T6Hj+x3MKxdLQwgQrCjVyxD0/Djjko=;
        b=UKvcK5lQX6JSH7mwmIX0UDmX6YtinQM5RgxqlATV9JJOwMMk1Z4fq2sNCKnM/lsfJz
         fgR7D67fwDkxICJ/aZ8EXnb3LmuoXuhsR/FP0I5GxB5/J9QSFhW6IF4WT3NZLPNyjGfI
         a9q4JsciJ+zPdrJjaXqHhD7stMeboZvvImwR6sXmOqf8audwQz4w/JFa1AAo+wdjLWKX
         razjXTrBApxFoxDOSJ+YL/zbsUKdsyVX6TYVHuE3L7wPdwRKzBO0v0OMx0ykkNDb+Y82
         tpNIq+76gMOQtgTRL0spuTSwgR1nR9amtVEQAfqOYdpvcfQ0LpOr5kHh6052DeFUFTEx
         U6cw==
X-Gm-Message-State: AOJu0YxTPAkkUp2nH2zWH0Tj6QKh+TXcHUSXAJqmaCxpL/HqqaRfAe1f
	23Th4+0Zn+oWZaFSr9T7mQ5CTUpRgNz4YO7PaaP7LiqqOMrs3gI5gcuuUoTtECTf
X-Gm-Gg: Acq92OGSXdNSizeOPcwhFtdUGM2F0tIpIMHzr3v9DMfArNHuO/PysPdNmIAoOOdYtJF
	cZ5kJhvsZi91L1q5K6RMBbmO/6w+8apW8UAgtXqWqoeoCbahMacIp+vYgswGq+fPdeSsD7AzTQS
	gFQHkSNLzkdlHQvu041fokBzV2Cf2BNS2HpIS97xzQZAFXmNdRxs732HoXJyOV59e+nTnprzuoD
	lLzDdXjIVKPe7sfGMevxcMmWMwNHH8ML5P8JAxXeIMPqPQLwnX7f7KKL5uiOokLLrV2KHWAEb8g
	IHLFvEVu7bjMrRcCLfV3xX8FpXhVPOwKZijNqtnpjEOJm1dZkXLHgtpko869NYCWilE0E2qMajI
	uDDPNeWp3cN0eC1jndd+NvpgYCCv10F5uebsc14rgWJWig669fL4Ryas5ckTWktpzlLLmd1g9a1
	cCOLkIEZceTmc=
X-Received: by 2002:a05:600c:470e:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-48fe60ea590mr306222665e9.12.1779222992370;
        Tue, 19 May 2026 13:36:32 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm388321145e9.11.2026.05.19.13.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:36:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 May 2026 22:36:30 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 06/11] selftests/bpf: Emit nop,nop10 instructions combo
 for x86_64 arch
Message-ID: <agzJzm_p_Y9s-Zt2@krava>
References: <20260518105957.123445-7-jolsa@kernel.org>
 <20260518111733.E696AC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518111733.E696AC2BCB7@smtp.kernel.org>

On Mon, May 18, 2026 at 11:17:33AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The patch modifies `USDT_NOP` to emit an 11-byte `nop, nop10` sequence, breaking existing BPF selftests that explicitly expect `nop, nop5`.
> - [Medium] Libbpf is not updated to recognize the new `nop, nop10` sequence, causing the intended uprobe optimization to silently fail.
> --
> 
> commit 1ccfa6afa421e13f88c377be82ec249ff187bf51
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
> 
> This commit updates the USDT_NOP macro in the BPF selftests to use a nop,nop10
> instruction sequence instead of nop,nop5 for x86_64. This is intended to
> support nop10 optimization testing.
> 
> > diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
> > index c71e21df38b32..d359663b9c329 100644
> > --- a/tools/testing/selftests/bpf/usdt.h
> > +++ b/tools/testing/selftests/bpf/usdt.h
> > @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
> >  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
> >  #define USDT_NOP			nop 0
> >  #elif defined(__x86_64__)
> > -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
> > +#define USDT_NOP                       .byte 0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */
> 
> Will this change break the existing BPF selftests that explicitly expect the
> nop,nop5 sequence?
> 
> Looking at tools/testing/selftests/bpf/prog_tests/usdt.c,
> subtest_optimized_attach() uses find_instr() to search for a hardcoded 6-byte
> sequence:
> 
>     const char nop1_nop5_combo[] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
>     ...
>     addr_2 = find_instr(usdt_2, nop1_nop5_combo, sizeof(nop1_nop5_combo));
> 
> Because usdt_2.c is compiled with the new 11-byte nop,nop10 sequence,
> find_instr() will return NULL and cause the ASSERT_OK_PTR() check to fail.
> 
> Additionally, does libbpf need to be updated to recognize this new sequence?
> 
> In tools/lib/bpf/usdt.c, has_nop_combo() appears to be hardcoded to check only
> for the 6-byte nop,nop5 sequence.
> 
> If libbpf doesn't recognize the new 11-byte sequence, it won't increment the
> instruction pointer to skip the initial 1-byte nop. This would cause the
> uprobe to attach to the unoptimized 1-byte nop instead of utilizing the
> intended optimization.

as I wrote in cover letter I prefer to keep these separated to make
the review easier.. we can squash it once we think it's good to go

jirka
