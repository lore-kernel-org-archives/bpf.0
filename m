Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527351CD2C;
	Mon,  1 Jun 2026 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283313; cv=none; b=Y/qXcbwN6ondajFmJao833zYzzdQVdsfKDFrRAJY/ubNNbzlxK2LRcJQP4290Lo9M4jsj1e/s+GRpZ5B6cjkcCkdO4RPF2AgJokiZUxkmlVOc7s7uuO21gEQw7TWVECqNgOkSV+0StKaPfmY4rnNACi6OeqUWXUjYN77MJsR5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283313; c=relaxed/simple;
	bh=tMDfNkGQ+Wl5mAlRHZIVISbW6X21lwUZRzgzAXlvml4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A4gqOoxsQK8c5W/c+q9VbeJmgwJTbljia12StHaBHKt4fVS7cuZg3IBWqKbgGbtjBbwZ3rHQQaRkL4ETj8cCmd7WqF0LVHjpdEx95QkxrbtyP8VQFFB9+EGoYdDOimWgKvnXFFBH8xM5cGIw3q8JKuRf3VYqL21bBtrifBcUlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iOYhuolm; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iOYhuolm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780283257;
	bh=QO1KFyPL1+J1GrBWkpwiZMrb/LxQzYLbjd8amO7TedE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=iOYhuolmDrpDMi8DESaZSPILqmUGv4xlmzuhj3fAKEihvM5S3pr4RlMZR2G9YIw80
	 0Lqbk46CgfI7I0s3nIGWiHg/9VMR2WTnjUBg4aKmm9cX1TBITOKWrCWOudOJuz59FI
	 zMdFQEqFy6cTdjhZBOcnkFT0WksaPi24GUIYiidU=
X-QQ-mid: zesmtpgz3t1780283242t05aa13f7
X-QQ-Originating-IP: YRCbA7bqRKH6wAc7eU+oyoXj0OqwQdNppr3PyW5KP6M=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 11:07:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17389882740423473155
EX-QQ-RecipientCnt: 17
From: Shijia Hu <hushijia1@uniontech.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	kees@kernel.org
Cc: paul@paul-moore.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	kernel@uniontech.com,
	Shijia Hu <hushijia1@uniontech.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>
Subject: [PATCH] fork: Ensure copy_process() returns a valid error pointer on failure
Date: Mon,  1 Jun 2026 11:06:49 +0800
Message-Id: <20260601030649.2513937-1-hushijia1@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Mutteg8H72qDCQX/Hl1ykzF6t2LTCtRZBPGXwJEdobHtvkNqUgyOXt0g
	wEAO/c5hG5SAZgq49k+ndUo58+480+tGkFT5WLwqpVjwD1JichFtSmknyGsJU18T9FQjKSX
	HOHTfCwln3+kJEIff1KUiMuVXeBW7Ksg66Uo7Kle9OC3OV3WmrEROPL5JKEEwVGeiCw7naD
	kkiPoBZ+Lpsgbi1BjXrtVkba1Mrf8OQ9ASK6dgNltj8qST/IFpGfyVWOyd5/BmBRxk72XtF
	r0OhshlLB6eZca7sIpqNqWR7LqSjDMcWNr7jhC9p8T56vfAltOwmg0cAYCXNgZTljbY04d0
	yMTUNFf20YQJ9LGKN//k0z3qlDxNgTdu+EG0QemaU4sGyRbrYmCY0rYJ+8bEQXDo7TI0mi1
	eqcDro50Z5Qs/1vn6ifd1AecLj2MIMBRGKbiZjgARYn3aOX2lKjkhbQMqG039dTti7ZN0Cf
	Oz8B68NTJB1Ts4iUItuQzaggtyBeeNpku9rYPDWL2VHJrQyxjewYDBQb7IOMwUT86aGyG7B
	lFNDT4esYr2BbvD1LcUg3kHW9hmg2gtbKIiYWHew6jus+57cjq+9i8tIb8LM4ItPzdNiTNL
	PHmpO3FRt+onVEgfrS/ifL1F0Fbq9R/aU7MSQ7Ql//vAFFclei+Xjp8bcJmMvAYi/hFujrx
	WhO1N6lXca4C2QgkcukJwHO/WEYPN3Xq/BmzyulhVkJIwhfOIpA89+j8loxmBjE8APdPOOu
	0YjaH5A/mxg3gcMaK90m8sL9iEfr93uu6jz3CWer/b57dNSzJ6v7VAcj99fAoCweLCO55Um
	QZZDBaLd+9W52k4smQ2+wt2vxvPDFthkg3b13A4wwbbI3Vh0ULDHUorDK2BU2ehiS38eTIN
	V1Jz/gDy0PnBUAosjW5MLw3wEaE5D/emUu7XkYNEB9SmwlI6cV0acXmAQ7iV3fAjGRGQK5b
	K06hyctPExH/qfdtladvZ/AF9TM383GP8EgV9eRftIf8iIunb9n5XQFvkmoAVEz9p3Tt8hk
	m3F/71sGCjLCtVzZJh
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

copy_process() returns ERR_PTR(retval) from its error path, so retval
must be a negative errno in the range [-MAX_ERRNO, -1]. Values outside
that range produce a pointer which is not caught by IS_ERR() in
kernel_clone().

This can be triggered by attaching a BPF_MODIFY_RETURN program to
security_task_alloc() and returning an invalid value. copy_process()
treats the non-zero return as a failure, but ERR_PTR(1) or
ERR_PTR(-MAX_ERRNO - 1) does not produce an error pointer recognized by
IS_ERR(). kernel_clone() may then dereference the returned pointer.

Normalize unexpected values before returning ERR_PTR() from the
copy_process() error path. This keeps the fix local to the fork error
handling contract and does not change BPF_MODIFY_RETURN verifier behavior.

Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/973a1b7b-8ee7-407a-890a-11455d9cc5bf@std.uestc.edu.cn/
Link: https://lore.kernel.org/all/20260411163556.8567-1-yangfeng59949@163.com/
Cc: stable@vger.kernel.org
Signed-off-by: Shijia Hu <hushijia1@uniontech.com>
---
 kernel/fork.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8ac38beae360..40bfbdfffbdc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2599,6 +2599,13 @@ __latent_entropy struct task_struct *copy_process(
 	spin_lock_irq(&current->sighand->siglock);
 	hlist_del_init(&delayed.node);
 	spin_unlock_irq(&current->sighand->siglock);
+	/*
+	 * The error path returns ERR_PTR(retval), which requires retval to be a
+	 * negative errno in the range [-MAX_ERRNO, -1]. Normalize unexpected
+	 * values to avoid returning non-error pointers to callers.
+	 */
+	if (unlikely(retval >= 0 || retval < -MAX_ERRNO))
+		retval = -EINVAL;
 	return ERR_PTR(retval);
 }
 
-- 
2.20.1

