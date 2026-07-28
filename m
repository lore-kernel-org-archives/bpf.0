Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1637E5CF
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256487; cv=pass; b=XuYxneqqF4jwm51vNPs1x5ZNxQf/rR22tkgfXPMuaMDgk/fAgngZkOPUiXxCrV4oLseTL3FgRQXbzwNEEhnS/Y+mjS2sLntS7U1/HieGArEdrwPL+ZuIgGYWI3D0nuVYv3pVKFBJJGQ+yZ8BuJiMGxQYmltjeWnK/k/l4AIEi5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256487; c=relaxed/simple;
	bh=ZZJ9QIag/3gAcMWUWDaNjsju+j0gSfAckFYq/iyfY5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8dDpzGhq1vLOT7ASX2UJ3nZ0xnPiZACLoW8DYzQuAoCt8wCsdWDCeULIhkiMEHfqL9FA6k9uSSkaYk0wb0Cq1d2oE6uk8C/hfkQftyByJs1Z+IhWCFEyYSmiE2jjDozbeizYWB8qMcc+0S3Fy3sx8pcdlZP/0f0W5SC6Vhz6z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pb0xAliE; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb0xAliE"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e04df8c46so37850b3a.2
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 09:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785256485; cv=none;
        d=google.com; s=arc-20260327;
        b=SEysv1mv0Na90jbHY/f4MlRF1qhGh43gHLqSgC2F0HMa/YEAAXMLEwdXx69lvrPfYS
         i0uolZWTgncqG8v8BqJAEJPrMSwpCQQEsVLsgy2ghKjChWYbYmNkIl48XOB3huyYZVw1
         XhkWHpD1KsIEUWGfL0lPAz5/+qBdcF/GLks6ASfWTNnkco/2Mr5cA1FGZobZicSHEz4h
         xd8G4REqCQsMW7DwMaL8JJ/01NH34+CotMP4jcqrqGDpM2smNY379gSnFaeVghkFqHHY
         YS0CbZv3q0VJgBW8JTNAuzfsmLRn9p/FlEotMac/a1Gv7oiFVD5I3jLMXq1/Fu6f1JUE
         a19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LCxxQn3jjtSo95XE7+aYxPfpJHDf7Cwr3szolk81BPo=;
        fh=N+yBtD9ZYZhwbkISiMTEUV6M0QKOs/k/Np1BLg3CNl8=;
        b=LgHO4ZSaayc7IBztUYumOJhGKfMZThirEDTU0IwWc52a+3wYFjFbtjm9GpeYKFPbrg
         SwHC6kNMYNuHJlLCkdINhQWy6XDICopD5Xz1Uyt71XiWRu7Eo8UUVycUhK4l3/OfYDON
         S7sks4kL9ZTX4mGcoTHR/pslCErJFVKa8bRwssL1w2edpu3s/vwL8tWP3aO5FMn/ur8K
         Ar965R2rRCRUjvhlwIsWK3+A2RJ8fmcXVNvYYhbneWZFzdC/uOs1xn45fjeW/wD7Egka
         7Y1AAH9dji1XPqX05VxVTip/Ar3feNLuzxepMJ9R36zqir8WpPoWq3MGe5gkg8YqAevN
         o/3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785256485; x=1785861285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LCxxQn3jjtSo95XE7+aYxPfpJHDf7Cwr3szolk81BPo=;
        b=pb0xAliEm7Te4BsLc8JfG3KQGA423QW45DAQMKOwe2sja4z/f5Er/3epWEQwgRcGJ3
         6qITM8hkvl1kq4YnVz4/lTOpqrzE3cRQGJ95QFt8UC9NoCV1JHlVFYLlROFvVdKC5LeI
         jgbVlGqlw1K/3nLnn7A64CooWW11KoEg/jxjbaE+uxhtYkzEm+HmnVg9JsOAN68hIwlO
         6jdoQYPus/uU/9x178MQpOLBAwT8fE7+mpbbAaXfEBgJRJcGoM+Fb8EFmnMmTbQ+yysc
         Y6y2tezokhWKOwmg4Btg3lvsaqKIFExgV4cho4+vEclZH0cRkBNKs0d/XjCnbsx2w5Pp
         gyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256485; x=1785861285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCxxQn3jjtSo95XE7+aYxPfpJHDf7Cwr3szolk81BPo=;
        b=QafUyVmlozI0HdFOC8Hdx9TAu9Q1Q67o9Z3LpIT3u78bxgKoeL5LiNGT0WODwSP3z/
         vZ/gUfDLgpTTA+fxBaaqs/pZUXceJVdXuRIPCRM719yCtP7B4KmLLDZq1uIosmGWEwgB
         0oHdzrlXrxFw0yWXYDufvrbMj4xMcuPl1b4PkSEnDpFyND6fEmEJPU6WOUJAurOrd4T+
         1hxtNJFkcNDBYX6LefWiVjmsEnZGTMpxIlRp0ubJXMxdoL7i9qPa/6DpCuXOSDA2KcbR
         n71ZTRcsKtQxwrouzwLCR66nBf4gQzJOn4VNfc9omqM6k4ey05hzDIcd2rEyY5N8Ra/y
         FnVg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8e5zxrvrEuPp4cSmSi6Wa4vxzRKmRViPXq5PfnFneShsju5MlhcLIeaxKe2mBuuIF4is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcupgfeETg5W3yQ1NbNdebQ7Ne9Acs5MZWAYAgZ4nRRFzkQ0P
	kZETqgCnSTscOhirH9YdB1VTk65Kttgs6gWEF4O6fhRU4s5rv8lUU1i2qbQSHyz+X5EuiNissHk
	3MeyhYca0kgUb13TSJCKPxD8d0N3aC12IdFdD
