Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567889;
	b=mibvzMFTnWY2wv5F8n1FRr/Um6jHf06iLEhSNe9ziLP8DAgelbGMoUrXnSdRFU/zNDHf
	 01vvdbxPPGTyqN6ISgnnFw6RCosC9DVNyM+qA9Fa9XgG3BLb4LlpZykw2XcjETTG8qFfu
	 PzO9bPnHHTYQjaX2baC5Wj27eAPKprctOZ+v7Pxiz9zVTphcgDHwGFS9T2ba+nkgtTdiM
	 vbM0nSjmWNrIktd1p5Xg3QZpFDvSX/9hBQIVL8vpCVjrjA07RV2mYdP0mXBHob4Hs858X
	 8GllhJkq95p5Xxg6Km59nu8hofdgrjJCLAPljGq2MVkjW0ce2rE+bD5frsVVeZmQpJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ijEoceIPA/FhPxFIeWOafWruJLYo5pmY1/F1ij1l6HU=;
	b=Ls1SFWynJWIBPP+LfdeZQAd/II40wECYh6G/GkBgnYAJoBVxzd5Kp1imWT0aNhXKSo/Z
	 atdv9olkm4JP9WtkfODFogWg/2cY37tnN69qA8CT/+EWaTCvcwhgeNF6oJRj5ZQDYuz0Y
	 4QX8FEipPmasOIUUlyX+vJklsRyT9vtZxuDe2ZToQeKhtitMq+4SPZvhDhIPLFhTmDwK2
	 2Aqu3fDxcSnLz/WE5CjSShiXBOm3XEUu0HssfsNFFOKcoVoveFBQUMhue1UBbNpNTzfZf
	 50AzSiuyUk4iRoeVZVkpDZ/DDdeoLLaL76qV7cVjTUcsOQPcY/LMUYEpEkB86PI9GmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yfo6ZkUK;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D733606A6AD
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D733606A6AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yfo6ZkUK
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3846d5f54c1so6274579eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567888; x=1796172688; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ijEoceIPA/FhPxFIeWOafWruJLYo5pmY1/F1ij1l6HU=;
        b=Yfo6ZkUKjcSHglyh0+xIzkgrqFMsakw+GqpeC3ZcxXN3+pawyDxzpppr6AEdrnD+gG
         JA3se7wAc4H7WcGHACOPpk/UrGPHqh5/GyUFDpBubN3MtzYiyLlwo73wCF1uSjYvyRnJ
         csFrMMMMGP7gXsVt+8l0/wk7tmIg73vEPdWnabZcvpTVDQCzS1HkGsf7Et4i+3q1Isfg
         TiHNU2RVJbM8VVKxNpspjZXVW+Icwhph9TsMN2gghZtKWJNMOT/IXPidXS3CvrevbX+i
         I8MdM2ja5HuFYq9yijZLqvvscq+ALtCP4767louykXJ7XNWk769qqqGtX4tblXzyzyOT
         fQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567888; x=1796172688;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijEoceIPA/FhPxFIeWOafWruJLYo5pmY1/F1ij1l6HU=;
        b=uZVB8MmYJq98wu6Hh+FhGFa4Liw4cmVoTx04QSyVrTSfWJ3LbqYJ64Dx6ARpMKNu2O
         cJ9dcx25JflTu8E3wXKhcW5LA4l0rZfya3C6DHVUfnclS/272QFEXPU++spxVqdar9O5
         GzYsbsZ6nz/BnwSc7nD0kl2UCSHzhdZ4fPUbDv0l/nf0/IJdi7+nDNFP5jfJvfnLh8RD
         lUFx1MGp64zAA3duxIFb5V8r+Di83MwgCtKfLV6+pkgTYKNGFxC0XZ/SAhsBugxq82Ji
         1o4rpU72zr2+GypBLdOzvtHm1OD6Ta6AyP8bFStuiw277OyeVe2ga+axr3ZbxpC/i64x
         /F9Q==
X-Forwarded-Encrypted: i=1; AL+hErEV94sxyvghA82GRaz8n5w9yDhtD1bp53vBWnbilOOSd89oOKym0chw+vX/sxi9VxwSM0s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qN6ZY5Q/EQI0cjCjkgwkXEXIJqntz2cJvGEtz4sLJQxJ3Fbtr
	vUsUODR3HkTBMROtOfClJWlpIpHyFRUQVoM6YietwxIh5ROR7ApQfOjwKuZM6WmS5FvYFu8Lsfd
	cf+XLZV1fGw==
X-Received: from dled7-n1.prod.google.com ([2002:a05:701b:42c7:10b0:1a8:14f9:6e3a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:260e:b0:1a7:e1c6:6f33
 with SMTP id a92af1059eb24-1b5568d3ca9mr16326776c88.30.1795567888201; Tue, 24
 Nov 2026 16:51:28 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:53 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-5-irogers@google.com>
Subject: [PATCH v4 04/19] bpf: Export stack_map_get_build_id_offset() for perf events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make stack_map_get_build_id_offset() non-static and declare it in
include/linux/bpf.h (with an inline fallback when CONFIG_BPF_SYSCALL or
CONFIG_PERF_EVENTS is disabled) so that the perf events core can reuse
it to resolve user-space instruction pointers to build IDs and file
offsets.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/bpf.h   | 14 ++++++++++++++
 kernel/bpf/stackmap.c |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d15af0e..4b944d6e845f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4499,4 +4499,18 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PERF_EVENTS)
+void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+				   u32 trace_nr, bool user, bool may_fault);
+#else
+static inline void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+						 u32 trace_nr, bool user, bool may_fault)
+{
+	for (u32 i = 0; i < trace_nr; i++) {
+		id_offs[i].status = BPF_STACK_BUILD_ID_IP;
+		memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
+	}
+}
+#endif
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a19126f5db02..11f6349b2b8d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -406,8 +406,8 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
  *     id_offs[i].build_id is zeroed out and id_offs[i].status is set to
  *     BPF_STACK_BUILD_ID_IP.
  */
-static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
-					  u32 trace_nr, bool user, bool may_fault)
+void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+				   u32 trace_nr, bool user, bool may_fault)
 {
 	struct mmap_unlock_irq_work *work;
 	bool has_user_ctx = user && current && current->mm;
-- 
2.56.1.831.g720f3f5937-goog

