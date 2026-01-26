Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985E347FD9
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447267; cv=none; b=jL2j0exp1RYE9Rz1KFw9Byf1ANRINryHsZLRq6QcTedVGCdSUMTKcg3CzVVGFoXQVO8/7pj3Vl0It4oIK/6CZPVjnZnw28rG5MhFzgc+RxeWaCW11kPUF14GlnrewUrR4jPhxA5Ycye05C95vpi8ClTNDLlsWQTQ2I3I9v7fP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447267; c=relaxed/simple;
	bh=EqVngNuEHnZVHBSO69OOVWF4J+LbuNd2bp/i8SWcv0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XzHGcdCxxSFmxxhZ0MhlkcnqCi3nMv2BF9TvtJkv7Jo1nNLkv5Yoxj80ntxWL4PEShVyS6zMwBnHnb7qZyK+ISGkcCyHu+Ii3EVdOf8vjQPLtilWBGYTFOp94RWx3gW3Phi+n6cDIIZJ/tHiSB1x5wsANJ6XTWtapIYWDHiRA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeZANRie; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeZANRie"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-658078d6655so9460327a12.3
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769447265; x=1770052065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoFxgt4MIOoF9lQcM5CAUN8aEZL7XjnCcnUwidZ6p4U=;
        b=WeZANRieHMeOiIJzoZBVrIRXDMFMk7VZ0ESv3fedK1b8bDY28wGsJ+4RLkNUUOsv4v
         lSFFxSUK6ensL7toKUIkAbu99PNYHBpcq8tnPjwVwJINreoq+XE6ClUNpMgWYi9gdHuX
         xf76k1C6nF+9DJLJyqdbe75ootH40783uZHHsIuc/enSg9YyuaUchARtbE/4LyRJ/e+q
         FZObhQk5VwcVYbqfE3BSBjRh2xiXCDfTHDsY6JIZ76SFFvCWISe+2J5fLhVfAApvlLod
         tDF0i73azCU6+gYwPgyRArRVEU+GW8vCdxusa+EKGBpooivWNKwiYFF2M+nJfXRbY0Ui
         XeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769447265; x=1770052065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EoFxgt4MIOoF9lQcM5CAUN8aEZL7XjnCcnUwidZ6p4U=;
        b=xGShFkD02mubuNEeHf4MGhmP0IjXi7FoKtkalOPvnw3zzBn2fQNN2z2/NbyhEWg+2q
         3x5hP5QZlEb1mnHWefFhZLtZ5WPYRdPpIVkxFc7zbGsDyucIdXTLKX7NFzdiYj6TgYNg
         I6PijnXpphh4Io0o586nU7QmtCa1c7howRGwOaKRR5KoE+L4CWjtPp2Jx4TXlybKj/XZ
         IdZ1KUEReE0QtEKDzRCWXitJgIjht74GEw3Vm9J8UoZwpVYqxCxl5PWRxhyWKtOQNP5d
         GSaRgy0VaQewLaIL6qaYuUl2K0TQAvUOTMG4lnfNkJPVifGhvvdgde38wli5h7MDm/mw
         Bfzw==
X-Forwarded-Encrypted: i=1; AJvYcCU89IcVkVzmXs1Nr/7yvl5G+fVg4rS1Uxqu50erb8qAPvThFdQ0nCGWNIoGdrK9AgF5esQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VzigbRrRxtQgXYEDXaT2eaj/+iwtDMrSw8Eie4ttx/iOHrUW
	CaEKEoMkrY5qrJ3VhTnchemEWY4kwuE2SsBlp26+BsR8d4Xrrbbu1qK0
X-Gm-Gg: AZuq6aLqVRs8qWOpmfrX1lbZlBv9axempGDTdueYjr0ozLqBPtAwqAqXCdZTvF+lFJr
	JmUeJyqFSAHDOA1S8v2gIoPUeriQ01t/z3k3oD13Lkyrrh2beHKP8nGXQI5u0OltgGDynZrRDIw
	QR+tghnHTyChFUALKHYYIZzGfqeSFyjxA/1LlUedgE77noDpo+m+R5ey6dArnVvnCK1a/iABwmL
	vtBM33M6x1Ww0jF4+v/I1PfjZjzTs81ztR0goCGZQt8LopzX3pcM3YzYbimyPK4cQQnUUqBQCTZ
	V65g+pXyAO/D29t5hUoMVYX9MdAe/hZh73yX06BvGZ5nS/Rbt2bv6NTSMZ6vPawbB6pYeQbmX0A
	UOopwYUuBzwhZPg8JMBBm4Y8NEXE1wkjlLGzMozwpqH2AA/PGccm8a7zoib9ufMUfVSlYebK1U1
	2utPlgQJdrtUINxil2SeaZmg==
X-Received: by 2002:a05:6402:13d0:b0:653:e85b:7729 with SMTP id 4fb4d7f45d1cf-658706db45emr3696066a12.19.1769447264492;
        Mon, 26 Jan 2026 09:07:44 -0800 (PST)
Received: from LT2202712.. ([2a01:cb16:3013:f686:9880:33dc:3c70:30df])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b948670sm5330687a12.25.2026.01.26.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:07:44 -0800 (PST)
From: Guillaume GONNET <ggonnet.linux@gmail.com>
To: daniel@iogearbox.net
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	ggonnet.linux@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev
Subject: [PATCH bpf] bpf: fix TCX/netkit detach permissions when prog FD isn't given
Date: Mon, 26 Jan 2026 18:07:31 +0100
Message-Id: <20260126170731.16321-1-ggonnet.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4cc162d4-9d19-4406-a93c-d6dcdf65f55f@iogearbox.net>
References: <4cc162d4-9d19-4406-a93c-d6dcdf65f55f@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes a security issue where BPF_PROG_DETACH on TCX or netkit
devices could be executed by any user when no program FD was provided,
bypassing permission checks. The fix adds a capability check for
CAP_NET_ADMIN or CAP_SYS_ADMIN in this case.

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Signed-off-by: Guillaume GONNET <ggonnet.linux@gmail.com>
---
 include/linux/bpf.h       |  5 +++++
 include/linux/bpf_mprog.h | 10 ++++++++++
 kernel/bpf/syscall.c      |  7 ++-----
 3 files changed, 17 insertions(+), 5 deletions(-)

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
index 929225f7b095..0b9f4caeeb0a 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -340,4 +340,14 @@ static inline bool bpf_mprog_supported(enum bpf_prog_type type)
 		return false;
 	}
 }
+
+static inline bool bpf_mprog_detach_empty(enum bpf_prog_type type)
+{
+	switch (type) {
+	case BPF_PROG_TYPE_SCHED_CLS:
+		return bpf_net_capable();
+	default:
+		return false;
+	}
+}
 #endif /* __BPF_MPROG_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b9184545c3fd..419d88bb5944 100644
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
+		} else if (!bpf_mprog_detach_empty(ptype))
+			return -EPERM;
 		}
 	} else if (is_cgroup_prog_type(ptype, 0, false)) {
 		if (attr->attach_flags || attr->relative_fd)
-- 
2.34.1

