Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B043E1713
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148237; cv=none; b=Ijzvx8IU5exwyRLdtvC2IJf6l/LIOx9HKYqoVisBOkSjMNv/EkcCp2mtk8V1gMh0VwzlpX0SsAKEFf7x5Zvnewrwg7IeeZnE3/LSh09fcLdGd0KtchnU+eDe2Ksc1gfD+Yi5jLwpHMJpgVROKkQHiZ1QmAfPZ3ca6GhCPYwAv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148237; c=relaxed/simple;
	bh=37Co+XwP9uWZp5tfMpf5fcEYp8chfhoFKZKhxZtxJ2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txkQo6jkQ5lN08xCeO591PaLecTVkspPTXuxSR9ESe85GYTWMfxToI6tdFDF5D7k1thF20iGR1bpSSzGg5lOKSthjIeSpXgmpXD2ucQqT/6tBvDSwayLQN9VMaIQA4w+OUnHLDDJAmtrbrzeVamJPadNgMfNUCIuGQfIIh7Y83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfxaVYGl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfxaVYGl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487214ad2bso3434647b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785148228; x=1785753028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ezCW4lm9mYFN6PTDfYpk3rq7ZibyjvVjQyvO71TAYU4=;
        b=mfxaVYGlGxaXr0Lm8nh9V23Uuq39BxX4w/YJt6xEWuE3ik8GL1rMeBiX2gW1m1YmVx
         mSiSeUAPkA7h9so1J2uqS1nfhHWYqkWZeOKzQQm9EwVh6Pk6HZ5JEkka4gHSQ+A7uZuq
         UxTRKye7tO4X/Mqs+89zEroWqrFMDfqBbPdAJ3fhRoOOZdujJVOZWX9MTM1Ttcvq67vL
         rKZHxYnys96pYuiTlgnmVgze0AjiJkCDMQjYgUNXp7ZaXtYIYSUbmCNCnQ+tddVibK3I
         jZLoqn2R43DWgZdbm3wn3LCpULPXX4wz6vtnhtaCFnY3l4xnY6hEV7wDhxn4IEqrv5Ff
         c4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785148228; x=1785753028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezCW4lm9mYFN6PTDfYpk3rq7ZibyjvVjQyvO71TAYU4=;
        b=Io7POLjD2PoC69YH815NTYHXNZC5fci1Ma/uc52fHowtXoXEqAWF9YrT7fmLr7Dhtz
         OikyNR9hXYo2fYCpa79vxJEHX9mfErYG2tzVQo2IFSw6FB7aod+ISqh8LwX/GBpJEfeD
         Gs4In24V187JqG03Scxf1fBg3VdnLgNHTyPmW2McCwBfFCqGFhwaUreTOQQx4kts39bn
         2hnLkzUqoMn9ACF185ZekdiYJxeou+nU70MSQAiTjxjDQqASbB0A/Fl7rtYA88OGfm4U
         Vh5r+ZKGb0s7Q1bv55rs8absJcbWB2531d6ukWkMnDDRuRsaH8yM6xP0Dbe+S+zjTK9G
         UEBA==
X-Forwarded-Encrypted: i=1; AHgh+RqbDRKcgQnV6O35KGnPWAXT1vXYWt2wMQENTVj0++hMg1+YQIT3cJ6bxLSmZpmVzV2hrB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwytVDkbqSwzk85xJF68xKTGPjgsjh3OQleJMJrEpc23LC0YTBh
	UJwBZfE3M4y5ar41owszbPIKP29HxZ/5OU9I+RmV+laXs2k8NFh+hBi6
