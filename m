Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72A142E9C
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376931; cv=none; b=Gp+gos4o1M5sj50nx3WUOkimDEIDybigfzlFB0hNMyUTUoLckisIurpmbw4A+wKOM/IMMpOBlfDRQrtKusD0gHKQBRZ0sx4XZB9GODu+1cig5hmDbDPHgQaa+3hhTd5mpSR/YCQABYGOxAK7BwtMZkE09l4zZZjj9acQsOWPgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376931; c=relaxed/simple;
	bh=pmrE0tB2nY8lwV1dSjWtH/s+ULZ2Jo17jGtGZW1/4rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWkgyCdyB1DZbmiqVJjRsgXJxEPTeyA46k3JQy/TCzqxZ9b7xOpLAwERsG9SqwVxK90EjjyW6K3l25ckonE9Kw1fPUe0IcUxEJpN2zZ1PBH2HSI4fQeh7rpl2e7CWhDutN+vEBLLNwR+V56UEs4VSVVdzjUxYD32izKKKBqQqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=xktRfdqn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xktRfdqn"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc742543119so4093883276.0
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711376929; x=1711981729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EX1hV3Fl1YfB4PTy0pJ1+sJmHAq7d6j6l+c6OGOEMA=;
        b=xktRfdqnQbm9AXlDbGKDnSCE8TQQyTLPPB3BC18uzvh6ObH2q/FG/PiJmrwksK0TvL
         ug6G8bpl02nHn7NwxG1RdbcbdfquzdqfVQOVvFs+lJNA+pFf3rfdHsFGAsvwhAGMK1P4
         /bvwU3sDltoCroE6coRW9jeA2pGIOCcz4be1saLpLHlgiVsfvxS6TJBOgF27pr47lcSa
         eRibYCEk6AY9Wtcym94imeSY/hYR9HGsedztfXQzI/TDv/5CN2rbfQRJCu9Pix1GlSZb
         zyStw0PcYhU6hIAgZ4MODwrEGJI5hLWJdGwdiZw2WMFdLw3s52TSdD7XE8NCeLtYyiV1
         7pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376929; x=1711981729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EX1hV3Fl1YfB4PTy0pJ1+sJmHAq7d6j6l+c6OGOEMA=;
        b=Ttlsz2e0lr7Sxf+RHqbteawnR/rZ3tVasW5Ay1pvW2RHC/bdYls6krljBXdvSV3hxF
         LL/VMyGSfifwSYc1aXONgnwheemYKcMtNQbp98U4pEQe8tva6NSkXVfJuSB8jNjqcBZa
         xn6xYtAROpcPKaq7W26YncGov+bHXhqKkLf4UIIn+ksTQ4ZlRzoQciNF8+t8mCVmuHX4
         w2D53U+aMqCNi9+E5d5EhH25e9FlcxUFN3joZGRzzM4eFud4Zg4K3w0+qj3iqCMsnvZ3
         3Qz7ja8LRW/p4JmQDYWBWlrGzQ9lS4xxhIinGQBfVzrlb+9UfxCqV8+T0NxhYV1wbLhM
         7oyw==
X-Forwarded-Encrypted: i=1; AJvYcCX+51vQ3Vgwqgx8YcB3Rd1cUsRKpyN4ecmbeMfdEcwbvI++iT2gqewHD8mArrBBv6pYZo5G4fCoGjmT+zXgl1HV3zav
X-Gm-Message-State: AOJu0Yw1mVLr+ZZn7AaIwMHnUhV3HVPdn0iUGi4vFhTO+O2YoVLI4jpb
	yeMqB5EvdRNYsCX3xPlCx8C4SBd3fUb3h7XlDthmmGjRwJFzSHUD9AEaz72WYg==
X-Google-Smtp-Source: AGHT+IHM+KpBypFw7UvyXwaAMXG4NofG0JQCxRBmSP+xYnwXXepo62Wf1Lnu+BhtQlMQmL1onWpiag==
X-Received: by 2002:a25:4e02:0:b0:dcf:f535:dad6 with SMTP id c2-20020a254e02000000b00dcff535dad6mr3868196ybb.56.1711376929057;
        Mon, 25 Mar 2024 07:28:49 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44bc4000000b0069687cdaba3sm1729255qvw.36.2024.03.25.07.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:28:48 -0700 (PDT)
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
Subject: [PATCH net-next v13  02/15] net/sched: act_api: increase action kind string length
Date: Mon, 25 Mar 2024 10:28:21 -0400
Message-Id: <20240325142834.157411-3-jhs@mojatatu.com>
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
---
 include/net/act_api.h        | 2 +-
 include/uapi/linux/pkt_cls.h | 1 +
 net/sched/act_api.c          | 8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index f22be14bb..c839ff57c 100644
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
index ea277039f..dd313a727 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index be78df334..87eb09121 100644
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

