Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403287;
	b=SHpd5JzZs2yfXQK4BDq8Y91V1Onr2SFiZlA6Ud4wtEhuTFQrtZiglFZ3PTsSNkNnN0XC
	 k1RKfQQNW3Bc/3zDO58jJ2RwKLbwOQBpcfo/UibrNUZPiqqAXw2aXmFk5MtBUZR8Gb3ui
	 94kuWKjgKxFGTmoxg1dRoq3UP9YgB5vosbPF7bixnLvAvJU+Fa6Y05ID8OIsBG8bWGiBs
	 GAyWFvrlUl5qQq7YCTm6VvhOo/hYah/DXJpZx4vz80ee2uWd/arnL6PM761v6FOmTXNaM
	 ducZzvadi11Y5/SyhIa2gYZXHKlZqVlUVJuAd577QneLEnUAjihmUv2DKy5Kbf2uW+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403287;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6W0l9u3ZvdNI+PMB8JcFc3HEAyY6JWYPWWoTW6MWjAA=;
	b=CO8S6c2qePBrxGo58Ii0AjVBJU5wAnp088MVtGOXSQXhhH3dKb6MZHatDw4mvVERpM+5
	 9K4opFlSQyMBWwCh6x0gPwlnL1nO7r5kkwqAL2eH09zPQYNcyyFBjhK51RcnOjI4ZaQf+
	 /csa3aZm7CD9Okb7PibhAQMnJYpBmynq0fq8GjJqilby+pa5IGXOan1DZfFw3kTPorbhR
	 z3l9UTowC3Hz5Nb8cKCPYvsgT/pDZt5fAvbjxXwqIeAKtfh0zrKlVDs8RYLMUV7WLnhQ/
	 erOOQXQ4yTm2ggisDHklDS+6feasH9m2H4godO9AS7pRtfexIoAbsF+mF20zzJQMW2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mtwYZuyt;
	arc=none smtp.remote-ip=91.218.175.22
Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C5606A324
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A11C5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mtwYZuyt
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YC9FsXdra1a+1p1mCp2VFbJP0Vf4nse3A8nJpey1Kho=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403284; v=1; x=1794008084;
 b=mtwYZuytie9DVrCgaNQ+z4yPhcua/wJ3+F2ptg/TTUoKISDUm8TpnQcVFPf49w1tcqEYjWx8
 iy9RPQD0C4UQji0x/dxjnIRVzACNqkSwr5s7zDer9c4t+QQZwSXZ+A9RTDbgJf/vYDkEu1DZ0qs
 zHG9BvN33gUw5F+Ou9fTMmxw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id d9072071e9baf8aa;
	Fri, 30 Oct 2026 23:34:44 +0000
X-Mizu-Trace-ID: d9072071e9baf8aa
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
Subject: [PATCH bpf-next v3 09/13] bpftool: Skip __bpf_relocatable on verifier-rewritten context types
Date: Fri, 30 Oct 2026 16:33:51 -0700
Message-ID: <20261030233355.1836749-10-ihor.solodrai@linux.dev>
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
 tools/bpf/bpftool/btf.c | 83 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 5f5c054d7366..86ab844898db 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1123,22 +1123,101 @@ static int btf_c_fixup_legacy_arena_tags(struct btf *btf)
 	return 0;
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
+static void btf_c_mark_non_relocatable(const struct btf *btf, __u32 id, bool *non_relocatable)
+{
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	const struct btf_member *m = btf_members(t);
+	__u32 i;
+
+	non_relocatable[id] = true;
+	for (i = 0; i < btf_vlen(t); i++, m++) {
+		const struct btf_type *mt;
+		__u32 mid = m->type;
+
+		mt = btf__type_by_id(btf, mid);
+		while (btf_is_array(mt) || btf_is_mod(mt)) {
+			mid = btf_is_array(mt) ? btf_array(mt)->type : mt->type;
+			mt = btf__type_by_id(btf, mid);
+		}
+		if (btf_is_composite(mt) && !mt->name_off && !non_relocatable[mid])
+			btf_c_mark_non_relocatable(btf, mid, non_relocatable);
+	}
+}
+
 static int btf_c_annotate_records(struct btf *btf)
 {
 	__u32 i, cnt = btf__type_cnt(btf);
+	bool *non_relocatable;
 	int err;
 
+	non_relocatable = calloc(cnt, sizeof(*non_relocatable));
+	if (!non_relocatable)
+		return -ENOMEM;
+
+	for (i = 1; i < cnt; i++) {
+		if (btf_c_needs_static_offset(btf, btf__type_by_id(btf, i)))
+			btf_c_mark_non_relocatable(btf, i, non_relocatable);
+	}
+
 	for (i = 1; i < cnt; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
 
 		if (!btf_is_composite(t))
 			continue;
+		if (non_relocatable[i])
+			continue;
 		err = btf__add_decl_attr(btf, "__bpf_relocatable", i, -1);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
-	return 0;
+	err = 0;
+out:
+	free(non_relocatable);
+	return err;
 }
 
 static int dump_btf_c(struct btf *btf,
-- 
2.56.0

