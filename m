Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403291;
	b=RjIMkzlzn7gorK0drpK7w+iyH/5E6297dgvQus9d4V0Q3zx7XDJrqEVBDuYj98cmeZIX
	 zmy4jilRaJO3RQPRpUeIz/R2+Lo7fX/AzOkG4VXE8pqGMR0VIDAU4uM7fTQFh55kv4eUJ
	 Vli+bB5T1hAe3k61pRG9fY03LSOMrixEwu1+DyaD47E7lLVFBQ2l66kz/duOqyP3y5D8V
	 QY9Bk7pz2cGsad6zHXWP4koP5KGq9SojeQIm/7uSAz4ma7DszlTawnASIw4vdy7ubf4U+
	 H2AySeOKkoBzwWdCjwPI82D2l/pDLfKTxffEVbqA0lCh/UCALrNQhhj5UDC2FdIR25Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403291;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UP4Mh8dUAUMHFxLvakJazUBpQ0KyNmEbtA2CeEn1vkM=;
	b=3ipKzRwaoKuKmuvAxhSwD7ALRgWb/s5xCWQtIXlN1FRvu0OJxzbq6YaHXr+BekvkStX7
	 BDsQM/pURfdEx8cSH6hk/7zImDnR/riDVJlISYxN/AWjQ1GTuxNZ/fmsze8VtIHxci7YH
	 obFitwEY2RmYx6X9Cn8BNGRDTdfb3fXYSJSOhFr5dwco3gKGZnoV/kyZ+qu8eZwRRjYmu
	 FqQyMkS6160e53ydl2C5jfE/u06+RLsqzLgA81X4C9fYyx0pl0V7dbz8br8uN9w0tPAfJ
	 6FamImqKxAn81gkCU8Q8whsyRWQWds7doq99/0ze2HgCjK0XAJ1RDtW7koad/pF3/bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IRCZYrFc;
	arc=none smtp.remote-ip=91.218.175.28
Received: from mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072F606A325
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7072F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IRCZYrFc
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=28z+0mBn5pCcbPz/HtFwvcTQyMELRP0X9g3gV/iyBak=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403288; v=1; x=1794008088;
 b=IRCZYrFchhy6iVtfZe/58l4I+ImEcvmd4GBc2wJXWfdesodmuLZalgN5UPylmfX+MqLsahQi
 4+GWlZlE3r5WhijEV2v5qySHJPv1AY2D5zjScrh9RjW8L0UciLGY6/VNL1DckV3ZNCr3+jyckzX
 zrWpXTiyvknt3Uz5zEJ4thRU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id fa8c08e570eeab58;
	Fri, 30 Oct 2026 23:34:48 +0000
X-Mizu-Trace-ID: fa8c08e570eeab58
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
Subject: [PATCH bpf-next v3 10/13] bpftool: Emit __bpf_static_offset on verifier-rewritten context types
Date: Fri, 30 Oct 2026 16:33:52 -0700
Message-ID: <20261030233355.1836749-11-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
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
index 86ab844898db..03da4f6821f1 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1204,12 +1204,17 @@ static int btf_c_annotate_records(struct btf *btf)
 
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
@@ -1262,6 +1267,13 @@ static int dump_btf_c(struct btf *btf,
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

