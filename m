Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40042A86
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885106; cv=none; b=H1nAr+For25khrZd3xLF6qHc7igOTUg+iZYu+cZufepEt4TTm74gVN3TL/9fxZJQXvys+/BjV8btgjqMV2Ns2GUC/DQWU0P/tlyCVpVfHmYcc9ezUI6FX5v2DghpWMw5TwYyLdydtimWGpOnnkfIA36xlmJKbX7Kxne4WcDPp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885106; c=relaxed/simple;
	bh=GYxXG+yHmvPcHYMds30AJq+DWMiRjuUdAyto+662a14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYaFBmKhcR4FD8afZUhRyT+RQy3s3F2o2KmM302y2mMw6doy9F9bBEtilEpShFlj3ocMpvksuw8F06VrklmgZjN2rRKWexMCr2pYgc/nu4140zIlz+mT5BMyUQ5gEUahRMMhHFOYlaYe/CesCDGky4G5rQ+jfphT5EnIFNFyLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnV9g/Gd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnV9g/Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB3AC433C7;
	Tue, 19 Mar 2024 21:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710885105;
	bh=GYxXG+yHmvPcHYMds30AJq+DWMiRjuUdAyto+662a14=;
	h=From:To:Cc:Subject:Date:From;
	b=BnV9g/GdrUfLFklOK3TPWxAsND+1adcaDXYxPouRv0WPyHwf5KFxTk0hBzaFd5x2Z
	 vON8Wq2x24DoJ4m2nPq5RLA67tKNtM34hhYqTXEFilyFX0Gfo5W6ykczDGIzN0zQtL
	 qGaIruVovtl6gMSinsyZKDM14tjYa9c8+YFjfTzHDF/ZiziypbvgoScoldlYF4n/WE
	 2I6anJj0WuL3oe64HLNt9J7QxGDAh5pCQ0eunT+eN+9zjmhYQSducCMlRCEeoQJrTZ
	 eU0PI73HxxJFq/wgD6phUnXuOIYJx6D3W7k78g593XWVQmJsOGt5thJ8BzkHpUZEfH
	 mDk/yvTN1LLaA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Ryan Eatmon <reatmon@ti.com>
Subject: [PATCH bpf] libbpf: fix u64-to-pointer cast on 32-bit arches
Date: Tue, 19 Mar 2024 14:51:43 -0700
Message-ID: <20240319215143.1279312-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's been reported that (void *)map->map_extra is causing compilation
warnings on 32-bit architectures. It's easy enough to fix this by
casting to long first.

Fixes: 79ff13e99169 ("libbpf: Add support for bpf_arena.")
Reported-by: Ryan Eatmon <reatmon@ti.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a756d61c120..37c27be2449c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5366,8 +5366,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 					goto err_out;
 			}
 			if (map->def.type == BPF_MAP_TYPE_ARENA) {
-				map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
-						   PROT_READ | PROT_WRITE,
+				map->mmaped = mmap((void *)(long)map->map_extra,
+						   bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
 						   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
 						   map->fd, 0);
 				if (map->mmaped == MAP_FAILED) {
-- 
2.43.0

