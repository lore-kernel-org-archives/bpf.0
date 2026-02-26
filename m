Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09021DF74F
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772080276; cv=none; b=Dq6SfmVa125ekV2Mf19dkSsOhSY3FMr8nh8s7Npp6n9A00p5uJhvDleQaOu6ycAh+5g6YITlRuQv27tdluX3ErKtcPPxzNpzvk2aPXkbsYMKhncqQK7qBlUMcqCZKto/f9d/OAd6zFOuVaMNxbxBsNnk4WXcoFwti/tPS5mLNg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772080276; c=relaxed/simple;
	bh=nK8qcsqNVsBEnxLUHyrMO6wpcLRHMcNreNEXj4ei7ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQ38wULE9cIIGeAwunA95FN1v52iPYHEUmoU6e0axlV2ycjefas1JeXiAAf4QCWn5xCE5aCckQFhF9lP8WB8/shSk4jLMadboA1UnHKUweUWv09bU55QTkjo7GuoW9dTra8JRUXeXT5jG9JihXEcBtqblgxwZx0AZ3AA2Iu5dV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDvt4FKu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDvt4FKu"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c65d772cso175653a34.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 20:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772080275; x=1772685075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c+X0lwtAWesW7kcgtGHzcZxnylsx7SbXmwTh5mC2Kk=;
        b=JDvt4FKuNOWOmh3M6EukUfOqPnH+ItAbxtDPHAWhZhReAb9ODBVWkf0qtC7+DYZ88d
         IkU1wzeOY5M6KtZkoqStFiUrh1KvyEOYURkhwoT7t3J0Po7/4vpL5K7NjNRjFMgvLIoc
         PxvSP7A9FZNWmrYkacvxL2scbHOaWSTkASa7nS/cLedyrx3rSyCJClp+Mg9FlvjYvIYL
         dVAIaY9KZ8Wyf3WOQMJ8ebqhFqUtlcpPurRd31oT8V1DmR2dgWGcNdVNCLROa5mvfNVc
         egcnAGJMVQRKGiO86SMMOn8cHmiSn/jsgTYav/eHOQ3g+2fFOY4GcUOyHGt1wykgkgFL
         Fh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772080275; x=1772685075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7c+X0lwtAWesW7kcgtGHzcZxnylsx7SbXmwTh5mC2Kk=;
        b=Jk60HEWLyL0dsLmtiD7v1t/zcK2Jc0vPvC8HT4aTWAudXy6ljCKVi5ZGW8VR/fhTUm
         s92hZJZfRxR3yad0bjGst2i3V5yWytx58tJy/LP7doxLLWQPYc2ylUizhVRNkgCMBRnm
         Ezj2jQdEyIbcc40OA2q5ydJFN/P5ezPwKlqWJpqpQWxsBZYcnwfT5l1ss6sMLQJ1YOi+
         Z7dtuEUlyRJafMUUdqZh2Nhc3bo64YFjI6bsGMqyDF+xLI4aXBlbI2ehYjRLMNhcE35j
         +xIzRsd0iphOXblPwWdmthDav35A4O8twtNbfZ1dBHVVBT0hIY6xd3PxAWyxky/1UtPm
         KiIg==
X-Gm-Message-State: AOJu0YyX5GjWIyqijrnOfOdGTsuEX+MxzcnvChP7u2iN/WybH2RbkoTD
	WqfY7x2MVIJjmSnCBma4mnn13Z6sXElulZmUw4b+mxQij/nHOqvywusR
X-Gm-Gg: ATEYQzwA6biofU6Ke5Z/G7zYOz8CpkIvPer7zuDcWK8hbgKkKzBsW/zuGNxDtl917Jk
	+gPG/zDphBKNsXajAMuZGX7bV7sb5rl6CGo+iLrgC/Li1QVfsmr6yilAY4kwqc2HD2ZMZutZBR5
	eMwNr6i7aHT84PtsVg1M+3kAHgOvYoYQ4gjebe1Tf7QjKLfbSPQIQMBB4h9sAaQaLM86KBv7a1G
	MgrYHkBqrdfW6WkiDOt2HA9ZgB2hSK0rKBIuOovcFxe+w+aMQEY8zEUh5QLu3SgTbxjzVtfCtjK
	/1LdGDjWGeRfXc/s8xEzAHiimM76kGBIKBuPBPXRLPp2JIn2Ycpdb87+2tjOnxTO63BK37qhvKX
	zlcxIUU9rARgCmW57mD/wymEeZimvzOzLTh0mHvP6UzNr/txDRNMopPQCoc6s73Xr/ZodZjCDI/
	bmhYsCaKLENeniZpTSfl2tKDHAX7LSrfrG9q+ExY99ZjmZmUuU5tEuJ6Vfy6MrBmeMGg6MuMvHX
	7TXarZeCMwkmzcRNuYxQpo=
X-Received: by 2002:a05:6830:6419:b0:7cf:dd63:3d52 with SMTP id 46e09a7af769-7d586f37d0emr502232a34.18.1772080274771;
        Wed, 25 Feb 2026 20:31:14 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586653f81sm806659a34.23.2026.02.25.20.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:31:14 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 2/2] selftests/bpf: probe_user: drop serial restriction
Date: Thu, 26 Feb 2026 12:29:49 +0800
Message-ID: <2d193ef21754e23bc915645d9c54d3be8ccf4186.1772079741.git.sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772079741.git.sun.jian.kdev@gmail.com>
References: <cover.1772079741.git.sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1/2 added PID filtering to the probe_user BPF program to avoid
cross-test interference from the global connect() hooks.

With the interference removed, drop the serial_ prefix and remove the
stale TODO comment so the test can run in parallel.

Tested:
  ./test_progs -t probe_user -v
  ./test_progs -j$(nproc) -t probe_user

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/probe_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
index f50ee4066759..0ace1cf157ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 
-/* TODO: corrupts other tests uses connect() */
-void serial_test_probe_user(void)
+void test_probe_user(void)
 {
 	static const char *const prog_names[] = {
 		"handle_sys_connect",
-- 
2.43.0

