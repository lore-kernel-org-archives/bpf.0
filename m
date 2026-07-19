Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A683B27D5
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484043; cv=none; b=WM1+OPkFK40Qs1v723/LGE219CjRV0vrVi8v5qWJBW1rXBzEINw65qKl54fKKuXR9oUUX8SPaiVui7Ruvp8NcKtwBNozcvMW7uDsf6zXbrt7LB8A0JAEV5GoHGa1N+xdGm7l9ofQk42RkNFXWOKlaUXO2udVlyvSCrdQE1qc+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484043; c=relaxed/simple;
	bh=3ZUCrrDmOM7VZSnp6sdBGE5jCnwQNOc5dOPQ5kzHMhY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYdOZf8LlKbt/KAe9HsPZVdC6T5AwyLRofFbpmyrpqanKfKnhqYYN3uFL3WGspyTKn5EY9q3as8dm1H9rOhZC8Pct35TGlpeBiZmF6u5fo1o/ekM3x6jBTLmHe45g7wpO+jK5Ke1N0rvt1WzagkYOBbD2XbOonAo3zYdDqWlAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExhUftIV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExhUftIV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caf228a910so73166465ad.2
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484037; x=1785088837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gQVLUSh0YdJH3i5yQlMay6TXyEhugldDrvm9uMupsBE=;
        b=ExhUftIVu07CRaWkA9btZNonG/ISkzf7n8v+5OSZpmTtSD+vyFNTnHW5vo2MxaRJ2Y
         2NFSCdUYT4ZCtPWwf2RYXdU+9Jc5QVP6RyonM+yB72H9vEeeFHKExnMphZBd6YFlzDwj
         CbASnd+Y0hvBf6wh+bebN+yIauWXQfo/ayG2+LYL2PhyWfH37vvxQ9ecEa/A6JUhX5/u
         n1+V6Ecc3I67uEAIVYJfhYBkHf736a82LAX7Og+YiwQd1bKONylK9q1J+FU/tkZJ0lI2
         jh0qzZ6ZPvCCPZjaWibdfFjz0Npu+Q5WrPhDnVu50XsQe6Nj4QaAwWsZGbY6PhcyCFym
         l0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484037; x=1785088837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gQVLUSh0YdJH3i5yQlMay6TXyEhugldDrvm9uMupsBE=;
        b=C+WjyPo7JJM6qZFt8OYDQMGV5LtnuTnHMy3pIXNU1AKygjg+xxr7Kw12Sczrm+06X0
         Ug55OaHqEwkla8mwaTa5N9719BwWHJYKR4JuSwXv4d0LtLNas3qQlhHR8Kw57o6g5j5y
         2MUmuZqsVlW3LxyG6kH06dmhnoO/7ssa1LDxgFFx4cddBkCVw2XOZtOF0FkfR5n4a8+x
         4eaQ5GL3+kIbPxbXyxvLJa9Twg2s7Y3kd7iXoYqKaM+ZUxYOzIhHMgsx8H0hGzJx/IGy
         AwKHHprUn4gZHgUTQ+l3n3eeRaYk6V4ZPUaYvClYzGUIS+qEXnFuVXNkY5ZS19qBs2v/
         ivYw==
X-Forwarded-Encrypted: i=1; AHgh+RoFWSMuu90RhLUglGN2oEIKeGLmphhwrJ/abfQIGUfaUwVphbsHCEQRF2/uhKcFHeBnFnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTFxIhGchBdL8xO9v3E+38Ks2IBn9Vss3+uDk7NknsDzDi4NG
	Qnn7dJ3CKiALBxGSk4FQQ0ADRaX3Ca0soUuUzBglQ0/NOeKFYwNiyC51
X-Gm-Gg: AfdE7cnnrGMo4DLfNTjDA8H7fG9O4gmdFNIbXD4Saj9wOCtsIvwyz/4av2ABz5s23f7
	vRlTFasI3q6ZEqdWG1NQwAXyT+Xt2HW2JYN0/cxGClsxG4QRiue/QJ++e6PGoHbyoElvOKlf5DA
	O6KfjDUdDsVuOXn5Oh4AhTqIMPmMQ7fg6MMyFo1gyWY7rm5RDB8b9o6mlMBLmkeIehzTVOc1PLl
	QSFnJwj/q0viiwx+d/E49KnSUe6+gU6q2zkKlUAGz0dBXywQiixKQHg3CXZ3bo89ZUBbA92l2tc
	KeUS+uavdAwutiv2ghzoOPZJwmori1xxkJbcwnSOXd/FP5DF+Iqus2UJKLZ69qjhE3Yr0t1RD4E
	VlpRrQ+t6rmu6gYcqqXQFd1a86KegH63w/ROJReLigMhyBP0xa8jQhwY4k/Y3V9F7jw==
X-Received: by 2002:a17:902:fc44:b0:2cc:b480:28ba with SMTP id d9443c01a7336-2cf34a25ab6mr120497085ad.44.1784484037543;
        Sun, 19 Jul 2026 11:00:37 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34769bd6sm43511065ad.74.2026.07.19.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:00:36 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Alexei Starovoitov <ast@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	bpf@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Hoyeon Lee <hoyeon.rhee@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Nathan Chancellor <nathan@kernel.org>,
	netdev@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Simon Horman <horms@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [RFC PATCH net-next 05/13] bpf: offload: allow PERCPU_ARRAY maps for offloaded programs
Date: Sun, 19 Jul 2026 17:58:49 +0000
Message-ID: <20260719175857.4071636-6-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719175857.4071636-1-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The knod BPF offload keeps hot per-CPU statistics in a PERCPU_ARRAY
map that is mirrored into accelerator memory and aggregated back on the
host.  Permit this map type on the offload path.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
(cherry picked from commit c447c9012940d48c1ec20a8ebac8d779e7d5a6fa)
---
 kernel/bpf/offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f5569588c..36e747a12cbe 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -510,7 +510,8 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 	if (!capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 	if (attr->map_type != BPF_MAP_TYPE_ARRAY &&
-	    attr->map_type != BPF_MAP_TYPE_HASH)
+	    attr->map_type != BPF_MAP_TYPE_HASH &&
+	    attr->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
 		return ERR_PTR(-EINVAL);
 
 	offmap = bpf_map_area_alloc(sizeof(*offmap), NUMA_NO_NODE);
-- 
2.43.0

