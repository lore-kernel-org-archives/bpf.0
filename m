Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB627F749
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772914679; cv=pass; b=C3IIadel7etQeNuqPfU43Sv+7Oz0MMk7twSnJJaIF4iR1LtRaW1DEg+O33zGSM2cLK9qR+SpIE4x+OmKlCFZwOJDfyYbF/aCgq2+152doPflyxtAPidi+dINqCX7zKvA6Cqr5SDuStNwc/mvRqeC+xH92gud+BJJMh1L0RhBylw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772914679; c=relaxed/simple;
	bh=G8oHe11o7E4i6+klKx+pUiuGOYSKstjLg721v3r1c1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBA632ktVK6LxHVr62o65K2qQ+tQHQfZiy6Qe2j0qV48U+kZli33V6onuXwXR4FhETDpyWnXbdcroM4TtNirjm/JOgwBqldjTN7I+fc6yZR291BgorfOZeSqi1hqscZy6KwTXE4+GUFIERjGS2G/KMCh0ePx4d9K4Y/FFLxFIHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LosA7rAv; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LosA7rAv"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-480706554beso113650665e9.1
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 12:17:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772914676; cv=none;
        d=google.com; s=arc-20240605;
        b=DB3RoIFSWNma7elvQV5Lq1TFa9r4MpVtcBhI0BAHBxvs7kXzw/Ts0RexTY7+qHhl0I
         0yqSzi0Lyp4XNMKoa3RTVd5OEhlKv8EEEOZCSbOdqRdRFwgubjLFuJvtMY9GBCg4h1x3
         ySo/e9wmuRfpTHIxOBRF3PlBH/ZjWq+QiM3nZJwEyIMFk7t1gJ+bTYADjNOIhZ7zMp7v
         tRvjJJtCxdS831NGdXgHYO6U2HJ/oGBP3gPfxMQbBGUBbNHlU0VXS7S8/HJRpByyh3jH
         +96QouOSvfpikqeLR0Eg0/ZhrWwzU96nsthW6PuaC6d/0Iv9mpjc0GWoMGJ/PcC+Jf2k
         WY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jq5p5NfVotedgkLDqzJ82lY4xvBEFKzG6N/ovoN+MgI=;
        fh=awGC5hgyf/3Fqw1GyT2tfEbGENLJLOKg7KOD+00Vpqc=;
        b=OPYgJkrVOB3U9APPHh9/fWLadAvfTiTiWblcdPuuYwiXuXkEmcFIL2YNljdzpTjNhG
         RX0vpzDgRIjuwrYkFpqD7RCsEEm7lniakNsFlaxtkM6QFcReZw/4XQt9/XzqYtUqgJEk
         MBxonGH6vg9RDRTHB6ASli+JAzOH/rXijb3zU9ubUCzaivD/j4NLikgZy8BOIIdQb049
         4MJ7+D12omm+2dqlTJWdkFvl82Ri8Enx/Tti1XtjC6+W1ePd9QHGVWcMmqwwZQPxLxp7
         wV9HoZ7v+YUdaCGBgxjjc+tiZXqUrliU9pUU/drTRt+xuwSJuMB7inp/oS2p0oHMew5H
         WuuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772914676; x=1773519476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq5p5NfVotedgkLDqzJ82lY4xvBEFKzG6N/ovoN+MgI=;
        b=LosA7rAvYAdu4VQQyhQPwr6anHti6kugtI5Dd47E+VJUiARD42G+GeCh+BrhKfvi6V
         ohMl9BfadM9k3hZWuRqQr+n6z0RpeOwDk0KJk+F93bAf50YKOWUqv35ROCyyxJJQo0df
         14TrDFX7WB0eg9D7Y1EyVmbarNsOapsX40NjziUJPPYm5PePDWlDSuUO1i6JeMAnBtSB
         hI9M2XMIQo9NEr5hlH/PaAVmsMmz6DSE1oBiDoLJad4Crdv2HJXRu092u0GztRrOYURC
         r8ZQb54A8TbKHa/rtA4NcpguWKdqYu0YQvIVS+UlmkVfn62E6okKas9ITPP1L/uDConK
         IfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772914676; x=1773519476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jq5p5NfVotedgkLDqzJ82lY4xvBEFKzG6N/ovoN+MgI=;
        b=iX7133nuYnwgxqgwDDx035cdi9q104NQGN6OWoY+WmkOlhu5vrMaQeshY2f/CIFysw
         QgtUnmINAnTJTUCK2016iY6JQCluqzkhTnZjNM67yeBw4agoeoDVo3Z7S0OaaG/TPQnS
         ijzoRemayiuAe2fB5t7gdzDz55BuzxK+mcJan2egysAdHCyeIWMzmNk+O/UfDEfTcKtf
         FxmEkCNfYxe5B7i7YOtJl6HEQ/YXnjop37TwGnYlzgVv0Ps6oSQCdF2amwXfvmvudSDc
         OGIekPNeT9j8CnUbO+2BqcjruB4b+/jPHhotVcMa0RmdFqQkanMxUXqbZFdkTmG1Alz1
         fywQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5hLn+kNS79YEYz6O9Xj1k1MXMsSr7JYty8btDEriZeycVLnlYfbZhLlZ/C3Wp+1Gu+SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFXZMu9TRIpySMkTZVgeQoTlmLBCm60Tv0iCmLEKjr58p86W7
	WW5340Q1kex96OSS7pnmZ2kw37M++yoI59dh5OxVSGBGKIXM+vQ6C7j6FaR82nO8dMuzAhjbbDz
	1E7izCX25/ox6O0YWD5HkFdwnATku80A=
