Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889245;
	b=PTCfTX/u3kfBkhOK/9m5LhwHOzTvjmeSOqleLJNU2c5fWtuOA7k8eDXLCepde/ryM2jz
	 HtHOUP2MOSwnXBMXmmp46RMlYdtRS0WuJ0QC494kU8i8A9T+zxcVXWIFcwtLGX8NMIbba
	 YKWd94D3HQtKAyjuJL+m0i3DvromNvaA2B4w28/mrkiV3G4Jtp2KFf8R0p6APYuQhRVvO
	 99tV1tMVyd9qG5AakBI+Hywhun20f+bC7BQkjuhh9KxBXAKqygtBlEfS+ojpP1E2lC1em
	 o4nW0Tjrao7GsYjtacJRqdXf9XcwGV6RN2bRdfOMgXq52AcT8RM6D8MUUGARclBgtEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=my9OBy1bBkluWAYUioairn9napGH+N/4+ZlIeEPaY8c=;
	b=VvAOmkT2ZN4vW0K2VUW4L4aBETTsjW2iJqXnDu7ZtSjOFka91b2fvLpYKPuCZDeK/0yI
	 IlFQg8hbcDOAlKObrPVOH9TtBgdY5j2FdB7nKVIDUSuMYa3i4FmjVKfSMCm+dPXGiK8fQ
	 /1s2wfMveU+MTqyFRGSzVo6eco2LZjouStQT9ERwv1BQzQE/qa4rGiBPa0ioD8Od9B/VH
	 /ITFrg3sPRFEtp58KXi72+jgqMkP3XRrLWSNP5HV586XbPDmlej7lkONpV5YBNQ0i9kQE
	 rzIsKp9Z423d9GeXlUuO8O9tmUyMVYj+RKW2q4kg2tzj4yoSw9/MUcoWhyDJZ7Uh5OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="e/BKoors";
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E176606A33E
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 14:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E176606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=e/BKoors
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso305588566b.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793889244; x=1794494044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=my9OBy1bBkluWAYUioairn9napGH+N/4+ZlIeEPaY8c=;
        b=e/BKoorsJFShcC8l88V2dJXe8612SlmcCnK41t7jRCWKK4eDqHPbYBXK3Dr3Z545N0
         yM+WASdRiPoPoA95bBpkfuTeUH74OTCCYJLwj7cVgLHrZpOnqg1u1w1hTsArDThQqRho
         f0EyI3NUPOaf8wW96n4tYhmikxR8ZCJf6VwS7ZGkMwlZwzY0oFyIAvcm+Yh+a/SZ7quf
         kOqxek4Ske891KPElKAH1lrjoLt/S2O/LqifV0eAheZwxNAVTggE1nXlCY8sexsq+dj3
         43RCqOIJXhaTCRb8kgW0vs33xVe5t6UNTMpJwtEdP2E4mcfykW8kOUGhyygWlW5NXwx5
         k/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889244; x=1794494044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=my9OBy1bBkluWAYUioairn9napGH+N/4+ZlIeEPaY8c=;
        b=jjm5/3WN9SGn1yBeF6KyYAbSExrofXQR68U/FLWrnVnW0QxBV6J3w6EQw8oGLmOD+v
         7QVTmv0OGjtrp2TF6ucznjkIqB+JRd+GpvnpLd84zY7HffzuYkhJ0b+Tqonvh5c+zioC
         8LPt5tZ+3DmWMA3FT9TXSyEE/bQYAPOeAgoe0zAn0WEMmLYlBi4n0IOkCqnGorR16pmX
         1cjLOcRCkyBTIPqiuMqGG0ZQDZkCQiAxQV+SUu4As2nyXOvsqlT8znwmpMiIYk48OXeU
         ipm5HT4pt5OW9ZziAbnrzCJp3mMAD662gtgiNQAvjErIRSp9cpOVjyLTSWgkZRft+8cS
         I3rg==
X-Forwarded-Encrypted: i=1; AKwUvBzLU18qORIvOIjZQnAMKb3CdookVjyIuTOH9NzJEtBharMl2GN05eczJI57FymxYYHvhnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9X/KZxEYlBg2KX/i1ez3uxbgZMyjVReWNvY4mDF1txffIKVOz3
	XqnZ5lg5eevPwdr9ThPFZ1YNE4ffzDX1BaUI6nRkvX8e/AWd+wqrMMogveQawNuMv+Q=
X-Gm-Gg: AYBFou02e5SZ2Yx0PmvmpOJSawLQCzsod3sAKjlmU4nVXWo7XqrnAyTE7GB0IzbCLEE
	rB/wQBg5b3z2xpsjORwgX/OVReWH8t+ikO706wMBYfAjuNkppphEtP2QA0G7mEQ2lTmuQfLc7b6
	evvgXIpzXq9ExIMwPbg/2U0X8Jf63hXpxS9d6/G19yGq8+IJ8BUZB+yMb/otbWzq7+KWE5uF5ar
	TzQLSgiHFJRtwmggllrdKQlkyLMsSz5oUD5ycgXROhGnytCGmfe46PPrn5T15seEbbLemWt3zM8
	WtUhtueCLI4K9PUtNrZjmQaUObUMY+8hSz0Jfhk0ilfGEBrwvUI9YJPkpJ8WJribxHcdhtwSj8R
	LNZGco0RkE593FowbIFX57zvF9tsMlryxGeroEfLz2UC9pte1ccSWecBEJs/ynEaUaETw46sy3M
	0An5Y42BlScwbTHhhChCjKUOHS15wtvu8a24BS4zDJkzksU+Q9Nhi6qa8Flqq+IL75VDRRnLKek
	1l0yl9Z00odm3ffqwRcKxMEE5oZ86pKh6hyfDUPVsagkjLYZoocXeWt83sargmeVk1vPFFKtus9
	fIpdW6UstIDgm0yL/qzd0w2U7HpTBfGx
X-Received: by 2002:a17:907:f20b:b0:c4c:eb16:4014 with SMTP id a640c23a62f3a-c4ceb1640e5mr896680666b.1.1793889243799;
        Thu, 05 Nov 2026 06:34:03 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm178671066b.54.2026.11.05.06.34.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 06:34:03 -0800 (PST)
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
	jiayuan.chen@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 3/3] selftests: net: veth: test RX queue NAPI links
Date: Thu,  5 Nov 2026 14:33:56 +0000
Message-ID: <20261105143356.17062-4-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105143356.17062-1-tianyi@cloudflare.com>
References: <20261105143356.17062-1-tianyi@cloudflare.com>
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
index 17cfe412a266..affcdbf772b3 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -107,6 +107,44 @@ chk_xdp_feature() {
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
@@ -255,7 +293,8 @@ fi
 
 [ $CPUS -lt 2 ] && echo "Only one CPU available, some tests will be skipped"
 [ $STRESS -gt 0 -a $CPUS -lt 3 ] && echo " stress test will be skipped, too"
-[ ! -f "$YNL" ] && echo "ynl cli not found, ndo-xmit tests will be skipped"
+[ ! -f "$YNL" ] && echo "ynl cli not found, ndo-xmit/napi tests will be skipped"
+[ ! -x "$(command -v jq)" ] && echo "jq not found, napi tests will be skipped"
 
 create_ns
 chk_gro_flag "default - gro flag" $SRC off
@@ -364,6 +403,44 @@ else
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

