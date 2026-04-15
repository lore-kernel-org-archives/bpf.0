Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD513264C0
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776295453; cv=pass; b=dSHLfL/gRLErLbb92z1TDyEYgEXAHPSzE1x0nyM5K5nmZfGpl2/cQiE0ads8yFzEs3pMXSDwkRsysfsiZT20NUIvZtoPf1ZoT7iCO35TmrBnbq9FKumE0W3otXoBRsm2r4UeMWcZiE3ryjq8hxdemWl9YakOOcG6Ho8H75xqkvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776295453; c=relaxed/simple;
	bh=OzPJl9BtKUk2JKGbS+i7ViR2AYPd6xWLRn2D5pNDjV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4QRlzdujSwJtqFRBKDdW1s45SIKHgFIXoR2EgdCJRCZHd7bbCLsL3GxPE0APlo09Eji4vfBj1uduhz+E0iLW8wvCemEv8eQKM4Mgkd8F/6V6BxxylKRL67h13JXrZ3pFdHsg5dALHLdRG8tcVb1xPE9vi/xUp0gbSpxqg97lag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vcZGIbeH; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vcZGIbeH"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FJZ9sg2761622
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:24:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=gr8IedKU+80kKkbBb+bUbs0RFW/yxzweYmY9E3NxZxQ=; b=vcZGIbeHWy1u
	InWGWJGALlb/ChU8JLTHsL6SboovIC6KNWfvsU9liFWmwnumtntU4byuHXwRQLrr
	DvhZhKAyRb7KDe9H1zsBjnkp2+ptV+YeS0c0PBM/dAF6ZaDvYnzKGv01de2iCjZZ
	nGp02FJx7TnHhE54QrkUEvpygULpl79KsOOUoKNa3d4bMjwGTArK8saSgUr32dat
	lN4p6RnNiT0PIYci5fafzURO91jeFGBFwRyRkgk2JXwxQzfaWmVEt56kOh5z7tFG
	cIYjQB2QxzmO6rhX0vE/Qbb/iJXHktY2OsQwHHMf4hNwqSwsat0/uvHXPLdlUEZg
	UfCSg9GEfA==
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh864xvc5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:24:11 -0700 (PDT)
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-66c165a7a8cso6190504a12.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776295450; cv=none;
        d=google.com; s=arc-20240605;
        b=CiWEy2BRRSAqXGrQmNC8F4+yVJBTmKNE3k5zX0dQylMyQ+UF53j4hxxCiRTclqpdXv
         db7F7HjqgZK3ugCykOpuljLAP5NUYjy+IjWT9DzIxAf+iCro/e0CA2KKyiBSfBAzMXYK
         k42NMqLR1a5KT3uzyemwdicPJbu5BeNIWr2Jrx8MkKQv1docFPt9yqL/UxnlYhz/UI5P
         E3A/j9+iin5Gkh8rJ81VUU9mB1p/07Vq0SrJn4wXyjltfiQqZvibpsSVoyZgvlwrSdOc
         iVVFk4ENJx7ybVf+h1vK9JMXgw8NOcRwTCrsr/fgpqn7jGa9y5UGOS3ylb2kKzazupvy
         PO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=gr8IedKU+80kKkbBb+bUbs0RFW/yxzweYmY9E3NxZxQ=;
        fh=2preLHJWrZUJHAHysLerVW1HApTZILl946/QdWHD3dc=;
        b=adtjn86FDXIK2rWVlLwUATgd2O/hCScrFqCKf73YeYNBqz8Va38/qGU9JjMWkgA91i
         Gzd0saMln6m/TduY+piE6k/Rv3JLGJwf3NbK2DHvHdpfB13RtKRQcK5UFPOpfAXk3Hfe
         KPBNOUsr2Ke1OX+Nf/cx0y03UF4nn6O+HIaXw/urNgx+MvFTi+2skRK1eZQXurbwkXYQ
         ZTyoNB5k5R1qyN+tRIP03Zm85WNNLYrEe0N7VMxMHL+iQ2jEAQxEHUyhuc+HIQQi/SmQ
         bnEXApC4ul53m1Rl33uNChoq86hT/8JSzARd3S0nz00ISeFKjZHl5bmAMGzFNYKf2hPY
         vsag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776295450; x=1776900250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gr8IedKU+80kKkbBb+bUbs0RFW/yxzweYmY9E3NxZxQ=;
        b=iHCdmHcfzcyI8uSDS2l2lCqPvP8ZqB+fAda+IPCI53N0fq9W362QsrF/e/LaK3ZhCg
         eisdp4Xa2BBz/v2FS8TEvVFeo+Je+hXwGGXhmbq1LCih4lURDlGRGlYR+pVm5JdGvLPK
         MRoJ7pbYnwEyawPtboVuPvcm+TRAHZ2+5VtjcegHkzFMx3c3qPpa4W+ytAic0z1nFeGv
         V/qDsmpTa7+HKP5DGcW9FJRX8yTVt5VgfZ98p3XON1QZmFZae7sJ1y3fYUzc29UgPOyR
         yIyTvE2fA4qmuELGgvcPNtsaLKeavuYo0APYi6rVYgM+Jzv2TLfaFV79PPF6dpxUOf7t
         ohiw==
