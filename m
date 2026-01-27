Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586725A33A
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502421; cv=none; b=jeNJz5rEHywAaSd0J05ggazjgkOnYLm4hqVwxcc14lGrQdiF1UQKxJ0vy5GSFoU38MgSwWIc3q6k/KEvOeKFSZxoflVqa/SZdV560Bm2QVCZdZ0xRHa/aD8kdG8kT+fohBm2jDYrQGFAhG2072mnSRZAgvfeLdApl6cjngxYoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502421; c=relaxed/simple;
	bh=qxsb9XL4M3phRf5Ar6Kb6Ai2gYXxa3plCXx+k6p0Kc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxq4+uL7AxAMIgnHQ2zaN3NuaUCulniWImSTljLti6MRVAkyOSvMmNb45+va1P38SYrRd5PLoD6RnP6EWoDz0GK+pwssWoRGuAfGm+XYqFdrzuW0MkpsJzPpRjXD3JRwOXAuUqcKX1jVSBcuFG13HQK/HpJfVQHBxUzl6y98FqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DThwOOgs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DThwOOgs"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so55863555e9.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 00:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769502418; x=1770107218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Icrufma3P9QCbYveOQElssQZt0wniN7qPDaqatBryd8=;
        b=DThwOOgsirdPEVF5bTsqPSZsJ1iMrLZtUxdTpdJww+hoC8pv/QMhvPDshW4ylqEeuR
         s/GA8JTapQTJ4oVW2aPJvRs3JycLp+lceJ9TiGgfUXzMJI9dVP82lMZLeYHBFe0rT1h8
         PQ57mSeYHsGgFxGAKkSwx82VdRVYIcEmzBE/S6Rnnt9jGqduRPa1JHcBhT2nr2KTWVAM
         RcCpBDrdLYNequOJIno5vTv2ijJjYcCZuyz9kMdbC8yIgq0Pw3rjcYc/rqhkGAbxjYgO
         NjsepRNKwbIri3xHiPuhtcM9yk6upFQ/GeGlDX9/7SWuVUeSHfqmyCdeQJG5lrAzTigw
         w4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769502418; x=1770107218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Icrufma3P9QCbYveOQElssQZt0wniN7qPDaqatBryd8=;
        b=r8kAmgcUASBC9dyuBFTN25bsAna9RQXLUKQv3c1EHZIx5541FLHUWDDoCb3BUoxS5t
         MYAVbKBbIi1v6qLr9MWSQo9IxsArK+I7F3Z7JKn5HpRvqWEko3k/+cXVqDtmv7oQfzNm
         V/2gmKfoGkAjOkiqkVCHDHJtVKxziOzFkFtDPSUECXf0KwpMfBa5o+yQhjHTHt/bfhap
         YO8181Uv/HkwpZgQPwVRVvA/Beqe4VFqTsx7jEHPMDFrZN4ZISA2UIU1PezgDxZ5rMK5
         U28IazrzYvHtIgpLnD4WpKZn06i87AdNzn8pXkRXy1HzbEbTAOIyBGaPDqqe3NQ3ScKM
         1Y0g==
X-Forwarded-Encrypted: i=1; AJvYcCVUsIiKN27Wh05mFIYueOE4JSflpNWxD2YLAyRSATN1KASnFo8/nRBWv3nkOzKRRPgEFV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQYtXJFhtOoEwGjEORp/F/x7Abuj0sMUz0lkvu18G1A026Y9n
	ZlUqT7Uo8b3ddBlX20eXghMtUReM+vRSkFMzJjza5YuwII0U12Ti9UuSIIZ8p/2Fj1M=
