Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8E8462
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776031308; cv=pass; b=AC5bQpa6G+g+iDD7+SHjjkH8twbQVtl/eXgJEU3efFnczFXnhI3eT80Vbij5RjZ3nOgPH9iSmVZNYehVgvWTbYW4bGAydXkt+SskuriFLBcEqQaPWSAA7xsah513fLdsHwphrNxeKl/fXAFGKpNyLevCz/bAYkp4vrvM0N+hctw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776031308; c=relaxed/simple;
	bh=Wl5r0KoZl60h1vi2OjLDGU1Al5P3vHNy2XwYEXT6EX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHVv0qKd+0jhtp0wcwGBg/Urd7wv533t+4WDXYTNmMAE6k8G3e17OMGjZ7fVJdlrTjxl0LZqSddiM/gq98RDAknwCpMAMY3E92qWsW6i3jxw7pyXmwY7k2+6xjGT8TzJGp5SmfctR4iev49r89ySntkLSHZ8eOyMwPBmN08BUww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNFQ+P0V; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNFQ+P0V"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfd96354aso2152672f8f.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 15:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776031305; cv=none;
        d=google.com; s=arc-20240605;
        b=D6hvVg+/fOj3caqbvsaPV9t5mD3Z2n941c/1wHoZSlWYkJ13tMzEmkO3r8djBSNEz4
         s0SksaVvy8gUQ/qhlqosFWVlOCipDVJRRJ/mNVysfLCnRdFw0eTxeyJAetOTxYfkDuRg
         Kdz0MYBxhrhQUUPzlvNC2hhSMefixoA5sSMVchs3PHPRc/ppHBO3sHZ/ijScRmIV7nic
         htuY7C9Tpwf522inURP/zbD4wpypltp4HNrq2cDpK96VVEO7OBJuis9cf1reFpnyhj4w
         GekP+/9vfAgPSIlWBmHOs0PLm2rrxlmsn/FyaIEWpcYghXKqpqbgQQ/5p6amMdCw1Lel
         Ou9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TfnXqDCHcRY/LzAbs10LIxuAcX2gBnNVQzV8SepgC7Y=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=LnMPi5BBjsAoIGw9xRbnk3xw4LremvsP7KTxakJbJ/eWk3TUSkT+QaEg/U7rbxVDNj
         aVEl/VoyhKEaNPxrevGs46b0HzhSLmUg1Pw8YeZ/EZpjgi31FWiOjecDXzprtLx5Z8yq
         or7v1M+OiON7Htq64Bv8fOufMLiePZlkCIkByMx77PNn2kvGcGpSOq08/MB69DT1/Pw2
         NgaOGr9hjwA5/jsrhTie3rk2cKy6QU6AAAh32/PowXestiOE9IZpRfmPoW1mAtcb+W8M
         jqG4GIpIojtF2Iod0MBxkel3eIJ+G7aFEcJsuSy3nFcIXuis2FOuw6BM+Mkn2fEA2waq
         2saQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776031305; x=1776636105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfnXqDCHcRY/LzAbs10LIxuAcX2gBnNVQzV8SepgC7Y=;
        b=gNFQ+P0V4vamWtMnLV2+mApy0JH7SCdIbSmpku+cQ7ul8+C7evDrRF+Ze1ph21UMe7
         BuDaIeRgyXJ4YBpni75+HRLhN7XJNKeZi7tWdlW6g591JZ3QY7Y1flHMntPwpYzXV1Sy
         OVa+0kcZZ5JfscF++zSNR41weAvocP5L3jHqSSKFfTAl0674RHAUwg5Sm+83PsKvBQ1k
         f7uE99Hy2ccUBe9osUesZIvtkDqFjBH1ivYhbXn0/SckK1uwwg/jB0nvefIG1geQnyjQ
         SsC9HuWPYez8FrAYELfL149oPvKYppHziMoIOkrEhfUEoAQIim/pS0ECvR5+OWOYmmKd
         M8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776031305; x=1776636105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfnXqDCHcRY/LzAbs10LIxuAcX2gBnNVQzV8SepgC7Y=;
        b=juIi1g1uBqotr5YfSteToXVqGk25+RSY0Mm0BFP/G8ND/xoH3ONzVG3x4/z+Foy3sy
         xPUO2l5CKhoYas9D00Ci5Pk0QIcZTbsxn+jhsMOk8JAG0GMDUyQ/d0qs86l8ujVyvv1J
         C9gHE946D5stltdip/rJrKAA23mQ6EW8S4HWR9Ct4o/jGnsniCxk5ZG+NjC4gTfi6HV/
         L3d9CoULPSxwwBb/B3gS6X8b/O90fBVyMF1y+G+3sq62EEbZO+SjMUv/dsDI3a4M3yAO
         GyNSSf6blgeJQV7x+UNBK/wztL0YeYcmSdFoCw9Eyml6Pz9z9kc/a0/1GWLxLd1KRNnC
         jFww==
