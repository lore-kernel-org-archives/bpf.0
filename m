Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661A3264DA
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407064; cv=none; b=CyIM3aGwEVz3C/p2/XRCHfcfywQ9LfRmLf40CIVAxXKv7/xH0vc6AiiGfhZcOogJ1/NimNZNjA+/60lh36ac29866qMf9S0f2QrF/5gbZEoQXoIKOwg8S3l0oZThFUYI+dhGC3/xoPKygqYSng0zzultobm2sfchURZlKGRaOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407064; c=relaxed/simple;
	bh=lr4WQBiD+ocaI3F2IYA4q+3tTDh38cx+KvBGYXye7XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0QZS1ffHjXEMaMvmNcyvKtoXdlzD5JfIucjiWEFyp5Os4RniSWl3d02teawM323TfLUp6nGCDiHB9cRvYMchXmnho3wz8b2NAPMxFjlbS2C5bkICDHoW84nNS1MGbD6wpe33OYRc8N+kjCnZN2flwvGymHX1V/bKN5HQBDfqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jA6QpLMd; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jA6QpLMd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BPpur+OBwTMSX0x4LFXGUxo6U1DhRYKICNyqiGy0HN0=; b=jA6QpLMdfd0dAtUtHFAFVxMGFq
	NvJAyCKNJ9x/eTYH01xg9NZR7qB6LINW4UAqJFqFK62SJj6tAS6Di2pOthKAUoNRIyuQBhmL3uIv1
	ASzHdoTAUyyPVq6e9NPqwNiFKEZr8CP+0GvhjdRiK1ghwu+pCbQX8QjYilN74x0TyFHtUx+uhH/TP
	7C4nI5dPIRoFABGSTbxC5qlKBes8VE+ZRuuWfIM+a/Ba8uvsaRINQaDzIirMdR0xMp9Ojxy8KTDob
	tgxF5V5p6z9DExrx0gjpknf+a8I8goGBnFHk/mwB/dbJBCO8ZmEUGuw9Xi39HhGgQdbGEKne0KYLd
	yrOl8uDA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUPCo-0007Ig-1n;
	Tue, 02 Jun 2026 15:30:54 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next 2/4] libbpf: Guard add_data() against size overflow
Date: Tue,  2 Jun 2026 15:30:50 +0200
Message-ID: <20260602133052.423725-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602133052.423725-1-daniel@iogearbox.net>
References: <20260602133052.423725-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28019/Tue Jun  2 08:33:27 2026)

add_data() computes size8 = roundup(size, 8) and then hands size8 to
realloc_data_buf() before doing memcpy(gen->data_cur, data, size) with
the original size. A wrapped size8 passes through the realloc_data_buf()
INT32_MAX check. Harden this against overflow, though not realistic to
happen in practice.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/gen_loader.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 66e13566bc31..d79695f01c87 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -160,10 +160,16 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
 {
-	__u32 size8 = roundup(size, 8);
 	__u64 zero = 0;
+	__u32 size8;
 	void *prev;
 
+	if (size > INT32_MAX) {
+		gen->error = -ERANGE;
+		return 0;
+	}
+	size8 = roundup(size, 8);
+
 	if (realloc_data_buf(gen, size8))
 		return 0;
 	prev = gen->data_cur;
-- 
2.43.0

