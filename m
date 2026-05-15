Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B93F9A14
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870294; cv=none; b=NNSv7GdFG6+in/vQWCOLGap8PkZmuJYSPqmMyypGEeJfYLLCDly1HNaFSHpN6f0QDrgmLSd5WKfwO3qniJwiSbeNY6Q3A/HgCY4g+y0O8FwAxwzg/cYJG/gFkeaZ7ntb8bcoT+PiqYzZxR+lY+lN3bZC3YtoiEkN/QaGlKX5fAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870294; c=relaxed/simple;
	bh=k5VW4oDrG/O1uIaSctnLaAkhDnEI15xDK9kkrZgNuXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDDKt4c8w9KLTBHJMMffEclUpVEKAIgGyanptsTYRvVlvZuUuWc7T+FYtx+CXWCnlcev21H8jklVSBAybyrbljMsziJKaRAgjRc1mtIYkTqMAavx0OktWEyGkB7RV88jUSjXMhkvgB4EOV29xjYevz+w2qhLYpn8Y2ZWTUy/5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XghzgMbW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XghzgMbW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48e82c23840so910315e9.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778870287; x=1779475087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5VW4oDrG/O1uIaSctnLaAkhDnEI15xDK9kkrZgNuXU=;
        b=XghzgMbWSQOxk32wfrd99kf1tXI3HumLCinzWmEWtLVzIFjPIhNSNIq4kDC4tTL2YE
         ojQegKItxinfFAiCTz+geqaOJ0Vf19NMskIjxE8uKTBu3pip19EVqp5E3u9bJy3WqZ8k
         CO9tbRQmXYzStZm2kmfkBEqPgnJemreJU/W+YitqMI7WMMO6KckgR1avTXPfEXC39Cum
         T+/2xSH1EynZHsh3N09H/g819AfiiA2U4aZ8Rr7iU1zb4I647UxITthgmwtuVL4c/LST
         9D4rUCokKH3jGLH5WhD3GjlPjooncqa3QimOXxDBedZQjIYilKHShbuLzOvMBLlVJenf
         o91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778870287; x=1779475087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k5VW4oDrG/O1uIaSctnLaAkhDnEI15xDK9kkrZgNuXU=;
        b=lb4eOilvWf/zM/UoyKODGsPyAwwrwog4BhWi+2BlKu6jxvg0Zcsbsj+/3tyjlYXlKw
         8ZDucDSdM3yl9Nc7nvB/5L/f8XJX2oEUWzfjs7EavKa+TL8F1UNkWN1p8SSHoTqrNtxa
         k/k/V2jkkd0l96iCxPem/BOc+FwAzWnbIZNjj3oMU+F/pMTX/0W05vgqunnqny6Fi4Lk
         5Scq6ljdt3XhK8Y8dVZisgTNOPrgVbfwjqi4X8XpzQW7G2EX+OExacPofMz2MYQ0vZI2
         Gl5rfiQuXN/g4qv3fDWZYhWfYb7TT8gQYMDOMLRaycg+Ud/16RHljSo0AerwfwfFwT4l
         HhAA==
X-Forwarded-Encrypted: i=1; AFNElJ/LVFhqJAKc2cNMtrRls36RvnxAFh1e3grxTVMN4iE320+q5CeqEHtCV3eofyY52+8DGek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIZq6sbBFwB4wr3LMHha+UjhGu9kNRCssFaG8BYLbbht+uEAw
	pE+lnpE9CzsdBCm17KV+qrZz9s0u2zXsxDrHbd2WIo8+8/BXfPLfvR6EH0uE1i6U
X-Gm-Gg: Acq92OFeMyWkivEEf6JbxxswwNJryu2povXI6sP3OHdp1dk62+QuWzS7WfXog9R6vpK
	tyzwuY4cQQm+oUMvJEwdt6NV4Bl/TOSh8IkVLx++5a+m18kwjIWBjDn7JOOaaYKXxZMs9Z1LCUF
	4zzSH9EsXnBI2I5hBdlUDgDKmcegKohMmZZ9QyHYK+0q/LkUYcGMOFSpsfs7NxlEuyA+wYTPodm
	wkfyrxXuHzgOpx22gjGclwLmjM9iSBUJRd5MJmUdLHi8m8s2QWvC1ahMYggM9QVPH9tFvndQVJO
	IRRebLDKVHkJxAdHFG8rsXjGWsQE7QDKdOsURgK7SMvE0mC1Rk8KIwN5PP7tSX4rdH4wye8Nh83
	w8Sifsd4INTYJfxU/J2WpmfiCSiyN+y77j3IHBaaUcTgxftjI34PpyLxe2skf7l5O5qcOH8doru
	Q9GLv7PVCW+xeYQP9bKVatOUIcSjKIdkt/WPGA2F9v5/jrKVLvBiEtD31TgvPqMnTN+iSko/M=
X-Received: by 2002:a5d:5f53:0:b0:44b:9dca:7d93 with SMTP id ffacd0b85a97d-45e5c58761emr6944564f8f.26.1778870286817;
        Fri, 15 May 2026 11:38:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm17709798f8f.4.2026.05.15.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:38:06 -0700 (PDT)
Date: Fri, 15 May 2026 19:38:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Arnd Bergmann"
 <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <kafai@fb.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Simon Horman" <horms@kernel.org>, "Stanislav Fomichev"
 <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, Netdev
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
Message-ID: <20260515193804.4d85283b@pumpkin>
In-Reply-To: <b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
References: <20260515113102.2389020-1-arnd@kernel.org>
	<CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
	<b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 17:15:46 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, May 15, 2026, at 16:47, Alexei Starovoitov wrote:
> > On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >
> > 1k?
> > pahole -C xdp_test_data
> > /* size: 192, cachelines: 3, members: 9 */
> > /* sum members: 120, holes: 1, sum holes: 56 */
> > /* padding: 16 */
> > /* paddings: 1, sum paddings: 36 */
> >
> > what s390 doing to make it huge? =20
>=20
> I think it's a combination of cacheline alignment (256 byte
> lines) that leads to padding before 'rxq' and at the end of
> xdp_test_data, as well as CONFIG_KASAN_STACK that increases
> the stack usage further.

There will also be a 'double stack frame' in order to put an
aligned item on stack.
That could be slightly larger than a stack frame and probably doesn't
show up in the figures.

-- David
