Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F21F5EA
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454531; cv=none; b=WAGi7v1ylZJWQco06xyRLaWMFW3KUuCmPrSSPvGufPfb4Wu8X8rUidFFE09RODd8tWjKIen7iZXKnrZ8XVTIoSTnZPM4z96kGi+VSdqXNRj+ejPC0E/UfS1HYt8dQZ3xPeziCHSNKjhOwBo0YZ3w5KtCj4GV5y34VSfnYVgP2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454531; c=relaxed/simple;
	bh=2obfrN3xukBlw8gUZrMELYjYemu9iLsVISnT6DiONJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOWz43iFmfV6NsCzPNCTGWAA5+cjxo3X+gXHjskq3G+kiL6v/srO4tgc8mAUFTn7AK+ud2GLJsdYF11h0op2vv4nUBE+WCfHoLdhaQ/mZb//3WsW+slGoFrRPNKZG86qYMjIWppdyCo4uVuhA6xDWoHqD8F4xzA7fUPBcvWPqS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfb08vpc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfb08vpc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad9a9be502so17206715ad.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 19:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773454530; x=1774059330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM7fg0AcCxqw0lX68DJdhcMJr61PKTQOot6DwWedJ1Q=;
        b=Vfb08vpcBqzg4UixF4n9E2k+q9lTY5Olxe6Mqc2/7MswdhSUjxeXbAstvxox6L7GZS
         PK892CdXliiKXEwvBnmO36nLSgfpx3j3EeDK63oZmJ8uhTEvpN/l7lAeI7NxpyDfvrlJ
         cl44LW9A3cye2i4hwdNqCuc6Xc8YBioamdCMO2TpnGukgm1Uw2txHDLRu+Bj2bUceAxu
         wCHtQIUih/mOYXYV/hkRYGxXxzn3VGLYA70aPDm3QV09GAq3d9YaLCJzqWKFzay6rZP1
         clC05ncZxhE9gcz71eHcfc4QtOl/nzcDGj2HMbUqIC1LcwmdcTzj3YlLQT46OMoOQ5+u
         jN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773454530; x=1774059330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dM7fg0AcCxqw0lX68DJdhcMJr61PKTQOot6DwWedJ1Q=;
        b=Tg3wjazbsJwPUmnbP446R94QYjBwJunAje6WdybNYazf9JESxOyjtgrT0SNXBqyFgh
         G1/kPFu9uYLSRMBsAOg8AJiPMDy8yqdxunOzd/N27hahNSJ5VdUHro4qYXnwHF9MnT3T
         eBBMFczJzPXTSCXgLxaxlA5/18HZ8QNtBMceqrldrM8mJ8iNxLD5n1f94Hw7xdEYllIB
         sp2W7dxzUK8DTQG+8xwKfKtxUw1BNeiuApFgvC1WLp+W583ABmrCGPqAPp89BM2o/GI6
         UuYwkFf20EzMT5Ly12fbPEdgt6Xbk3CmnSxihwUYNuH9Bjr5rxWIhLGmehZmLugj3BP2
         WR6w==
X-Gm-Message-State: AOJu0YyKhBdZSLvcOrqvd5rGd5CtZcxZfTRAT898pg+eCX7vA/8jqCbC
	fzlGBfbyltLObjfvfQRiHbgBOuDdsG8CPeD5ctO2csta914+R84yAHyXeHClnO+ouMk=
X-Gm-Gg: ATEYQzxInK9RHBRKLntscFnpY0kl203ZEiF5AR3GY/AQ9HEsPEWWxxFOCfXhkowsn1b
	KVG7ZEU7jUrF+ifBTu4r/kCuyG3WPtdj6XfQdXfT3cLi+y3UhKaIqxnj/1F9afm2n3mBY05KlJR
	sbPxAlFwGaI4li6UItOW/nXOZ4/cqI7qiDTqt135ZLTR1QLnDjnribDIiOWDBC7Gm74Srk7E2NZ
	pRi4JTV1SXR+qBn2Cdu8wE4SXgYOz5Esdxd5d+kLFQYriOiavaKIJmngZ5889iktOmoZI3yHB/9
	iZ/pFLtkWvPrqWkFN0jEDJipnfoTuZu7u21gBcuVrq44XQuxgIotf6FqXZ3v5lubSDfiytGpDbv
	mKKmgaEFK5ghXzFV4I4VECbXdVVocDLxKuzKYQyBwkEFPIqkOvu8vugMgds/yZukaV+ZosVvZse
	JA5VS3pvw9+lP4oZYOWWMq6vaM5qg3ZBKvBXlSZNv8gNdf+eiiQ1jbdasBKKoeqomNK+JNzm64E
	Pm9ZDiJKg==
X-Received: by 2002:a17:903:19d0:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2aecab22c09mr60070625ad.30.1773454529526;
        Fri, 13 Mar 2026 19:15:29 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece627683sm33450305ad.32.2026.03.13.19.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 19:15:29 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	ast@kernel.org,
	danjwade95@gmail.com
Subject: [PATCH bpf v4 1/2] bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
Date: Sat, 14 Mar 2026 13:15:20 +1100
Message-ID: <20260314021521.128361-2-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314021521.128361-1-danjwade95@gmail.com>
References: <20260314021521.128361-1-danjwade95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
source operand is a constant.  When dst has signed range [-1, 0], it
forks the verifier state: the pushed path gets dst = 0, the current
path gets dst = -1.

For BPF_AND this is correct: 0 & K == 0.
For BPF_OR this is wrong:    0 | K == K, not 0.

The pushed path therefore tracks dst as 0 when the runtime value is K,
producing an exploitable verifier/runtime divergence that allows
out-of-bounds map access.

Fix this by passing env->insn_idx (instead of env->insn_idx + 1) to
push_stack(), so the pushed path re-executes the ALU instruction with
dst = 0 and naturally computes the correct result for any opcode.

Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the verifier")
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9e2380327..68fa308520 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14206,7 +14206,7 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	else
 		return 0;
 
-	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+	branch = push_stack(env, env->insn_idx, env->insn_idx, false);
 	if (IS_ERR(branch))
 		return PTR_ERR(branch);
 
-- 
2.43.0

