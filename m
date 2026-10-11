Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F43DD854
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699723; cv=none; b=QQNOuIFfNEQRbjPvXbEGjbwkw5cKCsQdOuE5PMCw6l7OcqtmazurI28LdT9/zTQm6RriKSmw9ulLn0+aaQi7sKD+w8eP+r35fYqCrbHiN3TND62etBmya+sVvvUgfGeAnFd0g5vpA/LGjk1rkgr7fTw2+Whyiu9awnJAAJbV3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699723; c=relaxed/simple;
	bh=GeN5HfsOZ0YhBvtCtM85XCULZjJ0izFrO2P824Pi0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4bHwiWCFIglrRXiqEgUHKFv7d9aR3ERS05itMdsrm5+CVdhIZWoaPZqZWNx2hhrb6zuDErMxtxgVE0z8raUwDd6mxu5REfFUxQzqyI9g07PKu0OqtO0JR5ip/34GwmwKMXsonZIuZA60/8npjG86n4ZeiRd75vFQ/77khj0gq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o78X1Y5h; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o78X1Y5h"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-88b7d853b11so470300b3a.1
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699722; x=1792304522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8DSP2N/a61a8Xd/LK2XwQoroQeJQVJ5U02uGaDkv9lA=;
        b=o78X1Y5hHSfYrIbQ0H20E0nzlBRUwBWiZ2zkN/yF+/9INFzniLBKb4jnKm42tIz3W0
         cAWZoBJ20UmhE6naEkyia/UOr/wtAOMgbWWTdVB0g8xeVodKYNiRUcOkXq/b6MPUfC+z
         9UifQ75d3/6wKeskWehvhH46czH9NyGyHMiYYvh9Zti7ku+pNKP0r4+pSFayYV3xEMxC
         PZ4+/9c72Z1tpHUInnu3VeNBr83jmnRRLpjSWVkb0y+/pAswfAYsJYqXkaiI2sOtDMOg
         cagPgjzv/2+SE072Of/qDA8vyFDKstGg019Rr6l7I49iMuaDtI3P2JlROq3n4V3bTDvK
         98MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699722; x=1792304522;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DSP2N/a61a8Xd/LK2XwQoroQeJQVJ5U02uGaDkv9lA=;
        b=KeMTrTXnfGivkIUv69jBphrOy8IeuIfDhTyJOioIwq9g0Wia0r5vrR4ubUTsh2JF42
         E0wvEK0WZdQCVeTnQNt3PuzmpYbPHwB7U3vK9sESIHEUZGkvEXC+wa6B6JwvrEoVBk9O
         0y7KA4qwkFLa2AAvss88cKPGgBQ+hgMwIasFIn9biG76TjugtbgmqNBKL+udc1w94BQV
         bbGgeBIB8jwMAIReNtZQCxMiuuxmPdOTUeqJIWf0oP4c3gFotjY1zerorswRdFWqiibS
         pLw0sBdgtKW9hjsLTTJGdohXuPIviUAJbMVEfR/dIhC+QobRrfWJ/CfApAFSSGUzIqEP
         wQJQ==
X-Gm-Message-State: AFq9FYLIrSuak6C7SBnCZ7yaczgV3XQ3fdSAPy+l18ZOx5mARHzUYG5x
	/NjbH7ptr9EYzA4Go6NdY4jLdMsNhQAPo9MlkxRRF3f99+5+NaXqul68xaUbqA==
X-Gm-Gg: AYBFou0dzUfso8Y8xcJhxVL9n5P7s7ynb2k9ffph/rZn9i8m64mmZn01qUfe/rE2UNj
	g16IRHzvKSmxW8hJZA4uAutA0l9Q+/s02dsozdRZTqgBfKsV3tOhN2e5T3zcr5TUdz9BLqXjV83
	VI7uqa7cW4KBaHxKwVuluhdgLvMifodGWWC4BR5ZiQfjaOU63jAfKXeiKNXqcy6hJB4Z7NrZbim
	EMxiN9MmjM83fVobOdJNixPko7su4UrNG7vr6iUNEBn6YQOlD3UCRRKGgNT0roCmBBFyHi6dQzk
	lR620yIi+N13JXZyp7mKQZLrrClGxbRUwkLHBG5bTvwdn/V7l0T6WrOZz3NO88XbFDUXECmHA5N
	YBG6YjH3WVOsgSgqO78WmpwpfutPpdnsBYfmIcBkUKWDRsltNMBxP0ZOkjxoelUJ49Xu9mK9f2q
	WsW1YFCUVWwCcrdaIWppwtKOUDCCRU7Na3i/6SknlE69E4nNf8WVncqb/vXKjuO4v4EYtMyCGz6
	ZM7eHgm66v+38I=
X-Received: by 2002:a05:6a00:8c3:b0:882:1b4d:1847 with SMTP id d2e1a72fcca58-897c7ec5c9dmr5012677b3a.39.1791699722207;
        Sat, 10 Oct 2026 23:22:02 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:22:01 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 8/9] selftests/bpf: harden __msg patterns for step_movsx_bounds_on_line
Date: Sat, 10 Oct 2026 23:21:42 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-8-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The `{{.*}}` in the pattern for R5 below might hide the `step=...`
logging from the __no_step annotation. Replace it with full expected
log instead. Also drop __no_step for R3 above, where it is
unnecessary.

Fixes: 2db5837f9ada ("selftests/bpf: Tests for register base/step arithmetic")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bounds_step.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index c9ee1c7efcbb..d824a5d48a39 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -338,9 +338,9 @@ SEC("socket")
 __success __log_level(2)
 __msg("r1 = (s16)r0 {{.*}}R1=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
 __msg("r2 = (s16)r0 {{.*}}R2=scalar(smin=smin32=-24,smax=smax32=144,{{.*}}step=0+24)")
-__msg("r3 = (s8)r0 {{.*}}R3=scalar(smin=smin32=-128,smax=smax32=127)") __no_step
+__msg("r3 = (s8)r0 {{.*}}R3=scalar(smin=smin32=-128,smax=smax32=127)")
 __msg("w4 = (s16)w1 {{.*}}R4=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
-__msg("w5 = (s8)w1 {{.*}}R5=scalar({{.*}}smin32=-128,smax32=127,{{.*}})") __no_step
+__msg("w5 = (s8)w1 {{.*}}R5=scalar({{.*}}smin32=-128,smax32=127,var_off=(0x0; 0xffffffff))")
 __naked void step_movsx_bounds_on_line(void)
 {
 	asm volatile ("					\

-- 
2.53.0
