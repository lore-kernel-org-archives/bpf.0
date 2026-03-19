Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCA27A904
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939621; cv=pass; b=ex8y+uu0WDEyPUkimz8NA1mAwPavxQ2+W5tHz+9PdRaNLim4hZ0sBUkfsx1jFy1JWzwooEn8AurN/iTGRe3TP5BDyVEOa1fLlbiVQoWrgk5UG5SltGp07xPmAD2XjHt4FYBRE8/VO5PbpxpTMB42y4CCPDCXv2YWvVTXas2m5uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939621; c=relaxed/simple;
	bh=lEu0ZdZk+7V+A9EsVEIVTY8OPXiuqCJAQfImiRMh+Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzk89S/VSexOvohWpBq5sUgvZgoUUHzBBjke3gN13r3+NtJ2l3DzAw4s/RASseXrPpDhy9SBR7/Z4sFEps7nNmXhFljZDO2ZRWEbCMgXB/dNUDwwhLG0/UZzS5Jh39SNjsfAlSNI4qIb1doYYUOmG9a29XcK9lW6uY5a1QtAHU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWzFia0/; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWzFia0/"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-486b9675d36so7890415e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 10:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773939617; cv=none;
        d=google.com; s=arc-20240605;
        b=RSkySQXa2GSyzLc3xMUhTZYYSf+2nE/+NnRaSP61ac0MU5ncplzc/kv7yBxdtCOn4U
         LCIvFsw5VnIWZi3cTEFxRBcxnTrBfvbA3ApV8OKMKd5uVsKLOAiig5hexE9IyOoHpVNM
         L/k1N0ar6lo32PldL982er9bL8F7qYVJ1NJQyI0ZfmBOjdJP2haPp9SA79znc545CjUc
         pJ3nc5ME8AAzVs8LQ+kwasWMucymukPav11fouVPqW+lJ5Uj0j2tU8wqyginpkiHLWit
         D++DBqbOUs5L5AXl9TaPt060AF8Jz3+zl81rOCoBHCsNnmkUuBNpedfEt/oUDraTx5mp
         aNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lEu0ZdZk+7V+A9EsVEIVTY8OPXiuqCJAQfImiRMh+Gs=;
        fh=ccQfgBkAJa+D5FHhZStQmPT2Nm+OvViQuYHLtPMXp+c=;
        b=KRgjMNcxYIggKeCi0mMSAlIAhb8IDG60LYES1bcGdifiBkCAMB+0y+UZhZGsrhGw7H
         KiWeCzE6+7i3DvlLpZkVbc8picQ5rri/QvKFKXWI9Zrwc9xysfka4d2Mip586WUiJ/G2
         GXKvNb+rIYZu8mbaIzKGKv+EdsxXY0PVqQk+5eIlo9OTztYwq3nkfuCJlvXRiv5gJ+Kw
         2z9jGa60WvM9b7HVQrBAQizlZsmePGd+cSDnuYsXD/OIY42tSfeN2mjmjl6emkAxEI3Z
         kVL0Xcoqy2YLxiu5QoxROQZ9mpw7QJS1Y2yBywwoQuiQn1csprrRQ3iaDD/Wi6V4CevL
         Jz4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773939617; x=1774544417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lEu0ZdZk+7V+A9EsVEIVTY8OPXiuqCJAQfImiRMh+Gs=;
        b=AWzFia0/drdkBWEEn0BE9nWZTbaJ3TPJ+CZCrBM/lFUUp15ek9EsZOXCvCZb/GDUuu
         Yz9H25jz986oGfu83kG3rw1bBy2DYu3ppcensHZ0vCdKpLZAhGBykQ9GBU/AM5rqb9Tp
         wBLiwX4MzGw1aHWrmxnYqKlpqj/C6lKgWw1yusKF2JNG4OOdo3gZS6lvV+ZJJ4ok2RDQ
         YQ++gS16wxyowdK9ZeKj1jQouKaGP2HFRsRWcDoSBv4TdPchpT5UKG0mPhHr7YXp1wUc
         nqDyVTsAttdOsTEZkVkVJF+NYfuZ41jUGlamOimDqzSesjLzCO+xLKYJ64waJGrMJHES
         uYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773939617; x=1774544417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEu0ZdZk+7V+A9EsVEIVTY8OPXiuqCJAQfImiRMh+Gs=;
        b=Yi7diOtM9DEbOlVUfrYqoII2LZcXvWixEzLfWMhOLQxM49e3RGy5cPzbSK0qiCVnKZ
         6Ct8wHl4p9pPw7NxR/EkV9SoJRZ4Wm+iFg7VTqoXx4pma2ZeplfF9XDznJATmM1BuWzB
         YeAoEHLT9z81fVhbqpZFIqmZyE14Np+4m8pe9paRR0VTGcsPCgc4lBnVKkCw2Ltx3jSy
         Hoc5S8U/VSGWisb2ZhMw7UgYnBN1K/gkrs/78GgIIlgsJnFclExOB4NovBTIZlO02WuA
         UjkeM5MbSuIlyxBMZsy7sT54pGBQr7dMur26VsAbCARfOQhJRQO6dCNA8dELNHYgkV3d
         Ai/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHA+b2D1GxHwXkQpBFFWFAkWydnXkfJtsWA7QwHy8TMTQSkja+OUyssXGOFYwTQrrOV2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAyBBaTlqVXLJkZsJi4G0wA3rzaimmbOrcTqtQZMdOCn/hXvhG
	jS6DSfmF+RuMwzsGE3/tOHJUW5FK1m3StBVtBK4x4qJ+BCm280QqdedHKCsmb2mhDUgATfu0OAK
	d71yJkI2CmuGbfrYMwKZZkYV7/vP4yVg=
