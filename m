Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB4346791
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448878; cv=none; b=gafFeyC2WdeRU2Y8HGHdSsw5TnbLcrzSU0PrBw/b3zSHJ4H/h2e9mqXZpBHIoeM5B5Ppvat/Tv3fnUVFA+zBWUz64GJ6JBlL3nmQEtEwrbJY4CjpU5NYqkyV8XrsQjMqlvM2mV7ZwPjGdlgzwFz8ls0ereEZEpq1WJ6JxMjtEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448878; c=relaxed/simple;
	bh=faMkRSzEjxFmP50TijL884C8Ef9w8hRvv2mBg1bU/Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTQzigMfNpNV8E9Se3KTJQ07nkGrxaxkFZqVzhRkwtGegcQPsgeszUQlG7Izjl7Pqdzh/+y1jwas0Y1uMP/U9HhQQYwd3GE1v0+Ux3JjfoY2ocSP02i2ktd6kzPKUflQsC+isofjzriNWe3U4XKU6CWouCP/LOkznnF9WDAtFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzlwpufA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzlwpufA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801bc328easo54051055e9.3
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769448875; x=1770053675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68PX3ZBzTGWm1jfWmkk8jKDkPQItWhCtTlzGy5B7vQo=;
        b=UzlwpufA4RvSukOFCMgXjwZwqcUN1n3ZtQfhi1zYOWPfl4t3yzF31tMGEuSeSEvYHz
         9Ot7gFAAXAu0CzhP2Ibq5pXdktpHlJ4isvQ7tCWAh4QKb0ns8EBkiHWNIiCfVIHW2Z0q
         sc1Q8l6WsgIomDoapbRwJxt1Ukk6xrFCKcOE8MRh6MzmfQKY0YQ7T1NxPeVHM87MLqjc
         8dd7ZpqHjr/8LUmkdvZCX4gxccnAvcCAwIYW8pxhjlAtY5YubP+uKI++sZRpDftCjzi4
         v0otUzavDRMpFnEj+IBEtFbil0NAmGi0unPOAmIPStLtVUXfL9Z55vkOiGxonam9xGlV
         309g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448875; x=1770053675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68PX3ZBzTGWm1jfWmkk8jKDkPQItWhCtTlzGy5B7vQo=;
        b=sMxcyaMwWEFrcslBIZiJSMS7vLjPOylkrBoZXJdgFEEQ8e5WkMeK17Ai/5kUsk7QDW
         vdSWDV15yKlMZpMNDxLIk+RgemegRGOfne7kb3/GPo4lgTSc6Ag5ueHuDoTZf7PZcMTC
         ud3HcznhBAMUkPLJK7VCQIVZTFpSUTqfn9v8Te1mZeDuTBJj4e+o/FF+pkTHAaeTPqxC
         q/vYUdBYHZtRs2gYBUI5kSIpUNhqKPPKCI/0v1JmtIo026/4BV9adr/4jMqm1kjukjkg
         +pxcHj9t+pN3lgSdakRug/tGFw2w40cBARACt3U9P3lBNJXohR6IeMVp94FQYEZurjh9
         VRhw==
X-Forwarded-Encrypted: i=1; AJvYcCW8WkRpw173mzNPC2ZY8x5iQI/H6B9BiqHdXnhlAEbvs8cGdn9FY678hVKvRtXwn28eCts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOZTCvHZQNjZVomGYb46jvzSawo5SKvR8Z44CX10j2LH4UxsF
	uWHaFrVIlJkRVRWOtWHNH5QG1zWNsafDUmYH9fgnyMZmao2YqXT+6TnF
X-Gm-Gg: AZuq6aL0aFH2jcir7HSBGyfIdYUl4/jSBMBYykwFq9DlOdNdAKKA5Y/Xge5TpFSOKS2
	2J9i0Bg4CKNnmXDhFNXGtHcj6fkHwcKrsIAcqaARxuvC3w7cuNmMTRDRz7aUIeMesIFlnn/BOl8
	7/gqEnATAPcB7AHtv+1Iae3hKdnZaWgHXRnDK6BDco++vArNrDu/euEWJ/Erx8wQeSp5YHeXrid
	ypH7wbe/4pKsgUXP7iYARl5PNhi7uBU+M7y4k13pl6UP1FGvCjkpb2dL5fzj4hYiR13lWvs4wHU
	oYrrMSvkZTVvilzIA7cDFnB9aP31VGqfM8ZAwjh/GX7SPI4xCaUojvHjDA0CK9cW9gStz6H6aHT
	SYs02Zi+UPYXWAy9A7CgWHu59H6Jeq3pqwuuX0bbKtIA/Au2u39y7LqYUxJjmM74DX+GM8OceED
	fK3Yb8SabrFX0JHZpT1hJPP0w=
X-Received: by 2002:a05:600c:46ca:b0:480:1a3a:5ce6 with SMTP id 5b1f17b1804b1-4805ce4eb3cmr80288115e9.14.1769448875346;
        Mon, 26 Jan 2026 09:34:35 -0800 (PST)
Received: from LT2202712.. ([2a01:cb16:3013:f686:9880:33dc:3c70:30df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d3ab9a7sm118335555e9.0.2026.01.26.09.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:34:34 -0800 (PST)
From: Guillaume GONNET <ggonnet.linux@gmail.com>
To: daniel@iogearbox.net
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	ggonnet.linux@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev
Subject: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD isn't given
Date: Mon, 26 Jan 2026 18:34:31 +0100
Message-Id: <20260126173431.19825-1-ggonnet.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d269a9b8946d21a9f93724baa6ed06e9873e8c13890902ff09e201a89c727804@mail.kernel.org>
References: <d269a9b8946d21a9f93724baa6ed06e9873e8c13890902ff09e201a89c727804@mail.kernel.org>
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

