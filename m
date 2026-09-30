Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B73519E12
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792486; cv=none; b=Jd4sVdWqA+VhdCYBDpyjt3afFC6JEsmJrkRYjTqKPP5kJ4d34YvRAdlvqYcIG0G9gZWGF2VD3kvIFD8Kiuq7lSGluV2GkTmyTvqMtJL9i4wFENr19WBkVb9TBoN0AqfkKjXT6IFdc50Y//14Kk2Ei80bmZ4nMU1R/iFCA1Xfv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792486; c=relaxed/simple;
	bh=lg6aivrxTqBRLzIPKY88JLYw0CPW4j1nokLPM5koSvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coE9Bf3wDesCvmGi/NXO8KXZIW+eUyxwHDQOJ4MvPdWOT+bQoedrCF43f0m9/xUwcZMyH8htfASuAwfy0vgsQ9TE2kor008XkuTc5Kp3IwBxfaKXI6xoolysW85kPAkHQJ6qpNmRXntDnmubHrK6/fCiLbi50zVpLcn6qPthJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+C9di2n; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+C9di2n"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b059eae96so266807f8f.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790792483; x=1791397283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HmtafwAk9w3FChk+oreA8eX/x5O2/vYIjUw4i9jNPQs=;
        b=m+C9di2nOlgbm7ugL+eTS5bqkExbmcL6ni7dyh6a/9OO4+SUo2X9mytIZP+r23aRL9
         sUyk/el1asOKnS3K6ccNKtOXwsddU4Uyw4PkMD8ZxI+O9FRoXC1UJajcwZ6F4MqiISwI
         vSi18d2eLOUZNbq4r4btHOQTq4z2VsYljEA06cpYwlTudy6zyRGY8z4mjkJzu33tHFm/
         Os0CeYBPgvyA20fRbkTvy7AYKA98NPFB51q2Na16ti0zqSRXtvywD4pASG5UnieE2sXT
         z+gIH62KDG+4sxbH/qyrJzeSbPxQxTQoSrz4BGD1SwSo/lmcoNofZzOIwiGZir+FtQEj
         4HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790792483; x=1791397283;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HmtafwAk9w3FChk+oreA8eX/x5O2/vYIjUw4i9jNPQs=;
        b=IsMp5GwbbNHfYaFZTMr48+erR27wvUiPeInv5z9cQqfbAfUnfmJSvhIDDgavEz+upf
         sk0+hEm0Jh47EVTt193o9ehsavMCqrkc8n4CngV+dT9gGXOo99n1/sG3773FbTAY6V8R
         Plzo/iTf+EjlNKll+qMcKXWI+MCiotCNUmopPUSmtdFxLVDfNbx2pVMJ+8M1flJKpKNB
         14rmFYCjiHAhh647Ej0URYlXcFspumubDKIXrYRDETe2fWK3GCMQHKjA/zsQFADq4vXE
         v3182pw1gm5cmpsebKMv9USbFtKzhaTHyiGxgcNUWi62NBQ7UA48VT6U44q6CbTVYEG4
         r81A==
X-Forwarded-Encrypted: i=1; AKwUvBxIdlsZDacrMLOGMgP9q2/cLeE5WW17DpT0SkpC7txQFiOndNxLqK8PVb18lfKvU3fCMzs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuiy5R8YiNfz6VS7ORTMDnOATxwpRX0x2iJTiTL/RvB5A1B83N
	px8JYYiBX+txNP2NYbjYo6C1Ps/ooYdHXTA5y2NFYBr1NlASpQZakvUp
X-Gm-Gg: AYBFou2poA2pOPodX3516ijlmpSKI4oIaC6Y5oDH7f3SwiraMndrxRcG0v/cBIArkLB
	ZbbiK8JFL1FNnyHqFhZf3J9vpmZHX6WwVYgeBREW21/1aZfOti04zDC3h0yME/g4diwXQUheihB
	AyiWPcbDBa8ZCs3yf0h27a8VvD8PfgFj4m8/g5lOMV4f6b3zEW87JyXrwRCRxgdjPpHKOw+NXw1
	qXSn6Vvf266FquwUYVsw9IS/DhQInE52b5tWku9x4nikoKArRw29/p7jqmLcVwsuSMt2fER5+2q
	7RwrNX5Fk6dStCLPnD3s5OXH5PegPKr8qDE/VDZhYNj6BCr1ouCBdo7IHjq0m4D9I+XFLPrBoTJ
	ptL0u9Z0pwMxzIdP4H1Wp+z40scRTshAWk3d1t6Uhrrsy/UJJ4GELvhF+nS3eRo2JAtRUYWIcuG
	YCqFgEdYYenVWB0CeLqczATbtb7XczzQasXxn6FkBs8mkAacrihY0S/7idwbScv8HmmWOL8DpHf
	xG/NL+Clv2C7G7FBaBJOqyf4CpOR2ZU2Rc=
