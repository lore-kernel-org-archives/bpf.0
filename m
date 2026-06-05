Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1126F2A0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780693241; cv=none; b=OGds0nYvDp+bmEIttv4SqcYNIXjGCn076KVFX04yEMR1AIVcTBA5HzT90pdVAl/ERIMNKErX6WPIQeIZlLNIMhSZuiwEPrsAVIYAIDgcYyIj0rOk4skk8DygvtztW/07AeB4F1WHyRoJhQpWJZMNsxlgJ3qDkexslFcx6hCFXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780693241; c=relaxed/simple;
	bh=pyFb75hvN9oB0Gtvinazm1I6mPbcYm4ls4LQBMuExaU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U6IAetwQNL+60tFj330Bn7r9tLX/RVGxJTtWghE//Bqn0kluS4EU432jyilWh+nml4/GAgs6thnzsggev1/6T9mhNJdyu1/BfbyZPCH2ZFfNAo7rPtYjzu7/5R3eL5Lh17gZ2QOzJQnWSYtI0r/5CqaR8uagBnQ1CZcK6+EeAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUH0nzIF; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUH0nzIF"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6cfdc8382so1620492a34.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780693239; x=1781298039; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5sqjQgX3ITxbRuATEOIK56/fOzNeym8AsGc0JKRS1o=;
        b=NUH0nzIFEWlK93FCggxTqSeH4SvRv//ukWSqY56wC59vmrG6FxPIQ0f5bstGGZZO/V
         Qf8pNzr7JzO7BiDKHP2AQp68yK5UdY9dw1lxSlnXwN8RTS0Jcee5dUiu+4g5PS2rgRz7
         2lHmZg/mIrOt7YCfjETZNfwAvKbBDKXxohzONPBLL26DGDMJla6Zblp29merbDl2JvTC
         6z9Gn6QMtIR/PZJ+xiCvJfw0Q281i1ep0ckNQNr2rfhAVQWltl+/B3E+Leb82kijK0WO
         8SCQRkfZKlZI4rQ5UyTQcoWO4D2ZRo6TZYqUTfPWjppWAkDenYR4xXp7KBIJW5OYBifS
         jL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780693239; x=1781298039;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5sqjQgX3ITxbRuATEOIK56/fOzNeym8AsGc0JKRS1o=;
        b=citsKjxrckyB3jNZyscvAc0vMPUWrSUQYkWz1G52f79fQBS78bxTg1XUUFDgg5vVzu
         3roKpZ2aSwuW+6RLNtSXT9EB5J+f34kJVibHB3y1if7RKkMTmCNM87OBvQqiAFMzi9Z7
         hYq2P8spACgRI4d+mdal67WiKfUlW+cGjpYu8rWPJIbz5/g03214hjnx1tQyKL0iKEs5
         ZUnW3vug8yhQfCs2SIZng5XPnRQhw+6gv4AWQu603sDlTsY4msvoKVErn+WaLwO4DqWe
         wG8zykJtPtI1HqorUCBcsx3Rkx/iUFRsY+BZuC2IzHvi8SPRxww63X41/QI/s6g3Xdvf
         RWug==
X-Forwarded-Encrypted: i=1; AFNElJ91gzH0F/zrJ4E5135ElxpXfbfx05Qj1UHBF+qu71XTfT/g61ejaWKuwDYojBTZ3qABgqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDr9jvzwFOdVcS/d02MCz1gCENhmYo+F4/DDkBYTcwmp1/EZE
	/YfddM4EATS5yya5SW7m/aSAeleG3XX3jHG3BwOt8rK3Pxl2Jed6Pql+
