Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794771349;
	b=FCLO35mv3wuh8EVW3AynGNzz8xOk0Gwu55EtsgseGtt/CqaG30BPPEPIVeKxYSccje9c
	 y/EokPiBpyE2OfANyB03qaJ3hi/CRINx9iYwW4vnod12eg6AoThsHDwVRQnIdildz/+zG
	 9FDHp/TEiNE40YXorDSfGFJ3XSgHAW4UxFuup+haTXqiR/9K/1hlkJBqiAitNVWHisJzn
	 Ovhbtk62nkfAtXJyVG9CillaaJhCw1tAjpm5fq/RUJl+S+yBEuoDQaiBAkyJFDofp/2uv
	 XCoX6a9Vp/yDBx1zrAbLbmLX8VQj8zVolQMRGKIjAHXWogwyJD5PbtQrVU2P1aGQV6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794771349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F1yhPQtGuQiIVxyFRyGRvPMKXeA34EsZZQXwH34MUDA=;
	b=0w3U3/Vb0w6CKYtSk54wtQ0CKCoBW7Trxjqy2rX/tv0If5qUPdm9qAaMm0mHjes2ktfR
	 mhd2ifrnBbeQgCSMm3TRHrH+6MuX7s4Y2IYQfisaV8WKDC6jGH1fzqhHiy2ZB4TuJ72N4
	 sq/7EOZtb2ayvkb5CtZimg+A/CPdEtsCUfvZOBRk9+XbS+IhJuA28SRoXj7N3hq4uQ+di
	 ziA6qQgkZNAnN7u8efJClwCO9mMG1XZrTWG03vWcvEjnf0BPzt3JJzi53g9euHGlnyhLC
	 XCqN7FWMVQ4/bvTPBO08fBHjEVoCAyPHdhXiBQhi5HzRC4lIEjP9lqjCNIf/YuUc7+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Ddd1tPw9;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9439606A88E
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 19:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9439606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Ddd1tPw9
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso429284266b.3
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794771346; x=1795376146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F1yhPQtGuQiIVxyFRyGRvPMKXeA34EsZZQXwH34MUDA=;
        b=Ddd1tPw9RAVNYmD12nYH3+lDIsw1GToia/TS6/59V68w+pW8wA2Ki3VhpKYAmnAnO2
         jeIup19iPB0uS7rCH8PHJknGTdquhpQx2Qjpmmka9fpGIOzuEmYt9M8ptEi6A3JxT3sW
         8/5pEYQxQBHdAfY4aAei+Fe/QAvKlUNOfVgnhjlqSKYKTBbZho6GMt7Gb3uOropgCzPy
         a23XRIktJ0XNMq4SRpqeM5KE18pG/hlNQY5EGHXdW2tj9yQRW76VFLzawNBjI1QEyEIW
         OG7/xrshCkTwNomu8g7+z4o1ieIbvizWy6KJncCgY85zVeU9d1mOPszv4TDP4XwOUcee
         L2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794771346; x=1795376146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F1yhPQtGuQiIVxyFRyGRvPMKXeA34EsZZQXwH34MUDA=;
        b=Y0yW7rOlF391+wG7TI2KlC1edXoV2yqX8m7aKNxXugLuFTNdcegQ7fvyFmOhllxpzp
         7kxJ8jf3UlvFASHqQWDGB4Em15PXWBs+NE2sUIaupfyLbUmKIb2kvdWhruSWxmnSBfR+
         GpvocW3xtRLFEpqpDW6hl3Jmpif++Gp8dbL3svVDlP33HUg5C7WWmAGb+Zp5gPnkPcby
         HIIzMcR2umAVM72OZlubYIkTX6zWGk4R/hF+mLrdWhrhRi4HoiUg+douTVqjVIpq9lpq
         W6LaPX/wlmAvYRD5qqsxgiOaAaHsjE5XtUoVa8MOSHB/ks/6PLes79Lc2kA6FbU6bnyb
         UfoQ==
X-Forwarded-Encrypted: i=1; AL+hErEEApe1EZIKfVbuDO89c/RCNNq3jUqxiRQU6lWUL1hhuczrmLjkAbZHDgrya27YorZW99Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+inTWPnS31PwgoOD0dUh3LSWER2cdsk8jN28Jm9SK1sH5iaQgf
	AhYRMjpNspezJSNlwMcL4tIL+pPvYUPShRQcTQdSOwS4oT74/8u+HUg0+OG0CRRevTw=
