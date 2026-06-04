Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0001923507C
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598613; cv=none; b=TR/l0BpZEbcXgEHCu3cWtiq7Mdm+QDcz8LfKAxXRL30d1vng3TiF7fOrv/3G/dF5ehiF5FpMDp6xRi+kXBCkEzM7qY4eacoz5JVeCdBiXQfTF3WMG/ZY/fxYs+0CobvRpGlQrKk+aDh+761/0fn+OFBNcz+xXFlKJhg1IGgRtOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598613; c=relaxed/simple;
	bh=sfuQKsrhoFs9kEK++3rk/Bea3itFrBaJOsBc4qGq6p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKYW2hMQ00PZvv2DoHOrzd7sXRTs0qQ2s4bKvtTI5Q3S3UBGClIGoZj8pcORJFkqAYX0Xq1LHHB0R4dGeY0M+ZIoHC805FNnKzBpDi5lul/X/o5UHA5JU7nN4lMm3bokT5l80KNCK92pukaZXmivu6dY2HgFwxzMfplZJHE6uOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=R4iUKOaq; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="R4iUKOaq"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-304ec41197bso1170859eec.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780598611; x=1781203411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAySu/uWGaPa4aKm9tW80sqWhOtJDWki4voSoEovBWg=;
        b=R4iUKOaq4kNIAS0Ip0/HmK2cQXbhkC+GWNTP/EQcAzEeHnbMoO8ubis4PueSit6rnZ
         RffJQEK5FccywnziwOY1PeIbJxjjdKzIL4Z774ZsNM2TpEt46Uij8APdOcVso+A6tPC1
         hWB/MkZKrU3TgsAdev1YnfdfC9yapmm8hO8MZetwsElCEKiStXiXTsnWf/nk+CvqCfk6
         PXdE3o5afBAa//YzDo4jbVGrHWvfY1PzwE9pEscqrCF2BUgaj3DV/NItGawHQo284g7/
         Of8QKSLHEnR2uJ6gpH+LEo3m+9IB6HyHrFSOaNBRUbWHkH+/Bk5mLps7WUF+bustJpnD
         UT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780598611; x=1781203411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAySu/uWGaPa4aKm9tW80sqWhOtJDWki4voSoEovBWg=;
        b=L8wpQ2spjWmglhR9sW43I1AIpeiZSQWyVKsjFx1f0GgkcBgMz5JVVx+qf9vahCYOH8
         xgt5zfzsZmsrOEkH33fVoz0xMJ7PPaDZHBBZCv6/sDMzAZnkbC5bQvFk4VjMoR3qQJdn
         TJyNzRtLuG4nW/1fiAsM+Mm5jp2wnq+nHzY4d40Nf/bQQKIXlpBc7QYgdH8IGtQXDEtj
         tHRq+vmv0tr45zNQI91597fpKaduOnRpgIDQZmYciDvoqtZ05ItRhLz9rIJXIvSJHLeo
         k1mOPMv52NGDDxfxE+Apc37jgo2PtQXkF52ut1zYMoXXPgDK8L/hDEnTlDs0WiH3acA+
         fosg==
X-Gm-Message-State: AOJu0YyzprN9Luj+Abe1MOnvsz9rFPJ4Thu5gUYW0209Q//SCekvK6ZT
	vfDQjCegZT/pH7B484GSK5ADVItWIvFjhALehSHaF95Du4hyjj7v1WxWVxou7nzuOnsG4n8tffk
	qOGIpHAZK9Ns3Jw4=
X-Gm-Gg: Acq92OFfOf0+yVTjFzkHskaVUA+RFiZPpjjEF001lLzbNk/Gdv8eLUvYd2UhJhEmh4z
	+paSqQhYCQF/z0YM98L1XhkujFiBxZ6ii2/XMZFh31X7yOVnMUQS7FJcLqDFeccs0USugNvzOSI
	FsCPhaB3377JW9UM1uQJqt2m84ykwTrVsS7xsXhh3Hzieah53IHqYLuQq3jUSJJYCa6072YDjPx
	bxw9B4PracOSdXGI4OeU1Jpokw6A9J6wqLCqIvG+DZbFGLQmH9uAczVBFFaML0eMvIQhjcPvFiu
	SQZ7xAWutCJbXqYVT40m+SPTm+RnsS5i7ZNkLcCEIY71zYHW4jMVMwNoL/wSEqD6k7Z5hz25RGZ
	17xyDXzHz6Q2Pqg/H73W9SRvrYhPaQAVGdTXDYxk5aO17Ew+smntRXsYMF2iF5e1vg4Ib2fdAoW
	RefA4XzkXmkcoJidU8YrmbW3S5sVzp+A==
X-Received: by 2002:a05:693c:2c97:b0:304:caa4:3559 with SMTP id 5a478bee46e88-3074fb4a3f4mr5022933eec.22.1780598610901;
        Thu, 04 Jun 2026 11:43:30 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::5939])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074deaab1asm5293964eec.17.2026.06.04.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:43:30 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next] MAINTAINERS: BPF: Add self as reviewer and run parse_maintainers.pl
Date: Thu,  4 Jun 2026 14:42:52 -0400
Message-ID: <20260604184252.9917-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as a reviewer for the BPF subsystem. While at it, run
./scripts/parse_maintainers.pl --order and reorder the BPF-related
entries in the file accordingly.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 MAINTAINERS | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index afae76600fc6..87ac5cafb55b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4811,12 +4811,13 @@ BPF [GENERAL] (Safe Dynamic Programs and Tools)
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Andrii Nakryiko <andrii@kernel.org>
-R:	Martin KaFai Lau <martin.lau@linux.dev>
 M:	Eduard Zingerman <eddyz87@gmail.com>
 M:	Kumar Kartikeya Dwivedi <memxor@gmail.com>
+R:	Martin KaFai Lau <martin.lau@linux.dev>
 R:	Song Liu <song@kernel.org>
 R:	Yonghong Song <yonghong.song@linux.dev>
 R:	Jiri Olsa <jolsa@kernel.org>
+R:	Emil Tsalapatis <emil@etsalapatis.com>
 L:	bpf@vger.kernel.org
 S:	Supported
 W:	https://bpf.io/
@@ -4826,7 +4827,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
 F:	Documentation/bpf/
 F:	Documentation/networking/filter.rst
 F:	Documentation/userspace-api/ebpf/
+F:	arch/*/include/asm/rqspinlock.h
 F:	arch/*/net/*
+F:	include/asm-generic/rqspinlock.h
 F:	include/linux/bpf*
 F:	include/linux/btf*
 F:	include/linux/buildid.h
@@ -4838,17 +4841,15 @@ F:	include/uapi/linux/filter.h
 F:	kernel/bpf/
 F:	kernel/trace/bpf_trace.c
 F:	lib/buildid.c
-F:	arch/*/include/asm/rqspinlock.h
-F:	include/asm-generic/rqspinlock.h
 F:	lib/test_bpf.c
 F:	net/bpf/
 F:	net/core/filter.c
 F:	net/sched/act_bpf.c
 F:	net/sched/cls_bpf.c
 F:	samples/bpf/
+F:	scripts/Makefile.btf
 F:	scripts/bpf_doc.py
 F:	scripts/gen-btf.sh
-F:	scripts/Makefile.btf
 F:	scripts/pahole-version.sh
 F:	tools/bpf/
 F:	tools/lib/bpf/
-- 
2.54.0

