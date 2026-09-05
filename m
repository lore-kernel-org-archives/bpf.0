Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9301E5B88
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566788; cv=none; b=gtMKT0Z1icq6ooG0fbzGi94tJ5Zj5gDl8aN+tD2dGBGp/xRKLYFVpXeXmx5ctqOOgyEIU6OgBOHKgx5iRL9C11raMHZbBo/Bs0tfuVeTZu0ZTJettci8ZsfpdDHGnzE/UKpwbPxyNrZwrTWL2WeKmqFszopSX3N7wyL2CF78jvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566788; c=relaxed/simple;
	bh=Vdq3HsEYvu6U59xCvMXq8QSeLp714AUvyFYhF9Brm40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvZA8pNgENVra/PDFShxBx+2nt9o9RtcsTUkq8gcmQpEj+whktn6CMPz+97GMvMZDRUVWkL1gnQbsQv+iBhK1SOCa7wwxEpx7EiQe4R1LFUY/pLCKw4n+KKDmiVFDegSn6fsnq9hc/eDrf5jcg8mLMHL2iGly+rxPv9SbI/x5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz8I8mBZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz8I8mBZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso14898035ad.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566786; x=1789171586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15VqCCS2VXO8ujPcwHPYxsnQSFZmYZsxDPBiglKRxyg=;
        b=gz8I8mBZV6yZxuEiMaWmbHNANes8Z/uwAwT5gdB2XgSV9iDdQuleamY5CypsR57qot
         y1h3/OV2uo3WKo9G87hRZTyhSYJXrk/o9b6DiGIk8tloklfYHZ8kl2bioO/q9/dEY9s3
         dn2XWsdCQlmNqlL1jQwl5HwJGE1Omw4k/oXavUh7TGFdvUwHp54NkmVlU8e26PUB/Hqj
         Ay3oZzn5NV8+EBM2nINaMCZNYkHh5NjDCt+n5pXKRYJ0z97pkdxUww2bf3hRZ5JGdfUb
         NmgERMjleRHetbFW+V+JgYQE1SkVh5FkauXvrF1Fl4/W4c9cJ33CUlVIZOAXYfL7WX9g
         /kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566786; x=1789171586;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15VqCCS2VXO8ujPcwHPYxsnQSFZmYZsxDPBiglKRxyg=;
        b=VFO3LZJ05aMkH82z1sRs5R6bAONxrrWl7+TC8blABVI0nqe54gQ8F+2YLMBHiqCdYw
         5vjrQe88f5rWqaVr44GS0ugYc+G8GzrPOySC+hvcQGOBrRRF0YwifBOP7D5FmJZQT0xz
         qBfymDIEVE/M60LblI0JPZKTX3SNi3gbCOyd15380uMLU8JQrChVhH6Ln5ErcF0C67rn
         3znK2rho2QsYX6NS4Yxu6FfTjkxFuF4OOiSQeixc1aK+orCtDmccscQ6UD6+ohS8flrx
         OdLXvRTnIJntlMiHNOzRQ+4okB7MZFh2bVkx+xnwW4o/DbIhqgyb1Xhp3CtsXVopRjwG
         tOLQ==
X-Gm-Message-State: AFuF++lrRSOts3rP7fH9ejpiv8lwwQ+AtiA91clUCHWaXkjP5TZi3tNI
	CEqxG9AcuxvJMUXJ6+GjOlGjtoHRnzlZGkonQEHDSRE+FBroCLA91Or5eI/qY2urhuY=
X-Gm-Gg: AYBFou29y3Vclxviq6B43A3v7ruiSbvc8l7JuM4cP/v/+aoZk/aKanhzvNxDGeNEDKb
	KEkNpYLnz89rF48NLLTw87fqRzyEasATqjMYOdhJxMr66O/BNBlGWtnCrifrC/uJ2ecyVnZ/iYU
	NBr8g1DXTabNGoICRAbxXgMqNCd+TZvPllLIFwRhuVzIALXPxhIVq/bEWZaOrUWsBuSEX78sbaX
	7Y8l6/ZqyGIhRCg6fCn1OQTS/Dk8UpE8Mrw2VginvKvCkdswJggVVCyfK9J1ZIsL9ZNtH4gYSTP
	WLrGks2mZB6EpUJa6W7EkdEUm/MKW3a9u3ikpKJl/+uhEfQIyWoaX2S237DOPT0I575e4SPcnIW
	IsSQNvORfWsZaqWenS0jx6jG1N8C6Q0S/493Wi/B1vVkvbKBDN401IoT9X6V9yMAJk7sRarxVAP
	Ac+K9DcvVEAFUW4CRcUJmRM1QHENRB58Y6e1P3AfkbPawVpDPfYk3G6iXCJwgVG06qR/U3dT0jx
	gcvC1bry37ziNkTrR54yCpUGUxuHyoEuKvtJPWDVAhl9+kLaUWnYneVyA==
X-Received: by 2002:a17:90b:4e8f:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39b261ba63bmr13490904a91.11.1788566786197;
        Fri, 04 Sep 2026 17:06:26 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 07/10] bpf: mark a NULL BTF_ID argument of a global subprogram precise
Date: Fri,  4 Sep 2026 17:05:58 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-7-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

btf_check_func_arg_match() accepts a NULL register for an
ARG_PTR_TO_BTF_ID argument tagged __arg_nullable and skips
check_reg_type() and check_func_arg_reg_off() without marking the
register precise. Hence a checkpoint created on such a path would
prune against arbitrary scalar value.

Fixes: e2b3c4ff5d18 ("bpf: add __arg_trusted global func arg tag")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2b3d08097806..3c3575215899 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9767,8 +9767,12 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			struct bpf_call_arg_meta meta;
 			int err;
 
-			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type))
+			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type)) {
+				err = mark_arg_precision(env, argno);
+				if (err)
+					return err;
 				continue;
+			}
 
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
 			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta,

-- 
2.55.0
