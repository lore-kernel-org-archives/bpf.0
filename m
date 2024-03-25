Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFE17EB7C
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337736; cv=none; b=IfAwcqoAAlsn2MButSN5HwAxW/VSCWE+4yWOYdbF1yPlAO7X/zO1SwAK061Ongz4iwSJ/RHqyR8dqorwLczHx5HxrjQQI0I+oNupNNcY0qj59DP9f3pKVoKukldHdUV7JHHlXqgADVixJkRSrEU1k8QVT2i4PN/nKAs+fetFcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337736; c=relaxed/simple;
	bh=TIIsnhNC26TlvoI9fq43s6Lexb7AsZtK3Hbfov+OSOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/4z2hgPGgf+NG9hU2fQvK2OdLICcHDLOYRZi7gkG3fgfGFe1Ar0xcyrSkZDE+JSspemcOvTcBFXhXCvSYxqyZwwTYmAvhLHEaCR/FvZusCQ+GqbxDoBK40n4xkuIR5UtVnL2iy/mPHgSrekRAKvn9Q8sbm9HOQ42rbwfYWzkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EC7B52455A7C; Sun, 24 Mar 2024 20:35:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Sync uapi bpf.h to tools directory
Date: Sun, 24 Mar 2024 20:35:19 -0700
Message-ID: <20240325033519.1681477-1-yonghong.song@linux.dev>
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

