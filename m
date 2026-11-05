Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901671;
	b=gcaeRU7oBI4MXTbmAfwWDQuliARPv9p7mrCpLCx4+9ZJlZpbZzfYEOUxHV+OdgYYzVJn
	 2r7jiinIimQjc2bH2LqKwiwovrhtShAv/cp7dCcAs5u48lSp1dZEgMB2c7vMOzcERJvUp
	 CM1QRojA7mSofa5oRQXi9hZy8Z+4QKnvLAlB/UxGb2XYZtFLOCJymVDWE3WVeqhVwJe2P
	 4ZuUBy8y6SrGpTq7tV9G1Rl91Ix49E4pf2i4YPGZTo83+5PGPXtfRqzaB5nFPgzG+HHdS
	 KhmR3kXW1/iu1cGtCO5qXU+dWQva01d386X4VsY3evBlUeS/xbNnzfQ3O++5kpFFJpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901671;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mqIgipGNH3uaJPun3gY2EdWJe5EjgNO1lxAnDZz0bLo=;
	b=A1L5gO6d2XIatDfhKRhct+Jpktr+clnJlwAPph5odNvgwJOIufrNfVxFM9dMPuKJAHI3
	 RDsylOEMsSpbDoWPqRLFjxIrYNVmuW5FWEgca5JUNwXwJyxxu57Ae5/oqCEOgCMsc/kX6
	 xJUED+CwCexiK8rc8bE44kkxcoRZnbPDuD2AaJYg4ZRZ2nAdgYy+doTUngFjofdzcAKyC
	 Bm/EIXgDOedKR03jSczYbC+ZT7ikkD1GeWO0oRme4s0FJ/MxJv1IEp+aA5L1oNRJP4oqn
	 hOWQlVkyBhPI6BKuEZcu9yNQ2fZcG9QPe3ec9LyyQb/nqUfKuUEXHjeQb7I8lRbhOkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sx+6tTot;
	arc=none smtp.remote-ip=91.218.175.33
Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49700606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49700606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sx+6tTot
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BGAG7nspM85fYkrguaFEyaMIhs8lFjlVYZzb9T0jeG8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901668; v=1; x=1794506468;
 b=sx+6tTotw++m0p8vqHKsVo9Sj5cdXGOiLPfmmpxNtCeJw+KgiTIjfk101A5tA920yNgGBcK6
 4k0boHuXZmmX/hAvlFSTrE+kHJMwe7Xo4QksWpcOnezgp+3l8c/gTz5o0n8Rk1LCY+MCJD1qCrn
 g771EPrJNzRcXRUTslKpiRPI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eae9d1363d87049d;
	Thu, 05 Nov 2026 18:01:08 +0000
X-Mizu-Trace-ID: eae9d1363d87049d
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 12/17] bpftool: Emit __bpf_static_offset on verifier-rewritten context types
Date: Thu,  5 Nov 2026 10:58:40 -0700
Message-ID: <20261105175845.30357-13-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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

The verifier translates accesses to some UAPI context and socket types
into accesses to kernel structures. These accesses require an
unmodified base and an immediate field offset.

Leaving preserve_access_index (PAI) off does not stop the compiler
from merging loads at different field offsets into one load through an
adjusted pointer. The verifier rejects the resulting program.

preserve_static_offset (PSO), available since Clang 18, preserves
static field offsets in load and store instruction immediates. Apply
it to these 13 types in vmlinux.h through a __bpf_static_offset macro.

Eduard introduced PSO in Clang and proposed annotating BPF context
types in 2023 [1]. His v3 RFC [2] left pt_regs annotations in
architecture headers unresolved. However, since commit
de6c7d99f898 ("bpf: Relax fixed offset check for PTR_TO_CTX"), program
types without convert_ctx_access() accept fixed offsets from modified
context pointers. pt_regs can now keep PAI, while PSO on
bpf_perf_event_data covers its regs member.

PSO creates no CO-RE relocations, so BPF_NO_PRESERVE_ACCESS_INDEX does
not disable it.

Clang 18 through 23 crash on __builtin_preserve_field_info over a PSO
record, including bpf_core_field_*() and the CO-RE bitfield helpers.
-D__bpf_static_offset= can disable PSO for affected programs. LLVM main
has the fix [3].

[1]: https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/
[2]: https://lore.kernel.org/bpf/20231220133411.22978-1-eddyz87@gmail.com/
[3]: https://github.com/llvm/llvm-project/pull/234280

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c                          | 16 ++++++++++++++--
 .../bpf/bpftool_btf_dump_sorted.expected         |  8 ++++++++
 .../bpf/bpftool_btf_dump_unsorted.expected       |  8 ++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index d913723a691a..1329745c5854 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1206,12 +1206,17 @@ static int btf_c_annotate_records(struct btf *btf)
 
 	for (i = 1; i < cnt; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *attr;
 
 		if (!btf_is_composite(t))
 			continue;
-		if (non_relocatable[i])
+		if (!non_relocatable[i])
+			attr = "__bpf_relocatable";
+		else if (btf_c_needs_static_offset(btf, t))
+			attr = "__bpf_static_offset";
+		else
 			continue;
-		err = btf__add_decl_attr(btf, "__bpf_relocatable", i, -1);
+		err = btf__add_decl_attr(btf, attr, i, -1);
 		if (err < 0)
 			goto out;
 	}
@@ -1264,6 +1269,13 @@ static int dump_btf_c(struct btf *btf,
 	printf("#define __bpf_relocatable\n");
 	printf("#endif\n");
 	printf("#endif\n\n");
+	printf("#ifndef __bpf_static_offset\n");
+	printf("#if __has_attribute(preserve_static_offset)\n");
+	printf("#define __bpf_static_offset __attribute__((preserve_static_offset))\n");
+	printf("#else\n");
+	printf("#define __bpf_static_offset\n");
+	printf("#endif\n");
+	printf("#endif\n\n");
 	printf("#ifndef __ksym\n");
 	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
 	printf("#endif\n\n");
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index f2389e3dceed..b56b676b96a5 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -9,6 +9,14 @@
 #endif
 #endif
 
+#ifndef __bpf_static_offset
+#if __has_attribute(preserve_static_offset)
+#define __bpf_static_offset __attribute__((preserve_static_offset))
+#else
+#define __bpf_static_offset
+#endif
+#endif
+
 #ifndef __ksym
 #define __ksym __attribute__((section(".ksyms")))
 #endif
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index 549045677a45..543db89078af 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -9,6 +9,14 @@
 #endif
 #endif
 
+#ifndef __bpf_static_offset
+#if __has_attribute(preserve_static_offset)
+#define __bpf_static_offset __attribute__((preserve_static_offset))
+#else
+#define __bpf_static_offset
+#endif
+#endif
+
 #ifndef __ksym
 #define __ksym __attribute__((section(".ksyms")))
 #endif
-- 
2.56.0

