Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406612;
	b=sCunEUZWnKKmte6RWBKRhO58ftM01ujRyAM7dBCX/QQShDQj4w2bCbyzG9WIOYcH+wA+
	 N+0qO83sNrp0WZa0PIrIVf8IPCxvlvN57dARcdyxd96iQBNvmg9b4kl1416ZpHEziMoLZ
	 lkuE12d7SNdV+16j3Xo1QDowcqh0lL1ASCm9JgZ07yr5X/PzyehaF+79OFyeoFNvFYqPz
	 Wo6AvN8xRUsKWSlGmpn4aTzl6EQ/lG21ROZkfMqIm/Bf2xsZN/Ds0zIC4Ao1dA/pKLy4Z
	 6AXBZtOtKvQ233mMN5CBVW8eBFlivcDrKzDy0QexloLRT/EIHir/PHPtEmRamcQuPSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rxh6ySQw4OyzmF+zvez+p31cAvwAIQMJM/KeP5k2znw=;
	b=tB//Q31NbkbtbsAZU5kk2Nhkf9kGjrbMnp/daC9CssXJ3K0YxLUHR5Zn6qrXdsU9dgpd
	 k3ijy/h6BY/j32ybQaQCZsdBCSQCNxlZ5NyKf60LSRs5hsLiiYocpeDSH1alXcds7RBIJ
	 FE/xjm2mTVRUtliPzS4EZZGFtFxaLxA1UMSa0LivGJrsBfjdZSq4NvA88009PEnvIYTbj
	 8MFGAePZtl8Lw/FgfIxTZWgAIl8bJ9KuTTl6j7Fte6WqNbXyeseua3ZB2xlqczg8l+YQL
	 A6MDQjVhiLQPKM/EDniMj4td+UKI8mCxo0dBEVc4jGP/QRptC1+ddTpiMQCjFtJ+HBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=PkOuAvhP;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4009606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4009606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=PkOuAvhP
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53664b4860bso30918241cf.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794406611; x=1795011411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxh6ySQw4OyzmF+zvez+p31cAvwAIQMJM/KeP5k2znw=;
        b=PkOuAvhPVdtzJ3wJgKaLOTUIfWGW2ZvolzadQnNSWT0uvvZq9KvTMm6jBKhUkb6MaE
         BCHFnx5z6Bo5mDTJGyI6oPI6IeT7T0KK0DY1aErqz+2uFReDs38ZFl6kgYnPkeVGiKUB
         whj4ZiaJEzjJNVw8xmStgAv0PsTye5lxa6S2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406611; x=1795011411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxh6ySQw4OyzmF+zvez+p31cAvwAIQMJM/KeP5k2znw=;
        b=lbzQgwa7tkOaBqmSYWLM/4GWH6tp+hK3v5o0n4Amd6vkoCci3wpiD7quvcoTrl43qF
         P01MLFM07JJyzQBqCZa78C4XTWAzIe43nBzUO0NAqnZp4RjmxPc9zCTedUAGeBwVqn7R
         4hBRbrWl08hyKjRJVHvuUhJ1DmjI/zjyefYyLJ12Fn5mTBivOadImP25O5NhKBf2mG20
         5tW3JlQbnh3kjyu1O6vhHQ7m5FqCGLNVpIfiVAFi/YIkKuPARQ4RtbjMPmWGYRx9n3lj
         ZaOyAKvtFbyC7+LHnLddWMkVScCLLKnhstRUwtIUMnvZ0tlonTajRVDdbdltU7Y5oxgW
         wFfg==
X-Forwarded-Encrypted: i=1; AL+hErESDBEEfTtIc55raoyEzT02K6rvd8IPbXNjgIC4jdbH4RmsJ+7Xz18WvVYsDDs00vN4vMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rqe1R98Iitifj5g0fyVulj6L9tt4BD97unLZgKl8maSv5Syvd
	YWV/Z6KyXbHujX9pMm+UYRPh/zOyLOhYatNuiAk5hYrLH/XOzZLHwqanB4ycLOQONA==
