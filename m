Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D03DFC61
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353801; cv=pass; b=XtLj9tAFxabXmpZxphUvPlAi7DH17GWQAQtBGzY8qBBPKL3obcuJeuptyRJ4cz9RdwShhiUiHrf6J8q4t/zemMmXDzDqCDUAnHL3nAS6PQv2/s/NxN2HUyIWAqKb1SATrTZQlPmsR3AMfqxaDRR65P2uzbkEzGNfoOpTuo+rJ98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353801; c=relaxed/simple;
	bh=TEXP2yah33+AE2fjne475CUYasFJjAsmtUxwsM9imz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nrbh0MMsLeZd9AFYDu3qItSTZmYGKUNuBWWJ3rqsiPLE7jMlMtU6mRehlu8b9QzJ+n+8+NelIRHnZQC4FX50tKAXJ0huTk/khP139AkvxWYjcu6HnCGCEkcUfxTpLsbjHJW7B6e8i12r0dVF1hVXbyxxEzHOM4JpAkfSmzIFLjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pz2QApV1; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pz2QApV1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so108473965e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353797; cv=none;
        d=google.com; s=arc-20240605;
        b=OrZ4fb/dWju+RfLmq3T6vZq3EjdrJli21/QOGrGiuqRVj5cG0vU1egJAiXK0OqqKiF
         HdoiJY4qKktcXvxTcpY4rMeGBUSNQmRtdSxOZ0zeJnpMivCoYmqMDwjJcrgNkJMybG++
         mOSJkNxJkiishRZFaVHwl1Ey+9v8GsUpT4togzmcT8B4wxbrQ9XRD5jmwgtQ6dCMuGEw
         Mis3EaDsJd8JiStrYxmpRAyZV1LCq2f7c0eVXavsQ531TfxAqI1hALPGiGdtFoMevUQU
         MiUMlGLYHfHLMWn5ln7LAtFecrX5amN9b6swvB4ZewL2JnIabSekEx6LEwz5KpBAm6K6
         LauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PbP3oiQFn7yKe+Kt1nPFNW7BzelEUxnA+jzurJQdfAY=;
        fh=pCfMVzn9wo0oe+5eaZFcwfSoP3asM4laqXLkl6YwHUs=;
        b=edrFpIzTHsOEjPr5NEjV8a3guKaLALoPGBGZmgLlr7WJq9Dn1grSTtb+kj3Swmwt10
         55IP/UezrZ5vXUoQssbaEhgrdQ1cr1EcfEYB+Rr4RHg4CiDsuBIe6ZZaNzgndjeUiGQN
         tT0knL+Gd5VfqfwkCRU7deMNYm2YhngdQT1O9ts8e6eqRCmibEeUzUVAvD4GdW10GucE
         epmOI2Beo6D69WKGUP/uZbMFjaaDFSRAzydmgBJ2vkTqDulJ0JYL05bobrFB5KLybYrk
         NJbb7mJcv1eTc7ucmOvjLvr4Tq6BZlmNpit3zsAP/hFknOBpf/oXsTfkpm746wpTL1T+
         T8XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776353797; x=1776958597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbP3oiQFn7yKe+Kt1nPFNW7BzelEUxnA+jzurJQdfAY=;
        b=pz2QApV10cA3h9Yg002/J95RcPYnbnyjyBWIgJse0z6FyX9Is4ogpaTiAru8DHPUkz
         IIrhpJsGZuCOGJhRWSNgwMILzgqOCXB8fDPgq9a3+JTHNoA046lsNKUqTS/aQbtTYFgA
         I8dS3Is2avci7DlFJ5lVFM1bZzJaKZUzgDmBxjPE/kttqMyMwqiHfEOfk3StMG/NDsIC
         vTEF/IwxVfif5HxTBZG6sfZu2L24A8QbOhgjwqY9z4Z1ItYDZlCvW171c2p6mz91xxtl
         VN0InAQmW5aA7WxqjivZMq/OPoOHEKztpMVRAxPJWw/VJw3Y0TMHqlV1gtCpbSiouiZh
         WsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353797; x=1776958597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PbP3oiQFn7yKe+Kt1nPFNW7BzelEUxnA+jzurJQdfAY=;
        b=M7vFXTCu07V/mJnNK0EDHpqjFFefc84E+LhIeZgRmcuRwRwiwtU9+3iwrUxppFezvw
         71C5GSYDjoLGcWPidUh6ZP4bZU0aE9pR5ly2wcR8A06o+ooqQlJ5PrgFcdAaUdEcKnNk
         lrrphkFJU03NH1ToTZo/G0th5CVXvWueqSuUvaz9tBnBuzigS1D/AQCdLaoa2kVh8+/G
         iHRQHPvK8QwxJzT0GIimXneU2hJbvMh2oIxUHt0lwBJ+6oOSI078uP4oHR7kU6ZnT/xf
         8+nj13aX+nl6amSptYRfUycuTjteroG9GPAO/81AvIUTjUY1q7FDB2tFtb6Fm4JDlV8C
         X/iQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WNUxg7DljAY1k3yqLHe4m0EmkDjfNYruoDK4NB43qeHHQ5Kso/BQyqimC/OC6r6r47bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxO3Yi7XBY7qDHENLHQRe8JN0EAJR048AQCDp0IKTPpi2ImMAf
	2+n2yGGU9mc1Uqlk7c9K4JayqggK8xP4EZrqWHF0junCoMCNTJ1D0k/L2KNHjwc1MoV8XeNjkJK
	SBFtUQ9zxFoRtSGNRTKsuS0qQ/vjLGpiE99aM
