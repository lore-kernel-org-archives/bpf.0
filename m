Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341BD3B71CF
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854758; cv=pass; b=H+jc22yj4VJdDKLAfHXMX5x4jmwm/zTgbDLyt5rQ+B1ezOJYZAXe+uIJFHOrrlwj3NKaxaFnbwQ7dTll/2TjL+lgD99U/I1C77xLCCVJgmTS5wTFVeeVEw14cJHjCgCHsODIQnQbIxvPOwPBfBQeSWXQzhjc5cZUyD0Ibj+tyAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854758; c=relaxed/simple;
	bh=ztSaoUfMVezUsDwkDcA8OfphYl9+J8Z12iVlxPqy/tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeX/4pxncdbrdjRByak+EjTX3eS2oOEoxN1yMd8IahUCCkeWkLzzymSJEf9yOC8ufZvfCQexXyGlXlAslgXwWWotJrL/3B5ycXswW3qsuFAUSr9zrN0nYnorn5XKM8bsVvgYXd3lutiKKC5dD4TxVqvhFHgLlPG34Gal1KQwWqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB+N/y3z; arc=pass smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB+N/y3z"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38dc4f9462cso1390595a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 07:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854756; cv=none;
        d=google.com; s=arc-20260327;
        b=GSBV+1aS3sAD2o5qLyGAX7f+QeaBrhq38+LV7h94LlrdfyvSpuE6n15XiJWJYbsP6o
         5t7U/yWz7DXdEv6NYOZsd1Cjj0FZG0R8osyn8iPtS4Gh2QvS++O8/6YojTmh0QE4UtUR
         2CY+umkNZBQTucUNecKGqUnyZv6nG5lDFySe6xiS6/bBKt3YSOZle8xfd9ytQ6n67lup
         W+XsAKCU8hFXr4Coz/TCTo/SBZZ4LwiRQBpY8wXwAvuDVp1a9DkX8bY+PdQz8psJXnEb
         thN559Q1wNDRDS4d5HBuKO4B89BtUU0ZaQoG1sOmzdir6tBXdTx57rfDCnK71gGMNGEV
         EdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ztSaoUfMVezUsDwkDcA8OfphYl9+J8Z12iVlxPqy/tc=;
        fh=EnqRaJhD0aTbB8xJN3XAhCkbP5I2nQlB+HHIDCOf15E=;
        b=Eec4MxEItvTXAHMLSimoPlJ0bM3tPoNRP5VHJzxhluBLFNKu0JNYSfenN7ZrWreJgw
         en/U7oUjflrTR1feLkQ6kakNIbTKr3+0LEdx5jnm6x7jeUfS7KrBmNY3b8PtR2F2Dw7A
         L/XA4woc9RCvbOiCSQyxZ3fae15SHnB0JJJWfLEtCcPFzzwKnH2TqnlpOnvr+0Fz6zKk
         FI7MTEZKIF+QAXZ8JGmCmFnifmo13lD0qh41qunJseHOvHAwmSYgKbvSjo0bEbo96msI
         g0/w6Py4FohBK5Y1hewCue10ufglC5AVedEJj/iAJrfD4KufRvKU+46mTR6mrenZ7iOy
         4LRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785854756; x=1786459556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ztSaoUfMVezUsDwkDcA8OfphYl9+J8Z12iVlxPqy/tc=;
        b=TB+N/y3zKPWzhMOqzKFMBTA5TTJ+jE3XxywU0NuIrh21A7EPUwkMiCjLKniUTvY4DG
         J03gc/31Pq7uai+EhZV41j8NoMZeD42XAOZhijrYks9+mXHICii51clDQbGZ1ayBQnFD
         tk1bHsW99rqzgh/2eo/yzVXAgF2GPBAQRZAwpyoncBFKxMU/e/m33aiAyhb5wlT/tmoC
         B2Ah5CY9VHTW/yhFjKuKOrk28uE/961J7Q7EAvXDdGk1y1i9eRBhZWkFf2OwbePmmyvB
         XSv1N1OJfWfXX2bzaEwjhY4aIkFxqOpVPPazY0qzJIi/+NsFIdZT5ir+ctJdgNq8iHxV
         TI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854756; x=1786459556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztSaoUfMVezUsDwkDcA8OfphYl9+J8Z12iVlxPqy/tc=;
        b=lvdqgkgr69166IVCkj02JmOGdd6TpjccYK6nWN+OlLV8h7/f6pMUzq3MRSh4X+N1UT
         XA2kFG1UzTx5mXkqHkeIwXzTwAy6eGY4oSgZnywUpxBQq/IaeJltSsZZqhxpyn2uTgke
         l0PjUnD8ZowrzQGd6lfLe1CuKUkiqhTcUo+JHqlmk6UDtZOovaYeJTmfrPB2No+4gu+A
         UOves9LPWlcyA5k/H+t/37hjbuTjWbB/DP+B3w7zu6sh8gsJ9QvGVqM8tkqf5ljJZZJp
         +GifT+jT/fg+JpERVNf9y5DGZQQA3TWT4xqHDraQSiic7wEcuLx9HR3Al5kyDrJCEgJl
         /ZgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqlgva+tSSgxC0x8I5ku4aj+iUSa0O1PtjWOnmEfOJlOWkyE193rIsgamb3a0eTf2pImgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8k8dhvcF8ABPPjvMQeAnGcDjLlps1MisHdB/5JkxoKoLWNch6
	km47aWxXB52UyR1fWk8ed7KE1U9f4xsxWqNpGMvE92yppG1YVOoJg8TcgOXAxp+MRoD5hARZgMe
	xe4ricVEsp0QBGDmC+VoWHWSFJM02kI/UEN1ctpLJnx7f