X-Gm-Gg: AR+sD107gLRk9WvvGurI8NbHxrE6sy1VCT7P9kk5byO8cxXynfDM1Fld/4ZhvuuUZ94
	hsOxilqMoClaGUSlfc2eKdBlG9/4ZCdDFXhqKI8Y86Y8GDG8YsJivhLWT+PatL3A+Ny8Yxf7PAN
	CzuyaVtwLBIxc7ouEXDMjndrWfgRkrpRjrfk0yKnSa+MSEZxjn8oDA/SQvYj0vl9M32Plj5Ua2p
	0nPobBA9hChmSLUdD4AwRvpcj08TjRBZVuuY+T+P79o8L4pLLtPee4LRfZcK9lYms/ER5XQX7Ga
	EnBk59B+zDRF+MKW+xef9yy4uIY2k/AtVqBZWBi24MPOvmjMn8lQIi4VKBPcVuJbKFmG6UjUAQq
	8d08NQ8PIX9nHmiNoIJ6IoVi5kHkvZ1owzigc4HUBqJSyXHpo7FpS6k5S815vF43WbUArxzta
X-Received: by 2002:a05:6a00:4fd3:b0:842:55b6:f5a1 with SMTP id d2e1a72fcca58-84e5943132cmr6671649b3a.6.1785148227986;
        Mon, 27 Jul 2026 03:30:27 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533cb54dsm2823860b3a.31.2026.07.27.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:30:26 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Graf <tgraf@suug.ch>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Junseo Lim <zirajs7@gmail.com>
Subject: [PATCH bpf] lwt_bpf: account for aligned neigh header length
Date: Mon, 27 Jul 2026 19:30:05 +0900
Message-ID: <20260727103005.897983-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_finish_output2() expands an skb to LL_RESERVED_SPACE(dev) before LWT
xmit. An LWT_XMIT BPF program can then modify the skb head and still
return BPF_OK, so bpf_xmit() rechecks the remaining headroom before the
skb continues to neighbour output.

That recheck uses dst->dev->hard_header_len. This is not enough for the
neighbour cached-header path: neigh_hh_output() copies the cached hardware
header using the aligned hh_cache size, HH_DATA_MOD for short headers or
HH_DATA_ALIGN(hh_len) otherwise.

On Ethernet, hard_header_len is 14 but the cached copy needs 16 bytes. If
an LWT_XMIT BPF program calls bpf_skb_change_head(skb, 1, 0), the skb can
still have 15 bytes of headroom after the program. xmit_check_hhlen()
accepts that, after which neigh_hh_output() hits its headroom warning and
drops the skb.

Compare against the aligned hardware header length in xmit_check_hhlen()
so the BPF_OK path leaves enough headroom for neigh_hh_output()'s cached
header copy.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
Tested on a veth pair with an LWT_XMIT program calling
bpf_skb_change_head(skb, 1, 0). Before the patch, a UDP packet sent by
the reproducer triggers the neigh_hh_output() warning and is dropped.
With the patch, the packet is delivered without the warning.

Below is an excerpt of the warning before the patch:

    WARNING: ./include/net/neighbour.h:538 at ip_finish_output2+0x19f0/0x1f80, CPU#0: lwt_xmit_headro/55
    Call Trace:
     __ip_finish_output+0x59b/0x8b0
     ip_finish_output+0x67/0x390
     ip_output+0x1db/0x700
     ip_send_skb+0x1f6/0x270
     udp_send_skb+0x8d2/0xe00
     udp_sendmsg+0x1717/0x2620
     __sys_sendto+0x443/0x4e0

 net/core/lwt_bpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index bf588f508b79..2890aa59a3a0 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -169,8 +169,10 @@ static int bpf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 static int xmit_check_hhlen(struct sk_buff *skb, int hh_len)
 {
-	if (skb_headroom(skb) < hh_len) {
-		int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
+	int hh_alen = HH_DATA_ALIGN(hh_len);
+
+	if (skb_headroom(skb) < hh_alen) {
+		int nhead = HH_DATA_ALIGN(hh_alen - skb_headroom(skb));
 
 		if (pskb_expand_head(skb, nhead, 0, GFP_ATOMIC))
 			return -ENOMEM;
-- 
2.55.0
