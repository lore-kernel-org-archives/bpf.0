Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359763C457B
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169659; cv=pass; b=C+l/NoA5j3M2zdN/aMDR2ITxgMi+VynvKlv/wYBfowa4rlXthnDpVyL5qCBoy2D4/GLyU/yd9YVPTy4apNYIMXMf+Am2ycR3MrTNXC3XOQh61INHgs8srsKxoOIaKEepNNng9xy8Teg+XfyAkflocI125/jJk+H6Z9x9gvqiDWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169659; c=relaxed/simple;
	bh=M4G6BVQc7wyVi/rYLMy4GN5cIBbzwpjrBiwI5EYSZRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdKkLMJ/YEWYlqGbmOvlelHuynPdgVsXzxGHuugg67QBpUMlv55TTHbS8tmDcqseqW6zaBR8H4HGvjSZ8SwMl2JQuU+V1yjJiVQku7VNFcSOW/XMXbzBuz/7PrK1u/JphzKS4jAC48D+suSCmf8uaCSYv+w1pmTAoXCcPztZPvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHOgWwC/; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHOgWwC/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so24649675e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773169655; cv=none;
        d=google.com; s=arc-20240605;
        b=eisg7INo3uXP0UnxdFxtwyNoBCOPvGegIDQgZc5jI988GeyFXEnaxzsZplNOu44GL/
         4OATvoNiVkZYq49AUJeOVcsVEZ3cFolnLMQy57CH6vqfbh8Hobn72UIXuAapsvsWf8CE
         kZQ4YrthWkl/G2pKchCHp94KqxScnOMUFSJdwDSAPO6xrvBAL2nD/sU34cm7MnK7MmFW
         azOCZC/xSWQf8XE0tEamNCPaiJF2w1t2h7IgAmlOuvXaEmMwIv7jWszfETlHfV0O57Ca
         nW2Ixpni3tQsmp+wumAvLJ9xHu8m1DldfiILm3aX5ekNJ8L7y8EWJyKI1RnQk+Hh7Kgo
         Mtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a+v32bmvt28S66urLAu/G/381TNjPcA3Kc2t3SJF/oY=;
        fh=WThrXM8o/W4mLSVYCQftGI700gfnOOKptET//gXOLMA=;
        b=QBfvk8/GJv8QI4dXZFw94PseZV0aJzWQq7KFVExHknHMpS62bOSbsYyK6jkReaHe6w
         Qw3gAZoF5phzO1WzZdbJQuJc7ILdy7tKU69xMA0UPhDY2O9jwUDrejE+14AppnSCzOEP
         EEHjXuW/LY8VW0uVRK+4cfDlaeXPIDJZ5+nR0XKIat5mEUJU7auy9mwjhCSLIvxUGXdy
         I6P8cUL6cFlGXYZd7IGL6LBPwv0faeIHpUyzeVfCUn+J1SdIVx5kJ4+cWS9+TBtFUizk
         1PfJzi/zm9og+3kl+MASvPJyF8q1ShYrZv4KMjKUQaBt3P0Ki+ybbYJqjdXJ/EmBBQWu
         ZcNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773169655; x=1773774455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+v32bmvt28S66urLAu/G/381TNjPcA3Kc2t3SJF/oY=;
        b=aHOgWwC/RxWn39W4WnXOIv3gwlRmq04zyBSfSpa8adNr1D5RNWhMBgy5/1yvdqKIqh
         U9zGQw2+hk1CA1/ShZ1UfPGO0bO8oHbJF7jx2ZspOn97AK+1SkdtV4wS91p/IBMIvPq7
         e9gtWk3jODUaj+nMOTaVoCRugn/kc0w7HYci4dJiqi6yNZaVqAeEIjoWXX82K4yEWn0S
         GgYDQkGTAtTu3gNCTpSlRfdVArDp4SJhCvrV0XIuBXo8J354UhORz8EyKZTiE8zfuxbW
         s1duWZ5sKYLAGML77RgVI77fW26s+dPaAYUSOlS+UbmYSx1Ne+edB70ijK6Ky+luamf5
         eWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773169655; x=1773774455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+v32bmvt28S66urLAu/G/381TNjPcA3Kc2t3SJF/oY=;
        b=Uju26lBv8YmTgVO6cA5PCJsiM5JLmI/lORk9631jmdEl7uh6+rnNAp1EZ9ES/8stpl
         vk5U18EswZA+rb56+KneakW9URo+jTu0R9xzy/r2n8ID0pf5yV/7AwEDR84/ueLVGUYB
         4Zw9z/j1RmlPphN8UUWswiRsG01HSCUrF17sKAFLmRqTVGnlZVjBahkOlzFp0OMNxNf0
         ZKAxiW1pr5ohmz3Eg+WOZ1glHg0YhAsm1YBRcU8Oj7Bhrg8H0egtHv0ow8NWcnqIkyTm
         daFNKEfoFdBlmtKwfxCe3+6Fk55tKW9ZZr2QTHbDPX4+vqtvtlZM5REJJNHwtIcfU1BE
         G5yg==
