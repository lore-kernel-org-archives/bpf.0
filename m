Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A71296BD7
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406423; cv=none; b=L6go9r0mNkXZADXTXZ1h4Gimv2YowiwCnZJuxPAAnNZfb0bi7VbLw0PxzgycDtHxFHCcee8DMFbf3i45N9pTZgy9Li0r0b0GITiEh1cc/prk2JoX5ek3HFzhZc+cYJEVsLLH0QAYvYwA2mIlIWv2rY6GL/mHpiN6NDShRfbX1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406423; c=relaxed/simple;
	bh=G8i8l1HaUJwIvvVaqfhi1fhbz840otW5i4iqXUQWS+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6+9SDEKXslKyZBfpAoR9E4+vwz/SkkFJork9EIW3FY9Xrmf7lyHt/1wZERZG8XATTCsN83Mf18a3BArqqy6UX+/zE1mfpI18D18Dpyl6ee4fpsQdV24wrujUqB2QA57udOia/n4w9CVajtiG3a+rJHAwlAbA2hMxN77PZl1r40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jabSSRve; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jabSSRve"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-480706554beso49642635e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406421; x=1772011221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GT47+DDqY1qh+uutKLyaKTWw+O5qS7pkg63HL+xIqBo=;
        b=jabSSRvekg3DRCyMFsYJyuYp83OWeRHZaHI5fK7PIr/UCygBn1xAUdvA3B7EMX2Dnt
         MqmDPoW7BPIWFp0JnK5kM1dLpSWON8QGv1wVs7yEgj/+RTAhMfHGHTGgxjLErJMqEZqb
         zGjZc8CXEgMseEgVrpzhQtdPs/yk/QIcMlnh7O668DbXmK+Ulj+AJ/C2kxatZWvToGg/
         fPB76rK7QmP0T0aoHUJyRdYMhYyjfqOh342vToFR1+6oHEG8VUQClmheIdKU3zGHwfXs
         GpRALIDSXrj9SJTy3ZGWRtQW6E+J77/7vaTizLrKOybQbtmR/f4UP08RaoEH0p7rb7bI
         /Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406421; x=1772011221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT47+DDqY1qh+uutKLyaKTWw+O5qS7pkg63HL+xIqBo=;
        b=NQopNjMVH98gB9nD0JnN6sstoj9j/KxLesVxlhTTSswdeYA8EypUDz4yWy0ywTOVt9
         0aOD8CdRYEM2Ql1zhGePYRr/JZduvZW+ObiWl8qASgTw6AdZVRCkBVxur9uc50KVsHeU
         SQbofHhBdMSOFo3Kiu9Pw1nACoumYGZXRnLoScBEM3UNLWYYKCQmc9JacehKhUEq00lg
         pILhXhYOyr48jIm6eXOZS3OyH5nYuToBDt0j+NQAJ4SGdFAGEGI5WJEQ7Rm466n87QrV
         +JI5IHE4kH0DFTSw/8OuQYSxUCJs1+stWNRhp3R+tpZSX95mwwJOqdbLJteldzAy3Azn
         l/SQ==
X-Gm-Message-State: AOJu0YzUib8GJIOBrPRjLmholgp5X7dJrY8dpdknm6M2d19A5xfguCzZ
	tjn2OaguELmE4mvxd5IlNIl1fTZ/GtkDN3GS9PA/55jPI1467SLkqkG4Fbvj01WsTZXbMSaJ
X-Gm-Gg: AZuq6aLwZI++H9aAwYs8BrHnkc1wDGrJcMLQQdM1MYuuYIQEag45iYHTjTdi/2vTXH4
	3C4G2pP7HwltRsLZF93lrM9kQvJaURG9+3T21l5E12k0X42K+EuhhUnvQKf3Qt8Jycbc4xyXy3D
	xnC6Dci02Yiw5G7l1N5R4+ZlXTYIkMBx+VNneQKueycchA/nHcHz5VKDu5oQFZUfzuRlPBjyBJv
	bw7IHm5gf6CRQf9uLEj2NoOsZbyMD4JLwEQ3GdaA0RInNNVcDnPNyMgLCHJSyY+bLwixYJMu0aC
	Yeake3FhPTy+hytkjGoJyZ3mx8wsONg92NigobOJPW26QRfg+ScY5BmPbKcVvnBeXNwaITYLDnm
	C5KAy87GBNB+whGsDJos4OXvPUKfs3L0+kz6anbOvDeTZt5IL83UexVocA+pe7ul9ly9/qcx9gl
	ftJ1edCMs1N4Nk
X-Received: by 2002:a05:600c:154f:b0:483:3384:a873 with SMTP id 5b1f17b1804b1-48379c15d86mr228677965e9.36.1771406420254;
        Wed, 18 Feb 2026 01:20:20 -0800 (PST)
Received: from wdesk. ([86.57.23.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm41352691f8f.32.2026.02.18.01.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:20:19 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
X-Google-Original-From: Mahdi Faramarzpour <mahdifrmz@gmail.com>
To: bpf@vger.kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH bpf-next] bpf: fix selftest/xsk single test selection
Date: Wed, 18 Feb 2026 12:50:02 +0330
Message-Id: <20260218092002.147306-1-mahdifrmz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahdi Faramarzpour <mahdifrmx@gmail.com>

This commit fixes the integer parsing of -t option. The cli parser
only relies on errno to detect parsing errors. The manpage for
strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
states that the said function "MAY" set errno to EINVAL in case the
conversion fails. Currently on some systems, this leads to a silent
failure with return value not being exactly documented in the
manpages (probably zero). The reliable way to validate the input is
to check whether the endptr has been bumped all the way to the end
of the string or not.

Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
v2:
  - fix style issues
v1: https://lore.kernel.org/all/20260217080326.50564-1-mahdifrmz@gmail.com/
---
 tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 05b3cebc5..5e4095fd1 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -200,6 +200,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	struct ifobject *ifobj;
 	u32 interface_nb = 0;
 	int option_index, c;
+	char *eptr;
 
 	opterr = 0;
 
@@ -248,8 +249,8 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			break;
 		case 't':
 			errno = 0;
-			opt_run_test = strtol(optarg, NULL, 0);
-			if (errno)
+			opt_run_test = strtol(optarg, &eptr, 0);
+			if (errno || *eptr)
 				print_usage(argv);
 			break;
 		case 'h':
-- 
2.34.1

