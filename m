Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FD386561
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093117; cv=none; b=A9Jp/zrZIoU+RxaE3yW6Iq78WL0L4/4zp2PiboQz1QW6zTlk2oNTPU9sKi7eQDzPQHfkSA3ij+qOJDWu7PKPbU/47DLSeb/0yF1bIByENYwm8Am5YhZKFGMfDH283Q/xPpCN30dByFSPGmfikgyqAPgcC76ExlvIUTQ7WsmNTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093117; c=relaxed/simple;
	bh=PmpScwcGJyXezoD1P7i8aSqy8+IuUXibgGwQ+ap6uj0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2f5eqUhIThf2rdnfa5SwkbjmIpOS4aY1qc6P1459GHgTUR6ZfDioglAEAKyzdc+1WgMh1P69hLUuZCa/GCwZA+uUUTeTGUXEdFh5iJIE9Dbjx/vfkEg3VGynb8DDZVB7tJt0ULQlXiXYJvz8kS0yMvP1vDnsFmNeJikf40Cz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqYMJKhI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqYMJKhI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7e23defbso988348f8f.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779093115; x=1779697915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw8ouC4hEgSVvRs2LGBCbdqdtEj1Oh885FP+LlzBSas=;
        b=PqYMJKhIq/F8qbQY7HS+jpofpzVmcW/ZQPBdrj5s0enRqwWfVvdY0oxi3wpjE8kEYv
         aIIbMKO3fMPFzfb8+kWYlYNEElvH/+yvpoyxUH7oLiNR0RkpTLFAptMcOCyKZEP3I7Q0
         uwQ5qIObPapxT4o2ko/UD8RuxO8FPMFTKd4S0rWfiDX0zOwOE7CLkRLDI08MmXfKkcer
         cuc6DCOv+6xtYE0drcoYxJr9fhC0OXAdrESAmX5O5dvsFcizIHeoL8VtsSLsthx64TAL
         mMXWWSFSFQZyTl9BYlYgKaOIFTcLTzB5v5RMQpqWDPZYNESfEbiqVyOgSDpvZiqGH6j9
         O/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779093115; x=1779697915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw8ouC4hEgSVvRs2LGBCbdqdtEj1Oh885FP+LlzBSas=;
        b=XsPF7AOBGJYn3+apojUILeIhQUbRW/b4UMmWADPx1oseVY8o48lpOrYvCn/YfiJZZf
         LexoJ/YwCgxWErjsoi9p8vlQbRMN28L0fsdRE8YLqrO8wwTNJrb24fXzERcXh7B6OTTh
         +LQFO4u7S/UrJ2CzodBw2eZCovEnBtytyqYzNxhCVOwshF/ewKVboeFSma9KcgkJZzgq
         y8Pfmz+GURr/lRL9w7/DR5WKWY1lz/Hxn/tmkC9i5I51md/qOJO3M7t7gopFPAyLwjSm
         GTnCtms+1oPe91TbBo9URk1ieraJ6vkeLkKMDYQ6Hli+x0/JHWppO2drRgtTaQ1bym7L
         bL0A==
X-Forwarded-Encrypted: i=1; AFNElJ/fduKlzp4ezhTj3uj9cn5SxuB5CB9jM1SC88+fb1IeByLsJefva/W72hYs9h0HXybOWZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmFahom8JTL+dxP2BSKgGBNSXKL2ARGMe6IsyGaTCV9IqosAm
	lcjxCwksd8PD0yYw7zRy+5p5UmvA2a47lQ2Y0db+g3RxIZ9WeNdjBGwqhchgcngk
X-Gm-Gg: Acq92OEyRdUk7ucI0vhzAAeW0xWpfqcMpEBSJ3NZspRGBRA53Szag8SGDtc794w3yhV
	apE+cj5DGsYg8YJhnhyZKFxyjk44jHqcYA0o3LdoR57Di1IVCK0IvRnO1iPMwM4HGGGuu+DOhVr
	4rxJha7cNK6iPZ8Y0bqY/geiuF3jl3+NPm4Xq+MUOzDhoVSWZvwFTGJYADRpOa9/g4/BVsg4dcA
	FcTrbjyF5xxtbKtbCQvJOwvTb3s6Nw+7lmS1oUT3dxIsNI9ozBEUYAaN+4OLc/rELb8CqGGnGrE
	X3DltIHOxOpPAsNTESvBfIXTDXx+Hp3OC5PITYBL6+DLSQ9Qbk9U2Orqp1BzyuRRjDdY93dEUhZ
	yPwXi3LSf7wxCjl1G0vO0oqWGY2GrVeXsFaTezFBM/rO2x2wnixbHKJtN5ZGkkwg2T0BkWlcp0r
	6k5UjpwTCTGxQ6zK8=
X-Received: by 2002:a05:600c:5297:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48fe61ed375mr212210515e9.21.1779093114436;
        Mon, 18 May 2026 01:31:54 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b9efsm112607115e9.5.2026.05.18.01.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:31:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 May 2026 10:31:51 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <agrOd1GVFYSH_txN@krava>
References: <20260514135342.22130-2-jolsa@kernel.org>
 <20260514200545.C672EC2BCB3@smtp.kernel.org>
 <agcSP6LxxpRA4ICO@krava>
 <agmpurrWy15nahPK@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agmpurrWy15nahPK@krava>

On Sun, May 17, 2026 at 01:42:50PM +0200, Jiri Olsa wrote:

SNIP

> > > Is there a similar issue for forked children that inherit the optimized
> > > 10-byte sequence?
> > > 
> > > During fork, uprobe_mmap() installs a breakpoint in the child by writing
> > > 0xCC to the first byte, changing the instruction from 48 8d... to cc 8d...
> > > 
> > > If the uprobe is unregistered before the child hits and re-optimizes it,
> > > __is_optimized() will return false because is_lea_insn() strictly expects
> > > the first byte to be 0x48:
> > > 
> > > arch/x86/kernel/uprobes.c:is_lea_insn() {
> > >         return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
> > > }
> > > 
> > > The fallback check for the re-attached probe on top of jmp8 also fails
> > > because insn[1] is 0x8d, not OPT_JMP8_OFFSET.
> > > 
> > > Could set_orig_insn() then fall back to writing just the first byte of
> > > the original instruction over the 0xcc, again leaving 66 8d 64 24 80 e8 ...
> > > and silently truncating the child's stack pointer?
> > 
> > nice.. maybe we can skip the install_breakpoint call in uprobe_mmap
> > for optimized probes.. will check
> 
> I think we need to dup uprobe trampolines on fork like below

or just allow it to be copied on fork

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 4d91930aa792..e0067d1b6242 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -719,7 +719,7 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
 
 	tramp->vaddr = vaddr;
 	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
-				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
 				&tramp_mapping);
 	if (IS_ERR(vma)) {
 		kfree(tramp);
