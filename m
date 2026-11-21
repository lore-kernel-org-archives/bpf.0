Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285681;
	b=tLaKqulJ8ygOpQ+Jh0ttCAPX3k1hEm6oFB26OR0ENzdLwsnkmQ5ePKBtnhNt/zAfTFU1
	 o+/ouF/67gyBQIDwgccCcEL+bzWKgh8u5eBOt8RYWIbfkOHG0cQEupwSQic6G1F8hoEQ8
	 UnK24KsP5Mz3ifKcKlwUArFAwg3ztZ3bc17cPA7XR1ZonPpRf8ZiuRKofm/QISrxBFoxA
	 ErWlumObs6XzUgr/JktpNlwmwE+3FJRe4mH54q5dKd+LKSO/Fvuq6B1kfoqSUarVeERdQ
	 /6e49nP7svqTufB+ysVOqxfIcOLbbNQIeMN2DJCGrVg2xqIGeUqcsZxiZqr/Om6dYRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5Og6NCy+0q6Ms7/gjrdBqKnQWMZOjV+DT8n7b5GCP2c=;
	b=GthrbiGOp8L7ATwD9fIlMc83/tBU6o9JmFc+6r1bKvRJftlk308mqWzwL9i9qITr1D07
	 0a9zsI0tCY9TB5cWKW180Ssn2ezqy0ldLzGz6617VbH88sBaPq1eB4sass4vOA4HSK4pq
	 sZBEUsQIvJ82EQA9Ozn8qmWa0uV5Kaa6Tf8PH0812nDlvxgEIWL/goep0Js/3xokth4x0
	 sAD0F1KaaxSUrjgcKdvfo5ypgGz5mRBxyq/ZqTCaiz9YtAGgkOWPR/ey8TCQYe70WeNur
	 eEJXw8gj2qDNXEBUbImO9SMjBbjxkoE19RCX4AnfwxOAZiuPmuMyxSxRK+Wp3X9kN3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyMluaa0;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC48606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 18:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC48606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyMluaa0
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb67b3a18aso1574945e9.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795285679; x=1795890479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Og6NCy+0q6Ms7/gjrdBqKnQWMZOjV+DT8n7b5GCP2c=;
        b=nyMluaa0J1C8Evy34JB1U2I9D51Q8jV2XWGP33Q29wwR04CdaApUHFGVZ2CgDIlzru
         6JtGhIgueKLnH8bgq4caltjkpVzFJlDPCnKVJp3MR6DXGXe933oVBlSg2XJKdhtgD9y6
         8ZDnyTSpLzDB15hwFqy2tPgVOVY2zXmdMPG2Nv6qlJih+3q+3wcN4Ny6qm1QUQvl2C3F
         hg+NKn/4Zn4b0mhLm8VFpPrvJvhoGR/IL1PBlQUZZR83ssKIcynL9HPYhajsYO9E+qlZ
         s+EL0mbWGwNTx3uSimOvIAEK0oLNMwvjW+ejd7sUdYqOrb9LpWhoA1aBBJidKPmRS7Ak
         ILsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795285679; x=1795890479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Og6NCy+0q6Ms7/gjrdBqKnQWMZOjV+DT8n7b5GCP2c=;
        b=B34fo4RlheCrci2IBLjjzGhBGFnY/2WRsRn5HZ9o4shqr7VOCaE3EtN0PQ8cgOmR2J
         413HkMXzKvuA0NIQkh+5p90jjYgKNzfWRGj2BCxDP//kbVMNw7HbQqXnOuTNvPl8/E/f
         Uf4s5JiU8NLRgmiRIDdOjYaTjFzIBOWOeBW63O569thWwMaOvyfT7suq3mgl98+tOxKN
         iYLTpKfQTLKqLnLfjCw9es6ch1O5ZHoRjqmP/TUX+IOQ/25UxdOh5/WGGS1hCZoyXYdR
         DILqdS3msrxDBMs87nqQYHVFzVB7YkK/JKMHqIi5e1JLzsSvwTBvXdVEAcHAfaDMIxAk
         uMLw==
