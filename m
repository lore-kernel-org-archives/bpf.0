Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FD38D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108833; cv=none; b=Y5ncw4DcmXeqqu5z/257oyvLDNjX90UN1oMFNgS10SIGYz3kc/Q12t7hF/00zR+uSPUaVEoVLWLfoYYzL28vctYc+q3ofG4zLMhhCDp48idMgygYV66w0tqwAhPfBFFB8jr0zn2Jmm0+FYSNvn+a5f/5bArWn2E60MTNu2PES64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108833; c=relaxed/simple;
	bh=DI3iY0jhH5BCJbPAEuTD5+gjiP0EJivO5ZWMKtE8pPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF01jhke4GgBghoi7bUGKlXMfKuOzMm8m5R0xPSbqvq8vy2gw3F6jaCv3ozNnjCiD96lAgFZLMneivpTWiLtHlmjMqHtMmtIM+GzTmrPonkPIFVipqYkBHxRW5xH7T6+Ndfu/bc9pTpcdBP1ouhdFNBBAQS2emllpU5OrcIX8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rBJCn1zm; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rBJCn1zm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DI3iY0jhH5BCJbPAEuTD5+gjiP0EJivO5ZWMKtE8pPk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108829; v=1; x=1792713629;
 b=rBJCn1zmctDFnjpclM4H0vQMnXIdOuqIYJ3elEcvOI3Xg7+dSptv7oDyVwR4wXcI0tTprick
 r3WL3+8HAfbls019YxdqZp/lwZxm9iRHNY3AuvWlL9hDJIvhBlVWYXaLapygRRo0U07aGJFaPh+
 gfDINXuv22uG6LyFSrlHqdgY=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 012556801b8dd8b0;
	Fri, 16 Oct 2026 00:00:28 +0000
X-Mizu-Trace-ID: 012556801b8dd8b0
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
Subject: [PATCH bpf-next v1 1/8] bpftool: Dump C from a detached BTF copy
Date: Thu, 15 Oct 2026 17:00:05 -0700
Message-ID: <20261016000012.2232059-2-ihor.solodrai@linux.dev>
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

To emit per-record attributes in the C dump, bpftool needs to add decl
tags to the BTF it dumps.

Modifying the parsed BTF fails for some valid input: libbpf refuses to
modify BTF whose header carries unknown nonzero extension bytes, so
such a dump would stop with -EOPNOTSUPP.

Dump from a flat copy built with btf__add_type(), which only requires
the destination to be modifiable. Appending types in ID order preserves
every reference, including when flattening split BTF. Carry the pointer
size so cross-architecture input keeps its layout: btf__new_empty()
assumes the host's. The layout section is not copied, since btf_dump
does not consult it.

The C output is unchanged on vmlinux, split module BTF, object files
and root_id dumps.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c | 48 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index abd661db91e6..cc15989643cf 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1092,17 +1092,53 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 	return datums;
 }
 
+static struct btf *btf_c_detached_copy(const struct btf *src)
+{
+	struct btf *copy;
+	size_t ptr_sz;
+	__u32 i, cnt;
+	int err;
+
+	copy = btf__new_empty();
+	if (!copy)
+		return NULL;
+
+	/* Retain the native default if the pointer size cannot be inferred. */
+	ptr_sz = btf__pointer_size(src);
+	if (ptr_sz)
+		btf__set_pointer_size(copy, ptr_sz);
+
+	cnt = btf__type_cnt(src);
+	for (i = 1; i < cnt; i++) {
+		err = btf__add_type(copy, src, btf__type_by_id(src, i));
+		if (err < 0) {
+			btf__free(copy);
+			errno = -err;
+			return NULL;
+		}
+	}
+
+	return copy;
+}
+
 static int dump_btf_c(const struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
 	struct sort_datum *datums = NULL;
+	struct btf *copy;
 	struct btf_dump *d;
 	int err = 0, i;
 
-	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
-	if (!d)
+	copy = btf_c_detached_copy(btf);
+	if (!copy)
 		return -errno;
 
+	d = btf_dump__new(copy, btf_dump_printf, NULL, NULL);
+	if (!d) {
+		err = -errno;
+		goto done_free;
+	}
+
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
@@ -1130,10 +1166,10 @@ static int dump_btf_c(const struct btf *btf,
 				goto done;
 		}
 	} else {
-		int cnt = btf__type_cnt(btf);
+		int cnt = btf__type_cnt(copy);
 
 		if (sort_dump)
-			datums = sort_btf_c(btf);
+			datums = sort_btf_c(copy);
 		for (i = 0; i < cnt; i++) {
 			int idx = datums ? datums[i].index : i;
 
@@ -1146,7 +1182,7 @@ static int dump_btf_c(const struct btf *btf,
 				goto done;
 		}
 
-		err = dump_btf_kfuncs(d, btf);
+		err = dump_btf_kfuncs(d, copy);
 		if (err)
 			goto done;
 	}
@@ -1160,6 +1196,8 @@ static int dump_btf_c(const struct btf *btf,
 done:
 	free(datums);
 	btf_dump__free(d);
+done_free:
+	btf__free(copy);
 	return err;
 }
 
-- 
2.56.0

