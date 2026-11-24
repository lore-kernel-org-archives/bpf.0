Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556463;
	b=m9Z3Scphscg7+Mm3SUbc2TY94siQ32CZIGmYwl8JTO4A7vdqm7UDwJr62TLM9JEoJuAi
	 e4u8BcaKye0rPPVUWtyvYo0Mrcvr84k8p15OfChbByOIlJwE+96M35lySZEF0eXRepGeg
	 KA+lQsQKjGpyzhJioqsqW3W3v9tbHbTa6oIs1SpD/0KcYnLbTjii3KJSMtE5MnH2Q6Pyc
	 Ip3fomAzOJelrpDbdDqgUzfnrWJ4jp4vWdkcA6WO+YnVJimX406yDbPfYULHPVTEyOwNI
	 YnW9hLNw6UF0kA74roTiHHk+CaSV193x3gnLEtdtJ1Ad3uBNIusCd5Iv79hBf55YLWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6/Eo4P9Q5rSLruD9XOambCG6ddcXLpv660iZmjCXc5Y=;
	b=MEbKESYHogUyrckK+oC462SUCs1sqS78yWrLfQJ2m2YLQi48vZxR3UJB54pGQMX85b3M
	 DhhaDIg5Wo1YRMIc34C5cHU+a5BWFTqyWYS6Tod6/vf7fY/3WbAJK7c4RorcF0rEwL8Is
	 nMDxjkR+E6HV5AOuq8KoGR5xDoKKfmPwZ0/GERY8wOn+ZSUfvUGeAxczRpbHJAQ49WBdS
	 lpRN3dpOzFSmkSVpWe1MwohKTOz9LaadBIaKV8Zly1RW2eemFXFaT8BBlRwTltiRQGN7o
	 iKdOGAJiu6Q1Qp13NekF4paLNeOT1ZjRbxZvFL5/C90FGeW3WqsShu5T1Fb6K5Zmfeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vbh6Go9Q;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5C606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC5C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vbh6Go9Q
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so4677645e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556461; x=1796161261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/Eo4P9Q5rSLruD9XOambCG6ddcXLpv660iZmjCXc5Y=;
        b=Vbh6Go9QrB6H0Ci+ICfsnVc/Vnpu7Z5MeztCGu0guAbvGlNHsrrPkk0VY3N1pD7MHC
         VheORaOhmiPJ6e5quiRTYcJm5iS7zGq+1Sbb37Ae74UDo75P8sxw/QyBrrTAoVpkFRym
         4sN0CqvmxdOnDEXqASm05sl0L5co+sBDSlRInJOxlAXsoKtWpDLmJ/DhPMlt4FqWJDqI
         Go6Y81x/DV6JJexZsaXT39ZqhZ4lFAlfA9BUdf4N/IwO7ncpQGwUBclACpDn6fhpL4A9
         icVhYxkXAUfD+s36UfHnwhkknLYY5slL/VA5KajX5FgwI0lPvYUFloKHo3eDGQK8vG+8
         E8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556461; x=1796161261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/Eo4P9Q5rSLruD9XOambCG6ddcXLpv660iZmjCXc5Y=;
        b=XabRwsapaP/47U/SO8MlcWJCDCaVzO3x0K+8zldxUvGUpLKDnmpxxtWi/462PmyQ2t
         m8EiORIZgu6SLEWiVVzAJsq2wFV4MeHCsNdwJMrAfUQx9oxr+27FhAuSkdTZsTrpbRHq
         KQLhtGjTfiLh3nfD6KYXYeo7v+8Dhr32KBr6oN0oCXnPm0PxjdSDhe/DJUldccPz9wHO
         iCvp3MGHIG02fobLQBKOOZTRDAi5orqjWzHEpp6eJbxUA+bXNk4fyf58uQAS/oYu8qn6
         0j0tsD8AqOzbJlB6HoojnePPZGpLCU9bTzJeVIXXSZK1tI0l8X3uMFfextpakm3W0EO0
         jOdA==
