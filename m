Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DAD3ACA60
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342064; cv=none; b=Tr5919Zu9ZvdKEAISpzhPDKzSRV56uE3003G0B8RpUGfOEJvnNKVIDUdD/GoYv1bHlBuRcRJVcPDlG9H+0HlBh7dGu5PqaUnGMeKwMefg/VBYtMbbpf5aaXnrImLXZI7+vGb1xiCzg7GqCVu61bcbddBM+KIfa1h+RN/LJ3DAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342064; c=relaxed/simple;
	bh=F4gfl0+YMk4ioGpONVD79EZfw8vpMfcktCDSQJ6061I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLczbf12oinHvFchWNTSMmbAb+Wi0axU2Ti/dutlyPabf5EtBWr//2hogzCoR/fRzWZFNgHIWZyw4apuT3FbCLsrDC0FWickxILcF5Vh5zy+WVrrnc0QYSevSGWu60d0pV21LF0Le/24osmEEF9pwvrEjhQlh9EX/qW/I+P3AGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShcgmJ9u; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShcgmJ9u"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso681987f8f.3
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792342061; x=1792946861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EnjrROwlUYtLbg1DZjsxtXuCk8E0M6SVTV0/eLvG49o=;
        b=ShcgmJ9ucl1pJplXjVLsArfDouBdEHDwbnFGeTNkK2xNU4qrVIMF54nVyliorb7u6j
         RtIMFSW8NeLkGwPdEMr9foBt1TxQtRncw3i3KEUF+QPHs46on6yd9SWg1IzkGNgSPi2U
         3bBKN7QGrx3fUBGga8IiDSWS1m4r6vexqcPFgiGbRnES68vWYFdI5CWX5WGXwsctBs3g
         bct2+NEBicR5a8TDbApbRyUBAsfzuoiaMt686eQOXbSYzxYmbbXbdHNSsFixOq8gMUi5
         UWxDM6bTguJnCBJzIuluTho8uyTSOe0Vx4x12jVqVuUiSUi+0rg6T0yy2Vn0Jz2jI5ii
         L1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792342061; x=1792946861;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnjrROwlUYtLbg1DZjsxtXuCk8E0M6SVTV0/eLvG49o=;
        b=G01SlBXImHZBRo2KGVUqWpILJ3oCohypnIWw2qrzDOzvPSGi+LtVRaw1lKtyLZJr+C
         6FUPgpOCoXWlUUHdkXb3aFivEzNalFDEgsi8vI/zfuWsO/xwQJyQZ2kv5f4DY8qnRvVF
         xORAUDDTFmydSyzmCx4moRcXlkEb2Wl6H0xFr6OVP4V1SKzlkPG8XI6pVnOscXA0Wn/+
         /1qA3Wk1dIkIiKC1eMeS6VgmNLxvO34Iiu8PaAf1kT6USHkQa69flMRnLTNvXlXX4evy
         WtPHnfgY5xjHdJIq56h+CjlKUq7Nnh7LuMqhO1P740ae4vEUrP+Rw5vSJyZRCC5k6Eqf
         QxIA==
X-Forwarded-Encrypted: i=1; AKwUvBzoqVtUQIwFqiNhXMZf1QKekqkkAlmyo6Mo5xEtzWnMPfn7H5xdKbWQo3W1BEMt2K/dzOE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN31NXTvYTX9cCa19q8GITgtEpf5Idmy8u+VQmWTOmSGjqXfEP
	WSpYgn7U1cIr+upmI8NTKflUX62mq6agRV4b6HcpMXs2uzmUuy/u5N9I
X-Gm-Gg: AYBFou2m0qBmVTFSZURNOiE7X8sqz65ybfMiM6fLr1/uom0ADnbry5BBGW73tAGrevf
	YgCrCxTPwmFq3GtWKW6VyYGG3GN6wY84Ab7sZZ0SwJUzQPWtyrCmEXFE1dB2qF1VwyhpEgDDQJC
	miBIexhq2gPH0t/wycZKEXb7Ek7gc83mqSqA/jcenpjsp70cUcxCFBK3zkFsbYQ80C/WwJAWPY5
	6DU961gx3JL38Meobkv0wSUEd/AoIfN/1u+jyL4ioaB7FIDWTGNsPk1fsGzR34dQUIMwc1IFoKU
	LK6qZanSY2BRi5Jwcjv2HVM0S7d5FTPgavI1IGtSTQoMXqZVGFUG8veG1N6Ru2C56yknFIkPSXb
	z3t1y3NrGaUBKu0xwoLtH1PvjxmUyHQAUVtr5dUg11yLMT8SRR4ID9xzL2wX3+qLfhpUY1kIxwk
	KspvBBlgB9W69onSF3BidAcB0l8UxNMWMVAa1gucaUbGO58oXobtSDg7khMuP4unViEGd4GcdOn
	T9eS5J9/d1lJ4Ws3Dqjrg141uKy6McMV2Y=
