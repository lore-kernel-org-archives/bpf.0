Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818524;
	b=AYc53MzFspdiWNWP3c6LKmIj/Wb6WRbl51+fpB9fD/7YYLMrBZ0nejen4Er7lT+ZvNEc
	 2qFMHY6uhzk6kYM6nxpKOcIDYb/cqGEqDMX43beaHON7mz7izevn4qP5kuuoo1mhseyqj
	 WUs1ToLuZsw5tgdU3T8DsqMM23JZ/nZYWXIrmy0yiPhotoLZdsHG2pGcBtYNRWd99oIx/
	 n86UqG0ZInIykRd7IJFk1mWAPWJfBwPdibhlrlf9eBwzDMTDol/f/Gy/LDOkL0t1lUezK
	 L0M6LbnhmC5ve98LPB1jXS8YV6YZWM3L8mAnGhMSuNMt96Z1VQMuWI7E9pxN0y68xIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IbDW2yfp/G8HBG/wT9ipOeQ5Z+TwPor4+SUJgaV0UTA=;
	b=zDQVv6XZ8LJIUfuF//ZlQC8n22ZlzFNkZpax/tO1WIDIlwI+ZN5r4xY8IEXWvUYx2A3w
	 ttKsl1fyPaK0/vLfwIylkJgZLcBHIjlpV7S/DijNJwVSuJm9taH3u+b45eEnY0ZQYNhMk
	 3csb7/bvQ0LuRBDZNklbBsf9RpxPHCOxz6S/ct+ugPtp2jXK+Rg9SWBltOJJh/h090lAo
	 PAsQwE//0Gqs9pbZXG2JAKqEEKgBGYeiX/dOgXUhZiwVX/rNVLtRQsH4o9Rw0vVDb0nHI
	 8vZ5nwt89RU8AaAi9r9zeTj8gyDTaoB/sNTcSJ4Ag3G8/ADnGRyD+D2fUDpJEiILZHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZoA9pBn2;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D9606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A6D9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZoA9pBn2
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb72b6e1b2so278695e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 00:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794818522; x=1795423322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbDW2yfp/G8HBG/wT9ipOeQ5Z+TwPor4+SUJgaV0UTA=;
        b=ZoA9pBn2SaQcXdbdTbDGdUqkVqrFSWt+g1wynpHCOei8Q80uX3HN3uHnYFkli9EpRG
         32eCjf+w9PF111gI8CFo/2Fi6iAE8awhIK8ghCdj1w/Z5crBUJCEdB83o/LRmQazFxCj
         h5RvnVii23vtsdO+89HmwI8+MkPFeZOKVW9+kNYlK7TFWubhLKPo5wYsAhYf/4RCkI1T
         UoVlloGuVEBvVpV5t3vXpqc9paD7z+rZ0msoiFb0TefH5FcBOiGaSkEvImmecOZo97oE
         lJpXf2p7y7H1i7zqcUPmiYhnOp7/Ab9yXqGHGSu6bD6g4r8JAACBJYaBTBaZ/1hZOsdg
         BvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794818522; x=1795423322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbDW2yfp/G8HBG/wT9ipOeQ5Z+TwPor4+SUJgaV0UTA=;
        b=CjfCDEHibcydIxT1UQnWGXz0QRGhxYIMAqG3PlGOxq7RAacTGicY9GWXOZRPxYtCch
         xx3VfqwV5rWM5EjhQtstZIAkQ4Kkxm5hrK0WNEUZdzNzJ66e8w9XMhzSTdXqhxnh8dLo
         m9SshdfS3cMYccZY/e3MFFNcmyny3L3s+9wSpBu+mTbxHldJ3MuJOmphzWYdBXZw4FqX
         nS2y4E6MSbacAeLptu5vBtS6q+u6wrZ45LihvXzRXe/BJo8K9bosUfaPuTqw3WUOtaLg
         AE+J+Hr89Et9jeckvtmmL0x5cYK61RhqVWM8/HwBwrn4N58ug3Wy1tvEjs4oMCUCLIID
         6PnA==
X-Forwarded-Encrypted: i=1; AL+hErEkzKFEqPCEiML21Mu5/v7Wb9pqaH5/cRqAu/x20L2L2xiMYJdrivMv/kumA0tu/gYtuKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SYz2qWjOvXLejTW+fpe2NBBc0u7i3eOC6qALpO4epQEol30ee
	veFqkiHnGWH1e4zll2WLxbRTQ2nL+Ls5IMpLrxlvCWbD6Rt8/ZOrzPW+