X-Received: by 2002:a5d:6f1e:0:b0:48a:f247:214a with SMTP id ffacd0b85a97d-48b02431188mr4748619f8f.5.1790792483003;
        Wed, 30 Sep 2026 11:21:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690e19asm816139f8f.18.2026.09.30.11.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:21:22 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:21:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] kallsyms: Optimise symbol name search
Message-ID: <20260930192115.491c461a@pumpkin>
In-Reply-To: <20260930133525.C8CA21F000FF@smtp.kernel.org>
References: <20260930132109.260597-1-david.laight.linux@gmail.com>
	<20260930132109.260597-3-david.laight.linux@gmail.com>
	<20260930133525.C8CA21F000FF@smtp.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 13:35:25 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] kallsyms: 32-bit offset truncation in scripts/kallsyms.c causes panic
> - [Medium] kallsyms: off-by-one in get_name_address binary search bounds doubles scan time
> --
> 
> commit aa83959ffd157437ca56938c0da66225c5fc9aaf
> Author: David Laight <david.laight.linux@gmail.com>
> 
> kallsyms: Optimise symbol name search
> 
> Change the alphabetically ordered lookup table (kallsyms_seqs_of_names)
> with one that indexes the table of compressed names rather than the
> array of symbol values. This removes linear scans during the binary search
> for the symbol name.
> 
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index d18d78e626db2..2f39fa850deae 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c  
> [ ... ]
> > @@ -177,6 +177,36 @@ static unsigned int get_symbol_offset(unsigned long pos)
> >  	return name - kallsyms_names;
> >  }
> >  
> > +/*
> > + * Find the value of a symbol givem the offset in the compressed stream.
> > + */
> > +static unsigned long get_name_address(unsigned int name_offset)
> > +{
> > +	unsigned int low, pos, high;
> > +
> > +	low = 0;
> > +	high = kallsyms_num_syms >> 8;
> > +
> > +	while (high - low > 1) {  
> 
> [Severity: Medium]
> Since high acts as an exclusive upper bound here, doesn't this omit the final
> lookup marker from the search space if kallsyms_num_syms is not an exact
> multiple of 256?
> 
> Any kallsyms lookup for symbols in the last partial block (up to 255 symbols)
> might fall back to the second-to-last marker, unnecessarily doubling the
> linear scan fallback duration.

I'll double check.
This matched one of the other scans.
I did check the first and last symbols (by name and number could be found). 

> 
> > +		pos = low + (high - low) / 2;
> > +		if (name_offset >= kallsyms_markers[pos])
> > +			low = pos;
> > +		else
> > +			high = pos;
> > +	}  
> [ ... ]
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 494852ade6d87..74264ead1efe1 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c  
> [ ... ]
> > @@ -448,13 +439,28 @@ static void write_src(void)
> >  	printf("\n");
> >  
> >  	sort_symbols_by_name();
> > -	output_label("kallsyms_seqs_of_names");
> > -	for (i = 0; i < table_cnt; i++)
> > -		printf("\t.byte 0x%02x, 0x%02x, 0x%02x\t/* %s */\n",
> > -			(unsigned char)(table[i]->seq >> 16),
> > -			(unsigned char)(table[i]->seq >> 8),
> > -			(unsigned char)(table[i]->seq >> 0),
> > -		       table[i]->sym);
> > +	if (table_size < (1u << 24)) {
> > +		output_label("kallsyms_off24_of_names");
> > +		for (i = 0; i < table_cnt; i++) {
> > +			printf("\t.byte 0x%02x, 0x%02x, 0x%02x\t/* %s */\n",
> > +#ifdef CONFIG_CPU_BIG_ENDIAN
> > +				(unsigned char)(table[i]->seq >> 16),
> > +				(unsigned char)(table[i]->seq >> 8),
> > +				(unsigned char)(table[i]->seq >> 0),
> > +#else
> > +				(unsigned char)(table[i]->seq >> 0),
> > +				(unsigned char)(table[i]->seq >> 8),
> > +				(unsigned char)(table[i]->seq >> 16),
> > +#endif
> > +			       table[i]->sym);
> > +		}
> > +	} else {
> > +		output_label("kallsyms_off32_of_names");
> > +		for (i = 0; i < table_cnt; i++) {
> > +			printf("\t.long %#04x\t/* %s */\n",
> > +				table[i]->seq >> 16, table[i]->sym);  
> 
> [Severity: High]
> Does this code inadvertently truncate the 32-bit offset?

That is a C&P error :-(

David

> 
> When the compressed symbol table exceeds 16MB (such as in allyesconfig builds),
> this code shifts table[i]->seq right by 16 bits. This unconditionally discards
> the lower 16 bits of the sequence offset.
> 
> Could this corrupt the lookup table kallsyms_off32_of_names and lead to a
> panic during boot when the kernel attempts to look up wild memory addresses?
> 
> > +		}
> > +	}
> >  	printf("\n");
> >  }  
> 

