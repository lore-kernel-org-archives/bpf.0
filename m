Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901614;
	b=YAto7eZyghItFSoTWBX7Ie/dFQzl8zeukRxA1MopDJNFOTIkBzTRFrMtoVLcFzQ1ZyhL
	 Qyfk9tkS3j+8wZJesDnSNZ8V87LEEbAyuLqccqipPrV2Ix9/PXyOkTjZWxd1+sJbHJxRh
	 PfdPwG4FKs32A3E+YTULtEnGdSFbPSJe81d4390/9nZrg3VAZXhTTwqeqdDdiSn8xibhz
	 g+D4I+z5wW4MSKWDQ/DArPf0UnG7M1bJ2pFHyvqZ6+I29sl4ZG8E1Hgzqbu01+sLGwzek
	 n2UpppPR1lSiONozUbvZKA5g4AFz3YaFO7/cSrVPRKPZAj2hjXRa2en7/5ESE5gWtDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901614;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fRJLjRNHGcRGX8zCMRalBOFrNANGlIBPBDSWeyjfy0Q=;
	b=374LU4zArRmd432ZZoL1ogA78XgqULHmekEjg94qPamyYq3uA+IN/v986UCPDkNf2sjR
	 p/XuvvvbZAuuNzq0d4bxi6cSFRXQLRPZB7OSRgadFUV6cBrwk5dtwQeEpBw92bPgJ2U6u
	 80Hf3lwSpRIJBMd/2bcQC8HLUaGssH7qdnL+ejUKWUtE8BUrPzuZ/2QJCaJ4IqcwHn7cw
	 L5O/Q8pDyrr4IPiA6Ov9nI2pqxolZsJd4cIwdaBgUv7QM/dO2Hv2Z4oukeQLvmb27E6U4
	 X9PdKYheU+mF3Lx/eOeFH+sV6U/4uXe9/1GlUo0pM7RF7r5oz+Y/lE1Bc9He74TTb+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rsG6zmNF;
	arc=none smtp.remote-ip=91.218.175.252
Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B51606EE90
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B51606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rsG6zmNF
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+/Aar8q6d+DUgfZQmeu+4E9BUOeN7ffCEFAFyVqdmnA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901612; v=1; x=1794506412;
 b=rsG6zmNFWD50v2bVQak5lWhCfKrH1IoVTv/7Dyj44rOtjY40RD41I/rAvI3HEhrgNQiPhEE0
 Rc9Eb6xHpwl3hL5TNClq7NA3hRWsXfwUXEkgnvV6fsoII5sS64iMdQygL5Aniq88BAbryOVxdlH
 MmsNLr1zwgdqRGAj+ieDiM+A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88c112b763e979bb;
	Thu, 05 Nov 2026 18:00:10 +0000
X-Mizu-Trace-ID: 88c112b763e979bb
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
Subject: [PATCH bpf-next v4 08/17] selftests/bpf: Cover type tag rendering overrides in btf_dump
Date: Thu,  5 Nov 2026 10:58:36 -0700
Message-ID: <20261105175845.30357-9-ihor.solodrai@linux.dev>
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

Check that btf_dump prints the kflagged decl tags attached to a plain
and to a kflagged type tag in place of the type tag.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index ee8ccefc2a45..bfa74db17987 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -607,8 +607,12 @@ static void test_btf_dump_type_tags(void)
 	 *   void __attribute__((btf_type_tag(\"void_tag\"))) *p1;
 	 *   void __attribute__((aligned(8))) *p2;
 	 *   void __type_marker *p3;
+	 *   void __plain_repl *p4;
+	 *   void __kflag_repl *p5;
 	 * };
 	 *
+	 * The type tags of p4 and p5 carry kflagged decl tags, printed in their
+	 * place.
 	 */
 
 	id = btf__add_type_tag(btf, "void_tag", 0);
@@ -626,20 +630,40 @@ static void test_btf_dump_type_tags(void)
 	id = btf__add_ptr(btf, id);
 	ASSERT_EQ(id, 6, "void_ptr_id3");
 
+	id = btf__add_type_tag(btf, "plain_tag", 0);
+	ASSERT_EQ(id, 7, "plain_tag_id");
+	id = btf__add_decl_attr(btf, "__plain_repl", 7, -1);
+	ASSERT_EQ(id, 8, "plain_repl_id");
+	id = btf__add_ptr(btf, 7);
+	ASSERT_EQ(id, 9, "void_ptr_id4");
+
+	id = btf__add_type_attr(btf, "kflag_tag", 0);
+	ASSERT_EQ(id, 10, "kflag_tag_id");
+	id = btf__add_decl_attr(btf, "__kflag_repl", 10, -1);
+	ASSERT_EQ(id, 11, "kflag_repl_id");
+	id = btf__add_ptr(btf, 10);
+	ASSERT_EQ(id, 12, "void_ptr_id5");
+
 	id = btf__add_struct(btf, "s", 8);
-	ASSERT_EQ(id, 7, "struct_id");
+	ASSERT_EQ(id, 13, "struct_id");
 	err = btf__add_field(btf, "p1", 2, 0, 0);
 	ASSERT_OK(err, "field_ok1");
 	err = btf__add_field(btf, "p2", 4, 0, 0);
 	ASSERT_OK(err, "field_ok2");
 	err = btf__add_field(btf, "p3", 6, 0, 0);
 	ASSERT_OK(err, "field_ok3");
+	err = btf__add_field(btf, "p4", 9, 0, 0);
+	ASSERT_OK(err, "field_ok4");
+	err = btf__add_field(btf, "p5", 12, 0, 0);
+	ASSERT_OK(err, "field_ok5");
 
 	test_ctx__dump_and_compare(&t,
 "struct s {\n"
 "	void __attribute__((btf_type_tag(\"void_tag\"))) *p1;\n"
 "	void __attribute__((aligned(8))) *p2;\n"
 "	void __type_marker *p3;\n"
+"	void __plain_repl *p4;\n"
+"	void __kflag_repl *p5;\n"
 "};\n\n", "dump_and_compare");
 
 	test_ctx__free(&t);
-- 
2.56.0

