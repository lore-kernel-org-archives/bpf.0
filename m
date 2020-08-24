Return-Path: <SRS0=dkA9=CC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFBC433E3
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0768320738
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289598;
	bh=LnaqLY9ql4cWQoO1HlbbxQ5sT02Kl1si/mbPUnWBkbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yizrql5FLGJ/c6IyBX2TeoUoau/tQtn7Es64PTlNtyevpI/gKsQxUNw4UFX/qOQ2w
	 ICTu1xyJMCGXFA1J1LeGHSCjv9hPcWb0/3D2vyTqIsW8pNcK72jliDNqei843+eryx
	 yyL3pwfW3HnUNLiAJhQebIktYUirZE58Fo6e2uxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHXRSu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgHXQgj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 12:36:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D03F22DA7;
        Mon, 24 Aug 2020 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286981;
        bh=LnaqLY9ql4cWQoO1HlbbxQ5sT02Kl1si/mbPUnWBkbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LnVzYf2q+/ZxhYqfm94Q9Zz7jIMrUt9aN2+gKLAPlZE1pQe6Ci7xFhM9AktjOyoNe
         dI/Fu6wkMSDSHZP6V9H1ssw4MRvkWcNbDTvnJGmMJTqrqPisPWyic44zs11LZ5bVe2
         sw8Hznndyex6cEUOrBH52u7nu6o0dCzWJMv4PlCE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 56/63] bpf: Avoid visit same object multiple times
Date:   Mon, 24 Aug 2020 12:34:56 -0400
Message-Id: <20200824163504.605538-56-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit e60572b8d4c39572be6857d1ec91fdf979f8775f ]

Currently when traversing all tasks, the next tid
is always increased by one. This may result in
visiting the same task multiple times in a
pid namespace.

This patch fixed the issue by seting the next
tid as pid_nr_ns(pid, ns) + 1, similar to
funciton next_tgid().

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/bpf/20200818222310.2181500-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/task_iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index ac7869a389990..cd7d9564bcef6 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -28,8 +28,9 @@ static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
 
 	rcu_read_lock();
 retry:
-	pid = idr_get_next(&ns->idr, tid);
+	pid = find_ge_pid(*tid, ns);
 	if (pid) {
+		*tid = pid_nr_ns(pid, ns);
 		task = get_pid_task(pid, PIDTYPE_PID);
 		if (!task) {
 			++*tid;
-- 
2.25.1

