Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE403264E3
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792287116; cv=none; b=A9zVzoMjtTu+LhbSBzuoGhw19VGMU4oNvqG7XiL/xxCS6i5HY+zMPgBPX/DgeePBQF7htH0BxAQXb4JgKtjsslCUuS0OI2Eso3lHL25GMrVygTwq5BiBa/LyXKXDEXwSL6AKpFj7Xegs2+bDnRSdB7hVNzSd2WZ22vdQfotR6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792287116; c=relaxed/simple;
	bh=oNxfzgBbURzMQCkEJGIbH3FK2W54Yoben1PWrgJX+Hw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UTyMeavjAizg6whmk24znG1KQXkug7iianqf5zvkY+y3yKZY+8sg4W2Y5NbhgP8bkyMXPksQJJDddd4gyms3lKZN4nT7dLFcHTKHEhxudYJ4iqedXpIB/scKprHwZolrPt4u+t6tvwNjHvy1z8lpZWAXXdci+u+gJBPP2Y6zN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSjq6Al3; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSjq6Al3"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so555074fac.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792287112; x=1792891912; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k47nu5m9Hj6wDMcttMxyoS4UrO2/vXLq+4Q9kvyeEKg=;
        b=SSjq6Al3sLhgFtnXr7LXFBJnduF6r5Q+2EihKMxcJVuHsnzmQTHh16Ygd66tiskZLb
         sgRSG9gno6GzwACWFEgztWmUAp0T+r6LcYRRCKu4cxQScwbQKG1n1Tey65COrrkYvHII
         tw1bLXORuEb9EAbCcIL0gn/vvkQzvr+xOj8uIf/eNEyKOnxqNINjVUsvuDmDYNK+KUdc
         H2rK2tID0KlhNhoblY+5RPSxR7U0y4QT8dX0N05LgInNyP/FXQhFFpqc4tPfy4njVbkx
         frdQ+sud2MQt/5XglB2MLBC2rKKu+06l3NrR8xPpfAgUqAzOGpAcD9QAHdyAf9guqX0N
         AETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792287112; x=1792891912;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k47nu5m9Hj6wDMcttMxyoS4UrO2/vXLq+4Q9kvyeEKg=;
        b=XCpAMNmV1C6jpeU377NhK/3YZ8BGg2/FMaNFp1Y0bNJoOiRZ71tWR/8f2hpFyPYJr8
         OXA5dcODs1datardYtIS9SFKcioYuS6ueIWmoafcm+ZKiSbsBIwFt0D7jAKa+GVG+pkQ
         3e6mCVdgu/F2lY6Uz12+ICapswtfwRMxLKab8kO7MZVSafjW9tKN7RWLwtxh3TdGylKA
         lTT/DJ5RB137ehwNX+4EmGeYIJYs9OvwtIRuLbwzCmn1yYup0OrkEYee4fz+YOV8bium
         zZHPPfsm8px8SaXrB0CzueLGVfzyrKjo+dLerv1OHfBC9mJ/SWptBod5vt3nibeRScK+
         EIfg==
X-Forwarded-Encrypted: i=1; AKwUvBx/P94blEkTAYV8EHnmGGhdSf37CAhoohXrTOJurfiwjxNPDan9PO8+tKnIdGysZKV9rMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFVf/c67brzYwbJxdB1B5zU5GkZMuxh0Cb9r6QsBCHHiVOumoT
	nrQvmh3hs/mq89lVVYFxVpw+wDVb8RMAXn/J7jh1fSkxs5lufqzZAdwHhzYoW4iSeGc=
