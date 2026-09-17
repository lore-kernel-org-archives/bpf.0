Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A63AFB11
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682147; cv=pass; b=Va6QODT4ocZ+fI0Rv7vPELYp54jRSLslYc/Q8yrNwKKkLNAdPa7ZsFlECY4giURW+kKZ9VNYP45/niUNwhz3Bo0XJKrt0//vNlwuwcrVkdSPfTUqjmNtGzLqGeEAq+YDSc3GORhTuuzsEiyzgA8St7NsYru48zVaLIA3i3ezrS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682147; c=relaxed/simple;
	bh=r5AAXgGugm3v2tQRXLU9oLkE8RaEdqh2fNPhKUIWSPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/OUQhY2TDxtYEb53hweYHefA3NF1/xaPvdzq/B1TrWmha70XIKCEvYHP9XVwn/HujJ3x/tcT6Qj7+AGdU+78+1gr1kmlPtRzJBlnNKJbDPhH2IVI3kakp80Lz9RB2LBPmMYq4YIABMxeDpSCxoaxwfyOkeHVvTZdoXJyArpypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4ihjB/r; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4ihjB/r"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso122023a91.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 14:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789682145; cv=none;
        d=google.com; s=arc-20260327;
        b=VbHrkJf6uRddIrGwxehM0E79UPrB7lq6fegxiroFvJoPgPVe8NQBo8dKQb5N4INoLj
         n2GmOOyPNCttR7FiitHihmG7wCGwNUkE5lUsZA3BmLNHaD76e4CbEGzuuOucaO/lkkg6
         Jux223oB0zz0s+Aeiyj1l+GG7qhpW+CHVoruBJ1ueWeSlFZFx51venKVORJlLuI+n3qt
         vS0vFSonj5QqKSJkHkWFAoznzzX/ZtTsQcw2iJ60YVMMbWvNuGaid89oPa+56EZbWRks
         qeBnm5G1+4ZNR2F2qOfVi/tzyRGd1KhPXyckRl0ZyOOgGmNV/+7mb6TwLGwrSppOWnKX
         jvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5EASeNTIRY3EzSaEHQDClxhZTBndb032SMhOR0ZVmSc=;
        fh=C04JRxmZvwYu9XacjSeq34vlH3FZnhtgX1KvBV2i/kI=;
        b=P4LTvOTBLSmzJSUmbC2O7uVx9adJ2Yg08/R8EPN/53kIi11yckq4OkO0+HFDdDNgee
         78FvnxnFZSOJUYlB1tlV4kzuRt+v3NEnCEw5f+be92vVnzIuyaRpC6+bbxcnOumHMQMC
         ESWgyRPhT+jMgGxtuxmQM6QubBK5tqJHRrnojocjLuOWeCZm5N8rHXFlKozdAi1ls0M+
         vaPhReVbqu6BAcQNcfUl68w+I11MJOYK/szM8szfFB4tLaT/oTCt6v2YTPPObgalaY8l
         3bq6W6CkWh+EYSPRIlfYv/bZTJi+aToT1Zl6UvzP9gq9r4W99+SoFcNs/qXYX5xJQpab
         Nc+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789682145; x=1790286945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5EASeNTIRY3EzSaEHQDClxhZTBndb032SMhOR0ZVmSc=;
        b=o4ihjB/r0PFW2ZOxKokVlGz5XHUjXDbUU8LjgXhJ+TpznAYV+4WWlOxYGmlsDpgbyT
         k0mFXPEGEhtbdSs41k+dSIXZHhZUQBjyE5Rd/W/ojNEqrEkNsGyb//zvXVxPWuX5vTSv
         deGWznKZYK6bNPM5SE+xKqYy8HWWrgST0xDSvUsEVjcI4+CqtUFSG4uxU/lbTTGRR7CQ
         ONt4qMJWD/S+rBTMHo+8KwsUoBWtnJAaBYHHIakv78H0rxtbF0I4HBNwZ8LOOSC+s9xm
         8hTpu4xiUFbr8ICvcKSQPl+/r+ZnZcG8BKK4ybIEfTHu4MApk2HV+ETQ5FssCUN62fxZ
         xvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682145; x=1790286945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EASeNTIRY3EzSaEHQDClxhZTBndb032SMhOR0ZVmSc=;
        b=2WXFCnkWkQt+Gli5pImgUgRPO5rEMpr5HyFcyBLb/MThiomy9r9SEp38PAozGlXvjn
         bPTYkBxYwY3WWfLmtgH2VC2Hk4stVyA5K9a4gqULi2zX33pF0X/FxrmweuEvDagzsXPN
         yCwhQsEpFem6qitBh4DAWvSsC5bl2PtmC/aJRv8N1xR034yI6KKffJhS2WZ1EoIE4gV6
         FYeEL28VaWtx5CLOiclNVgAl6+lmBw+BDaKFb+GD0K7ksNkigvVvr1RBs9z+UNl7MOeH
         kPiAndDX9TMAiSK0Mn+wIHc0ZWtIlCbVwuagV2VmncmrIfq6+w3VmoXVyUCVSb71AkFM
         Bg1A==
X-Gm-Message-State: AFuF++lUqZkk/z8xBtNrCL6Gby/Jqid/gzADfdX8PZfqShpKNjj91gzp
	4hXKi2qM+kPaPLOPcTljgZig+QtbNKaV2HDPCeodCqfhZhm1SYHnQi6AOpyExUkoKMVytVj96nE
	RkYkm/XqT+zvO9coy1sxwstV4z5fnJ90=
