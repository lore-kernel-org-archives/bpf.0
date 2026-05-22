Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3534E766
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779421660; cv=none; b=bKaK2g0pi1qWjxHwaL74PYhlHiMvR8AYr83OytQooQdqmXDfLayB5HqnsR761hfz8+dqJY/dU9/Iu8W0q24GMgS7WJTHGcTp+0SpZOrLY9uFiMRufFkC1WjFPFHEf9GMX9zI8A6P5Td133Ou7RnbAiat6LpTueoBQlxIkbDlpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779421660; c=relaxed/simple;
	bh=OFqf0NxWu3KtmR+ESvy9OHWBqQSWHuppEU0lJJAii7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMfmc/Bu8pVt9ZfCEH4aacoK62+AvDKdSgdm8a2kxf3Ne3HIdTPvHcwXgDAuh+ELAJBP3nNw8mAWh8MXeJsmRdLets+0wd1MmvZ801LLADFJ7zzRy8qhB+JqOQTL7R7FrBJjvnxZP9f79FT+Ct34jpbO2jjR9Io4lYZoDjQpkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiF1p7BX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiF1p7BX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EB11F00A3E
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 03:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779421656;
	bh=aRUrjq6UmND7bgt05ehxJpaJzPVYrNGQ+mv6AME8wXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OiF1p7BXODXAz8GG60+ZAqA2UTxaJvcwK+0RYG3xOzoHE5Elq+0B/vKaUuG5Ramio
	 2BnrRSymr2L5y+GFzK2h9MRC7y/8ADKY5Rldp29F5Q179qryTGWpCp0Hy1+6bcqkEK
	 e/pbJuKygQFMun1sUg3twjklQlulVuqy9ucZKeK8JpWB4ZixbQwvM7/KYB28HEDd34
	 MLcg6JcE3vxHO0juOaTUiHxM1KFQ+GwchrSZMub7UfPP9oHFtc1W8iTeV6uVzSZUJs
	 MXRJrUMK9HAVGJBfnYvduFOKNU5OWsLG+anuINNIZuBhX1uT3aME1PPpG26tRg0zK9
	 liBU/yK8ONgFg==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so32822785e9.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 20:47:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/oPEBzIkzHsikDhtP7ANEnunshaBDoRfRW3mFQIPpB9z/d6vjaqYCAaTdbfKblLsQ4p2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTdbhhESqK617P2EqkAoIt5sRRkc7SgqTISaKEYV2Cbeb6j3un
	eIhTUgAFz0ho+S2/WM4F/c5A/P0O6iX0VgeKGswoWkEM82GVS+wL0kCSAS8+2ftREGP9Y1//4QJ
	vNnETQqxMk9yYyiGqjX0XfswwPgghTeRbGcYIRkAR
X-Received: by 2002:a05:600c:5298:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490428dd523mr18183585e9.25.1779421654672; Thu, 21 May 2026
 20:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521152217.2345235-3-kpsingh@kernel.org> <20260521165240.D95EA1F000E9@smtp.kernel.org>
 <CACYkzJ47rASFZLZPz2VU9FE7J2-hGdw2f-5LQYmXoB9urVwRqQ@mail.gmail.com> <CAADnVQLJw=Dk=VjWmot4O1WLm2TxLH+-mX3G8AuPd9f_5rAJCA@mail.gmail.com>
In-Reply-To: <CAADnVQLJw=Dk=VjWmot4O1WLm2TxLH+-mX3G8AuPd9f_5rAJCA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 22 May 2026 05:47:23 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4LO2tAdarpKAO3Nz-XjCiJ3+tNkBp_kXEr-2YqOnCwMQ@mail.gmail.com>
X-Gm-Features: AVHnY4ITCxFUj4A9fbyPW-DCeoQ91orAkt2w-7HK3bZX5vWHDue-rH6ETxuxd1w
Message-ID: <CACYkzJ4LO2tAdarpKAO3Nz-XjCiJ3+tNkBp_kXEr-2YqOnCwMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf, libbpf: reject non-exclusive metadata maps in
 the signed loader
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 9:09=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > On Thu, May 21, 2026 at 6:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> > > - [High] The BPF verifier will reject the `gen_loader` program on 32-=
bit architectures because it accesses a 4-byte pointer using an 8-byte read=
.
> > > - [Low] Multi-line comments do not follow the mandatory BPF subsystem=
 standard.
