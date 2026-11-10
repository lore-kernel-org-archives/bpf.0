Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318682;
	b=IWglqn7eq7scToMsjmYbAVBX1F3ot6w9p4lqUTYpJFknbIaQJLVMmwq+maJZlTB5Qzor
	 uO3GHoZz0FimshZvmhHPH41JrJ9QVO+v6Vtdl7erthkr6EjDUJU4QBo4D6Xg/CFfe9IIY
	 0eyqlA0vjFPMlriUxAdU9A7j5pqqudp8iyQSY6GHpdFjuq2nGmRuMr8X5cXsTF1C9BFkl
	 0k2OHSKm2aadNNyzl0+CVL32D6LQtP34wQsbA/Sa+K1OsCEGAvQel+rXG0rQEPEeB5o2e
	 VRM+AtiiPFwEpvgcGvQya6dzrdGBTTkO92HM6QZ/9yMv3aQTralk/h+J7R/U62CgZcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=x1qBW8RoYHIsd8MuKQz0jzwuZbI8dPJ3tz/udwg6UjY=;
	b=X2LIVe6km8RfnytmJRAmtm/Ct10mp/fm/ZYSMEPZzkUFetm70++tZgQviiNeklMeP+nD
	 jS7OPVtOI1pnQtCvnQTY7t5V3y6OGfiBnOJWssc4//cfziNkmwNOE6s+9zMMUFMSt0mZM
	 TZLplemBBGJYtGM1QT7YEr8p6Nz353T1c3GQZzRg7HEmPAVJ05k0xdwwa4L64dojzDTm+
	 qSzEybLc3ZZBZVZ2ntOryqDryAeZBz+umDX+cxynfdlrpWwTxZuD3tgYaajPinxRVgu+e
	 PYyg+7KbCk9BEaKmr5HNPXPEQsVQFdUZhsU9S6DkLnD4FGpWTSrV1syxmZGSSiLU7sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKjaivIt;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D990606A321
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D990606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKjaivIt
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so17394375e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318680; x=1794923480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1qBW8RoYHIsd8MuKQz0jzwuZbI8dPJ3tz/udwg6UjY=;
        b=WKjaivItfPGf1vLYiZe1ufT9ND8ivobVNmmgJ9QSpL6M71YrFIdQrEZSC873reDfUy
         lbcISDgE0nzps2hmXEDQ31Ld8KKepHFTWeby8GK0bKKWO/sPXbyRIfReJxh9NVhEA4W8
         ylccNGSgZoEC2DNFIbM1opNxTIzooxaIZte9FU3RQMpBTlwbp6Iham7UM84RPxmJimVv
         2svlzvXdCziWbS1/6Huqi0VbsXsvfwpD0W2vjZZJIUGmpiT39kiNFT/YJEYgbrtpCb5u
         ZNkLgbs+NAAGtXag1cAku8dO+ZEQNtVgWm4ZUmG7najz3WCtCoH0VldDuAoHRgIQkVid
         1Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318680; x=1794923480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x1qBW8RoYHIsd8MuKQz0jzwuZbI8dPJ3tz/udwg6UjY=;
        b=kl0JseVlJyg5G7C8UFzy61F04+CCwGNriUrv8G3aXk6HNX31b2k4x9sQcbf2UKxrVo
         0bgGNScDX0+eWWsMYtLKUtZX8JXTmIP0jnAY9yDB1k9FfZVOSGhSMDOHvVVU1ndr4edw
         ABTREnSd1iqBtv/5oI1KWj6KwTMiXjJm7Cnr8GGeM6M/SCjyF62oG1auItBzbn6KxiwE
         8abgr9gmOi8djYnEzttKUeNDCiKGKtH+bkRF+yiGzIl2Cl9NTRquGtHtOa6gCzS32gx2
         fRFvboKAlUW96h98Y04fDgWrzgOR4jgJCCHcBCi6Dfia96qmNhQ4uoNbv/AZjl4LiPXg
         Bt+A==
X-Gm-Message-State: APuU4Z/tX8g8UKvrFgSp1O7sm0qYiVAoMmKyIc7yJS929IWGrstvrou6
	GWPAlRBXTbPxW+8kqDeYJzpXmGCyyWOpjfIGLsQklnkrODKmqhnLTSst
