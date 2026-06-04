Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5B30D405
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610950; cv=none; b=eiirJ730N0/8kSwsnzJRvQjaxS/V7MxEWtSoZGvJGKStPGGXv1tKbpvDKoqj0E0QNB9uOE6DLAvHQtM7nqAtunzGg7WqgVxahkbw/Gb+bqP6mpdVvBsJfnOj3Fe9x3ZF2n/d2HoBpN12AB3kzCKjBB2+ePOdOdH74JXJXwyOkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610950; c=relaxed/simple;
	bh=+X+9TfLYSycM2HPO1ZGliaygiNyuXO2Y5PqJSerkc/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADWnqjDu3HDH9uNxI0inhkhSmdRQupQzJIhdLpyROxVJMlqV/ppZNUhsBuVzTnkeRhpw3AqIpr8xIEm0rxyTl2eexQ69tMJCV1CblhDmKItzE46rX8euVyGl8IxWTTipyLFG3Zc4oQRQ1yWmxeci6kYt+tRKUh2LtUh8miT+tYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pa8226pV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa8226pV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf18c30bb2so8483255ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610948; x=1781215748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH2Bii3TFDEbVaIm2aZbVbUnROsdfZJZdTJSpnjysKc=;
        b=pa8226pVlwEb5CHS+a4dqA9otNVMvoFguVGYT1vZ+MgSJF2vS4OWaCdfouz06czKMt
         4XMvfeo1sdLqZP+/5CO/MAVDt00yV85IsZi8XvrscYRwAv4hz42xXVvVLJglO76YYSOa
         da/GhdPA8W3GyrGNV5SB5A2qasEGCiqsCzS/ZB9iitmf5RXIExZRBJKtAUbEzfkkkBqJ
         B71tV5s/DTa51+V6FZsMx4jpJ0KmWJFqdeNXrAdH9OnQuQB/7W6Y7A66ZtmcDhN0K9FC
         0j2FM+oaVKkCoNdC1EhCQI9iI57/j8bydS8UPE+KiYAjxTeHlUpNnXC3EuomOwdO1uy2
         5wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610948; x=1781215748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WH2Bii3TFDEbVaIm2aZbVbUnROsdfZJZdTJSpnjysKc=;
        b=eVIT4JEl2Q7tVYK0nBZT0EAPnewAuTIM9yR6bSWtbug8UStQloa3kQAhvx8Os1cUW8
         E94YjyvNOrnLHvC28Eu5KPRA4mIi1icPP1CaMO7yHZqsK4IFHY1/FIsiTt1Mu7LHLBrA
         OFWLil7wTw2KVwle8Tp+C0Fq3nEfRK4ypmDpTLbWI7NaQhjkfPxssmadmph1P39L1RNK
         VcS5DZOjB+iPxD6SD3wOpAHF68iuFW4nbygD+OuWk+w2mmk5rLDbFMYEAyrehNFg6OC3
         4epF3qBM9gaqW1Xhbf6gW48SvnZIs5rGAAhijzZNPzBZ85fPQtgEn1vMUff0U/rOfSt7
         SYEA==
X-Gm-Message-State: AOJu0Yy1SiBUazUdjXB5wl3xgT3mTkymI45ZLPeLpKis+QeS7/6hk2wo
	okZMlLsFvcwm/HyjChyfUK1i7i92WV8EViYFz1uIiLeq4UVPkacVieGpRewWsA==
X-Gm-Gg: Acq92OFSYHmEFsQWgDeiGzrsI0qTLub19LqfRTbHgaqkdIpSMDBu0nxh3zy5duV0HP6
	aYtVJ5XC2hlaVxKPQ3kaZErmKbrez+3v176nofly5OMIsPvgY4uiF550ua4rlkaGbnsV7rnhihn
	Jqrvuwue5o2ABTDln3yPfJyG6OAdgJStUvWQDPOCwqB31Uj/da0ErCMbD41owl4A8FFJOF1b7wm
	BPRAZ5oqYS4l62+qENNE/5Mk3/ZllO+8FaFRuqo7+D6CqinteXMzY4IGBpjPWCc3AZU1wWXXDKU
	+U7Na2VOEeRdNqmgylhj+FOSG3Bs26XdsLtpy/dvYhmpuy6ubeUPl1ZCZQmBaG4Yiie1s7/4f/X
	bnz1XtX1wYThT7m2pTnFdGQ4CPJQceA19M8GmVRx4DCGWwueFGCQkroTzcnPkZJG3yAEcdE8rPb
	PoOaxpYr1UPE+xlS4eQefGGO8JodQzvMIVL1U=
X-Received: by 2002:a17:903:4b28:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2c1e89579ccmr3625675ad.35.1780610948100;
        Thu, 04 Jun 2026 15:09:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609ed97sm70195545ad.41.2026.06.04.15.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:09:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
Date: Thu,  4 Jun 2026 15:09:03 -0700
Message-ID: <20260604220904.1032145-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refsafe() compared each reference's id and type but not its parent_id,
so two states whose PTR references differ only in the parent object they
were derived from could be wrongly treated as equivalent and pruned. Fix
it by checking parent_id too.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5945956a7573..06d9ae24f006 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
+				return false;
+			break;
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
-- 
2.53.0-Meta

