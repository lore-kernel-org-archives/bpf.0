Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795646993;
	b=ndvbFUE319cOI3bm2wdN4PQBm2Gx7AWb9iyNyGDgy0hjV0pUTZSJtTL+hTofGr021AHc
	 bOsBDO0LqYGnkcIY/h2Rh4ywbsOG0DEjCzgmAvYOUtCvj7b/sIhogR0IdCPDy9z1Ayi/h
	 NFo+kQ2MD8LYGX2cRR/bb9rGf2a61BZYjAowIp44upC9ojeEx8Y+Ddlv/has0OYC7AgLx
	 mZVB8SzFdr31S+7a1jDvS9k34FiJLt+QcuoY1leOP535jj7ba4U3JpVFLIOjkg0f723nZ
	 kOlS/7btzNJhcYFkiCU5flm1PnqGI9TtbAZrkjjdYjBS+fyGbnGPjyuUkmqYSR8dVtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PU/CD7cZhI9wMkWdpn5UNu/iaTedUIUl7VHMq0M4TJY=;
	b=Yi4pcfddL85p0VTbSbgfRMgWAuL7s5wEN5yqzty8tHaejXRt+BSybanYdfueLV0jK6vF
	 WQcrLHaR4Hs2BVv8niWeZiknKQ3Zh/bImKYu2y5eBW7w8UuUo3kRb1jflq0LCyOZUm7CH
	 QskeONQv4R4JtGpHQ0d7mBWwVejyjeYvUGSbTjKLTWM06DcmG2ZEG62M67xkgY3wHVk8L
	 D0AFdaHkLwOiswrPD2uYO0jeiCiGd1hrhVjbbYZJJrMpsIBEl5gqYNLAbexbq/lNhmcjY
	 yR+FKqgVkb8Y1f3K7sCdfoWS4WrzunOTIHftEZxr5lj6Apr/fgc+AuDNQQ9I0tznltw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FXSqxLuU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD0606A6A2
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 22:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5BD0606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FXSqxLuU
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so3990078f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795646991; cv=none;
        d=google.com; s=arc-20260327;
        b=K2WIeZeSNNKKs+DFgfoPgeMW1Wr6btgo5Y0yMwYbwZagTRAQ8Dbvw+JYIveUpGs0nt
         IWhsymK/ufnuSnImy3DsA2BMPTpQGcnu2OKfC7PVmu5jF5/yxYETc93v5vXcOIfi0Vxe
         xyBbI5o/OAO9wp0Y6mFykzrDljcQ6K/LdlboTTjDeUc+tKK6rhnioN2MZbtUj8XPaIxu
         RCIVidPiL/KTwf76pAyYmYFyqDWUpkSZHmAtv0jv6kTS2YsSE/pm/ph+HtjiDWXRgHwQ
         AjHxie/NbjnrkeOyIqakPx/N1LUjg+eSrHQzd0oPggWtYu9kFviTteeV31pMJbaoSp0N
         H/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PU/CD7cZhI9wMkWdpn5UNu/iaTedUIUl7VHMq0M4TJY=;
        fh=M+wDuEQATPFRtzUoRp8Yjrha2E/E9XlCSIQ/SrW1FIM=;
        b=TZHSMCNqotH68eAWsPgM++x2vlOBBcT36lEH5kdeHeYxK6VVLmvQBuZhTkR5n/otZt
         SaOHJaxUp1Jo7PZPlytJPzG3zde5ylByYV6zKeJjejdGnCga1tp42wY107bCq4+I0MCy
         CVZphTTssP/Udi8gwdtH+ysr0QsDVriFwuQ70EX1C2+MwCzPS+tcI5yGkKeQpZLVPKm1
         O5C0OOqEIy3FLD4GbLYmmdyquvggFBAZQS6DYqKkxk9tGgStiP8KYA4IGlSXuoBft3Ne
         LWQHha6BJKTr3bNAEcwV/Xs4+rRk5GiIKKa33uhg5/Xxgm89aZnHbZlmT6ae+zHfuELp
         u1WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795646991; x=1796251791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PU/CD7cZhI9wMkWdpn5UNu/iaTedUIUl7VHMq0M4TJY=;
        b=FXSqxLuUmrchgEuUdkYgQgcGoHywiuM3bsjV9i1beGO67X8TqNsWpEf7KjSb5nWYDT
         pNWh27OIAnbB4ZUk3Th1ea/Cvhj2YLCCiw5accCVKma9pTYWKwTTUS28sRUbWvH05d3V
         Km0iNeK4UQl9rqW8Sn1h2tQ4HaSK2+I211EnbLy6A7eMBkSamzYBi8w4wY2ItpVA0w1z
         pqPzcXEwRaIrLzI22vvjiCgJG4JOSAi23SKnpbsbonSIStbe9rKo0gA1uyNHtTycxget
         KZh5DTljzVQs3r1K3CpmQ6CaD3N0dk5sP/qh81T2w1WS3pOBqf1zyOL41XLCGy0JSErp
         Lj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795646991; x=1796251791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PU/CD7cZhI9wMkWdpn5UNu/iaTedUIUl7VHMq0M4TJY=;
        b=hbPMbgr28i+EQJYs4kaAGlOFeUzQlDEeVtOMpIaBKr2GoG6YZVKd/6qAwNyExHEe8V
         KKsi1r36tW+4S1JNRjdCciAdu+FQClHOWDK+YMx1fgQH4XZIfk4UzpmphhFnRLRb5G7s
         ECbpMpAQhTiAKHNUwIufXfsc1oeJl/9O5KlOyK7MDZ0+Zici5yyaTHSKKhahQHRchh1L
         W9iIPoraak7+eg361suZE8p9vptC6YI9ogR1vqRiTpH7JlaGmQGp8uqGFsUm5zF5JeN6
         5kJXXVsCDdktPPGWclDAb1XmhSS6dTNMysjROjibVTK1FI07A9FcHamCdLhSJmY21IT5
         pMhw==
