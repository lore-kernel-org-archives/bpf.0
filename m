Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793676110;
	b=rYavH3+n0tBH5lGtd59Du55lT7AlCKKlRFpkzRFfnVUvcX1KWWO2fxOrHWsY3g/4zX5p
	 GMHHadpG40f/gOg5gp9AKcl9jJy3/MXl463R8aAa6ZKfkKTQAcqB9mUJ90eR/CAKU2YHv
	 qxcixMFep4rl7Z1AVmq4obvSX9CMVtGT2lJA7wTwu702Fmdea73I5PHk/1ARNgnPAKaRZ
	 s9VWjdeaYorm52iZdr+fSXCiZW3XiMyHm0eCRnBw0qmm373ewYNqORyuiU33uKWi8eJmu
	 VqZZ/sYY7H6KfVASmv1sBBezPtgrOlqATYsqHQxSdiyuVycOubrc7KThmf/olpY1Wrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676110;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3Bqa70HFsTlC3jpdiRmNrdcuuivYTvNPkgmkmv1vsBA=;
	b=YNTm4zbBK9vw9gv+pCH9GjqfZxYjQmSVi5UbOrd0A+jtobIjpIKU46y+1I8qU7UGXJMx
	 zVnS4upFrbPt3VPz0hCJDE17cCN0hm3otZsWdKq01kPsdKBvrTbFqHh7LIVHhqHpOPUSG
	 PbRaNJ62X4DkmYoV4RRqskdhFdezyoNQNqRc9GrRJChLHcU4H3xgbW1w18jEGct0Ie0h/
	 qIjc1XB2uI8Pekzus+mk/LWZ//wMm59uU/ljFXyI01zshoC/6ik7hkuLQnUZsQ4JBvZSD
	 cuKzxB4YWkOVCYujfdOJtwgdOhdJQXEtzmo/djxlz1EX1IoIBODpJ2Gjjhq+On3iKqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bz/wQ1yL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD15606A324;
	Tue,  3 Nov 2026 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz/wQ1yL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793676109;
	b=qqMgS3Dlq+2NrZK43voZHtsd7+qnsGnJ3fHcy2vuQaGd9z5qzCHSXTuvmL/5CcpsMFI3
	 oD59hXTbfhdy6k1Nol3hct5ofCVz+55LLUOkmLJ5OSxcLaBRPMV0cgpt5sXxg0AT22VIq
	 ITXeE0g9W4ZiRRnEs2Bv+dDAN35xesmqd8wPJXn4dGiaigpdVERh6Gw16V+gM4mJai7nM
	 lehTUhRZeaFwDfzDmB9IxkqSJHbEqTag1P23PFjVpsSg7rWfWhaDL6VIuhDfeqIF/65jE
	 E4S50bPb4u5x6Ww8hoNBNJVbuKoK7D0QMmSvOSqnasv6mcQBA8g3MSMXnpAcsbeyQIA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793676109;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3Bqa70HFsTlC3jpdiRmNrdcuuivYTvNPkgmkmv1vsBA=;
	b=Sc1YID6Ut4xksXpub5ntZHGv/Yc1pry0ZquLVA6Aca9wxzhOMlY+ZJ4VGORmlQSYifT1
	 8FPKveN1LPpz6BVPWiMVsHLA1y0wwECpZY5ipyJO7GXJjcjvIhaIyY+Cs92L5XxBnLh++
	 5IvYKPsvzMs/UuZOubDCLGE55cXrq3SpzWxLCB1tXnaShFvGMLnh49YqfCOVQIANX/pA2
	 137WTUUauKXqOh1sKdl4vplAbpvTUmmhsC9BBjgqbfFXviMdeAYQW1jieN1TV9AExsWzU
	 WbTEQ6fMU6YiZiXjHzI4TFv04pAUDUtYDWKPIY9axgOxIq2r3/8Vgno7CB22L4cWE0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4F3421F000C1;
	Tue,  3 Nov 2026 03:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676109;
	bh=3Bqa70HFsTlC3jpdiRmNrdcuuivYTvNPkgmkmv1vsBA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Bz/wQ1yLAk84kP9CS2jCqmWv7GDwx9GXkf2aZeN3hb3z7shuakacLgmDNEtxyWJfP
	 c/Ot3jR/DPEj3d98G3qloSxn6sr8Vpirt4DPo1EeMz7hbfUQ/3OOcoohftpLJsLacl
	 Cw1kmP+SDf6hWtS4dZAJcSRZemC/S7oX9Zk7zhylG8Hf+TzvMIVENAy5eK7IITWTBG
	 Vi3PJ14fg8eiNZz1HP2orM147bajBLFUrlYc0p/vbRKY2of+iZbjjpYsDfy02RSGK+
	 cvwdUOP6TXXXa+mdR2ua0lyNuSFxtpWHVFtNvvhad3S4/TZeILZ6SvGAlupWGcNdSQ
	 a48+e7znRlWoQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A790A46774;
	Tue,  3 Nov 2026 03:21:48 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 10:21:38 +0700
