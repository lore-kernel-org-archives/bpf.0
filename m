Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EB3CAE76
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858429; cv=none; b=fJ9rlYYNdvNjeLVnpQfBMYuzQXj06x1xjiSL8Dc7fqQG5zEC9B7Wdorm+SADr8UUBT5YaPv8M+i//pXp6z4AmWRRltO9jXujltMxOxVuA5Lzw2hjw7vceV34nYSnWuIRTaL/kSEElmoBnRXneCMuFPY7MnP/4jApiWkb/QVl9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858429; c=relaxed/simple;
	bh=mQgAGJ4m2Qmar19EXsMe8wXPf8JlFhMhxq8pUVUbHP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/dr8dQQ+c4xdBPbo/s1IRqIXytE9u6XLseB6C2uwjsmhqIeJblpGW42qzYWq5/RF5do7mSRL+66R2bFNrRPgsBYS0/WJrOtKLObGDGR25bLfU4mHqjngCl2vsUWnugGP+a7+52dXUTWqw40iXtm3GDOIE5/Mdio4cF4QLkKI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCs7VktW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCs7VktW"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba6485d219so61980625ad.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858426; x=1779463226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuO01rnDl59LMjBMiEYthQHIfPuEwYqZTirIS3MXQR4=;
        b=pCs7VktWrYNy2s8a1Dbxny6CqJSGG7oCQ2jmKpijW4J3UKg+H3uLUcRl/xvnzsck+g
         XH4eUHQwM4KRKOiGcb91BSW8xV6NqLhaoH9SG1ofyscUw5tpnXlOZPEVgDTliVDoULp8
         YPvdHBZ/Ys2D7Qrk88H5zj5r8da10dHm2e111AHHZmYeRG15EtSJSx52Dx8pKnY9IlJ0
         HmUciMPeXFTrkbKh6JLgJpTENmeniqyrCzDKIihtYjmCFLRKG4LIH9HmI8zGVqVOzDiP
         /XvAFKe+92ogf15qtfLtdHoZ5eBpFFRmRFuZOef0Gmmycb6BznamI7Ja7hZzI0AgwsPB
         8SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858426; x=1779463226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuO01rnDl59LMjBMiEYthQHIfPuEwYqZTirIS3MXQR4=;
        b=BfslbEWvIYC7GVmYLf2DCOVzT+oJ5/U0jbkzvu/qh3BQYJfL+NvXR6amlZlB4vvP0p
         lc61UoNEYqXKHX9RoamHWRnuFxcc9mVbyPdltS1UA0o9MdVGDNHU/OGMWprJfNs2r3pw
         mWQJvj7pv1S/t+Xb9R6u3Uk+Nynp0rK3u5V4emjYmVjcyBBrAXQZJ9hqxasg9mzqEtTJ
         yz/DDMFiZqJS8RcxJsAWIU5dAP+b4Tg0KNoJZgOiieu910PzOOYk3SjS3tZKWorFTEY0
         7La66ceSgPRCAn8QPmhqTZPC7lowYRwvm4iuGjfezCSpXENUshTrc2orZ4hA8ePsBN/m
         ccnA==
X-Gm-Message-State: AOJu0YxeRUt1g5Ugy1J+9k8Fcp7jM2IfguCdhZwEYkpf8dQl9wXB+URk
	yLmTOXpH1bCYg+Oc64Kh+vH2NkLs+TAfvVokdic+DeXm+/MvNfllhzYs
X-Gm-Gg: Acq92OHVsLT/mU/cvyFJ/njFHRSU1WBTbc0SMH5b4RCFCYpmd7JscPXZSVuhrPTiVHV
	IseGmTdZfTHTMjmldmvmca7AFRh/A5nJ5QvfCtx8tzv/B2u6tvlClT4/OUrwVdSZry4uzydnuaE
	d2vm37wewargCgHunKx5HpE+W3xqkdoUtn0z8fkTExCJ84GdD3tI2hUXZ4ux4CwVHXQMc+j2yZp
	qyo/aawKSb/k0fWcZMr+ARMO+AQcvr9vaToY45EyjZq3jP/xblWLHCTdxw4PMGDDAAUfA8ulxuu
	sH12Bg02qzxjx/0WxQTaGHQ+Z2ornZfZIJZneNCIdppdScaFG25zUDZUUatfxje0nf7vXn8AG+9
	A9gsUMWNk9qm1B/L71l0OFk+dKGQ0vlLfqJh/YmibxzBJoRxLMANew6ZaG3etV1QwIyaeMZeAmF
	wijoH+0leJRYvtEwnvKk22ILWVKnsp6iWoueUD
X-Received: by 2002:a17:903:388d:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2bd7e9769e2mr50886965ad.30.1778858425344;
        Fri, 15 May 2026 08:20:25 -0700 (PDT)
Received: from ThinkPad-T490.. ([49.207.206.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6487sm63803245ad.54.2026.05.15.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:20:24 -0700 (PDT)
From: Faisal Bukhari <faisalbukhari523@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: fix tunnel option size in ip6geneve_set_tunnel()
Date: Fri, 15 May 2026 20:48:30 +0530
Message-ID: <20260515151830.711129-1-faisalbukhari523@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the correct size to bpf_skb_set_tunnel_opt() in
ip6geneve_set_tunnel().

sizeof(gopt) returns the size of the pointer instead of the
actual Geneve option structure, resulting in an incorrect
option length being passed to the helper. Use
sizeof(local_gopt) to provide the proper structure size.

Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 30f1de458669d..ca04d1d1ade4e 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -674,7 +674,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 	gopt->length = 2; /* 4-byte multiple */
 	*(int *) &gopt->opt_data = bpf_htonl(0xfeedbeef);
 
-	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));
+	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(local_gopt));
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
-- 
2.43.0

