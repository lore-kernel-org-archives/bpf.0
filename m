Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707028;
	b=z8yYAOn8bgD0CPB33NSHgwcJDWF1m9zLBKtY9apPs8Ubr+EHceguZkLND9fS9QN3PzOa
	 wEXrSVVDdu12onLBsELMkQbO+s9vsyna0pVNXLAxLoWe+nWHHJ8ywNK+98NAF69sBPYYO
	 mb+rPk/GCQnXv7uKtXadM/bKmYQx/sJfkFHQdtqmoyNu05vyiSdroWKJxjOiquvBSdRhC
	 127B3PbptsQhIDkfRhd6UvTnTdcrMh1kOhOzg/Wnz3rnyQUQPXrN285+1seX5uaMmW+9y
	 r7O66Yz8ZtGKoIzvM1w2ihJb27obMGGLnPYL1936h0jYsjzHGEkFEmCRd8a/R9h8b3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707028;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XKZ3x/rie7YxuparZp3FDLxAgZri1JZZJzg0hOQw4vo=;
	b=UkRrvgUD2JQC6tXP7dtOKgcyk6UpLygYWyqHjJAN2MC4tZGV0M23+1q3uSnBxsCqZErR
	 bthTQdFhMIImzNzOdYW9jl/baC+ivfVu4v/uBKMJlyZCryxD7KHtgioxqhE3N6dcl9WX4
	 53RXD4+dV41/uYEucOb3Ck9SIuWsAPP5EMllHIiQcxds3wJjyW6zBoExFElMykinOB20D
	 umEmehnWgSGqpfA96y1AzvoPJaI2NyT7LViZIRVUA+ptlmd//NwrNnuqKQzAtrEk7tPgt
	 3pcyty0LG4O4wBQz4loVrlcgD9sXhJrlPXhmsV+l1siVLIIlI9JWoyABVuy9wbExzIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jGaNPfbj;
	arc=none smtp.remote-ip=95.215.58.198
Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45677606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45677606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jGaNPfbj
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lu8CDYDhRtzNr4mWTlOAnFDoXf3YmniHydQtAwXqbPE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795707026; v=1; x=1796311826;
 b=jGaNPfbjnpr+26NO5g1rYHVotLgkjc3X/SiVOlWO3Pxux9fwVQiIiHjYyH8Jzh5/M/E+408S
 drGA5yBvnk1GynNvN5DRjmxuNjbDDVZ4xissHCbKKSelmra1TySp8SO+rVAjJMEkGPNmFRnzj7C
 GU9mJAUPQ5NcfzPB0SshpEOQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c568da8571219e0;
	Thu, 26 Nov 2026 15:30:25 +0000
X-Mizu-Trace-ID: 4c568da8571219e0
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH linux-6.12.y 3/4] bpf: Disallow interpreter fallback for arena-related insns
Date: Thu, 26 Nov 2026 15:30:01 +0000
Message-ID: <20261126153002.162337-4-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126153002.162337-1-leon.hwang@linux.dev>
References: <20261126153002.162337-1-leon.hwang@linux.dev>
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

[ Upstream commit 34746b5a84ec37c0ea2bf6808c65c5ed8790eb51 ]

Since the interpreter does not support the arena-related insns,
interpreter fallback should not be allowed for these insns in
core.c::__bpf_prog_select_runtime().

Currently, when the interpreter executes the arena ST/LDX/STX insns,
it would hit the BUG_ON() in ___bpf_prog_run() at run time.

[    2.579196] BPF interpreter: unknown opcode a2 (imm: 0x0)
[    2.579998] ------------[ cut here ]------------
[    2.580652] kernel BUG at kernel/bpf/core.c:2349!
[    2.581314] Oops: invalid opcode: 0000 [#1] SMP PTI

Set jit_required as true when arena map is used in the prog to disallow
interpreter fallback for arena-related insns.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/bpf/20260715141122.15783-2-leon.hwang@linux.dev
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
[edit]
  Apply the check_map_prog_compatibility() change in
  resolve_pseudo_ldimm64(), where this branch handles arena maps.
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 492355f69d26..ab6263a769d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19772,6 +19772,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 					return -EOPNOTSUPP;
 				}
 				env->prog->aux->arena = (void *)map;
+				env->prog->jit_required = true;
 				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
 					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
 					return -EINVAL;
-- 
2.55.0

