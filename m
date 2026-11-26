Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795653751;
	b=ggz0BxWCurzfWQaoCHXy5z8doKZLSzKDKKMTflr64VwZWnSExdZGmMOmaxTTLZ+5s5Hy
	 jSQB/9i1dXbYDAT0rmp02wmguLgKXm8sIPjaqSt8w8rapSvkGVOBHxTSFk4ASI4OKWGu9
	 CxdW3ZudTMqdG5kFHSdgd2Y2Nf+6iUSNiEaW/ct6G/pKF/6GYjW0rzp58lOPsMiKR7Eqy
	 OCu71tfGefGDFESQFBG91F2qm+Fu0AQtz1kQTfJbMR/BNiTIEHFTQTv8ur6To2ke+u3w3
	 n2B5xqwXyONDy9Vng/SBHT4ot92oXVUg+3dqVIkbZcaQxIU2iV0TbfEU1gS8owvz5gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
	b=mwf2Ja51g0a3ma1U9VIQmUkpUvnVtA+J1JYeEBN3iI3pN40LEShWLxO26i11dTUw+UFJ
	 gI0iyBQMs4CMoXvIunsMpqXVI6tufbiHQmJi2iN7rtN/GT/5jp2W09WXVhezmwsxCb1gR
	 dO7DzfZf0RqTwHcgdTA9C/iGXH7vVsdfwNl3dpZGeV1qN5OJd9EysRGOQlksYsipiSjfd
	 84MD/BGGqYhfCqhfiPQUmDHWEsvnz73Y/pSm1DiKovZCjsgAGCkQEGv6rCNs1M6YDFCud
	 6wzW5e8RzcA/sZoOF9NalAWnHFI81oRLP90aVLvjYo/pOrDXZjCSAM0Y2M2TEIupqGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpN49+az;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB63606A32D
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB63606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpN49+az
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4322d310e7so109261266b.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795653749; cv=none;
        d=google.com; s=arc-20260327;
        b=rdybMvvnELRxAUaIL7Btvbjqlh49MXgBCWppvbDeQnijZZCQ54W8jC4FTSD3SsLTRK
         +UVj9UXBUHlYsYSYTiPxCBt1GKLmEZhTJaW7vGfjNYf+6kiUjHUn3pBHaeQvF1TRVxPZ
         r6bWVa7bAkp4P+GLLwyDv3P3TthqwWEA84Qa/XdEI+jtxUrpx3YagI2R0UzinBebRe7T
         njHq1sK/6zBFCOtyv8/3tK6hf6x/YlrsVq9ohqpnb+KbqBVb3MBCPOj6gZ5+Q7qFXoeI
         HpbKhEnqtAngb/uByrLOlV4Iq03Chpz8TudGI4fEa4e6/i1g1gi5VnxrOAGP31Sj3aPW
         5ekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        fh=xM+ZMfY68ZxVNTnbUKBDLBYZ6441ifXRMJl9K6fOhaE=;
        b=CD9ayAkTUrM7F44ta0R/m6/k0Q9v6C6yvpQhZ4/oWmiqR6SquPImV2ajBZ/jek4Y3k
         egBs+c2swoPuorDlUdKzyZAiV7xeE0OLg42oEMjgiTu8HW1vQadltbvYNTC3tvgoOa9O
         YIXduEW9TH6H+NSng/go5X6a292TRcQaj8Pj91NzNhZAOeBpMmou5fxy8+EGveGqpfny
         YA0q6VE/nA1v+EV7xAfh2NuLB7kkxiJQueaxtaovUF5VZlgfKtNZbyvQrBJjBWdn4Fzy
         ZroKdiVV2UW+3dRD7Blz/Mp1xkmPrKzr3Qon6R0K8BtxFYR2U7W4Gy30i8T8OsXGVDq6
         Tw2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653749; x=1796258549; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        b=LpN49+azCIrNLot1wWdZkbi4Wt9+5r7MX19ZP740YGH95NjHPkEZ3J8iTn5nZs2aU0
         YtfDizzXcozDLpMOLK52IGL19BDPPkZBwwaARaxU027w//2VU6VirePpo9PC6B6/Gvyf
         w2GVoXFxRvXbXsOKb1KJ+C3LWAAUbXNTn5yq/DRtNMB33KVLBN+E7CMg2n3o0WEACasU
         2Rm6jn9HoFPOXbo7vWifWbukhD/T5j5US9xUFhxajKYt4rvNrF1rO1KNwomR3ZLuXZ6w
         QUOmuxgTXoYSvlHBVpUm9Y0LfNn1TpJbekKTAn/WwvKBAhjn4jwfG9HFJEBd61cyDiFr
         AG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653749; x=1796258549;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        b=sH76N/FrVlO3roA3ePXklKxSdbWBDRRF85jhVHgAoLRJ+09Yh27nOiLUcoGkFfBN0E
         a+lUojynmjpMCrIv45U9frkLj8wsSWghkjDDYX9VAe6aRIOXUveoWPzwweVIFeSC5CSN
         58w+Ks51fH/Qben7h96oIWOYlV+dFhvUALpSWwk+bQKbgDpWPqYVqU6zLbgE4vo3E9vd
         h1PKriHSsk19e2vYFx124LMPPTsVe0owm3ZJLSmxGPB1wqH4j/x35HfkzoGwRRCn6jct
         xYb1KI2A2uLxquG0SzRwtKDCgkZt6jjzYUTFwT9/xmizcsf3fA2n4wkkL8EorQXzt1gV
         ioNw==
