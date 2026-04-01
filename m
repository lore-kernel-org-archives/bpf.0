Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AD265629
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071645; cv=none; b=cfjnEv+Rn/lxnep4ixohlQPfFD4l9ehB+tZpvPwh7r4CKrEYNGDPza6cFBLiAJSu9DplNrFAc03l5J+1p34o3EHL8kaVhceHMyEcw94Ci0G9lDNQq0gPkCr7/bKojQLttg+z7LxASfwGwbnY3KE0V0E3VSIjDTKHcETqwUU3t5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071645; c=relaxed/simple;
	bh=b5IdeE7kFc/miq7BppzwA/bkG03Djynjc2AeoAGB7IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cj2YvYPenZ+ng7VbuxVRlTvJ4di3ZOQRmTYPVIYq1LZ588u7q7h3+l1v/vnubNhHyaYW31BzP6xEOqUVLJe1KC4+kxrhpVHPouQOKsT+gxPvJ+wqO0hp2Rlg1G2WXBj/PTD7aoJdbmRzpqBXgLbzrRLrqI5R4v03secTNJAw+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFAGdrfz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFAGdrfz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d90833cacso35407a91.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775071644; x=1775676444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63iyAQmWNAhonz2iSCzY0EqYxTH5mX3G5BXUayBCveI=;
        b=YFAGdrfz33BtL34G2UDHN3/myb6isrpVmsdgYAx3k+GWVqZ1OBkHLKdOhTMh5UeIyq
         RVB4OQXFenA6edQud2JiEpVeyZC3Ab4AIjNU6bihix6PZIuJZHSuIFd78k1C4lEyl3Pc
         BwF1+/u6y/WhoTLdOlhM+sDTEWL01IUPyoog1iSVoYGkEaqH32hW6XSfa5y/e4+FZxSu
         EnG8cVv5C0En8cL5TQ+BNwPmFwVDvrGtBuIZxtBE1Qs4vSqSeLD1ZavGpH44LIFzPFbn
         UGAKmjYC6t1IykuI3RgC5vfJh0Dki8dj38VvHZhXN/tk+BWaeFPAe7XBRuymHQH1IDSB
         DOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775071644; x=1775676444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63iyAQmWNAhonz2iSCzY0EqYxTH5mX3G5BXUayBCveI=;
        b=Xsl42Z7r4yMUJaUo6vHhqhlfMxowf01IsUpCmjH7/F5L1/xZQxM7jJWW0PflaTmZBs
         +GmtCX1dxJd+rEsulUnes4dYQsSLZleyDf8+50oSE2xdyqw2fHh8H9mxXIvNw/yQJbK1
         Q363rFMYcRvaVAiNleDB03WaG6tEpJ8L5iePF24vZmOMBzOUdVgkdFmUGkUwgSXX/NLS
         63bl8I6G7D0Du9wNysTolBO5WsR7JOlHcjnA94vjciEZPWTj9TAvw9+Qo7fu3jq6SoPA
         ABcm8omvjqzc3v3t3BZBA8N0RvGle5rvqQoxtvVXge90KZ5BBPfR2jmfkim6JVOTCyB1
         HoPg==
X-Forwarded-Encrypted: i=1; AJvYcCUZHuStvUXmuadDT1//4iwFUSgxRhnXioQybovD86tdtTDlb6WLoai3lnxJPPUFu3KgdTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzslYKbYZjGgUdp9Caxf75HNyoUkkmFqIsSPgW6Qs+6V8K8LNHj
	4AYIB3DtpaP5qN0fAGxvlycbjTvuO6qnyeDu89yU2TlUIG4T2FNhwkxA
X-Gm-Gg: ATEYQzztOhm6g6oz8TT0MasLK3PC4b2pUtSVUH8J4oXx7PrbwwA660UlbTbFBglcJFV
	FQhSQZsWVq6UKCx8EiTfT4H2HNc8tnEfVd3+AELaZNc7dPm7OFW7o/AT/zppxgIZXslXVkfhwjy
	QaCerjXCveG3cJiccX7j25GvGabWrPBl0nH6v/gpCg1vz1edyUiQ9mB2mDBiZAmvavtMya0Y6ql
	GOIkkIUeyPMve1p6q4YL6Zt9vuT0x/VPHyHhJIXa4hW8AXz9lQ4h6LGWA23T62Xn2whYmnh8KNO
	H2zI5+fNtUVRB7rTUS5tfAKGjn9DNM4Fr0wg6NipRch5QyXZPJIlLSq3vt6I2iXKIHq+MDUwWkN
	rZz/OLDFDmAW0saLopaKb3qdi2MY3bSCjCH16Gj8auNunBJAzvJA72HabedLyoKGpzZV1XHMAyA
	CMldQx2dN6nHNgQ4pKznQEawO19hMpxeZMrS+E211nIEmQv0WpvYWYctp6ZsPiXgzrP+g58E5+R
	f6OcjGpxblM
X-Received: by 2002:a17:902:7c0c:b0:2b2:4697:78f6 with SMTP id d9443c01a7336-2b269ccf325mr35420715ad.37.1775071644085;
        Wed, 01 Apr 2026 12:27:24 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2745c480dsm7387015ad.0.2026.04.01.12.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:27:23 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf] bpf: fix end-of-list detection in cgroup_storage_get_next_key()
Date: Thu,  2 Apr 2026 03:26:16 +0800
Message-ID: <20260401192615.3548627-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

list_next_entry() never returns NULL -- when the current element is the
last entry it wraps to the list head via container_of(). The subsequent
NULL check is therefore dead code and get_next_key() never returns
-ENOENT for the last element, instead reading storage->key from a bogus
pointer that aliases internal map fields and copying the result to
userspace.

Replace it with list_entry_is_head() so the function correctly returns
-ENOENT when there are no more entries.

Fixes: de9cbbaadba5 ("bpf: introduce cgroup storage maps")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/bpf/local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 8fca0c64f7b1..23267213a17f 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -270,7 +270,7 @@ static int cgroup_storage_get_next_key(struct bpf_map *_map, void *key,
 			goto enoent;
 
 		storage = list_next_entry(storage, list_map);
-		if (!storage)
+		if (list_entry_is_head(storage, &map->list, list_map))
 			goto enoent;
 	} else {
 		storage = list_first_entry(&map->list,
-- 
2.43.0

