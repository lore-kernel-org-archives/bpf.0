Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72F34A78F
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848337; cv=none; b=BgahfNUKxnJc4rRcXTWKcBtJOHBBJWGvv4ETif5vRiGZuYZWdqc4/ovCBdZugX8yk2TquK6NVhXsPo8HIfBOwVIfAoxIZilqh+xjqvwuOKpQadWotk4dalHm3pxh5NiguCGLDomswBWiU3H7TJNMMpGYKm+sDgRFCVTFTMpPC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848337; c=relaxed/simple;
	bh=Gp+S0v1rYV7hpzCCANfT++44VMYZp/S22ThXtTKVNRw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzeu+wrl0Yh1+U6IwHJfxFZ3vYBwPcQRb+3hZ2VSa9FPHNczoiS92cis7DDOTH9/T8XezbCPhMDkJmk0wkr6XlaHhD1crq55czojLBTtG2Z6WYLvdGzDxzIeQLPO6VabAEquIHzt5u51ABQQWi4wfFNn12ZQDQircEu4ZYfmLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmcIpH2L; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmcIpH2L"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so46392495e9.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848333; x=1779453133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IrShLxsV3WkUC0fBh2wRnSsPzj6d/MK1yXuxavlu4hc=;
        b=fmcIpH2L4kP+AnICi6/95Bhd381AlYkKSfLd+oX7CqwT8j84M0ePliaOqq+fS3IhNl
         er7kX0Zc8mOLVOaumoQmnC92ofHinVupbqTUtVrNc3yMr1IfPn+INR1JU9qc0/pJ9q/C
         qvZuWAZZlLmFXnZf8toJLT46BRjI2QFs6OGmdwgqZsRuCeYttfxSCj0NnnmlxSQnbYcR
         MVcGsr1/8R9Lc6po3T0Mrzemn+4zZD+nW/Dc0auSbbq7mPgoctTkO3I7b1gG8ohD9DZl
         P5rsLdLc0RsfmGfxPNeTU0nl/2JhGPni4Il9UtlkxugQv0lC5HwK1Zco86NJrqXkPc+s
         9qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848333; x=1779453133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrShLxsV3WkUC0fBh2wRnSsPzj6d/MK1yXuxavlu4hc=;
        b=AgVIBfhu40Jo2gqMJDqsAJsJ9nRdXj/7QwALg4nRQVMY6SrxfdXwkwJ26On6sX6oHL
         AZjQ3dmHpwhuPMNSKr7laBrTHccnGts4TccQBqZK62qTTacNJLcXN1HK5PiM2WtKpu1s
         5qd7P+wdB5bbY11bPhTCemoDdMBjarnbwAYjl1c6TScSvasbsa4Dgg2/XsI4+ZmEE+6z
         5UOTcu93H26Eip3x8HPU4NB+5XsWEKtVASpyEkZt7tGYnMQ9ttmV78irh9WlgU8dpovy
         b4w2/TDDSLeZ5x7lDkKiJh3u2O1+CBz0RyKEee5JSmPk8dsMxnq9vOQoAFKH0pZL8a9S
         858A==
X-Gm-Message-State: AOJu0YwWqZ3rnlE36dhf0hxRBoCh4mu0QUGFHwp75QuNyGHcTvRGxm1a
	rC3ZdzoENcUVWszwTtaMOUUf8Ole+VnF8SK4quiZmAQD4zyE6/MaPbMY
X-Gm-Gg: Acq92OG0M48FfXx0UPc4K5U0CIqgLUKO9fDX2bPd5l+NQRt3nqYS1HynC8OJkft8Xnh
	7jUhfwF/blUOwedNKY5WhEKG7pAdSNHgjWCNFlOQaTU8x8RPK7JliQKuFDMq2mh858UGvP1dbyN
	rozNk3UmgUpQe4PXEOYnZpVe7X2BUzRJgfyms//zRA/TvvC3OAh1YTrWQ+Qe9u+Kp8HZZpoDHIP
	Ih2InodPY8IPxivNzjEPe8hjW+7HLbKwQuDKdz/iRhgkeY1EVsl+gQryPPSdbXkyKfBp3bAUGJQ
	z1kIlkBXaC0GQWETGEbHAy/jC/RSjoFKjtu7FWi4OJDe/q+y+uDCIWt3HhSXdE3EnpIL2Z2pcUa
	CyFNjslvYxCfntrnWx39zgj1VsBPsXGIR4CjL47vQBSx2a6WrIoTQJGK0pZ1heNeu3ODdExsMPA
	JCZ2QlZ0ovxBBjNTs=
X-Received: by 2002:a05:600c:34d4:b0:48f:e230:c3fa with SMTP id 5b1f17b1804b1-48fe6626a58mr51392865e9.32.1778848333256;
        Fri, 15 May 2026 05:32:13 -0700 (PDT)
Received: from krava ([2a00:102a:4039:3341:dfc:8dc0:b9c5:81b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fbfsm105593905e9.6.2026.05.15.05.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:32:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 May 2026 14:32:10 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 3/7] selftests/bpf: Emit nop,nop10 instructions combo for
 x86_64 arch
Message-ID: <agcSSnEu0nWsWgvc@krava>
References: <20260514135342.22130-4-jolsa@kernel.org>
 <20260514204426.36E20C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514204426.36E20C2BCB3@smtp.kernel.org>

On Thu, May 14, 2026 at 08:44:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit modifies `USDT_NOP` in `usdt.h` to an 11-byte `nop,nop10` sequence but does not update `prog_tests/usdt.c`, causing the selftest to break and introducing a git bisect regression.
> --
> 
> commit 600c1890b9793e001b5d8d9027629fb122af9024
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
>     
> This commit updates the USDT_NOP macro in usdt.h for x86_64 to emit an
> 11-byte nop, nop10 instruction sequence instead of the previous nop, nop5
> sequence. It synchronizes with the latest usdt.h changes to utilize nop10
> optimization support.
> 
> > diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
> > --- a/tools/testing/selftests/bpf/usdt.h
> > +++ b/tools/testing/selftests/bpf/usdt.h
> 
> [ ... ]
> 
> > @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
> >  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
> >  #define USDT_NOP			nop 0
> >  #elif defined(__x86_64__)
> > -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
> > +#define USDT_NOP                       .byte 0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */
> 
> Does changing this instruction sequence from 6 bytes to 11 bytes without
> updating prog_tests/usdt.c in the same commit cause a test breakage?
> 
> The selftest in prog_tests/usdt.c hardcodes the old 6-byte nop1_nop5_combo
> and searches for it using find_instr(usdt_2, nop1_nop5_combo, 6). Because
> the old sequence is no longer present in usdt_2.c, find_instr will return
> NULL, causing the ASSERT_OK_PTR assertion to fail.
> 
> I see this is addressed later in the series in commit
> ca88e95623000540d5b706ce364d5b5abf75b4c1. Would it be better to squash the
> test update into this commit to avoid breaking git bisect?

yep, selftests are modified in following change

> Additionally, looking at that later commit, it updates nop1_nop10_combo to
> 11 bytes but appears to continue passing 6 as the size argument to
> find_instr. Should that size argument be updated to 11 as well?

yep, will update

jirka
