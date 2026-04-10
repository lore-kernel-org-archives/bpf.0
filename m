Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C8344DA2
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861759; cv=pass; b=JWNuToDtnzpfi1NFFgNZUw5wDBd64pwZ6CDLG9z5XPnaSxs0RfyVAYvvKu+ZAwry3AIeoHCIZ8t3O6LI1G+nRvvMACjoMr8OrIh3bGpuOdkFsF5k58coZlOOGM4phdlMZNom8rt0XUwnHb7Rt9vCwsEzx0ya8zYzgkk/bX2YgSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861759; c=relaxed/simple;
	bh=mb201+YXPHnEy8u6abSmG05WOoAHzIXkYO8xFMqNvWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aN7rzuIoHWnr2JIubJ58fQiFoHuGaXkyakWIBmX9GkgMyXG3w8saxWBtBgjoLQk+Yu+pN7vat/HYy1dDHvswJHJyccpM1Ao8S78yUrrgVakRBvg8btT6v9XyHD/6lhpsmVWMb+TZpyxZpovUkdA0B4Wio7fTxZGyJPsvEW3w55w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7WdWLsu; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7WdWLsu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso1637523f8f.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 15:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775861757; cv=none;
        d=google.com; s=arc-20240605;
        b=a/OGIUoTf1WRir4ORrQh3etpRN6WF9TLoCNnIoZFdVB7ME0rbmCIJ4czkMGvE57PC6
         qHKG5StebCFtV1X16vo5JY6Gi9QRJrfv51uiawGsyEpZhW4WjHBI4aJ5jLVXechJKN+j
         M5dQosyjE9lyNI8LN7NwbxB9dWK9mtcMownXORsvJV2dgmizgSSdwHalM41A/RgxqWQq
         DiZVsr/SR6f74V1H4HyM9xzoLF8bVCtIV+X1S1m1JO1kCR+zHskvcSyKf9IM8/LnNgNG
         qpTNSADzeaI+35W/19XAUE4wQVhmHoIG4oJJ14WsixGqMi4dgWUytRTMkx1/UzMGFU+s
         qcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MWEqdG3wHIXCHd9p5FSHdBTNxDiJh+dvxcF84wZSMkI=;
        fh=w9paX8TUTjpUD+DoFbhOt1TKmN2uoKLuFUUpp09tRys=;
        b=Z5Rddb8Uoj6bfteqiMa/GddtCzX/g7CkeY5Gd9TC0YxzGroNMqHwK+sr9IRLGh4PsI
         Bkn6ouH6es7617NGfZ8wFPLEnzcMupj3Hg04uh+0xmeosQUpXOtoKWVX/XYYrvGBRWO+
         uEmDexDIpQqXtYhT7OYTRXRYKyh4pbiZcD+LQqEMq1zPUNRLS9Tp45anHXfbIgb+OPMf
         /vV7dK58ogdN0irjm6ngcQ+PUjTPRaSo9LNBQH6Bcjo9Ymz1QJ1iU4CItBsGeOVhyIXK
         3+G/UM51UYkPvYyqv+vL8DIT8fQgTe1ycOuMCXM7xgdvEXWDLYkbC2uv2s38y9v/PvNv
         PIsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861757; x=1776466557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWEqdG3wHIXCHd9p5FSHdBTNxDiJh+dvxcF84wZSMkI=;
        b=r7WdWLsuOjDQWq3cFU91iRXi0qNU1qF+CeS2t3cu70TqRCwKR4OlmUomudnCK+R+dF
         MfNcmUQqhZVrE0vtzfUAjoEM3ZXFKrNPwE8oNAb0v9aAkZPIsbSj5aBBqApckdtPz9T0
         +pL5aIuHpV13+iLFWH6Ge0ZFQuaWkITCmaxCL8TDfUnQnw4I+o4npdQ+TbTXNG/s5WAq
         nhPAuQ3odq4sBCKMFIE8NXbn8qsDCtbHczL/JznuwGLGDHKZTkFLjSdir3MNQbrbbtXY
         1NR7izPvS8ZXlOMT/IEMn9NkeXRMjgs0nu90sWCFAUhiupjQhtAXySJhQdUDoz8lz7Xj
         aHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861757; x=1776466557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWEqdG3wHIXCHd9p5FSHdBTNxDiJh+dvxcF84wZSMkI=;
        b=OVKtxpiWIkA5IE7o3c4VCj9Rzp8T5aNb7CKQ28qmd3CUECc+jPaJI86gswmJh0FkeN
         TfT4FuQP+jEA4vgOtMoQI0DpTZ8abRdtssQeiQNvKPa0iZLsQFnj+WJNRpj1s2fpHmHp
         xEFKQ/q/Zgx2k8IoDtueEbsLpvmvkh6NcG64Xo/s95bND9nDYP3JgeZQ4Fi5iNiZZ/Zs
         asxvtSJwI1QdfUtan7Esjz0MlTtWypo/fxGL/FQWg7weEjMieESC6TqKXGm3B2H/YYZW
         ulLd7VZHwweNTM9nTt3jV+MHuRYIjt194xmvMxeetZG9DmHLyoVSXO+0R6waLsaQo392
         +oVA==
