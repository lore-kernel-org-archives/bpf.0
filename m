Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C852BE053
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281728; cv=none; b=Mffww7Qk7OPJjx7akcZPz61HAEiZBQIbBNyidrpD/39rYqZc9dp/AKLIWf4IaNbmPGlAEwzM4NKNj+sgIT8L08QXpDgv0NqJE2QYVZoMflTziSj9+aCVwP+YvwrtJfWjGwj2ADJS8zEJ+HaNBSQ/zkJ3qijM6ADWFUTNeNTo6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281728; c=relaxed/simple;
	bh=iehgMQ3zsDAYXru/qpskT6SNNaQ5ZNTsgJtsfacd6dE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP3rg71qmkE2t+cmS1wbamHmu4Tlk+QPSBmH9JuJtrTOUYKtQDJGe2EmKe7mQKq0CnhAqvxvcqQUYfqrD6wC2slBFkrZEs8Ltt+Bs3B+WGmL3k20vGlC1oBXZsXF4zocf4m873wwCW9KKJbgkEftcQ0ro04WW2bU5JXdHZ9o1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWWty+Ej; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWWty+Ej"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so7323265e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770281727; x=1770886527; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oaHpNHjAg7f2Vs7GUsD+kiDBNGhY/HDODAQ8z+oYh5o=;
        b=KWWty+EjNHqRmakTVfB4UnEsaA8oyYdY4UGwYPaKnRD+Upc2nrm0PbHudDAKhPXLJz
         RMFkkLgV0SX+XGWXY01WTFK91kAdlRcxLmXH/VdHjIkv1Ly6XEfO5qOwUL1o7b6cEvFT
         kOfSRmreyUZjrRoh9vU3EI7MjFZTMhDpm3+8TluvkOG67oq3gNpvbsbPOV1l7mBDls8+
         rcZRMOX3UmtSmCBCxVesmvqx/WxL8A9UsKiZ4gk7JgNuZ+bQtDptEKOaORHRg9HStnyF
         zoG5vfL7jxYBpGBjT745I0GVnuYawpnqHCc+vSapZuridmVkrQi9qDN+LYtNilGxe+lF
         UuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281727; x=1770886527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaHpNHjAg7f2Vs7GUsD+kiDBNGhY/HDODAQ8z+oYh5o=;
        b=wtiE3zbrIiA0zBjTDSJV/wHVmuJa0PZpwJEtFVwJSmhEvpYK8OtK1K3Cnql3/7HMG9
         D6+IvY5O5NzleQ25cqRkQY49mY9SvedQ2AHG2Vv4lmBSeif/WpaHnS82291r3RGmRrRx
         QXtOzZhBqC1VLLpUAKmsAmR/8IcCkhxbkx0OkAT1DNGcPU47dCUFRGJ+sKad51zIINwm
         GtzJkrp1eo+YD32/lYCWvSxYW3T82FmF9O9aIW/prthYcSNeJin1FpV4LDUAdPIOGwA+
         fcCyzmMNNSEdx+S4bQY4muc8fY1IDwfsK2dVenb6NSQO330i0GIZaM2ifvlRmucTTAY2
         xiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS9CG+jsGXCqSNS5s+iQo3ni5zjPy4Uzxrdb7cTMMVE0MKmUY9ADPxVZu0DPxnVLKiA0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWs4JAflZbaNyJEXQXNOw8v8GPIY3qJSQHHURjQak+b+xKyN2
	tTGxtKnQ6a+H+9x9j890y28go/+tnYEQZj48+QfFPX8MkjQRPeM9OVdK
