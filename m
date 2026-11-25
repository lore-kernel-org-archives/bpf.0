Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625932;
	b=j12zEEaAHgdZmIvwfENvoEKtL7dPqDfJ3DO8S2Y9VFcMaIyxqGK+XuwtQM6SUmV3SHbl
	 zN7+HJ+ND/u/7EjzHgC90G56O4WvMp4Dl+GpIjtnQ8x3tFIBpv6+juelPzfLqy3P0ReCB
	 PI97zaPATPJKPt5moCh3INheFrVZuu0Sn0q4QSNck95hNv8dl/ZKrzEEHat38iPrWvjk9
	 1obQgq2mndWSx/TFGpfQRXYe3T6+pAQmv7pdrOafLm79aeTFNsXCRtSh3xiFqwmQmx/45
	 5UCjjZGOi05eNDE5oC1JNe468LNhewnJ/bW/+Ub+rR68qv80XTgNYmrnvtXpwC+TUag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dmQUVqTp14X26ttepELvp2L8RxDZJ/+kNsjQvBQEJhs=;
	b=0C6GnLL6k3MqZxWXb2+HAAdljfMv2Aap4o6G0yPFs2BFg2G+UY/wk5HbuZivz30kGb/5
	 4OjrG9XbDLqSGs3E8mDOWVggBt+zXVbddlTnkdMB5c160UdWIzrta2GuUHVEcnLz6h4AZ
	 /4VROdExUp0kM3FG9AZ0f07BfCYKuEAPhYRkkPo49ODNKd0iG4z9hRQEFpWh0sJYIJ6eb
	 T8WjhX3KH3R3jXS2C2r3pSel1AhZietR6sVV1JdU7p0Dn7NeP8Sx9bkIBTXKm3MkFqqQe
	 365+QOEbdrT/te6dDIBMObX2Xvd29YYbC6cre/9r7/hwNIVyP3UonkVPGIcVKtVwzgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJHLbqRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E9606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJHLbqRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC171F000CA;
	Wed, 25 Nov 2026 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625931;
	bh=dmQUVqTp14X26ttepELvp2L8RxDZJ/+kNsjQvBQEJhs=;
	h=From:To:Cc:Subject:Date;
	b=eJHLbqRYHU1Yu3pNmTpBoV1+rW+4OGoLG6oBjHhKgfyZw+Z1RLdIN/wAhMdE3YE0O
	 9lyi/uCDCQPzg2QkEa4wZrmzwtMHZyKozzkfHSeLhT3L9zJcE4P4wl2KEXoy6uUIUr
	 K4J9vbDlXYXejSkP6knt54CVd1NxA7AwAxHcX5OcHfi4Kf3DmroihNXjGQ+gAheX8p
	 iXV8IqRw2TiZoQ/OBQBzmFIOf2oHBJOQU1gjMhvp47wr8Tjk3QJe6aKQmyWwPuLsNM
	 ns6dj1snJdah6fL8EhRj24b8sBfbdESykEkwcsXv+J75t23Am+bTfFLtgli4T8DlbR
	 KpdchGUb/iaMw==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: andrey.grodzovsky@crowdstrike.com,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	mason@kernel.org,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH v2 bpf-next 0/5] libbpf, bpf: Utilize CO-RE for BPF program parameter presence, ordering
Date: Wed, 25 Nov 2026 16:58:40 +0000
Message-ID: <20261125165845.45806-1-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the BPF_PROG() family of macros greatly facilitates
BPF tracing/LSM program writing by allowing specification
of function, tracepoint or LSM hook arguments directly by
name and type.  These are then mapped to a context struct
consisting of a u64 array, with one value for each argument,
with by-value structs larger than 8 bytes taking more than
one slot.

When an attach target gains, loses or reorders parameters
across kernels, programs silently read the wrong argument
or fail verification, and they have no way to check if an
argument actually exists.

To bring a Compile Once - Run Everywhere (CO-RE) experience
to parameters for programs, this series lets programs describe
the parameters they need and any variants via a
struct bpf_func_args___<flavor> which can contain

- parameters in any order, to support cases where a user might
  only use a subset of parameters in the associated program
- parameters that may exist for some kernels, where use is
  guarded by bpf_core_field_exists(ctx->field)
- renamed parameters, allowing the old and new names both to
  be present
- parameters whose type varies across kernels: a pointer can be read
  through the same struct either way, and bpf_core_type_matches() on
  a flavor with just that parameter tells which type it is
- __ret for the return value, for fexit, fmod_ret, fsession and
  LSM programs

