Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166030;
	b=aBxeCTzTzK63xzmX1Hnl3VpchSNolDrr0hpNDiUafd60jZz5QoD3WA/H1FhPhKzo0nXZ
	 eVckUlqGbkLJnGhGnMFP27lpaFZk4GC7yOmE/F5dWGR3xz/Ms9NeQhPB03V4UeDhS7SF1
	 rXZabYl0fS4/CDSljVoAvbAf06RfnuqzcZd7WWd8GmflJ8ezqXOxsmqayvx1xw/xhC7gj
	 iFnRxMHrCN/mmMHXcTin44AqOCaTWaco3XZSYEkAx4rpa0bPEHdtImN2fWmvIni0vmM2j
	 QVcsJCqget/jKlt8Tcf7SdhViAemC4Vrlhb+YAb2HuLuPDsWcHOS5Uj1/n1qy2XE2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166030;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=193Rw+X6vjOVNKX1MlmXENqkNt2FJ7C90nJnedeDAaA=;
	b=rclkNgZsVxhnhnFHHpdrsEUre6zXY0zosyURbhpdtMZBpqFzgo3akFp7ButtK6/f7OkC
	 GUCPWDF4swBh0M9SRT1ogN/lArO/gSOE+1VtGCaUEC0qPxq0vK/qBojvisdFMWUsxEZu1
	 /dUAZNykxnhDy+V2SPFQM3lQMWfA4/NCNs2l52lUlKMKKs4i1oE7NtOJItdNYGAafK1pR
	 6eeQQsuo16X67aXoN+DdwYwjMafmthYLfkaNIJO2kuw/f5SH2qSNe/qC4kasSRbhPWNPh
	 TdjZrNF88u8l2W1awG8Q3X61JCAsovTOgscHCKelpvArQH9ujGE9x1hAcAzU9/qvsOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="e1eQ/xMp";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74911606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74911606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=e1eQ/xMp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=193Rw+X6vjOVNKX1MlmXENqkNt2FJ7C90nJnedeDAaA=; b=e1eQ/xMpQLkxqbUekc+RJHsRkM
	OSleDNdCz09n+VZJyfvyWw0K5NaGLs4x/sOrryXbTEoeI70AzceUqTvqZXy1jZXVBSY910hmLb2ML
	J+sQVZewYHlGMElYGbT/OKL0xOdKKsg5GrCObLFN5qwVvlEibigin9zgVnvSPtvrscsdWXCnAxbsA
	MgO4UQKifY/Ixg+enrU64sksV47N0wrDvqGc9tKLSIDeOAfpF/Ks58rkfk7QYnf7QftBfNJ4XU4De
	l9eFEZTDsBzCZo0dKka/z5t9hSwCrkCoLwKY6I1JVJgBirTeDijTnlRTUZOMw6T1UmpXzRr/ciYWI
	lVa8rsMA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Xh-000PfD-2X;
	Sun, 08 Nov 2026 20:27:06 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 02/24] bpf, arm64: Free the offset table of a subprog in bpf_jit_free
Date: Sun,  8 Nov 2026 20:26:28 +0100
Message-ID: <b507119f0ce8088f51fbfee5387efd7e3d483908.1794165614.git.daniel@iogearbox.net>
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

When jit_subprogs() fails after some subprogs were already JITed, it
frees them through bpf_jit_free(). That frees jit_data, but not the
offset table that jit_data keeps for the extra pass, so every such
failure leaks the table.

Free the offset table there as well, as the x86, riscv and LoongArch
JITs do.

Fixes: db496944fdaa ("bpf: arm64: add JIT support for multi-function programs")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 6deedb169915..e72bf79d219c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3616,6 +3616,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 */
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
+			kvfree(jit_data->ctx.offset);
 			kfree(jit_data);
 		}
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
-- 
2.43.0

