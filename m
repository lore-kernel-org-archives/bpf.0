Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253C2C0F8C
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223046; cv=none; b=JSRgZ0l//18szI0md/a1VSsiuGqvGhX9nuBy4lpx2sMYiXFsJPNM8qzn0edhuFQDn8ucbcjjdl04kR00hUDVCZK/H937/2THt9x0JKu1EBdP5bhHjwPixTN+Txb1O5mS7cmeGJWvPgvTTDr14GZZD3/q3d64BoXi8xPff3xAb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223046; c=relaxed/simple;
	bh=XPW+jdegZbsSXUyY3E1GbCwVspcmnVrMIrTsdU2b2wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZsXO9O5mHB4NE13mJ/pzY4tmo1HWvPldGvClZZkgVO4XDP0te14eykP25T4/gD4T1Q1RYZNe5rg9GfBNYg0rHaF+ypcH+sL0ZCL+d2VpVkJhJtPjGollziQLdTdzRHlFYLDcLwkgxzS6YTeyh/8DrSK/JbTK05ZbOoqPhnDocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KarLpEEg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KarLpEEg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a871daa98fso14767355ad.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775223044; x=1775827844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R3hTq3fpNtsEePkbDShk8jy4QoFXIwKgMQ+uHYCy7E=;
        b=KarLpEEgBh9SlnBBPGuVxZeyqOiqIKmLg/bViBDi8nXleqe9qbt4Fvz7013EldTwxw
         2jusLSj21syX4gsHXK8F94ruwjGkhmtEkaS0vu2+CQNgGcXd2QXQCfZ53AtvYIsW4yaj
         BWINuABg1y5Oun8afz+8L+d0yIUBxplktUM8M1U4BHdYnwyCJ6Bsu73nO64tDZxcDYsC
         f+1WVaZrZC25qG5U/vAM+sSPrV4Ilbf+giHCJqqu98CHSZQWV4qGX/cEsp+q+oQL1qXB
         UbWc38TQtgsz2Olmok1hdn9H6E0NPmSFXNMa/G9pqRDImWUP8/IMtk1aBpaTFLymPwGB
         yjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775223044; x=1775827844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R3hTq3fpNtsEePkbDShk8jy4QoFXIwKgMQ+uHYCy7E=;
        b=jifNfke+ueIZFpoVLU+I2FCfBSVgqxm7qY2LtVCeNS983Byy1GHZRlYDEZN5XthSgb
         dXRr1e8++QeBFI3hpnvo0c6/z7bKZzhY/MesVE9E3cWM/UhwSFgCgHttw70QvD6OGQOx
         qHY1oCkAS0trkONIVdwEYnTuc1kKI9JGOmQgE4hJzS/r4iMDGC4qrhPqaBDdld8m81Zd
         BZsjhvDhPsDvZ0VtSreLRQzi60Ov7Wf1O53nlQiBkuOjZo9BWuvcPakfghZuSUi9VSX4
         asQ3dKg6B6TLxLWJIkTcjndJENpsqKYuvszQhf55ZLUkNYoSp2Lu+JxO5SYSMiELgpED
         Kl3w==
X-Forwarded-Encrypted: i=1; AJvYcCXd6mkAckRrfYgQYiGBxMMtGQ1eHyOhG8FL5g0+P2fGGw903UWXjILPK5+ssdFaaJO/qoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hNJA9BZeCxzkgSH9kTsQhxhV7KhdrlRjpSEPvYHr99FGcCoo
	4rM9SLm06MZJVUyNvZLkxEZ9OJomMmuqkF7RSJh+o3P2SxeEOLhZDLlm
X-Gm-Gg: AeBDiet5o/mUA7YYBJaD2GKk55cW+9xAoPy8ck7qS6MD8YKz0tscH8ZDaxDsdZk7hpx
	/uWuDVfV2zi9YfzMjnYb6MHqvfTR42eDpqLr506UdpYOpovW7qsfPnyhWuk9yWOtLhCRfA2dvuc
	dehL0J9+TkpUEuzTQO1zaqzDj8b6oPLY+1HOZc+KkJg5i6q1+q02ZsmIWziMOSujA5XZTB5u3hN
	CdnaPUJjvheX3XvFlGzF6Jf01+i0/OTaQcviioetIa5nahLYXURjYBI1JyaO4ZDbXjHJmMfORDr
	DDkZ4BpJhw1IQthK0Ip5/0SZRkAOYqq+OTGyDQHs214qPvqUGkO+/IxztU612RrRh4DOk38UU3p
	YvY1oByBucn77O1pOh6H37YBMXXMu8OJGlMvmA+xDhHy3gQkFLQYoAn3EEr58s1aW1U043y8x3x
	GLQMBLCWqFhIHJq8pnIL6WPye/6NKbW5eOI/ukPB3dT+rI+SD3poCMTd5O0ZRZ4J6jvjwo1m3zL
	5vYVvmEm0qU
X-Received: by 2002:a17:902:c942:b0:2b2:42da:25cd with SMTP id d9443c01a7336-2b281889bbfmr36878255ad.45.1775223044279;
        Fri, 03 Apr 2026 06:30:44 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm64221225ad.55.2026.04.03.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:30:43 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: fix end-of-list detection in cgroup_storage_get_next_key()
Date: Fri,  3 Apr 2026 21:29:50 +0800
Message-ID: <20260403132951.43533-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403132951.43533-1-bestswngs@gmail.com>
References: <20260403132951.43533-1-bestswngs@gmail.com>
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
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 8fca0c64f7b1c..23267213a17fb 100644
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