X-Gm-Gg: AYBFou2bgZmuv515LG+lG3pu1t3T4pwq9DhYJKOz7hDyZBY2y2HkVEmzfY7Rr++qkVW
	yGXHDxytlWmDw0loNdEiEw+5q6JBNiq42GaM6ht5tdicN0P7a3hA+cqWuxciLey9mMzaZvaN78H
	Sd6oR8EzCVPRcnYNg2PM1QdZeGsWq8tkVRX7JL0zBrVpf4yMAZ6vi4muqC8O8yE1JS8zWztBLn8
	TwkLDMUub6tE8FiVB3TD0LhMLYz1/eKSlwxDIJ6f3BHiICUnzpAX5GyNdff7P6o5zOHfIQ5qrbg
	BuLTqPIr6QQ/Ras3FKNJrZEdJoj+184HdpCA3WnQvyiRJEpHRjEqv0Dc+nZfmruRLEBEz/4o1a5
	A7cSTFIB8+z8FkWucIhji5vsqsl2t4+xlIQwNd5g6rXwM6zR2cx0d8T6TLpVmo7ls/pPWMuhND6
	nG4tIqPpkIJFoo8G+l6P4iGB09jFFNP0fNyjmv/9VoQ9YgAqyZ1PSkTKrhqSzl5Y/GoByw5Kmyy
	C6qplg38ALesbuVkRNZEy5SHKgv7OlL1/eshFprIdbQkfgk93vhdDL9Bo1Ji/DWvV+ZLK5su/jL
	MI9z0iFY+TCB8ccrAzhLtLDN0EJSLJ0ao74H6xjRsPO8R+R0y8tW+L5Fjsk0IQ+u3twtB/gy33S
	kOCAG80n1MnbYvg==
X-Received: by 2002:a05:622a:13d4:b0:532:cacd:e420 with SMTP id d75a77b69052e-556bdbeb543mr38533561cf.6.1794406610942;
        Wed, 11 Nov 2026 06:16:50 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550be2e592sm51505041cf.24.2026.11.11.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:16:49 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 2/2] bpf: drop the stale dst when redirecting to an explicit nexthop
Date: Wed, 11 Nov 2026 09:16:38 -0500
Message-Id: <CORE-9NOG.v1.r0.20261111073528-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
References: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
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

This is a followup of the review of the teql arp-queue fix as reported
by Sashiko.

The issue: __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6()
install a dst for the redirect target only when the program lets the
helper do the FIB lookup. With BPF_F_NEXTHOP the program supplies the
nexthop, the lookup is skipped, and whatever dst the packet arrived
with stays attached while bpf_out_neigh_v{4,6}() switch skb->dev to the
target device. If that device's neighbour is incomplete the packet is
parked on its arp_queue with the original route's dst; draining the
queue re-looks the neighbour up from that dst and builds the frame with
the original device's link-layer header, then transmits it on the target
device.

The Fix: drop the dst when the nexthop is supplied. That branch never
consults the route dst, so nothing is lost, and the queue drain keeps
the target device's parking neighbour.

Conditions to recreate the bug: two network namespaces, A (10.10.0.1/24)
and B (10.1.0.1/24) in one, their veth peers in the other with only A's
peer addressed (10.10.0.2/24) so B's nexthop cannot be resolved by ARP.
Resolve A's neighbour for 10.10.0.2 as permanent and attach a cls_bpf
egress program to A, with vb the index of B:

    struct bpf_redir_neigh nh = { .nh_family = AF_INET,
                                  .ipv4_nh = htonl(0x0a010002) };

    return bpf_redirect_neigh(vb, &nh, sizeof(nh), 0);

Send one packet to 10.10.0.2. It is parked on B's incomplete neighbour
for 10.1.0.2; once that neighbour becomes valid the frame leaves B
carrying A's source address and A's neighbour as the destination.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index aca8160b26a1..2af24f371648 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2318,6 +2318,8 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 		skb_dst_set(skb, dst);
 	} else if (nh->nh_family != AF_INET6) {
 		goto out_drop;
+	} else {
+		skb_dst_drop(skb);
 	}
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
@@ -2433,6 +2435,8 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 		skb_dst_drop(skb);
 		skb_dst_set(skb, &rt->dst);
+	} else {
+		skb_dst_drop(skb);
 	}
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
-- 
2.43.0

