Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157949;
	b=00FgQ7hfEox5NSdnX3xIrVEY0OODMFNWypRfn1N1++HsHvs1nz4X5VdIA22UvxFuzCjQ
	 T+iJvi8KEctnzZguHdqO7g2EpTbEThgCYcL+2tfHeSu8P2GLNCklUCAf8Zj5la6PVhhDF
	 ShXTNQ0V6l0tyR9jyCqdLK4biDPjRxYYyWy2TtMP1bKOm3sdVH+jJakn741vSEvmUmHKy
	 WreHIeCBxMC8QZKKzLUjTaMVO/dcjMDO162dXuAuoOF7fVvOPru4BLnazrnqmbB4Ad/Ah
	 nh5GBaHLTscyYzXLcOblZrqmAT1zuZl5Qefknp3JXbAV3x1k+BXNh9jdNKhtAv1aqDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157949;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PsTftBeYEFXfD9zeAqWuNXYkJ0bBYpNs1Jn91O8mPyk=;
	b=LFfaRMQscjUE0glB0lbrMtKzYc4mJq70ZG6j/DfA6xAJkzJjkMFqddMIu4W3GeRgr+sQ
	 cQdQ8Y8ZSyx2pML/cwWpzxKz6Gm2Quorl3IBhjKKZGivxp9NKso26kGt9JHbzb5qHfrbA
	 Qmv9GDFQISqVRUoVZ9zXrH1H20yuP1uRg4mV2+ZBXtSa8prHHKWKqd27Y++PwaDfHe18M
	 nLFii58TRASRx+cGSondcvX2OveI+r91mgbRlcnWdkqa1eY0wCNQTiFg6Z6BGCKkJIJV4
	 SyQLYtArY8Q+71s6WQOnVGUbdknF5++I1+ssTv7DNwIkxUvEiaABLNIbgs1LlY52GOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCyew42g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70619606A326;
	Fri, 20 Nov 2026 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCyew42g
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795157948;
	b=vT2lxp5LBkET7JRoxREp0QtKM5PcBsUu13sKVElh7NBSkj/x57joI+fEKiOQLgDi+SA0
	 JvcyqiO+WitfNlMDEpWDNc+oIxW3VzF6XJJseMpUliugryadPJixr+ElQGswq28pLMeB4
	 ozJ6cyyidq7gw9LKLYTZCxVHPxAOSLtn3jB8XXNSQNt8glNBBfbt3mZRK18ysiwtBeAiK
	 bv0b7D8CQP6A5grJnv23PaeryhPxil9R+5F1W0SHh7cZq2IuEgeNafWQ0EYcLIXd/YBHH
	 AJOaTW1H9kLV1Ug8ITwOVpBSaVX+6XIZI/dIFbZ9h31aqEhd6gJsUmzNQfe3akuQ7Yw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795157948;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PsTftBeYEFXfD9zeAqWuNXYkJ0bBYpNs1Jn91O8mPyk=;
	b=LeXcqISEq3T7ip2g9u8n0NJrrxCyh14vSGvlNKqOWfvmp0IC+EnUgvK/fDGyTmNODPt0
	 2EvXJXTN4ZLvujibTxkqROw0Frj5bDhSTtJ3p0myeO1JMCs8iz6NnKNmlTHC94qlKQ7MM
	 D0NmNXUjoTiJjIqL40wcLjopX/r8tNqaooUA6c6shkao7SJIx6zChgLL6WhDf+jdvmahj
	 ezYGKHRnitriix6O1BI5xBI6q4A8qQlOC2cFlzUDMSJGbfq90BV+dN4/QMXRp7zQtjoUO
	 qLynDsIC8V0wtxarM4RaqUHbe+gUkPl7jyp1x+yyYQbqpttg695LVZ5lXLDCnhMs8og==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 77F2A1F000C4;
	Fri, 20 Nov 2026 06:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157948;
	bh=PsTftBeYEFXfD9zeAqWuNXYkJ0bBYpNs1Jn91O8mPyk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lCyew42gbvburfPID2Gmw+2swMZfRiqgc2H0IknU+oMblMaoV5lSiw+FGWbdg8tX5
	 Wfpl7WglovqsLeNXtAeRq3mexaI89U9aVt9mPLsOf8MXYhFdb2aNBNhXVloaeQts1Y
	 sTpcSHAfMvnqnbEn1JfE1lqEK0ZJyAB8UiIxCYC1hit47/CDLVTKzeE1QKRldwUi64
	 osxknHtzMwL+or18O+iwy8K/3sTOc0T+eX2le8BOwh0YXZdGO0wT4ODdbyk+6/BMeR
	 ruOwJFd40e8TFT8vHpq0wKMNiXlSvzxLaF2ci7hEvowgBCxSW4xaYF6pXQG/czAZ2w
	 2EA/t9NYdZ3nQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B6C949716;
	Fri, 20 Nov 2026 06:59:08 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 14:59:02 +0800
