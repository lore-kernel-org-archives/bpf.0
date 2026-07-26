Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB955477E
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049304; cv=none; b=OI51KVH6rtSDHvSZ5n4vIfHY+YEKHZmMNpRHLFbEBtjzYQA9JXHkBllZA5rgPmdDRMttRF24HMZuSdWQyQviUNGd3w+tA5j2lNqQ9IDAaR+c961GfQXd21rEtvjW3wviS7yrao4iy2oFsI+y8gNjst5owXt/BEji2Lt2KZErvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049304; c=relaxed/simple;
	bh=XVQ4K6t/aKmeJaXRT2NIg9IPgvotPyRWcYA+50Uk3j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKgYLwO1MN//6AqNQznkc3qG2Ell8MjHM1PtKmHf5ZQKx3BLBEtQspbacop69yWZvz+06C16MSR47LG2cwxeXjB5aoovfjGDEJO2XBM/I+U5AvSloK2sHHUcAtJI5SISVMZmLFk1Cp8b62/rHoKRJ/x2S5/EovvWulJAzj0VMsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU9IhGsr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU9IhGsr"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so26297745ad.0
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785049302; x=1785654102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5WelClJpxas4ruVu3+pWlz7YW9bPmso8om3006Hc5Y=;
        b=jU9IhGsrYMnpNrtSXREZBBGc19vXoK6L2LLgBikCV6LaHdZj3NA2bZIsOwY+FeQKdp
         zZBOeqg7MdXDkF592wLepRIhDRUOc88GtwW/IP4kLizXP7ZpQWXuylDf3bO7uoAW+Fa/
         JcUcZ3OUmklVAbICRKvE6ddBQ7qHb3cQY4XO9DfOzdegDj3N+Xd5v6ufytzVCsjoNdSs
         xs7/UvYFoSdxd2s1VKxkQ55AamaGqrchmpaSM5O4cwwm5uDMwnfFCbjNpkq6/rRkxvGO
         axGihbW8Vjuec7uYDuYEN1jbSbvsxdD9eSBhaKI97eR1lxC6ZtSOu44OUXaoKQZRSHWA
         UzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785049302; x=1785654102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5WelClJpxas4ruVu3+pWlz7YW9bPmso8om3006Hc5Y=;
        b=tRhccQsbDwdlB3ApZ7kFumlA2J3gJxYE4dn0qVHhrfW2d8E+sWKOtmININTjT2kgxv
         OaNv8TMxdI4xPBVyhiwv9MZIckV1yRh8nPJGH295L+nyg6ic0f9fFxbVipBOT3EPq9an
         YuLCODR4fsso7AvrhQRvwS70HC97b1J22lRT2NShkkukvpQwhLjwUfsk0xE9fq+6usm3
         0bihEmPxf45CRSvZWQYKEhjkh9aZxLgdzYGjus8YYeTzTMAoSy4yVbOw/at9V7b75dAx
         wkeBKc8KgxhUQO59YkeiNdo+C3EdJ1hABzklhYB49yFlbzYsRul+d5M9rQSoi5rv44hh
         ccnA==
X-Forwarded-Encrypted: i=1; AHgh+RqD7b5MEknbscyZyNUCkTncEWbnNBm202UMcF/6DQhRPqd1WcSJ4gF/QoL3iBCV6sdJPZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lsApmk68BW+ZKH7baSYgDEH81mC25a6BW4MwhYuJmIJye+rF
	41pvSpV7CBZIfTREEX3Qaz+FtzGqilXY72kcebQmo/zm/s3iW1xbC00l7pkjH/uq
X-Gm-Gg: AR+sD12pY/rV5/y+nu4vbTg8Id0MgWk/NaGfLaTl72dPV+PL0GjGlk1jRmMccPXkXrA
	E3AAaq3WhsAwA+A3XyL7YhWZxQK2OGtozus2DFBVaW29QmL58WK9w6KfBgU5r8D8BG/u4R6t8A0
	xB0FRhAOt/tNCoHig4SeQ3zADrSnEUYzMBOGLiQ2298pksDtB3G+1XtqwXvACoQey/CC8dUSb8F
	m7wr5O+ihpoPcgFTDu+Rdv5OpoNLAIhgCuNdmrTrMNYA0yu/h+dHFt1vM4M7wR4/LJYxOaGNWlW
	9VZSel4VXc818ozhPTsKFioSiMP9bYUpU5v85Dd642HLs06W9k1sntNxH5ngzDx2o6SsO9OespX
	W5fW0qebzcaRP7Vzn9vClnfnWcUn+rRA10fn831WEPbikrAPL3MEnsyv12UP8ye/XXhc7zBiBOA
	EioIq3CNM=
X-Received: by 2002:a17:903:f8c:b0:2c9:97a9:2097 with SMTP id d9443c01a7336-2cfde89441dmr42250255ad.43.1785049302096;
        Sun, 26 Jul 2026 00:01:42 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b44sm17215565ad.27.2026.07.26.00.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 00:01:40 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Junseo Lim <zirajs7@gmail.com>
Subject: [PATCH bpf] bpf: Reject negative optlen in cgroup getsockopt hook
Date: Sun, 26 Jul 2026 16:01:22 +0900
Message-ID: <20260726070122.2407344-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cgroup getsockopt BPF program can shrink ctx->optlen after the
kernel getsockopt handler has run. The kernel-buffer variant, used by
TCP_ZEROCOPY_RECEIVE, only rejects values larger than the original
length.

If BPF writes a negative optlen, that value is accepted and propagated
back to the TCP getsockopt code. It can then be passed to
copy_to_sockptr() as a size_t and trigger the hardened usercopy
bytes > INT_MAX warning.

Reject negative ctx.optlen in __cgroup_bpf_run_filter_getsockopt_kern(),
matching the lower-bound validation already present in the sockptr-based
getsockopt hook.

Fixes: 9cacf81f8161 ("bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE")
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
Reproducer and warning: 
https://gist.github.com/ZirAjs/a177ec6d8f2c8ed7d93edca6313a9255

Tested by building and booting the patched kernel. The reproducer 
returns -EFAULT and no longer triggers the hardened usercopy warning.

 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4355ccb78a9c..c04a244fe2e6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2235,7 +2235,7 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 	if (ret < 0)
 		return ret;
 
-	if (ctx.optlen > *optlen)
+	if (ctx.optlen > *optlen || ctx.optlen < 0)
 		return -EFAULT;
 
 	/* BPF programs can shrink the buffer, export the modifications.
-- 
2.55.0

