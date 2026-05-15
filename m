Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209B3CC320
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858175; cv=none; b=sQEroLj+bAd9OnFxAekpgdx7l+OzonH2JAEmC/Qi4THs8Bt6YWrB3JpOhWZJmKJQkCTEfDPve83rZtM/cE8y0lEE68TrR/EGIgtyfHQqHTfLJxLRnLs20jlkTQJGL5rQwhvmXOnbPZUGl2NBEWCtCaxwLztHuDe6lxv/H2oS8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858175; c=relaxed/simple;
	bh=j/JtzMkIpgce34VYyGskUNs64HhUE6kYkeklt0ZtZig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToipGHqnR++vZEET0eT3yyFOE809Z1CByPFLAwrMu79LtWsnMK/4b9waciUxLGX7q0wTNnXGhA/duktwae7k73C6GnNGpQUVhKZDlBGGXgKC37WDX9uKQG/1rNKsdiBCXCEKpyRAMMxZrsL+UoD88tb1G2mtmytj+X+rnBi56MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=lmHwvnil; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="lmHwvnil"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6543c251311so1123890d50.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1778858173; x=1779462973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3mh0bTathtWuR9OagZuWnPfTDRYwjb2Qrr+cXSGHw4=;
        b=lmHwvnillnbksuxlXpEmx99WxtLGBXT/ZMp5xaGoXhc03oWDSy6J/X5tdX/KM3lU9R
         jU4HmSi+41OqY69DDEag9pNmxvta3kQPrPO0IoMxv8orwF4Xj3keieOe71ciiqCPmsxZ
         /6ikV1FS2XyUCNeqGZJIGIKU7SuXayenwyy1xCxtkCBqj35IPvKESMExJUSUOULC/kU3
         /ao7+W1jaPDww47JjdewtJ8kQmr7q1r2a9qU2yCRJrx7Fo5GyZTFUlwmdgNnXeOqPGEm
         mCWwUryGdCe8IvEW3x7QTo1hGUbc45IkJjijxUgADM6Vhnt56ElUZXkygSxYdBNYytPu
         derw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858173; x=1779462973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3mh0bTathtWuR9OagZuWnPfTDRYwjb2Qrr+cXSGHw4=;
        b=TI1APmF7i7G7PG3fLqFybNMZIsPKGmVqF8ulgBkjn1BBXXZVJ9hh3hkIIE3lGN47m5
         dvnFytzDUBhe/tmx4djSEEn8yrogeG9fXQdPuC8p/a748z9EHlrTUQkl4Mx2W4QMXmA2
         nAvIgbiJ8E+DCzlgzGYGqOT25yR9bMvYoNZG5JHd0wfjNfCYs0ObX4kGfTMGgxpQK1sM
         6ucbjbaUo63zOQOmew1U51KxpK1oU5ilnnHX53Xc848+Z9t1O/yChAHuLH6hPqN/vcQU
         mx4X0yYan79kjLwP6ewRUx01H0+T6YX3SNjVnYmnq0mzxaZJRQAnHSpI3cTUJnQvL/q0
         4Vfw==
X-Forwarded-Encrypted: i=1; AFNElJ/PutsG/YjS0kM/YrhJpX1km5/rT7TCzoTkQ653osmZs50JKA4SPmqkK/6Epg7HDPZKB+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLmKwpVIL1e0cppIh7pAeLc/XpHo6eGels0k3yV4t/WexphWr
	REbDZ83UK0s1/XTaPwPyYaOAvobXH+tJuP6fHX2wAkbb9GPe5bLibxz5xNRk/5L/Jahn
X-Gm-Gg: Acq92OGhiQlb8G0xuYOwM8WrFY2WiRxKuWbmcmdmiqot2fnIdnMc7Tds/7lLZVMTnZP
	YFAgIwmi+EzCtezQXR65AFuBBERni8P4mIbneRyYvZsjN6l0O0aTwIbze09UGsZo0DO2v6I6QR8
	5UqAU25ZdoKqx1yAQ44QLYOvGYpf3ok+hLM+68B07/oLWYDDFgDhnaCFtjZg292a8kZz1e4GEOu
	sh8i4xLDaDJO/68dZCpZj35F2xE55Xa/YMKQSH/iTYFmYMHLziqJh0qIGUEvJtBEWUWQVLW3xVq
	+4gsFmF9wVYWoAJ327CDkNiBpp/bTHHOW0Oau8lYf6ceXssVtzP8qAj4qrrQgBn1U/jy/Xc9UlO
	b8Xul8tq/NxJWg/hRxLesCDcnAnmNPykPbyWsS5NG60Yl7CMF5G3BcFFwehL0Cy11zGVWZdX9dl
	cCzKR1b+tHzIL3+gki+3dGrFtmdOTp+lk+UC69RpF37h7RExQiW16ZgMYLHWEJMNpFLvUFLMuZS
	cDTmSpYZ/7GIc+oGjJpgyTSmQ==
