Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3EB2E738A
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984886; cv=none; b=nY29e5OgS5QcbejG7K+lqaJ9yhplkqlH2yHpSd0+glvJA7fXuBuHXh27s7Q7vbh6z5PmdYx+noU/1p1leGJ0mcWu0pXOGQJ4cSw8eyXzxeG5keZJnY21TaNRKg874Ga9yfSX+fzCqyIU7EfMS8ZpDIEwfyV2M/Pf5K4GRSu4yv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984886; c=relaxed/simple;
	bh=PHDLCXHLb6geoV+liXss4T/l8l490ju4aZ4ydPGildk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxB+Al78Bzjpc+ympW2799qW146cdtFOxvuGdmWmUcVR9IoBvZjMJp9Dniy+LvWOQHd4fjo+hnNtMMSCVJrb/RDX9p3fiReYJ+6wh+3R3OOhoZj7VFykwd25FPNwQKuunoBYwwDw0DYDMjxAcrmz7kjyo61yP5b1mjxlOk3Q+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso49580575e9.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 09:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984884; x=1780589684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfCiAYxwM6fSi2FMKc9LgQjerGAgaqnqOAwHUcR+LT8=;
        b=ly+fqCvsy1bYIx/RbGjbvwuJcqdNP8ZmKe/WuxxSEGR77QaTQrSN5t7EYWkTkPecGn
         tkeq+VvxwppGLGQQqLwaHwVFlvojiuXRax7Etb6t4fYLA9IJwGMpBZOsdgOFGc+1xkwm
         5PeqxZ5e+6chjRSP2l67IRXU6u0UIDULiwDzugzMdzU5h6F6GpwbJPZAy0AB9Qu/PclR
         DMxbLkPosxPqPEc29B1f2BQdFB/XluGYlhyM7UmOwvhQXlumJoNWPmkV3p3BEtwb5iXq
         czjyi844tC5Xi+7Vf74GleRsRY2toXO2kUFU9oK+b8JimM80tJJR7CfKNaQG3kn8xC0U
         1BZw==
X-Forwarded-Encrypted: i=1; AFNElJ+WLhn+RNPw22NaUv6TaH8NEp1WR0ubKg5O68AvEFKWY3h/khXCPVNouAAOfxdHYpZeyY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwe0MXwcWfvo2VDWBXo+JM6l5sBo+DqV/rN7bWRRycptbd0gYZ
	QBdK16xgtfAoonqfJ1kpFENbicdR3ywWT4NS5bcYLzq1ZK2tcn2E7iGj
X-Gm-Gg: Acq92OH/KV3QKxonGEbY21joJCT9BxkFI1VhRXVSa3zZW1x7CA5KWipX3oVwRyYa+vS
	1AyQDozTDW/8Pm6oMi48xkmBdhVAJ/nApCRYhIZwV8A3AbiN2optr2hpgJojkhfRgjT40+Eqes+
	5SeAplYyUM9Mq8sExm+fSXAh8SosPMtwYcaep0HMm0ZcxGs4NTCCGY5WNPL3HrNaV0UHmfcaV2n
	B5ESJzJiQD0urUGG5779Mho/2MdbcrUDs1Ih18oiTDH/YtgDe3fwOuxHzN7Lwy4oP52hPXloQr3
	+vyS/Zpz63x3aEneHZbE9zC5iHeRxHjJ1yiERbAQnsUtPBYekMkD52nubh4P6GR9/++5lD7A18D
	YNLgat+l5ROBm/V4bKa9EWaF6quab2mQASKJtFjdBFayugc2rYjI7KSp8Ow3oI5I/emiIKuMjW9
	UfU0o1KtC8wBtZC2+9/p6CwTJOUYXadz88YnTg
X-Received: by 2002:a05:600c:c0d2:10b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-490426c1759mr350308945e9.20.1779984883857;
        Thu, 28 May 2026 09:14:43 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909235d4c7sm45535105e9.3.2026.05.28.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:14:43 -0700 (PDT)
Date: Thu, 28 May 2026 17:14:42 +0100
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/4] bootconfig: embed kernel.* cmdline at build time
Message-ID: <ahhpvNV91F6HUMeb@gmail.com>
References: <20260527-bootconfig_using_tools-v1-0-b6906a86e7d5@debian.org>
 <20260529001519.14ca9dbe92fb2622249137c6@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529001519.14ca9dbe92fb2622249137c6@kernel.org>

On Fri, May 29, 2026 at 12:15:19AM +0000, Masami Hiramatsu wrote:
> On Wed, 27 May 2026 09:41:33 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > The userspace pieces (xbc_snprint_cmdline() in lib/, tools/bootconfig -C)
> > already landed; this series wires the rendered cmdline into the kernel.
> > 
> > Motivation: today the embedded bootconfig is parsed at runtime, after
> > parse_early_param() has already run, so early_param() handlers can't
> > see embedded values. Folding the kernel.* subtree into the cmdline at
> > build time gives a CONFIG_CMDLINE-equivalent for embedded-bootconfig
> > users without forcing them to maintain two cmdline sources.
> > 
> > Behaviorally, the "kernel" subtree is rendered to a flat string at
> > build time and stashed in .init.rodata. setup_arch() prepends it to
> > boot_command_line before parse_early_param() runs. Overflow is a soft
> > error: the helper logs and leaves boot_command_line untouched rather
> > than panicking, so an oversized embedded bconf cannot brick a boot.
> > 
> 
> Thanks Breno, yes, that is what I think about.
> Let me check it. And could you also check Sashiko's comments?
> 
> https://sashiko.dev/#/patchset/20260527-bootconfig_using_tools-v1-0-b6906a86e7d5%40debian.org

Ack, I will have a look at them, thanks for confirming the direction is
correct.

--breno