X-Gm-Gg: AYBFou2AwgByFF0HDSFGnz/va9ntc6TBWLg5mgYQ3yzmG+sn1cMSF6bMZeEt6oHvuAW
	b5/VCLNliGIm9cNiiaeW8uGJtEAghn3pVLarX3WiTROLVCHCbQ4RpFMHGTCxC/mg2NqS5E6iA1J
	NgQ4cGE5s0LHcZK1UHI3yJyGSIGXS14zreicgMrgnapT1dphTpjp3gmHYF2v+Gz7tICfQMDqz9q
	t5H9c5vfr/B7dMdwsqXYStEu8HDsaYgX3LGZiDR9IHE92cIr8RJpzCsPhk4Dy5/D9xm3Yy8hmca
	RhcDMQWfddAEf29zx9SIVXffs3zkGnP7FJuPU5NDZOY1e0zFR2Qw25sTCAsnBLwKrnz9X12lcOX
	U8XSkcg7c4iIZNptExQP9upFvIkupE4v7qTKCYC0CNoO2ywpUmFf2SQ==
X-Received: by 2002:a17:90b:48d0:b0:39d:ec24:5ffe with SMTP id
 98e67ed59e1d1-39e54d1115amr966673a91.9.1789682144756; Thu, 17 Sep 2026
 14:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911084314.3481637-1-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260911084314.3481637-1-xyx2021@mail.ustc.edu.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 14:55:29 -0700
X-Gm-Features: AcwNN1UboOOEPDuASCwC9MV3wugVSXw-VsdJ0RVnKW3dQCaOEBPZGPpkElxK3iE
Message-ID: <CAEf4BzbYzt-Riekpc-A=MfQft9ZELwSDSE8kkQO1ZOyR3O_FAg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject non-negative offsets in stack_slot_obj_get_spi()
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 1:43=E2=80=AFAM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> bpf_get_spi() computes (-off - 1) / BPF_REG_SIZE using C division,
> which truncates toward zero. For off =3D=3D 0, this produces spi 0, the
> same index used by the valid stack slot at fp-8.
>
> stack_slot_obj_get_spi() currently checks alignment and the resulting
> spi bounds, but does not reject the non-negative offset itself. It can
> therefore validate a PTR_TO_STACK register holding fp+0 against an
> iterator stored at fp-8 even though the runtime receives the actual fp+0
> pointer. An effectful iterator kfunc can then interpret memory outside
> the BPF stack as iterator state.
>
> Reject non-negative offsets before converting the offset to an spi. All
> valid stack objects begin at a negative offset from the frame pointer.
> Add a verifier test that initializes an iterator at fp-8 and attempts to
> destroy it through fp+0.
>
> Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> ---


please split kernel fix and selftests into two patches, we only land
selftests together with kernel changes if kernel change breaks the
test, which I don't think is the case here

pw-bot: cr

> Please queue this fix for stable after it reaches the BPF tree.
>
> Tests:
>   - W=3D1 make O=3D<build> kernel/bpf/verifier.o (15071f-based candidate)
>   - make O=3D<build> -j12 bzImage modules (f77d212 baseline and candidate=
)
>   - strict clang-20 build of iters_state_safety.bpf.o (f77d212 candidate)
>   - test_progs -t iters -v --watchdog-timeout 180 --workers=3D1
>     - f77d212 baseline: 96 subtests pass; destroy_fp0_fail unexpectedly l=
oads
>     - f77d212 patched: 97/97 subtests pass
>   - panic_on_warn=3D1 and panic_on_oops=3D1; no warning, Oops, or BUG
>
> The four commits from f77d212 to this base only change sock-destroy netwo=
rking
> code and its selftests; the patch applies without conflict and verifier.c=
 is
> unchanged across that interval.
>
> A separate effectful reproducer is available privately on request.
> It was not rerun in this validation round.
> The full unfiltered BPF selftest suite was not run.
>
>  kernel/bpf/verifier.c                         |  2 +-
>  .../selftests/bpf/progs/iters_state_safety.c  | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b0b1fb628786..efbb446998848 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -567,7 +567,7 @@ static int stack_slot_obj_get_spi(struct bpf_verifier=
_env *env, struct bpf_reg_s
>         }
>
>         off =3D reg->var_off.value;
> -       if (off % BPF_REG_SIZE) {
> +       if (off >=3D 0 || off % BPF_REG_SIZE) {
>                 verbose(env, "cannot pass in %s at an offset=3D%d\n", obj=
_kind, off);
>                 return -EINVAL;
>         }
> diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/too=
ls/testing/selftests/bpf/progs/iters_state_safety.c
> index 646026430e9b5..e5bb9fe6d5e53 100644
> --- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
> +++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
> @@ -52,6 +52,28 @@ int create_and_destroy(void *ctx)
>         return 0;
>  }
>
> +/* fp+0 is not a stack slot. bpf_get_spi(0) used to alias spi 0 (fp-8). =
*/
> +SEC("?raw_tp")
> +__failure __msg("cannot pass in iter at an offset=3D0")
> +int destroy_fp0_fail(void *ctx)
> +{
> +       struct bpf_iter_num iter;
> +
> +       asm volatile ("r1 =3D %[iter];"
> +               "r2 =3D 0;"
> +               "r3 =3D 1000;"
> +               "call %[bpf_iter_num_new];"
> +               /* r10 is fp+0, one byte above the top of the BPF stack *=
/
> +               "r1 =3D r10;"
> +               "call %[bpf_iter_num_destroy];"
> +               :
> +               : __imm_ptr(iter), ITER_HELPERS
> +               : __clobber_common
> +       );
> +
> +       return 0;
> +}
> +
>  SEC("?raw_tp")
>  __failure __msg("Unreleased reference id=3D1")
>  int create_and_forget_to_destroy_fail(void *ctx)
>
> base-commit: 15071f2a1263e82150c77eeb1e94dbfc31950a8e
> --
> 2.43.0
>