X-Received: by 2002:a05:6000:654:b0:48c:557d:ab24 with SMTP id ffacd0b85a97d-48e079800d3mr8049235f8f.4.1792342060574;
        Sun, 18 Oct 2026 09:47:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503d78sm17256266f8f.50.2026.10.18.09.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:47:40 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:47:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Andrew Morton"
 <akpm@linux-foundation.org>, "Petr Mladek" <pmladek@suse.com>, "Kees Cook"
 <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, nathan@kernel.org, nsc@kernel.org
Subject: Re: [PATCH 14/15] kallsyms: scripts/kallsyms: Reduce the output
 file size
Message-ID: <20261018174738.79ae97b3@pumpkin>
In-Reply-To: <sashiko-outbox-176260@kernel.org>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
	<20261018155206.132411-15-david.laight.linux@gmail.com>
	<sashiko-outbox-176260@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 16:05:41 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kallsyms: NULL dereference and offset mismatch in write_src() on unused tokens
> --
> 
> commit 20102d6e3b81d88a59f6ac3b9732c8a7b28d3f98
> Author: David Laight <david.laight.linux@gmail.com>
> 
> kallsyms: scripts/kallsyms: Reduce the output file size
> 
> This commit reduces the size of the assembly output generated by
> scripts/kallsyms by formatting byte values in decimal, packing multiple
> values per line for kallsyms_token_index and kallsyms_markers, moving the
> token tables first, and replacing duplicate symbol name comments with
> symbol offsets.
> 
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 189fb50ec8c58..8576fe6ad90b7 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c
> > @@ -350,6 +350,30 @@ static void write_src(void)
> >  	struct sym_entry *se;
> >  
> >  	printf("\t.section .rodata, \"a\"\n");
> > +	printf("\n");
> > +
> > +	output_label("kallsyms_token_table");
> > +	off = 0;
> > +	for (i = 0; i < 256; i++) {
> > +		best_idx[i] = off;
> > +		off += token_table[i].len + 1;
> > +		printf("\t.asciz\t\"%s\"\t/* %u: %u */\n",
> > +		       token_table[i].str, i, token_table[i].refs);
> > +	}  
> 
> [Severity: High]
> Can token_table[i].str be NULL here when fewer than 256 tokens are
> populated?

This is the same issue it found earlier in patch 11.

David

> 
> During pass 0 of a CONFIG_KALLSYMS=y build, scripts/link-vmlinux.sh runs
> scripts/kallsyms on an empty symbol file:
> 
> scripts/link-vmlinux.sh:kallsyms_step() {
>     ...
>     if is_enabled CONFIG_KALLSYMS; then
>         true > .tmp_vmlinux0.syms
>         kallsyms .tmp_vmlinux0.syms .tmp_vmlinux0.kallsyms
>     fi
>     ...
> }
> 
> When symbol_cnt is 0 (or whenever the input symbols do not populate all
> 256 entries), insert_real_symbols_in_table() leaves token_table[i].str as
> NULL and token_table[i].len as 0 for unreferenced tokens:
> 
> scripts/kallsyms.c:insert_real_symbols_in_table() {
>     ...
>     for (i = 0; i <= 255; i++) {
>         if (!token_table[i].refs)
>             continue;
>         token_table[i].len = 1;
>         token_table[i].str = xmalloc(2);
>         token_table[i].str[0] = i;
>         token_table[i].str[1] = 0;
>     }
> }
> 
> In optimize_result(), find_best_token() then returns -1 and breaks out of
> the loop before filling the remaining unused tokens.
> 
> When write_src() passes token_table[i].str to printf("%s"), isn't that
> undefined behavior that segfaults on non-glibc hosts (such as musl)? Also,
> on glibc hosts where printf("%s", NULL) outputs "(null)" (7 bytes
> including the NUL terminator in .asciz), off is only incremented by
> token_table[i].len + 1 (1 byte), which mismatches the actual size emitted
> into kallsyms_token_table and corrupts the offsets recorded in best_idx[].
> 
> [ ... ]
> 

