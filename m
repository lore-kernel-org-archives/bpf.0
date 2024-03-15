Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC117BAE
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535530; cv=none; b=jeLT9peOdHLjPdLBf5ivvTLmiclUd0teGgPeSktx7LkyRh7YaqA3YTcJBRsDFjG99rsvaNU3tcZBEQWyIrau357Jm2939Nw6br9yMbbk88G/02FaBmNQvVkvyEUuhMwFMeA+BvUEQZjiNSJNYPS2Ce/LF1H+4O9Ia41jzt87YOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535530; c=relaxed/simple;
	bh=e4lvcs2qKGSR8sAgBOu+FV8fxsA5w+osFeWkhXlycHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5CRXXONH6CWpfqDQeSKLoWEZOkQdT9unsKgBb+RpgT7Ma+gzqLnwjk7OXRV4yDlZk1ysLyYmoqg1qX4rVS8YrqSpX8DDhnUt2q+LEHX+woyc328tAdXwTs7yx7HpC4NANPbbGUh34xCR3jHgIyi6yuErFsVCjRF5l6QndMFYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AljUkQTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AljUkQTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DF3C433C7;
	Fri, 15 Mar 2024 20:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535530;
	bh=e4lvcs2qKGSR8sAgBOu+FV8fxsA5w+osFeWkhXlycHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AljUkQTrmPawiZCzag6UDfH2Fe4NkK2zdvAnpBlfUtWSbU+JiRDCEWd3oW0YuGRC2
	 Ddiz1WE1/tq4TM3/Uv88IiLzQMjoXi7Y2FtuedG9ouH0WkW+uvAO3M0/74qL3qYcbV
	 KE4Xh8CK8QpjkI/pPp4CaTgjLXqc1ecs1IQUe9nDYND9CETWnIwHwO29bFnr18emPa
	 pwBdDY4UNgBzhu8qB5Vr+VPt4Xt/o/b5lybDx+pPgFaeaAU2DbnkGZlqCR0NCxVnFy
	 Bch23dXBX+1bfln+b6tIUdZXOdEi+qmjzMkm7iVeQwDE5nTC5odHeSfX3OWZX9rfV4
	 9Dh6d8S5wuVFQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/5] bpf: flatten bpf_probe_register call chain
Date: Fri, 15 Mar 2024 13:45:20 -0700
Message-ID: <20240315204524.967664-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315204524.967664-1-andrii@kernel.org>
References: <20240315204524.967664-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_probe_register() and __bpf_probe_register() have identical
signatures and bpf_probe_register() just redirect to
__bpf_probe_register(). So get rid of this extra function call step to
simplify following the source code.

It has no difference at runtime due to inlining, of course.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0a5c4efc73c3..f29735bb7aed 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2429,7 +2429,7 @@ BPF_TRACE_DEFN_x(10);
 BPF_TRACE_DEFN_x(11);
 BPF_TRACE_DEFN_x(12);
 
-static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
+int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 {
 	struct tracepoint *tp = btp->tp;
 
@@ -2447,11 +2447,6 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
 						   prog);
 }
 
-int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
-{
-	return __bpf_probe_register(btp, prog);
-}
-
 int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 {
 	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
-- 
2.43.0

