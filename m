Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625954;
	b=kSc7MgpOOwkzY2Ky8JqUBHVagNYH3NEx5qHpUZ0CtSu9cTEltZRo5IhjWpUjuudfBIKE
	 dnPDQvZs4nLxo9Q3iGRO5EvOp+RzPBW+EYX+qA2wFt3i8BAVbAAVtLqAx2pZCCI8Hg6dR
	 QgqP+TvtXKX5M7MYN6GfwAAR56nn7g2vS85ItaUGg0w7oOWEnOqkzVBkXu8F0xb30KhpH
	 T6TtlG5nLwa4zK6smW7Q/UjufRx/gQ1eKKHMcSxj0ik7QlwWH8AlWqbilxvpobZVdB36q
	 F9i12g6Ktu92py3Lq6Ea+1TKH9Me9D0b9qx/CmJKo9Uqj14rmjM8bxCAx7VTIdMwASw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625954;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7m49xkTgVN4SWsyt6hc8jJ21yjlxoqM5zzdUihxZlqQ=;
	b=uEWOrn5RglJSVG0/xXWOx/OATfdEQCzIw/kwpC4QZHcU7WP7zOj/O+XBe8l518dWSJ+a
	 /SbqIz4poBN1VC3XN/hrsWg5JnnY8AHw4U1wV/fotDNnRdS+bF5agYEskJNlDm0Z2LJ5L
	 5wttY2jZhH5Wff3tO4ZEyQ4nFSwnKhchIMy3zbVkhrUqPEIMwZE+qoDHiuNQXqsxNTIl4
	 Mc9wHGdmxhgCTeZa0b3mo6+kUPzv16VNLpWLxJSF65ivA9lc6W3HiqDnCbTFY+VlMOK9I
	 qQu1Xk3683p2NH3CcednhGLetRsAZEJV1F0LLYQJyE5XGVXC7DXWj9BkZIF0hfB/jKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dnSLJd2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BF606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnSLJd2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEE41F000D4;
	Wed, 25 Nov 2026 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625954;
	bh=7m49xkTgVN4SWsyt6hc8jJ21yjlxoqM5zzdUihxZlqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dnSLJd2/RhKFB9NSiJu/Y9TZWQF+Symm2nWhq4emHe/9iLa5dHHeVQOu3xf5wgteu
	 WV/RcgkFylaTE/CfPX51fARHPJ+rXEHUTTTEcUxXrK0XDAl5nk7aJ96yHU88WtSEru
	 r/XlyRM0KFu40+qvkMIrVCH9boPlzD83B47SMtXeGefLY71OBKEKT+s5UDNOPHJO6n
	 bL3CB6M7+HQ/Mie2SchKF3p/iUBJecFyze0Sqd90IhH0gk2mnzl881rgrLu0WZAQC/
	 Ck/l6+PCzQUV7qY7Au8plwfNqt3EFR1OojOOhxwnh5HZDZUp/HnCIg5UoePpO2vBTx
	 neqQUC8qcB2gg==
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
Subject: [PATCH v2 bpf-next 5/5] Documentation/bpf: Describe CO-RE relocation of function arguments
Date: Wed, 25 Nov 2026 16:58:45 +0000
Message-ID: <20261125165845.45806-6-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125165845.45806-1-almagui@kernel.org>
References: <20261125165845.45806-1-almagui@kernel.org>
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

Describe struct bpf_func_args___<flavor> in the libbpf overview: how
programs use it to access the arguments and return value of their attach
target, how to handle common cases, i.e. using only some parameters in
any order, and parameters that are missing, renamed or of another type
on some kernels, and its limitations.

In llvm_reloc.rst, describe for loader implementers how relocations
against such a struct are resolved: which names are recognised, typedef
handling, the candidate named after the program's struct, its layout in
the context, __ret, where tp_btf parameter names come from, and
big-endian placement.

Assisted-by: LLM
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 Documentation/bpf/libbpf/libbpf_overview.rst | 123 +++++++++++++++++++
 Documentation/bpf/llvm_reloc.rst             |  72 +++++++++++
 2 files changed, 195 insertions(+)

diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation/bpf/libbpf/libbpf_overview.rst
index f4d22f0c62b0..08b633edc9bc 100644
--- a/Documentation/bpf/libbpf/libbpf_overview.rst
+++ b/Documentation/bpf/libbpf/libbpf_overview.rst
@@ -198,6 +198,129 @@ about the field that should be relocated on the target kernel. i.e, if the
 ``struct task_struct`` due to some new field added in front of it, libbpf will
 automatically adjust the actual offset to the proper value.
 
