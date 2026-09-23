Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AD33D6D6
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205538; cv=pass; b=Q3Ht+lwmSkbWCHhztflwXajOAhWS2wEGESf5frmohqPQnPUxhtZWbxj/zmLPg/RCjJqNT6G3uzxjqZcHzdDXRTUKdAfZGuNgzh29C6wim0dI0mqEGAuwfsdGzcmuJEVmE0TUNvOzGAebExpT2TPm/FSu8TXZrwAWXXYGnGvv5HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205538; c=relaxed/simple;
	bh=SO2LKRP3vfw5D7K5kCN968nf/tnu9OGGl19n6QD8KN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmLw0ez6vVKy1TlRz7UToWKcWl/93GOS3VpcLDiJb44rnFZvwiXk6yilXunQO0qSWQTmqABt7cKENNvoCcV+9pO5Xl1CqgThhgkZ9g1Qad4s5NFzkdKLLUwCZrMJ9pbDuuz2c5FYxGOqlRQwwGwurawLMis6BinWKVF2WY+WY+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rw5eFsKF; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rw5eFsKF"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a30eb3bso859408b6e.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790205535; cv=none;
        d=google.com; s=arc-20260327;
        b=TfYlcBZTusp9vjEvpqzveoGv7nn1dxK43R1W/jDx0P1ZPkTABlUXf5fcV3tG7q4HU+
         FZcSbh9AE4ca6IsGyG/jLwJuCjTAaMMCegIAHwVDeeFuhBJZnS6Mh14H/ITY5fcXDV7j
         NA889w5kGuo8Xmq5iQ4TJB1+lbHngm3KX2kqMzaICpOuPibxwYUUln1KEiA/OAJfAbxc
         0MuHAA2Dt1Duic3GYVAeJMPLipHth0quQTAOz65KlVQItax7YXAIU4goR9eyDhHV1z1d
         //yMc0k0v5wu3JxW//0ltDtRjH7rL7FPwpq7DVcpYihDti6f058gMsXSRnFuy23Y4SJy
         n6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E1TVqCSewv7nNRHv5byGC8EVAAgyRcmYJvlA+fjv05M=;
        fh=tD4gjKXl5Nf9p+s3fVvNbPQy2ApqJecMAJb+axKZTlA=;
        b=pcwOIiJpqAWhCyX1/NvgToDG+laCy8TQ2o6aTXkifiHtKpLHZTGHsGdV9hkbh3LEz8
         wkSYbSBV71ZSge5R+aHtXizdWg0b1MMFZEYWieaTlkccqRF2vTxgSjqECtCx7ZOWt3dE
         vBvNcWHrKoQEdadC7kJfmBsBh6fyCTn0KMNgU/frdojRNoomIPqKCjCX45RlpWKJPzXL
         7ZQMXk1rwZy9xWYqSpKnki09+SgBZfBL/LkAXjMTA8wulXe8drmO9QIX2EmxJAxwXuT8
         MjEubiFdI8qo5JwaRYg/SgK4Z94YY2BlT8m47Z6gzMi9131N8hyiloJjhKfft72aDu84
         zppw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790205535; x=1790810335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1TVqCSewv7nNRHv5byGC8EVAAgyRcmYJvlA+fjv05M=;
        b=rw5eFsKFQuRqnVJeIOeBJJrJgYa+lAvVjTF78ipttUUAWQEE9hCnDeAGRzj/vWDWrf
         9a+d1gUZDElnr0lsiliIqjt2wAIFNQetsA5QNdsMCPbjHK3A2pCoZXqLhJt7SO24TrTs
         3BB/Vvdr+wuW8QEit+rqjB13Zs8ZlEf0yL3YccaRJdroLVElvMxX4FFHLWKSwW5dz1K8
         EBOGHR766E34PXfMhFlI5HLuu73tIWeWxbRDEhFG3CA0PE+mx/xCkDX2qzZqG68fkM5E
         ZtczRvHgoPkG8Z/GBBpwLco2bTlJxz3bBTxHqpKEPtn6CY5lSPvSv41b1mSkjxKzciY1
         +tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790205535; x=1790810335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1TVqCSewv7nNRHv5byGC8EVAAgyRcmYJvlA+fjv05M=;
        b=OjBZW+miJH+ruoZrsYb/zaQqqnkNfv0sj6skZWr9Skm04jd+2dOTfdq0P2Ya+l4JWC
         XHyTt4EXXN6RnAci88DlZoGfCrLuUnYK+wj26IXfhs2o+zBw9WDj7kq+8IDaHbCGz+pS
         58NLPUL2GXdW4T1Xez5r9GqRDGF68prnq/H/l9RcPCcrqs6llpt3Qhr9sMKqYez2Yuku
         WW+cuEhDwUgfcGF/1onjJAtW5jY6N4UszD/zoSKGk9f8kEt6CBz90N6eHHwpP3T1Th5K
         dDEHXGS5H5HBn5EyUqJyjQuzfRXBIB9ImZ9r1BZGPJyCzGlT6K8oaXLM7w1u7dWUaaKu
         bXCg==
X-Forwarded-Encrypted: i=1; AKwUvBwvoF57oGvcmN7Xtgyx1fh6WBcK19WThEPwFeetm0ROvNq4PYKciILFQMikz6I9gZLVoGg=@vger.kernel.org
X-Gm-Message-State: AFuF++ldNT+Efsyn6UDsEwvG0ZhKfEbC2AKPDccfRtY/2enBHsNnOnKg
	ZQFX7jfEReJG4L3/tgbzt8Fo/IdDYKYg8cleoSFZucVcV+MNE/OdFd+dj19ivSaj0Dnr4CPCshl
	UPVMsMeVIyDB/8jFuTbOlMV2vSspyzjM=