X-Forwarded-Encrypted: i=1; AJvYcCXQsUh5hj8G97+x8CMq0ptiDUCoS30o5zxeh05p1V0ddB3NwKgcFU19BtaS5M0/CtgO2rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Fk3YQr+lCk8CsIcNvVJwg32WMkTDSxph8AEh7+NBjbjbfoCD
	wQBTp9lQjNGa6Fr5s8Sy1QdniNhH4413av/NQowwD4drTcnBR0SS01yUgNvqOwXFLQkS4KPKzmo
	W+Xf5ck4Iirf2IyI34U3/mSoQgXRkILM=
X-Gm-Gg: ATEYQzyGm5I3P6G0ajjvO58usUn3kDJnrFz2WtJuCtyaUPiskJjgh7mcpUYTSfiiItU
	QbAMoXkpfHjLGgLFiZSqHo4+6UCXJBMVqHkZ3yshjd5LILgj9Z2pOLT6aLyhwExn+ygESbLDGaP
	pZ/GPCKny0PlXkK8aX/ndDU8FgV6dHLfcdnioLC0CaZ7zstdk6SWB11S1x0tYbikUMHHehgA2+i
	3ldbl0qhKkyqsDz7YG7XP8WbYULmhF2d0zmIpQQjwhBumU49Ob8cQmWzhC6AZfeJ6qWuiczVDRQ
	vdL7KUkA1eLlypd4rYDh7gFHy+YNotqmpsUYRqRGx8BZ7m9Aor/2mtH7XjuW/a+NuzGtHL43zZ0
	7SEKaMWG73PBM1cU+fsP3uXGHIA==
X-Received: by 2002:a05:600c:3492:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-4853e19a14cmr120998865e9.28.1773169655372; Tue, 10 Mar 2026
 12:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309204430.201219-1-emil@etsalapatis.com> <20260309204430.201219-2-emil@etsalapatis.com>
 <7ca5c5ed22705e31b4ff6085dd4b9a92fc653f53.camel@gmail.com>
In-Reply-To: <7ca5c5ed22705e31b4ff6085dd4b9a92fc653f53.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Mar 2026 12:07:24 -0700
X-Gm-Features: AaiRm50p3KMG6wG6Ep-26VDjNHszSOiq-H0_-oahWF7-_r7lyXp2ZajTfMplJns
Message-ID: <CAADnVQJHX51jGV0nuPsdD869e5_iaB7z-CyJtfgfRDoyoxSWmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 2:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2026-03-09 at 16:44 -0400, Emil Tsalapatis wrote:
> > The BPF verifier currently enforces a call stack depth of 8 frames,
> > regardless of the actual stack space consumption of those frames. The
> > limit is necessary for static call stacks, because the bookkeeping data
> > structures used by the verifier when stepping into static functions
> > during verification only support 8 stack frames. However, this
> > limitation only matters for static stack frames: Global subprogs are
> > verified by themselves and do not require limiting the call depth.
> >
> > Relax this limitation to only apply to static stack frames. Verificatio=
n
> > now only fails when there is a sequence of 8 calls to non-global
> > subprogs. Calling into a global subprog resets the counter. This allows
> > deeper call stacks, provided all frames still fit in the stack.
> >
> > The change does not increase the maximum size of the call stack, only
> > the maximum number of frames we can place in it.
> >
> > Also change the progs/test_global_func3.c selftest to use static
> > functions, since with the new patch it would otherwise unexpectedly
> > pass verification.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 090aa26d1c98..b45c3bb801c5 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -651,6 +651,12 @@ enum priv_stack_mode {
> >       PRIV_STACK_ADAPTIVE,
> >  };
> >
> > +struct bpf_subprog_call_depth_info {
> > +     int ret_insn; /* caller instruction where we return to. */
> > +     int caller; /* caller subprogram idx */
> > +     int frame; /* # of consecutive static call stack frames on top of=
 stack */
> > +};
> > +
> >  struct bpf_subprog_info {
> >       /* 'start' has to be the first field otherwise find_subprog() won=
't work */
> >       u32 start; /* insn idx of function entry point */
> > @@ -678,6 +684,9 @@ struct bpf_subprog_info {
> >
> >       enum priv_stack_mode priv_stack_mode;
> >       struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> > +
> > +     /* temporary state used for call frame depth calculation */
> > +     struct bpf_subprog_call_depth_info dinfo;
>
> Nit: I think this adds an unnecessary nesting level (e.g. I'd had it
>      either at `env` level as a separate array, or here w/o additional
>      struct).

it's also not needed after analysis, right?
So let's not waste memory on it.

pw-bot: cr
