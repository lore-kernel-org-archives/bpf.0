Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D55625
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355112; cv=pass; b=RxQ5fMR6Ss5F1xBE2gTKOleCWks+SiiQqrdI0DAtlVmLpC6MOHUGUjxvKn7VJLGRYrry5fxMPrPNIQphpJFaJexedRmWSNhbxSxdcoSc/WJlapyY3ssUGZVxjmxi9pvHjulKkQj5EIx/m/M6aEuRNwjV+RiClcKmoBalKIuCMLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355112; c=relaxed/simple;
	bh=xBE2TSsTPsqB7Mtk6zE5tAycoOMC35uli/y22UX1+zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrIbgkwBrQXBqqwSRS1wbGrsv8sOAxZuA1BlOxOgt600JHLoczgfqYt9MVhMDiwnX8t+AkfXNa8B7FPFZ/MbO0CSXz9Q+9clZ8h7U5zm9EH+FU1pSUzshED8wP6hjnyVhgryaHGjAcBlD6ngz1QCPe1/b7dZzdvVBLq9bAfYngw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGmT3Yyb; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGmT3Yyb"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so3067406a12.2
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771355110; cv=none;
        d=google.com; s=arc-20240605;
        b=Tjykcdbk8g71nNQlLKiqVDTsc4bCSAyZ882QmHQVQGQyfgj2CHqo/RahOD3lRS20S9
         LO/AvnP6BMGLJaTlvYNe5hjB7TKkuaPsmJnNZvatlLsMuqWTEi2rDD9xzxW/oA1W5wKz
         eP2O6O1SH4xeU/MyVAcrJXFM4LiqHeniTluBJOo8Dc6WT5i+BvMzd94lDO/VuaeDl1ks
         Q0iEtNq9z3Sswq48kJkpr2Mq9hBcFfP6tINDLOtgDvzViTRM7tdwf8y7eS6idP551gLP
         GqPaEPHcDAgU9UWzGkw3d9NOKCzG+J9hH+GhY1mnIrqsPYpIr8UOyLkWu+TBEe8RmIg1
         LDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d5CX0BVyYhnUjcQxMQdv3o1MzA2r+tV/cZOpNmoI9xI=;
        fh=kQJoHmciZhFE410Bsj90HR7sS6L9VfCXE26CeirnTkI=;
        b=NmEDyhvX1rrWzzr//yzuV8ozPftriqgvHRVquVoXPqxickz8NGIXrU94uP8BFZ8EgH
         B9Asx5xXFcMPLaxEFA6QQ/tdL9vDvtOcaxPX93xLiEJuSHmM/Ek2+64m4PaOJkJ+sS/y
         Dp9O5ltf/LUSrO6FeRY7SsaXFJhudz5nsdSHsmXKSLLCIFMcQjPt5tcSnBSRBmgomyPq
         o0qtG87RfTUTFDqbxzVY/0E3ciMJdLRtlSxLA+Yyn5RGLRstWD1fbz+NqhyuO7BS+/mS
         C+MSyZvjMt0oXD5svGiP9HexUx09xeI42d7QOlO9JLiXqQiBBp3PbEdHUJ7ihLCpf0Ew
         XvHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771355110; x=1771959910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5CX0BVyYhnUjcQxMQdv3o1MzA2r+tV/cZOpNmoI9xI=;
        b=eGmT3YybxixW6LVrwwDv5baXgO+VG0lH5YoZQ3TJx6HK61KNBGW2KBivG6R1mEXv2J
         8VwpIr7+1UjKAdpnOSdpwJTuw9f5l1hRTcRS58CHNQWvCOSEt/qLubi/BUvPrZNC8Xw8
         pTYG/rE7MypPgjORZZccOyxmYqGSSw5TtQdxo8tKnNMcTaUaAO0GvFBX9u1hR3L3v63V
         bEO0xhwptj6qe/1uAos5yOL7UqisPSHnv4+oxIw3QdehxF64WDd8jsWOxz+2v+aqICdL
         fubRUF2y5qTrYLdxv67NRPQxZ4wFDFa+DyXgHDmqaX7dw7CRXL3Uk5KpercjmG0aynvc
         SP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771355110; x=1771959910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d5CX0BVyYhnUjcQxMQdv3o1MzA2r+tV/cZOpNmoI9xI=;
        b=CAHjY5vXEyJKFLaY+ZiPqyUl2q7jLjbLQNXV6GPB00q+Gczxrq3DmEfc4YpKgE3ezd
         JsL2FbpuSiaIxVn5p7yrx3AcOqIeeRHPsCbdGc5YEy5pit6OP6gpe03fculGIsDsM3az
         ohMu/2qwoctZVBz8zk9QjOPRJwvESOW8JfkQ/48qQLpnGlEcsOOyMptDnh/I7+6EHJbo
         8WGCUK0KA1nruT1neYcir481Q80dMRtADK8M9ogDCi0HC8L53srQ2vvIiu5RMWyFVilk
         JfsTbSLk/QHJ0yih/H8sC05BX+MuGddeQjbwAPYRapg0YX6o38fk9AMc9dbplpfKs7EO
         SpHQ==
