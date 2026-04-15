Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CD2192F9
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292338; cv=pass; b=oRj4U8YPoiVginkipxGQIeZ9lGhfYApS33PNrHPt4NRiIm+gh6lv9z+I4ktXJaSn8+k1LnvyXahWLYjwP8/elRet3aRVmxAlJo8ltyfBrOHI3yc6DVevM5Uhokv0FyvO6tNZWnZVJZZ1C/6gzY/yq6HLYiZ6j/RCNH7r+GtH9Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292338; c=relaxed/simple;
	bh=OkIyyobTg+h8YwlTfvgCqPTo1HQ77YRqp3DS+hvi0mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BawhNJKErozOgHoOpJ+VjmTXW4Y4cudcCkzz0Hpox+8O0qC/yS+O2Pe30i/s0LkV3Ejap6bT0Vylm13h7Hqi10ObzVDh311ya+sfzqy+jdUdOKYVdhUul9rPXcXKBelvWSJjBTOWKZNouwHs7QttJY8Ssf3LCvcjWvXeTvv6J1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMJJAxTS; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMJJAxTS"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79ab3e26cceso72166677b3.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 15:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776292336; cv=none;
        d=google.com; s=arc-20240605;
        b=k8ba6A5KtrXKq+it6D3GCy3DgYofh6p7z5PBTxxa5MK6uKQ5omWUYeVZcB2/1BEcam
         +9oco80lFJCRS9sYLRQ1Ob8gxtB65h1/Cd0JSEiTUKbGp0OWIhte2On25KtjeYmVRGTg
         wz6xx2r956yaQ8d3xCMZs04v78lGFIgUwxqHYkoV8GyCEz51qndna+/n67SV30oHL+vv
         b8vSgCduCEZzYQlqTqgZ/Xt4CkPkD547xCx+KsqsZ/u1WD9bp4jyoxVYdzY/F7dUSD/f
         rMjfU2Yl9IB3gjiMBYFqXygg0T4/ujrxBsXWOcBdg8X8MMasL2hVWO0atl7H32wIbPqd
         ZY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WujiemL7ZvBsP6uCAyYQnT/jkTe0VWchy8ZVod5OOzk=;
        fh=PvYPcwWkAFTdNDlHuRMEXK4H0X8YFjGgiYsXgOFIKvA=;
        b=SirvndlpdbXu2+7i5hBXcK12woQnpax4h0eOpkymuXByEvmIXNZEsihtV3PDn5wTp6
         HwK3oqe27Y8XoZ8Anxwa01+bLM8L3Gxpg4bsKbjUU31r7n2GJchweQigK591lud6ZyvJ
         oqys9Cu7CrKLiQvF89VGSTCOukfXdxrWabfWHC+sF/E88AvjBDtCMRI756VuMAhPJNzq
         Ggc2Eg+n3Y2wejRqsgIxdQ/b45ZBXJMfA+eN0iN+dxADTOVDQm9BtAjMFBVfTbRkiJot
         UDCV+8MbOna3k2RFioxqk1oSttF1eFz3M74OmRfi4RKTiyCzoN3JXXOfF48fXffgEqAz
         MFAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776292336; x=1776897136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WujiemL7ZvBsP6uCAyYQnT/jkTe0VWchy8ZVod5OOzk=;
        b=OMJJAxTSTbBO6LH0ye9RVRZFWL/a/eEGxghfqe5n7oTmZog69NPRtN6IhEo/JwwD5o
         TtxflkzfgqbYoF93yEjKtf+h3hnNTXha0t1M0Rn1CByuMD0RG88FfuiM6tyGQqqEKr4c
         qa2HwBaZeEEJKzwCHBZTnQmog+89s2r9fRx6b6/SQsEOYOZUfd2KrWf/RCfFY2Hayo4I
         F+hS8zlEkvkNFUNHPVC+ZpCAHZOu51Z1y+CJ0vP3ct6me0Ixpobr418YBR75VqGmmcUY
         tQM2X4VqMp8EDi8DywZNZLj8MwPSZ1VKHDu6+LqxDRdAGnCj/nqD7Gc4ZXtL+UREhp8X
         rK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292336; x=1776897136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WujiemL7ZvBsP6uCAyYQnT/jkTe0VWchy8ZVod5OOzk=;
        b=nhP0hMK/VfRjl31iuTxwM1FU4GXpS6o9ZvtE7Tx5FA8BLKtkSgmPE4zau0jiyG7EQy
         tqueTWIuH8/ihnkSi/fs6vM+WqtOt5z1O9opJWT/PjUgIgpOq8Qq33bZOK/XqcxRIb7T
         UdBTpcfXUsT517r4HQkbAl31TYZfPv4CDSV/lxsnfr65/Ox9eYqoGJGHu2MB731BTYBZ
         +wSUDjxxzijeh9BvlicaS4IQtH98NAfzGqqoVQ0yJk6T3GDRxeXJAMN3w+lZg3TYOzAJ
         N9Z8JipTOqKhNfPpWSrT07OH1Hvcry/4iMOxrOgMK/6vPWug4n+hSr93/HAyW9RfbtC+
         6d6g==
