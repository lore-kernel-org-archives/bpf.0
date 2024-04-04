Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E5128372
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233430; cv=none; b=R74sZHuhrrd3WB1lmy4Auvk7R2Em8z2neAzqAmpCzKtZx4QFcJpkLXiS81jor+BPSpHYIthX38o3GfwUiINccAyZrIo6FlpJoc2N14RCPm9wL7Ij/viPr97Q5dRrp7NBceFslMClLBml7n03A0TSTTLGLsYVeMK1CCcaDwHe7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233430; c=relaxed/simple;
	bh=b8bptETvG84oiXi8WEQCccf8XZFYg83kzkS/2d51CA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQG8TDz5Lg0/FVryDTS4mQ7hOlUPP3XYzD182jeEHdYuY0t/r2i2SNsXI5bRbyIoXOq/NRt6pE1CvzyM8tFZPn1suCPPnDniQFDIGTlfTKNbLuGMn/IDfGAonp+hIupe7qChEUZLbEQ45QMv3Ebj6Kv5GbNSYh5p/GyNHeLIPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eJof1qYX; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eJof1qYX"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c3aeef1385so634951b6e.3
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712233428; x=1712838228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ayqzmg/dq1ZxpnFUTOb8nK1tSXrGpGgrmAqxDfILoE=;
        b=eJof1qYXcVwf6Zf86TWt/vsshpLhtV84rsP7pyxuiok7ilDDHZHSvcdDJMO/rjX5sB
         +WTKPIwWUP7x+51s/DaDNwacDXOSDTtzwtome4/wKySxeu+T2EobyLm8xIzimdSwC2VP
         WW8R5f3CixnxEGEH/FeMETrBVGpSU5ktYH5mtLICwbD7JWaau0ual3D4wx3E3OX3sevB
         wHAX/3XnsZgINDPgbujewGN1v6mp/n//MPqaralM/4iO4M1n1VCHosg83kGlpuNzNdDt
         P8OMj2kpAfxIzdxCK6YaXy5pEDocXKgHa5xWgtBqZq9q6zErImkXfWO8aEHC/gvnh1qs
         72Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233428; x=1712838228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ayqzmg/dq1ZxpnFUTOb8nK1tSXrGpGgrmAqxDfILoE=;
        b=qmjhfKxpscGkM0MzRHvD83/gVHjCGssIdrV+SLoCtjlf8hJI134XX1KjB6CJRu0bPt
         wnPkpb0CQwVjJcGV3mAPnV58sfnoBe6uc35sV+t14Q5av0mkWfyxUn5MY8joqhzC5rBv
         Rlkljg2yJI8xk1ybWdSEXxLf8rhi7Ewu+YAwAGANGE1fhTJUJh/XFB08IlJmW7j8fseh
         bcn3ihYpV7flGttKh6PAUWSfNR9iU77xUmrJj5+FmsQkNDB87EfBoHf66MDZ74sJdcfa
         mJenm6vl3hOx4OtupSyHhrwX+A/vPaWUIB6+5HdFBxslKstoWWVKP1IonlA0fuxPJyal
         rJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa9y/SBVOjBmFrw4B7DxQDxAEll01XUVSBSGqwZQronLexv+UVlwCcwGGgaFHV309uurK1DasiUTWWaqri3AF0aQM5
X-Gm-Message-State: AOJu0Yz+2B4s561B6gksQ9L2UhsEUOw0QkMw7U0R1NWl1O3GKgHbOTBY
	BzG9vMI+t8IO/mXGUsLA6BGH8JtXC6TuTb27C+IIFnkNCUglWfgVCeUrFm3eaw==
X-Google-Smtp-Source: AGHT+IHWBCwoTzqRECXiQ8oetTuXFAjlVIj4lwfLZn9CbSrt05E081JoGio/ZtBDJxcZlO7m5KFJXw==
X-Received: by 2002:a05:6808:250:b0:3c1:7eac:a8a8 with SMTP id m16-20020a056808025000b003c17eaca8a8mr1876878oie.26.1712233428486;
        Thu, 04 Apr 2024 05:23:48 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id bb19-20020a05622a1b1300b00434508cfb62sm584945qtb.79.2024.04.04.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:23:47 -0700 (PDT)
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
Subject: [PATCH net-next v14  04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Thu,  4 Apr 2024 08:23:27 -0400
Message-Id: <20240404122338.372945-5-jhs@mojatatu.com>
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
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 59f62c2a6e..52aab6dd8a 100644
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
index c094a57ab7..87b6d30077 100644
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

