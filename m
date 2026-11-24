Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555059;
	b=ldQucY0kEv1QaVAtLEg3OjWMpxk3AhFknrHMCGpZdAiZfjLztdGhSWSEjjz7MCztgcVi
	 lgY666ZObLbRbxp0bQKXXd6sZ/yPX6ObXYm8yLOTL0dtil2CmA1/msY/9LRddU9gdFHOD
	 R/BQ7AWpOKEHw+CKYiMdT0BOHt3Gc9Mg1x1+VFopX8NGGTZF0zqBMMXeLIjvj9WbhZWZp
	 c9vkbhYbLsFGKLslTb47x2EXvLoRURj2lmF0Jz6eksZ+S7695nPGtGNZSqx6bQSlFgrOU
	 XGnxTyMZ/k9q/aGduAbBfudGRfjj+dMNYckjHIHUx5SwxxOIY4Oj1E2OV4PV1tYTlPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6/Eo4P9Q5rSLruD9XOambCG6ddcXLpv660iZmjCXc5Y=;
	b=YI9s1NT77x5nYRrz/TULCb4Kk5eCfzdDg7NhjzK1AOX7qMTTKDmhz/KTNI2p72t00lgq
	 fKUUmTaKg+FaCWiLD3EZBPVU4sw098WDJ3nHOXbmtdKHgL51KCOmE382Be+kX3jAUv3yA
	 Ej8yQkx/4YfW0q6nXafwkV5dAgBG6wJt+D/eV5HjBlZOI5ZKKsoRMfgTa+AnfD2BIpJTl
	 dQbSUKrLjVN3ac99WEnFLSLbM9vDMRh/AJrXf3TH7DpZgkJa2nPml1W+L1d8BgAt4U4/u
	 uy6vtNpAtKz/kotcl82qUTRBZT7cI/KmL1dJYbdER2Thn5F4nmkTaBW25bntmM7Fx9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GL2PIYrI;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE85606A6BB
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE85606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GL2PIYrI
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5348aaba5so5438255e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795555055; x=1796159855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/Eo4P9Q5rSLruD9XOambCG6ddcXLpv660iZmjCXc5Y=;
        b=GL2PIYrIRpaC5rEfwK58c4QXdqCa62VtMZeg/Gf53XM/8avpaP3BiMh3NxbbFalaNX
         6TPayS4v0zk2Z7E6zpWNN8y63hw+NozjuUfQJq3931vwVaoIfWgF5FbIxrcPBdwlmogt
         oW21UZVGoo6oWvk2rJgdK1Rhb/79yD+Ca5fp7caFv/ZyUSmxmh7p/1MOml30zBU6HIfi
         Mgu876CjesSi0Kc4c6jLwivGfmq5tdlW1X2SOsk9t1dXdEhiM+BQrmY/EqaVRq1RdWPb
         e3UlDe5zqGBoOwnFFh0Yuhbk8Ezl60AUhi79R+mQIG610LaBXv2pQAeBytJoq2OmkXmt
         NHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795555055; x=1796159855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/Eo4P9Q5rSLruD9XOambCG6ddcXLpv660iZmjCXc5Y=;
        b=bCjGIRkfeL+wrjp6UsgY382shzYZoIotx49OrT1LXpbmfsr/Vm2kal4gVjTJZSOZoQ
         BA20pIGnxAHtyXxOSYGHR8K2uS8nPQGR7LnOJppooZx6z9B0xb7rE6JuoONC1gwgVKSv
         qF70N0HD8lJyOi5T/j8GY0yNQ3i87K9e/UGuaUUwTJKIc8uvhKuwB1Wep3BNziuMEVf0
         h3nJd9fGvBH412mp9abRQYYTVWETXjX16bq0Jg7yEeYYVwcY0hocFJhlNE2DB/sA+Vg+
         yXTuSuZOFM2Ueh1kIMj9O56sn4cpfLpK2eAegpocM0qTP9kULhfdPM0VH5DowbZmK3IP
         zipQ==
X-Forwarded-Encrypted: i=1; AL+hErE9HdGCFAbb/zrpdjrZJOzExvheZdi1ILtKVQ5TWNtgtNLCz7+/os4YKWNf365r1zHvPkI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nirlTIzGU5Qkx7X8YSDqFjOtWIjXhEBjKgVjghas5vxJFJSvw
	mRdEzSCtr8WjLgtXUJEgpUg0143gtZxorH5KrTQLdWCVbxLIrpy/yECR