X-Gm-Gg: Acq92OEB0iWCsHn1Uwwma5ahQ9u0VBs9yl7pmJFbc8X6oDoq8jZKsOz5U746N7h0zxb
	7LAbNZWyIit604TJ49X8hcC82Ecwb53nL9RMc83Ov2atnJyZ12RoN+cD0zEwD7og1E5FH+gsM5I
	nypjhU2pmVlIPbEqamu32/jz6PAYDUzBA7ERnpvTfELnsWl5uz9P2ZZE+x9J4BNrVXLKEsunIcq
	nzvy0jqwgo1efYO9seDbTjkdfXEn+n0kjhVBVHtSrT/mBskqZBbBRV5wRSlzjKlTGzwgPtLYpO1
	vtNt6HFIkMi76iAn1RRo9V5q8VTGduneZ7Yi+oIjXir16dwwrZBVeR+QWrp7TxDEkMD9YBZVR+9
	mWhkQ887wIFN0u3lM8klX+3gtxCAkroGeo2hr/CyfZxhaHuaEzLYbdm8We6ueFvS+9ZWPka5qkn
	Rw+b4ykNJXxWSmAcHpDGt54mBp0yr1AIhDwtNXpE5r6Nn3DRwVVSOv/pIcAYD3K+kmhLFPYPkq4
	tkkk6zZFMmmmKJTMbTbQ82qrzn6
X-Received: by 2002:a05:6830:8292:b0:7e6:cee5:1bbf with SMTP id 46e09a7af769-7e70c8ff1c2mr3241768a34.12.1780693239073;
        Fri, 05 Jun 2026 14:00:39 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:57::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e797cc76sm6800097a34.26.2026.06.05.14.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 14:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 14:00:37 -0700
Message-Id: <DJ1F2K7SET77.3JQ2IJHY6H584@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>,
 <syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com>,
 <syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com>
Subject: Re: [PATCH RFC bpf-next v2 1/3] bpf: Fix NMI/tracepoint re-entry
 deadlock on lru locks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kernel-team@meta.com>, <eddyz87@gmail.com>, <memxor@gmail.com>
X-Mailer: aerc
References: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
 <20260603-lru_map_spin-v2-1-7060cfb6cdac@meta.com>
In-Reply-To: <20260603-lru_map_spin-v2-1-7060cfb6cdac@meta.com>

On Wed Jun 3, 2026 at 11:55 AM PDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> NMI and tracepoint BPF programs can re-enter the per-CPU or global
> LRU lock that bpf_lru_pop_free()/push_free() already hold on the
> same CPU, AA-deadlocking. Lockdep reports "inconsistent
> {INITIAL USE} -> {IN-NMI}" on &l->lock (syzbot c69a0a2c816716f1e0d5)
> and "possible recursive locking detected" on &loc_l->lock (syzbot
> 18b26edb69b2e19f3b33).
>
> Prior trylock and rqspinlock based fixes (see links) were nacked
> because compromised on reliability.
>
> This patch converts every LRU lock site to rqspinlock_t and adds a
> recovery path for some failure windows to avoid node leaks.
>
> Failure recovery:
>
>  - *_pop_free top-level: return NULL; prealloc_lru_pop() already
>    treats that as no-free-element (-ENOMEM).
>
>  - Cross-CPU steal: skip the victim's locked loc_l, try next CPU.

These two make sense.

>  - Post-steal local lock fail: publish stolen node to lockless
>    per-CPU free_llist; next pop on this CPU picks it up.
>
>  - push_free fail: mark node pending_free=3D1. __local_list_flush(),
>    __local_list_pop_pending() reclaim the node from pending_list.
>    __bpf_lru_list_shrink_inactive() reclaims the node from inactive
>    list. Nodes from active list are reclaimed by __bpf_lru_list_shrink()
>    or after __bpf_lru_list_rotate_active() demotes it to the inactive.

Here I'm getting lost. Feels like either mechanism free_llist
or pending_free trick should do it.
I don't understand why both are necessary.

Overall it makes sense, but I looked at this lru logic long ago,
so please repost without RFC and let AI find issues.

> @@ -318,8 +315,10 @@ static void bpf_lru_list_pop_free_to_local(struct bp=
f_lru *lru,
>  	struct bpf_lru_list *l =3D &lru->common_lru.lru_list;
>  	struct bpf_lru_node *node, *tmp_node;
>  	unsigned int nfree =3D 0;
> +	LIST_HEAD(tmp_free);
> =20
> -	raw_spin_lock(&l->lock);
> +	if (raw_res_spin_lock(&l->lock))
> +		return;

just return? I'm missing something.