X-Gm-Gg: AYBFou3sZJ37c+ipy49K6zbNHoBS3Xk6Co9jlP2xzkqiu9lzt6yWT6Dsp8hs2zyMEbH
	lAMVhKGlK2Xo9ofka7Oc3/yajeuMQ7VbVOXM4tHLLt96yTnQRP/2oowcD4ST2nlsx+AmbOz7syA
	2gvKChrNwdY3HbPrrrWCUC8a29WnDiJeVusJV16U3QNDKRnV22FBd3exMLwa2tqqC62ILUmh64z
	sgC9jwOPiYKVJaH1Jc6Vggep7KcTYAM7xbzxlaF094HXZzM2CdHFX0IvChp9zfHYGLH6ho6GUQW
	3bVloAPZ2u02FIkHFlsCvE6NRR91R9douX9LPJqoHZd5ebBmFcIQn1/FOs74MvkG+vKJGBh9KkS
	qC7pOAtTkEY0SduEmtY8GLRxIhcgj/b/ez7RNahUyePRcG7yMPPrS9vEIlhRYapku10tkhy6ecz
	wwAhZC8AIL6bUQNXplG6ahQH2yil0ZOk56i2rYx/25R34SNxXgLe3NZhCJdHvLZyeYE1rodJt2x
	4f8wvhYCifB4WIgVG0+jZWPPnGWXz5TKSXzN2bRpvPa8jpGgkbwQ9YAyqfhMQh8GpYWiVIEqRoD
	WDqLGv31xU9geo4A
X-Received: by 2002:a05:6870:8112:b0:4a2:4d67:5977 with SMTP id 586e51a60fabf-4a7578ad1a5mr3251055fac.18.1792287112186;
        Sat, 17 Oct 2026 18:31:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b2dc362sm5628335fac.2.2026.10.17.18.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 18:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 03:31:49 +0200
Message-Id: <DM7KR7J8VY2T.1CZIRUF6QRCWG@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Unwinding via r3
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>

