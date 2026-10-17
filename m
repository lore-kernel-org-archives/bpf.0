Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544423507B
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200089; cv=none; b=JrNHOoKTvghTqlHLZRL2+sL748kPjxSOi4Lsv9Ezc6YjLtYcm9Q8zV0DPCo21AqIsKGw2+eRwV/7lFdXJBul+D5odHpTy0Qm4/Ax3Nl3ovwlU3pEz509fSZQuyNkHED8iV8VjlM1B/8RQb9u6Pvob0kLKMeUOIFFsawrvHPKFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200089; c=relaxed/simple;
	bh=eUvssHMgi9uWImtjEOl39Yas/phByQHZ1Ucu+8DH/Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONJU84C94EJmd0RQEK6YpNBzzuQvBKZoNzkw7O0IZL7Bg9g+aQW2UamCRnxsXTtqecc+HtQJGGABshRO4yMLqFffjhsUlPCmk9Qf2tLHW2MioP32+Hwx1cC/sydq/TRlRMNx8WD2zdYWHOmpp9hmfqbqxI6GD6Y7D9UsIYULgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8/eBX37; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8/eBX37"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so345716a91.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200088; x=1792804888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qND9eoVfb23NMeltyU+Z7QueTQJ5SyLaDy+fo2vIfdI=;
        b=i8/eBX376sQI2qnNsMQud1Yl0KWqUKrRADPpYborfswq7SCK0JTyE3fjZZeHMQdpao
         cvGNOopvoOqapXTHLU6dVUKt1rG2rsxVgo6plkXIzxmX8SkufPZis10+gnySEXtA6ULB
         B7m4tGDFq7gYy2A1M4cGB+KtLIBVUf76AdyZ0AFr9vCG9VMccxUc8sLfApquQEx7EZQJ
         juo77h30bkn+IP/aBwPE2Ie4WeqclcIanAcKVTHlvdKvc4nvXd/FMfvhEtx92nCk496K
         pMPGQ6J9vFyX6DadmvBM8nJdq0n25hZDVxW2lTXZe4pXBsZdC6Pw2i0w7OvPzutRMJJu
         4bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200088; x=1792804888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qND9eoVfb23NMeltyU+Z7QueTQJ5SyLaDy+fo2vIfdI=;
        b=F4UA4iT0PRS+iWMIjxQbt23BX8nOW1KU2sjXUwadTeml8CxZ3zt/4G07Awg2irBNWF
         aIH6prZKH1fLzkvXkpk3zK5W0GqPBEkbYnwa14BVMKGv/Cs1hhKp0gJ2QZ4jAYsNGent
         bGUVXXZ9F+ADkY15e3eGX8mFTBanI8ecgpPKBV1bfU3P3HrHlCIKk5I1YrL35lIm38Yf
         6FCiFZuOQK3PYdF2lOonOMyugI2IcDGj7w7eMsf9ad9RBI6yykfampsOWNQTywwH1ZuE
         wH83acNNzy4kjaRhkjziCWQboiLYkeMVNom/VE5EA0+uxH1k0/JYLLM150QJ02U7WwpM
         8kWg==
X-Gm-Message-State: AFq9FYKqNCBuFTKEda8lL64ZsRDLlMpeo0Zcy/9TUya2tiqT4cOEDm+B
	ssz+1a6t0L5bKKrcoSHoNYGMSJ6+cohO9dgNPnkJqLzByG/0HbwQEOiXCkVIGhW6
X-Gm-Gg: AYBFou08oZCTRs68jV/iP/Z2L//tutN5w8EYU9/DkjBJG7qFalbp547+h8IACM5gXFJ
	xDqE4Q0wwOC5DTzC4m2hnJOw7F/IaXGbP2qptZiaYVhokPNoVB+Yb5FC5Zijbuj1+Tx8A6c6Jf4
	SMq4fx9gcuScQ52uIFbD1NfNjSH/ncdW6NjpSr7nRpAXscNzHZ3dGQ8IDy+sB5SQIJRZ9X1IKWs
	YK8wZbiiXckBSWCY3D72twMTj62EUbh9CBdSa7lg6r4ou0+tzouKRtfsIT+Sd9e2nLialU03pFJ
	BD4dxNvpPn789D/kqVneeFp5OicV333lLceAuR7QwPA/Gp4mXk2MeQkTgBKdIsb3Maxej0r4MBz
	bAJ3kHo3JSMbMwVsmHUwSL/z3aIYObCuaVQBpAw2KzvPouUrzjYD6izVgJA9cco4a+HVNPNJP52
	90W+9/cjwiUiF59JHA6yEtqjYDclvZd+K1K8IovOUWEl6ZeITQ1JYaxjO+GBg7ZEOzycayPT8Ny
	wYpBf74hdlQrOHhYA6tzjQT75fAEV5mXQrjzpehFq2wIEv9+8bNXwY/EPht1OUuHUKUfpSpMObF
	+dI+8Mx2yttX1otxNBLn6YI2u3ePING8JET0jMc1+PE=
X-Received: by 2002:a17:90b:4d88:b0:3a8:cb54:e135 with SMTP id 98e67ed59e1d1-3acef134c30mr1497740a91.19.1792200087871;
        Fri, 16 Oct 2026 18:21:27 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9e47588sm3341060a91.1.2026.10.16.18.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 08/38] bpf: don't let bpf_skb_adjust_room() use up the MSS
Date: Sat, 17 Oct 2026 01:20:28 +0000
Message-ID: <20261017012058.355787-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

When bpf_skb_adjust_room() grows a TCP GSO packet without
BPF_F_ADJ_ROOM_FIXED_GSO, gso_size is lowered by the number of bytes
added. Nothing looks at how large it is.

gso_size is the size of the segments the peer has sent if the packet
comes out of GRO, and what the sender has written into the virtio header
if it comes from a tun device or a packet socket. If it equals len_diff
the result is 0, and a packet of up to 64 KB is no GSO packet any more. If
it is smaller, the 16 bit value wraps around.

One less than len_diff gives GSO_BY_FRAGS. skb_segment() then takes the
length of each segment from the frag_list. A packet with more than 64 KB
of payload gets that far, and one from a tun device has no frag_list:

  BUG: KASAN: null-ptr-deref in skb_segment+0xcf1/0x1a90
  BUG: kernel NULL pointer dereference, address: 0000000000000070
   tcp_gso_segment+0x1be/0x9f0
   inet_gso_segment+0x288/0x740
   inet_gso_segment+0x288/0x740
   skb_mac_gso_segment+0x179/0x2e0

Refuse to grow such a packet, with the error that other packets which
cannot be adjusted get.

Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba536be2915f..a18702f89feb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3612,6 +3612,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
+	/* The MSS is lowered by len_diff: something has to be left of it. */
+	if (skb_is_gso(skb) && !(flags & BPF_F_ADJ_ROOM_FIXED_GSO) &&
+	    skb_shinfo(skb)->gso_size <= len_diff)
+		return -ENOTSUPP;
+
 	ret = skb_cow_head(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
-- 
2.55.0

