Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D995313E21
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098317; cv=none; b=WsC8oWIRe3dFrxj/CiN6pIuVKU8X/ycpjngLZco++dLNzt88uwFMQqurMo47oHf9jnu17HwZ49kR/9Bp1FAsLlow67ApbgDOAkR88JPFtqiUH3Rn9AmYQHDbTyEDJCnD2T++pgawKrKTVVR02bq5u+mmPTXr7Lz9tgrLYVZSkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098317; c=relaxed/simple;
	bh=7hlfsR+NxVR84wDC2V+k6SQPH/xZi5y8H+6CYmBY5BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlK7FQ3FSEc0ug8eOKI4KP+GJHHRb82GA57RumbQSRUWSN3DrQ+UHfKzCEYMHRtCbUnGwCTiwCatU7FOLv8JvP5NftSzBK3Ahlv6cFmAtcBek689qFyZB9/W/2cLDxlTfUqD9Mskw4JSaGk8j1MNicy6cXEKGSROmPv/lzNQDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp/73ine; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp/73ine"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732e6a123so165164c88.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098315; x=1772703115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTO52UAvVAs4B92EPIjRgjAEaywnmDEV4QBGIv74ZP0=;
        b=Pp/73inevdIICPttkoXbYjTFkamREKn3uSp7qVa4M0hDGAuOJbJc3OrDfqLz9znFyB
         vAX4jWbJR6Cjt6K4Qnw294Yh8FqpmPvHlZ1HU5knZlFm1ZkdJSgb7zRmpEQO67tsa5RH
         41DjmqNdTZkUXzYxAaz3gEgtRv5LHfnZyK677ZeFV+EtLkSSjsDUMYHCQC9I/RhBuMLL
         oR2xjL62KRP3AEI32FbjkdfqEfI7DZoR+Ry6SVsy4J3grXj+Y9w7u7ozESHTCMU/dJYF
         JHIpap+EMGuQlWtaQwTjURmlqPdriseRfpSMUHt3svgIueCQfsBeMHRpY4y+lGDEGxvP
         ijNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098315; x=1772703115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTO52UAvVAs4B92EPIjRgjAEaywnmDEV4QBGIv74ZP0=;
        b=w2CiAtcRpEa3tNMm1aKBFjvLu4mHBzXCNsMkHbE9kEj6MfxCj9if5Q2k1YFtNXGDe+
         Dw+0+SjXGBqHi05Vk10/1D1u8l10Htkh6BgPsj11+/zKUb0j9Oc3YOo3CZKYGROPcb1V
         aHIb+/UsoEe74CEwkWQnh1BcOwYlC41kqTRStH7nRJjxoIEJgw2jolk1eozn4KfxcHKW
         oUt7u2lfESyf09bS0mtVXFy0Gqenb0rkoYWMTkADOaWfhi2RIQPFPQko58r1AsDMszCy
         Cb0wjyEd31tfquUkgzvYzFTgRt/PqMUecEQngR0z1P1agV8XSKnK0VOg+AjaFIOrlJj4
         4X+g==
X-Forwarded-Encrypted: i=1; AJvYcCUf5ds2Qho9sQgFigcgAVNy9JXQ+2H1vj/K2M4JKohI6NJ4Vz0vdJY33ZLADX2ExeV/Ei4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyme1mvKjefqrxnyGePccS0v+XUjb0IwWsiMan1trnVtmnuX0Q5
	So1NfikquOqq1WOq9LjzERtirQWfUp2tLzxZBoDHHDGPHySQIkikJSER
X-Gm-Gg: ATEYQzyH35w40vY/CevGJgP9e3B/YXOZBeFpxlwPJiCR3N32htSZJvFwy/J+f0NY8vQ
	dtpr3ECL5qgBKCLU1R58ME7HkjrAN7Ui1s/LIbTWOqUHZldBCMmtA127ON+2OlJUj4eoTgG0dDB
	Pr57eC6AlTo+1xYHvlP1rl2BCAPIZcOyZH5bynpRyzhmNbneYW/f9XAXgBfNHrgJiEA4DFZlMpN
	8sO3VDc2a8Qe3ITeVJr2tqe393XbDu6zBv0kdwrCTneelGe8/1aNgha8S4A0NUYyqFPgUUpxqEA
	NFcffAYtYv2DxEewoWteG/WAan6x7MJk5YeM8TylWixQ/j1XnyXO3OeRgt0LYTldzWLKMpJpmkI
	r+g0HkgNN0QMaiUNozlkj0Q7R90nk24TW6uytI1FZ7AWJR88MWohV1giNWOH78uhzVifmXQzhfS
	nMtd4nKSz0nuymySUUoUyWtLCMra9IykLttI+H6qm/tnn0Il2ngrYJWU6x/9amwgwWue32IgPef
	wSYJLJbBvC/yUKfNGiWJO8=
X-Received: by 2002:a05:7022:238d:b0:123:331d:bdbb with SMTP id a92af1059eb24-1276ad6277emr8587660c88.22.1772098315212;
        Thu, 26 Feb 2026 01:31:55 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43c12sm1771904c88.14.2026.02.26.01.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:31:54 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2 2/2] selftests/bpf: probe_user: drop serial restriction
Date: Thu, 26 Feb 2026 17:31:32 +0800
Message-ID: <20260226093132.437206-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226093132.437206-1-sun.jian.kdev@gmail.com>
References: <20260226093132.437206-1-sun.jian.kdev@gmail.com>
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
index 280dcdb5ddef..930cded1602f 100644
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

