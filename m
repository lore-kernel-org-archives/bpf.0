Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E01279334
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791997; cv=none; b=LfhBdh/CQNKK/Of+gypsDDDuaQiaPjgBu2cEGpim0XcbkMy5wv+hlUZUL2szU5f85qbmedCZZfdbPOx2RIM5Qm9FJ3ik6NiyNlLVFU+3lCkWfRxnS+jbZZpwSd48jdic49XFVJQnTeSwXVjZx+yvP7waw2bGSSsJDzCy8Nzzu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791997; c=relaxed/simple;
	bh=lpc7h8z2D1nSAkYqtSzG9CwEJr5pVJ9kRMCM/nrYbyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFt+ZNulX1zxOtitieR5ziTxFjdXxpyyC0AmzML3H8c53F7aORsnFrnIsIOG5IuQrbANR5mZbhZiQB14xwa8beasZgPsa77XZgh8Yz5UayePaS+Fu9juCCJkyEPratE7MIPbTw2kYWFci6JbeCj7FrPP0GBhIc8/NOT80raUxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6E7CB44B2796A; Tue, 21 Apr 2026 10:19:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 3/9] bpf: Remove WARN_ON_ONCE in check_kfunc_mem_size_reg()
Date: Tue, 21 Apr 2026 10:19:42 -0700
Message-ID: <20260421171942.3508899-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421171927.3507554-1-yonghong.song@linux.dev>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The warning is too late if it does happen. Remove it.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 34696af96b3e..ed04fef49f6c 100644
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