X-Gm-Gg: ATEYQzw8ryYaAmAr2HS5lXLf9lD4nFNT+RYpAx2EWg5JNOuDSjhq5+jST4jM5Vash61
	XD0Hpq7mM4qS+y45hFhUUEQKUJQ04Zgz42b5804K2x5j9/vKzt6dIDE/JnRG1ETZNzIXVs6Ng8i
	V7ikGzR1wRyRBj1276cvhpEW4k49DgO7EQW1LgC8667GHpv6OEt90CABAWmXu7Ec4RN1uG51ESM
	e/P5ZJvyjCwXYm3YYsefb0MPtkqaU+quKXq7YgwyuYbmK2UfvH3/S38aDfDq950KvQZQshxx41L
	PPfYayCNUEdA9xnz+dnjuUtbF/Jv7yJp3T9YFs6QQp5twCk2RRuVAND2FRT0
X-Received: by 2002:a05:600c:1382:b0:485:3423:727d with SMTP id
 5b1f17b1804b1-48534237536mr18923775e9.26.1772914676037; Sat, 07 Mar 2026
 12:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225210820.177674-1-wusamuel@google.com> <CAG2Kctp1q1QtB1-JT2cgBsYu-WceV1YdSM1sSwNm8pyGtZQ6TA@mail.gmail.com>
 <CAP01T776Ni9R6CT_phx5wNDUoN13Tztz3DD5ZgKWedNLx7Nb0g@mail.gmail.com>
In-Reply-To: <CAP01T776Ni9R6CT_phx5wNDUoN13Tztz3DD5ZgKWedNLx7Nb0g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 7 Mar 2026 21:17:20 +0100
X-Gm-Features: AaiRm51GVKV1mIPHG0sQJgsGJh5rD_lPQu5OaU3TbtUpLcBgOcxHNzYP75Q8oQo
Message-ID: <CAP01T77EZDLhjwtZBSt+DXLG-ftHfows-p_6FgXZQDQGowcDtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/2] Add wakeup_source iterators
To: Samuel Wu <wusamuel@google.com>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Mar 2026 at 00:28, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Thu, 5 Mar 2026 at 02:31, Samuel Wu <wusamuel@google.com> wrote:
> >
> > On Wed, Feb 25, 2026 at 1:08=E2=80=AFPM Samuel Wu <wusamuel@google.com>=
 wrote:
