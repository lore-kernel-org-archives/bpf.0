Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3B3FF8A9
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365756; cv=none; b=IZaIecCHsYeFHxMoTUCgObtx0t59qFsg6yLo51lKTnk7E4GxIO99VBrG7+ZGPg7lWpN1D2JcP3bTn08fXghZ2RFSGBepQf2ubLiyLphRQiyUVBANJF9VCaNozKefGB11YFhw8u2+JS60/4nKd/LLjaGVypdOkAI/+SfSbe7vDDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365756; c=relaxed/simple;
	bh=BL6U0PGGlAvTBLFZEYRoTRsTyhNsdPgVAmSHRVjNhj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eomy1tbSFbFPKAlVBwDp0abzbUS9hYLYnaAtUAIDRyUa/f/klAvXZ3TRdVMcEdqurR9Gm5o12qiQRm5O33IKIIqQhuF2MEDqQpzgmestfrJHYNNZ1LJUCGafI8JWKW3hjgVy7M8I2YGhM9FrjLPSjZ9yNmOyY0IN8NaCRlojH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sANOGZ1+; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sANOGZ1+"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d7f09aa39fso4316065a34.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774365754; x=1774970554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk3AHP5tm6SXd9AguNLbNmgA5tkcSSHMOQbAO9OOBDw=;
        b=sANOGZ1+LXhiBRAcgeDdorcZD/dp/tZMzXKdc+cvxH16ap8KkHx3s21c0ui/3SXOSX
         IUsnO3z+5sT8OHRPKDOzlseaphZqa30OxeEI7RUZ5Fyy1CY5CNW9L624lJWZankMAmZU
         6rCtFMFIfrJ3S5fgZCKauy94L7jmtUw5i9zkNrH2WoU26njYuoridBVEjrLaumHl5vz5
         du0D16EYP5ssQPuX0KE+5RISXITxvC2lfn5TFR1ZJvDWz7DTITRG8QyCqLKxAki9ItKY
         ePysSkghERKPlz0Mo5/HA8X4WPZe/sVms63j5pb4zqGYil5Z1EXzbi06eUcSdJNw6b8s
         tFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365754; x=1774970554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk3AHP5tm6SXd9AguNLbNmgA5tkcSSHMOQbAO9OOBDw=;
        b=EYBVga7J86AKJW3VtmZVlDNKsNIRzx4+I+YSsWfiili0gtbMReURVXBrxvUIVvMhEG
         zCFa464ILak1kB2YudOBWT41/ezO7pa3JxiRWL2VmZM1UsY1VhRyJpkcvtuKZ9zl9gPC
         1uicXsWCbGCfsi0RNgtmz3zETh+iuJRr3AF5scKYC2lc5iAZv/aHLnUyLByIvA5+hXYo
         0KxRSgvMPtfYlpv6hnop5Rdlc6wLmUZd1ni+DG9Q2Rdqbqw4fsMepT1Hcx3eFJimUqXq
         0BWrHkWmnxxX7AhEW4hlrNOo48FTC4vCkmxldQmBihK+qHCizJkxzCcQcfrJtPY3LN0w
         V9qw==
X-Gm-Message-State: AOJu0YxszCGvTKHsbAewfQgHfi98gGBXofkN9WXjrPqqFPfdBTFn0683
	VFUhLw9dGNtMqitJxXSX2OHBRWJhChG6kTaAeoVKwGt1vAHX4XyUl+s6B/BMJTlQ
X-Gm-Gg: ATEYQzxNivYN9cvNCgZ7G+OnG9mQjnB9V84v+3BN+cMPhWFwiyq8jr96CO7FOGRDa2D
	D1GKvYz5SjmgD+hzj2Zfq7+Zcg3Ls+1MglZRaWGt8p8EyRmQG7a7KMEtc7im7k4gOxj2179OIvd
	YQTZre6CLeSFg8yGn2DZLmPIgm10WGnf05qwZ7GS7MWJBWZq8lyM1ZqlkesWX2AL+vv5XOw9HiS
	x/zgijXil2DSjMRjrA1zbCdgT9EFeVZjHFuhF1WBgolpNGMo1dTL1BmGp1q4AmFejTkqo1WfMv1
	REDl6NmibWZlNswCa6SbzGSUXk0aj5OBR1PKB80LRVBbj9iOuN5jKGzw0EN8/zyEogmVuNBctDW
	Jcz8tB2SSbqnux4gCTOdhGZt7d+l7Qd5rvKBWWCwtLJw753UoC71ZYXDBMim5m4+lcO+33mrl5E
	R7DHmm8IYVr+/qs4Lv7k77CuQPOEB+uNtg8iuV2UFeri+A
X-Received: by 2002:a05:6820:1b08:b0:67d:ea1c:e50c with SMTP id 006d021491bc7-67dff558fabmr110502eaf.51.1774365754023;
        Tue, 24 Mar 2026 08:22:34 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddf9d4sm12767132fac.16.2026.03.24.08.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:22:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] bpf: Update MAINTAINERS
Date: Tue, 24 Mar 2026 08:22:30 -0700
Message-ID: <20260324152230.2916217-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; h=from:subject; bh=ZNEQpwHhjSmzlLXNjREXJfKDGkHY3vu0TXAichgBnTQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPQSqN0KbO1nNGHdi/XOsD4acIf1zxV5SaB+jTzf8eTYr3N 68U6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJHb4owM+7XVJ54987lSZ0mHhkiijX SZ6Jf/SVV7fBzWaVU3Si6zYfjDVyP4QufuoW/M899eF3qhctGz5vtnYRehzBfnc9UWPWVjBAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Per discussion with Alexei, add Eduard and myself as maintainers under
BPF [GENERAL]. While at it, drop R entries for reviewers who have been
inactive.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d10988cbc62..980ba6ff3011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4813,13 +4813,10 @@ M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Andrii Nakryiko <andrii@kernel.org>
 R:	Martin KaFai Lau <martin.lau@linux.dev>
-R:	Eduard Zingerman <eddyz87@gmail.com>
+M:	Eduard Zingerman <eddyz87@gmail.com>
+M:	Kumar Kartikeya Dwivedi <memxor@gmail.com>
 R:	Song Liu <song@kernel.org>
 R:	Yonghong Song <yonghong.song@linux.dev>
-R:	John Fastabend <john.fastabend@gmail.com>
-R:	KP Singh <kpsingh@kernel.org>
-R:	Stanislav Fomichev <sdf@fomichev.me>
-R:	Hao Luo <haoluo@google.com>
 R:	Jiri Olsa <jolsa@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Supported
--
2.52.0