X-Forwarded-Encrypted: i=1; AFNElJ8G9ZT7+I2CutfBe3ARtom+1dumctHJj7jICB58TYIkDfIix8vNMGwUW2Q7IKpnCPKPLfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWIKa589yc48bj5Q7BLrUWMyZxZ62fhMKx07hD9edj4TAn3Ck
	o1962+3lQSYzf6XgFkMnp2e01Q5+EZGa5s4Vji5MBXY7H1zKfX9YhorNmY3QeMslugwMEaMk6S6
	pm/UhBzZVhGTugXLip1/V/bOeH85UiDRYNJZqaEJ6WxZlJ5OaWGRhKHekrE7QMakhOlehoy0rYf
	FKQzr4aXg/A4kzUUtTD/jxCDSucJk=
X-Gm-Gg: AeBDieslUlmBjcufKiKxNnWSdLVqGAnjQdocLzcSMRXp/OKKFjGHFTD4kMMt99ud2Sv
	XCbKwZlb69rO2GNLWaKwbr1XZm2d1VH4m6+ACXi4f+T46D61wZTqwRg0F0JheLUjLfIDFYdFyCN
	BwWwvxmhV065ZW28tmHx6cGfhJddHyLDRltzTmHaLPrPKtSX0N0S87q5YiNTRxK92sm+nTm8Rij
	yphZTZ0dfr4DyKT
X-Received: by 2002:a05:6402:4548:b0:66e:2f86:ab1b with SMTP id 4fb4d7f45d1cf-6707903f71fmr8801126a12.8.1776295449819;
        Wed, 15 Apr 2026 16:24:09 -0700 (PDT)
X-Received: by 2002:a05:6402:4548:b0:66e:2f86:ab1b with SMTP id
 4fb4d7f45d1cf-6707903f71fmr8801116a12.8.1776295449340; Wed, 15 Apr 2026
 16:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412045857.256260-1-yonghong.song@linux.dev> <CAADnVQ+0JgQDosS5=+h=mUJM_Dn=bK-XBpiq1LfamUHTSTOEZA@mail.gmail.com>
In-Reply-To: <CAADnVQ+0JgQDosS5=+h=mUJM_Dn=bK-XBpiq1LfamUHTSTOEZA@mail.gmail.com>
From: Amery Hung <ameryhung@meta.com>
Date: Wed, 15 Apr 2026 16:23:58 -0700
X-Gm-Features: AQROBzA9BhQkGPJ0gDKlulzyntbSZKzrBXZagClszibyAiW9NiNXQsvyJAMr774
Message-ID: <CAP17u3PdGDRfE09g7rDqTaMZG_Q_Py1zVb3xKaVQUccUMVN5zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/18] bpf: Use argument index instead of
 register index in kfunc verifier logs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=PJ8/P/qC c=1 sm=1 tr=0 ts=69e01e1b cx=c_pps
 a=DTy5UCxgudPLKrSn28m7Kw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=pGLkceISAAAA:8 a=5xLGJ1x0EgSuhNTXbG8A:9 a=QEXdDO2ut3YA:10
 a=VzYV69SsQLkmnS9OQLw-:22
