Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AC1EA7CE
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773456053; cv=pass; b=Z1VvNT9ma0OMHFJMPCb/VsX6LC4K5cSERAcTmvT2rI97aDr6xho0mGgvfKfL5Ynd9fZF2eK1Evbg2qJvvgO2F504LIhnO+OqysaafjRDcqpUv/4d93p7uP26sdDOEa0/8aE+T6I/cVUhQ4MYuoY8Mqpil9H0ac9GWN2prtKKrl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773456053; c=relaxed/simple;
	bh=1mHmGaJvWxaYGxjuX05QyQWeGifGr9HzDG3fmX9QtD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IogJnVRs2xq+v+ipnTLh1CRiFIQx2TSmkvyn5zkreG/mSdHB03l1t6CWR2FCaYXVDQrj684vAZ9B/Ihi6oG9RPSNy60zhVWE1P2opot1NWuGGadvbTb6RmCtTArgsvnOK5nMNpphQvnmHrH5LkBmC43KySindoRe/Rr6I0XO5p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXWU2FMR; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXWU2FMR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439bcec8613so2206523f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 19:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773456051; cv=none;
        d=google.com; s=arc-20240605;
        b=V+Obua+k9D2BJeIrYupjDlCrLuoOZVWjBkeXe9YeqW5BoYTlhAjfqY5JT02Xcg8aaJ
         2sw/6Al4U9GzhA9jTEjgVNVoa55813sh1YF+ov6N8jbpapfwxhpbD+xGy1+eJCjgi0X0
         XApo3TBWU+oZw5WbWSq9tzXYB9b3RoW9Ez8Wa6ZWvrXUMEWkXPi7GFxI/sx7p7Xhx72n
         1Ys0HFYfxs7uWZ9LAO8oAgMQT9SJpcYUbB5AEGkXPBNu3QR+vNCpIRE3fPJOFNiei07x
         ib7no7uCrG4TC0mwL34sEbZzu8YqvSmgz1S7MH4ePXqmpVAo+HnioNAc5jPVB4SwxxEc
         WQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQ/xFyoFPUimJtdtrYmjPK92xNzXhudyV3hVp1U+iEU=;
        fh=3Tm13LMhab5Lv+9ktggVSR7AoHnYTXiPhK4SLQK+x+8=;
        b=UFKeFMAqF8PqQjXIKkylfqjH2JenZ5trXBXhaoXnHedzHQhLoGV/hk353LgMLq3VYt
         UcN/2OyMbaDHYa+hGgzVxNSgbjVg1fI062slyqn97z+H8/3tl6o1nCxa1WHKn3PjgoLa
         g9AEgtfiYiXyMQdCk6kI3Hb1MQ4vT7K169/bUdSF9HwbS9JIM8NIIGtMjno05/hvLrd3
         hgqmL1W6WwgIIKehDbRA3gc7noKlvNtQ8Gq6OaEFEB8Fv2nmod6WZUqhHi91cfMYO9QT
         zclIB3+ryTqDvbHROJFs6zw9zs/LoMxSTs/wdQ0AFrZo9vTonksX9TnwuV2J1Ahzdk3Q
         +oGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773456051; x=1774060851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ/xFyoFPUimJtdtrYmjPK92xNzXhudyV3hVp1U+iEU=;
        b=NXWU2FMRZNb1xGSBY/kT76QIwr6o4ABAd1HDd1u0lzyo3GFNMDQIDlKcOqwy1dWFZN
         hqOXI+sS/nuBKq9+CcTErS1eiWP05iLcKEfkRw5DY0zi121Tl78MKyxwgZ5X55aTAKcL
         rgiR4cQcoxqfBsxRSfIu4nibHH9pm1kTNkGdyhXXhmtuGXDXjYJUUyK1RH2j7wIIswfc
         ErczGG7bSUZiuH4S9iCHyD8oxvooSc7GxOJGMOUphrvMTm01dd+urL9wofqs84xvuxTW
         prbF09Pxf8BhJsk5wl5tNr/O1i7hLuAPbSMaVhVWUsOMDvVooUCOmYNfqg1F6cHZH19V
         BadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773456051; x=1774060851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQ/xFyoFPUimJtdtrYmjPK92xNzXhudyV3hVp1U+iEU=;
        b=XEY7yIwdGgE9UDuoOyRShiNBG1ye9QC2PaHqQjce7WHOFCqfVv9CVlyc+fKf09+rb9
         ogSO8aVDhTGZrWLrreNwh2wQ2P0FN2N9b36dU0nEOiPLIqAPFYQXWeSRYCVmTW3Eb2BB
         MvvVNK+HL41qET+s6G0iogrp2T8dJfFB8VtR64etXCeJq79axOEPB7+ufh28wGs8LZFZ
         p6tiRMkMw0NHpYC4RyamnFzLr3i2LJ1qFMVWNTktm167ryUg3wmIcHW3FrEQkG34UInD
         DmI3lKCn1hrmzC2ApJrX+p0PqWxzEnuA/h60cVnJM5e2d5whW50dC9jfzTju4bWQ5Xjy
         013w==
