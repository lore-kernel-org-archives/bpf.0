Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014509;
	b=RkJeE6wp4TJDobPIe6gISy2i1bJq1+ci3bhISAWtJBXYWTSntQfO0rvMM0lfXgSMG1ec
	 +VwymWLjeo5EW4lkta6D1p+Oq2ch/EHLnyaa/ob9Q3bmR1Vp6A+TBSFmQl0zgC1jEawSu
	 IwVhkPep6VBHRmxIlsl3hM7J1R4Hs3ixSILXtJnoRBdbrE/XQM3dZOo0/lbBq4AncGhff
	 Wi0BlNQGiM89c0D39yiEVVHGMA1+nRyQ/7jHL7InHxEz+yjyXxbMNSQeAe7YfsbBUCr20
	 zOXf6zuz+OSQhiiIC5BlRof1uDrjOeq19iRAeb7LQPK/lja/+wvfCCFRfvZhhC2BzJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014509;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=hmXBOFJVisUqKsWSXSyM1C7VfnAQRO3g66qqmgXB4ZE=;
	b=H30BwTRti6vzfS/3Wb2O0YOyRbbHbUpIktne+wyrkp9UnHPLXrdjuT/Ev5lV8UAxtKh5
	 aNlanqF8KKiGwstLEJyHn6fOtN6XrOV0ZSh0phYrWk8eUJXwy4VEjdamSJxfRTngy3nPM
	 2P7NoRsoykWLo8S9M6G5juUmUymz8jX5KywTzVB25BwMkDDCxu47doPOl6/RaNRLzd4g4
	 K+dbqdodsRQUpqvpxvlXP2RfDKrYbOdWLULw3uZr9a9oD2gjgze7XSKyejstR5IQcM/zm
	 dXXsbDOoCRPErV1rqQXu8o+p3DqPFtNUrU0yZr5WC25OcTn2hx2AEUGOYXzLqiZQ8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=U+XfrZ9p;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=BE3xfWBa;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A3606A33F;
	Wed, 18 Nov 2026 15:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC0A3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=U+XfrZ9p;
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=BE3xfWBa
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6AIF7YJ8012193;
	Wed, 18 Nov 2026 16:07:39 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 8973E122958;
	Wed, 18 Nov 2026 16:07:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmXBOFJVisUqKsWSXSyM1C7VfnAQRO3g66qqmgXB4ZE=;
	b=U+XfrZ9pAiZV+r1dhjbdVX+7vYw7zMmeAtyQQYkCDgU/UDc6gm8r6F7R7piWXb3LTsedOx
	oPUy/HN4qzUcQQBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmXBOFJVisUqKsWSXSyM1C7VfnAQRO3g66qqmgXB4ZE=;
	b=BE3xfWBahuAv++SpGa6ntVuWzrWUubbdVtnM4HRnXwoRcz/dD1jxaYtC8hk0k1yzF8uvPz
	SLLBw836WgJrnjD+Tfa+ylX2UF8CclVAFXEdlwcBH2TiV2bnwBPov7S7TuISayG3pKBu53
	AfydvRXXP77h3QEurV1MrGiFpZvD7HMrRQ2EPh38taDOM3l0YPpVdVZWa4VuHXGnXWpwqS
	uw0GWs7UmoIxLehZMskr8Hu9Sd/f70jkIms14e01mwq/ThhE1GPSZ2YozCH2O1PmbW7Lnv
	tRxUd2S/cbxuYaGWP8AQpS+6J1dEs9xgqm2dhOwGsOFp4TzdNEx9asX7TnqEig==
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        David Lebrun <david.lebrun@uclouvain.be>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Lebrun <dlebrun@google.com>, Hangbin Liu <hangbin.liu@linux.dev>,
        Justin Iurman <justin.iurman@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net v2 5/6] seg6: account for the MAC header in skb checksum on L2 encapsulation
Date: Wed, 18 Nov 2026 16:02:50 +0100
Message-Id: <20261118150251.65-6-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118150251.65-1-andrea.mayer@uniroma2.it>
References: <20261118150251.65-1-andrea.mayer@uniroma2.it>
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
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

In L2ENCAP and L2ENCAP_RED mode, seg6_do_srh() puts the MAC header back
in front of the frame with skb_push(), without adding it to skb->csum.
The encapsulation then calls skb_postpush_rcsum() only for the outer
headers. With CHECKSUM_COMPLETE the MAC header is missing from
skb->csum, which no longer covers the whole packet as required.

For a forwarded packet, ip6_forward() sets ip_summed to CHECKSUM_NONE with
skb_forward_csum(), and End.DX2 does the same before sending the frame.
When the packet is delivered on the same node, a raw socket with
IPV6_CHECKSUM still reads skb->csum. With skb->csum computed by the device,
the kernel can then log a "hw csum failure", as if the device had computed
a wrong skb->csum.

Use skb_push_rcsum(), which also calls skb_postpush_rcsum() for the MAC
header.

Found by manual code inspection of the skb->csum updates in the SRv6 code,
and observed in a VM without kernel changes or error injection: with
skb->csum computed by a tc ct action, a BPF tracing program on
ip6_forward() shows skb->csum missing the MAC header. With this patch,
skb->csum covers it. Also tested against the srv6 selftests, and with a
ConnectX-6 Lx NIC (mlx5) that provides CHECKSUM_COMPLETE.

Fixes: 38ee7f2d4756 ("ipv6: sr: add support for encapsulation of L2 frames")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_iptunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 3bc47c5614ff..82b3c2af03f7 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -472,7 +472,7 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 			return err;
 
 		skb_mac_header_rebuild(skb);
-		skb_push(skb, skb->mac_len);
+		skb_push_rcsum(skb, skb->mac_len);
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
 			err = __seg6_do_srh_encap(skb, tinfo->srh,
-- 
2.43.0

