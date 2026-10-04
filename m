Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1573F1045
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112274; cv=none; b=N1NvDiaoYCbVRteyHAb/Rh4eDiM/BSMBwV5JCfgMBb1xMx1iRQgBBueDXnUcHUxwutBTb0Ge2ao6TEvnSHXdvmLwljqLO44OuVuZnwyGwoJJwI1PYKyC6eEO4+WAczxEWKaDeVDBjURrSFLsW6krcUvFohwWPfdiET0xOtqKM5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112274; c=relaxed/simple;
	bh=B++SXv2ASrVoSy+Rijjd+HXEmUD0SMOCvZ0yBLe3XHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI80VmV53mhQ32nTZrgUtnOPdbLYjSnVeSUYxo6l7PJIVmHFlMl6l8P+3o58EyMuVxgg+1IHozgtW6NXYfXa60QH7QbQ/AmFGl3lrOpepHzc8dm4dhnKEMYCH2GYv3bcdO6Hycfxm7VIUy5LL463gdfBE8j6Pb47TSQ8Hyf/ivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PCCb4cFB; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PCCb4cFB"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D009B82CC8;
	Sun, 04 Oct 2026 13:11:03 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtluSCMVkcdI; Sun,  4 Oct 2026 13:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791112263; bh=B++SXv2ASrVoSy+Rijjd+HXEmUD0SMOCvZ0yBLe3XHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCCb4cFBCaC9htrvkxs6yrylc71L0sRAJjXsbOy8+YlVjJvXcsJKiZ9crrtFDquNf
	 yM1L8sKWGns9DJwmRhNLPwzCv16n8xwScJY+zRqpYr4es/rnNvKxGCVzGha3wvHnNl
	 YJ+WSDkDwUS3NKEMidTni6FOcbm1mTqpLHGsxt6yqSmc03yHEJ8wn20hQbkzjiTMlh
	 +EeEqa+ncfTZxosZZzOr2H97ATEe4I0T2kFry6IMKdQFhv4c2xcGUCJDOdlbgh2jo9
	 yxYrG2Tyg4jwqIPpwI8CkRpMFHYbeo0gXnMtAJZYLHQyFPHzpSLRH7rW+rtvlS7Wtw
	 RbuXAdEvYgH5w==
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
Subject: [PATCH bpf v4 1/3] bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
Date: Sun,  4 Oct 2026 12:10:04 +0100
Message-ID: <20261004111007.3216186-2-maghasi@disroot.org>
In-Reply-To: <20261004111007.3216186-1-maghasi@disroot.org>
References: <20261004111007.3216186-1-maghasi@disroot.org>
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

