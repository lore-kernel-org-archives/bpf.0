Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22B265623
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338774; cv=none; b=sixY2xxikc8udcMVkkA9QyBAosveBC6TuTUCGIMwD4Z/EZAKI/tTbwcDF7Py8jykYcMzIm78t2xJyUNYEb8/3xMgDcmOdfa2Q1+CEgaMz5Zb6AvO+1c9Eo7EFDyDmOFsqHNTfBscsgK0PxDf8z7vZXYC9BvtdW2PFFulHT45qgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338774; c=relaxed/simple;
	bh=51regzvlTrVRH572VciJP3Jr6oOu0PTdqVUzOG+7Q04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmpY7Gjifs/qNZH2L3cFOFr9WILeuIKl9Vl85d582XP4f5afo41/Ch4n3vnXX29Uu+dM+u2cNpb7RzutbluMbiepiIHY25sm5d+0hmWNuPPSYTr+TidsOaGNrNHgPzDJjstfC3W6F+UHm8Ms6nguPhR0DwJ6FJYZxBFfXADEEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex99wPKg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex99wPKg"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82318702afbso3043722b3a.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338772; x=1771943572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PK3wDL94RvHZRaijVfhwQjim8sVJxa74bWIAAhmdngQ=;
        b=ex99wPKg+lacYDsbqnotYbdhN4dKn4VV6owBRBU8C/ftWz48u3R+0dMm5GOCbFgMDS
         Wh8HQrqDkXYrftzuKjPqcG3Ac2ZsTkeB6TAgZphCNBFcVaNmeEMbkA5KWzGcOj2ClICa
         OWQloX+gN2Qn1Z9LOSq1A0exgdbVA4KcJ1KWjcVgPwHrItugsc+8BlO+IBtB7xtQuIsr
         tHzkMmPe1mCgpzPz012mF2gAGA/InXEZ/xKfJzouyO49tCdCvSiY7jnjdk+kR8OB9v0Z
         cD47ufU4/7TOB+ojRl5M7E1CLe3p4u4i6HfCEx1iARCAkWf0y+byy8OeoRrHEhEPkNS6
         8pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338772; x=1771943572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK3wDL94RvHZRaijVfhwQjim8sVJxa74bWIAAhmdngQ=;
        b=lQkowfskkyzogbedVc5rQlBfslEz9PCVb4wV25XwabNacs3r9EzDOlogbBFbYS2QYN
         Fq/1vKnMgDmN9Oqg1cD427HGxMofiPfu8ZqBQ/uQJv3uSx4vqXfr0bw3LHIwf6j1QqBD
         TzW/gxI34GvCH3q/TjfktkB0fWilV0yEpVlpYk/Rs7zuhAMTfFDwyie9Njcxi1QCkk33
         WX5vdk53IWBk/pUJk7qx+DjmV1V2bljBXtNPZRnSoy6XoHCvZryO4jV4IWhSYAb0wxvG
         U3zXtxD9A9zaHWMCvou1DN7R+L/8nqYaZDf6dMY062So0mA4FDdNSH18AkJRwRj6nqLX
         iWQQ==
X-Gm-Message-State: AOJu0YyjL4pRDq9gqPKcoMvkdp+reZS50ipgvo0RVhpXiZHqZjac2pQy
	wMcpPHCj2ZipjqM311eJvd2TLcpnrjFFMIXcp9lV+8nlaL8R0tRjZYWFBzT76jGM
X-Gm-Gg: AZuq6aJHZKck56+9CKLpFP/1Qcu8nksb0uvgKAqcbng3TxxRVjGv217ZXpz3V5mrLqR
	hz2ctqE9+IqYxbtnGP5WEGycHCuBO08/MX+fRMY+FHK7SbxF+c5Nw16yG1uoo065MVkklFgMr+u
	3Ay7gdvejdhl+0o382IMDXLj+fTC5NJgpF2WW20L/26GntTaH1lztHE2mAqAH90MdP4r6wZfxvc
	52FRofJdf7ClOphYq6O8dFMyF8CmI1320vq4XFwxzygebnBIhoSG6spcSDbt/qZx6P3Rzhb36cz
	b68JjBvorn77rRzuAvYWGF8Ra1gxlYgFbG2Envzg582P/gxFx1ew5VqStkybYHoGc/11zyTxlQp
	4aSS3O4X29xgwE31/kQX0Pup7Ccl4adiZNE0OsykJ5jbVoeay1v9nrOmd92OIG1ZasRBGFX+sft
	otpSjJ3cP92ytBlXJrb0o28xEOmpeGkythsb5V77gv94i6zV8in/k6QmJQg5Tgbzohck3Bp9usU
	XEhaCnHA1ikzlVdh+/I
X-Received: by 2002:a05:6a00:3c90:b0:81f:2140:136d with SMTP id d2e1a72fcca58-824d951713emr10954343b3a.23.1771338772337;
        Tue, 17 Feb 2026 06:32:52 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b935c6sm14770821b3a.47.2026.02.17.06.32.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 06:32:51 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	sdf@fomichev.me,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH 0/2] xdp: propagate rx queue_index through xdp_frame
Date: Tue, 17 Feb 2026 20:02:40 +0530
Message-Id: <20260217143242.4404-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an XDP frame is redirected via cpumap or devmap, the original RX
queue index is lost. BPF programs running on the second-stage
(SEC("xdp/cpumap") or SEC("xdp/devmap")) always see ctx->rx_queue_index
as 0, and SKBs built from xdp_frame lack proper RX queue metadata.

This series adds a queue_index field to struct xdp_frame, populates it
during the xdp_buff to xdp_frame conversion (both normal and zero-copy
paths), and consumes it in cpumap and devmap when reconstructing
xdp_rxq_info. It also calls skb_record_rx_queue() in
__xdp_build_skb_from_frame(), resolving a documented gap.

Patch 1 adds the field and populates it in the conversion paths.
Patch 2 sets rxq.queue_index in cpumap and devmap, resolving a TODO
left since the original cpumap implementation.

struct xdp_frame grows by 4 bytes (40 -> 44 bytes), still within a
single 64-byte cacheline.

Anand Kumar Shaw (2):
  xdp: propagate queue_index through xdp_frame
  bpf: report queue_index to xdp_rxq_info in cpumap and devmap

 include/net/xdp.h   | 2 ++
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 1 +
 net/core/xdp.c      | 3 ++-
 4 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.5 (Apple Git-154)

