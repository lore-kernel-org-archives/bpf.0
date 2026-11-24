Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556451;
	b=Rk2S/P/BixNKCQ6WhXx0nfja8mYj7UF5gCn7BLSawxqSyeGTmvIsp4u4ZNuOsK6XdqiP
	 fxqZDdYX50mDXlADt/WO+XnotsvWQxN+vAGAzAeX2/1hkAlKt6XVQYdeNFfZPLMRfti9B
	 x3u0Hdpg7+2j2XGnxs9lDtyM80RxeyV0biD7puE3tuuhRCo+Ux7YeMQ7kSErB/D84TRvr
	 fn2FepWn79N72CtAkqiDEC88K5OWuVkAX0NRMF/XQmZkgmKFNXFEd1neAQ3OCXG227APH
	 ANRv0JBYqRRaOKAXjfKK+EhjlueokSBp7d9ymNkL9UWQP17BTvv46G/QJAxSvEpF5Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o2HebQcADRBDbRAS/PnKH205LJY85BhrCi94R+RBG68=;
	b=IsSIhDQnIdK9MnSZRA+GVgQJBYq/c7mgkyxSBZjBCExykWm191GKo+mC7qSW1jQwz560
	 sRU1cPDkevojgA/mIigpzwEpQ31hYEpp/V60ASouaSckERbwzVwvmAJOuqsD4164+1p5R
	 Bz3kpi/B0wQBXj8VdN1BtVM63VfYREW6L7q9fcPGWITE2cyFU7OZ/vxfPxTzIblqkzglr
	 jJEo7TsLGZHJc6YvdsJbL8RA3xbRGXBu3mIm7SryZYPZ477zC6ua1+4ccGT3ymrB3okwJ
	 GAKNs+tJPF0WDQAQebNVHqX9kdu6OIOB+nWs6iSnxybTGOscKCoJIfc7upgF7OqTunA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgNL8acB;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47936606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47936606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgNL8acB
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a8eed31158so417540f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556449; x=1796161249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2HebQcADRBDbRAS/PnKH205LJY85BhrCi94R+RBG68=;
        b=tgNL8acBEFQiM09jqOQEKfm574cwa75oomLxVmAtzuC7msa6gwol4we64P9TRE1Dc7
         LXCA3IsW0m56tZnI0CQeb4Fm1L16FbwhcFbLuBopqGuvQRkrQNqL/neNI+9lyy3tn2PC
         f7coVRR4igE1DnyCqM1TZPV4Wo2SF40eBunmfhsZKzbfpatP7f6FHwEt/UPqFDXMdrbr
         yrGkO50XrHR5wyHxAKbkhWCwhQPLQeUTsIW9jKerUd+roFUgp5zxSlATOpCLFjL7eit7
         hNNj4fYtUfT7ndzyR8mLaNequNVrryrkOwM9FgKaxtjHwzgDreB2Yuq9hbI+Oou3lm1Y
         YSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556449; x=1796161249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2HebQcADRBDbRAS/PnKH205LJY85BhrCi94R+RBG68=;
        b=okd9oqoaNiWN7VjEihmZKZ/5rSjjPx7PLFJhK6xohWOR8DXu5Y6AjlbpflQdKdXTuK
         7QlClt97oh/Pd+wj4L5VTA1jtOqvVDZvtHYADpTpn43XsOpCECFKaE7r8uPMrbEaZJaS
         vl4FHI14v92aD1RcXAVjg0ccV8ftFUcJpxHejBtWbwF+4pcnwf42+zFxl3KB+knI/R0U
         JOdqP5MESNZoMZvLawxSdpLIA15UuL7zjw3nwbQOrdriXRq1v/QNkMwWSAuJmzzA/x8r
         r/jn90nEl3Un3Vza8YRkgq4AZRfMGDB/G+EXW8l8ZaHa3Yq2385ZAfIiZBK+kwoESU3z
         vbDg==