X-Gm-Gg: AYBFou0GxYiThi4p7xXz4tmhuriTlSxu4trhlKNmTIv47GqLiF45yr16629A2a+r/+Z
	+TO5VRuAwEyj5wBNDNgKcqpauwoQ1OCvSe/WZmYqf7VpdueQL1wdrarvCJ5xI6i3sAIsuaA83RF
	QMv9isJPeK69hjU7Yt+3UwuCqjI76QvaTWjS/bA+SKQmPWDrVmxGgVveg/7cSQTtugeyjn+umKi
	xQPw/6/XRUDrIrPVR4+e225u/tYROi1MdP0vUiAt8F11kGFri2c6OibZlflMzlkD+ytIupneTwV
	QiCCIXbh9d+U5/QY1KXl+YY+sbjN3rQhpBTh/ABI0S6Abx4Xmv4guIP+LSiNpB8QZT7oPshI7sM
	ZMxrgbHVjgnZCAS4NL9FIYWBm9N3JSsrGV6yAE/q2oZislPRz0uO7HJ8eYM6yqk8Sj7H9vpkovd
	DidMS2SKaf321kLunQS3cPYFRZd9SJUMWg7hkJXDLEmP9GfSujYM5gcLm06HvOHFIuklMJ3cxlh
	CqzM0om2jDTEkkH5uC4a6+Gtkx76dABQQRf/KdBlu/0M+pSivwMXOZw6CjUIpoQCl3iNxXxKe3C
	r2huM46yE4TljsDuwjwS4gYRFkmGY9TjQOLuVI4R3gDWLw54Yntw7tkpxck=
X-Received: by 2002:a17:907:94cb:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c5096389759mr692569266b.41.1794771346212;
        Sun, 15 Nov 2026 11:35:46 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b24b88sm340448766b.16.2026.11.15.11.35.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:35:45 -0800 (PST)
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
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v3 5/5] selftests: net: veth: test that RX queues keep their NAPI IDs
Date: Sun, 15 Nov 2026 19:35:31 +0000
Message-ID: <20261115193531.57679-6-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115193531.57679-1-tianyi@cloudflare.com>
References: <20261115193531.57679-1-tianyi@cloudflare.com>
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

Add a check that each RX queue keeps its NAPI ID when veth deletes its
NAPI instance and adds it again.

get_napi_ids() reads the NAPI ID of each RX queue with the ynl CLI. The
test saves the IDs once GRO is on. chk_napi_ids() compares them with
the saved IDs after ethtool -L raises the number of RX queues, after
XDP is attached with GRO off, and after link down/up. A failed read
fails the check.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 tools/testing/selftests/net/veth.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 685209995485..9496b599d722 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -148,6 +148,30 @@ chk_queue_napi() {
 	fi
 }
 
+get_napi_ids() {
+	local ns=$BASE$1
+	local ifindex
+
+	ifindex=`ip netns exec $ns cat /sys/class/net/veth$1/ifindex`
+	ip netns exec $ns "$YNL" --family netdev --dump queue-get \
+		--output-json --json "{\"ifindex\": $ifindex}" |
+		jq -c 'sort_by(.id) | map(select(.type == "rx") | ."napi-id")'
+}
+
+chk_napi_ids() {
+	local msg="$1"
+	local ids
+
+	ids=`get_napi_ids $2`
+	printf "%-60s" "$msg"
+	if [ -n "$ids" ] && [ "$ids" = "$NAPI_IDS" ]; then
+		echo " ok "
+	else
+		echo " fail - expected $NAPI_IDS found $ids"
+		ret=1
+	fi
+}
+
 chk_channels() {
 	local msg="$1"
 	local target=$2
@@ -492,11 +516,13 @@ if [ -f "$YNL" ] && [ -x "$(command -v jq)" ]; then
 	chk_queue_napi "queue napi - default" $DST 0
 	ip netns exec $NS_DST ethtool -K veth$DST gro on
 	chk_queue_napi "           - with gro on" $DST $RXQ
+	NAPI_IDS=`get_napi_ids $DST`
 	if [ $CPUS -gt 1 ]; then
 		ip netns exec $NS_DST ethtool -L veth$DST rx 1
 		chk_queue_napi "           - fewer rx channels with gro" $DST 1
 		ip netns exec $NS_DST ethtool -L veth$DST rx 2
 		chk_queue_napi "           - more rx channels with gro" $DST 2
+		chk_napi_ids "           - same napi ids" $DST
 	fi
 	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
 	chk_queue_napi "           - with gro and xdp on" $DST $RXQ
@@ -506,15 +532,18 @@ if [ -f "$YNL" ] && [ -x "$(command -v jq)" ]; then
 	chk_queue_napi "           - after gro off" $DST 0
 	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
 	chk_queue_napi "           - with xdp on" $DST $RXQ
+	chk_napi_ids "           - same napi ids" $DST
 	if [ $CPUS -gt 1 ]; then
 		ip netns exec $NS_DST ethtool -L veth$DST rx 1
 		chk_queue_napi "           - fewer rx channels with xdp" $DST 1
 		ip netns exec $NS_DST ethtool -L veth$DST rx 2
 		chk_queue_napi "           - more rx channels with xdp" $DST 2
+		chk_napi_ids "           - same napi ids" $DST
 	fi
 	ip -n $NS_DST link set dev veth$DST down
 	ip -n $NS_DST link set dev veth$DST up
 	chk_queue_napi "           - after down and up" $DST $RXQ
+	chk_napi_ids "           - same napi ids" $DST
 	ip -n $NS_DST link set dev veth$DST xdp off
 	chk_queue_napi "           - after xdp off" $DST 0
 	cleanup
-- 
2.56.0

