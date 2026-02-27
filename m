Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD7299943
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772169647; cv=none; b=M6o3fA4eTgT5eE1HEiQYIme+J4R5KoLr3Z0sO7zoY3widznn4K3tsvnx3/fuYzibUgT5RC7hrn8INL597CISIK2woLNpxqjC51LET8rC27MxE1O0NZDug3Z86ScFKwW2AhNe/NsgeN0G3QSIKPYR2GiZLIpVaoDn4EooQCkQeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772169647; c=relaxed/simple;
	bh=z8JlAmzIEK0TyaOAbqv+mlG0HRfpsVgWdFpPjHXKchw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK8CceVzUmO4VJSnJnIMSpP65ELIlAoPGVfYk7GYXjdKuwuISiQrz5gUx9cxRBp97URTU8RKzNI1+cH8sPcPa3sxCYZMXAY84ANefmhVhbfG7wQcE/PVs7mQXTxjlwacw+QU/Hz3a4nZZXO/42zDTanRlPbQrDbN6otBwyicH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ/K1Gy3; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ/K1Gy3"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-4638a18efc2so1227799b6e.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772169645; x=1772774445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct8A+IuhVeq4s59NBTekgiZbhsXJsus26BkXJVfkIOc=;
        b=RQ/K1Gy3Ozzw+o2b0VpdQZPHVeElpvfOW/wAAvBLgSU03u2pHQYF1tecj1ZAVxPgNy
         yf7RVJLXz4/lYp/Wp6bVn8z/cnFhhfs3gKpxJMyM7JlxMyXE4U5hFDbnET39LU9TxIgE
         josRHjlvU/md4Y7VcjasUA2ookN2Ek0vwM9hBF4mbXcd3OplVsxoXL7Li5J2TH7Ys36A
         bX0580QCRzWyJy9+BV/7s99RK9cvwPVcEuBzXsIvApnTksPJFOxWURN5XEOvBebThhsX
         eaIAaDQsRJkSmAcR1TUl7tSo58HvLGetQ1DESSJXZMTOcr3FNPFm3ouH1XWF7A0x/ljn
         2Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772169645; x=1772774445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ct8A+IuhVeq4s59NBTekgiZbhsXJsus26BkXJVfkIOc=;
        b=nzn3mwcP3JahmT7kKTcApfv0Y3BHYjXbZxv5HXcrw0rAViXaed5+sUFwJ3l5Om47kF
         bYf7TljhJyoM6PFc4JnDq/It8cjIukxo1Rne+F8dls7/eGPjyjjRTPGRMbhUpd1Xkwna
         q7LkjLzWY9qNzN4Wrm9tg2okLZbnGKGkp1BSeg4bYvKWf5P6uaEo5ZIY+0o9g2pvYslp
         tAx6EQEwDSRViZ5XsbdGREdAlt+B3Juu9Us/e//6hbXtgWN9odCeV0tyU/FiloejnjNc
         sGYFysCEK6VuVbeFx9/GdQ6QHszd7a0/MQRgQU4N4NXU8LSXMHP5t3bvdUem1pWgQJSj
         K6kw==
X-Gm-Message-State: AOJu0Yy58TQHN3620HoB+Hei9+tprcS+BXTxsxvz0YPzWBJKhCBixXGj
	iymLsYpjiKQP/GcsO5w+MEvGs8qgyh9zvA0WKahUzs0j37lI+/L6BAJmhwkzgKRkUgw=
X-Gm-Gg: ATEYQzy/pNXOkarkBrxSz5nYqiKrpplpe6KdE/8Gwzlf4fgzUySl5Bizb/UugRrkGzw
	wicto3uRxzQiffzusjWVaCrBg8fdHwenMnKD2zWLTLghtLFH0h/rKcoXjfEJsMT7efCas8R90dk
	UgeoFiRgnS/2i1iccWHTImxPDMntf98L2iRaFGiBNibY1O948VQDmxRRuVHAh16qFSEv+ow9b9N
	WKNDL/BtzPyhpuCr6fr5nSMpCbleYryqxmtCmt6Iq4/C+6usCchvQoJx8XBFBxqrs0NDpIWOfBG
	8ktRiuwRwckVyefXYwCOxbeoVfq1tDKk1XRdv/SLQ/achPFksqc5EM6J/pBu08v1QyHK1VphgXh
	tgzY8zR5g24cndYYSVC4Pdltg6LggI7U79E9AGtXzX2YqRrlVHuaruZOenQaoqFd9UuEbg+Ma78
	JCQ/C1mPGgvq6OOtdrxzMahccQquRYAVuqf/JKyqCktrCo4oHRE3o8AlA=
