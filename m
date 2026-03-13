Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96971372ED0
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436727; cv=pass; b=Tzgq1+///3BNIe2yOdD7OFxVyFVPu/XF2jldDwgn0B7JYhug6JWmvqX6NVp20EAraxCE1NxLVcszfSlLFkqyY6CcP4gtlqkJmb/dWsusW5r+3Jnc3go5mAcroJVo7IkCFT6fodXa79V4KQ1VlrBOog6QLxfGm/m7AhtrfjVdj5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436727; c=relaxed/simple;
	bh=7g9q7KkvQHvAJkxuC9kNzCUl854HTZO4qMXNsD/wssw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo+H6qLY1AObede9G3JiuV15+Z+wQ5KjUQ6JZLCKumv/UwHChfEhhxVrQ68B2aLjCiR2SZu1fAmiimCNyH7pIUHsQaTGswIffpAdY29jevyjgoXgXa/HjlftucNqIi5bPmYvyDjT1KFlA0R2G1+B067g7n+aowIy0axcO+TnFCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoS+SOQE; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoS+SOQE"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a2ee65171so2431727b3.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773436725; cv=none;
        d=google.com; s=arc-20240605;
        b=LfqoDyUBxVZpHHjz7r1DM/3HpZHg+XbYdoSuBNc58iY2zngtlLa6hIc/ity6ACejRQ
         onaM2No7Wru5fR8QsHy68XkhxvpEnmAl6b1Xcapmv1hEqB+sY5ayeBTlpnt4uQn2YNS5
         JpWiCZWTmOOPam25jGNmKjhIjM2zVrrARFIuJcd7C07VN5k6ozDZk/t23XfDstAH8GuC
         v+GWPVfUyyed4cpxW7LuUAxFwpyTIW2Lt4nikF3uFDm86LQmwBqzM3fF2UWoJVgz6Ult
         uBTIfvFADKJRs9jz9wD7zH65VciaqifV6B1wKypx7mzr9+KCwyNKPeGS2ZuF//ipDbz0
         qFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G5w+KWeohGoa+knsdy4MLeTSplc5f+5/aRbCiRvY8I0=;
        fh=5WNbLMzUIJSkT/c9iz+xFtbu/ra9gd2MHn/Koc3qUo0=;
        b=RL2o7MkIKCfxlVp4fSh3WE/eNZrUz0JzHxfEMG8OvD6TPNL7kbh+EalXEVTDnGIi0T
         rLb+1k2umDI+JdDjbTFAgQjS2vTgcqA+DJnJUtIQ55DvfU1ViJD36OmkUMXVk8kfqm0x
         dzR2tgUMN8C/zUPAEqYu6ZapOnwJHvU8amTYaQwnAUtR3+5q4RGjAriZ5toJ6w2NnkXp
         lenqMB1BSOCZCbiPqN6eVZ6aTONkV2zRV3fBoEHQ1MNZH1KN9Nfio8FKDbpjBfZSc3sO
         p/8X/TFffIK+dM6tm5voMxXL7Mc7Mr/dm5IqLxGp0ZoF1RVR3ICT4vrWZcgiUKKHxUKw
         W6Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773436725; x=1774041525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5w+KWeohGoa+knsdy4MLeTSplc5f+5/aRbCiRvY8I0=;
        b=CoS+SOQEjhlntDcfoPzlMbqyOu+azz4LxwKSjuEAwqXgZYWI7A6Kh2W0H/htcQk2bw
         q22m7JGhFNAjqSKjan1Oq98NXTBjcRLbmSrgsESMgaNDEX08K3jeuj9GSSJhbEHZiO9P
         fg+2/qDfa+7kc+1Ll1DCLEP4dHAjFUjjvb8/1fVs9WuUkMWusWRdvgEjW9+RLR7wiKPw
         JxWBelfmTLT/z/s4PzaEjBdGbknz9eVIi6r1tZARiQNhmlFYx2tXHLMsJoKCujXe2FDw
         Xz+K2JIF8JkdSNvjMYvxnJ5tbFpaIh2+MSrR1GkUJEUJM0YGBdpqmEuF1lHd3MFe+qky
         asNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436725; x=1774041525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5w+KWeohGoa+knsdy4MLeTSplc5f+5/aRbCiRvY8I0=;
        b=NgRsCd+9slsuzt5fEFXYErXeXjS/vqqCfYQMYb5vjejqqtjUt6ouR8eYYoA4BmbNbK
         gAjSLmqBlYdktDfXUR7KORlNuEv65Zo6Y41yJ54fSaEkCn4JJcm55K3mw98+GTlcZHgv
         7RGLgxDSPxiwI1L+BYupvfSRTQL56XqZXaQXTPh40tz+NClFmFu+V3YcWW2p8tAtJzSw
         JaJ5qQW8+p5MP8aoHq8zKITC3u5Nk+6gLIouT/9Ogv9hT3ArxtMngRWxWJJ5WGf0YRDi
         /3HPgqwvjxWzpsG+C6uycYZW6U+tu5S19j2Cjxbxme7cxt2QJ8iN+8x14wefWFny9yjd
         zEBw==
