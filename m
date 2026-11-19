Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048225;
	b=c+hYsiTAZTN1x/APwpcc46DgD9tMbaINCnFEsVqdp1cwmFfAHapvx/QTIrmjkPJhRTCB
	 9Y18A2jxSfxGMFL3rWflNdhCYRCuyxtljq/0+MwblsZ9S53PRHIt9MDbqFioJP0Jsygdc
	 xOJ1dBT2rofTuVyKdecpEZdrXbqmGYsy0tUowDFA2jET9DPAae+AWhCHsyfjQ6ChIquKj
	 MTdBGjp0qy7QzTKB+RwTvYdzSd33nvEvL/AVDk+ygbQ7CBzZqzqkDrF2kiUCKpxjlAq/i
	 tG85EYY4FNo9Qqz8TQspVDgCWRlegjaS9nZm2+RsYG7vjtHYKIMzWjo8gFyuCctgPoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QAnazgbAEbBUyJvl2IrarULxEN8A8O9+J2KxABxOX8o=;
	b=1IMoJJOx2Vw/TVNN0pjt6ewZ8ta0LxDXGahmy9ZwXv6irLN9eqqMlBdrA+v9mkasY5qq
	 OH2sRSAB0QBzHY65fIpnMm4NaXfBgE6aj58xdOT/m1GzZxpdBMpgsj1pwHKWsy9zoz3Wm
	 DS4OHkYJAaZYyfsm+p4z/396hYkeBUTY2i0iHq6CK2ttz2VUADB6vtkNpm9ACLAWp9Gti
	 39K4j00pnExYVkdmL0e1GQMbFpszEGx1C1arZa6eO0IMov2bDlDdjyWLwMagnOLQ4qFYz
	 Y9yNAf0Tir1u4jl2X/yCoWik7osYLl8Ox0+PXEVJFGZey5R8MTSoXqKfmeef3HfjDLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZOt97z7;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA11606A337
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA11606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZOt97z7
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c408e21e8acso42727466b.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048223; x=1795653023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QAnazgbAEbBUyJvl2IrarULxEN8A8O9+J2KxABxOX8o=;
        b=pZOt97z7oXYPDrXer2WA3LC4yS2BO044M6yHvur62qVooM8RRujv164PxvZTmPo/pC
         YTEyg0l2pdWvhT0e5vGapkbYWYaYe3zfm57V5SEkCRSwoYTGKPt+j28zJ9yFfRInOOuB
         lzSi+wlIQEF81Lp9DT3Umx/ywacnX078dJoyLGYL9vOlkpyQFEyjy/DF9LiNhwPi5EyT
         Git1WOgf3JoINy8xjyg1h/YpZYHcf6SXMKRVkDFoTJoaB7P7W4H0f0kvgM7IIh+8lO9R
         X4InlCI0k0LphUqOqKDtpA8OnIVQAbh7KPZ73XVJDa8x/3ujv3VJNy9ATUKlAHSKa9HK
         Biww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048223; x=1795653023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QAnazgbAEbBUyJvl2IrarULxEN8A8O9+J2KxABxOX8o=;
        b=KxS7tOLjGhcwDLU3FaE5ZIikikE+qNWPLOKOA4L3RNi23jJ2w0TtevSQbKdvIHlN15
         xL2iDcSIlKxRYCCcQsM76C/KX7I0Gwqwi6KrBn1Ej/AvgvnQEDq2Vo3W74mtpSLh0aLm
         L8OXjQHKpNImaRHla9QoW1cSgfVDGZFXe6vsOaYDxx7e2tOjoEoUVizjEZPJSe+hzZaj
         5rFy5rK+JCGrkp62376I+S0jvfxyPy3zk2fk5sm2ARIC0BTfhFx/799f8Me+jD1UZEmH
         ec10Oqu57ecgSMZXG6BwO8hotai26T6Yc6steUgHOEqqHE6GCc6ltpRs4fhkIIixpfyD
         lRmA==
X-Forwarded-Encrypted: i=1; AL+hErG2dCU6CeBbfPUEXz+ai5fUt+0ucSy8h/Kr6pakom5oKjIV0EuJ9dGCSuqTVNq3SIWoEa8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Mm0koBTza/u9pM4lTBSXAJyLgjH4eowTWRJvwfQeqjrKGD3uf
	x6CxoUqXv8l9gSfYuxF5pjrtCa1/LgjCCAcXXicy7MBS01BXPdKVQMMS
X-Gm-Gg: AYBFou1SijtvHgiqlOA8jsK5yzdGb2TxurNpXYBuMD6oxWxE0O7GuWO0xpvR7Pik30R
	RgDw6RveR7zLiauwyTBXcrzKYmfeUBcVlIG5glbH13owenomW+HPiiraPa3IsKAA5R1OgZFYmHA
	MNjbLO+MW8vYZuAKGPnlhXLLcfCgnTVPJgE+l+spuDoXcn7q3AEoBHCYbxme01F7NU69QhN0aJp
	10TkJLXCUjbOpTkAHYvwWKZ9m86ceF7jLcS1naDTyz0hCt3CSwMNbauy6pJ7lmx4usntoDT/Rkq
	hgA7HQzqmsBimK72HaY8Gtp/KsoC/hx/CaxgP44NkpA0cI4ZMK01wSvGIiC+FbEdeu8j8dxzJgJ
	ha+RZY3yava3Ub/CgbJ/1udAlUgHbJvcI8JuwNzLpbOty9bTBQ4MMMCrtY93KxsEABxHFyrvWqL
	q/AjrsLS54IXfIq/hnYRLihOQghR2wYDTKpjO06uqsD1LoThJ7iB+CnLo4CSQch0ozYAnKJ6MTH
	U/cdW6BALiUyI7HXxl/Irwza72z2lqWKEJX1kHNk+nRlnTMr/DDhf9b8HvtIMjlm+b1/mlQPCHX
	NmtYNSsQFjhCgTgvTsHbxcEynnY8kPLpCBTo9IxLpS61/l8uYdSBpnoY7z0nCnBAedJyk0AIAA=
	=
X-Received: by 2002:a05:6402:2422:b0:6b8:4f3e:62c8 with SMTP id 4fb4d7f45d1cf-6b8877decc6mr4950784a12.0.1795048223372;
        Wed, 18 Nov 2026 16:30:23 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.208.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a001123sm1729744a12.21.2026.11.18.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:30:22 -0800 (PST)
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
Subject: [PATCH net v4 1/3] selftests: net: veth: propagate channel-check failures to exit status
Date: Thu, 19 Nov 2026 01:30:00 +0100
Message-ID: <20261119003003.40482-2-emmaonana18@gmail.com>
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

chk_channels() reports mismatches with a "fail" line but never sets
ret, so the script exits 0 even when channel counts are wrong. Every
other check helper in the file (__chk_flag, chk_xdp_feature, chk_gro)
sets ret=1 on failure, and all chk_channels() call sites expect the
check to pass. Set ret=1 on mismatch.

Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")
Tested-by: Tianyi Gao <tianyi@cloudflare.com>
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
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

