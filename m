Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F92857FA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432759; cv=pass; b=WQYkeFQ2fvPlyY+tCoaM0p40UBmL7XHm47ihmaHVA3AsYn9leSeuIPBfvu4m6r4er8Lr4CSS9SBcUUkqIA2vUySIFtOSJNXcTdwfaezjAMxqoZi30cfojGbA8sYqCYBHTE64gI/E/UB3RmZBUPTgvkqtYD0bPwwqgq/ratEQURk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432759; c=relaxed/simple;
	bh=BaMmrTOGqMeTWU4cHIgEhE8sDQ/KoVQiVvTC0uPQTBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCIXZbN/DQB+lUZqHkKYnA7DQfTEJBANUpDmmYiCvvP+MnQTY2te0A2lEY+wpbe3yesyYb3kiTQDIbdJeu4aa6CEojgz5xubED3B7ede3C1YRULP4SsU3XqXTNSIXTHno4yO8KFaXESnD6AeMereuw/oQoCaYEurVulDbOz/wlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccu2oByH; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccu2oByH"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b128dd0cb1so2776004eaf.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789432755; cv=none;
        d=google.com; s=arc-20260327;
        b=I1yqWHpJjsNNKSf8kJ9Fjo69iX4pRutc1oEU8VFFSFII+Xcuiexo9KPgELiGsg8DMZ
         5UR0bg1/Is6xN9h02MKhnTNqoeYS51bF7+jx6tSSByQ4yg7QR9IQ405GP+khsE1R4Luy
         +MM5+3CztcjvCilCl7TeMPNoxU0rGf2uB13ncSUavHAWZ992XBi6jntu9vWz/ZprrbAg
         Uqid2vdZ6GrTl9C2GPsi9gUU5HQgHH7zue+le6OVyF24JUYTYi5ROBAN/7aYzgcNpBJp
         1zK0ibIkLmzf12eDMSAgZRhaZqecVjIECOM/C9yuvCwBEzwedC586KBDLU6B8Y+gl8qK
         /5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=acTxuAJD7BV/aV4sehYd/xwIkSac/YA3bN2NNfcEwh4=;
        fh=ZVapXO9jFHh1gAhFGTR9vAlDcAVZ1jtihvaYpeiRZDI=;
        b=XyTHU4nT3/jryCHoD4FRTKN/qGYKrgm+61XUmgQT77jCiNhGGdcW7UBClDYJjreAHt
         2qfYVx9ixrw8g9ag5UP9u2GzP/h0ysFal7CkutSZeh2SC9AiopIzn/GxQ/GiiwVkBWtG
         1TcsLmS5HBupTPoSBAiCJUajNuoY8zkvzGoYF06N+Hoq27mXd6TzDIAr15vUkynRzVQe
         IBUjqa/t74BqW7+9oy+abYasooht2qRkTBCtF1ODVQ5FMYA3FMuvUS8+p5IOZPcX4Pt+
         nzX0FHP9xSXuQD3if/TUrsLG54UZYNFuh1dCcawTIYrm9Ev8Nw0rSDufG2CIjESiuJMz
         v9UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789432755; x=1790037555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=acTxuAJD7BV/aV4sehYd/xwIkSac/YA3bN2NNfcEwh4=;
        b=ccu2oByHCcoQfzQtaexMd9Ay6oJsJ28oznY98M9ygLCPyt2lkYI35a80FqK6RoD9Hs
         sWQkA8+cDgyLB7KNbo8SBsBScf2/9ArAVserSGi/dagwturj7LRkTD/9z27XnqImqXTH
         qGDNqcj1G8+dywX9TJhsOajM5tk86FWaYibkMZzhZ1lGTBdg1mVVcK+QebbDudfEkGwK
         Ln3va9ZoDFb15i94qoWEE+pD4GIV/lQuWw7wxACRMKqcLUL9YiH7dSjNZlts4SO8slcB
         qBRMdqnZOhA0Y9pvueBuwEl9KcdlEFEFuTCiC3Hyzxw5bzSDW9us2u2EZ2/Y9VTGjlYo
         sJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789432755; x=1790037555;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acTxuAJD7BV/aV4sehYd/xwIkSac/YA3bN2NNfcEwh4=;
        b=ZVY68CfT/nWH/sAatKLYko3o/IyLtm1HOf4qaFH4sUKVdc422UgBeVBtsdC8S2KFLS
         N87dKKGVx/UJTSWIr+3AlHF/HkFbqqMDxHPWI6zhF3KT8qGfGxowZ8DRwhEWc1rp3Dv1
         P27nsxmSM93VFHU58bbV9dJgoEL1dPuh56lUDAW4wbeC5ZD3SSvXgBEKgxBjhCF1M+S2
         tCRv0qL5QwYfjnf5oyjMbJAMVrTC0VygA6r/4D2pYHXAgUnQ2veUsIHoe2onoYBRcbVS
         8VFru8yLlsZ6UVcCaxOSgxAscIr/FUU6U7VgXFYHdBxvNY4Mmm15Y9NpN2XsqpfOVNxn
         Lnqg==
