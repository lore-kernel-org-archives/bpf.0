Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885544684D
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457963; cv=none; b=i0LI8eRLpVuMhpLxCwTqaD0t/IO+ehsVB4XD5kacVmg10jLv4UX8eHPqCjbtTrF65azdurQSqYHSAPmENZvYvRt8Hd7moEmWGbjMQjk92KIl80l9eBNY16lukeMjlwLHnibC6jjzn3KlfQWAQWx1UxQtNIOKF8YqbSEZEkPcz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457963; c=relaxed/simple;
	bh=vyxynog3OYF5kBzndeupmeRqkFVd6kt7RTwsz0Fyois=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn8jqoEOcZBpwJe+nkcAo57wafxs1zFxgW4ZBPoUVaq2RFASSdnW9IR8AA708yChj5XGSXZNvJIxLZCauG3u11npct/u9SKzjPYtmGWGZg6bvfo0JeiCNb6nu6OV5YGpc5RmEtLL3h2R6fYhMbCqZ/S4XX8OqvXDKPM26VvRHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaj2xhh6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaj2xhh6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso4025299a91.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786457960; x=1787062760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JsuAZPhP/dzedWK1tVd8R5hV4+SGc71VLUA/CDLtwQ4=;
        b=jaj2xhh62rJN9kJ8JgujS7Uq9yCu73q/keu+XpbFYz3e+ZzskFRPDuAHLRlAg8S7Hs
         rxqOuhFMyJovI4BGAjExTTAmhUwyZ65Bw0RvqT2ihJbHg9vwGw/WQ6k4bZzBodHDPzCV
         YUF+TIrltCpVTlzKE9rVZvBF1+SB38UaJxQRCMgvN8U0vZjKzJbGXfiMHJSbu77WVaLc
         p+PvBmGO3fW7C70as4CknoXv4sChatxfkIjgHfExUqDMrdSlCh3cLlq/RhmL2zR9TgkW
         I5bXhlK0N2jzwKrFxOCa5vHQS730dInr0C04Nirg36MAdcRkm1ZLn5sJ93s/FplKKXcM
         N2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457960; x=1787062760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JsuAZPhP/dzedWK1tVd8R5hV4+SGc71VLUA/CDLtwQ4=;
        b=RSfxSPsFTQTfkIbtdYVWKAdw4YLHpU9fEHiCEn5iPYckN80xvBD8sgoWzXnimUhc7a
         15Kmw5zO7BqsjTGEY1QQfDfQ4LYgbPG8+q/huXfF0yOmLT96vBBiLDfKKd9lRzIjtSus
         oXF8mHBVs7xMn9Q0AsFCrCdPF3pVQ1L/1oHaFptonjl2LiIm6rOFEa+fE2PzHu7zMyZ+
         odXJbl8QV1NLzX7SR9WjuCRkj+CSK3XiUL7ehNPvYNb1BX+MNpVLXtpQ5+GC6zM1vZvI
         95Eo8nwmNZuchQ6KyIESkI3gJtE4w4mlv5WWwzPfqTaAh8hqg6RQEPlSwxVejy4JWmCg
         EMcw==
X-Forwarded-Encrypted: i=1; AHgh+RqQirMIOjXHJiVy/Faxnm3SQtL/AMpj55wxs0zXM8UtzUMZ7BUKpUJNOc4UrR3kbn9xUmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ75uHZxfe4yxBPDKY3/l8tG/i403rqtRhVgyONz51tJrdRXo9
	idzlYn+ZRUJmDak2mdcMvqGm3fA839p/RXiGxIkiv2ErZ7auZO6ZZ7bu
X-Gm-Gg: AR+sD13wgTI+J8krceuxqiJgfcdtSUzyyuMAwXXfNYpGQ4vL39RUV/z9jvdHk8d0nKV
	RVkECKxoqPTG90YuX5yidetlwtjbuEvRszA76uVkCPTD+WUt43EMs/l+EME5pBxujo2FN2sHvTQ
	tmqoos9ysJGCx5Xj5cZ+gCeBlTZFZgICh8PJlr41HJ55lM3O/3aoRYPIdx+atTNrYJxzinEb7Dw
	cmebCrYTi+KXi6wMotenmMnf+4eBuPRH9l9lcmUEdirF84OxPK/ZN0Rop8weOyxSxSif28y+CX3
	jyvUP0LY+0EvQII5/meMtIEx6+Ny9A7E9BpELJpWC7VoxoChARCGBQcV2SbjJAKYeckVQRygMrA
	V7ZzBj1WM0cZltWrL+f5hbPV0KrgTmEzSFmhkOt2J0MR9C+Q3Cs6X12X02uh7s7RNKegxfu4koT
	etNJcHBdVwJGzxEH4A0yeH6I0zxPiTvDYj+VsoPZqYuhVbwObry+5H8hU=
X-Received: by 2002:a17:90b:3fcc:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-392ec570a46mr4077087a91.12.1786457959866;
        Tue, 11 Aug 2026 07:19:19 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d534bfc9sm4028489a91.10.2026.08.11.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:19:19 -0700 (PDT)
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
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: Reject negative optlen in cgroup getsockopt hook
Date: Tue, 11 Aug 2026 23:19:07 +0900
Message-ID: <187a4d756275aaaee5d65eecb63c1477b3b66554.1786448307.git.zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786448307.git.zirajs7@gmail.com>
References: <cover.1786448307.git.zirajs7@gmail.com>
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
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
This issue was found by a custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

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
