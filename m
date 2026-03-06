Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075642EEBB
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826674; cv=none; b=H9d8CkUTT9XqXppcKulycPvWW6cinlAxPBKqy0GS9jZ6i+2e2bCgdStPxCnRqRXlqEBR5MvUr0VEcL9a4U0fXjOm86zW6By0Zqegg6kFsC/noHiZdmK3JhBg2zBFJT+bSYo2VVDyUv5wMDx1s2FKHwBLuGYp9W/BpyOtvZV34ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826674; c=relaxed/simple;
	bh=26QaMlsBHZXBBsoWb+RFPRcsWBtokGFkKVFb+dwgdz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YfZBVMqcvd5wv7ApAWCSAveTvZ8LQFjxwy0cT+9xYaisga8iTdfovc6zmdsiCy9ZiT9qf5ccDeD88fphX25VHTVUR6aq23mZWnstphFiYmQzb8vCgDJhNd8o8LkA+91VcyN6kU1TttA84rMaKZoOiOLrvPKcDgf9UluMdNFqc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fC0pLv/3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNdHoM09; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fC0pLv/3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNdHoM09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772826671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lIsA0vBDr/Zf85MeCX2VIrGY0ZH9k8QbBxgGKGtnSCg=;
	b=fC0pLv/3MKiqW/cOCj0Bneba1kDdydcGoSYpGEVdF3eAjIXOlV8RM2CqTnXZz7G+FifMV1
	mAwD8SJvFVnv/VELEG2crkHdEYjLFKOiOqvnBcEGdoDXiHpV8iDI6nYypcLOvz4u9bmYe1
	WVNuHl1G+gWax5an2cOEfpp9ijYlPMc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-sq6XfE5xMDqVOMX02yiX9Q-1; Fri, 06 Mar 2026 14:51:09 -0500
X-MC-Unique: sq6XfE5xMDqVOMX02yiX9Q-1
X-Mimecast-MFC-AGG-ID: sq6XfE5xMDqVOMX02yiX9Q_1772826668
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48529c087f6so5774575e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772826668; x=1773431468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lIsA0vBDr/Zf85MeCX2VIrGY0ZH9k8QbBxgGKGtnSCg=;
        b=NNdHoM094dTl03N5MB2JxgRli671micuqf7XVaF109ag/IogQDr6K6T9Lxm+L0j4Ys
         lMc5kfp/V8RxyuBdQr9XXKbnbPHoim51MZFeymf2jDgbEANpYYZFlhaQhx2ZS1pMzO9T
         8bYABPEqWShaN0WF6AbaT3KX4i7lnhCNLNm6GSzKVXeqEdsH/TS81k6evvEbDydIiAtP
         V9zPm7++zi7TsYyVInQEJYOJF8OkRQkk8HNxNwlY2rZ6nzsSpmmcNki0Pzm4ngDLYgm7
         hGkuHAkMa8a1PACs9nQa9RhUha908kDM9dP7wwmoe33HbZs2BkY4F9gzncXnt6fd6FOP
         4JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826668; x=1773431468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIsA0vBDr/Zf85MeCX2VIrGY0ZH9k8QbBxgGKGtnSCg=;
        b=YYkyGVHD5VmgekPKToVDcWArGu2FfEfcSPKVUm3Xbi8/jwDsNajoB7wHbjS1iUTMMY
         bdBje9UlC0b41GtwU2gTUtGpo/ApUuWozkjSdTwxCt9JswZlDWtimSe53ejDQFJSDYm5
         RAKO+CiUTapzOzZsNTUPrZujLGwbE58xF14MHfdPJQ6fhwXpMkkNkuVUR7bx6FF/mY0c
         Pt8gJgIHG6lC9Lbkz/9dATnMdauxqPE9ZbfEnHc3rDUmqKLCUXnJQ+OiEn9W5Zy2iXqE
         ZmTa/QsbxfW7VgcVYeVsSm7z0aNH1GJCYxWUEHi/Um4kcohEUGQEdEjiL1XzQ4Q1qnmc
         AGfg==
