Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560040;
	b=LZL8ndxIyL+RcGwXPI0TEhl8xNKqt8usFW0+BeVsmBCTOTn4J+Grv3Ji3sp/SA0jWNTT
	 s2E0ooUQZM/DZbfBJlperkc/9oSvgm0+q5JcT4RTM56NyCQyzEVKDyx7Jk//h6svcj0xL
	 17Wi87g/Oopw4AI+EBd23YRtD6yxiDr7UQ3GGrNKd/f/+KTsL7RJSlK01s+IvNmdhEAyc
	 aquitA5CHoChnTqFOnXhi7suP8eELnZRhbuE/v+TczOZwPI+q99Rlxv83jbwO4o9bzdjI
	 oh3w84OKi0/Klf+NBE4jvXiEEuTniIOUhKeF6lc1i5OyVUKIKAUaUUYcpaecpifNJwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a21O82dvQUevxkezjOIgTCThf5P+xceMeGRnT6Lu/Vg=;
	b=Wu1yrBBnKtyqrqbFHwfX/YOaIpE/y65mcJPIWraH0R4xdnsFTar2dAVRQj2s+hBY+7TQ
	 WL1cHV4W89NJr4xrBtp4uDxYSYZNzPZEjwW5WmGP7sq28BPM8W5GDGOKDECOVLsNd2rwV
	 v9Q2nLgI266jBlsxl0dj24pnz7Bb+I8ERLCJH145MM5xxDer/sqTqz33FPScxZH0dnXqi
	 cQpi4kq5K8HAEqacB93auZUfrxIPlUj58rb7/9XdJZm8d1r30cqEAwCj2uybB3Yr1LIIv
	 33xD2Kdu2VpyMcGtVuhmNQMUsCsxMSXdjtuyrqS++B/rL5kQJuWe0Y5HeEikxhl55nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWmuWie7;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59A606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB59A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWmuWie7
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so1046495a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560039; x=1794164839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a21O82dvQUevxkezjOIgTCThf5P+xceMeGRnT6Lu/Vg=;
        b=OWmuWie7hUIAuYGDZfiG3aScX5Jex3OZed9ZumHP8IuX6kd5EaDAylRMk+Pdlg6/Ai
         1ShCtdn1vt3maKc3s2Ti+Z6u81/tIEV7H+FgKjIx7ReUlCPebAyEluNX4987W3xRy7oj
         63obR8eq9rSUjdNlNTjQ7/9VXSm7Da1iXFnJnP705egl8ozURRK2+CbM4sGNzKohCSly
         pcA+WFZ4ibAZ6ejKUIf57elx7bwDLKoednzK0dFEpsKifUpwnDwh/vn2ZNBaTrUxY0v7
         3KhcDqZ4ljX+2MnD22Mn/Nqxf5pSmBvVdGveXCuFcAD8qwOA2aqhg10xUEChoitVn0wp
         p4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560039; x=1794164839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a21O82dvQUevxkezjOIgTCThf5P+xceMeGRnT6Lu/Vg=;
        b=NmHNp1C01NpF0RsB6Px3UFg4lbWBcyuBABE1zQYevX/pZQmIhCL4MCgm9M6dcvYgfe
         XS0WYqe9IBg2xHJ0DEfrVGHhyqDE8kZKygvgjbls/vttCNR/1BwVlwlNFDcMch9O2Ozw
         E9kFyQXOClDqGyu0Y3U8zTWMRvyWtpDt6yzBYLdU5n3h3lQw6VAT0iKlSoqTOJSx7+/N
         2Uq00457VSWBlgplevK4I0CJAnRoravMuX/Ia0tazQhhArzrGxqXXO1ckwkI0UXt1DFn
         DSf2TSssT90xnLrIo4Gd6WNgKi3cWwwmt7kNJQmDy9GHZa0irrwqF9FsXwuEHkXNtSuq
         rE9Q==
X-Gm-Message-State: APuU4Z/Eh6nqUXlVO5+TPMkY55+RNstLiEc/lt0MvFdV40nXOJ/Kt55f
	llJ56nr2gJewdVkO2FJ7r9zGjhDUlKQX/8sq7NMCwKhE2+eNxUOer6rCwK3E5g==
X-Gm-Gg: AYBFou33R984K7mbcbwFVUKW0dNvD1blHb1ebJKaL8QYgHPMqPX2nlRyViAJw/4qEQE
	24jcz6Otazp/9Ur54yRHwfTIKqawAFmTdSdqXKjFF2eyFinfQq4h7fIsHmu/4YK8v6Iscvn8Xi5
	vYeEJqLTbklAO0KTJm+tITFkkCRml4AzsZbR6qdPpN4z5qN2KjTYipWPaoQ5ItHBg4hTokAT4ez
	EP06yI/6R2N2AVDHrIt3HGYREgbjt7enzchZ9IcOI0bQyxhgCQabVKVAv1koaKAffUun0bonxR1
	heSHjozvwit6yL/m7MXBQNO0pr8opXI8xJJH6i8g6czYFCEVqIJyMfv1aNYPVgMgvl+bx1erLLU
	Tl3vwgXBmaEncC1Zqq6S8NzVXl/H+rz9nxyx2YS2UhWNdynQo3ejc2pRc1ajQlj6EEhkAko0FtZ
	JBnChMMBJ6eos4b6j78hHAOlQSgv6smon6I3hqn7TZoKWvq9go25Jwja/INS2ky3u8SjNKwe+Et
	0W7tWQbO0oNLxIdYHU4r9wiUTDOiwC0Q7i+hn5JYxoqdWqccOxQmd19NimEEIeD4a0Ji/ezmWLE
	5E6HZ0Y7wPseNm5c1f7MNgYAVKGVaz5o0PupxcGNBG/WlCVYNC4ASesS7XPpgydkoZJmLCS8RyJ
	G5tYKG9Ll0nHoqQcq0uRcqfIK/HEeL8sbzNEzcsHcNMU0lSJ9k8Bhr5We1+/rABKE8+pNCLQalg
	==
X-Received: by 2002:a17:90b:4e8f:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3ae89806287mr6106143a91.49.1793560039281;
        Sun, 01 Nov 2026 11:07:19 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aebc89475asm1244481a91.0.2026.11.01.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 17/27] bpf: Set a dst for test runs of lwt_in progs
Date: Sun,  1 Nov 2026 19:05:25 +0000
Message-ID: <20261101190535.1454146-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

When an lwt prog runs on a route, the skb always has a dst. To push an SRH,
bpf_lwt_push_encap() reads the device from this dst. But
bpf_prog_test_run_skb() sets a dst for lwt_xmit progs only. Thus the helper
dereferences a NULL dst in a test run of an lwt_in prog.

Set the same dst, ip6_null_entry, for lwt_in progs. When IPv6 is disabled
or not built, their test run now fails with -EOPNOTSUPP too. An lwt_out
prog cannot call this helper.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/bpf/test_run.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 3043a7393c29..d6c9dc62182e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1210,7 +1210,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		skb->ip_summed = CHECKSUM_COMPLETE;
 	}
 
-	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
+	if (prog->type == BPF_PROG_TYPE_LWT_IN ||
+	    prog->type == BPF_PROG_TYPE_LWT_XMIT) {
 		if (!ipv6_mod_enabled()) {
 			pr_warn_once("Please test this program with IPv6 enabled kernel\n");
 			ret = -EOPNOTSUPP;
-- 
2.55.0

