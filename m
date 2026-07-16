Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149322F90C9;
	Thu, 16 Jul 2026 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172871; cv=none; b=N7lIsAK8nxRIWBqH6c0QlXwDzUxrRNJ++cLZ9bht4USsrQp58Wwql6YFInPwH8AflC3/FlxJw/da/FE9svfdycxwMi0WHp5wlzU1HmeY/5yLQqScKF1HKipXavqGCazVLdQWLAGnUGX2d1kZhumKOalLXaVfd4YE6y4pcji//eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172871; c=relaxed/simple;
	bh=FBCMdJM1jeN4KH4oPQcPWGErjrIz0YNM6wQ+NO2wTLs=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=p46ggdFrDmD7pkT+9W+mFW4YR/fgt9xE0dbxqI7I0C0YhM7N/Y+UZW1b5tcEF/+LcOFPYST1GpQlKYUMnU8331qorJCEOuaQaR0SuAewWZs1lKLczMW+XOZqLqson6ZZ54ttxnUfHyIZcSFTc/C9lAlU8ABvTrgAMxXXWU18lFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4h0zDc5q9Kz4xNtg;
	Thu, 16 Jul 2026 11:34:24 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 66G3YIip041199;
	Thu, 16 Jul 2026 11:34:18 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 16 Jul 2026 11:34:19 +0800 (CST)
X-Zmail-TransId: 2afb6a58513b03a-bdbe9
X-Mailer: Zmail v1.0
Message-ID: <20260716113419588y6Ycmo7pzva8buwne9yWZ@zte.com.cn>
Date: Thu, 16 Jul 2026 11:34:19 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: <xu.xin16@zte.com.cn>, <xu.xin@linux.dev>
Subject: =?UTF-8?B?W1BBVENIIGJwZi1uZXh0XSBicGY6c3lzY2FsbDogTG9nIGVycm9yIGNvZGUgb24gdHJhbXBvbGluZSB1bmxpbmsgZmFpbHVyZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66G3YIip041199
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 16 Jul 2026 11:34:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A585140.000/4h0zDc5q9Kz4xNtg

From: xu xin <xu.xin16@zte.com.cn>

Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
code from bpf_trampoline_unlink_prog(). This aids debugging of race
conditions during link teardown, while keeping the warning rate limited
to avoid log flooding.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 kernel/bpf/syscall.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b47..2348dc33abf4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3626,10 +3626,13 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 {
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
+	int err;

-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
-						tr_link->trampoline,
-						tr_link->tgt_prog));
+	err = bpf_trampoline_unlink_prog(&tr_link->link.node,
+					tr_link->trampoline,
+					tr_link->tgt_prog);
+	if (err)
+		WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);

 	bpf_trampoline_put(tr_link->trampoline);

-- 
2.25.1
