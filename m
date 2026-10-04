Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172D43A7FF
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121148; cv=none; b=BclzGPvikEUDKqQZ9Bwc+eEVX6b/nJ9Td/GzoL5HIf/L9TbYNSToSrJRGXooozsGulZBKk9UcVeXwSRn3cqNsA51Bw94+53rLDeQKAPTFOjP3o7ELqcGM4KzZImBGpZJ1gTdYfUiH3p867kMqoCtTvdufmljAzL29jG1zZvz0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121148; c=relaxed/simple;
	bh=+7n+VAOK454JUna7O7impUHUVNwkOJp2zE2SB4yifz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=necMCa2RGpYLUN/m0W3Tpv/oXqXq0mVilnBTcrCTOcePtfuYr6sxZTzx6WShgrcpHJ0/X+iaTceui/z99+eo95WOpMPXpXqAsgKYi+hIaHnL4ViIUdfCD5dmAfxaup867V7wUDXzL4KcDzPY/bBn3BPeJQ9Ac/atIIXoP7cz+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca/qhK9P; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca/qhK9P"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso628079a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121147; x=1791725947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xZq7SPo9Y/whhStQfkD4IvVpMX9n+LJXWJy6ODrbTsM=;
        b=ca/qhK9P5dWFNSd5OD89L7AUJqE+L/A1tkQQEe83iy6i9VJvOYjlUwXLO0iKI4QJnT
         6YDn9xJVfblBEBk/uF4LiefpBw0VEXLdB5lW6eZcSlIqOQL9LJzXht9bQDxIiKQ+yorM
         g4THGod9zJYZiJrnlD0HbnbKhRcNl9DTluRH7F/Vu3pBu7O6AOjOIPDcFHbHZt6BzXex
         VbG1ZlqST9ymLV/+KPmq/kEWMFQIzZIU4QgwHyhK9XXES/xFj/u31Sx/ZA4lYUBmV2oH
         vyrL6fUBkeQ1FCrWGE0oiyB5zDc6ViUhIbz58IezynOmDR5NPpNGoY2rS7Y/uoz23pFn
         F2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121147; x=1791725947;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZq7SPo9Y/whhStQfkD4IvVpMX9n+LJXWJy6ODrbTsM=;
        b=Gy/DPFi18XhVH9IiGWOW5aLdUbEfWBMfW2J7ohpU6/xPeGK62QUAaxyWPl8zuiqPLi
         l/WWlwI4lvBSVoFHfCeDSWWwhB7SmCQS7cu/XDGBzSjhskhFCaJrffQBAefhAS4SUQRX
         CvozJre9gLOHR5RhkUs8tPFTJs/hPvLo/IF7+cZ0b2nXVCgbevRQI1Y6EzosTCJiz7xF
         5u7Is3SIA5F1lC4CaBzKH/MsvLrgnfKEzsZm78Cc+5nCFos4uM2tYIWctM6et2l6yUuR
         kUp2Tux0rqJWWqp+WUmQE/SgdiLasdg2olXvj6/rgEL8pGHMMFwLx4i1Rk5++8nS1Ncr
         NMYg==
X-Gm-Message-State: AFuF++kbM5vZV2PlYNueBUr1Uajg4iiPharQ8c1QnqA3mU+htEh2kTEK
	/wPVTeDLKklTE3oxMqPvQJb1A6qA/ektvxlNMRdm/daHbqP2GA42YEmvAgdz7Q==
X-Gm-Gg: AYBFou2EvJWIdrsMlwAUz5/UuybC36NHG93DLlQWuAtj6xaW1/+Pq7b+mmbXPMU1LDZ
	r3ho7S4chQWolhmARP2KaLu2Cdrjj6ZoC7oz4In/VB3aCB0REoMql7H0Mabo2WtKcFZFYNjF2AK
	zbjgeJ9txvwSlvCT9PBxNh2+kP9SPV0f5EixIzmuBOfv/REEfwS12t49iTjEAFCCrZLfrUYkKbK
	cifX1wnN6H/BLc9OeoeEqwvCLYaTJ3kyiKRtr+ljr895FZrv5gQ/6BLNIitRYDeNaaSrk7BYtaU
	ZQGsiLLN5vw9d9HAxdyAA3Lo84IMCqIhy7qcMthb6Hb3lvTahJ/Q97+3bZp/xauYUJKi/uDwUrR
	1SAH2eZgJ3gBJCa+Pb7MhbX/n7PQV1qilzjPUEBJ0ClL8W8O6m1Mzh9O2UOSglrwuuSsVB1k12p
	chxarBbtGSXF4gnFzR0spZUA8i4yIDLBDiChrgN2vDMuRn30pK0NKD87GXwpKQ9DpO3x/1NyEL9
	cvM4lJj6arI+Yo=
X-Received: by 2002:a05:6300:614e:b0:3de:456a:6e07 with SMTP id adf61e73a8af0-3e0d6b1fa75mr4529409637.46.1791121146797;
        Sun, 04 Oct 2026 06:39:06 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 33/43] selftests/bpf: bound UNIX socket path loops by sun_path size
Date: Sun,  4 Oct 2026 06:38:15 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-33-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The bpf_iter/unix and skc_to_unix_sock tests index sun_path but bound
that index by sizeof(struct sockaddr_un). This allows indices 108 and
109 into the 108-byte array. With SCEV loop widening, the variable-offset
BTF access check rejects the resulting range.

Bound the index by sizeof(sun_path) in both tests. Runtime behavior for
valid UNIX addresses is unchanged.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c         | 2 +-
 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
index df3d971b21e8..3061b148f338 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -70,7 +70,7 @@ int dump_unix(struct bpf_iter__unix *ctx)
 
 			for (i = 1; i < len; i++) {
 				/* unix_validate_addr() tests this upper bound. */
-				if (i >= sizeof(struct sockaddr_un))
+				if (i >= sizeof(unix_sk->addr->name->sun_path))
 					break;
 
 				BPF_SEQ_PRINTF(seq, "%c",
diff --git a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
index 4cfa42aa9436..c5c643064eb5 100644
--- a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
+++ b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
@@ -29,7 +29,7 @@ int BPF_PROG(unix_listen, struct socket *sock, int backlog)
 	len = unix_sk->addr->len - sizeof(short);
 	path[0] = '@';
 	for (i = 1; i < len; i++) {
-		if (i >= (int)sizeof(struct sockaddr_un))
+		if (i >= (int)sizeof(unix_sk->addr->name->sun_path))
 			break;
 
 		path[i] = unix_sk->addr->name->sun_path[i];

-- 
2.53.0
