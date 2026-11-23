Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473172;
	b=1qGqBRRg0FgTDhBMaASL7G+jjcst3CXEV0JVhrZvfVhFNlr9SpJTp4koHuB12lAJ1br7
	 xL8vpqREyaZthG59JgkklBi+T2i2X/wTLt0npc9h+cxdSRU910t86eXi1Tl5lqA4XxOws
	 efGL7f3BLXmaL0hCGYnufYSk2SoSG31SorRTxXwfpBp8LJ11O7P7oyxnv7f4hNkbOVQVx
	 zR0zibVluTUIj0Rr0YdDSHYc4UqqEDgFxn57kXNzJnppmwLudMJXLiVd2R6SV1O2j6Zsy
	 28y3jZ7cfY+Dz/cWk+F5dYUIk3qWwSvZbYisC/dUNZhhtgz02MjtKAvDJgIRyQ3NqXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+LJzIzaihaUWMo7KZAjjgcmeQI3T0a6B6zd2AU66n2Q=;
	b=C7OxNIU6WbyGRTGL2cIy6HHam5dwFuAdc3sGYLiptULop38PEOXg0IhTJndYuEas7YTE
	 5XkHjPdQcwLEmvRwWN0NeeEif7dfiPckbKuUf9Rv3SPRLKrlnZJ+h50nAbs+TrVy4cAIo
	 5fxqhZ8ompkwr2HaJ5XXzQPK25vwmYZyFt6/AXT77tTstVcBOobyIAm6Pok/+aB9AVZm5
	 i6YBtzVTmUo9CG7NjVQz4u5DeH3NvF0m7sfF5g4yFRL91qch6m4X7dWrktR7damXG5Bt3
	 sd0hMoph3xJFg4XqlR7tAoOJsXgfqPHlKrTsVUPmldEkIqXZi+MkSkBVPgRz1aLSwOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlLWcGlL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C54606A322
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlLWcGlL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A40C1F000C0;
	Mon, 23 Nov 2026 22:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473172;
	bh=+LJzIzaihaUWMo7KZAjjgcmeQI3T0a6B6zd2AU66n2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DlLWcGlLnfRGn3XRjlb2hjUFEcIXUhQZXORIL8WVIStJGnU410A4ZAsgmLNNW+Brd
	 wOmersy2B1QmpJm8QoiNl2FdoMNklUYk1ZRI7XStDT+YPpmpmqRds2PaOBtT3H4OCc
	 scvsJrTM3iUxViDNJr8mKDx4pA/rrRh1T1ilPePVzGXvKVrUaoIFNzPVzUxiTIwToJ
	 pV9OpHRqOdk/6CshiVokEp0ciVdT5sOMypSzWPYIVF9lLPCurGFjmjNC6sfMW6VB0j
	 fKtsBZe5JP04azu7zg9wdC2Cpnpdgn6zPbQOHcres+nqpz1WrFz+U9HgIjGULau7oH
	 waJ8842BcSecA==
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
Subject: [PATCH bpf-next 5/7] libbpf: Report function argument relocation support via type existence
Date: Mon, 23 Nov 2026 22:32:25 +0000
Message-ID: <20261123223227.745345-6-almagui@kernel.org>
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

Function argument structs (see __bpf_func_args) are relocated against the
attach target by whatever applies the program's CO-RE relocations at load
time, which needn't match the bpf_tracing.h the program was built with.
A loader without support for function argument relocations treats such a
struct as an ordinary local type, for which a same-named kernel type is
looked up, so all of its members appear to be missing. As BPF_PROG_CORE()
guards each argument read with a field existence check, such programs
still load, but all arguments silently read as zero, which can't be told
apart from the arguments not existing in the attach target.

When the program is loaded by the libbpf version whose headers it was built
with (e.g., a vendored or statically linked libbpf), support is a given.
It isn't with:

- light skeletons, as the kernel applies the relocations, so support
  depends on the running kernel;
