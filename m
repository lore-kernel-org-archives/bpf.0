Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C2122065
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787243; cv=none; b=BYAZzSyvx6XhCaoDzn30/SCpQ3NrTleOET1bvgykofvhCtusW2CeZSfKUgAP7OLYhOnKfdkyUdOa6qas5hPC8/Mb6gTTG/ZaWt/t9UJ96krPgREshN1CbMu7WKa84gOA40EkvHZ0nbYOFgCmg+tp3yZlbN9P3Y5YesEIwIla7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787243; c=relaxed/simple;
	bh=JHpeHtEVdSDGnLUj4D66AFo8fEXo+9uOmVdQ0Q0qY3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6NWhuLP97iQjmqz+HobhenYLc0ccvlc+nNDnPKlpFeAPIsEJ7lNrmqyzUCKrUYt3Kzfel93nQzz2S0oeDEq3P2iP9TI0913ZEyhb9T08xN/zVZfOckQ7yOygVwvcTEB8Zjuv15JcyZxvznjO4EBAkq5lMjGcCJYH5zZ5is5HdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQAYPHlU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQAYPHlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A59BC433A6;
	Mon, 18 Mar 2024 18:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710787242;
	bh=JHpeHtEVdSDGnLUj4D66AFo8fEXo+9uOmVdQ0Q0qY3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQAYPHlU7u/TtKtITtrlWfuXLULA4h6lAgsDKE/DwYPkvmO2UDtc+YG3R0ngNfpbW
	 aNmRIpAYujtl9/dnFTwpslH5NhgMFWRfc7WKyH+PjCNLl9HLtSbn59dHAbL6e11tTg
	 u/Djup1RxslGx+fiQxWVcJfThqP71w+TibkakrwlX9M3qqE0oHJJk8omJTzCYeW6Rf
	 4AErdhAMU1SbH4mtM87hwhcI/AqrAzPuoquUpNIgsM7+wERxymOLQcT5t44jtLYbWL
	 MdExtXyINyK0uBy3cvhcFc5GmgoLcxab2g0OeqJvBCmp0Uw+Ld5Ld1Ixbwl/ICnduO
	 oPaadORhHfSZw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 1/5] bpf: flatten bpf_probe_register call chain
Date: Mon, 18 Mar 2024 11:40:33 -0700
Message-ID: <20240318184037.3209242-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318184037.3209242-1-andrii@kernel.org>
References: <20240318184037.3209242-1-andrii@kernel.org>
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

