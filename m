Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708866;
	b=r+8OId1xxzgm/Hm4Lw048ndDQVzxosLvrkfuD18jo1wMlVs/tSBo+J9jD3tqV4N3RKyW
	 VcQMykBhpJYLaYsl2Yab8RBvXp15cbEyo1ehSx0wM8yFHrWrETXldPyl//N9NFUisQ+tF
	 qtbFstMYLD+jk5UH8JrH7phXo4jCmwc5/5hLtt5i1JExbx5kJ/7EvCJ4Apchw2oe7Dlz8
	 uAiIlrbsx0awHM4P6btze/a9Rq4q36HBEABEdAIsuAp5Wm4HbrI7AyP0foh+WrGyHQJ0X
	 r87aNuKruR6Z+fCDmteonXzZUGbpQ/5in02HTy1EzF82n+VK/oDuOV3v9RucYACOFsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=sBhJv9zw0NUil/U71/qnen5M36PLAt4rlTpZclyqZe0=;
	b=mHgvnkbzf4Z73Ok2G84+D8z1Cfd0htSqRczlTjSRrh6Rvh1mk2/azLEC211Ufu3t8LIV
	 ENwH+e8VA3PREvO195imvcJ+sxm42034FlzdW6XWvB+IX7uc9jYcQxJ3RVmiLw78edjqR
	 N744oyWfSBZTZgPr6VxhmlO6J9MRAftLmTZS5vkJ2qLzkccMvC2OhwPNg+H7zgJH9PyUp
	 r1afecjXvBUbj0PEoh2eg8HzEKnHychRwUAh4StJIrTVgXE2qwkyL6foI/6VMK7Biylit
	 wqF7YCK+ZRCNukZqfbe552AABOtLyfuyyiHgPO8+luNj5BtKO8W4KobXpj8Npn97jiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=LygpZag8;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FF606A33F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C95FF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=LygpZag8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sBhJv9zw0NUil/U71/qnen5M36PLAt4rlTpZclyqZe0=; b=LygpZag8KeW00q9IOk+o1C0eF+
	K8GCcB2UoLw4hlLNZ8ViHrfAS32RGC10RDSu4IMW0ndoNl9Ie6ZRNiz3EwFEr7JQZWvrWIeGNmOVV
	GDXD0M7V55MQ+Yd/FL03okX+6K35Y2gSwTtTtB/30NRO8NcM3pyBXK29UpEalJs/+/eOvO2OKU62r
	WUn++CzxYOdvo65Dr4vwnXNskgBDLbU6L4EWWZe6tknau2fXpXQP6xDVxrhamOLsIhlHXXaTWFxrn
	luzfz0FaXR+VbOz3fxqlC0VaH/CRXSdNeFP8q3FXQrpPR/AoSH8cnls9zYg06k8QgA82I8Xt1dUgm
	DeBDVzjw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODby-000MQ9-39;
	Tue, 03 Nov 2026 13:27:35 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 01/20] bpf, arm64: Free the offset table of a subprog in bpf_jit_free
Date: Tue,  3 Nov 2026 13:27:14 +0100
Message-ID: <20261103122733.1383002-2-daniel@iogearbox.net>
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
index e99f105b7f61..19c986440235 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3580,6 +3580,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 */
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
+			kvfree(jit_data->ctx.offset);
 			kfree(jit_data);
 		}
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
-- 
2.43.0