Subject: [PATCH bpf-next v3] selftests/bpf: Wait for wq callback before
 checking ok_sleepable
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-wq-poll-fix-v3-1-8e7b38f5e71f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMyw6CMBBFf4XM2jF0eIis/A/jopQpNKEPW4Ikh
 H+3ce/y3JtzDkgcDSfoiwMibyYZ7zJUlwLULN3EaMbMQCW1QpSEnzcGvyyozY5c3UvSddsIUpC
 NEDnPv9oThqDR8b7CKz86eovrHFn+r22EAutuuI2COtEM3WOy0ixX5S2c5xdF++irqgAAAA==
X-Change-ID: 20261102-wq-poll-fix-e3902f46512c
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>, 
 qikeyu2017@gmail.com, Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793676107; l=2995;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=gdSS2Zn2Y724+t41UF0QYn1E1bwWRv+MZqExp9d0kLM=;
 b=QzNXJ7/3tjFJT5uXYRsgG7/N2lQpdIxxXgJv9b0ADpCMIAvmXMqkrG42t3cHQktY4J/fsTYVt
 5n6orF1dTy2DiuipA0JGB0f3bFXXaB5keaFRN1GBXIoxOlG7SWuYXZL
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

wq test fails with ok_sleepable reading 0 instead of 2 as workqueue
callback hasn't executed before check.

This happens as callback runs later on a kworker and 50us isn't always
enough.

Change from 50us sleep to waiting for callback by polling
ok_sleepable every 1ms for up to 10s. If the callback never runs, the
test fails instead of hanging, similar to ksock_wq.c. If test_run
fails, it skips the wait and goes to clean_up since the callback
was never queued.

Before (usleep(50)): 3 fails out of 5000 runs
Diagnosing issue (usleep(0)): 23 out of 100 runs
After: 0 out of 2000 runs
Tested using vmtest on x86_64, test pinned to one CPU with `yes` load

Link: https://github.com/kernel-patches/vmtest/issues/455
Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
Changes in v3:
- Go back to bounded polling on ok_sleepable, similar to
  ksock_wq.c, as unbounded wait in v2 can hang if callback never
  runs (Alexei)
- Skip the wait if test_run fails, and raise limit to 10s (Alexei)
- Drop the wq_cb_run flag and the progs/wq.c changes
- Link to v2: https://lore.kernel.org/r/20261102-wq-poll-fix-v2-1-48b7d12815b8@gmail.com

Changes in v2:
- Wait for callback via a wq_cb_run flag instead of polling with a
  timeout, similar to test_struct_ops_assoc.c (Kumar)
- Link to v1: https://lore.kernel.org/r/20261005-wq-poll-fix-v1-1-99ce4bac59f4@gmail.com
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 97926e35aaf2..a4f71bc34fa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -4,10 +4,13 @@
 #include "wq.skel.h"
 #include "wq_failures.skel.h"
 
+#define CALLBACK_WAIT_RETRIES 10000
+#define CALLBACK_WAIT_US 1000
+
 void serial_test_wq(void)
 {
 	struct wq *wq_skel = NULL;
-	int err, prog_fd;
+	int err, prog_fd, i;
 
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
@@ -25,11 +28,12 @@ void serial_test_wq(void)
 
 	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
-	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(topts.retval, 0, "test_run");
-
-	usleep(50); /* 10 usecs should be enough, but give it extra */
+	if (!ASSERT_OK(err, "test_run") || !ASSERT_EQ(topts.retval, 0, "test_run"))
+		goto clean_up;
 
+	/* wait for wq callback to finish and fail instead of hanging if it never runs */
+	for (i = 0; i < CALLBACK_WAIT_RETRIES && !READ_ONCE(wq_skel->bss->ok_sleepable); i++)
+		usleep(CALLBACK_WAIT_US);
 	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
 clean_up:
 	wq__destroy(wq_skel);

---
base-commit: cd5bc55288d4fd999595c8f2af6a5408cbe92a52
change-id: 20261102-wq-poll-fix-e3902f46512c

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>