> > > --
> > >
> > > commit 878a81f0d9571d5734eccfbe01c3dfe58050f954
> > > Author: KP Singh <kpsingh@kernel.org>
> > >
> > > bpf, libbpf: reject non-exclusive metadata maps in the signed loader
> >
> > [...]
> >
> > > > +     /* Reject if the metadata map is not exclusive. Without exclu=
sivity
> > > > +      * the cached map->sha[] verified above can be stale: another=
 BPF
> > > > +      * program with map access could have mutated the contents be=
tween
> > > > +      * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> > > > +      */
> > >
> > > [Severity: Low]
> > > This isn't a bug, but does this multi-line comment follow the BPF
> > > subsystem style guidelines? It looks like the opening /* should be on=
 its
> > > own line.
> >
> > Sashiko, this is how we comment in BPF.
>
> No. Sashiko is correct. bpf doesn't use the old networking style anymore.
>
> > >
> > > > +     emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_ID=
X,
> > > > +                                      0, 0, 0, 0));
> > > > +     emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DW=
ORD_SIZE * sizeof(__u64)));
> > >
> > > [Severity: High]
> > > Will this 8-byte read pass the verifier on 32-bit architectures?
> > >
> > > While __bpf_md_ptr pads the C struct field to 8 bytes, unnamed bitfie=
lds
> > > are not emitted in BTF. The kernel's BTF will represent the pointer m=
ember
> > > with a size of 4 bytes on 32-bit systems.
> > >
> > > Since btf_struct_walk() enforces that the memory access size exactly =
matches
> > > the BTF pointer size, it seems the verifier will reject this BPF_DW a=
ccess
> > > with a cannot access ptr member error on 32-bit architectures.
> > >
> >
> > Good find Sashiko!
> >
> > __bpf_md_ptr doesn't help =E2=80=94 unnamed bitfields are stripped
> >   from BTF:
> >
> >     $ bpftool btf dump file vmlinux | grep -A1 '^\[1462\]'
> >     [1462] UNION '(anon)' size=3D8 vlen=3D1
> >             'excl_prog_sha' type_id=3D17 bits_offset=3D0
> >
> > vlen=3D1, no padding. On 32-bit the pointer is 4 bytes, BPF_DW is 8,
> > btf_struct_walk rejects (msize !=3D size). BPF_W doesn't work on
> > 64-bit either (4 !=3D 8).
> >
> > gen_loader needs target pointer size tracking (like swapped_endian)
> > to emit the right sized read. Will revert __bpf_md_ptr and do that
> > As a follow-up, I need to re-spin anyway since I messed up PATCH "bpf"
> > and probably confused the CI.
>
> hmm. I think AI is wrong here. size=3D8 is all we need.
> I think BPF_DW should work. Pls double check. Don't rely on AI guesses.

I wrestled with the AI to create some test code, it still does seem to
fail, anything missing in this diff?

https://raw.githubusercontent.com/sinkap/linux/bpf-md-ptr-32bit-test/test_b=
pf_32bit.sh

commit 13fa71a6e16b6f024da481bb7a733c312974ed32 (HEAD)
Author: KP Singh <kpsingh@kernel.org>
Date:   Fri May 22 05:18:32 2026 +0200

    bpf: use __bpf_md_ptr for excl_prog_sha in struct bpf_map

 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

commit 13fa71a6e16b6f024da481bb7a733c312974ed32 (HEAD)
Author: KP Singh <kpsingh@kernel.org>
Date:   Fri May 22 05:18:32 2026 +0200

    bpf: use __bpf_md_ptr for excl_prog_sha in struct bpf_map

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 11bec73db199..ea9bd24f82c0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -295,7 +295,7 @@ struct bpf_map_owner {

 struct bpf_map {
        u8 sha[SHA256_DIGEST_SIZE];
-       char *excl_prog_sha;
+       __bpf_md_ptr(char *, excl_prog_sha);
        const struct bpf_map_ops *ops;
        struct bpf_map *inner_map_meta;
 #ifdef CONFIG_SECURITY

Building (deps, selftests, 32-bit kernel, rootfs)...
Full log: /tmp/bpf32-build.log
done.

=3D=3D=3D 32-bit BTF =3D=3D=3D
[79128] STRUCT 'bpf_map' size=3D224 vlen=3D33
'sha' type_id=3D70 bits_offset=3D0
'(anon)' type_id=3D1349 bits_offset=3D256
'ops' type_id=3D1351 bits_offset=3D320
'inner_map_meta' type_id=3D1265 bits_offset=3D352
'security' type_id=3D30 bits_offset=3D384
'map_type' type_id=3D79193 bits_offset=3D416
'key_size' type_id=3D139067 bits_offset=3D448
'value_size' type_id=3D139067 bits_offset=3D480
--

=3D=3D=3D Boot 32-bit QEMU =3D=3D=3D
qemu-system-i386: terminating on signal 15 from pid 4116468 (/bin/bash)

=3D=3D=3D QEMU serial output =3D=3D=3D
[    0.000000] Linux version 7.1.0-rc3-g13fa71a6e16b
(kpsingh@kpsingh-genoa) (gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0, GNU ld
(GNU Binutils for Ubuntu) 2.46) #3 SMP PREEMPT_DYNAMIC Fri May 22
05:25:14 CEST 2026
[    0.000000] x86/CPU: Model not found in latest microcode list
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]  Sys

[...]

=3D=3D=3D Running atomics signed lskel on 32-bit =3D=3D=3D
REJECTED: load: Permission denied (errno 13)
LOG: 0: R1=3Dctx() R10=3Dfp0
0: (bf) r6 =3D r1                       ; R1=3Dctx() R6=3Dctx()
1: (bf) r1 =3D r10                      ; R1=3Dfp0 R10=3Dfp0
2: (07) r1 +=3D -136                    ; R1=3Dfp-136
3: (b7) r2 =3D 136                      ; R2=3D136
4: (b7) r3 =3D 0                        ; R3=3D0
5: (85) call bpf_probe_read_kernel#113        ; fp-104=3Dppppmmmm
fp-112=3Dmmmmmmmm fp-120=3Dmmmmmmmm fp-128=3Dmmmmmmmm fp-136=3Dmmmmmmmm
6: (05) goto pc+41
48: (18) r1 =3D 0xc1258000              ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976)
50: (79) r2 =3D *(u64 *)(r1 +0)         ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976) R2=3Dscalar()
51: (18) r3 =3D 0x687c37c5f0d1a81f      ; R3=3D0x687c37c5f0d1a81f
53: (b7) r7 =3D -22                     ; R7=3D-22
54: (5d) if r2 !=3D r3 goto pc-48       ; R2=3D0x687c37c5f0d1a81f
R3=3D0x687c37c5f0d1a81f
55: (18) r1 =3D 0xc1258000              ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976)
57: (79) r2 =3D *(u64 *)(r1 +8)         ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976) R2=3Dscalar()
58: (18) r3 =3D 0x50bbf46171f6280f      ; R3=3D0x50bbf46171f6280f
60: (b7) r7 =3D -22                     ; R7=3D-22
61: (5d) if r2 !=3D r3 goto pc-55       ; R2=3D0x50bbf46171f6280f
R3=3D0x50bbf46171f6280f
62: (18) r1 =3D 0xc1258000              ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976)
64: (79) r2 =3D *(u64 *)(r1 +16)        ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976) R2=3Dscalar()
65: (18) r3 =3D 0x62d310438c86b5f6      ; R3=3D0x62d310438c86b5f6
67: (b7) r7 =3D -22                     ; R7=3D-22
68: (5d) if r2 !=3D r3 goto pc-62       ; R2=3D0x62d310438c86b5f6
R3=3D0x62d310438c86b5f6
69: (18) r1 =3D 0xc1258000              ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976)
71: (79) r2 =3D *(u64 *)(r1 +24)        ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976) R2=3Dscalar()
72: (18) r3 =3D 0xc5a92d04886f9627      ; R3=3D0xc5a92d04886f9627
74: (b7) r7 =3D -22                     ; R7=3D-22
75: (5d) if r2 !=3D r3 goto pc-69       ; R2=3D0xc5a92d04886f9627
R3=3D0xc5a92d04886f9627
76: (18) r1 =3D 0xc1258000              ;
R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976)
78: (79) r2 =3D *(u64 *)(r1 +32)
cannot access ptr member excl_prog_sha with moff 0 in struct (anon)
with off 0 size 8
processed 29 insns (limit 1000000) max_states_per_insn 0 total_states
2 peak_states 2 mark_read 0
