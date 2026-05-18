Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC302C158A
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116183; cv=none; b=JX2XePa+/Sv5t9BWZuApAYjmCzQQXDX6cArPY+pr09XjeGZ+OfupZ0yHElEqns3IBr2VPhHFfXUeFhr6peT4n4kis565OLS2j0sKG0WlQprssHNqgU/PjJXUkDCinEg6x/qJKxLF+gRmdA6XoiqT8E5df2SBz5KC2688TKIOO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116183; c=relaxed/simple;
	bh=d12FHVGA8hv5Fy901cw7hrsXXwWJys4dKS7YeItZkuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgPrLi8qHhf3slV6c2jNXfC/Chdb+BEyFA9MrUIMzgNYE0LQjekbPlZftrKRSkzAflNPytBNmsxE9JoOnfB3RtDc8CTa+lJzwLFKJ/jXBwYyZVjyELwCr4Vs9TooO6axWf3HjhptaSo9tVVzn4P1ne3w8/BKEivOMSkCXm68DRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OktUflEI; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OktUflEI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779116175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MdM+gON6cwas8DfDd9lHSjt1u4dRrEGGU3GktE4vic=;
	b=OktUflEIfivkW4XKnUDQRF2r+VraTIn8Ccblj4+2ZZeF0kiLp9aoqQkwtfKZxgVYQtWcvu
	DZUoqdyCohok5kQ8U162Q24duLJUiGd0X8YDAQVHQpV8NfPiY11R0bbqElpxXIFz9AqvXg
	dzXNOeC0J+MtR2Mlgwt46n745UR/jC0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in map_create()
Date: Mon, 18 May 2026 22:54:43 +0800
Message-ID: <20260518145446.6794-3-leon.hwang@linux.dev>
In-Reply-To: <20260518145446.6794-1-leon.hwang@linux.dev>
References: <20260518145446.6794-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because there is time gap between bpf_map_new_fd() and close_fd(), a
concurrent thread is able to close the new fd and opens a new, unrelated
file with the exact same fd number. Thereafter, this close_fd() might
inadvertently close the unrelated file.

To avoid such regression, drop close_fd() and override err when failed to
create map and failed to finalize the log.

In other word, when succeed in creating map but fail to finalize log,
users will get the map fd instead of the finalization error.

Fixes: 49f9b2b2a18c ("bpf: Add syscall common attributes support for map_create")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83de8fb9b9aa..322865a88b3a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1647,11 +1647,18 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_at
 
 	/* preserve original error even if log finalization is successful */
 	ret = bpf_log_attr_finalize(&attr_log, log);
-	if (ret) {
-		if (err >= 0)
-			close_fd(err);
+	if (ret && err < 0)
+		/*
+		 * Failed to finalize the log.
+		 * Should not close_fd(err) here. Since the bpf_map_new_fd()
+		 * has published the map fd, if a concurrent thread closes the
+		 * fd, then opens new, unrelated file that receives the exact
+		 * same fd number, close_fd(err) might inadvertently close the
+		 * unrelated file.
+		 * As a trade-off, override the err only when failed to finalize
+		 * the log and failed to create map.
+		 */
 		err = ret;
-	}
 
 	kfree(log);
 	return err;
-- 
2.54.0

