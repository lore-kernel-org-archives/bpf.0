Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34C3469F6
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072115; cv=none; b=XdrOLcPzhrOT/Uu4U7U7YFeHWLccxj+dRHFzsa65QaLd7kd0bKIqTMGeRcOtAiPdPiO7QaxdKbSdpLF3MMp5vN4w/dmuyDnHL8jce/GdVPcJR0yjsrsyhR2d7l1qxpTke710GhFlB4QgstqCzB55GnhNdCJqj4l1pmpPGlOHoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072115; c=relaxed/simple;
	bh=FrjDvBNdChIyyZFjgYOZ/V64Zy60YUEvAyAmitm45ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTKaKns+sLXnlBn1FqjZeh7dEG3tFNF32LBM+fytRYu+tXtPuJYH4E47shPrS2g2U8uPBYEGTM0rp4VPxpfMQLl0S1gOg2JXv5U1sbIpx7GEUm5gV/SwxJjRjIzkk+UUnN1zfo14yaguE9bjtMXaY0cDYjobqHoU6tO8dIV31sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BmDDkT+f; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BmDDkT+f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=gvQYM3CHMr4331PQJMo+eNKO5dQe81m7KRlGiOringc=; b=BmDDkT+fqShYgq/qS3PezhuC6/
	lh4bJ9RprPu3pi2TIaGgpaoa+CdqIvRAOsHwXtBEw3NtOPuwO+qFJVYDFAzx+Jhnj+ci2Y22C1KUD
	UdcUs+2TYU0wIJfF/81a3yxnPXeLof/xYIGk9fkp7gPVuJ18mDH7rB/jf+yF9EIhqLESADlFcMhfH
	hwevzKPzbi43lGVX7pkvy+cKf+xoSq35VROMKr5YyU0F8c0xj4BbucwhNsNp1orRsGzB/16jHdIYE
	LgyMZWHfQFIy1W3dgw+2AYlk5gxytPv68Hp4IuIAugROsffooTshyW7jOAdKc/2jqcEsPK1F0RDij
	F3d9gt6g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wT04U-000I2V-1M;
	Fri, 29 May 2026 18:28:30 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: sashiko <sashiko@sashiko.dev>
Subject: [PATCH bpf-next] libbpf: Skip endianness swap when loader generation failed
Date: Fri, 29 May 2026 18:28:29 +0200
Message-ID: <20260529162829.315921-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28015/Fri May 29 08:24:51 2026)

bpf_gen__prog_load() byte-swaps the program insns and the {func,line}_info
and CO-RE relo blobs in place for cross-endian targets. The blob offsets
come from add_data(), which returns 0 on failure: realloc_data_buf() either
frees and NULLs gen->data_start (realloc OOM) or returns early on an
already-latched gen->error, leaving a stale, possibly too-small buffer.

Neither bswap site checked for this. With gen->swapped_endian set and a
failed generation, "gen->data_start + off" becomes NULL + 0. Guard the
same way via !gen->error so they are skipped once generation has failed.

Fixes: 8ca3323dce43 ("libbpf: Support creating light skeleton of either endianness")
Reported-by: sashiko <sashiko@sashiko.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 [ Addressing https://lore.kernel.org/bpf/030307d2-f065-4434-b746-4ef5349f6190@iogearbox.net/ ]

 tools/lib/bpf/gen_loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index bcea21c3b7bb..fb4425cbffa3 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1054,7 +1054,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		 prog_idx, prog_type, insns_off, insn_cnt, license_off);
 
 	/* convert blob insns to target endianness */
-	if (gen->swapped_endian) {
+	if (gen->swapped_endian && !gen->error) {
 		struct bpf_insn *insn = gen->data_start + insns_off;
 		int i;
 
@@ -1092,7 +1092,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		 sizeof(struct bpf_core_relo));
 
 	/* convert all info blobs to target endianness */
-	if (gen->swapped_endian)
+	if (gen->swapped_endian && !gen->error)
 		info_blob_bswap(gen, func_info, line_info, core_relos, load_attr);
 
 	libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
-- 
2.43.0

