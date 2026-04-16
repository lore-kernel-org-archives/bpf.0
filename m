Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DE39D6D3
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367870; cv=none; b=KRw1TryPTCFwTKZ0g5ckyFRngL8u6AZDNY6963/yqChgMtHwIAxgfooN3FFlwe0z91qp0t852evmtOep0Mt/O26C46GnWjDhyalZyByTjpUj7edMjEFhTfewlmHywehpdqszdKmldddDO/MXIuVGtSbWdo94fE54NMOiiJ5RctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367870; c=relaxed/simple;
	bh=r4Eeeqlnty5JWhyFFs4PmBr0ldtcOWrItly6lcvC8Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXrBujy2YVVxgRWTVYQWPhiKhEAyE2FpDqm6roE18W4MzIis9Xm88pEl8OVmopX+9rY9tH8rl5TD+x0YJmWrR88je7UxTc4hYaeqoHnCHJSX95r3aZYFJXW3YZaffUhDPNeimWA28mHW5RDe4n66SlePWHQNUoc4fMCLW47yO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HcVKU3Um; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HcVKU3Um"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso81682915e9.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776367861; x=1776972661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg2etNAfQKZBd7rcNCY3p33XRFv6QLBK/6YkWrjaoRM=;
        b=HcVKU3UmRdE/4w4F0f7C/nCck/V4mTxNRWUdn7YZX+q2/c9uVDlZfXFKE2ZRp22xTO
         9YWNum3HjfS/W0p4F67fcJ/41AgU8DOhxQaAgDsuDgzmePPKCUsls2osVfgmF6QcsgqQ
         26oqWcIfZo3sQeSdm1GB9nPmCLaB/OSIyBLHFi8tB7Q2iMFWVfvujoJF14vfggE6bN1X
         +/6PqkNhPWMsIuQViySzUivXp5YlwFK8vNTmmRH9DUnNVr9KhLcRRS9ErUokfKuxYn71
         5irMRL5dOwq5RggZAa43yr1J7gqerE6IPMTT4icAA203CF5HYUC+S9VoyO0nReAGIHPh
         tZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367861; x=1776972661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sg2etNAfQKZBd7rcNCY3p33XRFv6QLBK/6YkWrjaoRM=;
        b=R1pNvqrQwV5r4x0hzmeupt/gf3ErTWcxEQlT2y8r/mmUZBqrihZ940kW6Kb/TQTAl1
         GpLAD8hXoVDI43RMwWgLRiaPjVmDbSvpSCv+5MTv4dNINjz5wKS1aulZt5MoAREfXwY/
         rKMvfutnvWH4jLrn7L6l9KImOEWb77GDHycb7PymP1LZB78Y6ba33WcSKqEZsxkwrpfi
         t1AhQgwrsay0ov++seYRO66dOMf7d/VjZOHAiwkEaQFCnLXE8j3F0I7QHcfsOK4PP6Hr
         oPC18XAvPeYbobn/6f0Cd2cu9hoXvQrsDc2SMtAz9bCtey2xaJdDF5J3fRluknx287ug
         LEDg==
X-Gm-Message-State: AOJu0YzbPeR2snD78Em2nXQ2ENGQFz5a51ZXNT8DvYaxjfFa7QiBKubN
	kLl0D51d7Pm8fqvQrM4LLIO3Nw7lc6xu6EC0NJC48JmHA5jEYykiCxeyIhuTMfKTtRs=
X-Gm-Gg: AeBDiesFnN5OsWV8vutS7m7a9Gf+/rI8RiWuULghi7T+urQN5J6EihtgrsA2EW70VHA
	mcF2mW4QmmIqUJuZLIDuKfV6McA6g7RWuYwC+9Mlq2OsXhonuOvvQzmAt5aOmm/zyq8Omtbfkv/
	u0DIkHbAt8UqMmwZZEx2OsZgXqfqcpb5rJ/e5jzbM3Z33DyZFqVSniTXaZHcVEurg7mQ0ZtoLVy
	qJCGexgokve/SAOLMc1iLPUroxzU7aRiiHZaw6Nrq7ypeCRhDGcl7P7VlyYmxuV0A8NoOrIpCyi
	6ff9CXKcCRLT7GnzHa//l6ruu9jGj6d3vtGR8XwupGEIzURCwhE8Nlet5/h+RKMRHlT2oIGFHHs
	1QsGwZ1T7HorqR0eVfxsai+5ab8IZF/y1TV8DG0uJVGcgQFPF8rGNMKiZg/rRK5PT/DrGY74zkN
	u515USVxT1FYB8VT5QfwcGOFU=
X-Received: by 2002:a05:600c:3b20:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-488fb293c76mr2913935e9.28.1776367861036;
        Thu, 16 Apr 2026 12:31:01 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:dc8:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c10a688sm11563728eec.4.2026.04.16.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:00 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 16:30:50 -0300
Subject: [PATCH bpf-next v7 01/11] selftests/bpf: Add BPF_STRICT_BUILD
 toggle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v7-1-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776367852; l=1377;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=r4Eeeqlnty5JWhyFFs4PmBr0ldtcOWrItly6lcvC8Ts=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAPbtf49MZRZIT6BCmzoEC5ue1MD2cdyhiDdjZkr/s/rJ+QXHkqIxIuI51vftri0M2v9UeZfIXV
 wVe2C4ANA2wU=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Add BPF_STRICT_BUILD (default 1) to control whether BPF compilation
failures are fatal. When set to 0, failures are tolerated and skipped
objects are reported, as implemented by subsequent patches in this
series. When set to 1 (the default), the build fails on any error,
preserving the existing behavior for CI and direct builds.

Users can opt in to permissive mode on the command line:

  make -C tools/testing/selftests \
       TARGETS=bpf SKIP_TARGETS= BPF_STRICT_BUILD=0

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 78e60040811e..c8ba8ccc2c6d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -44,6 +44,12 @@ SKIP_LLVM	?=
 SKIP_LIBBFD	?=
 SKIP_CRYPTO	?=
 
+# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
+# benchmark compilation failure is fatal. Set to 0 to tolerate failures
+# and continue building the remaining tests.
+BPF_STRICT_BUILD ?= 1
+PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))

-- 
2.53.0

