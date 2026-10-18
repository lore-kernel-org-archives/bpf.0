Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7C3CFF79
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338801; cv=none; b=JuGIH6rXZdNqIgfwFlBn50B7FYW4mFfaDwD1JiE1xVPlGEP6jnAH+BXnNkuU0Od5wEt7YhGifKwSRzWImpGgXgEwmww4w2SHjMjvCxp+Mxsj7WSj60PTjlr5E80+PWUwF9z8EdKZtU0x7ny4NQq6jnKyQwFqqtMh7iPpZQECX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338801; c=relaxed/simple;
	bh=zNceYR6R8GGDn+3YVEowWazLXgZtJDU4P+7MLUo4JpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzirZSFuq/7QKVZJtbiObZ/KnRsx6Xo7pPO1Ba7r/Eul6jHb6nVQDDl+93xo22sBvSg52j8wwhs94Ib8Ct9n1UciqFqFbqu8TsB37F70VZz6raYl3nwcZ73dTgPjtf6mTLISjeczLUj+ZUpmHmhiOlr5/VRWG6mAmirR/Cn+LUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ifUiZXGS; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ifUiZXGS"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC6-001KCD-7J; Sun, 18 Oct 2026 17:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=jRboKxvlUefbj4z2+0WRdzGhr7Fy1gLY61mf41YU3JQ=; b=ifUiZXGSn4Z8bXrY166aZq9xeV
	WfZxUhgN7LJZ5O6oH+mQjWRJzS2sEAVW2rEx+MRz47eWS2+a3M2vZJPxbivM31DGcCHKLOTpoK9bg
	RQvz4P28loTv7+hSWd7c+vT6mxMrbFfWGqPpk3PmbChYZ54GcMjO3Ptx17404WzE7y+dzxzE+AdqQ
	oI57MKPLmC4h713uvP2mt9mBvtDr/TCjBUTRYp24QokUtCl3l1sOJN82S4vYQKa8D9YO7UpZoTWCf
	5E01KXUi25w07+CVU/4gQnpx/qpV1lrY2G91qbVFJDSnrK9fj15X5zRsc8Z0+/wyDqdZ0vm7VJTky
	TRFg54nw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC0-0000Bx-QX; Sun, 18 Oct 2026 17:53:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBe-004q3U-0Y;
	Sun, 18 Oct 2026 17:52:38 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 next 01/15] kallsyms: scripts/kallsyms.c: Avoid overrunning on-stack buffer
Date: Sun, 18 Oct 2026 16:51:52 +0100
Message-Id: <20261018155206.132411-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261018155206.132411-1-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A maximum length symbol can be KSYM_NAME_LEN long (including the '\0').
But the name being compressed contains a leading symbol type (e.g. T).
So when the compressed name is expanded (after the hex is written out)
the buffer needs to be KSYM_NAME_LEN+1 bytes long to allow to both the
symbol type and the '\0'.
But it is declared 'char buf[KSYM_NAME_LEN] so a maximal length name
overwrites something on stack.

Found by code inspection, seems to have been broken before the code
was imported into git.

I expect there aren't any maximal length symbols and/or the byte that
is overwritten is something that is either zero or 'don't care'.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 494852ade6d8..bda8921c95ef 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -341,7 +341,7 @@ static void write_src(void)
 	unsigned int i, k, off;
 	unsigned int best_idx[256];
 	unsigned int *markers, markers_cnt;
-	char buf[KSYM_NAME_LEN];
+	char buf[1 + KSYM_NAME_LEN];
 
 	printf("\t.section .rodata, \"a\"\n");
 
-- 
2.39.5

