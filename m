Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C183E95BD
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788304; cv=pass; b=PH/AU+tyS8DWWnVPopiYea0tIW/KyoyETxLNK7ORo4Xc6QNjgJlXydP0radcS0m6Di4owLrlDt1B+c5K21+nxu12CzohI0Jp7b/gDqAKQ6ZXKl7LQIQPwmlMiFWlR0LvKFakY8b5+6LrMLPIqLMbs0tw4ywrrNoCU0vcGRSLu0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788304; c=relaxed/simple;
	bh=Ikyt66TMlNKpG3woAwTQOhNuC+F7tCqH5WhDe9sQD5w=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYb04VbDyYDiByefVfZi+OBs6CFup+pUHuS2h8ZlauFZq0bQ99CnU3uVMb+QWF6h5ZXMwG5WPVCHuIXEYpZ5Rq9tVLJxwOg15KUGlrj4nODRWbyhxxXi83zIVUAuoLaCRha212L0dv9MhHTwh+5OnayURpsbH3ZElL4VvTUDxI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=l7lBrjx/; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="l7lBrjx/"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C5A1A3F97D
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 13:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781788299;
	bh=Ikyt66TMlNKpG3woAwTQOhNuC+F7tCqH5WhDe9sQD5w=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=l7lBrjx/i4WZD1f4Wfxq71E84Mk5upv5cobBaRXhDUlFm7y6qHXwZy7DRfz8oJfSK
	 KI7degmeiyUGkduQJC+G2el2K2yUTdq9DP8qx8BaMaRgPahfgkmgS/9LmDGV4hCrwr
	 qgNuwcMqAtDucYs2wUOmGoZlYIQKtgNXSwTWOQtouvtDEQjhQERt+Da5NoYFPDJIjf
	 eE0+/wnVNnsXZBVbg7C/TjrM7wtBVs0g/egEnAOldxr1WboZjg3noItr6WGO7u56uS
	 t1UDo9n0sTQZjAElbRNS3w3fVwmIrd70BzioI5OD9Jk24SuoBM3yGeKWCLOky/iVoC
	 siEjw2MwFHZ5JoRhUefwiLDSYQnUUBuoddHieM5ZWl+qJh74xtqSxxkBVVJ00Wki2d
	 WyJ828StNI2NbPEvnxuLto7dKtxqhSTlXYWMTLBgAMfJxllxACcvYPT5eo0O0Ey0v/
	 iGiH71OW+YkCbAo8kxi0pIWmJa8UdGuMe4ZvIFGvqCqMzWPBY9HN53R/+sYOSZ6fCl
	 ibqanGkJxFb2ihN6MR6XuKVzD5s6AR6h4DETyiI/s4S/WZWoP1N2DmNvw8H8RgiUaW
	 T1AHO4aq5WT2kR/vmsSnKgVo+mtT0sE3cdMUvha5LxZg4wXkwpzr1XFJfKBxHtLXIb
	 TqPsm1ri7AFoAUAsgGmjuDmM=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c0793772071so88189166b.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 06:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781788299; cv=none;
        d=google.com; s=arc-20240605;
        b=kq+m0VHqcgtCnn9hE7BnkKmfUJswCjzeEP74oNGG4tlg9U5JjN0RURaX7tIlz6S/Pl
         L69Om5AwBKGEv5+2z3msNig6WAP094Pqug2tT4+Z1ld3R2fHnNAheLYPPSNFAxzOJDMO
         hLgjnajtrlL4XjJgBf+6PtgT1aY5VCIgybV1KJJjcXblcOl4y0SVdcQKnRW9Z6hSJjla
         hCZQc34Ry4ns7IfhZYhfeLGauEk9MTpHgtFttvSdNMGBEyvSB05Hh51+G9PLo4pW/QIO
         tCi5dwFuIrjLu/mOhL+0gfJtygOBUAJKwiUHSVzynLjCZ66jQOtLVekL5b2oQ1GJG5It
         9shQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version;
        bh=Ikyt66TMlNKpG3woAwTQOhNuC+F7tCqH5WhDe9sQD5w=;
        fh=xnB6TqSmnHr4ybWpnLQknbdacYtXERMFXbYTOB1zum8=;
        b=VfDb70qQd4ZRgoEBRtX0EBUifomz7uvDsF+zpU5iygdh4EhqUdeBrtnixQxZe6Vudp
         N0XU4pf8FPOLuahhDEexho8G32CNWqITeb85AImSC4PAcZWjKauOhdReBtSO6HbV85gx
         H1xEBB+K7451mN70+exunrD0lFlH/x0gJHJJmZEabgW+2pmStFqXLNfs6OoDp75rNrjH
         M9I+zGxlwG9P83qHWLcDHpZUBcUH3dzwAo3x44sxu0rs+PoNITdccWDUZg2I9lOcGIUG
         M7xCpRtO2zgBGNZFiHUayW1Z+b/M6NWtGXnmI+FwRZ4eisXAvjNMikbkNONVEyBybpCU
         tzaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788299; x=1782393099;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ikyt66TMlNKpG3woAwTQOhNuC+F7tCqH5WhDe9sQD5w=;
        b=ebrNpM0aN+r++onc/oK2WqKQmncKU9KVHsm2W1v8wwtjqsIAbYVtfoMLG9otqo9LkX
         zcNgZzBOuSzvQ16x96ZP90MZYnv6YzYHrca0EpqL4mJZ3EpAfCFdiRTE7YSyDgWXvnXY
         hHGMFjlb4PLthXDu4nAH9aKI1wLZi7nJiH7bJ5yXZhd1RAjEOLXzJC7KrOhFl4PsyZOs
         JKlK1Qn9NaTZLhyxGL/wglSNWNpRfYpe57rxytCNrR6LQqVvC5TK26XYbFafMiS1QjC6
         6s4xLu3UJGSj/NK8F63TD4LYSCKUCnDC+t4khm3lxCVFhWpZW0u6o0I+XbcoX3z4OMQ9
         J1CA==