On Sun Oct 18, 2026 at 3:02 AM CEST, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@anthropic.com>
>
> This is the r3 alternative from the discussion of v12 of Yonghong's serie=
s
> [1] as patches, with x86-64 and arm64 JITs and selftests.
>
> 1. What is the problem?
>
> A rust panic or a C++ exception has to run Drop impls or destructors of
> every frame it passes through. bpf_throw() discards the frames, so the
> verifier doesn't let a frame that owns a lock or a reference throw. In ru=
st
> every index and every unwrap() can panic.
>
> 2. Is it worth solving?
>
> Without it rust-bpf [2] drops all landing pads and a panic is bpf_throw()=
.
> A prog that can panic with a guard held doesn't load.
>
> 3. Is there a simpler way?
>
> [1] keeps the normal path free of unwind code. llvm emits a table, libbpf
> passes it to the kernel, bpf_unwind() walks the stack and rewrites return
> addresses, and the verifier models hidden edges from calls to pads. That'=
s
> 1400 lines in the kernel, with new uapi and two kfuncs, and 440 lines in
> libbpf.
>
> Here llvm emits plain insns [3]:
>
>   ret                            r3 =3D 0; exit
>   invoke foo unwind pad          call foo; if r3 !=3D 0 goto pad
>   resume                         r0 =3D 0; r3 =3D 1; exit
>
> Pads are ordinary code, so the verifier part is 96 lines in patch 1.
> The price is a branch after a call that may unwind. Patches 2 and 3 take =
it
> off the normal path in the JITs without telling the verifier. 360 lines
> with them.
>
> 4. Will the api and the layers last?
>
> No uapi, no kfuncs, no changes in libbpf and other loaders.
> r3 and BTF decl_tag "unwind" become an ABI between llvm and the kernel.
> The source level entry point is _Unwind_RaiseException() of the Itanium
> ABI. It's what the runtimes of rust and C++ call on other architectures.
>
> 5. Is it good taste?
>
> Every frame returns through its own epilogue. The only question is where =
it
> returns to. That's one bit.
>
> It's not specific to rust. A C++ prog with throw, catch and destructors
> compiles, loads and runs. It's a selftest in patch 5.
>
> Since the sketches in [1]:
> - bpf_unwind() is gone. _Unwind_RaiseException() starts an unwind.
> - llvm applies the convention to functions with uwtable only, so C progs
>   are not affected.
> - JITs opt in. A JIT that loses r3 would skip a pad.
> - A subprog with the tag has to exit with a scalar in r3.
> - A callback that doesn't set r3 was hitting verifier_bug().
> - The extable lookup is search_bpf_extables().
> - 'Functions end with exit' was not quite right. A function can still end
>   with a call of a noreturn function that cannot unwind, like bpf_throw()=
.
>   rust-bpf adds 'exit' after it.
>
> Tested in qemu only, x86-64 and arm64 with and without pointer
> authentication: the selftests, C, C++ and rust progs built with [3],
> with and without bpf_jit_harden=3D2. test_progs was run on x86-64. On arm=
64
> the same objects were loaded and run by a small loader, and __jited
> patterns were matched against the JIT output by a script.
>
> [1] https://lore.kernel.org/bpf/20261017025129.1914859-1-yonghong.song@li=
nux.dev/
> [2] https://github.com/4ast/rust-bpf
> [3] https://github.com/llvm/llvm-project/pull/233140
>
> Alexei Starovoitov (5):
>   bpf: Support unwinding via r3
>   bpf, x86: Replace 'if r3 !=3D 0 goto pad' after a call with an extable
>     entry
>   bpf, arm64: Support unwinding via r3
>   selftests/bpf: Add tests for unwinding via r3
>   selftests/bpf: Add a C++ prog with exceptions
>
>  arch/arm64/net/bpf_jit.h                      |   2 +
>  arch/arm64/net/bpf_jit_comp.c                 | 110 +++
>  arch/x86/net/bpf_jit_comp.c                   | 107 ++-
>  include/linux/bpf.h                           |   1 +
>  include/linux/bpf_verifier.h                  |   5 +-
>  include/linux/filter.h                        |  11 +
>  kernel/bpf/backtrack.c                        |  10 +-
>  kernel/bpf/core.c                             |  53 ++
>  kernel/bpf/fixups.c                           |   1 +
>  kernel/bpf/liveness.c                         |   7 +-
>  kernel/bpf/verifier.c                         |  66 +-
>  tools/testing/selftests/bpf/Makefile.skel     |  11 +
>  .../selftests/bpf/prog_tests/unwind_attach.c  |  67 ++
>  .../selftests/bpf/prog_tests/unwind_cxx.c     |  76 ++
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/unwind_attach.c       |  32 +
>  .../selftests/bpf/progs/unwind_cxx.cpp        | 117 +++
>  .../selftests/bpf/progs/verifier_unwind.c     | 759 ++++++++++++++++++
>  18 files changed, 1427 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.=
c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
>  create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/unwind_cxx.cpp
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c
>
>
> base-commit: c058636f788f8751e419b407206516280226e568

Overall this makes sense, I guess my one small nit is that since we've
crossed the bridge on changing the compiler, we could just use a
cleaner encoding of some new instruction, but that is a matter of
preference, it would be slightly more explicit and cleaner. Claude
suggests "BPF_JMP | BPF_JCOND with a new value in imm" with the
following benefits:
 - The verifier treats it exactly as JNE r3, 0, so no new verifier
   semantics.
 - The JIT elides it by opcode, with no lookahead and no shape test.
 - Blinding never touches it, since JCOND carries no blindable
   constant, so the blinding fallback disappears.
 - The kernel can require that it directly follow a call and not be a
   jump target, and reject otherwise, which makes elision
   unconditional rather than best-effort.
 - Dumps show the intent, which also matters when someone reads an
   xlated program.
If we encode unwind exit as another jcond variant to replace
resume/raise_exception then you can get rid of the decl tag as well
and just compute it from the subprog body while we walk all
instructions.

Concretely, two imm values in JCOND next to may_goto, and the whole
convention in the object becomes:

  in the object                     meaning
  --------------------------------  ----------------------------------
  unwind_goto pad  (after a call)   if the callee unwound, go to pad
  unwind_exit                       leave this frame unwinding, r0 =3D 0
  exit                              return normally
