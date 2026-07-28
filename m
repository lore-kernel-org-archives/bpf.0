Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C233A6F2
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254219; cv=pass; b=KSzssQ7rCdEv9txOLMZsooya8UW8xm2QloGCRtVLvIFFfmZwZ1ZX8TkBh+9V5aapQoqfDBbrCKSTumD0xEt8JHGi2gnRJisYgUchAjtrhdSJGIIHN1oCZksmho5idbetkvY71MXIgNJxp3eZKgcI/K6ImeYp/s58HOoNgKIXqzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254219; c=relaxed/simple;
	bh=FAjIij5Ojwi/9N+Se437AAU39d/A95W3gwD25RtCDas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trQjlwPRBoQ4QMx7xgz+H7lasGiHnmPZRCW1JX7jRv8peufyYUX8sILhb8T5pI6qsem373W2XKwu/DxTqIPwJnGzx0ihcVGmKvFvCGxzLemB5sblg7+WGWnrzmP5rgMxgLKM0d+7OKXE0fr1Bv2JWj0rkODayJBLXTMJ0gkEAQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nzih55wh; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzih55wh"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848595b338cso4500417b3a.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 08:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785254217; cv=none;
        d=google.com; s=arc-20260327;
        b=S+mTLeQD/tFpbT6xh/8YRwdBFfJi4d8QYyQ/AUQzkMeLIqZ16QI/5bCNEYCIxmtgm2
         olT8ncUyAdxkdy/lqVQPxVMvgqwwAlH86R+1VraSAR2NQQ5/in26BAl03FZHVRoa8swj
         R4KAPMn/fTq46v8n+mkhRQBLZjVYvJczplW/QGrQq/BtofGm91K4wELTOyB81t2lETGD
         jNhjxoWiDRSgCl2V50bhKwhr9Qi4JYeUbxwNsx9CrHp2m0xdORBMD4dz9CfTmC4ILFt/
         tXMRnfvUWlbGTtKdsxfayLs1glkv+rv7wb7EhfLrRZRmUYXguY/Pm3Dys40Z//jmX/bF
         05pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n9P6oywP2JL8p01luNe86al50qtDvBtTWyqs+Ss5kvM=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=iuJM+pSMEA+UayuR0zS56gusEzTKHxtIROOT8rgNgQgKlrK4V8qID5TRUcldJyyCX1
         DbwUEEXH8769yOheQ7irIkW19wadDRhmrdp0z8CguRV8grIt93T3j3gzVd4BPrSHheNY
         NR96wAwtBqdRjb9Y6DXzaH98rNTZGf+65u8DgUzJwBtwcnpTfhcv8RGuqKFT3wnVxSrn
         /hl2uMQ2IkvfEQyOhcwtCqNzua39kPByOnQa+szaT/iMc7uYR3mCLc/9HQrs2lQk8W4/
         gg78u42UYgJPl0yxODAg8SQb8J5MKdwHygU72EAwqafIRb0cwfw++pixdrl3s7R9EOKh
         9dNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785254217; x=1785859017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n9P6oywP2JL8p01luNe86al50qtDvBtTWyqs+Ss5kvM=;
        b=Nzih55whAjrAN1J13iq42W/NzMQbw8k4PEtr8gEvI18qdCUgyr58zv59PdTdRLUhEO
         23AjHODu+Bis8fDYuGajivY/S3+e/kETgemv908K0+8b4xHveBJz44kl2juZfxpscIcN
         i0Uj9PXV3e3ZfGIYRQY/5QEJivIc0SxYyIUx9ZTzQEMafkcwssH1VYorSQv2L6j0YVU7
         i7Ou+btaVWT95AQexfXYXrt4W+dR5jczKFyAfbLv/JX6+avyBqHgxEbYeVnhbu4J9UC7
         VM65MyMGHCOK0JUF7ve2eZfGpAEsEXs9qOTV97dqMIw7g5D3rhs5A6cKBvxM+x0qy+g4
         M78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254217; x=1785859017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n9P6oywP2JL8p01luNe86al50qtDvBtTWyqs+Ss5kvM=;
        b=rYA+xzwnUPp0A7Y/K41foWHxIeJDhUc4MAwpRknyJkahjkpGF5l5I5l52G+g60h6sd
         hcgOGULzAtO+Y+Tq4dKbMOa5+6vg06o6VTL1/QgRM4nVv0e4NcGmGvdqk/jNgkhFPfwe
         BF8Gz6ac9kk6cpR3MWTx58ZliqXnI69pW8Z/pe3NIGJBgoax99D267UOwEjxdXBnBuem
         /NtWnLsebkhaZnM4kNmMPbbqjbNvU6e50JuRQcADCH7Qbcm10saYw5zSfPbW7xvNYQ7c
         FANoQ9NhIpgG/PEtLbykGmZCi2SnTQUetISCl9Wmytlu2TdpR7uuxynY9T38t2juGz+C
         +SfQ==
