Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BBE3F9F39
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057419; cv=none; b=UwER8ntIzATfE6UvGO2EbBxDR3hBMB+Sry1+LUPO4Wgj3PGsusZU5z+v/INVNZHwq6/8GJfubZKKBKDY2LwDnInZvLp/us8PJNVtGyCPhAwgBtGJLd/pWnsCzC6y0QyNOQerXFtPNvsXqz74N96mUZnrb0V7KsbBNgcFJtub8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057419; c=relaxed/simple;
	bh=TbKzAKxcSUe8NnXwGkLYa8oxQYUI5of8nFXqsMfDQOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZxx1mnbL2BFJb6qYj0I+pxsB/t1qaRmDd4cANOM7SJ5UPtQesT9x+fEXa/L8Kc7U0XybTdyaKyNNLy1zZDJugLeKYh0DQmli3uKdvc7F+GYE1hEFSapRjRElaud+C2TesQ6vXZJc57N96ZvSa4BaWoSSAD5qMm1bEKx/N04q4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heWT7L4n; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heWT7L4n"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso6780317eec.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777057415; x=1777662215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKQY+wUxFz1qr4YidrTiuAid6P1a4VOteLmmLttjMCE=;
        b=heWT7L4np98DsMm2AwEVnWGGx7x9Zcu/OF6N6cpVuwicgybUx1SyPKt+gGWKjDI9SF
         ajSQxmjdD3Zt3rQQBC+w1PZLfkLEotDy7zpAijxI7o5/LzHF0Zk6Zn/ZbWJ32/nNE6GS
         ZmnFCYEJoKcj1FD+/KT16SRr7cWgmLIFuOvYXRxkO9gbd1KBIS0N7Fccr5daiMx6x++8
         Sw1hL1Iy3yJrURBD5PQzZTixHwB99F+TvS4xWtAaXi+QlykEdy9IQmuD7bSxaWrDvblk
         7ulZBlRcp791JzdFepkJYy7IKqUVKanx76JleCzSb/n4P6hn/TEQxGNAPYh+/xr0HlWk
         lrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777057415; x=1777662215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKQY+wUxFz1qr4YidrTiuAid6P1a4VOteLmmLttjMCE=;
        b=QEduOgvQ2D7NKtgJQVuosWFHN/Di4ML/3Q7gAB4fbMxx4ACuMJ/i+BvJzWmpuhjOLU
         hdKYalhg4z5QJnZehW274zI6rZ0CucbHwB+a879BKrhhNmjqWz383Y3w07fegvlk9XlQ
         93TSJdkTk7K5QUra+7BiN4EIN7PJDgHNHOdIauKCHws7sCWkctRW6RrstkVtUKhXFE2H
         DAhVMXFN85Un06OotkC5NHiV2dDbkg2kfi9r9EQtO7N6QrgcLKzk95bZpjgcK7CdhOth
         z0VGN0xp1PFbsaAmHe4eujk2CJtwivX+R8w29oduCAZYKsyMmONAjufvF1W0raqHxKZs
         5hPw==
X-Forwarded-Encrypted: i=1; AFNElJ/VzTd33WZH9E2f924afVfMk03VukKrC9iBVa5T2bUfJ0f6BUGbKQLJphMpfVCb3RSbMPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlNsuVvjFU3XW8UmnShj9jWKMJ5ArdpEg6Ff6ycfRVlDQbd3kN
	SkcPkMyyfxjV/GdMXVfNvNwc+WhQONV2GzcH6KwNRPzwW8YdIhQ5dbY2
X-Gm-Gg: AeBDieu/gdlUGnwxMg4nK4VddMB5e4VtntuE5NPeQq3Zd+VjTuHSafgUR4nOx9yWA2K
	0RerNRXpUaiUNPCROD8lGVcx7gyVXILKdbdrN9Pn0ALP3DXqRRq+baXCOUKxMV2nRnmgRwdqC93
	qOa3NdwhIyU1zbFhxvEYa203dv/iCTZFVZdbGBmvmp9W/bZu+XHCS6sSJYetlQTCqyQkrlL1sGL
	uHJPTpQa+WZAOrk+kPLZxas5Z+5aSfVvl9Z2bmTCsyOzpKKbBwxddi/EFruwgb9l0yiaoQo6Gxy
	4nmRkXhN9FI99nrZPcMJY7CiU4SHwFcw01YRgTadKs5gNWt6VnZTnzdyB7JT780KeNA2ZUb0RCi
	/I1TsgJr2riSPOswwN2Y433Qfr6RvXko9StfbfsdsVescctCGA3fcRz1mvAg3/6BEdE09LL9HFA
	cjsC4t9fMeMRL96OmFADh37vtIyisekv7IW7H08nvWQghZcBZCU/NXdIVp4jxUGsGmLsVlm7eqe
	n1VO1JI38I+8kWKICMH
X-Received: by 2002:a05:7301:3d19:b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2e41a1e3fb6mr13143549eec.0.1777057415164;
        Fri, 24 Apr 2026 12:03:35 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a7ff1sm33082081eec.9.2026.04.24.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:03:34 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Xinyu Ma <mmmxny@gmail.com>
Subject: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data
Date: Fri, 24 Apr 2026 12:03:11 -0700
Message-ID: <20260424190310.1520555-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_msg_push_data() allocates pages via alloc_pages() without
__GFP_ZERO. In the non-copy path, the entire page of uninitialized
heap content is added directly to the sk_msg scatterlist, which is
then transmitted over TCP to userspace via tcp_bpf_push(). In the
copy path, a gap of len bytes between the front and back memcpy
regions is similarly left uninitialized.

This leads to a kernel heap information leak: stale page content
including kernel pointers from the direct-map and vmemmap regions
is transmitted to userspace, which can be used to defeat KASLR.

Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
page is always zeroed before it enters the scatterlist.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Tested-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Xinyu Ma <mmmxny@gmail.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index bc96c18df4e0..ea02239892fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2820,7 +2820,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (!space || (space == 1 && start != offset))
 		copy = msg->sg.data[i].length;
 
-	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
+	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
 			   get_order(copy + len));
 	if (unlikely(!page))
 		return -ENOMEM;
-- 
2.43.0