- objects built against newer headers than the libbpf loading them, e.g.,
  an older shared libbpf provided by the distribution;
- loaders other than libbpf that implement CO-RE relocations themselves.

Additionally, explicitly declared structs lose their "bpf_func_args" BTF
decl tag when built with GCC without __bpf_func_args_marker (which
BPF_PROG_CORE() always adds), so they are treated as ordinary local types
as well. And for tp_btf programs on kernels before 5.10, whose BTF has no
parameter names for tracepoints, there is no candidate to match against.

Allow programs to detect this, by having BPF_CORE_TYPE_EXISTS relocations
against function argument structs resolve to 1 when they are matched
against the attach target (otherwise, the lookup by name finds nothing,
resolving to 0), and add bpf_func_args_supported() to bpf_tracing.h to
check it, using bpf_core_type_exists(), which handles the differences
between clang's and GCC's __builtin_preserve_type_info(). It tells
whether the struct is relocated against the attach target, not which of
its members exist. Other type-based relocations against such structs
remain unsupported.

As relo_core.c is shared with the kernel, this also applies to light
skeletons on kernels with this change, while on kernels without support
for function argument relocations, bpf_func_args_supported() resolves to
0, as intended.

Assisted-by: LLM
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 19 +++++++++++++++++++
 tools/lib/bpf/relo_core.c   | 11 +++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 24182b48fa4d..f08164ce4f3c 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -721,6 +721,25 @@ struct pt_regs;
 #else
 #define __bpf_func_args __attribute__((preserve_access_index))
 #endif
+/*
+ * bpf_func_args_supported() tells whether the __bpf_func_args struct that
+ * args points to is relocated against the parameters of the program's attach
+ * target. That is done by whatever applies the program's CO-RE relocations,
+ * which needn't match this header. With the libbpf version providing this
+ * header, it is 1, except for tp_btf programs on kernels before Linux 5.10,
+ * whose BTF has no parameter names for tracepoints. It is also 0 for light
+ * skeletons on kernels without that support, with older libbpf versions
+ * (e.g., a distribution's shared libbpf), with other loaders lacking that
+ * support, and if the struct lost its BTF decl tag (e.g., when built with GCC
+ * without __bpf_func_args_marker). Whenever it is 0, all members appear to be
+ * missing (BPF_PROG_CORE() arguments read as zero). It doesn't tell which
+ * members exist. Note that loaders without that support look for a same-named
+ * kernel type instead, so the struct's name shouldn't be that of a kernel
+ * type. Within BPF_PROG_CORE() programs, use bpf_func_args_supported(ctx).
+ * Requires bpf_core_read.h.
+ */
+#define bpf_func_args_supported(args)	bpf_core_type_exists(typeof(*(args)))
+
 #define __bpf_func_args_marker \
 	char ___bpf_func_args[0] __attribute__((btf_decl_tag("bpf_func_args")))
 #define __bpf_func_ret __attribute__((btf_decl_tag("bpf_func_ret")))
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2f6627952220..ed566a55cb06 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -907,8 +907,15 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
 	targ_spec->relo_kind = local_spec->relo_kind;
 
 	if (func_args) {
-		/* only field accesses (args->x...) of the arguments struct
-		 * have a meaning for function argument candidates
+		/* the existence of an arguments struct indicates that it is
+		 * matched against the attach target, as only libbpf and
+		 * kernel versions supporting that find a candidate for it,
+		 * allowing programs to detect that support
+		 */
+		if (local_spec->relo_kind == BPF_CORE_TYPE_EXISTS)
+			return 1;
+		/* otherwise, only field accesses (args->x...) have a meaning
+		 * for function argument candidates
 		 */
 		if (!core_relo_is_field_based(local_spec->relo_kind) ||
 		    local_spec->len < 2 || local_spec->spec[0].idx != 0)
-- 
2.56.0