> > >
> > > This patch series introduces BPF iterators for wakeup_source, enablin=
g
> > > BPF programs to efficiently traverse a device's wakeup sources.
> > >
> > > Currently, inspecting wakeup sources typically involves reading inter=
faces
> > > like /sys/class/wakeup/* or debugfs. The repeated syscalls to query t=
he
> > > sysfs nodes is inefficient, as there can be hundreds of wakeup_source=
s, and
> > > each wakeup source have multiple stats, with one sysfs node per stat.
> > > debugfs is unstable and insecure.
> > >
> > > The iterators utilize pre-existing wakeup_sources_walk_* functions to
> > > traverse over the SRCU that backs the list of wakeup_sources.
> > >
> > > Changes in v5:
> > >  - Add CORE definitions for *__local variables to fix s390 build per =
bpf-ci
> > >  - v4 link: https://lore.kernel.org/all/20260211235055.239024-1-wusam=
uel@google.com/
> > >
> > > Changes in v4:
> > >  - Proper init of variables in ws_iter_check_sleep_times() test per b=
pf-ci
> > >  - Remove PM patch since it's already part of rebase
> > >  - v3 link: https://lore.kernel.org/all/20260124012133.2451708-1-wusa=
muel@google.com/
> > >
> > > Changes in v3:
> > >  - Update wakeup_sources_walk_start() to handle an empty list per bpf=
-ci
> > >  - Simplify read of a struct's field in BPF program selftest per Andr=
ii
> > >  - Drop open coded iterators for wakeup_sources
> > >  - Fix condition from !get_ws_iter_stream to get_ws_iter_stream in se=
lftest
> > >  - Read event_count instead of wakeup_count in selftest
> > >  - v2 link: https://lore.kernel.org/all/20260108225523.3268383-1-wusa=
muel@google.com/
> > >
> > > Changes in v2:
> > >  - Guard BPF Makefile with CONFIG_PM_SLEEP to fix build errors
> > >  - Update copyright from 2025 to 2026
> > >  - v1 link: https://lore.kernel.org/all/20251204025003.3162056-1-wusa=
muel@google.com/
> > >
> > >
> > > Samuel Wu (2):
> > >   bpf: Add wakeup_source iterator
> > >   selftests/bpf: Add tests for wakeup_sources
> > >
> > >  kernel/bpf/Makefile                           |   3 +
> > >  kernel/bpf/wakeup_source_iter.c               | 103 ++++++
> > >  tools/testing/selftests/bpf/config            |   1 +
> > >  .../bpf/prog_tests/wakeup_source_iter.c       | 300 ++++++++++++++++=
++
> > >  .../selftests/bpf/progs/wakeup_source_iter.c  |  80 +++++
> > >  5 files changed, 487 insertions(+)
> > >  create mode 100644 kernel/bpf/wakeup_source_iter.c
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_sou=
rce_iter.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_i=
ter.c
> > >
> > > --
> > > 2.53.0.473.g4a7958ca14-goog
> > >
> >
> > Hi Andrii, any thoughts on this patchset? I've addressed your
> > suggestion from v2 of this patchset regarding selftest, but nothing
> > fundamental has changed since then.
>
> I think it's still unclear why this cannot be achieved by exploring
> what Andrii proposed initially in [0], i.e. by using existing
> primitives and adding extra kfuncs where necessary to solve
> bottlenecks, and I didn't see any indication where it was explored
> sufficiently.
>
> I think all we need is the wakeup source read_lock()/unlock() APIs as
> KF_ACQUIRE/KF_RELEASE kfuncs. Just need to ensure we pair each lock
> with unlock by passing the index, which can be an opaque value
> returned from the kfunc (e.g. dummy empty struct pointer encoding the
> index). Then you can use bpf_for() to open-code the list iteration.

I had a longer discussion with Paul on this. When having multiple open
SRCU sections, mixing nested calls doesn't flatten the protection
scopes and leads to all kinds of issues, an example of which is in
[0]. That said, in this case, the verifier isn't tracking what the
underlying SRCU section protects or isn't even aware of it, all it
needs to ensure is that section is closed eventually, out-of-order
unlocks are ok, it would just exist to allow looking at the list in a
stable fashion using safe bpf_core_cast() accesses.

So, I just wanted to clarify why I think this should be perfectly ok.

  [0]: https://www.kernel.org/pub/linux/kernel/people/paulmck/Answers/RCU/S=
RCUhoha.html

(if you are like me, please follow the link at the bottom of [0]
before feeling good about understanding the example).

> The iterator would become unnecessary, and everything can be done from
> a syscall program's BPF_PROG_RUN invocation. I didn't
> check how we can get the pointer to the wakeup_sources LIST_HEAD, but
> you could try several options (__ksym,
> bpf_kallsyms_lookup_name+bpf_core_cast and then walk it, or return
> pointer from a new kfunc and walk it using bpf_for()+bpf_core_cast()).
>
> Also, how much speed up does this really provide? It is hard to
> understand the motivation from the current cover letter. Is the
> bottleneck due to opening multiple files in sysfs? You will still have
> to read text and parse text from the iterator's output in your current
> solution. Wouldn't it be faster if you just used a syscall program,
> and used binary output (using a ring buffer) to stream data to user
> space?
>
>   [0]: https://lore.kernel.org/all/CAEf4BzZv9kCAmX0Fo4kR8qh9mu5NB-wLDmNAK=
_R=3DVzcxL7VPpQ@mail.gmail.com/
>
> >
> > Thanks!
> > Sam
> >
