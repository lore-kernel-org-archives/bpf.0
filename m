Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE426E6F3;
	Sun, 14 Jun 2026 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401744; cv=none; b=FZQozTd1GNsklbk187t2UIpmU2PPwDlL/eGKqx8ca5XKH8vJtEg0B34ykkSN+RIFd4apt/jb74pNL35lOpP/9nX+yTsXLsb1aSUjLkDpW+souZbroFsaywisViGVhrHVlfBg5g/T+d2JN5uq1HWr5b/OMSLvvIvv1ZhLbsOTrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401744; c=relaxed/simple;
	bh=ild0iTxSm4VS5EwjCoCAWpgySpEcrcLmiLWVzBUlz6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVeJd3ugV77kVjhH58uIAlZGp48c0YOSg9n9DNu+Tup9yLJGO/lscjlVjhU9jDdcAiVu14NDrR1rGU3xhwSGQ0EtYq/nCQa3Xthj4WQi2pUyO3MIsqTRqQS0jqXfpNfxrEBF7dGhQKT1OH/aju8a5psixNiNioazTgUp4CwQ6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA6zF6Pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA6zF6Pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBAC1F000E9;
	Sun, 14 Jun 2026 01:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401743;
	bh=BC7V621uLpV43rs4Jsxzy0oM9i8RWW4+PZ721ooD5GE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DA6zF6Pp/QuECrKO2R8MAGbIkZeBn4rk9vYEz6e/h6sNut7YyoQvDZHKarVS3K6zj
	 Z2KdYeHFasQvGaBCVppknr9qtoMxviHsNqBo0RnvUYdbUXlRIj6oHRUCw5AGqSj6Ea
	 5WeKkFbw9wErd2P9mTMAbStfgsadTVeKib6oeMzTfFY6Pl14aH4cDKgIuVMYFAyA07
	 G7dTcoL6TAAa7GBWRJXffgoss4i5YgsyApFRkn8JmaFp8kQyNv4cnpoVtXhs11Fphs
	 ssFkWRDJQURQdLXFZcHe2D1TLBMVAbwETIz5ydd6gM1pDQBrZMOQeR41r2mSzrMceE
	 /JWUkB8OAEwXg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 13 Jun 2026 21:48:46 -0400
Subject: [PATCH bpf 3/6] libbpf: ringbuf: Handle position counter wrap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-bpf-ringbuf-fixes-v1-3-e623481cb724@kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=tamird@kernel.org;
 h=from:subject:message-id; bh=ild0iTxSm4VS5EwjCoCAWpgySpEcrcLmiLWVzBUlz6o=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFl6HG3GxqJxG/4d/bn1aO3cKTzls2bKG9/9Pyco4hbX7
 NLXCfI7OiayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEz1kkuMDH9d5B4/eSqlrrd6lWhiwwyxz19eGnyeXyH09+mhlSUsM78wMixoObd
 Ye2bC9XO9sjlBm860nPB58dmrivmazidWjcSdfSwA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Ring buffer positions are unsigned long counters and can wrap on 32-bit
systems. ringbuf_process_ring() stops consuming when producer_pos wraps
below consumer_pos because it compares the counters by magnitude.

Compare the positions for equality instead. The producer cannot move
logically behind the consumer in a non-overwrite ring.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Reported-by: Andrew Werner <awerner32@gmail.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index ae7fa79b6217..b7adce37b519 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -268,7 +268,7 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	do {
 		got_new_data = false;
 		prod_pos = smp_load_acquire(r->producer_pos);
-		while (cons_pos < prod_pos) {
+		while (cons_pos != prod_pos) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = smp_load_acquire(len_ptr);
 

-- 
2.55.0.rc0.96.gc050c23164

