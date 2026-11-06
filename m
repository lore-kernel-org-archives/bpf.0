Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988248;
	b=lGzh0B+NwBkPq4kLslaE7o/O2pp/Lrr0uXwypkCYtxE7xs9rrDw8k6PCshp3F3vKyhgp
	 uMElFLjKx8E9WbsQJwNAl4FBOVaj3lbGUH7yR7l4KkKeW9JHw8zripJKgaUHoB/dUbeNc
	 JlWewNKIl5QsfGxun9ITkts7cCpFRtsrXziSOJLxF+SrtdnNKMwvQBY5NX7bQ2JNSfcQC
	 A2GU2qPaC1g+btQmxEkDmK+fR0fvRuIQzIOyEcpLyQFne7ipzyDW3w5K8ywZeVyfwsSbK
	 QEU8sh0/Y4FwuFKP2oHCsB45qsi3Rt6YckxqQV06yGFtBFgb2j8vlSSotBM/VGX2QKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ff87flfpWxQA4dJrc987lusQnFIhkWINyfHTfPBOik0=;
	b=Jlxu+Ermykb8mrcieGmozlQCr76HmjymD7iCSLOpRNsTRXDMWjGFaUmfStgB4rIK6tFL
	 i8/12NrJTvB7aXwiXDgLTX02SLGaOBUOOn78kgC0ASyRMOsX6ng30Zc6r/L7eeFWEjcah
	 VY1IQ4+akhRZjYCGWKYHMa1bytWliKk3zRyKCBp++omzJJXgL7IvagEvb5uXflCJPB6+P
	 T+lpyoa1osSPO33gibZ+EhofJDrqFyfu4Vd/qT+9ujq4yMgzmysnRelhH/+XJILLHxy79
	 WCUmAE9l/fQcU4o07Lx7tqVatWWRnt3DlgsHU6U3n5vjiSyU5nw3bmY/Pl0GWbS9r8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YWjno4e7;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CD606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 18:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 054CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YWjno4e7
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ed1414df17so3625355ad.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988246; x=1794593046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ff87flfpWxQA4dJrc987lusQnFIhkWINyfHTfPBOik0=;
        b=YWjno4e7L9L3NjRYdqODuPBgXA4YLXt0z/Zp0jjJWNG/wwMi+2M7aEl0GWBS+gm/fJ
         qssPwwDTwh9WFW+bzyCVHhT9i2g8HUSKWa/6s3L5Ukw8ES1qfiBrYU+GSzPhPty4IRLh
         SK9gsTGLvMhoj92IV20iEErU1/E6HKFBbDIZuIe1nGsh2qsqMCmkmtukdQ0HaIYUAS6t
         BkxCjHMAKugFN6rqg4F7Tf9rWyTrqoRQ9iVUp/IbC2LuxFYADi45ENT0mpuBbe8AAPfJ
         HeMRsXNivXuB8+iVacAnZOXeV8Uwmq0D2r3V6OH8g35CPpKiuTZRY7bP3ajUI2QkbwSP
         c3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988246; x=1794593046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ff87flfpWxQA4dJrc987lusQnFIhkWINyfHTfPBOik0=;
        b=UmPf4oJplF5t6Q+QkV301QUSK+docQCOS0vqmDKFX7x6uxQRmjN47dPAUKNejrbvrm
         OZ6D7rfWXoCRTrori/m89uRw0Jr2AxLlTD7TnWBwo8Etm1DmW+OKMHUlbvnxkh/bLzu5
         5qmBbBFvZMaH2m8gFfj+mgG2BDw+7UT0tjkTBhby/NsngUwCJ+gnTK3PQul0qOvSK258
         lrJ5hkAHhDBe5P90+FRSwWKA4Ne2ejqoZ3/E6rZr3PVNaml294MS/BU6MVvOfl20437h
         6yErPs6/jGbI7DYmzzqSjo/JBbr9Y8iPTToD4unRqb9hALCGJ9S5Wrg2QdJAncZmPWuO
         aapg==
