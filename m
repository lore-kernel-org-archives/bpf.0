Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FD3CAE7B
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288005; cv=none; b=GYjBgdObzr3KVLxkzuBs9J0sIncqIAZ8OWA9Hz1R376tZlsvPNc/NmFQtVhMSu1JDbteLpWCBx0I1EOIYNiFbG/7RpQg7uSwFiouLpy8JRrG9o34P3NF1RfgFr/ZuzU60fWJsPnk5qjBMRR2vz2ygmEx3ZMPRujN4f+LzD4Xh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288005; c=relaxed/simple;
	bh=u+IaULLqloKLkPKUNfwuuhLUl6obrLbG1y1vPmdRmh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ky2Ctcq5z1D5OcDomUSMLJZbormdSqfJAd9LUN1C7gB8rQ2Pq9/NWZhu+EF/jh9zf48trcS4IqQNgIcKeRWBt8D8HwLCJiQ03T5xe2NuxRFvVScg9lFNgvvnkVejNYrJyLLnJcuPS/fFc6LVxMF755+fRokYwCfwOtBaAn8SyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdcCVaZi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdcCVaZi"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439bcec8613so2094118f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774288002; x=1774892802; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6ofWU/RGuBDRp7u1lmeiL07G9nwE/mejSfwBc/pmLQ=;
        b=AdcCVaZikhoQ/5+g3TI4+IJCLZDgBUFGnifys8Da3yq0uQE73PWV+whPWXcpWs9BbV
         d+I59ec8GbYyUiCVF6t0retVOIqYd196ddMnaFkO7XzYNPkFtuTuMQtSE7Q7ytgWOLLw
         6QLW3sHHdVp0Gp8xcQ48oN+jPrBUDAR1yRHMAcLiN0vu5lp5aBwxVfk4VAj3SYafRNIh
         mUVYKex754wrdfr2cWBD3PXQF46gM+ov15Lkc7TzhHU9dk3sA+n+oq2Pty6oYIubAHJw
         SkDEJeLvKIVFs6tBqXCbXGBl4YS1go3uc9uvigttHmFAcw1QFEo+xZbg6+IoVXeVpd2b
         0cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288002; x=1774892802;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6ofWU/RGuBDRp7u1lmeiL07G9nwE/mejSfwBc/pmLQ=;
        b=gOUP/fJxhN7409Ozep/3WNQr3vBT5os/wz0UQ9qDcgzszpuQgGoiZiSD3QeuDAkXX0
         NV7h9V/GKbsl4p+vJK03jxVhSkZiXGUYogm5ekpax1BNhe2yvZ9zBtrOmrHgWPSt7gEO
         0vN2GLTDuB5J+AyXFtdX/eWj0ePmV2fKK8p6FbZhmKYTOWn/7T9RCM/ipHlLPrUXwcS4
         kGD5nAbskci0fd5kHdE0zam+ptNF3nRFjukzGxlpuge5hTdPOQuCu3shLjnavbzkVHjn
         JD5AfH6+BJFaMZUABYAbnYqxoqHkq3VRmHoOWAupGyirDcCgIBD8Ua75c/S0qbw1uY8h
         qqQw==
X-Forwarded-Encrypted: i=1; AJvYcCU5eN1+DTp4UUK/f1lY6zG5eqBNN/q2SZgvMWwHk5QuzMulIlwIzPfBmjtgyY7g8c4JqEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt6z80UpIwp1ITmaOlsRyv+jLgTjqDnQmRybvPcnBvwta4ajM+
	4y8W/Oa5ML3JaamigmIu5fbn2foo9FUUQSYtsC4SSEDdxOZzgaIp3Pnu
X-Gm-Gg: ATEYQzyATxMD7yr2zxkWJC+OrXenfPD2WuGVQzx3bKnlLH4h8GMKDvRWjASwzt98Ier
	q/Nm4hEb3dlVIS12N3dszi0tMJ0ha97wS856BtUoRaSgHlRdhHmkXIqhY6DyQoxmBYvxGLQC2wh
	NV2hsu+y1R8LZQLG7Ay+wZffrKdl7HX0tXNVEPsiRgxyoFDNpiofnmDDMxBWlrLNpI1iLJZ0qiD
	1GLF29aWvdZtg5BNsJma7jV9Hn/hSU+CoYJpiY4WpdYbZoAz/WeQkDLpSoGvJIW1iQ1Kc0idlsC
	5NGielTAJ8s9757ZQXEeg8G3aqMUs82pNbLhHjgUgt0BqrFN2wousS/s2Ij0SFj+n16THkbDJWZ
	K57JTeYIQEmb5el8lS1wFyBkEAVR/9WQym64n064c3gMfErFQYQMzv+LLkt/ut9jsDUKb7tNjqS
	8GyLDJee9BdjCh5FY=