X-Proofpoint-GUID: ELXyKw74rmFuZZWFaFm1Rz5Nx9Y2_xDb
X-Proofpoint-ORIG-GUID: ELXyKw74rmFuZZWFaFm1Rz5Nx9Y2_xDb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDIxOSBTYWx0ZWRfXyyacDvIHZ+Ye
 TSCK7UzSKj5k+B1npoJTz/awhAzAvZrOUM17D3OwtRCgQyosxYK7F6H2yupObmq1LIA8TLK9Nbp
 HbaDmkbE8PBg7EGuTj1FVy+Fr0d4q7Eg8coYyC1L3BtlNuYJn7rjuCIBLAnloecnaqmepCeOPVS
 xejRQDAlvJPLN19CSwxbrjE7KG8vbc8zwlo+w7HzppAAzYI5K2BaaUFD5du2Iu3UGBzQYfOT9Fh
 YvkqBABIa/x/+FHYRDsT6xcRL4S3pgIQdSQ25yg8xI2Z4L0qQgedr+wMtLCTNC9PnKChcZKLdBA
 lF8JOO65QGLQz66sLzPth6UIwp7nRwKs8Hfs1OsepaL2xNbpHCR3bepvXZ5dND3eYEg8hig9+5u
 GWL6zgMJ0lW+Z/e+HRQZ1OuXS3C2NPczFbUggp/DroecPGSGOrdIlW1uolsL9G47ujwTA7Oj5P4
 /XBhuyYSV2ixxFn7udw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01

