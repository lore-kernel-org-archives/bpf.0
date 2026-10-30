Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403295;
	b=W1cLZWZBNnjhI2kZL5dY1KCdUlLW3sD5+r33mpfOeJvtUAlALKZw9uJ9uC1/36/7y03t
	 dwnj2u17wlCVs0PkhoHroGCTHL8xRO8+Ntg3HtuNpBq5BEvSAUnWCe6gYozwf+SROF5cT
	 tRjbsv37q87nfnv1NIENN9BGkVlE6SrzvWRIZ3pAgH1BIixSKho10hhm2SUuSZGZCkLhH
	 gKsJRx9lR5yXWkqiN3gidZ6926uKnIzrwvuHD8YVFjL6QE+JRFRV+N9Iof0P6vPeG28yO
	 kvmi5UxTpzKoldacij5LA2DVxzx1xoKE7tcwZHK+4/202fPMbxMDOI26nb6Qc7dXyzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403295;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XTCjIH5iD1w9pf1hkFE2wdzGBCG4uf8JbZqpD/p/k4Y=;
	b=3OE7A9Jea6v39LH4e/UMuZMYMVC2ZOXWVrGTf+6J6J3e1KoiWX+4KHVHyTJVI5vCyZUf
	 5PGQnBDrJRZ1EQQDqo4wlNlNa+HpOu1guBt/L16yByiGcOCGU9CajyyeeJxVo8U4deKDZ
	 vxdfZlrM0aRP1d2KoUuY8m5mftwrLgBrdCDM9saNp0M3JX12Lo27Vk1xKAQXsz+rutc0E
	 nJQG40HSDWTPXamlGpoRl2GFFO7E/D6hShmIBhOInBnXgsfPSNEY7xKcdr4OIIOueODH8
	 o5eCF1uNVuBn/VROYdPyBJhtO0zero0Tn3k6gW0qWOuO248tMu/9agQ2C6vCXfu7aqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VAOHrZrC;
	arc=none smtp.remote-ip=91.218.175.33
Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829C606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5829C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VAOHrZrC
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nu7a3z6FP/nMKsM6GA5muyXxarva1/rD5rROLuClCFw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403292; v=1; x=1794008092;
 b=VAOHrZrCd6JziRBgV56SVSgWlrktAEgo/6hJpWp9e8yrZQvqhBKM2Xp0pb3Sz536MMa4nedM
 NHjLC33UYXNgCZ9+nUOquYDjkGRfJPm1dENyfJw4h/Re5LQMuwPUKe1izCQlXRd4cVUU1IVfFvf
 M1WbBgUAkfMFULP5Z5BM/KPs=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7fc45828336366cc;
	Fri, 30 Oct 2026 23:34:52 +0000
X-Mizu-Trace-ID: 7fc45828336366cc
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
Subject: [PATCH bpf-next v3 11/13] selftests/bpf: Cover record attributes in bpftool BTF dumps
Date: Fri, 30 Oct 2026 16:33:53 -0700
Message-ID: <20261030233355.1836749-12-ihor.solodrai@linux.dev>
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

Types whose field accesses need static offsets carry __bpf_static_offset,
while their nested anonymous records must stay unannotated. Other
records retain __bpf_relocatable, including context types such as
bpf_nf_ctx whose accesses do not need static offsets.

Extend the existing C dump test fixture with selected context and
socket types and recursively nested anonymous unions.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/bpftool_btf_dump_sorted.expected      | 24 ++++++++++
 .../bpf/bpftool_btf_dump_unsorted.expected    | 24 ++++++++++
 .../bpf/prog_tests/bpftool_btf_dump.c         | 47 +++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index b56b676b96a5..190cf16e49a2 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -37,6 +37,30 @@ enum {
 	E0 = 1,
 };
 
