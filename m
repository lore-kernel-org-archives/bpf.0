Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD527A92E
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 03:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769915786; cv=none; b=LUNHcx/wvfNis3+5nFsKee90KU2ukKu5aRLHHO+CbRJc0w5zUwTQzPWng8sUT0rPE4VEMC04UNR1f5+zpV9TgPYMS7Tvi4ci8CJ8bIwpoCO8NjHZk66dDSYocl8hfXzdPCjrBN0csiPfMQXF7lk3cwUSWs62h/HD2f9KwqJxb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769915786; c=relaxed/simple;
	bh=sWh4qRJW5wuJPUJ9xDpga/kqSm/hNDUxwTBOVpO7yLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXwkUXUdcyTn1zrWtjWDbQ84nTkSrG8HYG4KHxdnYtcLzUNoWDgfakE/YUMfMKINRLPuvbOS0KWAax+JVs2GhMxxsL9uzWy6eEPTIDDUa8hnc3S21MTu0II12lEdC7cdlF5Mt8r0X9QeMk1m4p0gqxe5ytzwrnSNjZIM0tApnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7DkMk6E; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7DkMk6E"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823c56765fdso445716b3a.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 19:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769915785; x=1770520585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMhSx+6lEu+8jKPgVw5bypgKSiK+gEAAE/MS9cV7FQc=;
        b=N7DkMk6Ei4jyLUgmG6n4QOYCluCj0s+R/Nr2YWcnnY3vh1hxplcbdFbu9mVpYEZcpp
         0iXEh/pxQtbjuTbSGveiPAiDosmTnHPezV7NsCit9tXsdBGsQ24WYx+1PulETCJYA10q
         n3xUzzsUMaLzookq8VLiW6dOM7/+uMRINJ+Z08fSY7RTrt08Dw5p05PekVlszlVeI1Jn
         ifGYaKi/oh4x4iT3cRTZuxLFaVjkjUn+FV62khlbzf09d05hM0LGG36va2roehK62vkx
         y3VMSXwpdcRuxZFnsIzj/+vCcyCSeb6m02n+HUN+k5ryuefgniZxzwQOnioLG0M3k/Mk
         2pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769915785; x=1770520585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sMhSx+6lEu+8jKPgVw5bypgKSiK+gEAAE/MS9cV7FQc=;
        b=eU/ISpvphcjC3BzlUHduATiXzfE8OEzLAKXkI8C+QJMEHlE+7WGcPb8hWFwHyuIdyJ
         YNVpnD5IhuIqpmsRT+q7fF+nWemQIulPlfz+5ZglDYL2SA6+u+SyAS0cZ2Qrmeu3Brj5
         6Hh3P/xtdqYBXIKBJJyqa59583ji5dCaw1xCZZDdGILemkljL122oaE51t42Hx464xzP
         SanB5W6Y+dZNeKMu7TiwlGx2xi6QoOPZN3Q/QEF7qsXVNumBSX9CkNJab1Jd1weRvSnO
         5LTYmzEpYfYzqDxzLHgn5WjLYDrgSS7dKCXwnvgj4tNNWc6na4HqoIwGajxzHaYyuvg7
         7Cbw==
X-Forwarded-Encrypted: i=1; AJvYcCVqLc3V62+I1Uv0RFciJ9fDtTg1NH+w3lPQqiTSG/0nRVV77vxHo7BFe/d2RoKGjhVAlrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaic4jx6+pOd01frGMxYPlPmaF/4U/lWuJt52VKknJwYPv4oxD
	GBmwxNyNY2PC2bc9A30lMTOj6YO07trVKtCcu0nhBL1K+vtsuaKKTTgU
X-Gm-Gg: AZuq6aIdsiUFOR6RBNvRDcROIcQBUUJXro8equ9ullAR6Y4uaVcPFyhqHn5WokS1coi
	icjEZsoEDbBWnxDPdmGpy62BAkl5R990YO/KTJbNjPYgTFVJ/i38wIeiX9I0YEvDQeJn/Ca5Pj6
	+B8ocYfoCVZydIkJ1N3uuIo/Cms97pz/kCskPe84Fq2mALZbVKVrLhl663Y8wdHPRTp1VWCa+FN
	/2lSUL5tvHfNYhGfevJQ9MhYK9NoFS0w00nIXL2JPM84U2DmMUeZqmYOv0dZuNSdlecZewod1CL
	n7tatl6p/0peFv69gvg8ozF3xNGALe2yOZgG9qVM/nBmKhQ8UosFixkT9tDK3ZUvswyPS09RnsT
	CJIAU5gt+E1bu7/lBMQvdnsZZ9cwu9S5WozthM9NWDu6xkcNS+pxyovjq7PBAtA9POkrHN6CH52
	GO6eYnH1a9rlZ8v/goIxlxyGI9UrWbx4nQztFZhp7XQw==
X-Received: by 2002:a05:6a00:a21a:b0:821:85a4:3f75 with SMTP id d2e1a72fcca58-823aa67f131mr7379254b3a.12.1769915784990;
        Sat, 31 Jan 2026 19:16:24 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b2bdsm11810818b3a.30.2026.01.31.19.16.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 19:16:24 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
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
	yangfeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v2 2/3] bpf/verifier: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
Date: Sun,  1 Feb 2026 11:16:06 +0800
Message-ID: <20260201031607.32940-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260201031607.32940-1-pilgrimtao@gmail.com>
References: <20260201031607.32940-1-pilgrimtao@gmail.com>
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

