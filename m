Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794466;
	b=HP/Ta/nmPYt+JoUrgaQn1GyGaVW46EiprqxQsHMsYLi95pHCxgmfZhsDfLPxEaPDPiiI
	 PxQE9ebLS5EDsekhO1TaNbn5puwuIso0+UGkPfXjEYaqSSRV2fYgNjM8v9xa9FBgh3zUp
	 l4wDKuUlrRucaDp1peACupCGEGhEaEFkzrUs4rTuJYkeTHmZKErnYf19uwgYFRurUfd/V
	 bgA7SJZTqWAxnxbXp9/sS4eHpbiqdZgDB4a7m9GTssccMRr4kYxf96SPxdYmP/CdqC7t4
	 czLJph2DKZ2eDr0u0E3ZicSh5h7bCdqcbjPbGz3EqMUl8IPAp0lZhCuIlRcMvaGT8hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794466;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1LmCta+E11bwos0r0fzb+F8GgIxUxhmDUudltqscimw=;
	b=Evp2e7RYdHJWwlr5CU45NHrVt4ji7E1qegKxLI7sSt+ebxBF2FhEHNTCvBpu6By9MmV4
	 TfCR+rI08CtWAiigNlJgb8fZSMOVJ9MqFXRH/OGXqG/PNY7iedY9dMfevVZIwm8KlG895
	 kq0/KgdWF/hUOHXQS3gCe7QfU35WOrwY5/l+nbn/zC23QtU9vqS3Z8aupCRfMBx4yugaB
	 DHDDtaONimChnlrwhYgiG0CQzWiVfxWQ8/5SZV0PdZjiZ9lpli9UejGoALtKg6zmUtSBR
	 5vDpUauycXZZ7jyhH/brzjwQJnPI0TNglayGhqgbYL5pWjosVta61/1PprmmOrCCp5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RP++P2J1;
	arc=none smtp.remote-ip=91.218.175.185
Received: from mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB23606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB23606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RP++P2J1
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7hHZa94DsysRIGv+4xVSycVDgMvWKBdWVSbG1A27dwQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794464; v=1; x=1793399264;
 b=RP++P2J1GTHRfpseMDCCf80wjflok+wr/zj1EtytugUuFYvapgk7EKELT2u8J6U/IyxjDCr2
 l36rYt1NzBVL2tQOhzD1HXDEczpYb1TReqq6HFJbJTh/xcdTKDJds1HeSrPjlv0Jrd85E+eEKyb
 IM0OYpYWB0D9B+NnKP7JQktY=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id fef41547452717e3;
	Fri, 23 Oct 2026 22:27:44 +0000
X-Mizu-Trace-ID: fef41547452717e3
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
	David Faust <david.faust@oracle.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2 5/8] bpftool: Emit __bpf_static_offset on verifier-rewritten context types
Date: Fri, 23 Oct 2026 15:26:49 -0700
Message-ID: <20261023222652.3927736-6-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
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
it to the 13 types that need static offsets in vmlinux.h through
__bpf_static_offset.

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
-D__bpf_static_offset= can disable PSO for affected programs. The
crash has already been forward fixed in LLVM [3].

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
index 5c88f665e6b9..c7f446ab6afe 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1174,12 +1174,17 @@ static int btf_c_annotate_records(struct btf *btf)
 
 	for (i = 1; i < cnt; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *attr;
 
 		if (!btf_is_composite(t))
 			continue;
-		if (test_bit(i, no_pai))
+		if (!test_bit(i, no_pai))
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
@@ -1228,6 +1233,13 @@ static int dump_btf_c(struct btf *btf,
 	printf("#define __bpf_relocatable\n");
 	printf("#endif\n");
 	printf("#endif\n\n");
+	printf("#ifndef __bpf_static_offset\n");
+	printf("#if __has_attribute(preserve_static_offset)\n");
+	printf("#define __bpf_static_offset preserve_static_offset\n");
+	printf("#else\n");
+	printf("#define __bpf_static_offset\n");
+	printf("#endif\n");
+	printf("#endif\n\n");
 	printf("#ifndef __ksym\n");
 	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
 	printf("#endif\n\n");
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index 97664633931f..9166a99a6077 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -9,6 +9,14 @@
 #endif
 #endif
 
+#ifndef __bpf_static_offset
+#if __has_attribute(preserve_static_offset)
+#define __bpf_static_offset preserve_static_offset
+#else
+#define __bpf_static_offset
+#endif
+#endif
+
 #ifndef __ksym
 #define __ksym __attribute__((section(".ksyms")))
 #endif
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index edc8c5b708d7..ef01a8a4e6ad 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -9,6 +9,14 @@
 #endif
 #endif
 
+#ifndef __bpf_static_offset
+#if __has_attribute(preserve_static_offset)
+#define __bpf_static_offset preserve_static_offset
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