X-Gm-Message-State: AOJu0YyxMfvYfl1Q0YoRg9HlN+CbZBhFTB9ShBO7lXq8T2IP73Tn0NTz
	YYjOqkDryHbQXfroLtEQgVA1WtL3vgsCxwf7q0WP4b/gNpdHXl7v73AiER7A/uIeubvAOYHISZP
	8AJfflmYciq2tclE0rR2/P79JZIn2da0=
X-Gm-Gg: AZuq6aIFUvbqwA1YluJ4V7qC2G45/9Ok/SxB/Uom/Rzr0IXzXvLkBoMWsxgYa0UKDvm
	I+yEapu4fWBD1I0rSx0hoOzxmEdn4if5SvRjqPsid1QShIo5U6XXhauS0AQKFGsheb2XaqXFnG5
	MdVv0V2/iL365ICG9N31yLliiicdVBwO5tcgABtC/AGHRgnIUOIPvFTx6sbnIAXWJE3fEyA8maq
	sTsg/EB9vPIZnlNF8+89OkohpXv7g6gX3H3s/c9QmQvH4BjxxdqLBtjq6sq28g+zBDnDNTHV1/X
	MYYMNCpjW1dxaM2Ek6cAYfY=
X-Received: by 2002:a17:903:1447:b0:2aa:dbf7:7449 with SMTP id
 d9443c01a7336-2ad17501fbemr150297075ad.37.1771355110520; Tue, 17 Feb 2026
 11:05:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214021014.15670-1-emil@etsalapatis.com> <20260214021014.15670-2-emil@etsalapatis.com>
In-Reply-To: <20260214021014.15670-2-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Feb 2026 11:04:58 -0800
X-Gm-Features: AaiRm53DRjR8U8g10QGiSysKgq7l0CbLsL6bbjDmpnqiJTjKxPpNIg8_rDAeLBM
Message-ID: <CAEf4BzbxSRCxT9+3pjU_kN0K6R30RBXJ4UKOMZaRZe9FofBoRQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] libbpf: Do not use PROG_TYPE_TRACEPOINT
 program for feature gating
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 6:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> Commit 728ff167910e uses a PROG_TYPE_TRACEPOINT BPF test program to
> check whether the running kernel supports large LDIMM64 offsets. The
> feature gate incorrectly assumes that the program will fail at
> verification time with one of two messages, depending on whether the
> feature is supported by the running kernel. However,
> PROG_TYPE_TRACEPOINT programs may fail to load before verification even
> starts, e.g., if the shell does not have the appropriate capabilities.
> Use a BPF_PROG_TYPE_SOCKET_FILTER program for the feature gate instead.
>
> Also fix two minor issues. First, ensure the log buffer for the test is
> initialized: Failing program load before verification led to libbpf dumpi=
ng
> uninitialized data to stdout. Also, ensure that close() is only called
> for program_fd in the probe if the program load actually succeeded. The
> call was currently failing silently with -EBADF most of the time.
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation fea=
ture")
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/lib/bpf/features.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b65ab109e3ff..cf3937e08520 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -508,7 +508,7 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>
>  static int probe_ldimm64_full_range_off(int token_fd)
>  {
> -       char log_buf[1024];
> +       char log_buf[1024] =3D {};

minor nit: this will clear whole log_buf, but we really just need to
set first character to zero, so instead I'd do

log_buf[0] =3D '\0';

before program load


minor, because this is not performance critical code, but it's a bit
wasteful nevertheless

>         int prog_fd, map_fd;
>         int ret;
>         LIBBPF_OPTS(bpf_map_create_opts, map_opts,
> @@ -536,14 +536,14 @@ static int probe_ldimm64_full_range_off(int token_f=
d)
>         }
>         insns[0].imm =3D map_fd;
>
> -       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, "global_reloc=
", "GPL", insns, insn_cnt, &prog_opts);
> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "global_re=
loc", "GPL", insns, insn_cnt, &prog_opts);
>         ret =3D -errno;
>
>         close(map_fd);
> -       close(prog_fd);
>
>         if (prog_fd >=3D 0) {
>                 pr_warn("Error in %s(): Program loading unexpectedly succ=
eeded.\n", __func__);
> +               close(prog_fd);
>                 return -EINVAL;
>         }
>
> --
> 2.49.0
>
>
