Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125490;
	b=YsT6YLX8eGis0OQPrPCbHKqjKKVCYrRfyzZIumFTto/AKJxHeeG9pbb+P6AS7tYLskwB
	 Xu98GGES7FABD9V5j8GhMSlBwdy38Z7VZFs/6Rs6YzTn3DDk3e61LWktOj5yqHaGRXgOa
	 9/SwsQButZi5pzIc8rDdbt6s2WbXjF29CCPycB9+9X8EEjloT9OFaovDp27Z+zAVgTXn3
	 4HdFZWKgh2EKAhJjEfGNOezajLU5+cLwP8O52k+oOyehwe5SmAOe+YRXjgx9iTKPU24F7
	 blqDT8w6eqnfS2b7/wjmt05C855o5hz/VICKjWWGVlRFyWxBZGMnZnJxacPBqQGQ2lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125490;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=tY6nmCEm7LWidLMHD82naIlgb2AoTUYVSLqe4CK8OvQ=;
	b=k/oHEjYhqnreXJrfDSPTnOxXvpvwTl11LIsGSXAVnY5cQZqfHbwj/93IO/DSoJsuxR1U
	 Y4ZXVULwXejrQyRYlHYzNbwsCiCUul+J73EZorMVJ+9pEhnRjD1w+ye5iyhO19nQ5/J7n
	 aHEtD1XAyDhCNiPxHvzdcNregkIz9XdBmVx+RVWM77CXA4Q2Rs0g7WZ1NpO0XU7L178tR
	 N68mpbdDZg095wjrh33v3tdObP4I9/ziae0DwEfFVzdSHy3QkQ2LQmRo5v/w3rcJg/k0q
	 eR5Exifcw7la0aH/Z42xYa5Wmfo3e5PhNBPVO4a7uMYdWmhcXjUWkUjuZV4Si2YXHfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=MuLj7P2C;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30DD606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C30DD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=MuLj7P2C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tY6nmCEm7LWidLMHD82naIlgb2AoTUYVSLqe4CK8OvQ=; b=MuLj7P2CZz60XGHcClSUh49j12
	R/MtSPepZ7ooaMYuG1JtrYXx6Rg67ReDTKYY8xSFAeOordrK2DJqb4aYayPC6XEom3kwt4Qc3ATy1
	XQ76hhlGq0UPgRdi1j1qkd10/ei3t4xvh7P+UhXDO95COCENatYuu9TLkG/6uH3FXhWVWC7p5bVvQ
	xMg1vE0Kr2Gn+5cNXbyIS0JCUPLpUfQIh+RP4g7GZ8u1xYu44KstmwJYj4eabiXCcd6N0aOviEYg4
	tT3jN+flgV7Cbs1rnQOpsQ01NQVSKLQ5gG/6srBLNQIU/BTTDi7nRAirtiOwc7A01EUyqrvjX+OSU
	PTIP9Lbg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqp-000IiW-2P;
	Tue, 27 Oct 2026 19:24:47 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 02/21] bpf, arm64: Free the private stack when a pass over the image fails
Date: Tue, 27 Oct 2026 19:24:26 +0100
Message-ID: <20261027182445.1156335-3-daniel@iogearbox.net>
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
index bcad1ed87467..febe072a8af2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2528,6 +2528,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
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

