Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560070;
	b=aG12IW1Tamh3nqqpFvJHUwXrCjltplNcPbs8MBUcbQLjBrNML6WNkWJZDeaaWJgIQ6W7
	 Ydge9o24RxVebudX0mdj7ih7u503AS4Canjo7u6V/lAhaaVb4uU9uoAnZ78i6Tuo6vT4+
	 WQMxoDNAmxVP49lZWwv78Hb3ucamMSCmNF9DtXe3qBScZiRdvBoFo2a1AnRM9lO6WM3s2
	 HY8DXM74+h6H0+LDSfmtTt3Mj+wviAixKyFMxwg8SserH2GXUExWc84EjZ3si/9CKyg1T
	 TY3yxtxyJXaL6EtncZjGRz/mRY2KqrXCoVzkx/Xc+WKvRcSB+ruqyzyxkH7/KG11ehQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BHQfhtTfywRH3xOUM7L5ZkdVeeH4xNzFTQOBqxEYcCk=;
	b=z5EA8UXlOJ62Lcjwh3dP3UHlIPee51V+VdlbEu6o0Efd6hn2C1NTv3rtEVsTdVVzVwL7
	 BUHC5WK9C/0xeH3Eac4NJ85zoKj1hv0S+lJpG43VKybubPLcvgH40JUT4MM2y73yVUKgH
	 h2SkvkGsp6ElBIAcyoxpW1Se/YRb8Mjy/nBARicBEMz1yiOqVqbGLxEs9aJHZK418LHBe
	 QqHNbAmqW20adC5NlHee1XgixlD7dUBud3uBCR50sQiUHAuO6rclne8dKLU+/01FlhGfs
	 Qpc23PSg4Q04W6InGzkwApwxIDxJJ+bslwOTVdwC3pEVg+QrhtMhLGG9fLKEk4zZIMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h4OBRE0m;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9D606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9A9D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h4OBRE0m
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ccca948203aso702643a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560069; x=1794164869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHQfhtTfywRH3xOUM7L5ZkdVeeH4xNzFTQOBqxEYcCk=;
        b=h4OBRE0m1wwANShlDQksZCxT7eyNIEHwLu7RtqITntiHs7IlRJWiZp8Oo9DjXSBOLL
         kA3UU1kG/obN/BxrSbDaMp06ua1lN65RQKQzSihBbJN0f6rdxuQNXUZ3XjbBRzGSfkDU
         FCPdxYHR0uIVV8q65ZEfVTlXYNkXGDz5khXw//RuLmbnft7SWFMmhqCaKpSovlIf13mC
         JSpc3eNRgjWe7Py/lH6zVlHQG2dHvUWDlCtmXu+h2IS6LQBisgNsVSFma7R77A6z/TD7
         LDSD0uekHiVe4g+Qa8kClgwD/fiL4t/S6c6dsRz17nPOcxf+cR2+eX27CREidYh8ErHU
         Doww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560069; x=1794164869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BHQfhtTfywRH3xOUM7L5ZkdVeeH4xNzFTQOBqxEYcCk=;
        b=aoGYgPKegZtjKEl3eCLMRXwSHm3857iwOLxhUOVE8YQyaPbMAG/pc/N2Jz+aBUD8br
         Qb5cWBcLDwyINXyxrwFoi9NER/pLf96K2SAbSvZ3C9Fd3ee8ZO3En1JXx4Gcr+ynAvzV
         R9O7pq0hFk+rSNps+joiOrkEc9f0JF5by7MCMeHNDz3LGBWbJXZYEPVQZMz8r7UGLhwP
         5lHK/BVj2TAy9++KZfZnEolDovNeHTEj3IF2IYKFekJRBxuDfAhwrQga1xlKIzPkNhjZ
         oB3RqNat1DI8ZMJyNtKMAo6fuqV9GFQ76hHPqTeNF0C1kReslV0mcbkqCfu1/hlPvLjK
         k7LQ==
X-Gm-Message-State: APuU4Z+BaJGhCWCZQNLicNSgPiMe7iMH9acngNDzABydkaWqd7xBNvsL
	umAlxOj5XP13mWzFShWCiVSDHLuZS+adlP3dhJv0igaADk/SkCboGbgkq/fxfg==
X-Gm-Gg: AYBFou05LzE6PKMoOb5FAP1FtsBP4vRre+t3U9jRmUujEYbjUHzZIcTFT2/VTCObAOs
	TdZZU2KKZJxccNz6vbDhNDLpZy3Avm8awAGXfmaC0RJt8VES+Wh+p3SyiQ3QXm7n+pd7fturV8W
	/H2RjPfXUV/UuN8CA+Z8rbIXt4WA0bSay820fOUmSSyqaLQzQ1CRAUgHAuRCsOjaBO8uGOOzOup
	qeMVi/5zVSAIrKy6ptu4BNWQQDl4qbs2A2XJxv/+GPNOM54MtLxcQeauQtDIMrY4krkaDuNQCHY
	Fn9HMTnzHN3ywiivKVaj/wp+Fh6/KtqaRhisk9J57y/pgeBpo9yYaYonlNrrXTMf6Ops3qm74cs
	4SIck3bmPtyfYvkrSNYJoUXPD9SByWXyPUuoWTzxylNDA12CRwMqqzs79/3k5AtSxyEcROSz1Oy
	t8yHv2s6MxSoLaI16H0dbBHZTTb4rUDkC9mDnmp0k0jqKdW9jM0ckpdv2FWWpoqbc1Eges4YII1
	qhv/6MZFlVEyklSoO86tfzNckDFNtkPztdEXgYvBWwL6iJC9xoABLaDMy5hCXYeAjkWgsGIRlJh
	z+eqDZ3G+XH1ZFuiab50O3KyzdfrTXoYV3kYhQ1Jh+G63vSDPMXBvizvgWeih+aqsFnnjnVP8q8
	yPNHzuVStgTBQiffJevRccQX6WjjJQ0s4RGS38Pf5xQVXOKM/Vp75RI8hWI01wzwoIpJgbQqKCg
	==
