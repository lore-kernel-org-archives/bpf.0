Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BB36F909
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256156; cv=pass; b=mPdV1mBQiMsFfAJkf8D0iQIvM6wxv97a3P7YoGICTyG+P/t9dqQhVcNPMmM/OGYouLtDAZmur/Mhl2+HOs/PLo7g8UHYJTtGeUtqNxtummJWtv6jnZpkSjuUDEpKLti5pcej9p3dcVLo2kwK01+Psu/P4DBd1dPkEsn+PTWFpYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256156; c=relaxed/simple;
	bh=Z9sdy9+gwb4RrHGdYXRrIJuauxb2fnA/Ox//oXa7BBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDDpCEvFqQTRl786AYmKbCXWu2APQwSPfYpjbOLqyspiPD8uiIeCX5wWwIxm9P7HVhi5+vyu/8o4yOsIONOfQwXOpc6b3VsfwUzsyeomGHRTHw/YYbKHIr0zioQ0zDcqR37qa+NDNYTIX7e3UkVQLBiWthKgzb1Pc8oaA3uiBjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQUSS92n; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQUSS92n"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848595b338cso53930b3a.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 09:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785256155; cv=none;
        d=google.com; s=arc-20260327;
        b=N4/2BMbROnQuCtVRH4m13soT2RPAjW2Ci4OjUZLKmDW2XrliRzaz7r6q2UPDSeoxXy
         uz9qoj0mfTJAnAhKWWkOdJLEWGIyvA3paj25bKBpzLvzBBheBtuJk0Y2WNnCTQTW825y
         1TWDiGuud5aO2/7G6dnBDeudDtZcNujGpfIrogSc+NWY0VxRohqPXWb3upyplit9qflM
         ZIkJ8o7w8RVTYK6FqVxM1WZqeBfugIrPfthu7Pn204jKJUcm6NXzqqN9CEd5aRxp0ZQ+
         TzLKyp+1ncovdknlQjXhuEhvGQhQQnTM0Qac0IXr1s8FyESwKaf7WaElyTrwqAccI+HI
         QjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=22+OmFCDDQyr02gs0H+a4Et+SaMtgh8q2OInR+UENmM=;
        fh=ZmvZ87wBqU2D/XiluKCRR5eDUm/MsPoiiE2WgA1xUNw=;
        b=dnvqtc5Hc0rL5KhMruYqlhzrojgTyupqHvjyXofukRKkctAKuFMpTJpzLyXZf80YFr
         tN0rSWhFyxhcGZz7SucIR9JiU0ZvsUOhFh1ZbVYvKOwmijSYxy0IbG4VguX50iXu1Cb9
         9XKFeomR6PzAk5lBzoy8NppgeIlQQql6KtaYtNRfoMOJ/AhxaxisPuKcrPqucAHbTRPs
         rFmx+80/CdlL6z2h2+N57NY589qhmetrG8DzYVeNQD06SmbIqx5VwmFmg1W50zaVHtI2
         GD/eZnHFjv86WHO933JISMyg2Q5YYFiAGDbeaiyPfphnQR3WyJFfU1Byu7bNjV32f7ef
         ZCJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785256155; x=1785860955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=22+OmFCDDQyr02gs0H+a4Et+SaMtgh8q2OInR+UENmM=;
        b=cQUSS92n7HMB8vXP1ZICEsn+e5edE7dKQf80fZu51Oh1YUbclUjRlkajGkd//L98qS
         3lNsJNdNbx58Kc0VVssI6Y55m9ZBBd7Ic43D/9UwYFjTnBseI0PF/VotQI/tELiZWsOh
         M+3AOJTVjCVwM7U6EVrco5bOW4jVjnEFXqf0pCOreTtCngROxAhwmX2grdHzFfMTasFu
         w0dUMMVZTALz9q6SKB8TRGf7B48PtISsuQ4IaJpqL3Y2YHSPL4lI77m1l3ZFR0VFSIQF
         L7ArbwTUfpDN5TzV6PjLBs/8UQ+R4OiE4oV6CFnm5ge4hPPwywcYlZ39IUiQwhORGW7r
         w+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256155; x=1785860955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22+OmFCDDQyr02gs0H+a4Et+SaMtgh8q2OInR+UENmM=;
        b=OtdTVmQ22BhGiUWabQ/fSSjozXOKd7tlpzuyWPzDqUCWzUPsMEhEBktcwEJtE5T8yj
         04GaIVPaDcO5HYpOb66BUPTzlCkk9rdJ40nir7jrxeOGQsBKyfNLBUsGfpduSwtfASin
         Tsfiwxl/fsdYpjzZKO0g3zvpD9ctagLyGnNKjq5+AwcvX3kfG3TDh/jWAe0pPE+ouj0I
         kK07yBpXM7eDgC5/tZSO/jc+mA4GdpLePXW2Dy4YRC37XF5KUMrm3ycgnYDV11YCqN9M
         /i7f3OaIbFER9Fq4YgqKEE1SLLd4e8kx8n5d/gKhWo7Cahrh3ZVUgrI4c5+8QsaKN00S
         yv2A==
