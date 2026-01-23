Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA8D257845
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186293; cv=pass; b=gmzXBQPImWZalnjzILQdAXsv0JUBKrMJSbi/rjRj18/dXnVfLqhTL5SSxZCweZ9fKyNI8KvP5XKjcqKiPVZTiymMVBz7i3qgE0MECtEphy2jlGCswPS73wweqwo0bdggrK7AWsz4Igy7EF9EQpitg3Bi8CK7N+W1SDakGznSsj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186293; c=relaxed/simple;
	bh=RwDPvI0pQ8Sul1C0MMRL8oO67jL+BJknFecUZPy82xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnuFOpZpIayZlT3DJzwFbSCwDYra5bAXYCBHFuGZvDoTHY7awq/ZASdta62lg27hqqlAZFHTxtBzXenzUvaXugVz8Eckjr2+XD1v5/mPwAmR941y1TQyt1zNX/WzuSrWbtktOAy7fhABh+gD8LULBLoVJLk1zv2YJTQX2WoC5BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxw8rYDV; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxw8rYDV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432da746749so1323667f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 08:38:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769186290; cv=none;
        d=google.com; s=arc-20240605;
        b=RhT4vyn3KqE+kyh6VCuZgK1Q03kzyUnykTh/IBH0Hi/v1RevPekX8fiaiEn91nM+x0
         +1xFSIV5IKTujtevN72gGJIQP7ahwNokgWJmVsy0idoaYQq0KK8B56MPDP0ucaalOeqV
         XySm9FtZDOynr25CXH6tmkAydqJFkaDvHKAgtlsBooNbPrX2kFf/146rMrWEHnRxcrqd
         6CN/5ydsG13RppP1/HLB/HLmvKcOveKWj5HRS0KyChkKyh4eE2Gk5LNEXPLBUfnV8Xc+
         LBTWPnDgy5EQzndtlO0BTLAOWCcd/c6XNmmh069ZNFPZ9rSmoqReyd9t/GVwzRYLnk99
         6zgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxHbVBBXdVDou2agKorvT80NIS3RgrK7fNwOf23Uh2s=;
        fh=QGXAPmGZk1MPraYJG3gkE0ZUPzB9R1FaXjMvH0s8OFE=;
        b=SEvCmkEIjRdKsOBfmwLo91sdoOlINnN95FEGMFVIS+x0tLw5M0UqsIckmctRqkaKLp
         i0zFIN3LS+9t6AZelEM1nyVq3aanFl58ZKr47mfkiU7BP4wPfmRYJJdrM1hc22LqDf+0
         OZO8eOzKVtHs6FGNbPRalb9wbQd4Bse9S87ccSBz6JXSQPDKda1ilGpQGcLScHfxqH0i
         KCSgaG42G6RB51OGqgns3eehFWCiT81opJq/Dk3ZVC1b9mqJyzi+NwjxSSasRd8cDkc1
         bS02I7e+MmbNpJgNVa1ytkN8XJBH7MwgVbhyDtr+RybvYOY9Q1T1p+4yzXyD2zheuAQC
         iI3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769186290; x=1769791090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxHbVBBXdVDou2agKorvT80NIS3RgrK7fNwOf23Uh2s=;
        b=Rxw8rYDVZqUecuJbI/3jaSa2TAPAjaeqY14kama0avcq/kOP5XzpN2/GWzBmPMLlTB
         DGH3DDsYq3e9utNqM1fRNDWUUdqJN11MSS63aVKBP/58Nz+zMVhLiJpvWVsgv2vfsUar
         9HEtQF8fU0a/yB4uD1FaygFgjFpzeUsGhoDXFuobINmY7v6dhrNGDfeqTfV9MvJy4Z2x
         UY0LFev8/CT9WLIvS+u7clipU/cNBXpGJDq+K8M8LxZwlBH9ukDB+1/gkGt1RYceo38Y
         l2ShDeh6bxfzd/eaXwWgL+CpUiBzTWjmllRj5xSLL04vhQt3xX7x00tUZkrFAfsdx+xc
         mxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769186290; x=1769791090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kxHbVBBXdVDou2agKorvT80NIS3RgrK7fNwOf23Uh2s=;
        b=qBdsHDc+tqVNUZOp8C48QOFhZqxeMAWdxKOxugK/m3qo720K6SRyJmliNUvknaBcop
         ny4gDAKMqGbcS7t6CRrrTIgE5ujU52OgFpkbEakavOUJHdCUuFzxSffhdRo1k/Raypwv
         ajofMUUlw4/h2UoCSA1fHGJGLuT3psX4H1d/PsDxE/gy2p/cS0WW/dEl3VHdV2l+6qkO
         yBIVdszec/sUPJXnmrDLmHumismbuPzP9O97tboWI9vbKc4cRjoO2A9heRgd8lBnhd17
         HLPNjXIT63N/TFWTz8XQRoZn7ur7RCHBnPjnDQPxoceq7ZBF/FZO+S/7sgNh3gK1V2+8
         sjUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9RKD5jvSUrNYU7cN3WNnJACj5A5SC/YtmlNyle/zK2QEymdS/FGKBezaVk98XQ2Qv8x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVqSLaVHkKeQBXaLJgwILWm9W8glQFasSavVuCpD6/HE+3uNp
	3eXB6Kh9QOEW4JOLptpqxb9gxdMtv9ChiAbHlL6u2zQgdCzxq72pyCkFSsgRymbu/MMLUR5YtB2
	WjRmxN6t5t6XC3dEy5RP0gkMHoyZX5ps=
