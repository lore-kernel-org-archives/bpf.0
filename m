Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400E3E958F
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264460; cv=none; b=FqB/NPhGqDK6mh4fv0FN+0KrodPb/QJf8mkeaAEnKK22ROgijzFx55+SV3Yd1A6/fDPsM1JtHSq2U8KywCuw3qqhZkwYN8AB8trMbtd3lcH9LjsieocDfl5+9jbpBnAsUbuTtDaeROIMHMZ5GCPov7Eb8ulRSI/ne4F1XS2QKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264460; c=relaxed/simple;
	bh=pJ/QyvoAyb5v+r2U61ucd8SlUzxeU1gohB/ziTC8eW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYk0hV0W1u6D1HivDEy3Y4e7SWe8ZVOkgVEVIyAsqE1ws51Z4un+odvdCwalU75gSgcepF5uE/CWnzmdiCBUyPnOd3Bogbhg3xdhuVqfA4K+qjP/3oKL32xgzGeMAiyczolAHFc4uW1d2JXNM9/dZR52BiRRfUSfZBUq9ImUde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkQQ/xls; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkQQ/xls"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so548203a91.1
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264459; x=1781869259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO5l5ehIJQy/8ncJAgfC2hVtehf0lOaUgVls6srL24o=;
        b=ZkQQ/xlsyAwV63tXS5gGgEoLPqFO2FFqpYWTrlvJbfQ3QDDldjuSOoIraAWjf3zc3g
         kiEqaOoXH2AlJcJUe7joYbPgE74K+zhAdZ5KDAuyjob0jHOtVJfjs+VGFOMBLbbLy00a
         PJrftoY7AxGuH8u49YdcaGiEyntBZt0oHYm9sjapdCudqkESCTueI53y4rch1VUSQ1jp
         jNmPln79sxzuSiNKUOhQiXxH5kl8BbyhW6xWLNiu1Wr9t6E/jF+s66lEE0MtQAQ6PAZH
         kvPDDRM3V/CZRuR/M+fAjlvDgfksh1/pCaA6pq39glLaalUTvHLqLh9grTd+fZ/sCal2
         GzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264459; x=1781869259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vO5l5ehIJQy/8ncJAgfC2hVtehf0lOaUgVls6srL24o=;
        b=goP49sGf0ZzOB5ro7456tRtXGOJxKeCIN+0IDBYteI1onBUPykMYt1lhO2I+TxpOWX
         4UZu+lgh2TEHAA9ogbPJLZG0SLr6pNuvGuIIkPzFy4G3HHlVtJFmvhJwZW2F9HgJ8NeB
         XUa+6ACWgzj60VI27ST+do0ugP2cmkSwK/wKijJfgOpwf37purU5zPFsFoboA2qc/cyh
         Mabl/cNQE3pzS2XVRkP8uUYrgg6zAnN5GBYygKnnPAMptg56qaQuR+cTiIEWdr+JRcXv
         +HFzPHgbGCJ1JI93tuLvfSo/yTKDJomUkUBqz0/TkAk5uEjOS5dpIxUDXFUY/VfH9wZw
         fVjw==
X-Gm-Message-State: AOJu0YxIm9I/147FmqDlJx4Ec0iea9hatAsF1dymxZkUAiVx5C/xafv3
	kP8o+JkdSOCiNpG2W5RM8Cik9xQxKGpFoOS8ibAZY18o5ut1Ziof6Ep8EbkZErf5914=
X-Gm-Gg: Acq92OEmWzf+M0fUA57lVMrpEqF3+h7MYRTJQqCvLXLbqNdVJVE+kML80qdmZ9s6/gV
	AZgLvS6WUi8L2CFf02k9p8DquepVENX8HycnNwRvpTR0yO9f1dxYsut29AqnWuls9LKjbfsMzu1
	E/0yEezLLCKOoZF/daiJs6qL0qfKtbEjzFj3+ojcM0TqL7Ixkn9h3v8tGx9BG2UfnEOGE/1Qo4D
	wcxPwNLgGhiDzsy1sJDMvAmICP1eO4CrO1d6qRKaSCTLH4DaYg9jPv70DHmc391+mhw+PkBlYco
	zwFIqKNRdgE06YXYl4jHWCxl1hZv1O/O6jHzqM8VPGm1pYhM6UUcfSXF5kYRQREdd5k+ZrSpyz7
	vuB6Me7mm46INnQMxL7w2a5+xXrCnZA62Puayr8XlFm6hTbK07HkbiGqFNm1g8fjcLE1IZteBBj
	KZ1YeZmuGhu6hIDAW8GxloqRURWvIEjuZSJPaA7Cs/5STswFb6F0KF0N5J6w2QTBZbYV0hKQP+w
	3AqABezr41qPRwNknYq4Jg=
X-Received: by 2002:a17:902:ced2:b0:2bd:7684:34b0 with SMTP id d9443c01a7336-2c4105092a4mr33621575ad.15.1781264458780;
        Fri, 12 Jun 2026 04:40:58 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm20697455ad.38.2026.06.12.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:40:58 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on private skb
Date: Fri, 12 Jun 2026 19:40:31 +0800
Message-ID: <20260612114032.244616-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Generic XDP devmap multi redirect uses skb_clone() for intermediate
destinations and sends the last destination with the original skb. This
can leave multiple destinations sharing the same packet data.

This becomes visible after generic devmap egress-program support was
added: a devmap egress program may mutate packet data, and another
destination sharing the same data can observe that mutation.

Native XDP broadcast redirect does not have this issue because
xdpf_clone() copies the frame data for each destination. Generic XDP
should provide the same per-destination isolation before running a
devmap egress program.

Fix this by making cloned skbs private before running the generic devmap
egress program. Use skb_copy() instead of skb_unshare() so allocation
failure does not consume the skb and the existing caller error paths keep
their ownership semantics.

Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for generic XDP")
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/devmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..28bd44591ce4 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -706,6 +706,18 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 	if (unlikely(err))
 		return err;
 
+	if (dst->xdp_prog && skb_cloned(skb)) {
+		struct sk_buff *nskb;
+
+		nskb = skb_copy(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		nskb->mac_len = skb->mac_len;
+		consume_skb(skb);
+		skb = nskb;
+	}
+
 	/* Redirect has already succeeded semantically at this point, so we just
 	 * return 0 even if packet is dropped. Helper below takes care of
 	 * freeing skb.
-- 
2.43.0

