Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415CE78C9C
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218164; cv=pass; b=q0dlyZ2WPkVFRnWdFStKRT99Oo3F9QXGiP4VyUa9SFx24Vn9y5t8PUV1aSqC48wNLiuK6dR2nxLVANCCch/SMoNLx5tf0tStPeHMawWh5MMmC4njTMqytdW8pYzeW227hjsJrVkoPMFcZ3zqoMPoskFS0Ez7tx1h+6xiilstwNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218164; c=relaxed/simple;
	bh=t5vqTCJ64+LttEOPtBcuzMn0HXKg1nH2lmNVZK5A/vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jF9Rd3vP1RgJq3WFQtfRGqKQijfyxquIE/tUmsUnuBbxdVg98CGdViPZPnM5/wVJsfftT/GBqqyRxgYdrFfRuDKFN8KLKVMsMVKZ5xyQLv3hXGHeiz+B7gHSB19ytXvPut6Yo4zEOfFbF5gtcg/PxN64wORjU6cUWWD5DXQHrXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neSXKRO9; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neSXKRO9"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbcb467f2bso5604262a34.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 18:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776218161; cv=none;
        d=google.com; s=arc-20240605;
        b=JO7dCy6BMzstE2XsG8nOzaORiT6XfT/nD6RxAToZCI54m5Q+YHgFX+OWOj6DxAyFy1
         lyNaKLIs+xdGVVOTIn4DimVgd9nHSFbSveL+pWK4bWLTb+yQ5FKniTbb2UcqTsAMnqe2
         adHcwkWB9AIeMs8mPmR7jgx3QNm4hxxlADCe8D64e9H4v1Y3eNIpTlWEu0uwnE5z5Pnz
         Y6CRcGVjr6tp38dm+Q5A6INzJ65S6M3PSTar8T2BeNNaYcN2HWfITS8d9blg59VgfflE
         9f3kY5coPYnflifoeCfuJUco/U1MjSvNzTnSExtpcSdmvigINbeJnQDBB/smkUW/7gew
         irFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DuuScJrO41wU3vjKiXwwCtRZbcM08ckKA7HYywmq6ig=;
        fh=yUhbvMuLwFt+temV6WndYAAh4NB2NQlz6nEYH/aFVCE=;
        b=dWxifjM/Ppd9H6qCsSmwY/IQgGrJAwIjZYPaLuxhQhLdy7hvmRImTmcRNY8GRV0LAq
         IiT51NH5KP5eq2PWRINWBa6yWSkWdjxFMfAYOCkn3EGmEZr1BK0E27HsevQOK3mpvqUl
         gc4fdc3UezNthYM5BotspFShosa7xzYto+KQsHtAll02MqBP2WaSZcsta9cPyhMeCTCQ
         aCQOPdUeghUw2Dj5vxF3o2IKHO1ULe+T+YYbfaK22jyss1M1kcweY+q7pNn5M6iVmN3b
         kn6fUdenXzcjH9Gu79RhztQepvARuPmisY7ZfZbKpHHpeNSYWUsLzkGR0ClsDoz8QuOr
         LGIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776218161; x=1776822961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuuScJrO41wU3vjKiXwwCtRZbcM08ckKA7HYywmq6ig=;
        b=neSXKRO9D0JeT/M+NTjw1wZQBFrPcE2dr/GlEpYSU48HacfYBD7kwcOZMnVNYczwmE
         3ZKxJ+X/Wckcs0bp6uz/v8PJ0gdJMDf3VNVg0N1IC7JeD9pMUFm4PQYTkx/3jbwJp7db
         yFmQGcsV8tRBJILPZChC4BS1I1X2TRFUP3PIKjRvrISP2ct2K7YvdJ0Dusgma7USeYAL
         Bxp42ROwuWnVOldstTOg7AIkW+4xrZ4R4xWUa5z74x95thbC0ZbDlv+v9VIFsryN/Huv
         dkj/ljRRU7fu1Xa9JOYVdu+nPffyhDa1IkiVhr+yqzzs/YLrrPerthWYSd10Yw+ZBjz1
         rPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776218161; x=1776822961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DuuScJrO41wU3vjKiXwwCtRZbcM08ckKA7HYywmq6ig=;
        b=SiokQ6UOpCfQtATbQij56d1eMZ3K2+Qih8NoD0EQlOofIstR/pLRdeLUudItpkWt/M
         zd45HP72qkilFngceYSLKgaFcmb2AlQ1IWgKNqqhBo005aFpAVhhTEBPORoUepPON0E8
         KT49HhYUxQBGVwPd2qD+xeTZ0zRPMtNggpRKlW1YTqfBQm/WKcBl4Vl3Btq0YYDcbjFa
         T005XIwdBTGOV0QBVre18gsTW4jZhRpPdwa85Xf2blr7xKLjI8qFqQWc5lqPonZ0BXOz
         x1XEy+WSUelNicny1IBftchTcCWTYzBMNdsKORJW/dXFR1jax52zBnStG6p2RUtQUQMk
         Si3Q==
