Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602171;
	b=kVoExXydti8yctED7tgrQP39gJNtbCbztbuTp9fxp1R1WWOL1gHwCpvPApDgQNH/GX6k
	 8E2/N40SMI+rBRMr/9LrePGvunEM90glQPPh6hdGFZM59ZXqa9iNgSWRpwUesCsRu37nq
	 PfTYAF5rywVZnOQN3dPFwRs3WOoSDALqNSDikR6lsbBEuFWIAHqfpsh7L9NiZmC1WawR9
	 q7TLLSdRoklyCbo089fpyBW3WjYK5fFhTId3KGWeE9J0OroJRatfLX8P7eUAVVg6S6miW
	 YptWVIj/SAUxcXRFooqFLDcuw0xNb5lkyPr0YuetuOXhMd3bZLcqU/TBETruTPW5RBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6VjuU2aTLmacVA9KDoSsRlNxzT6VBc/2/KWdoZzBwEw=;
	b=wm8BC+fcbUGJ970enR3tEcxDtA7sXpmUgaa82U3d3AdrBRK/qOEx06gPUqTwwXkV4HNA
	 KDNe0bTESPDV2IVRoiycchQIdhI3A3zVKCJvoXf279m9y9WxRM6LwLTP8/RqXZqB8VxPO
	 Ra1e6EDONYti/oww7E6sHVKdlWczE0BSVl0aKD2zQ0tenoWb6/tkV3p8Y6VdMZgJ7PNr2
	 Hgd2PQ4YyTLNYmu5oBFduI+cEvgQmIzQVEYQqkSwlcPCKv0raZAI06QpYlAZZHzGoMVOS
	 VvYctTDFmDmqqXgW/tVEyt1J8z0MRkEorpvRATZShDpE2ud9NcjP5agVW0D+CgMZmRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rfka8TN9;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE01606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DE01606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rfka8TN9
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e977109392so17634595ad.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 22:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793602170; x=1794206970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VjuU2aTLmacVA9KDoSsRlNxzT6VBc/2/KWdoZzBwEw=;
        b=Rfka8TN97vWvPfkaIIflW761ov3ZlJdPvWet7UmMNTF4AoSczsdojaq8RakwlCbphK
         OGgDQN7jTBLf8q66kN6g9Nss6Vp250lTk7KP4s7LMhNybbEz5bONT15VMHmd3y/gkPaP
         JLmJ433k2CXcmo0liiOF55wXza2eAQqizr2tT0Sg3hXKq3zRklBKbOKcZDq7z7fwZj4w
         xNh8xdBtAlmPMUejQeQlpe3nDQA+aMbdO1MbU0DcFAt4mKB9kYxVd1TaP82pW2RW0wwb
         69clgU2OkKzwFMWxbkBAxjMo/QqiYPZmkBDr+8rSwd1rNXYqVnbOLpgFheNb+q0qfoYm
         Xciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793602170; x=1794206970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VjuU2aTLmacVA9KDoSsRlNxzT6VBc/2/KWdoZzBwEw=;
        b=oSY7wFPfGnZaqDGh+TFCCQ50Ly3MW3dQwYgDZxEgQvt7t4S6o+nJSY0P+042LnOuur
         hHdbv6cFshR/0G1R6dnV030beskOKSqPN7EI4icreah+n36EIPbDD9dFC1exqlURmCIH
         TSiUWW87edoI9SBzDaBhS56/oe6Gi7bWgnBbhSc0FCg4/D31zj63BkKrx64DlBX3HLCq
         KSx4ezsfgDx83WcA/jtM8c5ZRTYa1qIfxpPV1t/v2s3B72dpgXtZLcbDC3ii5SUyqmuB
         pxeUwy4QoDpYR3RZCSF3MLrFIDMu1pSdOonMcsMqvtalsUxPxSgFgqDu6Jqq7bziQ0U7
         /PbA==
X-Forwarded-Encrypted: i=1; AKwUvBz22NRC3/iGSif3t3UylyXyBjxIIcUQW9IdcW876Rg8tu6zcVzvarX+HQMcAwUkcbYItPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z97AG61PtY6Ph6DbUh5L64jYPXVX2qeGq0YJ/8ggFUmgoCHqiHG
	FcvcGbDHh1ZhPgztIyG0XMwnIeSwZhacIoqSFmaq/YpiKFvtFz+V3OU8
X-Gm-Gg: AYBFou3Qbk39TKoEP38UvobkxYQsbLlJR0LXbGiQg4jREHDce2ZKaC6yO+KYh8zNdMJ
	4Nrni2PgucZErRDGkAeoFdTaGmP1T78iUWVPIfq1SJ8nCCL/yP5ry3OD36CQXxkiyrpPA3IPk3L
	h9soJM1XEnVtLNcCHT9/8n3MEtMV1ysQjJWgAA2URjC14KwffDHxwn04LW2ZTDyYbNfWFoeL13T
	edJ432W6Y/r3F3cMxnymxdVO9Ce4dkXrpNcf9lhjy1Yd/cl2RJ/KGqc9ii28mJs+Vt98Xw5Yz6g
	jiY5M1ZRa3MQITVW/mEB8lNsSNDsbS7VdHL0oqM9WFGWGVT3CNEkeld9pylHHTxbjL6bydWUd5k
	DMSmOI18x1kvHvCKXtswPQ/q/PKEl2XOm7z/giY39vxY5o1f2at8Y4o2p0PFJiwgDYXyqHmi4fF
	EDSaxDW5WcpkutQJOAgIQDxvidgsFGg8398CQZQ63Irgz5O6i97qODBLYBf87QQ+fE/Y6miqvD9
	njKBuSs9WjZ+UQE3Kxpkjt/UXghrV1p9FO1SaZ7S+5ri/3fMdDpcNS1whIoop0AyN+icyw/KVli
	aLnU2sLn7zyAaeu0m/NRWQmkOGwQebhWZ9cF1vnaAq8Bmf86UDnMNiwyPtT9SrO/lcMUZDtHe3N
	Qu5+RVhETgC6U5Uh6dfWPRF/CeknyggWQ/gVNaQdy2m/XMLSHZ96XpryZkIVtDSupGNll6kaJ8A
	==