X-Forwarded-Encrypted: i=1; AL+hErGD0/EAB2Kidlor+YEPOQ7BZaXS1HzBQNFis6zwDlxCeJT8YC4RkBbmkv+Iu0hPk4ZiEVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iesp2gF1LTPjG13ClIzJonemjzVgP6qbhpIZaDlGlyKpEf2CA
	JGWqjsZuZiXpinSMNODPMzKMq/j4BpHl9q1Ff3CIrixN72fdj5yv8uLS
X-Gm-Gg: AZFdTZe9B8qdfcoZE8+xMgoj/fZjifyWxaTYOmrtCCwiwf+skR5w34Z5EzyqRZ7P/lx
	Q1pK1rb4A/KLxMzjMRhsJfl5mYzV3VF8RTJod7XpgFeGoBYzQWwnYuLcNzQxAQOosheP78lTa6Z
	7N53Q4ZzTgw1Z0ucKr3B49UcoEhkn7DWtt5MUCvxV/YqvUUK0cXSxYjiJ01+P+ih8VHFgyNpotW
	E7EQ+JtLZSzj2ogbwmx7e73EEp9IXOTu6z4MyEFrY4osEvxIWSJJeLY5cHY4Tkp4VO++gKMjpC6
	mOP+W6kOLsOkMQg37G//FIHScNA2t6rftHy1gK7zK8tXLGnTljC0gz5UDyTpwadhK1N7+f/M2Nd
	dJscbIijufsirz4Rb2h8Ek1HCvuOWSRPyEzfLVO01H6vbU6ydmsRLNp+kVVg1QmVlfzK5DNx2gn
	GuLiDKmdvT7C0LCpG+n3M560zkgcPqyCIfbAKnqm8Z4V6hfTzoJ78kMoQK+lDqUa8CIQOiK3P8d
	MdWfB4SvshP+R3uCP2PmnHbKAvVZP4jduAp9h2foIEWbHwATBcqYfwvMZhxcQ2rVJF1gpeRa74n
	+g6eUldNaGmWyWcEz6wthzFsoI5UPo5divOJy0WgnyEwDr6v3Ufcug4r9p8jC+V874+IvQ==
X-Received: by 2002:a5d:5f93:0:b0:48e:6675:3a77 with SMTP id ffacd0b85a97d-4abb400ac51mr13733609f8f.3.1795285679025;
        Sat, 21 Nov 2026 10:27:59 -0800 (PST)
Received: from Nuel20.localdomain ([102.90.87.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm14215507f8f.24.2026.11.21.10.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:27:58 -0800 (PST)
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
Subject: [PATCH net-next v5 3/3] selftests: net: veth: propagate bad-settings check failures to exit status
Date: Sat, 21 Nov 2026 19:22:17 +0100
Message-ID: <20261121182217.4609-4-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121182217.4609-1-emmaonana18@gmail.com>
References: <20261121182217.4609-1-emmaonana18@gmail.com>
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

Three more checks in veth.sh print "fail - set operation successful
?!?" without setting ret: "bad setting: XDP with RX nr less than TX",
"bad setting: reducing RX nr below peer TX with XDP set", and "bad
setting: increasing peer TX nr above RX with XDP set". A kernel that
wrongly accepts any of these invalid operations would be reported yet
the script would still exit 0. Wrap each fail branch so it sets ret=1.

Reported-by: Tianyi Gao <tianyi@cloudflare.com>
Link: https://lore.kernel.org/all/CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com/
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 7a2bbed0263e7..6eeb123aaf885 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -474,9 +474,13 @@ if [ $CPUS -gt 1 ]; then
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
@@ -484,16 +488,24 @@ if [ $CPUS -gt 1 ]; then
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

