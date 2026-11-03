Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708866;
	b=5WlOjeXC1IOpfXJlmo/t7KyLrMBDImVHCkblRvQP4edVjlGHgjWmyWUmTQ9UxOhQ1za7
	 XRL9FqlM3Rjzyim0tpoqTWGrlPo8Ic6cl8UsqC9VanPj+SlsiciZFPdaLCmeQ/U7toMnj
	 x9tCQ1yMxor/qbKvKVBMX+oPNqzVJ49zTSS+EPTouY/h31vAcHoM3WsOPcLdMSG6LLAio
	 LbEZJTD/Rm9b4JXzynocEPHily/z17p5k02T0u+VzXHhFUOH6wqEc5/up65NQ8c/nmnr7
	 ZHzxFY054aTVc2VcWKOMwmOJDGPVprapZ8hmGNLJXNXpoLxdf/o8tfpoihU5VuK1gbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=ocEWzCJLLk71mDT5qCXFczl0A5IHlB0oUhApx0ATmyg=;
	b=ojowNJsQYEq4PFNZ3VSGaNKA953X0DFHGb/uyJuP88T8Lwal6wZeCWo0dVihnIjzCHuD
	 0N0OWLS6q79I7SK45qrNlFgvSoSP8b9Ioo2I7goEvxbjpmFl1V9TMCZsO44iwukA4KlpI
	 KwpNFSeNbwpon9ClGcaLNFlOkBztb+RS+3GfmD5kLo+AHpMzYlHcQvdMJE6HFwrO2mQRG
	 BobQd5fOxXTMMQGUQxrD7iiJAl1hYI6NiV4mcDm2EUb5LeEsqDRe/f50jRyrM0SF3c8pz
	 i7v1EuIw4Z6GaQmURcbJfneNwwKN94CCs5U530NCgJNfBFlKKWDclUBkm8Fk9Ge1Ogg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=FpaiGObv;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A7606A330
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 609A7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=FpaiGObv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ocEWzCJLLk71mDT5qCXFczl0A5IHlB0oUhApx0ATmyg=; b=FpaiGObveXRV4SrEcTfurHr74s
	tZUxYTP9WWRlgqrhA4r4cg3zYG6De9uo6sQoHzOE0LRalq6WIxw3Q7OG1qj8YIyKZ34OvQHBjaaGT
	bjpM/MIndCYd3+Qwh41aRt2u4rdfEyj7Nsni1m0rvdIFPFhJyF8RXTbAhUWDAWOh29n8iRIldBr+b
	9ovkX1e4CIDD5lFKjrJ4EthLcFZ2jsHl8GffTF+D0leiCVbO9NP2OLU/cOuWr+MJgucz0oudjvVIt
	D0Yid7RgwSGctPn2A6oZx7tOlCx9Ovp0yh0XEORzPo3mhVvAHZOkfT32sJ//qcEI+JAm08QDBFAvb
	W0sayK7A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODbz-000MQH-2v;
	Tue, 03 Nov 2026 13:27:35 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 02/20] bpf, arm64: Free the private stack when a pass over the image fails
Date: Tue,  3 Nov 2026 13:27:15 +0100
Message-ID: <20261103122733.1383002-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

bpf_int_jit_compile() allocates the private stack of a program before
the sizing passes and frees it on the way out when ro_header is NULL,
which is only the case when the JIT fails before the image is
allocated, or when the pack finalize fails, which clears the pointer.
A failure in the passes over the image, or in the extra pass of a
subprog, frees the image but leaves ro_header set, so the private
stack stays allocated behind prog->aux->priv_stack_ptr of a program
that is not jited, which bpf_jit_free() then skips.

Clear ro_header and header once the image is freed, so that the exit
path frees the private stack as it does for a failure before the
allocation, like the x86 JIT does with its image pointer.

Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 19c986440235..27f0194ce0fd 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2539,6 +2539,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		bpf_arch_text_copy(&ro_header->size, &header->size,
 				   sizeof(header->size));
 		bpf_jit_binary_pack_free(ro_header, header);
+		/* The private stack goes with the image, see out_off */
+		ro_header = NULL;
+		header = NULL;
 	}
 	goto out_off;
 }
-- 
2.43.0

