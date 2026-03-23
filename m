Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A0383C64
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306384; cv=none; b=bNIOJ9vc/REA7Ge8/RkqjyU2B8Kyo6TLlrARagk3fxVAolH4fDfj9FFPyXlqeL/UU+hjFvdKb2l8d5as8KniYp4W05RE2EBdxWD0ldPnZ0SytzdKjonj3lbmwHEsvSiYqapzFvHUjJstLBrgBYht19IRSVDpr5CZodhT1hZiKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306384; c=relaxed/simple;
	bh=9hwFuFeafiCxNX2rf9FhnT9pc7zjaDB2weIabKgX7OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQffHwNTB58IurDb0KYhuFKZa+431km50kNl1hl20le4yoerrAFL2Qa+TOVsr8iEQgRQSCtJYK5eyzuE4kA4+hX5bmkiAJcdGhRjKWSbvWm/aTEW5CGYIhlvWi35AXnBjcT0gYLpj4ggpIc28KV1rxvXqnCkTIQ8YSvYvTzDAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=olggVphl; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="olggVphl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774306380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Awp8ntv1wXoCvwDEiN8wvX8nlownd7HDMmXlQU0i9yw=;
	b=olggVphlIokpcHuBYoGKv7Q7UZn4g3UFDrxK0/sYODAwmF4/JG9yk4fcoGk6vDfXvKX11+
	5EVAlo+G72nrmE3Rhv09qAwILSr9iQs2NzmfhQAeCLbHQxVSQxq4bs2Tub42BLlRNaarCw
	TZMoZmav/8Hkegopqr5SavnwxRGBGyU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
Date: Mon, 23 Mar 2026 15:52:50 -0700
Message-ID: <20260323225250.1623542-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

bpf_prog_test_run_skb() uses net->ipv6.ip6_null_entry for
BPF_PROG_TYPE_LWT_XMIT test runs.

It currently checks ipv6_bpf_stub before using ip6_null_entry.
ipv6_bpf_stub will be removed by the CONFIG_IPV6=m support removal
series posted at [1], so switch this check to ipv6_mod_enabled()
instead.

This change depends on that series [1]. Without it, CONFIG_IPV6=m is
still possible, and net->ipv6.ip6_null_entry remains NULL until
the IPv6 module is loaded.

[1] https://lore.kernel.org/netdev/20260320185649.5411-1-fmancera@suse.de/

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/bpf/test_run.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 56bc8dc1e281..fb25184ed03b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1157,15 +1157,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 
 	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
-		if (!ipv6_bpf_stub) {
-			pr_warn_once("Please test this program with the IPv6 module loaded\n");
+		if (!ipv6_mod_enabled()) {
+			pr_warn_once("Please test this program with IPv6 enabled kernel\n");
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
 #if IS_ENABLED(CONFIG_IPV6)
-		/* For CONFIG_IPV6=n, ipv6_bpf_stub is NULL which is
-		 * handled by the above if statement.
-		 */
 		dst_hold(&net->ipv6.ip6_null_entry->dst);
 		skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
 #endif
-- 
2.52.0

