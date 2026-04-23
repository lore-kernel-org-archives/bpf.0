Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F402EC081
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776983040; cv=none; b=dW0MzvUK+GXi5R3UNU3w8y29vy4pbHqxzbyq+KAxJQ7yigcV0luecQQmOlSgEUP5q+Ww5MSqxNbGsepCNJvzPmxoN/21QTh5/fxrnl7fFw4hrBMXZ3ISd/PPg/meJ+4h6B8tF1YgcRciY6CFU7oPNhOOepmtV4k/SrRiYz5Mw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776983040; c=relaxed/simple;
	bh=3MGLOZpKp80lxHgcr23oz1JZfL6KqD8v5+Rx4tNyZJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=co4Iv8UHDjGGUATz/CYDKGnDPFHtCHxDweI2Pzv2lQlU4qH1lza18na/QO+7SkzApOIu+66zyRsMsn80DEHsuW6ygx2obM3GYnEXIktbuQDcpwtgV8WCDKvYr7X/GPWiAqitQfBZJfl58p1srQOnDRQvyOekXJyazzp3GKDEJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PILc5M0p; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PILc5M0p"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso33856415ad.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776983038; x=1777587838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+K7aikbu3d3KpiPlkvmM69YJ7mz4TSGa6MsAPjOgyI=;
        b=PILc5M0pbgrhN6l4pclQvnAB5eeLQnAmiai5g89iUdK9+VAz82ato8giJHa/gIMfzg
         bjUy085lEJZZrsoTJ4m9tqm2RZAISQPp9buWSXwmUMbsslYUFeYdsenhjQae4gP/j9Qh
         zQh0Z5I9WmjZE7+1gw0ahbk5aJQqDIAehgHelZZPjwrsELwV1UC3OpU2BjIDcLy1jzqh
         1zyeW0KVk2IANBfqwpHirTk1LfljHDQH0jOs7vNj2nHMscmY5L70VqlFa/EhQXvS0OmD
         EQMhjdv5BBkomyJ4BEUavtQMtpnI4PMvz4NA3PglPLy50U0BI6e9JqYJJPwbchkdM/6+
         /AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776983038; x=1777587838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+K7aikbu3d3KpiPlkvmM69YJ7mz4TSGa6MsAPjOgyI=;
        b=rkxyR+5CnNzYHOWSVxrTovgHWARuSdhS/Puxea13MHckmOtr3muFtXup12XcxnHmCB
         V0XMHNTpW1PpGoV32eP2WLgbQKJdAaRd5vxW7zGITVOBc7CUPJJQUUEpg2draMhDGYHi
         +CP7NQ+ESevFSLRtGPBtdg0gHeDXC9y8KR08b39uQ3fPWFwth05WXiuKdcKT6J+Q+iIU
         f/xkpfkIYHEOo4q/KYoo04anNJG05jQNsxhPxruZ8wZlEWLsyZYCiJpOWv0Fw6ssUdRg
         +y/5S+GXAhb/LQA7jmZVOAqehpWv/xD7q2MhhYTkPJnh23Juo7XT8XxD5ftqo0Kwnx56
         OCkw==
X-Gm-Message-State: AOJu0Yx2NBxEjr0dxBYV3QH2bYJU5ERiyvBDogh+hy+XHooMM7s6xCBQ
	diAMEVo3cYGeAvXyAwDsRobmll9FpBJLOfqMho9UQ/EGUruSHnlxwpNDVtF0mQ==
X-Gm-Gg: AeBDievIvO8CnnLLGhX5eRzU293TUscQ+sE4DQJPCtjPQ84eRR9PUe5eKNo9aTILMTu
	FiVXy2fPD4AcVgPM5k4l0qpGAPQN4mdCs19RXyNJn/WSMvy8FCMLM6oIrvKOziuePlq1/zwcEWO
	8sIlSQ03A6NcRwgd1ELLfhI8txNrnPK6phKa8xIIA5PiB30Ju9YaOr5apxa2L7OeMa6eF+8edpx
	+bLVpcW5Oe4LkFGo3YYj5Zk5s2uVO2eMTa75Gu5OU/rs6fRBG4kuR02c2iNoVgBoTajxv3hkeLn
	CqHuP/aC9XwFxByKgNP/K2WvLff7RLpz1Y/NuzKSEg2Dd+77ZQKP/gPbr5IcfHoNOTvHY5p+M0V
	c+MYuz176PQJHWEsS89nFcPTJQLc8h5fQuX7E4aQjnDDJ5vlbAlfqL9xwk1XaDlsGi8nmrXN0yb
	JRldBMNMdkQukro+VShM6L42lFWNS0s6uc+DY=
X-Received: by 2002:a17:903:3204:b0:2b7:895f:407b with SMTP id d9443c01a7336-2b7895f4214mr125430125ad.21.1776983038424;
        Thu, 23 Apr 2026 15:23:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff390sm201377395ad.9.2026.04.23.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:23:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping uninitialized special fields
Date: Thu, 23 Apr 2026 15:23:55 -0700
Message-ID: <20260423222356.155387-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call check_and_init_map_value() after the copy_map_value() to zero out
special field regions. diag_get() copies sk_local_storage map values
into a netlink message using copy_map_value{_locked}(), which
intentionally skip special fields. However, the destination buffer from
nla_reserve_64bit() is not zeroed and the skipped regions contain
uninitialized skb data can be sent to userspace.

Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/bpf_sk_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 14eb7812bda4..b50d26a542ed 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 				      sdata->data, true);
 	else
 		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
+	check_and_init_map_value(&smap->map, nla_data(nla_value));
 
 	nla_nest_end(skb, nla_stg);
 	return 0;
-- 
2.52.0

