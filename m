Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2128363C5A
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629092; cv=none; b=P4CXEL7ZD0y8H84r8Zsr2AdpGG5Eeew+ecc5kI9lFYTjRi9Goe5AdoRm4BWzr4Wb5SLYiA2004kLKMLihnwjdyFaseX1LYch4qI4vdIpRTeHeIAGoXJHobVscx7paUAcAATwAzG47f/4VxpAaBoyWNqYl5Fx0S2CCM+qlFK/mZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629092; c=relaxed/simple;
	bh=oMZCJO0yTscifwcXj4R3WuQPIdJONxUuM4HNF44NyU4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sLzn09Hlk7a3EAeUX2Ry3iT60oarhWX/IH5AbkkoW7Bo0flA7q4JLuFTVsXxIL4inTPYOi0I72GU4/e9ocW/VQbthxKWwjc4AeuKA/EXE1HBUNrHp7t8FE3GrkXErTuJOpS2k8qKQZYObkDPKXmHGkLprfF1qlZgrPlf4J1QByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LD9GpG9G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjJk1McP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD9GpG9G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjJk1McP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770629090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XMqFYnQMjoFuXB5XaZ4vn5x4ztczYNKK1AvuxdTtqYM=;
	b=LD9GpG9Gz29fnalqkCWUzWyYE1T4x1R1OY00+XKVwql6Ln2Px93c5Ir3WMvYf7HJILraI+
	fctMMk9QRXUVqiQbj8qB7+KGug4lHHxxHogvzSASAFWJurUoL/L+718G8HDqSAtu+Pysvf
	u5cRaJaJyL72EtJ5fYxdhiMnmVFQpT8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-NDNv9f0gNYaxSG4p6sZxJQ-1; Mon, 09 Feb 2026 04:24:49 -0500
X-MC-Unique: NDNv9f0gNYaxSG4p6sZxJQ-1
X-Mimecast-MFC-AGG-ID: NDNv9f0gNYaxSG4p6sZxJQ_1770629088
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so58913705e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770629088; x=1771233888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMqFYnQMjoFuXB5XaZ4vn5x4ztczYNKK1AvuxdTtqYM=;
        b=EjJk1McPHbNUPAG0D+IxsepbEw44owmZnhNRbK/zBb0OtjSAvFfA96MRRqL9kj6NTS
         una7Ln8MebpXvkPhWW3t0ITT2KkXM7KqIR7ro2v5Qbiy1z83qUFyDje5r+4ulMlBUqOs
         0aQ5IBWU8mNzfILEeJ0mQl/fL8X8sIhmHzqbmWkGG47BBYXBmQ5ozU7PeLCcmTdZm5XA
         sE9IsBCs5gykeG4MWTF5Kya0mnrlZyhXhYmTSMAvUIJ4dIhiC9/KNk0tSRCwXeCsvAG9
         g2YZDvVgfiJLJgmZB6Frk+8e6F0g8cjFNxsbrrnfZw4tSY3gFhC606gCNbTavklKgXHy
         WUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629088; x=1771233888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMqFYnQMjoFuXB5XaZ4vn5x4ztczYNKK1AvuxdTtqYM=;
        b=A6m4rxIaf71fltJErUrT/V7Vy+tTvh/s8nQbBeEZrAce2tu4B28t2UPa2ne+NFk0QR
         e/K03HQ4xa5syN2Lqx+jZ13xQP5BdOK+uXBlZbIUKLzYq3Tt/KxvqAF4ItW87254iFiw
         b4LukdakVkUYcH1EfCw+y+fnwvRhvg3vwkPDbtS3dEhxpFhcqb2KI979O6xUCsYnaUU+
         L/ZKWEVn/yrv2basVHax2GXMoWduatBU2VTH3X3dcmOX1PSn5T0S0Cs8LQIYURP2Z1pn
         EeYCg+ytwdHS2cZLShzbVPKM32Rptf5Xnr2+KiK1lpkiCumsoDoyk8F8T7fHFJOR2M3g
         Ulzg==
