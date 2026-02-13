Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3512D836D
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983579; cv=none; b=uJ3YoX3CAose2fmX3B9NOZufvzP4z90kevElii5hA0ih91q6majpcCN7mQTr6c+ygGRmQL2md79tBpGzKwybJJWjeTVomOn/o2W6MzUZAb2GWaBrRS/rVcK/iZbVTWmh2frIEUL1zEcGoicFaPJd0It3QvD9wC2OiJgddHvOyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983579; c=relaxed/simple;
	bh=M+d3eeyRJDp8lq2b1FuTLoytddjo6EdJUp8ehWym4iU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WfJdzQ1EkzVyuARQg5XsdYNmHdEj74M/KhMLG8Y9EcXFJm7/9uVWyi9iBfYn1NCB2VkhPS4HiSpv7JSOsVggq75DYk1HD0CZbyt7hiWQa5ayu9+lifrhnc5wPuAJC6rWeDbyiqGYio8RVN5t+TKkBNUY4iqQvyQ9FpQTqY0m414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/kAkXM/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuLE+QN3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/kAkXM/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuLE+QN3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bABqLmZYMF+yAdDTmCHTcvVEVd1c5O5Y+vXfK82IHSY=;
	b=X/kAkXM/zW7CLh+64628HGqyBwGhB3Q0j5IO0Z4riFb2x0yJjAkJ/qO8arXgv7N+TTpntc
	C0IE3bZOJo0rqWdT/pUw7dfVbUy/8/4Uacs6V/x3VW5xYZoHszG1gqk1Y5TxcFqkj/ZG0R
	FuQeYkMVF/WK3Ibzbjv9Sai880qoGKw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-NlzL2ZDzPbGMdEpfaG1Npg-1; Fri, 13 Feb 2026 06:52:55 -0500
X-MC-Unique: NlzL2ZDzPbGMdEpfaG1Npg-1
X-Mimecast-MFC-AGG-ID: NlzL2ZDzPbGMdEpfaG1Npg_1770983574
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso12276485e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 03:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770983574; x=1771588374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bABqLmZYMF+yAdDTmCHTcvVEVd1c5O5Y+vXfK82IHSY=;
        b=UuLE+QN3xqTiqP4BYroZWHlLll5RQotMNRYopU+qcILIqr/FViSsMvb12T/pFeYJL5
         9Uv9lZvz/p9FVZnSHJEWNNmSJv7amdcKgfnjYucvVK+Q850bGXTGjrNQCttpBhkkQspW
         5liZa++cc5/bxLzbkxHg8rmW/VNywOlP3CecLuybmt7iEkatk8UbchD4Q+8nqSRJmggw
         qq/J4Ee0ft8uiO+jyKUx4x10JEMVzO6eiLt4qckmyUV0z/c6YxaBUluYFeMn0X3AQAtt
         ysbszHNM961jhgSri9CAiRU9UnjWgu0/IE61mJU3N3xl0e6x8zy0BMBLMrwRgGNRi7J0
         TyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983574; x=1771588374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bABqLmZYMF+yAdDTmCHTcvVEVd1c5O5Y+vXfK82IHSY=;
        b=PkJKEthWKZyVge2C9hsuPRZcP/pW6iv5/uaaE/8rpeqF2SusgG8aCtslYfBD9twZ2h
         MVJ/V9WXPQCksICArYtJ6shTVQXs0PD6LRYoWRhpgYQmEPqKnR2aW8dgQJODZFY5Udgc
         /v08rcAUZSANvIQEAU/Vle8B4NXkAmMpACLmOIYcU8xejntonm7ZMwSIR57niwFJvFbf
         89VkORUvc8uclKmHtwC7NFQ+X5nyscRBYH0QOCZ2OXz9WbgrpwdzveL53kSXvlDs3SYl
         vroOOMaFKk9sRTFAGkwRLvPbGWEVUgWPdSqUvuPNSmTcIu8Uqjp0pLMNq4xZFWzY+tYB
         7lKg==
