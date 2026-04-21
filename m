Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096123CFF46
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779325; cv=pass; b=GYkPRDLkF9LLAWV1n3EqHMDabudtArAPXpG5zLbunMi+Y0t3b1WCzzasC88ubp0i0gPUyTs47My4I1XiHTnywTIaEU3s3PrYp2D/oDyFCHcXD7M2vemoeOTok6R+J88F0qfiyWUvj3KSbtg6+f6RkC5FgtIl5QSSNu4ZL5shkB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779325; c=relaxed/simple;
	bh=3RJ3qPQCvtjaq3hzpgJUM5Kv98atQsuowUFk48E9osA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNRPbVrO+MuBgMV0LogCYzel1EtWFX20SmoTfCasH2ygPzzvfl6YOXmi3J1yg0hoLlZ/18mXobGHjkD7rc4SAPruxXbs3XbmDJD0DmRjFaAJ3JC5qsANfHrrnLyDvUMsY47+iKwd/LUl6kST2U+WaEtSXq3ReQP0mh8/noj1l+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDwNfgmR; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDwNfgmR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so27478205e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 06:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776779322; cv=none;
        d=google.com; s=arc-20240605;
        b=DclxiLluGqVDrw1yB1fO0Ys95vNXMgQyXjR5H3xGYk3p1PA+QE0m0iiqteNkhvAg0G
         4oWx8Znd+HWXuogeoSYJY7aIHVytNkRTLtiLFkXU+5oIAELTNdFTgXWdTBHj79A1l231
         bsSJJNNUAI5ULlt3Z7HpFwK1fSBpFxRQniafjf6L3imAVm5CkFji3W+GHMOPPqbTXdeN
         TO6aYJa/1928M6z8yH+yQznmizdfFUtYUG1a8TaO35XinsPFBDDgd44auYJTM/f1WYNP
         KPBHc/l4lZ7rO8EFVpnZLKtL4Kp2A1kmQYmC8M4sbHjWpBDHHjOUqVfaTDjM2BMN8UWN
         A6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YcwNNbCaC0VdXPkXaz9KyFuRXOspFj6q3Bxd5R9SMd4=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=lzmkVWZ3h2n70miwPqvi6g23PhGEEFJC6/k+6DogjTeExospMxZlQyqiXW3XpCu0W+
         +53ix0H15GUc19hWn15StMTCvI0uN1cWlpjOvKktDdQSidPkqHQBr5yNdgpGsJj7S++j
         XWniAOBj2ly4qjVRb11G6AJve7Isj2DGFVnTokesSxBpCHFHvtQi6bxlGyKOn7J38zaK
         6fGOGXrjb/qWfoL3EtLu3CT3MmRu04+kvuEArxxcEmdKw7QLsppnw7F9mUr7MbZ8RJfw
         Cuv2CzTfYms7jDc3H9JE/D6QLL7E5rqj3JUwh3Gnq3s/XxHyIl55SSvTmSIHeKKR7Ugv
         hrdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779322; x=1777384122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcwNNbCaC0VdXPkXaz9KyFuRXOspFj6q3Bxd5R9SMd4=;
        b=SDwNfgmR/wsYTgWpJszbt1fauUnWW7Dt409WZTTlnAFt5kkgdP2McDQXWE6wTeP395
         mygHEQJpkUKUWqUeEtk2MQ9LFyInyDMy3JabANykaukmTEmoxSbt766fyUctKfk3mgPW
         XHAeLgYzbCCeOO80IIxT4iy5TEStdLy6ybUPQobbY5kAi4Gk1bsrVHHLH58cI37fA8x6
         LckiWWC88bVn+qGE8JbylLCNasa4J7upU9ZlHcFv4cZbLD9adP0+nZmxW7a4ibvnBXOy
         Xx4E435Z4nrLmHfpENnS8xG8dMsUTMDXuuJeZhoN2RQFKvpST2PnPRHuRUmnP4r4eCRa
         jOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779322; x=1777384122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YcwNNbCaC0VdXPkXaz9KyFuRXOspFj6q3Bxd5R9SMd4=;
        b=fRoVpfrURz6PrGYLBKc84dXrI4Ng8tiqHnxwOujakcRdlky7rfo29zVJzOIi+sHujd
         Vpn/jsFW76IVQUxBHSMPyBgl6YYZnGp+/EutqT8kwkEQXQ6xxjOCm84uqQWHM86sFKKA
         QD4TmJh2CjCoO2kVpxSZZqo23EcSz2gMybtJyq9dZX1Opv19OpBCYDeuuLUsw2jc0jyx
         cWCrRtvVZ/TZ/3Unf9QybAjmWh20W5OFeiI3g8HrKUmR5h2jVO+hqSF+mml+2rQakD2u
         NpvX6JIEhUZqwGdZvA01Eqhh7r4XpFpoiH2KMIWbebmL94D1VHdRSi/8B2FRqqSEZmNx
         avZw==