X-Forwarded-Encrypted: i=1; AL+hErFVrfp049T25skA14HtEzcOcF0KEJ8zhKQvF4HHSGlILj6eJoVcQMc2HXhSMHrKZZdPKko=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Iz1ebLIgXh77VEuAbzXgFGYZt2pEZ/dsg9LifKPR797QmXkk9
	yeqc3wj2s7c902mtpo2EM9kIsYgRJsXEGc4xiOTq23ghS40hLXNYRrP6
X-Gm-Gg: AYBFou0/oaJtMLMZXit1QtPGXwgpEX4SSurHxX5DutI6v11BSp9ozJBrZMT6OMPRPfD
	Tbk7WDjqvdP+6UDuHe8A7iw1ea7thM1muZfwA9Dp/iBF8DIK7vnN1zuLO8o7Ngo/j6tzBGITBnU
	usT2y8cIp4+kHQfkoXtGDdA4FdZOEvMu1eOfMIL17UDFL+lMJAufvTXfm4BSjUcX///WagYUQi2
	6oTh3BpT2Tk9AP/diGS184CLZZvGjow6cjZ/g8BlrKs4Al3ZeZgrnM6AT8iX6WgXHJX5TNorMaQ
	F2q87l8NdpNQI9/Av2BECNF38Ey5a7MF7Q9XOBZzPDFmetZd7Rd5yuJH7W+zvV4Ebtak0trvXD7
	2wT4p/3WWc3Wh5TgaUUqs15SjXZyWTgrHt8rSJTaEXJQJNMu0kA9Qzx4SGdbuMUSjHTWvf0q7hl
	j7Wc0oc4j/SaRWwrcxDlQOsetTGrAx6Q4PS9CUIXA0Soz2kAVf1d0XDDzdXLDKIBtJIllMqtLvN
	p62/K6wEexVC+Wecyw0IdIHtgF72oPzWnEt4Q38hJJKBMTLXlO0JunMz2LITELomVr5bkFiYcWO
	gag2gRlqMskvP0sJ+bqgQjA871VaAVE9AS8PGxxom2FFZQK63wre8bxaMNQCG1Yct/pF2QlCNQ=
	=
X-Received: by 2002:a17:902:ce03:b0:2e9:6790:212c with SMTP id d9443c01a7336-2ed40c494f5mr41103385ad.30.1793988246266;
        Fri, 06 Nov 2026 10:04:06 -0800 (PST)
Received: from DESKTOP-31QBR7C ([103.120.166.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47da165dsm8057515ad.73.2026.11.06.10.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:04:05 -0800 (PST)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH v2] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
Date: Sat,  7 Nov 2026 00:03:53 +0600
Message-ID: <20261106180353.457-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
References: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tasks in SCX_TASK_READY are attached to a scheduler but outside the ext
class, such as RT/DL tasks, or non-SCHED_EXT tasks under a partial switch.
The scheduler's BPF code can still update their dsq_vtime and slice (for
instance, via ops.cgroup_move() as done by scx_flatcg).

Because __scx_disable_and_exit_task() currently breaks out of the state
switch for SCX_TASK_READY without calling scx_reset_task_fields(), these
fields are not cleared when the task leaves the scheduler. If the task is
subsequently moved to another cgroup/sub-scheduler and later switches to
SCHED_NORMAL, the new scheduler's ops.enable() sees stale dsq_vtime from
the previous scheduler's clock.

Call scx_reset_task_fields() in the SCX_TASK_READY case of
__scx_disable_and_exit_task() to ensure SCX-managed fields are properly
reset when leaving the scheduler.

Fixes: 5771e79e461e ("sched_ext: Reset dsq_vtime and slice when a task leaves SCX")
Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
v2:
- Rewrote the commit description to describe the cgroup sub-sched / RT task
  migration case (per Tejun Heo).
- Updated Fixes: tag to 5771e79e461e ("sched_ext: Reset dsq_vtime and slice
  when a task leaves SCX").
- Targeted sched_ext tree instead of bpf-next.

 kernel/sched/ext/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f74ffb3b1aca..b57a7989f304 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4728,6 +4728,7 @@ void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 		args.cancelled = true;
 		break;
 	case SCX_TASK_READY:
+		scx_reset_task_fields(task_rq(p), p);
 		break;
 	case SCX_TASK_ENABLED:
 		scx_disable_task(sch, p);
-- 
2.55.0.windows.3