Subject: [PATCH bpf-next] selftests/bpf: Fix
 file_reader/on_open_non_sleepable_first on overlayfs
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
Message-Id: <20261120-file-reader-overlayfs-v1-1-81aa7f3041d1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDuQpFaaXqV0Ec0fHZAokyIW8
 e6GLr/FewcVqKDQqzlIsUmRJVfYW0PDFPIIllhNzrjOWmc4yQxWhAjlZYPO4ZcKm9b7Z4yhe/g
 71XZVJNn/3zf1a+KM/Uuf87wAwDh0gnEAAAA=
X-Change-ID: 20261120-file-reader-overlayfs-04998dda6593
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795157947; l=2542;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=Z42i5/leJVwaMNYSXOof1lDedpwAns1zY51D5qfLFZg=;
 b=BVELy4sSCT416yAlXQDGZOkNtmJrAAIWI07LrHUOPdK4831RXbQ3f0/U5f91jZvgqGiuvGpmL
 WwqN1+FqKaxBANdUCPWmvgNM9CLE67wy3NxSXRR6Y8yeTXZOETej6IR
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

on_open_non_sleepable_first fails every time when the test_progs binary
is on overlayfs, as under /home and /tmp in a virtme-ng guest:

  run_test:FAIL:err unexpected err: actual 4 != expected 0

bpf_task_work_schedule_signal() returns -EBUSY.  On overlayfs, the
open() of /proc/self/exe calls security_file_open() twice: once for
the overlay file, and once more for the backing file through
ovl_open() -> backing_file_open() -> vfs_open().  The program runs
twice in the same task, and the second call finds the work from the
first one still pending, since it only runs on return to user space.

Act only on the first call.  The other file_open programs in the file
either don't schedule task work or don't check the result, so running
twice doesn't affect them.

Fixes: fc38f07781ca ("selftests/bpf: Test per-call site function specialization")
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
Tested in a virtme-ng guest on bpf-next (82cc2b4383e3): file_reader
passes from overlayfs and from a tmpfs copy, and 20 times in a row
from overlayfs; without the change the subtest fails from overlayfs
and passes from tmpfs.

The patch, this text and the tests were written and run with Claude
Code; I reproduced the issue and reviewed the change.
---
 tools/testing/selftests/bpf/progs/file_reader.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index 8b972fd26d73..1318b8e0845c 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -28,6 +28,7 @@ char tmp_buf[256000];
 int pid = 0;
 int err, run_success = 0;
 __u64 beyond_eof_offset;
+bool done;
 
 static int validate_file_read(struct file *file);
 static int task_work_callback(struct bpf_map *map, void *key, void *value);
@@ -101,8 +102,13 @@ int on_open_non_sleepable_first(void *c)
 	int key = 0;
 	int ret;
 
-	if (bpf_get_current_pid_tgid() >> 32 != pid)
+	/*
+	 * On overlayfs, file_open runs again for the backing file, while the
+	 * work scheduled by the first call is still pending.
+	 */
+	if (bpf_get_current_pid_tgid() >> 32 != pid || done)
 		return 0;
+	done = true;
 
 	file = bpf_get_task_exe_file(task);
 	if (!file) {

---
base-commit: 82cc2b4383e3edfa1026c8612fb4e90a9329ba11
change-id: 20261120-file-reader-overlayfs-04998dda6593

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


