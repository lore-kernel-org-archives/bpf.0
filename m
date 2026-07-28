Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AB33F36D
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254530; cv=none; b=aDzGupEDGSr6FQwu0rJuGo0U6MMD/JDe/Ep7m1yzyOiKtzQO5hTQEa2/BdWRXMOHapuFbOXrZAzdAXqciHqqRUWNTqmQdJ7aETIuRrYaJz1CgBednb9t6fLEuDbjcLk3YrP5KY2ms8HmnBZL1AsMYOwi5s85HLFP6xnylJ6dmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254530; c=relaxed/simple;
	bh=+luckX9WEHFVRzTgzAt3gNEt1mksyPs1HeEIUTUBjHU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Sc6vJGYlPAhhuEg4HPAbQZK3fzZAI53JRiyJ5soM1inFlmaVpV27GnRS9KemN89MQeIstrqEA4uNJkTlSHjE3zhCSR2FAy1laKhZnRcuvqFI6DJxQ9W1KL4rrBVMkRyoLfRafDhAFtNJzbBVR2RDmy3m7cSICtY9CcjI8+GYTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7sLBdqM; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7sLBdqM"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-46e747fbf36so14646f8f.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785254526; x=1785859326; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Vyk4eCHoyNu3OG6PHy6DSqIUfVxZGI8mgkop4sotRE=;
        b=h7sLBdqM0f3PIdzbP8j4pE4MP2KM2/Ryq7bFI8tXE2NSXMV4skmkduddhUJzEl1XYw
         6863tonyTwS2fwfhEIO5hEVBN853wnkx5IX5yF5FesAeZc2IYUpvv9HVMQ2TFiW1EpXt
         tTKGk0xreI9LwV44rkM+mueZW0j2t+iQDcMwxmTm+OrQbn6ehy/XEkoeE58dvmMXtl9Y
         qOckWFQl/IqyvrZ7ommjjooPMw2KygQR0jIkx9vFXW70ztWB2iN/Gom7rgUCE/GFSeTg
         +55bayMMlgKTTJnH3rovKdrRa6ow04yEfK4A3F0KRY1bvegvvapVejeC4OcTnpOume/G
         TFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254526; x=1785859326;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Vyk4eCHoyNu3OG6PHy6DSqIUfVxZGI8mgkop4sotRE=;
        b=PP7KXjgHHj0OAfOiATV9XrtrkoqMc1jPRZVye+8Wt+DiMSwRuUC8s2FBy0lqG17Sfn
         Q8b1+lNV1ZSk+dvFrDFrDSFsKoSBCeeJ5PPq6uSUpQyqq4eSOyzK/CrKhZHTnvAhKR//
         prTx1hVN9bIx/q0Elog5Fsc1boveQFkrp10A8pjt+aqL70jv9AxstlAYeNqG3JfbCjj5
         jFsYHuT4Rta4DDyN+3tHCEaxuZpwdEn444piqxqt9K7646XR8k/HFrT1xFCzQJhzzhNP
         vSAWXixpqxM7iwtYC3hAhmheDrU34f1leIKjKAcsh4DybaHQGfEgQvuR6IongNLHG/VH
         YvNA==
X-Gm-Message-State: AOJu0YwPnUpXEr+o4HX7bUeQKRNG/sJJdFxYXTo4zN11NLK6csINehcM
	nIR/MfarXwhqzL+AnAwp+SKtTCQz2x2U5JmbW7aCe4wGNQf8bGBsK2dw
X-Gm-Gg: AR+sD11At+cvierNsp0jrgPMJf/NoVW6WNufwnpuJkl8pEea/voRNIDRdtU1pfVQcT6
	CDJlL196vY8qyOfuiy7n+0kMBLDfB3RfRES6QwfX66VG11eal/6gIVs23AY3dsoT+2IAz+lB7zK
	F/eP1XaBWosUwsvgbqTKVZyCZuV+18Y+kuO1XWsm1JSSACYlaBwhvNg2LzU5El01xCTPP388uxE
	BhrBYD+u/pCVR/Swkx+XWLRz+1jyw7DLXv3u5MbvH2gyqhLE08dxHna80SqdwMkIBDvsPblVbjO
	RClnEx7CY4PivM/iGrQDaTMHFAUhYCDcSHzXLbXGwYgnZ6KUwwqnWX5vNbZh3baKRg6f8n6Y5Yh
	x7fXeI3ABpjcJZZAKJ0Iz+2zOW3wjdstATbXmFCt6vXN2sjUkxYl6cM0N4/LWJskRrAq/ScpBUh
	behtYrMT8NsIT058a1toAWs2zrt0Vp5nyBhp1/um+4J4X2ujFWSupT4fhdf4njxOZ72rz4bAh+7
	Eof5g+Em1rnSHpbINVI0/xk+3vpzA2wc3FL6dOOcqt/
X-Received: by 2002:a05:6000:70b:b0:474:cd60:1154 with SMTP id ffacd0b85a97d-47fb1f21bf7mr3075622f8f.41.1785254526232;
        Tue, 28 Jul 2026 09:02:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3935sm226861f8f.4.2026.07.28.09.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 18:02:05 +0200
Message-Id: <DKABWUUIQ4RA.JP5SHXL2VMXA@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Inline the numeric open-coded
 iterator kfuncs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Puranjay Mohan" <puranjay12@gmail.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260722132424.450230-1-puranjay@kernel.org>
 <CAEf4BzZkJrOZX8AWmk4AmGZvo1Dd7F6UraU1DFa16SiEEQiPFA@mail.gmail.com>
 <CANk7y0gekFOEO2WffS1Ms8_n7G73QxRmykVVxp903bCkT0N-iQ@mail.gmail.com>
