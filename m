Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901663;
	b=WmruIUc0E51wfMMUgPvfIedgjzmCYiVaugFecAl4eLRlBE02mqHCCtmQHlUEELW96GHB
	 63vPDUythq9358dA6M0aHD6gklZGR6Wg7iNopoQN+CZpBhUNJRRszfyYdYHilMvtx7J/T
	 2hrXcTSQk98r32PEkh0vMbuFkq9LK941zgG4kdfuBXjZCpOWbNnpsce9JKJ+7ejzCfSlU
	 uW8zN64dxQ3gis9rojg9ZJH6PiXIAWaoZCPBmJ2roezzU1slxYMWoG9Sq+1l8s96AeY5s
	 gqi+bKEKMDC8YQFLldMtpQehl0+ZE8z8IO5fMMoYKZK4z12EUei0nGwlsMNwKltGgJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901663;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UXWzrShwIx6pTY9kLNB6FgkR+ZsThs/MzQe+600aWOk=;
	b=TiLSHsLceYYwAuAJe9JQRjqCANCnUoRt3gNQDJIxzt4AKBrv7NJ1N8+Kq298uECK0ZK5
	 UOiGDjG5GoltxoGUX5lXZtxGsDYtSlw+Ea7VZ9ZO+ca/CokTE9Ay2EVHInD9uic8dUwiu
	 2Sf17Ug5SB7kdTyjMM65fmwAcKLiY+EZR54reOx80a0xrQCyUmfQ5vQ9OM6Gfdym+zokB
	 L/Hvo7zuK+IZym5kDsY0K1QdUJEnqSAIWdJ014yYiuzvrTqKgS0B657PmDTnmYR4uRcsk
	 70UcWEbklMEOvdaMr8r0b2dh2WCTvCrxCj+dS7APziYW5bBiJxfjzwCjaeC4+xdzUQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pETpMxJJ;
	arc=none smtp.remote-ip=95.215.58.106
Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAA606A329
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25FAA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pETpMxJJ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Zz7hxpt5bOq60gCnCiGuiFR4BjDSmbDXxelTnNGeuvs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901660; v=1; x=1794506460;
 b=pETpMxJJjdb+X2QYL1bfEKW7hGrhjhWGQUbSN8GplIjKXkLAJ/rewG8OViVwvGEe6/WyLm3V
 1a3L0m3PtZAkag6AWLNMJ44BtVRb6e2bo+69LeTU4+oLoK7UgErcwwvnqYmKNNqzok8g8B6ODkz
 HoKtSEtakaR3IBHzF7YgXn3o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d7120d6378bf5028;
	Thu, 05 Nov 2026 18:01:00 +0000
X-Mizu-Trace-ID: d7120d6378bf5028
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
Subject: [PATCH bpf-next v4 11/17] bpftool: Skip __bpf_relocatable on verifier-rewritten context types
Date: Thu,  5 Nov 2026 10:58:39 -0700
Message-ID: <20261105175845.30357-12-ihor.solodrai@linux.dev>
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
compiler can instead emit pointer arithmetic, for example for a
one-byte load at offset 1 into skb->mark. The verifier then rejects an
otherwise valid program.

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
 tools/bpf/bpftool/btf.c | 77 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index aa4290d5cabc..d913723a691a 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1131,22 +1131,95 @@ static int btf_c_annotate_type_tags(struct btf *btf)
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
+		const struct btf_type *mt = btf__type_by_id(btf, m->type);
+
+		if (btf_is_composite(mt) && !mt->name_off && !non_relocatable[m->type])
+			btf_c_mark_non_relocatable(btf, m->type, non_relocatable);
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

