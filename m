Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D631715F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763932; cv=none; b=FKuvGiKMYehHpWdX0JdlaHRQw5ZLHBggHK+PLAa3IfmOyWz/sVX/r3338i2gqWHW2hljNWqNgQeL8T/TJ8T2ZiWLquvsHWqlUveDTFlApTBEcHHsXNVpHPFUBufVJxCkBUrIQyRFKTQA6E2cYsaQ7/ZQ7+PS2Kqti+9tPut9nrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763932; c=relaxed/simple;
	bh=o9wMTxhYiDKmflOFYsWj2G5+KhuWu2fGjh/QrAEnzwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3pLU6wV0Tv3KY5h3eRJKjtl+S8Ed3V2Fpz49VJbDoBRJuh7jDx32B8fgNH5MPkLd5Yjdp7FEZHLTITL8R4ygUYh8VQp/Ei3Zgtm/smGh06WwwDzJidafezT+GW2f7vPEECd21gyXwExxNqJVXl0l0BQwra4DXEZKWAf6pTJPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=TEbOSmrq; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="TEbOSmrq"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c30aabe8dso914955d50.3
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 19:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1779763928; x=1780368728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naGseeLsZOt5/A5Mc1MGjXdOC/ihUE1Cs3gNHn6WygY=;
        b=TEbOSmrqKq3smUDcMdEMyNVgqupAbh3DDq0dAoGy9owBXUAEFgnpDhtzgn5FbS062k
         Ks+Ha2gHno4vvvrvN1o2Fwle9wjNrpSOasnJ6UVdCeMtV3dNDNqrs3BpYn9oqvpmKaZ3
         PY3MJ+ItyQ+Z+miQU6l3S3HFbDklKhxRVoh/6CjB/QA0boj4eFh19/k4pPZW7AI877BJ
         RvCwnXWzkO8FG5ZvKLwk04dxb3LX+CRk7ifKP28TIXv/BuW8G5RNzgB5yRTRoMkhYkoY
         XquAleCLQ8+Hods1tjYaHw/tALUfDRh1MCb8QwWjlCskWWQKH69foWgSDGtHWCKXwBeT
         DlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779763928; x=1780368728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naGseeLsZOt5/A5Mc1MGjXdOC/ihUE1Cs3gNHn6WygY=;
        b=c2mffpJuCbFmnymUs3Rkiz+YdtAdJpGGu0jZKSfO7Jz6sXKW+6GA1DaFlOr2GpwbJs
         OkUMJ+qVgBoRAgU1/JzUjtFpTRTEW2y4jJC2akZ2nVJR4N8qq5ufntb5SMtgrFQKzGEg
         D26vyeJXOf+Y8nBDJkSMTIUyh8IZg2NrIwasIrkIeUUeXvdLK4GRrTYjmBRPzuGSLioU
         EgzPEMr07kGe15HbrTzJQvNjIGaw8+F2pfN5IKaJT/2o4tuAKG5y5yooMwXVVKLwRN7b
         B9huAjAV8VfE5shnYLog3Bw5HHV+h0LemVfsEdq4K6hP/X341Zs49dEuGbh4jJJ47C35
         HLxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kG/ieUf2sEdZlUbHidUJ8t2ZwHvn43EES6WhVdpke5Sxsm/BAz/+P7ABzQ/jHHHGqYe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBdJ0l80ZSb/0FX28uWXufq1oiAXI8SksPAthQ1q9nfwIKG2x
	ZLvDx1hsz6Q0KAGyq9oc2cCXJLjv3V4+IJL+eJMymlmnmmqTOVDdnUDJwWa0Dksec4U7
X-Gm-Gg: Acq92OH6yUl3Sbp6XVOhQfriKdKjl0WwKXKRErxMfdU8UHd/e8MheJwaM4BNPy89gnG
	4yGYWoH/fB9RX9XaAq+zFy0gjsjIQcXivl7zug87lvw8N5tp4LzCTfeKcBJOiw6Zqnjy/mt9fLG
	6fDH1FjsK87Smj8nBGWV+KWCTkGYiY9M8DDicqVrsrJV9FAx8fwbCDDph1Tttv5C+rds6zsB+bC
	uvn59ElbGbGs4cTkstvjQ+ce4DTtjLCeRO4Afuca2FlZBsU4ipL5tEtN2XzQ0ztk4EWOrPQJNih
	zpflK1EJwzOsllHV7FLERj5ikxqkwzg5zBx2npiFNPHSYXP0y+6AZU+fvDRnDe14eWtk8LwLlz/
	eALzuz1tPofQ40Kyqzsy5Sa8QTy6h14SuIg1hBiTonGjtwHRnWIDAIuNGbdVJLp36rvhEydgoys
	ngnCzhUrX/+YCrL7tToOC+M5xxwKM2rIg9uqpF2dEeqCZ7J4kDlMfGAa3d/bTx7Ri5UnqdgwEGr
	oYVrJaRcL6tVPE=
