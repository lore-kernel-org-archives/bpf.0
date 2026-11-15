Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794779237;
	b=mf2vTQGA813W6/H1oQgh+idxlZg8otlZekis5unU5JyCcXrhCVvs9EnTha4M+n2oaZSH
	 qw2cNsXFsMDjNAjI4vFzXLu1I5zehQ5Wkl9TlUShBrXOLbhS1gx1xx790bJ1YNlw8eJfe
	 mXBTBoYm4Q9uzBkIHAqyvKpYdwqm5L71k14W7JXmVQV7BdTDmiZ1ytbo5s4COVZvz/jmX
	 Ce4Vu8E0mcj0bL5gs3zP8K33igYfXECGEcByNA52+81CoXaUkoEo/pyiqVjkpAbsCJKwM
	 coZtng8N1Jia5nsJKn86YrwhCoqdh+WpDF6BOepLgzf1MMOvRr4+nU1d3ZWeqpy9Ukw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=psvhFR3gX3h277fYLdFab5gaUTS02PdmPaUdlYbgfe0=;
	b=FUF/QyaAyIgKCakGGKuHnBxZx1aJ90QCcq+hDSvtPnyou/MO6rzblHfWEFS9Mx/FEGZL
	 bNgWf36SBiObnHTCpBgLUMWyXTyjY3vUib2LeOnNc+Tk1cjHogmpEbVzi7rFmRZYDG1sx
	 U9wdPJgBLJ3GWKV57iJ8IBjvDhHLvGPYkNSXjL6gqR3R0XM+Qd1Hd8POi8BuISzqu5MIA
	 7SL2Dmstee6IEtBaqBI/BGbg+lhm5C0Z4ivZF+Odxceyo26ZEYKZP5eaP+jP7lTgHGoVD
	 TZFGGWpeb4gETVgOZw0/tkDo1Tai5xt2/c/MYYTc5yBSHm7euxCE3An7CDV9GTPFWbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i0vogCSl;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCB606A32F
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93FCB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i0vogCSl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb67b3a18aso356115e9.3
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 13:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794779235; x=1795384035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=psvhFR3gX3h277fYLdFab5gaUTS02PdmPaUdlYbgfe0=;
        b=i0vogCSliLZJGYDRv14NGvoJrO5SGotB1IECpyR/cQn7RkJjcbXtZ15LN3HdYRuzJK
         3ghnZOKGJad3pty8zTXUIZyySoqi8t2T6QndoUZVwetLEruinA3Q23qATRL9sGf1hOf4
         Z7Vc7cAvyNjD8JJ8NLUXTZqI6ZeVlaC1M87vbmcRfiGsVmZj6cLm0rggjPOMTeej35rb
         hpi9+DgGTyVh7vvBbDkGkrVt9fQAn43NYaliIguXV3JrZaBTpt9dH7BGClgcmthhrLOo
         aOBH+5LgzrDvj4Wo//E5vupbxzwtPtwBU/4eJ9RBWvtUstHxE6d7ZyC2C4Dghe53V1Z7
         YZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779235; x=1795384035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=psvhFR3gX3h277fYLdFab5gaUTS02PdmPaUdlYbgfe0=;
        b=QRFvzHxjHiYsB3BIwR+ttEGk7wiGktj6PER9Zeo9/fYz2+r2IGSS6XIkW1sjD9+evn
         h5aNu7ThQKYIM2BlSB2JarHLkD73QA6pPlti369zZeDCLRG0PwTXJmrP3N+KTsjd1T0U
         xI6+nxT8gFclym1igMinuTbZfL0ZxP5z/bqv7q8Mu1EqlPOvjzV8jCTFBaE4l7cL/pOe
         QH4UcDSMbCBpPp9IxWpB3kJkTpEvMOFrIJdQYpdx3GDRm4tlr1N5ydWwrL7j6HLcbJ0o
         K1viRirHoQ2XeqM+FmdFBbueDm0cqCuXOFl2fbz+EYdpvSGYrsUSiV1vDFEqE9g1kLdY
         Pvxw==
X-Forwarded-Encrypted: i=1; AL+hErFN+JuSVq7BIL+//v7UzJ4eWwuPhi7aNxRMg4zd8HVSUTgDW83fIXzif/MaicOUQDBbMkM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ay592fHabeSF3yO6qPqqWCJG4vtKSPuJmnesRoyTlYg2ybjJC
	X8P5KrBszWQFBpoG2L9WWN2KDDtt4pIKaVYZx8PB4ABowA7+xQy1Z9tR
X-Gm-Gg: AYBFou0wsKXoB+L3A/C9jauP1F6/7xgItKcMalPDY+9K91w4qebb1ukcwu+DQd2Blas
	Q7u3fizCP8AR/ElsI5xqBWgWP6XEL026sazpYOpCrKA3CfT5hvvtcvITWIFsGOavZ4uJATtIvL4
	mnMxfP4UoYFU3ojl7nOJ01Z8YaBilgrITiGwU0RFpjL2Mt6bjwXMBPIrQmn6nING0EwXug5AYGc
	fptjcT15UKxiPvIwucGFoN1n+47ZJKrg9JkpjclZvW67tNUbLGy/GcVOvyTKvDU7O+8glhto1TL
	TTub9eiXfLW0jmisRpjKBAnqaJ5eoeuVQvO886ZEt6J8GBMHIZDBVZKS/42YxtLqN2WXCg8FCR6
	Ue4hNqNgiy5N+F5DgQrLhxqZ+bw3JE0SDMiqz+mE9arXtVJ3ziRFgy3szjg62w1nHzL6i/Jg1io
	3dD9I2CwFAL7MtCjWLj76gZI3jTRUiaXrCWDvhG0FDqL4y5yhZghoxrnh1uXvtvpyOvIZyBTgom
	go+BJPug2bLI5R7k0RoZmJCVH1QstNxnfNAnZeWea864RokTLUz1loKg8C7JdVhtB4uY6pHk3C6
	LjlTSVuKS56O06UvK+aF+TLZcIXAjZWxJpzQQGZvTEC7wGDVQsHu8a1sPMYhgkCpirPIkDd60g=
	=
X-Received: by 2002:a05:600c:8a17:20b0:4b6:2242:d0be with SMTP id 5b1f17b1804b1-4bb5599b367mr144632065e9.0.1794779234728;
        Sun, 15 Nov 2026 13:47:14 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.221.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb6f93b3e9sm43204765e9.1.2026.11.15.13.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:47:14 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: kuba@kernel.org,
	tianyi@cloudflare.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
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
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: [PATCH net v2] selftests: net: veth: propagate channel-check failures to exit status
Date: Sun, 15 Nov 2026 22:47:02 +0100
Message-ID: <20261115214702.50817-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
v2: correct Fixes tag (was c017800af5c71, now 1ec2230fc721)

 tools/testing/selftests/net/veth.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 64c2a5a59821d..5c1dbe1516bb4 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -130,6 +130,7 @@ chk_channels() {
 		echo " ok "
 	else
 		echo " fail rx:$rx:$cur_rx tx:$tx:$cur_tx combined:n/a:$cur_combined"
+		ret=1
 	fi
 }
 
-- 
2.43.0

