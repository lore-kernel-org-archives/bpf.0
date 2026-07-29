Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF78455162
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340075; cv=none; b=aOxFW+/SfeYgBudt1yPYcjl7bBFe2WlVLyMfjS/z2Ma/k1s1rcxAEtWf+7001nGFeJXaLnup4wAZGfv6prN+bftcHJ9LwfZky9CgL+FAGnY3y81SE49Djt/NcdzZNr7jk0OhP8UDcfVvDxZco5gDgd7/m6GGGQfGCKrRJqgKyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340075; c=relaxed/simple;
	bh=EXhgVMS0NxlxE5f0pFtmC2iT2ieedzhRX+u7Ni9PIk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZ3tfrPuoihESsdzG17nmSg5soLi9Uc42nNwMwxMnjcxuzJpm8PTfLlC55P1pmIMuD7xAsgktwwTPU2G6fDIJYHs+HJ2zXF6J4ZcLd7Z7n4hxG55Nl2+5YUxwGllcV6Pg23KO+i8SBKWTvbYDMhZJdBAAf+o09fWrWY6/VZ4L1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F2XQ1UHL; arc=none smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F2XQ1UHL"
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-69f4b000237so395178a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785340072; x=1785944872; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fldeuHlUZsSgbof6A4RukHGxb8EkbZ80+aaj64d3jk=;
        b=F2XQ1UHLgEDa/cL4YxnQlkbJaaz2I3QYZQnNdUzegHvjYgMJP5HQfmByr68wGfmXpX
         3IR4Lsuk+MBQt9ox4IIVyBYJZodAaXZBknBTHglm8ufGpvpce+WSFptknU7TueIasRMe
         axv5j58WYmzzQbGmy/j1//GEz/0/52fyb4VTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340072; x=1785944872;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8fldeuHlUZsSgbof6A4RukHGxb8EkbZ80+aaj64d3jk=;
        b=nE9SKl1AJ0YRhQ9okM3+fVFkglHklwbImKaK8HkQ5T8dN2EquOdFU+21rYsW26OmxZ
         iWcJYW8jFVsdc8WkqSHQdm9N4teHRkUcJ9HNA1PMu61I7GU/LOfpThSltrXwE/E+NpQk
         tzpE27KdgsEGdXEpqw/kLPUBkI0vRqerOhyJoy+9mMjr3OVYrpBySswi52GQigLdVk82
         eio3o66uyM1yOA9BtT3oDG4HPnv6CRpINShI/OSxORtPijQKjKP/pwHNOcWxSNdw3XHU
         VADmoPwX6ZKN7zpK70OuZKvH0pWq8YH23WjpThrQ+XjrnR6SSj8Q8jarxHJqGLiLdpMr
         CyCw==
X-Forwarded-Encrypted: i=1; AHgh+RoLone++GX59f1EMnMFvLk9FFWn+T8mBk86grdPCHe8JLhRpHI+ht5xQWadjQ3ai/mLlmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0kT1zAdQfzP+qhDahHarSASpQraSFQIQ5RTGUkoxkWnyDKKB
	5LK1L5NmcThdIdGh4Z0fnFijdbQBnBFTZSv9AeocFiwsKqYXYoApgwfKSNWd5Rs0EmmSOKIfWnh
	NIPtoDGJaWA==
