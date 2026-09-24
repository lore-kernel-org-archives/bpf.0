Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE4135A53
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209606; cv=none; b=nwJIJxgdIG4b7w16SDfjLc4SuTXllcGrKe3iEM6mcr+iJxqEV7rF2fQXmT6hcsUIhw0+7F0Jdgn6MNMl89SIZKhUQ1fl23/l+6FSiEQ9r1oya3u1SLzsMs5TjtiEDb1Vm4xxgzR31kctCv4STD5QSEU/madY7mrLNxAOJHBSsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209606; c=relaxed/simple;
	bh=4HAsvdFk0GdveALBcip2dd4bHGPhBVjzm6rXdXQtFfs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l6rhK27RxDBcSo3s1lkHy1f7FFsJvMxueDIBdfELYIB4CHqLucREJZPrUZN1wb0bU0DT/F6IhnymGyEBcGNgR2Psu71KcYqGYzXm1frEmcRALfBvxNXS8by7D3Q94MDpSiNElwj9Tkwu3a3TlGo2bUWH11Y2hB5+7sdFGexqyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=aa/fbi8j; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="aa/fbi8j"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso10784505e9.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790209602; x=1790814402; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0QKgPEbaPjK4cgjQjXruZncRqFCA9WSmzfVPt4HhRAs=;
        b=aa/fbi8jOeW4zyTOBBqMuV8QJCvF+OQoasqwITeEiTBhpTDWiRgB1CLSoxpjnGdTb+
         ajpBljQBA+1/xiLXN+JL3BIKDnYNt3TmqKx9iPe02rY4I7Gye05x8bRjiue9W+0oyTw7
         zJz5K/YiLdvgFIkT34jiBJfCjCLqwgRvdT0jAoCmY8xcDA2e8SXJat6aqyaz/4BroKap
         rjwcPDQUwJV2QlRurN0xRCADbMrXB04pxNlTEtCSmpYCnqwMlzoj/1FC3JUBlvgTw15K
         r1C1ZjP2ELgt44ySLe0YN1b0NrseYgvauR/xaqTFETLQatFwLmjCf4M9Ng+D7i4ZsnCZ
         JdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209602; x=1790814402;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QKgPEbaPjK4cgjQjXruZncRqFCA9WSmzfVPt4HhRAs=;
        b=jZfJRqCH9sCtsKCrqsu33s2tXmq9jhWdkKp8DXpGrl7wxFP8eyRyWYHNAWU6LuFCAP
         VW21S4B7eMkO5glgzzQKgcjMh3nPzPayAdqA+/dcUSibDGiwMKn5zoVDz42kk+BA93ev
         b6vB7PF8Ejq6j09AZdu+wZARGOC0Yd9Q22DTfad5oledQvZkli+B7IVrlRuDU6JtZaA7
         nLoM4GxzTjMNUyaTn+AILaRZyBJ+Ud+tyiMNZSVrPDX03UDcCZE2ta+CQP60NrdUTdm1
         LQTZa+vhohdAp9AtHFsfh66j26QbxC+k9W91kS+MYZwpNVUvw4Uds5Ha6E3hJgS7YcVt
         ATow==
X-Gm-Message-State: AFuF++koJ+nQ/wLclncHo4cdFoSHholQlnT9fR007mnktJVXyO56guKf
	94ZbDspTebsQkg4IkQR7KaVbFmpan4N54z3WjC+21ENpbfDK/fr/uACDN/IFg7guTVA=
X-Gm-Gg: AYBFou0ZTuIiIrToX753Y7FUFB10CG4sDZZZVwYuclqZKnryS60nopAeUCxWuhw48RQ
	k6agWwIx/Q9T4CYjigkbDJuHrRQjXJiWosRqlg6GhPsu4IT0nHvmgpfsxZoT2fvs847sUzRFdqp
	6f5dhQ3K2D14SF5MOvm77lUi+VFqDdPUDSgbsj3WNSzqNX7b1Uh/es6ZatFkmpl+6WVUpUIZ/Kf
	2k6KZXL7BzgdxMIU2laeZp4LoBOZkomVYJaHsQ+AModCLcYMPyiWCkLVQFHCtnw603nAua1MURo
	0ekaTyMLJjgIddl16Wwi6cmK2F6gsXferO3E7hRvBwaKJE/n9M+W9krDLwPPOYpjrFpPe5epIdv
	oCxIGWoQ7LQ4VBfEqo4kHzwTWsamuvnnZRCC8qxKgBcU1TV2nGUMvAVm5uXUp51zoGGhnX7PpW9
	dyV0IhDALtdWAzazhEB5MkKdLI4e/YSYhuWdS3twH/bwIo/339zM3qDME=
