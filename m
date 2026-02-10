Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224332ABCF
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759725; cv=none; b=EPu9070DogIG8hWrDJ8CVqnGRQDkgJ15paYGVqf34Kan9t3i8Z7n/fbzyG83iKdwrAknAOpTinTWUZbLxWl7LivbYad8ikXxSrCkqrx/i3JJQu8oOFDkJQdCMUmOaplMZSPZmWQ3Pi8f9BDVa7TialZcCCsyQdE7N8x8ITtSiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759725; c=relaxed/simple;
	bh=++5C+WbJLxmGHUXQuuM+mG2vQ+nrCXeiqTx33Y5OROY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVNuaJdnDyVRELq/782aa5p3AwCK3ypjUFRNXwe/DZx76wVq6iwooVGRXhKZFqrBhJFjOyladvnSB0KALGlUYZ6/FVnypRSngfoHL63R/vgt6MAhX6brsqCMurKP3kms2ehVPR+piYT/YP4DXyFg/0Ou72cGguTIvf8fp5sWBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqYHlD/S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqYHlD/S"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so58067475e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770759722; x=1771364522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mznFkkE5Sy4uQAB5r8Z5+NdhEJ0VFdYRjnQi6n0QRfQ=;
        b=XqYHlD/SbcXTX75V8u9cUJsa3migCchkW6JZqeV5mqDSj8i4zGv6cfd+OthhL57ASD
         1cfSYb/PI2M5GY/zEfRAjBmmHZVDohP/VoeNJBRfZf9G2yzh1c7VKNc4Qz6FEIEqyYHd
         Te2Iz4nnqAPB3JMZXJjbPegLDbJyvMBeuEPqc8LY96ObGmp5gEo/mWO57zlMuiJkYm3W
         sqSinqhvkZBc15JavW/qOcP2UAojyLyZ7fUwXI8OTpTcFT+meh3lGcifts+eCrRZiQOe
         Vhrl2KmWQ12WzBMTdJfyuegqcuUjy/Dc/4+fusl/Wb0JUOeSyj15Ytd9EN/v8cCQ/LaT
         uRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770759722; x=1771364522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mznFkkE5Sy4uQAB5r8Z5+NdhEJ0VFdYRjnQi6n0QRfQ=;
        b=sZS1JJNJRw3nHFND2dIw/ArHGtwl5DqgeowB89Cg3yyVbABXt18iPm5nLSLoIe3jw+
         13xA17T/g8ofrYlFaNDInVal0lWqOmoXY/3CyxEtqwRrxc8vW41rjq3YzU6wpWxLICko
         Ez9qRbq7/0yw7gWtTge0MNDJbxCB2cM6NTPh/iqJ7FN2YoszjbERZMbdNVkdsXvDuxKe
         KL2ZFTfce9IXsjPLAEd0LY9Duobab6s+DXlV5/Ah4pDrxyplWOeOghuuWjlkwC6VQKX0
         hepaFAAmkLp7Z4qgzuf8y9eZdLa6hH1OW7HiwIRQ0vVgoV78EsLl4m0TCyNrwCqS/bu2
         ng6w==
X-Forwarded-Encrypted: i=1; AJvYcCUIWUF9UCf4qAka1QZbip4Ir2Ofr1jvTCdreMg3osOxVowcss7EtmU2omne6JO52CAwfIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KYzwv9E7Ili/iJLCldMPYYe/yDb26LUz8vy58DwwJkN/sxVn
	SgBvZkNN3ohGUroR6RmoJvZ3s41HRBdoTkufA0F4bd6E0QB2tMmuh0Wy
X-Gm-Gg: AZuq6aIjU/eu0fC3B8Y6W4YW+0lCOUyeLOWRWImiJtx6fDrCm7LB9VmLUjXMtSdxSCu
	yq0rM2txB2ZKeI77I9bPSpjLIdRuP2IlrkeGe85FeiWyJbv7mkl/dN4JYjPpbBUxM8AokDJR/GH
	/L+eQWDR2rwPZUKb7r8QgIW16MSyJTQfmKM4kC6cop1+3HC1Y/Mx9X6hIPkm2ep/TRSU+zs/jhA
	RIH35DkOE4hFN8Mw5P/fCTizcXIGMONlJoVjkElwCd38fDh8OFxBXSrzQE+DcYZ2r9HYbo8UDJA
	Xwk0jQZerI+vcfml24CXew5Jbh+EflGPX60b85B34fkFetj60CANQ6nZUeBGrqLAQmIdd4QJMSP
	qPPGs/wAwFV8mrQeMrC1CIa143BM3AlzLv7dXkOfPbMNQAiaLc10D1rB2RzqGp6G8C4GoXeVV7e
	0SzoJQusCVGvk=
X-Received: by 2002:a05:600c:8587:b0:480:6941:d38c with SMTP id 5b1f17b1804b1-4835082d177mr52982815e9.29.1770759722099;
        Tue, 10 Feb 2026 13:42:02 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a5bf1efsm9740635e9.0.2026.02.10.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:42:01 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Feb 2026 22:41:59 +0100
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 5/5] selftests/bpf: Add usdt trigger bench
Message-ID: <aYumJ5MINI-nT4xU@krava>
References: <20260210133649.524292-6-jolsa@kernel.org>
 <aab191dcc7036e9ee105171cb4414df51c2ac0593daffff06c00e484b89c48b0@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab191dcc7036e9ee105171cb4414df51c2ac0593daffff06c00e484b89c48b0@mail.kernel.org>

On Tue, Feb 10, 2026 at 02:12:11PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > index 4ea0422d1042..f631706bbdc9 100644
> 
> [ ... ]
> 
> > @@ -180,3 +181,10 @@ int bench_trigger_rawtp(void *ctx)
> >  	handle(ctx);
> >  	return 0;
> >  }
> > +
> > +SEC("usdt")
> > +int bench_trigger_usdt(void *ctx)
> 
> Should this use SEC("?usdt") instead of SEC("usdt")?

ah yes it should, will fix, thanks

jirka

> 
> All other programs in this file use the '?' prefix to disable autoload by
> default:
> 
>     SEC("?uprobe")
>     SEC("?uprobe.multi")
>     SEC("?raw_tp")
>     SEC("?kprobe/bpf_get_numa_node_id")
>     ...
> 
> Without the '?' prefix, bench_trigger_usdt will be auto-loaded whenever the
> trigger_bench skeleton is loaded by any benchmark using setup_ctx()/load_ctx(),
> adding unnecessary overhead to unrelated benchmarks.
> 
> > +{
> > +	inc_counter();
> > +	return 0;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21867569087
> 
> AI-authorship-score: low
> AI-authorship-explanation: The commit exhibits natural kernel developer style with real benchmark data, informal comments, and follows existing codebase patterns with minor inconsistencies typical of human development.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor pattern inconsistency in test code where SEC("usdt") should use SEC("?usdt") to match the established convention for disabling autoload by default.