X-Gm-Gg: AeBDievPyQ4wj4dM3l0eX6AbogRMQdYpbMYnR4qWtzbZqnQ/dX/R8p6PWSednfwIQ8k
	rbzoMnmS2a0n9Kti3uN0D5ErDvwAr6XusYWt+czjYr/uTMyZwp4gfooVErnEtHAP7xi/SCCgk+W
	mkEiy1ulJBsDy8dnyMbqeISnav3YdAkG0wOvJnJSA9kgHMRSgTrSMhZF1W71G2DPi4Ao+TRRrBU
	vZ1uLg+qx6oOK7V7wmydgPkuVk0aVffRbPW4THzBal8R2oXs7Et4HIU7gmdIphn3ga4yfENDsT9
	byDUbhWMnHpXyJqSA6UFjx4ZY1wc7Du1UHS0kNjNimSp/254+yMHPcmtGeOFradhS4QlbKSbEqQ
	8CdMxRysvQ0v44z646NOc5l0x1myNykRnZ6A2
X-Received: by 2002:a05:600c:8706:b0:488:a62d:76d7 with SMTP id
 5b1f17b1804b1-488d67df53cmr381633535e9.1.1776353797374; Thu, 16 Apr 2026
 08:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au> <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com> <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
In-Reply-To: <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Apr 2026 08:36:25 -0700
X-Gm-Features: AQROBzCucZYGoMqHfzSh_2mdCkBFokB7UCUVKe4bArIY8AQGAIrXe2GgAeUvJzk
Message-ID: <CAADnVQJuOP5zViH-hiie2M5wVNFrjD=WddBoAT2NkeNb08Roeg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 8:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/16/26 3:11 PM, Alexei Starovoitov wrote:
> > On Wed Apr 15, 2026 at 10:18 PM PDT, Herbert Xu wrote:
> >> On Tue, Apr 14, 2026 at 10:13:21PM -0700, Alexei Starovoitov wrote:
> >>>
> >>> No need for such guarantees. It's best-effort only.
> >>> If the walk skips entries it's fine.
> >>> As long as it terminates eventually it's good.
> >>
> >> There is no guarantee that this walk will terminate (unless you
> >> finish it in one go).  In a pathological scenario, after each
> >> walk attempt, the hash table could be rehashed such that the
> >> entry that you're resuming from gets moved back to bucket 0.
> >>
> >> More practically, the walk is essentially useless if you encounter
> >> a rehash/resize event before calling rhashtable_walk_enter_from,
> >> because half of the hash table could be missed because the entry
> >> got moved near the end.
> >>
> >> I think a better interface is to detect such a rehash/resize event
> >> and then fail the rhashtable_walk_enter_from call.
> >
> > that's certainly a cleaner interface. the user can retry
> > if resize occurs.
> >
> There is a problem though is the get_next_key interface:
>
> int get_next_key(struct bpf_map *map, void *key, void *next_key)
>
> we cant store any metadata (table address) to check if rehash took
> place. Am I missing any way out of it?

Why store anything?
rhashtable_walk_start_check() already returns -EAGAIN if resize
happened. Propagate it as error from get_next_key() ?