X-Forwarded-Encrypted: i=1; AL+hErFva5eefR32bjWPWQqgMTm70jdwhqcdM5hi/UtpRQgN7U/SBjtQ+TTHQd6ZeMiH5ow62UY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TRECAj8gPiLjwo6pZv5079ayewS7AaBiLHkMjXpsw4+9mLFZf
	kfwkbxtdgKx+t9YecBy2mSCBUqsUMBqdsK/WYQDePn6A8nhIoKxAKnsF0IHYKTUNfD0p9vcttce
	SLefvfJtXpohXAXGVxWpQO/Dq0jD+kRY=
X-Gm-Gg: AZFdTZclVQbVovZMVVMs3X040XB7a6fmsDJvcjX/WGph6/KOdb2fB0TIaWj36Hcxoxj
	vbZL2SITqgXgwewcDrMLumkiDU90Ja7RRwhuB9nQYjZBwcAfVMP0GANy8bNIZ3zfWA1xx6c6/EL
	l8KImgpfjv2f4L2M8XJ9G6CH4gqD57gFG1Q7Rm7jk1XgvMmrVFxlg2/PcwLzpDpXhVJgg3On19o
	zifyQ613eDB/80sgD4GUkZrr+5JvW4Jt9W/Np6VbW2gbrkKcDf7e4duGPHoUwFvCWTWb81MHE83
	qnfhz5+qS3Mg4OiVG9C9cXDTWmxN32qW5Mc8CRMm0HI8Tl+awnjzfYwFzqMHusQ717YS0njwWXr
	Fj4HU0DC3EvzTshxp0rlQu8T6k5MelG/VbJjvzCaP8+pgs8ZKbHvP+mElYZ8AEZS0SCATOzpoGi
	2j4SwOD4oaAW6SEvuBEg==
X-Received: by 2002:a5d:5d0c:0:b0:4b7:730e:bec1 with SMTP id
 ffacd0b85a97d-4b7730ebeefmr15113896f8f.33.1795646990851; Wed, 25 Nov 2026
 14:49:50 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125165845.45806-1-almagui@kernel.org>
In-Reply-To: <20261125165845.45806-1-almagui@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 14:49:39 -0800
X-Gm-Features: Aa3M54o58YrbuSZOEtSJqp0ZiIQC49JvZvHG2HaBAg7MWJmC_2LE3BKduOTQ6Bs
Message-ID: <CAEf4BzbkrVyCSW1aRCo_s=2pxK7NRfUnznk21CY4-txqveRcnQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/5] libbpf, bpf: Utilize CO-RE for BPF
 program parameter presence, ordering
