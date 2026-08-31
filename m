Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C424466B66
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183959; cv=none; b=MO6XuTCuUlYp1H7Zkg4DtU0JOv7Cwepa73KIJnciGBFQamv9UWmnZbU8WSdpTc1n0tfO1SoQba9+4IQ6tlAlcqQe9tEkVegZq2f3Yx0FeDr2sOyCNOIXGT5v2yDOh0sp7HT+JSCqZ2qYtreH4U8TnKCXuEgGu5c1z//UhBH5KCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183959; c=relaxed/simple;
	bh=JUCk/cLbhidqmM5D3jBlxBY8fMO1bXj3IZTST3KwGck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SZtC5FIk82s1yeJiskSm2yKnAcjUM2ctD65qLZFazw9qLNlG8xMCx7TNjvr1rLvLb4iXZv2LaLn2qRTRyLuxHLGJJrDKIE9fMIbU7EcO4NgsKeNXsVc/oM03uChJlmPE1gQ5z8lkwAw0PNdCivsfYUQFO7/OsaBosqgbTtNhgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlAkFmVm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlAkFmVm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so3363555e9.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183955; x=1788788755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l1QkCFEds/SVo+FCUoEAOKjVoLsCWq/U/WfbsaF3Hfk=;
        b=MlAkFmVmMbVAMpWRgzBlUA+wPdZx6orWBVL3vG11scS7ntzhxe6/ek1DpQDK6cGukL
         ZeAj+Gami3LqI1OMgmAMTquJrnsE8j2ur1iZNtTmu/P5BvSPW5GpX0mDmcuoWkzOFiQk
         JFEYiYqaGeXKrU8i6JGzN1CjX/loP2rqjgJdU0bahy1a6PBcq0Iy0MPbvB01kZWX7ft6
         22Darggbey/d7aoPJ6uv6fdUxC7X6nxCsqpfflY3HDWUtyV9Ptq/n3EfMz9i+BErXDvH
         cPsmPdXdC6y+2VXidGFAb43Wx5bOQBD/GaDcntNiR9eFfyLbhwwGqglQAGhWkzik6moq
         y8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183955; x=1788788755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l1QkCFEds/SVo+FCUoEAOKjVoLsCWq/U/WfbsaF3Hfk=;
        b=NAsUfF/5FLmyJSkQrLci3leDgyyr290aTFDgmqVKWR3V4d53il7vCOduuw7ej2GaoT
         6vYJkei8wlnVt6b4M4pUXeq1SkX4JUDpug+/0oW1QoWRk9C+ZXSrKuuH3HANSSoaLlW0
         331dBY8Bs5svhyiOgq592fw9Cobfe5GZiZ3dLVsxCR+TaV26yyNvHSsVaKgZCNHVmHz3
         0YcoMTkqrrZ02RkgfghRmK8irsnYOkGFJ9F+uMuxX9a3BkghcWrlOfC5Dmbe4gibWFUt
         Ps95+G0tM79QypY4DVmgOFn9JKRMGLRHWJCHO/3H1BDyGk/fY0gXlWrYdLIpD0gjqsin
         MGgg==
X-Gm-Message-State: AFuF++nhj4lBCPzXk73Gguf0OGsCGD4HnFqAPZ9a8HyE8krpQ6tY4UMM
	GuZ+OdNun8DZXTyRMFZowzn6ngml7HKkKmnAx9c3HpjXSivFZ/0tdwC0
X-Gm-Gg: AR+sD10u2NPXhLLFL1+u0Z1/M9zdhGoCN/ogFL5mTyYa8UXqpLYshNEmiQ5wfAR3UgF
	ClTsZfoNLRfsOnoM2BbOind7KV/cR+jYRTuwLRedHUtxK0U8cpGHrLjQmlagkzSdOXo/qI6KqT4
	CQN1PTDUn23ANa9nWg3Psm5TeNzHPVNtZo28YvTn8y+GeaDQVSA3DxzXk3LwGaseo+uuynz93rl
	zIECbtYrkD0cBwYe9hx5fze/GptoWeretkStH4wOhWzmMiR1Knkop/rgzfCejIX3jEOWNiX6VVy
	BxAr9WsVmyo2xDLZhU8mxX6BorLKcpqvYgQu8IQ4502JpqJnrRISgZdJUGBaCzrwohTR6kAX/Ob
	UYhmFAp/ls3CBQGg1RUGMo8P9F4RMc80WoldtFOQ/qmJm4QNAFnSfXhV2lD3TP9fp9DnizJuIp0
	BO0zRvMcuEEmfR7GNE4qiWDuUZh8ObrUcp+mN0SlTZHpfgJ5D8BsRErS0p7ECtW3rW8gt02CySM
	w==
X-Received: by 2002:a05:600c:4712:b0:49b:910c:76fb with SMTP id 5b1f17b1804b1-49b91c4567dmr142503895e9.2.1788183955116;
        Mon, 31 Aug 2026 06:45:55 -0700 (PDT)
Received: from debian.home.arpa ([88.97.179.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b468009f8sm382530045e9.0.2026.08.31.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:45:54 -0700 (PDT)
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] libbpf: Fix debian kernel version information parsing
Date: Mon, 31 Aug 2026 14:45:37 +0100
Message-Id: <20260831134537.1227914-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently get_debian_kernel_version() expects the version to be in the
form of x.y.z but the Debian kernels uploaded to experimental are not
always LTS kernels. Like the current Debian kernel in experimental
is 7.2~rc7-1~exp1 and uname -v reported "Debian 7.2~rc7-1~exp1".

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index e40819465ddc7..5acf0f84a40a1 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -62,7 +62,7 @@ static __u32 get_ubuntu_kernel_version(void)
  */
 static __u32 get_debian_kernel_version(struct utsname *info)
 {
-	__u32 major, minor, patch;
+	__u32 major, minor, patch = 0;
 	char *p;
 
 	p = strstr(info->version, "Debian ");
@@ -71,10 +71,13 @@ static __u32 get_debian_kernel_version(struct utsname *info)
 		return 0;
 	}
 
-	if (sscanf(p, "Debian %u.%u.%u", &major, &minor, &patch) != 3)
-		return 0;
+	if (sscanf(p, "Debian %u.%u.%u", &major, &minor, &patch) == 3)
+		return KERNEL_VERSION(major, minor, patch);
 
-	return KERNEL_VERSION(major, minor, patch);
+	if (sscanf(p, "Debian %u.%u", &major, &minor) == 2)
+		return KERNEL_VERSION(major, minor, patch);
+
+	return 0;
 }
 
 __u32 get_kernel_version(void)
-- 
2.39.5

