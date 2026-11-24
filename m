Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555050;
	b=BaAT+iYQhRZjpbvy1bwDJGvhMVyG8GUcebpMIT6JWYoH7KRKTmEfWxLm+h9XpbIT7Xt8
	 lW8bU14NSzJtnesKdD1MWJPp1I5G6mzXxk02RECvX2TwL1wGEqHZBL3uKAVGNFvFjeQuv
	 L8VXqqIXmXc8vYSaHqEy98kd8Q/JXOEVt02vmIhrmWDjq2imRVQbslVjkXQT/oyGoYY42
	 CF8SAJ01tM7HuY4YQu+uESbGle3NYiivK1kRl0MvmUTncESv6PwgjI49IuJrDNajK5wCj
	 kZQG9Ua4uPydg4Q2yL9Bid6edEY6P8RrktmlwHagUq5IPCVsGWO2o/5flTjRjaB9fRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nCt5uIBBkppQcxpqoTId6AW8ghfLSBUA7Pu99I2wTq0=;
	b=sze3KX0yCBa0cTsiDPghXUH6R9SL/B7kYHhySEebbCf4zdd5nFhLd8sGn90hTPYBuY5U
	 0cEv8Z6FLzo0+Ykx0xG6xL12XcflJUOLMcXWE5NEE+mmTL4tgtf+0IrwtY88/oalgRL1D
	 DxgmUmrrLTb2xMnyv3oqv3oBsU6eI9bbx942bPshFPQgrRiEK/SN6ENRVDGtrM2av8Rwb
	 z+NbUOzr8NTjGfmGX6TzwQAyh7lW15bFnNTsFjS26EqT+7Re+0AhN83Ag9/j9hQzXvWtJ
	 MPImPWG1ebFZ5tnltvxb29STTrkLf0ecvBEJDHh4tSmzs20v6fK9vL3AmnjDYhy34aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQskcA8Z;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AA60A2621
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C29AA60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQskcA8Z
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a7a3b29c11so4804675e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795555040; x=1796159840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nCt5uIBBkppQcxpqoTId6AW8ghfLSBUA7Pu99I2wTq0=;
        b=zQskcA8ZlHw7+1G3I3S8bg8c2UnVXlDZpZFu/cHgKNGJGagbRIqOyY8ZsJbyrXc3gZ
         s4tIZ/+yuoMMpwlJUeGZrac0nZPZTc2nZOorRhGee391KR2ctTyoGtIXZ7o3NSEJxRjc
         m4vcvdkH/VXXFLIiQpsIbfJd5cvuFI3aSATqy6dwE9CDrGlBMc7f2YT3ZLeuP8gnBA90
         7kVR8RjQwfYJQq+Qw3NCCdLS9Q9rOShcLzOfNWvczoRzXOeCMuPdUHYNIpcrXOZV3vf3
         ClZeVw94hZhtQX9wsvJnTTvEMf6F31dOKw5kDD3tOtGEHOWCZhTDg7ROxHfnuJLC5yFC
         CIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795555040; x=1796159840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nCt5uIBBkppQcxpqoTId6AW8ghfLSBUA7Pu99I2wTq0=;
        b=02lGyMRrpADrYrkfVp5qGYpgPiSn+JDqO1wGHNw6x+FqaFFskBCy8/X3t3PLjFAtkf
         b5da4wOk7/2mq5gPYbTaknV+4oGg+GhYxZ0lS/Ble/SXkpLuIIBAX2xDsmerjjrPopb+
         HiYi/oMZrSTZC/brnfXNWpe/efawnLJ7i9j2b2EPqVZm7e9Lar9vSPTuV4dckWE2D7Fo
         xLmyRiTmTdlK14UCmFrJ+w6Fav2mV9n1H2lbhgVb9tnJ52Ot/Z5xSvWaG0ELDmbMYJ0c
         LD1c+EXQrefiLCmaI7gkFRqP6E0JrAJTXu+uQsxTTeieHkU+qoj9PZpYnDI/GuuLaG8Q
         nX+Q==
X-Forwarded-Encrypted: i=1; AL+hErEVLTENH6NNF9p8Ryas2UYn44BUq0rxyjdcBAFn7+gSxz8SiRky9xQ42OVsWJ4aEcvs6to=@vger.kernel.org
X-Gm-Message-State: APuU4Z8e7/jSpG8F9iEmNYx3Wck57ZpUrXhNF5mwG23Mq/JE8I7qmgzq
	GT+RV5SGR+Ah4YeY8kbbbwJgiJzokrAg0zd+ftvDILQeEWIfQbWUcigW
X-Gm-Gg: AZFdTZeWivM/EK/OEPfbfSweahWmpzxvqu0aqnJReaLWVxahP9qRhm6XZe5kv6SwXen
	cP4KI8e0g68V5yQVV+v+D/BWObwjtkeOeRVei63j1E4ciQ5Qbi47QavWONacFYMvw1Bj2UEgveQ
	fwdgMevuz3xTYp5/nDi54rfrfp8zt0hCDocpYCawLalP0ITwzUZVb8yFkRz+fFSp3NJMcS0U0Lj
	qL3lVxRaoc2Tmh+/X+mmKQXldTMl48vRW2hCjZXGoejSMVHG9zq12OGdLzZMhDysTxQD3DsKwa8
	h2Z8yGKBC0AAvwmd0gJsxywuffNAiXvLGJMjlY82mAPmoN6+Uog31ALoDuZNMe6WbRxTJsZqqHD
	V6HSyEguMSYr2bjZUKJfn4ikTfI2JoxW2qkMb7k2v9u97N4ANdIb+KGK1ceokJGAfA79XduHP/b
	5/NLDrGdhLCCGD4E1yyiNTgWprIANUcSsE9OdKIAGadp6Q+QTdpNfgtNj4joBao9znUjgrF3bp7
	BQjhUui7K0vkXkuRCl1I02Nn2Fq6Dntd7Mh+Bl/HeI2V7Gg00gPtoXSmMyIYoV91TFFzicJ09CI
	hFPKm2LDfMp6n7ny3zYQYYh9AnHTp1zvlO2kUfzbiEedFYDvY6/MEQOC92oSNluaudWo
X-Received: by 2002:a05:6000:4812:b0:4a6:bc53:2472 with SMTP id ffacd0b85a97d-4abb3b41cf6mr29086128f8f.5.1795555040099;
        Tue, 24 Nov 2026 13:17:20 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.4.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm29347713f8f.36.2026.11.24.13.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:17:19 -0800 (PST)
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
Subject: [PATCH net-next v6] selftests: net: veth: derive invalid-tx test value from kernel max
Date: Tue, 24 Nov 2026 22:16:44 +0100
Message-ID: <20261124211645.5751-2-emmaonana18@gmail.com>
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

The "setting invalid channels nr" check treats CPUS+1 (CPUS=nproc)
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

