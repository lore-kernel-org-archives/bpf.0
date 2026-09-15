Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6954C4F4D
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488166; cv=none; b=Qq27vq+2WUr8tphR0xsVqiX637t6A1HZvGZ+NpLEMn9JFGQr/gEIAPrNOpE3MPPg1xlYbq2e251y0cTvDx563uREEIIfsg35zdYpbkRC9XWkGMG7FYjGN787NjxrmRDk6LmdYNZ3PBGE+veV0Jb8xbuzOg4sFSyfIuGw/t44cag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488166; c=relaxed/simple;
	bh=3IjIYNZ//EkU7RRxo8bHkfJOqg1GwqJOxlBJJC6w2Og=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ok3l65Qa+AEEkkO0ataAj8CaW+q2cKRyffVQLxrU55CUIEiE44Li9q4I0OAj/H/9zO974pUOhXLLk7HoY/hcLHPhpQiOkpOIIuxwJyeI7qfYJOYQ10meitHt7Wtr33meh0C57unwYOH445tF9PEvzDl6L6X/DJvX/B5WFXdWn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HEXEEeL+; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HEXEEeL+"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97ea1a712deso203241241.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789488162; x=1790092962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kXYuW65IGDuV4RbA68/PmJHgU6ttorOq8wX2YILfQtc=;
        b=HEXEEeL+pryvm1DJszuag9D1YCUvmoJuXJERLAoSGa9/J1eb27fHWoDKsuyilFoHP/
         fjYS6d2/NGQLYvfFi869rjHgR4x1XQtQsAGFqsAmffFu0jG4PxSr2m8LXJJgEo44mKMK
         WPZYMI3fMx9T1zFgKyD6Au86+JM7Mdj88Uj2wv7PkZXjYfLTZ1GGf6aVz1VTley2RFUt
         7k7/rcIVBTgWc/y8yYTjDM7d+nKmq2AtjY/ZH4X9z+uCPOSYpqCEyK+v/QobLVEDy7jN
         Am7+RbygbtaFKOFj9rRfrndMqHWgJ0ZeUPCjF95xbAnpSjtI2KVALyvVVfgmLrDaqJWS
         sflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488162; x=1790092962;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXYuW65IGDuV4RbA68/PmJHgU6ttorOq8wX2YILfQtc=;
        b=P34GXG1b2M61bM3L2WaUxN7ko725qoOYtmZ+derIWiHQWs44B2ePCVLlqp5EWarABy
         A/Zq3rMjWp83gxpteRcLKmTzxCPMpFucBgBXkRbK8ejGV3SiC5+76csJkEGivAzTVbjw
         nm3otcvwF1g2VHw1iCivKRIDzs0HV7ad6R3U7h+f2YoQtpCqwG4DviytOS+SttklxNYu
         4ZLJj3HoIbToQio76ONuU+Ehx0KlHXDE2PRTHYT7rab5KsRa7pcdlOC0pXgnzX0iMctb
         ztAFIW+RZNrG9NpWp0hxqOzU+D0NRbfTgDJ3e9I/WBgdI3Ej910QAVLvmqMRwzzI9dsb
         Z2Gw==
X-Forwarded-Encrypted: i=1; AKwUvBybTKiAbtJtoyJ3JArTAWOyugFbcclFTvWqzKXht80ZZijV5uwNlQPDGErlgWwbXC4dQ6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lfNxXeL8AAU2ssGQVPQbaTUkngBo6L3HqjLyEsaJu5i9pREPcq
	rwon016r0i06/2gQTWp0MdS+xMG5g0ObrESl6AH2AUSzhWJzldJAHLgJJuuOtMAvaLM=
X-Gm-Gg: AYBFou3BWyhYM9RYe4LZPpD7ig3awuMBntrLhEpBaOQY42dL5nAhwoGzoMDc8IqEgt+
	8QEzEHgaoarMQcn8sRc/XmVhkxZqDyA5HrHJ9MshxmJErdYShcdH4nhm2Qo21fG99Os6UtNJEpz
	PacbafCDU04qFiY2HjLts9CwkdsbCbNju1dKr0Vt7hWy8IBsDjQBiLaFi39fk4cPgID1g8yFnx+
	AFO9MUHijJ077rS3MM/VMCAW7B7iGI7YxSWSmkZ+A3uoiMLF+Vhn6fdO8SijcNGDKyukGtRrxVP
	NLb3zA/nywj/TRVaGxxLHpl8XFQGwNYBDo57aIOO7gaVfBOuegFDt9Tmj52HQrWwSacCS5a2HEQ
	0rMlK1KHJfGoPb91oevZ8Sm/wjrAyQw2VhW5Ojr9ImTBNtqo55LD2ZfbbCtQUBU3KzeOlQHhNg2
	lnLXuPwuB7Gh8dHcRVQGy0n9FaH/GtWNPZEaya+x+nzdj4ULhgZ/fmkjFiyIxzu4B2ER3CpUM8i
	5LspjKwDTTqDshLVF7mkVn9riIyAkNym3CVlp3rltG8wnELXIM4CHGd
X-Received: by 2002:a05:6102:1609:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-79ed4a36e4fmr2855428137.6.1789488162285;
        Tue, 15 Sep 2026 09:02:42 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123bd339easm2205466d6.0.2026.09.15.09.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:02:41 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:02:31 +0000
Message-ID: <162b7a9a7e12191a9661465090319408.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines
In-Reply-To: <20260915132919.E868D1F000FF@smtp.kernel.org>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com> <20260915132919.E868D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 13:29:19 +0000, sashiko-bot@kernel.org wrote:
> > +	if (!(ct_rcu_watching_cpu(cpu) & CT_RCU_WATCHING))
> > +		return true;
> > +	return idle_cpu(cpu);
> > +}
>
> [Severity: High]
> Could the unconditional return of idle_cpu() lead to a use-after-free crash
> if the idle task was interrupted in trampoline code?

Yes, this one is right. The classic flavor ignores idle tasks too and
leans on Tasks Rude for that, but the idle_cpu() shortcut here made it
worse than it needs to be: an idle CPU with an interrupt sitting on top
of a trampoline the idle loop had called into would be passed
immediately, and since idle is never preempted from irq exit nothing
else catches it.

For v4 that line is gone and an idle CPU only counts while RCU is not
watching it. If it is watching (the interrupt, or the traceable part of
the idle loop) it gets the resched_cpu() like any other straggler and
counts once the idle loop itself schedules, which it cannot do from
inside a trampoline. So idle ends up covered rather than ignored.

Thanks,

Josef
