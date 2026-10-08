Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F5490BF4
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461327; cv=none; b=E2ubY4f5WBdRXuadlC/PT88nkp4sZp2JWQZIR4A/Lt6bnz8WgxZOBVyZ1ys+UXJDKiE+Lcv02YG51vljyJrTJbE4MLPNGcJT+ye6MARmt9AOvJ7QHTQYPtRjGocoSYbu1feSLs4SzFaiBJUKGNW6UzNHyBdn2HtibFeyTx7Xc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461327; c=relaxed/simple;
	bh=MC1xPeXIocoxdLPpnTecuPHGqi+akd7nd7GejQ0xcFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFixB6FK6qJmm/h8BMwpRghD/aM0bOONmEWZu4X7dY2w6p2QXtxpaguKXXmP//5QZIoIWYw7rXuxexIWEylMcaLi5pygJU0Iq8F+C6DinYLLWTyBXiMnKYQ9ZTUGlAqsBlQ8wLaQ8ZnANF5C6VhC/F6loJ9ZkMyzyI0kEQjOAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aC2H7g/D; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aC2H7g/D"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8657780E86;
	Thu, 08 Oct 2026 14:08:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GuCznqlho2Yg; Thu,  8 Oct 2026 14:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791461322; bh=MC1xPeXIocoxdLPpnTecuPHGqi+akd7nd7GejQ0xcFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aC2H7g/DKylQHB4jnRncCPM2zN7rp3RBr0a5cNgVfz09V6mRcd5a5lCA9VAOh2oAs
	 tlsvGEpe/ZmMr5cKGhNSSHjVKlnd1DMlFl95fspkGN5lHKXUrHSTyj1RY7jm7IVadj
	 hqfbm324VhsaxPqpcNyWQz1SnxvyjqQ7AKf/rNr+qeR72UkA/LRSw9Y0gUa7vHcbz1
	 len1wO0afPMNtcDVcfsWk8CU0wttTRJy29lHUZVFmSB54+qPWtNohaxDl16Fa3hSX1
	 kFTrqEsGxEL/BwBIn3mU+WNtP1ebEN3JUYjylGySSiSxepdv28mAhtJQt1qELKvdwL
	 z9z5F77+3aODw==
From: Masoud Aghasi <maghasi@disroot.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	john.fastabend@gmail.com,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH bpf v6 1/3] bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
Date: Thu,  8 Oct 2026 13:07:32 +0100
Message-ID: <20261008120734.1565972-2-maghasi@disroot.org>
In-Reply-To: <20261008120734.1565972-1-maghasi@disroot.org>
References: <20261008120734.1565972-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For BPF_MAP_TYPE_PERCPU_ARRAY map, bpf_percpu_array_update()
is not considering the possibility of a combination of
(BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect
in some cases.

For example, using the (BPF_F_ALL_CPUS | BPF_EXIST) flag combination
with bpf_map_update_elem() results in an incorrect EINVAL error
response, even though the flag combination is valid.

This patch fixes the bug by adding proper flag validations and checks.
Before this patch, bpf_percpu_array_update() rejected
BPF_F_ALL_CPUS | BPF_EXIST and BPF_F_ALL_CPUS | BPF_NOEXIST with
-EINVAL. Also the BPF_F_CPU | BPF_NOEXIST were accepted.
After the patch BPF_F_ALL_CPUS | BPF_EXIST is accepted and
BPF_F_ALL_CPUS | BPF_NOEXIST and BPF_F_CPU | BPF_NOEXIST
result in -EEXIST.

This patch also starts returning -EINVAL for (BPF_EXIST | BPF_NOEXIST),
with or without BPF_F_CPU, which was previously accepted.

Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")
Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 include/linux/bpf.h   | 3 +++
 kernel/bpf/arraymap.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4bae3796c42f..2efa8fdbb737 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4322,6 +4322,9 @@ static inline bool bpf_map_is_percpu_map(enum bpf_map_type map_type)
 	}
 }
 
+#define BPF_EXIST_FLAGS		(BPF_EXIST | BPF_NOEXIST)
+#define BPF_CPU_FLAGS		(BPF_F_CPU | BPF_F_ALL_CPUS)
+
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
 {
 	u32 cpu;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0fe9afd4a591..133f189bf6d2 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -438,15 +438,15 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	u32 size;
 	int cpu, off = 0;
 
-	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
-		/* unknown flags */
+	if (unlikely(((map_flags & BPF_EXIST_FLAGS) == BPF_EXIST_FLAGS) ||
+		     ((u32)map_flags & ~(BPF_EXIST_FLAGS | BPF_CPU_FLAGS))))
 		return -EINVAL;
 
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
 		return -E2BIG;
 
-	if (unlikely(map_flags == BPF_NOEXIST))
+	if (unlikely(map_flags & BPF_NOEXIST))
 		/* all elements already exist */
 		return -EEXIST;
 
-- 
2.47.3

