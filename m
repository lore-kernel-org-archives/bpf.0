Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E996263C7F
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915294; cv=none; b=JezYVI28QCeX9goz5EX6ttKFbcn5POHLC6Mu+lzb9IWsI3zmJ/kBTYFNXTp8vx+I72Xz9uuOP/QxtLDpvrsbQtrFBa0JL86pIqtizxDKcAGMkEPL30yW45hWPAKlhp/dM045RPjHOoS1vS/J6unXG4nI5RfbOsOMUxKVBEUYbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915294; c=relaxed/simple;
	bh=FDa4XnzppPg5UBqLx/vvYRAkRuIHNEMBJBzoxwn9UR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9pgtAv6QL/b910EdhT5Ex48m3sT1Oeex3qiwwfP29Av7UUqjj4EG7oT8/o7W6uBriW/bJUeqLc96jy8Fq7w7FGtfVgx7EttTvQvXNTW2ctmAklVNEAqfD9iG2DWRX+47TdYCH74r6E8QgeTBYOzk+56/gF3EIgjocheI1Cst8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 170AA45844AF0; Wed, 22 Apr 2026 20:34:41 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 3/9] bpf: Remove WARN_ON_ONCE in check_kfunc_mem_size_reg()
Date: Wed, 22 Apr 2026 20:34:41 -0700
Message-ID: <20260423033441.2538149-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423033425.2536883-1-yonghong.song@linux.dev>
References: <20260423033425.2536883-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The warning is too late if it does happen. Remove it.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26b6cdfd8613..d123449f5552 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7134,8 +7134,6 @@ static int check_kfunc_mem_size_reg(struct bpf_veri=
fier_env *env, struct bpf_reg
 	struct bpf_call_arg_meta meta;
 	int err;
=20
-	WARN_ON_ONCE(regno < BPF_REG_2 || regno > BPF_REG_5);
-
 	memset(&meta, 0, sizeof(meta));
=20
 	if (may_be_null) {
--=20
2.52.0

