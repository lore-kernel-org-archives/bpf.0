Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311BB46A61E
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043423; cv=none; b=lQqN2G0onO4/KolKiC6zHybL8TSsAwwlJJxkp2bjE02WNCPkcBfgbohDzTYcYfLPWuTK8cU9OpAvsJ5BdfRr9USf4UzwMZLU8rpNjmlOnVgSiHMdqcMGb+vmcGjNOzQuc1Ovb7qyhCoqu5Q3aIID89ipZR1ogKtjK/rHeUnr8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043423; c=relaxed/simple;
	bh=seu82InOUaXJ3EXRPnx6IM8gwm0j2OYdEIiQXNTIJC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiwGZpyMudbUD0/1aT8+Zhvj0pDaDwg2Bq9HIMtnLZkm6VAV9pv0JiCrN3X94HpRzfPK6+3dQcSRlEt9zXHlBx9dk8Fs0M0RhQuxEv7X48zVyF4swpoklCSDjAt6a6hakiQeDeObgbS0WLu8oFhYOnAuHhvZfC7wmXaU74zy2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XLMfsy+v; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XLMfsy+v"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8E7E382D7C;
	Sat, 03 Oct 2026 18:03:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7OCRcc37YOU0; Sat,  3 Oct 2026 18:03:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791043416; bh=seu82InOUaXJ3EXRPnx6IM8gwm0j2OYdEIiQXNTIJC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XLMfsy+vPQIhL59l81Q4cYnimwbTWofJRzWuDH7wvZeGFP+WdT24DeZ6ISo29YEoN
	 o7Z+2KtYLIFsLlxEZ8D9ODoEsqHsqc/F2gxjHIvnUtWfdu8iZwRboi76tyfX6BWXmh
	 dPWfnIQd8NeZAHlkola4bdwlbvxp2hpgUKKCZtvpeMiY+jjb2zD6/E8xW4ITsgOnj+
	 Jc5wYwjlXSw8rBH5n66J6bK5oEEsyEIKrfEGDq96x+KneX4eAzHEjDOiA9mOJr7Ue3
	 yD9cGRjICPJnGT6agCGEW+Ad7+nz7nR3RihTnAHwoYHONgOhcvG47Nw/kIhmgMbSo9
	 Odc9QWZExf+PQ==
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
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH bpf v3 1/3] bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
Date: Sat,  3 Oct 2026 17:02:11 +0100
Message-ID: <20261003160213.2641506-2-maghasi@disroot.org>
In-Reply-To: <20261003160213.2641506-1-maghasi@disroot.org>
References: <20261003160213.2641506-1-maghasi@disroot.org>
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

Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")
Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 kernel/bpf/arraymap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0fe9afd4a591..4edfde6a624c 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -438,7 +438,8 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	u32 size;
 	int cpu, off = 0;
 
-	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
+	if (unlikely((map_flags & BPF_EXIST) && (map_flags & BPF_NOEXIST)) ||
+	    unlikely((u32)map_flags & ~(BPF_EXIST | BPF_NOEXIST | BPF_F_CPU | BPF_F_ALL_CPUS)))
 		/* unknown flags */
 		return -EINVAL;
 
@@ -446,7 +447,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 		/* all elements were pre-allocated, cannot insert a new one */
 		return -E2BIG;
 
-	if (unlikely(map_flags == BPF_NOEXIST))
+	if (unlikely(map_flags & BPF_NOEXIST))
 		/* all elements already exist */
 		return -EEXIST;
 
-- 
2.47.3