X-Gm-Gg: AZuq6aKYsFZI2nEMcsVMJUy1bXfrzbJKFQZ7LEd/DUMToMJWOf2PEKWAm3ho6xVhw+8
	plHjT8t2ZeOSL5ZU+hV1xmeEOBvz+QxgZkINgWlg9GJw0kS2aIs6olMKjBC/vjcWcmttUV6bcSm
	l0LsF+g5Z9+AFQIZjx74j/i0kRzzfvmDf9F8y6LBmM052yajBA5IUqyshg3apeLmMIk9VicQGow
	kxgfQohAkEZpO5zBeqD06ZVUvUyQmQSpAPMUmHjz71FuqCZeTttV6XUCuW6Fp/BCkXHmtIBQc4U
	Ye5yYNzBAf8BiKAYvW3SE/0AbLHhcJiojLOGDk5+Mfj/IoOGcUgpBWsJVtO6E1PebbpRQShYQBo
	b5LbV259SVwkqbfCMOELTwNIblIanhgv+oU7CH1KRfzW+EqMihwLHYOsmBGMS
X-Received: by 2002:a05:600c:34c4:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-4830e96fa56mr74341405e9.18.1770281726711;
        Thu, 05 Feb 2026 00:55:26 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d57009sm37521425e9.14.2026.02.05.00.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:55:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Feb 2026 09:55:24 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
Message-ID: <aYRa_CDL1RqIR_8S@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava>
 <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>

On Wed, Feb 04, 2026 at 08:06:50AM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 4, 2026 at 4:36 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> > > On Tue, Feb 3, 2026 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > hi,
> > > > as an option to Meglong's change [1] I'm sending proposal for tracing_multi
> > > > link that does not add static trampoline but attaches program to all needed
> > > > trampolines.
> > > >
> > > > This approach keeps the same performance but has some drawbacks:
> > > >
> > > >  - when attaching 20k functions we allocate and attach 20k trampolines
> > > >  - during attachment we hold each trampoline mutex, so for above
> > > >    20k functions we will hold 20k mutexes during the attachment,
> > > >    should be very prone to deadlock, but haven't hit it yet
> > >
> > > If you check that it's sorted and always take them in the same order
> > > then there will be no deadlock.
> > > Or just grab one global mutex first and then grab trampolines mutexes
> > > next in any order. The global one will serialize this attach operation.
> > >
> > > > It looks the trampoline allocations/generation might not be big a problem
> > > > and I'll try to find a solution for holding that many mutexes. If there's
> > > > no better solution I think having one read/write mutex for tracing multi
> > > > link attach/detach should work.
> > >
> > > If you mean to have one global mutex as I proposed above then I don't see
> > > a downside. It only serializes multiple libbpf calls.
> >
> > we also need to serialize it with standard single trampoline attach,
> > because the direct ftrace update is now done under trampoline->mutex:
> >
> >   bpf_trampoline_link_prog(tr)
> >   {
> >     mutex_lock(&tr->mutex);
> >     ...
> >     update_ftrace_direct_*
> >     ...
> >     mutex_unlock(&tr->mutex);
> >   }
> >
> > for tracing_multi we would link the program first (with tr->mutex)
> > and do the bulk ftrace update later (without tr->mutex)
> >
> >   {
> >     for each involved trampoline:
> >       bpf_trampoline_link_prog
> >
> >     --> and here we could race with some other thread doing single
> >         trampoline attach
> >
> >     update_ftrace_direct_*
> >   }
> >
> > note the current version locks all tr->mutex instances all the way
> > through the update_ftrace_direct_* update
> >
> > I think we could use global rwsem and take read lock on single
> > trampoline attach path and write lock on tracing_multi attach,
> >
> > I thought we could take direct_mutex early, but that would mean
> > different order with trampoline mutex than we already have in
> > single attach path
> 
> I feel we're talking past each other.
> I meant:
> 
> For multi:
> 1. take some global mutex
> 2. take N tramp mutexes in any order
> 
> For single:
> 1. take that 1 specific tramp mutex.

ah ok, I understand, it's to prevent the lockup but keep holding all
the trampolines locks.. the rwsem I mentioned was for the 'fix', where
we do not take all the trampolines locks

thanks,
jirka
