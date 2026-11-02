Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582299;
	b=HOZE5oGxMQ1LOvi3yYP44APNEMI7Bg5OS1aDkZ4XF4mzqvfs0b2ZcjfnP2JJabQkXj9R
	 s3BfnM0yselN6J4XufocNT1duDg0zzyfDfgp4mMWmDNdqcPy/0nsVOY9OqZUTwKn5YfbJ
	 hK3JF3kglS1OMVtGnvgA9IRrA5k09H6mKIqU8mo0iWainfYMT9AEsr0XnBE/NbR1Qh2oO
	 Qz1R8N345/ncBY/GRg1Q9a1BB29jTHd/DuNE2bKV4o2FZz3iY/cjTUZ3TEBompfq8qJYq
	 dTfk/5+XobN2+suSkUohCb6cdfnKCP55JIr5C0zh6E8T9KNzfoEAwcxSxWqh54VYHYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582299;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=rbwj2BbMS5rB566iN4dUhBo7kO74O70WXmYwllEg0Xs=;
	b=4MRH6YV+N4PVdin/Xri0FgDxqnCukJVl/S5q+biRt9vIeLjiAjMke3vnS9XJd7jkRXDP
	 8/ReS7uNg6C6NKl6PFimKSshCwOHoRytY72wHVWSZZhA63e9MEVQ5bHrCf25sfFdeC8SD
	 iATKO/RyxjaJUCHh/ObkUcnKH7iLXdF/vwrC+fwIcqP3tUpyTsgOi3ZyXOF37zrSjlBI3
	 LG3K6dIt/YdGRDWERV/ltzYGXgCt34cUGMCyBlbEL01Rq2D3pNbqg6hLnLJWsKWkUo5rL
	 mN4cINoXSbEAYXXLGVa9KlaNm3H7mvGIaWXptrIzubI/L9IRKmh3VjC4pp5XJyYwU8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=blmaReV9;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AD606A326;
	Mon,  2 Nov 2026 01:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 200AD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=blmaReV9
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNggX-00AGXm-L1; Mon, 02 Nov 2026 02:18:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=rbwj2BbMS5rB566iN4dUhBo7kO74O70WXmYwllEg0Xs=
	; b=blmaReV9R3LoYbYS+jyBeUNJglaGmgZVejk1JZ31pRceHmW7IZdW7U480EnLEHe2j7l6NhScW
	2mwqIn+JW103Di/hl9cxH0ZdkMqaFrKMv5LFh/WqNtr1IC8eh4nMM1CTIVg2ddTsp0u8C/bl+xFG/
	OhCSEkRlOMSdgua4ORAruJun7H/LYmn1GGdPvIP7NHDgAOEACezmMS0RkXKoZgPfETIb1vNLwdEFI
	fDJlSD+9VyuzUFQmRQVKOLhC0KaL3l2oTLgi5ToWpPx69ty9AMKkJlTbvHO0sysq1ghYQicJv6J4K
	TT+HfkUYiGKdDuew1DEDPb7mwUya6fTKmR+Fhw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNggS-0005sN-6G; Mon, 02 Nov 2026 02:18:00 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNggH-008JiF-QE;
	Mon, 02 Nov 2026 02:17:49 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH RFC v2 0/4] bpf, sockmap: Restrict iter-context sockmap
 updates to sockmap iterators
Date: Mon, 02 Nov 2026 02:15:57 +0100
Message-Id: <20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf4XM2pq2CIgrExM/wK1hUdpBR4WSt
 hAM4d/lsXd5b859jODREXo4RSM47MmTbWYhdxHop2oeyMjMGiSXqeD8yLzV71q1rGuNCsg+VFN
 gFNAxw2NUMqnyLEtgzrcOKxrW7jvcrhcoNtN35Qt1WFoX7Ek+WPddH/Rihbcxkf4Z6wXjTMaVy
 g+pKZMcz660w15bKKZp+gFG9Pzm1wAAAA==
X-Change-ID: 20261008-sockmap-update-limit-iter-d03ea25f9775
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Lorenz Bauer <lmb@cloudflare.com>, Eric Dumazet <edumazet@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

Follow-up to Sashiko's report [1] and the decision to restrict which
iterator may perform sockmap updates [2].

Short series: remove about-to-be-stale test, restrict updates, add a
negative test. Related bonus: mark bpf_iter__sockmap::sk as PTR_TRUSTED.

[1]: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
[2]: https://msgid.link/87echn2fhd.fsf@cloudflare.com

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Commit 7cc639dc45c5 ("bpf: Don't take an extension for an iterator
  program") and commit b83bacf2161d ("bpf: Don't take a program with a
  target program for an iterator") landed. Drop the redundant
  env->prog->type check.
- Mark bpf_iter__sockmap::sk as PTR_TRUSTED (Alexei)
- Link to v1: https://patch.msgid.link/20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co

To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Shuah Khan <shuah@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemb@google.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Michal Luczaj (4):
      selftests/bpf: Remove sockmap update from bpf_iter_unix
      bpf, sockmap: Restrict iter-context sockmap updates to iter/sockmap
      selftests/bpf: Add negative test for sockmap update from non-sockmap iter
      bpf: Mark bpf_iter__sockmap::sk as PTR_TRUSTED

 kernel/bpf/verifier.c                                      |  4 +++-
 net/core/sock_map.c                                        |  2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c          | 10 ----------
 .../testing/selftests/bpf/progs/verifier_sockmap_mutate.c  | 14 ++++++++++++++
 4 files changed, 18 insertions(+), 12 deletions(-)
---
base-commit: a30c772627b2ef4bc715332b1b04938a914556cd
change-id: 20261008-sockmap-update-limit-iter-d03ea25f9775

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

