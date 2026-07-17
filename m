Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39BA3B0AE6
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331275; cv=none; b=Gb+Ldfz82lOzI6fuelEaAT8zvm3GyJ2ncsVSFSd9T6I14RsKvXhX05p8mMVgR8Lh39e+QJgG0qToRVmmT6jYYxRktop4Is/ZAtg1yqdaI2RWcFZXFdyj+O1cBSVOxUnU54D5hur8fXXkqtnN1UFOgPXjbvQ3wA88/gedKbN7Pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331275; c=relaxed/simple;
	bh=4C0MX4uyArPDgowGAursiF8mIS66ZG00cte/JsWr4ns=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ODLE2wtzZqPp33FZQfHQ8+GrOQmaGPWqpKZFsf5+qVqoJXU4WJoBO+25Gpo0RX00cWTjZ9mguXrZvSYLA6iKEh3NXzuffqWRqWctG5XN0PaijXKRMr4HjdwZ920stikGHeln3HYGKhpp7sB5BbpAuF3lGZrg8DaTTu5+s+hMT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OVhzkZOU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OVhzkZOU"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca12086c06eso6900572a12.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784331269; x=1784936069; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ua8qj50WZAgVGQ8X0eQQWXVA4kcbHFr66dYhd/GZ0rg=;
        b=OVhzkZOUlkyMc4wriF3/fJMOXmLXNHh54FuAP8c5smps2u44sSBBqdqje/qVNUqi04
         KtvpN/K1s6+3i1c7CDkLixBwiwFvAiIALVqedPZ+5PGMy9bSaDlCVF07J/G0hp5MUtx5
         b8A3UpHofWZirSCLlzZSgYI3d99cx2diFw4VvZ4JbLQoOxBemdETZNUVIXIbZW0VFSwG
         QCm8XQC04Kw3Rnc3Tc8F15CaH12nqI2NiASOc3251tMojO2xc0GgYmxzTwtrXbEzGc4J
         Ek2Udnw5c6q4nJh82Dhf2MTuZw8c09HdP+zK75875L8I0bbD0V+S69Da7y/l04wofFwd
         /u/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331269; x=1784936069;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ua8qj50WZAgVGQ8X0eQQWXVA4kcbHFr66dYhd/GZ0rg=;
        b=BPJkLfxTWarxwNEZJQIHzw/I3BF2m+0svdL84qp7ATlMwUUv6DB3uVMYge+ruMbxBi
         RpNIwn8h3oDq1BEivukU9DSD6kmDZpWcbEQ0SAwzDQaeTHfLzPUbNg2VzVWVKKQ3cPSQ
         gseXPGd4aWQ04DDCuWKIo4MPA3qNOx/IL47tNtKLDzNGrZjZ3YfFAniQLxkh2Sez9CEz
         +inu1lwJV6Jgs2eaJIEca0WXsBMZydRiGIcLcTkhiULwisRORNQGhtWXWU4VwW8kREj1
         aJrF9emnGt12R9NVuY3ipJ0RnGRrPGFK+zjoy8Q1//q/y1oIIjH2aL4XN9vbGNB9jjwF
         UPUg==
X-Forwarded-Encrypted: i=1; AHgh+RraBo3pVjBJ6aOkdg7WMG4YfqjygHfrA2DjJLv7zRoprUgSlirSy1GJZm/iR7RDgU1pKp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCtnBkvbG9JF1p0C0fZPodsDtgHnOnJAmPHLdA5PTj8KBlI98L
	XKYu3sNZEo4gOFkERcUNuCoMl1+9BZDOLCelnnaekelE/ApIgW+YpJYVixscD9pRrCA=
X-Gm-Gg: AfdE7cn8jw7Da24hr7Y+sh+I1MSEIauSw1NT5wiW0wryfTQQfmKWuEmdsF8NGXXmB+H
	sCTHanl1MTNBRBlrO64U48jAFW1f6BkwVCs9IxD1NwiyjIa0fdRkecjT4O0B1snrmcZdM41E/vd
	ehAxdXYk8MTTXncM86afJL9VzoEhsKu1uTYvHmdcd4jMoKjYnG2atDmzT8sjY8PhdrTAoFooH3j
	xpBQ1SiQQfOLUyzwo2kTEJ2vmaxHYv9NE/EYyr2kBvZ52BeZtpOGxVEFKhj0jNFahzDS5RCkkdn
	J4XOO+Cewrui7jo7tWDYBz00wABh5yocWY20jXImCYL6LYA5q2GJguVxNAHj9/xphHXqx+sU6dJ
	iKph66TLe5QIzXcoy77MNW5VM4qEeQKpsqb8qNMHTALF6oc1+Di4aiK2U5dk=
X-Received: by 2002:a05:6a21:7111:b0:3c3:aabb:dba3 with SMTP id adf61e73a8af0-3c3adb17f56mr5275028637.76.1784331269165;
        Fri, 17 Jul 2026 16:34:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::f5f9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb69bsm7973699c88.11.2026.07.17.16.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 16:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 19:34:26 -0400