X-Received: by 2002:a05:6808:124d:b0:45e:e1f1:4af0 with SMTP id 5614622812f47-464beca70abmr916773b6e.63.1772169645018;
        Thu, 26 Feb 2026 21:20:45 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edf0sm3475322a34.2.2026.02.26.21.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:20:44 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 4/5] bpf: Retire rcu_trace_implies_rcu_gp() from local storage
Date: Thu, 26 Feb 2026 21:20:30 -0800
Message-ID: <20260227052031.3988575-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227052031.3988575-1-memxor@gmail.com>
References: <20260227052031.3988575-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; h=from:subject; bh=z8JlAmzIEK0TyaOAbqv+mlG0HRfpsVgWdFpPjHXKchw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoSmPyveH3E6uzBY4p4ESnjonTJzOt6uRY7QUJah3 hdl4JbSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaEpjwAKCRBM4MiGSL8RymjCD/ 9sAX9oSpfjmBbBRlT+/yqjqpZbd9LIzNheiTFbukoMIyXAIER6N6dzmG+SGVkE0PpqCHjhDm7DC9J6 lrqRogJCytaRNAjOmk4ZAQa37LoTmjhJ3okesnM6QcvSNkIlcYgvg6sAun5zYfDvOieFrFyioT5Kjb EqztpXdPUBpMS+TR73s9DhoaNep/HxiPYht3cpqAaLYmS1+J7l5fZmgc6SKe3qp0iZ+dxalFgb74ag Wwx7/nBtnYZ6C6hqzhWkSSBBdGhmaEYX6YT3i5m5MjmWEWPu1okycCeK4bgVG7kzeEYvMBCliSK5rm IsaUlIlyct49YEeaqB9dI45G+nHB0jn5jmL306+8bC2P5RTUq2cBZURC+xg0CwPG5Pjc+Jr5HMKAtB pxf+HVu3Uqx3ppg7YQ2ZZXxiHuXx+nEkUcdm5MubiRUVwdMsRbPoukbP+qxV8T557LNAR992l7Umnu 7pWFmDlZx4mjlwRD+Yl5HSuXfLbchf9lyBiErSJj4qX3vUveDvwyW1qzXEwt36iJY4NCGIJnwh43xt gWMyqyT0p3eA9FgrElYcXomouhE6dt153cv+zdR6VQBvyXTowX6ynasx7bxURTVyH1cJ3JAzLDm6Hk chnei5MCijV13DSEhJmpFworWkFNkyiZE66bnQ1o4XuXtOi3zOzSJmRMQejA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This assumption will always hold going forward, hence just remove the
various checks and assume it is true with a comment for the uninformed
reader.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 5cd874f911da..974bbc90fb5f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -107,14 +107,12 @@ static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
-	/* If RCU Tasks Trace grace period implies RCU grace period, do
-	 * kfree(), else do kfree_rcu().
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree() directly.
 	 */
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	if (rcu_trace_implies_rcu_gp())
-		kfree(local_storage);
-	else
-		kfree_rcu(local_storage, rcu);
+	kfree(local_storage);
 }
 
 /* Handle use_kmalloc_nolock == false */
@@ -138,10 +136,11 @@ static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 
 static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
-	if (rcu_trace_implies_rcu_gp())
-		bpf_local_storage_free_rcu(rcu);
-	else
-		call_rcu(rcu, bpf_local_storage_free_rcu);
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree() directly.
+	 */
+	bpf_local_storage_free_rcu(rcu);
 }
 
 static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
@@ -179,10 +178,11 @@ static void __bpf_selem_free_rcu(struct rcu_head *rcu)
 /* rcu tasks trace callback for use_kmalloc_nolock == false */
 static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
-	if (rcu_trace_implies_rcu_gp())
-		__bpf_selem_free_rcu(rcu);
-	else
-		call_rcu(rcu, __bpf_selem_free_rcu);
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree() directly.
+	 */
+	__bpf_selem_free_rcu(rcu);
 }
 
 /* Handle use_kmalloc_nolock == false */
@@ -214,10 +214,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 
 static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
-	if (rcu_trace_implies_rcu_gp())
-		bpf_selem_free_rcu(rcu);
-	else
-		call_rcu(rcu, bpf_selem_free_rcu);
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree() directly.
+	 */
+	bpf_selem_free_rcu(rcu);
 }
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
-- 
2.47.3