X-Gm-Gg: AR+sD13ahACgGxJ656yLkCrqsPCnmZvSvECAbOONmY1CopfYMMB/g0xk0y1bcVfItwF
	JiWCa1DuZGpoAlWoKCjHrKDZbOwVs3eYI5COtVGsyw+TJDBjRTykBXpXmld/ktvEMfZHL+SAzkX
	PYhUc+R6SqVL16BynDrDjogGfcwpU321i/19e6XyzwQws8aIAZSjTvA5o32mtW/h+qY/sp15CWq
	2rt/8kmIcOwtF8wB24u7EVxd4sSY7gDqctP20Moxs1fVJmvEXvrP1b/hpDwKhmRyFnXQZxewHUG
	ulbR5/MB2K0AX7VYmndz0ljoq+DmfomTNO4XtO6qnNdEvBiY9yNByZ7ZbmU=
X-Received: by 2002:a05:6a00:804:b0:848:2f77:e2d7 with SMTP id
 d2e1a72fcca58-84e9336c856mr3390214b3a.64.1785256484810; Tue, 28 Jul 2026
 09:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <CAEf4BzZkJrOZX8AWmk4AmGZvo1Dd7F6UraU1DFa16SiEEQiPFA@mail.gmail.com>
 <CANk7y0gekFOEO2WffS1Ms8_n7G73QxRmykVVxp903bCkT0N-iQ@mail.gmail.com>
 <DKABWUUIQ4RA.JP5SHXL2VMXA@gmail.com> <CAEf4BzYL1NykSg1-A8+EAKVmn-MGwvstLaSmguCxP_AHtx8thQ@mail.gmail.com>
 <CAP01T762eHApzPZwnBCKNfBQxhdumcD68Bozc5W07Hx4j2GO8g@mail.gmail.com>
In-Reply-To: <CAP01T762eHApzPZwnBCKNfBQxhdumcD68Bozc5W07Hx4j2GO8g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Jul 2026 09:34:30 -0700
X-Gm-Features: AUfX_myPE5BpBa4nL3HlB1Hp6-TQmlAuaMQYnk1wLpjIpLro_k6_AeDIwj_Mr7I
Message-ID: <CAEf4BzaziRB7tLrOuhekhGhg_ZRfeLkEXbTZioMfBzjKx7NOqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Inline the numeric open-coded
 iterator kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:33=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 28 Jul 2026 at 18:29, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Tue, Jul 28, 2026 at 9:02=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue Jul 28, 2026 at 5:59 PM CEST, Puranjay Mohan wrote:
> > > > On Tue, Jul 28, 2026 at 4:56=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > >>
> > > >> On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@k=
ernel.org> wrote:
> > > >> >
> > > >> > The bpf_for(i, start, end) macro is BPF's open-coded numeric ite=
rator. It
> > > >> > expands into calls to three kfuncs: bpf_iter_num_new() to set th=
e iterator
> > > >> > up, bpf_iter_num_next() once per iteration, and bpf_iter_num_des=
troy() to
> > > >> > tear it down. The verifier emits these as ordinary kfunc calls, =
so a
> > > >> > bpf_for() loop pays function-call overhead on setup, teardown, a=
nd =E2=80=94 most
> > > >> > importantly =E2=80=94 on every single iteration via bpf_iter_num=
_next().
> > > >> >
> > > >> > All three kfuncs are tiny and only touch the 8-byte on-stack ite=
rator state
> > > >> > (struct bpf_iter_num_kern { int cur; int end; }). That makes the=
m good
> > > >> > candidates for inlining, the same way several other special kfun=
cs are
> > > >> > already open-coded in bpf_fixup_kfunc_call(). This series replac=
es each of
> > > >> > the three calls with an equivalent inline BPF instruction sequen=
ce:
> > > >> >
> > > >> >   - bpf_iter_num_new(): the (s64)end - (s64)start overflow check=
 is done
