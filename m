Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560034;
	b=WTECb6rq7BmyFU8ctBvsF4/ypd0LdGKOvCGKmomGHCBdMaeDBFtw3yZdg+MhEd1cQzhL
	 2xPK/1QsCf+8an1lPHP09F8y63WloXXPnLDPBchLZAuxgmAKuIZlvpTJHgG7fvk0IeA6a
	 BOGideB+Bsutqazj9dQSLVyWsVgp5FiUYSdcB//qiamoIH5nUN6TMHHWTGwDlDtqmk/WW
	 L7kg+iEQVO6Yiyxi5vvnCuVGbeSuzZ+BcWNKSCB2yx4ln/hEaLlVxtKhX3clM4b6TX4DV
	 J1Juo9ejnuUa2qdVzAfuaLN2Irpz95S5vedLtW7yFYDvJdom82sp42fIVRm72iwGXyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pVndV0n/YkRP/thIpSXgVugQOXgz4joR1U8HGW5tXlg=;
	b=2u+AOH77clyx6AhBYvB6JZE4SsKKTIvzrUA8DNYpLjo5AqofkJPXYkZvDGTdxjoWPt3n
	 mRwdod8jPnGlcBNy1Oq9qlGhX8792Cqvs/FgdCXeyX0OH3hamwVrZDKZSZrd8vOaPWjXa
	 iQFiKQAgWp3Dpcykct2QihTtUUj/WOgKxAT7B1EAauAKk5OjCGsHpFeF42wIRS3izVtpY
	 xyZwYBX2BscJFanuZrpZ/QMYfVMxpwLdbR6pePxF0UC7T7HRwGIjr4FSHw/+lj1gCLiy7
	 ok74dNbknXel8hW+OQuVAOsBtoclh9y9LFDeziTZZv0C6/94S6SLDpxRYUIyEeTqncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eE3eD3sv;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAF606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09AAF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eE3eD3sv
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso875327a12.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560033; x=1794164833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVndV0n/YkRP/thIpSXgVugQOXgz4joR1U8HGW5tXlg=;
        b=eE3eD3sv0kMPldxvF23ZhXGQ3mkh8ugBV4PW3lWD4i7E14vjzL4T4oEu2rqoL4MJTO
         /otLSoAa/wdmG4+BXv6LMcWJGV0oFLhpCUzTpVPiiGWznFA1nDqR+LzlSUoJe0qIgsOw
         PPpx73zsVI8ali06crjmRkWv6rSS3swMo6YdfdqdSvEZJhKya5V6SNxJFOiQBO4/FvX3
         bwZmZSrLMQG4WP+6+sV8Qpshc8Vv/YDp6kIkQcqDbNLMbNajkURcEnfqc8WgWv2weryC
         J2eR9IcBfG5MKfgpJ2XseJFx1nPHFSP7qTx2MJBPfGw6p/muQm5QpwcY3tSCOTmK7qAY
         72Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560033; x=1794164833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pVndV0n/YkRP/thIpSXgVugQOXgz4joR1U8HGW5tXlg=;
        b=EBuLvDnR+eFQ4nqSyVUviSVSQz8HXKwvJmH1q9p+trTimHUCYfuGTHNFtXClq2XkCU
         OBMSGVcEv8uVfPNwnY0o/9weuoFl07tynJhizblCn0aAKFvl2GqqnjvusY1tJUKErDNM
         We/pNAG/Sv23hBxefh0WBE1lMxF9Omb0gTvQRCtqwFTVv4Rg4tmSD/v+L/VMaiipG3l+
         BU1PwnfegA8fVp4FpzgoA1VF0hroga7BzunVSKIit1zqqGq28AarAcPZkndOUXz6C+rX
         tBAxz5bZyNVBgWCMcJot7lhJbwZEJgtD7/kIffRmzAM3NpyrpCmpPnOW3h7CfXiPv/+C
         Ic4w==
X-Gm-Message-State: APuU4Z8OADsOwzsoPhi0nbN+PiDclc63iyfr5QUW9XfxEI5gVs1B8ApA
	07d5ELb/srDrT2rzu+yLW2qPb1D7MuqWCLasoNotpFI5EoZxHNn4mSr6pn4RuQ==