X-Forwarded-Encrypted: i=1; AFNElJ8DOOAXe7xHYXohfQ+DodxckNsNRm9PUja7mUA93zMcPvOfvZwa5DASUCl5y2HoyAOPT9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHxec3yAg7gQi843EpNTV+w4G3zUwEf9bbTeXpui2v+ZawcPy
	MnzeqYscfiB1wc2BZf39c9w810MKpYclf1EtuMec/ZJC9EBPpReYVmbyx1O+eFmp4X0aIpTa4Wa
	y86FtLWuivB1ogEsXNKRiEnbrcfV7YMdWwFn9qm8wnyXuhT8gkZM9TC7H19PgDyQWuR3YxW+iuu
	1pHj5FW0rYo/wkm3B4hwig5uO9ibXuXGK3p/MaxN+GdYQBCAti3pNr
X-Gm-Gg: Acq92OGjsak9SePAlMZYut6skQ6g88BfuaJU7h/+kWnMI2+VeyaS11d5E+bhxrS0Wbu
	P9Z2RETuM3sGEYaKhUO6amkqPYdx1dA+tAjujbYe7XL4IzZ6c90TTaT8mGpvVawwwjEU/QtA7ko
	iiWCpPS1aVKbiVUurlcETZnFdCHXY6cNcBAu9bBgHlJMAJGnNnRUBl/k9eE8kvI5JE1g==
X-Received: by 2002:a17:906:cc47:b0:bec:e6ae:2f69 with SMTP id a640c23a62f3a-c05a4720184mr330890766b.30.1781788299123;
        Thu, 18 Jun 2026 06:11:39 -0700 (PDT)
X-Received: by 2002:a17:906:cc47:b0:bec:e6ae:2f69 with SMTP id
 a640c23a62f3a-c05a4720184mr330886266b.30.1781788298585; Thu, 18 Jun 2026
 06:11:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 08:11:36 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 08:11:36 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260320222916.19987-1-boqun@kernel.org>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Thu, 18 Jun 2026 08:11:36 -0500
X-Gm-Features: AVVi8CdNkaVYBWAhyDgLK0vLSd4h3zxECQx9FcmqMplPRvrgTirU1SNRffTdnLU
Message-ID: <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
To: Boqun Feng <boqun@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, 
	neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>, 
	Zqiang <qiang.zhang@linux.dev>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Quoting Boqun Feng (2026-03-20 23:29:16)
> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> happen basically everywhere (including where a scheduler lock is held),
> call_srcu() now needs to avoid acquiring scheduler lock because
> otherwise it could cause deadlock [1]. Fix this by following what the
> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> the work to start process_srcu().
>
> [boqun: Apply Joel's feedback]
> [boqun: Apply Andrea's test feedback]
>
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Tested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>

Thanks for the patch, which is now upstream as
7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")

Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
SoC both on the 7.0 and 7.1 kernels:

https://esmil.dk/d1-7.0.txt
https://esmil.dk/d1-7.1.txt

Reverting this patch seems to fix the issue although it then breaks when loading
modules which is can be fixed by reverting:
d6e152d905bd ("clockevents: Prevent timer interrupt starvation")

This might be a side-effect of reverting this patch though.

We'd really like to continue support for this SoC on the 7.0 kernel, but since
this patch is a bugfix just shippping the revert doesn't sound appealing.
So some guidance would be much appreciated, thanks!

/Emil
