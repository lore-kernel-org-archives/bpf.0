Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149445560E;
	Mon,  5 Oct 2026 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193065; cv=none; b=YbCfTpfGeZB/IPSixLhYSHhj17NkhQy9PiwNHwb2z25QjRDEY00HCixJWd05093uVrWAD3VPXOFdsBO1Q62yMCvYcLHsF5URQrKCqAAl3DDT/hQ1Yhdr+Hn69mm6S9yLmkoLhpt9IDNqH6oG1pzXz+/XHofO9PZpn7PV9YcAAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193065; c=relaxed/simple;
	bh=wJRcErGmmgxqQicRwNkQHCxmUcyx2m11gOVwZNpW3Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pknKQhPI//FagvERGnQKgg8WmKMipmLPxNtqvKNDlVyPvbCulSh5ejP8664r0KQ5/w6fUgczF/wioCdqzsoEl+AX8tgYW8yFkzR7TKxNS9ABQQwkuNbM0X7QlOcHKkWKAjpMaDqDXfyw0SF85KHx71n8NcTwimnwVsOBaBAoEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVizt7DS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVizt7DS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4578C2BCC7;
	Mon,  5 Oct 2026 09:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791193064;
	bh=wJRcErGmmgxqQicRwNkQHCxmUcyx2m11gOVwZNpW3Iw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=aVizt7DSmad9nrbrS8y8zULrUXK9u7O32U9F7avM9590fygXTDsPbWGtdCpIra2Gw
	 i5g0eb/MF0Ab7I9riqka7mS5jaLRYp8/qoHTH8M+8A90BFxHfSte2WJVThk5ptasQc
	 Mfzzh7V7qgqZvnv9bb7VJcEyr7OCoIGMD2AcoMullTG+3TwY2YVtSF5Wx9cnn1ram5
	 giaS8KFGpVKn60Vgk6j1epBUBMgi0/JvsxfZ7TGKCE/xEKuxvqTEfQtEDnMMA4W6+K
	 2pE4vTZr0Xs7DmUApzqmC0psDCNKPV0NQ/Ozxo/u7M8Om3G8aq2pqSHS4kNh/OMoJL
	 8rg24A9TaxJ2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021BCA5FF0;
	Mon,  5 Oct 2026 09:37:43 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Mon, 05 Oct 2026 16:37:40 +0700
Subject: [PATCH bpf-next] selftests/bpf: Fix wq test by changing 50us sleep
 to polling over 1s
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-wq-poll-fix-v1-1-99ce4bac59f4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAAryL73YLaC7pK9NFjrYVQ0yghunvS5
 wzMPBApMEXoxAOBLo7sbAZVCJi30a6EvGQGLXWjpKzxPtC7fUfDCU3VzFW7TKORJeTCB8r6v/U
 weYOW0gnD+36q4uuHZwAAAA==
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
 linux-kernel@vger.kernel.org, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791193062; l=1776;
 i=thamrinjonathan@gmail.com; s=20261005; h=from:subject:message-id;
 bh=PyP8WYl7h3i0e+qMKJnBwJw8uVyt/3gufaH7HZJsx30=;
 b=MV6DKh4M8wIRsCymZTo6WYAbR9zbZOVVqYVtmlHYLJIaB7/jW35tryb2G0q1SP+BfBrIUpY+G
 ge/On1jAr9bD9u04c60PfH+kXWHItLZhUcQJ4hCqB++imEzQvYjlKZH
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=QU907bIMYty/tEI/iJF2SrD1lqOf/+2B1MI1zwJ5cBw=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261005
 with auth_id=1114
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

wq test fails with ok_sleepable reading 0 instead of 2 as workqueue
callback hasn't executed before check.

This happens as callback runs later on a kworker and 50us isn't always
enough.

Change from 50us sleep to polling over 1s.

Before (usleep(50)): 3 fails out of 5000 runs
Diagnosing issue (usleep(0)): 23 out of 100 runs
After (Polling): 0 out of 5000 runs
Tested using vmtest on x86_64, test pinned to one CPU with `yes` load

Link: https://github.com/kernel-patches/vmtest/issues/455

Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 84831eecc..b55d8547f 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -7,7 +7,7 @@
 void serial_test_wq(void)
 {
 	struct wq *wq_skel = NULL;
-	int err, prog_fd;
+	int err, prog_fd, tries;
 
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
@@ -28,7 +28,13 @@ void serial_test_wq(void)
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
 
-	usleep(50); /* 10 usecs should be enough, but give it extra */
+	/* loop check over 1 sec to make sure it doesn't fail early when busy */
+	for (tries = 1000; tries >= 0; tries--) {
+		if (wq_skel->bss->ok_sleepable == (1 << 1))
+			break;
+
+		usleep(1000);
+	}
 
 	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
 clean_up:

---
base-commit: b5a4aa31abd6fe90009b63e35dc18c67d041ec0c
change-id: 20261005-wq-poll-fix-f46c47dbaf03

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>


