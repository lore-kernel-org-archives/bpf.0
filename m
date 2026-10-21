Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609039;
	b=F1kA8hQSKIRr2gjXU16Kx4b3xdREZmROf0M/R1jR7A94h0mEBQFxTs5EwoMdDv65hNz3
	 azNTXFLgMeHoshBaXtVebl42KTwQ/Xq+lQvZ85ajRcXTpHoDaS6ut/gOB03bn2UolXuyP
	 j/1nletDAHWjcNLTZUyzRxN1CaqUfLyA+PsgMbfE6JQvVhXKHaXqJUGnN6MGKFCGl0FwA
	 wp5xFhJhtJrel96gCrTT37Len3raQG9hXXAS8eSnLa//E4KHT3NFcllSGz9axVGUKwQC/
	 /gNAmEbPYX4M+wBXgULW9/iqU6EWGvD7fRh52/pS0M8iNw3nRvthUignhRXSYxhEfDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tI/n7i8YUulS5nmMk231Om3hhflnA13FHGA5mnNrpuY=;
	b=hq+vF87mcwZfACP+9IIh++JMlvJRkJEK78cZC3a0sG6/cdk1nWuEfqJRC/sx+QzwH3Jc
	 5zXCFlTNRpwI/x0mSyDFMOT6m890NRkUWN7hggvHyaL62NSwS7SIthxBBTKUWB8JkccQQ
	 yCkie2gw8aZ6KiTQE5E+2Fex1DU99Pp3/90Qo14aBh42cRiABAvqL/tA3PdMu/63N/65p
	 WTXLrsgWP9r4QaPiW6b0CXWn0aIoqG4j9GZRL5uPWGjrPMuYAkE73ksUbiNunzgKBMU92
	 DG6SKIWQr8L285h39iuJwS9JAPoIxMRMcZfcsQd023qph8w/hJM7zRNTxZrvGZ6/LJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=sMdTfLuT;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92820606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92820606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=sMdTfLuT
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-188406bb948so605364c88.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792609038; x=1793213838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tI/n7i8YUulS5nmMk231Om3hhflnA13FHGA5mnNrpuY=;
        b=sMdTfLuTKJULS0Py84zcJG7gxVbaoZFLk0uy6tq+akLRbz8GTm24Ytky15ywyNE14U
         WIJshEp4jqB/NVXmTMwR10O5nwI9GMJZCcvHjT189KTkAYM5rdXSzQzxBwLc6XIY+iRX
         Dpw14ZhPgTGQt/zlwEmzAEANGQyzCbdGl7/NdDTeUvYgRjR5jX3YPZddOAFUaQvsbSFV
         ej37O/De8wCgGfMMpA3/TX+ztzYN/K/tjBUgc0WpSeA+YfKdKJ8vPylM6MSDxakMzykJ
         DAZkcGIMkx3YYJPm4plCpixnJA4FSv6HNxW0DUnfe1n+wWb0xeZoiasOMHMQRsUAwz1J
         GIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609038; x=1793213838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tI/n7i8YUulS5nmMk231Om3hhflnA13FHGA5mnNrpuY=;
        b=lkoKlzTxAVSrrXP+kMhWK8GmcFI/O5rNpwP657ViWFa65MjD0SS+jZ3plNgnMaZU0s
         8Qv0AhTqJhiI0wqcWJgQGK62KsfkaBjhybdlYE5pH72D2kkxSaxn7NKXOUKWA1gXgEo3
         iqyvV2HbQqzfoRWh5n7Ne2KHTNVQRJA9Sa+cU5nFNfljKjqjAFALVMg6lDCzo0Ah+Vlv
         cTtVQZK/7LiBgsT4XUpFLPLm3R/oOelbJr1tZ0iH6DMh6oaffGXsBoYh9aCqrDFoNQZq
         fU/ms/tbLOd/ZOJZXWNh5IYfwU9iDPTZIn3OeIpTNP/YIDVYz75Q54y4yTh7cjTr2qpj
         bI1w==
X-Forwarded-Encrypted: i=1; AKwUvBxlg+0Tzp301bNxgRinn+UX17ETZa0pzTaMlv37/rLhCc8cB2DLTXY1FbC+531v4/3zExo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoajYBm/sP/hJpr0OJ1m2kSlnjlkxhzzmx+1hhs0yWv2B9BHLB
	SgwXtAUx1ia893Ou1dni89cXriEhpUQWeuQw2plwan/qvszcv+tEgd2IAmOrtVgtsfbn
X-Gm-Gg: AYBFou3LX/wwR5rwxvk6CThvIojGxsLvXyLz/eyCexE8gH/24BMKZTa5B3/n+DeY3z9
	CmXNtDoACT/3+4LKki/GQLj3E40raNYc10gLU+wUf3OJzUndIWR2ExnLqMQA/qrQTopAS67VOoS
	P2jsheYL092f915WeJai1src+FmSaGpeV1IJnM+mwSxDU634cuVi2Gzi2YtTQNENMZMuMqaQbHF
	M4x8oWrZk0me0uiNewwKY9+Wc8v+hKRzhOm1kWrB727PdeCPJngBdMx0e1jGNY60hnElHSgUXS+
	17ZIUCuBfqX0ygaeoF7Pikjt+j1o924gy+6rIlJpl8oN/qs7hfJ6qMU4t1FVJAIgS9ASJ3z45tl
	ZibThP2TfIPL1X9AxtZsIJipfRjJIoVQ+JYLQwQrnXyN09rOtZ/Y3x4wHHFTlWmiM/q38Qenc8c
	gmskq5KcN/aLykiLTecFNxIVydUuijPj2Eu/l2K36s7im8siQFwtsX2IQFWmD/RFJMXE3W6sbLC
	owGNvcnUu4r55U3mFd3GyKmBOlEQy3cRGWIkBu0jAeqJcCy7sEwRBQnPJ+1W26QDyhMGJE=
X-Received: by 2002:a05:7022:387:b0:154:fa0b:6df1 with SMTP id a92af1059eb24-190a6fa9d37mr4175396c88.37.1792609037603;
        Wed, 21 Oct 2026 11:57:17 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180b9esm12553346c88.4.2026.10.21.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:57:17 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	jonathon.reinhart@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] tcp: release congestion control reference on rejection
Date: Thu, 22 Oct 2026 02:57:01 +0800
Message-ID: <2773af2572ff59055933e407a135b39bca537381.1792607608.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792607608.git.zhilinz@nebusec.ai>
References: <cover.1792607608.git.zhilinz@nebusec.ai>
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

tcp_set_default_congestion_control() takes a reference to the selected
algorithm before checking whether a non-init netns may select a
restricted algorithm. When the check fails, the function returns -EPERM
without dropping the reference.

For BPF struct_ops algorithms this keeps the struct_ops map and its
programs alive. For module-backed algorithms it leaks the module
reference as well. A network namespace administrator can repeatedly
trigger the rejected request after the algorithm has been loaded.

Drop the reference on the rejection path.

Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong to a restricted algo")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv4/tcp_cong.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 8e83ef81fc187..907c63af14785 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -293,6 +293,7 @@ int tcp_set_default_congestion_control(struct net *net, const char *name)
 	} else if (!net_eq(net, &init_net) &&
 			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
 		/* Only init netns can set default to a restricted algorithm */
+		bpf_module_put(ca, ca->owner);
 		ret = -EPERM;
 	} else {
 		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