X-Forwarded-Encrypted: i=1; AL+hErEB6W/fU9Ue2OTLDAyOxSmHWJQJKulYb8D6pIOsD1SQ7Zw4lDAZvjpZRQUOUpkUibNUabc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qi4AzQeVPmEyvIM3kwJMz6tFya7vb4Tttu7ZEDpbhXnFjqzfa
	7SZrZ+8ragQc9QZ39LVAGnK6tXiMZcuUnApwCvHPIgTsq9813YJISdRg0wFMyH8PnNJxGwjEKNJ
	HjWTI/RzZO1Xf5ZQ2BfribmelOro6Iu+sEqgaki68
X-Gm-Gg: AZFdTZeQPiIYbrbUKrIDaTe1qlt2um9q9XtbUt8iUaMQag77kfy6KEX9XiPofU/+jIz
	HKbDXM3ao38QcCcibJXAm3L+rYVLoqSPBaHqP3nB/e67YcLOF8iOrSkkkibIIMPobaaNxazfId2
	bkzSz64NUsIWPDSWvk4RmWlmWk6+lS98+WdZpBd3rdpya6mRQwltXuQn7mh0bMBCCVou6IruJJv
	ggz6PuFZpvBaQpY05wb9dKPfqYCPU58t1cmrzAkI8v15J5CzB3ACgZGvlfmXFb938ChP+mTLXXj
	unj8rEkRTNbAKZZx5RWDJ52oGBOjaunPcbzdusQ4U369kqx2bU11sPakUmJv+w/K5QvvSNJmiWr
	ogrLs1fueNy4o4rn+uFaTDVTttueHWwtCWazGxzu7OTCDzhEBcionm+lTAKATJQzkC2bAtZPMGZ
	7oCMxiAiwxX726
X-Received: by 2002:a17:907:da1:b0:c50:5275:fb97 with SMTP id
 a640c23a62f3a-c513acb5e2emr1626085466b.47.1795653748662; Wed, 25 Nov 2026
 16:42:28 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-13-wusamuel@google.com> <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
In-Reply-To: <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:42:17 -0800
X-Gm-Features: Aa3M54rYVczs2SqMo55_UQYl-QiaJqAFTx0CS_STMdfssfUbqw_TSopd5IfB7RE
Message-ID: <CAG2KctrMMo0j9Mnbg8fdNsSc-eQaaaW51dO4mqwVNn3hfSdx_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[...]
> > + */
> > +int module_kallsyms_find_name(unsigned int *symnum,
> > +                           const struct kallsyms_name_query *q,
> > +                           unsigned long *value, char *name,
> > +                           char *module_name)
>
> Nit: kernel/module/kallsyms.c already contains a zoo of lookup functions
> with similar names. Adding module_kallsyms_find_name() adds more to the
> confusion, being similar to module_kallsyms_lookup_name() and
> find_kallsyms_symbol_value().
>
> I suggest calling it module_kallsyms_query_name() to match the
> kallsyms_name_query parameter and to express that this is a structured
> query, as opposed to a simple by-name lookup. It might be a good idea to
> similarly stick to "query" instead of "find" in kernel/kallsyms.c.
>
> Otherwise, this looks ok to me from the modules perspective. Feel free
> to add:
>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
>
> --
> Thanks,
> Petr

Sounds good, will apply s/find/query/ in v4. Thanks for the review Petr!
