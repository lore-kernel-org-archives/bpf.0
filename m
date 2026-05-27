Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2C3C2B84
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875843; cv=none; b=KnDQiIe7vSQbWge5lh0a1N+0NUZmOnHLxiZ3bM+K6MOT+b2m3wgQGD6aYa6XgavLhLMaq+g24wvonUq5t5/TqgmsfN50omkblwtXWQTwfd6ufVIFDHtOAHCPGyOTT+V+MSIjHCKe98lTbpRVh3O4WtaSI+4Z9JhQXY5ZrH4pAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875843; c=relaxed/simple;
	bh=++tgT2Sz0TpWfiXXAm/QF+e/DOGLWBskiZrFnEqVsSE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOFMBCnAp7QHeWPB/uMN2cMtn3GpSTAFT0mgScNIv7FBMW9/XcEnr5/jwmGZjticufoYfZslKH2Fp2sMz+kn/AgYDEaxDdcge6Tce3onNiH1GomiQBxVwxy7+hGcR8i2IF6kApPHie1C+1VM7969+kfAjVLsgM5CsYhYijpuxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef2ISrmG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef2ISrmG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44e1860558fso7296843f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875840; x=1780480640; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FC7ZL5PTAZWI+jfnZHPihHv7ZDUJ8Gkzr3+eQaCgs2w=;
        b=ef2ISrmGJTwyC0W2lJUFlZveNzYTKzrz2iwdHCMOozi855p8TCpAlp6oa8X6psQsu3
         nrxHsySRjFC47aDvLtq7rrveebF+ZhJb817AZpmSR2J6xNxkK1GpRKEOz0thLxbu1lyb
         HRyNeF2dICah85TGm1/AKVI7XTmihxgyUxLJpuT0Ca+LzqAcV7RCJJmin8b10/T4XCrw
         SxfvNj5Pr2IW55GxobTSGAlhvEhpi/Wp/NXutHWSrignfDxkLUUmcukO3ESpmfa5LP5W
         V8pDMXSenxGorPC0ReT7Xf+zATyOsn0hM2YQ0Yzb978iQIkyOiR0qIJaHsS7FitL0GY9
         cXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875840; x=1780480640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FC7ZL5PTAZWI+jfnZHPihHv7ZDUJ8Gkzr3+eQaCgs2w=;
        b=tVbyLkZ6mAPOSIn4w8F+XljBGyEUcfXYmbsGWtBB+kbJh8/z0c1lXxvI0JTh7ATnQS
         /CVS/x7V6+iCVq/ijtZqo0f8AdSW7eVCH+wEUJ6FxapiYLwnrlZVdTTn6RnlyuBM8iXX
         X+b8MoS8c1OXu4LzIAy3YNVrvUsOFe0Y/NHPqaNO5bAgDbFliWl6N+1Z3To7BMHmDIKv
         FfAX3L4p3WDnIBQKyFrbYerI7/hlg0EMdOOYHsGBJdNZPbilWfGTe2X2IcVGkD4tIxEX
         lHJs4h6iJdFV3BBdljKOnu7lU/WTKYr8fKJJsXKsbRrbCwwNQ5OUy2p5+8o5t/NKiMa7
         QpFQ==
X-Gm-Message-State: AOJu0YzEPpykRsXOJDc1CoofDTSPFvq6hZaXcI6GGo6dRiqnAOP64bmN
	HtLCMh+QjUeBG0p2qFbmynrmNeUWe2Fk1SSLrFXU4ePopkzFk05qgF5cdXDdyQ==
X-Gm-Gg: Acq92OE2wpv6HbTRqRjL44y2eQQgLWe7zBLa/KgRHPNun6ll7zywdSEsD1H54Dd+i8k
	0KiRKnhnKV975DUGcs8qkHSWBlj/9PN1xlXZCwdeP7Kt6N6p6QsR+R9xat3Zkp/8aKdcSB/ne3N
	2SUtYwy9YA8Fy+1uYlt3i+Oud5pzHBLkpu1lM49mzJbcaWXnWYnmSnX/zMci4Rc66927LkF37nz
	wTtNo7mPAw8qcoIUVwhO7XglRk9ka1Z7PMvnM9c90f4x1QFUX5uLOYPHvfOK8E352AZAHAeBmCi
	xZIhuO4aEkwDJ5BTojL9O5OwmDHqA1FRJS2vPH7CNSeoB5arxQyQyF6+G+VXqllvUMZgAwICd1F
	69ONXT04f34bJM0X0Ah43AdSZUFkdz7b+XyFkGO4tzq+KDkFk6ofRrVmSqDU43jsmbJT+3bytjy
	CGuqRnpo1E5dnYkHUUf9ROkREFGA==
X-Received: by 2002:a5d:64e4:0:b0:45e:779a:302c with SMTP id ffacd0b85a97d-45eb38d297amr39611266f8f.29.1779875839707;
        Wed, 27 May 2026 02:57:19 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb4bae01sm4843151f8f.0.2026.05.27.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:57:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 11:57:17 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv4 06/13] libbpf: Change has_nop_combo to work on top of
 nop10
Message-ID: <aha__UZNxWCT2ZFj@krava>
References: <20260526205840.173790-7-jolsa@kernel.org>
 <20260526212840.1053C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526212840.1053C1F000E9@smtp.kernel.org>

On Tue, May 26, 2026 at 09:28:39PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch invalidly replaces `nop5` optimization support with `nop10`, which cannot be optimized by the kernel, breaks backward compatibility for existing binaries, and causes selftest failures.
> --
> 
> commit df13b5dc7675e7ea56d8d1775d22295b93e92ab0
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> libbpf: Change has_nop_combo to work on top of nop10
> 
> This commit updates the USDT nop combo detection to expect a 10-byte nop
> instead of a 5-byte nop. It updates has_nop_combo() to match the new byte
> sequence.
> 
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index e3710933fd52a..484a4354e82ba 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> [ ... ]
> > @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
> >  #if defined(__x86_64__)
> >  static bool has_nop_combo(int fd, long off)
> >  {
> > -	unsigned char nop_combo[6] = {
> > -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> > +	unsigned char nop_combo[11] = {
> > +		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
> >  	};
> > -	unsigned char buf[6];
> > +	unsigned char buf[11];
> >  
> > -	if (pread(fd, buf, 6, off) != 6)
> > +	if (pread(fd, buf, 11, off) != 11)
> >  		return false;
> > -	return memcmp(buf, nop_combo, 6) == 0;
> > +	return memcmp(buf, nop_combo, 11) == 0;
> >  }
> 
> [Severity: High]
> Does replacing the 5-byte nop detection with a 10-byte nop detection break the
> kernel's uprobe optimization logic?
> 
> Looking at the kernel's can_optimize() in arch/x86/kernel/uprobes.c, it
> strictly requires the replaced instruction to be exactly 5 bytes. A 10-byte
> instruction fails this length check, causing the kernel to silently abort
> optimization and fall back to an unoptimized int3 probe.

this seems wrong, the related kernel change is part of the patchset

jirka

> 
> Additionally, replacing this entirely rather than supplementing it means
> libbpf no longer recognizes the nop5 combo in existing binaries. This causes
> existing USDTs to fall back to unoptimized probes and breaks BPF selftests
> that expect the +1 offset applied.
> 
> Finally, if the kernel ever updated can_optimize() to allow 10-byte nops,
> sys_uprobe() currently hardcodes a return adjustment of regs->ip += 5.
> Returning +5 bytes into a 10-byte instruction would resume execution in the
> middle of the nop sequence, which could cause an application crash.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260526205840.173790-7-jolsa@kernel.org?part=1
