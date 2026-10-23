Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794474;
	b=leQb6WJmMo42ZL3ETfqtFrM/lJvffntgOa6hoK5sHN2OJdiyL0k3jEeFnyXCD5yoLr71
	 RfiV3Y+ssx9XdvnK4yqcqVxq1OdVmYfv1DlC80v5GagxJTkFOVLGE9R0VejvZ1keBw9we
	 QN5kXRyjX/IkhgM0J+pbFCqSf2UkKVcP5/TRLk3rCxS1sSoEmYGuo3BiovRCi4CVU3huS
	 1tWHODDad1IgQqSrhnbTOefUF0WPO8gBHxexfXtnw7XUB3b//HB1eI8LqfpWsLVTFhHOf
	 f4E7Lys9Zh9T3Nd8fMEznF0Ce+8i9zzlcGaqATbFXHO9F45rKVyMnV9OAxkCGCECMEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794474;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d3VTmzoqRaNHiY6nPNlMjmPHkWuhYTwFIGXxcSR5SBs=;
	b=ON5HeI1WP43YjKK5bFx4i2IFADq4TYgJHbPB4wy//Tteww/jqsedskNxxxvlFD4+XJfq
	 Vk+ifbHNof9+aAouvfOusgz16Q4VdMUA7OUOyROk/+sA5NGO6o0wJvZm51MRzuBmTtoFQ
	 RnDypsvFOB0I0WxS02VcoUsQB6D1iuhFREfk3roOBx4AaFnUDdGltBO/ALfk7xqZQ/TVq
	 2A+dMmeHtRMDa3wZpOH1pC82l0hP60DbtVeVp0PT+/jqYvMXfn4OhJfxWdzOXu+oSLrxH
	 QZWu3G2ZjqTRbjsCSvIKUGH8H/N6DVDyayy5eslWjoBD84k2Jx9le0SNTPGwgLdEK4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="D2SBu4/O";
	arc=none smtp.remote-ip=95.215.58.165
Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7A606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22F7A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D2SBu4/O
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WBzzdGo+ZjIZgINn80OttFUAte+JbSxcsiptePUIHzM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794472; v=1; x=1793399272;
 b=D2SBu4/O/wduHWGy3dH60h4ESDi6n/y03Gk3aqf42adKlaW41Cjzj73o0uFKx6JembKdckDt
 IeTF46yPrYD+zL/D891hpQSRyZbviYcHt44UX5kDwswMlYV2osxrN5nFWSExkEbH7wxadL60MGd
 Ah0tK3qK/c5AifpoZvpwtQvw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 5ea27ea574071876;
	Fri, 23 Oct 2026 22:27:52 +0000
X-Mizu-Trace-ID: 5ea27ea574071876
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
Subject: [PATCH bpf-next v2 6/8] selftests/bpf: Cover record attributes in bpftool BTF dumps
Date: Fri, 23 Oct 2026 15:26:50 -0700
Message-ID: <20261023222652.3927736-7-ihor.solodrai@linux.dev>
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
index 9166a99a6077..38cec98ddedd 100644
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
+} __attribute__((__bpf_static_offset));
+
+struct bpf_nf_ctx {
+	int f;
+} __attribute__((__bpf_relocatable));
+
+struct bpf_sk_lookup {
+	union {
+		union {
+			int cookie;
+		};
+		int family;
+	};
+} __attribute__((__bpf_static_offset));
+
+struct bpf_tcp_sock {
+	int snd_cwnd;
+} __attribute__((__bpf_static_offset));
+
 struct holey {
 	int c;
 	long: 32;
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index ef01a8a4e6ad..81f58181da14 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -48,6 +48,30 @@ struct s {
 	int f;
 } __attribute__((__bpf_relocatable));
 
+struct __sk_buff {
+	int len;
+	union {
+		int sk;
+	};
+} __attribute__((__bpf_static_offset));
+
+struct bpf_sk_lookup {
+	union {
+		union {
+			int cookie;
+		};
+		int family;
+	};
+} __attribute__((__bpf_static_offset));
+
+struct bpf_tcp_sock {
+	int snd_cwnd;
+} __attribute__((__bpf_static_offset));
+
+struct bpf_nf_ctx {
+	int f;
+} __attribute__((__bpf_relocatable));
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

