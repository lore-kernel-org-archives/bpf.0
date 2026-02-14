Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA317B506
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771043815; cv=none; b=RmmPvaCLPVwfQa2NPlQYsMYnypy2w5bcbyAEh5wkAP+M010+7XpQ4B6e506wr32gCqo4oB2jeTWEW3wek5UyQ/4S7U3rGf32BqDbOICqVNfczncROgl5uNNajyyyQdZXmOnQtH1F1fABVHCh99LEiQBO5gWKBG65KzFX/uUdt70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771043815; c=relaxed/simple;
	bh=aJnFa1Hsewgi8H7YxpRPpFYJuripGJ/a5ZfAUhM+lFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOOivpbqNFfeP7V3nj0p76eUX1V5kUzUfMuU0t9uE6dWk9XOFdzwGzBcF/qG1jOQlLNRdPxENFIoi7lynEH1OoH8FJjsBZunRTeg2E/TlSILtvci9IeDuF+LztdZU22OllV/7DeEutKghcNel4ez8i7Cx3jfIirju2nKayA0pXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giMlgTPQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giMlgTPQ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354a4ef0c1eso1073107a91.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 20:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771043814; x=1771648614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6tCm1dSlSN76Pq+BKvxzLO0K4J3qy/k2J9RReSkTgE=;
        b=giMlgTPQ6tF5SG6kv5BESCjypDlC8y+vMkAPyZdTOwkiR0dMB3Za16DVqlHARdjowR
         Ipa64ElCJR3ukNnzJND4K/ClnGXtH3HrG9kOCPzkWgxwfvkj8ns7zixUZI0vunM1NMNA
         VoGech0SplzdhIvEeJXbMYI/I5xWTinRFfN+U+N41vwYnq9I1WR/BH/jdjInmxAbTim3
         94biW4aXg2LLS6eS8fdyeDK/C05O3/fD++lhv0Ukpe99HWZwampUGuL7XAzeY37BQpcG
         IbZoGBdj02OKSP+Ffdgp5FBaN3q34UOhA+HIeu9DdRL4Ngl8Sp930xJcdU+BF/jZrqHB
         DYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043814; x=1771648614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6tCm1dSlSN76Pq+BKvxzLO0K4J3qy/k2J9RReSkTgE=;
        b=exDzv2/nFILBbvUCo+IT3GgmHLW1F6IMtAlzBRcCxuG0Ga1QG5Dka4Zz91cDCUU4j+
         fFaMUAlGhwuqp6+ARw/MZudK0b2/kz9UPYvQG1zAcog48IQeE34YEoJ3hUI4KJ/sEBLM
         +CdkZle0HwGeTaTaUENgvuUe0E03H4DhIfpE+3kD0uicnN9GrifbWcpGgcfrqu1KpS53
         bjs11tM/cji5jxW7PZZo6cWcQLH43C+QcxU5JHUY7pzfPGNZJ9kDCkICBTuR5n3Lm+ik
         aCoGx7TLAW967a5P/SFU3mY6qYsfJN7eNoJSH31emc66V1P9E5qyLvSm5aJrQskh2dPy
         kAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCViMWftyQHdptbkmvQCNiIRh9wiHJ+pAhVbnDIDsGtuHL9WhpR/+jiNhoaG2Um425BbD6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxigd37IDpeiAerqSwrKxCYIpW2KZA4uHu/1K3AM/1jXWOhi6/o
	AHQekJJ8kuiuZsD29rFuQxzf8Hdegg3RVMhoufN12sihUhpBUoIEC25G
X-Gm-Gg: AZuq6aLNhUJ94SvigVLPRXSM9D59SpIe5JAMn6WuF7iqDb9tAwwHf0MxThd0z/HOlym
	OKiNTImNdHzLtHCThUVIDW67IxRXA/fn9HNj49WZ3jzDOlww7SThQLRFVge9BTITEF+ek6yQxoA
	oUCsE8Gvyr0G0YMuVSLKwTwEXvMYM9SmkjuozV7N6dh9XBVqO2WR6f9MW1zUDkAWFzj7rSMeg94
	8xbpfSMs2QCMaq1bDtbrisFyrwYArN7jhpBqD8x9tbgFWzMxUL3qlZrb3cZoPVbIP/CVYBcyFSE
	yXV+42OouMiBs9N/3uC7TybsyTIDlJputvK7yqvrZHz/2OmEvKdUHzBx+DWNi0fAzHfYU+M/cP1
	hALFehZw/f0cthY3HGKqSHVRP7LvGg8x/fSJpFgfQTqUHZkY/g8ucvoVIqZPN4WCnxiTRe9laom
	Tog54CVXLEsJCm8nFdDcSQVFa4kkeXp6jySsKJSO2UM93j+sCnDpcx
X-Received: by 2002:a17:90b:35c6:b0:356:23be:7ecb with SMTP id 98e67ed59e1d1-356aabddce6mr4123718a91.12.1771043813796;
        Fri, 13 Feb 2026 20:36:53 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e53936sm13519815a91.1.2026.02.13.20.36.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Feb 2026 20:36:53 -0800 (PST)
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
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v7 2/5] bpf: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
Date: Sat, 14 Feb 2026 12:36:27 +0800
Message-ID: <20260214043630.38644-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214043630.38644-1-pilgrimtao@gmail.com>
References: <20260214043630.38644-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

When traversing an rbtree using bpf_rbtree_left/right, if bpf_kptr_xchg
is used to access the __kptr pointer contained in a node, it currently
requires first removing the node with bpf_rbtree_remove and clearing the
NON_OWN_REF flag, then re-adding the node to the original rbtree with
bpf_rbtree_add after usage. This process significantly degrades rbtree
traversal performance. The patch enables accessing __kptr pointers with
the NON_OWN_REF flag set while holding the lock, eliminating the need
for this remove-read-add sequence.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2927a4622ff8..3536a91ff8c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9329,7 +9329,8 @@ static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE }
 static const struct bpf_reg_types kptr_xchg_dest_types = {
 	.types = {
 		PTR_TO_MAP_VALUE,
-		PTR_TO_BTF_ID | MEM_ALLOC
+		PTR_TO_BTF_ID | MEM_ALLOC,
+		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
 	}
 };
 static const struct bpf_reg_types dynptr_types = {
@@ -9489,6 +9490,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	}
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
 		    meta->func_id != BPF_FUNC_kptr_xchg) {
 			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
-- 
2.50.1 (Apple Git-155)

