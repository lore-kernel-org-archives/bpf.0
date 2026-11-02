Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793587007;
	b=PRfRi4s4TNNpuuLPT6rWqgVbNZDJajCIlPj+N3nlfTRxf/wYZD4NU+vZZVxkK4mC6KoN
	 GIAn1yny+BROq9urk5YKaRNOPbqRRUg4QHUhsBo1UJtOEiKgbfQMQFH0tvY/VTwtU20MI
	 TmN7GtADqrd4p9pqcbPrtpTzpYzRKxtKvEuWs6fea9O2De14L/IbkaVHGJpLilccGDZFy
	 GIPi6+bAh8HysXey9biJVc4Bu7mjqKM/Oh31RIVbmsTHlU1y/Dd9Eni0rPQz9/RUpz2/b
	 G2Ds+bQ8JxdlGAH2hLqCxdRqi0dK46BgyiojYj9Ku4ePQyYXGeheSaoOs/osMgEy1Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587007;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DRmE5KHmA5aDoz/5PiXzFOa81nzQkhxyRpJ0L3vIsC4=;
	b=1dJM9ZpI2eO37RV548h1dZY07jXnpOaa/2vsz0UrsIZ1MN+PnDiR4+A8NFMe9B5XLQqC
	 aAeSgKSiOwHZDz/Dgw+xWVqxOUKat7O3N29FeV3Nb9XizihEp4J9nnOUYuEYleCYcRLrW
	 X3gNu8j6ChgucrnMqcUM32w1fheaY+mH+w/N8w/wtpwlalppEHKqAPIurBAGx91ad8K/I
	 dHyMlm0szKIVenZbebllWp4XFMs82vmO3JHy5ADmQhX8GcTKcmHAk3K6WRhIs4pEcOb8g
	 8u9hgmQCbvK0X+qqHxbiKttj6+0IAkomNW7P7Zmtx7lihQyOVrjv5DYblvXjE3EKw9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AFk/c7Ai";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA3606A327;
	Mon,  2 Nov 2026 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFk/c7Ai
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793587006;
	b=Fy7X+jW6lJXY7g6hLp1KkwuhzJYZJraK0Z9bm1troAKRiVUl2xPhzxElxp5L4j0Nr1W7
	 NJkQ1OmFwZZrdhCh6Ke4octu83jCJ+YUF2pyv5jR1gZ+toC0VegeafUSGvrwLCfCjU5A/
	 TEddfMr59oLBMXeWMZdyTUvY6OeESNr7zZKQswdFLk3ijiTuUg0JrHHgtMG1eBLON7n4I
	 SKL85QHiDJqrASPr+X/dcEypj0pqZ34rWWaTfXskVrhatpd7YR8jnX4dxjTkBsoYdzGjZ
	 q94R+WJRAwDAZVPVoZhB3QM6LUC0uyczobeGv9w36tiMUSnuNwzGqNfj14PWJ9tl9Wg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793587006;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DRmE5KHmA5aDoz/5PiXzFOa81nzQkhxyRpJ0L3vIsC4=;
	b=X4Pa+NOuJaSZxTt7+CWvdT6bQzhI50CMlYaQuJ5ImKuPT0hNk+FC3PFTfeq00icKwYJ8
	 nTH1TcfD/IqmPiBOOJbQUSzJanzbkz2LhTfhcbosu8UVeV18ULjNtU0qyc/THqHI11I8v
	 rtKPGLqISw5EQMrzS4i32AWRFh3221vcU3RqQ3bvf05bIaxdfI37OqGTgrwqEE/rrShHG
	 O6kO7G0O6cLN1p0yUvx2kDkqfJleUnMiKxBcJcHIiZhXQLPrMEVI3yhwGlvJxltZUq34m
	 SyI2aYlr4z4um/NEBUkQ83xypu0MlJEiy+BXrLkW2mpshzSz7zZVQstcEAFx/g6MSeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3FB671F000C1;
	Mon,  2 Nov 2026 02:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793587006;
	bh=DRmE5KHmA5aDoz/5PiXzFOa81nzQkhxyRpJ0L3vIsC4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=AFk/c7AinfDvTZT9lGhPD4bSCfmbLgPAXEdiZo/Nc9R4pQtmzJTJvpCMGgc1I+Wm0
	 hTi1lOA96KQmfExBtXg7Kd4LTpHtx/CHCewFEokEW/7gOE58+6IXooBuvna27DYRES
	 cjil3BWWJc2bmkdK8kVbQj1szCvmcjUakPRjCcN/gVfyF2J8sSpY1SVu3OTGqguPWf
	 4p4r6oXHCqxOaigpsBdCanXMJ1olGUqMNsdwBD6L49TglC7RXD6EPqCfynxztAhD3G
	 /HBfcuHVwBg/MSbkC6Jw5OHuH4gpKr1qiGP62GmWkjFZooAto5WTLKeDn76s/vy+Ec
	 HAg2DHZhaWPIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 912344632A;
	Mon,  2 Nov 2026 02:36:45 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 09:36:01 +0700