X-Forwarded-Encrypted: i=1; AKwUvBxgqB4szHYMYq3zXqkFkn4qOS977HI07pt4OfpAfYzjiiucjdmuxvgTrjsaoKjbRAU7Thk=@vger.kernel.org
X-Gm-Message-State: AFuF++nK0bOcq6stZhdSv08WpXp+CiiVSOl0JvCMILFlvfsJKKFjsGwM
	lTvHej1I/96YLediHMJjGZ5zsBnwxc8adVGseJJ9XljRbiGVlJr77Tjjdzm6TXv/2y/V2D/BXQB
	P1ttCRMuO89oV2qfjsGY2vhn8ByoohLc=
X-Gm-Gg: AYBFou2RuiNktqYa+VZ47Zkqmm3Mx2dFrPA84VlD05e+toot3rSYxNolCZEqKwuslOX
	+3zVYq0AULZDG2lFwWguuXINoThB+3+KKmQvrm2ubD3zPMOlB1rrSkl2qS8Vep8UWbKjrKk7XDK
	v03QwzlkUdVIQbyL0BXQWmHU/S6UHcEPhZUmfoBSt0InUlBq2DXA6q78im86JbJxp1P7PxgIfs2
	cltFg+c3qngTNQT68FfIG6mybmeiXnFYwUrW+tHl9p7li8MVYJoFSgRvVKXiet/0BQL/l+PqDwH
	mde8McsrQX9/P1n3icXNuYjeZHboT1+vIXRh1AlCeNxNTrmJrErpoG7GUkGC8anbFw==
X-Received: by 2002:a05:6820:4b87:b0:6b7:83d6:2924 with SMTP id
 006d021491bc7-6c542342787mr2847248eaf.39.1789432755522; Mon, 14 Sep 2026
 17:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org>
