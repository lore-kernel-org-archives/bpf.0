Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698031;
	b=HnInl0agE4X0DbYV+Vmuwd55jtMGopwVHgClreeBIuqIZujpLPC270Dj5iJsYPG2KnVG
	 tbNEUPCvxg/wy+S9eR6OlAF0/XWsTm0cp8rf8knf6NVErtqVHdndT1So1IBKfq6DKI4CZ
	 T2iUwmDnPPLr1dbWdzhT+u0994tuupbPW+bzKRzn+cgJFAVB+ZzqrTg9MOqs2X6H+IVHk
	 r7w/vR5IHn+lyxsTbIJfxZMcVSlQO25H1OgCNVmFaXzWrrPyH3KztMqDfFzF5i/oTuWh3
	 OlGONCHuWHxfEnsBNlc3l0RWttPq8//8Rt5kL6/s37TxG2vM2nuLjChAUUDJD5Rs7Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698031;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=fkK1uCwwzUMb2PiZqxaXOt1gFq6un0zd6u+YCXzwUoU=;
	b=ByRdyOrNFqzDDmctOE1gQm5SwskGjYVXW2L5GRF+wvJariGL4SD/BTcNFqpj3blEI10t
	 zAMn4U0lktTIpWGOagGiWAplpmFZ8adxPtVchQlW0NE7WSW0GWaegQZTC8NCz+qjNzkUN
	 QRf5RguXixNzMQxi8Q+CMjB4pXbmG9RoH548jQDGjnfnaXYKv5e4XIQR7X4OZvU4S7MlK
	 7jQbvOkDW1f5F/joQASUOJxtdpcLHh6g1nA7o5+TsL3kpdPYYbZWiLSIpegmaot2SvFYy
	 uCUppyAR6Zd2KNiTNZaucbthjQlkZdjPCQ0W91+ZYspJqjoNDGvRJXPKZawbEofZpeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="dWCfq7/u";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFF606A335
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAAFF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dWCfq7/u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkK1uCwwzUMb2PiZqxaXOt1gFq6un0zd6u+YCXzwUoU=;
	b=dWCfq7/uMqDwHqhAYrW56vmmjRRQQRT+sI26d2KHiB4EGk5hGpwHqrWuLeuLv+V7Pnnryg
	soEDlpdrxVsBOOauWdl4odB5Roc/0GketoRg993X5UY9zWRgaTKy2CUtMo5FjyW0W/Y6fJ
	a5k5yG8KrwVL+i2esdg3ALSK1qDdVlQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-U5FQP9DrOD2qBgWwCmUoPw-1; Thu,
 26 Nov 2026 13:00:27 +0000
X-MC-Unique: U5FQP9DrOD2qBgWwCmUoPw-1
X-Mimecast-MFC-AGG-ID: U5FQP9DrOD2qBgWwCmUoPw_1795698025
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C2BD1800349;
	Thu, 26 Nov 2026 13:00:25 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B833E1801977;
	Thu, 26 Nov 2026 13:00:21 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 02/18] tools/rv: Skip empty pid error in selftest if command failed
Date: Thu, 26 Nov 2026 13:59:48 +0100
Message-ID: <20261126130004.127155-3-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some rv userspace selftests rely on the pid of the rv process to match
with the output and fail prematurely in case the pid was not found.
If the rv process failed, however, it's likely it will terminate before
catching the pid, and the test reports empty pid ignoring the error that
caused the process to fail.

Report empty pid only when the rv process succeeds and continue showing
exit code and output otherwise.

Fixes: 92f0ce552990 ("tools/rv: Add selftests")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/tests/engine.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/verification/tests/engine.sh b/tools/verification/tests/engine.sh
index cfdf2180aad8..4dad43b0b822 100644
--- a/tools/verification/tests/engine.sh
+++ b/tools/verification/tests/engine.sh
@@ -60,8 +60,9 @@ _check() {
 	failbuf=''
 	fail=0
 
-	# Suppress any other error if a needed pid is empty
-	if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns"; then
+	# Suppress any other error if a needed pid is empty and there was no other error
+	if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns" \
+		&& [ $exitcode -eq "$expected_exitcode" ]; then
 		result=''
 		failure "# Empty pid for $command"
 		return 1
-- 
2.56.1