X-Gm-Message-State: AOJu0YyPydIbBio0Z9wfDkjIwgSzK59vwjWMFJ567/4P3JVtwJPeDsSp
	CtP6oEWV7WV4aeSNsPeBaLJ4su8t2FRX5y1UyQRA3TfzNAb1Y+BASeXVfpZiOTrr66nyF3pmxjY
	WEerdbiWo74t1FTG3XFIORIfUyniQLow=
X-Gm-Gg: AeBDieu8Taa77z/PIedYHDzzhLeduZ45cVhRWlEzkY28dwHYGJrQyulTnrB594q3fdM
	u7zSbbg7ngtAzKnkGshZUMjfogZJ6tlJBBKmfqVu16x60t5bCisXiuW4e8tASQZZTaOile+CQTm
	1AsiFm70iz2wAMQXWUWiyqjzWd620n7cx5mjSOCVHKajQLzgV7ob9e52P1T8oVFajkl4AbYqT+9
	7VLT5IJKf6JHTa1T7fpfr/kCG3sBMnBpcT87LVY9J9n1WkLYm+zYrY4NGIW3Q2tYX+KoxsLiUmE
	5HOsY+tf5WXllFLHOg==
X-Received: by 2002:a05:6830:4884:b0:7d9:b2b8:e06f with SMTP id
 46e09a7af769-7dc27f65b7dmr10748778a34.21.1776218161007; Tue, 14 Apr 2026
 18:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776062885.git.xukuohai@hotmail.com> <e99d594bcedfc0d818242ca6dda26f8f45f44062.1776062885.git.xukuohai@hotmail.com>
In-Reply-To: <e99d594bcedfc0d818242ca6dda26f8f45f44062.1776062885.git.xukuohai@hotmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 15 Apr 2026 09:55:49 +0800
X-Gm-Features: AQROBzCUAQX2PLCRiTcPfMddhIEe0p3Qg375MuPpiaM87l9rFtzcuBNvXKNUy-A
Message-ID: <CAEyhmHS_H6ckUoMGGPmyKbYfEWMivsY7eRnW373Y9NTiUpJ75g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v14 2/5] bpf: Pass bpf_verifier_env to JIT
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
	Paul Burton <paulburton@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 9:07=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Pass bpf_verifier_env to bpf_int_jit_compile(). The follow-up patch will
> use env->insn_aux_data in the JIT stage to detect indirect jump targets.
>
> Since bpf_prog_select_runtime() can be called by cbpf and lib/test_bpf.c
> code without verifier, introduce helper __bpf_prog_select_runtime()
> to accept the env parameter.
>
> Remove the call to bpf_prog_select_runtime() in bpf_prog_load(), and
> switch to call __bpf_prog_select_runtime() in the verifier, with env
> variable passed. The original bpf_prog_select_runtime() is preserved for
> cbpf and lib/test_bpf.c, where env is NULL.
>
> Now all constants blinding calls are moved into the verifier, except
> the cbpf and lib/test_bpf.c cases. The instructions arrays are adjusted
> by bpf_patch_insn_data() function for normal cases, so there is no need
> to call adjust_insn_arrays() in bpf_jit_blind_constants(). Remove it.
>
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com> # v8
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com> # v12
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

