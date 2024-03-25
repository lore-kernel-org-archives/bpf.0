Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC5156658
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376934; cv=none; b=qDX8kFNJjbjPOH87Oj1tKgf4yjZPFFr0+9sMKOg3PnLvdKrBEQDSSBOga+UH4MgF8u82cAU1GcaoObcH6L1n3TPdNCyQZi5HtGbejmtiZW1N+4pbBKBhf7TmE3woYvQxXn2sukz2SZ3OmA3FKgxNLG2L4FIzrXpUTnA6uVy6Cy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376934; c=relaxed/simple;
	bh=akBFG3f3YMW/BSV08C8xI8nmx1MQRnRFnLKAyYWsxo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qt9tslcXkzt+fKr1iOmTJAr8jCiYaoSNgb+67JQYkvfZtNJDsN0doqhaM0SBh9KleHG/NgzPan0/YmWI+UoGOb8WUHx1F136o0S3jZSWRr2IgceWY2c8Q+wBNTxt00Qa1rsQpdxEznE/M3GQmP1cTinBHc5WSupMrO7Gf35WVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Re6Xj2g/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Re6Xj2g/"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6962a97752eso32403306d6.2
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711376932; x=1711981732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf3RHIrMoub23mefzb8VvTbiVD8xe7TaBThYCOSSjsw=;
        b=Re6Xj2g/M0rzux34FU52uL8RB2+77XTag8CgxVINlLM730IvBElOTIIMDA10cpY37C
         ZvM2mH1GCz0s15IhNYCo9yXbqFXDzpcpAnqZnFJrQ2hU8XfN408KUIYhkxLscxKEePlu
         Y/8OSmcDkATa8Nzdl5xnsL94aQOW7orTabeZt52qPudolm0GX0plsRQI7KFALNYay6m8
         DIS5SKDd9sWXYfhg6XURnP0yyvceyjgNap5A6ziBhwDSQwh2Lx13T5ql8ecFLtBHIXXA
         YqURoFR1i+OiOSPcXFLnZQoF5aZAC27tL1chI62OODxjzn910WeH/lBoIz5qkMu8XEi/
         3Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376932; x=1711981732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf3RHIrMoub23mefzb8VvTbiVD8xe7TaBThYCOSSjsw=;
        b=Gz05dT6zBfm6RiL/b0wjGdKtOzeWDZSTG1jv4A5K5k/+DmgCB1Z9f/6z0TxabI4gNV
         YfOGwE/bVFwGHUOKQKHuO54qvs7xjuWEpItQ0ORlj82FOAt3pfjU9IKX8fv7Zwqka3sY
         rDpucDyG9r2VpEVFrAUE16s6r5C4ThPa1vcAJGWi7PRXsIwBWMx6eCXqqJ9Byw+4p1lo
         pZC2dfRzf8C1OQN0CiXCIjShwoi6N4M+1QkZcIMcV8fk9pgiCENEN1IpUhp/p4l0KbA1
         gS65n44cdCyPi7nxEmqtt535wFhVbG4u+nu3x+I3GifCda/byPifCpkZsDvgBXDLo+Zp
         DuDA==
X-Forwarded-Encrypted: i=1; AJvYcCX9eEUOvX5YXk4HBMxalAAtlOxB0MIzDpHgvFcAvV1U41HVy3gby5jJTJMkGy8M5nQEcG/gmgmiorZsL9XudrRfnjme
X-Gm-Message-State: AOJu0YzyFU4mqfa5WibQc5Ie6GPGYb5o9lsxatDER3O+uwjE7KPUDIyd
	3PFowlCHIVK3I3CW37VJFJXT+fUa70ZIrObBYqGdNsqgt9DDJJkOwTiWgM3RZA==
X-Google-Smtp-Source: AGHT+IE703dwRfmL1uIcHZx0wE8y5ZqmI9zhNmKqoHDDdLR59vrUMTvWQvRRRDyLFT8FWQ7ZT1BNRQ==
X-Received: by 2002:a05:6214:c4c:b0:696:70c6:5234 with SMTP id r12-20020a0562140c4c00b0069670c65234mr7303878qvj.51.1711376931996;
        Mon, 25 Mar 2024 07:28:51 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44bc4000000b0069687cdaba3sm1729255qvw.36.2024.03.25.07.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:28:51 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v13  04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Mon, 25 Mar 2024 10:28:23 -0400
Message-Id: <20240325142834.157411-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325142834.157411-1-jhs@mojatatu.com>
References: <20240325142834.157411-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For P4 actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the P4 action information
for the lookup operation.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 59f62c2a6..52aab6dd8 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -115,7 +115,8 @@ struct tc_action_ops {
 		       struct tcf_result *); /* called under RCU BH lock*/
 	int     (*dump)(struct sk_buff *, struct tc_action *, int, int);
 	void	(*cleanup)(struct tc_action *);
-	int     (*lookup)(struct net *net, struct tc_action **a, u32 index);
+	int     (*lookup)(struct net *net, const struct tc_action_ops *ops,
+			  struct tc_action **a, u32 index);
 	int     (*init)(struct net *net, struct nlattr *nla,
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index dc5caab80..f425acbe7 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -726,7 +726,7 @@ static int __tcf_idr_search(struct net *net,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1

