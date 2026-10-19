Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8564854E5
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392157; cv=none; b=c8LbEq69GGaBd+jHg4pea/CSTG/B/HzeM0WtJq30bsdy+25HZ/vjW8SPBZaBpqJe5PiuSNtm7zEFlOE95ktcBpLOxs3kEop022LGxpKOgFHE33amcEbC7oDlWL9dKHVJ3WLShIvQ+Tddii/F+mT1GLPIhUevxeG3gvctL+3q3RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392157; c=relaxed/simple;
	bh=sI0uRdJyIwS/576GKroHmj+P9dYFOWObm8nsBCmV8W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQ76tiEzmsfDw3gQw3Vf+muXJK8p/X/XPanlekYpPfLx1YEfuaGPJM1KeVXpU7sExsdmu8G05pGwY86YP2abcwhU0qk9svtTr10Ia77FfeTJYJ6WCY7vRybuDBAOvGTGCYEnM8cVJLgRx47vPudOvMKXSa4+PZHCtldMOrdUIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mym2WOqc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mym2WOqc"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so737705a12.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792392155; x=1792996955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/fCpTvdWPIdjGXF0xCoYGynFxh0LgUrYpyRnN0Oo9VE=;
        b=Mym2WOqc9oVz5JdiDodpZbxyQrCS1b415cTpdTpqMAy/wGVn5Yt+0GCw5lXqdrKEPK
         3tkazyRF19Y+4sfvHKglEGcGGmAqHg38t9SiVo95NQTVaT/Z9ddMOlamcRVZB7Ep13X3
         S46CdaSerNZnpWJtI8jO2FMS1VpCM/ZMs+siWYFKBIAq8/rICFwFpEZ2fWlJKwYJ8VHv
         jv9KcDyQ67m3EJ1MbNCw0EOHxXJmT+0VarTbaGWo0Dwg3FMJ17o7PqRChM/T1LCY7DM0
         6bfJ4x2KD4kSBfDiBsrvLXDzfYLzMXKiSF/AuD7udoRD2OuY/D/e6lZeivcFJsGrUThK
         b3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392155; x=1792996955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/fCpTvdWPIdjGXF0xCoYGynFxh0LgUrYpyRnN0Oo9VE=;
        b=BsE2SclgNWaC1USn0zNPrUgHAKnKwHnrF7q07APzg+TMh33t40DgxGoKQ+8VYYeY3A
         cdzCLCuCVXqTrLxO9GudwNondmww9tG/hvFvLzxJ/cWo3vAa0thka92I9uBcrOh5jDYC
         mjRxk6+QQO0XYLAlWMQLjP0RP9hSpVQYzzel80/dl/5uFJ41bNtDS3Qwrt/pCIxTuwLO
         0I7Rx/dtmjKpKCPGYm4kR6QuhPt0Y5g9W4CFF0Lvg0pWG/s0mkjehXH5WER5r4ljtZtG
         3NVkqkHLJ/xZ0hlh4rJTfbKU8hbaffsYXm/Ixs18c/T9Bhs/cIr1rG77RzOtagm6rroz
         kBjg==
X-Gm-Message-State: AFq9FYLPBDkM9dtXBmZzjlxk6RGl9Kw8pSJr6HnUcSKbMSu2oK6KpvLK
	ruSc2RDz+f6ktvZR3yTAsT4L4bAeEufROdqfcaV7GvgSGHKfoE4r2xIL
X-Gm-Gg: AYBFou1iNlWoZCnAtd5nSAVPE0ew5Qqm1w2j5ScIQdN1GQlt1HOw91kgItltqKC9ays
	lqdkpO070grw8oSTUJkiZoqEi686Qv+u5RQdFVD5qujIjrTiym4TUZ0sxXNIu1k6UJ2HlLPTCX9
	Qj2+cZpQR0JQvRBA7ET/7QkYETaKoXDBq+26KYI1g21T+buFvVge1VODrDlhNDHEQdNbmVGshKj
	NK7CvJCSidBeWw8Kk612Sl1pzHz5ti6RcK41mtgG6zNweh4VhaP1JhJTWCJlHXyQSHOi1iFUxGC
	851Peyuc0z1sS/lv9nqgTk+/5KPF3p68j0sY3kYbvIWggOAram8TUpjZMreRVlX+yRyWxl9olAv
	vqDFcWZoin6s1j03r0zA31rBUvuUL43/RuDQ8AVCOtSGMPI1SBzEGlL4H5qoVeREQVt/pFBiwcK
	msab2Fbv18qPnYOIsn2kfmUIsPUhsmBzwmeOXUBgh7OkesT/IpG4dIoYi3GiOj/VVma7VT3SuB9
	6jLygVe7Of9H9u/f9iegnlyEE1cupxmwVAf2CS2MpBI3Y2K8Qdw2URo3S+gZcDqZ8ZBhw==
X-Received: by 2002:a17:90b:4c92:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3acef134becmr6190292a91.12.1792392154938;
        Sun, 18 Oct 2026 23:42:34 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:3fed:6938:3f14:63eb:c479])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a3a592sm3688960a12.30.2026.10.18.23.42.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 23:42:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com,
	tim.c.chen@linux.intel.com,
	lizhe.67@bytedance.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 bpf-next 1/5] sched: fix stale get_pref_llc() stub for !CONFIG_SCHED_CACHE
Date: Mon, 19 Oct 2026 14:41:53 +0800
Message-ID: <20261019064157.29885-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019064157.29885-1-laoar.shao@gmail.com>
References: <20261019064157.29885-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp
to fix UAF") switched get_pref_llc() from taking a struct mm_struct * to
taking the task's struct sched_cache_group *, but only updated the
CONFIG_SCHED_CACHE definition and its caller: the stub in the
!CONFIG_SCHED_CACHE branch kept the old mm_struct parameter.

Fixes: b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp to fix UAF")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57360f5cdde4..973647ad6c2d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2194,7 +2194,7 @@ void init_sched_mm(struct task_struct *p) { }
 static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
 
 static inline int get_pref_llc(struct task_struct *p,
-			       struct mm_struct *mm)
+			       struct sched_cache_group *grp)
 {
 	return -1;
 }
-- 
2.52.0

