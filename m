Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC0363C46
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397946; cv=pass; b=UhITZWMmfFsOogxryFwKlxION/i7s3QEPOdCsQ2++LZeiiDFIhGpOtwD6YT43yyWGjdeDblj2n3JApijFNDhNwQvIhMPOvWWN4/5Bn8BL53j+fvuJWISYJUZf+AecWOXDESJAj5wAGDil2psiI3gO7uA9t/S9F5s8vVehIFR2jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397946; c=relaxed/simple;
	bh=eItsci1j6bUpFWKf/bM3HsF0LPU7ybEv0AslFAgLUbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIW3WwpYiKC8mQlMs0eFZ3G2/YyomUcbjtu6ANbdXAygAd15k+goZe66aMcCiD6XfP2jz3aSOLgLOtez0hEhs13Oau0u/LqceulIMsK/tEpKPKw71bS212SReFoeN6Mdvug17zk3HdgZ9YagG4pPGwzHIOYVZb7MZ7n+w/zxGjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ6Yyekl; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ6Yyekl"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-352e2c59264so1546645a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 09:12:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770397946; cv=none;
        d=google.com; s=arc-20240605;
        b=cPi9qeq0nLFrjmtTSyGsud+qCp0BUREzFFslvSt9hGH3vnYU5FSI8GA5cX/MEYKuZv
         GNnvT7MJ6CYcDkku7U9Gts+60qCeYaAKNxP5edgck29XeftxJDTqAFTC4qzmypXZhcxL
         kvNsZmoPfnogffJyzSCUXD3uSpxecC+Zd5B4FpuG1SNFIiG1jtONaKGHeJHTLGL36ynK
         QcJD3puHWD4QF15cAFIpT8PvAMza3tb6BPqCuWmjxxO3+J/d6P5E1ciNDeRua9Ihm4Lb
         G+M2yl+gPP80oGGkbtymJ/P0ALEp9p2bkFh0Xm5xD/YTqCu9S56Ljr9sgB2fLweu0KDs
         WP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fItd2bw2A3cIv4j5yZcRJpbDcD6mfOqtcfF4kIzdAho=;
        fh=WRciZejG1m2NBVt6qb8kKC2ilrZX40waX3awGc+SwHo=;
        b=AqTI2+t7TyDmytvJz7SP5Zat9Oe7DuGagCB6lVNZkBoKUpn9aCGXtCYRnNlxYZTDSk
         cSnM0dEFlvduaMdn0IyOIY/gd8PSO+SIbB2cGSTNbpZ7PKtatSkOKTRnLTapYrETyjzS
         Q9WdoSU3cSsAvEujIJ0EKFs6Jcu4YWXNaf/knGtPC0HixsTm+JPouwplWjinaNp1+Jpl
         Vv1RQAyFPQCAh20Hbdgz8FklFmjbJfzP82DYBE6cFbmcgGblNd0lxnNZshBPeTWqV8Cu
         hK8IeL1DmfANeP+WNHHwwPdv6xkCfZirUcO0LWJkQGeXm7YH0jiDmq6SHMO9KUnVglBJ
         aH5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770397946; x=1771002746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fItd2bw2A3cIv4j5yZcRJpbDcD6mfOqtcfF4kIzdAho=;
        b=CQ6YyeklWbo2JRgUGimeV2QNOO04t/VF6hCCDpj/QvoVcNcNSpyqiQ3WP6+/3Ohpsf
         xiDOnOBmbIb0+kqkszRhMMh8Rm4XK21JJIxKSwb9tgmwdcV1nlqzvekKK8wAFYNC3U24
         WYHSmSdDvoSs11VJ68ROFvCG8Itmu151Hus7lp1ZdsCWgjkxw2CJjq/E9Wi3cg3HOrRc
         X7LkNIoMJVuwhEXa/zTjpPIBp7eQqPYM3rrBfPBk9TWbvWAd1mz/KejdesnpH4Totnkb
         3kYxzL6DKUs0lu1BVcmm/yOZE3kbLMakuWEvg/FFi+mag787C53ObnfqAaO6Gh0JlyGj
         a6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770397946; x=1771002746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fItd2bw2A3cIv4j5yZcRJpbDcD6mfOqtcfF4kIzdAho=;
        b=rtU3bsejztSPSJZTDHguqPxI5DZgpAOMmEtXL21HV8QIvdBruJOK61MnDMb8QwgeDd
         S8CFFYTpHvMVEEfLu117DjEEHKq6T7LkxN85QiDlUhqqCipTqgfCQrB/uLjazSFQnLDs
         fjzdsECtlZYiinMV6exryYhtkk3ZbC7o1zodvpgE+YNrKuJz2FSnJB3VL00aGhOo4hXE
         d3vyhUsw5TAhKS4o600IwbV4WmeBFIONYmA5EadRZeQOJgPmDlvzQDJK1fK+fqC5IiqF
         5bXWFgpMOIt6F9fisu/WWmqndp5wLiF2WikjU9NAWSCEnQ+qx69p13lXcQt3ItwXbhxY
         OgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSQSJOSeWlFytxOOUsylFCTOi5gDDGrKcfSD0Axl0C5hh00yoHR2WWhuO1mpzcz/KUdHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFArRyVJC2mStAjgmA/KVDfF+ucw6oUqtCxeGr45WkOr4N6iX6
	yvUCMeVMWhzAZaMl3bkxHPRZ+/pVe1KkQDN2/aeZ8+MCJtLXep9Tf6ip9CHz1nLiHZl4XWadjUn
	hELMJNTH/TgN5w9mdDUiMm+x+5iiQjyY=
