Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627F3A1A22
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736451; cv=none; b=YV1FeSkUBL0gw8t4iFwwUhoNwRqs4oocBAdiPaHGUMYKNEjFYrixj09YV23RAJ2muZoX7T4FlfscozKTE0VvraqCWctu8t92jzZymhlm+Ri3OzeEn5OUXQYix32oZwN+RU1LhumhJNUdgj7/IQxVlV8ZdMoO+sOQkJljuViAJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736451; c=relaxed/simple;
	bh=yM6kJR9+j6KBxCtaM2cYf0AuV1XZewak4TynnyV+IJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKX4k1UQswyDH5EaXdMT8CN7vjJ6crc72gbnLu2/UoRrCn32JJsqdoSPM2vrtHiFqcfXMiuvCZ8FBqhguC8qi/uacy7BTq4KXpZRTitBqq6q5rhzXLiqwK8lZXgXuwde8DtA3t0Lnj/o/J5xt+utuA3YrpD4oZHzJShaHYx8m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db7lAJfT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db7lAJfT"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so115622a91.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781736449; x=1782341249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/ktcGtRdK8bOsxRZ/ZQSsMpZyLcq8Ea6Ees+j5Oy2A=;
        b=db7lAJfT2508SaTj8ZaJjvJLGtMNAIzbaFykFFUCY8wP618uagcRrrNNmxGCZI1wWV
         Xw2Gq/Db/wjFscO5Fz6w/0EKdvNwRwwR/iva/mAXSoJRjowls7i4zmbYVveHKwDfQepg
         2f34Rt+a7XFf0qm2rt+cQu37oKu5WqZsbElmktuArryLBZSF7uAh1TudDCb433+LhG5T
         7pbYH+LzPubGcShnXaLnquhrnZzdYketiAhHBW2z0q/u+emd9ja/d1/c8lNtRG2yldhU
         9QFm8tpCXHKwjRPBadweLHaMC7NmIgrfAV5oRBnR6o77i1tvOlMMTbPD/tLBHH+LTA+k
         xwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781736449; x=1782341249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/ktcGtRdK8bOsxRZ/ZQSsMpZyLcq8Ea6Ees+j5Oy2A=;
        b=Y9Ibd375SPCRC/SMcYrLbVtjB4T0N5Yyzh6glx4QLdgP5z9RImHeMcCih+c00HReCb
         ph1UX56ie5VFjUCCTsxXMJeSJQ6CvdyaaOk9Wj8T4wAotp6b5I90XYXm2VELckqsWrgE
         B24a7jVOCxKI1RdqUNoguQPbsYYDh6nJW+q7n9PM/3wY86HPoHyit/iLS0cl8+qm/89+
         hoTmJKKo03i2Nop68lHwcnZLy+SqjsITBO4zwNXYfgVNM0nA6fWRajxDJIMfBr5BoGeA
         5XzpJNSWSNqW/m9KvG3f9ji/O/gxD2WSHjaeoLrW04o+tUKsmeO7F6hg1nGRIftjuNCJ
         wHQw==
X-Gm-Message-State: AOJu0Yw4C3pXumYH7PN/jCxpTRg7zBXRRHkJH9LPkiMFUWTbSQAknq4F
	63HvSxIRdkMSmfndHTl3auwwrxAG/5GP1I9yn9+JWIId5RaoKFXccu1Q
X-Gm-Gg: AfdE7ckDhmn9KY7x9jiyQY3IXufVWMQpAHVqutdnN25EsdRG0nM/tvyvqBHikt84Cl/
	P/KA1GKpTHGEprazf/vVb67GwLkm/e2C0nWjt+oS7shk65jppY5ShXAOHd8Yu0t0y3aj2QyS7PQ
	TQ10fmU2PuuT9647ALhB19aLRHGKmhY5VmfZ+50Z/TSpDd8dFEpdHU0KSfmUqi4kSEX/SZ4Uc1/
	7ESucO1aZ7BL6cPK6FovuZdQwof3c8nOSwwJ3QMlt00Zd1RPKN4m6zTSADNpVOnSds3Hl2jPxxE
	gbhNFRrJiN/8VifPvUBnoupAyigCsS5MF6XhkjTu508Q/XZLuTvTA7WAkDgUNUkmLRiYjc3tQT1
	q1dQe0Igj2fzgcXJ9oCT96F9Q7dwP5C7BtPfCCnxsORPQdvSC7/0UodSA5q47RCzTqNtZFGaca5
	6VrnR/fhX4HQbE1g0/Svsvm9SynOSYBPg/r4lr9O+z1JYJEprZXDiDOCIH4LGz
X-Received: by 2002:a17:90b:2e85:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-37c94b136bdmr5931252a91.23.1781736449387;
        Wed, 17 Jun 2026 15:47:29 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5d505sm14890344a12.1.2026.06.17.15.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:47:28 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	song@kernel.org,
	toke@redhat.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf] bpf: zero-initialize the fib lookup flow struct
Date: Thu, 18 Jun 2026 04:17:19 +0530
Message-ID: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() build the flow key on
the stack with a bare "struct flowi4 fl4;" / "struct flowi6 fl6;" and
fill it field by field, but never set flowi4_l3mdev / flowi6_l3mdev.

On the non-DIRECT path the lookup goes through the fib rules whenever the
netns has custom rules, which a VRF installs:

	bpf_ipv4_fib_lookup() -> fib_lookup() -> __fib_lookup()
	  -> l3mdev_update_flow()   reads !fl->flowi_l3mdev
	  -> fib_rules_lookup() -> fib_rule_match()
	       -> l3mdev_fib_rule_match()   uses fl->flowi_l3mdev

l3mdev_update_flow() resolves the l3mdev master from the ingress device
only while the field is still zero. Left at a nonzero stack value the
resolution is skipped, and l3mdev_fib_rule_match() then tests that value
as an ifindex, so the VRF master is not resolved and the rule fails to
match: an ingress enslaved to a VRF can fail to select its table. FIB
rules matching on an L3 master device (l3mdev_fib_rule_iif_match()/
_oif_match()) read the same value, so an "ip rule iif/oif <vrf>"
mismatches the same way.

Zero-initialize the whole flow struct rather than adding one more
field assignment, so any flowi field added later is covered too.
ip_route_input_slow() likewise zeroes the field before its input lookup.

CONFIG_INIT_STACK_ALL_ZERO masks this by default, but it depends on
compiler support (CC_HAS_AUTO_VAR_INIT_ZERO), so INIT_STACK_NONE builds,
including older toolchains that fall back to it, are exposed. Built with
INIT_STACK_ALL_PATTERN, a plain bpf_fib_lookup (no VLAN, no DIRECT) over a
VRF slave whose destination is routed only in the VRF table returns
BPF_FIB_LKUP_RET_NOT_FWDED, and resolves with this patch. On the default
config the lookup succeeds either way, so ordinary testing does not catch
the bug.

Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..7c58df589826 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6139,7 +6139,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	struct in_device *in_dev;
 	struct net_device *dev;
 	struct fib_result res;
-	struct flowi4 fl4;
+	struct flowi4 fl4 = {};
 	u32 mtu = 0;
 	int err;
 
@@ -6279,7 +6279,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	struct neighbour *neigh;
 	struct net_device *dev;
 	struct inet6_dev *idev;
-	struct flowi6 fl6;
+	struct flowi6 fl6 = {};
 	int strict = 0;
 	int oif, err;
 	u32 mtu = 0;
-- 
2.54.0

