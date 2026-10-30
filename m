Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403268;
	b=K1TNvWBXR/n8MR/U8mNkkZe2gH1AfrTrJdez3RqQx7j2/uUmeSDCUNC4/41F2iNl1vx/
	 W7NwTS5ciy7+MxkUOnmFMGLR0CO/TUTpOZrnIz4+xYu9pl0tV1IIpLrMN262YjAAgcwDf
	 mX686jDchI0aGSzEJQbSTSVDet3TuHLBXooA0GnkZf9z0JhWbkUDpz5JUfKx4ti0/NtNG
	 SRK9NjySZUoInfqEuWUyHNhXKlHYPUPZe/G/ao/IokEzvupxiu0kUfwuR8kVZwyQ7e7r8
	 pT9szD1q4m7y6wbeA2+PykiM7nRv/zawtopxW+UYFbGo8W/tEjenlrxhVnbi5/qs4oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403268;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aOETFB11lK61JVpcrF0adyQknR1ZnwtVjLv9AkP3jO0=;
	b=4PC3a9y7eCVz1EaBS3h1mbkYdLnNh1K/CEk7wjA8SwWeWBELTGCXn2srV6gwHKGWdUIT
	 a78tSAtWtyrfcGb7h2jkkl3mWkwBPhAO2LMmZC5kwXJuk4A+taR1frSiZNBbAAYGJxsYX
	 GpoHSUzoTw/sTwHg1nex6Q5WbY6eyUTZI2PUUiBJ8nqLBP+MmaaHjf0BhpKup4eF6m3Fu
	 z45O7J3sKnY4SFqI1LQTQfndAGH3THzC28Ttsbltx/u4lwDK16jAKPO2m8qRQRgfne05F
	 V7og4fafx9GlhBkGjy82i+Ls12dsCnBL1/QJOcLpUP3GuYRAzcOXbtNb1lrH16mzHng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CMeKZfQV;
	arc=none smtp.remote-ip=91.218.175.1
Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54708606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54708606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CMeKZfQV
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/l7JijRqeIH4ZNLQaYcxMZRJzO7OBEldHxwLVhwg5x4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403265; v=1; x=1794008065;
 b=CMeKZfQV+jm3CbX1w4BYMTDX1DAlP0m3vlgcnIoMS2HX0k94DQs9Jlg/VVs9CSnXai/xfgLp
 fgMoOjo3ZqHJYzrEU6GDLKZY+LZGVAGegFc58tH6nyBzScb2KQM7OzGZQw8w06U6UsfxZQYgD9w
 ls2+tKqW3kJxixZUIaBHpEAI=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 32629bfefc829c4b;
	Fri, 30 Oct 2026 23:34:25 +0000
X-Mizu-Trace-ID: 32629bfefc829c4b
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
Subject: [PATCH bpf-next v3 04/13] bpftool: Normalize legacy arena type tags before C dumps
Date: Fri, 30 Oct 2026 16:33:46 -0700
Message-ID: <20261030233355.1836749-5-ihor.solodrai@linux.dev>
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

Older kernel BTF encodes kflagged arena type tags as
"address_space(1)". pahole emitted them since commit 21cb33c7e065
("kbuild, bpf: Enable --btf_features=attributes"), and resolve_btfids
since commit 27a78c2e7eee ("resolve_btfids: Process KF_ARENA_* flags
in resolve_btfids").

Now that btf_dump prints kflagged tags as is, C dumps of such BTF
declare arena kfunc pointers as "void address_space(1) *", which does
not compile.

Rewrite these tags to "__attribute__((address_space(1)))" in memory
before dumping C. BTF without "address_space(1)" type tags stays
read-only.

Split BTF is dumped as is.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 385521e6b028..94237befec67 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -26,6 +26,7 @@
 
 #define KFUNC_DECL_TAG		"bpf_kfunc"
 #define FASTCALL_DECL_TAG	"bpf_fastcall"
+#define LEGACY_ARENA_TAG	"address_space(1)"
 
 #define MAX_ROOT_IDS		16
 #define MAX_BTF_FILES		64
@@ -1092,13 +1093,47 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 	return datums;
 }
 
-static int dump_btf_c(const struct btf *btf,
+/*
+ * Older kernel BTF encodes kflagged arena type tags as "address_space(1)",
+ * which btf_dump prints as is. Rewrite them to the complete specifier.
+ */
+static int btf_c_fixup_legacy_arena_tags(struct btf *btf)
+{
+	__u32 i, cnt = btf__type_cnt(btf);
+	int off;
+
+	if (btf__base_btf(btf) ||
+	    btf__find_by_name_kind(btf, LEGACY_ARENA_TAG, BTF_KIND_TYPE_TAG) < 0)
+		return 0;
+
+	off = btf__add_str(btf, "__attribute__((address_space(1)))");
+	if (off < 0) {
+		p_err("failed to rewrite legacy arena type tags: %s", strerror(-off));
+		return off;
+	}
+
+	for (i = 1; i < cnt; i++) {
+		struct btf_type *t = (struct btf_type *)btf__type_by_id(btf, i);
+
+		if (btf_is_type_tag(t) && btf_kflag(t) &&
+		    !strcmp(btf__name_by_offset(btf, t->name_off), LEGACY_ARENA_TAG))
+			t->name_off = off;
+	}
+
+	return 0;
+}
+
+static int dump_btf_c(struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
 	struct sort_datum *datums = NULL;
 	struct btf_dump *d;
 	int err = 0, i;
 
+	err = btf_c_fixup_legacy_arena_tags(btf);
+	if (err)
+		return err;
+
 	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
 	if (!d)
 		return -errno;
-- 
2.56.0

