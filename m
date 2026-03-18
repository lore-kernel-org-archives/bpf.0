Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8033262F
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814516; cv=none; b=hXz+odlWnI2IeDnGLevNdWI8x24r6+sPwXYeMM+zh55Ma9Dt3CKuqXD8dZUQs/TpS1QvES7Zrb0nFp347pjt8NG8PBcI10jGrP+GIXCWd7BT9sGR7BEuJnirRmn5mEjUCDbbsAQXgOm5WJ1nHP9w8T0lLIs73OvIpfDQHurht+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814516; c=relaxed/simple;
	bh=Dob3CFR6DCvWhrAFQ5iFGkDiY9AbjGTtgkUF+/K3rdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZEWwS4LAOSqrFJJ+rpXMoWI3ObtiogO0WfBGXw8c4KdnhP3TxzjkrKZfz6GPBOkbZItCO2o3MrarhE5aPWSy0SgTRXBNTgZ2nnV1XzyHIzWKWRp8hFUq61iVTZUfCfVr2gB+otflWYgGOzckAW9b+VoJ8YIPmZ9WtaQRUQt08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go0jx7os; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go0jx7os"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-829865a8471so6341361b3a.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773814513; x=1774419313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO+QmbA5qsZoboHmI71eTMhe6u+8jZPlbtd93PdrHF4=;
        b=go0jx7osQ0cEnMVbW31swMdDWFPN0xaLAEVy5ffJLTYAHR9BRdNt0howotpDbSAxbf
         Do0qCk0tG5ASojox9fGC7tAYHDgM3RO1hjtJRzJhHL0cfxfobznAYox+99WDsP03he/g
         7iTrCKyGqegF9pXgCli/RyvhnRwAjcd0ZUah30WxEiBCS9uErebI+kt3i30aW1BywaDz
         fcz3hzpNX7/LLTErA8RBIe5m1T7BsaCN2wHK4dw9DP0EHwfuwIy2eJR4jrKSOswpUzaK
         Qs7dRNvujCaYwx4jcnLC7pEBZPMwDsaKYbdaDbd/nnmqmERLVAWjIvIc470o8EZrrDr7
         2Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773814513; x=1774419313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO+QmbA5qsZoboHmI71eTMhe6u+8jZPlbtd93PdrHF4=;
        b=tR16XVtEqZWqfoyPEfsk/wOB9tvNGujMUHY/7UFJvfwW7LpUMBwkRD8KJcbLEURfA7
         tDvxhmaJctumJuF9XiVu5WZB4qhrYsaftTpEizxBtjK5McHeJhsypyzNtsOiTZJYiZue
         R2OuohRhe7Q+8BXjhF6fx6sqbatmgAsvh+WOAB61MNHwRi/VZrXgQ+Sa9OgziEoTRddM
         YLjBugtXhLTGbApW/yLLXjpFlOK6subMNiRtsLQ10FRsf/tFEe9xPkM/FFHbJmFIkeG9
         /IFPNos9YddqUjZssLqNvaHVt8BjkqNS+GWtMfG0InfLMBdcoJaZxGU5Spqxinu3A5bV
         4iyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG3dReuhJJL7LmZ5KNB+ST0itINE8dYChjYkbI8JnC8qPo1RJK4VrlS5BC95aK99UB6T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrd8J7LhnvT2wk55V069azK3KR7bVE35zfTZ+uMClPO5BvibmF
	91apPPnMNeiaPcK8qGC47ZDTGyMkM6FTDf+BG4OWZKpz6x4dpwSl460F
X-Gm-Gg: ATEYQzxy4AQ34u7TAO/tPh3ZCKjBqtraagDgRkDxlMWbLRGydwJVFZk8GbkIc8JbSmt
	U1fVYENQI2qtOVVZPGscLC8zQ9rs5/Ikv8oqKZBoz5K2iYoQ0eVh13lSmDaIgdjQTMlpdnAmpXi
	z1uBdwXsTl0iaqey43RYn3kTnCEdKTcB2udDkLE+mnoVhE7/5Gl4Fv1wXJrTpEmELvcCLRplJWB
	7gXSOFc6yGeUknuyK6idX777Mizy6JmP64XHhAn9OZNMq4yTv5D1QfDRf7nCqnJlEjOf4yffJvY
	0BFM/Ukm+T4RBLrNLK5+rp4knsAzYXWymAIxgryGdAIDZx69kTNKKQf5bSCx5mHGwu6wtlU3dJ+
	siknc+FHSHTBGa+HWxlqMncAk0mBjobbkxZyF83Qm7hpR57HoiyhRgBfIWPdXwgFpIi3k9QqRDw
	ryIThkgDF9EAv0ofseGLo/KWOqj+fTgeg1bYoU2ckH
X-Received: by 2002:a05:6a00:3915:b0:829:80bd:c0e2 with SMTP id d2e1a72fcca58-82a6af0cb73mr1979775b3a.40.1773814513115;
        Tue, 17 Mar 2026 23:15:13 -0700 (PDT)
Received: from SH-PF5NDYD6.Hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bef9a32sm1469330b3a.58.2026.03.17.23.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:15:12 -0700 (PDT)
From: Ke Zhao <ke.zhao.kernel@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ke.zhao.kernel@gmail.com
Subject: [PATCH v2] tools/sched_ext: Update stale scx_ops_error comment in fcg_cgroup_move
Date: Wed, 18 Mar 2026 14:14:57 +0800
Message-ID: <20260318061457.49988-1-ke.zhao.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function scx_ops_error() was droped, but the
comment here is left pointing to the old name.
Update to be consistent with current API.

Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
---
v2:
 - Corrected the new function name to scx_bpf_error instead of scx_error.


 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f24..c0574ff416c7 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -919,7 +919,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
 	s64 delta;
 
-	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
+	/* find_cgrp_ctx() triggers scx_bpf_error() on lookup failures */
 	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
 		return;
 
-- 
2.43.0