X-Received: by 2002:a17:902:ef08:b0:2e5:ee16:2f8c with SMTP id d9443c01a7336-2eb36426e30mr90562695ad.16.1793602170134;
        Sun, 01 Nov 2026 22:49:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392965fesm23212825ad.59.2026.11.01.22.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:49:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	bpf@vger.kernel.org
Subject: [PATCH net] ipv6: Check the Home Address option again before its address is used
Date: Mon,  2 Nov 2026 06:49:22 +0000
Message-ID: <20261102064922.2636027-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

ipv6_dest_hao() checks the Home Address option and sets IP6CB(skb)->dsthao
to the offset of the destination options header. Later mip6_addr_swap() and
mip6_destopt_reject() call ipv6_find_tlv() with that offset and use the 16
address bytes. They assume that the same header is still there.

But the seg6 and ioam6 lwtunnels, the End.B6 actions, ipv6_rpl_srh_rcv()
and BPF lwt progs move or rewrite the IPv6 headers and keep IP6CB(skb).
Then ipv6_find_tlv() parses other bytes. It returns when the type matches,
before it checks that the option is inside the header. Nobody checks the
length of the option again. Thus mip6_addr_swap() can write after the data
of the skb. mip6_destopt_reject() can copy that memory to an xfrm report.

In ipv6_find_tlv(), check the length of an option before its type. The
returned option is then inside the header, and the header is inside the
linear data. In both callers, ignore an option with a length other than 16,
as if ipv6_find_tlv() found none. Then the ICMPv6 error goes to the source
address of the IPv6 header, and the xfrm report has no XFRMA_COADDR
attribute. Nothing changes for a header that ip6_parse_tlv() accepted and
that is still in its place. For the other callers an incomplete option is
now absent:

 - ip6_find_1stfragopt() and mip6_rthdr_offset() can return another offset
   for the fragment header or the xfrm header, also in a forwarded packet.
 - calipso_skbuff_optptr() returns NULL. netlbl_skbuff_getattr() and
   netlbl_cache_add() then see no option. calipso_skbuff_delattr() returns
   0 and the packet continues unchanged. Today it returns -EINVAL and
   SELinux drops the packet. It already returns 0 when an earlier option is
   incomplete. The receiver drops such a header in ip6_parse_tlv().

The code that moves the headers still does not reset the offset or the
other fields of IP6CB(skb). If the bytes there look like a header with a
Home Address option of length 16, both callers still use its address.

The first tag also covers ipv6_find_tlv(), because its early return did no
harm before mip6_addr_swap(). The second tag is for mip6_destopt_reject().

Fixes: 793832361fe7 ("[IPV6] MIP6: Revert address to send ICMPv6 error.")
Fixes: 70182ed23d25 ("[IPV6] MIP6: Report to user-space when home address option is rejected.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv6/exthdrs_core.c | 7 ++++---
 net/ipv6/icmp.c         | 7 ++++++-
 net/ipv6/mip6.c         | 9 ++++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 4a9748338cf4..764c694fb417 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -138,9 +138,6 @@ int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 		int opttype = nh[offset];
 		int optlen;
 
-		if (opttype == type)
-			return offset;
-
 		switch (opttype) {
 		case IPV6_TLV_PAD1:
 			optlen = 1;
@@ -153,6 +150,10 @@ int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 				goto bad;
 			break;
 		}
+		/* Some callers read the option, so it must be in the header. */
+		if (opttype == type)
+			return offset;
+
 		offset += optlen;
 		len -= optlen;
 	}
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a95b0351824f..d8203ebad882 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -343,7 +343,12 @@ static void mip6_addr_swap(struct sk_buff *skb, const struct inet6_skb_parm *opt
 		if (likely(off >= 0)) {
 			hao = (struct ipv6_destopt_hao *)
 					(skb_network_header(skb) + off);
-			swap(iph->saddr, hao->addr);
+			/*
+			 * The header can have moved or changed after
+			 * ipv6_dest_hao() checked the length.
+			 */
+			if (hao->length == 16)
+				swap(iph->saddr, hao->addr);
 		}
 	}
 }
diff --git a/net/ipv6/mip6.c b/net/ipv6/mip6.c
index 6a16a5bd0d91..961567972411 100644
--- a/net/ipv6/mip6.c
+++ b/net/ipv6/mip6.c
@@ -211,9 +211,16 @@ static int mip6_destopt_reject(struct xfrm_state *x, struct sk_buff *skb,
 
 	if (likely(opt->dsthao)) {
 		offset = ipv6_find_tlv(skb, opt->dsthao, IPV6_TLV_HAO);
-		if (likely(offset >= 0))
+		if (likely(offset >= 0)) {
 			hao = (struct ipv6_destopt_hao *)
 					(skb_network_header(skb) + offset);
+			/*
+			 * The header can have moved or changed after
+			 * ipv6_dest_hao() checked the length.
+			 */
+			if (hao->length != 16)
+				hao = NULL;
+		}
 	}
 
 	stamp = skb_get_ktime(skb);

base-commit: 714b7112017fc7f8b2afabccf562acdb12d2ea7d
-- 
2.55.0

