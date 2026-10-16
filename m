Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429A24336D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108862; cv=none; b=tNmZtEBZihqxhY0YduQDFpkSOMWuroBCKoHuu1hbkMzhG+oewMCP3BCDSUkSAGsx0cJ1jzUZ2NAe3XXiMXNzZlpKAyjhk6JtvhWzvwp9H3/+G/rNRWrc45zzx9HzBFiKNmtg6hMefY8c6NvwwZRttZtKlNz8OlRQBUczNJJPPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108862; c=relaxed/simple;
	bh=1ZtSQRZJ4JaUF1Qwh9nUshVVCgLh8ALLDgOYACvwh5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o60Yqewv9pntYw3HC34PxDCIdyR+iBRlSV3cOpLx4n4iGyJPujJqFeU35nntnI+VVXM++0cnO9cfscxYxqvhHzWFT5vexTWTMKgbM7Tjs4KVEgenaZKtE5UA/1F9TE5iDzBuhr4LvF6Lh8vn1Dh32b/Z2OzkAUB7BplotEcKX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nnI6YVkm; arc=none smtp.client-ip=91.218.175.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nnI6YVkm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1ZtSQRZJ4JaUF1Qwh9nUshVVCgLh8ALLDgOYACvwh5s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108858; v=1; x=1792713658;
 b=nnI6YVkmEXyZ1n+TM4ClkVggz6K2zybrxOH0nLYl1eEw4ybrbZow4iHE8onF704ubSRHJ51V
 XN0dqW+k0zzWEuiWojtV6DQNswHNXOGZrLwo0XfLH88tz8shOOFLzoXlRBlt7uWIO/ZKT6dvGLX
 /TQEtti+564am570s9xRxnx4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f550892c26fb11cf;
	Fri, 16 Oct 2026 00:00:58 +0000
X-Mizu-Trace-ID: f550892c26fb11cf
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
Subject: [PATCH bpf-next v1 6/8] selftests/bpf: Cover record attributes in bpftool BTF dumps
Date: Thu, 15 Oct 2026 17:00:10 -0700
Message-ID: <20261016000012.2232059-7-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Types whose field accesses need static offsets carry __bpf_core_pso,
while their nested anonymous records must stay unannotated. Other
records retain __bpf_core_pai, including context types such as
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
index 7da4df1da207..ee093f08d123 100644
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
+} __attribute__((__bpf_core_pso));
+
+struct bpf_nf_ctx {
+	int f;
+} __attribute__((__bpf_core_pai));
+
+struct bpf_sk_lookup {
+	union {
+		union {
+			int cookie;
+		};
+		int family;
+	};
+} __attribute__((__bpf_core_pso));
+
+struct bpf_tcp_sock {
+	int snd_cwnd;
+} __attribute__((__bpf_core_pso));
+
 struct holey {
 	int c;
 	long: 32;
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index f082da51d630..42233e435a04 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -48,6 +48,30 @@ struct s {
 	int f;
 } __attribute__((__bpf_core_pai));
 
+struct __sk_buff {
+	int len;
+	union {
+		int sk;
+	};
+} __attribute__((__bpf_core_pso));
+
+struct bpf_sk_lookup {
+	union {
+		union {
+			int cookie;
+		};
+		int family;
+	};
+} __attribute__((__bpf_core_pso));
+
+struct bpf_tcp_sock {
+	int snd_cwnd;
+} __attribute__((__bpf_core_pso));
+
+struct bpf_nf_ctx {
+	int f;
+} __attribute__((__bpf_core_pai));
+
 
 /* BPF kfuncs */
 #ifndef BPF_NO_KFUNC_PROTOTYPES
diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 9104c059a315..0277f054410c 100644
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

