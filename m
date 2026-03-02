Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFEF390204
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484726; cv=none; b=Rj+paMSSbob1NQKGq/p9eLdCsQOvjoExJcgyRUmJPDx10k+n/Wg/hEzdFRD1RQJz8cqiwl3JaNhRRYcwnbo9nZLYp6ozg5Z4RcI8Z4ZAP2Qcuoz01Ki30Y6oLjk2F9LMCYpgdSSuW5j1kCL53dgSGSHnPRDmq8zig0MsxsLNRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484726; c=relaxed/simple;
	bh=YfGdZv0BYcJ0fGzfQ0hp+nngzF4RNGVHPtz3lm0ClMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udQ3vqYbvhVBArcIUMlowraoDoayY/Ul+/9SvXZWwmzHM+Zk4+AGfYyCF7tFmxY/6u96OUzT5iD5cJOVNoA9tX213Dz6WMyDqRfihLiBozYiB1WXDih8/g+s4rl4mx8PjT4Qrx2pLTVC0csWkiwzfr3dFv4oBlNXboFfSbvHsdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q12JfWtT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q12JfWtT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso43710315e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 12:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772484723; x=1773089523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33QT3kr+fmJUaDM35+MgGGfp5T88w9F+n+7ZGHvWHSQ=;
        b=Q12JfWtT3v3Wy2F5W0U5RE6BSUGceaWbLZAp2rAYKoKyVuf9uNlIwT1J4lHNHYoKGV
         Km6nE2sG/gt+26CwQHhl3NGF6TMXQs/xCSD6NvMNw2qNDx4g7NMKGVNGxbFklTdBI94F
         2lOtFluJ5IMYW8KeBrbwZVOvNQ30xQsJHAnvIJuUZgIKFGzwRBAtAxGjTGE0atyLOD1d
         ZLBfJpYkL0zIw4JyvPWcSPVwlMa+sTNtSNJRhyNArlsvLscgNaja3Diyes7aj0LyueTv
         tS9vZhmllMWbBzWLk3NeAEwLFXtZiGUEj7Ss1eyjJ7utgXGXtpFrd08aRrG/Wzq1BZ+6
         qcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772484723; x=1773089523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=33QT3kr+fmJUaDM35+MgGGfp5T88w9F+n+7ZGHvWHSQ=;
        b=g08o4Zj8Q29JkO2TaPtASwebmUP7jSjS8XuefCxkQQyqyGLz6COnUpARVR+NWaJLKA
         Cni7qI2LMAM9O2f5WRjHJ0lYbJrrwb+K9uz2ozDqAPA8SeC7QBh9I+2+SbbzhHypZ2GE
         1PNshFWFF2JzAm+B/+XTQrhh/76Rgud3q7LsUjyVtbSyLeNkgkpRFCuDEnjCoBkqOqs+
         6/qz6yPBBG0UkPXVtQMLGkNknwQr6Ebih7dIKe+EBNBlKhmaxDcEMS3t7Qin1N/FMXXJ
         V0pwjUH6YJslEGLZ4Y3758S1EbdtWlmGZtQNwZkkIauN+uwGIcRQOpWV7V6vsVCFsu3G
         bpNw==
X-Forwarded-Encrypted: i=1; AJvYcCUQWHqEW0HvO2L+/GS1DoYnYpipLP66GE822k1ygKB14v0edtTvhcPjfu21gx/q2aLakUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpPJY+twQWSOcwhYOkpKSl8YQawfGO5Y7FtVkV8TQFqPeHeh9
	Vzd95SoTNqE59QG3ucBfu9alvPtpvy71UAW9tIoqTWEz9FbcVHXupNIs
X-Gm-Gg: ATEYQzyRIYNMr+6P5fvyS18Upansj3hg+gzAOCpKyktaNW9ENHLm3o6YZOrVmSrRXMS
	a/CzKX+jV1rhLfc2m9GLlBapdGMoxOgSXFH/va9S4W+3BvV0DLJEsdVh+w3IBMmMxb1OSygRlC4
	CMKT/14jCAnehrFBhUpR2AlTmc2yPW76fkfbjdjCV03ySTzHDEgKgFJkvoy9KYTxyZk4LwnEDAg
	o9zWZbsv/fSWnSRkWh8QOvItbgOHHOopQ+LiHxa8tJvVOC+D+MNyfjrWiPhMCgxBGBz1Q40Cxq4
	g3bdqiYM+urPgcNar9kqvJLaryTRODeU/IlM7rYyyg3ue66bmPEPOvU6bDHrgdEUXJyqAVch9oe
	d+4WbZRU1Yt5r1HIEiJUpQm43qjFdHwffqTKRUi+9piuu7q18+RzDAsuoDF+21ux7vLh1qaHQIo
	R/VMBwHsA+KSalxJ+KvzKE+78dINbZ57g=
X-Received: by 2002:a05:600c:3b22:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-483c9c2d29amr219756735e9.30.1772484723262;
        Mon, 02 Mar 2026 12:52:03 -0800 (PST)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126705e5sm898705e9.5.2026.03.02.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:52:02 -0800 (PST)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Date: Mon, 02 Mar 2026 20:51:52 +0000
Subject: [PATCH 2/2] selftest: seccomp: Adjust test for using both `STRICT`
 and `FILTER`
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-seccomp-combined-v1-2-c0cb7acb0f97@hill-daniel.co.uk>
References: <20260302-seccomp-combined-v1-0-c0cb7acb0f97@hill-daniel.co.uk>
In-Reply-To: <20260302-seccomp-combined-v1-0-c0cb7acb0f97@hill-daniel.co.uk>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772484719; l=1026;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=YfGdZv0BYcJ0fGzfQ0hp+nngzF4RNGVHPtz3lm0ClMI=;
 b=1VtSq+i+Ji39cqfhNb37ik+b9kgFWrxGOhMQinjaw2UiJ15WX+qwAGSFORSZYYme2KCGW7kjg
 Lj8s5IVIimODE4g3jrzC7UnqzIpxiz+e4ZOSH29iceRRtT2QbgDMBGz
X-Developer-Key: i=jamie@hill-daniel.co.uk; a=ed25519;
 pk=ovqCXSlFUjrT82WuRtIuXB13U5n1yfxM6o0M5O5J2tA=

This test previously tested that applying `STRICT` after `FILTER` is
impossible - update it to test that it is now possible.

Signed-off-by: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..ba042828dcbd 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -516,7 +516,7 @@ TEST(filter_chain_limits)
 	}
 }
 
-TEST(mode_filter_cannot_move_to_strict)
+TEST(mode_filter_combined)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
@@ -534,8 +534,7 @@ TEST(mode_filter_cannot_move_to_strict)
 	ASSERT_EQ(0, ret);
 
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, NULL, 0, 0);
-	EXPECT_EQ(-1, ret);
-	EXPECT_EQ(EINVAL, errno);
+	ASSERT_EQ(0, ret);
 }
 
 

-- 
2.53.0

