Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C52459CF
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341458; cv=none; b=M8Ty3qLMFQJbnOKP1qlYoh8Z2qQu14N17fsgmvpGs7QcNGCn1U41SnkfjRoheGEBEVUyZJNQ0Tzdnmt4Fvu5Ko/GU9z3gdYbr2alO2ZbNMJ7ImHMGZQjcmZFKhwMJBx5LlqWJMwO/cIHpXXpC9BLVDy144/8QqAt/Z80/fWzXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341458; c=relaxed/simple;
	bh=Dn4leQDbq1m2uRP6oBxoD4WvGafxPMKi/15ipQiHAi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thl0fDDWa2HPe6IkDJ0oaT6eQOLDS/w6r93ByrXodUP8O623wDPA0k1eO/jSTZNvueWAIOc1hfwt+r+/KVR2OZmXZQPFEaCV/2eqRcmyoG/t6rnwGMn42KWu0tHqAQ5zfosHKJlRWV3ECn5LDd2HA+GMR5tpFJXTRCyjQKpxuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJpuPVzg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJpuPVzg"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-487049569b6so633254f8f.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792341442; x=1792946242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ua6j+thg4pXL7S9wJjMaHKA5Xj0iNYktIJ1108GNG0g=;
        b=mJpuPVzgqQPFcwoo1L6pEA/TslRAE2R1gmXrKcFArmF9WjqxWBdHcaYfjSm4sOAG4c
         T4NIb5jOJX0fkepYWcGbLcqtCV7o5wq3rK81IJKQv2hvlrmGkNosv4NMB22Ld6I26e0S
         Aa8rpFtLqOoiUQiohX/ZERFZNTO+aaut5s/2R3dgG4nWRn89JDKMaK+lGDpNk9nq81LQ
         v+m8jirZY2ZM5DJ8YyfrFeT49l+6FcYs/NLJwzU4HHy2tc/j057LuvmuaUUGLsovHbjq
         x+P6lO4SPtaZfwu9goSxdC27ikY7J+oCR+ucDWMMsMbj2vXVZfuFy6WOugVWfJWDOny4
         bL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341442; x=1792946242;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ua6j+thg4pXL7S9wJjMaHKA5Xj0iNYktIJ1108GNG0g=;
        b=HgUUqermbzYamZSyKU/9t5yObemuM4FnVu8ijPWoIu948/aN1nI8PYZlV5XUCqK2TN
         xy9UxoLTE2l0rkkUEfgqjs6VHWxN4GkncSeOuX1ooj/deqhpEcan+S0e38Zx8Vp+jMjP
         /KqUmGIYwQPU3jQydg/TBINRwQRrg95E+YZ+x3dXpFE8W1rHpCLpigFLpD4ZrkF0OC/6
         OBIwZpz/Vdxnu50S911Zs0wndQbcwoQOFSJaXWRbaEmFq6sYtOcYe6I/bxkG8bydBz8p
         E2aC9t6hsQIMEZnwZOPbbiMSr9ONdkTgity1wgPPkrV7/oKPMMiTg9T6Y236RBtRFNTi
         kV4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLjmpJ/a7ZRkDHF3+m+F/+iMV9ISRFjioFYGlAsbOWZ53j4cTRSoxo3dAceukBJbiyADE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlWbjswYjbIQZxOaoo4CAgOF9AQlL/ZtRM77f4tG8OIBIo43qi
	717v0NCyVLKzPzEjeZ/mCy6or8gZ2VJaMPuHPDQ4VjDy0cK5nK7ceewk