+struct __sk_buff {
+	int len;
+	union {
+		int sk;
+	};
+} __bpf_static_offset;
+
+struct bpf_nf_ctx {
+	int f;
+} __bpf_relocatable;
+
+struct bpf_sk_lookup {
+	union {
+		union {
+			int cookie;
+		};
+		int family;
+	};
+} __bpf_static_offset;
+
+struct bpf_tcp_sock {
+	int snd_cwnd;
+} __bpf_static_offset;
+
 struct holey {
 	int c;
 	long: 32;
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index 543db89078af..1a0a7b016c50 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -48,6 +48,30 @@ struct s {
 	int f;
 } __bpf_relocatable;
 
+struct __sk_buff {
+	int len;
+	union {
+		int sk;
+	};
+} __bpf_static_offset;
+
+struct bpf_sk_lookup {
+	union {
+		union {
+			int cookie;
+		};
+		int family;
+	};
+} __bpf_static_offset;
+
+struct bpf_tcp_sock {
+	int snd_cwnd;
+} __bpf_static_offset;
+
+struct bpf_nf_ctx {
+	int f;
+} __bpf_relocatable;
+
 
 /* BPF kfuncs */
 #ifndef BPF_NO_KFUNC_PROTOTYPES
diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 3bfbd185a74d..b9b3d31bc17b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -20,6 +20,18 @@
  *	};
  *	enum { E0 = 1 };
  *	struct s { int f; };
+ *	struct __sk_buff {
+ *		int len;
+ *		union { int sk; };
+ *	};
+ *	struct bpf_sk_lookup {
+ *		union {
+ *			union { int cookie; };
+ *			int family;
+ *		};
+ *	};
+ *	struct bpf_tcp_sock { int snd_cwnd; };
+ *	struct bpf_nf_ctx { int f; };
  */
 static struct btf *mk_btf(void)
 {
@@ -42,6 +54,25 @@ static struct btf *mk_btf(void)
 	btf__add_struct(btf, "s", 4);
 	btf__add_field(btf, "f", 1, 0, 0);
 
+	btf__add_union(btf, NULL, 4);
+	btf__add_field(btf, "sk", 1, 0, 0);
+	btf__add_struct(btf, "__sk_buff", 8);
+	btf__add_field(btf, "len", 1, 0, 0);
+	btf__add_field(btf, NULL, 6, 32, 0);
+
+	btf__add_union(btf, NULL, 4);
+	btf__add_field(btf, "cookie", 1, 0, 0);
+	btf__add_union(btf, NULL, 4);
+	btf__add_field(btf, NULL, 8, 0, 0);
+	btf__add_field(btf, "family", 1, 0, 0);
+	btf__add_struct(btf, "bpf_sk_lookup", 4);
+	btf__add_field(btf, NULL, 9, 0, 0);
+
+	btf__add_struct(btf, "bpf_tcp_sock", 4);
+	btf__add_field(btf, "snd_cwnd", 1, 0, 0);
+	btf__add_struct(btf, "bpf_nf_ctx", 4);
+	btf__add_field(btf, "f", 1, 0, 0);
+
 	VALIDATE_RAW_BTF(
 		btf,
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
@@ -52,6 +83,22 @@ static struct btf *mk_btf(void)
 		"[4] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
 		"\t'E0' val=1",
 		"[5] STRUCT 's' size=4 vlen=1\n"
+		"\t'f' type_id=1 bits_offset=0",
+		"[6] UNION '(anon)' size=4 vlen=1\n"
+		"\t'sk' type_id=1 bits_offset=0",
+		"[7] STRUCT '__sk_buff' size=8 vlen=2\n"
+		"\t'len' type_id=1 bits_offset=0\n"
+		"\t'(anon)' type_id=6 bits_offset=32",
+		"[8] UNION '(anon)' size=4 vlen=1\n"
+		"\t'cookie' type_id=1 bits_offset=0",
+		"[9] UNION '(anon)' size=4 vlen=2\n"
+		"\t'(anon)' type_id=8 bits_offset=0\n"
+		"\t'family' type_id=1 bits_offset=0",
+		"[10] STRUCT 'bpf_sk_lookup' size=4 vlen=1\n"
+		"\t'(anon)' type_id=9 bits_offset=0",
+		"[11] STRUCT 'bpf_tcp_sock' size=4 vlen=1\n"
+		"\t'snd_cwnd' type_id=1 bits_offset=0",
+		"[12] STRUCT 'bpf_nf_ctx' size=4 vlen=1\n"
 		"\t'f' type_id=1 bits_offset=0");
 
 	return btf;
-- 
2.56.0

