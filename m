Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166033;
	b=aBLDLZBvK6V0JO70wipw8kJ2D/EkkYYh4tYzmt2ZYudfdUAnlbxGQKOxFMacsoxFuP2z
	 uhX3Ec7yiPP/TyPpaEr9ScDmttkZG0Jy8/HdwMllPBUW8cJhQV3l5bz4Sn6JyEWZNXC08
	 dV8pQLsyy8dej/gyWZSp9LlP/bCoCrimZeDqJ+Q7X0wEX+dR8vAzZnT+AFayjDSzEmIES
	 6x5iaZj3PDiXk/RvnOVwcfgz3cCO9o3bgbC8OyeNZt+Kq4CRUvKDrDFuPoC/m8Xn8eb1U
	 dF/0/HEk4eLkBlE/PIuVRkBgOw/Rvgx9eN+bf5zKhk3CyPfhCTMSGGv9wbWq1m91+2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166033;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=lKpouXIO9b4QNV2BsslimI4O8D9UNFgyx4UUhqpvaHI=;
	b=29HKze132NpkZ15B41CmVdS9eivT9au7aOrWgYhLdTWFAAi+h452T7rx00e88Re1Sd4D
	 grLOdxNHrj9Rcg6AunbaWOf2FSKY/J/72cTwkcq3Te0m/M7ZR9m49lAKuHiBhsIRXMXmQ
	 slo7t2ldUoIrkpSN9NJEi41eTS8Ak5+csQVlw+S3UbZnE9+DcAkIlknfJxuQAj5jeNQNZ
	 1AFct7YoKjyxbiNjtU8GtPOkaOPkCBfQORl6EkNFy6g2FFpysVmgASe90SoOU6q03iK4k
	 5acRge35XHW5nYtsfDaNFYuHfrSTbS5wulqyk/500UrO2X0JygRktFMaASqd4rTJbKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=bNzdB+ro;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C29606A323
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65C29606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=bNzdB+ro
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lKpouXIO9b4QNV2BsslimI4O8D9UNFgyx4UUhqpvaHI=; b=bNzdB+rovBnbWAleJAPI2vVOLA
	HHM2qLhrVGbvGr99ni/8gUYNEu9b/CjkkhYny0R1jyVgORLDSeGggwmzQqw3ZTd5/iTptrL/7c1uX
	d8TLWEzGV42I1XhqpTOmlF7FyQEQV1zq7KFQkCCBcgn/50L0iiHWVC/AV86UGxyZrsFEGAyPHohsx
	5UvUzaybyWuXTSM0yowhnz8gRz4E05RQSDQApX0/vLFhI4Mv5+3w9z0VEGcbR1cmio9WMGfr4XgFw
	H3miq14FugX8+kUGtYFg/L/VrImCN+0KDM7OzS+j8tsbkZv1L7jg3OREOfNg4wxy0NCLnHZr7eg3i
	U4oU744Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Xm-000PgV-2t;
	Sun, 08 Nov 2026 20:27:11 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 03/24] bpf, arm64: Free the private stack when a pass over the image fails
Date: Sun,  8 Nov 2026 20:26:29 +0100
Message-ID: <bf4b96af4ba852c6ffd9c7db91ac0f0cb047116f.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

When a pass over the image fails, including the extra pass of a
subprog, the image is freed but ro_header is left set. The exit path
then skips freeing the private stack. It stays allocated behind
priv_stack_ptr, and bpf_jit_free() does not free it either, as the
program is not marked as JITed.

Clear ro_header and header once the image is freed, so that the exit
path frees the private stack as it does for failures before the image
was allocated. The x86 JIT does the same with its image pointer.

Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e72bf79d219c..976282418909 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2564,6 +2564,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
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