X-Gm-Message-State: AOJu0YzG92VLQ6PHJ9F5aTgsdXegrI3kFsnD37toZiOGQVSHlIWGakl6
	qs7mN68zv+ltT8G6i6eQWSC3rLDdlZ26Edm8wOrCNiCkDr1TR6rSS7ZD0QvWvr2D1TMW/+JskLC
	Y2mTisaBmb4TWAgRYm5hHDGampP0DHMA=
X-Gm-Gg: AR+sD10Br37L9vtlcJXqGTHRSOMtREsMZ08DzfCgWR7QlMaCaPU8/rPItnfR6welbJo
	jIGw4/nerkzuYX6YABGFmsjtVJvw/29QEPNm5+xE48kJcrrnBnzvFfLm0CPju39upxRpzX2upMF
	K2WEYCeNVlq93xS2oxeb9GSh6j8gFeskDi0xoxBOa+GIrkm/P94G4ITUSeDEK2J8JRGz6bKTzmn
	A08Mua3EM1Kr4uvjw5hvsbQp0fKhlAa5+0vUbs9/rlTCZtaXpMmcxrfD3aW+BQQNB36OjWeCrln
	OKfHsIbUCekbTaacAhlhGA2mf0wqSeFrBUclPvCJHHROY6VjLd2W0LdhWdI=
X-Received: by 2002:a05:6a00:2a08:b0:846:2f3c:3f68 with SMTP id
 d2e1a72fcca58-84e933606b3mr3233046b3a.57.1785254216660; Tue, 28 Jul 2026
 08:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org>
In-Reply-To: <20260722132424.450230-1-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Jul 2026 08:56:44 -0700
X-Gm-Features: AUfX_mwDvR_q7LYHWJnXBT6f9EBnlyJIIJE5nKpattqMlcjV4y-lHgio_WXM0bM
Message-ID: <CAEf4BzZkJrOZX8AWmk4AmGZvo1Dd7F6UraU1DFa16SiEEQiPFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Inline the numeric open-coded
 iterator kfuncs
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> The bpf_for(i, start, end) macro is BPF's open-coded numeric iterator. It
> expands into calls to three kfuncs: bpf_iter_num_new() to set the iterato=
r
> up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy() to
> tear it down. The verifier emits these as ordinary kfunc calls, so a
> bpf_for() loop pays function-call overhead on setup, teardown, and =E2=80=
=94 most
> importantly =E2=80=94 on every single iteration via bpf_iter_num_next().
>
> All three kfuncs are tiny and only touch the 8-byte on-stack iterator sta=
te
> (struct bpf_iter_num_kern { int cur; int end; }). That makes them good
> candidates for inlining, the same way several other special kfuncs are
> already open-coded in bpf_fixup_kfunc_call(). This series replaces each o=
f
> the three calls with an equivalent inline BPF instruction sequence:
>
>   - bpf_iter_num_new(): the (s64)end - (s64)start overflow check is done
>     with 32-bit arithmetic (start <=3D end is checked first, so the range
>     fits in a u32), avoiding cpuv4 sign-extension insns that some JITs do
>     not implement. Returns the same -EINVAL / -E2BIG / 0 as the kfunc.
>
>   - bpf_iter_num_next(): the hot path. Since cur and end are int, the
>     kfunc's (s64)(s->cur + 1) >=3D s->end test reduces to a signed 32-bit
>     comparison of (s->cur + 1) against s->end, so the inlined code uses a
>     32-bit compare with no sign extension.
>
>   - bpf_iter_num_destroy(): a single 8-byte store zeroing the state.

tbh, I don't think we need to do *anything* in bpf_iter_num_destroy(),
not sure why I added that zeroing out there. that stack slot will not
be treated as iterator state after destroy() is called, so what is
stored there doesn't matter, we can simplify (unless I'm missing
something non-obvious, but I can't see it)

