Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577606;
	b=NTAnJ060Vz18adadLi3ENqCrHqP+eb36Zx0IKez5Q4EIScA8vAVGUWcYQqPBbQe0PKg+
	 k6Emu3AmG4ML4noHGXlgQrci/vx41XFzOKnj4lBpph9Xa4kyA8XJTLtoM7rg7FeWAFSSm
	 Tvvbr7FNhlciG9nsh5nNYeEBSM3frv7H3qfB+Z8XO30DKoOaeerSIEVGL/N1QBYpXX+fL
	 678G+l5hj3DymQqLo98WzCg8uV9LdhjUeyifzlt9NgegB1Wp+4kiO3V4ztYskdyCVMP/v
	 jFtdeuQB9ojp+SYDrigPbjiqsNpKVp2oQTAy4R4dy9y3M2+/qB99Jtg7j9l0S9Lc0Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BM5sDaJIJ+bs/KbprmXTStxLdbr+JsO7JuypYmmZ90I=;
	b=IpKYx5MlbyFfRi59r/KBUMmPg76OeYzxFRv1DZ9MqZ8hT1B1dhT+XzFYRiv9ic8RPkYv
	 jHi8ZwATG/nqBma3pHVfPGa53/4D4CObqXl9SUzNWk9dm1A6g+/D0oYoCBx7sJJgzQFEJ
	 voCVnDTXvhpeZhuKh7TxpVDV3+uTRnqOsYaYiz87EOus4j3FJgsFVjuosj07ckWTd4jEZ
	 h4b9geRBt8GQ4vScC532+BP6ljLvGTYbhMEYUKg45Y4S9GUyYqFxWzP/WCbH+bQiFYc0e
	 lfY1NOnIGwc7JJui+oDU3sDCQmFODOfaBe3xVJMm99JY5OvzzMCa+ftLBg048q0pGuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iPQveuYG;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7099606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7099606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iPQveuYG
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso2789128a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577605; x=1796182405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BM5sDaJIJ+bs/KbprmXTStxLdbr+JsO7JuypYmmZ90I=;
        b=iPQveuYGo/aPOK8gD6R8Ojinljk9XXLrqcLB8tHVb7RtdjpeVODMhF3gNsCfzf1Msf
         F/4p+6zfgG34TH56f7AQvCsFPG6TAdXSuAKes4s7FC1wAAuVtIGYROyabXPjsiXROUv6
         bwbT+/wdDzYf7+40vo1eJqB/1OOV3Ft9L4sbx8l8/NGQdALp8TQjwTXiEA2tEptLCnFJ
         4x1KDUtJv984GAEK8qGUfWMwtNkJJG2eKUTzzEf76ctpuczGkZ8zHpa3bTlGAFxTbkoQ
         H13EUk/hqyig2NtZXGDjZEa0/Hs8+FH9JJ+syJO9irYOTDdUZtB+dZsMf7bgkM290yev
         RrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577605; x=1796182405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BM5sDaJIJ+bs/KbprmXTStxLdbr+JsO7JuypYmmZ90I=;
        b=STfR+yvnVrlFGgorBgmroAS18pV52L2iVr3uJtjzUJ3+0zuuHC9djmnjXp8ASty3jQ
         ki7QvejhZyCcaQELkKJlDCQim7BWLzIbRjsTdIVzv4FIpFWbT92SnVz4M+Nwjd174CJa
         fel1ytu+nfib5psDJKazxzkv4WNI/VjerpQUX0UQLS5niqXglqxXYQttu00kH5wxcZTA
         0J/HDsTT55F/mqiQ+wEXaJDeFIlMwOBrOjhaKpy+7TbF0ULb+lFjlIENpBKc7My/KArH
         hoTt0EpH6X85c+qU2IUTyr4foXrHf1gSV+iGz4hugHOVnZBM12frdIE8yW/JBqi3FO8C
         fe4g==
X-Gm-Message-State: APuU4Z/s3CvuGxGbQdGL9zsmJ0OFAOCgA6OT/mmtJs1MfDrR3fIUZimQ
	eXv8/lkyeMHrhgmlYAXz6V8OFboYjxSCNDana+cdQ3KfN+DY/4ZyJyIrUtRPa5TH
X-Gm-Gg: AZFdTZcMYcwvNriAuou5zI9BRIckzyNumIbR0m4Kg2mttC+qByUixlLJlyM0pj0gQbW
	CP/UrT4ZKhYjQroXZKJQg5mLyjUQaLDhm+Ccl1Q60dHKVmakfehcjYSTlfHMoQk34l0Lc6ygn4r
	mo74YXkwk/W1HqwyUBOtwy09+fmqws5BN6GWgdSim635hyF1766JOX9HyuiaoW3dZkzE2NiK11f
	+eQSaiReA7Vw/Djp5yboPHedZkOxMx724Io/fXF/sxlfAsNTSA0mANEkGBFYzC+WYxfCT/SzRFG
	s+st2s+Bi0AzMFpRcAujcJiK9J/Uz9TgoozDJ01R74M43ANd76fnT3Y1afklTEVpeLIM8qkkU4r
	OTWVbQ9tmYioNQIAFLQgPvtI509Y8tSgFKq1F7ltpt3WHjOG3U6F+3HndPvz9h61bhr8M5rtANE
	0HJ2PVR51LeuqUX78Ht40jGQk0vAWYY2YoBQ2cEbrxH0znSkQjh5RZV7kmY4OB7fUhQs8k2H7Sh
	zzjMQmKOXTHH4ZQKxkub4SMBmFFwZlYwK3InFm3VxsinQk25zHrUO0bp7Q5JLPAkhSaNiWbGlon
	rLpOJztLUC0efU3dcGgpNlB6mqZ4ipNmEhbD+AcecEMG3leuB5+I1GhGld1IwQdmCMcuyOevmwc
	iwEdyFf54uKdW5UBl+msgqRa5tbefe9j52uLzOGDkPzSzqEyIiPDOiyM3huNYE3DmSmVh2xpl90
	s=
X-Received: by 2002:a17:90b:3c11:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3b41c907eb4mr9431787a91.20.1795577604776;
        Tue, 24 Nov 2026 19:33:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm15096393a91.9.2026.11.24.19.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 38/47] bpf: Clear the data that bpf_msg_push_data() adds
Date: Wed, 25 Nov 2026 03:29:29 +0000
Message-ID: <20261125032938.670542-39-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

The helper puts a new page into the message as the allocator gave it.
Bytes that the program does not write can be read by it, and are sent
to the peer. Allocate zeroed memory.

Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b9dbdd276b02..b4057a6cdd7c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2902,7 +2902,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (unlikely(copy + len < copy))
 		return -EINVAL;
 
-	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
+	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
 			   get_order(copy + len));
 	if (unlikely(!page))
 		return -ENOMEM;
-- 
2.55.0