X-Gm-Message-State: AOJu0YzvQI3gEplSv/NxZZmHu9sc1IC4Zi5Lr7PCMSH9LkS1RkshtmUZ
	vMZa9hjRLhc4OUTS7pWV+AemW/Iw/3wqWrSgRQW8Z67MZey1NVju3e7OzE3dZa7hXbpvv5D6sj8
	EYps3hVRGq+hoj2mYS1LiyNmK7mCLAcM=
X-Gm-Gg: ATEYQzz8W7sFqw6Tcija2PpflgkYd5CVAzXdx+7nbElV7+SefJ7926ENdLsPlcFWFPS
	iHfRaYqa2Zbi1YMH6jyf/5ZNiL+OalYJbcMTF+FQSh+5o8hCREOG1OWAlk8fb0ZMY5BnYwGF24T
	9WpdlThz687PUtQTGDoFecIN4htx6lDS+yKnEEwRcqfTksHD9At02pC+XuhEmBJXgWhYrb7GUQP
	qSie/Zi3287k40BkUaKe/2Ebv3EYmaCsoreB+JNVcUNncUxyLHpmQ9yiFdTDSIm/bcM6luroRJj
	YBUyIAfK44dJDyjXXhLFO90gSVvzDinyFbn6kD7ed0V0z33rA0xI3vMREFGjLERSXqqzK1jBTDG
	TQw==
X-Received: by 2002:a05:6000:288c:b0:439:b791:f914 with SMTP id
 ffacd0b85a97d-43a04d894b2mr10251393f8f.18.1773456050537; Fri, 13 Mar 2026
 19:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311182831.91219-1-emil@etsalapatis.com> <20260311182831.91219-2-emil@etsalapatis.com>
In-Reply-To: <20260311182831.91219-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Mar 2026 19:40:39 -0700
X-Gm-Features: AaiRm539QKNDMi2N7ttUAshqcAfgVyUS2DNAZq8KZ2lSLU9xIJn9krmXSOKt8nQ
Message-ID: <CAADnVQJ7c-biuSzin6+-Jt=xDEP0+PdJPwR6xDPCQDYjf_9qvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:28=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> The BPF verifier currently enforces a call stack depth of 8 frames,
> regardless of the actual stack space consumption of those frames. The
> limit is necessary for static call stacks, because the bookkeeping data
> structures used by the verifier when stepping into static functions
> during verification only support 8 stack frames. However, this
> limitation only matters for static stack frames: Global subprogs are
> verified by themselves and do not require limiting the call depth.
>
> Relax this limitation to only apply to static stack frames. Verification
> now only fails when there is a sequence of 8 calls to non-global
> subprogs. Calling into a global subprog resets the counter. This allows
> deeper call stacks, provided all frames still fit in the stack.
>
> The change does not increase the maximum size of the call stack, only
> the maximum number of frames we can place in it.
>
> Also change the progs/test_global_func3.c selftest to use static
> functions, since with the new patch it would otherwise unexpectedly
> pass verification.
>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/linux/bpf_verifier.h                  |  9 +++
>  kernel/bpf/verifier.c                         | 62 +++++++++++++------
>  .../selftests/bpf/progs/test_global_func3.c   | 18 +++---
>  3 files changed, 61 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..f31194c2f0a8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -742,6 +742,12 @@ struct bpf_scc_info {
>
>  struct bpf_liveness;
>
> +struct bpf_subprog_call_depth_info {
> +       int ret_insn; /* caller instruction where we return to. */
> +       int caller; /* caller subprogram idx */
> +       int frame; /* # of consecutive static call stack frames on top of=
 stack */
> +};
> +
>  /* single container for all structs
>   * one verifier_env per bpf_check() call
>   */
> @@ -851,6 +857,9 @@ struct bpf_verifier_env {
>         u32 scc_cnt;
>         struct bpf_iarray *succ;
>         struct bpf_iarray *gotox_tmp_buf;
> +
> +       /* temporary state used for call frame depth calculation */
> +       struct bpf_subprog_call_depth_info *dinfo;

It doesn't have to be part of env, right?
Could you just pass it as another argument to check_max_stack_depth_subprog=
() ?

'env' is for things that need to be around for most of the verifier's
duration.
This one was added to 'env' just to avoid an extra argument
between check_max_stack_depth() and check_max_stack_depth_subprog().
Why?
Seems like a wrong tradeoff.

and with that struct bpf_subprog_call_depth_info can be local
in verifier.c?

pw-bot: cr
