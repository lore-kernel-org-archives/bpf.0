Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901579;
	b=haJcZaFWpjS3x5+7M493YwZE3hK38563f+W52cZt7A2E8WGzeTNCwcMithX9wLhoTNFY
	 OVbuC558MQi6ze6VKe6YK0sP0AUHRd627sCWx3AEAA4a++ufGAg2RivgTNa2JBnOPNilh
	 Ybabx66CAOxrG5NjrbhO6Yu5XcKYWJIlP1EVJ+M18mDX9anVBVIbZN+tZrVdaiIAbb5UG
	 rb70qkzDhqo0TqqGIiWPmoISEcywf00kxThyMAzoKNV/bRDuvSkZf1it+v5nSwSM6rv2o
	 M2+QRNg4+vq4f3h5or+FsEPoxOw9OyrqKv9v2tQ79RRttGPkWN4DXrflMw9HGw3mmZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901579;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dxfKc4tfkvkIzf7zzr3lw8N6K6NOKEx7d1XkXcvuqPA=;
	b=MpIm7/OKSobfJ1ppKzPb12jVYDS5JlVvnDsMZrsy+a7M3XiSD+BCk3fA1ULNxDaHb/7K
	 AYqzEJsbptyn7UhZCU/H6F2HUTlHKMJoxe8YboSjU6+AiE/dUB/mtFKHirlkN+FEw4moU
	 T01qbthy33n0lkgBbdr9rK1XLaOWwnWcjz4UMbwogZErZBbhsHIcz4HnTCZqPyhpfBiQn
	 EcyzbPV/CfisxiXNDsJtFw820eVM2mazJakf3y82dAyGXN26cX+LZlSDDctPqqIuKPkYO
	 4l/oxOhXMfWPxIBGda62QSe++TC1Q8DSS0qjgag5XY64gCb1oBdGEKm8+qO/1HLpr1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=isuj8yzE;
	arc=none smtp.remote-ip=95.215.58.1
Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C796606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C796606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=isuj8yzE
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KJu3dGU0Al9H58KIMI3ZRTN+4pr7vvX1nmGUup4X6u4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901577; v=1; x=1794506377;
 b=isuj8yzECGp7ZGRryegoNHk3BKOCfUrmAQyRPsqTFiBix1AGMaT3DZmEUPtB6z0S3jsvMYEb
 KE4n23w8sWXo7HlfGjOuO327+nFW9f1/Xa7lhaZW/u2jWtrBy9fgTaRUdXZEyI0F7KyEzgtGiDA
 foy3m/LNjS33q05/kta0fx+Y=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 62adfd3c28aaf402;
	Thu, 05 Nov 2026 17:59:37 +0000
X-Mizu-Trace-ID: 62adfd3c28aaf402
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
Subject: [PATCH bpf-next v4 03/17] bpftool: Dump C through a split BTF
Date: Thu,  5 Nov 2026 10:58:31 -0700
Message-ID: <20261105175845.30357-4-ihor.solodrai@linux.dev>
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

btf_dump prints decl tags, so bpftool can annotate types in the C dump
by adding decl tags to the BTF it dumps. Adding them to the input BTF
would make it modifiable, which libbpf refuses for BTF with unknown
header-extension bytes, such as BTF from a newer kernel.

Dump C through an empty split BTF over the input instead, so that the
annotations can go there. btf__new_empty_split() does not inherit the
base pointer size, so set it explicitly.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
Later in this series bpftool adds decl tags to the split, for record
attributes and type tag spellings.
---
 tools/bpf/bpftool/btf.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 385521e6b028..a438b5a03f5a 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1092,17 +1092,30 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 	return datums;
 }
 
-static int dump_btf_c(const struct btf *btf,
+static int dump_btf_c(struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
 	struct sort_datum *datums = NULL;
-	struct btf_dump *d;
+	struct btf_dump *d = NULL;
+	struct btf *split;
+	size_t ptr_sz;
 	int err = 0, i;
 
-	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
-	if (!d)
+	split = btf__new_empty_split(btf);
+	if (!split)
 		return -errno;
 
+	/* btf__new_empty_split() does not inherit the base pointer size */
+	ptr_sz = btf__pointer_size(btf);
+	if (ptr_sz)
+		btf__set_pointer_size(split, ptr_sz);
+
+	d = btf_dump__new(split, btf_dump_printf, NULL, NULL);
+	if (!d) {
+		err = -errno;
+		goto done;
+	}
+
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
@@ -1130,10 +1143,10 @@ static int dump_btf_c(const struct btf *btf,
 				goto done;
 		}
 	} else {
-		int cnt = btf__type_cnt(btf);
+		int cnt = btf__type_cnt(split);
 
 		if (sort_dump)
-			datums = sort_btf_c(btf);
+			datums = sort_btf_c(split);
 		for (i = 0; i < cnt; i++) {
 			int idx = datums ? datums[i].index : i;
 
@@ -1146,7 +1159,7 @@ static int dump_btf_c(const struct btf *btf,
 				goto done;
 		}
 
-		err = dump_btf_kfuncs(d, btf);
+		err = dump_btf_kfuncs(d, split);
 		if (err)
 			goto done;
 	}
@@ -1160,6 +1173,7 @@ static int dump_btf_c(const struct btf *btf,
 done:
 	free(datums);
 	btf_dump__free(d);
+	btf__free(split);
 	return err;
 }
 
-- 
2.56.0