On Sun, Apr 12, 2026 at 3:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Apr 11, 2026 at 9:59=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> > For kfunc argument checking, use the argument index (arg#0, arg#1, ...)
> > instead of the register index (R1, R2, ...) in verifier log messages.
> > This is a preparation for future stack-based arguments where kfuncs can
> > accept more than 5 arguments. Stack arguments won't have a correspondin=
g
> > register, so using argument index is more appropriate.
> >
> > Since some functions like check_mem_access(), check_stack_read_var_off(=
),
> > and check_stack_range_initialized() are shared between kfunc argument
> > checking (check_kfunc_args) and other paths (check_func_arg, do_check_i=
nsn, ...),
> > introduce a `reg_or_arg` encoding: a non-negative value represents a re=
gister
> > index, while a negative value encodes an argument index as -(argno + 1)=
.
> > The helper reg_arg_name() decodes this to produce either "R%d" or
> > "arg#%d" for log messages.
> >
> > For check_func_arg() callers, in certain cases, the register index is
> > preserved so existing helper function logs remain unchanged (e.g., "R1"=
, "R2").
> >
> > Update selftests to expect the new "arg#N" format in kfunc error
> > messages.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  include/linux/bpf_verifier.h                  |   1 +
> >  kernel/bpf/verifier.c                         | 466 +++++++++---------
> >  .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
> >  .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
> >  .../selftests/bpf/progs/cpumask_failure.c     |   4 +-
> >  .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
> >  .../selftests/bpf/progs/iters_testmod.c       |   6 +-
> >  .../bpf/progs/local_kptr_stash_fail.c         |   2 +-
> >  .../selftests/bpf/progs/map_kptr_fail.c       |   4 +-
> >  .../bpf/progs/mem_rdonly_untrusted.c          |   2 +-
> >  .../bpf/progs/nested_trust_failure.c          |   2 +-
> >  .../selftests/bpf/progs/res_spin_lock_fail.c  |   2 +-
> >  .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
> >  .../selftests/bpf/progs/task_kfunc_failure.c  |   4 +-
> >  .../bpf/progs/verifier_cgroup_storage.c       |   4 +-
> >  .../selftests/bpf/progs/verifier_ctx.c        |   2 +-
> >  .../bpf/progs/verifier_ref_tracking.c         |   2 +-
> >  .../selftests/bpf/progs/verifier_sock.c       |   6 +-
> >  .../selftests/bpf/progs/verifier_unpriv.c     |   4 +-
> >  .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
> >  .../testing/selftests/bpf/progs/wq_failures.c |   4 +-
> >  tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
> >  .../testing/selftests/bpf/verifier/map_kptr.c |  10 +-
> >  23 files changed, 286 insertions(+), 267 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 05b9fe98b8f8..291f11ddd176 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -910,6 +910,7 @@ struct bpf_verifier_env {
> >          * e.g., in reg_type_str() to generate reg_type string
> >          */
> >         char tmp_str_buf[TMP_STR_BUF_LEN];
> > +       char tmp_reg_arg_name_buf[16];
> >         struct bpf_insn insn_buf[INSN_BUF_SIZE];
> >         struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
> >         struct bpf_scc_callchain callchain_buf;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 54296d818d35..01df990f841a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2179,6 +2179,18 @@ static struct bpf_verifier_state *push_stack(str=
uct bpf_verifier_env *env,
> >         return &elem->st;
> >  }
> >
> > +static const char *reg_arg_name(struct bpf_verifier_env *env, int reg_=
or_arg)
> > +{
> > +       char *buf =3D env->tmp_reg_arg_name_buf;
> > +       int len =3D sizeof(env->tmp_reg_arg_name_buf);
> > +
> > +       if (reg_or_arg >=3D 0)
> > +               snprintf(buf, len, "R%d", reg_or_arg);
> > +       else
> > +               snprintf(buf, len, "arg#%d", -(reg_or_arg + 1));
> > +       return buf;
> > +}
>
> The patches 1-4 make sense, but 5, 6 are too hacky.
>
> -       { "incorrect_head_var_off1", "R1 doesn't have constant offset" },
> +       { "incorrect_head_var_off1", "arg#0 doesn't have constant offset"=
 },
>
> This just sucks.
> It degrades output for no good reason.
>
> Instead of inband negative vs positive signalling rename all
> 'regno' to 'argno' and always pass whatever argno you need 1,2,..5,6, etc

+1 to avoid using a negative/positive range to signal a stack argument
or not, and to eliminate passing regno/argno.

>
> Pass ptr_reg and size_reg as bpf_reg_state the way patches 1-4 are doing.
> If argno <=3D 5 keep 'R%d' output, so all selftest don't change.
> For argno >=3D 6 print '*(R12-xx)' where xx is where that arg lives.
> Printing arg# is too cryptic. Humans/agents need to do mental
> gymnastics to understand what it means.
> The output must be easy to consume by agents.
>
> I was also thinking whether we can get rid of this 'argno' too.
> cur_regs - reg is that number for <=3D 5 and
> some spilled_ptr - reg for >=3D 6.
> Technically we can
>
> u32 argno =3D cur_regs - reg;
> if (argno <=3D 5) use it
> else
>    argno =3D spilled_ptr - reg.
>
> Feels a bit hacky. Need to sleep on it.

The else case is actually even less pretty:
    argno =3D spilled_ptr - constainer_of(reg, struct
bpf_stack_arg_state, spilled_ptr);

How about dropping slot_type since it is always STACK_SPILL or
STACK_MISC and that can be inferred anytime by just calling
is_spillable_regtype():
-struct bpf_stack_arg_state *stack_arg_slots;
+bpf_reg_state *stackarg_regs;

Then:
argno =3D reg - (reg < stackargs_regs) ? cur_regs :  stackarg_regs;

>
> pw-bot: cr
