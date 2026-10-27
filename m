Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125489;
	b=2KtVSYG5AnR05xva9NmbRG80UthuIzP2z3jHHdYQg0Yx48533iD2kY6jOqHHuU2sAZUm
	 di6WA6tRf6J23IvRkz0maDckhcFLsHpNA/vRLAVnp0ghlVAYkZB7yAsI7tuSTwF93FUZA
	 uiw4HNQjyO/Xvr0uQ4yyTU4RN+oATW0UPgLPJcg+vc8zQVmGuo5FnEF+/17wIUJOPiGKC
	 wJyixnyfZ3xHSSOMmmcyK6FaCtxTEQIJOM42xhIYhcqu3WdkKmUeE3xowKKaOsH+WYCNr
	 dXl1blMru/htZffVVMP5LSdBxWMe1tu43gn4T7WCu3y5dt6GffkQhQ0ybgWieuAhqXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125489;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=sHiQnBRvOZMx9u29sfKJkaeknqkb8GJIpf4gRbPNpYM=;
	b=BXvcQWMS/lRiqU9PN42BVr9rhb/AU2jXwlFTsTIVfz0mYU1m0OdmSnsWdZX+ftyUwQxd
	 yJcaPaYCzb0jaNU7mFfvmHa0vVJF+ifiMjlyc/r/lJOO0tts5nco8G39YHP3AxAiX4WFb
	 bf+bv7KZzoAuWHFg0m5v7Ve8E/G9RxtkCdF6fbihKxrLAD9QU+xi1j19GGFrXfN/k3Fnj
	 tE6H+XTrNfKaRhObDqjeE9EX8f6Bd1ergr30edH9Dfx0pEyKDv9+l5fz93SQN1uY2vCWL
	 IXtjEj4NCIIs3gFgnxuKEUEXt3VSc989MpmF3yhpp/Wuc4kIopcKoamj/aEe5vj5Akg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=idLEhcZ3;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77507606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77507606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=idLEhcZ3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sHiQnBRvOZMx9u29sfKJkaeknqkb8GJIpf4gRbPNpYM=; b=idLEhcZ33/Vvjt5QcS1LpFzwS5
	/3dKlIgAnNIG0hUqhEDxed1wb0Wq3d58UL+E2eNG5bnET7qj+3LiUWNQ1FZHt+O89W9MvDp7cJ/Sd
	VU9Tmofdr5sg8mUGUrOkv5Ok+I/RmxudSlIFszBiXrfe/sbO7C62ZI/ZkYb0izUPw+yGh0vpvzOcy
	l+VASSxe/DzkZudOwH1QW6FEYVKZ2yfySzXhq2CMoSTXhSH9dwNluUixLV/l4hlQNkPVNfN3zIcVo
	bTRgNbBi21lP146Pp7qIlKhmPJxe5TyUhjz9YSJJg+uly2t6mVZWtZ0UOvaZut1K612DkboRcNlgJ
	YdEC6OIQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqo-000IiC-2f;
	Tue, 27 Oct 2026 19:24:46 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 01/21] bpf, arm64: Free the offset table of a subprog in bpf_jit_free
Date: Tue, 27 Oct 2026 19:24:25 +0100
Message-ID: <20261027182445.1156335-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

bpf_int_jit_compile() keeps the context of a subprog after its first
run in jit_data, with the offset table, for the extra pass, which frees
both. When the JIT of a later subprog fails, jit_subprogs() frees the
subprogs JITed so far through bpf_jit_free(), which frees jit_data but
not the offset table in it, so every such failure leaks the table.

Free the offset table there as well, as the x86, riscv and LoongArch
JITs do.

Fixes: db496944fdaa ("bpf: arm64: add JIT support for multi-function programs")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index aaa34c739004..bcad1ed87467 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3569,6 +3569,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 */
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
+			kvfree(jit_data->ctx.offset);
 			kfree(jit_data);
 		}
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
-- 
2.43.0

