Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530214AD20
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134311; cv=pass; b=llzWqmWl1hAX6gyP6/PUDyb4hOfDHz9FVAuoJFrRdwQhXBnUbc7vwSTOVdBIT13k+jv4g0jSWSIX2T9k4caHHfY6JboXyR6gGL6HaavooxmDmigjoR6ZewzIPcGflLbFpRRfewNhSuHKDhM7/2bL7MZD3k2lwaUE59X6+2haBLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134311; c=relaxed/simple;
	bh=UwRWY8WlifEVB4rrea8H3F15CcDnFu3ImTqOUY9A174=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVPXqLdbuR2S0ernmmNHA+6M8W8QPJz+RODalGHl1cP6XXpDQELOdqMyEdVibWheeruvFXsCBVyKNo4eTjRTcgsnCB/AA2pDvBMu+s8sVd1MB7Wfv3ww8r9rHhChLsZTtcqEIYxOTwXNGxjQtE1ujsTeOAhy4mB31ams28oZTZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmjlahDr; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmjlahDr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aeab6ff148so80065ad.1
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 16:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774134309; cv=none;
        d=google.com; s=arc-20240605;
        b=LCWYbCblQ8Y+J3bzB9tH9tu/h5OJ8pKHN7/oCQsUkR3O95OC1OPD83nYQOBLbbGPsZ
         XAN/zkJIx7iuArKTP7JlxeMA+5qubPdyubx5SgngkmY57BMCzd2TV6NS+dVsnRmtLpgN
         8czeTflD3Pyhsljefi/R25wvXPaDiqUHFj6Vrx2UV1pAXuRHMlMoSOjKm7qDiav/p5m8
         46CmqdlYUGj5G8r5ZHGmZGbc4/4kaA0pGIds+lXbcDUWacRKXEpUegeS07lXf8sJbYok
         aWwcFoAs08+1VlUrgOolcPSCrbjfznFKPsMgnytUfcDCyMTENzjvzHo8Pi6c2ppVarGv
         zUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pvXWNOEW/i6yBRC1SF4eHSDHKNtrEtqOBOAA5J40AbQ=;
        fh=U2fBpcz6PHDY/ZF0HJE3ccHYF5cQvOKlJAAlmEJdEzs=;
        b=e24x7xkGlQfcp+OlGb02nf2F0VWs9Sy+dTLR8ZBiGlV3r4wFkI1hQI/Su+n874nRS0
         OGrwdj2BGNAjlPB08QNBoUMyxL2khnksoytkjVtnTWdDScazSv1O2TaaHbnSuoV3HoVR
         McZ8Tjsl71Vu0sA4aJVi783SLBfoNDQDlVfmDQvaoG3II7hffU+FSWi1uUae/8vqkLEJ
         2sbRC88mE3MEnEG5E+3vRT7aV3dWTKXg6JBgJwvPeQwnh779vh5JF7tIoQq5t4UktULE
         cXB0ygt1cGxyFqWdUcJPJ3t8s62p+nddqpeswlgoyw08gNoamaE2AZYRkVEiE9+EA6G3
         vTmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774134309; x=1774739109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvXWNOEW/i6yBRC1SF4eHSDHKNtrEtqOBOAA5J40AbQ=;
        b=CmjlahDrCFsU3NOH9W2oiWTjrlRrRBirhNZ9b3wZsrNVSq0r+7ATDjc69IgLaGIWUK
         hTzlJk0rHc6THh0quw/ITeTZZqOAQ7zkft2PhMZ9jVul9F8TN7h/kBy/Ospa9HR6V43j
         pzifm3dx4m0l/d+WyS755bqVAoJZ8en1MlWt7JGp0H4RLTYH2cTt4UmrqfiHy7b69YRy
         ALZ9I26HPHS2SoF9xNaBwH1jrPyPbr32dGkYiWfCb9vwRA49L5IqXv4EBrw5LykU8Y33
         FGlX0C64CJeE5aGJOslrD94lFnCBPp+lllTJEORFODd8QsQg22X5C62cPUnviaYuS2tF
         +Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134309; x=1774739109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvXWNOEW/i6yBRC1SF4eHSDHKNtrEtqOBOAA5J40AbQ=;
        b=R8HMGAH4KdZ2mc8ng0ZurBCvJ2oT8v0P1eUkY4QKRI6GfgEJOG6rzzPGaGbqbhJ7we
         1v6OeJqaWakF5CQo55JeoalEn89myzHTMnU20tkZuT+jpRwuHA8P5enXMF9qM9JckjUO
         pWtw48mYN8PuNPFuqAtQFrhw3Aej9LJMOkQ/owKE/Z0vRde2mLmv5QU7DN7/6WdxzeIe
         p+CaRRZmCgQ/2KDjCwnvtUegy9TvG/ZlbFejFmIEpBNLyuhRlHxmZpXrZCq14enUQwSt
         f5YmRcmpQ7Yj62TfRoyQgY+NcACqpmzy5S0I1L7iYZ4oDtjZx7kdcAjsdsjEHuFYK+AN
         0L2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJii6hitI6Az/MTmnpsnOE8KKcOoHg3ZyFsD8L01ziK+nIAsfjuN7vlZw4+X6NOeQMjHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyMmltFLnQfaCV5DC7WkxcSEcQc6KqjW+UUhpwkV4RKiZmpAr
	qYbjFiSd5k7KVQUhycXuY+gHxmDtJa7IRy4oi0mJ3Qpn+qXaJL9qN1ortX0kA8d3g5hQBzGMTpJ
	UMljgp0StTHUQhPK2ym4tiZEjUAgYefAVUAQswSLX
