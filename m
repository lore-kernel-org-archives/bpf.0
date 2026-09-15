Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD646D2CF
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461126; cv=none; b=OAcT4IwTlw2BgGfQOD1KuZ0MLYYOMinNuDotNA74CXOyJJUmsstw/RjzZjkZsZiUKxfgpg8NytZ0vLF9AIB9NbwmY+VOjKQ9wjEGsVJBQ+uXQQpTxouC5mmIe/O0aiOBQ7PTQrsWiRr/dYExrG/0GFK+9MQ0VBKE7Gi1PouicT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461126; c=relaxed/simple;
	bh=Kyljv4Ok0VOKC1521YIj/5MqOlgJleHDXLfDK8e9KT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAldiIrN9E6u2oHnOr1rYiGHMfbHu4qYBXFTzhNvrDYi8mj0mXgJ78eUx8WFFDfoW+N0nhuylo7PZUuHOaguXFC4/BTq6ccZ+i4C+GSX9J+At+ZUjlhi/VWm7PK2aWIYOWKzHMDFTltoneK1ZjKieI5Rqn5Qg3VxU0zNljgYo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Rnt5tVig; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Rnt5tVig"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-80587a80992so2046221a34.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789461124; x=1790065924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nfGU+d0Ce1ol/Tm6wjF345/Jrj4e+fpsFxiynd3zRTo=;
        b=Rnt5tVigCJj0q/pFXAwYDku7SgTsY3dWgTxjngrf7YNBsk1tCg/+rtVgmmaWCJqDjH
         NLDhhTElv7TslHWuELgFXkuUgARszo1kR/eFg5CM5W5786Oc/9U9KudzH3XeAjMu1Gxh
         CSqJzZe/1w6H+8rW7Fc11WXWAMrujwIoXC9eXw936LXRuM/ruRv+APnrGUFlpUzhb4Qn
         +2QSnG4Id6X0AtyWnk42yARftwNOCtKKqPSIwMlk42xAoxEUVN2Wli379CX43la5wrZT
         CzIBotBiAQ4aJU/Wfb/ed3yNjm0YkBwjVDeJ+O0u2Kj1qqVWxy+KoS3QwNkd991HJeWs
         dKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461124; x=1790065924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nfGU+d0Ce1ol/Tm6wjF345/Jrj4e+fpsFxiynd3zRTo=;
        b=YWYfNjdXrrnqFJyRXOH1nwN+pyRDT+VXdo57lRyv2J9NWDW4LfnnLUM8p4Rduo4AG4
         ve/nqGFoKfVN4CgTf2GWwceXMmp6jPC5pmofAsWkSh7Iv1Wos/UE/KEL7uHThvgfCoQZ
         Bxn6Yi2lFA8H4IqM9zDZKNZU/x8PRp2iydNyuHT3GqToBJ/Gf+cbY6SUh5kzjk2A6n+0
         KGRcJ4z+zS52T8dXCAVhRzt4YTU/HPOr5LWzdWswVG36VslVU1ay5796CLwNuM+Y+KOH
         jzLamD/MKpYnxMx++An9gubHW+tkiMvk/9D/JjvUXPxG3S62SPeeJtdPEGDwUveMpSFJ
         66tQ==
X-Forwarded-Encrypted: i=1; AKwUvByCuaZClm4cpqcc8DT5Q4+c3j3+VT/XEDGZZ0qJ0BxC05dLzkLEAg9g465Kib6k53Z6To8=@vger.kernel.org
X-Gm-Message-State: AFuF++m/hWVcXDfx0d1VBvdVCWVceubjsma0RCBVHVfFU87BiOo3hUOY
	2NsAUPuDRp7Ek947oEQYk3Z0HU0ibmIUFNWC2ydgK1XepVZWyrOraI/BBMczK75CjQ==
X-Gm-Gg: AYBFou0y8jfkIZPi3gI05WLxn3pUmB2uBtgt0Z6ZC5AgTvXrkmgoIvMBFVHAlG9HWR1
	K3+NJL8J1jtpr6dvvoQc3PQmj1n83U/5y+KGk+SKJrWPLBOuELUtwDqnai6gU5xIMJeBikWlgSk
	jO92eeDtrZTCc6THVZBFYAsiaogFKXBe4DjVaHnv/tXIxlKmyhws0knZfMQOmGgDgJalqKriHMd
	TRrQ5Ei8Wp9KKzQAK5v8x0FcNI8WmzM7svrNb0k9LNlSER5hOTgZArkClW8Lkw8hH8lkjBFpuTl
	pgdjkZRYB0wIG1d2e4ZgSOLnFlU1sfrW04PUp0YxmrKHxFtBHgHxVMdiGpX/0A5DJY5VXz2nChq
	RrYe22MkNxBq94ygxZQdMscMNQBBmiWak8lGL0b90bT0HBVafR1kI+tHakt0XOn/7FOm4LL8HQd
	YMoBFG6NO8PF/cQU+HMiqIkYZbWRKJFRt0cbZsu5wancDN+Jv6oACM0iQ4EkD9TAFU4FCTQTiSB
	za6OTZHekRcXdpceOA2Zo4bwnaOYo0mhX/FPkScrtydQ86yRet1BuSl
X-Received: by 2002:a05:6820:190b:b0:6b7:83d6:2925 with SMTP id 006d021491bc7-6c5423435dbmr3269444eaf.40.1789461119455;
        Tue, 15 Sep 2026 01:31:59 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14382741839sm13579723c88.6.2026.09.15.01.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:31:59 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jakub@cloudflare.com,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org,
	co+0ea1ac045375cf05@bugs.sh
Subject: [PATCH net] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 15 Sep 2026 01:31:52 -0700
Message-ID: <20260915083152.705309-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vlan_insert_inner_tag() only guarantees head room via skb_cow_head(),
never that mac_len bytes of MAC header are present.  Its ETH_HLEN
wrappers - __vlan_insert_tag() under skb_vlan_push(), and
vlan_insert_tag() under validate_xmit_vlan() on the generic transmit
path - therefore rewrite the first 16 bytes at skb->data: a 12-byte
memmove plus two 2-byte stores at +12 and +14.  No caller supplies the
bound, while the pop helpers use skb_ensure_writable()/pskb_may_pull().

An IFF_TUN device has hard_header_len == 0, so packet_snd() accepts a
one-byte AF_PACKET/SOCK_RAW frame.  The first vlan push only sets a
hwaccel tag; the next - clsact "action vlan push" or
bpf_skb_vlan_push() - enters the helper with skb->len still 1.  The
head comes from skbuff_small_head without __GFP_ZERO, so each push
drags bytes from beyond skb->tail into the frame.  After three the
one-byte send leaves as 13 bytes carrying 11 bytes of uninitialised
slab:

  0000: 5a b3 62 12 80 88 ff ff 00 b3 62 12 81
           `------------------------------'
  only 0x5a was sent; the rest is slab, here the top 56 bits of a
  linear-map address

Require the MAC header the helper rewrites to be present, so such a
frame is dropped rather than transmitted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: co+0ea1ac045375cf05@bugs.sh
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 include/linux/if_vlan.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 20cc16ea4e5a..4846032bf4ff 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -365,6 +365,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 	const u8 meta_len = mac_len > ETH_TLEN ? skb_metadata_len(skb) : 0;
 	struct vlan_ethhdr *veth;
 
+	if (unlikely(!pskb_may_pull(skb, mac_len)))
+		return -EINVAL;
+
 	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
 		return -ENOMEM;
 
-- 
2.43.0

