Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362378;
	b=2v/pMjVdMRuuFF0jxVMlEetJ20PBne6ppQFrezYJGhpE1McOa9++XfIj15G5rAoSiGGU
	 LKef4+X5e/kkWRXbNQ+AwZ0ghPE+kyB+zkXo83LBhlv8B9LoWuTZEQEcmjpJxaOcHxT14
	 92ja0PdUoqowWFqh+F/hhZC2tmnCVsulQLf+Zf4Zts64Rz5GVeyBu+txLu6a0HETTIeYO
	 dfeRTXvM6fZtGdo4BAEJ4578wdkYAwzlG1NYHmAwR8VLKjAze1lO6ccKY1CzUtkX0wHrO
	 ofBbkZRMuAiZLF7PpT/+RFy0moSblvlYONs1UxVmcsS5f9L8Rd4Ae0pdq2hMma4oLQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Jgu962y8cHYH/mees700v1pRhH7ojTrqx1f7sTX+E/8=;
	b=hT54XwFySNs7OleJj/7lAZNthL2IVMNez8uB5WAOi0Au+BAqpeaJaiBOSlaDdVihTg7D
	 vZlaLKBARUS+hKSEv9HlOwNSPh3H/a+AjrMHDZ4R7kbyEo2I3e31YUq0O14xd7ndH7w7a
	 FnuvTnimF7AqYxA5iFDx3v41j7QAv3Ke9A2dDnJho6HBUxPZj7f3cO0GqUKcGqAzlTSXj
	 fTTpqgAYjizC6wJggRjtDJqFL/OrAv9oJ/fKv/ehzCmoKXEvbsgusQEI3DiY+/yKyRokS
	 Ie2/lSFc57dqkwYXvM4F7QvxKwmB7lKe3BzuV5mQyMk5cpZ/EXhxNSv5VyfyIAo3IOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NAA8ObNw;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA0606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 01:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8CA0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NAA8ObNw
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b785ca42ebso13074a12.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 17:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794362376; x=1794967176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jgu962y8cHYH/mees700v1pRhH7ojTrqx1f7sTX+E/8=;
        b=NAA8ObNw0VFx6zfK7QgM1ZFQMkCGhinaiCGyiEr/B2ayq9IY9lyHmHRK/ZIY952fas
         U6I0nseO8oXA8WL4i/T4WnssVKG9ZTwFsZq9WnrxFUDQYMOal923XAORXy68UIoj/fp9
         2o44YAqDd3V7i/wsQHzUoxOAQg2ZWdiVVgVRA78/MtLcuux2t4VWm8sbWXGsIL1CAFa7
         ppxqerNjc8Ws6DKxXNWki1zOGGGni9XMFP+vgcYS8jQQMS2+0YgvR+yAVrdp0CsweV86
         ul7lHm3tYS+gVl3leOtAa3t4ZdQOY2s1J6F4dlAkY64FxkLFuxYlLke/N78FKcpd41iX
         VRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362376; x=1794967176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jgu962y8cHYH/mees700v1pRhH7ojTrqx1f7sTX+E/8=;
        b=qGTy86XefkojlHijDBqwDEKBVdBMvLFL6yUUvOWLnUp42nhIFw2K/+kQTpMPWWrTxm
         nou2H4WJrM72/scaWItNZU5q9aWsnyLxI6RfYseI0UQgazfpUoItdcZZnO4/yjvFXhZ9
         6TygfbnO1Ms3yZC6lMEVXnprzxHhNB6hOu2Q09WE4v5DUMvpNDEMwTaZ23z9f9KyU9NY
         ycLlR5+MKUKBIYq0USFRm4xTfv35xFVr56+Gmio14OaKsZEElDzUuYwlY3Kb8AFJzCq3
         wzvAjGa0CujXNT4dzZ5h8nWFojywEtpyQNO1iyNFeF88hA4On725z1yywaOMETctJcg7
         HcWg==
X-Forwarded-Encrypted: i=1; AL+hErFYYc+xnakVNaNrSg3xifjz76KhVtueW/A78fJ9Zo2q1ra6aRCoa+uQ63EkfGyuYDuVthc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ncbAGQmaF7Fzl3F9e0GrTZm+WZyEoUPZJwnHZX2JOEo7bY2J9
	EotfHo438jmxtpwyfVrciz9F6nSqFxRqQauDbzA8UQv0c8UYDKWJnD+I2Ua8yNJknbj7eDa4WLf
	D1GADAbs=
X-Gm-Gg: AYBFou0xEbsKY9UkWq78kzqS4XdgzElYcWhEGieafQBMV2i7+w1D5UPOke36Nlo2Tdr
	zOjSXU27lP06vlwqnFTLicInp87szST7oQGlfh2CL69LEnlo6Ms6XNuJ2r9OvvlK0Jj8ihvZ0E8
	YkYoMPyGVlq5mNUOrqkDZe1yyXflW+LgAES1uug4Jw7oDkD0gYRQcgm7IOogFI5M0cqsqMstXvI
	1w4eBzOiPD5IIfFQ9CtOmSZITUEPAaHAVR7nrKuyQEDs/9kqLZWRnHWjN/RTU29MTGToUtNpKSm
	TAPmbfsvAOZLcIPY88kpIrqEG3WTX3ZqkVrmRtiVhE28qm44X+qXOw1FGu6rZvc6kSWzd764iXh
	jXnxpvNYKyO+oppctlQv+OW2L+C/JlbCsBGy/qJZxvpe1tH3pNXeYojyLAF1v4YfTFFlNtmWDoS
	rKFyaQsL9JDTICgJk5hB2hyPjOkMQn/QuuqWd+w+9infOGTk4IPCYxnPsnQ00pBPI1OfMDx3S61
	LfWK6nWDugYnHHo+ofENsXxfxkrDPkaM3W50KBvf0i+HviDDtpwf0v9PLNs/269o1kkrtmKo41m
	1BLRAvmpQnrY6C+jidowjwh7MYyGn6pGYIURE7phW4xOBLYWvSaQyY3GSA==
