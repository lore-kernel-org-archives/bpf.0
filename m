Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88533384CD6
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612724; cv=none; b=D5Ls7d0ujl18Kctxiw96japmckULPwPAlCFySTnnUEGNbbAkFJaJTa7qC4DmQYV4kLjfWfp4zX/5Y33nUernNXYQq2XB99EK2ZvrlGXALPknmIbVGEC4R8x334H9ZH0BLQUrD8fCNxCymyhTa9tQN3pSvO+ahJCmSQ89xby8a2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612724; c=relaxed/simple;
	bh=s3YisyCcI/hq+2XDqJ6T+ddttVQATSC40ix/6ulTrS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmVbP4cLMJRFgcHYTxsP7xPeZHp+0YlpP11925IV5B3slvolOuNp9qbmJlDHOX59PUEeNO48n9jTBLP/Wi7efxO6B/bInZWjLOFlQl1tMvXSbzdVX0KoMmuSlIu3ersUul/lWYs7YsEQ8u3pfmU5Zr/JXi9WNSkhVdzxs2apTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obFutiou; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obFutiou"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530e28a62abso4057711cf.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789612719; x=1790217519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R8rU0RaqqC+TTKzMwgYz73pV9RD2QyAiNe10IeS7OZ4=;
        b=obFutiou1/dMnMGl/im9cmqeFvlVYs7N/Qv8DO7XuZ/1o8MLq7z/EspK89ocXg3F1W
         N7IbIkf+GRqSLFg8LAw7U1biQ+ElAILfFmNzq84q3RHq16oe4gUq1PhCB791LTU44HWZ
         apZHdT+GPKhG7rTv2KyrzmT18PtiKcEUi6A21qn+b9egemRGPzyUI1U6JG612xxJ7+D5
         S0a/Q2lGt4IjuRiA2iK881JqJWJ8yaiDwqHxp/2ukwcwO9DnbWctkPuWnlhM3FBV95zm
         s6lia+664Wk2/SJzk3odCEwZpAnBZFJjdntQuCj+TAu1TF5sGh5oaZmD7xZlFZ7Zybx1
         z8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789612719; x=1790217519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R8rU0RaqqC+TTKzMwgYz73pV9RD2QyAiNe10IeS7OZ4=;
        b=kc0YoVx0miApae1nKJLTnDB3TnStLKJMCSy0fPJAG9v9TCV8NrHC8GVIeIplFNbnkd
         ToyiDF42GfCxltDCLwgH6bYBO6MngLiybaCP+uJfdnWSFG+1nIS4DBePUMXhZuNjTCKs
         I9njArjbcj1HDsr9FZbaXH2dtnE2/bSGqt/506Xs3z0E139Bxgo+V2Mxeb+nrI3zvmgt
         2z06wogjfBG5+bCt+xu1ocfH1kaEKhVgMBxPGai2vzPFjamERS91EZR6zZ7LswaR0lBb
         dmRGh2XhU8IcuZuTkhQcrRHGKb7eT+7d3RNlBAdzx+59TPPYFmYDb6/64zBHhN1N9Qbq
         GdIA==
X-Forwarded-Encrypted: i=1; AKwUvBwu7KUIb6hWZo8jsDbuYpnSdKijOkdp84ASAtbEa8Ttprut+eJhr4N/iWcoJqW9N8JA07U=@vger.kernel.org
X-Gm-Message-State: AFuF++leC0xCnm9jUMUFvURmQEXJHMp70Qv7j9Obx+bZD3wD15vUwv9F
	t2iFXNc2MVE6+4JgQuBiqhyfPO6TAkIzWxDiVjSAgGkWdXgT4EOzHFsfxfsYbw==
X-Gm-Gg: AYBFou24QvOICV0CwFPDW+zEvUqIieGsApsAJCyWBqSvG4uretCXB3P2ACPBQg8X0x1
	OVsnpO5ApwaY7pLPmT5D3PBgZW0zbpT6cYcfnZR0OiZXE2hHvsB8fW3n7Rs+y9l9ZSwbtaj+fdX
	0wg/iauh7kFU6jYf6ENEmCeuuWmBE2aS1mg7gunMfzx/m+g3xJftxgG7ehqR5zFL1HFasQvgbEb
	k6ydqAnS98L3v0zOymTQ1yM7NmBYyCdPPTVF6Ww6SRK2OoWF83lqboa/gbHONtZHVMDvbtswC2d
	kJ+L7SkU5mdsWhgd7xqgMj3LJCd97ty8b17lT9hdu00wtb9IXlffrqWThMIwYbYzCfIE0JFp0WM
	tMW1HN6H4aoUxncj1CG3IaiEMnalAB0ZELwKWNtTEjj+l7WuODG0nauDtv8XY9wZ4aCNHqJuyva
	kI8GGu48a24IDA6NCdmzU8uNoKLpdzaa4O5aWQ2wMvHm6w91DihnGjCc55m9YXzX9aJyqecKY/0
	ns=
X-Received: by 2002:ac8:58cf:0:b0:530:703c:d846 with SMTP id d75a77b69052e-5327ebfbd68mr89015881cf.0.1789612719251;
        Wed, 16 Sep 2026 19:38:39 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326204af13sm37680131cf.17.2026.09.16.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 19:38:38 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	akpm@linux-foundation.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	deller@gmx.de
Subject: [PATCH bpf] bpf: Fix page double free in test_bpf skb setup
Date: Wed, 16 Sep 2026 22:38:34 -0400
Message-ID: <20260917023834.2760055-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_test_skb() transfers page ownership to an skb with
skb_add_rx_frag(). If either allocation in the second loop iteration fails,
kfree_skb() releases page[0], but the error path then falls through and
frees page[0] again.

Return after freeing skb[0], since page[0] is already owned by the skb at
that point; the raw page cleanup is only correct for the first iteration.

Fixes: 76db8087c4c9 ("net: bpf: add a test for skb_segment in test_bpf module")
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
Please queue this fix for stable. The double-free has been present since
v4.17 and is reachable when the test_bpf skb test encounters an allocation
failure.

A separate bpf-next patch allowing TEST_BPF=y depends on this fix and will
be posted after this patch.

---
 lib/test_bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index af6f3340c034..6104b97764bb 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -15214,6 +15214,7 @@ err_skb1:
 	__free_page(page[1]);
 err_page1:
 	kfree_skb(skb[0]);
+	return NULL;
 err_skb0:
 	__free_page(page[0]);
 err_page0:

base-commit: c0b95a11b38b47ed4b88fa2cebd86bfc4b244c5d
