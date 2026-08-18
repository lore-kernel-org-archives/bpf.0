Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1362F3E44F6
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051557; cv=none; b=RhmCJjjY2qGLSOluaFN4WzNrZO8NC6Xx9nyb9IAIptLHpa7HrizIMw/LWy/7YqvNgKeUjz+A5PHH0VMPD6lF4AEPmpkM3N7LdA7U+eqDXnyQIlUGZ2z749AG7zAfDpbRYj3SkJqZLiDE//LrYKvGfS6EtqWT2JOo5m90ShHTeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051557; c=relaxed/simple;
	bh=B2+CLnZM+Dfih0z+JXU8VyNPvh5GNDa0TTaCL0GCFRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsfSK4A55yW1fCIKzFKcPmoBs82cNDcWeJIGswDfhfxboutQtp6hFI7jieVHedliZSwTxZmR6f+40TRO1Ixdt1P2Ig6Y0H6BvoZRQ7kVP/kt6h/pKVQyaBFIjFfmwW9xuRCEs8S/a/V4HFWgFbAnUxAWYp4Tv2s8uDuBxndGF3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUHXSB1j; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUHXSB1j"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80bb41f7f3cso38187037b3.2
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 04:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787051555; x=1787656355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15RZOvdraJlVKymuEVqpfPTvFuSCosFv3Jnv/6kSfDg=;
        b=QUHXSB1jU1m9Lmz0+qgvcUrk9DAHEHOvmrXEqt/OSOJjIw+h/Up1ZAQaCi/Lj51xSX
         gYGj6PMLvzDxvKFUZlWd3ojiChdbkV34AlFn9S6nusvjqGtzfqWjWE2UIH0WfZv49GUF
         Z6mokxCT1CGGEGauij2b5efeiuqyO+BL4/hOu98qd9ndoQRMpzvp03sMRmsJK8SybSjV
         mSyrjmxSFQaR/6rtmbNEBfXH9bE5qsz8bTEHq9QRmxxc20F5UXM3K4M/akJUo/r8sc12
         uyHxXbKyQOB24N1BYs9Z02CcGjcJGeqDPAP2wSw8PQsDxeubTmMa5fkqn0NWbjJbVoId
         wF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051555; x=1787656355;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15RZOvdraJlVKymuEVqpfPTvFuSCosFv3Jnv/6kSfDg=;
        b=Wvkse2iCG1oKNHzjMFpb+k5G+exQOpnkLRy10TcUhcVAFx+PagYDEWvFAtWD2WXK6Q
         Uosoi1BW2pXTypSyyJN8AFK+oD3CGy2OhDf23Ng+xzjdHx3+FZSXEjKPT2pE60DYWVkL
         3TYaNJl9ttgCKpGBkwuMBhE0T9izfjG8K/CaRn0fIUA+oEi5xTNw6oKNctGxvU1adc6/
         KgCxS+FMPT0rPJDb6bqilvnaB98l9u4k2OTyzL/K9XUqHSXqiDLffmjDwANbIGhLZ9Er
         uUeHOkuptit69h9IieIR76AOCIVf31KdiXX1B09ID3/GZWGZ0AfMudYoSm4fNy8pkGiA
         gS3A==
X-Forwarded-Encrypted: i=1; AHgh+RqqgfaO9EdsBzaaXAhtR77cf28ogZF6l4GgLfgMEPgPZFVcoC8+444SuHijzp75mYNNdus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKLa1i2xGsClodVZPST3H84V+YS6wIpS1n7E/iMsLn6pB4EKH5
	9pabAvnBA1wJtR29prPitTzvxCme5LjJ1ZJCpHtxNUtp6QYtDGDqBbvZC+/GRBFA
