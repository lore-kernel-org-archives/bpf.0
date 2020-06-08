Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C19C433E1
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A76206C3
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663051;
	bh=WqI1PTDKZAdRarwsH99PbqlFFjL5B6QoYx6yi1O0fD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GtSMvaGbr4wNVmt0IqfSPZkzobjmiPpXnwI0BZmf4ABLAJJAn9oSBS6CuU12nlNwf
	 CfVUae+TAXjtUzTZEyLy1gXMvu7JVda9xEAniZRHpR5xEwam/uC90Ru/airSFD313h
	 pKKJr6NUfYaa5mhjh92C6XbGOWLolPXR5+Cm+0CM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgFHXNq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729565AbgFHXNo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70EC21527;
        Mon,  8 Jun 2020 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658023;
        bh=WqI1PTDKZAdRarwsH99PbqlFFjL5B6QoYx6yi1O0fD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1s+xWP9LgVw9/isBtjxfhwugcTK7rTZPzpJmJPB2zr76w5JXxeTY+Yk5TcyXbBWw
         LBxkBeteZX/ePRtZZekNGnQM0z/VLdSTapagFU3gd9G/uKtwQsuVd2nU3EG8vD88wn
         2VB8ufKlM1jGQ6WX2mBFrg3f8rekKSxpKXIutPdk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 076/606] selftests/bpf: Enforce returning 0 for fentry/fexit programs
Date:   Mon,  8 Jun 2020 19:03:21 -0400
Message-Id: <20200608231211.3363633-76-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

commit 6d74f64b922b8394dccc52576659cb0dc0a1da7b upstream.

There are a few fentry/fexit programs returning non-0.
The tests with these programs will break with the previous
patch which enfoced return-0 rules. Fix them properly.

Fixes: ac065870d928 ("selftests/bpf: Add BPF_PROG, BPF_KPROBE, and BPF_KRETPROBE macros")
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200514053207.1298479-1-yhs@fb.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/progs/test_overhead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_overhead.c b/tools/testing/selftests/bpf/progs/test_overhead.c
index bfe9fbcb9684..e15c7589695e 100644
--- a/tools/testing/selftests/bpf/progs/test_overhead.c
+++ b/tools/testing/selftests/bpf/progs/test_overhead.c
@@ -33,13 +33,13 @@ int prog3(struct bpf_raw_tracepoint_args *ctx)
 SEC("fentry/__set_task_comm")
 int BPF_PROG(prog4, struct task_struct *tsk, const char *buf, bool exec)
 {
-	return !tsk;
+	return 0;
 }
 
 SEC("fexit/__set_task_comm")
 int BPF_PROG(prog5, struct task_struct *tsk, const char *buf, bool exec)
 {
-	return !tsk;
+	return 0;
 }
 
 char _license[] SEC("license") = "GPL";
-- 
2.25.1

