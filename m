Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228648;
	b=P2Je0AFfIZNHtpcONtUxl6cdz+6WIGkchfREXSH6ERgtlAaRnObwuVAJAabHSPonIaC/
	 SkgVI5bNhJgH4pk7lXC/JC34hLr+HaNP2D00nr6ugxCmtuWoKsyNiQRPvRhUwPjU1YBLg
	 71qBWwa8WXhbSyAroLcfanrUq7Wys9XISx43sSEsWnolSCRgQoqQufLkZfgYOeHcSjR9R
	 JFJP5x0qO1zjbLXvIhRCUIDM072wmx/zT111x5Wed3krYbhUpu39ENb5g2LCrDnBXnbMA
	 I0kaqq5E0KNIWzSN7BHYUUREOCTjj45ENsVt0KrvDWP+B8X0kFMZppmF9/VxNcnX0eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=YOpZi2VaklejSB7LucRgCO/ffxcIRCTN66BQYsC8WYw=;
	b=IPvfobgH16r7unzvDtd6FdSX+sy4TqTJcJrHYJi7eAH66JHvdbtCYiLz3O2RhjdHcLIt
	 +30ojyOCSAA9A0pRmNxyUxHaPpxQimbSe2qvdceFmXNJUjJ0UwaVJEwL/VE37mQcFeuQ1
	 SVB2Zt/iurxZ3Iub862mTuMS8f66QAgx4j7aSCl3tp+X/QYe+wP0A/unjWa3WePweTYGu
	 JLWAJLuaNcNL5Or2PYOfnUHwElXN49NXj47woqUZ7Er8ILAlc9aehJFllAyL8r/smQiOo
	 iL8uMlyBNYKoD5cAr2sFPt836b5zWf6itYDWq1b9mnFPg+1tQ2Rca8MyNweo7d3GnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=keaVCFqO;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B86606A322
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 12:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B86606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=keaVCFqO
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso8448895e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 04:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794228646; x=1794833446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YOpZi2VaklejSB7LucRgCO/ffxcIRCTN66BQYsC8WYw=;
        b=keaVCFqOAP78EpUbHh1CL5ySC0dYGYnvn515n8Q/hAjAKRWhc9yjx1CxX6lcNI6M6O
         Q8AH95KIWB2wleawXdJRbOdI4aTkqHkyIKP+2+KyuHJFRWROKam1o3FcBg4VC6C+Fq/f
         5gfww6Y2/VT/jpMPgWQ4mS3p5Ns6BfImY5hrmTLExdNv5lIuu5D0Onb3hBVFQOh+d03Y
         qTdr1M5joe/EaDhKvBbF/8+KJkR1o/hjUC5DL3FZXTFWInwO016+O+2vFlzKmHiJOyBR
         2So+z/Iv7RIclft52QzzYWY2SaLiiRKR7C9iOBTqTX1fdACEue/jtq/Qvvz75rzCakwP
         kxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228646; x=1794833446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YOpZi2VaklejSB7LucRgCO/ffxcIRCTN66BQYsC8WYw=;
        b=VQe42aMdbYPcpLPywQ5kkuMy6XInEko64wBwVNCuOsSa41fhBf6U21f8dBxRjEJqwt
         d8TI0+zDAbYwUn21Dcl4c3oHllQtY60hH2Wipa/bM6113NbGKog8ymOfeXT8vbNASDgj
         B7+1X76lcx2y36P8kUa3dy51B3vt3LnDWtiYBVH8csZfoIaqi5qPw2JdTvDiqFijHZO5
         czhfqtxCYxJTk89BT8qFgCAT8/FiLiHIeVsYGdqqS/TU9GAQ9Exk5g1BC1JyGOS7HwkF
         /o1MMegGiCR0t5BZA64ghLzOnCqkWf+NGRSTJxDbca8F3eF/8M3RSHtGxpx/JD8mkbI1
         OSjw==
X-Gm-Message-State: APuU4Z9humjetTbvAQBe42kH+NWhaoL7kan/4XTIqHVC1kX2wo0neFqj
	7xQPNX454M7B04LAOr5G3pljRJPWOioNbVNG5zn7QDHTYQOPsxHFf/N3