> > > >> >     with 32-bit arithmetic (start <=3D end is checked first, so =
the range
> > > >> >     fits in a u32), avoiding cpuv4 sign-extension insns that som=
e JITs do
> > > >> >     not implement. Returns the same -EINVAL / -E2BIG / 0 as the =
kfunc.
> > > >> >
> > > >> >   - bpf_iter_num_next(): the hot path. Since cur and end are int=
, the
> > > >> >     kfunc's (s64)(s->cur + 1) >=3D s->end test reduces to a sign=
ed 32-bit
> > > >> >     comparison of (s->cur + 1) against s->end, so the inlined co=
de uses a
> > > >> >     32-bit compare with no sign extension.
> > > >> >
> > > >> >   - bpf_iter_num_destroy(): a single 8-byte store zeroing the st=
ate.
> > > >>
> > > >> tbh, I don't think we need to do *anything* in bpf_iter_num_destro=
y(),
> > > >> not sure why I added that zeroing out there. that stack slot will =
not
> > > >> be treated as iterator state after destroy() is called, so what is
> > > >> stored there doesn't matter, we can simplify (unless I'm missing
> > > >> something non-obvious, but I can't see it)
> > > >>
> > > >> >
> > > >> > bpf_for() is frequently used with constant bounds; in that case =
the range
> > > >> > checks in bpf_iter_num_new() are decidable at verification time,=
 so a
> > > >> > follow-up patch elides them and emits only the iterator init (or=
 the error
> > > >> > result). The inlined shapes are pinned by new __xlated selftests=
, and a
> > > >> > bench_bpf_for benchmark (modeled on the existing bpf_loop benchm=
ark) runs a
> > > >> > bpf_for() loop with an empty body to measure the per-iteration c=
ost.
> > > >> >
> > > >> > The emitted instructions are plain BPF and remain valid for the
> > > >> > interpreter, so interpreter fallback stays correct and no jit_re=
quired
> > > >> > marking is needed.
> > > >> >
> > > >> > Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):
> > > >> >
> > > >> >     +--------+---------------------+---------------------+------=
---------------+
> > > >> >     |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf=
_for inlined   |
> > > >> >     +--------+---------------------+---------------------+------=
---------------+
> > > >> >     | x86-64 | 2946 M/s (0.339 ns) | 4281 M/s (0.234 ns) | 8981 =
M/s (0.111 ns) |
> > > >> >     +--------+---------------------+---------------------+------=
---------------+
> > > >> >     | arm64  |  618 M/s (1.619 ns) |  543 M/s (1.843 ns) |  538 =
M/s (1.858 ns) |
> > > >> >     +--------+---------------------+---------------------+------=
---------------+
> > > >> >
> > > >> > On x86-64, removing the per-iteration call to bpf_iter_num_next(=
) roughly
> > > >> > doubles bpf_for() throughput. On arm64 it is neutral: the loop i=
s bound by
> > > >> > the load/store dependency chain on the on-stack iterator state r=
ather than
> > > >> > by call overhead, so inlining neither helps nor hurts there. It =
still
> > > >> > removes the calls.
> > > >>
> > > >> exactly, and those removed calls should be noticeable in such
> > > >> microbenchmark... also, bpf_loop being faster than bpf_for() is a =
big
> > > >> surprise. let's dive deeper into this, this makes no sense
> > > >
> > > > Yes, I will do more perf testing before posting the next version.
> > > >
> > > >> > bpf_loop() is shown for reference only; it is a different constr=
uct (a
> > > >> > callback invoked per iteration), so the comparison is structural=
 rather
> > > >> > than a measure of the inlining: on x86-64 bpf_for() is faster th=
an
> > > >> > bpf_loop() even before inlining, while on arm64 bpf_loop() is fa=
ster
> > > >> > because bpf_for()'s per-iteration cost is dominated by the stack=
 round-trip
> > > >> > through the iterator state.
> > > >>
> > > >> hm, again, I'm not sure I'm buying this. bpf_loop() does indirect
> > > >> function call, stack access can't be more expensive than that, can
> > > >> it?..
> > > >
> > > > No, the above explanation given by me is not accurate, it was my
> > > > theory but it didn't hold up when I looked into perf reports. So, I
> > > > need to dive deeper into this.
> > >
> > > It might also be worth comparing cases where verifier does inline and=
 does not
> > > inline bpf_loop, the latter can often be the common case for some pro=
grams, and
> > > may help appreciate the improvement more.
> >
> > we actively discourage bpf_loop() in favor of bpf_for() or may_goto
> > approach, so let's not invest in (complicating verifier for the
> > benefit of) optimizing bpf_loop()
>
> It's not complicating the verifier, just comparing against bpf_loop in
> the benchmark where the loop count is not known to the verifier
> (probably 20 more lines in the BPF side to serve as a comparison
> point).

ah, my bad, I somehow read your statement as suggestion to improve
bpf_loop() inlining, sorry