X-Gm-Message-State: AOJu0YzIExkU0kckymKTiGmmlECAa7dpz2P0WBQV8W/eIyp+fV8VZxGj
	f+a5ns8poYJVpjjZz3wQ22VomKzy43c86Q+wxM906+pZsBGhT+ywW9B0okEGFA5DliK4YvPLY4S
	axA7kwdHmhgx/nJVMR9pB/REYVxrfZno=
X-Gm-Gg: AeBDiesqAPV2vqEWmvmrHj2XsZ+WBl4XdhMbqXJXSYWJKFOceLkLKHr4M42Gp20rYsx
	4WaKKIuglomisrgi4fKpl+nV4/cYEF0eEGUadLOOdAAsbeuWUGAkYnhwRIVUTEKE06Ieeg/PHS+
	pqhmx7Yv8lwykJPPX1f3TyhC3yjxOJdQrSW0jWEWIgYe8Z8MeH2qr3AQEmZNEiRfjjmHPk0MhWu
	ZeChGld7mAl1l8Qng5WGp3t1+o85TX9tEuC9TdBQkl8BZuae1PglfbimhI1K67bcJ0uirpt9zGB
	ov4+GVWS4bi2No3XvEYFZmn05BMIO9oDRvTKxDzwoBkYxr3DiveEVCaT9O2TjaQ2eJLs+NF7O3B
	aRka2Sr1e+Yo77093cEBbcPdDqw==
X-Received: by 2002:a5d:5f50:0:b0:43c:f7e5:817b with SMTP id
 ffacd0b85a97d-43d64271246mr16154810f8f.19.1776031305270; Sun, 12 Apr 2026
 15:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045826.254200-1-yonghong.song@linux.dev> <20260412045857.256260-1-yonghong.song@linux.dev>
