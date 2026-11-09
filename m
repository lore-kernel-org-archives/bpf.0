Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253657;
	b=s3ZK1XSVYLS6G7GmiFRyq/LdfgfkraRfitzo+qfPHjIUqSaiG6gkX5+c1EkHdoCI+sko
	 wJIYfso8f0QKgdx7VbnlPJfSmMIa5x7autbQnWYEs+BQOVZNkHAW0oxIDjBZ1dPUJFwRz
	 DWYUsT+AoU4ArEVWpOf37jwMe99TfiqslVsh/uKawRqkEOMqSiqArpvNnwJT5NCa14nQ0
	 +ekIvCFCPwnxxFwdvGZQhyP36BuZXLziCdlNyyRHnLWZkk2dh6cZLGWDPy9/yan+laL2B
	 C62+5wKAhCnfIEApDzTp986lCRFn90EGHKZ95FnMFY2KlM9hbmr1eLrl4mu5eMewFog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=hNVNAWptgfbriQBkfrSeZ85qymaCAPIKTSal75Fkq+k=;
	b=sUZIQ+A1KKhetD8JPH+v+VnDuIyTXqFUVMV0y0BMLNAyLUmfP41dc7+kAosB6Yp/7Apu
	 YqmnVi27LZFtm3R3NQJWBnRY6T87weV1LbkzB7mO7BV0L3xouHXzpc0Zj79agUxk+KG5Z
	 iYRMK3xXjH4GB3fwh7lgE5wHqzxdgId/20cB8SJ5BYB5hxPjT67Tz5v8oNpnneATPROTT
	 9etUVgLnY/YJArupteTC9LWNyW4UVlMCVRe4+XVBADogOQnmK1eNncqOb5+tnw1qII9SZ
	 LqNgc0gE19dZZK8mZI9vk2QcNlfgsfcufJNwx1IJ8eZCt9Dh3XvxZ67KUvQPADMuOcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GG4aqbmG;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384B606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9384B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GG4aqbmG
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b76ade741cso5347775e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253656; x=1794858456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNVNAWptgfbriQBkfrSeZ85qymaCAPIKTSal75Fkq+k=;
        b=GG4aqbmGvnTkNQ4pqm5aGvnsHjZvEk+hNXTe6g+pg3G7TTI3GnBOWIlLnj6Ze1bTQw
         t/3BPAiKohyjFdhW4o61xd/Fmz5dEVCyf0sJ6yTPEc8IV0rCl6LfubqgOnJ4Pm2btaHK
         cZDlpjIgPMYmzmixonMFBjeMxhy5jhGSWsoRBPE6jiJx12C1s+Fiqw98soclJVqbPrJ8
         4Wu6BLXT8YZyjSbC6sJsP0pAHAT+bNlBAs5uFSfb6yOk0ciVQhCQdu1+tM/N/4miRzSM
         w7DzfivFd2LhTNMyn4VoRJP/Zgda7RZ9kgAMRryKzfr2p01QzUOw2DsoKKYUb/fcuHuH
         4qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253656; x=1794858456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hNVNAWptgfbriQBkfrSeZ85qymaCAPIKTSal75Fkq+k=;
        b=Wa/45ZZQf8dosi9FhibId+pLByGWBtGQjZPgiKxJMIUm62Qhf/yd18Nft8my1idcif
         IlCmBOJZniCXOp/mUoQm9J5kwlSx5YRgWRjiToKTbvd9yaZ5pFSxRVEGU+73CR6ei6fL
         HIUqIJY9K8x5GSmv0CyB1ICcqWdXnZRL93yHGGsAtyx8tqNKzMnMdRYw51XoIptGjaYw
         KLH9cCpt577S96OfglfetxZLXvJyJMeZ02KUfb0aSuPBe3A2lXkZ4N4RJnadSPIL9Ndv
         ZmDARJnAKjtNfoAWC7qgc4aU1j23Y8jhDwXgj6xXtGbBoyayrvpTMoskm7LSfy87cuQo
         L0Rw==
