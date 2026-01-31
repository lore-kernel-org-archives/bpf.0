Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5D2D5C86
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818511; cv=none; b=E1mPfOAjHni8BsRLXW2mPoHl8ouAzB94Z3FYbZ3Ngk/i6RMyIinGYOrO5ie7EtZ7Op0enwh5ndmV9VhETAXAiCssyPx53dBkdW0nt7X103NxEx652cdMOlif0cD2Fcb8jd5+HQBDT+W8DSrZpUvIFsA2kVtn5rTfoptCxwYCGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818511; c=relaxed/simple;
	bh=w7+B8N3XRoFg3Of/Fw9iyPoy/mghU2Qrl0CPBbBgDGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foWAod1NT8HGDh4Egz744nj6efnca1uQ9Tk1nlO4DIq8PPPs2O7CSqMDfdM0prL88gzKGXoonQo3oRfqWkGL2CZ3EFrRE01hsjRNOVOUPofWlyguW37JZ4bULlxFPX/K6I0FFRWmvJsUMj3tQjMFrSS+U/SkZbBPc3SnMgIf6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ELbeBJt4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ELbeBJt4"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b883c8dfb00so635900566b.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 16:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769818506; x=1770423306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qV4mmOV+uOXX/Y9XduJfQAli873FtpKVEKD92eDGYCM=;
        b=ELbeBJt4G9P32oB4th2mwb8XgzZwEPzMA84FtKyQWfCY2Dx1V3tLH1sBe54PpInlaa
         hmu9paWFtdlyqnGYz1JmaHuXF+gs/N4jt4IzmUiyNGOndV8/XINt/32sUyco3nYq9QFC
         8GmTTQKiXpi5CAP9CnKOYzgWoMYpK//CFpLDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818506; x=1770423306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV4mmOV+uOXX/Y9XduJfQAli873FtpKVEKD92eDGYCM=;
        b=MUAng83nFYMKnWimklVMYNOJkC1JrOTfl/GLqE7ZWkQ9hIy+TJxnIkqDasC3EMTJEy
         D7QWaJTf+EJQbEr7LpqUTHrA4g+k6zYLLxP1RdvCo0IRFdQ32iS10brs7gKJnCLbBH/7
         OsiG+tKp1fDOOgOIk3Ev3CTiOdQqeAxwnG2IsSDAnFu2vJOTydBW+l2+MUcu5TcgMBdb
         UUWB0bnzDNvwxtr0ZrRX/xuJ9Q/N4vZcH0oGfSlW4oi8SCz6d0UbNP6HE3kqTMAYYOX2
         9Xr+RqALSY8Bmj4W7agRLydImxRvNQRrxdr6uZX0aO2M8sXGIdk6n0AAi6eXJOxFn8aw
         +A1w==
X-Forwarded-Encrypted: i=1; AJvYcCW4SEEHGbJDJ3HKBjt4JpYOfXckuZNq1k/i3vdwwr0tVqZcqBa17y8RARiI9hjbuOOrMFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwHB5qEPz99uroJqwzsXI2aMH/8lvM3R7hdw6NWmwJRRMz1gc
	rQFdohyIiNXTG39N3bpOmqr01nWjCYCVw8DqdR+2CPx6xNfWLB1xZp0ln9avJUdZDlrpjdjzkpp
	4Y16SRTA=
X-Gm-Gg: AZuq6aLjlskUzDyyHpf8k+MRPtfaBP9jqUUHXVcce/7s2V+og3CQBzNpV71rNOegJWe
	rPsp5r4imRoqOiqF9dfRqMeStUR2u96vZvymPEB67StDUiaE6y+9XdvmNKyGMawun4qwNR+F7ek
	REvKRPkvNkSDGNgDF53ihywYt2m1aF4sIF3l1j9jn/epgrOMO1jFJLWW6MEQgDutrEDWz+i9FK/
	hu7nTTDrsSKUxqhr9p4oRLfCDaG6w28FZJv9YM2qWnGztVXL4TRgNyqNwYif2FT4u7cx7sNsb2K
	ktKt1qRW/4K5QkYdLjxexlnDNz1lZbs2AKvUfElQpefWCq0y1g4zYJOyK/0ribomr51/UBA9Kp6
	wBDa2vwSNEj/b7pbJwpzU15WsjxMviuWQlJH2+T4vFyVBAPXD9WQ8Nm1emYhILvj1NIoikQQAq6
	+8ZebzSfR3UEDqw3HRnRW4ZS0fTlJRzDF9RkCTNWcrFHnaFVG5Na8ChLo4KpjS
X-Received: by 2002:a17:907:c09:b0:b88:6dd4:9ca0 with SMTP id a640c23a62f3a-b8dff7226f5mr255432166b.64.1769818506133;
        Fri, 30 Jan 2026 16:15:06 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc667asm501985366b.22.2026.01.30.16.15.04
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 16:15:05 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso4323508a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 16:15:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVU6v9cL5Ccta7q8nseEC5ur4BxxrVCtv/5unCfrhoJ+hSuxn0b/VMAd+iS0htAyLG7UMk=@vger.kernel.org
X-Received: by 2002:a05:6402:1d54:b0:64b:4f44:60ef with SMTP id
 4fb4d7f45d1cf-658de593957mr2779765a12.27.1769818504441; Fri, 30 Jan 2026
 16:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
In-Reply-To: <20260130235743.GW3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 16:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
X-Gm-Features: AZwV_QjK3epqif7-e_sBGUc-n0f418Z3nV80PkvQC8yX5DIdQ4ynfWKt9EE0KMI
Message-ID: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jan 2026 at 15:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> So we have something that does O_NDELAY opens of ep0 *and* does not retry on
> EAGAIN?
>
> How lovely...

Actually, I think that is pretty normal behavior.

Generally, O_NDELAY and friends should *NOT* turn locks into trylocks
- because user space has no sane way to deal with kernel lock issues,
and user space simply shouldn't care.

So O_NDELAY should be about avoiding IO, not about avoiding perfectly
normal locks.

Of course, that horrendous driver locking is broken, since it holds
the lock over IO, so that driver basically conflates IO and locking,
and that's arguably the fundamental problem here.

But I suspect that for this case, we should just pass in zero to
ffs_mutex_lock() on open, and say that the O_NONBLOCK flag is purely
about the subsequent IO, not about the open() itself.

That is, after all, how the driver used to work.

                Linus