In-Reply-To: <20260412045857.256260-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 15:01:34 -0700
X-Gm-Features: AQROBzCVJOf_mvlfdrP1jUkNxkzXyZI659FEFBwQjxRqATPpii5rC8RCcfm3FW4
Message-ID: <CAADnVQ+0JgQDosS5=+h=mUJM_Dn=bK-XBpiq1LfamUHTSTOEZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/18] bpf: Use argument index instead of
 register index in kfunc verifier logs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 9:59=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> For kfunc argument checking, use the argument index (arg#0, arg#1, ...)
> instead of the register index (R1, R2, ...) in verifier log messages.
> This is a preparation for future stack-based arguments where kfuncs can
> accept more than 5 arguments. Stack arguments won't have a corresponding
> register, so using argument index is more appropriate.
>
> Since some functions like check_mem_access(), check_stack_read_var_off(),
> and check_stack_range_initialized() are shared between kfunc argument
> checking (check_kfunc_args) and other paths (check_func_arg, do_check_ins=
n, ...),
> introduce a `reg_or_arg` encoding: a non-negative value represents a regi=
ster
> index, while a negative value encodes an argument index as -(argno + 1).
> The helper reg_arg_name() decodes this to produce either "R%d" or
> "arg#%d" for log messages.
>
> For check_func_arg() callers, in certain cases, the register index is
> preserved so existing helper function logs remain unchanged (e.g., "R1", =
"R2").
>
> Update selftests to expect the new "arg#N" format in kfunc error
> messages.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf_verifier.h                  |   1 +
>  kernel/bpf/verifier.c                         | 466 +++++++++---------
>  .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
>  .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
>  .../selftests/bpf/progs/cpumask_failure.c     |   4 +-
>  .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
>  .../selftests/bpf/progs/iters_testmod.c       |   6 +-
>  .../bpf/progs/local_kptr_stash_fail.c         |   2 +-
>  .../selftests/bpf/progs/map_kptr_fail.c       |   4 +-
>  .../bpf/progs/mem_rdonly_untrusted.c          |   2 +-
>  .../bpf/progs/nested_trust_failure.c          |   2 +-
>  .../selftests/bpf/progs/res_spin_lock_fail.c  |   2 +-
>  .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
>  .../selftests/bpf/progs/task_kfunc_failure.c  |   4 +-
>  .../bpf/progs/verifier_cgroup_storage.c       |   4 +-
>  .../selftests/bpf/progs/verifier_ctx.c        |   2 +-
>  .../bpf/progs/verifier_ref_tracking.c         |   2 +-
>  .../selftests/bpf/progs/verifier_sock.c       |   6 +-
>  .../selftests/bpf/progs/verifier_unpriv.c     |   4 +-
>  .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
>  .../testing/selftests/bpf/progs/wq_failures.c |   4 +-
>  tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
>  .../testing/selftests/bpf/verifier/map_kptr.c |  10 +-
>  23 files changed, 286 insertions(+), 267 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 05b9fe98b8f8..291f11ddd176 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -910,6 +910,7 @@ struct bpf_verifier_env {
>          * e.g., in reg_type_str() to generate reg_type string
>          */
>         char tmp_str_buf[TMP_STR_BUF_LEN];
> +       char tmp_reg_arg_name_buf[16];
>         struct bpf_insn insn_buf[INSN_BUF_SIZE];
>         struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>         struct bpf_scc_callchain callchain_buf;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54296d818d35..01df990f841a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2179,6 +2179,18 @@ static struct bpf_verifier_state *push_stack(struc=
t bpf_verifier_env *env,
>         return &elem->st;
>  }
>
> +static const char *reg_arg_name(struct bpf_verifier_env *env, int reg_or=
_arg)
> +{
> +       char *buf =3D env->tmp_reg_arg_name_buf;
> +       int len =3D sizeof(env->tmp_reg_arg_name_buf);
> +
> +       if (reg_or_arg >=3D 0)
> +               snprintf(buf, len, "R%d", reg_or_arg);
> +       else
> +               snprintf(buf, len, "arg#%d", -(reg_or_arg + 1));
> +       return buf;
> +}

The patches 1-4 make sense, but 5, 6 are too hacky.

-       { "incorrect_head_var_off1", "R1 doesn't have constant offset" },
+       { "incorrect_head_var_off1", "arg#0 doesn't have constant offset" }=
,

This just sucks.
It degrades output for no good reason.

Instead of inband negative vs positive signalling rename all
'regno' to 'argno' and always pass whatever argno you need 1,2,..5,6, etc

Pass ptr_reg and size_reg as bpf_reg_state the way patches 1-4 are doing.
If argno <=3D 5 keep 'R%d' output, so all selftest don't change.
For argno >=3D 6 print '*(R12-xx)' where xx is where that arg lives.
Printing arg# is too cryptic. Humans/agents need to do mental
gymnastics to understand what it means.
The output must be easy to consume by agents.

I was also thinking whether we can get rid of this 'argno' too.
cur_regs - reg is that number for <=3D 5 and
some spilled_ptr - reg for >=3D 6.
Technically we can

u32 argno =3D cur_regs - reg;
if (argno <=3D 5) use it
else
   argno =3D spilled_ptr - reg.

Feels a bit hacky. Need to sleep on it.

pw-bot: cr
