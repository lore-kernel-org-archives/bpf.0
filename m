Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901679;
	b=USQ+FhzV9InZYuJeI5o2BMYTpMEtc8P5D1JRVQj4zk1K87r7nQziyISyzY6BmPa3BDTz
	 ODIwXZC6EU3/E+eXL7m9hjsGYMggST51Bs7jG+tA83ENs0T5wVnHMMV4tC/uMnETf2bjo
	 BrMaihEXLrtEVg6C7e8I4q8/5pHwOK51MaRIiEyagh19ivQhdeAp3/SOZtukDTHCBahTO
	 wPFO2Iva0tfJNpea2jUPE7fVMV7DwiHBzN9uRXC7gaj/eRqxPMTLomGnC3ABD9rJ7+hh5
	 sKJx5BdDQ5vHF+JnpPorqKmp/A6vevTj4hr2AYpyVSEFbeQQ5LdTFRyWTAdsMbbhZsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901679;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vVrY7iO2E0QUSezbQT5VrBfQVYAbHYDYzf+ezNa/yr4=;
	b=XXXf/6uN9/HpFQD2hC13gTghcGszF+xI4IA4wh9/xkMJlsyeypePbgsxpc4cVmVDSf4O
	 MmdxccELk6CvhnTVjbFxGXQ9zJpT3m5NUmixcATL/EQKdqAFVhyYSOz5gOT/v2BwxLSk3
	 hydd5j7eZ+wq9+yzZSS0J2YH4eFPRig+EaiDeH7hNPqJiQ24lw9EuXLXrDETr/g2UhfK6
	 k0Qfe7+22ltxfEVo8AY4cesEnk0pP9Oit66gvPzatCqoM+z9fXVB5mIK4NNddjWijhiZU
	 rXDNg2dcIO9Wm3Qn59P3HaUNugcI8KVFJNb5adE2pXqcuIHPS6XOxfyXj5hfF7JqH+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dUPyuhtv;
	arc=none smtp.remote-ip=91.218.175.38
Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA24606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA24606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dUPyuhtv
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HVVLUAPpW/QYgHrgY8PEikya9mNgqdbB3N/oZINqr4I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901676; v=1; x=1794506476;
 b=dUPyuhtvcfAKBBmv644U8zcZ+TGud7oBm4DwEsIuJlQkoUl0rwVM73oGM3sO3YVXhgli3M4h
 XuLgIfmTTTv8O3Gq4KYQzQCMqkV2pP6WkjF90aNuJ+WOk9vvY8FX8Kz0jGYhCslz65g8Tc2yvMy
 Fz9HQxsF+qU7IHK8EhWWAAcY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7a03f7f486c8f48;
	Thu, 05 Nov 2026 18:01:16 +0000
X-Mizu-Trace-ID: e7a03f7f486c8f48
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
Subject: [PATCH bpf-next v4 13/17] selftests/bpf: Cover record attributes in bpftool BTF dumps
Date: Thu,  5 Nov 2026 10:58:41 -0700
Message-ID: <20261105175845.30357-14-ihor.solodrai@linux.dev>
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
index a0f801fcaa47..3cda90062fc6 100644
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

