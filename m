Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A63E1D01
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924022; cv=none; b=YOoX0oU9NDgDyzEGeRJADLJ/dhOzG9bczufpUQS/TUaNC/Fp2auAKkzCT0r8j92s9Q+lGJJS61EBnAcAOu4q5n4xt3eX2W3VRiE+Ie3SQHBla1p0AWcsn70Hz7f4hCuuOHvFkLaJBr2j7or0cNpucfhmMzmMvQNoVvpIrt1PTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924022; c=relaxed/simple;
	bh=IDOsraDOE3K+s+EjkoJqwDNghjg+p0z120razAVbZ2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pShx1sy0+Ndli8mnkPep1PnTVLPT9wqe67a/yteX5rkUaqsCqw1k23xRjluG8h2+cP94A1HYYx8OyAzfDbJHT4Mc01FpBsk0vORWpRRmksT2uv/PzzUc7fgun+ih3nDzATJgAQ9ZQ3ZtXZVGYirUfEZA22CbRqba7xuV40M7cPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARcdGsi6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARcdGsi6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so8040285e9.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777924019; x=1778528819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSTUhyLi+vVO6rXFjwHstd76fTIESRpR4flHhgUU1V0=;
        b=ARcdGsi6KDWiYyCJB/g9Ytoh6YkNHS+4ok30rlfLlGxiYB4h5zQaMTkHsIcikjhW8m
         v2dWqih3VpVBagFwWh/KiZD5+H56/BMI4t1lnvPpskhCu6v2dhIu+/4VZ4+Qoda/fKR4
         6oesk49il2zh09p5M7x2fS1zjYUKWV+jV1R0LVVR+chvWQKR0P/khK3ix01AWs1Yoztz
         UKLhozN25RSJADf/lV+85WQ0Pj1PzjrFfo68wYHjLFvn4Doh7ohfXtb0Gqi+LmxJbPyh
         4bfJORLEeKnTpfmPlxuqmwPYmijpWySFWbkrehWMKLBrCo9H8gX3tvuJiBLyavi0mkVI
         OcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777924019; x=1778528819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSTUhyLi+vVO6rXFjwHstd76fTIESRpR4flHhgUU1V0=;
        b=GWfP4gPTuOg7F465zKRWDYdUyDmevWMzImFjsgBbwH+NN5hc3AvQnUP1Cbr9EUTDRu
         mB69crIMGFpp+qQEnLp4mylB5At+U7NFzjsBAIoPCDWfYxDk2Cv/VYxhIlXp0LxN7fCJ
         XUMiRr+sKgOjOs8g1HnnmDTiBGN6phlWFS9dIyUJRCMDpJHU7a4V/L+pA6Gqy/h+ySj3
         Dy9wybnKPKiBGvCHK0iFi8yPR4DNie6GWW1/wbBiObKSaTPsH26hGrf7sEw8a7OHpYZ8
         xvvBJm7yuCHMngIEt/IYb8wVB7lsytu8yhXYx8HqEZ5/OzCD3B/T2BHEsqo/m5Wyto8i
         6GRQ==
X-Gm-Message-State: AOJu0YzGBxLHAi/uMEezVlrMUbsSxsyegKOxmJURgjBXDtup6tedT2DR
	1Wbi+yzy9lvbNtfQr10KwgsRrRflMMmrDG/amDvZMtkvwCfFhG5qH2DqCWRSLKu3aME=
X-Gm-Gg: AeBDievtAoalWxrb5QgO1Rrxgt7+/EAV2yyXHApaEKq3KvKlvJs9VRvDo8ZXsQucnVF
	VSZpTTMioqwSDvNHvo52x2CpfUBRs9+bimx2AO+UDf0k2U+BF5MXFJ3f62PAs9cL1MYPjNiir9A
	EPBsCZkTX6TaGXtrud5F9NT01piaPKrvKFDmZkXdf9W13fBXdTNPrfAUgNnK5Jwxsks4iQfgVpz
	vHLb+imCfMwS/DrKxg+PKxm9UxSIlgLp38xcxEmxLZ4WpW0GmvcVZ2KJR9LkB7us0NGo0DLPexO
	W8NN0Tdqpf8fNDbwKqYJQChjmTtIVpjYPX+FWCapIX6K5CSL4Ov8DcgFt5pgr395Jz05D0v81xA
	JpPo3xYyUmdUyAePVpVmHOoeY3DNrW9xKNnbjU8DXRRq0DbPoDIudcFh+VtRvVCGcV+awVXnpwq
	n9zbLwS3HWMNc13809bnL0
X-Received: by 2002:a05:600c:a46:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-48d185e278dmr34975e9.0.1777924019428;
        Mon, 04 May 2026 12:46:59 -0700 (PDT)
Received: from lucas ([2a01:e0a:354:c290:234c:5dad:48b0:9188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm619963025e9.2.2026.05.04.12.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:46:58 -0700 (PDT)
From: Lucas Poupeau <lucasp.linux@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Poupeau <lucasp.linux@gmail.com>
Subject: [PATCH] samples/bpf: add SPDX license identifier to parse_simple.c
Date: Mon,  4 May 2026 21:46:53 +0200
Message-ID: <20260504194653.52760-1-lucasp.linux@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SPDX-License-Identifier tag to replace or complement the
existing license text. This follows the Linux kernel's move to
standardize license identification.

Reported by checkpatch.pl.

Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>
---
 samples/bpf/parse_simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/parse_simple.c b/samples/bpf/parse_simple.c
index 4a486cb1e0df..b57ac5baca30 100644
--- a/samples/bpf/parse_simple.c
+++ b/samples/bpf/parse_simple.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2016 Facebook
  *
  * This program is free software; you can redistribute it and/or
-- 
2.54.0