X-Received: by 2002:a05:690c:f:b0:79a:8e00:a5bf with SMTP id 00721157ae682-7d3373a7a95mr124613927b3.1.1779763928408;
        Mon, 25 May 2026 19:52:08 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c33c935sm54938797b3.36.2026.05.25.19.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:52:07 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Date: Mon, 25 May 2026 22:51:54 -0400
Message-ID: <20260526025154.60607-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kTLS TX path can hand an open record to a sk_msg verdict
program before encryption.  If the verdict applies fewer bytes
than the open record contains, tls_push_record() splits
ctx->open_rec into the record being encrypted and a remainder.
The synchronous path reattaches that remainder before continuing.

With an async AEAD provider, crypto_aead_encrypt() can return
-EINPROGRESS after ctx->open_rec has been unhooked but before the
split remainder is reattached.  The remainder is no longer
reachable through ctx->open_rec or ctx->tx_list, silently dropping
transmitted data and leaking the unreachable tls_rec.  The same
composition also entangles the user-page zerocopy lifetime rules
with an async completion path.

A sockmap cannot be attached to a socket after an inet ULP is
installed: sk_psock_init() returns -EINVAL when
inet_csk_has_ulp() is true.  So the supported ordering for
sockmap + kTLS TX is sockmap first, TLS_TX setup second.  When
TLS_TX setup sees an existing sk_psock, allocate the AEAD with
CRYPTO_ALG_ASYNC masked out and latch the TX zerocopy gate
(sw_ctx_tx->async_capable) so the buggy composition becomes
structurally unreachable.  Ordinary kTLS sockets without sk_msg
BPF attached are unaffected and continue to use async-capable
providers.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4-7
---

Changes since v2 [1]:
- Per netdev maintainer guidance [2], replace the Option-C
  drain-on-error fix with a setup-time surface narrowing in
  tls_set_sw_offload(): when a sockmap is already attached at
  TLS_TX setup, request a synchronous AEAD (CRYPTO_ALG_ASYNC in
  the allocation mask) and set sw_ctx_tx->async_capable = 1.
  Both moves are needed: latching async_capable alone disables
  zerocopy but tls_do_encryption() can still return -EINPROGRESS
  on the copy path; selecting a sync provider removes that return
  path for sk_msg-attached sockets.
- Drop the selftest from the series per Jakub's note that the
  existing sockmap + TLS coverage at
  tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c exercises
  this configuration [3].  That suite covers sockmap + kTLS
  policy paths broadly; the specific async-pcrypt pass-then-drop
  failure mode from the v2 reproducer was validated for v3 on
  QEMU/KVM with a KASAN+LOCKDEP-instrumented kernel against net
  base 2156a29aecff before send.
- Single-patch series.

Changes since v1:
- v1's remainder-rooting fix was incomplete; Sashiko AI review
  surfaced a real UAF in the v2 follow-up that John Fastabend
  endorsed on the v1 thread [4].  The surface-narrowing approach
  in v3 makes both failure modes unreachable by avoiding the
  async + sk_msg composition entirely rather than patching each
  continuation point.

[1] https://lore.kernel.org/all/20260521025840.976378-1-clusk@northecho.dev/
[2] https://lore.kernel.org/all/20260525133028.58494274@kernel.org/
[3] https://lore.kernel.org/all/20260525133048.2dc6d8d3@kernel.org/
[4] https://lore.kernel.org/all/huduxtn6parzgiaf5cyiyrrvjjvx6jsdedowvrd4nkwmuyeind@j6migjgofh2i/

 net/tls/tls_sw.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268..0000000 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2867,7 +2867,20 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);

 	if (!*aead) {
-		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
+		u32 mask = 0;
+
+		if (tx) {
+			struct sk_psock *psock;
+
+			psock = sk_psock_get(sk);
+			if (psock) {
+				mask = CRYPTO_ALG_ASYNC;
+				sw_ctx_tx->async_capable = 1;
+				sk_psock_put(sk, psock);
+			}
+		}
+
+		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, mask);
 		if (IS_ERR(*aead)) {
 			rc = PTR_ERR(*aead);
 			*aead = NULL;
--
2.54.0
