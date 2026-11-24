Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560672;
	b=oOzBcj95J5ufk3YnEZGUrrC8aCqJWf4OnmvLTtIaXR7Xprr/BVtHm/v7mS3oc+cwEYQy
	 K8k7h0tD+CiIGd8FiDqD6VNhw7r8p9ilhiGK6wkv0h3PB+v8vj0ZOfMaiRBvlYL9id9PW
	 9Ekw+jKeWs0j7GnkE7fmvbJIxAoOhEi+n7w8z1KMavH6/GoC1y1LrxamOoLX8UjUVTTus
	 iBT2EVVLgw2n1Q2bap0ePTWNsZEIHki0nCCURMPob7PoBX6heo9RIZoFb6Mm23kzWCFVy
	 9hQELb+Ii9LI64AVJY+kuDH/I/6u2IFMmeDFXqVBV6B4VmvP7EL3z4dUmYFImhwn1Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=liov99GJPDwRp7LfHV3OU/QCtwG0K/vL8qG58IkGVsE=;
	b=3EkUlh8uxlcE+ZUiDe4rH7DcA/U99flSOwpqoF9uRniaumD1jPikg6dxnKLdAl4LCRpy
	 V2sE1yngR6Ntv9j5QjpdpijfBSTdnUmjhzZuVXkDumT1/H4fxy6rbZI0A86vrLBIhb1EI
	 D6S3RS4OiQDIrdgfltjyXTbnK7wEbheFopy4SG39sRR/O4M/0GMJ4037Ft/4KoBG+hcJc
	 2XUOI7bCUF3iEdg56Nq29EdBZqc+TtRDBgebRxr6QzuNMdKz5nwuzrePtnMffBPX1RgKJ
	 Ng12yqrwGCpgM4uZ2D4TXLAtRt3jRbuqONGNJR0zIJwH/R9AUo7QRwvEhBvkUHJURkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7CCnyK8;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC097606A32D
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC097606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7CCnyK8
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so47007735e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560670; x=1796165470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=liov99GJPDwRp7LfHV3OU/QCtwG0K/vL8qG58IkGVsE=;
        b=c7CCnyK8URyZ9d10mCgzJpitaKd/+AjqVzwHrg5k51Vx9aWB+J/Ux9cNLFtfPYcnbQ
         Gid+Ipfb+j/Wp5m2fAgCoGN6OPnVS+N3Ft7w1GeZ/zICiIMte/cRknVcxiuoMMQ4dpqE
         i1iDRNZsV9jVs5BbJJaq1mcTuZ/3K1jGXIe+v2agmaiFiDCGhTNqRzKRr14MkTdTBJ3r
         l+n5Ip1fcds/4evknI73/99/exlvJiOV1O/GfJQ+MqsQ09CkSO51OmKGyXW21k7EOw2Q
         j6T8Zk29kZaV9y591HUMDnQUD+jJDdry9jfzSW8SLM6LrNHQDnZ9gweXI3h4YPJMpzKv
         a/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560670; x=1796165470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=liov99GJPDwRp7LfHV3OU/QCtwG0K/vL8qG58IkGVsE=;
        b=NhYCR5umJLBhM6ubY236EiilMB/nFsXLZV0MVDLzKX6FeJHItmJdxSLwLOdxc2LjxD
         Nge56cDp8eWnu638NON+jyTJD7QNHX11GV2iCJ9HcArCpaXxA6HnuXXy2GOWpaYTnBdP
         nOZDjjNInDHNhZGf8h3L3qqnb7UxWRDq95WdxRgGRNUszW/tvlttjPaITLi7N+8UAwOL
         U0s0Vn8Lkd6lyw6ZbKrJCw3HUUwq2io8BJuTtJ31JaAsCYC+oaV6ewU1f97NdyX/1b4W
         n55dVqx+f3pYwKdhO1aEZqHSJ+SGS0uc4HlxigapNvWdBTj6OIbbFsGgeqPQYPlRKhwn
         8Z4w==
X-Gm-Message-State: APuU4Z9k29dXXRgIR9f5SQOUpVgnsX4kgZDZMXOlYvNEvT10PH6gFvsI
	alKJYYIkKgSc0WOsUqx56cDmAmXPn4abryti0EoSpPO8LYpBKOHDAng82WnnUJA=
