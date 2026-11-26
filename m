Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697769;
	b=h/cidv/5pyMaod65v5fncnRQgVkZ0hYtwNYi/xPanX/MRITRMuoY40hSsSrA1C/vPsP9
	 c5ISw/SxPAPc1r17JO0FiY1gHegOTGCGlkyMtkKl99mVZ2GX5YF8NQEe3RfrXQeU+3t+H
	 bxqUvKJPVFrGi7KBT3bnMi5wgFchK8lqzRkuxDfVQ+XKVFYeqoCp5wLG8nf8Axhx6KaQ0
	 aZ0tYn3ojdCCoRivW11OZ/8JGeQWvFnDtjCp4k2/bYPgLC8DeNEFsLyabiAtTvZ8w9d3/
	 TD6TSyqLDSLJXwXxJrR+/ZW0NfDBIwWoe/t9DbNyvx8bygANcuqXTHwWvuyP89u/zsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YKEgczro7mhpR1jUufN4Btp76B+Ta+1rD47sqZvgiP4=;
	b=4jgqxt6cnTfQOsvo8SYJOakZHksCIkO9zWiiEa/mE9cm09DGQIb9VfSjI1untoKQA8cr
	 BGoytQqbYg1R0ohnChXlBEMVSRBVboi4T0lBeskHXlrIYZt84ldRCM2AQU6WFVqZiyg6f
	 1Fjjr4cMuSEaUfky/clmlsYqzExztUvBJt30K31D6dLsDmrF0o5BazmqEksdIbd6cpCBO
	 GjohBTts+aon/6QtmUsd+y6jvvJCxyZPpu2zh51lLO+hgWSXe6+VsJi4fQsjRmBbJniJ2
	 jQbbYCPneJ+qPq13a9WlBPocMtWB+gIJEr1k6JsqLScULHzznIJd10yoVvXQjfP1Dvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1pL0OGx;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F9606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 865F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1pL0OGx
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15dd124bbe7so9743141c88.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 04:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795697769; x=1796302569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YKEgczro7mhpR1jUufN4Btp76B+Ta+1rD47sqZvgiP4=;
        b=O1pL0OGxdiTpl0rOlLPrW9gPsW4MnolnB78YVFXZt3taZLxujkSBcUBiQ3+4IZpmEC
         omovg2bBGRe3RYLhjNqmZnyo0uHQou48lPz68HisaUZ4pW5dC8kv++/Yb1ijKT+TVuCs
         M5/XId/v7wsoU9liz9H4XRh2Xn6iM72/1HqC+P0N7i44V2DuSOkxt1pDbe8be87fUm/5
         /fqXl5jPUxA/H2MdvfVl/C0R5LpCY/JQvjU9/tzKdjUte6ZydTPSW/CIHmwn/eb8LB+p
         bK5l8XtflTXwc0rHFSYzXBOVOIfxIGG/gOBeIBw9Z2OSi6aFuB9W2Hp7vB/8vtnoykoi
         hkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795697769; x=1796302569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YKEgczro7mhpR1jUufN4Btp76B+Ta+1rD47sqZvgiP4=;
        b=eQ6dK9Ki90kkkhAHskBl0YSvho1Oihq/A/lHHvgedeQknq56rLrBa+/LdCeJJTVyLf
         XGonrs3qT/cSa08ps+VjoGPbLucRTCzoejf1FUzrwe7v2NrJ+utYj3SLSqSFsZPY6Lq/
         SVCUGy+pD3sKX4rnL13blq+ScDTNRUJGHkfjJqxXDNk5ByVH6vXP9uNLL3pyB/E8R8hW
         e5OBlJK9nyzV0RtodtBxT+p/hJGBLHGUDU4IhxsEcp7vWyr4b5DRiGb2MtfD8Maypb33
         c3/RX+6DeP1Jlm0Un3qeYPszIyRTq1wuurnIfIL1LTfF5FdWegECvdev64nHYo3A4KPR
         1Hgg==
