Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA535730E
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018358; cv=none; b=LWGi5oVzjacI+rvb7UceeaRFijqHrVm1ES8OOBYYDa9miE8YA5W7zAUovhYsQXwpzOKybR2/6G4JAkPNGh3Y02lFKeub2bCeoUqk4o8FAwVkuQ86VudrFYwVs4DMJ4/8RlfSj+CdO80JlsUPsDzj52PwNK0zNivWV2DywcSt19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018358; c=relaxed/simple;
	bh=11tvo2PDjTfRQBPTyFVs5nae7lHuXBhUo1w9fhRUKCQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLNpcSZu2gkG/J03UhoLGhPL33RrBki/mwUPfbz9u6gPgraDzEVT1iKuu6A+iI9MW3otZKQcm7NIQnXQ+lfgaE/06sJhVfcbTQfQGZelKaDu7KwcLw3ZfxWk5vE7zC/CD+GSXywwP9tjkryqmu+U+kJvkIQe8YzDhVocOq3Gbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX/ghoGv; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX/ghoGv"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d476d7972aso14719631fa.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711018355; x=1711623155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45yhYh1c76B5hpMI/AXimlzQQNvaOFbzxBmt05VhGSk=;
        b=mX/ghoGvYbYetPHhblwgUyVkoIU+dKT1J5T71Foy1rH2jBBP8g90k9vajPif1Syve6
         7Apm5rJCmQGCyp2uahxPCl37BWDL4s/U+deuR+bkwyvhQyQqs/Fu7TWPB1MeUiPozQk9
         ZbpY/L3iwVjSokzo1sAhmcJO3eo2GjchfO0653sGzJ1+Kb4otLIPe8JaSe9IdCd4js/C
         2wrEHB2VqcaNI9cANcvoO+jZdqDUt7ysKcAhY+i/lOmwereM+mjzlN/FV5DQeTz2VD4F
         bjKZjunbh5HUjZFyIEPyh8JOJTOdRpAgOLZ6F1Z2kUB5MK5pQ4cFMXarfEh8UPbWWDAB
         3fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711018355; x=1711623155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45yhYh1c76B5hpMI/AXimlzQQNvaOFbzxBmt05VhGSk=;
        b=v3w3DiwPalMVdJquOfExbW8FG6aJ7rtUlTRAzxG6sYFlyhOA46EBX9KUzR6keivEj9
         ug4PcHFKVKLMK8KSj/sXEZ4jEgh1Q+YLD8Grr30WrZjloIwh5z1Uc1WMcJrurSs3JnPi
         LHC4gFdSg24Geiwk3Nw8gWHeaK5dHnya/mjUx0OPKoQ+nfwI8KB6PrXqiqclrQ03w6Bc
         HMGhhfUXX7jbgNSG0EQAWGdEX/DXO2M9ps//17gA1kx5pKIBMP+qXmDeGE+8+Lnsv4Wi
         4MRBS5pc9DkrQCJ4eJmhYfi1qUVLwL5DhtkkN2PO5RSH3CbgT7s8w5b6YuflypS2vzDT
         NH5g==
X-Forwarded-Encrypted: i=1; AJvYcCWuKUM35XXz5fmTvvvOeSjFXvm96LyUOOtbV9Mcm0qSnGtjEB2YRCoa+7qxkZcH7UcCqZwNzY9AZH1Qtw4QOqJURJsH
X-Gm-Message-State: AOJu0YyrnuqonrXGNog234oysdSoGBdu4QMTfxYsZXHRCKlRwDspqdSk
	7ixXaxEENdxVgW8Cp59PWpN1KII6+nBM8fCCQ+pw+Mhg1qc9/pVu
X-Google-Smtp-Source: AGHT+IHA7NAdCkz2g9hmN8Y2lNwhv9IWurTUIPXzOx5K+NdfMQKS+ek5axkKEgPAuXpamSqXtlHU2Q==
X-Received: by 2002:a2e:a7d5:0:b0:2d6:a8c3:7f37 with SMTP id x21-20020a2ea7d5000000b002d6a8c37f37mr46424ljp.1.1711018352937;
        Thu, 21 Mar 2024 03:52:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm4644885wmo.36.2024.03.21.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 03:52:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Mar 2024 11:52:29 +0100
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
Message-ID: <ZfwRbf0FMHVizZAC@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
 <20240320152848.GA7613@redhat.com>
 <ZfwFBgfdHUzQBdxS@krava>
 <20240321101750.GB14646@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321101750.GB14646@redhat.com>

On Thu, Mar 21, 2024 at 11:17:51AM +0100, Oleg Nesterov wrote:
> On 03/21, Jiri Olsa wrote:
> >
> > On Wed, Mar 20, 2024 at 04:28:48PM +0100, Oleg Nesterov wrote:
> >
> > SNIP
> >
> > > 	SYSCALL_DEFINE0(uretprobe)
> > > 	{
> > > 		struct pt_regs *regs = task_pt_regs(current);
> > > 		unsigned long err, ip, sp, r11_cx_ax[3];
> > >
> > > 		err = copy_from_user(r11_cx_ax, (void __user*)regs->sp, sizeof(r11_cx_ax));
> > > 		WARN_ON_ONCE(err);
> > >
> > > 		// Q1: apart from ax, do we really care?
> > > 		// expose the "right" values of r11/cx/ax/sp to uprobe_consumer's
> > > 		regs->r11 = r11_cx_ax[0];
> > > 		regs->cx  = r11_cx_ax[1];
> > > 		regs->ax  = r11_cx_ax[2];
> > > 		regs->sp += sizeof(r11_cx_ax);
> > > 		regs->orig_ax = -1;
> > >
> > > 		ip = regs->ip;
> > > 		sp = regs->sp;
> > >
> > > 		uprobe_handle_trampoline(regs);
> > >
> > > 		// Q2: is it possible? do we care?
> > > 		// uprobe_consumer has changed sp, we can do nothing,
> > > 		// just return via iret.
> > > 		if (regs->sp != sp)
> > > 			return regs->ax;
> > > 		regs->sp -= sizeof(r11_cx_ax);
> > >
> > > 		// Q3: is it possible? do we care?
> > > 		// for the case uprobe_consumer has changed r11/cx
> > > 		r11_cx_ax[0] = regs->r11;
> > > 		r11_cx_ax[1] = regs->cx;
> >
> > I wonder we could add test for this as well, and check we return
> > proper register values in case the consuer changed them, will check
> >
> > >
> > > 		// comment to explain this hack
> > > 		r11_cx_ax[2] = regs->ip;
> > > 		regs->ip = ip;
> >
> > we still need restore regs->ip in case do_syscall_64 decides to do
> > iret for some reason, right?
> 
> I don't understand... could you spell?

I was wondering why to restore regs->ip for sysret path, but do_syscall_64
can decide to do iret return (for which we need proper regs->ip) even if we
prepare cx/r11 registers for sysexit

>
> AFAICS everything should work correctly even if do_syscall_64() returns F
> and entry_SYSCALL_64() returns via iret. No?
> 
> > overall lgtm, thanks
> 
> OK, great, feel free to update this code according to your preferences and
> use it in V2.

will do, thanks

jirka
