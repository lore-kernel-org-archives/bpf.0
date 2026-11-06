Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995065;
	b=OqoXxTnGWyc4xy03pqiUJHzPSgF5vxHKdhmffLIGP4v/z0G3MmMErFFGVq993MIIlus1
	 1hNe7Ub9e4iyd6ewuZ+bKfQoAIAtEF/vOLE82Bn4ISHDh38bpzWH1b1+yadruqT3qEaxB
	 U1b7uraCNTLUbJcdYyQBFXFnPrIxG6kfNTStAy6lzHdrTo25oyCZkx/C+rEHElyMO5O2y
	 OQ4OiWkSIxFhSfvqejyRrhfWjwLRZfbJxIE3Xvma1oaVNw96FwGBkJdLYVDWtRpwHqxt4
	 rYxi1MVvCi4yzZ1g7kwvhkuvcohEs2bc7Xlibh+uzYsSCivQvEKT1AKc573KTW/Y+PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995065;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yR0wyjLXqswp1CQsrxga6re1CLg85kqI+4FeWhg45N4=;
	b=iezRzJpg2qDmDdfPJCxatT9lF2yJuEPbzRD3NIe1qiTYPBRv/qdeWK+eY8v4lhNhMVYr
	 agC8t32mSTZk2TstxLiVSzIxYmKtIzUA/oqsI7thngSd5g36oGGLCoJRZfc0S4qUsbvcM
	 eOKjXKNSbVW7TsjrOhn0Jk7rmNlAZg8O9maQLte7BmCDouq8Wg0GXxI5u1SxlTVNeYzuu
	 eCiaUiafBGeiHMnt6ZkED4Adm2c3fmgebxcbnVToJAucdoyraIr6DM+CK0W2yrgH0N5/I
	 N4pX0f6bzgWRNGXZpz7yGycq5G20RVfY0psYX0eeUKhXmiDR/rqtmyi7jy5BUDBq5NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JpZ6rNzr;
	arc=none smtp.remote-ip=95.215.58.246
Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C090606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 19:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C090606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JpZ6rNzr
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d/lPlHCf8xyzPs/06b91N1R+2xTg7kkZvJXNBtHLknk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793995062; v=1; x=1794599862;
 b=JpZ6rNzrjjxoLuABHJf42RUCph0XaZ8YWMX7q0kqUlEs4xNZvn/WqM96NjDIyxAlk3QGf+qe
 LxUzrLLgMmWmU9xVQrNjiLKjG58jG5zxOD1OWAFEjaZC5hQHmfZEiybif7cfRektV4GP72YeDdJ
 q7CZd21Lu+nf2L5NAj+/NhQs=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e803b596db9e8dc0;
	Fri, 06 Nov 2026 19:57:42 +0000
X-Mizu-Trace-ID: e803b596db9e8dc0
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
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v1 3/3] bpftool: Replace the type tag override table with two checks
Date: Fri,  6 Nov 2026 12:57:30 -0700
Message-ID: <20261106195730.2623973-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106195730.2623973-1-ihor.solodrai@linux.dev>
References: <20261106195730.2623973-1-ihor.solodrai@linux.dev>
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

btf_c_annotate_type_tags() looks each type tag up in a table of
overrides. The table holds two fixed cases, the "address_space(1)"
string of older kernel BTF and the plain "arena" tag, and is not
expected to grow.

Check for the two tags directly and drop the table.

No functional change.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4BzbpVnoqKnGAVKYRffraPpPWjnNFF2oFAnXmBkqd2V6vmg@mail.gmail.com/
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index c06b01f2c5b3..c51c2efde3ed 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1096,38 +1096,29 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
  * Kernel BTF keeps its type tags as the kernel expects them. Decl tags in
  * the dump split choose how btf_dump prints them.
  */
-static const struct {
-	bool kflag;
-	const char *name;
-	const char *override;
-} btf_c_type_tags[] = {
-	/* the arena attribute in older kernel BTF */
-	{ true, "address_space(1)", "__attribute__((address_space(1)))" },
-	/* __arena in include/linux/bpf_compiler_types.h */
-	{ false, "arena", "__bpf_arena" },
-};
-
 static int btf_c_annotate_type_tags(struct btf *btf)
 {
 	__u32 i, cnt = btf__type_cnt(btf);
-	size_t j;
 	int err;
 
 	for (i = 1; i < cnt; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name;
+		const char *name, *attr;
 
 		if (!btf_is_type_tag(t))
 			continue;
 		name = btf__name_by_offset(btf, t->name_off);
-		for (j = 0; j < ARRAY_SIZE(btf_c_type_tags); j++) {
-			if (btf_kflag(t) != btf_c_type_tags[j].kflag ||
-			    strcmp(name, btf_c_type_tags[j].name))
-				continue;
-			err = btf__add_decl_attr(btf, btf_c_type_tags[j].override, i, -1);
-			if (err < 0)
-				return err;
-		}
+		if (btf_kflag(t) && !strcmp(name, "address_space(1)"))
+			/* the arena attribute in older kernel BTF */
+			attr = "__attribute__((address_space(1)))";
+		else if (!btf_kflag(t) && !strcmp(name, "arena"))
+			/* __arena in include/linux/bpf_compiler_types.h */
+			attr = "__bpf_arena";
+		else
+			continue;
+		err = btf__add_decl_attr(btf, attr, i, -1);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
-- 
2.56.0

