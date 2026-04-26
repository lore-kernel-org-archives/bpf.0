Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41AC15B998
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777217300; cv=none; b=CBipbnthTbvlIg71fq9cwIR2eNqK1fo5RUyjROeOrj0ksWv0DJSa5N8CTHBMdEKbmAAdk3b6ILf/tLynhkdcB89HgN72RWdMFPprpk6ggmIknLI21qp4MjuTrWQ9o3Cl+94nyPtAO56RR2vK7iQZQyZaqD3+ZQVqMey/mUOpBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777217300; c=relaxed/simple;
	bh=A8vXdI2Upm9V9ML8CX/Bg99AFMK81d2W9vmRIXl9HMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlmLCwCP0na60zA4tRanRASFjoq2e6zqJAPCNuFhETlpEp3mbH8ucwJcCV/R0loR8GjvPQxzIqeOms/Jucv8RQwFxVj4gdvfKmsLfl6Y46HVdifx4V6QhyQyCdrULNk+K2uLes+HJuqevIyo+BTMVCQy5bjsL3QNR/j94BMsLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFKB0x86; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFKB0x86"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so4285180b3a.0
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777217299; x=1777822099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wA1Xx3qksBxo7ueLQH/Gb7GNuuDUoxQZdXt216j2Ys=;
        b=JFKB0x86NzFDRlu0pU1b4e8b1WiWMgzvZatbu3UPyOj1tdYpHBNomd3IFBH6RzzdiL
         6F1c+pbIcA3YmBQHWO4ZDrVHVyd0c30kDmhwuxzgXKB96G/BPWJo2uVZ6qB4V9BsDG98
         /N7KNH8yvopVIUXnCeHovuvDrfCit6UbpohHRpSx8WfWEUiE/MT3X3bEWfkvW9ALdHWg
         pKapazwQs7N7+QuWjjuNRBJrxM2fk2i9zYewLLrxaLs3IVWpG7goRnTTzRIzvEfdrnMD
         ocGGs4Hv8ov+iP11BgzBrzKROBMvA58q9+wnbXcKzy9I1F4fNAWkHRYzq05q1YDyn7dS
         He2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777217299; x=1777822099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wA1Xx3qksBxo7ueLQH/Gb7GNuuDUoxQZdXt216j2Ys=;
        b=I84o/LlQbGg/7mA7Uk3DYG2vTjVdRi6g0qc085IjwCy3krtVBfkupeRwOVFiglZcjt
         LfbmVOso+onWvgzrMxrKwcUia3u+Ciqy51klGkHcxO9yZ5pSLglDt0YKsyFlBb5aJDxn
         51xRMBzd4DQFcVjMT5SWGzGqz58d7QkPo/PMryzHFe24cXlpCsEdMQKwYBbWcU80Z8TB
         f5DiKon7jPnu9R0yZU0BKV5E70TyP6bwgDM5VyH1RXx/llBrFiq9MCRNhS+7LUZvKK5A
         vi7Z95vWM5dbX4eRh0s3jGZJYj3o6oEM2jDjijh7QPDdm78QcBdLAY1stAgZz/w2ftJA
         bWZA==
X-Forwarded-Encrypted: i=1; AFNElJ+iV9ChcICbM9dtTV59StkMwr9UqzaQbxZfuKvISExQ+Vy25ZRbvpIBMBvxUhzLErGsEFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCV7YMX4Cfs5j+DWQGrFM2d7pq+Qmaho96zFNvBwDXRXQ+f70
	C1H3zLBkdpodf3dF90q98+yU+FDDysxyXKWzt7phpBRd5bPw784mloE/
X-Gm-Gg: AeBDies/sARBaVaz6UyFIsIODIzf8DsSl+XEtgeb2816KF+7TtQ8/asUtIP7BPAwr1x
	jv+zbzv0VIojulKnxZzXwgXmatOx7gaJEZXQMANDJ1cmM5sqtX1JRxxAoSHxz6u/L6QJxvh7BIa
	cmzbU8U9zmxJU+NF+fD7NCDxs5wa0W3A8uD6o1roCS7QD9shsc+6mZtZOa0W9Tonp8jtBkb/Fxh
	nmq853HlQh5iPY6CoE+LmPrzG4djSBN08xbDIxcordQGutjSi+p8ioHQGCIzeeK9A0xZsyu0SiA
	1dj+OzRQWpzxx7/z47mzJvf/Q1K+qdkERErrdU6twdb+DI6GMM/vwTEaq2pz51Aji72Q+X1vsVv
	Oqvm2v1lbdto0ILf+G8dLHXoUpQyfuHY8hTcYyEc9GNrHLMzbzK8oLZimEIaFswb9htN8bQQKA1
	cdIioOWKjLO1xnf96a0Vc3K0BBAIohO/9h/m5CmFDlneUYOQTQRjO+pK4=
X-Received: by 2002:a05:6a00:179b:b0:829:809e:8977 with SMTP id d2e1a72fcca58-82f8c99883fmr41384675b3a.49.1777217299140;
        Sun, 26 Apr 2026 08:28:19 -0700 (PDT)
Received: from localhost.localdomain ([121.169.163.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm30155686b3a.15.2026.04.26.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 08:28:18 -0700 (PDT)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greg@kroah.com,
	security@kernel.org,
	Junyoung Jang <graypanda.inzag@gmail.com>
Subject: [PATCH bpf] bpf: Fix off-by-one boundary validation in arena direct-value access
Date: Mon, 27 Apr 2026 00:27:59 +0900
Message-ID: <20260426152759.1932675-1-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026042614-scowling-hankie-f84b@gregkh>
References: <2026042614-scowling-hankie-f84b@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_MAP_TYPE_ARENA accepts BPF_PSEUDO_MAP_VALUE offsets at exactly
the end of the arena mapping (off == arena_size). The boundary check
in arena_map_direct_value_addr() uses `>` instead of `>=`, which
incorrectly allows a one-past-end pointer to be accepted.

Change the condition to `>=` to correctly reject offsets that fall
outside the valid arena user_vm range.

Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
 kernel/bpf/arena.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 802656c6fd3c..49a8f7b1beef 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -511,7 +511,7 @@ static int arena_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
-	if ((u64)off > arena->user_vm_end - arena->user_vm_start)
+	if ((u64)off >= arena->user_vm_end - arena->user_vm_start)
 		return -ERANGE;
 	*imm = (unsigned long)arena->user_vm_start;
 	return 0;
-- 
2.43.0