In-Reply-To: <86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 14 Sep 2026 17:39:04 -0700
X-Gm-Features: AcwNN1WwzbGgP9OStftE8DTtFg0Y2xPQZsTNxTjlp_yK5QH7a8LBh2qdmMY2Tp4
Message-ID: <CAMB2axMJ6NJUtDc4xhUbSaqUsRyNXfyWTNTR7SCYyRwiBdoLAg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Keep generic __uninit kfunc arguments live
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 4:43=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Stack liveness models a kfunc's __uninit pointer argument as a pure write=
:
> whatever the buffer holds before the call is dead, and 2cb27158adb3 ("bpf=
:
> poison dead stack slots") poisons those slots at every checkpoint the pat=
h
> visits before the call. Argument validation disagrees. Only dynptr argume=
nts
> honor __uninit. A generic fixed-size buffer goes through check_mem_reg(),
> whose read pass requires every byte readable. The two rules meet at the c=
all
> and the poisoned buffer is rejected with "slot poisoned by dead code
> elimination", even when the program initialized it.
>
> Every kfunc with a generic __uninit output argument is affected,
> bpf_ksock_create() through err__uninit and sched_ext's scx_bpf_cid_topo()
> through its output struct. The rejection needs the buffer's slots to be
> allocated and dead at a checkpoint, for example on the second iteration o=
f a
> loop around the call. Before e566701b9b0c ("bpf: Check fixed-size mem arg=
s
> of helpers and kfuncs the same way") kfunc arguments could read poisoned
> slots, so the call passed, but the slots stayed poisoned and the program'=
s
> next read of the buffer was rejected instead.
>
> Restrict the liveness write-only exception to dynptr arguments, where
> validation accepts uninitialized output. A generic __uninit buffer stays
> live and is never poisoned, and validation keeps requiring it to be
> initialized. Add a selftest with a scalar output buffer and a checkpoint
> between its initialization and the call.

I don=E2=80=99t think restricting the liveness exception to dynptrs is the
right fix. The fact that generic argument validation does not honor
__uninit appears to be the underlying bug.

A generic __uninit argument should behave like a helper output buffer:
generate MEM_UNINIT | MEM_WRITE, validate it as write-only, and mark
the written range initialized after the kfunc call.

With that handling, bpf_kfunc_stack_access_bytes() should continue
returning -size for generic __uninit arguments. The current change
instead makes their previous contents live and requires callers to
initialize an argument explicitly declared uninitialized.

>
> Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/bpf/verifier.c                                      |    3
>  tools/testing/selftests/bpf/prog_tests/verifier.c          |    2
>  tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c  |   45 ++++++=
+++++++
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c       |    9 ++
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h |    1
>  5 files changed, 59 insertions(+), 1 deletion(-)
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12755,7 +12755,8 @@ out:
>         /* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
>         if (arg =3D=3D 0 && meta.kfunc_flags & KF_ITER_NEW)
>                 return -size;
> -       if (is_kfunc_arg_uninit(btf, &args[arg]))
> +       /* only dynptr validation accepts an uninitialized __uninit argum=
ent */
> +       if (is_kfunc_arg_dynptr(btf, &args[arg]) && is_kfunc_arg_uninit(b=
tf, &args[arg]))
>                 return -size;
>         return size;
>  }
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -53,6 +53,7 @@
>  #include "verifier_iterating_callbacks.skel.h"
>  #include "verifier_jeq_infer_not_null.skel.h"
>  #include "verifier_jit_convergence.skel.h"
> +#include "verifier_kfunc_uninit.skel.h"
>  #include "verifier_ld_ind.skel.h"
>  #include "verifier_ldsx.skel.h"
>  #include "verifier_leak_ptr.skel.h"
> @@ -214,6 +215,7 @@ void test_verifier_int_ptr(void)
>  void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_c=
allbacks); }
>  void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_n=
ot_null); }
>  void test_verifier_jit_convergence(void)      { RUN(verifier_jit_converg=
ence); }
> +void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc=
_uninit); }
>  void test_verifier_load_acquire(void)         { RUN(verifier_load_acquir=
e); }
>  void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
>  void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* keep the BTF FUNC record for the inline assembly reference */
> +void __kfunc_btf_root(void)
> +{
> +       bpf_kfunc_call_test_uninit(0);
> +}
> +
> +SEC("tc")
> +__success __retval(42)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void uninit_scalar_struct(void)
> +{
> +       /* dead before the call, so poisoned at the checkpoint */
> +       asm volatile (
> +       "*(u64 *)(r10 - 16) =3D 0;"
> +       "*(u64 *)(r10 - 8) =3D 0;"
> +       "goto +0;"
> +       "r1 =3D r10;"
> +       "r1 +=3D -16;"
> +       "call %[bpf_kfunc_call_test_uninit];"
> +       "r1 =3D *(u32 *)(r10 - 16);"
> +       "if r1 !=3D 1 goto 1f;"
> +       "r1 =3D *(u32 *)(r10 - 12);"
> +       "if r1 !=3D 2 goto 1f;"
> +       "r1 =3D *(u32 *)(r10 - 8);"
> +       "if r1 !=3D 3 goto 1f;"
> +       "r1 =3D *(u32 *)(r10 - 4);"
> +       "if r1 !=3D 4 goto 1f;"
> +       "r0 =3D 42;"
> +       "exit;"
> +"1:"
> +       "r0 =3D 0;"
> +       "exit;"
> +       :: __imm(bpf_kfunc_call_test_uninit)
> +       : __clobber_all);
> +}
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1087,6 +1087,14 @@ __bpf_kfunc void bpf_kfunc_call_test_pas
>  {
>  }
>
> +__bpf_kfunc void bpf_kfunc_call_test_uninit(struct prog_test_pass1 *out_=
_uninit)
> +{
> +       out__uninit->x0 =3D 1;
> +       out__uninit->x1 =3D 2;
> +       out__uninit->x2 =3D 3;
> +       out__uninit->x3 =3D 4;
> +}
> +
>  __bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
>  {
>  }
> @@ -1493,6 +1501,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_int_me
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_uninit)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -160,6 +160,7 @@ __u64 bpf_kfunc_call_stack_arg_big(__u64
>  void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
>  void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
>  void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> +void bpf_kfunc_call_test_uninit(struct prog_test_pass1 *out__uninit) __k=
sym;
>  void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
>
>  void bpf_kfunc_call_test_destructive(void) __ksym;