>  arch/arc/net/bpf_jit_core.c      |  2 +-
>  arch/arm/net/bpf_jit_32.c        |  2 +-
>  arch/arm64/net/bpf_jit_comp.c    |  2 +-
>  arch/loongarch/net/bpf_jit.c     |  2 +-
>  arch/mips/net/bpf_jit_comp.c     |  2 +-
>  arch/parisc/net/bpf_jit_core.c   |  2 +-
>  arch/powerpc/net/bpf_jit_comp.c  |  2 +-
>  arch/riscv/net/bpf_jit_core.c    |  2 +-
>  arch/s390/net/bpf_jit_comp.c     |  2 +-
>  arch/sparc/net/bpf_jit_comp_64.c |  2 +-
>  arch/x86/net/bpf_jit_comp.c      |  2 +-
>  arch/x86/net/bpf_jit_comp32.c    |  2 +-
>  include/linux/filter.h           | 17 ++++++-
>  kernel/bpf/core.c                | 86 ++++++++++++++++----------------
>  kernel/bpf/fixups.c              | 10 ++--
>  kernel/bpf/syscall.c             |  4 --
>  kernel/bpf/verifier.c            | 14 +++---
>  17 files changed, 84 insertions(+), 71 deletions(-)
>
> diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
> index 973ceae48675..639a2736f029 100644
> --- a/arch/arc/net/bpf_jit_core.c
> +++ b/arch/arc/net/bpf_jit_core.c
> @@ -1400,7 +1400,7 @@ static struct bpf_prog *do_extra_pass(struct bpf_pr=
og *prog)
>   * (re)locations involved that their addresses are not known
>   * during the first run.
>   */
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         vm_dump(prog);
>
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index e6b1bb2de627..1628b6fc70a4 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -2142,7 +2142,7 @@ bool bpf_jit_needs_zext(void)
>         return true;
>  }
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         struct bpf_binary_header *header;
>         struct jit_ctx ctx;
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index cd5a72fff500..7212ec89dfe3 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2006,7 +2006,7 @@ struct arm64_jit_data {
>         struct jit_ctx ctx;
>  };
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         int image_size, prog_size, extable_size, extable_align, extable_o=
ffset;
>         struct bpf_binary_header *header;
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fcc8c0c29fb0..5149ce4cef7e 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1920,7 +1920,7 @@ int arch_bpf_trampoline_size(const struct btf_func_=
model *m, u32 flags,
>         return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
>  }
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         bool extra_pass =3D false;
>         u8 *image_ptr, *ro_image_ptr;
> diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
> index d2b6c955f18e..6ee4abe6a1f7 100644
> --- a/arch/mips/net/bpf_jit_comp.c
> +++ b/arch/mips/net/bpf_jit_comp.c
> @@ -909,7 +909,7 @@ bool bpf_jit_needs_zext(void)
>         return true;
>  }
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         struct bpf_binary_header *header =3D NULL;
>         struct jit_context ctx;
> diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_cor=
e.c
> index 35dca372b5df..172770132440 100644
> --- a/arch/parisc/net/bpf_jit_core.c
> +++ b/arch/parisc/net/bpf_jit_core.c
> @@ -41,7 +41,7 @@ bool bpf_jit_needs_zext(void)
>         return true;
>  }
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         unsigned int prog_size =3D 0, extable_size =3D 0;
>         bool extra_pass =3D false;
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 711028bebea3..27fecb4cc063 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -129,7 +129,7 @@ bool bpf_jit_needs_zext(void)
>         return true;
>  }
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *fp)
>  {
>         u32 proglen;
>         u32 alloclen;
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.=
c
> index 527baa50dc68..768ac686b359 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -41,7 +41,7 @@ bool bpf_jit_needs_zext(void)
>         return true;
>  }
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         unsigned int prog_size =3D 0, extable_size =3D 0;
>         bool extra_pass =3D false;
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 2dfc279b1be2..94128fe6be23 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -2312,7 +2312,7 @@ static struct bpf_binary_header *bpf_jit_alloc(stru=
ct bpf_jit *jit,
>  /*
>   * Compile eBPF program "fp"
>   */
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *fp)
>  {
>         struct bpf_binary_header *header;
>         struct s390_jit_data *jit_data;
> diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_co=
mp_64.c
> index e83e29137566..2fa0e9375127 100644
> --- a/arch/sparc/net/bpf_jit_comp_64.c
> +++ b/arch/sparc/net/bpf_jit_comp_64.c
> @@ -1477,7 +1477,7 @@ struct sparc64_jit_data {
>         struct jit_ctx ctx;
>  };
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         struct sparc64_jit_data *jit_data;
>         struct bpf_binary_header *header;
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 77d00a8dec87..72d9a5faa230 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3713,7 +3713,7 @@ struct x64_jit_data {
>  #define MAX_PASSES 20
>  #define PADDING_PASSES (MAX_PASSES - 5)
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         struct bpf_binary_header *rw_header =3D NULL;
>         struct bpf_binary_header *header =3D NULL;
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.=
c
> index 5f259577614a..852baf2e4db4 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -2518,7 +2518,7 @@ bool bpf_jit_needs_zext(void)
>         return true;
>  }
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
>  {
>         struct bpf_binary_header *header =3D NULL;
>         int proglen, oldproglen =3D 0;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index d396e55c9a1d..83f37d38c5c1 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1107,6 +1107,8 @@ static inline int sk_filter_reason(struct sock *sk,=
 struct sk_buff *skb,
>         return sk_filter_trim_cap(sk, skb, 1, reason);
>  }
>
> +struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env,=
 struct bpf_prog *fp,
> +                                          int *err);
>  struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err);
>  void bpf_prog_free(struct bpf_prog *fp);
>
> @@ -1152,7 +1154,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4,=
 u64 r5);
