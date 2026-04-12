Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2D25393B
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027757; cv=pass; b=cEreMiBfn+yxO7FJ0JyWTkIFh2cLTVNl1YHolNUIc8KmJRn5SXJuZOTmdMQQfKg3JCP2NqvTEnjz2vV+GsbwwpyF70xglGKcgfPKZ5j9SJZ/NCmGRLSPZp9jlJMzaQ66p51F8wWRWFniNlrYKNOX9acAXPivE8iJYuRXvkmcz6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027757; c=relaxed/simple;
	bh=UpGn+dLSSPdFQoqgFCwZC4/yOQBu7p+tyVcKAO/vaAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSMDLVaP6QkL2GIAA8FYOOZZ3aSYvbeartl8TxARcKgvnD1XJFXcJPm/uVUMZF+ZKXFi0j+Yfm3zdWxSUNV6T4EqGNj3Ojr921kd8CwFBKbaZyqcKwryc5UP4qmVWYzqbM6h4y0TBb3KQnOlzmPZu8RiewcV/NNkqku+zOO+/tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sm//m3dr; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm//m3dr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ba840146so35685385e9.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776027754; cv=none;
        d=google.com; s=arc-20240605;
        b=lMFhArIWkd14kC51dstYmsYYU8BoFE1Uv4tEwrDUJzSi/GxMT1jjKiiZCAmt7PCmUW
         d5ey5bGhiXkoKMCUcQuPSHh3PKhdhq9L5hfqB75S1WlqmO9Y4T5dFn9yCC160fU0vatp
         4A60EJw648bObjcZLBh0i/nVjvkhsNpGGzutDEmkhp+nZrgavjx+563nAOIZW9JS/yT1
         vA+d70nkARanbVpXU6o19UA+fljB3nvN6OpkzksEsW2g1HnpKnEH/VsU/Z1snpbcBZCV
         yth3oSyB0aGoxEBNyqx6U3mMIpullaI5YHEJAM44P9E8Ns/Mvt2K1UtknHsezcjKeAxf
         6r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aq7oOwp7wgRv/b9bzOLiDEXrH64adU/KQAqTS/4rqsI=;
        fh=PRgOisS+4dL3hoju24GvIS4toL+2fehoUxNF2kPx1hs=;
        b=cKH374JfwolG+R1TmdykCil28CjCMv6tcgJpzfCq9jnusqVra4juX7UYuKbaBQbtiy
         BUZyUGi4tBq+znp9wrtakHbI9/xwISJ755EnL0UxkqGNvZJbi4b1nt7Eps0i0ip/HIjh
         UskuA/G6OB8O1TohRedbyTULyQZA5cxO3QIfe12JaDY625vbWYNDwdh6OgVePJBoHlfA
         pM4B42n6A92VMCoC0vOUeFAYEMQbjBDqthX3O6yWxywGc2AZsjTfvjG6ExTVzEsP8AyZ
         fbLqsyCuJwp75+rt2pOmsqkFWg4x7BmkBr3n0+zkpbIfG0O98vFIEGk0Ir3VbA6J7zki
         nGxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776027754; x=1776632554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq7oOwp7wgRv/b9bzOLiDEXrH64adU/KQAqTS/4rqsI=;
        b=sm//m3drAHtZ5AYDKjvyHmrldCtRSoNHnSr11xTNMAFS+i1D0wPP79SVajL3SXLx+y
         SKItPj2KyVfXyr4Gwz9QI1ZJJ8cedQBP8JeZpj9tdMPpzMTHYwh6vee9SmefIxPAc0n5
         KDv8zRnzgcidxwq2HedGtqEl4alNn9+BKeqYyt5qAAH+DXb6D8icOOzg0caY8UJsekez
         rDRHEfoxxWjPgKtvqOA3lnPBZzKOMiMQ3B1bUJnIvyYKiI9HqZpaD04o0+zlxH6wO8KW
         UcRYOoR/g2yH9vIXigz8AHXSqT2QsnMuNGn1iH3Y+1KSkjOBmTZrBSdJfDeR9skYf07F
         yHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776027754; x=1776632554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aq7oOwp7wgRv/b9bzOLiDEXrH64adU/KQAqTS/4rqsI=;
        b=WkNorEFg3avzydNPubyI4cS2u9quN2+op1A9sa5uRMEh13kRQnKBNyPVb6slMCjjnQ
         3jntHvJeaajK+m5ucWc6xFCSYtX+A5c7k6TW3gKhEyK/QmycgUUruLJZnc83oJMFwV/I
         pg8kXhk2ScvFjQe7nlU7Ot+zgRuasnNEkKVfgvulPS65D2RnetA4mmqLomrYFjAlLjzO
         cV8zBIDJzlR/GXLj+62eeI9YJZLiak5MnQBHo+omeZ4tJmQ4GOH5+96qXYoHqIQOUQr7
         mtSSPA4UJNDU/th4LeLkFcVjSinzRU4vBEKqMVFhG35rm4dHWrDqsCmvEtcrlkT8NKGA
         eakg==