X-Gm-Gg: AR+sD13OLxohiBSyipv4S6P2cx9dMyBOxGTQ5n/PUAX+kLc+OcPgGjMb8Vy0hFPnKmV
	sr6y9Mgsa89sAwogt/bIMsj1Fdlh+qqXx+pBVPbEPuYUpTWxvYr8ZvJ4Sticv2bBfxZ+BsHHgX9
	pGNBFnS2x7JFp2uMUvheDd56M52qI0DsQcPrO5MB5rbsMpvOR2CQaOM5nDU9bk4dXtiiCfaY4ux
	8vCjODPFb4Py5EZ58jNzl6l5Mm21sqXKdWrwCcn6LwZXFeu13S/sF9pQhu0/vV71KD4IQco9SD/
	PDXzcViRHGyVz7mzp7LBYU0OzYV83I2n+WRrhKXYZ8kYLMfCKZJcLdc0h9uNZLdcsPBTnfp2ekC
	oWwvKO74ylnl7kD8kfB+BLxIujNln3Jkx9d+PCV+qDScx6OfmET/QsiDEQc1dJNdGX6nyW7NFII
	40P6fLbPfjNjOQS5KaFKbIZxkqsJoVSQAyVZWNxn9Lv48zrVYUI03uFPOqFo5hPnHvluhadUAT2
	u3NB0zdk6mOx1sgTFY7TBULfhd84q1u8f/NAZMMRzsjzym9+w==
X-Received: by 2002:a05:6402:43c9:b0:69a:a279:dc10 with SMTP id 4fb4d7f45d1cf-6a034a52e43mr4101229a12.10.1785340071926;
        Wed, 29 Jul 2026 08:47:51 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c6d06asm1108641a12.28.2026.07.29.08.47.51
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:47:51 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15b1da6b82so117285566b.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:47:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpmD0X0eo9DkSzPUBHBFD9WtjiLSMfGomlJE1bYWBIgkHmDMORzedFyJQOglDb6adid9OU=@vger.kernel.org
X-Received: by 2002:a17:906:fe47:b0:c15:bea2:d209 with SMTP id
 a640c23a62f3a-c1f7215dee1mr360497966b.4.1785340071289; Wed, 29 Jul 2026
 08:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home>
In-Reply-To: <20260729113136.32af2a4d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jul 2026 08:47:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
X-Gm-Features: AUfX_mzh3d70XkZOQ8mPTBmYgVx50lGXSyciETgOqHmLrGk5Ua4q2GHqtff665s
Message-ID: <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	jolsa@kernel.org, naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org, 
	stable@vger.kernel.org, linux-open-source@crowdstrike.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 at 08:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > Honestly, I would love to get rid of it as today ftrace has proven to be
> > > rather stable. But as it is a user space ABI, I'm not sure what will break
> > > if we do. I wonder if we just make it a nop, and print a message to dmesg
> > > saying:
> > >
> > >   "ftrace_enabled no longer does anything. Please report if you need it to."
> > >
> > > ?
> >
> > Thanks Steven, if you and/or other community members would approve such
> > approach I would happily do this instead for a few reasons -
>
> It's actually if Linus is OK with this approach.

The rule is always the same, and I don't understand why there's any
discussion about it because it's been stated a million times: we can
try to make any ABI changes at all, and what matters is whether it
breaks somebodys setup.

If people rely on old behavior, it can't change. And if people don't,
nobody cares. It really is that simple. That is literally the
DEFINITION of "don't break user space".

Whether something is user-*VISIBLE* in theory is entirely immaterial
except in the sense of "be careful, this needs testing and may have to
be reverted". So user-visibility isn't a "don't do it", it's a "do it
carefully, and knowing that you may have to revert immediately if
somebody complains".

So changing user-visible things is potentially a lot of wasted effort,
and needs loving care and follow-up.

So everybody should typically avoid changing user-visible things
because it's potentially painful and developer-intensive, but not
because it can't be done.

All that matters is whether real user workloads regress.

And please make sure that any changed behaviour is really obvious, so
that people don't spend lots of time chasing down *why* something
broke. A kernel printk is generally way too subtle - and no, the
tracing "make the printk extra ugly with crazy ASCII barfics" model is
not an improvement.

It might be better to actually return an error to user space so that
users can see that setting ftrace_enabled to zero failed and it would
show up in user logs. kernel developers may think that kernel logs are
important, but users seldom even think about them. Of course, that can
then cause even worse regressions, so there's a balance here.

End result: don't do user visible changes unless you really really
care. And then you spend the extra effort.

               Linus
