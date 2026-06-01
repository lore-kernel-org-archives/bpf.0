Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC51D33F38A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352358; cv=none; b=qwEA9rOCbI4DPTyCBIuRdX2i4xvH12pwPhConOkwFrB8eCnzqIF7OoKP42iS7TXi+CsS3t9reNQqWjCNg//liawpjJ1YNmvtbPgxjwmcBZr5PKbCmD6c8TG7sviSDlk4AuyzF35QHjszLltkG7DsvEkvlziSHB7AiGyJsI5t9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352358; c=relaxed/simple;
	bh=fdAaXmr1cWg84b0wBQ8jqn/wzbTsxUaBTNoLVSNnX88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MG8ZdTTin2DDz4kchns7Auvr7ZWWkMYrsZVd6z34caH4nA4BaKTIFxPKHpVyy8ZpU+QWnm0yQe7k7dtwSpqp+y0OjbkyIis2wnWfHNBl1OWgD+9Rv68LTZ4Wg3EvxfYxZPSVxnx76qhX5yh1U6lRwF9cp6ovYtoUyQyN9EbQs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=swHQSmdp; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="swHQSmdp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780352355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZt7AzOdQKxnXzeb5++Qplk5WRhbTV2gZxVVAInflKk=;
	b=swHQSmdpPRVl95tS2sD2Iv9P/aGeoHZ+9B3lzpPcPb6J2lPEHCmmhWr1NfEBkGEMhccAdS
	A6pUDBGGeHi/CnzZlyW0hLtDZOjCSP8adRkNcFX4yqsz/BVrpfHvKQbLrKuutNPBBKbk3I
	PHbo86AgG+NtIpjHv+5OewGxfVZPZwc=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v1 10/14] selftests/bpf: Verify bpf_fastcall decl tags in resolve_btfids test
Date: Mon,  1 Jun 2026 15:18:01 -0700
Message-ID: <20260601221805.821394-11-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-1-ihor.solodrai@linux.dev>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend test_resolve_btfids() to assert that resolve_btfids emits a
BTF_KIND_DECL_TAG of name "bpf_fastcall" for each kfunc marked with
KF_FASTCALL flag.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/resolve_btfids.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 7d9c3460cbed..eeda4e3b6a7f 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -246,6 +246,13 @@ void test_resolve_btfids(void)
 					     kfunc_symbols[i].id),
 			    kfunc_symbols[i].name);
 
+	/* Check resolve_btfids emitted bpf_fastcall decl_tag for fastcall kfuncs */
+	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++)
+		if (kfunc_symbols[i].flags & KF_FASTCALL)
+			ASSERT_TRUE(btf_has_decl_tag(btf, "bpf_fastcall",
+						     kfunc_symbols[i].id),
+				    kfunc_symbols[i].name);
+
 out:
 	btf__free(btf);
 }
-- 
2.54.0

