Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5A80617
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855110; cv=none; b=droi94AyZHpiEaXtKJKnA5FdK+0oE2I5Ar2hGs7k6Pfqwi+wqsnQruzxPSiSuAxhjp0u2ZkRj74MhX/ms7F19ncA5vHL0V37s+iUIyeZBB/GvLICmYBpmR0rGwK8ESpZUmt5YkrHoH8HCpA0P/sqaMH/OM4vv+G8rJJkaESziMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855110; c=relaxed/simple;
	bh=oTq3CZN4Zju7qN7EjbzOvd+N3X+RLzsgzvo99LiFzLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsRnjBzZ265KVn8psnHrEZJ9721eeEwkQNd1u6UoqdE8/ZaSmSdgpUMPqOzOr3hlZlcVMV/ufJLHdnHYLepJ39X2vWUZKt1D0KxmDkbSFvLyDtdXFP62y1uHW2yYI2zjLw2MrkdTVYsjl5sLMihIKbvvCfV6RWHnldXYfUUmM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wId3HKGk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wId3HKGk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dee917abd5so152155ad.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710855108; x=1711459908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
        b=wId3HKGk+TuOB9R/FZKVEozItzgiRAWvqLYFoEG4rLg6g/rw0ixG7SuMeWOlF/NHpu
         8un6w5OueU8Lmekt+2otFr4Ik9Utl/DTzUvesjDgHpuXd4BoaDJPewBMM6J3iNFjH9pc
         RMw0yjvf2VROYUcDhDrhD8NQOj2HgAluzh6fxxyTvvtKBoVTLkt50uf8z58N+aEXwCd+
         0cGSayFDHlL78VSmpwIIVM6x+sKv6gu+c1/+JobT5UqcPcv+y7RpE0cNjZ6TQe0fYJPq
         bDSA8Ie8ibQtWRa9wTOkP8zGwjjY8IsXGrlBRJWP1Bw8s/7XRu3KfYXlNKx+Sj8Skk9U
         4XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855108; x=1711459908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
        b=NKfsfDBdDEEEK4dkJ0D7thLwbVtUSvliAekwmX4sVajy0BaKEDbgReUEcSHiESCIzC
         jvHGg3Q6K11A11LneoiGwNd06ORag3pd2ot5jkKQtr+VAvuuKGUmKaDvmjSQqxqXB2nS
         4YX9ZF9Emkxc382FVnZtDVcMQjrCJAxVA9EafbNfQa1hV12wKPfArig1KzMKQdA7nIzb
         wSBpiP+b97uiGqAt35xWRJxklUqC37Q2AQCG+Bbl0AjMUmAXyslclF8MJT2b4VYpVy1v
         xDu0ijXWAyPaoL86PTv04W7b17zuX5uSS2BTIn04CF+MUnxmfgjbQUzsVOrJGRPCNWdC
         9GwA==
X-Forwarded-Encrypted: i=1; AJvYcCUAt75eIL8Tdq29yudZ+KpMhwvMDvoK5wwi335JKRHH8VP0abFkmtwum3oTvv3wlpCXXcSED5D4J+Z5rnes+It0pgkU
X-Gm-Message-State: AOJu0YzKmvJqDQtFJqCqbhRcfvRjpMPNdx7QBf7Lehx0YwmQ+lfakizr
	9Ffo7hkFnDAdlIx32cuzJI88VcbulTj0PvRNPwmMSAZ+sgiUvfQuMxt2FSEXeqIifOBIAcqBEko
	nK7mZPsKEEPIGI9JCS/eby4O+vxueXy1rKjZv
X-Google-Smtp-Source: AGHT+IFNmXcGYu+lNSQ2iexTWqZe47HUoTeYhNiE93aW579mIfvRqJBheAkUJL1ix5bvm3wn2zyeJjyY46GinXgiC30=
X-Received: by 2002:a17:903:2303:b0:1dd:65bd:69ec with SMTP id
 d3-20020a170903230300b001dd65bd69ecmr240302plh.20.1710855107477; Tue, 19 Mar
 2024 06:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000901b1c0614010091@google.com> <2615678.iZASKD2KPV@ripper>
In-Reply-To: <2615678.iZASKD2KPV@ripper>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 19 Mar 2024 14:31:35 +0100
Message-ID: <CANp29Y7SuK8P8xHa6JzAzs_NxPUN9AvFTiKfMhgLy1POGBodwA@mail.gmail.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
To: Sven Eckelmann <sven@narfation.org>
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, christian@brauner.io, 
	daniel@iogearbox.net, dvyukov@google.com, edumazet@google.com, 
	elver@google.com, glider@google.com, hdanton@sina.com, jakub@cloudflare.com, 
	jannh@google.com, john.fastabend@gmail.com, kasan-dev@googlegroups.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mareklindner@neomailbox.ch, mark.rutland@arm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, shakeelb@google.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sven,

On Tue, Mar 19, 2024 at 2:19=E2=80=AFPM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Tuesday, 19 March 2024 11:33:17 CET syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
< ... >
>
> Sorry, this is a little bit off-topic. But how does sysbot figure out the
> subsystems (like "[batman?]"). Because neither the reproducer nor the
> backtrace nor the console output mention anything batman-adv related.

Syzbot looks at several crash reports to determine the bug subsystems
and in this case one of those crashes was pointing to
net/batman-adv/multicast.c:

https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D15afccb3280000

--=20
Aleksandr

>
> Kind regards,
>         Sven
>
> --
