Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5F50EC1C
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786442; cv=none; b=YOBZ5HOuG0SyW76l4MWaSXyVsoyFDCN5FixfYns2IouqiASOkM8g4Tp6XR+2pgYzyey8eiHaJEarDTqV93VpvyJcUh7VoKdhmznuX+ESla1/QTnCGXi7z0jNfHAzI4Z/uRmgNZewfAY3DyFkTS30/mM8/loJVAu+kU5XUqowH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786442; c=relaxed/simple;
	bh=IGjKYCcj33wJ8f6hSu4GlUqk6V+8agpe53HSKiZNqmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qr4l4w4rmiLoQrYL52TYta19JNayjPeCaHYt92O98DcQylQ5WD8PONg28HoF0juWBBh9Nh12q5JS6Hx7xzI765Y64RHNiYQ9Y0sd0Ua8sUYz16rnzmPjy1pwE6EBGXj2h9ialhMjQPtVS2tGw2ebeLdzFGAt0PfWlLwWz3RAIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2IHtmWO; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2IHtmWO"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc790c60953so1213665a12.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790786440; x=1791391240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWp0mZm/dpV9j6Y/XOFxLUMhWESv+JE7A5/M2q1MLDU=;
        b=s2IHtmWOrjxcHC7VTQB5V5ytGNHG3JxXOcHTfKmBWPgCg2GZOuaUZcgSN4nLoMWnNs
         +nAsWORq+nYlTsGh9fxAdb9nW7p3z7UQcvyFUnU6nM+vqnh4FjqgoqjV5kq80eMBtQCS
         zVGWWG3d+xjqmdoWW5bnTikhXTmd/v2sj5HnCsPdaulQzNBr9y8nBhFfGdqnIseclEaJ
         UqgeWwxsIeYV/NeeTI8HL+5mNvpZtCZkoUMroR44VKgHxf1nATeJR8J6Oe9JjubutuXW
         gdm+vh/S4fqQqA1KyTvPqvMXKDj81N2BltfGNEcyesRRoE3NHYDRooRlTVdS+THYfPXX
         p7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790786440; x=1791391240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWp0mZm/dpV9j6Y/XOFxLUMhWESv+JE7A5/M2q1MLDU=;
        b=ZXusax41Xjts3TMNzd6u2sBqznC6pyNPor2Cgr4LJDlYm2nD/a797vFrLCp6YM0Naf
         lchwH7LvcDuxTnWCLiTC6aCx0936AV9LQg9xrWYFZtScWr6u3JStl+dILmATsg7ExsY6
         /4dK63OYMxHosFAwUcqEYQveP/JcKmPPmwSsmOmX0NVxEVdYLJeU0WYpik/mzxVPKGhR
         ROQW+04/UrEG2RalZJmb9vScbf5ZEt0vHTghHEiiEs1bU8wdScff4QSd5KjJ/0HPdbNv
         758s29STczK7sdqwnhDRFwu0JF0EdI1kUd3h2Zxp4pOa3yLg8DOJmT6vatTq6E6LtY6R
         XTYg==
X-Gm-Message-State: AFuF++lDHBWy/OWOFFnMXy5HBQy5aeMLh8hgk7Ji+rOyKkBckb5DMvlC
	Pfdp8F7ktKkcSJfLQCxQME+m2dKNSvvE0R5GWIfJKTbr+2uTvRhuLnnofRWxzY1xYyqMGLcz
X-Gm-Gg: AYBFou1G4PtaPFWAZ7DLpmWHfAA6pF0WIW8bJoCAZgrZzrReDoo7FOcxu2GtqH5hqjr
	G6sPLt7lclGrDDo4KbchhhJTdDY76S11nZ9lyHm2gBiABT0t0BfL2pfC6EaupBSjMVBpDJovv1j
	6v0QA6ko4sbm0fB+tEB1Woyrlj79R4qvPaqAtOhqmxVjuqyoQov9K330yijsKc7ka5NfhGng2bB
	/t6wbG+czfkET8fKlOajZ4UjuzWjSXGw18yp4FftICBrKIkB02RB9Y5D/+SXWGJ/ryhSk6wj/g+
	XfBmZaoE6Tm3SahYIzyEqTCwn0ll7B4PpD8pV12NpCoNsgBcbO9RnYBj+lr/wfOQX03tE9qksnq
	RzgxgnLIO30tDTm4loWQ36/rctTnjSXcpNFaIlXc19K1vogMMwKn3btzehgkpeVfwY63JPzOUJP
	W5qMsAe42Rr0bj//fK0Ezbw5KH1MpqKb2RMVqOivCB/ECAUKJKOwbpD0BDPUi05rSaINHKcjF4w
	q04I6D0FkLlqx98j3uMAW5OnA==