X-Gm-Message-State: AOJu0YzMHE8HGDC0lwSmwpp4o5w5mkqase6NJ4/KkbnK6N0R1+S0pA7O
	2iXztm26w/wClV6G/U/a15H5E6dLduT/QdQ7AV0aeZam/tdnyPbD07iH86HWRAo51j2QdtLPOUc
	rrL6lOT4WRpedP6YFxY5YPpUJHEbgBjI=
X-Gm-Gg: AeBDies3dghc6C882zsqN01/9FGVtxcVLvfvnXqEDHkem7ytKhPq5ppLQemqoOQuQR/
	tOah+BSDBus2jBLSfQBtuslfDp39BEblnGciOzFKCJRhhkS2VS4TyLfTb8C3dZ2yXZWk7cHhJiy
	XZbIl/SG4mEOYjyYec5PDlT5IhXsK70lXVU8eOTgiOgjo4PythY9/WI5og9kj0DydSP2E87EqdS
	bSuDunPByyppyDZujuuvbdUhNMWDGEz+wX4PLa2lLPoaFlBLBPNzBoNiJmCpsPYrc6u5u9FIiHJ
	fAHyQARy9/Kr8gAI0wChYn4MB+0eLbYlejUHjR2etVftuEUFfrLETCA5XdupE6tbyEmale3thSt
	IG1OU7wbNSIa32f09xzKhreDIdw==
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-488d67bbd1dmr160134105e9.4.1776027754164; Sun, 12 Apr 2026
 14:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175217.1011024-1-song@kernel.org>
In-Reply-To: <20260408175217.1011024-1-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 14:02:23 -0700
X-Gm-Features: AQROBzBq3S8-HfXSLmejYXIQb96lGp7xSb_yp_4gi6lNj4FXfoMkza2Ce3qtFN4
Message-ID: <CAADnVQKMyGyw6vYVPVgT_G-CfbabARTiisd0dKV4U+8SY3qcEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch
 integration test
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:52=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Add a selftest that demonstrates BPF struct_ops controlling kernel
> behavior through livepatch. A kernel module (test_klp_bpf) livepatches
> cmdline_proc_show() and delegates output to a BPF struct_ops callback.
> The BPF program writes a custom string to /proc/cmdline via the
> bpf_klp_seq_write kfunc.
>
> Components:
> - test_kmods/test_klp_bpf.c: kernel module that registers a
>   klp_bpf_cmdline_ops struct_ops type, livepatches cmdline_proc_show,
>   and provides bpf_klp_seq_write kfunc for seq_file writes
> - progs/test_klp_bpf.c: BPF struct_ops program implementing
>   set_cmdline callback
> - prog_tests/test_klp_bpf.c: userspace test verifying /proc/cmdline
>   output with and without BPF struct_ops attached
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Song Liu <song@kernel.org>
>
> ---
>
> This shows an alternative solution to the idea proposed in [1]. This
> approach doesn't need any kernel change.
>
> [1] https://lore.kernel.org/bpf/20260402092607.96430-1-laoar.shao@gmail.c=
om/
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../selftests/bpf/prog_tests/test_klp_bpf.c   | 109 ++++++++++++
>  .../selftests/bpf/progs/test_klp_bpf.c        |  26 +++
>  .../testing/selftests/bpf/test_kmods/Makefile |   3 +-
>  .../selftests/bpf/test_kmods/test_klp_bpf.c   | 166 ++++++++++++++++++
>  .../selftests/bpf/test_kmods/test_klp_bpf.h   |  12 ++
>  6 files changed, 316 insertions(+), 2 deletions(-)

It looks good, but takes 1.6 seconds on a non-debug kernel.
This example can stay out of the tree.
