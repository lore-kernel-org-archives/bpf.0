Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594DD392814
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822055; cv=none; b=V++HoMKAx3/6iqy8JKOmun5dW5Y97GAcBI8eQhpN1c2+i6hVk6+ULoc20QvvvJfFDGBqWmxyJpavkvCZrOz6LqwLG1u7z/S1qZI4zp5D5KMVQMMdAcbpyXlfrgwELG5hIwnVXtED1ChDb+n+gC3WcczV0kdu6R6ybD9rd224s9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822055; c=relaxed/simple;
	bh=+iFlrJXpKZea2WpVSqgTdGJ9PXsZFLdRtx/hAx9zsIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrOrRnBSbKlaVgXMADSbxug2eNerW/Jj2Te1/J2l/ykGVojgjHoZXhn1CtiPBcjAAmt2fMJg3XayEDp4nW1hWPLsJ4R0f7NgdQUEeQRF/FZdex/C3Hh5xxyrlGojQ4A/lbFGA9DLMyTRN55YiNw5RknyzAY1fD3nD192M1HsYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vouc4WK6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vouc4WK6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso4486974b3a.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 22:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822052; x=1786426852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQ6IM8oB7QK336HOBIobZgU5qGVsb0MhAguyi+0VAXU=;
        b=Vouc4WK6vmg02d/Oh6dHRdRA0g6DAHggtYMr1U7g2gDvo9/ro5MNv9C3OU3r/WyPMo
         3NJ2Kc1Wg8UQA0PVUoD1FGnuhXro+WXCxt1eicXbK7VwngQv8FwlX8PV5fEWNgBCqmJY
         PBuh5D94aAmEyuEHkd0an4mEFib5HVN4pesSnI1UMb26J/MT1CzZ0IDBBbrQN+UFWqh1
         7z4NEU2fr50Ix6GDVxxvIVuC638dz9E7kmv4xmfuQBtdgJz16FyOGtl1ZeoNNFyZhxnT
         uW3kv2Rvcq8bGibX1JgADOG5Xy68/pjqsfrVQYXdDdj47Wo60OFP/zfXQEmwVnzQgJQZ
         dF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822052; x=1786426852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQ6IM8oB7QK336HOBIobZgU5qGVsb0MhAguyi+0VAXU=;
        b=BClUtJLQHpw/Mra3gBrvcL4M6YgUEreAzSH30B6+fh7lTIHUF6V+A6wPQiTxQsGygh
         OqK7fk1cUwyaCxusawynk5kDWIXWDT/U1nbzeVaC19CfY6akpYd1iuMehVL+Ro975p1/
         36JeG37v/0MH11h/IFKzsKa66DiAYFL/x21gSkXndXaPjEML8UGrpwyMliEGSvkxV6uF
         ZruoTJp0YuGQtzleynBFpltLyuRNSjI9PEnL1sxpUOTT4v4urKjJ2cMZvJzkHYtldwIa
         bnOY+06UyKwnBH4HQ+8QjX/giomhCw9UH2lXRFo0pfaEe+Q/9syEW+MfpA77kEwnuU7I
         KHQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNfWrsExFlW/M0LI2PrZBmoHcMKkwHtJme7QIj9nPJRVc7D1i6WPI0Lq++GV2g/7/MVIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvf1RASffuIq3/BPK9DoDo8LBobQ2cCE5iLcEzZAxAkYhfPJPW
	vxbQR2Nsm9E0O9L8GHynVH8zB9ACBn6qhMotT+tL6oAYxzU65RqpNbBW
X-Gm-Gg: AR+sD12tWi7yenT9ZmwWxOpZAsedHH2yM+NgrrCfVfWgerPYMgF8UyYTpHlCcxXR6pL
	pbmprlHe9ojO7dzJ5j6eaLWzqYvXIVAyJhmkDDDsR8UDzrJSuWUOPynNNJkAaJMPQxlwdc/U1xq
	uLxK6m1TFgJHDVMDvySdb06maSIPJMG+TnXY9wK5gyJd1D8NJr7yv0XQxWOqYF39xtDuZ0kai+P
	SzKNZxj+rgtJ3TGKHJ3GToSnIHd02idZNij7f338lLm9kxj2Q/gpfEGdWYfQS3aC2/hQ7W2Xo/S
	ozhvn07LUDA2IXErVgqLTgInSLDK0fKQY2LckgvtRrpLJnVBbla+V9bdGjrS4P5zd6puNRqyo8i
	GNjMTqMr4vIs7a0Ks3ZWIKACH55t1ISQtz65dqCAkgVm/RWMaN735sg67LJQtkQNKSg38MKmArd
	3kn50QeqL4ZNvFkxpoxzLIx9tlG9oAPd8q3Jc8v2SfZSOkWXU4SauMhFVLE1wtLW1mzrGskrC99
	gfYkiPRHrJino6HzYnuloXSg7KDKjTRwjh9XfUSROVjgsoeTBpJQ6JScU9YsPRjd0lHdqNXzUiz
	SIwCWw6zxy1qkg==
X-Received: by 2002:a05:6a00:2343:b0:848:7e85:f208 with SMTP id d2e1a72fcca58-84ee4954d26mr11791266b3a.37.1785822051598;
        Mon, 03 Aug 2026 22:40:51 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([60.168.97.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe5702bsm4678737b3a.16.2026.08.03.22.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:40:51 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net v3 0/2] fix skb length accounting after XDP frag adjustment
Date: Mon,  3 Aug 2026 22:40:37 -0700
Message-ID: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes skb length accounting after an XDP program adjusts its
fragment area, in both the generic XDP path (net/core/dev.c) and the veth
native path (drivers/net/veth.c). When the fragment area is resized,
skb->len and skb->data_len can go out of sync, and in the reproduced UDP
receive path this leaked skb_shared_info contents (including a kernel
pointer) to userspace while truncating real payload.

v2:
https://lore.kernel.org/bpf/20260731032357.6114-1-sun.jian.kdev@gmail.com/

v1:
https://lore.kernel.org/bpf/20260727032535.13469-1-sun.jian.kdev@gmail.com/

Changes since v2:
- 2/2: replace __skb_put() with skb_set_tail_pointer() and explicit
  skb->len accounting. As Mohsin pointed out, bpf_xdp_pull_data() can
  advance data_end while leaving frags present; __skb_put() would then
  hit SKB_LINEAR_ASSERT() on a still-nonlinear skb. Following Lorenzo's
  suggestion, use the same approach as bpf_prog_run_generic_xdp():
  skb_set_tail_pointer() carries no linearity requirement. The v2
  comment claiming a changed data_end implies no remaining frags was
  incorrect and has been dropped.
- 1/2: add Mohsin Bashir's Reviewed-by and Lorenzo Bianconi's Acked-by.

Tested with a local 8-case test harness (generic and native, each covering
bpf_xdp_adjust_tail shrink variants plus a bpf_xdp_pull_data partial pull),
all pass. A forced-tailroom debug reproducer confirms that v2's __skb_put()
path panics with SKB_LINEAR_ASSERT() when bpf_xdp_pull_data() leaves frags
while advancing data_end, and that this series does not.

Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/

Sun Jian (2):
  net: fix skb length accounting after generic XDP frag adjustment
  veth: fix skb length accounting after XDP frag adjustment
 drivers/net/veth.c | 14 ++++++++++----
 net/core/dev.c     | 10 +++++++---
 2 files changed, 17 insertions(+), 7 deletions(-)
-- 
2.43.0

