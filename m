Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8C207DF7
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156163; cv=pass; b=U3aGtUg7kca0d1tgz/C7R3wVSk0dX5nCRRWR5RIb5y1MZZyX+SB4ZEM86no7zxX2lZssrhqUl3Gi0x17uh2gWL1QATr7xsje3nff3mYFxOwwg2Y2/kcPOg5xroAJ1PaU/+zbJ7qhiAKS7mnND/cqSUTYexuX5Dw/PIqlKYE7XT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156163; c=relaxed/simple;
	bh=zSoPDQm3HFksqz3IFVRyZa/ow1US/NNB9c9N3TRpx4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/b0NSmyPUzNg26NWW6Na5NEe53SnmN6vHkzFc4WtvyxzEJWCL0+kzrOXEetU3tnj2F21ikfIKzu0QY6zFC3rZfXTKW3t4mfPTPrxlQB4pmJwDOZ2ztLbp96dvKhFXrBN3gc31LG9Ft8a9EavqNK9InJU+HnQZj0ce70aW/czM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tv6jOt+S; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tv6jOt+S"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6321jgQx511823
	for <bpf@vger.kernel.org>; Thu, 2 Apr 2026 11:56:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tD1tXAB3vCTpju1IJzfHPZmb53bqPQq94jx0EJZ8vJw=; b=tv6jOt+SqOx4
	JXe8htHUyrtfHpiVoKZTRwk0LFJ/dOBvVLiaf8cd7bj0wd5ZqBOGdO6123+RJpDm
	DTb3WsSgo36eWEBMpaecZ7h6TncxPFUL4owtGaEFLMQr8CIJtsokgDh5DW0FchSW
	Umf+WzmScMNnRIhktV+H8UYALyL/qi4VRiBEmnB/nMVyow7CqSN5rgNnwMy8iCvY
	2t/lRQxN8P4EmWQEXFGsBcVUbTFxZ4Ak0a67o0V0uKQYD0har+EgS7A/MmIGDuPE
	EjPIhjTusOUuzl0gtkkIV6cb8QJqZG+fYUhdbBT50RTndiU0aK+mZuuLwzeAR5RW
	4VoZxcyIJA==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d9byy6994-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 11:56:00 -0700 (PDT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9c4d00d361so89891266b.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 11:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775156159; cv=none;
        d=google.com; s=arc-20240605;
        b=DCD/HGVj/W9T4I9575YqUJklBk+kEJrEj+0kSYF58nJ+ZQa4utLvuPzMSI0r/eiNL9
         scwZa4CxypF5csu1SDSpgiVmI/gqN2hfT3eDcIplFemXUSixouePWzvGUGroSS89FRyz
         an4F/mIMj67ygN52bBtY9eU1k2gLnljOXXq1OzQH0IvN36GKDBns7nFUoi9s7Ldp32dR
         fneN5lg47GrQ/Ph7u92yU30wgzDmhj5o40qyzWh7y8wiEMOOjmOS+aOLNf5J8Dk5F58a
         sry03pS8MMf865pHPiiI9vPXXhOdDB6m6xIkr+UwcvDcveCil9I3zktFXThWhOfL/Tko
         ZyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=tD1tXAB3vCTpju1IJzfHPZmb53bqPQq94jx0EJZ8vJw=;
        fh=PvYPcwWkAFTdNDlHuRMEXK4H0X8YFjGgiYsXgOFIKvA=;
        b=PXPNulaiqpf5BwCItZpoq3pLEi1oJ4mwXITOjfAtxtRXjpvvfzIiI5ICTngrgVRQaH
         KCJ6H9XLrcx2oxmRIqQslaDh3YE7G1xvUjnvZUOMjmO+67ljA1NI3aYXC77yzMsJqmzz
         AQMyuWWWvew6YfN2th6UqdVVjkO7JRseEtjTBJWMJ+UPzU37udY+d+Xs7O2YhZS17uU+
         6u6i10o5mG8sM/fQw62/TSMm58swk0nXgJceXz5Q4FtOipu9VLeVNhm8bcocxRCbbJ/u
         wqkCv8Uqtrg1vzv98pTXZY1YKXRhlIxNvu03Eg+cZ8l2uqlxsPYvkSWx9dtKoCyWXGBF
         LMqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775156159; x=1775760959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tD1tXAB3vCTpju1IJzfHPZmb53bqPQq94jx0EJZ8vJw=;
        b=gwB2Nvr02i9SuAVaLQFfLXtCOD5yhY0XDkcxw49BtxnthPRRxLEZ67H6br/+AHSABY
         0bxwdqjirhoa/poCPH0S+GsFoyUzwyxOp4y2myyrhNAUgTbD0qj/0gN/Ru6dBecCA+ez
         EITAz6RdIcoDdra7cPWCtUbqAAgBJh6XdlF0X74osSQ7Z34xgvL+IvGTl+YzHqlp4UA9
         R4rC7OzhZkWHK/taNDu+967s1OzGxuQtyymq09YNr+QTjYz5l3m6Bk7FpuhBQn3nYqJl
         ga6qZ3I4Lz7kPKtDKMoZ9fHgb2oBLyQuxekfNxK1pe5XfUDy2f35wgY0/NuuVxevAHw0
         4EYg==
X-Gm-Message-State: AOJu0YzFafpy9waUmYYVjs/dzbPTee0TlM8orhymG+eZygZr6OPUKXfi
	g9bZaBY6tpJbQm54WO9wiyV9v3LW18q2jcyyMjNsrA8S4G27eTcEF5tuq0IP/Abknv0wIDgcc6c
	qcO+SfVECbF7ejFh+pgFSPzhoKNMRM8NAobAWCrcQhgxKeGiXd7B5SGkAwOXlfTA4TSQGYh08kO
	4/wDTf63QEEEEtgnukui4RtWZtxSI=
X-Gm-Gg: ATEYQzzbWeuZWuHNwyNWFBn9ImDmmEgaxU3x/OpAthQXpDuo4/toVo7e0OQxqcu6tdP
	9Cql5T3w7l6UmNhKb14nTt3tJ1xToZoHV9Mbm9wMcW3eHpzaHFVJyQ/Fr/D0mbg0sOewZFpJWfQ
	SQIUEhhLZ4CTk4s2a6OdTHuqr/432QjzGtW+MshzXog5UjGWz5rX0dGb2ypy8/5N2ACIBia3vDg
	dktKw==
X-Received: by 2002:a17:907:9705:b0:b98:13de:a16 with SMTP id a640c23a62f3a-b9c67a10a98mr1663466b.39.1775156159080;
        Thu, 02 Apr 2026 11:55:59 -0700 (PDT)
X-Received: by 2002:a17:907:9705:b0:b98:13de:a16 with SMTP id
 a640c23a62f3a-b9c67a10a98mr1659566b.39.1775156158422; Thu, 02 Apr 2026
 11:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev> <20260402012742.3917613-1-yonghong.song@linux.dev>
In-Reply-To: <20260402012742.3917613-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@meta.com>
Date: Thu, 2 Apr 2026 11:55:45 -0700
X-Gm-Features: AQROBzCWKIWo6TcrspnYA4t6Wu_A655SxIjdP1ZJw06pjo1lAYfyL9o6fV6LsOs
Message-ID: <CAP17u3OdrYpJpx2z0gQ9OosuA-cj6etc0CwX4FyBCmM-PEn_-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: IDuHhnr0s0OwrB3ArXh5pOhQYe6jCozX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE2OSBTYWx0ZWRfXzZizqSs4RIkq
 Z2pbKny0tVeRVoc+XRAVHGG71g6IZUXXQRuv5UjJe8eHW1QZaBCnFB5bel4Q1Nq0jwVbm0wmUnT
 qfsDORqGz0l45G92ouUGN+b6gRyAIEe6JFVLcgDT4BWRKXsG3fCEDbHIjV5cQpn6RJjlaKIVb0g
 nYAG7DgSqk51cmprBRlnylkWmIkw6r6HP6NYaMkBHRX0DDQ6dVNqBsARus7xGBpcO1bb3YndND5
 PRKktOsBRPNB0clYoVPdXvdX8udhWvqC6gMbkpsEJSmnDfAJTtLUGebeCY1TNJaJtInPs2rtXd+
 qxdlKfOr4mjEAItFNdteKvoYMf7HieOQvEptil/xQfe7nQmQWC1W3RZbpcWLybq0gOkwhyaTc/2
 cZ7zMFY/oDbMvz3j/+LHccBrxz+0zFyETb9lgd5QaCOO78/hvfCy9761E/64+Ic3Wh8CbrpaWHE
 Jju3M9QWJ4zdUsOpvqg==
X-Authority-Analysis: v=2.4 cv=KczfcAYD c=1 sm=1 tr=0 ts=69cebbc0 cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=NEAV23lmAAAA:8 a=2TprN7I0qojieAk2pGoA:9 a=QEXdDO2ut3YA:10
 a=PsfoTyiJ_72bb7xyA04f:22
X-Proofpoint-ORIG-GUID: IDuHhnr0s0OwrB3ArXh5pOhQYe6jCozX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01

On Wed, Apr 1, 2026 at 6:27=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Currently BPF functions (subprogs) are limited to 5 register arguments.
> With [1], the compiler can emit code that passes additional arguments
> via a dedicated stack area through bpf register
> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
>
> The following is an example to show how stack arguments are saved
> and transferred between caller and callee:
>
>   int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>     ...
>     bar(a1, a2, a3, a4, a5, a6, a7, a8);
>     ...
>   }
>
> The following is a illustration of stack allocation:
>
>    Caller (foo)                           Callee (bar)
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    r12-relative stack arg area:           r12-relative stack arg area:
>
>    r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from =
caller's outgoing r12-24)
>    r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from =
caller's outgoing r12-32)
>                                      ||+> r12-24: [incoming arg 8] (from =
caller's outgoing r12-40)
>    ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>    r12-24: [outgoing arg 6 to callee]+||   ...
>    r12-32: [outgoing arg 7 to callee]-+|
>    r12-40: [outgoing arg 8 to callee]--+
>
>   The caller writes outgoing args past its own incoming area.
>   At the call site, the verifier transfers the caller's outgoing
>   slots into the callee's incoming slots.
>
> The verifier tracks stack arg slots separately from the regular r10
> stack. A new 'bpf_stack_arg_state' structure mirrors the existing stack
> slot tracking (spilled_ptr + slot_type[]) but lives in a dedicated
> 'stack_arg_slots' array in bpf_func_state. This separation keeps the
> stack arg area from interfering with the normal stack and frame pointer
> (r10) bookkeeping.
>
> If the bpf function has more than one calls, e.g.,
>
>   int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>     ...
>     bar1(a1, a2, a3, a4, a5, a6, a7, a8);
>     ...
>     bar2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
>     ...
>   }
>
> The following is an illustration:
>
>    Caller (foo)                           Callee (bar1)
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    r12-relative stack arg area:           r12-relative stack arg area:
>
>    r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from =
caller's outgoing r12-24)
>    r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from =
caller's outgoing r12-32)
>                                      ||+> r12-24: [incoming arg 8] (from =
caller's outgoing r12-40)
>    ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>    r12-24: [outgoing arg 6 to callee]+||  ...
>    r12-32: [outgoing arg 7 to callee]-+|
>    r12-40: [outgoing arg 8 to callee]--+
>    ...
>    Back from bar1
>    ...                                     Callee (bar2)
>    =3D=3D=3D                                     =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>                                      +---> r12-8:  [incoming arg 6] (from=
 caller's outgoing r12-24)
>                                      |+--> r12-16: [incoming arg 7] (from=
 caller's outgoing r12-32)
>                                      ||+-> r12-24: [incoming arg 8] (from=
 caller's outgoing r12-40)
>                                      |||+> r12-32: [incoming arg 9] (from=
 caller's outgoing r12-48)
>    ---- incoming/outgoing boundary   ||||  ---- incoming/outgoing boundar=
y
>    r12-24: [outgoing arg 6 to callee]+|||  ...
>    r12-32: [outgoing arg 7 to callee]-+||
>    r12-40: [outgoing arg 8 to callee]--+|
>    r12-48: [outgoing arg 9 to callee]---+
>
> Global subprogs with >5 args are not yet supported.
>
>   [1] https://github.com/llvm/llvm-project/pull/189060
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h          |   2 +
>  include/linux/bpf_verifier.h |  15 ++-
>  kernel/bpf/btf.c             |  14 +-
>  kernel/bpf/verifier.c        | 248 ++++++++++++++++++++++++++++++++---
>  4 files changed, 257 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e24c4a2e95f7..a0a1e14e4394 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1666,6 +1666,8 @@ struct bpf_prog_aux {
>         u32 max_pkt_offset;
>         u32 max_tp_access;
>         u32 stack_depth;
> +       u16 incoming_stack_arg_depth;
> +       u16 stack_arg_depth; /* both incoming and max outgoing of stack a=
rguments */
>         u32 id;
>         u32 func_cnt; /* used by non-func prog as the number of func prog=
s */
>         u32 real_func_cnt; /* includes hidden progs, only used for JIT an=
d freeing progs */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..a260610cd1c1 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -268,6 +268,11 @@ struct bpf_retval_range {
>         bool return_32bit;
>  };
>
> +struct bpf_stack_arg_state {
> +       struct bpf_reg_state spilled_ptr; /* for spilled scalar/pointer s=
emantics */
> +       u8 slot_type[BPF_REG_SIZE];
> +};
> +
>  /* state of the program:
>   * type of all registers and stack info
>   */
> @@ -319,6 +324,10 @@ struct bpf_func_state {
>          * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
>          */
>         int allocated_stack;
> +
> +       u16 stack_arg_depth; /* Size of incoming + max outgoing stack arg=
s in bytes. */
> +       u16 incoming_stack_arg_depth; /* Size of incoming stack args in b=
ytes. */
> +       struct bpf_stack_arg_state *stack_arg_slots;
>  };
>
>  #define MAX_CALL_FRAMES 8
> @@ -674,10 +683,12 @@ struct bpf_subprog_info {
>         bool keep_fastcall_stack: 1;
>         bool changes_pkt_data: 1;
>         bool might_sleep: 1;
> -       u8 arg_cnt:3;
> +       u8 arg_cnt:4;
>
>         enum priv_stack_mode priv_stack_mode;
> -       struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +       struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
> +       u16 incoming_stack_arg_depth;
> +       u16 outgoing_stack_arg_depth;
>  };
>
>  struct bpf_verifier_env;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..c5f3aa05d5a3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7887,13 +7887,19 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
>         }
>         args =3D (const struct btf_param *)(t + 1);
>         nargs =3D btf_type_vlen(t);
> -       if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> -               if (!is_global)
> -                       return -EINVAL;
> -               bpf_log(log, "Global function %s() with %d > %d args. Bug=
gy compiler.\n",
> +       if (nargs > MAX_BPF_FUNC_ARGS) {
> +               bpf_log(log, "Function %s() with %d > %d args not support=
ed.\n",
> +                       tname, nargs, MAX_BPF_FUNC_ARGS);
> +               return -EINVAL;
> +       }
> +       if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
> +               bpf_log(log, "Global function %s() with %d > %d args not =
supported.\n",
>                         tname, nargs, MAX_BPF_FUNC_REG_ARGS);
>                 return -EINVAL;
>         }
> +       if (nargs > MAX_BPF_FUNC_REG_ARGS)
> +               sub->incoming_stack_arg_depth =3D (nargs - MAX_BPF_FUNC_R=
EG_ARGS) * BPF_REG_SIZE;
> +
>         /* check that function is void or returns int, exception cb also =
requires this */
>         t =3D btf_type_by_id(btf, t->type);
>         while (btf_type_is_modifier(t))
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..d424fe611ef8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1488,6 +1488,19 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
>                 return -ENOMEM;
>
>         dst->allocated_stack =3D src->allocated_stack;
> +
> +       /* copy stack_arg_slots state */
> +       n =3D src->stack_arg_depth / BPF_REG_SIZE;
> +       if (n) {
> +               dst->stack_arg_slots =3D copy_array(dst->stack_arg_slots,=
 src->stack_arg_slots, n,
> +                                                 sizeof(struct bpf_stack=
_arg_state),
> +                                                 GFP_KERNEL_ACCOUNT);
> +               if (!dst->stack_arg_slots)
> +                       return -ENOMEM;
> +
> +               dst->stack_arg_depth =3D src->stack_arg_depth;
> +               dst->incoming_stack_arg_depth =3D src->incoming_stack_arg=
_depth;
> +       }
>         return 0;
>  }
>
> @@ -1529,6 +1542,25 @@ static int grow_stack_state(struct bpf_verifier_en=
v *env, struct bpf_func_state
>         return 0;
>  }
>
> +static int grow_stack_arg_slots(struct bpf_verifier_env *env,
> +                               struct bpf_func_state *state, int size)
> +{
> +       size_t old_n =3D state->stack_arg_depth / BPF_REG_SIZE, n;
> +
> +       size =3D round_up(size, BPF_REG_SIZE);
> +       n =3D size / BPF_REG_SIZE;
> +       if (old_n >=3D n)
> +               return 0;
> +
> +       state->stack_arg_slots =3D realloc_array(state->stack_arg_slots, =
old_n, n,
> +                                              sizeof(struct bpf_stack_ar=
g_state));
> +       if (!state->stack_arg_slots)
> +               return -ENOMEM;
> +
> +       state->stack_arg_depth =3D size;
> +       return 0;
> +}
> +
>  /* Acquire a pointer id from the env and update the state->refs to inclu=
de
>   * this new pointer reference.
>   * On success, returns a valid pointer id to associate with the register
> @@ -1699,6 +1731,7 @@ static void free_func_state(struct bpf_func_state *=
state)
>  {
>         if (!state)
>                 return;
> +       kfree(state->stack_arg_slots);
>         kfree(state->stack);
>         kfree(state);
>  }
> @@ -5848,6 +5881,101 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
>         return err;
>  }
>
> +/* Validate that a stack arg access is 8-byte sized and aligned. */
> +static int check_stack_arg_access(struct bpf_verifier_env *env,
> +                                 struct bpf_insn *insn, const char *op)
> +{
> +       int size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> +
> +       if (size !=3D BPF_REG_SIZE) {
> +               verbose(env, "stack arg %s must be %d bytes, got %d\n",
> +                       op, BPF_REG_SIZE, size);
> +               return -EINVAL;
> +       }
> +       if (insn->off % BPF_REG_SIZE) {
> +               verbose(env, "stack arg %s offset %d not aligned to %d\n"=
,
> +                       op, insn->off, BPF_REG_SIZE);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +/* Check that a stack arg slot has been properly initialized. */
> +static bool is_stack_arg_slot_initialized(struct bpf_func_state *state, =
int spi)
> +{
> +       u8 type;
> +
> +       if (spi >=3D (int)(state->stack_arg_depth / BPF_REG_SIZE))
> +               return false;
> +       type =3D state->stack_arg_slots[spi].slot_type[BPF_REG_SIZE - 1];
> +       return type =3D=3D STACK_SPILL || type =3D=3D STACK_MISC;
> +}
> +
> +/*
> + * Write a value to the stack arg area.
> + * off is the negative offset from the stack arg frame pointer.
> + * Callers ensures off is 8-byte aligned and size is BPF_REG_SIZE.
> + */
> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bp=
f_func_state *state,
> +                                int off, int value_regno)
> +{
> +       int spi =3D (-off - 1) / BPF_REG_SIZE;
> +       struct bpf_func_state *cur;
> +       struct bpf_reg_state *reg;
> +       int i, err;
> +       u8 type;
> +
> +       err =3D grow_stack_arg_slots(env, state, -off);
> +       if (err)
> +               return err;
> +
> +       cur =3D env->cur_state->frame[env->cur_state->curframe];
> +       if (value_regno >=3D 0) {
> +               reg =3D &cur->regs[value_regno];
> +               state->stack_arg_slots[spi].spilled_ptr =3D *reg;
> +               type =3D is_spillable_regtype(reg->type) ? STACK_SPILL : =
STACK_MISC;

It seems any spillable register can be passed to the callee, so reg
containing ref_obj_id can be spilled to stack_arg_slots. However,
release_reference() does not invalidate ref_obj_id in stack_arg_slots.
Can this cause UAF like below?

a6 =3D bpf_task_acquire(t);
if (!a6)
        goto err;

// a6 now has a valid ref_obj_id
// foo1 calls bpf_task_release(a6);
foo1(a1, a2, a3, a4, a5, a6);

// a6 still has a valid ref_obj_id
// foo2 dereference a6 -> UAF
foo2(a1, a2, a3, a4, a5, a6);

Since stack_arg_slots is separated from the normal stack slots, other
types of stale registers may exist in the outgoing stack slots. For
example:
- stale pkt pointer after calling clear_all_pkt_pointers() in callee
- register with inprecise nullness after calling
mark_ptr_or_null_regs() in callee


> +               for (i =3D 0; i < BPF_REG_SIZE; i++)
> +                       state->stack_arg_slots[spi].slot_type[i] =3D type=
;
> +       } else {
> +               /* BPF_ST: store immediate, treat as scalar */
