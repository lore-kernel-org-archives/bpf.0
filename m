Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC453E1E
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015181; cv=none; b=e3Av4MLjEkwrrqPi5bpeH2b2mblxwzp61oQKf/ZTKPiEm2U+2TwAOp6PoDCDJ6WqdSQggPKDAN3l4RmCiVRNXiLGX3Va4l7p8MxfeSNYBuzGohW/37No4y2OTELGYgI63/2EOYKsIuc23uOF7kwMFwBGGjP7XDcTri+1aeARhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015181; c=relaxed/simple;
	bh=i+sFQt4Z7iRXCZDBQN6sUZhAMwTlqiEaiiBsNanVoQw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYUjYYGziQ4Kji/Qo+4D9gP0ls+nqWz2jLYvsOj1QnZnfADfRkWTUq9ABGl3ifS5NMTsozolFJiswYJqgBAp/QehD9YATgcxa0Cxu4Anj4u+imuytb1YIW6FvEtwQpRf/bhnr4cHudbAuNeyHJf2yZTnsP39O1iJRNVSLEQnpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQvFZcPl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQvFZcPl"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d687da75c4so9546831fa.0
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711015178; x=1711619978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqFZLx4Ef8u+2/oaUaUtZCp70ByD49HQbA0AkDvUL5Y=;
        b=XQvFZcPlHfqrdZROB4Ze1evPDcBz4LZr1RoLwNtqIt7kH7/7baYavrS4wV2Cw3s6hi
         qXwJo2BOcqivk8Bj2hWCWz70zdMmS89rk+brR+j85MrnWpf/KXy45uR1aqlEPQtfgqM/
         DiNWtF+vUuN3mLuv/HQVNc2t4sszBtl8NRN+vjSyUfITJzgDGGIyyjvBt9NcT1IOo884
         uwveAb6LfMz/9v0X58sfibqlAchNxnwCIyofJsoBiB8VTim7OyNb2p7HOIGIUJhtDUdR
         feOCJKyQNqSMbJ34VJLQOpHabGH4/meX7tV4gWbd+wlgnPjMOR1c9SiFgNe6ZHgmQQHb
         YB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711015178; x=1711619978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqFZLx4Ef8u+2/oaUaUtZCp70ByD49HQbA0AkDvUL5Y=;
        b=U1BfTrPPB+rCVaQhqO1A/vqvC7V0kX9H4XsBDNPuwxH8hSLtnK70LB82o4yzlaMzdM
         47DIqZNyma+NGYovmE4Y39KiHCk/vqWhrGO+DGVe+dRe3BXnQydDhrmFbztCr24VX1oO
         nPujdOiFPplC//HVyPHHGMLGvBLW4bejIoqzAUZA8CEkLo2mMgkkZhgR41J5ZTOPWgvT
         W/tTLMEfum3l+dbcwhj06d9Lu4IagvttGjINXqIBwKFeL+QPnKP8U/TQJv7IhIfEO75n
         3wPSaMQk7t01zIQk5reefb7gjf+1DCEcMiykPQgzDGJHZrrFLk+1x95xrCd9YX4sd4Fo
         9o0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwLgcv8BXVH+vxcKjDlQeLWr8EGEmybP6X3OOHolJy5fzLz2rmHrYFII9Vh0sF82rcLdqzcdtG3Q8LNP/eU7Gt4NJZ
X-Gm-Message-State: AOJu0Yzhr4p308j8dzspZsMtOWnSk0QHLLmtOVmcNudVbddZDU2rsvj6
	ughnoMPPLJhy5bfH1RSCarMNaqqmaElDk6Qzn79c/m9cbwZuUqI0
X-Google-Smtp-Source: AGHT+IEw2ecncepFxRTg0smPu9iCQIskGp4cIVa/WKUBt9fY/8jSHYNmwNdCzfNfMkmt68CrcCeAUQ==
X-Received: by 2002:a05:651c:10a3:b0:2d3:2ecf:c26a with SMTP id k3-20020a05651c10a300b002d32ecfc26amr11773946ljn.13.1711015177445;
        Thu, 21 Mar 2024 02:59:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c384e00b00413ee7921b4sm5001269wmr.15.2024.03.21.02.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:59:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Mar 2024 10:59:34 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <ZfwFBgfdHUzQBdxS@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
 <20240320152848.GA7613@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320152848.GA7613@redhat.com>

On Wed, Mar 20, 2024 at 04:28:48PM +0100, Oleg Nesterov wrote:

SNIP

> 	SYSCALL_DEFINE0(uretprobe)
> 	{
> 		struct pt_regs *regs = task_pt_regs(current);
> 		unsigned long err, ip, sp, r11_cx_ax[3];
> 
> 		err = copy_from_user(r11_cx_ax, (void __user*)regs->sp, sizeof(r11_cx_ax));
> 		WARN_ON_ONCE(err);
> 
> 		// Q1: apart from ax, do we really care?
> 		// expose the "right" values of r11/cx/ax/sp to uprobe_consumer's
> 		regs->r11 = r11_cx_ax[0];
> 		regs->cx  = r11_cx_ax[1];
> 		regs->ax  = r11_cx_ax[2];
> 		regs->sp += sizeof(r11_cx_ax);
> 		regs->orig_ax = -1;
> 
> 		ip = regs->ip;
> 		sp = regs->sp;
> 
> 		uprobe_handle_trampoline(regs);
> 
> 		// Q2: is it possible? do we care?
> 		// uprobe_consumer has changed sp, we can do nothing,
> 		// just return via iret.
> 		if (regs->sp != sp)
> 			return regs->ax;
> 		regs->sp -= sizeof(r11_cx_ax);
> 
> 		// Q3: is it possible? do we care?
> 		// for the case uprobe_consumer has changed r11/cx
> 		r11_cx_ax[0] = regs->r11;
> 		r11_cx_ax[1] = regs->cx;

I wonder we could add test for this as well, and check we return
proper register values in case the consuer changed them, will check

> 
> 		// comment to explain this hack
> 		r11_cx_ax[2] = regs->ip;
> 		regs->ip = ip;

we still need restore regs->ip in case do_syscall_64 decides to do
iret for some reason, right?

overall lgtm, thanks

jirka

> 
> 		err = copy_to_user((void __user*)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
> 		WARN_ON_ONCE(err);
> 
> 		// ensure sysret, see do_syscall_64()
> 		regs->r11 = regs->flags;
> 		regs->cx  = regs->ip;
> 
> 		return regs->ax;
> 	}
> 
> Oleg.
> 