X-Gm-Message-State: AOJu0YxUOhQuZqU3HurWzK2frZyDuaK+Yv6C8aV4pIxyjIxlohwiLFz7
	cuuW+k2T/1paHzOUd2NthQn5reudNXBYUoIYiGcyZJRpwvgg5eWsj1P8rs3gmNPGZpKpF45gYlV
	yw8MwfgFdciS2Ncvt6ejE8Q7ceI9L4Xo=
X-Gm-Gg: AeBDiesfWcI+BPbIrDJDgyzx8pkcAUb63uaxYP/LlxQZ3CmI7LhNUdLNjeQFg2zGlZY
	7DHlkEUKQuamTRC7j9OThxvhnsX4h7Okc+qJ6ZSfFtDsJJQUtmDznq6XL8kd08Tl0omOmSrhecy
	Ew2+g437vN9m1UwxcWysejYmR9RVAV/LWrqeh02Rj+eavkZCXLdR7FBzZ9f/QFTbsd/fJwjQ9L1
	fjOUG8T+Ey3LVbIQwMc9WppRA+YP1ChI1AgycDMtPhUb4Fki6E8/SuObRKfHrJX6EcSDcHMUWPN
	sLYHztK6+Z/fGgvyjRkVpQtfr73x4Ia6gC5HCdzybzU2IsTJabppRZ1VK1jOQGspbsP0oxZRavk
	oZwaLsoH2w7bcsSWz4pqGRr1Z43Cd7TGzfXgz
X-Received: by 2002:a05:600c:1554:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-488fb77810bmr269856645e9.14.1776779322092; Tue, 21 Apr 2026
 06:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163336.733654-1-yonghong.song@linux.dev> <DHYE574ZW4D7.2RNZPHN9QHT8@gmail.com>
 <2259b511-ca71-46a5-a416-8ea6ff0785b6@linux.dev>