X-Forwarded-Encrypted: i=1; AHgh+RrWnRuFiyZbR35dTROahqRL4FP/98DmJ5ZQCIa1WaKAos91d6uoXJeWFpe7Gviib8/G1S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgSBjnVEov8A2fz6nb57V4LcHJDPQuWrpXWajSPG9uA0oa2jHA
	nN/EEdTuamH1PCSW90BX/gt8xsObu5f+mmp67M0vYx9wRieqw4MtXE7k9Au8IBSDaGgYVthj8gg
	RYF5Gez0ty69SULdZ+2cy4IX8PZcxM58=
X-Gm-Gg: AR+sD115yARg95IPNML+FdZ22rO/Yb5Gxfo0+uY/EbVvsupqu/T9BTOHBfLQgLyWLxB
	2jfUmx9uHH6pTb00DI6fVOLdvJGIdVXx8l+LZcAsE+J38XFbB6Wc1fWACzLAV+Cz1ak+wYx7Fcp
	/B6yebL8EVGaaE5HtGcfzoxm5AnP3uSYvcG7s8J2elwv4KD8v3FclMyhCi+PYNohXT9SPfo3ICg
	LufMe/SNqvOf2PAri2Sm8GYUxb+ozAM7QOUglDCM5bx/tVtdqklPFw/xstUqXeWamzDGAfFT2kv
	ZtjO9t+ETETTLLGwlfVdm7/YQOxv4FR6tEUl5Vfg0X3DFYspHrEksul20gqVLzJJaHMJkA==
X-Received: by 2002:a05:6a00:cc6:b0:848:4c0c:59b4 with SMTP id
 d2e1a72fcca58-84e9337cdfbmr3401779b3a.64.1785256154498; Tue, 28 Jul 2026
 09:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <CAEf4BzZkJrOZX8AWmk4AmGZvo1Dd7F6UraU1DFa16SiEEQiPFA@mail.gmail.com>
 <CANk7y0gekFOEO2WffS1Ms8_n7G73QxRmykVVxp903bCkT0N-iQ@mail.gmail.com> <DKABWUUIQ4RA.JP5SHXL2VMXA@gmail.com>
In-Reply-To: <DKABWUUIQ4RA.JP5SHXL2VMXA@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Jul 2026 09:29:01 -0700
X-Gm-Features: AUfX_mzx8oY4pvdPHMWYYNN7mKsUi9oEKWe1E0LmJHde7zWB8op8V66SyDMcyNE
Message-ID: <CAEf4BzYL1NykSg1-A8+EAKVmn-MGwvstLaSmguCxP_AHtx8thQ@mail.gmail.com>
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