X-Gm-Message-State: AOJu0YyxB9dxolhJjuQGOfGhRLYB8xp1el2dTe16RCQKAjRvPqG8qjo/
	S5477CzeCYiycXH4s22q/2dyh6CjdwbHKxLjC1MAIjcjjljvRQimmOtKU7V/nGPkJXAwKbqDM1D
	luWFF/zVkcSZJwwiM7smn+e9M3Nh8E/o=
X-Gm-Gg: AeBDietpm9v+jUaYERzWEjkrBJAzfQW9djPcbFmKpyqp65pAaUvIOOo+PxsWu88qFA6
	Dk7XiG3+z/kFqJLCEkrMPObmQLtmE19GR1I/cUJ/MIedFMK2Wl7vjUtegSxKO/CN0SLEgRDWccR
	kPqoHccklIgzXgMLuPhqGwQMBugh3LpoJQerChgolGqZ94m5HCF9dHZXuMBDthY6nfW628SYOKt
	AufFWmyZuEo8Gv6WcvTKTB13EG2gpDsZpDeqVLONheDLxwSMd4xrEqeLQdyproywpn/XOiKyeTZ
	FtcWVfSdrHdXbSuV2sIy4Bs2BSh7J9m4buCyBeOpXQA8oq87NClDzO+4JYfJY8demfkIOeb8kdx
	hMGXLdFCai9Yy6zfGXh1mZ8KY2Q==
X-Received: by 2002:a05:6000:401e:b0:43d:4a43:53e1 with SMTP id
 ffacd0b85a97d-43d642cbb41mr7412921f8f.43.1775861756592; Fri, 10 Apr 2026
 15:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com> <20260410-sleepable_tracepoints-v9-2-e719e664e84c@meta.com>
In-Reply-To: <20260410-sleepable_tracepoints-v9-2-e719e664e84c@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 15:55:44 -0700
X-Gm-Features: AQROBzBuWq6KGdLj1M2DisBu85KlHnzXEuqbB2qFS5__RsduIobav869pbRxMjc
Message-ID: <CAADnVQ+6s0U6dVV0r_RK4ATwmuJd+BiGvp_yTYwL58ac9GEhwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 10:09=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add bpf_prog_run_array_sleepable() for running BPF program arrays
> on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
> includes per-program recursion checking for private stack safety
> and hardcodes is_uprobe to false.
>
> Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h | 50 +++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  1 file changed, 50 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0136a108d083..4e166accab35 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3077,6 +3077,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *p=
tr);
>  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>  void bpf_prog_report_arena_violation(bool write, unsigned long addr, uns=
igned long fault_ip);
>
> +static __always_inline u32
> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> +                            const void *ctx, bpf_prog_run_fn run_prog)
> +{
> +       const struct bpf_prog_array_item *item;
> +       struct bpf_prog *prog;
> +       struct bpf_run_ctx *old_run_ctx;
> +       struct bpf_trace_run_ctx run_ctx;
> +       u32 ret =3D 1;
> +
> +       might_fault();
> +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held")=
;
> +
> +       if (unlikely(!array))
> +               return ret;
> +
> +       migrate_disable();
> +
> +       run_ctx.is_uprobe =3D false;
> +
> +       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> +       item =3D &array->items[0];
> +       while ((prog =3D READ_ONCE(item->prog))) {
> +               if (!prog->sleepable)
> +                       rcu_read_lock();
> +
> +               /* Per-prog recursion check to enable private stack. */
> +               if (unlikely(!bpf_prog_get_recursion_context(prog))) {

from sashiko

> + old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> + item =3D &array->items[0];
> + while ((prog =3D READ_ONCE(item->prog))) {
> + if (!prog->sleepable)
> + rcu_read_lock();
> +
> + /* Per-prog recursion check to enable private stack. */
> + if (unlikely(!bpf_prog_get_recursion_context(prog))) {

Can this cause a panic by dereferencing dummy_bpf_prog.prog.active?
When a program is detached from a BPF array and memory allocation for the n=
ew
array fails, bpf_prog_array_delete_safe() replaces the detached program wit=
h
&dummy_bpf_prog.prog as a fallback.
Because dummy_bpf_prog is a statically allocated placeholder, its prog.acti=
ve
field is uninitialized (NULL).
If prog is dummy_bpf_prog.prog, bpf_prog_get_recursion_context() will
dereference prog->active as a per-CPU pointer, accessing offset 0 in the
per-CPU area and causing memory corruption or a panic.
Should there be an explicit check to skip dummy_bpf_prog.prog here?
