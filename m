Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9AE4F85D4
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840219; cv=none; b=SOtPoktyoLBXR6toPXGKTtY63U8P1y89KAvuhx8N7HAsbJu2z/gohh91pfCGUUxBUsWdb4dtZt74lrASAqmYoNQTwow+Q1M2n0qjaq/sYJUftgN2hWoBLYgOW/HERiwJ0cioj/Iuw0ja5y94QSiZQe5NdXgclFYibLnxi4FC8ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840219; c=relaxed/simple;
	bh=LsO1xfPThEa8wC7kBqFr31UhJSOzYIINCkUQJUsyjSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k99nPR4JDSjG6gAQdF+WO2L4KdHVx3mpTHoogGFdTBp3HWCJTvbrh/rJyKrORoY5P2rxN2IEMWD7gZOssIHrfx6EYP5Ulhqtfb10jhRE9h4/uGdKwQ7Fwdl3TVqpCd0QfEl5dpYbfDWAASfJw+GVRvSk0qAYsXV6Ox/5VKfi9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/sL9mNX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/sL9mNX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a166199820so14594055e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791840216; x=1792445016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rN9kd0u0kwEKQcqtsQgX5NTYJE7KMXdgprM5d1jYEwU=;
        b=Z/sL9mNXR3e/FMW6PzGARL1hquhNJWRvyliknPCnXAQophEheen0IDvNQfl3WBB0K1
         0Kgx8fRh6SrrXmvUyZZ9JzPAngnSo/4sNqcIe5IGxwN91m0T3dc/vcFrfahvGlo8MEJe
         7Trx+lZV0bHNvfoNotCJ8sPOc7/QbOOS08Bg9b4lTPM6LIeIJaHH0fPWMilF6nduKMh9
         4SKtH00T8kz+RQurKhhNl7s8XWTwgVx8J1EQJ6IirjSS9P235Yjm1+dBqduVzFmAcRJ1
         8owrkHtGLe1amcrSsrGIsKcKG9g+kIRGvqnKltv460SYeR68fnZWXbcSmBNun4AyXhZy
         pZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840216; x=1792445016;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rN9kd0u0kwEKQcqtsQgX5NTYJE7KMXdgprM5d1jYEwU=;
        b=Z3wII6/KMqu/HmkZ+bGBTAWYyLceZsQkmjnsfPOiEo5FbH5gwZImGYsGLV0bXDSQzQ
         G2VLEyKVQOpa+hUYgueqAmOwJ6ALfBApHrv/LEtS+MUjBlVPcciuTkraNnSczaqvM4SU
         VERR/k/xI+5WOSg06o0WyJSjMwCceVbCSZ/P2S7ubxgjppiVrjpNsKIHK6Fuwu1xGrm2
         mN1Q9rmQBaoUaXclvHQ4NHLA91tz+aQBekOJdcU4st7lvKBQmgshJUy50QxfHSBV/Nko
         fL6iJppaHVdDoMatPEFNSGIUr/P17oMrO/Xil8pBvsKaU4e/P7sLHw33MjAXaDDJJ2Js
         y2yg==
X-Forwarded-Encrypted: i=1; AKwUvBxUHUiIDfvIYmH6dFEFWYyydGpV0H36bitlhRutFU2Rj3gG5p64nCY9HLhWjRBUYbvs5+I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUB3OhOEFJ0SbYEb28hFuCSgh0jTi6W2mkuMyD8IjZcBmTYycd
	p7fRH8j7/yyHbhIN+ZPUjGyk5mRZhf3aVKR3RK1mGPalp138XNNy3d80
X-Gm-Gg: AYBFou2/lmwcVmme5xk4KVHRjqgAJampxdvaq7l4cWHDXZC6Bx4uaNDEuu1cTB7Zpe/
	vnfymoBs4Ip+j9BR8iG2zfKI52sehmAD16lo4nUGJSzVxt92ahDsAkOdUXSSLgROKTDWOsI9QZW
	RsG37U1XGHUj6ZrU0PlFhsIYWD55utwmg/cs04hWC37MuKPPmfZJj3biCv2zhpyxaniVJYqDi5z
	Af/B27EGiSG9UQcm8ZQLwGyi3ChL2/bw2L466lZwxAzzxEe6Yv/0ZMBU0H0qvb6UFqmgPIUspdi
	8tHpgItMgUfp8aiLydIFNFWgDgKrYYMdwcyodPhVBxrS7aJGD/UVRE02WpNGGzuk1wwsNOVl5sE
	zKGAt169qrY88E1/iwEr6ysjzHpS+v4rmJxXpnj1MTG9nNAo/6z4T1v7f0lDGIBfB49botGoYFt
	/T0dNfbswx0Rla06axgjL5cEWhoomsdVn+4P1kow5JlcW8VOKJbcPN85xdkZ1AoFqwUV63nIFnh
	I7WGCA=
X-Received: by 2002:a05:600c:154e:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4a18e49ad83mr204341295e9.11.1791840216298;
        Mon, 12 Oct 2026 14:23:36 -0700 (PDT)
Received: from localhost ([5.83.201.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19ba624b3sm186925215e9.2.2026.10.12.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:23:35 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix spelling mistakes in descr literal strings
Date: Mon, 12 Oct 2026 22:23:34 +0100
Message-ID: <20261012212334.183116-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in the descr literal strings. Fix them.

Fixes: 095ddb501b39 ("selftests/bpf: Add sockopt case to verify prog_type")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index 6c96f2d9fccf..7dfdc4c12dec 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -955,7 +955,7 @@ static struct sockopt_test {
 	/* ==================== prog_type ====================  */
 
 	{
-		.descr = "can attach only BPF_CGROUP_SETSOCKOP",
+		.descr = "can attach only BPF_CGROUP_SETSOCKOPT",
 		.insns = {
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -969,7 +969,7 @@ static struct sockopt_test {
 	},
 
 	{
-		.descr = "can attach only BPF_CGROUP_GETSOCKOP",
+		.descr = "can attach only BPF_CGROUP_GETSOCKOPT",
 		.insns = {
 			/* return 1 */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
-- 
2.55.0