X-Gm-Message-State: AOJu0YwWO+ZE4CdyZBCVCUQhtRb2+DTV1OZNShJLAHXFNGoFeFrhBRbD
	ntwB9Nyzt3tECmzmBRz/0tIjgt7uTKUUzYfMlQsfVmd5za967f5mwuDmJxheAZh1X030sfCb9Gi
	Myr03BE9+GjHMxj8DDS/B0O53xDOogpY=
X-Gm-Gg: ATEYQzzA7wFCyNq+r+jc7iFLXMZCLuexAb2VUxydvxbIczXLxgBNQ0h+6n+MYIg3Tx/
	kh81c/rKSRU6eKQUz9NYIiPc44tHDnKTuWS7DwJyLF7Y3KwTI+OHQr+mfOgRxeAgnTu8takm5NN
	poHXAf6aQELDgMVHREIRONAyFl5QCwhKjtkjmhUJZedcOEWbgNcK5uaDBm3aw+Nh7bkly57JM4R
	ylWXC5yq1s1MsrF8xMq1Wl+FilLMyUYK3l/xh2nmUeSpbDYM/+yWvqjkjQeeF6bjvtDBA54zzpg
	61Dg36g=
X-Received: by 2002:a05:690c:a0d9:b0:798:991d:2294 with SMTP id
 00721157ae682-79a1c1299a5mr36515957b3.28.1773436725623; Fri, 13 Mar 2026
 14:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313075318.11847-1-danjwade95@gmail.com> <20260313075318.11847-3-danjwade95@gmail.com>
In-Reply-To: <20260313075318.11847-3-danjwade95@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 13 Mar 2026 14:18:34 -0700
X-Gm-Features: AaiRm50TsHO8zEGeuQiOgkXNSwCT0H380kotQox7F-5uXK-xVIQ_6z5YU1f3uGQ
Message-ID: <CAMB2axOspp-6cAeH_a9AjuixJ+OgtzxmXyLRPvM3T-w02CSArQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add tests for
 maybe_fork_scalars() OR vs AND handling
To: Daniel Wade <danjwade95@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 12:53=E2=80=AFAM Daniel Wade <danjwade95@gmail.com>=
 wrote:
>
> Add three test cases to verifier_bounds.c to verify that
> maybe_fork_scalars() correctly tracks register values for BPF_OR
> operations with constant source operands:
>
> 1. or_scalar_fork_rejects_oob: After ARSH 63 + OR 8, the pushed
>    path should have dst =3D 8. With value_size =3D 8, accessing
>    map_value + 8 is out of bounds and must be rejected.
>
> 2. and_scalar_fork_still_works: Regression test ensuring AND
>    forking continues to work. ARSH 63 + AND 4 produces pushed
>    dst =3D 0 and current dst =3D 4, both within value_size =3D 8.
>
> 3. or_scalar_fork_allows_inbounds: After ARSH 63 + OR 4, the
>    pushed path has dst =3D 4, which is within value_size =3D 8
>    and should be accepted.
>
> These tests exercise the fix in the previous patch, which makes the
> pushed path re-execute the ALU instruction so it computes the correct
> result for BPF_OR.
>
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---
> v3: Use single-line comment style (Alexei Starovoitov)
> v2: Update tests for re-execute fix approach (Eduard Zingerman)