X-Gm-Gg: AZFdTZelVRtVzC3pTe12sLtmL/YrV67lP0XL8ubYjHHHcDyiBR8eTQnGOnYSL1lGBvx
	VmrMScDrYNKuc7x7HTtqN5VflE8rMY9OVbKldPWBlRxlVqkF9RY/tnuZdTAMMq3Dh9GTYTOXZMR
	gRR6BYjiNekHgtBURBJTmxOwZomqO04w+WjHnq4+kGCEgwKAI85vHINi4MsrvX2yoi5leo/W1vo
	PEupeE2U1h22qmdxpKpdKNCBJ3iY5ZIGQ+1PolZgqSk05zhPiyCxwV4xYsSW++ooAjSBGNKcW1l
	LpkQPeWzL4BxZMAGWzXPG6hHwJisajhzmNQ3fH5BUiezY1+x4xcN+ZPlFQs86i32T3PKIexVdJF
	SOnpjYwlsV3uZwr0RkwTK3PyFPwuKMxZlaeDD17k5dXVSokkzSVOk3SiWj4fb+WrSJ/LmbsBCOB
	dhLQ9LpEMfjVoCZHOG4R/Uh6J2bHBlDPfdkmLm/Lof7NR/PPvD/ISjLb7XEmsbGtrYeiVZT77Gs
	QUzXmhzwIJqbPnBNtP4lHxI1ULNv9jTFCYQk9CC3XOGRj5xDhAzhOazvceZHWzDtxxsanBe7G54
	2EdEB3nv4RbPvqe3br39FJquuUoPpRkSr4z5BqDCgRYh5AQinWj6jPBxjx0FG8bXUnpLk8ROcqn
	xhDYqwBhxYrTbKfp8FbFGT4jL2QR1FFmcfgjnWun51cuazmdETaLxKZAxUCVkC/lvgxW2gNA2zE
	PlLDbcNDt2W39AkYVfQN3qx9YPbRTeC8Y0
X-Received: by 2002:a05:600c:8b11:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4bb8881d194mr335283135e9.27.1795560670058;
        Tue, 24 Nov 2026 14:51:10 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-2ec1-8a00-a10d-4335-1e05-e7ae.310.pool.telefonica.de. [2a02:3100:2ec1:8a00:a10d:4335:1e05:e7ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm393839525e9.9.2026.11.24.14.51.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 14:51:09 -0800 (PST)
From: Tobias Philipp <tphilipp@gmail.com>
To: bpf@vger.kernel.org
Cc: Tobias Philipp <tphilipp@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	=?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks@slashdirt.org>,
	Stijn Tintel <stijn@linux-ipv6.be>,
	Daniel Mack <daniel@zonque.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] bpf: Align devmap values to 8 bytes
Date: Tue, 24 Nov 2026 23:50:54 +0100
Message-ID: <20261124225055.87344-4-tphilipp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124225055.87344-1-tphilipp@gmail.com>
References: <20261124225055.87344-1-tphilipp@gmail.com>
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

dev_map_lookup_elem() and dev_map_hash_lookup_elem() return &obj->val
as the map value. In struct bpf_dtab_netdev, val follows
"unsigned int idx" and is at offset 52 on 64-bit and 28 on 32-bit
architectures, so it is only 4-byte aligned.

devmap is read-only for BPF programs, but the verifier assumes that map
values are 8-byte aligned and accepts a 64-bit load-acquire at offset 0
of a struct bpf_devmap_val value on 64-bit architectures. The arm64 JIT
emits LDAR for it, which raises an alignment fault on a misaligned
address. FEAT_LSE2 does not change that, because Linux does not set
SCTLR_EL1.nAA. The fault is not fixed up.

Mark val as __aligned(8). On 64-bit it moves to offset 56 and the size
of struct bpf_dtab_netdev stays 64 bytes. On 32-bit the verifier
rejects 64-bit load-acquire, so the misaligned value is harmless there.
Aligning it anyway keeps all map values 8-byte aligned and grows the
struct from 36 to 40 bytes. Entries are allocated with kmalloc, which
provides at least 8-byte alignment.

This patch was written with the help of an AI coding assistant
(Claude Opus 5.5).

Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
Signed-off-by: Tobias Philipp <tphilipp@gmail.com>
---
 kernel/bpf/devmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 1b8f0d7f8..0ef24e3f9 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -70,7 +70,10 @@ struct bpf_dtab_netdev {
 	struct bpf_prog *xdp_prog;
 	struct rcu_head rcu;
 	unsigned int idx;
-	struct bpf_devmap_val val;
+	/* Returned to BPF programs as the map value, which the verifier
+	 * assumes to be 8-byte aligned.
+	 */
+	struct bpf_devmap_val val __aligned(8);
 };
 
 struct bpf_dtab {
-- 
2.54.0 (Apple Git-157)

