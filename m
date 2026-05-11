Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDFD3B530A
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533666; cv=none; b=PNngksBWN5VqnJhU+A2AKa5xr70XJYpk61jP3I4kYzGyNmsrX5MZ+llPFXoA+bTL+XPOuca4AQ+CWj2RAHyOyUm5ktgyN3c4iRxO+dD8dKLdaHuwm3kNj9JmJfgaZhYcnZI0PtHOJVQxd+M1CCfAsyk/8dUP+kTyWtM5roRsyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533666; c=relaxed/simple;
	bh=dQTMWkHZ+61+diF2Mv67Y7t1A8a50F5etclM7SiqmzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udtRIjue45gAO5s69LXCSBQtL2n7vAyUXcyVw/NO0ZGTHBdj+WTlYjXx90bNRfJQ3pz4gAu+IY99/78gmsGalOZzCdLRsaK15st47GEyLYH3SWsDrBpDWjXJ6A+++gwsvwdx+z3Yau6iLiZGeT5Sywfhs3SjXt5viK3q0eMmk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=rJ1XBAxW; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="rJ1XBAxW"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8352529eec.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778533664; x=1779138464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANkclkgJQIYrrBTnf7RM0dL7FCmVzN2wIW9q87YaMYM=;
        b=rJ1XBAxWuVuuduH3NI2akF35qlJF5ipLRfBcTN7+RAEVBNu0yYCqCR3U+MK2lJahmh
         M5DdANykGI2/UOKWKIvChHamW7jcuyOWcUL6LsZAN8mo7oY6b2sW31dukZ14umZuALMS
         Wot/K+q/1u4NmzSWFsCfTQUPZE/bc+o6IOL/W/8yr5u0sxApIzg/5GiCAfPQyfq7lN9z
         rHDB8P3aCXAExd3oxZnqDRxks6uSq74j1C1r5Ul05myk8xeXxpkTOIJZdqOQqyNH+UG/
         oK4e+1t/Upo7PmtonORNmQ4KH0ES3RBjqP77mxVX4aV8hm9re9caPhvUU88HPkmCCl7p
         nnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533664; x=1779138464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANkclkgJQIYrrBTnf7RM0dL7FCmVzN2wIW9q87YaMYM=;
        b=i+BRmIg6aaI+QY2WBR1QgAHy6YvE0PFHXFneU8z6czplL/RCVD6DW/o0Dtapq41oRo
         D5B5y4KyD4xDKEvV+nD2cpS+r9vMeBTFsC/Zaei1m3WcKexicckB/CF3WcCOIq/Brw3g
         S5/vGgVrWiO7wEhaeDMYRw5zZcOUbfnZW4PtrKCrYQ4OzrQC5cmNC/pUvvvviBQjvBhx
         y13ePARaRkVX4jkO3W1mWZhP/FQCL8edWY4zcUFg1Hq4MPz4k5nus4Y/62Mo9AA9RFZE
         JGgPr3fJ1S9Ci2GA3Esm+bAJhQzV8afSNNSa0ukRvO5tQ/n3bK0YpFuP4ODYkO8JRtu8
         JEWg==
X-Gm-Message-State: AOJu0YyoNeH175IoK3F/yv7fwxyMsRLVPEgDYJo6Tis64OKqT9yGmTPZ
	j9nyOO4hYDjUkL5hG8JHfALcqmywE7EwAFprQRwZElV52X6KIUrVNoMPBLCEFN74B+RyTQgUZNX
	j7i7WFK0/wG/diw4=
X-Gm-Gg: Acq92OFQt7BEFsLOMYNf9F69xeKzf/Gi6tfmFjStr4oN/rqHbJNUCV6igivR9ogCCud
	XFFli0AVe5gc19ET14QELRbQDEb4CysbXFq5Gwtx1r7/Q8ATrZMLJ+LEqI9ilx69K0Kl46aIXkO
	wQ+gp2SRQPqHqOhWCbD4QA263BoveGW+t7oIsylRDQrQPL8mTILv9ojabhaSTfIJx99DTW8rd6F
	RjCcRXK5h2Xz7oHocgBSZAGXwBJ5H7fY08Hf8UwjMOsDcKUUBieu0kOWePy41gCl0jzmCAoAXYi
	w26ra0/aqSPslpUqNsnCG9GY2z2uiRG9BMrzZuQPvpzVW2WnqbX2reCJclgdTiS3x63Ho+UdcJw
	xzUwMUQGJrVGdUxEdTsuQm94O895mUMJNHYYK32ASn5VLUxbeevTMrW7ScOarSevCKcFQNHho/W
	UGSvAH/p1YNlOxm+Gksng=
X-Received: by 2002:a05:7300:7c17:b0:2de:2f38:a7cb with SMTP id 5a478bee46e88-2f54f94487emr12171701eec.18.1778533663518;
        Mon, 11 May 2026 14:07:43 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::7a4c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm20177293eec.31.2026.05.11.14.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:07:43 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobfrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: libarena: Add initial data structures
Date: Mon, 11 May 2026 17:07:38 -0400
Message-ID: <20260511210740.5395-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new data structures to libarena. These data structures initially
resided in the sched-ext repo (https://github.com/sched-ext/scx) and
have been adapted to the internal libarena build system. The data
structures are:

- Red black tree: Fundamental tree data structure that can also serve
  as a base for more domain-specific data structures.

- Lev-Chase deque: Queue data structure that allows efficient work
  stealing, useful in scheduling scenarios.

The data structures are accompanied by selftests that are automatically
discovered by the existing libarena test_progs selftest and incorporated
in the CI.


Emil Tsalapatis (2):
  selftests/bpf: libarena: Add rbtree data structure
  selftests/bpf: libarena: Add Lev-Chase queue data structure

 .../bpf/libarena/include/libarena/lvqueue.h   |   33 +
 .../bpf/libarena/include/libarena/rbtree.h    |   89 ++
 .../bpf/libarena/selftests/st_lvqueue.bpf.c   |  194 ++++
 .../bpf/libarena/selftests/st_rbtree.bpf.c    |  974 ++++++++++++++++
 .../selftests/bpf/libarena/src/lvqueue.bpf.c  |  241 ++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 1032 +++++++++++++++++
 6 files changed, 2563 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_lvqueue.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c

-- 
2.54.0