X-Received: by 2002:a05:600c:4e93:b0:49c:f89b:f82 with SMTP id 5b1f17b1804b1-49fe66d2d2fmr13292995e9.12.1790209601678;
        Wed, 23 Sep 2026 17:26:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:ef15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cbd77bsm28451885e9.8.2026.09.23.17.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 17:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 00:26:36 +0000
Message-Id: <DLN4C778DZVV.2Y0M0WRP8EPD0@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Refactor cb_refs selftests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260923230717.3156345-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260923230717.3156345-1-ihor.solodrai@linux.dev>

On Wed Sep 23, 2026 at 11:07 PM UTC, Ihor Solodrai wrote:
> cb_refs matches verifier messages such as "Unreleased reference id=3D4
> alloc_insn=3D3". The ID is allocated from env->id_gen, so it changes
> whenever the verifier assigns another ID earlier in the program.
>
> In the bpf tree commit 71919742c83c ("bpf: Assign lock identity to
> callback map values") gives each callback map value an ID, and the
> nested_cb expectation was changed to id=3D5.
>
> In the bpf-next tree, commit 5dc1549afac9 ("bpf: Consolidate release
> argument validation") changed leak_prog to expect id=3D4 from the same
> leak check.
>
> The trees are merged in linux-next, and there leak_prog reports id=3D5
> and the test fails [1]:
>
>   Expected: Unreleased reference id=3D4 alloc_insn=3D3
>   ...
>   Unreleased reference id=3D5 alloc_insn=3D33
>
> The ID is incidental. The test checks that the verifier rejects the
> leak and which acquisition leaked.
>
> Convert the test to test_loader, register the test in
> prog_tests/verifier.c and drop unnecessary prog_tests/cb_refs.c file.
>
> [1] https://github.com/kernel-patches/bpf/actions/runs/35923662147/job/10=
7398076527
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/cb_refs.c        | 48 -------------------
>  .../selftests/bpf/prog_tests/verifier.c       |  3 ++
>  tools/testing/selftests/bpf/progs/cb_refs.c   |  5 ++
>  3 files changed, 8 insertions(+), 48 deletions(-)
>  delete mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/tes=
ting/selftests/bpf/prog_tests/cb_refs.c
> deleted file mode 100644
> index c32c6dab49bc..000000000000
> --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "bpf/libbpf.h"
> -#include <test_progs.h>
> -#include <network_helpers.h>
> -
> -#include "cb_refs.skel.h"
> -
> -static char log_buf[1024 * 1024];
> -
> -struct {
> -	const char *prog_name;
> -	const char *err_msg;
> -} cb_refs_tests[] =3D {
> -	{ "underflow_prog", "R1 type=3Dscalar expected=3Dptr_, trusted_ptr_, rc=
u_ptr_" },
> -	{ "leak_prog", "Unreleased reference id=3D4 alloc_insn=3D3" }, /* alloc=
_insn=3D3{2,3} */
> -	{ "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" }, /* alloc=
_insn=3D2{4,5} */
> -	{ "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=3D1" }=
, /* alloc_insn=3D1{1,2} */
> -};
> -
> -void test_cb_refs(void)
> -{
> -	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf =3D log_buf,
> -						.kernel_log_size =3D sizeof(log_buf),
> -						.kernel_log_level =3D 1);
> -	struct bpf_program *prog;
> -	struct cb_refs *skel;
> -	int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(cb_refs_tests); i++) {
> -		LIBBPF_OPTS(bpf_test_run_opts, run_opts,
> -			.data_in =3D &pkt_v4,
> -			.data_size_in =3D sizeof(pkt_v4),
> -			.repeat =3D 1,
> -		);
> -		skel =3D cb_refs__open_opts(&opts);
> -		if (!ASSERT_OK_PTR(skel, "cb_refs__open_and_load"))
> -			return;
> -		prog =3D bpf_object__find_program_by_name(skel->obj, cb_refs_tests[i].=
prog_name);
> -		bpf_program__set_autoload(prog, true);
> -		if (!ASSERT_ERR(cb_refs__load(skel), "cb_refs__load"))
> -			bpf_prog_test_run_opts(bpf_program__fd(prog), &run_opts);
> -		if (!ASSERT_OK_PTR(strstr(log_buf, cb_refs_tests[i].err_msg), "expecte=
d error message")) {
> -			fprintf(stderr, "Expected: %s\n", cb_refs_tests[i].err_msg);
> -			fprintf(stderr, "Verifier: %s\n", log_buf);
> -		}
> -		cb_refs__destroy(skel);
> -	}
> -}
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 4f1e1c1cd5ab..8b4be06bb181 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -5,6 +5,7 @@
>  #include "arena_kfunc.skel.h"
>  #include "arena_kfunc_jit.skel.h"
>  #include "cap_helpers.h"
> +#include "cb_refs.skel.h"
>  #include "verifier_aggregate_arg.skel.h"
>  #include "verifier_aggregate_ret.skel.h"
>  #include "verifier_align.skel.h"
> @@ -176,6 +177,8 @@ void test_arena_kfunc(void)                   { RUN_T=
ESTS(arena_kfunc); }
> =20
>  void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_ji=
t); }
> =20
> +void test_cb_refs(void)                       { RUN_TESTS(cb_refs); }
> +
>  void test_verifier_aggregate_arg(void)        { RUN_TESTS(verifier_aggre=
gate_arg); }
>  void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggre=
gate_ret); }
>  void test_verifier_align(void)                { RUN(verifier_align); }
> diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/=
selftests/bpf/progs/cb_refs.c
> index 5d6fc7f01ebb..d4a691db8a15 100644
> --- a/tools/testing/selftests/bpf/progs/cb_refs.c
> +++ b/tools/testing/selftests/bpf/progs/cb_refs.c
> @@ -2,6 +2,7 @@
>  #include <vmlinux.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
>  #include "../test_kmods/bpf_testmod_kfunc.h"
> =20
>  struct map_value {
> @@ -24,6 +25,7 @@ static __noinline int cb1(void *map, void *key, void *v=
alue, void *ctx)
>  }
> =20
>  SEC("?tc")
> +__failure __msg("R1 type=3Dscalar expected=3Dptr_, trusted_ptr_, rcu_ptr=
_")
>  int underflow_prog(void *ctx)
>  {
>  	struct prog_test_ref_kfunc *p;
> @@ -47,6 +49,7 @@ static __always_inline int cb2(void *map, void *key, vo=
id *value, void *ctx)
>  }
> =20
>  SEC("?tc")
> +__failure __msg("Unreleased reference id=3D{{[0-9]+}} alloc_insn=3D3") /=
* alloc_insn=3D3{0,2,3} */
>  int leak_prog(void *ctx)
>  {
>  	struct prog_test_ref_kfunc *p;
> @@ -83,6 +86,7 @@ static __always_inline int cb3(void *map, void *key, vo=
id *value, void *ctx)
>  }
> =20
>  SEC("?tc")
> +__failure __msg("Unreleased reference id=3D{{[0-9]+}} alloc_insn=3D2") /=
* alloc_insn=3D2{2,4,5} */
>  int nested_cb(void *ctx)
>  {
>  	struct prog_test_ref_kfunc *p;
> @@ -98,6 +102,7 @@ int nested_cb(void *ctx)
>  }
> =20
>  SEC("?tc")
> +__failure __msg("Unreleased reference id=3D{{[0-9]+}} alloc_insn=3D1") /=
* alloc_insn=3D1{1,2} */
>  int non_cb_transfer_ref(void *ctx)
>  {
>  	struct prog_test_ref_kfunc *p;