X-Gm-Gg: AZuq6aL2L3DgYrU1m6QK7Zby43XGEzksG62EWww7tR+xpegLBXXuJtvnXGeknR6XB9N
	0MYpnkvVKKrKMMVSlxbpSh12L4//PfnspXXAkaPGjR2H8KoGSBPcP2RPV8kRAUCCSm57ELAMor0
	8a9fc3vXUu/zyfgHfdQH9OoYxZLy9ghG2Pi7GICvQfyYpRW6nhJcbuRvWBJZd4UHxK3R+ZhT6ay
	4WglMc1/TVEy1cTZuxtnZoeGE5LpNjziYnEN7aS5EkJTqhdJYcJ1KCdaBXA6WDN72+G7YmlMJD/
	B0+uwQUS8m4=
X-Received: by 2002:a17:90b:5348:b0:353:e91:9b2f with SMTP id
 98e67ed59e1d1-354b3d086ebmr2798120a91.37.1770397946064; Fri, 06 Feb 2026
 09:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206090653.1336687-1-chen.dylane@linux.dev>
In-Reply-To: <20260206090653.1336687-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Feb 2026 09:12:13 -0800
X-Gm-Features: AZwV_QhIo0b-EARCGAHAsX97Jk6vBjuf3a75F2R2Xy-uB9J6NXfEDaz9CPSGXYM
Message-ID: <CAEf4BzbSCbqg6y1KGg_j5xkK1=xsmOyK5ob9uTJiVcWgQ4jAJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add preempt disable for bpf_get_stack
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:07=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> The get_perf_callchain() return values may be reused if a task is preempt=
ed
> after the BPF program enters migrate disable mode, so we should add
> preempt_disable. And as Andrii suggested, BPF can guarantee perf callchai=
n
> buffer won't be released during use, for bpf_get_stack_id, BPF stack map
> will keep them alive by delaying put_callchain_buffer() until freeing tim=
e
> or for bpf_get_stack/bpf_get_task_stack, BPF program itself will hold the=
se
> buffers alive again, until freeing time which is delayed until after
> RCU Tasks Trace + RCU grace period.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>
> Change list:
>  - v1 -> v2
>    - add preempt_disable for bpf_get_stack in patch1
>    - add patch2
>  - v1: https://lore.kernel.org/bpf/20260128165710.928294-1-chen.dylane@li=
nux.dev
>
>  kernel/bpf/stackmap.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>

Hm... looking at bpf_get_stack_pe(), I'm not sure what's the exact
guarantees around that ctx->data->callchain that we pass as
trace_in... It looks like it's the same temporary per-cpu callchain as
in other places, just attached (temporarily) to ctx. So we probably
want preemption disabled/enabled for that one as well, no? And to
achieve that, I think we'll need to split out build_id logic out of
__bpf_get_stack() and do it after preemption is enabled in the
callers. Luckily it's not that much of a code and logic, should be
easy. But please analyze this carefully yourself.

pw-bot: cr


> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c1..1b100a03ef2 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>
>         max_depth =3D stack_map_calculate_max_depth(size, elem_size, flag=
s);
>
> -       if (may_fault)
> -               rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> +       if (!trace_in)
> +               preempt_disable();
>
>         if (trace_in) {
>                 trace =3D trace_in;
> @@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         }
>
>         if (unlikely(!trace) || trace->nr < skip) {
> -               if (may_fault)
> -                       rcu_read_unlock();
> +               if (!trace_in)
> +                       preempt_enable();
>                 goto err_fault;
>         }
>
> @@ -493,9 +493,8 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                 memcpy(buf, ips, copy_len);
>         }
>
> -       /* trace/ips should not be dereferenced after this point */
> -       if (may_fault)
> -               rcu_read_unlock();
> +       if (!trace_in)
> +               preempt_enable();
>
>         if (user_build_id)
>                 stack_map_get_build_id_offset(buf, trace_nr, user, may_fa=
ult);
> --
> 2.48.1
>