X-Gm-Gg: ATEYQzzJ6BJn/ykzbBCiSBrpqXsJ+OEh5fNxhIYXjiu4MUCIW4/bQBOd98cM1a5o1vs
	VQYg5O0JwTcsuVAGC9d1CGsa+iDy60lANUNNmg78D6SeljEq1InmPmpjB0SeSApXDgqBSbYcXBU
	Bp4fpMEX1BE7kFZNFD5tG8IzWwx5n36uR5Slns0NGC2hxqcQNMhzNwKf5MQtjTE7cayKomnqUtT
	ChwS6PgjuPDr5b6CR2Cz+wtPe7K56UY589ANhN/KfnPsL6pqge0nLl+ddi7sRYZh0wJfGzkx9OG
	cm0p3Jc0W7HEpvF9OSzTaQ0qTkI6i/tuuoqSVkLBN38T+ENJc9FNP3uBK+0LG/9G7GsYGq3A7QJ
	NmhVQGg==
X-Received: by 2002:a05:600c:1d10:b0:485:3d3e:167b with SMTP id
 5b1f17b1804b1-486f441fc5bmr135256825e9.5.1773939616711; Thu, 19 Mar 2026
 10:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local> <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local> <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local> <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de> <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de> <abwo0I_mu94t5Ews@tardis.local>
In-Reply-To: <abwo0I_mu94t5Ews@tardis.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 17:59:40 +0100
X-Gm-Features: AaiRm52CqAzq_bYhDhK7AY8TG1ghElKl_vIl3ULwU0Boa56a8p9f0V8QgusnIKo
Message-ID: <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace + PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com, 
	boqun.feng@gmail.com, rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Mar 2026 at 17:48, Boqun Feng <boqun@kernel.org> wrote:
>
> On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> > > On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> > > > Please just use the queue_delayed_work() with a delay >0.
> > > >
> > >
> > > That doesn't work since queue_delayed_work() with a positive delay will
> > > still acquire timer base lock, and we can have BPF instrument with timer
> > > base lock held i.e. calling call_srcu() with timer base lock.
> > >
> > > irq_work on the other hand doesn't use any locking.
> >
> > Could we please restrict BPF somehow so it does roam free? It is
> > absolutely awful to have irq_work() in call_srcu() just because it
> > might acquire locks.
> >
>
> I agree it's not RCU's fault ;-)
>
> I guess it'll be difficult to restrict BPF, however maybe BPF can call
> call_srcu() in irq_work instead? Or a more systematic defer mechanism
> that allows BPF to defer any lock holding functions to a different
> context. (We have a similar issue that BPF cannot call kfree_rcu() in
> some cases IIRC).
>
> But we need to fix this in v7.0, so this short-term fix is still needed.
>

I don't think this is an option, even longer term. We already do it
when it's incorrect to invoke call_rcu() or any other API in a
specific context (e.g., NMI, where we punt it using irq_work).
However, the case reported in this thread is different. It was an
existing user which worked fine before but got broken now. We were
using call_rcu_tasks_trace() just fine in scx callbacks where rq->lock
is held before, so the conversion underneath to call_srcu() should
continue to remain transparent in this respect.

> Regars,
> Boqun
>
> > > Regards,
> > > Boqun
> > >
> > Sebastian
