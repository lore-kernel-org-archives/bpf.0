Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE66273D9F
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917997; cv=pass; b=i4jsUpbaF8XAxB+B99Oqf/24E896liq99DavwtopERbuH1cf4gf6HMdxoa/88bx7SbGfBUctqJeYmQ9+ac8Iw/qDV/wxySD5v2WWHrmtwt7BcIyWjqPuzDkaw6b8Xi2lReT/QTveAPXJerJ2Aqj4t+5pnGWKxDZNiDxqQ8EfRcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917997; c=relaxed/simple;
	bh=zYiszaDVBQy4JGrPLFGDXXS8lpJrvJLcXJGrvXbxUv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moFwG2lg9zB+hzJ/NtQ1JX/V9URZaTfUFxtO8L4ZecejnUpK/wD3VlOW7UwlpgtJp1As4qGpkDxNc7zZn6jfyODdXUdu6+eqM2aqoAVtiPnmAtQ1/eAduh7drFp/ndDT8ORPQHlOA3rQnpCMyvYNHNE2C8laHVfCX9kgQNMpsNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgJGMF+g; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgJGMF+g"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1848275a12.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774917995; cv=none;
        d=google.com; s=arc-20240605;
        b=RrTLf8ZQxkfwqC+C0j+3wbZrR3UYCoe7XaXcUr0GSk/Peh9Q7xqI2SF7trVMWu4fAg
         10TQ0nJhKmn7p65kJqfDq3IcPkh7o3fqv3DFVGSF8d5/ue8VTRpV3B9aXx7qiI6WX6gR
         ywxyAgWyq0oq6EdV5jLnx4hIFS0xobCHs8vtxkHzsOuFj0BEMI1i7AB9jhTtc9u3hK7I
         8rf7GNTaAcQWgNOpGzh8qULEsOVZc0Ddjfur66RVfCAdVWmoLIPvl71/5x3uTTvuF/Lw
         KhuS4j0BCKYZz06iYZupb4grbnVHHm9tEjvtHrUqCzolij+92It3C/kK1mKfS4TcbCDk
         4pYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=COoQNEmPiIycrQ64MYlTsehjwuDi8RDPJhSWNlgSaPg=;
        fh=w6YSdmtOf1NKX3w5wFeTCSc6scNeUu2+rBxyHKz+iAw=;
        b=RhbTB/m9A1aoVJXxlW+YoCl29CvnAYJqpa28F1Jg7h0jDGATpY7lGGFtoltgu+YS4Y
         t1V0E3BkuUOsRFJtO9l2FMRqSrci/DYYKneUoX83OQEH2G27zbPYCQQqHsN8IBMVtZXu
         kRH0nJ2dcgaDqcK9xiTHEy818ZM6hTJho81UShiCJRctomLQ2wSIa/R+M/E6xZL1Pn+F
         8gyxFs86PUV5+8N2TqmzWLVLHLO9EIEwzqZRewiedobKpqwSAQHsa2lhUk79gqCBx3sD
         bE1d7SHi2gkuYEguW7IJ500YYQcR6iY0WS+uHCCxeV1/vvjQX1B95fRVvCxTzOmU3fkj
         AWTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774917995; x=1775522795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COoQNEmPiIycrQ64MYlTsehjwuDi8RDPJhSWNlgSaPg=;
        b=qgJGMF+giaYPL48C+GpnLLTd0FMxILHo/pwkcPBHai9YRKv6lJV8DRpAgkAGxnhoVb
         pe4xT+k/uHRbX6JOwFKakRq97Goq5OZoWG00+lwZy4QYgm88FcG3OZCetnSENaLnBoax
         Y+fSS7r+QmXmmfWoRVQQ0Ne99pzYjdU4Bnmx3sQCYPwuoSN4vn5nPuWzz9PEevjkBQDg
         QfflEhEQyFQFeKG+Xsz11SKE/I4zCpwKumWNEAxNb1vCWeCXgVqGoklgNgtfVTdnfMCE
         E7++JseNcni7imCWcIqnj9kvbAYBn4n0iu/CTkoxyyps0c6pG+sgz6p/A1orHW3hXMiO
         LanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774917995; x=1775522795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COoQNEmPiIycrQ64MYlTsehjwuDi8RDPJhSWNlgSaPg=;
        b=kp1bWJYwW4RBEUslkaKuPEB2Z8lBwWIbol49q//kZxf1yUFFfXipvYY66I9a/YV+dg
         u7TTTytSaQtSHB3FYml6LSAX/wpDwGm6E5AOGIEm9jlWmlYM7yqKCslunj+3czMM8HIS
         Bf6hnHbUonlleWpw2JgCnu37iPvwpg6YxarMfVSRFWaAoaOwv8tv09kn3h/WDlZKaIIJ
         c2hub9NLKWHiwI9bsVkHPhtRjuSlmi1NDF4YGuZTuXXtcncMJpiRQ2bGnUJUVFYRzcr2
         Cw8vKC2OzjdDAHeLYPN6+YmVFByQa1lBXNbDADrT0/lF/tsUrFVKrdP3/qzVC8QEgBLO
         X0XQ==
