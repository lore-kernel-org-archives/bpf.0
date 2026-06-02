Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6538657D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433182; cv=none; b=WYdTx9W5/kp2pcStqytMx5EMfPGwjaYNG52dTvFHcn/ED/fobbDTS5ri89cR0NJvwFypGLyDmdWxeOjzBsvlEW7RazleqhOGtVluGqJicNTk/hOMkqdD3qFd+B0oQ7+HttYYkdNGxLiYKdpId+lrIlFF6Jsxg4mR/k15al/6lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433182; c=relaxed/simple;
	bh=MGnJYZ/GvqucQQodRvkdGWuIE46isfMrvhQisy0B14Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrCEfmniAlJP3NFkoSN2zlGP0tHyI6xDhADn34XuInImuRblle2BeP7kNmoAbP/mBWScfc3tqMpUuweCHF2ZYSqhfSPQs3cFsMdXfjRV+HfNn8W4YwclqnX/yjA9nFWcWrEYrfyng+KdDBX26zfksgNbkfH/6MrewqX6FKjgMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqjH0YRQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqjH0YRQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-46019edc13dso675715f8f.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433180; x=1781037980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9IEJRWhGXUd5wfptWkX+Y5DkYi/zOG+ZFCPXPI3eAM=;
        b=eqjH0YRQbIp7IequvWGmNko0ym8hcqJUBIUkHaXpH1ZlX1OXT+gFm1c3+TIwmvXKTi
         Lxxljex1up9HgnY/xJHGDVWOPwrLwpi7YfFpF16xJ7BNgvZhGxTw7m4EZEIW/4vmtcJH
         Qvl3KQ3TbSzlKETkynO4Qvhj9xlcGj1dFevZsuyzxY253RpW53hujbzUnLlryDtjWW2j
         TDJ21GCiphGXuIQJw65NakXZGVQCOZeXrFy55wnR/hzu5t9y4WRhv2zxuR2EqPaLf9mO
         fMybAQylVKlwzgX3ItS1ftHzXH9miIG/STZxU4blfkYH1l70hCvbOihFYwF5wUqD7eZv
         pJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433180; x=1781037980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9IEJRWhGXUd5wfptWkX+Y5DkYi/zOG+ZFCPXPI3eAM=;
        b=iVGKqGNiWYT4q/7MbJY2Y/WoEUqZIj+TVA5dDKE12ySG8BDKnGFNR/GznJ9+tzMBLj
         6Ttmq2jZggDUccbexyn2PSJ+hPCijLlU2TcurhpNeWwQ5D5RmBn2pfgWIHP7cejJdjkv
         e3D2KH/uPG5lHzuE2cUYytgyKieJLUXDmytJGI5dS2kUFlSIN2mlcdtZt4BCjVfvQVGO
         5O4pOg2n3ehBLZfx2ldjP1qFjul/WqjciBjrWpl0tgV/HGkrl2w3PVmzWwj21eQVtQ6c
         Vin6UdEIq8xcK6tF8q77tzJ4NYwcdGUzUpJkYmQDohbUrMSZmaLXz4R8oGD+36FAW3oG
         ukfw==
X-Gm-Message-State: AOJu0Yx9dL2AvQCzowxLmXy4Z0KK7WDiojiHC91uy620M7IwFp7OIZlT
	BBzdLYsAiRDYW1rvcS5y7NK/Z0jccLDh99CTk8+rbM5wrXmcaLdXnMu7
X-Gm-Gg: Acq92OGCpf95mbyjjj/ML88EFzNMiLCqH/ALMWCH9lAy8Y8aDlVWWlKzq8b4+4xZl4y
	z8LpctlHE6GFx1wNqU5/xR0fL1ZZiO2atjhqqsXTBNOrS+u/hBIU2qt1CJ7ZzoE63tiF7kbhJAF
	qe2nFIbOFHX04/nLLofA7tuj4U5VnOoUUnIqAmPBr4omK5VbFlf/rnTtYZKAbm3maJShuKeo/S2
	KzfsMdInXWOtQpSdP5F6c69+AKPvdYTMvlPUNXbnDhZLqWtN0R2B2kB2fSPUWCFdir8bk6fdn73
	y95c7A4u+16lpwzhU8VTJ3ZFbF3POZxJXYdUl/2nmS13bSASq8MHObSY6eSkBUoQXfexlJFUGeJ
	a4Zo9dPbqRd2HZNwAuxeuX/4bpzADcCI8ag22mILJVG8sqMTsxQfx9ZCzyKDdiZoAgc3ckFTQow
	icGb5AI5+dxYzyp0jPrRWH+7mh
X-Received: by 2002:a5d:4d4c:0:b0:452:3677:3fb3 with SMTP id ffacd0b85a97d-460216bdfa0mr194338f8f.1.1780433179550;
        Tue, 02 Jun 2026 13:46:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm1625443f8f.22.2026.06.02.13.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:19 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:39 -0700
Subject: [PATCH bpf-next v6 10/11] bpftool: Add rhash map documentation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-rhash-v6-10-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=1728;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=LPUl325KXGW0z58tRRgqUDpIjVZq/nr1dAQYcVgI3V8=;
 b=kzVnwkHYuxH+KxK+/+pvz2rAaXvEEt4hkpqiCXJDBHE65OPItLBEXQfkrB46GX45HSOWBT2UR
 G/GRdjq0qJ2C+xO/CGYRtmJASvyh9gSLM7YDT7uI90ZYnIbbK5fZtwf
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Make bpftool documentation aware of the resizable hash map.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 1af3305ea2b2..5daf3de5c744 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -56,7 +56,7 @@ MAP COMMANDS
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
 |     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
-|     | **insn_array** }
+|     | **insn_array** | **rhash** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4..71a45d96617e 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1478,7 +1478,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
 		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
-		"                 insn_array }\n"
+		"                 insn_array | rhash }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",

-- 
2.53.0-Meta