+CO-RE for Function Arguments
+----------------------------
+
+The context of tp_btf, fentry, fexit, fmod_ret, fsession and LSM programs is
+an array of u64 slots holding the arguments of the attach target, followed by
+its return value where the program can see it. ``BPF_PROG()`` accesses them by
+position, so when a traced function or tracepoint gains, loses or reorders
+parameters, programs silently read the wrong argument.
+
+Instead, a program can describe the arguments it needs as a struct named
+``bpf_func_args___<flavor>``, with members named after the parameters of the
+attach target, in any order, and ``__ret`` for the return value:
+
+.. code-block:: C
+
+    struct bpf_func_args___unlink {
+            struct filename *name;
+            int dfd;
+            int __ret;
+    } __attribute__((preserve_access_index));
+
+    SEC("fexit/filename_unlinkat")
+    int handle(struct bpf_func_args___unlink *ctx)
+    {
+            if (bpf_core_field_exists(ctx->dfd))
+                    bpf_printk("dfd %d", ctx->dfd);
+            bpf_printk("%s %d", ctx->name->name, ctx->__ret);
+            return 0;
+    }
+
+libbpf relocates accesses to such a struct against a struct of the same name
+describing the context of the program, with one member per parameter of its
+attach target, followed by ``__ret`` for fexit, fmod_ret, fsession and LSM
+programs. For tp_btf programs, the parameters are those of the tracepoint,
+without its ``void *__data``. Otherwise, these are ordinary CO-RE relocations,
+and the usual CO-RE helpers apply. The struct can be accessed through a
+typedef, and an anonymous struct takes its name from its typedef, but
+type-based relocations such as ``bpf_core_type_exists()`` need a named struct.
+
+Common cases:
+
+- *Only some parameters are needed, regardless of their order.* Declare
+  just those, in any order: each member is relocated to wherever its
+  parameter is, so parameters added, removed or reordered elsewhere in the
+  signature don't matter.
+
+- *A parameter may not exist on every kernel.* ``bpf_core_field_exists()``
+  tells whether it does. Unguarded accesses to a missing parameter fail to
+  load. Likewise, ``__ret`` only exists where the program sees the return
+  value.
+
+- *A parameter is renamed across kernels.* Declare both names in the same
+  struct, and read whichever exists:
+
+  .. code-block:: C
+
+    if (bpf_core_field_exists(ctx->new_name))
+            val = ctx->new_name;
+    else
+            val = ctx->old_name;
+
+- *A parameter's type varies across kernels.* Declare it once, with the
+  same name, and:
+
+  - for an unsigned integer whose width varies, declare it at the widest
+    width and read it as usual: the load is resized to the parameter, and
+    zero-extended;
+  - for a signed integer whose width varies, declare it at the widest width
+    and read it with ``BPF_CORE_READ_BITFIELD(ctx, name)``, which loads it
+    at its size on the running kernel and sign-extends it. A plain access
+    with another size is poisoned, as for other CO-RE relocations;
+  - for a pointer to a type that varies, read it as usual, as any two
+    pointers are compatible, and tell which type it points to with
+    ``bpf_core_type_matches()`` on another flavor of the struct, with just
+    that parameter:
+
+    .. code-block:: C
+
+      struct bpf_func_args___new {
+              struct mm_area *vma;
+      } __attribute__((preserve_access_index));
+
+      if (bpf_core_type_matches(struct bpf_func_args___new))
+              mm = (struct mm_area *)ctx->vma;
+      else
+              vma = (struct vm_area_struct *)ctx->vma;
+
+    ``bpf_core_type_matches()`` also compares the names of integer types,
+    which may differ between the compiler and kernel BTF (e.g., ``long`` and
+    ``long int``), so such flavors should only describe the parameters that
+    differ;
+  - for other changes, e.g. a struct passed by value becoming a pointer,
+    the parameter isn't compatible with one of the declarations, so it
+    appears to be missing from it: declare a flavor of the struct for each
+    variant, and read through the one where ``bpf_core_field_exists()``
+    finds it.
+
+Limitations:
+
+- with libbpf applying the relocations, accesses need to be made from the
+  entry program (or inlined code), as a shared subprogram has no single
+  attach target;
+- the attach target needs to be in kernel BTF: programs attached to BPF
+  programs and multi-attach programs are not supported;
+- with libbpf applying the relocations, the type, attach type and attach
+  target of the program can't be changed once the object is prepared, as
+  the relocations depend on them;
+- ``bpf_core_type_id_kernel()`` can't be used on such a struct, as it only
+  exists in libbpf;
+- tracepoints only have parameter names in kernel BTF from Linux 5.10, so on
+  older kernels all arguments of tp_btf programs appear to be missing;
+- clang can turn loads of members of the same size in alternative branches,
+  e.g. for a renamed parameter, into one load from the context plus an
+  offset set in each branch, and ``BPF_CORE_READ_BITFIELD()`` loads from
+  the context plus an offset too. The verifier only allows such loads from
+  Linux 7.1, so these programs can fail to load on older kernels;
+- on big-endian targets, arguments smaller than 8 bytes are at the end of
+  their slot, where older kernels don't allow context loads, so programs
+  reading them fail to load there;
+- light skeletons need the kernel to support these relocations. Older
+  kernels and older libbpf versions find no candidate, so all arguments
+  appear to be missing.
+
 Getting Started with libbpf
 ===========================
 
diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
index 44188e219d32..0da06e29385f 100644
--- a/Documentation/bpf/llvm_reloc.rst
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -544,3 +544,75 @@ Enum-based relocations:
             108:  CO-RE <enumval_value> [16] enum bar::V = 1
     35:     *(u64 *)(r2 + 0x0) = r1
     36:     exit
+
+Relocations Against Function Arguments
+======================================
+
+The context of tp_btf, fentry, fexit, fmod_ret, fsession and LSM programs
+is an array of u64 slots, holding the arguments of the attach target and,
+where the program can see it, its return value. Programs can describe it
+with a struct named ``bpf_func_args___<flavor>`` accessed with
+``preserve_access_index``, with members named after the parameters of the
+attach target and ``__ret`` for the return value. The compiler emits
+ordinary CO-RE relocations for these accesses, e.g.:
+
+.. code-block:: c
+
+  struct bpf_func_args___test3 {
+    unsigned long long c;
+    char a;
+  } __attribute__((preserve_access_index));
+
+  SEC("fentry/bpf_fentry_test3")
+  int prog(struct bpf_func_args___test3 *ctx)
+  {
+    return ctx->a;
+  }
+
+  0000000000000000 <prog>:
+       0:       w0 = *(u8 *)(r1 + 0x8)
+                0000000000000000:  CO-RE <byte_off> [2] struct bpf_func_args___test3::a (0:1)
+       1:       w0 <<= 0x18
+       2:       w0 s>>= 0x18
+       3:       exit
+
+Loaders resolve relocations whose root type is a struct named
+``bpf_func_args``, or ``bpf_func_args___`` followed by any flavor, against a
+single candidate, which they construct from the program's attach target
+rather than look up in kernel BTF. Unlike for other types, the flavor is
+everything after the first triple underscore, so it can start with or contain
+underscores, e.g., when it is generated from the name of a program. The
+compiler uses a typedef as the root type when the struct is accessed through
+one, so loaders skip typedefs and modifiers to find the struct, and take the
+name of an anonymous struct from its typedef. They then relocate against
+the struct itself, unless it is anonymous, and give the candidate the same
+name, so that type-based relocations match it whatever its flavor is:
+
+.. code-block:: c
+
+  struct bpf_func_args___<flavor> {
+    <type of the parameter> <name of the parameter>;
+    ...
+    <return type> __ret;
+  };
+
+- Its members are the parameters of the attach target, with their names and
+  types, at their offsets in the context, as laid out by the kernel's
+  ``btf_ctx_arg_idx()``: each takes up a whole number of 8-byte slots (e.g.,
+  structs larger than 8 bytes passed by value take up two). On big-endian
+  targets, members smaller than 8 bytes are at the end of their slot.
+- ``__ret`` follows the parameters for fexit, fmod_ret, fsession and LSM
+  programs, unless the attach target returns void.
+- For tp_btf programs, the attach target is a ``btf_trace_<name>`` typedef
+  without parameter names, so the parameters are taken from the
+  identically-typed ``__probestub_<name>()`` function (or, on kernels
+  before Linux 6.5, ``__traceiter_<name>()``), without their first
+  ``void *__data`` parameter. If neither exists, libbpf finds no
+  candidate, while the kernel, which only looks for
+  ``__probestub_<name>()``, fails the relocation.
+
+The struct is constructed in BTF split from the BTF of the attach target,
+so that members refer to the target's types, and relocations against it are
+then resolved as usual. ``target_type_id`` relocations against it fail, as
+it doesn't exist in the kernel. libbpf and the kernel, for light skeletons,
+implement this.
-- 
2.56.0