X-Received: by 2002:a17:90b:134f:b0:3a5:c08:4c41 with SMTP id 98e67ed59e1d1-3ae897db69bmr5704447a91.50.1793560068945;
        Sun, 01 Nov 2026 11:07:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98afe3sm15107001a91.12.2026.11.01.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 22/27] bpf: Reset skb->cb after an lwt prog pushes an IP header
Date: Sun,  1 Nov 2026 19:05:30 +0000
Message-ID: <20261101190535.1454146-23-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

IPCB(skb)->opt holds the offsets from the network header to the IPv4
options. But bpf_lwt_push_ip_encap() moves the network header and does not
change IPCB(skb). Then ip_forward_options() and __ip_options_echo() use the
old offsets on the pushed header. Thus the kernel corrupts the skb and the
stack. If the family changes, the kernel also reads IP6CB(skb) as
IPCB(skb), or the reverse. With CONFIG_IPV6_MIP6, it reads IPSKB_FORWARDED
as frag_max_size and adds a needless fragment header.

Reset skb->cb after the prog. bpf_lwt_push_ip_encap() cannot do it, because
bpf_prog_run_save_cb() can restore skb->cb. For IPv4 in IPv4, clear
IPCB(skb)->opt as ip_tunnel_xmit() does. If the family changes, clear the
cb of the new family but keep iif, because ip6_forward() gets the input
device from it. Behind a VRF, skb->skb_iif is the VRF device and cannot
replace iif. Do nothing for IPv6 in IPv6, as in seg6_do_srh_encap().

Do the reset in bpf_input() only after a push. Without a push,
ip_forward_options() needs the offsets. Do it in bpf_xmit() before each
reroute, because an lwt_xmit prog can also change the options. Thus after a
reroute without a push, ip_options_fragment() leaves the options in all
fragments, and ICMP errors echo none. After BPF_OK or BPF_REDIRECT the skb
goes to a device, thus bpf_xmit() does no reset. The inner IPv4 checksum
can still be wrong after ip_rcv_options() changes an option.

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/lwt_bpf.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index b9270a08cc6d..3a946e8709b1 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -85,6 +85,32 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 	return ret;
 }
 
+/*
+ * skb->cb still describes the IP header that was the first one before the
+ * prog ran. The option offsets in IPCB(skb)->opt are wrong for a pushed
+ * header, and a header of the other family needs the other layout. iif
+ * stays: behind a VRF skb->skb_iif is the L3 master and not the port.
+ * bpf_lwt_push_encap() cannot do this, because bpf_prog_run_save_cb() can
+ * restore skb->cb after the prog.
+ */
+static void bpf_lwt_reset_cb(struct sk_buff *skb, __be16 proto)
+{
+	int iif;
+
+	if (skb->protocol == proto) {
+		if (proto == htons(ETH_P_IP))
+			memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+	} else if (skb->protocol == htons(ETH_P_IP)) {
+		iif = IP6CB(skb)->iif;
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = iif;
+	} else {
+		iif = IPCB(skb)->iif;
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = iif;
+	}
+}
+
 static int bpf_lwt_input_reroute(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason;
@@ -124,6 +150,8 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 static int bpf_input(struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
+	__be16 proto = skb->protocol;
+	unsigned int len = skb->len;
 	struct bpf_lwt *bpf;
 	int ret;
 
@@ -132,6 +160,9 @@ static int bpf_input(struct sk_buff *skb)
 		ret = run_lwt_bpf(skb, &bpf->in, dst, NO_REDIRECT);
 		if (ret < 0)
 			return ret;
+		/* An lwt_in prog can change the length only with a push. */
+		if (skb->len != len)
+			bpf_lwt_reset_cb(skb, proto);
 		if (ret == BPF_LWT_REROUTE)
 			return bpf_lwt_input_reroute(skb);
 	}
@@ -311,6 +342,8 @@ static int bpf_xmit(struct sk_buff *skb)
 		case BPF_REDIRECT:
 			return LWTUNNEL_XMIT_DONE;
 		case BPF_LWT_REROUTE:
+			/* An lwt_xmit prog can also write to the options. */
+			bpf_lwt_reset_cb(skb, proto);
 			return bpf_lwt_xmit_reroute(skb);
 		default:
 			return ret;
-- 
2.55.0