X-Gm-Gg: AYBFou1mmA5NYnEtng/9ReL0RkvbqRT5CuFiSlbP8frMHeqN8aqdqR91WKOQPulaG+l
	4v1TrDv6u5fUR4svGs1TbU7JcyxiiM6tsSUQtsuYf1l3uL5l42usB4HPbV3fOBDt/xEiyNGMdet
	/ZbAMKY0QJUtiDJK9Mvc+DaJ45dg51/ANYSlKSIu/67rDEF7LzBqBZsH8La52b7I9JdujAoPVSr
	IV7STD6tzeE/IPljQxxO6Mv07dQuZ20G1SmSDXMi5vBTiDI7dQL1O3417tI+MRPXCyvDwgk3UTO
	oaVHkQV0bQrdwvPmS0Oau890744mwl4P6fc7o5sKsam15o1Qf8oaWRg0WZJEjfR5ELbKe6J5P+5
	HE0A+El/q/HV88Q6HGFTYgrzE6gU46DTmXaocn/kPTRwPBCpMTTrKQ/+JDkkHso9od6TYkyNdYF
	DRZPvZz+arH8sLi9vyjc69PouMiIzOzHbPtOYsg2SiwVuM4B7o9UYrEc2RTP/4wdcKJZideyAFC
	QffxVaOE/fjlSIOAfh854WwR4JkyWJKsGw=
X-Received: by 2002:a05:6000:4382:b0:48e:932:aef5 with SMTP id ffacd0b85a97d-48e0932b0d7mr10246501f8f.21.1792341442100;
        Sun, 18 Oct 2026 09:37:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5033a2sm17651691f8f.45.2026.10.18.09.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:37:21 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:37:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Andrew Morton"
 <akpm@linux-foundation.org>, "Petr Mladek" <pmladek@suse.com>, "Kees Cook"
 <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, nathan@kernel.org, nsc@kernel.org
Subject: Re: [PATCH v2 next 11/15] kallsyms: scripts/kallsyms: Keep full
 expansion of tokens
Message-ID: <20261018173720.142adfde@pumpkin>
In-Reply-To: <sashiko-outbox-176255@kernel.org>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
	<20261018155206.132411-12-david.laight.linux@gmail.com>
	<sashiko-outbox-176255@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 16:00:02 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kallsyms: NULL token_table[].str passed to printf() in write_src()
> --
> 
> commit b464b94e58431a4ad1ec112c739d63f16547b8f2
> Author: David Laight <david.laight.linux@gmail.com>
> 
> kallsyms: scripts/kallsyms: Keep full expansion of tokens
> 
> This commit stores the full NUL-terminated string expansion for each token
> in token_table[] as tokens are allocated, avoiding recursive symbol
> expansions later.
> 
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 5603b2a6c77bd..9e1bc0fdaa9f2 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c  
> [ ... ]
> > @@ -415,9 +403,8 @@ static void write_src(void)
> >  	off = 0;
> >  	for (i = 0; i < 256; i++) {
> >  		best_idx[i] = off;
> > -		expand_symbol(token_table[i].ch, token_table[i].len, buf);
> > -		printf("\t.asciz\t\"%s\"\n", buf);
> > -		off += strlen(buf) + 1;
> > +		off += token_table[i].len + 1;
> > +		printf("\t.asciz\t\"%s\"\n", token_table[i].str);
> >  	}
> >  	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
> >  	printf("\n");  
> 
> [Severity: High]
> Can token_table[i].str be NULL here when some token slots remain unused?

Probably :-(

> In insert_real_symbols_in_table(), token_table[i].str is only allocated for
> character codes present in the input symbols:
> 
> 	for (i = 0; i <= 255; i++) {
> 		if (!token_table[i].len)
> 			continue;
> 		token_table[i].str = xmalloc(2);
> 		token_table[i].str[0] = i;
> 		token_table[i].str[1] = 0;
> 	}
> 
> Then in optimize_result(), the loop stops early as soon as find_best_token()
> finds no remaining token pairs with positive profit:
> 
> 		best = find_best_token();
> 		if (best < 0)
> 			break;
> 
> Any remaining unused entries in token_table[] keep len == 0 and str == NULL.
> During pass 0 in scripts/link-vmlinux.sh, kallsyms is invoked on an empty
> symbol file (.tmp_vmlinux0.syms), leaving all 256 token_table[i].str
> pointers as NULL.
> 
> Previously, expand_symbol() wrote an empty string into buf when len was 0.
> Passing a NULL token_table[i].str to printf("%s") in write_src() causes a
> segmentation fault on non-glibc hosts (such as musl) or prints "(null)" on
> glibc hosts while advancing off by only 1 byte, which corrupts
> kallsyms_token_table and best_idx[].

For glibc builds it won't really matter - that corrupt file doesn't matter
and in reality there are always enough symbols.

I'll add ?: "" to the code.

David