X-Forwarded-Encrypted: i=1; AL+hErGReiXvvWN7tHXdhfdSuphPw+05/IvyFUAlGcHjby6IzbEGco7gRa9t3fEsg5Dz/Cwwlv4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2CK4RMeKSn14qaa1rxcJStSmKPZne1x/lvCBjaOqrem5qCd70
	TJeV7Aokh336xv2HytObITzXP5mL9oA7WmPjuwanVf506QCrVeb1Dr1u
X-Gm-Gg: AZFdTZd4o1JkySrjFOjH69Yl6Q0b1YZCoewAan7cv7G/ZXD9+yQXzvCKp6vQrHFOdeZ
	Fuu6qfR7mOVKs6Dbj7GTnk3o24K0RUXF83iudlkwGVFjDvcMCKWB0EQwiHMohALQ1kabCaYkkN5
	/MUwgHemoXCpIuvgVRSkGwJUH/6A6Ea3jCzjzx66SX77Gml2gk9K4QdrjqmpFmnxW8M+uOifgMH
	Y0KYNvrOpSKTycN99gXNi5qR5ZqKvGQAzoPwKMfjdKt32fo6NoV/btWlFM0KapCsJ16hisQnxpe
	urFCHawmgZxYNJYdqkiZmNsj6LopVBLIbFahuD3RIplD3OfR26QpigkTnoqaNaDFOBi+z3pJmAv
	lVpQ3Bcz19o3ma4cllutsH81g4joSykD8I/HZA+enL7lxZrYG6iBgklQh/qzyA5Mvu2xqBaTxtD
	e21doA6YJt0WAk9jrYSFC7E3PRyiCS5XL4SplEelB8EzJU0RCS4ZDuVbn5FdiXv4RMV8jCxbYu/
	BUh2Z5Hl0KufBoiu2FOltcEaJ1cDIMjx59F8v0EgPSGHJY6Xuuo500ZT+dSACS5oJcKIfyPnU8j
	xKbbh2VvjXWz+aCdRCy3EIJh53b0y842uCGx3DnMUlyEJd/BLYkE5Sxk1u2D7bdDP36j
X-Received: by 2002:a05:6000:4817:b0:48e:eb:56a5 with SMTP id ffacd0b85a97d-4abb097b298mr35909736f8f.4.1795556449580;
        Tue, 24 Nov 2026 13:40:49 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.4.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm28290872f8f.34.2026.11.24.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:40:49 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: tianyi@cloudflare.com,
	hangbin.liu@linux.dev
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: [PATCH net-next v7 1/2] selftests: net: veth: derive invalid-tx test value from kernel max
Date: Tue, 24 Nov 2026 22:40:24 +0100
Message-ID: <20261124214025.11603-2-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124214025.11603-1-emmaonana18@gmail.com>
References: <20261124214025.11603-1-emmaonana18@gmail.com>
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

The "setting invalid channels nr" check treats CPUS+1 (CPUS=`nproc`)
as an invalid tx count, but the kernel allows up to max_tx, for veth
that is num_possible_cpus(). On hosts where nproc < num_possible_cpus
(taskset/cpuset confinement, QEMU maxcpus slots, hotplug firmware),
the ethtool -L call succeeds and chk_channels() reports a false
failure. With failure propagation fixed, this fails the whole script.

Query the kernel-reported maximum with ethtool -l (the same parsing
idiom chk_channels() uses, first match) and attempt max+1, which is
invalid on every host.

Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
Tested-by: Tianyi Gao <tianyi@cloudflare.com>
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 64c2a5a59821d..22246278e6049 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -463,7 +463,9 @@ fi
 ip netns exec $NS_DST ethtool -L veth$DST combined 2 2>/dev/null
 chk_channels "bad setting: combined channels" $DST $CUR_RX $CUR_TX
 
-ip netns exec $NS_DST ethtool -L veth$DST tx $((CPUS + 1)) 2>/dev/null
+MAX_TX=`ip netns exec $NS_DST ethtool -l veth$DST |\
+	grep TX: | head -n 1 | awk '{print $2}'`
+ip netns exec $NS_DST ethtool -L veth$DST tx $((MAX_TX + 1)) 2>/dev/null
 chk_channels "setting invalid channels nr" $DST $CUR_RX $CUR_TX
 
 if [ $CPUS -gt 1 ]; then
-- 
2.43.0

