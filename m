Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A034BA42
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728642; cv=none; b=ZfNOgDgHvm1oUCHgAQqo/UPdY92yGb9edZySVOymcc0pWI5aF9Ql0g8O6m/jg2VHNqI/YpALOYYXkS9lWVRFQQcGm7X1ZVZ+xI/kOCTQhyspy58rolyLe9NfE+obo6vqMJTu72hzT2grZP8EEkXEsCgcWELWf8/Rn03JbSqgOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728642; c=relaxed/simple;
	bh=ZdB3m2iSuqfb77BpI4QLn9scPAGC3lo/vOo7T39FJUE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=It5/vQe1aeFE+ISxVmvt5CnQ4v8JLfx69UQoTefaygWYT2AbEMp9TRFpzt49bV9nWkpXbDTLf7jxBIWV0k2iriWGHLP8hIiUo9WySzGouhPwk/HjXaKS6o4IkkAEquK2kgPK/s3X0RLQHrGmKAd1NSICCizvVfFhWPm99/ktz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW3RB99Y; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW3RB99Y"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso15343485e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728639; x=1785333439; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=go5jgVDGTFBmuogaeDe5LrDifuMcupZu3FGvDho6cOc=;
        b=AW3RB99Y2m6Juj28tnhWBvJvmA2nbhMSYh76JmW00JCom1pBmoDmthrKkRTzcqTnYl
         5M2USjsbVhN8WUXq7ljnSPBLSBsLiwus9j0EmXkxScwNhsUr/LkAt5HExtIGRKBjwdTI
         grZMxtDEpbejMSP69eH30Qahi8whccOJWAY4bGgTDnJHRaAMkkqTJgV9Std2yr0SKiFY
         UzrjwKIGZmIvwPw2hsykGfMhl0jFwa0edc2uze8yZjLpKiGuTGSW+Beprn5Gqu/csXG0
         vhKMkWucoPIC3r5YlywZunAK3f0pNZKTx8cvD2TcMNPuoP4Tprg1lCI0ZeK1DHtW605c
         RGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728639; x=1785333439;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=go5jgVDGTFBmuogaeDe5LrDifuMcupZu3FGvDho6cOc=;
        b=IRww38oLYgNexDvbu/zZTc6yKz26U1qpUe7XHqFcHzl5fIsxPs3EbopPGcle+/RvKS
         XK+pMf7lSsq/Tv8enB6l24vqgErCnDdf8mzPeErqBx9WuaDtCVbxQA8oq4wOL7By8fln
         34iuTZCV6l6UfQnUGpgrln/kYu4gRJp1XgP5NB2qDhwMP916YFHeoUdHEhO2hne6Kh2+
         87FtD6cN2bKbMEbVzzhkHfe9H4+++llwHcbj+OC6z0L7fdGQpMKAhpi9MFWy6s+vGPW6
         6831Jqi3KUTScUQyLzIlGww+5hODAwZqRFEr3CELEtgT0DUnLrVhIngez4wyrebyglnv
         mdcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSdinYadYLhpSZkdOD1IRMWiPLiTE1e8f1MKCtZObHN+XrcvnDLHNDKBCDW2aS8Louzto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+mKjS2U5TKLIKk/m/OHJATllTh1CYVzEtp2psa8F4zCGhGJo
	UgziCwQopN7QCo15nau1Y4wVZws74HObtHDmzQPhiV8fzAf4kwkpS0V0rUz/XrM7
X-Gm-Gg: AR+sD10/x/DjnUm3cGW9KcuaiNVhYrhjbhwSLWQJ/nP5uzSXtobY2wzl8mzskLFSC9J
	Yv2VBESc1p8xt5aYIwDQ5RU542BlvMyt6DIA1F6AAcDPFIwM4ITSLCo9DkkGy6pjugEW1ndI7Eb
	BDGee2Rrw+QAPEpVggtp7qtx+R04OiFnR3aqYI+ZJPF0kuNEotglYxqRsGb/SrS7z771ZrA6R0O
	NKMLlFKIRajbyaFX3w9sZbBi0e3YeOykXfs1HuJyQuZ5rDelTMjYDHPIoth/4mDL778pVPzDnuW
	O06/hQ7VGdbaLIO10nHKP7UcSU2DiMDHXWB5uYvoBXLKUbWFWMgHjO8qvffvvP4CCEm/OehWqP+
	6t0eLeThGlquJb4BaErluA10nz7vBc2FS1OmF5DwIy9CEDKjr2JWizcVQfNdyANrmYTML84NXix
	T+J8Z8GXIoUx5H3u68/uot+tsnYPgjZIJZre0TN64W0yb9JZMBLt/UzM66A0Tew5jFQWiUbW6qc
	KRBzLShvWxcReCSOqNYIU1yox4ddyY7aT3wU3ewgEiH
X-Received: by 2002:a05:600c:e558:20b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-4955cda5441mr119195205e9.16.1784728638473;
        Wed, 22 Jul 2026 06:57:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b4e8885sm44307355e9.0.2026.07.22.06.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 15:57:17 +0200
Message-Id: <DK55I184SHNJ.37QBB1WKDWOEZ@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Inline the numeric open-coded
 iterator kfuncs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260722132424.450230-1-puranjay@kernel.org>
In-Reply-To: <20260722132424.450230-1-puranjay@kernel.org>

On Wed Jul 22, 2026 at 3:24 PM CEST, Puranjay Mohan wrote:
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

I find some of this explanation unsatisfying. How was this determined? Is t=
his
just your hypothesis, or did you actually observe different counters in per=
f
state to corroborate this on arm64? I am no arm64 expert, so perhaps it doe=
s not
do a bunch of things (store-load forwarding and memory disambiguation) that
would help here, but it would still be good to understand why.

It would also be interesting to compare against can_loop. Adding it as a
comparison and finding the result should be easy. Can you check what the
overhead is in that case?

All that said, I am still fine with all this, bpf_for() being costly has be=
en a
known fact forever.

>
> bpf_loop() is shown for reference only; it is a different construct (a
> callback invoked per iteration), so the comparison is structural rather
> than a measure of the inlining: on x86-64 bpf_for() is faster than
> bpf_loop() even before inlining, while on arm64 bpf_loop() is faster
> because bpf_for()'s per-iteration cost is dominated by the stack round-tr=
ip
> through the iterator state.
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

