Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0213D55D
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891539; cv=none; b=NjzlFZnquAX44KKOC+86CGVX2yopObEcUOkPgoy3bLRChr1YY7eqIETf77U9D2DSFj10Jw0XEpTnxZuDWl8uq76VFfUr7VP06nBA4Qu/TDLyaxWb9WZW5I4kLw4jNY9G4ox1sxhn6gyjGKH68COWIIWT87nY9oC3rTwC90Ldrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891539; c=relaxed/simple;
	bh=mf2ZhWe2RRahjZYrU49w/SaqHtRinykhLJXwudXGcqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyDyYJ0rTZTDpxlCroLKjI5qyKbbWUNQiUgmLwPh9gcfcqTzkykiLSbUt7gdxShIOtmynzPWXzunJVtkt17GDgrIjne6m4c4kzE+gphfT2DfhXIvuXeqPBGl9vVQ0tUK64AzMuacgVs//EzhzP8vJdPwNJdDKZHTNW9gXbhb2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPKc9M0n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPKc9M0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55476C433F1;
	Tue, 19 Mar 2024 23:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710891538;
	bh=mf2ZhWe2RRahjZYrU49w/SaqHtRinykhLJXwudXGcqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPKc9M0nAZXZknYb1+uSO9Xk5x94Kh6lV3WXk36Y9qD6Ocb1Q00hEXQ/rMLGvAWET
	 5sw1cXr0WjAh2vzoOJiL7pSVWh7nm8gEyqhDpAwmkbL5ZrmHwDQnyEhF0dQAWhKiln
	 xLFk1ae0xFQCcngfDpwc1LpKgUCaTHYrXcAWhdOaCM7QcZMW9nz3mqRP2CJwzLbmM9
	 ikEW/eTiV6Dpp3CPQSAlo8kz7iKvN8YgYiDHakkyhaGUPRWGpY4jAzmhxV2/SuFh5E
	 V6PaP9HJ6WcSY5Z193oR/wgjYilJpOYDl0mviBecstpZc6I91gCDeAzdlpk2/pTXgO
	 iafHzCjkLSNPA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v3 bpf-next 1/5] bpf: flatten bpf_probe_register call chain
Date: Tue, 19 Mar 2024 16:38:48 -0700
Message-ID: <20240319233852.1977493-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319233852.1977493-1-andrii@kernel.org>
References: <20240319233852.1977493-1-andrii@kernel.org>
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

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1b041911b1d8..30ecf62f8a17 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2425,7 +2425,7 @@ BPF_TRACE_DEFN_x(10);
 BPF_TRACE_DEFN_x(11);
 BPF_TRACE_DEFN_x(12);
 
-static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
+int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 {
 	struct tracepoint *tp = btp->tp;
 
@@ -2443,11 +2443,6 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
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