X-Gm-Gg: AYBFou3Wdm1UJ6iF3bdN4L0UWTB0Aey6wq9jy6/EiFBlyAOy0cpwnJ6TVJ+H4ms5job
	MxSwE/6KJJkUSP2FFVR5uXusWI2yA3yHoRCNc/s/8kYvrwhPOpN4M8H9YSZzDw4MeBOoVAqZ+go
	6TsMN9+/Z+J+E6XzZhBurIbwpHmMrXgn6nMxQhS9x3zNO5jL9TmD0fcyE/GVB0wO0KFQ+MaJqnd
	r+GXz11OVgf1Z3j+Pop8oAfLPzi9PG6WGbyzVGAznKflBvbYbW0kC/6O1HKeDJ/ZtMIvjGbw4YZ
	69Mhysxb0N5ygsuxR9BA9ws3Wslpzm4xBMcR9xXaq0RMlRYt9XkWIUGgHK0yWPVvpexFkoVsD8f
	7iFMUtpE99Ik/jFs/S3FjRIn0KxkRAR1KbJ1lIdTx84kzT7sag3IUD3xgBorh3ulLU+T89edMun
	d046q6M7FTBdY85o4r67yHUvN0I4k4yHiAlsRNQUe3/n5R2ucmB2XsqWOC2SBRckNL6K7zJ0OHS
	OhHvlcvzn5xVOLQU4LEQlX5ZpZWB80E428HyY4n4DCDLKz5+c60OBgDwLm6Ys7hSQ3hEkZWr5e/
	RWJCdAtD/DalYyjZzdF2GueYvIpEnKA5vvyJfQ==
X-Received: by 2002:a05:600c:83c7:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4b960d9bb6amr69706665e9.11.1794228645804;
        Mon, 09 Nov 2026 04:50:45 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb134ccsm213302635e9.10.2026.11.09.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:50:45 -0800 (PST)
Date: Mon, 9 Nov 2026 13:02:19 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 02/18] bpf: Add a btf_id_set8_entry helper
Message-ID: <avHEW-2OG8govtYR@mail.gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
 <20261106210314.1767267-2-a.s.protopopov@gmail.com>
 <sashiko-outbox-202267@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-202267@kernel.org>

On 26/11/06 08:58PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] bpf: kfunc sets destruction on failure in
>   btf_populate_kfunc_set() [1]
> --
> 
> commit 0f99bfedbc98b8fbe7b7a25dd4038c3e714adb73
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> bpf: Add a btf_id_set8_entry helper
> 
> This commit names the element type of struct btf_id_set8 as struct
> btf_id_set8_pair, introduces btf_id_set8_entry() to look up a pair, and
> changes btf_id_set8_contains() to return a boolean.
> 
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 228b93d4f8c94..61d2df6776a99 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -9973,8 +9973,8 @@ static u32 *btf_kfunc_id_set_contains(const struct btf *btf,
> >  				      enum btf_kfunc_hook hook,
> >  				      u32 kfunc_btf_id)
> >  {
> > +	struct btf_id_set8_pair *pair;
> >  	struct btf_id_set8 *set;
> > -	u32 *id;
> >  
> >  	if (hook >= BTF_KFUNC_HOOK_MAX)
> >  		return NULL;
> > @@ -9983,11 +9983,10 @@ static u32 *btf_kfunc_id_set_contains(const struct btf *btf,
> >  	set = btf->kfunc_set_tab->sets[hook];
> >  	if (!set)
> >  		return NULL;
> > -	id = btf_id_set8_contains(set, kfunc_btf_id);
> > -	if (!id)
> > +	pair = btf_id_set8_entry(set, kfunc_btf_id);
> > +	if (!pair)
> >  		return NULL;
> > -	/* The flags for BTF ID are located next to it */
> > -	return id + 1;
> > +	return &pair->flags;
> >  }
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but...

Maybe we can do a separate sink for such reports?  Or some tagging such that
this is easier to follow up later?

> btf_populate_kfunc_set() function that populates btf->kfunc_set_tab, does an
> error on a later registration destroy all previously registered kfunc sets
> [1]?
> 
> kernel/bpf/btf.c:btf_populate_kfunc_set() {
>     ...
> 	/* Grow set */
> 	set = krealloc(tab->sets[hook],
> 		       struct_size(set, pairs, set_cnt + add_set->cnt),
> 		       GFP_KERNEL | __GFP_NOWARN);
> 	if (!set) {
> 		ret = -ENOMEM;
> 		goto end;
> 	}
>     ...
> end:
> 	btf_free_kfunc_set_tab(btf);
> 	return ret;
> }
> 
> Multiple subsystems register kfunc sets into the shared vmlinux BTF.  If a
> later registration fails in krealloc() or exceeds BTF_KFUNC_SET_MAX_CNT,
> jumping to end calls btf_free_kfunc_set_tab(), which frees every hook's set
> and clears btf->kfunc_set_tab, breaking all previously registered kfuncs.

For the error itself. The only non-deterministic way to fail here
is with -ENOMEM (on boot, which is not realistic). Other ways to fail
will fail during tests. So any cleanup looks "reasonable".

> [1] https://sashiko.dev/#/bug/linux-1a311d3c-46c9-4fa6-a26e-40badcd832d8
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261106205523.1765622-1-a.s.protopopov@gmail.com?part=2