>         ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
>          (void *)__bpf_call_base)
>
> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog);
>  void bpf_jit_compile(struct bpf_prog *prog);
>  bool bpf_jit_needs_zext(void);
>  bool bpf_jit_inlines_helper_call(s32 imm);
> @@ -1187,12 +1189,25 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf=
_prog *prog, u32 off,
>  #ifdef CONFIG_BPF_SYSCALL
>  struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 o=
ff,
>                                      const struct bpf_insn *patch, u32 le=
n);
> +struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env =
*env);
> +void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
> +                              struct bpf_insn_aux_data *orig_insn_aux);
>  #else
>  static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_e=
nv *env, u32 off,
>                                                    const struct bpf_insn =
*patch, u32 len)
>  {
>         return ERR_PTR(-ENOTSUPP);
>  }
> +
> +static inline struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf=
_verifier_env *env)
> +{
> +       return NULL;
> +}
> +
> +static inline void bpf_restore_insn_aux_data(struct bpf_verifier_env *en=
v,
> +                                            struct bpf_insn_aux_data *or=
ig_insn_aux)
> +{
> +}
>  #endif /* CONFIG_BPF_SYSCALL */
>
>  int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index fc9fb3c07866..79361aa11757 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1491,23 +1491,6 @@ void bpf_jit_prog_release_other(struct bpf_prog *f=
p, struct bpf_prog *fp_other)
>         bpf_prog_clone_free(fp_other);
>  }
>
> -static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
> -{
> -#ifdef CONFIG_BPF_SYSCALL
> -       struct bpf_map *map;
> -       int i;
> -
> -       if (len <=3D 1)
> -               return;
> -
> -       for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> -               map =3D prog->aux->used_maps[i];
> -               if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY)
> -                       bpf_insn_array_adjust(map, off, len);
> -       }
> -#endif
> -}
> -
>  /*
>   * Now this function is used only to blind the main prog and must be inv=
oked only when
>   * bpf_prog_need_blind() returns true.
> @@ -1580,13 +1563,6 @@ struct bpf_prog *bpf_jit_blind_constants(struct bp=
f_verifier_env *env, struct bp
>
>                 if (env)
>                         env->prog =3D clone;
> -               else
> -                       /*
> -                        * Instructions arrays must be updated using abso=
lute xlated offsets.
> -                        * The arrays have already been adjusted by bpf_p=
atch_insn_data() when
> -                        * env is not NULL.
> -                        */
> -                       adjust_insn_arrays(clone, i, rewritten);
>
>                 /* Walk new program and skip insns we just inserted. */
>                 insn =3D clone->insnsi + i + insn_delta;
> @@ -2555,47 +2531,55 @@ static bool bpf_prog_select_interpreter(struct bp=
f_prog *fp)
>         return select_interpreter;
>  }
>
> -static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
> +static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *en=
v, struct bpf_prog *prog)
>  {
>  #ifdef CONFIG_BPF_JIT
>         struct bpf_prog *orig_prog;
> +       struct bpf_insn_aux_data *orig_insn_aux;
>
>         if (!bpf_prog_need_blind(prog))
> -               return bpf_int_jit_compile(prog);
> +               return bpf_int_jit_compile(env, prog);
> +
> +       if (env) {
> +               /*
> +                * If env is not NULL, we are called from the end of bpf_=
check(), at this
> +                * point, only insn_aux_data is used after failure, so it=
 should be restored
> +                * on failure.
> +                */
> +               orig_insn_aux =3D bpf_dup_insn_aux_data(env);
> +               if (!orig_insn_aux)
> +                       return prog;
> +       }
>
>         orig_prog =3D prog;
> -       prog =3D bpf_jit_blind_constants(NULL, prog);
> +       prog =3D bpf_jit_blind_constants(env, prog);
>         /*
>          * If blinding was requested and we failed during blinding, we mu=
st fall
>          * back to the interpreter.
>          */
>         if (IS_ERR(prog))
> -               return orig_prog;
> +               goto out_restore;
>
> -       prog =3D bpf_int_jit_compile(prog);
> +       prog =3D bpf_int_jit_compile(env, prog);
>         if (prog->jited) {
>                 bpf_jit_prog_release_other(prog, orig_prog);
> +               if (env)
> +                       vfree(orig_insn_aux);
>                 return prog;
>         }
>
>         bpf_jit_prog_release_other(orig_prog, prog);
> +
> +out_restore:
>         prog =3D orig_prog;
> +       if (env)
> +               bpf_restore_insn_aux_data(env, orig_insn_aux);
>  #endif
>         return prog;
>  }
>
> -/**
> - *     bpf_prog_select_runtime - select exec runtime for BPF program
> - *     @fp: bpf_prog populated with BPF program
> - *     @err: pointer to error variable
> - *
> - * Try to JIT eBPF program, if JIT is not available, use interpreter.
> - * The BPF program will be executed via bpf_prog_run() function.
> - *
> - * Return: the &fp argument along with &err set to 0 for success or
> - * a negative errno code on failure
> - */
> -struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
> +struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env,=
 struct bpf_prog *fp,
