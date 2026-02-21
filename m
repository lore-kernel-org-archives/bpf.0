Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FB1B0F19
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771675241; cv=none; b=nPUNBgyIj+8gn4J9n+ir6G4T7tbYb4X3akdtiqDdfSjY+ILmXPBgJHdvpYMiPLMYV5tzUrJIJ9M+VEpgCaljWpm3VtoQ5XSbiN7+2KWj6kNmoHOB99MINFDHyGzZAyFcER2fJUuwagcgMqpq2FHQcfptSv8DyLLRMmy5YqnGq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771675241; c=relaxed/simple;
	bh=RHjWx0X9Hlmy0k5PHSWWRSn4r0L4sFycfYFf/yMVnnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lootbyVh3ZCqrSzv3aNXP6h12RaenOG+0kZs5IZjFF528hr3VAQFhSzaCkzbMCTgEZ/T4NK/E5jCR5Zu1Z2m+jAfXVmt9BuA5yywiQN8WQpMP+JOxzng9HD54wSuAURURUgJ/gjZBoVFabj8XviA7/VO1U6S/uEnmGqsf8d9dxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKuhDNd6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKuhDNd6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so30065315e9.3
        for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 04:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771675237; x=1772280037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtUgp0+6jkXn56WgZsr0JG4gU+/EJFHQjq7Gj5fUqxo=;
        b=dKuhDNd60zt8eBQtDl6sNqw7j7q/+cWq20A96PzNv1isd65SbxhNWCLnIUPDLVQMTU
         zFsI+OAXXUF4cQyoB35Ngmu47vRSn6NLNhzS0obSVeGSR3Tm//KFhEXLYbVcPVray4ML
         ww27PBF9idkqrgNwSDQsPHP3Smhllo7dXeq3y5IFk0N0fzlPc5rxJVEy/lrCGoRfb1iZ
         iVZXTZIdb2JjUuXIdRA5QN201JNqnhvLGvd87Uc6/QcGetxREOW7P7OggOcRNPHr0TdE
         Tsur1oYfjq7fSO0mOxfW/Kc75w55yNGk7l6ATdEAnmf9kxthL49sNcqhK4Ut+rgoSufd
         12bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771675237; x=1772280037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gtUgp0+6jkXn56WgZsr0JG4gU+/EJFHQjq7Gj5fUqxo=;
        b=gWhgMv/UTzJBLOYuD3nFCEa/fVSrxy5NRLosV5VjWzfZ9U4chyWOSLfOchcV5ZxNIV
         +tyXEInPpGVuaz85UsRmu/SAaKA0BCCn161Dl9g3TzkzvUfM6fMqSafRlqixsBpkSvwa
         g99bdK6xdg7q3/lj8BOQ4Oq3vB/oNXxD0x3qybXo9idFais7MXWzGkmPd+Y7nfuyq7AV
         dOwnPnAC4qxzNGA3UAMCLudMapV8lkSVgnUUs/Ou2zsJa2gMvWzadPU9b7Pa49NiD9vK
         dP9eVdNAtVA8auaydfb09vFOlrTmtWJDxhtGcao3qm4ZIlYsC3sda3xOYdX8/F8jtFvX
         rMvw==
X-Forwarded-Encrypted: i=1; AJvYcCU+FsVPv+CPnaJPaFSgzJVrHMDuKI5olbrhyRRX9UxXFqmeLUdc4GFV1mgJ2PO6tLGi4tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9tBPArCAfrlqXvBkD30ouEg17yQuIIWFEc4T4WBKmBhlgUt2
	NBFHUJ/yrDRG6jyHoXTgtyPdpV4Av1t30wQDjFDGs3Tjzx47Cmv1weXT
X-Gm-Gg: AZuq6aIR22CmQ2F+w3rcZ0PiH/NkkuXZa9QSyfHNVb3rxXrEyPH8ZTMpme8iI687WEj
	eiDHrr/2AZG/cYqHZLCNsu9+/njsVFuZtK8eM5MK5wueleYXtSgC8TyOy4Nk2ApATZ6BiiITf5r
	O0X3gHIUdcLa59Uj67RZKSJ4w6mlJM4ZPf0qJbqPpfdHJZL2dSM01VVVdaNCkyVsjLwqsf2cYtc
	lfSnAzkH9Zfxrlwm8lAXmidSscmrR6Pbv7cfW36mmNpA4R0MByMSAd+W896zM+6ZPS2agHo85KS
	Ew0XDGVjqmErJKyOOryCictGgU+T5xM5AVYnl3XGDa7biZMbsianPDHuftExy+cI68NggPlj/qz
	GZDqQXiGxcZPCtws1eRlyIq1fnEEI63dq66Ji2igJbEMT9Se952+11M6S/Df56vVP5JB4cvByON
	Ivi9vbPhP/+gMDSKptGBOZoU612Zhl38CdBYeayU5E/bEzs6FKN62RQ+nQWVd8hsH/
X-Received: by 2002:a05:600c:45ce:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-483a95b5835mr42331815e9.10.1771675237088;
        Sat, 21 Feb 2026 04:00:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd902sm39760875e9.7.2026.02.21.04.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 04:00:36 -0800 (PST)
Date: Sat, 21 Feb 2026 12:00:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: jolsa@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 bpf-next 2/5] libbpf: Add support to detect nop,nop5
 instructions combo for usdt probe
Message-ID: <20260221120035.4562df85@pumpkin>
In-Reply-To: <e46ea28bf48fb9ff5ba205036a6baf0427f7646870cafc98b387940f99a848d8@mail.kernel.org>
References: <20260220104220.634154-3-jolsa@kernel.org>
	<e46ea28bf48fb9ff5ba205036a6baf0427f7646870cafc98b387940f99a848d8@mail.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 11:24:45 +0000 (UTC)
bot+bpf-ci@kernel.org wrote:

> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index d1524f6f54ae..c81e0a58caf5 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c  
> 
> [ ... ]
> 
> > +#if defined(__x86_64__)
> > +static bool has_nop_combo(int fd, long off)
> > +{
> > +	static unsigned char nop_combo[6] = {  
>            ^^^^^^^^^^^^^^^^^^^^^^
> 
> Should nop_combo be declared const? It is a read-only lookup table
> used only in the memcmp() below.

Actually you either want 'static const unsigned char' or just 'unsigned char'.
In either case gcc optimises away the array, the call to memcmp(), and
just compares with 32bit and 64bit constants.

> 
> > +		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> > +	};
> > +	unsigned char buf[6] = {};

No need to initialise buf[];

	David

> > +
> > +	if (pread(fd, buf, 6, off) != 6)
> > +		return false;
> > +	return memcmp(buf, nop_combo, 6) == 0;
> > +}  
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22221513473
> 
> AI-authorship-score: low
> AI-authorship-explanation: Domain-specific optimization from established BPF/tracing maintainer with iterative lore review history and deep x86_64 uprobe internals knowledge.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Missing const qualifier on a static read-only byte array is a minor C best practice deviation with no runtime impact.