>
> bpf_for() is frequently used with constant bounds; in that case the range
> checks in bpf_iter_num_new() are decidable at verification time, so a
> follow-up patch elides them and emits only the iterator init (or the erro=
r
> result). The inlined shapes are pinned by new __xlated selftests, and a
> bench_bpf_for benchmark (modeled on the existing bpf_loop benchmark) runs=
 a
> bpf_for() loop with an empty body to measure the per-iteration cost.
>
> The emitted instructions are plain BPF and remain valid for the
> interpreter, so interpreter fallback stays correct and no jit_required
> marking is needed.
>
> Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):
>
>     +--------+---------------------+---------------------+---------------=
------+
>     |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf_for inli=
ned   |
>     +--------+---------------------+---------------------+---------------=
------+
>     | x86-64 | 2946 M/s (0.339 ns) | 4281 M/s (0.234 ns) | 8981 M/s (0.11=
1 ns) |
>     +--------+---------------------+---------------------+---------------=
------+
>     | arm64  |  618 M/s (1.619 ns) |  543 M/s (1.843 ns) |  538 M/s (1.85=
8 ns) |
>     +--------+---------------------+---------------------+---------------=
------+
>
> On x86-64, removing the per-iteration call to bpf_iter_num_next() roughly
> doubles bpf_for() throughput. On arm64 it is neutral: the loop is bound b=
y
> the load/store dependency chain on the on-stack iterator state rather tha=
n
> by call overhead, so inlining neither helps nor hurts there. It still
> removes the calls.

exactly, and those removed calls should be noticeable in such
microbenchmark... also, bpf_loop being faster than bpf_for() is a big
surprise. let's dive deeper into this, this makes no sense

>
> bpf_loop() is shown for reference only; it is a different construct (a
> callback invoked per iteration), so the comparison is structural rather
> than a measure of the inlining: on x86-64 bpf_for() is faster than
> bpf_loop() even before inlining, while on arm64 bpf_loop() is faster
> because bpf_for()'s per-iteration cost is dominated by the stack round-tr=
ip
> through the iterator state.

hm, again, I'm not sure I'm buying this. bpf_loop() does indirect
function call, stack access can't be more expensive than that, can
it?..



>
> Changelog:
> v2: https://lore.kernel.org/bpf/20260717120215.2171057-1-puranjay@kernel.=
org/
> Changes in v3:
> - Elide the range checks in bpf_iter_num_new() when start and end are
>   constant, marking the registers precise so paths reaching the call with
>   different constants are not pruned (Eduard Zingerman)
> - Add __xlated selftests pinning the inlined new()/next()/destroy() shape=
s
>   (Eduard Zingerman)
> - Use the insn_buf[i++] idiom in the inline helpers (Eduard Zingerman)
> - Pick up Acked-by on patch 3
>
> v1: https://lore.kernel.org/all/20260715130430.318421-1-puranjay@kernel.o=
rg/
> Changes in v2:
> - Don't emit sign-extending (movsx) moves; some JITs (e.g. x86-32, mips32=
,
>   sparc64) decode them as a plain move and would miscompile the range che=
ck
>
> Puranjay Mohan (6):
>   bpf: Inline bpf_iter_num_new() kfunc
>   bpf: Inline bpf_iter_num_next() kfunc
>   bpf: Inline bpf_iter_num_destroy() kfunc
>   bpf: Elide range checks when inlining bpf_iter_num_new() for constant
>     bounds
>   selftests/bpf: Verify inlined numeric iterator shape with __xlated
>   selftests/bpf: Add bpf_for() benchmark
>
>  include/linux/bpf_verifier.h                  |  13 ++
>  kernel/bpf/verifier.c                         | 157 ++++++++++++++++++
>  tools/testing/selftests/bpf/Makefile          |   2 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_bpf_for.c      | 104 ++++++++++++
>  .../selftests/bpf/benchs/run_bench_bpf_for.sh |  15 ++
>  .../selftests/bpf/progs/bpf_for_bench.c       |  32 ++++
>  tools/testing/selftests/bpf/progs/iters.c     | 145 ++++++++++++++++
>  8 files changed, 472 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_for.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_for.=
sh
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_for_bench.c
>
>
> base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b
> --
> 2.53.0-Meta
>
