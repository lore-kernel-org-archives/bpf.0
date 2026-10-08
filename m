Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C33ACF0E
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478795; cv=none; b=aol1SLq3qzDHBcugcxcdfnpT98ZQce5GFNEoFjF4KqsghTqeqNuGYPmybtxDq9Uz0hFzR7zbaSb9NDdwO8REorJRzGVinskjKA5ukSbu2oq8dSNqjUyxVkU+yZaBS2IIZiHj7sd4/UqatgDEj+xH6Vb1BDvojKjKqYqAilzD1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478795; c=relaxed/simple;
	bh=1Eq2OLCklqhMHL30tdiX3UqMQZsrvHo8KrdQiyNe6Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3rLBYRgOSmEWGsWHfkT3TNbUxmXFs1hNwUjplUJlz7INh54e7Pr9nQgxjXBtMhTKmYQm4o79PHl5KSCOx1dbK7TewFEVPThWCLMMEMDxm6VaOE1sgX1uQHaiZMp5ViFyPMDhSzRr+jVLOnUKRM0jzATtk9LDl0pPSdc7nbt2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=PsQJZJoj; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="PsQJZJoj"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6768403e9bbso3531576d50.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791478793; x=1792083593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaahY5VyppYhjMzovhM4CJ1QxD6C1zY7gTyA5F8TsPA=;
        b=PsQJZJojHk4c8zvt2ewAF2WkgJ1sOXcy6xF0MdWkrWGF1SzodLWtDRLbPJzPET3n2z
         Psct42TAgk+AkIXVHc2O6ORIJ8ffwaug/t0Qnfxq6XwzUzP+dBu/yEKllVrFEo4zUY/d
         GnP6XNYUAGaVUSfv52v5GuHYNYCJjqHXINfSncw9TB5Qej6gTLJICNfE1xee6uy+8Txg
         FzsBxmeVm+Mbo40A/PWpSecDn+CIK8EdZ7WqzQ6wAKuHJaYtEm8BPYeHZwosMIvI9J4A
         1jtG7QDHVVMgRDJjyl3+oFU6KNIUwIgqAUgBImSIFLMK5F3RX2I5gffGFR7PTypOg0bk
         HsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791478793; x=1792083593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RaahY5VyppYhjMzovhM4CJ1QxD6C1zY7gTyA5F8TsPA=;
        b=z7keqRt4fpdiN6Oi77bYIS1Q30BeekjJSequUM7h4Ni/hiG0MIDgwprpBvX1G9cxyB
         20emy9o6LjaZf99Rwu3oh+gByuivpEDWpfGmmVbWPhafs4OEIqvOcbrjg8Lue4pDXEXR
         eLGXWz7Ge6t1Wu8uj51pRgoznzwaJHpMKp9qPfXazQ7LthqU8F0ktdLhEdi6C1xLnoHF
         aGK/17KpMghpWvNUyEbAA71guB87irI5FRT9Q/roMc0t9G5GBlWhDgSs3oHyHirPE9hS
         3GH3cDrI/lPdXBoeOMyU3AvsLSTobN657y7kXds9mSeL/0XW/UthTjlVjdDHHc852NU6
         SqqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+cCyFGmVWsosIrrEjhqw/Fz7dikqU4NJggsWhyP+cN392t0KX3EIJIPMXc/oj0l2yShM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFkNBq1SJ88kLFHGswVcax6R2frEGag6rV3tkds0tlGFdd4QEy
	nZV3t+GXC5aslxXRbA7bGPjoQABAVZfSbJ7uiz1O6Ciq8CPlrw6s6AqrgDdoYh41i545
X-Gm-Gg: AYBFou2eaHBdVY13U5JaEWmHBb6vp3Lf1osyW8JWrc5ScjafwasWn2P/mxAAK9Koz+T
	VWVy2KakvPFWr6jV+wsyo7OcmjAMJ4SoLXHgPKT64ZJcwKWivl4/PWXYA96xW/TO9fOezUyoIh6
	84L5Tf8/jnR5aLFZ/v3nZGmlwovGJSDZtImWDc9uNvJAAhMkgT3kJDyoOJTGV19YwZdjajiHiT6
	o2DLKJc+nuSzB8+2oQ7C/I0biC1uBCgbd1yT0hTY2ZCxcMQyCdh+kCUPdPVkyFqcID21K0sVaGP
	bYGL3f6LlIupGSxo+Owi54UA/3m/M1TIa4b4yzB19KWf79xDIjDdr9vjCf/d1WoeDbrG6TU3xkW
	U/wdkS4smrYK/OH+rK4vyZxWDsmAi3WdHnftPGQ+MW0QtITGKfM5cgYmtat5PrTxfMrJ65KqMNe
	K1KAnRGUTKfFyzLBH4lAOV7RhHyIT6kCmjh//Mc6bPhJ/5UOEGuV83n+UYk3gHAlHLbaHj0z2ez
	qHjXw9C
X-Received: by 2002:a05:690e:4381:b0:676:83a0:c3d4 with SMTP id 956f58d0204a3-6790a088a8amr2163247d50.27.1791478791828;
        Thu, 08 Oct 2026 09:59:51 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6791b26486asm1537965d50.24.2026.10.08.09.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:59:51 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	zirajs7@gmail.com,
	fmancera@suse.de,
	leon.hwang@linux.dev,
	luoxuanqiang@kylinos.cn,
	posk@google.com,
	ast@kernel.org,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: lwt_bpf: preserve encap header across skb head realloc
Date: Fri,  9 Oct 2026 00:59:35 +0800
Message-ID: <68db88ada2fd01fc03f17dc7d54a705aa245ddea.1791433504.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791433504.git.rakukuip@gmail.com>
References: <cover.1791433504.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

The BPF verifier permits an skb-backed bpf_dynptr_slice() pointer to
satisfy the helper's ARG_PTR_TO_MEM | MEM_RDONLY header argument.

In bpf_lwt_push_ip_encap(), skb_cow_head() is called to expand headroom.
If the skb headroom is insufficient or the skb is cloned,
skb_cow_head() invokes pskb_expand_head(), which allocates a new head
buffer and frees the old one. If the encapsulation header pointer hdr
points into the skb head, it becomes stale after reallocation.
Subsequent reads of iph and hdr in skb_postpush_rcsum(), UDP tunnel
header handling, and memcpy() lead to a use-after-free read.

Fix this by copying the encapsulation header into a local buffer if
hdr points into the skb head, preserving it across skb_cow_head().

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Closes: https://bugtracker.nebusec.ai/f/11304
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/core/lwt_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..15b753a67452 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -604,6 +604,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
 
 int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 {
+	u8 hdr_buf[LWT_BPF_MAX_HEADROOM];
 	bool is_udp_tunnel;
 	struct iphdr *iph;
 	bool ipv4;
@@ -612,6 +613,11 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	if (unlikely(len < sizeof(struct iphdr) || len > LWT_BPF_MAX_HEADROOM))
 		return -EINVAL;
 
+	if ((u8 *)hdr >= skb->head && (u8 *)hdr < skb_end_pointer(skb)) {
+		memcpy(hdr_buf, hdr, len);
+		hdr = hdr_buf;
+	}
+
 	/* validate protocol and length */
 	iph = (struct iphdr *)hdr;
 	if (iph->version == 4) {
-- 
2.43.0