X-Gm-Gg: AR+sD130qnwqFKkppWKUUNIWQ75WQxYxtQPL17/BPVgKOVDRW9nwx/aWLEaRpXpYDx/
	Ip4Lg7trnwN39yXRj+K5r23BYaprSQ9P7rzPbXdN9dfRSZhtDhS4f9Mr7TY+el7vJGEXLy8tfVj
	ShPLhQ+TPO29p5WXs90RWw2Rv6/1VJL3uCOrWLtq9R9t86E2pdhAZY3sH7/nX1GW4y4uCs81Apu
	MBEdrQW/wHuSmiVsXXjAAYQKuIr8UykkASrV/mkC30ozd1P/hJxm9MQkjt9cnsuTsiOIoU6SiOE
	HxjW3tKEkLZYzVQlhE0l71U5w18egpK7BbxjAEV7aVcamw==
X-Received: by 2002:a05:6a20:6a10:b0:3c6:3c5b:f2e3 with SMTP id
 adf61e73a8af0-3c92a62d94cmr15620433637.33.1785854756552; Tue, 04 Aug 2026
 07:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
 <anEuaSqiCVsQ6I4P@zenbox> <178583246611.3252194.4318729338489544399@noble.neil.brown.name>
In-Reply-To: <178583246611.3252194.4318729338489544399@noble.neil.brown.name>
From: Quanye Yang <quanyemostima@gmail.com>
Date: Tue, 4 Aug 2026 22:45:44 +0800
X-Gm-Features: AUfX_myq83VVn48ShEyGmTjvf-TWPUcuekz03-F_pf7Av6LHmdejBcY2Ac2RQiU
Message-ID: <CABcBDJuznu=BgDhevsD6PybX8+6fcaO1xyTcuGuv8F_+MfeZoQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: disable lockdep while running BPF on lock_release
To: NeilBrown <neil@brown.name>
Cc: Justin Suess <utilityemal77@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:34=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
> I know close enough to nothing about BPF or trace points...
>
> Can BPF programs ever block waiting for a lock that is held across a
> tracepoint?
I investigate this and I think the answer could splits in two:

Mutex (sleeping locks): no, this is prevented at verification time. A
BPF program attached to a tracepoint is non-sleepable --
can_be_sleepable() returns false for BPF_PROG_TYPE_TRACEPOINT, so the
verifier rejects any sleeping helper; and at runtime it runs under
rcu_read_lock() with cant_sleep(). It cannot block on a mutex held
across the tracepoint.

Spinlock: yes, in principle. Spinlocks busy-wait rather than sleep, so
the mutex protection does not apply. BPF programs do take spinlocks --
each map lookup/update/delete takes the map's bucket lock, and
bpf_spin_lock is a spinlock -- so a program attached to a tracepoint
held across a spinlock can spin on another spinlock, and if those form a
cycle (or are the same lock) it is a real deadlock.

That is exactly the hazard BPF already hardened its own locks against:
the hashtab bucket lock and bpf_spin_lock detect recursive acquisition
and return an error instead of deadlocking (rqspinlock, succeeding the
map_locked approach in 20b6cc34ea74). The rhashtable bucket bitlock has
no such protection -- which is the gap I think.

quanyeyang
> If so, then attaching a BPF program to that trace point could
> trivially cause a deadlock.
> If not - then how is that ensured?
>
> Thanks,
> NeilBrown