X-Gm-Message-State: APuU4Z+5bGDLzPmGirsRoCQ+CEwLalW1m1V+Ksvf1pGMIQU9nLMsOp+t
	6hyuQIT+wheYLuwOJUb6kLiADL9liYMPUlXXfin8VJ3EaDUMuID7WZZj
X-Gm-Gg: AZFdTZek2Apr3fkeUbQimE+FYL1DZBne+JvwKKtYqOx0lOgP+G9EQWKkrJvOnzHq7U6
	GkOHz3ur6jCVgpfz7udIGLjCC5pgtyQeYofnLEQ1juYqsQ6yq7YMj6tHgUD90rkcl+T/fkJa34T
	OfoAgwF+AqGiMn9E+MEXssUm100q7JFX0dotR0qVfWK0ROJUK3d6sKOYqC/oaygVvlpeyPYCTHL
	k00ZvinQwe66WsOaxejLb2c/r/p+bjo0kwWsDEj3cvgX11+AqUogXfAiZ6nF1BmdmmZ6SObf2gP
	1nmQgIMA0ZHubuG1m1rurtPSs9OKSiiW5tF0h0BXHKyECdapnMpl8JQ4dS5jobJU7k7VBXs+E1L
	msxdEQQ+Mda7wliFGuMO4+TcHzjBbjFqp1hL62ub+5PYn9FSELiQENk/fVtauziNzIqe+edNllr
	ecNZKnfDdQEyOzKdcZu6X2sdODtmCKuk8ktCpBCYxosfNKykYM0rpyWd4AxIodldNsQIKsWryYd
	v4rGJefKhV/QkxnCScj84Lb+vhI8AofXSomukmt7IY99QIku4FQeF0WFdq05DBm06GjWWfLM2+j
	TXkGNLE6ZMwUcwKNKm5RRJTEBT3ZWoR9Lgb9S2rK3qSJQBR6pYFgJGuMFhXXMaODEkiqt9h+ikj
	ZWlNPAJZrig==
X-Received: by 2002:a05:701b:2096:10b0:151:2e62:fe5b with SMTP id a92af1059eb24-1b5568eb642mr23363487c88.22.1795697768631;
        Thu, 26 Nov 2026 04:56:08 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm65219694eec.28.2026.11.26.04.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:56:08 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	tehnerd@tehnerd.com
Subject: [PATCH net] net: xdp: Fix skb->tail after bpf_xdp_adjust_tail() in generic mode
Date: Thu, 26 Nov 2026 12:55:56 +0000
Message-ID: <20261126125558.2032158-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

In generic XDP the program sees a frame starting at the MAC header,
mac_len bytes before skb->data. After bpf_xdp_adjust_tail(), skb->tail
is set to skb->data + (xdp->data_end - xdp->data), which is mac_len
bytes beyond the new end of the frame and can be beyond skb->end.
When a tc program then calls bpf_skb_change_tail(), __skb_grow()
compares the negative skb_tailroom() as unsigned and does not expand
the head, so zeroing the new bytes runs past the end of the buffer:

  BUG: KASAN: slab-out-of-bounds in bpf_skb_grow_rcsum+0x1cc/0x460
  Write of size 4096 at addr ffff888108e84ec0 by task xg/365
  Call Trace:
   bpf_skb_grow_rcsum+0x1cc/0x460
   bpf_skb_change_tail+0x50b/0x800
   bpf_prog_f9246b7887bf521b_tail+0x53/0x67
   __netif_receive_skb_core.constprop.0+0x132f/0x2e60

Subtract mac_len from the offset.

Fixes: 198d83bb3bec ("bpf: make generic xdp compatible w/ bpf_xdp_adjust_tail")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cd0796a1dbfd..1934e11c4401 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5737,7 +5737,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	/* check if bpf_xdp_adjust_tail was used */
 	off = xdp->data_end - orig_data_end;
 	if (off != 0) {
-		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
+		skb_set_tail_pointer(skb, xdp->data_end - xdp->data - mac_len);
 		skb->len += off; /* positive on grow, negative on shrink */
 	}
 
-- 
2.56.1

