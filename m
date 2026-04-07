Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349853D566B
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578260; cv=pass; b=Js1NViXxvXHyO+Wsvo2zhPQ45PSwmVWzfL7fVCdpxn46k2pvdLekBdAMWlx0QfP9gsztxaf01Uw82h0fGhxNOqGmBWzQ3eW8zaqqKIvrFBoNWVpQVEBhJms2RVs1JwvEUSFnoxDs4RJUmoO3t2cYirQBhkr/z6jOiRVk91Wbtsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578260; c=relaxed/simple;
	bh=hgnEd2GVPmH09kqdD+MeqD+KaIaC+9v0oUN+syMJdCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JieTvhOwOYtvDZCo1Et8l9rYt+ar/zUjomEXlFutuZ2awTDHxyQV1SpRAY6V4476BTH6J+63I/BwZQCXHMVZ45vM9mf21ze0t3p58zNkAYbpBQrrLoY3QCwa75/wK3a7E4T/P+Aqa4cPDnk0o2OcIJqGa0LIfAl1deiOVC6NHyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfzJCEha; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfzJCEha"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so4589766f8f.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 09:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775578253; cv=none;
        d=google.com; s=arc-20240605;
        b=EXcXXHWwJlC0AYiuMo6yrOyzlz48J/7WCSN7pARL5bGEevWkH1Y94u+YcdW/CcsnEe
         6hCOvUoqd0hgeTGeXeCbUv4ZjInkllkbpELO4kUvwM76RUObfJe//DyvaS5aDdm9Kkrv
         g8wULTpbsFoloiOuLz/90oQqbXXz0VX4xYoG6IOir4Q3DETETfXzH/54oyQRbZ8/RdFo
         yBQeKAJhUzXGCWlLM2+aDX1/96hcek3oPai5yJOLBTQpMx1Hh5AkKFbK7BBbuFqTnNbS
         t2Gd1SpFEchzjwBBNiXVYrlSMhol6b08sv9pX+oGSFGT+dk1B5zFjTgRL0gcLzgfuUCT
         JV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BgzjoXX1E/j+6DLoc36hazeFUTxquP7470zUfJI3j9U=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=hklqR4stVTzeYXr2R0aq1ghtGmoVxhf5Q35nZJYn7hGBapFzGKScpo+zOoTs69XFXL
         ST913FqKun4i0p0AqlYR2KoiRk604R+bLJFGpj3+WbwsKZnrzjTH65hQred9uZ1SKwRu
         iN7B6yJo2CSKnS3+V+RzmL+PniMrqbIX5ltpQDxS+JpwO5q2lZslqGTHKz5qlSfDoblv
         bcnbdjotq4VZkgw79PaJCPEmX9UwTNeO0zwinXKUZU8r/GzRchhdw/4V7KCg98qCOaHC
         MHkfXPkiV8Yve+WpHL8qs8124+Xjfnh6n224YJwN/lF+hXqCZQxwTUQAyzymrM8gx3N9
         Hycw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578253; x=1776183053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgzjoXX1E/j+6DLoc36hazeFUTxquP7470zUfJI3j9U=;
        b=UfzJCEhaEcur54f8JIe+KOvYXmq50/8sWlUVboul6tdLRODE39mXdtkXVsKGLDr09f
         /okz7rALj8VhTZFQv9EM9HhUzoj2qprMUI8EIBKf0f1rEf+cGB5GRQDrO/WGZgOhpiZL
         3xQu5+y6mRMIujbAHNxa0VCcIEGsORuIFlhDqa3WFjMkZLyyZZ+Bz1yv8PxlF/irqOxy
         5drtTr4wi+y36BxqJ3P/Kt0dEaSevaYKX3CWYSJiuhsSFRrxtDkMZzyACWnmUDa9m1vc
         l6XmUyeTWIMVXY1kACS1rw0iaQRdv4M2FelPybZqr3vtsgXaHCEXeGF4pcw80QxiPMEB
         jj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578253; x=1776183053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BgzjoXX1E/j+6DLoc36hazeFUTxquP7470zUfJI3j9U=;
        b=QYa/2ugxDkqENPoS+FZ3Fozzp0aiJvFKySZ0TgcWYTm/2howXVdEAAbi9UM9cw8RYk
         wRKFw26E4zogEF4Ma6zi2HvBbcfjt0sElEHDCjlYe/1DD7hs56b1xYSk1ljpmW16YhIF
         2XlJBx0zy/TTPT7F7R/KvxZH7bycZqhsVrq5Shf1nsE3V0WG7MiHcIHA71A5Gqqhyxgv
         vQJcgUOG+o+7kryWmVkgJkAq1dDPgC5hmaLG9v9xs8yoo32MQEYEIOHyntXvB2J69f3F
         uWjuP1TDAr2OWOIvPEYhU+HhQ+BkQJUGz6rjam7YGQ5/MuYqhue59xBGobKumzdnSvx4
         6vcA==
