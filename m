Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B33D34BB
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979098; cv=none; b=aWHNSv3F3wV2OtZ5vBnIsXD5Jv09Qzd1oVwSirfiGftqIkifspOcH+hi2tgac3sZF2F8nILYZeK4mHHbVwaPbEXak64ZEGl/aI74kiM6U1w0dd/3YHjG/xgrXrDY3zlq5WxiMxfVFOPbZ/TlDs63rAoMQ1tneXjkloZDqb53U1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979098; c=relaxed/simple;
	bh=x4/JSKwPdawieLVNdXlh9IM+37VIL0f1d3Im45Xk6NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8Mbt3uVIpnrdiNcBS7DGR3ssexL7dUaxzjBnG58/og9Or0tuXUpnfzmue9k+8rHdBZ4uvJsh7tPxrOxf4goq6Xd53EQVRgrq+dbqhRAnSX4eHLIFrU0f1+7mAbAYzli1mL+xqBl7aGXHjDc+znO6Xf+FYWbUxSferBr52m4hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=DW3yEtUj; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="DW3yEtUj"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30b6dad2382so9281996eec.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791979096; x=1792583896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiyPn/AszpmPaeCiQUAJFRlFHnxES35jjFpllUD/s/4=;
        b=DW3yEtUjcchi8sjPJA7tvhlZi/9vwnwQHKPoIOwTtXr7WnhAj9dvrF8eZv09E3jLRL
         lix3I49cpZY9WzW1O7d1dFN+LVCsVWRH7L0qJ2kxBD51fwVCgaBhQ+prL0aHtO6HZoe1
         uO6DnrS5Av1btG3UI9VDszXrYMpgIIOCVqf6AzBy9xNmaEo5b/JyUjrY1+34ETOHN4mN
         hxuWZBKAsWOka9jOWuh8BycbuSxnZJmxFFjV5iGJ+Td+Q5iCGrrVM5udeG/bKp80O3XI
         pZLpFO+cvRqkqQpyqnbUpN6RMY0QwyDe1r+ZxQDL8DBk/vYWpEeTwOCNvRQQ9ZKqBJ3p
         LAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979096; x=1792583896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NiyPn/AszpmPaeCiQUAJFRlFHnxES35jjFpllUD/s/4=;
        b=vEYBIhoJHAFZOWkK6v8sGYiCRe/M4QcuRyTwWS7mGm6hXQ5yCegJerScp6mZs6InXb
         X2XsBrdaiVN87XqGdsFqoXqNtknCvXalW6vftLjB3k50hbW/BJK/xX1pUn2LXBotBVkK
         EZSX3ubPLTiR/tWUCbQnKE/QZmBGsvc/Rpxjbe2KJc+fXAej8SnPkSIKIXuDtVVz23Rd
         3hiA0tsSjFFZrlKxToC/a86dqWH7/i41IXkEk/9f3ZeLO1Urgc550mPi9Bk9EE970kIH
         6Zf0VcNKJFlKDsWOSbsexiEltUurtF28Guq/bYspdXQA8bEOh73lnSHWBG5jrusJ78KI
         8ghQ==
X-Forwarded-Encrypted: i=1; AKwUvBwA+HADhmQoym9rlDHhmw8cX64Ts4LmnLxaM1YLCwMzGEK1xlteyu5znmV5T4GJ4G3Li9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfD7ncjzHc/pvYOYrE4JMaB8FzOvr0CgTrEdq3qmMtXwHC0Rg5
	gxgtUf6S7NGznsJVcUGIDVS9PHFZqWsi5NSMyWnYrHnPYRv1TtXx5Ks0POTTepODTL8x
X-Gm-Gg: AYBFou0BOy40BmG6sA63Wab9xdjk98XKeavIw/Cc1T8YlHTsSQZ+2XsnbrBZ6pSStyT
	Ila9DQuiqEsfNQtV02hzI2poCWtw1PhKHy3oJtHZUaOzj4eKW0trey/0a8wXory7qnsPpfeM2yo
	x/sauWw9DywpOFXvhvKc3I5rs1WhGaiesQfnbtZxtquROto9NQwdlW7afp3y5QkquOQo2H0+yIz
	W64KgqRAxgFSOgJc9ob+Z9y5ITluFFAVPj9vsJcx3B0QqjeAvKDgrjKejTtgurxyoieNd7MYpnm
	QIfCz/XBre38Gced0/DlN5+xQepbUm9XM7TW/JBW7TPfEo4aLhwIBO8eAiRlQPOhWYjEYd76l3X
	oyMLNLw763LNbpq3UHDiCDwtlh6yE+MdnerwHRD5VZ4TrtnIqYCbbSJZrOtq8aQAQVOWibWIaXn
	OV6PjZQkWeb0hXgEWifP+xSLWWqatfRDgSEG2svtmxoAL+zctmcnTSybokAhrqL42GskXa2EpEu
	gsCs4E=
X-Received: by 2002:a05:693c:66d1:20b0:35c:9ef1:a1 with SMTP id 5a478bee46e88-35c9ef107bcmr5898849eec.5.1791979095733;
        Wed, 14 Oct 2026 04:58:15 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35977229a6esm37796346eec.8.2026.10.14.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:58:13 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	zhilinz@nebusec.ai,
	martin.lau@kernel.org,
	kafai.wan@linux.dev,
	yhs@fb.com,
	ast@kernel.org,
	vega@nebusec.ai
Subject: [PATCH net 1/1] bpf: reject unsafe pointers in TCP congestion control access
Date: Wed, 14 Oct 2026 19:57:57 +0800
Message-ID: <ae0f5aedfff54432f75c7bd4d369166c028497b0.1791978740.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791978740.git.zhilinz@nebusec.ai>
References: <cover.1791978740.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_tcp_ca_btf_struct_access() authorizes writes based on the BTF type
and member offset, but does not check pointer modifiers. A BPF program
can use bpf_rdonly_cast() to create an untrusted tcp_sock pointer and
write through an allowlisted member, bypassing the read-only cast.

Reject pointers with unsafe modifiers before checking the type and
member offset. Trusted struct_ops context pointers retain the existing
write access to the permitted TCP fields.

Fixes: a35b9af4ec2c ("bpf: Add a kfunc for generic type cast")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv4/bpf_tcp_ca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..252cbfe11e69 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -65,6 +65,11 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 	const struct btf_type *t;
 	size_t end;
 
+	if (bpf_type_has_unsafe_modifiers(reg->type)) {
+		bpf_log(log, "write through an unsafe tcp_sock pointer\n");
+		return -EACCES;
+	}
+
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t != tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
-- 
2.55.0