For example, a program tracing a function foo() can declare just the
parameters it needs, a, b and c, in any order, irrespective of their
position in foo()'s signature. It can also declare a parameter "notsure"
that only some kernels have, and check whether it exists, and both names
of a parameter renamed from "old" to "new". Parameter "d" is a struct
file * on some kernels and a void * on others: as any two pointers are
compatible, it can be read through the same struct either way, and a
flavor with just that parameter tells which it is. __ret is the return
value.

        struct bpf_func_args___foo {
                __u64 c;
                int b;
                char a;
                long notsure;
                int old;
                int new;
                void *d;
                int __ret;
        } __attribute__((preserve_access_index));

        struct bpf_func_args___foo_d_file {
                struct file *d;
        } __attribute__((preserve_access_index));

        SEC("fexit/foo")
        int fexit_foo(struct bpf_func_args___foo *ctx)
        {
                a = ctx->a;
                b = ctx->b;
                c = ctx->c;
                if (bpf_core_field_exists(ctx->notsure))
                        notsure = ctx->notsure;
                if (bpf_core_field_exists(ctx->new))
                        val = ctx->new;
                else
                        val = ctx->old;
                if (bpf_core_type_matches(struct bpf_func_args___foo_d_file))
                        file = (struct file *)ctx->d;
                ret = ctx->__ret;
                return 0;
        }

Other changes, e.g. a parameter of another integer width or a struct
passed by value becoming a pointer, are covered in the libbpf overview.
See also tools/testing/selftests/bpf/progs/func_args_core.c for more
examples of usage.

Patch 1 allows loads of the low-order bytes of context slots on
big-endian, where arguments smaller than 8 bytes are at the end of their
slot.
Patch 2 adds the libbpf side.
Patch 3 adds the kernel side.
Patch 4 adds selftests.
Patch 5 adds documentation for libbpf/llvm reloc.

Changes since v1 [1]:

- Reworked as suggested by Alexei: rather than matching struct members
  against the attach target's parameters in relo_core.c, libbpf (and,
  for light skeletons, the kernel) builds a struct describing the
  program's context in a split BTF on top of the attach target's BTF,
  with one member per parameter at its context offset, plus __ret. This
  struct is the only CO-RE candidate, so relocations against it are
  ordinary CO-RE, and relo_core.c is unchanged.

- Structs are recognised by name, bpf_func_args___<flavor>, rather than
  by a BTF decl tag. This works the same with clang and GCC, so
  __bpf_func_args, __bpf_func_args_marker and __bpf_func_ret are gone.
  The return value is the member __ret. The flavor is everything after
  the first "___", so any flavor works.

- Dropped BPF_PROG_CORE(): it couldn't express the variants that are
  the main reason to relocate arguments (Alexei). Programs use the
  struct directly instead.

- Dropped bpf_func_args_supported() and the type-existence special
  case: as the candidate is named after the program's struct,
  type-based relocations, including bpf_core_type_exists() and
  bpf_core_type_matches(), work as usual.

- Pointer parameters follow the usual CO-RE rules, where any two
  pointers are compatible, instead of a stricter pointer check.
  bpf_core_type_matches() on a flavor containing just the parameter
  tells which type it points to.

- Big-endian: arguments smaller than 8 bytes are placed at the end of
  their slot, and a new verifier patch (patch 1) allows loads of the
  low-order bytes of context slots there, rather than widening loads
  and poisoning signed ones. The s390x selftest restriction is gone.

- libbpf: an attach target that can't be found no longer fails
  bpf_object__prepare(); the struct just has no candidate, and the
  program fails to load if it is loaded. Once the object is prepared,
  bpf_program__set_type(), bpf_program__set_expected_attach_type() and
  bpf_program__set_attach_target() fail with -EBUSY for programs whose
  relocations depend on them (Andrey).

- Selftests: test the libbpf and light skeleton paths, the LSM test
  folded in, plus renamed and missing parameters, struct and type
  variants, integer resizing, and the prepare-time behaviour above.

- Docs: llvm_reloc.rst describes the relocation for loader
  implementers; the libbpf overview covers common cases (a subset of
  parameters in any order; parameters that are missing, renamed or of
  another type on some kernels) and limitations.

[1] https://lore.kernel.org/bpf/20261123223227.745345-1-almagui@kernel.org/

Alan Maguire (5):
  bpf: Allow loads of the low-order bytes of context slots on big-endian
  libbpf: Support CO-RE relocation of tracing program arguments
  bpf: Support CO-RE relocation of tracing program arguments
  selftests/bpf: Test CO-RE relocation of tracing program arguments
  Documentation/bpf: Describe CO-RE relocation of function arguments

 Documentation/bpf/libbpf/libbpf_overview.rst  | 123 +++++++
 Documentation/bpf/llvm_reloc.rst              |  72 ++++
 include/linux/bpf.h                           |   2 +
 kernel/bpf/btf.c                              | 253 ++++++++++++-
 kernel/bpf/check_btf.c                        |   1 +
 tools/lib/bpf/libbpf.c                        | 333 ++++++++++++++++++
 tools/lib/bpf/libbpf.h                        |  13 +-
 tools/testing/selftests/bpf/Makefile.skel     |   2 +-
 .../selftests/bpf/prog_tests/func_args_core.c | 129 +++++++
 .../selftests/bpf/progs/func_args_core.c      | 178 ++++++++++
 10 files changed, 1099 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/func_args_core.c
 create mode 100644 tools/testing/selftests/bpf/progs/func_args_core.c

-- 
2.56.0

