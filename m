Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473180;
	b=OdDvcIEAyovl2gUFftG4qeaW4pjYIwpVxmebHVbag9SucLINPQDSR7UhpI3joy2ywGQQ
	 gNMNXM+QkhPn5tKsDqtXTOh5i+pePKEuDg/T0lNj8Yg6520Xam1yuc1F3DFXPV2pMUegn
	 abRCxG5ImzR5iLxuK+pIOQieJ4uQx0TF5gj20bYDf2xLieFkWqB9zebm/fEIXP6lfjAfr
	 YuR+5qQ6OqDrugiEclKKw9+Xp1U3RKyj95IMCgBaZgT/Xk6b652obke7bI7V0X3xlr/in
	 Xg1LJ909X27oWRQCMliXXP+iDLIT+dnHAOURIib20muGHz0PpRiwduaXTwAk2Ujzw6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473180;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cpIw2A6OFBNlmroDBWQD3yQ8kMJz/acrOm7Pz8kSVXY=;
	b=xshCcM+8BNsq5y7CU1Nw14PddzouUdprcWkEXMcqQBiOmLDg+LHjkSwPtzcbHuyfHvQ/
	 yWjZx615uq6r3OIizB0GIpmxch7J5u6pkzjFQMd3bKEyt9d3tXZqRxJL+hpBxJqJukKXW
	 Ih4yOGBPAUp3yOc7DNC4bJWrHzpFVzm5ccFvaEXYtuKqp/MijsQ/NpfzTWt3cPyOLbJ51
	 O/3Cg00J1UAzGxEaHRqKrwsHK7VCWW9zFA4vASdprr6tfQN0+CtgekugLHT6uaP3zQ7hW
	 81eC5tidFElIzhJpRlwNLnQOd7efqLEOvdfN8MqTL3xDeUqCjuSlaYYXZ5PoWtjlGJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+rYZ+Fq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92699606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+rYZ+Fq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014091F000C0;
	Mon, 23 Nov 2026 22:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473180;
	bh=cpIw2A6OFBNlmroDBWQD3yQ8kMJz/acrOm7Pz8kSVXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n+rYZ+FquzlQJVmCggndeoMkqXfmvjwYC30xKq3rCsETkJ5E68dosSAZ3XMjMJMvX
	 WJJO31M7ZuW+gxcxWq72SuOSwHZF8mwba4Rs5u39ID3os4qroUaahrdAJiSrXduIBK
	 aWFQfaIQeiHEVU/OnSf/ChiTEcCMwORbsdx3HbACCoL+oqI27jgMicPqKIrXQweOYo
	 MU6/fDwjXMmK8RvCs0q3Gu7KU74Hr1/bcLGj30HWsNhlChWrqm8z/diNqm9HVFPJ7f
	 CE24PyTiHvi7GfJXP6f5wpyz3liDQZReX1+Q/xO72L1rDBT/NrW4xpiGVpt8+wcRUJ
	 lzXYJOwVrxoBA==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next 7/7] Documentation/bpf: Describe CO-RE relocation of function arguments
Date: Mon, 23 Nov 2026 22:32:27 +0000
Message-ID: <20261123223227.745345-8-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123223227.745345-1-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
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

Document how BPF programs attached via BTF to kernel functions, LSM hooks
and tracepoints can access the arguments of their attach target in a
CO-RE-relocatable way:

- in the libbpf overview, for program authors: __bpf_func_args and
  __bpf_func_ret structs (and __bpf_func_args_marker, needed with GCC),
  BPF_PROG_CORE() and bpf_func_arg_exists(), how members are matched to
  parameters (by name, ignoring flavors), how parameter type changes are
  handled, including the stricter rules for pointers, the use of
  __probestub_*() or __traceiter_*() for tracepoints (and kernels
  before 5.10 having neither), the behaviour of light skeletons on
  older kernels, and the limitations, including that signed arguments
  smaller than 8 bytes generally can't be read on big-endian
  architectures; also how programs can use
  bpf_func_args_supported() to detect whether the arguments struct is
  relocated against the attach target, which it isn't with light
  skeletons on older kernels, with older libbpf versions than the
  headers the program was built with, with other loaders lacking that
  support, for GCC-built structs lacking __bpf_func_args_marker, or for
  tracepoints on kernels before 5.10;