X-Forwarded-Encrypted: i=1; AJvYcCXVK6lrnsEah3cPWtRhHRaBZ4kU1QmDjepDxJL6o2qh6W+PyCPPzvm3MW40c1+tHC5yI7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EWZL+d2iFc10gxCZJFgbcVWDZfbo8ALix12GwjwFFKROQ83I
	31dRilMsHYGG7j4vxLPg9DWml3QhmEiX7LKvaVo/jSqpLj9hDXSGDtb6Dj3eq0ykf1caFFxUzgF
	xpUbke9LeTeB4VkaRAZGa6ymc5jr9nH8kFyJp+CiyRhE5ohSyG1ifGQ==
X-Gm-Gg: ATEYQzzmDkw0CbrUdAXlMNMoFSVhMLnAzz8aVpWZl9w/KgSJvlJASquq507gD31e7lW
	ks6D312/5lz46dya2J/uy82+W7PFCqJCICXIlEWfz9jtYrlhKNUUq9NX2bDGbfJPbwiwFd3fXrQ
	L6wccNLPmwFwN8zAlkO3Y8qIQUkG6D5HUdYiBfmZWC8HXxXcwQr8dKCAoLa+udFdnh0NRvAkeG5
	eLJEoCbbvORwFKRVpn2uYS9yxOrEYibs1NXTcs4XP9Ap+j/p9MlSBHLpaXlo/RIBZxRp4UG/lWy
	Iud7f48L6UITZUqPhq+i+rlPNXX2U9ns0QkNXnQMkr6xjuS7JjkpWaZ85f0N4r2ObaVGO2lgla7
	60OHbhD0D1U0MhaSpQx1X2rFclHAibsulqNURCw==
X-Received: by 2002:a05:600c:c0c3:20b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-4852a85e711mr21979795e9.2.1772826668402;
        Fri, 06 Mar 2026 11:51:08 -0800 (PST)
X-Received: by 2002:a05:600c:c0c3:20b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-4852a85e711mr21979485e9.2.1772826667946;
        Fri, 06 Mar 2026 11:51:07 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b75eesm48596485e9.14.2026.03.06.11.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:51:07 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 0/4] tools/rtla: Consolidate nr_cpus usage
Date: Fri,  6 Mar 2026 21:49:48 +0200
Message-ID: <20260306194953.2511960-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
cpu_possible_mask, which is fixed at boot time, so querying it
repeatedly is unnecessary.

Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
global nr_cpus variable initialized once at startup.

v4:
- Reorder change of BPF functions
- Update unit test
v3:
- Remove unneeded cpus parameter from timerlat BPF functions as
  requested by Wander Costa.
v2:
- Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
  pre-C23 compilers.

Costa Shulyupin (4):
  tools/rtla: Consolidate nr_cpus usage across all tools
  tools/rtla: Remove unneeded nr_cpus arguments
  tools/rtla: Remove unneeded nr_cpus members
  tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu

 tools/tracing/rtla/src/common.c            |  7 ++-
 tools/tracing/rtla/src/common.h            |  4 +-
 tools/tracing/rtla/src/osnoise_hist.c      | 26 ++++-----
 tools/tracing/rtla/src/osnoise_top.c       | 16 ++----
 tools/tracing/rtla/src/timerlat.c          |  9 ++--
 tools/tracing/rtla/src/timerlat_aa.c       | 11 ++--
 tools/tracing/rtla/src/timerlat_bpf.c      | 19 +++----
 tools/tracing/rtla/src/timerlat_bpf.h      | 12 ++---
 tools/tracing/rtla/src/timerlat_hist.c     | 62 +++++++++-------------
 tools/tracing/rtla/src/timerlat_top.c      | 47 ++++++----------
 tools/tracing/rtla/src/timerlat_u.c        |  9 ++--
 tools/tracing/rtla/src/timerlat_u.h        |  1 +
 tools/tracing/rtla/src/utils.c             | 10 +---
 tools/tracing/rtla/tests/unit/unit_tests.c | 44 +++++++--------
 14 files changed, 108 insertions(+), 169 deletions(-)

-- 
2.53.0

