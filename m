Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34433352F84
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658640; cv=none; b=j+9IEn/obF6j3JNGI0HvX1U+nCpkovFsyGOeu8rN4zpVncQtaJBUqnHJ25Y3b1ZQhLheRfle490Yz6mRh1PYqwCEC7xZNYc1YazB1OlaAdagz3rG744yD961EamRvZlsNCahhP3Q0H2H7ZcSqgIQUIjnAzOdZl/II/BgVawZc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658640; c=relaxed/simple;
	bh=jtLB/czrRZ77D0/tt10ovpVdSgEst5eGeIq/HIdlg3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjnEMEUfJLv/7MVf0oWkDM8bMeYv3+MsyJZvzaKJzI2SB9ucKaqzwd8wfyF7ur+Jx7IcODWOu+gBqjaI/ljnJRpBosSOP9MGCcux8GrMl29GDyImyZtcE0j8m8KOrfp9YHZ9uejSQ+iw7Qrx80gC1K2gx74W70/pwDY7ptwpJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lw9Keiwv; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lw9Keiwv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769658626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2/Qs/X84F7xqVULHI40NbrGxxf+fCcySI+HtrrKnXho=;
	b=Lw9KeiwvPevGSEmicxuywrMDbeZB6Yw++8Iw2z7hTXv4HRbKT++i7fd0qktNzEVrD+p4zE
	T8dLoJOHcK9Bsy7Fy1UvhXDOBhAWzFI4AVUixU9uC6J8l5nj4GC/VhPejGAfEFkDpNi/NT
	MzgzM3e9ipworgrbd49lOyKRFcQqneM=
From: Hui Zhu <hui.zhu@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next] mm/bpf_memcontrol: Add missing newline in pr_warn message
Date: Thu, 29 Jan 2026 11:50:14 +0800
Message-ID: <20260129035014.3283392-1-hui.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add missing newline character at the end of pr_warn error message
in bpf_memcontrol_init() function. Kernel log messages should end
with a newline character for proper formatting in kernel logs.

This issue was pointed out in
https://github.com/kernel-patches/bpf/pull/10864#discussion_r2735018210

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 mm/bpf_memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..20999a29820b 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -186,7 +186,8 @@ static int __init bpf_memcontrol_init(void)
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					&bpf_memcontrol_kfunc_set);
 	if (err)
-		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
+		pr_warn("error while registering bpf memcontrol kfuncs: %d\n",
+			err);
 
 	return err;
 }
-- 
2.43.0

