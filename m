Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794666735;
	b=hHP52PSP3CDCBzR0pfEHXQ0MwGFdMANbI0IQT0NFZqDpCzcjPkoSCVh1yyL2WuYiuVNb
	 SJCvTYuzND9jFyXHN1FhvrDHO1n8TmLl9QFYO5di9lRgTdkUOnyhWVUAju/Ck1IwK1zq0
	 DjT/6T4tLc28J+/jxqSayxoJDi+jsKfxAb6qvTV4yTk5q+lIBSAQ2Wf8LKCUwtlAeUdle
	 uy0wX3sMhaSd9TXbG5cMgyFYZntIQw2uJY71U43SwKmgMqYPCuA25reKDncq/PXrLmXrx
	 9UPqampHH/xTDtSu7oyO8bPwhOhi55QlnJm/WmnSwFrrab3Fo/G9QyO1UrC3TXmo7Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qWeCdWju2mIKB8UGaY5EcBwHtnHoPxgSD81CkBCW95g=;
	b=RAzojM3vVxC3jZIMOiAiOzNGMU1PJroojmY4+F+vKd7+h2C/cKlGgPwNUAI4Ly6KELdn
	 fmDSHigq9qWQ13m5tQ9oDw4ZFTjQGgYqSROyKqmmCuQQLJSV0FIFQ56hKdTCAE9jQczrK
	 Hc2EwqLsFtGxhAGFtEnZW38wdu8ygVS+WwpUMt/cQLojmFqjEUl4IzF7sdTc1LSMyKXj5
	 0N0XCDZwzNyhgnyn3wHGamDpF0tbyNBiCsQh2GEbDW5vEoCYb4ImkXPAQiqPzkUbhRmcf
	 RmopEPBF6bf0oRRpNGkwWZGDZfKQbgwOIzbvFmuOxVQzFl8REj6CgVVlnEVHJ+w5HtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4uwH9W+;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342E606A32D
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 14:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C342E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4uwH9W+
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so11507375e9.2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 06:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794666733; x=1795271533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qWeCdWju2mIKB8UGaY5EcBwHtnHoPxgSD81CkBCW95g=;
        b=l4uwH9W+LongKMjKUPj5DXIOjleJ2mm4NAm1kSaMM6/9KiDRosdmoAXy0LMFRC/TAF
         MpOGY+/UwXVfZeKN4RxiXflwYRTCKdbtMjBqJ2SZ/sENJMariHaUEJUoOeIyFcdtxAGu
         u7Dr3YngPo3e7vKyZClqvWfsBsy6XYXoPwkryijjagUA+U3hgWhI6dc+xZSxPXW8r4qG
         70bYXCpcsbdvqJqkogb9egAWtDNaTH6d1bKxLnKzO7duUPl30s+fUwomjOqZ01rNSo4M
         xwvmOb5y5jl9RPL1c5AjYJbOYeXVM09JMwQRxkTRgeJOCly30U6uHLai6B94BiNTfAFF
         Hd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794666733; x=1795271533;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWeCdWju2mIKB8UGaY5EcBwHtnHoPxgSD81CkBCW95g=;
        b=DGYTqsbRmU3JxgjnWrREW2hikBsIz7by2pMJhLWBTZkx2k6VW1oT6CXqiriEugwCAC
         WRdLgh8M7Idii3CVifMn3IZ9oayzV0E9YIHw/sh0JOnRUJ+dKJiZsET/a2/XiaDP5Ehb
         I6uNjIvvArbPUnWT2P77lPEhIHeOdwx3cHcdonY/fBCAQWBMzTMfwq5tC4ZM2PhVd7BR
         YNCinU/Xdg6Bz3rngk/LF5WfTKfRljD3CBN6Oqs0+/eWWtV5WW0DYB1bChnNkLftYF9e
         CxhZdjmjMgctLqPmW88bCkS/RbZh4jqi8JZzqSJE/ZGeuguQ4ySeR2v+2HnnkH3P1khe
         zeaA==
X-Forwarded-Encrypted: i=1; AL+hErHDaueNJ+1MLIFx6Jo/xDPLs8jvoplGIj2Jbkd9XZhfHYbiIS5dLSFJHRbDudEYI9QVXLw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A+XMDx/RHc65g40+ZIznlfwBdHRuQk/7gaxS+w0XxcHfoFnZY
	Udf7Ulyanm1Jk3fWb0haMVeYvaMSs024UFuTHVehCOQnsvE3MoKA9ROK
X-Gm-Gg: AYBFou2xNC0RidI+SZzlUHHs0rEiTnOczZkzXoLCS5w0nTckMa3Cf12Zi/5kIPjkAi4
	Qr+9uLve4Bz/RO823o0Yx92SsXwb8k85R7HnwiuzlJTaDNBEM7Na4clbJ7gFrKmIKRrZJpt1EB4
	KslwLebIpICi/3HaxSAhssP0/gfVEPl5hIAzkbgwXHzEXU+5VU3fSvqgN7Iz95Lub7RZBQ8D4RG
	uh3T41m5Qulzg9SCZwiW+a0VybG7agw4C6cqXJdjm4R1u0pqTdITbnFAZf7oH+dmrOlCWvTGZYp
	Zr9OvkthglUX4q1qkRVtBUymN+vclpEcyIUOho7iv+LKEAbzcUOn1KXVa/E2IIbkT8r6IXa1A0Z
	k6Umwe/vQbH7TnCQa+ndZTef3zMoMRMpoDNN4E6X9leCrm7++7Ss8fHIA52Us8d5a6JKliogvGB
	zIcF2iojvML0q53Jkf6Zf3blUEX6atJcUtp0TuytEqYSI0LRHjbE58hyEtHg7XSv5j0NDanb2is
	Ssfz0/OrB2se11QjLMI3Q6N3PKfHQ6Ck4pN797myRibZ2qw/p1hWBWsMm5T3Ao2RHwssdTsehiY
	RRNsW7n6kTCp4EI0ugWfh9POsxkM7PzArjXubVGIb3MB3Ma/G6n7c66O+i6vp1QxeQ==
