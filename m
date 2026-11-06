Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995060;
	b=qdJMK0sx1qEw5EiP2fRWJZVHIMdg3GE/PPKwKnYyGBJ8nibRJv7O9M5kslf17gNOcLz2
	 aDkR8aNkDSPWBjXChbOAwe0OeITHQ2SZNRXBHMQr2LICozU80+HdUz5J5kZN98sJ0lMRg
	 mjLnCCazAZE8AfNJlHvWXG7q+bS3UKD0V248nljxATg5v0TZmQePvSRrzd/qynxbKY3zF
	 pv6d6DmppXqkkdN3KXAQwt+8bCWbfa1CVYESxQJ+yCF8vKtiHV8qmfB51UQkXmZ1xlaNr
	 F+BvU6SD2f8cZfpPPnTavizhm3+Q6NEr+P/4yGzajuEZ+kQ55hYI8T15Lpf8h/5igOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995060;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MulVyDbnCUc8YyE5iCVGhXbTjVuL+662xwOchhs5a5c=;
	b=2zZcHbj8d7QEn5qxe0zxx3yS+dKjnzhe8eH9Fnv28F4BYaSyL109x0Om71mZo1XIBxr3
	 I0VYPZcVXpLb53Ng+FLVofb6L9P2rx/YEi47wK8MeNrWYlvZSEuacqmPi20EYviKWfSMc
	 7I2ujRjF1+XUj76vnBGuxuWTYNJZC9S+SRDuNOQDNbyU/Bi4yAzP1ZW4WNQxKZ7iQCpqx
	 riZle004lRtxOB+LE2QZU/9zG4iAeAxfIY9KBdW9JI6VcyXTc6WnRnuP82N3wblA9m/ix
	 RVkml8EnLMkp/3/KDRlgBl7Uh3GQByF1wH7yfvYs/sZR8YfT7WS6+Rb/r5BEXoDKheA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NobdK2O1;
	arc=none smtp.remote-ip=95.215.58.238
Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC8606A32E
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 19:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCCC8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NobdK2O1
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LsoXSHMCwcgc48OOvY1fDUb+VUa7Qt3/OfLtIE3Ovsw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793995056; v=1; x=1794599856;
 b=NobdK2O197g2ybBsKimzXn2lIVzzIAcDFcZR+J8rE9B9nUpPbwFZdM9tKnmFSW2YI5WZtLxe
 R6EhGfjk634yXUk27/B9ogjZDAA56v9dwr9HcGnN73rxq7+DGN9tZpEs9lg0QMo7joQlAbcmC/u
 r+SzeEkjuyWmDguutjijeZ9w=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 6e908634ec4cab24;
	Fri, 06 Nov 2026 19:57:36 +0000
X-Mizu-Trace-ID: 6e908634ec4cab24
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v1 1/3] Revert "libbpf: Fix use-after-free in btf__add_type"
Date: Fri,  6 Nov 2026 12:57:28 -0700
Message-ID: <20261106195730.2623973-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 9abe2c42ecab6c86b54838d2d645ca2e10204606.

The commit made btf_rewrite_str() make every base of the destination
modifiable before taking a pointer to the source string, because
looking the string up in a base made it modifiable and freed its raw
data. Since commit efeb5ab5753d ("libbpf: Look up BTF strings without
making BTF modifiable"), the lookup leaves the raw data in place, so
the pointer stays valid.

Making a base modifiable fails for BTF with unknown header-extension
bytes. With the loop in place, btf__add_type() and btf__add_btf() into
a split over such a base fail with -EOPNOTSUPP, and so does bpftool
when it merges module BTFs over it:

  $ bpftool -B base.btf btf dump file mod1.btf file mod2.btf format raw
  Error: failed to merge BTF from mod1.btf: Operation not supported

Suggested-by: BPF CI bot <bot+bpf-ci@kernel.org>
Link: https://lore.kernel.org/bpf/e0df4fa9e17514c79de41ee9fd2eb610d43a95741fb994db160b35fd488f054a@mail.kernel.org/
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/btf.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 0984a8ccb526..448ee6acf519 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2232,7 +2232,6 @@ struct btf_pipe {
 
 static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
 {
-	struct btf *base;
 	long mapped_off;
 	int off, err;
 
@@ -2245,19 +2244,6 @@ static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
 		return 0;
 	}
 
-	/*
-	 * btf__add_str() first looks the string up in the base BTFs of dst,
-	 * which makes each of them modifiable and frees its raw data. If src
-	 * shares a base with dst and the string lives in that base, the
-	 * pointer taken below would be left dangling. So make the bases
-	 * modifiable before the pointer is taken.
-	 */
-	for (base = p->dst->base_btf; base; base = base->base_btf) {
-		err = btf_ensure_modifiable(base);
-		if (err)
-			return err;
-	}
-
 	off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
 	if (off < 0)
 		return off;

base-commit: 3e18218484126afb9da722080659c038cb2256ab
-- 
2.56.0

