Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818510;
	b=b4M1GcGtW7Yw0J0UuTqUQJecYc6XHDZmGifXCsZAGPdcSkAYoMh4PHxEgqtMoHjDmEtr
	 /WLrWZUoHEk2344lL1T9X4dI3AsuIL0OxyhOiGLzQl4q8DwEDmP6e813SeB1VQBSHBoCX
	 QW4AVaPiShYBWV2mIgw1CCta9nZ15MSIjDq6e74vI006H50QAvCKnyNYVjO2OE7e/7Jyy
	 bYYVhwL9Wu8olXlEenyE5mDXTFBsxCSdY2AFea9j7xWQ5ACJmp5i9hGw5Elkdz1f9Y2oF
	 0g274zQhy9RL3a9YnNAr9cN8+0PGPfcg6jX19S7ZNOidUhS0qlaxoQw7Grv9+W5k3Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QAnazgbAEbBUyJvl2IrarULxEN8A8O9+J2KxABxOX8o=;
	b=XygyUPEKNDnhBVW+YDLcnrDGam4/+7/Vx8A1sj2QiYGbzcDNxaGaXhSwXk/DL9eO1lN0
	 0A3vOHU7RtT2N3+Uln+uhKJGhxIUe/cWDWyfb+GNi4a0XCxu/QTaxWCuABEplF36tT3oj
	 hTaZV9KaZiarjQOtiSUotskiqjVTQ08mqNVk/F3Ch9UIVi1MVHA9/+46Fm38tUbyarDWV
	 YnM9SIdDbaemgxV9/S50AbryRaV7DMZAdlwP/llrcjQRv0p5FZtHglfF0dV/qig5gvdxV
	 Owj7z6ssu3mg/KSI8md81iOsJqk/9j+0ZehBt2mQgLhGeprf+uUXhDX0a5HFD4bzWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wd16GRgR;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64694606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64694606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wd16GRgR
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5348aaba5so3410725e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 00:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794818509; x=1795423309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QAnazgbAEbBUyJvl2IrarULxEN8A8O9+J2KxABxOX8o=;
        b=wd16GRgRSa7VO6+SybNxvyCo3e+ypxaoEE943KTIsD/URI0L7FNt5Y1QxdgztsIbzP
         vF20g6P9Ktu74GZMlimq0HKk+vWaEwle6X4Svezwg4s6RXBYrx8S5z74domL7lWnZp1v
         /XMRjxSCLazvCJaMC/+r+zmbSmeWpNmUanwHqyrECn6LRLebioR7kYeyQ4az0mgpDkJ/
         wRREOG4SCTvGq7W7qQSyGbktgz+TJLCZ0QdACr6bLtQdcj5lBieMVBPjEwV2ycuHNLch
         mN4WLOER4fz3sU/0HEfVHSC17CBGoVwI9r3N5DycUvO3wwahoUbNbqP2Dp6ogpE46k7n
         IyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794818509; x=1795423309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QAnazgbAEbBUyJvl2IrarULxEN8A8O9+J2KxABxOX8o=;
        b=oGZPLWLtm22dHz/1grHPDbJhcCSr3EOEN7RhbAmuxv6iRdKQC2b2Wwn3D/H04jMYNM
         Z/P1BglJyu3qgoBPm/q2nIb/k+Dv9vbNhkf7kPyqzQ27SivA9fr4IcEtY14o414TE+o9
         oAXq8qF7AxMDt2rpw+41ZRkP8S2YjRhhW5MZ8Aruh+dpiskrjE8nNf0WiGbOJBfoc5j3
         kHbSO+LUMWxi1Ry07Uv5KZhByOwn4Ejk6Md9zsZaOj/JGJwIyfELBGEs9GqJ4gz1KTEC
         MLmli3IcQdqCAJkvB3b3gjdXqbKc7bIUZ9ewcva0eigpeb9neEBCsd8SRJgpJ9htNeLk
         vYGQ==
X-Forwarded-Encrypted: i=1; AL+hErEjfTt8ZF5zAjQBZ62xFj509BjSJg77H1jYwuGt0qq809dTmFyAUr/9BtcQ9Ci5bV2yZlk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZJVMLmSbwJrkuz6P+gJ3ymEHXP7EjCpKtFOcUyMhyk+0sY7/2
	WZxT+7h1Z1Jfxm6zk9c4GTfY7o6C8lwBROMrQ0tcPRybaJ4E3tkchTsA
X-Gm-Gg: AYBFou2h2Kxi3tR1dOwR58a1hNgdFwAUoXV1OA23oUEI4mqA+sVLmPAt0kDTYOdWdtw
	lATVs0QA6KU1ih7Z3h1CDGnlkgmk/+k0cRsWnymXLHY8mAXdJIB1RxHVvJJxr3S8AC5eLt9EoTL
	3iosQWg/rCuv4Ik7wHN6RpEXeSJDnvntYijaAdnOjEOtthg/gFcXWLw5nWI+hHhNZ47XKBnBFuE
	jorQhba22sORUfolXKP1/DMyvkJxR3RSpn/pmnSd4iVcTURaWW+Po0IojXobIVmLhYTRFN0hEQx
	lVyyU+21bTpZwUBTQVrQvm9QmYFLyjozfzmNYX67Q5kbYAruwcq82LalM0Pb+zmuVHOv0dQMSPE
	IPsCtQFmG/V8QkjGNoach7EGKKFn+YXSgFlADMBEgenuPJLQ2T3tD++sILgoRxFkWMX82GJ+8jT
	xqyjvk6+eu8yWOskrkYveFL3Ix0lnqApgnRH3l1rDuPy80n8fWMriAxQgk5HMUgrcwyd1mt8OXZ
	WDHU2sMpWQyCp2Ozr/PusZ3SnGlJiagf2SunmkGns8CRmuaiKx1rNW3xs1RjLEEGsMoxlfpB43r
	4xOns1KAMlWi0H3MXFHVmCXmaZ2YDxt8aawfN+bYxziNU5L5cOBbajPMZPwjbae9FfcK2Vt8
X-Received: by 2002:a05:600d:6409:20b0:4bb:6fb4:586d with SMTP id 5b1f17b1804b1-4bb6fb45a20mr42466605e9.0.1794818508748;
        Mon, 16 Nov 2026 00:41:48 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.221.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb62d5ec30sm284300555e9.15.2026.11.16.00.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:41:47 -0800 (PST)
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
Subject: [PATCH net v3 1/2] selftests: net: veth: propagate channel-check failures to exit status
Date: Mon, 16 Nov 2026 09:41:06 +0100
Message-ID: <20261116084107.6675-2-emmaonana18@gmail.com>
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

