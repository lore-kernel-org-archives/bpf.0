Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F57315D37
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045494; cv=none; b=DaLeHZmulmLHoyc1zYHkn1ldwga2g3k3wI0kttZgDmjDWaHkNKX2yt6WcnTCW36CqnE5H6SEmqyx2aizN1uu9Xl1BKwf557RzUypq4C7/2DTau9W1R3sykgtn64EgtAvmeWKlft01xflBzXXqs0qigYoIPzpCAtaNqQ9CJvlp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045494; c=relaxed/simple;
	bh=ktSsHnIeb85+GLCRE/QVJBd+HUq/x/Mddonuzk6pSUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hfxgg8mEvwfSLbKJ55jEo2IMHuTsxOfvKuDO6mLVrkvXAJolrHZRa6eUmT3UP+7PzyAYhFGxbcYSY9banYeWiQ3W/ioScVqDo3/k2Z6heIB7DbWsqpaqy3hsz14+XKaKRGujAN0WWNNqci57Zrs1k/hIHrk0fW4AlogUt+/c2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcGhrJ3T; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcGhrJ3T"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d18c654458so3007854a34.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045488; x=1772650288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvh2fMffXWUqz30wsgMK149EQv8Rx7SI2K+poEAhNIo=;
        b=jcGhrJ3TzgucXdOLudnzr88nELSiCUTBlWakkmRCsrHNrWJ1s1e2n3EesuCQEgZKu1
         m6z0tNAYR58riE1BFZ/Tl27+C11yG8PYAYy3tfWfOLdN56L5JIFTb4fq1AS26FMdbux/
         kaTL6JgpbaUQGGOQpWLUqasGOUoCA+psMS1XBfQu59u+nFxaQhuPX+iXxTLJB428OMeE
         LpFVrAHbL2xEazi7WlTyixYRL62OLBEMxHPAplZ/Z9yU1KHm9h+WmZjxXw0oeWyJu6dA
         DdvtEc3kwoVvDkmoqgyv4JvnZG/Q52Ypd+y0sn2V6nAmFFfVb6RFoo2sCF3RMxNisN4e
         lOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045488; x=1772650288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rvh2fMffXWUqz30wsgMK149EQv8Rx7SI2K+poEAhNIo=;
        b=NZt95b7BsUAL+zmKaakoX9PDeYT9R/EC4ccesk5XRKMdrytFCrgqPpWp3le0tps/zZ
         IPsHxXfwHUEPuRdAjWKyr5VJgP2jE6uzuBvlWtNxsIK8p8Mbrgv506oAGbiE+WTtaEWf
         s31Sws9nuR+vTM8v45Wj3o5CxJsp7ikgnmo5KnBFIfV/i5ysNrF41lHtz6eqXLD5ELxi
         1Wlh9R5GtXZgDW5BTwCZNYBvk0mj7ZSqSn+7AUfjEwePV6hsbmjt0hSov2aTeiLRVC2y
         JvbYnXXIK46WcF/CQVo92mvXPQxuVmVsl1iExOG4llj2AMXHJP7tV6Ytniop0ooUoKZI
         tF9A==
X-Gm-Message-State: AOJu0YwiIxtfKB9fGfwQNAFkKdYlnhqZFjERCtc+rJs1qKbTsIXcyQ9w
	FKyqX4L4BATSHY8XEgSexRMGEq/5lwoffXsxVxwYfHPQBFAkaFQif0VeojQqFSSd
X-Gm-Gg: ATEYQzzlUL3H5dVCt0apnb+oT6q6TQ9IN/PN32f3X4+KX3bQanauG+J8Q7bm6JRdlyg
	OVqp5qbCZDHELS8J5Nv+gO6/9Aheux3rzskAyb0KkzIND9/p2gDwfu4tNXmFt3j9hVQRPrJjlMk
	9YH2hxv+QKn5JyuDOe8c1a2A+NzUGR7VRbzx6hUl3wYdELcVijauk1Qjd6B8MRqpSiVjZnMpDeG
	JBXPHV3BvcL6m2QRUGU6Jdn8UCfYKAUqxWsD9T8laUDfkyKlm2O9rtDXP2panT5rEoPSpoKIsMG
	k/pavTWX2TzOv5WuuJwcKWRhXsag8O6fNdUqFdtsBQR1Loq8lUZ0Wi69VGgflQcMzQ2lP5LlQk7
	cq6Hx+JQyd7+m8zZBHtIi07ac6FrYkhVrj/TbF0zh44HAGx7C0JDI02w+RC57WscWKkmt4HiQoH
	lUQmKhiXPU0bgNgTxtuVnOG8cNJDmuW/IGum72B/f1pJE=
X-Received: by 2002:a05:6870:2011:b0:409:7d3a:bfe1 with SMTP id 586e51a60fabf-4157ac4d509mr8420096fac.13.1772045488161;
        Wed, 25 Feb 2026 10:51:28 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cfa6624sm15856727fac.8.2026.02.25.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:51:27 -0800 (PST)
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
Subject: [PATCH bpf-next v1 3/4] bpf: Retire rcu_trace_implies_rcu_gp() from local storage
Date: Wed, 25 Feb 2026 10:51:20 -0800
Message-ID: <20260225185121.2057388-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225185121.2057388-1-memxor@gmail.com>
References: <20260225185121.2057388-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; h=from:subject; bh=ktSsHnIeb85+GLCRE/QVJBd+HUq/x/Mddonuzk6pSUI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpn0QMAKBz0t+sEK6gco7neCtjwOxPlFGfF1fx2zB3 SAQetkGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaZ9EDAAKCRBM4MiGSL8RytcyD/ 9NTVnClHQIdYrnTWi3vg3GfSAe2Kpcz0u6baScvgQljN8LKnUsZxKlAyM8uWSFAt+AwyiuchAV0P6K QdFEJHX0I8NYrO/Q4iMrQ4TV6ou5EIhPJY2GdJM1ETFgG4oq7PNZod2cdvJyhaS4w5HETjj8quBMN+ F7r1o9XboEhbOP18gr41nJzOqaWB8McuvZ132LGjdAoJsSr7pUiKSuT0KcIga5af66N5H2modS7HYP FWqru3KGD+FCu6pzuS2iRw2iwl2JfA0QBqKtBdsjsTPxuhzY+QuQ7L2BJA1xFBWAMWewLyUAn9pwUE VjTKXT1Vka9LvqgriqTIoBYv/nmcbZg2ijIp8UY9mnkBgZd0fouzp0Pkguq12HdSHbPgTcFp1YNFZn PeIE4+dmKBXT1dV2PQKAYMOcfMN6ImZtAXMktKFSkGq+S/CAvDyOZoIv0mXAMBwXhJAwFkTfLmOKHB zm3x+/nSrAycmcV4Sp+5JIFqVqivNmgsn6pUY+DIe7rd0Nl1yVVPKkGp1haf4EK48YwHzx+tmTIelk ZU9rbjkX1PbktZ+s9Xxsht7w9nOPgoIR9FyPMYAZcMlu8SZbtjQcRjdJ0aRyvNQHH5LjPcOqGedmMe I/7WeBpPh48tbfQAbJNyRadDCj5TLdFQVS/1ijEMn25KTqjIhaO9Ig1bUerA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This assumption will always hold going forward, hence just remove the
various checks and assume it is true with a comment for the uninformed
reader.

Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 0825a92dcd6d..84fe6364c75d 100644
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

