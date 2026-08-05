Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FD480DF5
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971253; cv=none; b=RF+UAYFrv43n5+8I3/DI6VEv7XTTeIELbUJffR01fi00/PZxyuaPDKfLbYxsnuGud0Y1j44/+DgLCI65qU9T1Z7q28pjLZjCJ0spslVBOtGEsYnMVWISE+VAq8GFPto0E/9wghfNuxSmmYsrVrOovp2DHcVH9NYrwJQ74cx9GCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971253; c=relaxed/simple;
	bh=cjrlmbpbK55J6XhUdAA4/lu6vPo2YFPJkxlu5mPZcmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FulVlD/H3usB8HsaWd15VBfMFrsjMoetpj3AM7ShT6t55q3iT8LftM/29IT4DtfMo0JHMs3t6l0lBUcaRdT4cS6VaumPTDFIcL8ZsBrjlG+mHhWcdOkBjozKfhCrV9cY8xrlpzYTydQN4+u34fVYde5zqWd/81sYm6GxHa2M3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EBIahVa0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EBIahVa0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785971249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cvdhRbZRMPdMvUelus/fwFwpurapN4EV4fIyx9xqu8s=;
	b=EBIahVa07wpPMznBi6ckJVBqZD2YhqGHZRQoq+D1ArK5PwLtHJVhSSScaFgdkWg81hqaTe
	UhNZy2tVwi8Cj1rc24ebS+lYbDhT1JeLt6vU1xv+C6XpyVEbpCUQLryLreaNsA1HxlgXSY
	+aMHShGns6zjWfqf4axME3Rp9vizJHU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc BTF annotation emission
Date: Wed,  5 Aug 2026 16:06:48 -0700
Message-ID: <20260805230648.2354989-7-ihor.solodrai@linux.dev>
In-Reply-To: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

resolve_btfids now emits the bpf_kfunc and bpf_fastcall BTF decl tags and
the arena address_space(1) type attribute for kfuncs, which were
previously produced by pahole.

Reflect this in the in-tree comments and documentation.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst      |  8 ++++++++
 Documentation/process/changes.rst |  7 +++----
 scripts/Makefile.btf              |  3 +++
 tools/bpf/resolve_btfids/main.c   | 11 +++++++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index cbde86d082cc..c60fc574e8b0 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -472,6 +472,14 @@ type. An example is shown below::
         }
         late_initcall(init_subsystem);
 
+At kernel build time the ``resolve_btfids`` tool discovers all kfuncs from the
+registered ``BTF_SET8_KFUNCS`` sets and emits their BTF annotations into the
+kernel's BTF; these annotations were historically produced by pahole. For each
+discovered kfunc ``resolve_btfids`` emits a ``bpf_kfunc`` BTF decl tag, a
+``bpf_fastcall`` decl tag when the kfunc is flagged ``KF_FASTCALL``, and the
+``address_space(1)`` type attribute on the return value and/or arguments flagged
+``KF_ARENA_RET``, ``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.8).
+
 2.7  Specifying no-cast aliases with ___init
 --------------------------------------------
 
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 1ca8c5f73ad0..6d1dbe4abf0f 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -147,10 +147,9 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
 generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
 modules as well.  This requires pahole v1.22 or later.
 
-Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
-or later.  Without it, such kfuncs will have incorrect BTF prototypes in
-vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
-with vmlinux" error.  Many sched_ext kfuncs are affected.
+Kfunc BTF annotations (the bpf_kfunc and bpf_fastcall decl tags and the arena
+address_space(1) type attribute) are emitted in-tree by resolve_btfids from the
+BTF_KFUNCS sets, so they no longer depend on a specific pahole version.
 
 It is found in the 'dwarves' or 'pahole' distro packages or from
 https://fedorapeople.org/~acme/dwarves/.
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index a1812985a61a..717e76ce96a7 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -14,6 +14,9 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
 else
 
 # Switch to using --btf_features for v1.26 and later.
+#
+# kfunc BTF annotations (bpf_kfunc/bpf_fastcall decl tags and the arena
+# address_space(1) type attribute) are emitted by resolve_btfids, not pahole.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
 
 pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index ea25ca34aa00..66f4014e6aa1 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -58,6 +58,17 @@
  *             __BTF_ID__func__vfs_fallocate__5:
  *             .zero 4
  *	       .word (1 << 3) | (1 << 1) | (1 << 2)
+ *
+ * In addition to resolving BTF IDs, resolve_btfids performs kernel-specific
+ * BTF-to-BTF transformations for kfuncs found in BTF_SET8_KFUNCS sets. For
+ * each such kfunc it:
+ *
+ *   - emits a "bpf_kfunc" decl tag, and "bpf_fastcall" when KF_FASTCALL is set;
+ *   - wraps the return value and/or arguments flagged KF_ARENA_RET,
+ *     KF_ARENA_ARG1 or KF_ARENA_ARG2 with the "address_space(1)" type attribute;
+ *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
+ *
+ * These kfunc annotations were historically produced by pahole.
  */
 
 #define  _GNU_SOURCE
-- 
2.55.0