X-Gm-Gg: AR+sD132N549xacw+qu0ChmyhlY0LXksdEoO0BBY/0UY4cmb5JE1CZi1p2KWn/KC2cf
	io3RmzYJ8jdz77AeM4dawEBx60GxmZTw0mITpZ8vwHx8BkhAQb4s1ESoMugjt5Zt7DbBK9UgOx6
	Db7kVAVCb7nKGmDxRe0LWYyQaEFek2L0nc73TGKuMtqtW1AKbJuO5NJZIlTMvZOqFCWf8plUapD
	B1wKh2TokKXH0LCZmQ8mv+6h+oSFoIpf/kWl2tQI5s+M2Mhdla6kboBVWtFxUB0c8OfuZ5CzTQ+
	5Pxzka6o7lasyW5I5P86vTyZZdfbWVCgzxQZJi2A3twS3pqyqsvSEV1Kd3UzYgldDjl8KcqeF1m
	l2R1LL9Fso7lStrx3Ax33aTlUjpm0B5PkrLCmU7eBKSXFE3bbDLwQ7uUlSQ4tTQqPZXusfmvLJY
	OIec2+sAUKe/HfJml0SEjsjS0Oynf9pFZNaKKphBjhukJhmdPsGZjE8OiSXoANvdw5nwKptpjfB
	1tfy8auL2WlqhSt5msAnDY=
X-Received: by 2002:a05:690c:a647:b0:821:133e:569c with SMTP id 00721157ae682-8370ee56bc8mr74781987b3.15.1787051554998;
        Tue, 18 Aug 2026 04:12:34 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f3e5:832a:1675:b570])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840f3d18a90sm16737557b3.46.2026.08.18.04.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:12:34 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:12:33 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
Message-ID: <aoQ5PqX9psvbeOtr@zenbox>
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKRYZPV04750.1V3UXL56PKB6@gmail.com>

On Tue, Aug 18, 2026 at 11:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 15, 2026 at 1:20 PM CEST, Justin Suess wrote:
> > Howdy,
> >
> > BPF programs can attach to the locked_down LSM hook and contribute a
> > verdict, but they have never been able to ask the locked_down question
> > themselves: there is no way for a program to invoke the hook and learn
> > whether a given operation is locked down. (i.e be a caller of
> > security_locked_down rather than a consumer).
> >
> > Today the state has to be fed in out of band, for example userspace
> > reading /sys/kernel/security/lockdown and writing the result into a
> > map. That is a time-of-check/time-of-use race: a security_locked_down
> > verdict can be raised at runtime, so the cached answer can be stale
> > by the time the program acts on it.
> >
> > Add a bpf_security_locked_down() kfunc that calls
> > security_locked_down() and returns its verdict, letting LSM and
> > syscall programs query locked_down state at decision time. Out-of-range
> > reasons are rejected with -EINVAL before dispatching the hook, and the
> > kfunc is refused to programs attached to the locked_down hook itself,
> > which would recurse into the dispatch. (how the obvious recursion issue
> > is addressed).
> >
> > As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfuncs.c
> > to host it.
> >
> > This kfunc has no reliance on / relation to the Lockdown LSM, despite the
> > similar naming. It is an LSM-agnostic caller of security_locked_down, and
> > Lockdown just happens to be the only in-tree subscriber to this hook at the
> > moment.
> >
> > In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN at
> > all, and uses a BPF implementation of security_locked_down.
> >
> > This kfunc can cause notices to be printed with kmsg if the Lockdown LSM is
> > enabled due to this line in security/lockdown/lockdown.c:
> >
> >   pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
> > 				                 current->comm, lockdown_reasons[what]);
> >
> > Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/master, but
> > applies cleanly to the lsm tree.
> >
> 
> I don't think there is good enough justification to add this in the discussion.
> The reason you gave (dynamically disabling hibernation) also doesn't inspire
> confidence. I think figuring out some other way to achieve that is better.
>

It is really a quite terrible hack isn't it?

I am using it as part of an hid_bpf_ops program to allow disabling
hibernation on my Linux smartTV box via their proprietary remote
contro.

But you are right using it that way smells off.

I was proud of it anyway...
> If you care about knowing the state of lockdown LSM, doing
> bpf_probe_read_kernel() etc. should allow reading that state from the program.
> If you have a BPF LSM supplying a dynamic verdict in your environment, I don't
> see why you cannot use the decision procedure from the same implementation in
> other places of the LSM. I doubt you have the scenario where BPF LSM is shipped
> by someone else and your program needs access to its decisions instead.

This argument persuaded me.

Given this, I don't think the kfunc is the correct way to do what I was
trying to do anyway... so I will drop this for now since it was a trivial
patch.

Justin
> 
> Lastly, given the difficulties we've faced from the LSM maintainers, I'm not
> inclined to waste more time in explaining again why this cannot go under
> security/.
> 
> pw-bot: cr
> 
> > [...]