To: Alan Maguire <almagui@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	andrey.grodzovsky@crowdstrike.com, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, mason@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 8:58=E2=80=AFAM Alan Maguire <almagui@kernel.org> w=
rote:
>
> Currently the BPF_PROG() family of macros greatly facilitates
> BPF tracing/LSM program writing by allowing specification
> of function, tracepoint or LSM hook arguments directly by
> name and type.  These are then mapped to a context struct
> consisting of a u64 array, with one value for each argument,
> with by-value structs larger than 8 bytes taking more than
> one slot.
>
> When an attach target gains, loses or reorders parameters
> across kernels, programs silently read the wrong argument
> or fail verification, and they have no way to check if an
> argument actually exists.
>
> To bring a Compile Once - Run Everywhere (CO-RE) experience
> to parameters for programs, this series lets programs describe
> the parameters they need and any variants via a
> struct bpf_func_args___<flavor> which can contain
>
> - parameters in any order, to support cases where a user might
>   only use a subset of parameters in the associated program
> - parameters that may exist for some kernels, where use is
>   guarded by bpf_core_field_exists(ctx->field)
> - renamed parameters, allowing the old and new names both to
>   be present
> - parameters whose type varies across kernels: a pointer can be read
>   through the same struct either way, and bpf_core_type_matches() on
>   a flavor with just that parameter tells which type it is
> - __ret for the return value, for fexit, fmod_ret, fsession and
>   LSM programs
>
> For example, a program tracing a function foo() can declare just the
> parameters it needs, a, b and c, in any order, irrespective of their
> position in foo()'s signature. It can also declare a parameter "notsure"
> that only some kernels have, and check whether it exists, and both names
> of a parameter renamed from "old" to "new". Parameter "d" is a struct
> file * on some kernels and a void * on others: as any two pointers are
> compatible, it can be read through the same struct either way, and a
> flavor with just that parameter tells which it is. __ret is the return
> value.
>
>         struct bpf_func_args___foo {
>                 __u64 c;
>                 int b;
>                 char a;
>                 long notsure;
>                 int old;
>                 int new;
>                 void *d;
>                 int __ret;
>         } __attribute__((preserve_access_index));
>
>         struct bpf_func_args___foo_d_file {
>                 struct file *d;
>         } __attribute__((preserve_access_index));
>

to make this work reliably and not get screwed over by compiler
generating context access like this:

r2 =3D <offset> ; CO-RE relocated
r1 +=3D r2      ; verifier doesn't like this
r3 =3D *(u64 *)(r1 + 0); /* ctx access */

we need to make sure that we can use
__attribute__((preserve_static_offset)) together with
__attribute__((preserve_access_index))

This was pointed out in [0] (which, coincidentally perhaps, also
mentioned explicit bpf_func_args___xxx struct idea), we might not need
to block on that support given user defines this struct and bears
responsibility for this to work, but still, should be addressed
soon-ish in Clang/GCC.


And I'm actually wondering if the better name for this would be
"bpf_ctx___<flavor>" or "bpf_ctx_args___<flavor>", because it's not
always *function* arguments (tracepoint, BPF program, etc). Keeping it
more generic as "context arguments" or just "context" seems more
future-proof.


Also (I only skimmed patches, haven't gone through them completely,
will get back to this next week after holidays, sorry), I saw you
mentioned the limitation that this context access can be only done
from entry program code, right?  I think this can be lifted if we
apply these relocations after subprogs are appended to their
respective main programs. Not sure how ugly that will be, but you can
try that and see how it works (please do it as a separate patch to
distract less from the main logic change).

Overall I like it, thanks.


  [0] https://lore.kernel.org/bpf/CAEf4BzYNo54oz12C+s51KG5yWozDHGsQHYqdqHfq=
pSJ8=3DQPmyQ@mail.gmail.com/