X-Gm-Gg: AZFdTZe9v3HzwgsAaKjJoWu4i1+wfhBnp8uDHwbb4fE5t4RIjzCdZ+LDrbv+CyL27c+
	tzWjzX4ud8NsheraBosEE5RiZQI4OG49VqHE9Zn1FMamGfPLxhdIzsAqu99gqhXFkfy9ijmEB2f
	jHrJDetH3m6IpZcQCYW8cyEEyOzkWLb0xB4XDW2lVxN18/KJ/esI6KTPbn5FUp6SRNXD7IWFX/g
	dQ2CYmg8jiOItz0ZHWKqGVVda9JMaURPbyVS/WpaJJtx+qmvzvQOfdnsDHDq+qPspwHUfh4CSiD
	7ono6FM7l9iOOobYKVtOlDoS3bbhcuQRKT/PL609XndGJ59zHEor0f4pVUUA5idj5AFsn9+ZyTV
	405476umArtym6wk3oEk29fwrz5WAopkpq4r172Z/kJcUvH29Mdk+Nmq/BjRXmFy8ZtVBEe7Yh/
	KQaCUoCPyuArmTcz4y7+To6ArfANhGXmO2n2gOTfKgG1wdRHQNR2rqUj2zNfV6hl6gkp8ZKIB8W
	rsDboBzxRniFj7HoBoTEh+yrtvMuK8F1EXCSRcp9oY9QsetQFKmR/xj3iHAbjGJVSzqHjEiWzNJ
	Xmnj1jf03k+BDYMK+btBAHvzXVq4ANhaR5rbR1tJlG/KcVCpS/jL+/a11rHV/vqBq0Op
X-Received: by 2002:a05:6000:4a15:b0:4a6:9f2f:4151 with SMTP id ffacd0b85a97d-4aba57e9972mr28188997f8f.0.1795555054760;
        Tue, 24 Nov 2026 13:17:34 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.4.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm29347713f8f.36.2026.11.24.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:17:34 -0800 (PST)
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
Subject: [PATCH net-next v6 2/2] selftests: net: veth: propagate check failures to exit status
Date: Tue, 24 Nov 2026 22:16:45 +0100
Message-ID: <20261124211645.5751-3-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124211645.5751-1-emmaonana18@gmail.com>
References: <20261124211645.5751-1-emmaonana18@gmail.com>
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

chk_channels() reports mismatches with a "fail" line but never sets
ret, so the script exits 0 even when channel counts are wrong. Every
other check helper in the file (__chk_flag, chk_xdp_feature, chk_gro)
sets ret=1 on failure, and all chk_channels() call sites expect the
check to pass. Set ret=1 on mismatch.

Three more checks in veth.sh print "fail - set operation successful
?!?" without setting ret: "bad setting: XDP with RX nr less than TX",
"bad setting: reducing RX nr below peer TX with XDP set", and "bad
setting: increasing peer TX nr above RX with XDP set". A kernel that
wrongly accepts any of these invalid operations would be reported yet
the script would still exit 0. Wrap each fail branch so it sets ret=1.

Reported-by: Tianyi Gao <tianyi@cloudflare.com>
Link: https://lore.kernel.org/all/CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com/
Tested-by: Tianyi Gao <tianyi@cloudflare.com>
Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 22246278e6049..6eeb123aaf885 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -130,6 +130,7 @@ chk_channels() {
 		echo " ok "
 	else
 		echo " fail rx:$rx:$cur_rx tx:$tx:$cur_tx combined:n/a:$cur_combined"
+		ret=1
 	fi
 }
 
@@ -473,9 +474,13 @@ if [ $CPUS -gt 1 ]; then
 	ip netns exec $NS_DST ethtool -L veth$DST rx 1 tx 2 2>/dev/null
 	ip netns exec $NS_SRC ethtool -L veth$SRC rx 1 tx 2 2>/dev/null
 	printf "%-60s" "bad setting: XDP with RX nr less than TX"
-	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} \
-		section xdp 2>/dev/null &&\
-		echo "fail - set operation successful ?!?" || echo " ok "
+	if ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} \
+		section xdp 2>/dev/null; then
+		echo "fail - set operation successful ?!?"
+		ret=1
+	else
+		echo " ok "
+	fi
 
 	# the following tests will run with multiple channels active
 	ip netns exec $NS_SRC ethtool -L veth$SRC rx 2
@@ -483,16 +488,24 @@ if [ $CPUS -gt 1 ]; then
 	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} \
 		section xdp 2>/dev/null
 	printf "%-60s" "bad setting: reducing RX nr below peer TX with XDP set"
-	ip netns exec $NS_DST ethtool -L veth$DST rx 1 2>/dev/null &&\
-		echo "fail - set operation successful ?!?" || echo " ok "
+	if ip netns exec $NS_DST ethtool -L veth$DST rx 1 2>/dev/null; then
+		echo "fail - set operation successful ?!?"
+		ret=1
+	else
+		echo " ok "
+	fi
 	CUR_RX=2
 	CUR_TX=2
 fi
 
 if [ $CPUS -gt 2 ]; then
 	printf "%-60s" "bad setting: increasing peer TX nr above RX with XDP set"
-	ip netns exec $NS_SRC ethtool -L veth$SRC tx 3 2>/dev/null &&\
-		echo "fail - set operation successful ?!?" || echo " ok "
+	if ip netns exec $NS_SRC ethtool -L veth$SRC tx 3 2>/dev/null; then
+		echo "fail - set operation successful ?!?"
+		ret=1
+	else
+		echo " ok "
+	fi
 	chk_channels "setting invalid channels nr" $DST 2 2
 fi
 
-- 
2.43.0

