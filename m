Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5D2E3AEA
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770011928; cv=none; b=FzbuLxgzvQyuH95cFF9Ton2f+lFY1M5mEwECG72ogmrho0KbCYYCWA9rzlRIqteGbTwRCvXBWqGfkN8gJdTWXAqKtiu/2Mk+Y2Aqa9byjSjryfPRQYxIb+AmGo+5B+D+4lHdZEITzOxu5uDysoe5nJ14adFKRNE6z+3LZ2f9lsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770011928; c=relaxed/simple;
	bh=sWh4qRJW5wuJPUJ9xDpga/kqSm/hNDUxwTBOVpO7yLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6ANh18zrEENvc0zlGAEpy1FeSSB04z3MzoGEWouBO2yuGvTQzreb9OoZOfHOl3ubs2qW/qpPRBk7JoMhsRQPaUmZ/0CSRRR3YJori5w5rXRpuXMwJP+4fF806UWIhlyJOyEPy9WyRphl4I+Trpjqe2WKmWCJxNNXkwzpuK6O6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJDgfcNU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJDgfcNU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a8a7269547so38823585ad.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 21:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770011927; x=1770616727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMhSx+6lEu+8jKPgVw5bypgKSiK+gEAAE/MS9cV7FQc=;
        b=XJDgfcNU3PKMjQmczVXjyk+N85UEXf+o6htBYWFPlYS691hqn9sK8eUZV1AWL5sJwu
         l8YUeahfnHxylM/mn/Kbbr992lBfHDFbksYfP1WAMDyhy0I4busrxJB03iAqYk/hYWu8
         JGdBx1IHhpXotF/qcp5Q+amVA0vQ/zVoSF2iZjryZ4aZ2ZM2W1qPDDblQlZP1lGa4W4T
         44nSjryfOvn0pXdqg5pXf7mLl3l2Qmx5V4IyUQhBo6G51D2yZQAMuxlkly+XfF5VKZ0V
         Z5DgAnBbLpDhd38U7fLvBcv6VZLgFQcuSrcmunWABHlLC86MTumV/zIfsj9K0gRxKnur
         salQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770011927; x=1770616727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sMhSx+6lEu+8jKPgVw5bypgKSiK+gEAAE/MS9cV7FQc=;
        b=gubrRFIHzfNsh7TlUdKPn7ohEYGb/MllgnYVHrdTEy+1FlLeD57XuVr/HxsBPbL59P
         nvRhr2nvMIOqEDqGMbggOQzYgMaFrlOmG/Sm805BDP6DIvzTyoQ5OVcIVQ3e6Ra00zHp
         6LIJmcyY3hZIPMCPnJWSzmzPZpzTe0WFR3VkaDD+OPRmWNvJKFv4KadmZPugYB4Oj7E1
         yDzYGXLNcjBTQuVCzZWIdSw3pjUM2T+cCRIz7xfvI4qyukg3n4VTB8htrdOIqPlcYdQU
         FvYNVWtcU6WrEFr8r6b8ZZO5Cz2FErrQ6CtokF3FT9yt0STSTyB+d9iyGqk+f//Qhs2U
         6m8w==
X-Forwarded-Encrypted: i=1; AJvYcCW/cMm5tPyABfUahD2nVAWinSgod8UkqNy+t2V33ARds7rgBDPv4OnKhWdNljyRzINVBng=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaLuApxKX/ta13uR9XLTzB4DEkMOlGUqPPKGdnbjC7HRpBozd
	bJEFLRX752FS20rjj2bZ/FVn3mOZBnDOmhIbrNWvxOgZv8Osq1QtWqMS
X-Gm-Gg: AZuq6aL2dqWc80ltp0kvinxrwFgGv3rTzCCovLkRbbnMCa2kZbY+2fZ3BmTmYZj8QX8
	+EDE9TVnAwqRgY8NjG4psOeXKnSfJjDme0aMDMzYp0hRmeIzOJttUiG8COOUsu7Pyp2w0yCXjpD
	6+9VFO8hZ8EhrkqQo3iugPAXKYHH69CHs3TjNFmvkS632C3fTDWeTrNf/bL6fuvhKpF7Q0/zwSA
	OLYtP068pI+vXkHUySDlxeH8yBaEVGpbNjfSvLvY+PVLv3F1BbzsJCftvaYDekLO+KrmBX0UaOv
	3abWkJ+0+rJ2zE7Q2mj1zG8k5/Hr0vbx/lpNh7p+WBIOzoogx6xXPjqp/P5t51pQRvosLnOwHmY
	fRSGuda+PudEbTKSgPC3b+v7aaBG6aHPk8FOVrEXQwCRkjwv/RRB9z/dEkbLMzZRkes4wiY9yjf
	k4PgYFkqnogk8b6pWC1G8G+oCw+xJo8Q2o+FhlUXL4pw==
X-Received: by 2002:a17:902:f544:b0:2a7:fe78:a344 with SMTP id d9443c01a7336-2a8d959c5a1mr111982815ad.6.1770011926631;
        Sun, 01 Feb 2026 21:58:46 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4173a2sm139121185ad.30.2026.02.01.21.58.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 21:58:46 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yangfeng@kylinos.cn,
	alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH RESEND v3 2/3] bpf/verifier: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
Date: Mon,  2 Feb 2026 13:58:17 +0800
Message-ID: <20260202055818.78231-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202055818.78231-1-pilgrimtao@gmail.com>
References: <20260202055818.78231-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

When traversing an rbtree using bpf_rbtree_left/right, if bpf_kptr_xchg
is used to access the __kptr pointer contained in a node, it currently
requires first removing the node with bpf_rbtree_remove and clearing the
NON_OWN_REF flag, then re-adding the node to the original rbtree with
bpf_rbtree_add after usage. This process significantly degrades rbtree
traversal performance. The patch enables accessing __kptr pointers with
the NON_OWN_REF flag set while holding the lock, eliminating the need
for this remove-read-readd sequence.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 05a6a6606b6c..bb3ff4bbb3a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9260,7 +9260,8 @@ static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE }
 static const struct bpf_reg_types kptr_xchg_dest_types = {
 	.types = {
 		PTR_TO_MAP_VALUE,
-		PTR_TO_BTF_ID | MEM_ALLOC
+		PTR_TO_BTF_ID | MEM_ALLOC,
+		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF
 	}
 };
 static const struct bpf_reg_types dynptr_types = {
@@ -9420,6 +9421,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	}
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
 		    meta->func_id != BPF_FUNC_kptr_xchg) {
 			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
-- 
2.50.1 (Apple Git-155)