On Tue, Jul 28, 2026 at 9:02=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue Jul 28, 2026 at 5:59 PM CEST, Puranjay Mohan wrote:
> > On Tue, Jul 28, 2026 at 4:56=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
> >> >
> >> > The bpf_for(i, start, end) macro is BPF's open-coded numeric iterato=
r. It
> >> > expands into calls to three kfuncs: bpf_iter_num_new() to set the it=
erator
> >> > up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy=
() to
> >> > tear it down. The verifier emits these as ordinary kfunc calls, so a
> >> > bpf_for() loop pays function-call overhead on setup, teardown, and =
=E2=80=94 most
> >> > importantly =E2=80=94 on every single iteration via bpf_iter_num_nex=
t().
> >> >
> >> > All three kfuncs are tiny and only touch the 8-byte on-stack iterato=
r state
> >> > (struct bpf_iter_num_kern { int cur; int end; }). That makes them go=
od
> >> > candidates for inlining, the same way several other special kfuncs a=
re
> >> > already open-coded in bpf_fixup_kfunc_call(). This series replaces e=
ach of
> >> > the three calls with an equivalent inline BPF instruction sequence:
> >> >
> >> >   - bpf_iter_num_new(): the (s64)end - (s64)start overflow check is =
done
> >> >     with 32-bit arithmetic (start <=3D end is checked first, so the =
range
> >> >     fits in a u32), avoiding cpuv4 sign-extension insns that some JI=
Ts do
> >> >     not implement. Returns the same -EINVAL / -E2BIG / 0 as the kfun=
c.
> >> >
> >> >   - bpf_iter_num_next(): the hot path. Since cur and end are int, th=
e
> >> >     kfunc's (s64)(s->cur + 1) >=3D s->end test reduces to a signed 3=
2-bit
> >> >     comparison of (s->cur + 1) against s->end, so the inlined code u=
ses a
> >> >     32-bit compare with no sign extension.
> >> >
> >> >   - bpf_iter_num_destroy(): a single 8-byte store zeroing the state.
> >>
> >> tbh, I don't think we need to do *anything* in bpf_iter_num_destroy(),
> >> not sure why I added that zeroing out there. that stack slot will not
> >> be treated as iterator state after destroy() is called, so what is
> >> stored there doesn't matter, we can simplify (unless I'm missing
> >> something non-obvious, but I can't see it)
> >>
> >> >
> >> > bpf_for() is frequently used with constant bounds; in that case the =
range
> >> > checks in bpf_iter_num_new() are decidable at verification time, so =
a
> >> > follow-up patch elides them and emits only the iterator init (or the=
 error
> >> > result). The inlined shapes are pinned by new __xlated selftests, an=
d a
> >> > bench_bpf_for benchmark (modeled on the existing bpf_loop benchmark)=
 runs a
> >> > bpf_for() loop with an empty body to measure the per-iteration cost.
> >> >
> >> > The emitted instructions are plain BPF and remain valid for the
> >> > interpreter, so interpreter fallback stays correct and no jit_requir=
ed
> >> > marking is needed.
> >> >
> >> > Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):
> >> >
> >> >     +--------+---------------------+---------------------+----------=
-----------+
> >> >     |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf_for=
 inlined   |
> >> >     +--------+---------------------+---------------------+----------=
-----------+
> >> >     | x86-64 | 2946 M/s (0.339 ns) | 4281 M/s (0.234 ns) | 8981 M/s =
(0.111 ns) |
> >> >     +--------+---------------------+---------------------+----------=
-----------+
> >> >     | arm64  |  618 M/s (1.619 ns) |  543 M/s (1.843 ns) |  538 M/s =
(1.858 ns) |
> >> >     +--------+---------------------+---------------------+----------=
-----------+
> >> >
> >> > On x86-64, removing the per-iteration call to bpf_iter_num_next() ro=
ughly
> >> > doubles bpf_for() throughput. On arm64 it is neutral: the loop is bo=
und by
> >> > the load/store dependency chain on the on-stack iterator state rathe=
r than
> >> > by call overhead, so inlining neither helps nor hurts there. It stil=
l
> >> > removes the calls.
> >>
> >> exactly, and those removed calls should be noticeable in such
> >> microbenchmark... also, bpf_loop being faster than bpf_for() is a big
> >> surprise. let's dive deeper into this, this makes no sense
> >
> > Yes, I will do more perf testing before posting the next version.
> >
> >> > bpf_loop() is shown for reference only; it is a different construct =
(a
> >> > callback invoked per iteration), so the comparison is structural rat=
her
> >> > than a measure of the inlining: on x86-64 bpf_for() is faster than
> >> > bpf_loop() even before inlining, while on arm64 bpf_loop() is faster
> >> > because bpf_for()'s per-iteration cost is dominated by the stack rou=
nd-trip
> >> > through the iterator state.
> >>
> >> hm, again, I'm not sure I'm buying this. bpf_loop() does indirect
> >> function call, stack access can't be more expensive than that, can
> >> it?..
> >
> > No, the above explanation given by me is not accurate, it was my
> > theory but it didn't hold up when I looked into perf reports. So, I
> > need to dive deeper into this.
>
> It might also be worth comparing cases where verifier does inline and doe=
s not
> inline bpf_loop, the latter can often be the common case for some program=
s, and
> may help appreciate the improvement more.

we actively discourage bpf_loop() in favor of bpf_for() or may_goto
approach, so let's not invest in (complicating verifier for the
benefit of) optimizing bpf_loop()