In-Reply-To: <CANk7y0gekFOEO2WffS1Ms8_n7G73QxRmykVVxp903bCkT0N-iQ@mail.gmail.com>

On Tue Jul 28, 2026 at 5:59 PM CEST, Puranjay Mohan wrote:
> On Tue, Jul 28, 2026 at 4:56=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
>> >
>> > The bpf_for(i, start, end) macro is BPF's open-coded numeric iterator.=
 It
>> > expands into calls to three kfuncs: bpf_iter_num_new() to set the iter=
ator
>> > up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy()=
 to
>> > tear it down. The verifier emits these as ordinary kfunc calls, so a
>> > bpf_for() loop pays function-call overhead on setup, teardown, and =E2=
=80=94 most
>> > importantly =E2=80=94 on every single iteration via bpf_iter_num_next(=
).
>> >
>> > All three kfuncs are tiny and only touch the 8-byte on-stack iterator =
state
>> > (struct bpf_iter_num_kern { int cur; int end; }). That makes them good
>> > candidates for inlining, the same way several other special kfuncs are
>> > already open-coded in bpf_fixup_kfunc_call(). This series replaces eac=
h of
>> > the three calls with an equivalent inline BPF instruction sequence:
>> >
>> >   - bpf_iter_num_new(): the (s64)end - (s64)start overflow check is do=
ne
>> >     with 32-bit arithmetic (start <=3D end is checked first, so the ra=
nge
>> >     fits in a u32), avoiding cpuv4 sign-extension insns that some JITs=
 do
>> >     not implement. Returns the same -EINVAL / -E2BIG / 0 as the kfunc.
>> >
>> >   - bpf_iter_num_next(): the hot path. Since cur and end are int, the
>> >     kfunc's (s64)(s->cur + 1) >=3D s->end test reduces to a signed 32-=
bit
>> >     comparison of (s->cur + 1) against s->end, so the inlined code use=
s a
>> >     32-bit compare with no sign extension.
>> >
>> >   - bpf_iter_num_destroy(): a single 8-byte store zeroing the state.
>>
>> tbh, I don't think we need to do *anything* in bpf_iter_num_destroy(),
>> not sure why I added that zeroing out there. that stack slot will not
>> be treated as iterator state after destroy() is called, so what is
>> stored there doesn't matter, we can simplify (unless I'm missing
>> something non-obvious, but I can't see it)
>>
>> >
>> > bpf_for() is frequently used with constant bounds; in that case the ra=
nge
>> > checks in bpf_iter_num_new() are decidable at verification time, so a
>> > follow-up patch elides them and emits only the iterator init (or the e=
rror
>> > result). The inlined shapes are pinned by new __xlated selftests, and =
a
>> > bench_bpf_for benchmark (modeled on the existing bpf_loop benchmark) r=
uns a
>> > bpf_for() loop with an empty body to measure the per-iteration cost.
>> >
>> > The emitted instructions are plain BPF and remain valid for the
>> > interpreter, so interpreter fallback stays correct and no jit_required
>> > marking is needed.
>> >
>> > Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):
>> >
>> >     +--------+---------------------+---------------------+------------=
---------+
>> >     |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf_for i=
nlined   |
>> >     +--------+---------------------+---------------------+------------=
---------+
>> >     | x86-64 | 2946 M/s (0.339 ns) | 4281 M/s (0.234 ns) | 8981 M/s (0=
.111 ns) |
>> >     +--------+---------------------+---------------------+------------=
---------+
>> >     | arm64  |  618 M/s (1.619 ns) |  543 M/s (1.843 ns) |  538 M/s (1=
.858 ns) |
>> >     +--------+---------------------+---------------------+------------=
---------+
>> >
>> > On x86-64, removing the per-iteration call to bpf_iter_num_next() roug=
hly
>> > doubles bpf_for() throughput. On arm64 it is neutral: the loop is boun=
d by
>> > the load/store dependency chain on the on-stack iterator state rather =
than
>> > by call overhead, so inlining neither helps nor hurts there. It still
>> > removes the calls.
>>
>> exactly, and those removed calls should be noticeable in such
>> microbenchmark... also, bpf_loop being faster than bpf_for() is a big
>> surprise. let's dive deeper into this, this makes no sense
>
> Yes, I will do more perf testing before posting the next version.
>
>> > bpf_loop() is shown for reference only; it is a different construct (a
>> > callback invoked per iteration), so the comparison is structural rathe=
r
>> > than a measure of the inlining: on x86-64 bpf_for() is faster than
>> > bpf_loop() even before inlining, while on arm64 bpf_loop() is faster
>> > because bpf_for()'s per-iteration cost is dominated by the stack round=
-trip
>> > through the iterator state.
>>
>> hm, again, I'm not sure I'm buying this. bpf_loop() does indirect
>> function call, stack access can't be more expensive than that, can
>> it?..
>
> No, the above explanation given by me is not accurate, it was my
> theory but it didn't hold up when I looked into perf reports. So, I
> need to dive deeper into this.

It might also be worth comparing cases where verifier does inline and does =
not
inline bpf_loop, the latter can often be the common case for some programs,=
 and
may help appreciate the improvement more.
