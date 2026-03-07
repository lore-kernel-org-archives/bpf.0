Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA03783CA
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916673; cv=none; b=S6BDmZKlNF7EbGtnKhjwJtGQ2XUO8/FvTTMimUbq7ZeCzStU1z5k36np3GiQBTGNsJcu5F2ZxX6pi4jkEmKlkPRWcXExcMa75HD+EYBDp8kvsV3ni/wZEbvrFG+NK95BnaEhW6I5PgSL96pDt5HsYIHoZ8ntcjpyQfG7A8em0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916673; c=relaxed/simple;
	bh=rQz0G09ECTye/1V+FFrPEYbTDw+YCYeHWPbDy66SMRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUBYyJ9nBaEyk6tCp4YETuo/YTXKojfFjtoXW9AEtYrYUbTP026a6F3hg+Kc6foLem9PAJY68c4Ejfchemcx6RNu9NLEsHjW016wvucADlZpRqPEGNmh2v0Pq1W7suDcob5kGpQlJddQIFw8vshi6a9nfy8keLCv/QKOaud3Cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ITkjOxaP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ITkjOxaP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so1319595e9.2
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772916670; x=1773521470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TEKXuJgPJhSEn7xi7NpdjtrZ7sxjabMNE5jL/D5Rdk=;
        b=ITkjOxaPCo833NGBF7BtbDeuTdXB9wRblgPeP69oqN5l1Jtktxi2Xc6TCW3CvFIkNc
         1kPIJz1/rWvbN3UPyyd2EYL/UPBHFMj2IedioLIxaAV9CyTYodYO8EURt3rUJ3K1B6+4
         beFdAx/s6lMXT4li2RGeUta4w/8Y/ytCozoUe6kkiT/HhPqy0pHmOTTmJ6iodI1MzSvx
         x1qc7SSbL1y1Rjy3BBjiW3BPmxYqp4YOaj63K6fE2ZSEkq6Q5P0sRPOcp1mxeDgU7pqw
         MK7DHz+8rES9kus4a09R85wLCkTFp1rH/+1zaUr98XoJoSKc9o8QTEN5LC/ka84sdR9n
         htDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772916670; x=1773521470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TEKXuJgPJhSEn7xi7NpdjtrZ7sxjabMNE5jL/D5Rdk=;
        b=unoSweWYyAwIiQGLC1wDDzAgCpqEe5u8XcLLao+rlGOarMsvRMMBBwAlHE6gtM/MTi
         Cg0XHY6uvM3V7AJXtuevpzeHmp2xH3Tu9LQliHCbq6zjqs79HjaDjI6QEfUDCNLsLZAy
         nr6QeaB3PlyJjzdSKU/flIbCSzfZJbG1fQfNDWm3BqWWl98oThtY0/cwEBZnrk4lvGUr
         29imPbr5PoNAVl+q+Sjng+Kh3j5t/AfYtmAY58d0uuuJyqt0zNeZxhw46fFEO6YVTctR
         YGTrN/QUr0ZlrO9zC/3WH+Ma/aZE9kh9Uv/qdIp0saqI8v8EJTGHwC4OLW2ZPnVKz8x4
         psbA==
X-Forwarded-Encrypted: i=1; AJvYcCWewJnKuTEAVPzjMZqmanwVDxHfWd4MmhOWslp3YRMkAoKmhY1ugUPSryLuohonmeJz1L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtXz6SCjAuNgv1EqdIAtkaLqh3Od+SlU7TvDLKVzcsuSeCTTH
	3Qmn8SO8WexC+H3RFWnhUtKeQOM5FjS/ajeV5vp+SR9LPmdH4zC72abJ02xNFG1IZ8c=
