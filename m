Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7251DF963
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529747; cv=none; b=VOVRj4sfIek7TIDTrMvGgApm4uV809sXIw2ltAs3+FDb5kargepEUL7Ty8Jcl4klZDC+dX3RommI81eN3HdlSi60gDV+LbsSM64+qg1oHv2xegfDmSruTi+0H605zDUoWJb+oraAsFOHs+5pT3E9elX9dp7qvzFADbjS5Omos4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529747; c=relaxed/simple;
	bh=80QA2qKhdqd81GTUrLd8NbmxdcrAHMEH0Wzeroi9kx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yf7VE9RTmLUZmQNEAepe4ooTW/G5OBmkoh28ITJJmRebZVP/34nYmOhUuAr2n87I3ZLZ4dWuEyh8wC8W1S2fOsRAB8RweMjKR0ws7oIoYy7tYe2hS3pd/uxhDfwARjAKJBDKY8QiJ6NV+UBnzERugKPODrAhY/1th2iPIQdn7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP4xeHHD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP4xeHHD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4805ef35864so21348115e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 08:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769529745; x=1770134545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olTpw0u/jlN4U7IPiGAMV8xXkk0tzTQoqqLiwZiF8XM=;
        b=MP4xeHHDgpcB7GB0+ymMWHiEBIG4psm0da5gyFKeUxQu0lHHKA0Sxv7JJdEoQyUjfL
         jzoA/f8KWibmmcgB7ELnEpAceZvaATlPjeoSrMAEuf3ozQdeTnQWDrn6BSsW/p8+ryoz
         npJOGVxsLuOr6Ey2VRrSiN2zUtfd2ZymQDKATKzq7/cP5CeOgQtnM1IT/iUMUh9CVDqX
         F+vf7BpMjY2972I50hR4nfc/QU9PKVmZIXd0qDNGNpOiLzQLD2nbXKK4I62rsBsLVIuz
         GvygKTjVsxcwWsM10btW+hQNq6C9ZxKBdZFVeMQwnCMmnwonluQUU+nBKI/g0Y5GCgcE
         Vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529745; x=1770134545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olTpw0u/jlN4U7IPiGAMV8xXkk0tzTQoqqLiwZiF8XM=;
        b=MYHqMRvQw8jeINdCJQ3+0Q5aJFs4PjTX0BwfqD9hKVu7VNIAWri2WEdRVbNt7pXKtR
         aQoGdheaV7kmtSNErMBel3jMbef+UC4qBGBR0WjmFSCNhPurJStBbgNicHRbl6T6f3zM
         JY2Kiklo91y9t42naU5d1CqGg3aJRTq2k7+lvkmgkTSz6Vk5WYcUOB9C6QcnDW8hiroq
         0MwmVgIIu3nr6/SYW4kpl+kA0h707KhA48PgrIuPo5xvd+hMpw8HISHVdZPDIcPeYZpn
         q2FFcilLUhD7RYUQLVATb6Va/8SGSDGiHf2tLtDCw5zNDgTWZITLQ3++IRAOpX7rbCFn
         Lq9g==
X-Forwarded-Encrypted: i=1; AJvYcCUlDGfv4EZZiUCIjVcTUGn+ezxZpZGx8wM/0lHTqSICn1PPZf+zLWO1l5mW/hQiYmvHc2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPQm7ik05Cgwp3JiUfLs5A0mjLaSOqsiKNeP5VeUP3P53nxmJ
	bn8wh6wLQzCqA1FFFyuJ2NavK5CXLzp5UUH9EkGSMdghatMIWwqAW3Yv
X-Gm-Gg: AZuq6aJGupZ4NvBi/Pcxybsy7cHPDhsIIHjaytEFha0/3u5DUtiQab3AVTmXIeQpeEq
	NEg+I0nbCad8wyLspmDUHOJC7WaXGpLL4WmRpBL1s8lCM+E8j+3HvVBNpxT958tksKsIULbIXo+
	d8eT1HCGW3eUeAvrcUtq/3Zu7KusNiI14Xnj+8Pawytp0QXClm4UobrYnTydW6T696iHYxd6T7C
	d/kE0sfdYo1jvBayXxAqf52SSAtiyQagbYAv1rbaM6WOsXP/d4vsBs3aIOfSxM6vYCDn+v4b2iF
	ReI8UJqvu2yNgKTaM6SZ0pQOXV08AMMLoQLxIpULmIgAss6jyd5TIgX0Zrnv13GREqgoh2JtRvu
	GrRezTV8Q3AEb/qqXXTNQpSAnett2lfLlY9/6qybC6jWJTLjoYLBfa9Iv83fAfz1WmG9751djmY
	GVc8EEQLyTezHIBRvB/Nm74w==
X-Received: by 2002:a05:6000:2401:b0:435:97b2:a9b with SMTP id ffacd0b85a97d-435dd1c0cb9mr3260437f8f.37.1769529744405;
        Tue, 27 Jan 2026 08:02:24 -0800 (PST)
Received: from LT2202712.. ([2a01:cb16:3054:f7b5:be78:2d38:beb9:75b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f74b15sm38709404f8f.35.2026.01.27.08.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:02:23 -0800 (PST)
From: Guillaume Gonnet <ggonnet.linux@gmail.com>
To: daniel@iogearbox.net
Cc: alexei.starovoitov@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org,
	ggonnet.linux@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev
Subject: [PATCH bpf v5] bpf: Fix tcx/netkit detach permissions when prog fd isn't given
Date: Tue, 27 Jan 2026 17:02:00 +0100
Message-Id: <20260127160200.10395-1-ggonnet.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8ae6e34c-3c6d-4777-ba21-34a525728b3c@iogearbox.net>
References: <8ae6e34c-3c6d-4777-ba21-34a525728b3c@iogearbox.net>
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
 include/linux/bpf_mprog.h | 10 ++++++++++
 kernel/bpf/syscall.c      |  7 ++-----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4427c6e98331..9272a237cced 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3362,6 +3362,11 @@ static inline void bpf_prog_report_arena_violation(bool write, unsigned long add
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+static inline bool bpf_net_capable(void)
+{
+	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
+}
+
 static __always_inline int
 bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 {
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

