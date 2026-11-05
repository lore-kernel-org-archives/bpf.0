Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901702;
	b=5ICQuEy314sH2pOgeUUJNOY+ewCYNRrsAeQPUAiWS/UHReZD1rUvJoDIp1Qz6uUAvkKQ
	 NNposBb1YQON5NBWh6Euw61n+o/WctZjfjpyGeRDIK7zGxRt2OQBvIrw5nL4+6lIvv6EF
	 248rxJt7zIDv5oaF8sKEhsLhmco8KWU+JhgWOGOkD1yLco75j9IgONtCS/+73rTNfU9r3
	 kEaQrCTxZnNPBQ+fd8hOBqTresiRPaUPLY7cAT4lXWnTpSuP2iw5mfvlGSWT1QBC0sCYt
	 h+HM+GxFJ5mMYYtxjwXYEy+zn6LeJvh3w1qij8WPgGKdnru41VV5qaLJLfsA31zkUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901702;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Jq+Q0U3o2EkYuq+B86LKkqOpSwTuw5gYD8i0VJcIcA=;
	b=xtV3GzBc+tn+8Vxd+jb7enBUIGpbRhjRccs9O0KPHQhV9f/Lv/zpZnkAW2TrDrNoWX6x
	 odq3yA5XNyk2RpHFW99DCJnVXx2YqQ02eXijiBrF6HiIwk1a5VLrazr3vE2SnioR4iLLI
	 KoXzP8wQRRNNE0H6J38kX57UvEeBMJUN1AtAnnbkR7AsZvfGj5iQNl3OX3Q7O+Ub9nDGC
	 5nrAbn67FJDdU4n2JqwTLPpm9vu9+z3nuRMTyenN8jyIH4o1gaWjRM5QKKZ8jIe2N20DN
	 0qHgOaXj2q6R4OwgBs6NB9kzhPCg+HG2MrBUpQ8VvlZ6Laaw4sU+klFxxz41BnRcH9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=twZYQR6l;
	arc=none smtp.remote-ip=95.215.58.172
Received: from mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A723606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A723606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=twZYQR6l
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yxGB61swd/Yk2GTfXrRSS8GiKzwStyGxd9xb7fXb9Og=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901700; v=1; x=1794506500;
 b=twZYQR6lvW/o4Uq8L8JDiYD7OV2t1t7qsBXdPvlAh1nmTqTGJQ3ZPHqmJ7hz/wQfIArLXZiX
 feGEJotL7wvMuKraIk8R9u9tUaUqTAleNRq21anDpNdpc3gCmp5MIjBgeDbBPYsmPOYq4rQegVi
 ttymiwcOl+6lY6LHNMRlwyKs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a9ec28209fbc30f;
	Thu, 05 Nov 2026 18:01:39 +0000
X-Mizu-Trace-ID: 8a9ec28209fbc30f
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
Subject: [PATCH bpf-next v4 17/17] selftests/bpf: Cover the arena type tag in bpftool C dumps
Date: Thu,  5 Nov 2026 10:58:45 -0700
Message-ID: <20261105175845.30357-18-ihor.solodrai@linux.dev>
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

bpftool prints the plain "arena" type tag as __bpf_arena. Add an
arena-tagged pointer to the BTF behind the bpftool C dump goldens and
expect __bpf_arena in its place.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/bpftool_btf_dump_sorted.expected     |  2 ++
 .../selftests/bpf/bpftool_btf_dump_unsorted.expected   |  2 ++
 .../selftests/bpf/prog_tests/bpftool_btf_dump.c        | 10 +++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index 0ecf53b29042..2370a60ca7c5 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -41,6 +41,8 @@ enum {
 	E0 = 1,
 };
 
+typedef int __bpf_arena *arena_ptr;
+
 struct __sk_buff {
 	int len;
 	union {
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index 24a8db96eab0..540a073c410f 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -76,6 +76,8 @@ struct bpf_nf_ctx {
 	int f;
 } __bpf_relocatable;
 
+typedef int __bpf_arena *arena_ptr;
+
 
 /* BPF kfuncs */
 #ifndef BPF_NO_KFUNC_PROTOTYPES
diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 3cda90062fc6..ce37aee5f288 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -32,6 +32,7 @@
  *	};
  *	struct bpf_tcp_sock { int snd_cwnd; };
  *	struct bpf_nf_ctx { int f; };
+ *	typedef int __arena *arena_ptr;
  */
 static struct btf *mk_btf(void)
 {
@@ -73,6 +74,10 @@ static struct btf *mk_btf(void)
 	btf__add_struct(btf, "bpf_nf_ctx", 4);
 	btf__add_field(btf, "f", 1, 0, 0);
 
+	btf__add_type_tag(btf, "arena", 1);
+	btf__add_ptr(btf, 13);
+	btf__add_typedef(btf, "arena_ptr", 14);
+
 	VALIDATE_RAW_BTF(
 		btf,
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
@@ -99,7 +104,10 @@ static struct btf *mk_btf(void)
 		"[11] STRUCT 'bpf_tcp_sock' size=4 vlen=1\n"
 		"\t'snd_cwnd' type_id=1 bits_offset=0",
 		"[12] STRUCT 'bpf_nf_ctx' size=4 vlen=1\n"
-		"\t'f' type_id=1 bits_offset=0");
+		"\t'f' type_id=1 bits_offset=0",
+		"[13] TYPE_TAG 'arena' type_id=1",
+		"[14] PTR '(anon)' type_id=13",
+		"[15] TYPEDEF 'arena_ptr' type_id=14");
 
 	return btf;
 }
-- 
2.56.0

