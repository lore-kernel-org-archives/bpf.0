Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0E346FB7
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809305; cv=pass; b=uw63s0KfdZqiaVFKKYKxYp03rGezIvCA7CYVZlnUTDucEX6JA9XESlELCBGZaX6V5xOqBbzebMwv2mM2WpNj8P7NrJWX3jI4+HOVRp3HCxj3as0Q9Vtx4gkhP75J8vClFCTEvOBv/BdGpfXAG6SzMs8MAVLmdDuVAiP7rRdGH/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809305; c=relaxed/simple;
	bh=UXtLfltFUXTDQKVwK3oHWCxh+k3pk+raWNie7ZxXZJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpAf1pxXcQwvIr+FsqIY+4Cw8P3++V3kA6+et9rUWNAQizSHHTjIPzMNtVuFeQkIB2CMSjy2Jm8OM3GwqS7U9lu80s1PSvdFYgDMAQNjx7+r4gkWGIkSSz9X5glmHgqlHrpIipSaA0wzsVgZ1BnV02LGvQHEh9Zm2++SzGl4Pjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0xxI9tj; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0xxI9tj"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-947fef8ebf4so2094675241.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 13:41:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769809303; cv=none;
        d=google.com; s=arc-20240605;
        b=fbHn3LzymWVd1Erc8PsoT5Vfo4QYmxswctLwoqQTA/kzR1zbLF79W/Ax8qCTCwQy0k
         ezZ+dpAccRlsOeKQqyFSG6zJBC4ZYaokDr8H0U63ONmeI2WyCQvzd+X1tOJaw0kxJe/j
         8RFRMc10XF9aHgY5MW3w0vGlp/SZVVmHpcTrLBmLQK57dU39iQEF7TzDU2OaAeKThfbW
         TT456nj7rdOym+lSOu7WpattSyFNJTFL8Ia5/PwClRodH9PaQ5CvPEYuGD+D5LweCjdc
         Xtl4y9iEdRA90y/HiDVCcRD541fc2p308N83mxQmjxKTVq+Tn0wMkutJfVjRAD+A2xzp
         zNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UXtLfltFUXTDQKVwK3oHWCxh+k3pk+raWNie7ZxXZJ0=;
        fh=s146PiVQjT1VKUjYrZraz0HBga4VOJGBemYFfItwKdg=;
        b=h1jJK56dwJajubmeyhIAYkZRHEi4Szp/TQ533mCCac3VcLfI4Q7r88RKx791ByMi1M
         7MAMO4GKd4t98yAhFn8mrJFrzZcyPzcDSK29DQq2KI63lRfpkbac1EqwIxqtq/zUGuxp
         RSCgSsZ95UzETycJfFB/kpfBKoIWYNnb821woqlmWFX1LSuMzf+4rm30R8bfZZ0xQPGv
         o9wJ3iI1+3MXwgUCAMy1PnjVDmvi014J2xg5zfX2j/AVzVAuELn8+SkAECD+J+j0bwKs
         kp+ry8n9UTJUOH3UuRmyasSGLHaPU97xvmuUziC844UNMINc1BeF2U/gDdsDPyrC7awI
         +ZPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769809303; x=1770414103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXtLfltFUXTDQKVwK3oHWCxh+k3pk+raWNie7ZxXZJ0=;
        b=T0xxI9tjOjGhldwnQY6fNSYWyfhx0ualHbYLzfoNLF+BATLjdu4EDVBJSXlHP5kdJG
         Ut7IBEXnuuN6H9w0TXLIndLa0t8XJqbADbGwuzqwvdULvKnDirOZwxOOrOq0sS55Nu7u
         Bu5zxdBaSUPsVWnZYITI5HF8yxGsqUBklZIBfpdI/akYUwMOR+n4FrJ+kNpSuKQr6PDH
         lmnzbQC85DEx7I7f5LBf1WGE9un7Z5HyiOeYg8A1O0cPC6dzLrb4+DkzSM4SqO7tmGZ9
         fMvDw2744J+Q1PBU2sTyVf1d6/yQrptvWdC/wHWv0ivLdfNgcglD5tBbApMw5BXwjfdT
         A/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769809303; x=1770414103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UXtLfltFUXTDQKVwK3oHWCxh+k3pk+raWNie7ZxXZJ0=;
        b=esu7+LMje6lrZAcPyHzFELP+Aq9c2ug8s9HHm5QtSBeGOPuwLrSKX2vU2J8/XQVvhJ
         B/CRwRfKyoeA0mO+l+xbWfNRwLXoFtXEVKNiWrcSNJG4CvLiy8NsdaGSv9cjJ3SG9NLw
         sQDi1VVeGd74ZOYXG8kaiXSP2WjfYLCoKYVxZfPUOl2h3iOSY1YZrjgc5NxlWIJMgCP3
         qp3LIzKE9MnmnID0b8UO3aKR3pra3IFoFXre1xzIC4LOCptzgs7GxRss4iS3zrQJgEdy
         MZuZsVo8Dq3VluejwmtT/50/lFT/WFVuxsG/9R2VbDKxTkkDiTl6Q+7S/928tAanKNV7
         YM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSNQXIGcQiHbA8vfxQ2DiLIHHdne92FuJ9E2cmMvn5ig2Mesy2HsIo5OuB3JCwU17hUZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRYQlfSkOLYoMxDM+1b4EZgY0NQ+RKg2Hp1qaZNOP2Sy1Uown
	/fy1YVrIb0qWw0yEwPEOLMKrXMG+pz/Xh0CaqqAQ+PfSKNlXylzonfL56reeHvmsqA+D9zyUpoY
	AJtuxKV4OGuQ1eOpEsYFB5l6zefH9OVNKRw7vfT3H