X-Gm-Gg: AYBFou2UwUjDvxyieTpSICa5qDsM5iedi5dO0D2pyZ9ACrRv6LHjAP2iBkYkksTBfKM
	cgOK/ofq46YpAPyGPaIzW9rzKZ9R30i0NFtIOz5ZtpA36Oa1WJe+upSeLtpxnm90pTIIU3aNqpm
	/Qu6O2zqUoPtnNV+SVJ+SLaztTsq2L51kciNFQywBQgRBVGVmRBp3bQHSZvHwqq12rcoXNP56yS
	dN4UT5jlLwAmrOK4ZfUZjsRr9lbZJklmh3yDn04Bz/rqYFbSLFcy8A2x9GP29q3tKcwLMa0N+aO
	4qFfe7zLx+w4UBgTIxvSkzHR/GkcJt7DuWNf/1Q/OKhMiwJQS0/Uoz3h3d2zzsn5P5SAKj/xcRT
	7DrTtA2cCDktn4dkiS6twP0lU/LQABZKJmrsVLx2Wg4KAt3OFipC1ZdCRfkJDt0oOuKlhOfr8+l
	+3UGe1MD2Hb9KL5PbXApt61WdifofLYnOT6pXsxSqiKqYq+1Ztpf7HhO6TSp3DUtnIXlqwZZ9pj
	G/ftx+BbkMnuq3Z1B3fJPre/nOvLoHxIQlO5PXdhXt6tCzH7sUqKMayfuqOxDtk30dqjcLHR9/M
	hFUpMh5zMTYOfxi438nD/uowAHJ65+giAkTFPQ==
X-Received: by 2002:a05:600c:3e1a:b0:4a1:de8a:603a with SMTP id 5b1f17b1804b1-4ba0233a429mr47496295e9.6.1794318679654;
        Tue, 10 Nov 2026 05:51:19 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fef1d0sm64488975e9.13.2026.11.10.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:51:18 -0800 (PST)
Date: Tue, 10 Nov 2026 14:02:50 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 07/18] scripts: Add LLVM plugin infrastructure
Message-ID: <avMkCh9LLezKS151@mail.gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
 <20261109170550.141443-8-a.s.protopopov@gmail.com>
 <sashiko-outbox-205331@kernel.org>
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
In-Reply-To: <sashiko-outbox-205331@kernel.org>

On 26/11/09 05:45PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Low] riscv: pi: filter out LLVM_PLUGINS_CFLAGS from KBUILD_CFLAGS
> - [Low] vdso: avoid stripping LLVM_PLUGINS_CFLAGS from kernel objects
> --

no, riscv is not supported yet, vdso is not target for fmodret

> commit 072fb07f8d2d07b80e87b0ea8e05cc60c466504e
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> scripts: Add LLVM plugin infrastructure
> 
> This commit adds Kbuild and Kconfig infrastructure for building and loading
> LLVM IR pass plugins with -fpass-plugin, and excludes LLVM_PLUGINS_CFLAGS
> from vDSO, EFI stub, and early boot builds.
> 
> > diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
> > index a273ab5af805c..5813bb75c9925 100644
> > --- a/arch/arm64/kernel/pi/Makefile
> > +++ b/arch/arm64/kernel/pi/Makefile
> > @@ -10,6 +10,7 @@ KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
> >  		   -D__DISABLE_EXPORTS -ffreestanding -D__NO_FORTIFY \
> >  		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
> >  		   $(CONFIG_CC_OPT_NO_ADDRSIG)
> > +KBUILD_CFLAGS	:= $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
> 
> [Severity: Low]
> Should arch/riscv/kernel/pi/Makefile also filter out $(LLVM_PLUGINS_CFLAGS)
> from KBUILD_CFLAGS?
> 
> Like arch/arm64/kernel/pi/Makefile, it compiles pre-MMU position-independent
> early boot objects with -fpie and -ffreestanding, filters out
> CC_FLAGS_FTRACE and CC_FLAGS_LTO, and prefixes symbols with __pi_ via
> objcopy.  Leaving LLVM_PLUGINS_CFLAGS enabled there can break symbol
> confinement or introduce absolute addresses before the MMU and relocations
> are active.
> 
> [ ... ]
> 
> > diff --git a/lib/vdso/Makefile.include b/lib/vdso/Makefile.include
> > index cedbf15f80874..848d58296ba23 100644
> > --- a/lib/vdso/Makefile.include
> > +++ b/lib/vdso/Makefile.include
> > @@ -1,5 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > +# vDSO code executes outside the kernel.
> > +KBUILD_CFLAGS := $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
> > +
> >  GENERIC_VDSO_MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
> >  GENERIC_VDSO_DIR := $(dir $(GENERIC_VDSO_MK_PATH))
> 
> [Severity: Low]
> Does stripping $(LLVM_PLUGINS_CFLAGS) from the directory-wide KBUILD_CFLAGS
> here also drop LLVM plugins from standard in-kernel objects built in those
> directories?
> 
> Makefiles that include lib/vdso/Makefile.include also build obj-y kernel
> objects linked into vmlinux, such as arch/sparc/vdso/vma.o and the
> vdso*-image.o targets in arch/x86/entry/vdso/common/Makefile.include,
> arch/sparc/vdso/Makefile, and arch/mips/vdso/Makefile.  Those Makefiles
> scope $(GCC_PLUGINS_CFLAGS) removal to $(vobjs) (as this patch does for
> arch/x86/um/vdso/Makefile), whereas modifying KBUILD_CFLAGS unconditionally
> in lib/vdso/Makefile.include prevents enabled LLVM plugins from running on
> the in-kernel objects and drops their <generated/llvm-plugins.h> rebuild
> dependency.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261109170550.141443-1-a.s.protopopov@gmail.com?part=7
