Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCE274B3B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483665; cv=none; b=nYhj0HLrB+u/Ztxg7F8MwfRDfIb/uZsQXHFepaJadtZBCRdRLUxYBTc5Drwu/oh0Txx6OL8PLx/Sx4Uqsbn8psGS6xuGyy7RctzeNDX1uTC5T4c4YkJqiHbErHHd95mAzKlwZkVqEUxt/DPks/3QWEe9xG08c6FAaK6uRXcvvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483665; c=relaxed/simple;
	bh=m10CAdrsp6p54FwpwugijpPVB9yBAv2eSCq9P2w9kWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYdqEyyn3rpvtjZwbiOuqmtUCs2SheFMiXpwnfw/bhPg40lTuu4FToGiqjoX6Zzqi/p9vG6zRKIXehUuEoWUpOsUMZIlDqaO1ZL8CQQAJpTRQ9rhJOVttw/UxJF8Sfn6zweemap2tQ6p4yMmylJDTCSWTfo1pou1Y4I2LYS3VRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU9hLO64; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU9hLO64"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so89278a12.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 21:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783483664; x=1784088464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Rv2Gw3WLZDDDoso1NlG7NBYclNw3yTv5b2yJb+ChmY=;
        b=fU9hLO64Cxge+9BKJQYPbNUioRhYMmq956sdV/Tp4tbznX3A3nUJ9tOmUZPlwkcAug
         OHx6mGspAJeJRIIWLrN+QURHOS2lk2MMf/v5upSw38uRQYWcRifeTiCZtf3oQrgs5iNj
         3AupUkGd3cOFdUdZlhrhcW5OMUNBnDcSNIxsWL0yIlq9a9MYPd2R7PVi0JIAhm/LjqXK
         VJuB4LWB1WCrjnEhUa7hk6gNe5mf4vt2JDUYugo21nj5PySRyyGoIHkKTssGlFi35gUG
         I7q6AaYhvjBiuWLonFYhX5BHDRy5KXgQw0mjsXt9x088yQNgyVyoeW4l25uYii8eLpcb
         UBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783483664; x=1784088464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Rv2Gw3WLZDDDoso1NlG7NBYclNw3yTv5b2yJb+ChmY=;
        b=GcO9ccKeJeDQmLijhANbzFTSqWtsI4MFjZ7WAxT/HPp9p1KmRGdLu1aGTXPAD9ZM9v
         DR8wUDokYAZxuqom5haDZXyEcN6fzD9Na0O3mS3h7zwr1YHXp4niR2j/2Pa9arjJjTdi
         kn3k/AXA5qPOIpfxN0P8Xmur5VBaQwVX0hmQ/+cVuJrpxjyI8l429/YgUPHdR1U7vHmh
         3WVehWjNIhGume6GDDSxPz4eXpg20ngWRV3Kh0lNX11S/aSDYYulYqXUFvEi/h+kpx8V
         3j+BDlJ+Oo24V9BnzeEDkRLKbCE2shfTQsgIFzqD+V+riFgSLgSngIQ7Rh8cK/A9+8Vr
         uNjg==
X-Gm-Message-State: AOJu0YzdHaDBEsdCnzdWmVIZpGxu2cdjahO/uxMC5Iir/DhSPBOhmouO
	DaMXs8QqiGWUoHV/uoZGUZU9zb0jntggjtiYLa3BasRlFU6MeO0iTJFoI4Rc6BQ12jVsLA==
X-Gm-Gg: AfdE7cl/O0NIbc1Fzqey9jUsK+aUhmJcxj/AGGu19G3saVMH296Y2rqH69HLGM+ZVxA
	lQSY2gkSNHnbEevrjB3uyyps9YxJuS9aA6kiaw4+XQHH4ZG3hFjGhLA+InzN46h3625K6e6Y7He
	YTH0G3bOa/sG4ZxuiEeaqQBD4u2jLIcE3pflJN5RqFTuXYC5A2kBkGL+4HdSeS9X1iXDbwZNoza
	uUj9dQzkqLz1a01rhvK2eKOhJJ7grdBGb339kVnCxgVDS6rWJZ9RPOdmYr5YEPFunxwF1kPWlhO
	wTSJSsk1A2DyUvj2LmiKDaD5bleksqa4UjDp+veCBPMWi+6gvJobvNW6yMsmw+62kbG/IkXsriy
	RCZcT+PooEyuZjb89s0DPeiVjZMueBO21og5zbWkrg8ixxY75xAJUSJApeJd0T4+j4G7h/UYmUv
	Xxi3ai9S0xiCFIQVyQV3cLpnoqAtn/DmPh+UKXprt+6Le0083Sok7HsJYUM+sOZ+013zKpszliA
	tXx0z9ZEHQ7Zc6sIV8NHbfWtJuE8ktp5w==
X-Received: by 2002:a05:6a21:6e86:b0:3b5:a008:683c with SMTP id adf61e73a8af0-3c0bcb803c7mr844879637.45.1783483663634;
        Tue, 07 Jul 2026 21:07:43 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.tailf6b5e0.ts.net ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm4198982eec.9.2026.07.07.21.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:07:43 -0700 (PDT)
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
	shung-hsi.yu@suse.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: Reject negative const offsets for buffer pointers
Date: Tue,  7 Jul 2026 21:07:13 -0700
Message-ID: <20260708040715.116680-1-sun.jian.kdev@gmail.com>
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

Changes in v3:
- Check constant var_off against +/-BPF_MAX_VAR_OFF before computing
  the effective access range, matching the existing verifier pointer
  offset convention.
- Keep explicit rejection of negative instruction offsets and keep
  bounded negative constant var_off valid when the effective offset is
  non-negative.

Changes in v2:
- Split the kernel fix and selftests into separate patches.
- Add an attach-time raw tracepoint writable test that exercises
  max_tp_access against nbd_send_request's writable size.
- Adjust selftest formatting to use the 100 character line width.

Tested:
- ./test_progs -t verifier_raw_tp_writable
- ./test_progs -t raw_tp_writable_reject_nbd_invalid -v
- ./test_progs -t raw_tp_writable_test_run

v2: https://lore.kernel.org/bpf/20260707060804.93561-1-sun.jian.kdev@gmail.com/
v1: https://lore.kernel.org/bpf/20260703035137.109608-1-sun.jian.kdev@gmail.com/


Sun Jian (2):
  bpf: Reject negative const offsets for buffer pointers
  selftests/bpf: Cover negative raw_tp writable buffer offsets

 kernel/bpf/verifier.c                         | 48 +++++++++++++--
 .../raw_tp_writable_reject_nbd_invalid.c      | 58 +++++++++++--------
 .../bpf/progs/verifier_raw_tp_writable.c      | 16 +++++
 3 files changed, 93 insertions(+), 29 deletions(-)


base-commit: 12091470c6b4c1c14b2de12dcbae2ada6cb6d20b
-- 
2.43.0

