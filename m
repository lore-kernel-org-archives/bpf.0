Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7C21D596
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784088920; cv=none; b=fOrscZtRllxvLI1T+hdV4UNDlE4wlZiZwEYAuTC/2Vle8iocecqNGGaogaXe2h9HxVtM+HHUZ7KVloeelG02LCX2XAlBqyJGJJIi2b3hpTL/OVVt6fdgfCPMPy9azQPJkuMhyjJcHtvTmaEXBwhv5Fh52ZjP06KYnd29qxokofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784088920; c=relaxed/simple;
	bh=16DHuToYWDY48zhMFmSTuIb8xl3je5jZqI8M9KYbD6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRtFAMD+d2gvOCiTt9j1DD4lPfAbo6Et4hcEfupDaiSLKqUahv5CN82YfYYXE3x3l7sm6gM7cngWkzHRfOA5f+OYcuadEVUL6tZ/KjJ+TV48Juw/02VDTJpBE7w9G1eIatC0LXJXfu4VmV7tnsOO6CBS1n/uJ45boxmlZmiV+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WZkTsYJQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WZkTsYJQ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69e2266b07fso63232a12.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 21:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784088917; x=1784693717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f5HqzaGK1TaHR8NVrhGDd/lA3x1fxnTO8aG7VNVpk8s=;
        b=WZkTsYJQvvAdyF7lRNbHfK2PJ8PUqYJBllwwU9sVToozvYWYR10L8UH4S7Jt5Ea9fc
         AVeGNGMLMwvDYP38QNvzH3aDwCaoAiYv7cyb+7lbdbQ1RGaRvE6zje7ce1xe+/9oYoa8
         COy4shESM3SbP9ybL2fhuTVAKRbEMVP0CELZ6HOzXiTOkNUo2tgSaiZiPCyLQF8eEAox
         9m4DrLSQ/u5EDLoieBLYheX+YlUFgoM2Wtfxyz6WCLpIG88AL4K7EOBjN1kS1UkYNV19
         lztQKadKV72YWVnL0KoO5VNy/YygwQN9hhZTi5Af+mhcsa5PIbrZxCcBvqKwFIEwEfbb
         ok1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784088917; x=1784693717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5HqzaGK1TaHR8NVrhGDd/lA3x1fxnTO8aG7VNVpk8s=;
        b=HzAWwd6f1nvKQMyHwcx64ivpWLeT+2gukd/p9asqPJsrjvRksqDdpBYx1arnePCIU2
         CAKnI2q96p3hGs2oBOBGCqYgTqxoRy1bjdqqJ6KcxyWFJ6oKQbLlTZYbbju9U2u5fG3I
         hGf60jYXJ23nD3y2gHepqsX7T15aWsaFYt5Mla+SjfYjAqH0Rzzfi750734S2JW4gYU7
         4XiJasR2I4TgKfRf0rYPyRY3dvmCmM6dLt8h7DbG5y9JxrL/se/5lmEifBbmj3XrknyR
         9b28u6uqpqmUQH3EOSZ5OzDOWJqVpYe4p4iTJRfgpaiFT42RuF4tTWoOnowLtoMFG3IV
         e/Zw==
X-Gm-Message-State: AOJu0Yy1o6xys2CNHgJxyn3p83yRrDIxnTArU2alTgFF5gUTONGqRYs7
	dxNERIJIodIK+ssGyMHMCs7R/yjANpXblrUUaTtI6yQUQkSz5tt9mCEbY2qwomDmp6M=
X-Gm-Gg: AfdE7cnNMHL5PXw8pLWdBlNAazRAGKP6WF/v6PKvLD0FTt889UWMmOddEF9NXODnHQc
	p19+6wN47UBnSSNTfzJla286Bj8JcFkL3PRaotBxZQUdJSbkgNUmyuggc8lAqMC1kS3yiMRxGjL
	E42e3XpSC/nEPktVVAYehcoSVkGnJcBjbKqBD/3/cim0xeB8i06fzJjddfRTi83MikpRI2qVXVW
	GHTTPUzZ/lGNN66EWmVIChEooV74eGKPySmNqP/bJQB4a42CIhWheN/ex4WZ8qwkTevHrbFH6Ae
	WgO/qUxnNjUzjiky6IDj47iCiXCdVhAN0LuHYauRkXmbGXuh2/p9l5ai4QCVjhb1xNhz1XeBpqu
	KRahnRrWgs0pWBNec7KlIryl9ouLgJfvHf11md8LvfQUUwc/JyZ4osa4kW5dvyMkAgRRnoWAQ3R
	8OfCPBKrOmzoIGh/0P552w7q3ILWNpX1qi
X-Received: by 2002:a17:907:3f91:b0:c16:67d8:7a0f with SMTP id a640c23a62f3a-c1667d87c1cmr391012266b.28.1784088916647;
        Tue, 14 Jul 2026 21:15:16 -0700 (PDT)
Received: from u94a (27-51-89-168.adsl.fetnet.net. [27.51.89.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238f75sm2427757b3a.9.2026.07.14.21.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 21:15:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 12:15:07 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer
 offsets
Message-ID: <alcGgfNM94zgydlK@u94a>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
 <20260714093846.18159-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714093846.18159-3-sun.jian.kdev@gmail.com>

On Tue, Jul 14, 2026 at 02:38:46AM -0700, Sun Jian wrote:
> Add verifier coverage for constant negative offsets on PTR_TO_TP_BUFFER
> and PTR_TO_BUF pointers. Both programs adjust the buffer pointer by -8
> and access it at offset zero, so the negative effective start must be
> rejected at load time.
[...]
> +	const struct bpf_insn negative_var_off_program[] = {
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
> +		/* make var_off negative, but keep the effective access offset non-negative */
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
> +		/* one byte beyond the end of the writable context */
> +		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6,
> +			    sizeof(struct bpf_testmod_test_writable_ctx) + 8),
> +		BPF_EXIT_INSN(),
> +	};

Come to think of it, perhaps we can add another one that test one byte
*before* the start of the writable context?

I understand that it won't even reach the attachment phase because after
your 1st patch is applied, access to effective negative offset of will
be rejected at load time, but the one that tried to access one byte
before the start of writable context was what that triggered KASAN, and
would be useful to have it as a regression test.

Or alternatively simply change negative_var_off_program[] to be the one
that test access *before* the start of context. I am not even sure if
the compiler generate such pattern; if it doesn't, then this test would
make future refactoring harder without much benefit.

[...]
