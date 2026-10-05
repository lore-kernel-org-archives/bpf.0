Received: from mta1.migadu.com (out-217.mta1.migadu.com [95.215.58.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27B46D560
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225347; cv=none; b=hONJNC9MqUJXWnKgUsthLwB5LXaz0fJRcStOffhxgNUp3n4KXte9S966QiG0d5hFUCxM3k+FigkaLFJ9fFGI3Kz062iJ6UaZ8fyY2dFOEdjbtXBokxSWovWENHe2fP40Lbw8AW+PGtzpL4QXKa/njuQL8lP8cIZZSz/+VxIs2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225347; c=relaxed/simple;
	bh=CVzoHsqoDYl8TH05v1NiJqpqDRuNCy/CW4PEAwqurqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCEWkFksvFp9OiVHp6RV2s43YJQZyDR1lYYhzahbuIWHPyfS1GjbeO8jAYnk6K7s7jT0qQbO3lNL+B4AEEHZZzdwbpodFx5hfZz66azaGWiEmqplb84QHEJH6m2jv4pBGeXKpCRrrhylONMsI7r00xEM1JjN5jlglE/0guhVLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vzy2znhp; arc=none smtp.client-ip=95.215.58.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vzy2znhp"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CVzoHsqoDYl8TH05v1NiJqpqDRuNCy/CW4PEAwqurqM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791225343; v=1; x=1791830143;
 b=vzy2znhpZwm2y2m4EgoiD8GJOOoq5wzvVHTTLI9EkTZa4UgMaz1xlLn3szrambfvyFNWu3Kg
 OQRcuMDrT5DkUHnogKbhgj1NV8GsWPfHiNU1eu1Rs7c8i8dWorluCkWOZbvjEjLf0t8TIztXgcl
 9fDt0tgIqf+cdXwdNf5pkxio=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 727dac0d1049f12b;
	Mon, 05 Oct 2026 18:35:25 +0000
X-Mizu-Trace-ID: 727dac0d1049f12b
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Start v1.9 development cycle
Date: Mon,  5 Oct 2026 11:35:11 -0700
Message-ID: <20261005183511.201045-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libbpf 1.8.0 has been released [1].

Update libbpf.map and libbpf_version.h to start v1.9 development cycle.

[1] https://github.com/libbpf/libbpf/releases/tag/v1.8.0

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/libbpf.map       | 3 +++
 tools/lib/bpf/libbpf_version.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 53b7b591325f..eeba4072a5da 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -473,3 +473,6 @@ LIBBPF_1.8.0 {
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
+
+LIBBPF_1.9.0 {
+} LIBBPF_1.8.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index c446c0cd8cf9..57b74ef3618c 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 8
+#define LIBBPF_MINOR_VERSION 9
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.55.0