X-Received: by 2002:a05:6a20:3949:b0:3de:3d35:c646 with SMTP id adf61e73a8af0-3de9e01da33mr1932270637.4.1790786440522;
        Wed, 30 Sep 2026 09:40:40 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([120.235.123.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7e54a4121sm168735a12.20.2026.09.30.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:40:39 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf v3 2/2] bpf: reject incompatible protocol changes
Date: Thu,  1 Oct 2026 00:40:20 +0800
Message-ID: <20260930164020.41006-2-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930164020.41006-1-shlomojune6@gmail.com>
References: <20260930164020.41006-1-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An skb assigned to a socket by bpf_sk_assign() can later have its L3
protocol changed by bpf_skb_change_proto() or bpf_skb_adjust_room().
Without revalidation, this bypasses the assignment-time family check.

Reject incompatible protocol changes before modifying the skb, including L3
encapsulation and decapsulation. Reuse the assignment family predicate and
preserve the socket assignment when the change is rejected.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Assisted-by: LLM
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
Changes since v2:
- Check compatibility before changing the skb, preserving the socket
  assignment instead of calling skb_orphan().
- Cover L3 encapsulation and decapsulation in bpf_skb_adjust_room(), as well
  as bpf_skb_change_proto().

Changes since v1:
- Revalidate prefetched sockets after bpf_skb_change_proto() changes the
  packet protocol, closing a bypass of assignment-time validation.
- Preserve compatible dual-stack assignments and release incompatible
  assignments through their existing skb destructor.
- Split the fix into two patches and target the BPF fixes tree.

v2:
https://lore.kernel.org/netdev/20260911172313.64009-2-shlomojune6@gmail.com/

v1:
https://lore.kernel.org/netdev/20260823101809.26802-1-shlomojune6@gmail.com/
---
 include/uapi/linux/bpf.h       | 10 ++++++++++
 net/core/filter.c              | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 10 ++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5d8f5e2c8db38..d1897ee13a66c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2659,6 +2659,11 @@ union bpf_attr {
  * 		checked and segments are recalculated by the GSO/GRO engine.
  * 		The size for GSO target is adapted as well.
  *
+ *		If the skb was assigned to a socket by **bpf_sk_assign** and
+ *		the requested protocol is incompatible with that socket, the
+ *		helper returns **-EAFNOSUPPORT** before translating the packet.
+ *		The skb assignment is preserved.
+ *
  * 		All values for *flags* are reserved for future usage, and must
  * 		be left at zero.
  *
@@ -3067,6 +3072,11 @@ union bpf_attr {
  *		removed from the packet. This handles cases where all tunnel
  *		layers have been decapsulated.
  *
+ *		If an L3 encapsulation or decapsulation would produce a
+ *		protocol incompatible with a socket assigned by
+ *		**bpf_sk_assign**, the helper returns **-EAFNOSUPPORT** before
+ *		changing the packet. The skb assignment is preserved.
+ *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
  * 		previously done by the verifier are invalidated and must be
diff --git a/net/core/filter.c b/net/core/filter.c
index 5f64065523584..09816da113554 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3549,6 +3549,12 @@ static bool bpf_sk_assign_family_ok(const struct sk_buff *skb,
 	return bpf_sk_assign_family_ok_proto(sk, skb_protocol(skb, true));
 }
 
+static bool bpf_skb_proto_change_sk_ok(struct sk_buff *skb, __be16 proto)
+{
+	return !skb_sk_is_prefetched(skb) ||
+	       bpf_sk_assign_family_ok_proto(skb->sk, proto);
+}
+
 BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 	   u64, flags)
 {
@@ -3556,6 +3562,12 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 
 	if (unlikely(flags))
 		return -EINVAL;
+	if (((skb->protocol == htons(ETH_P_IP) &&
+	      proto == htons(ETH_P_IPV6)) ||
+	     (skb->protocol == htons(ETH_P_IPV6) &&
+	      proto == htons(ETH_P_IP))) &&
+	    !bpf_skb_proto_change_sk_ok(skb, proto))
+		return -EAFNOSUPPORT;
 
 	/* General idea is that this helper does the basic groundwork
 	 * needed for changing the protocol, and eBPF program fills the
@@ -3699,6 +3711,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		if (inner_mac_len > len_diff)
 			return -EINVAL;
 		inner_trans = skb->transport_header;
+
+		if (!bpf_skb_proto_change_sk_ok(skb,
+						flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 ?
+						htons(ETH_P_IPV6) : htons(ETH_P_IP)))
+			return -EAFNOSUPPORT;
 	}
 
 	ret = bpf_skb_net_hdr_push(skb, off, len_diff);
@@ -3786,6 +3803,12 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
+	if (decap &&
+	    !bpf_skb_proto_change_sk_ok(skb,
+					flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6 ?
+					htons(ETH_P_IPV6) : htons(ETH_P_IP)))
+		return -EAFNOSUPPORT;
+
 	ret = skb_unclone(skb, GFP_ATOMIC);
 	if (unlikely(ret < 0))
 		return ret;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5d8f5e2c8db38..d1897ee13a66c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2659,6 +2659,11 @@ union bpf_attr {
  * 		checked and segments are recalculated by the GSO/GRO engine.
  * 		The size for GSO target is adapted as well.
  *
+ *		If the skb was assigned to a socket by **bpf_sk_assign** and
+ *		the requested protocol is incompatible with that socket, the
+ *		helper returns **-EAFNOSUPPORT** before translating the packet.
+ *		The skb assignment is preserved.
+ *
  * 		All values for *flags* are reserved for future usage, and must
  * 		be left at zero.
  *
@@ -3067,6 +3072,11 @@ union bpf_attr {
  *		removed from the packet. This handles cases where all tunnel
  *		layers have been decapsulated.
  *
+ *		If an L3 encapsulation or decapsulation would produce a
+ *		protocol incompatible with a socket assigned by
+ *		**bpf_sk_assign**, the helper returns **-EAFNOSUPPORT** before
+ *		changing the packet. The skb assignment is preserved.
+ *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
  * 		previously done by the verifier are invalidated and must be
-- 
2.43.0