X-Gm-Gg: AYBFou3rUqbZ9WEf20FrAMAsdBjF+Jmk994fM4HsYP9t1Bg+Aep4xwV+OGsPgL67Ov3
	/ec4FNyO535qIumJmJjO6M+T+YUjZAaRd6hMLht5K5klTynhmO7YGx6H7+p906Y3nfruRV/S4Dz
	Djf/me0FXkaSBDPOhjAd6RfEWdFYcIaew9IkiANYT/sqfPsunNos+1AJze8sSTr7nT/tLg5+F5s
	N2H4z3v47R3gWnFLq//FT/XOJbtQD1QfWorUAdlRyPWfWWgHoB8sTWQhTkccDr5DNWc765yM7Gz
	yf9D0gmdSGgQxLS9dW2k08AwzT0ir5BZv8M+iHhZr6EDQMNDU9vhPJfaLRz0ob1vsjmfVnml7aT
	wTnFX/mNUZS3lLP0Igle5JGEVG6DgJorheo5X3VZvY2lAnqgw38dkxd4hZpm6drqTvdlhJ8sdVD
	RtVIoDDPA9b6yduUg0YVFbr/ufQS/00HqtxAYKRlOQDX+qWYPx76j6ZAqUBB3LPL86R3iQh1yPa
	0PjdnKy8SDLANsQhx4YyOec6WNYa/Rd/UVuVhF1RQ4gTfTXBxgFRkOKqCbhg7r5nfoUjPHAhMuC
	3nu81Jd13A+J2u7u4UsiUB1nN+fRllhzdoHJClo+V1NWY6n3SG9KyAQo7PcgmyKhsXrXh4XCMpY
	S3Z71eZML2Q5bqU3ShVpn/IxdUMA1ZZVyEW/IzgbtNLRHpTKPrdP8flzWxc0lW4LZMm3jXIXuRA
	==
X-Received: by 2002:a17:90b:518c:b0:3ae:2961:14d5 with SMTP id 98e67ed59e1d1-3ae8979807emr6131020a91.42.1793560033451;
        Sun, 01 Nov 2026 11:07:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm10844618a91.14.2026.11.01.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:13 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 16/27] bpf: Reject non-IPv6 packets in BPF_LWT_ENCAP_SEG6
Date: Sun,  1 Nov 2026 19:05:24 +0000
Message-ID: <20261101190535.1454146-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

The mode BPF_LWT_ENCAP_SEG6 of bpf_lwt_push_encap() pushes an IPv6 header
and an SRH, and it replaces the dst. The SRH says that IPv6 follows, and
skb->protocol does not change. Thus the mode assumes an IPv6 packet, but an
lwt_in prog also runs for IPv4 packets. After the prog, bpf_input() calls
orig_input() of the old dst. This IPv4 handler reads the pushed headers as
IPv4. It can write after the packet data, and the kernel crashes.

                 after the push         orig_input() expects
                 ---------------------  --------------------
  skb->protocol  ETH_P_IP               ETH_P_IP
  dst            rt6_info               rtable
  packet         | IPv6 | SRH | IPv4 |  | IPv4 |

The mode BPF_LWT_ENCAP_SEG6_INLINE returns -EBADMSG for non-IPv6 packets.
Apply this check to both modes. End.BPF does not change, because
seg6_local_input() drops non-IPv6 packets.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index c0fc9ff04bd5..a69f6817e273 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6927,11 +6927,15 @@ static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len
 	if (!seg6_validate_srh(srh, len, false))
 		return -EINVAL;
 
+	/*
+	 * The encap mode names IPv6 as the inner protocol, and neither mode
+	 * updates skb->protocol.
+	 */
+	if (skb->protocol != htons(ETH_P_IPV6))
+		return -EBADMSG;
+
 	switch (type) {
 	case BPF_LWT_ENCAP_SEG6_INLINE:
-		if (skb->protocol != htons(ETH_P_IPV6))
-			return -EBADMSG;
-
 		err = seg6_do_srh_inline(skb, srh);
 		break;
 	case BPF_LWT_ENCAP_SEG6:
-- 
2.55.0

