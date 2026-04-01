Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081E37F8D4
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054602; cv=pass; b=jY8c1YAHx8+LX/CVm5EIpAhNzKQzVE8n1wlSFtlRQEvk8dGH+e5h4OMAmWF3Pv8paEpGqiWzVLitca7XGdgjeOKWlWsa4b+TsCdcAKraA0wFQOUbq5SI6HiJTLIWYaC/2tCWPll/2okuK6IVFnGIowBDa38toUuW9CP53AVnntE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054602; c=relaxed/simple;
	bh=X5nfkx4/Qm3d1skqkseBbH+/HkmCh60oDdKDOFooGbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfkxXLLJhxeDx7CbvEMoKV6tdbBbV2AOH7FErjFpsuNZJarHHEasklXeryMe3wtgPK73yFDaRnpYWm0zdl1Zln+nw8YHsI3bjR1ArHN4BGbRZYdN3sEePIbvdkoZSDwRIDLNVZTuYPexJcoNIWnhYK5JMwoEnB2zQyuN+WxBzZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMWfKyj8; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMWfKyj8"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43cfb723698so2995679f8f.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 07:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775054600; cv=none;
        d=google.com; s=arc-20240605;
        b=LP3lrjeaHmBSiRS7uh8rp5+gyeXtGtAWgVORhaJArFCADErCQZEFzR64T4oBEZ3/9E
         bnoaS0po8U8T93R3wOYkNCZJ2DKGG8y+cvE611DWQs0JcXkDjupkOt5RmnYZX9hgNpWB
         XrWjkA4KREZcGT53ycK/ifEn1BKl3MzFFNytGZ6f50/QN61vaVG59InEAUtSiH24B6EI
         cyIdB/jkrGDCBovwq4VIUP9gC+PcMOri2JnHsgtU5EZeqcb0MxISZOIIpHhENuHDWrGo
         gYXj8oLVk/PkTSihjAjlIo/olSKJtYR67m/dk3MnjSyF9fPVeL+CQL0YZF76ZCxeEyfp
         3CoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XCEkWUgf5f/vT3IihkMjMEhZxsSNLlsM4yI7619bxWg=;
        fh=Hc5uvHdeKfdmJytVk6z7x9GbuA25Wi2Pa1W3vA/ZGlU=;
        b=OeiUKaX0TSRSa5EdTftbLTy93Q3PQJtjIxiWT61FUAW+CPDhYd+FsJjym5eo+QX90D
         LIkvv29UD2iKzw4UNtzpXopO+mE1I+MhyZ03kHSu+yBe3EoNtzkiqdxN2DsJtds1ypKw
         rIi7xXE/4plSaoO5dHEogsNledAGlIBt+c259xrvaUq/YMiBppjHQL1zxfWHD0ORrtrU
         51u/6O/Y1TwFDVt8ghQqcpZcFqwEOE6M+T0SDO0pjkD+fEEm4GuAI57IfR6/7SxLXeDR
         wZE31mcx0kVlbkvf9V/+r6hzYGYZMt4eeJMZbVu1lcwJFwb4d3ecZvtGWr/Jzi+bltRT
         Hn2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775054600; x=1775659400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCEkWUgf5f/vT3IihkMjMEhZxsSNLlsM4yI7619bxWg=;
        b=FMWfKyj8jMCudcGedDgnHv3Ck97vQwgToDPyXH5qTJAR9Ir+2lRUQQ6HAR5+nhy9ia
         g1eZmT51K5MCzfVGThjxFy/ev5mzfKZ9fpxv3DAJDI189/HWV+KOGeTJrxEysZebdOEb
         xX7xgfHSQZpeTi3g4rVxsy/BYJhd3OPZ4+FfCb0rK+1R1WjKLM1WhuHaT8QGGaVZoyoV
         li8fmg8R/QjvBfO0v21Ok2FtpOZ6Pn5PUdBqTYSyZAb0MqTj7qwnP+VafqPkh5Y8lJ4P
         DjaeyqU7cYg9wGvmj5ElZbO6pbGMigf9LtjSgZR4NcqyR+DHmQt+nveaAFhvgF4pPm8N
         3Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054600; x=1775659400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCEkWUgf5f/vT3IihkMjMEhZxsSNLlsM4yI7619bxWg=;
        b=gKbFjq08VmOB3o3KkQEeQK9t02KYBSJCmE8h7jdYLYjOJJifs5SUjdXMPz7N9Vz33G
         5vODUEIm3/b5lOCTkuevDelATBei4Iy/DMBE0mUsGS4y0lOjofSIGAQedDEF55Dpooxt
         dEuLNwAkFbreo1GJoFKqlKgp7lfYWF07eCOD1ozWJNmzIXQmVFk6E6zdSzrDUI1zKVNt
         LFuw37GunXhihz9RZoBTCaxxiVpA0xhcw47nINcDdZsSEt314/Jm3cEmnTQ2PyvfNccO
         r4IDzuvI6313cVXSfWPcv+B2VNfqb3WKIzBc24DivkNvQuV1DncABSkeO6B9Z55T+qqk
         guGw==