X-Forwarded-Encrypted: i=1; AJvYcCWVTy553tdk212boOWpPsKgZFH735dqCSPrOpYT4BOtNs26Hrk/hhjRAGKJj6Jnn4dDLwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhI9fMPVFvY7hMLLxfOpMAaZB8ad/DKoZdya1kX+9na7bSfTRP
	Kyo4aoVYfIaJkMKmEcHQmRspFrWYUAVghJcj8w03br4JdCvp+OqGEloqt/kuJB9CuRHCfyV8Fv5
	TxL7ukpmEmQcXHmsBkM3FpaoCH3Il+EeAtLETh/dxVke2TVJBM+SsFA==
X-Gm-Gg: AZuq6aJE13eyYLJGhyjeCFmb/K/O7Ag7iaOB/Q1CHdin0SNUfNJEw9zDOqBpebGMHVS
	4uH/Cc+ET2hDC53L8tzU7I9mKR97XozSzMqools3Cb6eaA3sPOqn9BRFkFh61JBq+xAayIqZWxs
	FJw15eQjjlSqu03QbC8hqjxIbFglCRdljaOeqbrhv8lk/fA+Jn7SKiKKwKh5zMyfKkKOKIDq2to
	gevE2wD/u3Ib67eReeIBzXJ+9V/pTdk/xuWfFba1En1wRI3puj3ybPEmFVFv29qBkaiDxUT7Uhm
	k7m74E1EKxa+o4oXeKbs++lzCEs85GGZblwrojm4AmdKT+PVBuy0Ju6SyNEfZ8p4D+vjw6eoEqk
	WBORLiWrnOOOJ03weC+t7vzCXjA==
X-Received: by 2002:a05:600c:6285:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-48320231170mr161098315e9.21.1770629088346;
        Mon, 09 Feb 2026 01:24:48 -0800 (PST)
X-Received: by 2002:a05:600c:6285:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-48320231170mr161097875e9.21.1770629087862;
        Mon, 09 Feb 2026 01:24:47 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33f5fsm316310295e9.5.2026.02.09.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:24:47 -0800 (PST)
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
Subject: [PATCH v2 0/4] tools/rtla: Consolidate nr_cpus usage
Date: Mon,  9 Feb 2026 11:24:32 +0200
Message-ID: <20260209092436.2899888-1-costa.shul@redhat.com>
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

v2:
- Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
  pre-C23 compilers.

Costa Shulyupin (4):
  tools/rtla: Consolidate nr_cpus usage across all tools
  tools/rtla: Remove unneeded nr_cpus arguments
  tools/rtla: Remove unneeded nr_cpus members
  tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu

 tools/tracing/rtla/src/common.c        |  7 ++-
 tools/tracing/rtla/src/common.h        |  4 +-
 tools/tracing/rtla/src/osnoise_hist.c  | 26 +++++------
 tools/tracing/rtla/src/osnoise_top.c   | 16 ++-----
 tools/tracing/rtla/src/timerlat.c      |  9 ++--
 tools/tracing/rtla/src/timerlat_aa.c   | 11 ++---
 tools/tracing/rtla/src/timerlat_bpf.c  |  5 +--
 tools/tracing/rtla/src/timerlat_bpf.h  |  6 +--
 tools/tracing/rtla/src/timerlat_hist.c | 62 +++++++++++---------------
 tools/tracing/rtla/src/timerlat_top.c  | 47 +++++++------------
 tools/tracing/rtla/src/timerlat_u.c    |  9 ++--
 tools/tracing/rtla/src/timerlat_u.h    |  1 +
 tools/tracing/rtla/src/utils.c         | 10 +----
 13 files changed, 80 insertions(+), 133 deletions(-)

-- 
2.52.0