X-Received: by 2002:a05:600c:2d2:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4bb55a63720mr87539035e9.24.1794666733074;
        Sat, 14 Nov 2026 06:32:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb679b7e1asm56702255e9.6.2026.11.14.06.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 06:32:12 -0800 (PST)
Date: Sat, 14 Nov 2026 14:32:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 "Jim Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel Wu"
 <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
Subject: Re: [PATCH v3 next 04/13] scripts/kallsyms: make use of binary data
 output optional
Message-ID: <20261114143211.753aaba7@pumpkin>
In-Reply-To: <sashiko-outbox-208980@kernel.org>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
	<20261111115911.1142000-5-david.laight.linux@gmail.com>
	<sashiko-outbox-208980@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 12:32:07 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Medium] scripts/kallsyms: wrong variable negated for negative offsets
>   in write_src()

Will fix in v4 - all the symbols offsets in my build are positive.

> - [Medium] scripts/kallsyms: 9-digit buffer in write_src() clobbers sign
>   on large offsets

I can't count! Only affects kernels that are larger that 1G.

> - [Low] scripts/kallsyms: missing endian.h include for htobe32() and
>   htole32()

Will change since v4 is needed,

David

> --
> 
> commit b5cbf4ceba792715bcee0dd6d58ce67f9542a5ad
> Author: David Laight <david.laight.linux@gmail.com>
> 
> scripts/kallsyms: make use of binary data output optional
> 
> This commit makes the binary output file and input ELF file optional in
> scripts/kallsyms, writes the markers table in target endianness when using
> binary output, and formats pc-relative offsets into a buffer for fwrite().
> 
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index aa3a8ec83fbb8..74db751600b4f 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c  
> [ ... ]
> > @@ -406,51 +417,105 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)  
> [ ... ]
> > +		if (out_bin_file) {
> > +			if ((i & 0xFF) == 0)
> > +				markers[i >> 8] = big_endian ? htobe32(off) : htole32(off);  
> 
> [Severity: Low]
> Does scripts/kallsyms.c need to include <endian.h> for htobe32() and
> htole32()?  Glibc pulls it in transitively through <stdlib.h>, but on
> musl libc hosts neither scripts/kallsyms.c nor its included headers
> declare these functions, breaking the host tool build.
> 
> [ ... ]
> 
> > @@ -458,31 +523,15 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)  
> [ ... ]
> >  	output_label("kallsyms_offsets");
> >  
> >  	for (i = 0; i < table_cnt; i++) {
> >  		if (pc_relative) {
> > +			/* All 64 bit builds and (at least) relocatable 32 bit ones */
> > +			static char line[] = "\t.long\t_text - . +123456789";
> > +			char *end = line + sizeof(line) - 1;
> >  			long long offset = table[i]->addr - _text;
> > +			int off32;
> >  
> >  			if (offset < INT_MIN || offset > INT_MAX) {
> >  				errx(EXIT_FAILURE, "kallsyms failure: "
> > @@ -490,12 +539,28 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
> >  					table[i]->addr);
> >  				exit(EXIT_FAILURE);
> >  			}
> > -			printf("\t.long\t_text - . + (%d)\t/* %s */\n",
> > -			       (int)offset, table[i]->sym);
> > +
> > +			/* Build the line so the the faster fwrite() can be used */
> > +			*end-- = out_bin_file ? '\n' : '\t';
> > +			memset(end - 8, ' ', 8);
> > +			off32 = offset;
> > +			if (off32 < 0) {
> > +				end[-9] = '-';
> > +				offset = -off32;
> > +			} else {
> > +				end[-9] = '+';
> > +			}  
> 
> [Severity: Medium]
> Should this negate off32 (or an unsigned magnitude) instead of assigning
> -off32 back to offset?  Because offset is not used after this point,
> off32 stays negative when a symbol lies below _text, so off32 % 10 in the
> digit loop below yields negative remainders and writes non-digit ASCII
> characters into the assembly output (and -off32 overflows if off32 is
> INT_MIN).
> 
> > +			do
> > +				*end-- = '0' + off32 % 10;
> > +			while (off32 /= 10);  
> 
> [Severity: Medium]
> Can a 10-digit offset in [INT_MIN, INT_MAX] overwrite the '+' or '-' sign
> in line[]?  The template only reserves 9 digit slots after end[-9], so any
> symbol at least 1,000,000,000 bytes from _text runs 10 iterations of the
> loop and clobbers end[-9], emitting invalid assembly syntax.
> 