Message-Id: <DK18N7NTNCP8.1J65M00LCPNM9@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "Woojin Ji" <random6.xyz@gmail.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Saket Kumar Bhaskar" <skb99@linux.ibm.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Run arena tests serially
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717114117.350851-1-jiayuan.chen@linux.dev>
 <20260717114117.350851-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260717114117.350851-4-jiayuan.chen@linux.dev>

On Fri Jul 17, 2026 at 7:37 AM EDT, Jiayuan Chen wrote:
> Every arena reserves a 4GB kernel vmalloc region at creation, and on a
> KASAN build that eagerly populates ~512MB of shadow memory per arena. Whe=
n
> several arena tests run in parallel their shadow adds up, exhausts the
> memory of a small CI VM and trips the OOM killer during map creation.
>
> Make the dedicated arena tests (arena_* and libarena*) serial so they no
> longer pile up in the parallel phase. That alone brings the peak number o=
f
> live arenas back within the CI memory budget.
>
> A few other tests such as verifier_arena*, stream and compute_live_regist=
ers
> create an arena too, but they run inside shared RUN_TESTS()/RUN() suites,=
 so
> turning them serial would drag many unrelated subtests along with them.
> Leave those as-is.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/arena_atomics.c      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/arena_direct_value.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/arena_htab.c         | 2 +-
>  tools/testing/selftests/bpf/prog_tests/arena_list.c         | 2 +-
>  tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c    | 2 +-
>  tools/testing/selftests/bpf/prog_tests/arena_strsearch.c    | 2 +-
>  tools/testing/selftests/bpf/prog_tests/libarena.c           | 2 +-
>  tools/testing/selftests/bpf/prog_tests/libarena_asan.c      | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/too=
ls/testing/selftests/bpf/prog_tests/arena_atomics.c
> index d98577a6babc..1ad5d03d07ad 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> @@ -222,7 +222,7 @@ static void test_store_release(struct arena_atomics *=
skel)
>  		  "store_release64_result");
>  }
> =20
> -void test_arena_atomics(void)
> +void serial_test_arena_atomics(void)
>  {
>  	struct arena_atomics *skel;
>  	int err;
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c =
b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
> index 4b4adb3f4b71..01fcf4965ea4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
> @@ -66,7 +66,7 @@ static void test_arena_direct_value_one_past_end(void)
>  	close(map_fd);
>  }
> =20
> -void test_arena_direct_value(void)
> +void serial_test_arena_direct_value(void)
>  {
>  	if (test__start_subtest("one_past_end"))
>  		test_arena_direct_value_one_past_end();
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_htab.c b/tools/=
testing/selftests/bpf/prog_tests/arena_htab.c
> index d69fd2465f53..91ccf0402980 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_htab.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
> @@ -81,7 +81,7 @@ static void test_arena_htab_asm(void)
>  	arena_htab_asm__destroy(skel);
>  }
> =20
> -void test_arena_htab(void)
> +void serial_test_arena_htab(void)
>  {
>  	if (test__start_subtest("arena_htab_llvm"))
>  		test_arena_htab_llvm();
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_list.c b/tools/=
testing/selftests/bpf/prog_tests/arena_list.c
> index 4f2866a615ce..2648e06f53d0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_list.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_list.c
> @@ -68,7 +68,7 @@ static void test_arena_list_add_del(int cnt, bool nonsl=
eepable)
>  	arena_list__destroy(skel);
>  }
> =20
> -void test_arena_list(void)
> +void serial_test_arena_list(void)
>  {
>  	if (test__start_subtest("arena_list_1"))
>  		test_arena_list_add_del(1, false);
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> index acb9d53b5973..545b05d7a0aa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> @@ -101,7 +101,7 @@ static void test_arena_spin_lock_size(int size)
>  	return;
>  }
> =20
> -void test_arena_spin_lock(void)
> +void serial_test_arena_spin_lock(void)
>  {
>  	repeat =3D 1000;
>  	if (test__start_subtest("arena_spin_lock_1"))
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_strsearch.c
> index f81a0c066505..0c1c6cbfa0f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
> @@ -23,7 +23,7 @@ static void test_arena_str(void)
>  	arena_strsearch__destroy(skel);
>  }
> =20
> -void test_arena_strsearch(void)
> +void serial_test_arena_strsearch(void)
>  {
>  	if (test__start_subtest("arena_strsearch"))
>  		test_arena_str();
> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/te=
sting/selftests/bpf/prog_tests/libarena.c
> index ba5a5a50f7c0..df7e4b8dc394 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
> @@ -202,7 +202,7 @@ static void run_libarena_parallel_test(struct libaren=
a *skel, struct bpf_program
>  	run_libarena_parallel_fini(skel, name, prefixlen);
>  }
> =20
> -void test_libarena(void)
> +void serial_test_libarena(void)
>  {
>  	struct arena_alloc_reserve_args args;
>  	struct libarena *skel;
> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c b/too=
ls/testing/selftests/bpf/prog_tests/libarena_asan.c
> index f897405f701d..9c31b17dbf39 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
> @@ -85,7 +85,7 @@ static void run_test(void)
>   * Run the test depending on whether LLVM can compile arena ASAN
>   * programs.
>   */
> -void test_libarena_asan(void)
> +void serial_test_libarena_asan(void)
>  {
>  #ifdef HAS_BPF_ARENA_ASAN
>  	run_test();