X-Gm-Gg: AZuq6aIb//Er3RiOlaAFYxysq0368uoCcUeU9PQshH2U/cqT8d8AfKVj5V1/xNnQ/e6
	AdTYGlXYz/VF5bs2aZEB76KKtxIzmNulOIzh5mFUjDdMmwg+BbYqipQrTDRFOm3xAOq2Mtks+iO
	Ru70Zc6UbeZSJU0Iyl/GNGVWpCFz1aecBQcQKW7W2M6BK6mU+4vR6xB74qOACmAlpc5lJN8oFhB
	kgMthLzJLMUU9TOMXht5wMKCSBpqqCswZmchsc6ZphXnaQjds1ihtyrJ4DTFpY98RPa2oqRKoE+
	M3qnng4sK54X6z/Wygf3FcwUkpz3
X-Received: by 2002:a05:6102:c91:b0:5ef:a1ea:bd33 with SMTP id
 ada2fe7eead31-5f8cdb11921mr2641358137.9.1769809303102; Fri, 30 Jan 2026
 13:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
 <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
 <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
 <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
 <CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
 <CAEf4BzaEiQ8FApp1KMrCvsBVs+xLrk_mtQFUCfXZ3co2D6Oayg@mail.gmail.com> <20260130152400.6a71abb8@gandalf.local.home>
In-Reply-To: <20260130152400.6a71abb8@gandalf.local.home>
From: Blake Jones <blakejones@google.com>
Date: Fri, 30 Jan 2026 13:41:31 -0800
X-Gm-Features: AZwV_QiiYnttMQMqjip9saNwFanukpyE_OCMLPfNAZ_pJl8fE-izRc73RaKpSCs
Message-ID: <CAP_z_CjZWFqyKAti_NLtq7QhiJfwVXhohakQh2yEFS_vLsb4zw@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:23=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> Blake, did I explain that correctly?

Yep Steve, your explanation sounds correct to me. If there was a way
of storing a non-constant amount of metadata in something like
task-local storage, I would have a solution.

What I'm hearing from Andrii is that fixing this is my problem - that
"user stack traces can generally be taken synchronously from arbitrary
places in the kernel" should be thought of as an implementation
detail, not an interface. To me, this seems like an example of
https://www.hyrumslaw.com/ - this has been reliably possible for
decades (modulo paged-out text, which again is probably not
performance-relevant), and so I do think of it as an interface. When
I'm making interface-breaking (or even "interface"-breaking) changes,
I view it as my responsibility to try to help out consumers that are
broken by it.

So again, I'd love to get some ideas for how I can make this profiler
work under SFrames while still aggregating data in the kernel. I
strongly suspect that mine is not the only profiler that will be
broken by this change.

Blake
