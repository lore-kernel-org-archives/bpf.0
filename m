Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFD3DA7C4;
	Wed,  1 Jul 2026 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948558; cv=none; b=GWt5m77hxJYPD1RBy80brUS13cjrFcLhuq02CCdokXWhcJTSsot65v/NlSULmWaSU0a6Quy9SaRhlnkgN31MxwG5LzDFE6esNfXMkXhYiR3+OVDx+ynxzn9R5OsgOtuipfK10xT4bKiqZ8W/g8WbN0XrBHef3EifgdDuGZmNXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948558; c=relaxed/simple;
	bh=68nog/yWG7CnzJhBQNjr76kwELBHhfJEkbThzQ5L6Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NY9unABkrHexhqi94rXraCYFvu9jQJjESjBRANuJalepBl8ljPYylbXlYRcgeYApbvgqCCM6nYBWrUkG0e8mDG3pK7wzUqd1rXG57xgQXsEHCdXA/ZvrH0DlxGIbLi944kYb7hIsrwunjAcDngPLGIzU1qLKdv2k5X9WRVyOZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Kd21nBnl; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Kd21nBnl"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wf4Me-007jy6-0d; Thu, 02 Jul 2026 01:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=MlIBowz2hjZvMC4jobVQ2h3VtaQHdZIYSQ5rZe6eF+w=; b=Kd21nBnlUAJIuJ0KLnIvhsIoC/
	HQcFDxoIE4UwmucEtfZmXQHfTfVY7gwIMBlciHdO6wzRHVkz7hdMozdEPTVcdrt+eQWwtwkcYov7/
	ROZveS/0Z6WGaK+TQNV2W45onNgJdI6INJ2XGXJNnWcjJKGCjv23aClGMCAUt73XfEgwGFDpcMo/6
	s1WOVhSU6netwCsTDi0vxglVHJJiUbxlNA/630drdczB0h9kiSFGH9LBEdYC4QYCAYxaVKTGnlmm8
	daUj+KMP74ng3aXP4tROBE3C9NOM1tP06jUCcD4lc17sLibRIBJRi2zUeQbTOXCruP6hWL1/fDdrO
	kCJSofNA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wf4MY-0005GF-BE; Thu, 02 Jul 2026 01:29:02 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wf4MS-00467f-F4;
	Thu, 02 Jul 2026 01:28:56 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 02 Jul 2026 01:28:22 +0200
Subject: [PATCH bpf v3 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sockmap-lookup-udp-leak-v3-4-ff8de8782468@rbox.co>
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15.2

sockmap now rejects unbound UDP sockets. Adjust test_maps. While at it,
check socket()'s return value.

This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
test_maps now that sockmap supports UDP").

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/test_maps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index c32da7bd8be2..6a2641ee7897 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -759,16 +759,15 @@ static void test_sockmap(unsigned int tasks, void *data)
 		goto out_sockmap;
 	}
 
-	/* Test update with unsupported UDP socket */
+	/* Test update with unsupported unbound UDP socket */
 	udp = socket(AF_INET, SOCK_DGRAM, 0);
-	i = 0;
-	err = bpf_map_update_elem(fd, &i, &udp, BPF_ANY);
-	if (err) {
-		printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
-		       i, udp);
+	CHECK(udp < 0, "socket(AF_INET, SOCK_DGRAM)", "errno:%d\n", errno);
+	err = bpf_map_update_elem(fd, &(int){0}, &udp, BPF_ANY);
+	close(udp);
+	if (!err) {
+		printf("Unexpectedly succeeded unbound UDP update '0:%i'\n", udp);
 		goto out_sockmap;
 	}
-	close(udp);
 
 	/* Test update without programs */
 	for (i = 0; i < 6; i++) {

-- 
2.54.0