X-Gm-Gg: AZuq6aK1jSGDbVjO6ApTAje238A8hkSxUZVnD6LVlItfC6y91fbvLb32cH8V5ab/WGK
	qAJVvgD01pqyy7w1uZOlUByAeZG2WJ7w+YbI7YR41xYEZiSBp7VHdxVJaW2MBE4sSNo+vtbDLge
	9tQUe/8QHlsQXY9qoSqEib+K9XM3JCkViNKf33B7u53gv0Hlu8d0rA/tmvfyAaDIBCEMlAtnJmc
	Bk4nnHdG+K+X4bU/Ra18YsMtKKQyoGZ85CHK08YarQLA6gflPDaXdfPcNHlVnhtVBxJlj9lypQE
	7PH1bdkvJxm6YYz68b84SZOhazm/zmFZNGoRQKbD27FNHzQqVT47YH6aUumn9q84iFlJgurvnWE
	78M8Bi8cxNZ7ZursqQSP6voxFSDCKC9kOORyRJz+GBQAt+sawl7HmoZDkrB4pxWY12ll/gPgngi
	7iir13x9/gAAaDNbGHXEbHfi8jZQ==
X-Received: by 2002:a05:600c:c173:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-48069c54b96mr10296075e9.22.1769502417701;
        Tue, 27 Jan 2026 00:26:57 -0800 (PST)
Received: from LT2202712.home ([2a01:cb14:322:b900:bee8:7a1:a58e:8b0e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c428basm46670385e9.12.2026.01.27.00.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 00:26:57 -0800 (PST)
From: Guillaume Gonnet <ggonnet.linux@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ggonnet.linux@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev
Subject: [PATCH bpf v4] bpf: Fix tcx/netkit detach permissions when prog fd isn't given
Date: Tue, 27 Jan 2026 09:26:16 +0100
Message-Id: <20260127082616.28850-1-ggonnet.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAADnVQ++Bx+xZ1jmeM6rLC7xeLHfsSUNizzMtw0=zOcPfLcc6g@mail.gmail.com>
References: <CAADnVQ++Bx+xZ1jmeM6rLC7xeLHfsSUNizzMtw0=zOcPfLcc6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes a security issue where BPF_PROG_DETACH on tcx or
netkit devices could be executed by any user when no program fd was
provided, bypassing permission checks. The fix adds a capability
check for CAP_NET_ADMIN or CAP_SYS_ADMIN in this case.

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Signed-off-by: Guillaume Gonnet <ggonnet.linux@gmail.com>
---
 include/linux/bpf.h       |  5 +++++
 include/linux/bpf_mprog.h | 12 ++++++++++++
 kernel/bpf/syscall.c      |  7 ++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4427c6e98331..5f59d1f173a2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2742,6 +2742,11 @@ static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
 		bpf_token_capable(token, CAP_PERFMON);
 }
 
+static inline bool bpf_net_capable(void)
+{
+	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
+}
+
 int bpf_map_new_fd(struct bpf_map *map, int flags);
 int bpf_prog_new_fd(struct bpf_prog *prog);
 
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 929225f7b095..18d26ae6a5b6 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -340,4 +340,16 @@ static inline bool bpf_mprog_supported(enum bpf_prog_type type)
 		return false;
 	}
 }
+
+#ifdef CONFIG_BPF_SYSCALL
+static inline bool bpf_mprog_detach_empty(enum bpf_prog_type type)
+{
+	switch (type) {
+	case BPF_PROG_TYPE_SCHED_CLS:
+		return bpf_net_capable();
+	default:
+		return false;
+	}
+}
+#endif /* CONFIG_BPF_SYSCALL */
 #endif /* __BPF_MPROG_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b9184545c3fd..5f59dd47a5b1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1363,11 +1363,6 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 	return ret;
 }
 
-static bool bpf_net_capable(void)
-{
-	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
-}
-
 #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
 static int map_create(union bpf_attr *attr, bpfptr_t uattr)
@@ -4579,6 +4574,8 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 			prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
 			if (IS_ERR(prog))
 				return PTR_ERR(prog);
+		} else if (!bpf_mprog_detach_empty(ptype)) {
+			return -EPERM;
 		}
 	} else if (is_cgroup_prog_type(ptype, 0, false)) {
 		if (attr->attach_flags || attr->relative_fd)
-- 
2.34.1

