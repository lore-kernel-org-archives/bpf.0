Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA03168EF
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836539; cv=none; b=mQgo1O6+lcpI5srPL5MTL7T8kV5+v8gqjwdFo4x4WM1cRcMGx2n6mWvze/r+I9m08YsE9VDSLc0W53lRKKcOgQtUZNG2xfTI2f9VJft0CT9fCeeeRip8nFCCUxOfRSGP2HRJOUmF/dlTJfjLjCuYwSid09z0yaDVdskUPz1uQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836539; c=relaxed/simple;
	bh=6uFwUDyOCW3NRcUFi6s9mTNqFwK5hSEQy+80JRvAO/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx0zcVyCzIfcLJLXStAaePVSkBtZKchWLdPqsmqBRU0xEk9HKSKK0f55B8qbDKXYQWL6QZPQ9DNV1PCGxkWI+siWUPUgRG91u4GCJy0vFHfP2kgzH0ugC1xhQVSWlpRYCphIYGub5do8OACw2p+Oyf7RlTzcKF8DLEQ1diAbOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6F99644D083D9; Tue, 21 Apr 2026 22:42:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 3/9] bpf: Remove WARN_ON_ONCE in check_kfunc_mem_size_reg()
Date: Tue, 21 Apr 2026 22:42:04 -0700
Message-ID: <20260422054204.3125553-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260422054149.3124342-1-yonghong.song@linux.dev>
References: <20260422054149.3124342-1-yonghong.song@linux.dev>
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

