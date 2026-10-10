Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D19371053
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660563; cv=none; b=uD3DAeO9OZQZLCHzrcwIFLXFVA4uPqpXNGsC5i/rJoa6ztLtG5HmOLxf8T/VK+iwE+hsVGcxDq2M0Dx4RzDnUH/psvpMHSpzssNDNsoxvcgW02Y6g2ssWGCG8RRfbwKlyvKe4mCDHwMODV6YPdQX/CCmXlfekNl7J2O6dMi6cD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660563; c=relaxed/simple;
	bh=FHammez+ru5X1OzUn5iEe21COb3PmhudSPB3aCrXcYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXY3FnxZLOAAm0nYPCo7KWg+Ymqqztf1xjN1w/HGplfVYhT3BE5WE0KWlpsZ14JMoXnTvjsLCOubzmV8209mNRtLS5XWbNhTAcAr1yi+UIQrGBapAnyd0kHITfie9fsc9G+SU2i3L75KDuXEnPkoaVjCUQuLkvO5OphRZj5GTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CKrZfCY2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CKrZfCY2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so6019255e9.2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791660559; x=1792265359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mSJDmADZtNyWrQqxKhYzkqnU1qutd4BzGMBm9BmhF80=;
        b=CKrZfCY215PDRh0N9e9iPEMwselnt+6edarHfFAaSf2U3D6QSGyexp3u5PrFLEyNt1
         UbpX4XXiyj8vXedURLYbOUJ77rLRyE9yBdSrSpGIbu5FQlK7d0Nwk6uuOydBYbsVghXo
         dLL0OQaS//8N0c3msO/uoKTvB2AKuNX/wKoboqjuTrTOlC2gjR5825JMw+CqhcCqh13t
         tIbxlE6H29onnzRCPJmca6INwMxQ3ylJc+AAgNhw8VE8K89KIAPWkQ/d2o+p0uim8gOa
         7n9t0DvE8epeoomCcOFTYHp0ecsJTAsGffCDJp6pF/YA32yX33JaeIUEEFgkSjf16gkr
         RPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791660559; x=1792265359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSJDmADZtNyWrQqxKhYzkqnU1qutd4BzGMBm9BmhF80=;
        b=uqH/FsyCGwy1ov1Cf+V6Ly956JcCxPp+XhVBX7e8tIexwsZq+HXlR606SEdX6S07SG
         XgbP/wK1NUJ3wy8P58zs63QbzH9k8xfGv5KCtrdvqYK2oc8bWvq/tTbUhUmnI5j6wW9J
         JO3wLMiZeXi/SqQrLsCahRTnGmcHRJUSFtlZ7aH9hdCiXufNYC2QIbsNqNf2az1JzMWN
         dEyN5WVOj2hPq25oczxANPfIzZixi+GoCQLj+B3MTUe1mvrSZar8PPJUcxaovki396bx
         OgdFPwh8waQtFTwabb1ngL1dnVEvF9iU6fWh42aYzx/iwVzRO1OMFhTErjY7+uSBkOAe
         J5iA==
X-Forwarded-Encrypted: i=1; AKwUvBwdfYSodlZFmwXI9fUFaz5Hkbrj72+WBesnpgVV8cDsrCPL77NbNU4v65qtTPEOMN65lwc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJivKUrQMSHv1hq1EB+X9r4ldo0hMtG0fF7ZjespZeZ14SNdKC/
	tB/KsbLnh/XR+x2TRMYpzCywKOzChkU4UJbSAaei6oYTwdb5McMgssSdXT7GpUsDrjU=
X-Gm-Gg: AYBFou2DQT5Lbvr96oHhGw4T8d078mY6l243Go8gwHiFagBsHufToWVHEfo5DrGaH6H
	Iu//bqr/XUiT9euI0YhqqZZZNaWfePanZytzrrh30LhsvffMS1l03/GoZBzQKGCR7yeAHeRUCSd
	lMv/R+/NHjm9fxEeQgDPQxzht1cN148ZqHNsq4o1EQqG9brtke0IS9gWm+OGQD4eYv+1CfMw4X6
	R3Mpd7oke4jfb9VFAiWwVc1udarLCu7YM1nH0eEsOEO3iudxBkr6TFNWlhyIipaVNcfVOj4ZuuP
	RuiCBuNmA7MHLMSZ5JE4H3iiq79nqtddUAsyJsmYZpPIyicJEv+WZ+krWN2yiMbauRZiTE4Le5G
	N7XVXglsXlK3/0CC8sGs1tmpJvTas9uqlJ9anUGFaPESRdP6uCyERZp7PD3uTLadAp63TQU7INc
	/zLHFYLb0KMD6Pt40kFHkiNSFOkNfSN8JuD1Bgf15tBzexwIPmoAnxkPureCurmwPn+gXLxzTPW
	R/p36OddPa2FVg8CvRioX6Xzc0n
X-Received: by 2002:a05:600c:4ecc:b0:49c:fa21:e749 with SMTP id 5b1f17b1804b1-4a18e4d55f2mr118580455e9.31.1791660559467;
        Sat, 10 Oct 2026 12:29:19 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:26d2::3de:5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm236394285e9.8.2026.10.10.12.29.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 12:29:18 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	toke@toke.dk,
	lorenzo@kernel.org,
	hawk@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next] selftests: net: veth: test own ndo-xmit after peer GRO toggle while down
Date: Sat, 10 Oct 2026 20:29:14 +0100
Message-ID: <20261010192914.83651-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that a veth device advertises ndo-xmit when GRO is enabled on its
peer while both are down and only the device is brought up.

Commit 7a6102aa6df0 ("veth: Update XDP feature set when bringing up
device") made veth_open() set the flag in this case, and selftests were
requested in its review [1].

The block now ends with GRO enabled while the peer is down, so the
aggregation check that follows covers NAPI enabled by veth_open() again.
Commit c017800af5c7 ("selftests: net: veth: test peer ndo-xmit after GRO
toggle while down") had moved it to veth_set_features() [2].

Link: https://lore.kernel.org/all/155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com/ [1]
Link: https://lore.kernel.org/all/179165459278.434549.1711113374323842550@kernel.org/ [2]
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
The new check fails with veth_set_xdp_features(dev) removed from
veth_open().

 tools/testing/selftests/net/veth.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 8b867e0675a7..60d0754928bf 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -327,7 +327,12 @@ if [ -f "$YNL" ]; then
 	ip netns exec $NS_DST ethtool -K veth$DST gro off
 	ip -n $NS_DST link set dev veth$DST up
 	chk_xdp_feature "        - peer ndo-xmit cleared" $SRC 0 ndo-xmit
+	ip -n $NS_SRC link set dev veth$SRC down
+	ip -n $NS_DST link set dev veth$DST down
 	ip netns exec $NS_DST ethtool -K veth$DST gro on
+	ip -n $NS_SRC link set dev veth$SRC up
+	chk_xdp_feature "        - own ndo-xmit" $SRC 1 ndo-xmit
+	ip -n $NS_DST link set dev veth$DST up
 fi
 ip netns exec $NS_SRC ethtool -K veth$SRC tx-udp-segmentation off
 ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on

base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.55.0