X-Received: by 2002:a53:ac9c:0:b0:653:1298:2757 with SMTP id 956f58d0204a3-65e227bbac6mr2466784d50.3.1778858172447;
        Fri, 15 May 2026 08:16:12 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d878cf2sm2724116d50.2.2026.05.15.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:16:11 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: tls: preserve split open record on async encrypt
Date: Fri, 15 May 2026 11:15:55 -0400
Message-ID: <20260515151556.189841-2-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515151556.189841-1-clusk@northecho.dev>
References: <20260515151556.189841-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the BPF sk_msg verdict sets apply_bytes smaller than the current
open record, tls_push_record() splits ctx->open_rec into the record
being encrypted and a remainder record. The synchronous path reattaches
the remainder to ctx->open_rec before continuing.

If the selected AEAD provider completes asynchronously,
tls_do_encryption() returns -EINPROGRESS after unhooking ctx->open_rec.
tls_push_record() currently returns immediately in that case, before
the split remainder is reattached. The remainder is no longer reachable
through ctx->open_rec or ctx->tx_list, which can silently drop
transmitted data and leak the unreachable tls_rec.

Keep the split remainder rooted even when encryption of the first record
is pending asynchronously, and continue the BPF verdict drain loop after
an async record has been queued. Re-rooting alone is insufficient: the
final split remainder can otherwise remain as ctx->open_rec until close,
where it is freed instead of transmitted.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4-7
---
 net/tls/tls_sw.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268..6d3df74dd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -840,16 +840,19 @@ static int tls_push_record(struct sock *sk, int flags,
 	rc = tls_do_encryption(sk, tls_ctx, ctx, req,
 			       msg_pl->sg.size + prot->tail_size, i);
 	if (rc < 0) {
-		if (rc != -EINPROGRESS) {
-			tls_err_abort(sk, -EBADMSG);
-			if (split) {
-				tls_ctx->pending_open_record_frags = true;
-				tls_merge_open_record(sk, rec, tmp, orig_end);
-			}
+		if (rc == -EINPROGRESS)
+			goto split_done;
+
+		tls_err_abort(sk, -EBADMSG);
+		if (split) {
+			tls_ctx->pending_open_record_frags = true;
+			tls_merge_open_record(sk, rec, tmp, orig_end);
 		}
 		ctx->async_capable = 1;
 		return rc;
-	} else if (split) {
+	}
+split_done:
+	if (split) {
 		msg_pl = &tmp->msg_plaintext;
 		msg_en = &tmp->msg_encrypted;
 		sk_msg_trim(sk, msg_en, msg_pl->sg.size + prot->overhead_size);
@@ -857,6 +860,11 @@ static int tls_push_record(struct sock *sk, int flags,
 		ctx->open_rec = tmp;
 	}
 
+	if (rc < 0) {
+		ctx->async_capable = 1;
+		return rc;
+	}
+
 	return tls_tx_records(sk, flags);
 }
 
@@ -871,6 +879,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	struct sock *sk_redir;
 	struct tls_rec *rec;
 	bool enospc, policy, redir_ingress;
+	bool async = false;
 	int err = 0, send;
 	u32 delta = 0;
 
@@ -920,6 +929,10 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	switch (psock->eval) {
 	case __SK_PASS:
 		err = tls_push_record(sk, flags, record_type);
+		if (err == -EINPROGRESS) {
+			async = true;
+			err = 0;
+		}
 		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
@@ -989,7 +1002,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	}
  out_err:
 	sk_psock_put(sk, psock);
-	return err;
+	return err ?: (async ? -EINPROGRESS : 0);
 }
 
 static int tls_sw_push_pending_record(struct sock *sk, int flags)
-- 
2.54.0