X-Gm-Gg: ATEYQzzDxy9gQ/WN6AL4QAVDPLB8AhIBJvmJ/toj+jWypNndCw8HKIUUsg184Ak/FWM
	3JX+fzFk2nJIu9gEHQ0FwPAEO6rZWWhLn1cIPF76w7RHC3+sigoI7+ojdX/6jtOIf74QR+Fp0xL
	UTyGk5Uu1njRgxRBHNthUB7zIJ7Q6HcWeyebOB5Vj4VyfHwUQhdkii0GRl9eiIqXj1DaxSM4hty
	/Qfj6V8J7386pu5d9XSdVR5TdWjChfqtCbBs6XIFtQNgAK8bOa0hVz2m/Hv3SGZaHya/CHzNnGk
	1rUu6cnW
X-Received: by 2002:a17:903:1a27:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2b08c4990f3mr1638895ad.9.1774134308521; Sat, 21 Mar 2026
 16:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
 <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com> <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com>
In-Reply-To: <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 21 Mar 2026 16:04:57 -0700
X-Gm-Features: AaiRm52gbnQBWVlIQ5v4tgMEcNJKjU4ML7pBfqsVkt1j7XPP2DScTpH8oTgsPvU
Message-ID: <CAP-5=fXhuLE5R_t1A=+WLve3Wu9N999gXcG0KjEFGVBBh4+1=Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 12:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 21, 2026 at 10:37=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.dev> w=
rote:
> > >
> > >
> > >
> > > On 3/20/26 7:44 PM, Ian Rogers wrote:
> > > > The hashmap implementation contained strict aliasing violations.
> > > > Specifically, the hashmap_cast_ptr(p) macro was casting pointers (s=
uch
> > > > as void **) to long *, and these were subsequently dereferenced in
> > > > functions like hashmap_insert(), hashmap_find(), and hashmap_delete=
().
> > > >
> > > > C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> > > > through an lvalue of an incompatible type. Dereferencing a long * t=
o
> > > > write to a void * object is a violation, even if they share the sam=
e
> > > > size, as they are not compatible types. This can lead to undefined
> > > > behavior, especially with aggressive compiler optimizations.
> > >
> > > Potentially this could be a concern. Did you actually find an issue
> > > with it?
> > >
> > > The linux kernel build has
> > >     KBUILD_CFLAGS +=3D -fno-strict-aliasing
> > >
> > > The libbpf does not have this flag. Maybe we should add '-fno-strict-=
aliasing'
> > > for libbpf as well? This way, we can avoid any future potential
> > > 'strict aliasing' issues.
> > >
> > > Note that bpf program (tools/testing/selftests/bpf/Makefile)
> > > also has '-fno-strict-alaising' flag.
> > >
> >
> > The change itself looks correct to me, fwiw, but as Yonghong said, we
> > can add -fno-strict-aliasing to CFLAGS and move on. I also doubt the
> > compiler can cause issues here, since the usage happens in hashmap.c
> > which wouldn't be visible in other CUs where the call is made and
> > pointers are passed in (unless compilers also do aliasing-based opts
> > during LTO). I guess libbpf maintainers can decide what they prefer.
>
> Agree. I don't think compilers can misoptimize things here.
> It's safe to ignore this.

There's LTO support in the Linux tree for tools/perf with the LTO=3D1
option [1]. My experience is that it works best with clang and ldd.
libbpf is statically built into perf by default.

A sashiko review raised the issue when perf was reverting the addition
of -fno-strict-aliasing, the sashiko review is posted to LKML here:
https://lore.kernel.org/lkml/CAP-5=3DfVro6E6fowmmJ7gmKX-5SN8bFU7-5KJk_wFG-b=
QuVnMHw@mail.gmail.com/

-fno-strict-aliasing was added because some crypto code (copied from
the kernel) requires it for get/put_unaligned. The fix was to use
memcpy in the unaligned functions, which they now do [2].

I'd prefer not to hamstring the compiler with -fno-strict-aliasing, we
have sanitizers that can capture aliasing issues.

Thanks,
Ian

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/Makefile.config?h=3Dperf-tools-next#n279
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/vdso/unaligned.h


> pw-bot: cr
