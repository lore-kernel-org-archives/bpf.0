Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABC42189B
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602298; cv=none; b=WpScVcLf1Z/5XsqhsXWPLKDvtvN/AmeDgvGjkHYNoEUkctyrwoLdDTR9y3cY+rc+mzGHqTzjFdAt0uR+6SFDbsR+o5ImthOIq5N45vBc4rIu89rpw0bOjEIRo/2SZztJnUGy/UEj1Al8swjZZlLq18rpLyAlZyA5jh/7lgtEBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602298; c=relaxed/simple;
	bh=BIygEW99km40DQ4U36jHMgpKSlVhAexmh7XqJfveh7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdqmQJDafcrSzXd0EhR9c5ZTicc6Gx60uOEQ00KmAXF01oW7WsOUN5IL/OKcZ0DKHvPtlxjNcOdbYXhkmviJMuPKjFYLoox/BH2QVa8kW21WWYHkP6dtPobKwl4XXszpzeUKszFxdlLiHhvezTQWL7rPB1dsRZK0PbUW3gFat2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNKz2Ni1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNKz2Ni1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so33664215ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602295; x=1782207095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgtSCkqGvjyXkueHDMEHTv56UIjlIzxynvR+gbghz2U=;
        b=TNKz2Ni1jUU9ZBPds65++RIucziSCMXPF7RhWF/8MkFpI4JMY6fUb4s3CRgqJJbkYf
         TND+HPEgQAvT2r3f/JTbxzdhmUhHmKTAi9CoYyxJ9O6+1jgtKaIM2PEXwh8Crov54WUg
         6B5/pk6FERxR3EEqnUpGWeGMQefcFzslwwQZpZ6427/Djl0l8Z6Fv0OJlQ8Ze/PCuJ4O
         3yOPw60oLrlAEgzl2/RXWkGMd4uj3+j73vceSeIzZaUDauWs8jXAxgzvQWQrcjOCHUsf
         7zCV6Ek9X25MvYOCXJ3WS/lCMOyfjpY0g55cdwt6QeCG3vViiuTlvzEYfh00ameymu3i
         cSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602295; x=1782207095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OgtSCkqGvjyXkueHDMEHTv56UIjlIzxynvR+gbghz2U=;
        b=qrocECON3YbczpIdq9Y2gDnSCMLQF/wmNoi4tbFiEy92MFuD+2/xt7WsOWzi1htMN4
         1V9MbHz/W5igI6PYuDNCrcGGrG8jevVojvTGtjuFOAGASQY1vbzRF1RpNMeTZMY0SVZk
         gAAjaj+ZUYYy35xUYUHC5uoIA89yQjqul3tlvKLpqk5S9y41Tae+KoR+7MBmBxtGxjNd
         Ey5tFA2Cc+ai9As/EGYEspVNUxOacnWBe2+aHeu3vsgON7L6I9nJf/nXtb+5umhmR+TH
         wH8RKuUsH+tZpaRaXxZHUEF4fQLCMG2iJelW58A5kCuCdjkxo51HZqE4E1f0j2YbN7y9
         DQHA==
X-Gm-Message-State: AOJu0YzrquIeKW+hkx0Z8m8VZDEjFAR4oK6Mb/7MJveHrFmYZOtntY95
	hkzdTJgLGZh4Q767q48knAO6LVQJhCqKF1pl48Juu4eY8IfLLOu8/yJAjYJrV7F2bY0=
X-Gm-Gg: Acq92OGWS870/87QYCHUNOJaxypha9N0UAJR1jYIj0PoGSJiBqODuWp5c1TrqcPW9AL
	wKPq9y7r9nwkVEtIUApfsCv/177opk49dsI10MP66W5s4o+KAb+UXEC7pCDI5nprcaITT98/fJU
	Ioj0kKp3lvjfOPNJgJW0S8vrpbeAUWmYLmcZLehAntMOhna8gg3w+HLFxTwxfYeVsFxk+bhYXpR
	aSI54ZXRW+A4jjXJqRl76rYwj8UiG8M2oF6lUU1nVR2QAuqNUyOw8e/+ESoX68yT5WBpI9CD/pU
	igzwpKnBS2rMN9rbul2VIIEkGcAp7DuVVvvxaOkQFrkxGjf90AoX/0WVZwaJvZCeGkWOexzex0t
	iEdwwIA/qwm1u3TqI+p3aCqbTQ4M7SiwPSIHHq7pfecnkXd0Hs6Zits4g7h5JHi4fiPpjrXWaev
	EencLqOPdLW8lTH8oZwwkm9ykX8YyOsb3h741hR7dESlE6gsRTp4N0r01iO0gTVo0=
X-Received: by 2002:a17:903:1ac5:b0:2c1:20fe:9d5a with SMTP id d9443c01a7336-2c4135e86ccmr181937835ad.35.1781602295359;
        Tue, 16 Jun 2026 02:31:35 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c52sm127329545ad.22.2026.06.16.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:31:35 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com
Subject: [PATCH bpf v2 1/2] bpf: Fix partial copy of non-linear test_run output
Date: Tue, 16 Jun 2026 17:31:02 +0800
Message-ID: <20260616093103.471444-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For non-linear test_run output, bpf_test_finish() derives the linear
data copy length from copy_size - frag_size. This only matches the
linear data length when copy_size is the full packet size.

When userspace provides a short data_out buffer, copy_size is clamped to
that buffer size. If copy_size is smaller than frag_size, the computed
length becomes negative and bpf_test_finish() returns -ENOSPC before
copying the packet prefix or updating data_size_out.

Compute the linear data length from the packet layout instead, and clamp
the linear copy length to copy_size. This preserves the expected
partial-copy semantics: return -ENOSPC, copy the packet prefix that fits
in data_out, and report the full packet length through data_size_out.

Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/bpf/test_run.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2bc04feadfab..976e8fa31bc9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 	}
 
 	if (data_out) {
-		int len = sinfo ? copy_size - frag_size : copy_size;
-
-		if (len < 0) {
-			err = -ENOSPC;
-			goto out;
-		}
+		u32 head_len = size - frag_size;
+		u32 len = min(copy_size, head_len);
 
 		if (copy_to_user(data_out, data, len))
 			goto out;
 
 		if (sinfo) {
-			int i, offset = len;
+			u32 offset = len;
 			u32 data_len;
+			int i;
 
 			for (i = 0; i < sinfo->nr_frags; i++) {
 				skb_frag_t *frag = &sinfo->frags[i];
-- 
2.43.0

