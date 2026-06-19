Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB633149C7B;
	Fri, 19 Jun 2026 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828841; cv=none; b=dh4auvoXMp5193ufcAnG7C+45bR1W0UmCCGu6rautNZnj8SuHGafHT7v79TEuHOcUK56CprVkqkcSEVvp8pdGYcaJRWJ5cchS9G2KiAvmX8r2ayuzdW9GVWmsx7pQu37w8s8GLq/7VEUn+XYdqnbhyx/gRtsDByNXiBhlfw9qWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828841; c=relaxed/simple;
	bh=yUP/e3S1IasxSSC+l8MbmGByA6qKHvo0Payyw9pmHsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZyHGzsIG46YVAWFaDD6wCAKf9gjN2I8GT1g41aRdSwO4AhuzB9N4iQv37aGK+e2EyQ6vrBjF2MwMPdb9EeiC6FCL234dTDBFSZFJg18kXrxZ/3bCVDeikcCE02qiugR6luGu+4pnt+j9Cl76SsMBNDRZuENvIOQM9ca0qZ+fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdpvIn5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdpvIn5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3111F00A3A;
	Fri, 19 Jun 2026 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828840;
	bh=9gkWDD2gPdq1QfEMDU2X58H7vi83eZmunCXcycM/P2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YdpvIn5WO+Xduy60ynoSmWKMsB7lwPivWSf+I/HpHdohh/tTAuNyIYKvJrioT0VrP
	 Mi1A9m9wRBxK0javsT62OylNzZGMj2NGufpLnWz77+RB//4FAEY8y86TXhUn2Tf2P1
	 BNn4CP3M/7nN78Ch3kNBwmX1i964xpnOqjL1foACEiPx0BpiqmVsO8Mw1CpS7sFi4b
	 r8+bLAMN7krv7094jzTFheZprrEYSLb+0wNr+oDiEkgbzRnuU2rNNUERM9K2LhZx8X
	 QrAil9a/7SR3F62BTLwlw0LavSfA552NGH9LPLjgzWACYO3mKj+TpQfxII3hlw8y4D
	 /2jj862aLrr1Q==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 18 Jun 2026 20:26:43 -0400
Subject: [PATCH bpf v2 5/8] bpf: ringbuf: Handle pending position wrap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bpf-ringbuf-fixes-v2-5-33fde039ddf3@kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Tamir Duberstein <tamird@kernel.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=tamird@kernel.org;
 h=from:subject:message-id; bh=yUP/e3S1IasxSSC+l8MbmGByA6qKHvo0Payyw9pmHsY=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPdebz2lIZhltKkjnaujbfbR80pH5+TmiN3q8u13cV
 0iYHw3tmMjCIMbFYCmmyJIoemhveurtPbKZ747DzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjoGOsYMXJwCMNXd3YwMG+0rTmduOhLprLNokcSdXV/UVtnVrN6dElwSLfZ0R+eF+wy/mGrfLNx
 TY9PEse7hmQi12t9Rcaw9OtI/bvpV/6rf85qHCQA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Ring buffer positions are unsigned long counters and can wrap on 32-bit
systems. __bpf_ringbuf_reserve() stops advancing pending_pos after
producer_pos wraps because it compares the counters by magnitude.

Compare the positions for equality instead. The pending position cannot
logically move ahead of the producer position.

Fixes: cfa1a2329a69 ("bpf: Fix overrunning reservations in ringbuf")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/20260614020552.022A11F000E9@smtp.kernel.org/
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 kernel/bpf/ringbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 35ae64ade36b..909880031fd3 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -482,7 +482,8 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	prod_pos = rb->producer_pos;
 	new_prod_pos = prod_pos + len;
 
-	while (pend_pos < prod_pos) {
+	/* Positions wrap; pending_pos cannot logically pass producer_pos. */
+	while (pend_pos != prod_pos) {
 		hdr = (void *)rb->data + (pend_pos & rb->mask);
 		hdr_len = READ_ONCE(hdr->len);
 		if (hdr_len & BPF_RINGBUF_BUSY_BIT)

-- 
2.55.0.rc0.159.gbe5d7338c2

