Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66A35E93A
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138125; cv=none; b=EuqddEC/7aR+kLuvqU5V0SJx860ntyZz59ZkD+ML3qBMwmLBxKCmMsELfDcbMF/W9GIo4Nl2vopKvzIBEcd+mGmpoQohyG4ZY6DS8+evWNYy7vN45mFIY3LhOfZ7l961cyNT1cGocsguijeWvk0SY5aObUpXEq/XT/t1yMdxUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138125; c=relaxed/simple;
	bh=OblWpqp19kDTyqAGzbzu2Q8zH9UYGbJQfvTQaIiJLRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IG1/HCx6+C+SzvlNvMcDjQRgrJxUwKcnK/4wS8OMceyHh0pVXNwxHthDJeDPJ6WkrwyweTBM7ya+sHJqDOm133FgVHFAo/Cw3ZsKxBLEARFgth3LUu9N2ZCMXg0r2FQcop82GxmPyInUnpHXpFPIGsRS2ugR7VT5h0uXvB6SFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9g2NcIp; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9g2NcIp"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d74fc959d8so1226115a34.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 03:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138123; x=1773742923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=653FzskN4REwEFDcgD8vcg1axVo0C/yYw7++qUXSZzQ=;
        b=K9g2NcIpBXFzNnohzdJE2krUeW2/q7S196XA36pQq7vw01Ypx8AfPZNS+ajfWGUwTN
         DexqIJ+ACkMVg9R8s7RrbWJEreaLXDzBzWd5mITjBXelW3QrSckdJjEcKA05vm+DmZus
         6yoS5H9Xmw/jhz7ZlnhhWRbrDsdLniSbLMGg3KHmNEm40rbFae5pYym1UPNE7wdhi5at
         +c42yVift1mS+F9AIkVbj+7hA2+VHuiV5eiho1PjkQFoFNCXG9omq8ixsFrGCLrDmQPk
         o9n2VNV2AmvzPkXvMHeniKBpg5jG0jJ1gxH/LMegqdD3SlSAHNGd9T5ttIlknAvPvf+E
         z92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138123; x=1773742923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=653FzskN4REwEFDcgD8vcg1axVo0C/yYw7++qUXSZzQ=;
        b=PD0CgIplyd+IwlxtzT+9DrHWoysyhQ0RPnn9SnCoZcFNyB4lgwAWHdBj9guWwkbMVH
         JwR4/K3JQYVfVObUiJ0CfZZAiMFnkd2HFuorGz84RO5cgKgODhYHyGl21Ihz1yZfqS/i
         vZ9rZLaJTgAF6GhPt8f3SElCojaAfMTngEPbTFvaO5aUcFPOCxWO0jCH3cqy8n4gY6QA
         GlIhITJ8iYib898SSVow7KTh8CN/tXx7qJKCJOT2VL0LoIETYtAeBjglmrAD7CorV6vD
         8ZpTgbMfnMnWb1gzm2XblQfk3PPo82R1SvZb1e6/8xDtfYgOZUjmybcM5rF8znm86HtQ
         aQFw==
X-Gm-Message-State: AOJu0YwVPvaIV1IfHxNvuZRnMDjp7O7PgSvJeUESSCnLekFIYJ59GI07
	8s8Rh2l5cJf0b51UUQ2fcYV/SySQmYrMHmRNbO69SPo07r6Vwzppm3eN
X-Gm-Gg: ATEYQzz14DUqyTwKhEWWYzyXK59FL7PaAIB5JlHU+RxBvdmfFko3JYSbF4ZYrGO2gYm
	a4uFQuhzymz6fFH8IqXWvkFAOOll0YulR8ENMDVBXYwA01zcmyAX6JhoLjvBR+0irgZOlPxrC4e
	ZH/Q8SFZCj1RIn9gaYhGyfwItpjH5KH9OTKze26DoA9Y9SXJxnip3PKnJUlWOcHjNRngwYGnBxL
	Qs/w8QKBQkFSsB81IATOKCMI5qsirQT19kcWJ9pNQyLfmlfebXsXKMl2C5A6zR4iTdRyF0ikDho
	MGnE2eGEQ9oT1isl4slFIGb2Om/a4mOWRIbRgWA5bHQYyZUQ4O5x87dpGcAtF5AGZ84w7j+0+OV
	RGWHwrvMeo0TAjjdVsk1liPZOCx/MwEfNtH3Qfbvblq3TwKNU1rGrpr0aNt6pUM2N6kzGwbAz7Y
	77Ic37cI5bfmcqMhTR+WdGzrgRY+/SkYOe2hW4ih0zBwfizETQOYA1Y1a2fPNVVOgR4VmIoSYGx
	cMWiQ1WETeuOtEHpCsvmgsfAXI=
X-Received: by 2002:a05:6820:818a:b0:672:e67a:96cf with SMTP id 006d021491bc7-67b9bc81ea2mr9110007eaf.16.1773138123241;
        Tue, 10 Mar 2026 03:22:03 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb331eee0sm3877789eaf.8.2026.03.10.03.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:22:02 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 1/2] selftests/bpf: Fix read_iter buffer termination in test_bpffs
Date: Tue, 10 Mar 2026 18:21:44 +0800
Message-ID: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_iter() always NUL-terminated at the end of the buffer, so strstr()
could scan uninitialized stack bytes on short reads. Terminate at len and
use O_RDONLY.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_bpffs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index ea933fd151c3..e8021ff0581c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -17,11 +17,11 @@ static int read_iter(char *file)
 	char buf[1024];
 	int fd, len;
 
-	fd = open(file, 0);
+	fd = open(file, O_RDONLY);
 	if (fd < 0)
 		return -1;
-	while ((len = read(fd, buf, sizeof(buf))) > 0) {
-		buf[sizeof(buf) - 1] = '\0';
+	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
+		buf[len] = '\0';
 		if (strstr(buf, "iter")) {
 			close(fd);
 			return 0;

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.43.0

