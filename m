Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D513859FD
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072869; cv=none; b=N/cgdJb9rSnPqxCQ3eHGdtVtHYjOmjB7/VfMAZFqgpcGmHssiyJsACRA+/T6ITSp3tZl6vaqTplZ1JhZEn0+/4eueVdHLEZbVmcmfWDGJL1i3zSmokZrN8Pevp/irbMZhVUZIRBqK/8/3i6vDP+lmVGjtYaVvlGv+OsFRu37y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072869; c=relaxed/simple;
	bh=HoSpnrpyvWGNn+KSIUKohATWBxOzOifzy0qnyc17aCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gD4Yl4lTFGLMK14+oodzl36N1TrNURP4C3QeUoQLr+V2CC3bD9W8ohxhtIVWGN+OvYiTDxcLVTgprISpX2nta3c/glaCiD7uvyTAhQkh5zbTbRpY5z6R8xWmPnHcMxGfVPix941OH4rqwbKcsbON8YiXK7sUAoIfhHHoOwlUpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gI26PUnK; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gI26PUnK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786072865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5/tWgHgFEgpSzz2ajUpvgEIm5hebjmAwNu/APD2gfk=;
	b=gI26PUnKvflOyDb5sR0LyeVG4mciL9u4a0MHLWb8xfB/aq3iPiWiz70rGFfUhw9A25y2A6
	t7tRjPs/579btueJfV8cPbOxQWWIIdbzx+eK87LLoZUKJewT88SalbfjetQTMyJwq4fIAh
	3Nlrg5ANDt72D+lWQ46VSKXccNgsG50=
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
Subject: [PATCH bpf-next v3 6/6] docs, resolve_btfids: Document kfunc BTF annotation emission
Date: Thu,  6 Aug 2026 20:20:29 -0700
Message-ID: <20260807032029.78092-7-ihor.solodrai@linux.dev>
In-Reply-To: <20260807032029.78092-1-ihor.solodrai@linux.dev>
References: <20260807032029.78092-1-ihor.solodrai@linux.dev>
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
 Documentation/bpf/kfuncs.rst      |  7 +++++++
 Documentation/process/changes.rst |  5 -----
 tools/bpf/resolve_btfids/main.c   | 11 +++++++++++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index cbde86d082cc..021be6d93dfb 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -472,6 +472,13 @@ type. An example is shown below::
         }
         late_initcall(init_subsystem);
 
+At kernel build time the ``resolve_btfids`` tool finds all kfuncs declared with
+``BTF_KFUNCS_START()`` and emits their BTF annotations into the kernel's BTF.
+For each kfunc it emits a ``bpf_kfunc`` BTF decl tag, a ``bpf_fastcall`` decl
+tag when the kfunc is flagged ``KF_FASTCALL``, and the ``address_space(1)`` type
+attribute on the return value and/or arguments flagged ``KF_ARENA_RET``,
+``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.8).
+
 2.7  Specifying no-cast aliases with ___init
 --------------------------------------------
 
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 1ca8c5f73ad0..0aa232b117b5 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -147,11 +147,6 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
 generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
 modules as well.  This requires pahole v1.22 or later.
 
-Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
-or later.  Without it, such kfuncs will have incorrect BTF prototypes in
-vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
-with vmlinux" error.  Many sched_ext kfuncs are affected.
-
 It is found in the 'dwarves' or 'pahole' distro packages or from
 https://fedorapeople.org/~acme/dwarves/.
 
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index a1b921e86ef0..d2e4176339da 100644
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

