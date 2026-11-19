Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048233;
	b=X5QtMyVAtonAJHus2DByLy8zrnGhknVGzL1YuhcMHUZTl6YyQ7rE7yPIeW2gD4NAnd98
	 HiWbs9MK2dWW9bOingB7K66MNxidyFp2zLH44qbtjAs4EOqc8MH9/ZQbx2HeAycMGOgR6
	 KIgtEXnLJx27wMQmcsCoCz5OiE4CbxDgfgFranyFYw+7XJ4Mwhftso3ztpjCZUjyT2XK6
	 1TUgGiopT6A0Ep8VHw48/lTpWqVbmVpk9yQX3tPeu6WNfnTd0LyD37UonvOY4ctIIQ6DO
	 QM89yMtAsXTjmLHQi5ooV75+d1FmYuQBFL6MQTlzx9jvUz8jL4l4BDF0hLaNxK2EWTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tY6fRiRHZ4qZ5vYbTo0aHqI1fHONsrHB61AnWgkQo9U=;
	b=ofQXKsdnkWT9B3YttOUOEIboktEYv7H+FR40gU6FvJdWHl7ujVWIPwx+x3wA0Oxuzzvf
	 d6+RvaxZodxEODnEuwIIQcz2y6WAk6GtlEPnvS+INEaXodQ/uxginn2GEiDbKb82XbU1I
	 5KviqloQuZAbUY7N6DzjYJ6qLgo3lmGlrtfxEeSb26mnZRyvGx2++hQdBUTCAp5PCOyUC
	 UhxiEZs8QpnHQ/tEskAMCABVaYPJeWj5CbRYuFkZQHvfy0g3tYK4DsCwXzfYVUWEZpGNf
	 7ZpXrl92J+17LRlIjVMPlAYjUtFn/WHsTO73l7qQtcjthItAK8TirkYRJf3d/ACch/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRNwZbbp;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0A60A2623
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45B0A60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRNwZbbp
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c504707acfeso36736066b.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048232; x=1795653032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tY6fRiRHZ4qZ5vYbTo0aHqI1fHONsrHB61AnWgkQo9U=;
        b=PRNwZbbpu1cxDps4lx1UK660t5mxgKF3mzzZubJ0SgZGhmNYtnHeBDIQK0hVqt6qs0
         1qzPOjOtvYhmWNnW1MrRjPaBgOicIxQW7ZaCLSAxktNNeZGws5e9jDQ3iQkqI/qxXto9
         JGct10nK5IE1P0lsAHlZ+iX24wYAY8s+K+d0jEBa9K0/R4A9MOJQFqH9ZIbj4GRy+rDJ
         rXohZgzARca5GUzOWkjtOE6N+z7JrIQjHoAbO2xd0JxxNhvMRK/LPYAZ7GfXvfkvJEt4
         +fhXNAS7vdhZlHrDvrbpkb2ndMD7fSl5EQx75kNhbXfrTx1SkXDKtXAii9K7l2iWP1C3
         E3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048232; x=1795653032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tY6fRiRHZ4qZ5vYbTo0aHqI1fHONsrHB61AnWgkQo9U=;
        b=lTyg5d1ibzW2ER3Au9CnRPH/qIBRf1QdSjNlqt9MrfF+P960FHLlRRGjkPis7Vn4cU
         EaHCGpkrKp91PCLJtlDJCBLObI2I7pdvrvFMtce3bTyK24N9uCksEcvNd9/jYERfL5sF
         suxRvI55WMLMoAn5m+MdDpVsMwl/TV7NBLUoYoiUFnlHS0sJnOU+rTepVu1uQO4YYmDL
         hiICy4WeJom66kCeV+R9mFFTYqd0z4Gx3nSfMJMISC1CI3nMf3ZEJLFQJTeHX+Hz2o5e
         niA5OKgUrG48irzJSwlAjcRnTBxmrSnpHKFbbbGQcayvSn02Ltq6ldAAW9bPevXwEaBJ
         f4dw==
X-Forwarded-Encrypted: i=1; AL+hErHNtMcoTeyVc7yjOOEEw8S4nK0IEHrBl3c0mpSXr0znFL/lGvMq10NX/L8nI3DXR0W7KYU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PREzXsTFyecR71mNm9sBykW0b+Cd3TasGRPBKg4/kILKPYyaA
	HXwrkoFbnSzzUZ+2KgZKI/zOnHu0gmYH3ANj5hy/KSb30OFlA4Jpyh9O
X-Gm-Gg: AYBFou12ATSoVaddWt7ktH1Bi+Ip7M0hd9mThdCgyzUvG7LOoxTTpg7WOpP9Uw9BXYA
	dixmmv3voacmxqyZeQ2NjhkV2zocMEVxMSxcMQiNu8AIcK+2iZKuMcQrclGWltipKPBpCo9a4aa
	bHTlWZMYmY6DbspfmGBfCrzymgm9cIcIIPU0BdLG3yi6UB4b+XzRW6GrlRpgYeQngDvjps63SGH
	EhwLAk+WxtGF/4aPfJpMeHBg5jSfmUyy4FtCW+YuFxQp29Taod7x4wsZfc3M3EN8UAvP9KegaRO
	iI040uivVvriB85SY9toIBH2CUa01yWyzUXh/JAGQzR4Q6J5KZKaSiPdJglZ/rCF+YX06/sMqcr
	cL+YK+ICKzsTO0dsKnQLOVpk8sFWaB2k3urNoePot9gbvdkyapRsylc/W/hBfgEc8BzknAFo1iD
	AtPhJ+DEfDqvPa0FKdTptYbDZcZP0rMVK5gCFTUUlJ1UxYm8j6bSggrBVnzT7cDE7lRbgG1tvc8
	IjMjM5vJEEWqwOHuXAFlLPmJ0T+1lPsAcvpxXG07MaF3uvIqgjTIrLAFP1T3HB9n4uQoHX8hpfT
	enjS4gUTz6SLa31rgQi0TvrBIvWJN05jOZzMzHlK9qT6EoQxv+ZVL9C/VGn5APHY73IRut64Pw=
	=
X-Received: by 2002:a05:6402:ca02:b0:6b8:8146:a10f with SMTP id 4fb4d7f45d1cf-6b887e52710mr3301122a12.2.1795048231599;
        Wed, 18 Nov 2026 16:30:31 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.208.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a001123sm1729744a12.21.2026.11.18.16.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:30:31 -0800 (PST)
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
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: [PATCH net v4 2/3] selftests: net: veth: propagate bad-settings check failures to exit status
Date: Thu, 19 Nov 2026 01:30:01 +0100
Message-ID: <20261119003003.40482-3-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119003003.40482-1-emmaonana18@gmail.com>
References: <CAG4wq-d_30-B4wQZu48ZQXAORM4QxRqPfmYsmoHS0hiYp1EtTA@mail.gmail.com>
 <20261119003003.40482-1-emmaonana18@gmail.com>
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

Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")
Reported-by: Tianyi Gao <tianyi@cloudflare.com>
Link: https://lore.kernel.org/all/CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com/
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 5c1dbe1516bb4..2a37d21f97da5 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -472,9 +472,13 @@ if [ $CPUS -gt 1 ]; then
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
@@ -482,16 +486,24 @@ if [ $CPUS -gt 1 ]; then
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

