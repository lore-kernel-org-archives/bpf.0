Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163836A35A
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404502; cv=none; b=iYt1Z98WcJZBbqu/mJb+teay6Gf6f0Nl8qhGWedxr3BUSoJYSe4NlaQKN00O1VVQ6xsCb9UzZU/r/9SGyrsdmyAZ6Bxd2jwoutoTXoLdYxubZRehNvlnV8L4tO6NHELqABRfMQdpJdVy0eX8lL0wpvE2FFAzmgKksLuJIDc1Uqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404502; c=relaxed/simple;
	bh=ZT8aj6S+na+j+Btp+fT7CSFDMUOQI/VUR0MhPkxp8o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6yK6mFK4kaJybcL/joWx05k0uuX00Tbiy2pOzQ9RGaEVhqTRz45unb5OU5Hc0jI9EKo4hfgveMXUT2hPPqLFx+LAjPspHlxwc9P1ag5tkifeEKJhFBUgux4EDeOK59P4CS6zwvRs86+855NY1HUgk7SCd+wJ88cjXFBFJLremw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9AWHo27; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9AWHo27"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca12086c06eso2798610a12.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 23:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783404500; x=1784009300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iwBtszJm0T7qJ+C73l5jdkC3o8ClI8QQ5ln+BuSFhXY=;
        b=g9AWHo27WPit0s8TUDeR7TCCak4IGBXsvuqHgOMy6PUSRi95ihh8HXSpKWahuzkMpb
         QZUWMwdiIQSzjSfFtuCV0icXdWXfeyj63yX1lZ76u5kMe2u5AIPy8u6EUICpZuXNZkNN
         zDzeJaO0SWsMc6jayhLCK2L3yYKuQvKDceGTgyd9WFBJ5soiUVMhEBwQb3t+F4QcKXQ3
         //QWmu+9RThTurqgq//tlpoW4jdZbCTEgV4opWPCzaT8g4j/w/+X+k23YbfHY4KK2ZLX
         AvZeFueJcjf3E/1Gog42hsvuSNVLN43/DIK3xtl45gPS6UfqOTou1K86h8Ju4eeEtyl4
         gUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404500; x=1784009300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwBtszJm0T7qJ+C73l5jdkC3o8ClI8QQ5ln+BuSFhXY=;
        b=H/rh4icttnWT6/kulQNGInvmwsyGJ3/rifYr2cVo4KjRUYjDSie/czixGDkAdBSlud
         v5NXFqHkBTs6Z9JlO/Lf0J2id5h4IK1/COhnekmBbmYKsJwUdyPUArxyQrIgKNqGJSE8
         nssFbKHnz07YeL90jV1/dcwbCxGZKSbCZ6kSwmhZtI4UGlFE25lqukM3wsU/Y2eOJj1B
         8JMRhqX8FCqxHTllJkpl2reRLtgkPi29d2D8OU0XihQv11Zt6l6RnhSjt3xoC7f/gwWE
         jRakZovj36DM6vsgPMDgIOGeP/tHj8fULWiY+8JCdKM4JyCldJ5qVBy0gal3xl6zD8SG
         yPQg==
X-Gm-Message-State: AOJu0YyH29hZ8n+WjjVhf2vUiWyoFth8w9bSiFyf/X42h9VHASLpeids
	YnCn/ADG7JPmKz5EBi6JRsKoJW7Q5qODQHlFsVttNYGYHU1vxzWOtIeG5r2IDQ1K+gdT6A==
X-Gm-Gg: AfdE7clPjpZk5fOnwIEkTql+f/uJpkxCo0kIP351mgIHmWiQrg8S9SVE6J2/v2GzR1x
	c4KqYEEEAY9Em2LVnrO+YCWQX1GBkRXhwGV6kGhv3+88AKckE/wY0huvrlN9RUPMf7e7bGquyri
	ZOed5d4BYy1NQR64QtFDxk+Nf0HzojZU5zs84Krg7v+sMNsZrit8BPhiTDDpadGbk5ox5xuCF9S
	Fi6/HHoMobpk21zWBLxjKPbhqe3e7qMS5bHL4pJAYdRGpOHuwOd0jRUS53q8+kDxA7gyaReW8pA
	E6Qsc8LPnPCdWVIF+oUO60lRC7ObYUFmOhNi3La2oCC2qYDYOXXnaKF8NaPxgFrfR8qXxhrS8op
	H+mKWWucefmTTHarLvFEMLuwupYNM7kJeZ578xCzjWDzdJwjlo2W8jzCs+ceWzOJvQMjSG8Sovz
	lkdSEXiSoO8Qvvf5C3ZXXuY0M2q8s4TUI+0U2WCquBuhclC8lJIvWkF7GSc9dpW2mgIC13KZap4
	0zl7STcQM0qzLZ7x6qTtqY8LTEprIYtKQ==
X-Received: by 2002:a05:6a21:e097:b0:3b4:888f:b3f7 with SMTP id adf61e73a8af0-3c08eebaaf5mr4454529637.42.1783404500223;
        Mon, 06 Jul 2026 23:08:20 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.tailf6b5e0.ts.net ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm4101507eec.4.2026.07.06.23.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:08:19 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	mmullins@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: Reject negative const offsets for buffer pointers
Date: Mon,  6 Jul 2026 23:08:02 -0700
Message-ID: <20260707060804.93561-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject negative effective offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
buffer accesses, and add raw tracepoint writable coverage for both
load-time rejection and the attach-time max_tp_access path.

---
v1: https://lore.kernel.org/bpf/20260703035137.109608-1-sun.jian.kdev@gmail.com/

Changes in v2:
- Split the kernel fix and selftests into separate patches.
- Add attach-time raw tracepoint writable coverage for a negative
  var_off whose effective offset stays non-negative. This exercises
  the checked access_end accounting path and verifies that the
  resulting max_tp_access is still checked against nbd_send_request's
  writable size.
- Adjust selftest formatting to use the 100 character line width.

Tested:
- ./test_progs -t verifier_raw_tp_writable
- ./test_progs -t raw_tp_writable_reject_nbd_invalid -v
- ./test_progs -t raw_tp_writable_test_run

Sun Jian (2):
  bpf: Reject negative const offsets for buffer pointers
  selftests/bpf: Cover negative raw_tp writable buffer offsets

 kernel/bpf/verifier.c                         | 40 +++++++++++--
 .../raw_tp_writable_reject_nbd_invalid.c      | 58 +++++++++++--------
 .../bpf/progs/verifier_raw_tp_writable.c      | 16 +++++
 3 files changed, 85 insertions(+), 29 deletions(-)


base-commit: 12091470c6b4c1c14b2de12dcbae2ada6cb6d20b
-- 
2.43.0