Subject: [PATCH bpf-next v2] selftests/bpf: Wait for wq callback before
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
Message-Id: <20261102-wq-poll-fix-v2-1-48b7d12815b8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6DIBBEf8XsuduARRt76n80HgAX3UTFgrE2x
 n8v4dzjzMu8OSBSYIrwKA4ItHFkP6dQXgqwg557Qu5ShlKUtRSiws8bFz+O6HhHp2qr7p3RTtw
 gLZZAqc62F5jF4Uz7Cm0iA8fVh2++2WTmf42bRIlNY0kZbavGqWc/aR6v1k/Qnuf5A9N5ZsawA
 AAA
X-Change-ID: 20261005-wq-poll-fix-f46c47dbaf03
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793587005; l=2820;
 i=thamrinjonathan@gmail.com; s=20261005; h=from:subject:message-id;
 bh=hj1bolorYbBPrCihpIUsWO5AkHVCWxDBPFRwoFbNmSE=;
 b=2qboYx7ki1e6LqE0lhjhrM98EDBq+eZMEpyS8XxWBLu9Cy712OkJLs6X2eAh+pHcSfsen8tu9
 hnzvV2sXU3eBpNnqYwlHmZ9beozVU9HkH1aam4rdDat+z8buLX+3kiO
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=QU907bIMYty/tEI/iJF2SrD1lqOf/+2B1MI1zwJ5cBw=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261005
 with auth_id=1114
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

wq test fails with ok_sleepable reading 0 instead of 2 as workqueue
callback hasn't executed before check.

This happens as callback runs later on a kworker and 50us isn't always
enough.

Change from 50us sleep to waiting for callback by checking wq_cb_run.
wq_cb_sleepable() now increments wq_cb_run after setting ok_sleepable
and test loops with sched_yield() until wq_cb_run is set before
checking.

Before (usleep(50)): 3 fails out of 5000 runs
Diagnosing issue (usleep(0)): 23 out of 100 runs
After: 0 out of 2000 runs
Tested using vmtest on x86_64, test pinned to one CPU with `yes` load

Link: https://github.com/kernel-patches/vmtest/issues/455
Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
Changes in v2:
- Wait for callback via a wq_cb_run flag instead of polling with a
  timeout, similar to test_struct_ops_assoc.c (Kumar)
- Link to v1: https://lore.kernel.org/r/20261005-wq-poll-fix-v1-1-99ce4bac59f4@gmail.com
---
 tools/testing/selftests/bpf/prog_tests/wq.c |  5 +++--
 tools/testing/selftests/bpf/progs/wq.c      | 10 ++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 97926e35aaf2..95ed4b69c0f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -28,8 +28,9 @@ void serial_test_wq(void)
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
 
-	usleep(50); /* 10 usecs should be enough, but give it extra */
-
+	/* wait for wq callback to finish */
+	while (!READ_ONCE(wq_skel->bss->wq_cb_run))
+		sched_yield();
 	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
 clean_up:
 	wq__destroy(wq_skel);
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 25be2cd9d42c..8148db35effe 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -52,6 +52,7 @@ struct {
 
 __u32 ok;
 __u32 ok_sleepable;
+__u32 wq_cb_run;
 
 static int test_elem_callback(void *map, int *key,
 		int (callback_fn)(void *map, int *key, void *value))
@@ -130,11 +131,12 @@ static int wq_cb_sleepable(void *map, int *key, void *value)
 	struct elem *data = (struct elem *)value;
 	int offset = data->ok_offset;
 
-	if (*key != offset)
-		return 0;
+	if (*key == offset) {
+		bpf_kfunc_call_test_sleepable();
+		ok_sleepable |= (1 << offset);
+	}
 
-	bpf_kfunc_call_test_sleepable();
-	ok_sleepable |= (1 << offset);
+	wq_cb_run++;
 	return 0;
 }
 

---
base-commit: a30c772627b2ef4bc715332b1b04938a914556cd
change-id: 20261005-wq-poll-fix-f46c47dbaf03

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>