Reviewed-by: Amery Hung <ameryhung@gmail.com>


> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index a0bb7fb40e..bf834414ea 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1200,4 +1200,94 @@ l0_%=3D:   r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +__description("maybe_fork_scalars: OR with constant rejects OOB")
> +__failure __msg("invalid access to map value")
> +__naked void or_scalar_fork_rejects_oob(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       *(u64*)(r10 - 8) =3D r1;                          \
> +       r2 =3D r10;                                       \
> +       r2 +=3D -8;                                       \
> +       r1 =3D %[map_hash_8b] ll;                         \
> +       call %[bpf_map_lookup_elem];                    \
> +       if r0 =3D=3D 0 goto l0_%=3D;                          \
> +       r9 =3D r0;                                        \
> +       r6 =3D *(u64*)(r9 + 0);                           \
> +       r6 s>>=3D 63;                                     \
> +       r6 |=3D 8;                                        \
> +       /* r6 is -1 (current) or 8 (pushed) */          \
> +       if r6 s< 0 goto l0_%=3D;                          \
> +       /* pushed path: r6 =3D 8, OOB for value_size=3D8 */ \
> +       r9 +=3D r6;                                       \
> +       r0 =3D *(u8*)(r9 + 0);                            \
> +l0_%=3D: r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_map_lookup_elem),
> +         __imm_addr(map_hash_8b)
> +       : __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("maybe_fork_scalars: AND with constant still works")
> +__success __retval(0)
> +__naked void and_scalar_fork_still_works(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       *(u64*)(r10 - 8) =3D r1;                          \
> +       r2 =3D r10;                                       \
> +       r2 +=3D -8;                                       \
> +       r1 =3D %[map_hash_8b] ll;                         \
> +       call %[bpf_map_lookup_elem];                    \
> +       if r0 =3D=3D 0 goto l0_%=3D;                          \
> +       r9 =3D r0;                                        \
> +       r6 =3D *(u64*)(r9 + 0);                           \
> +       r6 s>>=3D 63;                                     \
> +       r6 &=3D 4;                                        \
> +       /* r6 is 0 (pushed, 0&4=3D=3D0) or 4 (current) */   \
> +       /* both within value_size=3D8 */                  \
> +       if r6 s< 0 goto l0_%=3D;                          \
> +       r9 +=3D r6;                                       \
> +       r0 =3D *(u8*)(r9 + 0);                            \
> +l0_%=3D: r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_map_lookup_elem),
> +         __imm_addr(map_hash_8b)
> +       : __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("maybe_fork_scalars: OR with constant allows in-bounds")
> +__success __retval(0)
> +__naked void or_scalar_fork_allows_inbounds(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       *(u64*)(r10 - 8) =3D r1;                          \
> +       r2 =3D r10;                                       \
> +       r2 +=3D -8;                                       \
> +       r1 =3D %[map_hash_8b] ll;                         \
> +       call %[bpf_map_lookup_elem];                    \
> +       if r0 =3D=3D 0 goto l0_%=3D;                          \
> +       r9 =3D r0;                                        \
> +       r6 =3D *(u64*)(r9 + 0);                           \
> +       r6 s>>=3D 63;                                     \
> +       r6 |=3D 4;                                        \
> +       /* r6 is -1 (current) or 4 (pushed) */          \
> +       /* pushed path: r6 =3D 4, within value_size=3D8 */  \

I think the proper multi-line comment styles mean something like below
instead of the netdev style you were using in v1

/*
 * r6 is -1 (current) or 4 (pushed)
 * pushed path: r6 =3D 4, within value_size=3D8
 */

> +       if r6 s< 0 goto l0_%=3D;                          \
> +       r9 +=3D r6;                                       \
> +       r0 =3D *(u8*)(r9 + 0);                            \
> +l0_%=3D: r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_map_lookup_elem),
> +         __imm_addr(map_hash_8b)
> +       : __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.0
>