X-Gm-Message-State: AOJu0YysXiLVFUkcy0CUVm/PvL3UCiknzuJiP8ga79DSetGpvB+dP2HW
	pBvqoUneDeXWrzuZqSvWVEq5bbzbUJ2LdpPm7v4BgD1hES4FoVEdM+Fca5yC5t9tKDpeB8yDMNQ
	ByzSvLdRqdY6qlG8Otv0QzKK6noa+Kqg=
X-Gm-Gg: AeBDieuo1D0HDNhQ3wII3uDlt5mC0ag76n+5En++Y/PfRUENHRGsmuX4NqGzQHynPbw
	nvRSZD/1kphTbHtIAED48BXG5aclIKOHNM86axEfiTYebXU39cfkyBiWSqbDHdg3I49k6f9vr+e
	xUYUjjNdaE4EZXA11bPdfTZof/5DrZQB9I7tI9n389yvKUycbYK0H8nUFajStB6rl2visTgaz2p
	iXe0zEmUwTspWsoihTGSk/F88+K/zY6VWIbGr5XyCylxbCWPbtJohl+pO+FSvErMpzk0iKXLSwP
	+6JPNcp9GqtHih5KnQ==
X-Received: by 2002:a05:690c:85:b0:79a:d2ba:3c24 with SMTP id
 00721157ae682-7af7213be32mr249230147b3.41.1776292336472; Wed, 15 Apr 2026
 15:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045826.254200-1-yonghong.song@linux.dev> <20260412050000.262030-1-yonghong.song@linux.dev>
In-Reply-To: <20260412050000.262030-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 15 Apr 2026 15:32:05 -0700
X-Gm-Features: AQROBzB5d0wOP3IMe9lbaY--KWUPZ2j_Xf5kd72AMgi-A-i9XcelX8Tz7IBrGv4
Message-ID: <CAMB2axPoszkZqHYh8g3bH0V-c4-BzLX3ywSsF0fFyQOmN0Vp5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/18] bpf: Fix interaction between stack
 argument PTR_TO_STACK and dead slot poisoning
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 10:01=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> The "poison dead stack slots" mechanism (commit 2cb27158adb3) uses
> static liveness analysis to identify dead stack slots and poisons them
> as a safety check. However, the static liveness pass cannot track
> indirect stack references through pointers passed via stack arguments.
>
> For register-passed PTR_TO_STACK (e.g., R1 =3D fp-8 passed to a static
> subprog), the liveness abstract tracker carries frame/offset info
> through registers. When the callee dereferences R1, the tracker
> attributes the read to the parent frame's stack slot, correctly marking
> it alive. So no poisoning issue arises.
>
> For stack-argument-passed PTR_TO_STACK (e.g., fp-8 stored via
> *(r12-8) =3D r1), the value goes through BPF_REG_STACK_ARG_BASE (r12)
> which the liveness pass does not track. When the callee loads the
> pointer from its incoming stack arg and dereferences it, the liveness
> pass cannot attribute the read back to the parent frame. The parent's
> stack slot is determined dead and poisoned before the callee even
> starts. The callee's subsequent dereference then fails with "slot
> poisoned by dead code elimination".
>
> Fix this by allowing STACK_POISON reads in check_stack_read_fixed_off()
> when the read targets a parent frame's stack (reg_state !=3D state).
> Same-frame STACK_POISON reads remain rejected to preserve the safety
> check for real liveness bugs. Cross-frame reads are safe to allow
> because:
>   - The pointer to the parent's stack was already validated by the
>     verifier.
>   - The slot contained valid data before being (incorrectly) poisoned.
>   - The read returns an unknown scalar, which is conservative.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

While liveness of stack arg handled differently, can R12 base
arguments cause some OOB in liveness.c? For example, can
arg_track_xfer() reference at_out[12] while at_out is defined in
compute_subprog_args() as struct arg_track at_out[MAX_BPF_REG]?

>  kernel/bpf/verifier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e664d924e8d4..bfeecd73e66e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5764,6 +5764,13 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>                                         }
>                                         if (type =3D=3D STACK_INVALID && =
env->allow_uninit_stack)
>                                                 continue;
> +                                       /*
> +                                        * Cross-frame reads may hit slot=
s poisoned by dead code elimination.
> +                                        * Static liveness can't track in=
direct references through pointers,
> +                                        * so allow the read conservative=
ly.
> +                                        */
> +                                       if (type =3D=3D STACK_POISON && r=
eg_state !=3D state)
> +                                               continue;
>                                         if (type =3D=3D STACK_POISON) {
>                                                 verbose(env, "reading fro=
m stack off %d+%d size %d, slot poisoned by dead code elimination\n",
>                                                         off, i, size);
> @@ -5819,6 +5826,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>                                 continue;
>                         if (type =3D=3D STACK_INVALID && env->allow_unini=
t_stack)
>                                 continue;
> +                       if (type =3D=3D STACK_POISON && reg_state !=3D st=
ate)
> +                               continue;
>                         if (type =3D=3D STACK_POISON) {
>                                 verbose(env, "reading from stack off %d+%=
d size %d, slot poisoned by dead code elimination\n",
>                                         off, i, size);
> --
> 2.52.0
>
>