In-Reply-To: <2259b511-ca71-46a5-a416-8ea6ff0785b6@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 06:48:30 -0700
X-Gm-Features: AQROBzBBTn-7UhFUyclqbKm1Tu22OuEVlwXMJjK3VYD5z72MidC-sxXUk0l7CCg
Message-ID: <CAADnVQ+fb4mY4ermo5GBtz1jx7kB4xsDGE23m2G8qEQa261VNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 04/17] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 11:07=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 4/20/26 5:03 PM, Alexei Starovoitov wrote:
> > On Sun Apr 19, 2026 at 9:33 AM PDT, Yonghong Song wrote:
> >> This change prepares verifier log reporting for upcoming kfunc stack
> >> argument support.
> >>
> >> Today verifier log code mostly assumes that an argument can be describ=
ed
> >> directly by a register number. That works for arguments passed in `R1`
> >> to `R5`, but it does not work once kfunc arguments can also be
> >> passed on the stack.
> >>
> >> Introduce an internal `argno` representation such that register-passed
> >> arguments keep using their real register numbers, while stack-passed
> >> arguments use an encoded value above a dedicated base.
> >> `reg_arg_name()` converts this representation into either `R%d` or
> >> `*(R11-off)` when emitting verifier logs. If a particular `argno`
> >> is corresponding to a stack argument, print `*(R11-off)`. Otherwise,
> >> print `R%d`. Here R11 presents the base of stack arguments.
> >>
> >> This keeps existing logs readable for register arguments and allows th=
e
> >> same log sites to handle future stack arguments without open-coding
> >> special cases.
> >>
> >> Update selftests accordingly.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   include/linux/bpf_verifier.h                  |   1 +
> >>   kernel/bpf/verifier.c                         | 649 ++++++++++------=
--
> >>   .../testing/selftests/bpf/prog_tests/bpf_nf.c |  22 +-
> >>   .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
> >>   .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
> >>   .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
> >>   .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  14 +-
> >>   .../selftests/bpf/progs/cpumask_failure.c     |  10 +-
> >>   .../testing/selftests/bpf/progs/dynptr_fail.c |  22 +-
> >>   .../selftests/bpf/progs/file_reader_fail.c    |   4 +-
> >>   tools/testing/selftests/bpf/progs/irq.c       |   4 +-
> >>   tools/testing/selftests/bpf/progs/iters.c     |   6 +-
> >>   .../selftests/bpf/progs/iters_state_safety.c  |  14 +-
> >>   .../selftests/bpf/progs/iters_testmod.c       |   4 +-
> >>   .../selftests/bpf/progs/iters_testmod_seq.c   |   4 +-
> >>   .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
> >>   .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
> >>   .../testing/selftests/bpf/progs/rbtree_fail.c |   6 +-
> >>   .../bpf/progs/refcounted_kptr_fail.c          |   2 +-
> >>   .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
> >>   .../selftests/bpf/progs/task_kfunc_failure.c  |  18 +-
> >>   .../selftests/bpf/progs/task_work_fail.c      |   6 +-
> >>   .../selftests/bpf/progs/test_bpf_nf_fail.c    |   8 +-
> >>   .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
> >>   .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
> >>   .../selftests/bpf/progs/verifier_bits_iter.c  |   4 +-
> >>   .../bpf/progs/verifier_ref_tracking.c         |   6 +-
> >>   .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
> >>   .../testing/selftests/bpf/progs/wq_failures.c |   2 +-
> >>   tools/testing/selftests/bpf/verifier/calls.c  |  14 +-
> >>   30 files changed, 474 insertions(+), 374 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
> >> index b148f816f25b..9fbbddc40d21 100644
> >> --- a/include/linux/bpf_verifier.h
> >> +++ b/include/linux/bpf_verifier.h
> >> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
> >>       * e.g., in reg_type_str() to generate reg_type string
> >>       */
> >>      char tmp_str_buf[TMP_STR_BUF_LEN];
> >> +    char tmp_reg_arg_name_buf[32];
> > the name is too long.
> > Just tmp_arg_name ?
> >
> >>      struct bpf_insn insn_buf[INSN_BUF_SIZE];
> >>      struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
> >>      struct bpf_scc_callchain callchain_buf;
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 3716d9688d00..6aa4dc161a56 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -1751,6 +1751,55 @@ static struct bpf_verifier_state *push_stack(st=
ruct bpf_verifier_env *env,
> >>      return &elem->st;
> >>   }
> >>
> >> +/*
> >> + * Unified argument number encoding for verifier log messages.
> >> + * Register args (arg_idx 0-4) use their register number (R1-R5).
> >> + * Stack args (arg_idx 5+) are encoded as STACK_ARGNO_BASE + arg_idx
> >> + * to avoid collision with register numbers. reg_arg_name() decodes
> >> + * this back to a human-readable string like "*(R11-8)" for logs.
> >> + */
> >> +#define STACK_ARGNO_BASE 100
> >> +
> >> +static bool is_stack_argno(int argno)
> >> +{
> >> +    return argno >=3D STACK_ARGNO_BASE;
> >> +}
> >> +
> >> +static u32 make_argno(u32 arg_idx)
> >> +{
> >> +    if (arg_idx < MAX_BPF_FUNC_REG_ARGS)
> >> +            return BPF_REG_1 + arg_idx;
> >> +    return STACK_ARGNO_BASE + arg_idx;
> >> +}
> >> +
> >> +static u32 arg_idx_from_argno(int argno)
> >> +{
> >> +    if (is_stack_argno(argno))
> >> +            return argno - STACK_ARGNO_BASE;
> >> +    return argno - BPF_REG_1;
> >> +}
> >> +
> >> +static int next_argno(int argno)
> >> +{
> >> +    return make_argno(arg_idx_from_argno(argno) + 1);
> >> +}
> > I don't like this +1, -1 dance all around. Makes the whole thing
> > hard to follow.
> > Keep argno starting at 1. So old regno =3D=3D argno.
>
> The above make_argno() returns an argno having regno =3D=3D argno
> for regno 1-5.

No. It doesn't.

it does:

+static u32 make_argno(u32 arg_idx)
+{
+    if (arg_idx < MAX_BPF_FUNC_REG_ARGS)
+            return BPF_REG_1 + arg_idx;

so for argno =3D=3D 0 it returns 1 and that's my objection.
Make argno starting at 1.