X-Forwarded-Encrypted: i=1; AL+hErHVlVU6eZOyNbYJ51rhucdQVfufgHJACBkBzuQHkH1gIxlBizNGhLe6DEkbCC+3KABpgWY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tp14fo7beehiNVuTEbWRZGb1+S+b5M2K8ZRhnYb+OCenhUn9C
	hBhflj3l0B4Hgy1MS0BMdUWexj845m7+xD8DTsTej3PeVHFLM0Jltip2
X-Gm-Gg: AZFdTZf/nN/jHDluyULfRzXHEqYSGwwd13Kvdp0QEwaNA+5ExJ9bXLRF3MBN+6iVZKo
	XarI3rRj/BeJXwqW49pFobpNQ1bVvpj1ad2LBWqquwAKGpF0bCIH6X1c7pFyd7SFzXC4dqgMsym
	GsZcy/vmMBC7nGa8Vb3GH9rHb5GHGpK6gPoEEUD5Nq9GtdNDh/SJxOdQg4b1hEr4zQJF0IZkwHd
	BFRtYeeCmKLhaZntH12WLb0kmJktZLfQvhs3GS784y4HxNfe5msU+jTi+sWAIvxFpkwv6FBaUC6
	6M1lUxpAQW9fau7zDd1NOClW6oKDxeILL4gpK6pzC+Gm1e4mYJ/xEtHSQfhKOP1DLJqdgla+ceV
	jIu11G8q99/xNJLQVf2aS/UXngu1mdLrMjN9Dv4b4OPS1BkYkCzrjAPtdDUL7FfrxF6bP0yqsEt
	9y06F65hNgj3m8VPjLGim9IN850QHQQHcu15U4ROD3sE7e3npF9wtmovAvrDXk4PDsU2l7HA/vx
	2dEPMG9bhg4Ss2MKrsCkpt+KULapWw7YO6NZV2kyZ+BtvrK6UqWmspi/pSvktppFfVVEgcCHsa6
	Q+daKsDO1BeqMiAPqEwunCEeMnmRt71SnYe8xCnRPsSngDoNIyj13JwvE3saJFYECZnchQ==
X-Received: by 2002:a5d:5888:0:b0:4a6:d298:832b with SMTP id ffacd0b85a97d-4abb6095e39mr30672204f8f.6.1795556461284;
        Tue, 24 Nov 2026 13:41:01 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.4.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm28290872f8f.34.2026.11.24.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:41:00 -0800 (PST)
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
Subject: [PATCH net-next v7 2/2] selftests: net: veth: propagate check failures to exit status
Date: Tue, 24 Nov 2026 22:40:25 +0100
Message-ID: <20261124214025.11603-3-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124214025.11603-1-emmaonana18@gmail.com>
References: <20261124214025.11603-1-emmaonana18@gmail.com>
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

Three more checks in veth.sh print "fail - set operation successful
?!?" without setting ret: "bad setting: XDP with RX nr less than TX",
"bad setting: reducing RX nr below peer TX with XDP set", and "bad
setting: increasing peer TX nr above RX with XDP set". A kernel that
wrongly accepts any of these invalid operations would be reported yet
the script would still exit 0. Wrap each fail branch so it sets ret=1.

Reported-by: Tianyi Gao <tianyi@cloudflare.com>
Link: https://lore.kernel.org/all/CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com/
Tested-by: Tianyi Gao <tianyi@cloudflare.com>
Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 22246278e6049..6eeb123aaf885 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -130,6 +130,7 @@ chk_channels() {
 		echo " ok "
 	else
 		echo " fail rx:$rx:$cur_rx tx:$tx:$cur_tx combined:n/a:$cur_combined"
+		ret=1
 	fi
 }
 
@@ -473,9 +474,13 @@ if [ $CPUS -gt 1 ]; then
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
@@ -483,16 +488,24 @@ if [ $CPUS -gt 1 ]; then
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

