Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4A3CE8C5
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337938; cv=none; b=VzCKwOXgBVzKMWeeW7ldQYDkIbng1GRsV7tXrV8gl6LpyaQl/+YwRRT/kGoh+xqt1Glt2bPd0Lx6Rpfpna8up0BeRmymsd8eE7UXx2vj+nWp0KIsbki0H1gDGvOyofZDqE9msMVptGDlORqixYuKs6zbqxZR5yntXFjDfWyZFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337938; c=relaxed/simple;
	bh=TIIsnhNC26TlvoI9fq43s6Lexb7AsZtK3Hbfov+OSOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hM+y+8kED1QpJGh477F27bnIExSxRUW7iqMw7ZC/ucOoiXqzuOYpyX1JR/fqMKzlO9uhC6dvPjeDFIw/QXH/w4cj+0SXG4J3MF417AEqHHqm3crfGNZ0zcu76BWAWZ0NrGbjrl0fn2bwQSCi40IskWK00PNsvP0pRxrpm7yPCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9E8C82455F5C; Sun, 24 Mar 2024 20:38:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Sync uapi bpf.h to tools directory
Date: Sun, 24 Mar 2024 20:38:42 -0700
Message-ID: <20240325033842.1693553-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a difference between kernel uapi bpf.h and tools
uapi bpf.h. There is no functionality difference, but let
us sync properly to make it easy for later bpf.h update.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/include/uapi/linux/bpf.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index bf80b614c4db..9585f5345353 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1662,9 +1662,10 @@ union bpf_attr {
 	} query;
=20
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
-		__u64 name;
-		__u32 prog_fd;
-		__aligned_u64 cookie;
+		__u64		name;
+		__u32		prog_fd;
+		__u32		:32;
+		__aligned_u64	cookie;
 	} raw_tracepoint;
=20
 	struct { /* anonymous struct for BPF_BTF_LOAD */
--=20
2.43.0