>         SEC("fexit/foo")
>         int fexit_foo(struct bpf_func_args___foo *ctx)
>         {
>                 a =3D ctx->a;
>                 b =3D ctx->b;
>                 c =3D ctx->c;
>                 if (bpf_core_field_exists(ctx->notsure))
>                         notsure =3D ctx->notsure;
>                 if (bpf_core_field_exists(ctx->new))
>                         val =3D ctx->new;
>                 else
>                         val =3D ctx->old;
>                 if (bpf_core_type_matches(struct bpf_func_args___foo_d_fi=
le))
>                         file =3D (struct file *)ctx->d;
>                 ret =3D ctx->__ret;
>                 return 0;
>         }
>
> Other changes, e.g. a parameter of another integer width or a struct
> passed by value becoming a pointer, are covered in the libbpf overview.
> See also tools/testing/selftests/bpf/progs/func_args_core.c for more
> examples of usage.
>
> Patch 1 allows loads of the low-order bytes of context slots on
> big-endian, where arguments smaller than 8 bytes are at the end of their
> slot.
> Patch 2 adds the libbpf side.
> Patch 3 adds the kernel side.
> Patch 4 adds selftests.
> Patch 5 adds documentation for libbpf/llvm reloc.
>
> Changes since v1 [1]:
>
> - Reworked as suggested by Alexei: rather than matching struct members
>   against the attach target's parameters in relo_core.c, libbpf (and,
>   for light skeletons, the kernel) builds a struct describing the
>   program's context in a split BTF on top of the attach target's BTF,
>   with one member per parameter at its context offset, plus __ret. This
>   struct is the only CO-RE candidate, so relocations against it are
>   ordinary CO-RE, and relo_core.c is unchanged.
>
> - Structs are recognised by name, bpf_func_args___<flavor>, rather than
>   by a BTF decl tag. This works the same with clang and GCC, so
>   __bpf_func_args, __bpf_func_args_marker and __bpf_func_ret are gone.
>   The return value is the member __ret. The flavor is everything after
>   the first "___", so any flavor works.
>
> - Dropped BPF_PROG_CORE(): it couldn't express the variants that are
>   the main reason to relocate arguments (Alexei). Programs use the
>   struct directly instead.
>
> - Dropped bpf_func_args_supported() and the type-existence special
>   case: as the candidate is named after the program's struct,
>   type-based relocations, including bpf_core_type_exists() and
>   bpf_core_type_matches(), work as usual.
>
> - Pointer parameters follow the usual CO-RE rules, where any two
>   pointers are compatible, instead of a stricter pointer check.
>   bpf_core_type_matches() on a flavor containing just the parameter
>   tells which type it points to.
>
> - Big-endian: arguments smaller than 8 bytes are placed at the end of
>   their slot, and a new verifier patch (patch 1) allows loads of the
>   low-order bytes of context slots there, rather than widening loads
>   and poisoning signed ones. The s390x selftest restriction is gone.
>
> - libbpf: an attach target that can't be found no longer fails
>   bpf_object__prepare(); the struct just has no candidate, and the
>   program fails to load if it is loaded. Once the object is prepared,
>   bpf_program__set_type(), bpf_program__set_expected_attach_type() and
>   bpf_program__set_attach_target() fail with -EBUSY for programs whose
>   relocations depend on them (Andrey).
>
> - Selftests: test the libbpf and light skeleton paths, the LSM test
>   folded in, plus renamed and missing parameters, struct and type
>   variants, integer resizing, and the prepare-time behaviour above.
>
> - Docs: llvm_reloc.rst describes the relocation for loader
>   implementers; the libbpf overview covers common cases (a subset of
>   parameters in any order; parameters that are missing, renamed or of
>   another type on some kernels) and limitations.
>
> [1] https://lore.kernel.org/bpf/20261123223227.745345-1-almagui@kernel.or=
g/
>
> Alan Maguire (5):
>   bpf: Allow loads of the low-order bytes of context slots on big-endian
>   libbpf: Support CO-RE relocation of tracing program arguments
>   bpf: Support CO-RE relocation of tracing program arguments
>   selftests/bpf: Test CO-RE relocation of tracing program arguments
>   Documentation/bpf: Describe CO-RE relocation of function arguments
>
>  Documentation/bpf/libbpf/libbpf_overview.rst  | 123 +++++++
>  Documentation/bpf/llvm_reloc.rst              |  72 ++++
>  include/linux/bpf.h                           |   2 +
>  kernel/bpf/btf.c                              | 253 ++++++++++++-
>  kernel/bpf/check_btf.c                        |   1 +
>  tools/lib/bpf/libbpf.c                        | 333 ++++++++++++++++++
>  tools/lib/bpf/libbpf.h                        |  13 +-
>  tools/testing/selftests/bpf/Makefile.skel     |   2 +-
>  .../selftests/bpf/prog_tests/func_args_core.c | 129 +++++++
>  .../selftests/bpf/progs/func_args_core.c      | 178 ++++++++++
>  10 files changed, 1099 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/func_args_core=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/func_args_core.c
>
> --
> 2.56.0
>