X-Gm-Gg: AYBFou0zX1GEn0xglPX3oE0XNBeR/L0B6364nZzvPbUIdEPGRTUKTwncJnAJLJO6olD
	HBjgzLaGfjhNQZgscOcDMvOZgi9O1A7zAAy8MH0AahwJgpxsvE5duwTE45Blk48iIw/QaAy0Qwp
	QZx/FHr+x9McXS+zTXqScFqXx66S5t3D+5dKQ4pp2KtZdoHfYGwBRLCSxpG5jqDQIrfVMGNxf3W
	TCvxE7S6x/dVu37zfeDNNi1FwJ7DjUFmdS/89b6bVltkhIyNAsWzuvX6N6fZB5bQltV3kZnRw34
	QhTiLH2+wqO2n025hLIrgnc1CW68Tw4Hf+Zc0OjHLlfQ+2q+ikW/ajw=
X-Received: by 2002:a05:6808:508d:b0:4cb:f21b:6f91 with SMTP id
 5614622812f47-4d73045fbb4mr913808b6e.36.1790205535226; Wed, 23 Sep 2026
 16:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923230717.3156345-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260923230717.3156345-1-ihor.solodrai@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 23 Sep 2026 16:18:43 -0700
X-Gm-Features: AclHuK-NyO71AkjW7n9QKqUtfGSacerJ1msZTOhjp6etGIlejXfveI-NROpIc_8
Message-ID: <CAMB2axP9xiZ6U9PnWSSr_x0HRQUZgmvwa3_BmBz5evDWMZW_SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Refactor cb_refs selftests
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:07=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
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

Reviewed-by: Amery Hung <ameryhung@gmail.com>

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
> -       const char *prog_name;
> -       const char *err_msg;
> -} cb_refs_tests[] =3D {
> -       { "underflow_prog", "R1 type=3Dscalar expected=3Dptr_, trusted_pt=
r_, rcu_ptr_" },
> -       { "leak_prog", "Unreleased reference id=3D4 alloc_insn=3D3" }, /*=
 alloc_insn=3D3{2,3} */
> -       { "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" }, /*=
 alloc_insn=3D2{4,5} */
> -       { "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=
=3D1" }, /* alloc_insn=3D1{1,2} */
> -};
> -
> -void test_cb_refs(void)
> -{
> -       LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf =3D log_b=
uf,
> -                                               .kernel_log_size =3D size=
of(log_buf),
> -                                               .kernel_log_level =3D 1);
> -       struct bpf_program *prog;
> -       struct cb_refs *skel;
> -       int i;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(cb_refs_tests); i++) {
> -               LIBBPF_OPTS(bpf_test_run_opts, run_opts,
> -                       .data_in =3D &pkt_v4,
> -                       .data_size_in =3D sizeof(pkt_v4),
> -                       .repeat =3D 1,
> -               );
> -               skel =3D cb_refs__open_opts(&opts);
> -               if (!ASSERT_OK_PTR(skel, "cb_refs__open_and_load"))
> -                       return;
> -               prog =3D bpf_object__find_program_by_name(skel->obj, cb_r=
efs_tests[i].prog_name);
> -               bpf_program__set_autoload(prog, true);
> -               if (!ASSERT_ERR(cb_refs__load(skel), "cb_refs__load"))
> -                       bpf_prog_test_run_opts(bpf_program__fd(prog), &ru=
n_opts);
> -               if (!ASSERT_OK_PTR(strstr(log_buf, cb_refs_tests[i].err_m=
sg), "expected error message")) {
> -                       fprintf(stderr, "Expected: %s\n", cb_refs_tests[i=
].err_msg);
> -                       fprintf(stderr, "Verifier: %s\n", log_buf);
> -               }
> -               cb_refs__destroy(skel);
> -       }
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
>
>  void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_ji=
t); }
>
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
>
>  struct map_value {
> @@ -24,6 +25,7 @@ static __noinline int cb1(void *map, void *key, void *v=
alue, void *ctx)
>  }
>
>  SEC("?tc")
> +__failure __msg("R1 type=3Dscalar expected=3Dptr_, trusted_ptr_, rcu_ptr=
_")
>  int underflow_prog(void *ctx)
>  {
>         struct prog_test_ref_kfunc *p;
> @@ -47,6 +49,7 @@ static __always_inline int cb2(void *map, void *key, vo=
id *value, void *ctx)
>  }
>
>  SEC("?tc")
> +__failure __msg("Unreleased reference id=3D{{[0-9]+}} alloc_insn=3D3") /=
* alloc_insn=3D3{0,2,3} */
>  int leak_prog(void *ctx)
>  {
>         struct prog_test_ref_kfunc *p;
> @@ -83,6 +86,7 @@ static __always_inline int cb3(void *map, void *key, vo=
id *value, void *ctx)
>  }
>
>  SEC("?tc")
> +__failure __msg("Unreleased reference id=3D{{[0-9]+}} alloc_insn=3D2") /=
* alloc_insn=3D2{2,4,5} */
>  int nested_cb(void *ctx)
>  {
>         struct prog_test_ref_kfunc *p;
> @@ -98,6 +102,7 @@ int nested_cb(void *ctx)
>  }
>
>  SEC("?tc")
> +__failure __msg("Unreleased reference id=3D{{[0-9]+}} alloc_insn=3D1") /=
* alloc_insn=3D1{1,2} */
>  int non_cb_transfer_ref(void *ctx)
>  {
>         struct prog_test_ref_kfunc *p;
> --
> 2.55.0
>
>