X-Gm-Message-State: AOJu0YzYJqCQP9aEca5OAS64aV0Hw00lZLKyyisB4nmA+kQT9f3ij5IZ
	wBxqguCWo7ANF+3WFe9wJ9+OkQu3AFo01xal9jJSHlbMTr4cDcY/iN1HS8lckjgEU/Y7OTxJ2Ub
	LpZmKoN9JVHKGQ82wBxKCme7sfmbwbAmlzRmE
X-Gm-Gg: AeBDiet7/jgKpVeb21C5+ZDIrLbLIujvv1pDASISYPbsWY8aNfCbcae2iSPQDevtiR5
	XUKZ8pyJ3MDrMMpCYl7c2C2wsqWuB94KgWtTtDQs4EJ4HRMN2Khnjag2cDW9T/TGaTob7qyZwwP
	rpAoEnbz78Gt+hDRQhorrdoT3C/N2qHB0F5QqB3xfcqIfAzo51AmtyKqYvYQ0fMVaLxy3QT2daO
	J74X0i3fEPRkhChkd27FHJufmKJ7H98lEOfK9aoeGHLOD4bnL0tXwbkpUAS4x46Xbc6+hhlZLVF
	KGDR/xzU9FSFPCCe+lvYHT8+GM7OEVqpww10L/WnNLj30SsjK9vsGwWF2PWtKTJRY6x+R+VwA3M
	/EfvNqBOAiVsL086KbicCYmOOWQ==
X-Received: by 2002:a5d:64e6:0:b0:43d:740:fb37 with SMTP id
 ffacd0b85a97d-43d292cd110mr25762025f8f.24.1775578252568; Tue, 07 Apr 2026
 09:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-2-emil@etsalapatis.com>
In-Reply-To: <20260407045730.13359-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 09:10:40 -0700
X-Gm-Features: AQROBzAq9NRdWUFJdcsv4befWmEEWu5bLxX6iOxYUV7rYmMVfLauvKoE0sZwxmU
Message-ID: <CAADnVQL5Aheo7GrVtxaE0F1xOcUN=6aifGgh8RE9m4Orj0H19A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> The compiler sometimes stores the result of a PTR_TO_ARENA + SCALAR
> addition into the scalar register rather than the pointer register.
> Handle this case by upgrading the destination scalar register to
> PTR_TO_ARENA, matching the existing handling when the destination is
> already PTR_TO_ARENA.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/verifier.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..30bb71f90477 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16297,11 +16297,34 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>         int err;
>
>         dst_reg =3D &regs[insn->dst_reg];
> -       src_reg =3D NULL;
> +       if (BPF_SRC(insn->code) =3D=3D BPF_X)
> +               src_reg =3D &regs[insn->src_reg];
> +       else
> +               src_reg =3D NULL;
>
> -       if (dst_reg->type =3D=3D PTR_TO_ARENA) {
> +       /* Case where at least one operand is an arena. */
> +       if (dst_reg->type =3D=3D PTR_TO_ARENA || (src_reg && src_reg->typ=
e =3D=3D PTR_TO_ARENA)) {
>                 struct bpf_insn_aux_data *aux =3D cur_aux(env);
>
> +               /* The compiler sometimes stores the result of a SCALAR/P=
TR_TO_ARENA
> +                * operation into the scalar register. Properly mark the =
result as
> +                * holding an arena pointer.
> +                */

No networking comment style in the new code. Please.
Can probably drop the whole comment.

> +               if (dst_reg->type !=3D PTR_TO_ARENA) {
> +                       /* Can't do arena arithmetic with non-scalars. */
> +                       if (dst_reg->type !=3D SCALAR_VALUE) {
> +                               verbose(env, "R%d pointer %s arena prohib=
ited\n",

How agents suppose to understand this message ?
The comment right above it is more meaningful than this verifier message.

> +                                       insn->dst_reg,
> +                                       bpf_alu_string[opcode >> 4]);
> +                               return -EACCES;
> +                       }
> +
> +                       /* We have a SCALAR_PTR_TO_ARENA operation,
> +                        * propagate the info to dst_reg. */

As Leon said...
Also SCALAR_PTR_TO_ARENA is a new enum invention.
I say, just remove the comment.

> +                       *dst_reg =3D *src_reg;
> +               }
> +
> +
>                 if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
>                         /*
>                          * 32-bit operations zero upper bits automaticall=
y.
> --
> 2.53.0
>