X-Received: by 2002:a05:6000:4382:b0:43b:3f2d:7d43 with SMTP id ffacd0b85a97d-43b64242a62mr20427573f8f.8.1774288002374;
        Mon, 23 Mar 2026 10:46:42 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:a228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm33027390f8f.35.2026.03.23.10.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:46:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 5/6] selftests/bpf: Cover invariant
 violation cases from syzbot
In-Reply-To: <b82e9240f62200aae173a1c69c782f56ed7f8f21.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <b82e9240f62200aae173a1c69c782f56ed7f8f21.1774025082.git.paul.chaignon@gmail.com>
Date: Mon, 23 Mar 2026 17:46:41 +0000
Message-ID: <87ikamjv5q.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Chaignon <paul.chaignon@gmail.com> writes:

> This patch adds a selftest for the change in the previous patch. The
> selftest is derived from a syzbot reproducer from [1] (among the 22
> reproducers on that page, only 4 still reproduced on latest bpf tree,
> all being small variants of the same invariant violation).
>
> The test case failure without the previous patch is shown below.
>
>   0: R1=ctx() R10=fp0
>   0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
>   1: (bf) r5 = r0                       ; R0=scalar(id=1) R5=scalar(id=1)
>   2: (57) r5 &= -4                      ; R5=scalar(smax=0x7ffffffffffffffc,umax=0xfffffffffffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0; 0xfffffffffffffffc))
>   3: (bf) r7 = r0                       ; R0=scalar(id=1) R7=scalar(id=1)
>   4: (57) r7 &= 1                       ; R7=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>   5: (07) r7 += -43                     ; R7=scalar(smin=smin32=-43,smax=smax32=-42,umin=0xffffffffffffffd5,umax=0xffffffffffffffd6,umin32=0xffffffd5,umax32=0xffffffd6,var_off=(0xffffffffffffffd4; 0x3))
>   6: (5e) if w5 != w7 goto pc+1
>   verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xffffffd5, 0xffffffffffffffd4] s64=[0x80000000ffffffd5, 0x7fffffffffffffd4] u32=[0xffffffd5, 0xffffffd4] s32=[0xffffffd5, 0xffffffd4] var_off=(0xffffffd4, 0xffffffff00000000)
>
> R5 and R7 are prepared such that their tnums intersection results in a
> known constant but that constant isn't within R7's u32 bounds.
> is_branch_taken isn't able to detect this case today, so the verifier
> walks the impossible fallthrough branch. After regs_refine_cond_op and
> reg_bounds_sync refine R5 on the assumption that the branch is taken,
> the impossibility becomes apparent and results in an invariant violation
> for R5: umin32 is greater than umax32.
>
> The previous patch fixes this by using regs_refine_cond_op and
> reg_bounds_sync in is_branch_taken to detect the impossible branch. The
> fallthrough branch is therefore correctly detected as dead code.
>
> Link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5 [1]
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index 3724d5e5bcb3..818efa08404d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2070,4 +2070,28 @@ __naked void refinement_32bounds_not_overwriting_64bounds(void *ctx)
>  	: __clobber_all);
>  }
>  
> +/* Last jump can be detected as always taken because the intersection of R5 and
> + * R7 32bit tnums produces a constant that isn't within R7's s32 bounds.
> + */
> +SEC("socket")
> +__description("dead branch: tnums give impossible constant if equal")
> +__success
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void tnums_equal_impossible_constant(void *ctx)
> +{
> +	asm volatile("										\
> +	call %[bpf_get_prandom_u32];								\
> +	r5 = r0;										\
> +	r5 &= 0xfffffffffffffffc;	/* var_off32=(0; 0xfffffffc) */				\
> +	r7 = r0;										\
> +	r7 &= 0x1;			/* var_off32=(0x0; 0x1) */				\
> +	r7 += -43;			/* s32=[-43; -42] & var_off32=(0xffffffd4; 0x3) */	\
> +	if w5 != w7 goto +1;		/* on fallthrough var_off32=-44, not in s32 */		\
w5 has bits 0,1 zero, rest unknown
w7 has top bits known as 0xffffffd4, and bits 0,1 unknown
If w5 == w7, their tnums must intersect to a single
value = 0xffffffd4(-44). Which is outside of w7's range [-43; 42]. So
the r10 = 0 branch should be unreachable.
I guess the comment should be updated to the kernel style as well.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> +	r10 = 0;										\
> +	exit;											\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.43.0
