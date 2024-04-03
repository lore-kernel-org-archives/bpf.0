Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE2155A46;
	Wed,  3 Apr 2024 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181815; cv=none; b=a6sw7oE931HfPAmFNEjz003+pzydFW+zFq152LGz2fwVYeT8H375DK8gLd9dq9imqHChWQwRRVm5FwK47g2yydSUvEHZ/+PsU9NXuOiCLJZPHq6JiPShnSNPrnr5iMbZfCj7SZyaJx+Mi2ZN3hAQmGnsiOnviHScICMqYWIpy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181815; c=relaxed/simple;
	bh=n3Q8pcct6u1puk940GRaHLodcqgH7KSOUMdJGkXoHcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFUHB+QDedFz02JG8804juvIBAJaAC0qX60jM/21aEA+8YR3lfyolDGVsXzJcOx51YpqBsYkrgFFsgjoJga5csXPknzRJga/6qfWV/+ptrnn8Rs7PmMS/xBLFqry3F7zZG1GX0P5IDusPAC5EkCqcaL1WmpWfRtIyaLGBw0yV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMiZaEW9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMiZaEW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4529BC433F1;
	Wed,  3 Apr 2024 22:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712181815;
	bh=n3Q8pcct6u1puk940GRaHLodcqgH7KSOUMdJGkXoHcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMiZaEW9if+NKbiFuyVUgKfHehLr0akVWn5G0Wc0cDWVBeHQVAv2ZU05VYO8gZzC7
	 vYj8GNMipIJgdyjEwwQqdaHEQD3G71HoVNxurc5DoXuiBP70m1bmzj/fIfxbzALX0z
	 OvJkS9qblmGRYB9PNMMQNG93P73oNRE75ywCTq15fDVKJI5mrs4ie2EY6AjqJL8jMt
	 u0zow5tL9IcITwRzLgfsEWYC8tZWXo4yY6XcXrd4UQP4MLnlqCo4sqUlzzj6pTPKRC
	 6jZlc7SHN+EOyc6dVmCHrVbBo2EhuCn39mAtP3TPKYGom/RuzW3cBYtWY6eeP0YOgC
	 RBNczoDnlMKjA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 2/2] rethook: honor CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING in rethook_try_get()
Date: Wed,  3 Apr 2024 15:03:28 -0700
Message-ID: <20240403220328.455786-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403220328.455786-1-andrii@kernel.org>
References: <20240403220328.455786-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take into account CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING when validating
that RCU is watching when trying to setup rethooko on a function entry.

This further (in addition to improvements in the previous patch)
improves BPF multi-kretprobe (which rely on rethook) runtime throughput
by 2.3%, according to BPF benchmarks ([0]).

  [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/rethook.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index fa03094e9e69..15b8aa4048d9 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -166,6 +166,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	if (unlikely(!handler))
 		return NULL;
 
+#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
 	/*
 	 * This expects the caller will set up a rethook on a function entry.
 	 * When the function returns, the rethook will eventually be reclaimed
@@ -174,6 +175,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	 */
 	if (unlikely(!rcu_is_watching()))
 		return NULL;
+#endif
 
 	return (struct rethook_node *)objpool_pop(&rh->pool);
 }
-- 
2.43.0

