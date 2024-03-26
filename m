Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AF1133980
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440748; cv=none; b=ic+NtxLEFGHwgS/mIZAl8IWeo3hywBzqkb+ss1E/AXsdqDW4KSof8V/CgGj4eEtQHBuRY6KSD/LwLkvEhP0KOv8B5aE1KrQZjNRQ/Me1kXgzxXnQvd5YYyuVwrHJKXfE61HLmW0wtKKDdTHrAf52jT8Q6l/6XoosnB9pePBuw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440748; c=relaxed/simple;
	bh=lgJMr0YqY0zRK/JTqdBounRfSHXOu2VBoOM/18z1zj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sLi2+PSY5mVxlMHPvtMxAa7PPqdl5wPmQN5de+0F3Ler6DbJPDQPW7Z2g1UoMd7mvrqpBXu7mC39hjf4Bnn9VPqvrNHdMVunnixujryunvHTTQXjwIVZGDI3oiK4L7XqPFSIL15H53Lt29Mn8sWhw5tEO/G4WhYjaRgZunI4JqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enKn/8J6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enKn/8J6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0f3052145so2567605ad.2
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711440746; x=1712045546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2MuKLWtlklci7+tcbom4ug5qrUNhnb2kY1MAbzGiGc=;
        b=enKn/8J61/ooz30wRjN5xdUuZphmn8HNI31OLhx3vKo6hT3c5fmMxrz9p7nyStGZDO
         kH4EMU3tirY+K0JJ87zEdingbjLvrdchHM/TxpuphnCOIZkbVsb2gxW/hAQRuX5t5MRS
         VTK/BSY5KCdiNRozpRt4JAwjyAJSpEgofP2s3Yo1NHzjXtBIhAcGrUXinMIVKHwpWyf8
         cPoj6D0ZiW1MUHX8NXZGVF+tazHVnM9WO3W2PQS7S4n0QKBqAaOxX2c9Fsj3MMZwkba7
         CU6fK5Rq4ITO/bP+hj9ovc1z+UFq8K/MElilH2oNB9jWsD2YNQKO4M7Y8w5c7s50nmZZ
         sU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711440746; x=1712045546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2MuKLWtlklci7+tcbom4ug5qrUNhnb2kY1MAbzGiGc=;
        b=W5szthO6cVmSdWjchMtNsKu8mFV0w55lCs5XEYE1t5YDCZV+KYq3H2GvRDRoI6B8ch
         TI4vBU0GVvxRyEUQuCEmbUXGHSibgQYn2qvMGn9z3A6Z8B17SAuLhrVI2HZuJ+k1JBHJ
         Noa36RiGXry0rdyr61AcydbrfUFZOlpM4E4IDmVhwt3RaN+G7y44d19MZrfCN4Wjrmsd
         NyT4KFwZ73ptGofjxKDGryr2KpyznmND92wkqg/ctrDaapKWHCMm9Xjyb3PaszbRUstn
         TR50e6zacL+kx7xWHR9fftzDeAI7qeMYrLmbk9DefizKGWR06xtrwK5UgVqugFkcWT6N
         oxAQ==
X-Gm-Message-State: AOJu0YweGmYPStZ4z5U+9MVB1zAxihkhxuANYcTFZCoZhdxDfTula/E5
	0e9xJjJV0/hsWtTo0XaZQXwApn0K7yGHp5NIzvJ6P5mmkMj28/cO
X-Google-Smtp-Source: AGHT+IHN/rlX4+7e1mT8kgzRAqdUnvhbc3/G88MW1gBXxdz2Jl+DR6Zy52hGOskss8iBjaKDthI6VQ==
X-Received: by 2002:a17:902:cf04:b0:1de:f82b:4c53 with SMTP id i4-20020a170902cf0400b001def82b4c53mr434085plg.12.1711440746395;
        Tue, 26 Mar 2024 01:12:26 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.210])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090322c100b001e043df262dsm6139872plg.33.2024.03.26.01.12.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:12:25 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next] bpf: Mitigate latency spikes associated with freeing non-preallocated htab
Date: Tue, 26 Mar 2024 16:12:07 +0800
Message-Id: <20240326081207.73375-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the recent upgrade of one of our BPF programs, we encountered
significant latency spikes affecting other applications running on the same
host. After thorough investigation, we identified that these spikes were
primarily caused by the prolonged duration required to free a
non-preallocated htab with approximately 2 million keys.

Notably, our kernel configuration lacks the presence of CONFIG_PREEMPT. In
scenarios where kernel execution extends excessively, other threads might
be starved of CPU time, resulting in latency issues across the system. To
mitigate this, we've adopted a proactive approach by incorporating
cond_resched() calls within the kernel code. This ensures that during
lengthy kernel operations, the scheduler is invoked periodically to provide
opportunities for other threads to execute.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/hashtab.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3a088a5349bc..d3d5aad045cc 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1489,6 +1489,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
 			hlist_nulls_del_rcu(&l->hash_node);
 			htab_elem_free(htab, l);
+			cond_resched();
 		}
 	}
 	migrate_enable();
-- 
2.30.1 (Apple Git-130)

