Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60C175A79
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389976; cv=none; b=bBVasssyVyNbYhZta1TyC0JjovKwCwtDr4Jy5/HCV6xLBtUAm1d1kAowRf2Rj1iRvNq29VC2Yr8vQCyMdOq46z/A42bFnLXDIMDB2eDxOsBI0s26aeKE9BFpCWnnkLWfuK/UGXKmhnAVesXiJlXJW6ZZjjgbDaEZFmLHmjNm6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389976; c=relaxed/simple;
	bh=R6FEUBYA06hsDYNSLr7aWIvbxPxEeCt1RxhTBBrf+nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgoymi+xBKfs8dDjyQl/eKw39MUynT6G6NiOyVSnHY2ICHGtiSoXsVhSvmcKFU6hHMe6PeOQ8cjGmrbUbXIRAc0w6TQsDttPsQ7h/Vyo38JLOkE9WmG5NMPYV3iYl8vMfXKYD3HXc8mVSHmLpqS13tY3pvI12L44UmXH+XZd7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv4AR2BX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv4AR2BX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC81F00A3C
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779389975;
	bh=7cfoEJcpP//Ki/e2IAwslnxZGdOe1dNTVmUeaTGI3vg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Iv4AR2BXcTwg136CdO/IVh2OJ9+79oK72d5VpVk345GYAxUkTBts2A7j9nAogUSH3
	 +qVCEadYtYvj2msX0zzDB6E8bvr/rHhtBVABWBrSOTNaodROzTzqZmqfeiTwL2EYzx
	 NEGzLF2COskUonnDWZuMcQbiIr5NYfgQgoNeNAOyeVOVjAk/+fVxkPNzkwzfY3QGdm
	 KoSHQg8neiRBCYmgsDSlm3q9+u6iYij85luXPWy8lG4q62dX+wGy/HL5Noi1ZV7nLB
	 QXM7/BYWHBsfT3i416Zzo22xTtyVIG2yT6QafUoxq0elh98VYr826kfXA+AsuTWeyB
	 p7WwMHo8wjoSQ==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso54735405e9.0
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 11:59:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YxdJXNEzXK2pPBX131zplCSa6JLcmB9I1M74XIHcw1jsCkz2NbL
	WoRcV/h8M3p9GDqEABOSXbUyy9DTnNdZn5VgLZoOyIqaICRDGgSaSGxXJdoKJRq9jbEEXIPgLxo
	R6LrtFMpQP9tujRvmgH1QDkX8SVvrPoI370DQcTe2
X-Received: by 2002:a05:600d:840c:20b0:490:41b6:4d87 with SMTP id
 5b1f17b1804b1-4904248b0b8mr695815e9.4.1779389973789; Thu, 21 May 2026
 11:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521152217.2345235-3-kpsingh@kernel.org> <20260521165240.D95EA1F000E9@smtp.kernel.org>
In-Reply-To: <20260521165240.D95EA1F000E9@smtp.kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 21 May 2026 20:59:22 +0200
X-Gmail-Original-Message-ID: <CACYkzJ47rASFZLZPz2VU9FE7J2-hGdw2f-5LQYmXoB9urVwRqQ@mail.gmail.com>
X-Gm-Features: AVHnY4K6PUI1V_NLphdY9s4xZy1tPcZtTPOJWQxZpCfCIEqiUoCkQTUlhfRmuOI
Message-ID: <CACYkzJ47rASFZLZPz2VU9FE7J2-hGdw2f-5LQYmXoB9urVwRqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf, libbpf: reject non-exclusive metadata maps in
 the signed loader
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The BPF verifier will reject the `gen_loader` program on 32-bit =
architectures because it accesses a 4-byte pointer using an 8-byte read.
> - [Low] Multi-line comments do not follow the mandatory BPF subsystem sta=
ndard.
> --
>
> commit 878a81f0d9571d5734eccfbe01c3dfe58050f954
> Author: KP Singh <kpsingh@kernel.org>
>
> bpf, libbpf: reject non-exclusive metadata maps in the signed loader

[...]

> > +     /* Reject if the metadata map is not exclusive. Without exclusivi=
ty
> > +      * the cached map->sha[] verified above can be stale: another BPF
> > +      * program with map access could have mutated the contents betwee=
n
> > +      * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> > +      */
>
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the BPF
> subsystem style guidelines? It looks like the opening /* should be on its
> own line.

Sashiko, this is how we comment in BPF.

>
> > +     emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> > +                                      0, 0, 0, 0));
> > +     emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_=
SIZE * sizeof(__u64)));
>
> [Severity: High]
> Will this 8-byte read pass the verifier on 32-bit architectures?
>
> While __bpf_md_ptr pads the C struct field to 8 bytes, unnamed bitfields
> are not emitted in BTF. The kernel's BTF will represent the pointer membe=
r
> with a size of 4 bytes on 32-bit systems.
>
> Since btf_struct_walk() enforces that the memory access size exactly matc=
hes
> the BTF pointer size, it seems the verifier will reject this BPF_DW acces=
s
> with a cannot access ptr member error on 32-bit architectures.
>

Good find Sashiko!

__bpf_md_ptr doesn't help =E2=80=94 unnamed bitfields are stripped
  from BTF:

    $ bpftool btf dump file vmlinux | grep -A1 '^\[1462\]'
    [1462] UNION '(anon)' size=3D8 vlen=3D1
            'excl_prog_sha' type_id=3D17 bits_offset=3D0

vlen=3D1, no padding. On 32-bit the pointer is 4 bytes, BPF_DW is 8,
btf_struct_walk rejects (msize !=3D size). BPF_W doesn't work on
64-bit either (4 !=3D 8).

gen_loader needs target pointer size tracking (like swapped_endian)
to emit the right sized read. Will revert __bpf_md_ptr and do that
As a follow-up, I need to re-spin anyway since I messed up PATCH "bpf"
and probably confused the CI.

- KP

> > diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/too=
ls/testing/selftests/bpf/progs/verifier_map_ptr.c
> > index e2767d27d8aaf..baef2e93cb414 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c

[...]

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521152217.23=
45235-1-kpsingh@kernel.org?part=3D2