> +                                          int *err)
>  {
>         /* In case of BPF to BPF calls, verifier did all the prep
>          * work with regards to JITing, etc.
> @@ -2623,7 +2607,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf=
_prog *fp, int *err)
>                 if (*err)
>                         return fp;
>
> -               fp =3D bpf_prog_jit_compile(fp);
> +               fp =3D bpf_prog_jit_compile(env, fp);
>                 bpf_prog_jit_attempt_done(fp);
>                 if (!fp->jited && jit_needed) {
>                         *err =3D -ENOTSUPP;
> @@ -2649,6 +2633,22 @@ struct bpf_prog *bpf_prog_select_runtime(struct bp=
f_prog *fp, int *err)
>
>         return fp;
>  }
> +
> +/**
> + *     bpf_prog_select_runtime - select exec runtime for BPF program
> + *     @fp: bpf_prog populated with BPF program
> + *     @err: pointer to error variable
> + *
> + * Try to JIT eBPF program, if JIT is not available, use interpreter.
> + * The BPF program will be executed via bpf_prog_run() function.
> + *
> + * Return: the &fp argument along with &err set to 0 for success or
> + * a negative errno code on failure
> + */
> +struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
> +{
> +       return __bpf_prog_select_runtime(NULL, fp, err);
> +}
>  EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
>
>  static unsigned int __bpf_prog_ret1(const void *ctx,
> @@ -3136,7 +3136,7 @@ const struct bpf_func_proto bpf_tail_call_proto =3D=
 {
>   * It is encouraged to implement bpf_int_jit_compile() instead, so that
>   * eBPF and implicitly also cBPF can get JITed!
>   */
> -struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_verifier_env *en=
v, struct bpf_prog *prog)
>  {
>         return prog;
>  }
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index ec8afd6a9369..6ef213429a2a 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -991,7 +991,7 @@ static void bpf_restore_subprog_starts(struct bpf_ver=
ifier_env *env, u32 *orig_s
>                 env->subprog_info[i].start =3D orig_starts[i];
>  }
>
> -static struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifi=
er_env *env)
> +struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env =
*env)
>  {
>         size_t size;
>         void *new_aux;
> @@ -1003,8 +1003,8 @@ static struct bpf_insn_aux_data *bpf_dup_insn_aux_d=
ata(struct bpf_verifier_env *
>         return new_aux;
>  }
>
> -static void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
> -                                     struct bpf_insn_aux_data *orig_insn=
_aux)
> +void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
> +                              struct bpf_insn_aux_data *orig_insn_aux)
>  {
>         /* the expanded elements are zero-filled, so no special handling =
is required */
>         vfree(env->insn_aux_data);
> @@ -1147,7 +1147,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
>                 func[i]->aux->might_sleep =3D env->subprog_info[i].might_=
sleep;
>                 if (!i)
>                         func[i]->aux->exception_boundary =3D env->seen_ex=
ception;
> -               func[i] =3D bpf_int_jit_compile(func[i]);
> +               func[i] =3D bpf_int_jit_compile(env, func[i]);
>                 if (!func[i]->jited) {
>                         err =3D -ENOTSUPP;
>                         goto out_free;
> @@ -1191,7 +1191,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
>         }
>         for (i =3D 0; i < env->subprog_cnt; i++) {
>                 old_bpf_func =3D func[i]->bpf_func;
> -               tmp =3D bpf_int_jit_compile(func[i]);
> +               tmp =3D bpf_int_jit_compile(env, func[i]);
>                 if (tmp !=3D func[i] || func[i]->bpf_func !=3D old_bpf_fu=
nc) {
>                         verbose(env, "JIT doesn't support bpf-to-bpf call=
s\n");
>                         err =3D -ENOTSUPP;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b73b25c63073..a3c0214ca934 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3083,10 +3083,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, u32 uattr_size)
>         if (err < 0)
>                 goto free_used_maps;
>
> -       prog =3D bpf_prog_select_runtime(prog, &err);
> -       if (err < 0)
> -               goto free_used_maps;
> -
>         err =3D bpf_prog_mark_insn_arrays_ready(prog);
>         if (err < 0)
>                 goto free_used_maps;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9e4980128151..e804e0da3500 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20155,6 +20155,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>
>         adjust_btf_func(env);
>
> +       /* extension progs temporarily inherit the attach_type of their t=
argets
> +          for verification purposes, so set it back to zero before retur=
ning
> +        */
> +       if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT)
> +               env->prog->expected_attach_type =3D 0;
> +
> +       env->prog =3D __bpf_prog_select_runtime(env, env->prog, &ret);
> +
>  err_release_maps:
>         if (ret)
>                 release_insn_arrays(env);
> @@ -20166,12 +20174,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>         if (!env->prog->aux->used_btfs)
>                 release_btfs(env);
>
> -       /* extension progs temporarily inherit the attach_type of their t=
argets
> -          for verification purposes, so set it back to zero before retur=
ning
> -        */
> -       if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT)
> -               env->prog->expected_attach_type =3D 0;
> -
>         *prog =3D env->prog;
>
>         module_put(env->attach_btf_mod);
> --
> 2.47.3
>