X-Received: by 2002:aa7:c683:0:b0:6b6:feca:2450 with SMTP id 4fb4d7f45d1cf-6b7775eba49mr531899a12.19.1794362376364;
        Tue, 10 Nov 2026 17:59:36 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7834cdc23sm147498a12.12.2026.11.10.17.59.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 17:59:35 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 3/3] selftests: net: veth: test RX queue NAPI links
Date: Wed, 11 Nov 2026 01:59:22 +0000
Message-ID: <20261111015922.67745-4-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111015922.67745-1-tianyi@cloudflare.com>
References: <20261111015922.67745-1-tianyi@cloudflare.com>
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

Check that the napi-id of every RX queue matches a NAPI instance of the
device. Also check that the queues are linked only while NAPI is
enabled. Run the checks with GRO on and with XDP attached, and across RX
channel changes and link down/up.

queue-get and napi-get are only visible through netlink. Read them with
the ynl CLI, as the ndo-xmit checks do. Compare the results with jq.
Skip the checks if the ynl CLI or jq is not found.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 tools/testing/selftests/net/veth.sh | 79 ++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 64c2a5a59821..685209995485 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -110,6 +110,44 @@ chk_xdp_feature() {
 	fi
 }
 
+chk_queue_napi() {
+	local msg="$1"
+	local target=$2
+	local expected=$3
+	local ns=$BASE$target
+	local ifindex
+	local queues
+	local napis
+	local st
+	local linked
+
+	ifindex=`ip netns exec $ns cat /sys/class/net/veth$target/ifindex`
+	queues=`ip netns exec $ns "$YNL" --family netdev --dump queue-get \
+		--output-json --json "{\"ifindex\": $ifindex}" 2>&1`
+	st=$?
+	napis=`ip netns exec $ns "$YNL" --family netdev --dump napi-get \
+		--output-json --json "{\"ifindex\": $ifindex}" 2>&1` || st=$?
+
+	printf "%-60s" "$msg"
+	if [ $st -ne 0 ]; then
+		echo " fail - ynl cli error: $queues $napis"
+		ret=1
+		return
+	fi
+
+	queues=`echo "$queues" | \
+		jq -c 'map(select(.type == "rx") | ."napi-id" // empty) | sort'`
+	napis=`echo "$napis" | jq -c 'map(.id) | sort'`
+	linked=`echo "$queues" | jq length`
+
+	if [ "$queues" = "$napis" ] && [ "$linked" = "$expected" ]; then
+		echo " ok "
+	else
+		echo " fail - expected $expected found $queues napis $napis"
+		ret=1
+	fi
+}
+
 chk_channels() {
 	local msg="$1"
 	local target=$2
@@ -330,7 +368,8 @@ fi
 
 [ $CPUS -lt 2 ] && echo "Only one CPU available, some tests will be skipped"
 [ $STRESS -gt 0 -a $CPUS -lt 3 ] && echo " stress test will be skipped, too"
-[ ! -f "$YNL" ] && echo "ynl cli not found, ndo-xmit tests will be skipped"
+[ ! -f "$YNL" ] && echo "ynl cli not found, ndo-xmit/napi tests will be skipped"
+[ ! -x "$(command -v jq)" ] && echo "jq not found, napi tests will be skipped"
 
 chk_channels_carrier up up || ret=1
 chk_channels_carrier up down || ret=1
@@ -443,6 +482,44 @@ else
 fi
 cleanup
 
+if [ -f "$YNL" ] && [ -x "$(command -v jq)" ]; then
+	create_ns
+	RXQ=1
+	if [ $CPUS -gt 1 ]; then
+		ip netns exec $NS_DST ethtool -L veth$DST rx 2
+		RXQ=2
+	fi
+	chk_queue_napi "queue napi - default" $DST 0
+	ip netns exec $NS_DST ethtool -K veth$DST gro on
+	chk_queue_napi "           - with gro on" $DST $RXQ
+	if [ $CPUS -gt 1 ]; then
+		ip netns exec $NS_DST ethtool -L veth$DST rx 1
+		chk_queue_napi "           - fewer rx channels with gro" $DST 1
+		ip netns exec $NS_DST ethtool -L veth$DST rx 2
+		chk_queue_napi "           - more rx channels with gro" $DST 2
+	fi
+	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
+	chk_queue_napi "           - with gro and xdp on" $DST $RXQ
+	ip -n $NS_DST link set dev veth$DST xdp off
+	chk_queue_napi "           - after xdp off with gro on" $DST $RXQ
+	ip netns exec $NS_DST ethtool -K veth$DST gro off
+	chk_queue_napi "           - after gro off" $DST 0
+	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
+	chk_queue_napi "           - with xdp on" $DST $RXQ
+	if [ $CPUS -gt 1 ]; then
+		ip netns exec $NS_DST ethtool -L veth$DST rx 1
+		chk_queue_napi "           - fewer rx channels with xdp" $DST 1
+		ip netns exec $NS_DST ethtool -L veth$DST rx 2
+		chk_queue_napi "           - more rx channels with xdp" $DST 2
+	fi
+	ip -n $NS_DST link set dev veth$DST down
+	ip -n $NS_DST link set dev veth$DST up
+	chk_queue_napi "           - after down and up" $DST $RXQ
+	ip -n $NS_DST link set dev veth$DST xdp off
+	chk_queue_napi "           - after xdp off" $DST 0
+	cleanup
+fi
+
 create_ns
 
 CUR_TX=1
-- 
2.56.0

