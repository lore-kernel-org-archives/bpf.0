Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCA3D75AE
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660692; cv=none; b=hSDODYKZeuJikGD+xJzQ1Uyl+aSYEATLplIWpI3Ke+qUq0fc0/rMonubJswGhFN3ttg6zMp2uMSXmzk3eYBFOYp6f6/ZEOJtfhfZD0w0ttTBHuT6hEsGrRJNQpEqZpK5obZ8W/A8WfGOSURZrMYyijWRRWjQlXMpF/rI30IiL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660692; c=relaxed/simple;
	bh=PcS5mLYUPXAnbl7k8XF3V5byX4FCrBsPOJjd42WKHcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFm9h0sgchYtWHduDl3+44xAUsN4sDUBQEGXsD34TavkKiUekE3mSwuRJVpVxq2F8GvWOc5jPWwyOGH426fza+KRxXhTym97GR6EhqL8KEnsb2cc9+0azklnQ1D/GZ97qD7sCZJnF5aV+5RId2WLZHtgWoEv33qOvRlL8puNvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzFMEST3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzFMEST3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so83517195e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660690; x=1773265490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBHy4//B0BVAaOjPVplq/WDAKnGbN6ejMvGH72LFAkg=;
        b=AzFMEST3zuiFDQ4q+oM+1xG3cpv7N5NnhQoLYAVJZbptPl9Wg3idk5Ui6FYSOWNMYV
         Eb0rHpiheJyjtPz8w5cR5UmQKHo20ZRpcY2yizeXCMdIn2YZZG9ku8OpHm0zvryLqQSC
         6ufiiDn3zoZZQ9/Mz9eOsPP8uom+O6Y0ivwXASh2Sw2+govhoT4oNgZdWUExYwaa+wQP
         GB3a5zFvK4CvdT1lUKmBK2gBbwe2T+C1KRr9U2+OXEBgMjuG2bIdhxQgGXbqgo/PeQvT
         uyyM6mAY9TzHHnNdW8P61hEpK+nDRx0Xuak1OmdmFTxIgvNJ4tI3h1xSXhwJQvMgnhWR
         A4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660690; x=1773265490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XBHy4//B0BVAaOjPVplq/WDAKnGbN6ejMvGH72LFAkg=;
        b=W2Rxi0IO6mm61arV+GVHw7o7wCf3dacc93Ucetz9rkek3NVqivfsCox9mza/K/spcQ
         v22SOFiP4a1pu5xyqcy0YDjz3SmtiRZIlGQ14aDMRD1Eu8Fipd1Cqx/ihALa7YitZJOU
         1YGVSzkDTmBhuLmUgv3Jr+Fg/6d7KCsO84UBDlE/MwYay9v7sLGVAit+GOXV67aVDn9I
         Fkq49T9TIMZcs853HAn8aDESXOt+8E803OdkMSB8Bjk1qzUYuKsiVEKdbiE9NIvQ3raD
         ltR7PJ7/r/l4ZWCJ0QBvO/J3zpYuYqaWU9fq0BP1X00IgbQ8LAzo66rl6j1kMa+a0KWZ
         nWnw==
X-Forwarded-Encrypted: i=1; AJvYcCVClwlt1KngQE5QRrA0OYZm88wr2/pBY2YPlsUuhXLK+Fo0j9fOgcSKfVH04K4domqfCFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZ2VNmekOxwdVtjMsr6sbC6v6dz2ww+dHxpxQJTdaR5a/gbfZ
	3JlaBlXh0JEzT98wjsQ7OD2Ypn9TpUd1HwlAHdC3Po+0QOz9qUrescvj
X-Gm-Gg: ATEYQzxrvkX822mXJQ4daAETJZbqDm1c90/a+NFvOoSmLficKA+k6oTwlGI9ulj25bY
	Tg4g6PjxGSYK6Mk24MZHrx1zG6idlqF2Ikr+lfgBAVKy9fiOSa62mDtQR0/ykAvQeF8uzQsuM5H
	r1sRMfURgRFSPyVJWXuiW7oTLt9uONV1QOLt55jrb5NYsB5FZszIRgs4p5UQrEjbAVYpl2jxbzW
	xgkZEp32+rp85jX9d3t/mAfzoFR2NoHKrr4q2VMvQV4yFvsKF0CqZHpKZuKCVhD/5GzRTXaGqvK
	img9eIHgp8ZzeZYb6v30Js53XxnAssQtpdgxSK8KCXQ0ThfL9C7EmvMRIVWTZjciAm3cPWYXsey
	LiUsSwmilDOST2pR5ELfGsNF8o8/qaGHG3BrIaUO3KUogLUujhKtjgrJEiSj77B4xtyTsi2zZCb
	perc/++eW6CJmdI9kX2UacpGAf7fg4VbvDjKVRHW1dOA1hLzXkqvMymTlnw4mWC4ev
X-Received: by 2002:a05:600c:46d2:b0:483:b505:9db4 with SMTP id 5b1f17b1804b1-485198a3d0emr61675375e9.31.1772660689592;
        Wed, 04 Mar 2026 13:44:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851883a012sm148720885e9.3.2026.03.04.13.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:44:49 -0800 (PST)
Date: Wed, 4 Mar 2026 21:44:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Yafang Shao
 <laoar.shao@gmail.com>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304214447.3e5817ea@pumpkin>
In-Reply-To: <20260304155742.7b4de2d1@gandalf.local.home>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
	<20260304095415.4d5f2528@pumpkin>
	<20260304155742.7b4de2d1@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 15:57:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 4 Mar 2026 09:54:15 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > That might still be an issue if a high priority process is spinning.
> > But a %sys spike doesn't imply a latency spike.
> > 
> > Is this using the osq_lock.c code?
> > That will have problems on overprovisioned VMs, it tries to find out
> > whether the hypervisor has switched out - but ISTR that is flawed.
> > 
> > In reality a spin lock shouldn't be held for long enough to cause
> > any kind latency issue.
> > So something in the code that reads the list of filter functions
> > needs to be done differently so that the lock isn't held for as long.  
> 
> It's not a spinlock, it's an adaptive mutex which spins while the owner of
> the mutex is also still running on the CPU. If the spinner CPU triggers a
> NEED_RESCHED or the owner goes to sleep, the spinner stops spinning and
> goes to sleep too.

I think half my brain knew that - otherwise I wouldn't have mentioned
the osq_lock.c code.
That all reminded me I've a patch that optimises that code a bit.
But I do remember thinking it ought to have a 'I been spinning long
enough, time to sleep' path.

	David 

> 
> Honestly, this still looks like a non-issue or a corner case that I don't
> think requires these changes.
> 
> This looks like one of those "Patient: Doctor it hurts me when I do this.
> Doctor: Then don't do that." cases.
> 
> Why is a production system having multiple users cat
> avaliable_filter_functions to begin with?
> 
> -- Steve

