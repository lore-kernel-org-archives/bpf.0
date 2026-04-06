Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB6397E6C
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504652; cv=none; b=Ib3RmvljOi2B8P8SD3lT/Q6hKnSSSTc2XxISfoU4IHrU0cth3eneq0BP1wjqfEtuB5PZy/e59cl6q0kYmv+99qGpXpF2XnwNdtrGfOATs0V9LUWhk9u64ddukBeSfXhokixMGVfOec9A7yqwdq4yiiIqJV9bpYIURCbkwqMaHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504652; c=relaxed/simple;
	bh=NRGoKvu5ZhkzjVJydlyhFleI0DNN1HXfpOCVOcpw4Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzI60NCrDf56+6A6c1fZ3UYbsMF72OKMhawJzGkOJrVyLhknjB3/nmqFhWXm0leU7lAmAJq+hG2tAcpihpMrWsuNbJyDGBUepnUdmVxtB8OO7tvhfcnILMey2flnpM6FGYtCsy4WTTHTAEfsHNIdn7k+ATaflHFCQOa9AUprel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqkXmyFu; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqkXmyFu"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d9bba96f7dso2238711a34.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504649; x=1776109449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6GaE0f2tYPiwFhW2tIxlKKZjz9wir0Gp/ON7anT3VE=;
        b=KqkXmyFuptsG4I5nXg4jIw4PoDL9bgsEH+BoOOfqucQEqK4d90ypC0rsZekCZRMQ+Z
         UU6CZ74BmWV+t6Ehu69PBEKK8TSt3Axcm4/0H41KNu6Sat5zD8IuitOJqvuajglFwmLL
         g4SzkzDsVCWSq2vyTkEFRxs1TNO1jGQwEJ2ZqWi6l2YAsCYLyhcEktIyqACI8hmpmd2W
         O9X99wqBDmRRqdF6IeTSG7BErMiU6Yicz1s7sDuNO7k7gGLkcZmDC/ilnLZSol8VpDyW
         LTvh7BdA8QqAyJ/CzTGccAAe+vp4IMJxkqMat5GomcpmDGppt/XbM1vZSSENl21W3VJb
         C+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504649; x=1776109449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6GaE0f2tYPiwFhW2tIxlKKZjz9wir0Gp/ON7anT3VE=;
        b=VKi4/7DvLMh4B6Uy61yeS50BuxVSVtjrXTH1x+TwRyYQCRykJpDTdXyySSM2+8u1e1
         35Zuv26+yOdbK6cuoGw0UW2Oq2RH/M5pRkINyd5NzTWvfTjKh2QavSr+a6BbMz3778Vo
         0ng7/JI/+o8N+y0qzJ1C7ERnMjFauSigGCdyiurpnnQkZdrYljND60W2eNZccieRmMFX
         JZUIsHIahCGbNLAuzi4amr8TB1W0TD0W/eiHoRd+kJRymWD050PnA1dBtfNjttyJgo8C
         PLTogwLvtjCngWCQjxTxvnd3dyhcVOiy+Gb4qCDdHK6Sx92FDiGOxVLtUBNVg5n5UjVX
         ENfA==
X-Gm-Message-State: AOJu0YzL5VjJUHVvcgNJNexRUsEWSosSOLCWdzXj1xdIo/axgvPMJQOH
	dxRSESH7AeY2atV7GHbdzkI7mO0ltBGJT1e5FF58D8AlNVIpaWkHTubUm12HBbkpcsE=
X-Gm-Gg: AeBDievNC9vLaztzAs50g8IH8qs08pvDXGY6nUpKjRJYftj6U7XLG4Mi6Ks9VOYNW3+
	ejjNIdXxCSWtiAVGYu2NnVzCkjzdQLV7wbHg8AHINGtiXRg5WdknYeu2/dWroLBml2UadnmsP8a
	j8hESFgQqyzMb6x/GJGttmgL/rlc6N7rSoRNdHfzHnP60Zh2vOJcHbfFB4aP7aiMAhJQ4MVfGa1
	+hQfATfwNMmuLIHHDZEvyjW9V+7mMC8dOwHqiRRbDHLqAd8VoXv0W7Ghrw2oPXRwODS6xd2mLsa
	IhRBBjyVOk0MIKxfUuMOxEeanF8cuC18ZkLuLcgeY+oiDO2Dl2BvG/wmCKidpT943Ba7uWPInlR
	Un9hHGPo0k9y3OShLFvy94FyScLoXDARW+mlvQSIshpPIiW1AKi7oUAysfLuUa7W07IOLWZQMlf
	3Ej+nAbQN3sEcX2v+HqJzWxkheG+Z1W+NR1RjOmYyzKgc=
X-Received: by 2002:a05:6830:2992:b0:7d7:d54c:5b53 with SMTP id 46e09a7af769-7dbb730d7d0mr8972650a34.29.1775504649514;
        Mon, 06 Apr 2026 12:44:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbb5c96485sm8368068a34.22.2026.04.06.12.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 2/7] bpf: Enable unaligned accesses for syscall ctx
Date: Mon,  6 Apr 2026 21:43:56 +0200
Message-ID: <20260406194403.1649608-3-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406194403.1649608-1-memxor@gmail.com>
References: <20260406194403.1649608-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=791; h=from:subject; bh=NRGoKvu5ZhkzjVJydlyhFleI0DNN1HXfpOCVOcpw4Bk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMKD9ulzPUFfv5Wlbm1N54ILdT6/Zw5VreUYTvDhoshlRvP 6vt0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKcSxn+l8vfPH9psoa+/DfJKVNX35 9i9fGetXHD/X/neqZovYrVd2Rk+OCtncP1m/FyS+BduQDd+3cvz839q1O2qJdHdu5zSesnnAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Don't reject usage of fixed unaligned offsets for syscall ctx. Tests
will be added in later commits. Unaligned offsets already work for
variable offsets.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/syscall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 810991709da7..f1044ab9b03b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6386,8 +6386,7 @@ static bool syscall_prog_is_valid_access(int off, int size,
 {
 	if (off < 0 || off >= U16_MAX)
 		return false;
-	if (off % size != 0)
-		return false;
+	/* No alignment requirements for syscall ctx accesses. */
 	return true;
 }
 
-- 
2.52.0

