Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9686652
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233427; cv=none; b=iQ9HuZvPGRW/m0qZumhLVH4715JGlwohP2yu4VPRE/O5n1U4ktXMzQF7FrObYr9HvhhpydwJZpgSIlMexJfT7odzsBvd0v5yx4cjNyriuWS8aopdchMGBlKWeG2ZLF5SX4YGdr8DoOCOP/NiwjlBIZeuQZN6BgaN2/HgVwKCQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233427; c=relaxed/simple;
	bh=KfGNjAUtb+mZ/8Mo8TWcHVtUWPxugUbcvST0KOlyvec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=it7Wa1H2TeSHHeXbssHWQFNP5f3V1qyE3vvWOng+yUuPVSAYPGvHzFDz9IIbhacu+7Th2j1MlR5fcCYX5fz0YaVtDYvve4C0ZI299DT+uC+E/zwU+MWCcQTg5pbxq78I1qsI9jlpOj7Kbp2DgKXQ+Jzqx+E27werpcoi4cM2Mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=XyCgVy7r; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XyCgVy7r"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-432f93c6c7cso4295051cf.2
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712233425; x=1712838225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/8OW6GFQ8bSxY2ye3MTKJIlWkM6Q2//Y6JjwJfiICo=;
        b=XyCgVy7rZq8WIez0MOFFTEf0IFwO5nWpPswPRc9ySU+HrGvpVj0zAaxQ3kKxP04m2k
         tY0Bx6RM68x7RKgMC19I3U7EpwOV+Gzrzj+m5JRLcwZA2ZICrEB+EFo4IfLpncOtmgZ4
         /OqMDkR6yTgnm6d500uTJLY17j0eI7lFctQLrjZilmZYhJo2p2oe5I9EaW4ozZjrA4i2
         cUXuqTdCD/AnTUTkUVDa53j8idKNwnUuRGSvY0rTIgqmJkkMizysVKx2QSWJhiuAUYJ1
         mhlCafRG6nTBnp7x8aoh3orM1FuH+tXpWAVC9bjPgWTr6OkPTELEv/7K7VC8de1sDfdY
         ZCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233425; x=1712838225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/8OW6GFQ8bSxY2ye3MTKJIlWkM6Q2//Y6JjwJfiICo=;
        b=sqf7U/u1FM1RV/qYhBXeYDmedQVrLR8pi5TlFGQbwzTMC+cK0bEE6nf+qTzyGnqcQn
         UZCeZ12EhH7kO4rUeQHjHIUjpuxtTSz+JD9xBafyF3KmbXhz77vt2NbnbZVE4l2sKroh
         4jFX0/QYcUf6VT65tC3syGbkJB1mYKJsV+be/E11eDoYawz7l1kjFN7L7w2sYvsD4qj/
         w5kQljAOKsrhShcHzrNZOliTYKz+yYwul/IAUUhIxmwEClD2J/iwDKMraMWK3mH6l2q1
         UJN7ba6phuSmig7JlJX4UISrGmmNRI2Y8aIN/6BYX43XpHDjqCG5gHO3ZtrE7RostShx
         NvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZBCSIj10FHBIe9GG0kqpAanxhC5+4yNspD9QEV8J0E9HW0gPF61lXrlOGyJRWwN7BSSPWokgDUva8BkVpw2mpJvG
X-Gm-Message-State: AOJu0Yz28ZoCWSBl5vagyvAc7bAmaEG473HUdL1TYSFokRKlurwAZPzT
	4+nQPxm1ibCyQZC4D7Mky0c3XKAx7xgByRWmJCiPcLt4CHcFMmXVwqtNrqGXaw==
X-Google-Smtp-Source: AGHT+IHoJa7bbkiP1ECXcG+3tFD+b5F1r3w8QfqN7nBHI64J45Wve6eVuGEOZl4NnqABF/4oJOd58g==
X-Received: by 2002:ac8:5955:0:b0:432:ceb1:c8ed with SMTP id 21-20020ac85955000000b00432ceb1c8edmr2001056qtz.37.1712233424738;
        Thu, 04 Apr 2024 05:23:44 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id bb19-20020a05622a1b1300b00434508cfb62sm584945qtb.79.2024.04.04.05.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:23:43 -0700 (PDT)
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
Subject: [PATCH net-next v14  02/15] net/sched: act_api: increase action kind string length
Date: Thu,  4 Apr 2024 08:23:25 -0400
Message-Id: <20240404122338.372945-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404122338.372945-1-jhs@mojatatu.com>
References: <20240404122338.372945-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Increase action kind string length from IFNAMSIZ to 64

The new P4 actions, created via templates, will have longer names
of format: "pipeline_name/act_name". IFNAMSIZ is currently 16 and is most
of the times undersized for the above format.
So, to conform to this new format, we increase the maximum name length
and change its definition from IFNAMSIZ to ACTNAMSIZ to account for this
extra string (pipeline name) and the '/' character.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h        | 2 +-
 include/uapi/linux/pkt_cls.h | 1 +
 net/sched/act_api.c          | 8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index f22be14bba..c839ff57c1 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -106,7 +106,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 struct tc_action_ops {
 	struct list_head head;
 	struct list_head p4_head;
-	char    kind[IFNAMSIZ];
+	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
 	size_t	size;
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 229fc925ec..898f6a05ec 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index be78df3345..87eb09121c 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -476,7 +476,7 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 	rcu_read_unlock();
 
 	return  nla_total_size(0) /* action number nested */
-		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
+		+ nla_total_size(ACTNAMSIZ) /* TCA_ACT_KIND */
 		+ cookie_len /* TCA_ACT_COOKIE */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
 		+ nla_total_size(0) /* TCA_ACT_STATS nested */
@@ -1424,7 +1424,7 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
 	bool police = flags & TCA_ACT_FLAGS_POLICE;
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
-	char act_name[IFNAMSIZ];
+	char act_name[ACTNAMSIZ];
 	struct nlattr *kind;
 	int err;
 
@@ -1439,12 +1439,12 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
 			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
 			return ERR_PTR(err);
 		}
-		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
+		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(err);
 		}
 	} else {
-		if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
+		if (strscpy(act_name, "police", ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(-EINVAL);
 		}
-- 
2.34.1

