Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76D212564;
	Fri, 16 Oct 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186620; cv=none; b=gvmiaQKP+KBBvqNfCNtma+GFOw5jRL5EOqH8k5SOolB5TSinT/8bdUZceMHel0rZl3OsyINhL0SCQAKJTryeyyMhgqz2tdOXpPi0BUxqpgCuzQFeyrLFZuQcH2kyt64pCd01RZiFbAu5I7U2+pJ5331D0g7U9H4DZnsG0pnaAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186620; c=relaxed/simple;
	bh=6VNmyRu5TSfOZALvL3r4rdGQzkZWCVjcxSFsflalNDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbTjWhUpnEeE1skH06PoqvDuIbeFAbFBvyXBMHLX50m7NqmZd7WjbBsnJdJUB13126ZYdB+MCRxyVMoCWjxhxN3ffZQiMvVMYUhtKqX2lqcxdEiBZBQras7Kj3aCTc3BpLR9q1Ro829KxhDDtWKN4dwfsmUdHuCH8i10H68gGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=wOxgVDVR; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="wOxgVDVR"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xHpC3-00Cshy-9V; Fri, 16 Oct 2026 23:10:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ZddAGYbDrtSr+CZdnQE/HLJuPzfHd++uOjWgRuABxX0=; b=wOxgVDVRPEWPWMpWDJRwvub+Xd
	d7D2km+a5dJhOLGYzDt5qC2S9xwzMnPRDBXMSLlGRMESjT5Lg3Z3hcDLt20N4ZDsi6/+WHp9MhOoc
	5tQEo0oCr8AKa20wQCnsTcyzEeDThzHSzTMOrJ2Z9KjTOEEzMnN/OKvPxPpLsHqHobX2wVoGkbiFq
	uQI4aW2FjO8KgHWjcjFGC0ZQDiXhvPEOOY8F1vv/HbEmxjFBtsIP4gPYvXXX46BXqbG2qFJsuxYmz
	1ezNHs0VPKECuc9kw4/ew3b/2gPKeDUPPS3wgNsFLAcBCCNn6pUgOpRObYxAyjGpbxWoIfZkaB3O6
	PVGIrpvw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xHpC1-0003aO-SN; Fri, 16 Oct 2026 23:10:21 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xHpBn-00G3o2-Kw;
	Fri, 16 Oct 2026 23:10:07 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 16 Oct 2026 23:09:13 +0200
Subject: [PATCH bpf-next 1/3] selftests/bpf: Remove sockmap update from
 bpf_iter_unix
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-sockmap-update-limit-iter-v1-1-23fa946db59e@rbox.co>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
In-Reply-To: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Lorenz Bauer <lmb@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

BPF iterator programs that can update sockmaps will be limited to
iter/sockmap. Remove the update from the unix selftest.

This reverts commit 997b8483d44c ("selftests/bpf: Extend bpf_iter_unix to
attempt deadlocking").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
index 3061b148f338..90beada0386d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -7,13 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-SEC(".maps") struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} sockmap;
-
 static long sock_i_ino(const struct sock *sk)
 {
 	const struct socket *sk_socket = sk->sk_socket;
@@ -82,8 +75,5 @@ int dump_unix(struct bpf_iter__unix *ctx)
 
 	BPF_SEQ_PRINTF(seq, "\n");
 
-	/* Test for deadlock. */
-	bpf_map_update_elem(&sockmap, &(int){0}, sk, 0);
-
 	return 0;
 }

-- 
2.56.0