- in the description of CO-RE relocations, for authors of other BPF
  loaders: the "bpf_func_args" (on the struct or one of its members) and
  "bpf_func_ret" decl tags, how relocations against such structs are to
  be resolved against the attach target's parameters and their context
  slots, and that BPF_CORE_TYPE_EXISTS relocations against them resolve
  to 1, which programs use to detect that support.

Signed-off-by: Alan Maguire <almagui@kernel.org>
Assisted-by: LLM
---
 Documentation/bpf/libbpf/libbpf_overview.rst | 190 +++++++++++++++++++
 Documentation/bpf/llvm_reloc.rst             |  95 ++++++++++
 2 files changed, 285 insertions(+)

diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation/bpf/libbpf/libbpf_overview.rst
index f4d22f0c62b0..cdc489cb27f2 100644
--- a/Documentation/bpf/libbpf/libbpf_overview.rst
+++ b/Documentation/bpf/libbpf/libbpf_overview.rst
@@ -198,6 +198,196 @@ about the field that should be relocated on the target kernel. i.e, if the
 ``struct task_struct`` due to some new field added in front of it, libbpf will
 automatically adjust the actual offset to the proper value.
 
+CO-RE for function arguments
+----------------------------
+
+BPF programs attached via BTF to kernel functions, LSM hooks and tracepoints
+(``fentry``, ``fexit``, ``fmod_ret``, ``fsession``, ``tp_btf``, ``lsm`` and
+``lsm_cgroup`` programs) receive the arguments of their attach target in their
+context, as an array of 64-bit slots. ``BPF_PROG()`` and ``BPF_PROG2()`` access
+these by position, so if parameters are added, removed or reordered in another
+kernel version, a program reads the wrong arguments.
+
+libbpf supports CO-RE relocation of these arguments instead. A struct marked
+with ``__bpf_func_args`` (from ``bpf_tracing.h``) describes the arguments a
+program needs, with members named after the target's parameters, in any order.
+The program takes a pointer to such a struct as its context:
+
+.. code-block:: C
+
+    struct unlinkat_args {
+            struct filename *name;
+            int dfd;
+            int ret __bpf_func_ret;
+    } __bpf_func_args;
+
+    SEC("fexit/filename_unlinkat")
+    int handle(struct unlinkat_args *args)
+    {
+            if (bpf_core_field_exists(args->dfd))
+                    bpf_printk("dfd %d", args->dfd);
+            bpf_printk("ret %d", args->ret);
+            return 0;
+    }
+
+When the program is loaded, each member is matched by name against the
+parameters of the attach target, and accesses to it are relocated to the context
+slot of that parameter. A member marked ``__bpf_func_ret`` refers to the return
+value, which exists for ``fexit``, ``fmod_ret``, ``fsession``, ``lsm`` and
+``lsm_cgroup`` programs.
+
+GCC doesn't support BTF decl tags on types, so with GCC such a struct also
+needs to contain ``__bpf_func_args_marker``, a zero-sized member that carries
+the tag instead. Structs with both work with either compiler:
+
+.. code-block:: C
+
+    struct unlinkat_args {
+            __bpf_func_args_marker;
+            struct filename *name;
+            int dfd;
+            int ret __bpf_func_ret;
+    } __bpf_func_args;
+
+``BPF_PROG_CORE()`` offers the same with a ``BPF_PROG2()``-like interface,
+declaring the struct from ``(type, name)`` pairs (using
+``__bpf_func_args_marker``, so that it works with both clang and GCC) and
+passing the arguments to the program body as variables:
+
+.. code-block:: C
+
+    SEC("fexit/filename_unlinkat")
+    int BPF_PROG_CORE(handle, struct filename *, name, int, dfd,
+                      __bpf_func_ret int, ret)
+    {
+            if (bpf_func_arg_exists(dfd))
+                    bpf_printk("dfd %d", dfd);
+            bpf_printk("ret %d", ret);
+            return 0;
+    }
+
+Arguments that don't exist in the target read as zero, and
+``bpf_func_arg_exists()`` tells whether an argument exists. Within the program
+body, ``ctx`` points to the arguments struct.
+
+Members are matched to parameters as follows:
+
+* Names are compared ignoring any suffix starting with three underscores (a
+  "flavor", as for CO-RE types), so that several members can describe a
+  parameter that is renamed or changes type across kernel versions.
+
+* Members without a matching parameter don't exist: ``bpf_core_field_exists()``
+  returns 0 for them and accesses that aren't guarded by such a check fail to
+  load. Parameters without a matching member are ignored.
+
+* Member and parameter types have to be compatible following the usual CO-RE
+  rules for struct fields. Members of a different kind than their parameter
+  (e.g., an integer for a pointer, or for an enum) don't match. Integers match
+  regardless of size and signedness: when an unsigned integer changes size the
+  load is adjusted accordingly, while size changes involving signed integers
+  make accesses fail to load. Structs passed by value match, with accesses to
+  their members relocated like those of any other struct.
+
+* Unlike struct fields, pointers only match if the types they point to (ignoring
+  typedefs and qualifiers) are compatible: structs, unions and enums need the
+  same kind and name (forward declarations match structs and unions), integers
+  the same size and other types the same kind, recursing through pointers to
+  pointers, while ``void *`` matches any pointer. A parameter changing from,
+  e.g., ``struct file *`` to ``struct inode *`` thus appears as missing rather
+  than having accesses through it relocated against the wrong type, and flavors
+  can describe both variants:
+
+  .. code-block:: C
+
+      struct my_args {
+              struct vm_area_struct *vma;
+              struct mm_area *vma___new;
+      } __bpf_func_args;
+
+For ``tp_btf`` programs, as the ``btf_trace_<tracepoint>`` type has no parameter
+names, these are taken from the tracepoint's ``__probestub_<tracepoint>()``
+function (Linux 6.5 and later) or ``__traceiter_<tracepoint>()`` function
+(Linux 5.10 and later). On older kernels, there are no parameter names to
+match, so the program loads but all arguments appear to be missing, and
+``bpf_func_args_supported()`` (see below) returns 0.
+
+Light skeletons rely on the kernel to apply CO-RE relocations. Kernels that
+don't support function argument relocations find no match for any member, so
+all arguments appear to be missing.
+
+Function argument relocations are applied by whatever loads the program,
+which needn't match the ``bpf_tracing.h`` it was built with. When it is the
+libbpf version whose headers the program was built with (e.g., a vendored or
+statically linked libbpf), they are supported, except for ``tp_btf`` programs
+on kernels before Linux 5.10 (see above). Otherwise, all arguments appear to be
+missing (and read as zero in ``BPF_PROG_CORE()`` programs) with:
+
+* light skeletons on kernels that don't support function argument
+  relocations;
+* an older libbpf than the headers the program was built with, e.g., a shared
+  libbpf provided by the distribution;
+* loaders other than libbpf that apply CO-RE relocations themselves but don't
+  support function argument relocations.
+
+The same happens for explicitly declared structs built with GCC without
+``__bpf_func_args_marker`` (``BPF_PROG_CORE()`` always adds it). Programs can
+detect whether the arguments struct is relocated against the attach target with
+``bpf_func_args_supported()`` (``bpf_func_args_supported(ctx)`` in
+``BPF_PROG_CORE()`` programs; it uses ``bpf_core_type_exists()`` from
+``bpf_core_read.h``), and report or handle a lack of support:
+
+.. code-block:: C
+
+    SEC("fexit/filename_unlinkat")
+    int handle(struct unlinkat_args *args)
+    {
+            if (!bpf_func_args_supported(args)) {
+                    unsupported = true;
+                    return 0;
+            }
+            ...
+    }
+
+This tells whether the struct is relocated against the attach target at all,
+not which of its members exist. Without that support, a kernel type with the
+same name as the struct would be looked up instead, so arguments structs
+shouldn't be named like kernel types.
+
+Limitations:
+
+* Structs passed by value that are larger than 8 bytes can't be copied out of
+  the context as a whole, so they can't be ``BPF_PROG_CORE()`` arguments; use a
+  ``__bpf_func_args`` struct and access their members instead.
+
+* Compilers may access members of structs passed by value by adding a
+  (relocated) offset to the context pointer, rather than relocating the load
+  itself. The verifier only accepts such accesses since Linux 7.1.
+
+* When libbpf applies the relocations, accesses have to be made from the
+  program itself (or from inlined functions) rather than from subprograms, which
+  may be shared by programs with different attach targets.
+
+* Multi-attach programs and programs attached to other BPF programs (e.g.
+  ``freplace``) are not supported.
+
+* The verifier only allows context accesses at offsets that are a multiple of
+  8 bytes. Members of structs passed by value can thus only be accessed if their
+  offset within the struct is a multiple of 8 bytes.
+
+* On big-endian architectures, arguments smaller than 8 bytes are in the
+  low-order bytes of their slot. Loads of integer and enum arguments are widened
+  to the whole slot instead, relying on the calling convention extending them to
+  64 bits, but only zero-extending loads of unsigned arguments and
+  sign-extending loads (``-mcpu=v4``) of signed ones can be widened this way.
+  Other loads, e.g., zero-extending loads of signed integers, and accesses to
+  structs and unions passed by value fail to load; ``BPF_PROG()`` and
+  ``BPF_PROG2()`` can access such arguments. In practice, signed arguments and
+  return values smaller than 8 bytes, such as ``int``, can generally not be
+  read on big-endian architectures: compilers only use sign-extending loads
+  when the value is converted to a wider type, and ``BPF_PROG_CORE()`` always
+  loads arguments into variables of their own type, so it can't be used with
+  such arguments there at all.
+
 Getting Started with libbpf
 ===========================
 
diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
index 44188e219d32..147cca6e45be 100644
--- a/Documentation/bpf/llvm_reloc.rst
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -544,3 +544,98 @@ Enum-based relocations:
             108:  CO-RE <enumval_value> [16] enum bar::V = 1
     35:     *(u64 *)(r2 + 0x0) = r1
     36:     exit
+
+CO-RE Relocations of Function Arguments
+=======================================
+
+Programs attached via BTF to kernel functions and tracepoints
+(``BPF_PROG_TYPE_TRACING`` and ``BPF_PROG_TYPE_LSM`` programs with expected
+attach types ``BPF_TRACE_FENTRY``, ``BPF_TRACE_FEXIT``, ``BPF_TRACE_FSESSION``,
+``BPF_MODIFY_RETURN``, ``BPF_TRACE_RAW_TP``, ``BPF_LSM_MAC`` and
+``BPF_LSM_CGROUP``) can access their context through a struct describing the
+arguments of their attach target, with members named after its parameters.
+Such a struct is marked with a ``btf_decl_tag("bpf_func_args")`` BTF decl tag,
+either on the struct itself (``component_idx`` -1) or, as compilers such as GCC
+don't support decl tags on types, on one of its members (typically a
+zero-sized ``char ___bpf_func_args[0]`` member, which never matches a
+parameter). It is otherwise an ordinary struct accessed with
+``preserve_access_index``, so the compiler emits the usual field-based CO-RE
+relocations on the context loads:
+
+.. code-block:: c
+
+  struct args {
+    int b;
+    char a;
+    int ret __attribute__((btf_decl_tag("bpf_func_ret")));
+  } __attribute__((preserve_access_index, btf_decl_tag("bpf_func_args")));
+
+  /* int bpf_fentry_test3(char a, int b, u64 c) */
+  __attribute__((section("fexit/bpf_fentry_test3")))
+  int prog(struct args *args) {
+    return args->a + args->b + args->ret;
+  }
+
+The relocation's root type may refer to such a struct through typedefs and
+modifiers (e.g., clang uses the typedef as the root type of relocations against
+a typedef'd anonymous struct), so loaders skip these before looking for the
+tag. Rather than with same-named types, loaders resolve relocations against
+such a struct with the single candidate given by the program's attach target:
+
+* For ``BPF_TRACE_RAW_TP`` programs, whose attach target is the
+  ``btf_trace_<tracepoint>`` typedef, the parameters are those of the
+  ``__probestub_<tracepoint>`` function or, if there is none (before Linux
+  6.5), of the ``__traceiter_<tracepoint>`` function, ignoring the first
+  (``void *__data``) one. If neither exists (before Linux 5.10), there is no
+  candidate, so no member matches.
+
+* For other programs, the parameters are those of the attach target function.
+
+* The first accessor of the relocation's access string has to be ``0``, and the
+  second one, a member of the struct, is matched by name against the
+  parameters, ignoring the ``___`` flavor suffix of the member's name. The
+  matching parameter is at the byte offset of its slot in the context, which
+  is an array of 8-byte slots, one per parameter, except for parameters larger
+  than 8 bytes passed by value (structs, unions or integers), which take as many
+  slots as their size rounded up to 8 bytes requires. A pointer always takes a
+  single slot. A parameter smaller than 8 bytes, including a struct or union
+  passed by value, is in the low-order bytes of its slot.
+
+* A member tagged with ``btf_decl_tag("bpf_func_ret")`` (``component_idx`` being
+  the member's index) refers to the return value, in the slot following those
+  of the parameters, but only for ``BPF_TRACE_FEXIT``, ``BPF_TRACE_FSESSION``,
+  ``BPF_MODIFY_RETURN``, ``BPF_LSM_MAC`` and ``BPF_LSM_CGROUP`` programs, and
+  for functions that don't return ``void``.
+
+* The member's and parameter's types have to be compatible as for struct
+  fields, except that pointers are only compatible if the types they point to,
+  after skipping typedefs and modifiers, are: structs, unions and enums need the
+  same kind and essential name (forward declarations being compatible with
+  structs and unions, and enums with 64-bit enums), integers the same size, and
+  other types the same kind, recursing through pointers to pointers, with
+  ``void *`` on either side compatible with any pointer.
+
+* Further accessors (members of structs passed by value) are resolved as for
+  any other struct.
+
+* On big-endian targets, as the verifier only allows 8-byte aligned context
+  accesses, a ``byte_off`` relocation of an integer or enum parameter (or return
+  value) smaller than 8 bytes that is applied to a load is resolved to the
+  start of its slot, with the load turned into an 8-byte ``BPF_MEM`` load. This
+  relies on the calling convention extending such values to 64 bits, so it is
+  only done for zero-extending (``BPF_MEM``) loads of unsigned and
+  sign-extending (``BPF_MEMSX``) loads of signed values of the parameter's size;
+  other such loads are poisoned.
+
+Members that have no match don't exist, as for missing struct fields. A
+``BPF_CORE_TYPE_EXISTS`` relocation against such a struct resolves to 1 if
+there is a candidate, so that programs can detect that the struct is relocated
+against the attach target, and to 0 otherwise (for ``BPF_TRACE_RAW_TP``
+programs without a ``__probestub_<tracepoint>`` or
+``__traceiter_<tracepoint>`` function). Other type-based relocations against
+it are not supported. In the example above, the ``byte_off`` relocations for
+``a``, ``b`` and ``ret`` are resolved to 0, 8 and 24 respectively.
+
+Both libbpf and the kernel (for relocations passed to ``BPF_PROG_LOAD``, as
+used by light skeletons) resolve these relocations, using the attach target
+passed to ``BPF_PROG_LOAD`` in the kernel's case.
-- 
2.56.0