X-Gm-Message-State: AOJu0Yw1y8TciBz1VV+FmO3PPTyCNq2AC+XLzUF7qrXJNwu/KqLdoor4
	uHtT1MmG1AP2j9TAR19okXN4UeY359LPJRu34Zc0P1ex9ed9ETkyGyG8DvGUghT0DHF0JMP+wEW
	92g6Tc8VLTf/uzLaztHpX4vZYC0KsLD8=
X-Gm-Gg: ATEYQzyJQkl93HBo8IEDlvhRjvHbEQThkzbwwVwjtSm4IHc2w3NhwHhYJNOQ8Ht4n5N
	0QCg9WAhLkxNlmDwOzfvYc0/8P2wHGSOHPv9X66n1icmDKZAOj+ImbQcEr5Itn89Nj3NC6IuPfC
	Eflfb85C+RpxlnSd86Gi1kR25CQlGfSh5+jeHdmUawi674eu2AaPg9/OEy0eT7NZG8xcxqo/tLS
	3Y3EUhU3IS8wB9XY/acYPJ3wrqrXxil1auR1KgKSUxq5E1ehYxrY0b+Ktr9siut4ssgjjUoclpt
	k+/vn5DivuOVROMXIzWiW8k=
X-Received: by 2002:a05:6a20:938e:b0:398:a128:d463 with SMTP id
 adf61e73a8af0-39c87a3c214mr15366070637.35.1774917994898; Mon, 30 Mar 2026
 17:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com> <20260330-sleepable_tracepoints-v8-2-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-2-2e323467f3a0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 17:46:22 -0700
X-Gm-Features: AQROBzC-VT-xZKwcUFjjqPWkErz_dBlX8TaFYHPCff8Xp8jTHtc6I0I7oZ-lV0o
Message-ID: <CAEf4BzamwGd=_q4aHiWDx5cyRWPNHpH=9JwpsHeFrxCv0AFg7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/6] bpf: Rename bpf_prog_run_array_uprobe()
 to bpf_prog_run_array_sleepable()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, peterz@infradead.org, rostedt@goodmis.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> bpf_prog_run_array_uprobe() will be used by both uprobes and faultable
> classic tracepoints. Rename it to bpf_prog_run_array_sleepable()
> to reflect its general purpose:
> per-program RCU flavor selection for sleepable program support.
>
> Add a bool is_uprobe parameter instead of hardcoding
> run_ctx.is_uprobe =3D true. This flag controls bpf_get_func_ip_kprobe()
> address resolution and should only be set for actual uprobe callers.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h         | 7 ++++---
>  kernel/trace/trace_uprobe.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..9fe19ab21cfc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2487,8 +2487,9 @@ bpf_prog_run_array(const struct bpf_prog_array *arr=
ay,
>   * rcu-protected dynamically sized maps.
>   */
>  static __always_inline u32
> -bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> -                         const void *ctx, bpf_prog_run_fn run_prog)
> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> +                            const void *ctx, bpf_prog_run_fn run_prog,
> +                            bool is_uprobe)
>  {
>         const struct bpf_prog_array_item *item;
>         const struct bpf_prog *prog;
> @@ -2504,7 +2505,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_arr=
ay *array,
>
>         migrate_disable();
>
> -       run_ctx.is_uprobe =3D true;
> +       run_ctx.is_uprobe =3D is_uprobe;
>

nah, we can't make it into generic "run_array_sleepable", it's clearly
uprobe-specific due to this

>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>         item =3D &array->items[0];
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 2cabf8a23ec5..eb4d78e689ac 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1402,7 +1402,7 @@ static void __uprobe_perf_func(struct trace_uprobe =
*tu,
>
>                 rcu_read_lock_trace();
>                 array =3D rcu_dereference_check(call->prog_array, rcu_rea=
d_lock_trace_held());
> -               ret =3D bpf_prog_run_array_uprobe(array, regs, bpf_prog_r=
un);
> +               ret =3D bpf_prog_run_array_sleepable(array, regs, bpf_pro=
g_run, true);
>                 rcu_read_unlock_trace();
>                 if (!ret)
>                         return;
>
> --
> 2.52.0
>