X-Gm-Gg: AYBFou3OtLO7LxYv6lE1PLmEn9r+HXP6d17t1a/Iwi2mlthSoKJeGhsawDZrUdDil71
	uTylYpMQdGrMVCsQST2PPvAZOEksvHmYBOISb8GKXbqx5W+55MGw9FPS5+BLvgJXSo6VDiHUr4B
	L7w0uvOH2n83zlC3NKKBXY2sAVizrWeb8QTprfdppkS+dGw2WQMT6Bh/HUFYi+dWAvZ50G9DHaL
	wdQF7c0C3r0KFWwtgzSd6MJ1yCJ/f6I+vdoxYmm23R4zzQud2Y6HEzcpknvmiWL+b1ugk/rbhCj
	2XO11qVqvHevIndSeBpHLXJ7y0BoCQsEyqqfYfQt2LNioXp+XCfpV/rl3SVFR9rxp6bjhtJEVE2
	88HiObL7o4KHvGgLSI0/CGKbySGsRQREHk7Vhd4ZcKQlnp784Oa+VZQgSLRRS4Af44p82JdX2F1
	acM2rWGmVG9MXD3noWIYBNKrqCnp7LHcqeL/c2Ex57bzx7ti2o4rqoHXFnVskDcUq9kX90OoH6Q
	gQj7GWP9doo12m14r3URCOsGSuNiNlZBx7H0Q2hP+wH/QGilfXcfHSMgIl3pMq957VeD/mB1Gn4
	/FZrQW2+5RaY36g7BIZIE92MfGsL0vd1NWUvyq60d39VjG19138znnNYNZtkwT+N8z8iqgA8j+M
	3sYNW7xa3Sr1T7E1vU80=
X-Received: by 2002:a05:600c:16d5:b0:4bb:732a:2837 with SMTP id 5b1f17b1804b1-4bb732a2af5mr21460175e9.1.1794818522364;
        Mon, 16 Nov 2026 00:42:02 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.221.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb62d5ec30sm284300555e9.15.2026.11.16.00.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:42:01 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>,
	Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kuba@kernel.org,
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
Subject: [PATCH net v3 2/2] selftests: net: veth: propagate bad-settings check failures to exit status
Date: Mon, 16 Nov 2026 09:41:07 +0100
Message-ID: <20261116084107.6675-3-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116084107.6675-1-emmaonana18@gmail.com>
References: <CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com>
 <20261116084107.6675-1-emmaonana18@gmail.com>
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
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 5c1dbe1516bb4..0b173beed3442 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -474,7 +474,7 @@ if [ $CPUS -gt 1 ]; then
 	printf "%-60s" "bad setting: XDP with RX nr less than TX"
 	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} \
 		section xdp 2>/dev/null &&\
-		echo "fail - set operation successful ?!?" || echo " ok "
+		{ echo "fail - set operation successful ?!?"; ret=1; } || echo " ok "
 
 	# the following tests will run with multiple channels active
 	ip netns exec $NS_SRC ethtool -L veth$SRC rx 2
@@ -483,7 +483,7 @@ if [ $CPUS -gt 1 ]; then
 		section xdp 2>/dev/null
 	printf "%-60s" "bad setting: reducing RX nr below peer TX with XDP set"
 	ip netns exec $NS_DST ethtool -L veth$DST rx 1 2>/dev/null &&\
-		echo "fail - set operation successful ?!?" || echo " ok "
+		{ echo "fail - set operation successful ?!?"; ret=1; } || echo " ok "
 	CUR_RX=2
 	CUR_TX=2
 fi
@@ -491,7 +491,7 @@ fi
 if [ $CPUS -gt 2 ]; then
 	printf "%-60s" "bad setting: increasing peer TX nr above RX with XDP set"
 	ip netns exec $NS_SRC ethtool -L veth$SRC tx 3 2>/dev/null &&\
-		echo "fail - set operation successful ?!?" || echo " ok "
+		{ echo "fail - set operation successful ?!?"; ret=1; } || echo " ok "
 	chk_channels "setting invalid channels nr" $DST 2 2
 fi
 
-- 
2.43.0

