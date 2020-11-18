Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A9C63697
	for <bpf@archiver.kernel.org>; Wed, 18 Nov 2020 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CEB24698
	for <bpf@archiver.kernel.org>; Wed, 18 Nov 2020 13:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yxB/KcCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgKRNtf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 18 Nov 2020 08:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgKRNtf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Nov 2020 08:49:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D020D2065C;
        Wed, 18 Nov 2020 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605707375;
        bh=Uf6OeZIjyAMpkxI+7HgUeUSemvA3wxfOMZHmxJmLarU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxB/KcCTGyW11MVhtTRAVTO0uUx0M4/3q2ukRHfgjFU/B4lwb3/6N7mrnG3nsUF+V
         QavQj/B6Js0paJshW8sGYvWcuyBk+GdfDK9UrWV8vmcg/hcROdhMb2qZPCCTCK/FGq
         c7+ayaXjgpkApN4u2Ew0ON7Y/CCsIlDTl4a6s6U0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     jbacik@fb.com, ast@kernel.org
Cc:     bpf@vger.kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, luomeng12@huawei.com
Subject: [PATCH] fail_function: remove a redundant mutex unlock
Date:   Wed, 18 Nov 2020 22:49:31 +0900
Message-Id: <160570737118.263807.8358435412898356284.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110084245.3067324-1-luomeng12@huawei.com>
References: <20201110084245.3067324-1-luomeng12@huawei.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Luo Meng <luomeng12@huawei.com>

Fix a mutex_unlock() issue where before copy_from_user() is
not called mutex_locked.

Fixes: 4b1a29a7f542 ("error-injection: Support fault injection framework")
Reported-by: Hulk Robot <hulkci@huawei.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Luo Meng <luomeng12@huawei.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 63b349168da7..b0b1ad93fa95 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -253,7 +253,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 
 	if (copy_from_user(buf, buffer, count)) {
 		ret = -EFAULT;
-		goto out;
+		goto out_free;
 	}
 	buf[count] = '\0';
 	sym = strstrip(buf);
@@ -307,8 +307,9 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 		ret = count;
 	}
 out:
-	kfree(buf);
 	mutex_unlock(&fei_lock);
+out_free:
+	kfree(buf);
 	return ret;
 }
 

