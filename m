Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93E3002A9
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851180; cv=none; b=CiNDBiMEyogrDuOkStwukLrR5HYWDqFi1Z8YACSkP2jRy0EriWZ0uZ7SM60BGmvaMZioyJ6rrd/i1fD6UaAh0siWtWYY7zxHFILLsPKYqpuexp1kNIO3krT6PR3VOPCFDIGMTS7yj7hiQH0ebuMUEs3HJNfdF4i22a3hGzWiiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851180; c=relaxed/simple;
	bh=zTje3iRfCIkqaaWodKfNkDeaOdzIBf4NAD3PBzYsSHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc36LakUedKAtljkXZ0ncrQlEGcYZhrlvtOz+BMWgibL9TVZv3DcLFdStQQ2rUfXEeQVi6OIVRttGBcY2J4zteFBvMK9zU7+nSpk5i5Y0MQYXqMvBgY1+OxWPMephMPFce+Xo/TrueSKq6xipcXA0KZ4V13ZOi8+5+I4QL8k1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtZqtueM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtZqtueM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909831F000E9;
	Tue,  4 Aug 2026 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785851178;
	bh=GwRyF0L57u2ava0AJTHGsIYtgb+eQrabTle7UU36ED0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtZqtueM/SnG8SLSPgNoTJVgZCVLfYaubOSu1J66+mOcJ/UYWaVOufw/HiAecAD7s
	 YHeTj4xXgNsf2V+n4kRAONxiSWUf0jIYF9DjqzUNhCwdwcyvL4IsOgMNA21kImFM50
	 ZAUtIl9sA1zoZZdcSytp/sq42q/iV6S/GQaOxQN7dmGIsloziPkkevuZ6tcczuIDK6
	 yjkBbt/OUjDtvCyc5YApfyJh9kDVxZfq+Ac6NCDZfMwYk2lh0BQrt0+4rJEADYJpYU
	 WtmxmuhvWQlfF2aCqTb550SCd3szG1n8x03HWszTSYIlOyLSwjkKIVFUWwd+NnhYYm
	 zWPduepr321TQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v5 1/6] bpf: Correct the overflow check comment in bpf_iter_num_next()
Date: Tue,  4 Aug 2026 06:45:53 -0700
Message-ID: <20260804134601.2305303-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804134601.2305303-1-puranjay@kernel.org>
References: <20260804134601.2305303-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment on the s->cur + 1 >= s->end check claims the (s64) cast is
needed to avoid overflow when s->cur == s->end == INT_MAX. It isn't:
s->cur + 1 is computed in int and wraps before the cast, so the cast
changes nothing (INT_MAX + 1 compares the same either way).

The wraparound is the point. bpf_iter_num_new() sets s->cur = start - 1,
which wraps to INT_MAX for start == INT_MIN, and the wrapping s->cur + 1
brings it back to start. (s64)s->cur + 1 would instead break iterators
starting at INT_MIN.

Drop the cast and reword the comment. No functional change; the wrap is
well-defined under -fno-strict-overflow.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/bpf_iter.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index f5eaeb2493d4a..b235e117e206a 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -802,12 +802,11 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
 {
 	struct bpf_iter_num_kern *s = (void *)it;
 
-	/* check failed initialization or if we are done (same behavior);
-	 * need to be careful about overflow, so convert to s64 for checks,
-	 * e.g., if s->cur == s->end == INT_MAX, we can't just do
-	 * s->cur + 1 >= s->end
+	/*
+	 * s->cur < s->end while iterating, else s->cur == s->end == 0; the signed
+	 * s->cur + 1 >= s->end holds even when s->cur + 1 wraps (start == INT_MIN).
 	 */
-	if ((s64)(s->cur + 1) >= s->end) {
+	if (s->cur + 1 >= s->end) {
 		s->cur = s->end = 0;
 		return NULL;
 	}
-- 
2.53.0-Meta