X-Gm-Message-State: APuU4Z/8YW0THFeAIMTUlHZrbVyjNwK8ZEFe59wIcEd7a5XSLdy2A64a
	0YgZ+3c3nG34/sEs655C7lS8I8UZkWAXx+Vz1YyAvJ+miUPI5BRokLCcIHblCZrS
X-Gm-Gg: AYBFou0a2xI1BEq7c4hqF/rLo4Nkc4mfDLpZiK0VuB8HsTpQhiUu3cXzV9g2hI4Us8A
	5dRE4hq5Sl9dO1kACQC+AD+I4Gs408rtGolZg9FaR4Lv7hqT0rFj6oqlVRm1Dmx4ZeCCK+jtwcr
	uah3itHS4AecBr+TASd5ygbAcL9L8UA2I461FvpW2YZPw8nyum0Jxtj7rPzFHzwwIb3tOoi4BRX
	KFjmAbgay1CpmQ0VgsuEqeRA4A7CfQqw1paZjNHXQ3iM33Zl+MT5bntA2Ktr4BUZkiv7G4VH2V0
	km6b7B5Vv8LNLH1XIAPAK83WqHAgW0rzqDwpbzCpZ6phhLxP9L8+Ugly4d27aCmpdxjWbQ2caO0
	Idd6mCf8ho56EgS4Nmr267yd+enncWLdyPvMcy70yCZkBfnvZ7I0cnr8HpjgI5BSW56/YyTpEEa
	Bo0oVXLA+uzQdkPNzrngcZIS32T4B1bXlGMtiPMNWyrePKPn4dxWtpJfW8slGLwKozXezMiEbr1
	PSwWJCf7oy3bm6LPbXVuWyD71QxQBTJMsP+ZqkwOKMUwhyvbWefFFbpO32VGKYLQweIXziCJmcl
	97w6a8uupZ1DSDoN/4pXckYapbr5Sjp0e/mSPxme3CPjPx+SXqawYlSWaWufckTfRIjjk/HdJ3I
	iTvDq752GLYDJY4WJnsVmdxcsS5xPz+37sqUZiWpecawIEBp7ySSbqSKfjtYJBb5teKcq5NzAMZ
	SC9RTooI/uPIYhoQ==
X-Received: by 2002:a05:600c:4752:b0:4a5:87a:50ba with SMTP id 5b1f17b1804b1-4ba0235ba4amr4134735e9.33.1794253655668;
        Mon, 09 Nov 2026 11:47:35 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm17307135e9.11.2026.11.09.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:47:35 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/6] libbpf: Honor zero consume bounds
Date: Mon,  9 Nov 2026 20:47:27 +0100
Message-ID: <ad4631a937789da25e988e093c66d40e98b41806.1794253561.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794253561.git.memxor@gmail.com>
References: <cover.1794253561.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=memxor@gmail.com; h=from:subject:message-id; bh=pu6Hz3RMX9EFGIHlRBvAFT51voXfEQiY7xrQWVuHyLY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuT0q/skqJfM99YXmtg8c/xOaNdKVNVGHFP7PnHnekPh JobjBs7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBGHXkaG75Jd2g0Oh/p15jH+ 5de4cej30ZsayW8PXUg98kVsptK5/Qz/XVLOf/6x4X263SMti4fO/cw8fwpu/YqK2DFVdPE3o82 ijAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tamir Duberstein <tamird@kernel.org>

ringbuf_process_ring() checks the record bound only after advancing the
consumer position and invoking the callback. A zero bound therefore
consumes the first available record.

Return before reading the ring positions when the bound is zero so
ring_buffer__consume_n() and ring__consume_n() leave all records queued.

Fixes: 4d22ea94ea33 ("libbpf: Add ring__consume_n / ring_buffer__consume_n")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/ringbuf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index c8fe57401a8b..6e88ac209298 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -240,6 +240,9 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	bool got_new_data;
 	void *sample;
 
+	if (n == 0)
+		return 0;
+
 	cons_pos = smp_load_acquire(r->consumer_pos);
 	do {
 		got_new_data = false;
-- 
2.53.0

