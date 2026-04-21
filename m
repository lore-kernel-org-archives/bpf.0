Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715C3D75DC
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782022; cv=none; b=pJsPPCvjFaNCKq2AvQ8xRfoBO58CjoSsRoctUcjF7DsGZrt83KT84uHCZldh1OvtxdNhgNRGWmssTkNx24IzE14jMoazIogMRS1ZQ8ufIa0q/Jjw8PrfHBZ2hrRY833L+zUke73SzTlU2CxFcPanStOcMbbH5lhaEVJsQ4mpw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782022; c=relaxed/simple;
	bh=QRkzpOfIdLQOwO+1Bcq/Svmd0LDuWBS4jZWfdMs7VW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KCX6dTbTQ2Rb6A+qpV3W2a1bCPEamJ7UmjLdsS1gdxPEiOoPBFmzjA94l9vQEo8v2IUvBjcvc9Sb74NBdOmuOsC14WfsxDQ+vbfGIwemgtcChJjqqyYRNYEeHPL1XqUFf2IMCfaihmwtbV1YdcsDJrvnEUWSrQ+nwO2SAyE1NtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zPoA2mxw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zPoA2mxw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C2E5C4E42A8E;
	Tue, 21 Apr 2026 14:33:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8D8E2600D2;
	Tue, 21 Apr 2026 14:33:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3303E10460AE2;
	Tue, 21 Apr 2026 16:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776782015; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=PoW8gAqBbWO9OL/dC75McAVWKYPqOXFPSYaS2+pvi5Q=;
	b=zPoA2mxwBWemVis4ZfN7tiJ5OD/Cy3Ogs4zXDHGtK2jQXdezW+p/HIz/k64MWvzOQ0l3ic
	QnrL8C5++JJex21qL5v4gMTZTuXMjOoeT40hPDRtdCMCQQ39/SCkJauGcLWWTweHPQ6ANC
	BwM+vlbTHjVzLG1R0qOmKvHlNd4yn+A2+KbvNxywEJ9fIzJ1B9w7KPRxugYcskWzsCkr0W
	/0TnJwrvLy40hwnDS6XCWTXgHIPesOmBzNqGj5EJXBXmqlk8r0AAl7lDKwOkAA4E8t3oDa
	wU/LUeClrlBJl6SnydbtEPNvCZ034Us1oA1oOKL183B35IfjYkbD1T6pgYAdtw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 21 Apr 2026 16:33:29 +0200
Subject: [PATCH bpf-next] bpf/selftests: fix uprobe_multi usage
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-uprobe_multi_usage-v1-1-4c51675955e6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQqDMBAFryL7bSCG2GKvUkRcu2lXbAzZRATx7
 k3bz+G9mQOEIpPArTog0sbCqy/Q1BVMr9E/SfGjMBhtLtqaRuUQV6ThnZfEQ5axPGzbYXfVttX
 ooIghkuP9F70DBqc87Qn6/yIZZ5rStwnn+QHwNaTHgAAAAA==
X-Change-ID: 20260421-uprobe_multi_usage-459b970450bf
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

uprobe_multi usage message not in sync with the list of subtests it
actually supports.

Add the missing subtests in the help message.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/uprobe_multi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index 3e58a86b8e25..0af330b6c364 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -144,6 +144,8 @@ int main(int argc, char **argv)
 		return trigger_uprobe(true /* page-in build ID */);
 
 error:
-	fprintf(stderr, "usage: %s <bench|usdt>\n", argv[0]);
+	fprintf(stderr,
+		"usage: %s <bench|usdt|uprobe-paged-out|uprobe-paged-in>\n",
+		argv[0]);
 	return -1;
 }

---
base-commit: 05103382104b8ffc701f7b2c79379a0361ecad30
change-id: 20260421-uprobe_multi_usage-459b970450bf

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

