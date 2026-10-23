Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794462;
	b=eP0HmkiDNPUh9ejwwVx5P6zFiGz+laYcKXDhX+d+0UAOilNvHkonvKvv0llQjfyKxzyN
	 nlABwmWSh/Wgqj3VFXx6F0jpTpBFlohwrvEgnHUytKAsIahudyJYTjxnlP6o9rY2ymrYW
	 lUB3wcabG5+BMaf/oqDOikVx7JDjJ1E+H371Lrqq4z7f7xoxoSeUW/ZnzNWHlkQapWieQ
	 IM7T2IE0DK7C7SnlEwPMIi2IdEhNgCFKWx3Avr2CXwmz76QCwOU1Lz54jU38SRFi1DR7n
	 lxhLCPxPhcHWcRTCtAXxvrjg+kwLcbPL5xC8vGnAgQVAc3CdoIjrvZ2QgzKTDvtkU0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794462;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OeHh3AaRca1sCxgd4NjV6R8yzIKkvRHrJoAfrZ4R5lI=;
	b=yH6vIFF+P2BIQOnRMndlnMpnK0BziZ2GMhxDgOK1LiRGFKbWWfYbCmh0j2gWqxRs395a
	 YFnzL5mMLQk/pX5PXzwKaBrbuwNJMfjB00mYfnhjKsAPFa8+ivH+Emfqzvng5/0Wts+4i
	 8nmv3sfHd/uKSRF1a08BkBk+S+V3sN9OK5jFCyiLO2XxOUTOiWopJYTu3vuj5uWGsLwXa
	 aOh64itNm+Cd55HvtloJCtDJaeSQD8QItUmq4qfBlUyscqBxrVPFF/6Z6Z8Y8T1Hr8t2Y
	 KrlV/GtFJ+mQpFUOZ0ACHRyrfUphGr0lkKbUmQQn4nG8G8J8ZTcASyB71HcSStXS1kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="s/45cEzQ";
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B48606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s/45cEzQ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=azfXhD0l3bMg83jHpdyvflFINn66BPwKceVvdkz2JH4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794460; v=1; x=1793399260;
 b=s/45cEzQ0V/00SPjPHYYHDI1Ye8AYvty2AF0cKrsUZVlnVPOWIY7YkmDsatAhXXNvyyXOTsY
 /tSRYpXOStALwIKCabC0kCEpHxmQjknCubvcFmg5/J/T/WCwAeWuxKtfQU3LJfNGvY7fZ1DgGea
 2todDxuA1q1dhTIp/gML8b1M=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id c756654e26e70556;
	Fri, 23 Oct 2026 22:27:39 +0000
X-Mizu-Trace-ID: c756654e26e70556
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
Subject: [PATCH bpf-next v2 4/8] bpftool: Skip __bpf_relocatable on verifier-rewritten context types
Date: Fri, 23 Oct 2026 15:26:48 -0700
Message-ID: <20261023222652.3927736-5-ihor.solodrai@linux.dev>
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

The verifier translates accesses to UAPI context and socket types,
such as __sk_buff and bpf_sock, into accesses to kernel structures.
It picks the kernel field by the instruction's offset and keeps the
base register. For example, in bpf_convert_ctx_access() [1]:

	switch (si->off) {
	...
	case offsetof(struct __sk_buff, mark):
		...
		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
				      bpf_target_off(struct sk_buff, mark,
						     4, target_size));

So these accesses require a load or store with an immediate offset
from an unmodified pointer. Their UAPI field offsets are fixed, so
CO-RE relocation is unnecessary. With preserve_access_index, the
compiler can instead emit pointer arithmetic, for example
for ((u8 *)&skb->mark)[1].  The verifier then rejects an otherwise
valid program.

Omit the attribute from the 13 such types when dumping C. Also omit it
from their nested anonymous records: keeping it there can root
relocations at an unnamed type, which libbpf cannot resolve.

The last addition to this set was bpf_sk_lookup, introduced in 2020 by
commit e9ddbb7707ff ("bpf: Introduce SK_LOOKUP program type with a
dedicated attach point"). Keep the set hardcoded in bpftool so the
exclusion also works with older kernels.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/filter.c?h=v7.2#n9939

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c | 84 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 5a2c5341b736..5c88f665e6b9 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -6,6 +6,7 @@
 #endif
 #include <errno.h>
 #include <fcntl.h>
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -1092,22 +1093,101 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 	return datums;
 }
 
+/*
+ * The verifier translates field accesses of some types into accesses
+ * to kernel structures, see bpf_convert_ctx_accesses().
+ * The translation keys on the immediate offset of each load or store,
+ * so offsets into these types must stay immediates.
+ */
+static const char * const btf_c_static_offset_types[] = {
+	"__sk_buff",
+	"bpf_perf_event_data",
+	"bpf_sk_lookup",
+	"bpf_sock",
+	"bpf_sock_addr",
+	"bpf_sock_ops",
+	"bpf_sockopt",
+	"bpf_sysctl",
+	"bpf_tcp_sock",
+	"bpf_xdp_sock",
+	"sk_msg_md",
+	"sk_reuseport_md",
+	"xdp_md",
+};
+
+static bool btf_c_needs_static_offset(const struct btf *btf, const struct btf_type *t)
+{
+	const char *name;
+	size_t i;
+
+	if (!btf_is_struct(t))
+		return false;
+
+	name = btf__name_by_offset(btf, t->name_off);
+	for (i = 0; i < ARRAY_SIZE(btf_c_static_offset_types); i++) {
+		if (!strcmp(name, btf_c_static_offset_types[i]))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Anonymous records within types that need static offsets must not start
+ * CO-RE access chains. Named records, typedefs and pointer targets are
+ * separate types.
+ */
+static void btf_c_mark_no_pai(const struct btf *btf, __u32 id, unsigned long *no_pai)
+{
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	const struct btf_member *m = btf_members(t);
+	__u32 i;
+
+	__set_bit(id, no_pai);
+	for (i = 0; i < btf_vlen(t); i++, m++) {
+		const struct btf_type *mt;
+		__u32 mid = m->type;
+
+		mt = btf__type_by_id(btf, mid);
+		while (btf_is_array(mt) || btf_is_mod(mt)) {
+			mid = btf_is_array(mt) ? btf_array(mt)->type : mt->type;
+			mt = btf__type_by_id(btf, mid);
+		}
+		if (btf_is_composite(mt) && !mt->name_off && !test_bit(mid, no_pai))
+			btf_c_mark_no_pai(btf, mid, no_pai);
+	}
+}
+
 static int btf_c_annotate_records(struct btf *btf)
 {
 	__u32 i, cnt = btf__type_cnt(btf);
+	unsigned long *no_pai;
 	int err;
 
+	no_pai = bitmap_zalloc(cnt);
+	if (!no_pai)
+		return -ENOMEM;
+
+	for (i = 1; i < cnt; i++) {
+		if (btf_c_needs_static_offset(btf, btf__type_by_id(btf, i)))
+			btf_c_mark_no_pai(btf, i, no_pai);
+	}
+
 	for (i = 1; i < cnt; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
 
 		if (!btf_is_composite(t))
 			continue;
+		if (test_bit(i, no_pai))
+			continue;
 		err = btf__add_decl_attr(btf, "__bpf_relocatable", i, -1);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
-	return 0;
+	err = 0;
+out:
+	bitmap_free(no_pai);
+	return err;
 }
 
 static int dump_btf_c(struct btf *btf,
-- 
2.56.0