X-Gm-Gg: AZuq6aJKqHCKAZfBMxP8c1mYARWcQp9VEDPZOXc3qUyMFtaWpXfC91Xb4mUGOre5J4K
	tXqWhXfmZhZXHSKitmbBDOs7FRshcKjzguTTAN779uHQjM+fxdSl/4ZuYIvN/Q32SvukhHtZFdy
	KalsnChFAIxhbqTEWhIkW4jL9YX7Uaym0S8mBvCNnGMaRKFtrv1Q3+G1b2twAUMsLsaWgPEF2O9
	dynFeaT9P+XrivuDWTmYikDdrULCbuuHvZJAcxyZ+Ab+JevOu2qTnHh3IBpzMVaGrQbnzRVcPd1
	vspckHb2GNKLAMio3TVdjddbWlVX9cokVnx3APXUBj9PpOJwVIhRDDOjdWHgKLXuR/XAjspT
X-Received: by 2002:a05:6000:2510:b0:435:a3c5:a526 with SMTP id
 ffacd0b85a97d-435b9306f93mr3153762f8f.14.1769186289815; Fri, 23 Jan 2026
 08:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123084248.259278-1-changwoo@igalia.com> <20260123084248.259278-2-changwoo@igalia.com>
In-Reply-To: <20260123084248.259278-2-changwoo@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 08:37:57 -0800
X-Gm-Features: AZwV_Qj09XJMcjRsVhLeepl5jIwtRCuMSfLzrScea9MIVqBh8kGfGuH7SfaIFuw
Message-ID: <CAADnVQJTaYo0=aaTii6n+yXLuacLcc9XSj=PLgbq+-mn5Num9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Introduce execution context
 detection kfuncs
To: Changwoo Min <changwoo@igalia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-dev@igalia.com, 
	bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:43=E2=80=AFAM Changwoo Min <changwoo@igalia.com>=
 wrote:
>
> Introduce bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), and
> bpf_in_task() kfuncs to allow BPF programs to query the current execution
> context.
>
> While BPF programs can sometimes infer context based on the attach point,
> certain programs (such as those in sched_ext) may be called from multiple
> contexts. These kfuncs provide a reliable way for logic to branch based o=
n
> whether the CPU is currently handling an interrupt or executing in task
> context.
>
> For example, this is particularly useful for sched_ext schedulers that ne=
ed
> to differentiate between task-to-task wake-ups and interrupt-to-task
> wake-ups.
>
> As the names imply, these helpers wrap the kernel's internal in_nmi(),
> in_hardirq(), in_serving_softirq(), and in_task() macros.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/bpf/helpers.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 637677815365..cb36bc7a80c6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4365,6 +4365,46 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf=
_dynptr *dynptr)
>         return 0;
>  }
>
> +/**
> + * bpf_in_nmi - Test if the current execution context is in NMI context.
> + *
> + * Return: true if we are in NMI context, false otherwise.
> + */
> +__bpf_kfunc bool bpf_in_nmi(void)
> +{
> +       return in_nmi();
> +}
> +
> +/**
> + * bpf_in_hardirq - Test if the current execution context is in hard IRQ=
 context.
> + *
> + * Return: true if we are in hard IRQ context, false otherwise.
> + */
> +__bpf_kfunc bool bpf_in_hardirq(void)
> +{
> +       return in_hardirq();
> +}
> +
> +/**
> + * bpf_in_serving_softirq - Test if the current execution context is in =
softirq context.
> + *
> + * Return: true if we are in softirq context, false otherwise.
> + */
> +__bpf_kfunc bool bpf_in_serving_softirq(void)
> +{
> +       return in_serving_softirq();
> +}
> +
> +/**
> + * bpf_in_task - Test if the current execution context is in task contex=
t.
> + *
> + * Return: true if we are in task context, false otherwise.
> + */
> +__bpf_kfunc bool bpf_in_task(void)
> +{
> +       return in_task();
> +}
> +

This functionality is already available.
See bpf_in_interrupt() and get_preempt_count() in bpf_experimental.h.

No need to replicate that as kfuncs.
If something can be implemented as a bpf program it should stay as
pure bpf code, since it's more flexible and faster this way.
llvm together with JITs completely inline get_preempt_count().

pw-bot: cr