X-Forwarded-Encrypted: i=1; AJvYcCX957+OVorRODWb2G8yGOvySv7Lw1CaYuNDCzCIfJ+X8tg8pWnJPTXxSKIxJxFxH15xH84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrtk1ZSjf8xdm6ywFtpyrvfNrGMSgDWZN0ECtioiADjxYF/MUg
	D1RD2q/hpeuNmEl3BdO9MiKhdCEC0PYGD9dflnytf+pfFlp/YKi4po7zUEplewmVY/Nu/jO1OGA
	b1zdE0lWG5V4VT3gGwrcaR8WpVAC0RfpA0K1yQE7xig==
X-Gm-Gg: ATEYQzyNN2xt2nqOkynkiwEYUn0/phdv8cIYYHKG+Ro1WhwFgDLTy09T8oXnBbm6vyo
	VXqeIr/BOv5Y8XZoKXO1vOtHthwdmCmIW2RYeo9utwoEV1t6Lwy/11JHLKQLd//D0GC2x3fM8x0
	MJIYqMJl8GGGoNnXvAY6P2XzvnAY4NUOc02db+loDVIuttAFgwUB1+5pGGZFKzoMB0oWWwyTLEB
	IG0fFvJY6ozIR1CvhplPOzheW1XAj0L+lqZA46nDg1wHjt1nxwCdIdk4VhJbgzM7ckMSPNVWz16
	s6547sozjTaIMUTxhfnJAeXFz5UZbv43zDV3+q8KUEi+hctjooXjNZ4THmI=
X-Received: by 2002:a05:6000:2409:b0:43b:6a16:17e with SMTP id
 ffacd0b85a97d-43d1505b105mr7181347f8f.11.1775054599060; Wed, 01 Apr 2026
 07:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac0hLyMuPHiZfnVc@computer> <20260401134921.362148-1-varunrmallya@gmail.com>
 <CAP01T75D7p2smSyoFvyZykgC5bJdobL_cqtk6-w+LmP4NP9SpQ@mail.gmail.com>
In-Reply-To: <CAP01T75D7p2smSyoFvyZykgC5bJdobL_cqtk6-w+LmP4NP9SpQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 16:42:42 +0200
X-Gm-Features: AQROBzBw2x8878imdwPXOOGBOW_LkGML6dkWFLRsSFWWVlrdf0uthfaebSWVysg
Message-ID: <CAP01T74EV11nW1y_DbzO13UMPDx-aq11KHOfdjqT35QdN414Cw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject sleepable kprobe_multi programs at attach time
To: Varun R Mallya <varunrmallya@gmail.com>, jolsa@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 16:08, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 1 Apr 2026 at 15:49, Varun R Mallya <varunrmallya@gmail.com> wrote:
> >
> > kprobe.multi programs run in atomic/RCU context and cannot sleep.
> > However, bpf_kprobe_multi_link_attach() did not validate whether the
> > program being attached had the sleepable flag set, allowing sleepable
> > helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> > context.
> >
> > This causes a "sleeping function called from invalid context" splat:
> >
> >   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
> >   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
> >   preempt_count: 1, expected: 0
> >   RCU nest depth: 2, expected: 0
> >
> > Fix this by rejecting sleepable programs early in
> > bpf_kprobe_multi_link_attach(), before any further processing.
> >
> > Fixes: 0dcac272540613d41c05e89679e4ddb978b612f1 ("bpf: Add multi kprobe link")
>
> Please use the right format.
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>
> You can add the follow to your .gitconfig to generate the fixes tag.
> [alias]
>     fixes = log -1 --format='Fixes: %h (\"%s\")'
>
> > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > ---
> >  kernel/trace/bpf_trace.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0b040a417442..af7079aa0f36 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         if (!is_kprobe_multi(prog))
> >                 return -EINVAL;
> >
> > +       /* kprobe_multi is not allowed to be sleepable. */
> > +       if (prog->sleepable)
> > +               return -EINVAL;
> > +
>
> Looks ok to me, Jiri, could you also take a look?
>
> >         /* Writing to context is not allowed for kprobes. */
> >         if (prog->aux->kprobe_write_ctx)
> >                 return -EINVAL;
> > --
> > 2.53.0
> >

Also, please add a selftest.

pw-bot: cr