X-Gm-Gg: ATEYQzzGQIaswxbBzhAH/GxO/LLJTpR4Ptb7ZFTrfwJb67q7EfThtJARSQFj5oQ9tCg
	3iSyAgHznufsKh8EjP6yg5iEtF2JwkT7eZoxGIAGEBYE3simnYtDJG31XrZSM+r/MVVS9WtWQGp
	dMdNv181TPmx8JxTAgB6Q0FLo2f3auLJIIEgJ8rlFVmo0Vf571DnmE4PaO3NanuXjL19CJZfrLC
	2lRAM2mTCwBaEwVqUWjKmsGzuNDG6zdvWGaVV89bp1m2+eLZzYf4b4b79c2+FjOrQjbc98KVJmt
	OsDCTe1LIztGgxpo7crdqWLx6lb/IRgSdUry5CvmZcVpO23yiIdtVTDAsKzbxRU2jp/Cx6YlkJp
	m7kl9hZWuOBLk0M9AFhRsdyvt4vXwg9lYcWI87V2LzHoWEV+PmXJZt0lkoA/esYOsnsMRN/TfR0
	M3ql4DfoIn4g==
X-Received: by 2002:a05:600c:a00f:b0:485:358b:e80c with SMTP id 5b1f17b1804b1-485358bea63mr7375885e9.0.1772916670131;
        Sat, 07 Mar 2026 12:51:10 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe88aa2d6sm5497582137.2.2026.03.07.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 12:51:09 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 07 Mar 2026 17:50:54 -0300
Subject: [PATCH net v4 2/4] net: bonding: Fix nd_tbl NULL dereference when
 IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260307-net-nd_tbl_fixes-v4-2-e2677e85628c@suse.com>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772916658; l=2801;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=rQz0G09ECTye/1V+FFrPEYbTDw+YCYeHWPbDy66SMRc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLCmgfW5DEXGJb2EZsh2R6vAsikXWKiPtCnscGYQnGo0rUUoES4G2ViJ1aKYt66Gh8fF8JsbZUl
 wHGhFS0aC1AU=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called
which initializes it. If bonding ARP/NS validation is enabled, an IPv6
NS/NA packet received on a slave can reach bond_validate_na(), which
calls bond_has_this_ip6(). That path calls ipv6_chk_addr() and can
crash in __ipv6_chk_addr_and_flags().

 BUG: kernel NULL pointer dereference, address: 00000000000005d8
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:__ipv6_chk_addr_and_flags+0x69/0x170
 Call Trace:
  <IRQ>
  ipv6_chk_addr+0x1f/0x30
  bond_validate_na+0x12e/0x1d0 [bonding]
  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
  bond_rcv_validate+0x1a0/0x450 [bonding]
  bond_handle_frame+0x5e/0x290 [bonding]
  ? srso_alias_return_thunk+0x5/0xfbef5
  __netif_receive_skb_core.constprop.0+0x3e8/0xe50
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? update_cfs_rq_load_avg+0x1a/0x240
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __enqueue_entity+0x5e/0x240
  __netif_receive_skb_one_core+0x39/0xa0
  process_backlog+0x9c/0x150
  __napi_poll+0x30/0x200
  ? srso_alias_return_thunk+0x5/0xfbef5
  net_rx_action+0x338/0x3b0
  handle_softirqs+0xc9/0x2a0
  do_softirq+0x42/0x60
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x62/0x70
  __dev_queue_xmit+0x2d3/0x1000
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? packet_parse_headers+0x10a/0x1a0
  packet_sendmsg+0x10da/0x1700
  ? kick_pool+0x5f/0x140
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __queue_work+0x12d/0x4f0
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by checking ipv6_mod_enabled() before dispatching IPv6 packets to
bond_na_rcv(). If IPv6 is disabled, return early from bond_rcv_validate()
and avoid the path to ipv6_chk_addr().

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14ed91391fcc..33fb5f168cef 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3377,7 +3377,7 @@ int bond_rcv_validate(const struct sk_buff *skb, struct bonding *bond,
 	} else if (is_arp) {
 		return bond_arp_rcv(skb, bond, slave);
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (is_ipv6) {
+	} else if (is_ipv6 && likely(ipv6_mod_enabled())) {
 		return bond_na_rcv(skb, bond, slave);
 #endif
 	} else {

-- 
2.53.0