X-Forwarded-Encrypted: i=1; AJvYcCVPQgEkhyllkdoAOsMORlswF0a+iibdgbf7zW91vGKt/vZ3kYy0gkDiGrUII2ZYZiVdlWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN98whkUz1wVrHovN4tWWwxwNvCkMCJ8Nher4Ya6gtao60Guvn
	RCpVAGXRwzwVLq/zc3zfGqyvAo7fig4AHddIKdeMSWaDkZ1sNsjycXdvmSzMWwXkvSwTh9GqHBa
	evWsfzUJfscUXm0wWsyj4cEieSQcTJBB3/5DL11T9+un3suEN6kD0JA==
X-Gm-Gg: AZuq6aIcmwyfxH8POW920mwWZ9f/vw+KkWmjxT40qrlyRU2sXUi0NXpTb3zOiLaV3oS
	lSFWaX424/19frD2EMUP6Ko249/0EKNf1ceK81Olo7W5j9uHshpwSS+wh5DjGxTMuXys8M9LG7l
	iV5n2TXvcvZzXoOKZP1Kjn3yz9leqN6t6ui8TkJ3pJ7JxYLFqFID9ODSK14bRJBNHTqFT3Sf+XQ
	3OpXdOrux8mkqzgl0szabE1GtGgNZ8Rx2aznwK/YsEmpgec1Ss6hvEM9AjhDOzjk1nxWhf8OOuk
	2b712wkZ8/An36E72n0RtlJyh07T7Bf7eSYg0DoKO5eFxt5+0OKVbanw9Y3JqlsYtNXnBJj1gLS
	AJu0UO/g//j+Gaw5VgHoFTe6+qa6+bbMxoJo=
X-Received: by 2002:a05:600c:4685:b0:483:361b:deff with SMTP id 5b1f17b1804b1-48373a25cadmr23354065e9.14.1770983573990;
        Fri, 13 Feb 2026 03:52:53 -0800 (PST)
X-Received: by 2002:a05:600c:4685:b0:483:361b:deff with SMTP id 5b1f17b1804b1-48373a25cadmr23353745e9.14.1770983573553;
        Fri, 13 Feb 2026 03:52:53 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:52:53 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 0/5] tools/rtla: Consolidate nr_cpus usage
Date: Fri, 13 Feb 2026 13:52:29 +0200
Message-ID: <20260213115234.430232-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
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

V3:
- Remove unneeded cpus parameter from timerlat BPF functions as
  requested by Wander Costa.
v2:
- Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
  pre-C23 compilers.

Costa Shulyupin (5):
  tools/rtla: Consolidate nr_cpus usage across all tools
  tools/rtla: Remove unneeded nr_cpus arguments
  tools/rtla: Remove unneeded nr_cpus members
  tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
  tools/rtla: Remove unneeded cpus parameter from timerlat BPF functions

 tools/tracing/rtla/src/common.c        |  7 ++-
 tools/tracing/rtla/src/common.h        |  4 +-
 tools/tracing/rtla/src/osnoise_hist.c  | 26 +++++------
 tools/tracing/rtla/src/osnoise_top.c   | 16 ++-----
 tools/tracing/rtla/src/timerlat.c      |  9 ++--
 tools/tracing/rtla/src/timerlat_aa.c   | 11 ++---
 tools/tracing/rtla/src/timerlat_bpf.c  | 19 ++++----
 tools/tracing/rtla/src/timerlat_bpf.h  | 12 ++---
 tools/tracing/rtla/src/timerlat_hist.c | 62 +++++++++++---------------
 tools/tracing/rtla/src/timerlat_top.c  | 47 +++++++------------
 tools/tracing/rtla/src/timerlat_u.c    |  9 ++--
 tools/tracing/rtla/src/timerlat_u.h    |  1 +
 tools/tracing/rtla/src/utils.c         | 10 +----
 13 files changed, 88 insertions(+), 145 deletions(-)

-- 
2.52.0

