Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B214D90D7
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535667; cv=none; b=HbuVGXfBxsgWRV1zo2xk9mcjjeqIFJOT4NJMow7a3l4woHVoJ9lOWoPeO03cXTe3pxtplJS1vRPZ+C7P3UJpFUae4/gLtOTd3B4xuriN/tOLqTBZfK3N4z5z5A9Z3WDfQ55xBayI1EXx7IDddnkV4aypinAsIUcMmMG3dhZwgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535667; c=relaxed/simple;
	bh=wbwm5U8COJM0kcPaC0bdtnfBVVjhGb2wMIj3RlCGzv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2oaxFAzZunzRXPSQmUfE1bbrvAxxTHx3uQe6kippeQrEav0yMuGmj6fL4ngaJd6Nl6MqmZv7tBR0GMdPOuN4P0t4jasOhh2Lf4MTP+Siq6pTdGxT5NgCXKe1fuZlF+dOtUZQbvDx5cO5qyGhlnUQA8dA3L/s7dRYiVfIe5JbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=E8QT7Rt0; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="E8QT7Rt0"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8395858eec.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778535665; x=1779140465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPwXyQjW4JchVUdiHmPjQwTXFcpYTSNU8YZsNQ/Qw74=;
        b=E8QT7Rt0zivv7x8yGy5m6PWEH9WRSkjNXHr8rcekhTfHm87EiWrQAktXVYjyX/Z8wI
         jxvewHekL87vxZQxkcpwW6fUor5Srn0O4ioz1GcgO5OtMJq2EgkUEFOR4hxkCxFcCygQ
         bt8m/hWE6lm3DEmHfM7PDJNbDdST35RuhV8E6zAW7sOyXlnX5MOukvenOe67vud7sG4X
         n2G5LCh3tKc1Eh1rYON2lCJB2RUKFFQGTgZnx/roU5fzvLkE48/I3IGxpH0dizcm0wXA
         4TxKokcmnzu3l2kR+w1mbLFskRQc/giMkz7FmOdeBZfp2K4PltcAwOtXx1KDDu+TPgdK
         f3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535665; x=1779140465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPwXyQjW4JchVUdiHmPjQwTXFcpYTSNU8YZsNQ/Qw74=;
        b=ejXNnRonHMdmDQUJ8w9K6iW8Ewr5F0utwEhv5+PRXNCp8XHO4JlRiREWWzTE86yexU
         OPhPGa4om8GGxMTGSUCCITvOfP1DN4OCIgpdge4KJPnWxsBHIEcdnoGpfS67gbw3ZOn0
         UKXhMk4RPiyzubT4NRK+Q26rEkpa7qamXtK0YKF0KFcaO/nTbKOseY0xQ6ell9ELvL2i
         0OhoiMckeoUIPRjwr9pqxGAU1vz47D5+wQ3HYp/HrAY2jXG7uBSDxFTyOwSZLjNPRp4A
         OoFy28fkAcACMUp2Ao6ash+WRWOWtHU5qdcVxqEWyOxGvcfO1bGnGZAbI2nfNv8GfWWV
         7nEA==
X-Gm-Message-State: AOJu0Yy2XAtZHzOFUcFlI1+N9FltXdK5eubsDmdA4JDQwW7BO7UwxLJM
	w317oq3JZPzc9f1u/BULLpV0A17xW7hfa4DjRPH2LGrsWzLD7eO0Mjyqa2ZGzEjhuG0wl989WtW
	6lp24ljjnNx1YC0E=
X-Gm-Gg: Acq92OENEjbx91kD004ZaFpPuqjcJ12Ipm/9bGoJ9W/wHdxMHoEiTuVnDaDYYSLF2nW
	df9uRT1oDFADsWfBaJofH3257p91uRYN+2B9fCiR3rNFgun4r9P307fp5+Q+bzCJnoxYLkUz8Nw
	zDCkL4Y/B3b2xs6oIVOZtKrlfHJGn8bDtVFnvxNwTjVcqj4oLuxYPKoZ08kFm4k+g62w0nDF6wq
	uvxN+8ti7wrZ4xoO+XMMPZw8GktpIGoH0wjf74z2626+L/Xkt9/cQV2Y1Uzfs3rny8iuxLPinI9
	juYUF+j/pB2ve47Uc3uKSOorASCvLXpAzLIADIsz7RonFEJW8zFWd9AUIkAs01P7DFYhmhPr9kD
	Oxi7to7hue//qmowGdtRd70lDyL+GLmwbVXfPD5CBih8ijpPevGwqujyfBmjQSFQKrW4bp7WjMv
	6hJm6ucdcoHvsnL5/1OIxoUefTmbUp9g==
X-Received: by 2002:a05:7300:6ca8:b0:2e0:1f09:d924 with SMTP id 5a478bee46e88-2f54d696ab4mr14103820eec.5.1778535665113;
        Mon, 11 May 2026 14:41:05 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::4b34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f885edb83fsm15052473eec.7.2026.05.11.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:41:04 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next 0/2] selftests/bpf: libarena: Add initial data structures
Date: Mon, 11 May 2026 17:40:58 -0400
Message-ID: <20260511214100.9487-1-emil@etsalapatis.com>
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

---

Resending this because I typo'ed Matt's email _again_, sorry about
that.

-- 
2.54.0

