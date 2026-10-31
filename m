Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793489749;
	b=NsRB8pugWCQ7+Xm5OqEdPwRQpRRegK1TkaEGW4Bn0f1PIpmom9F0UiTw5jZ5wgRtEihh
	 VZm4oMK53GC1OAwLnM1jIpS2pWQ77habMsI9C6bQk5Ys844NJIVTd+cmJgmdxAM74mXQg
	 91qNIgOf8GjEPB+gYuKvhR/d39mfhBnpEhWAF3rfqQ2hInO5IgYHk9vFROJDqi2kJQBb4
	 N9pSN+lqoLZd8BXQlAPjv60KKQPU+bVXi/O8dl/PUEexwXCNqu3aDGbnrI2KeuuKuLPYr
	 ad8/j8k5Xq4kKJ3+TW11633f8m07LnGonBXTSmNR/4iOtL9PzB/yMdWs5vEhXue+cqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793489749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U+VmHF669EdNYCUg2DjEuSwyfbsxpcZUE4PFfBDrE1s=;
	b=yn1xussky3bj188gDb4jQ5ioptuB3qTyt0JbzBvsph2/ZNRL8DiYeKojQ56jyyu4gybY
	 pewRLhhpYnakt3M4dkparFTEElGwWpExxK3UO1u/LKKwo2KE1+kMn+F4sfKQ/k+AmFOIZ
	 C8QUs8K/9jCv9gpEZJC83t7E1Z/l9CG2rUZ+lPgaNRG21BPXnfhNPxKui12puK66WSwS/
	 7EFJV4zn8B59wWuI+L4d8Sf+h8VJOlHuE7aXzuQiwQPPNXv3LGQcnPwvQFUf9pzJgpWVb
	 ZB2C0RqCEj+E8KOZeZgsCcLit3f1DDD58OpPIqEg6/7ZmqNW0OPeN5MOO+WQ2c6gTYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wljbtXVX;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4A606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 23:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8A4A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wljbtXVX
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso1787005eec.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 16:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793489748; x=1794094548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+VmHF669EdNYCUg2DjEuSwyfbsxpcZUE4PFfBDrE1s=;
        b=wljbtXVXbZMCFcNOZBZasEhsvzLDT3TwXsVRWC5kfe5sNagcFMJ8Y9IGhLWE4ks8Cg
         kX79i7up0dWl/SunWNFFsl6pgIXNUdRMYcBLCPDCLP4KnYhcqFz8QdOdkL1WZLaUHkw/
         5hWnJ7DDic1RrRg1Nnccdv/Wk1gOX/gkW6TKtbMlJSalput4y2wfZs3jKbxxFtOj7lmQ
         ZP5fsQ3DuiLlx9bwZyrcsER+p4pldy/RNudVNAjfnpUb/oIfZVaX7zMIVAxbEI39Q5pW
         Vk360dvtF3i4qoLBuv90xnAOwH8C6oHtXBgUqeQPPRou63IO8WdCtKezvpRU5G79cdDA
         blcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793489748; x=1794094548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+VmHF669EdNYCUg2DjEuSwyfbsxpcZUE4PFfBDrE1s=;
        b=tJpiTokUUjmCqJ6Rh44seNF1gVHkEsymmneEYDXOyxPz8Hwtdt0rLUg5rE5f68QMyw
         nYFY0X74GOsfdtUrwjV/BgUbpC435krEWY4FLuFIU1cMND2hgIz0fzjgfcFX23Lm7IWD
         TnxheoDGTklI3arqxCHWYRweAPoo1L4xUP0UUxzb7qqL5/l4Zh9/0sj2wWewyS4w+ldA
         WijT3sR0SoSE+P6G2Kd83W1WiQHhz7/QgpuEUSQTA1HXJzhT+4pIq4wbSNJiGIH6QGbV
         X+xdh11Pq8qehO73/vbR1aXdpHCCGkP/64Q4yBAx4AGHN9ocM29iUcjqTNeYt5ZQe8sl
         usyQ==
X-Forwarded-Encrypted: i=1; AKwUvByAi/1KEPlQcHg9Ukl6H17dGYkgSq853AJOQ5GN25f+SlMJelD38+ULTU11boAVwzIIOOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNOuEn3/5GO0EZ+AypqoFtRo12GpwkHpw7pcmsjeRJ3XNGMzzs
	nH8/j2Eze3D8m84XLi5FqLbds/ZMCZjUKjba1YuSqgUirmjE3A48jljm
X-Gm-Gg: AYBFou3l9x+/GdKFeEJ4hUw2Qr7fbuLpXB5AO1J0olzqfcExjspyjo5L8T1z4BoJ+3f
	mwGvtNEoM/HAoQwLPD1Pb7RClcoYyQKKz9me8mh96jegvp2QB7kbrVsjzIJuspgogmshKYQEEUk
	/vIBH5Mrpx15CRsJiC2y5E3sxK43i3ce/k6VceMFj6XP3pUIXxe9ElsfmNmXwPmxVptQinN4Pjd
	jDx6LbIZ/1TcrKAMo6CTVCa61uGQMDoG5+rqOCYmiJyfTJa4KRuAbP82lV5CB1yi393ot/twu2y
	UyypeBAuBnsW8s+FtxIReZ7bLBf9grrWyaJhwUM9CTLzlYhKXYrZQSXfltQpxd7md7lYKzm4T2k
	94yLZy1tSVNU2/LRYIPcdSmizCoworT2eSuHmlrAy2uq7N3KcUWGhIwFK4Ntc+HWV1We5lBg9UI
	ZtnxIRb6IFgke+j/KLcc8IWxzGuuzZgP3PFvQ8skpDFnnkHcA3qsJ4UfgI9QyPmckFAQAidL0UM
	wWRGjLfx6VqbMRX2SkpfFNClfKrIGfQM23klBbPViJty4/Dk8HtQCl694HdCjvqCxzdOtwcZ0Fl
	/42YnnUHCGUn6C8QmIJXzb67lNomp48QDLXxzJkdfkcyA+jU4Frc+t5G
X-Received: by 2002:a05:693c:8959:10b0:362:fa87:2aa6 with SMTP id 5a478bee46e88-36a4207261amr8801261eec.0.1793489747503;
        Sat, 31 Oct 2026 16:35:47 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm24073199eec.15.2026.10.31.16.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 16:35:46 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: andrii@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next] libbpf: Match unsigned enum values when dumping data
Date: Sat, 31 Oct 2026 23:32:19 +0000
Message-ID: <20261031233219.9362-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

btf_dump_get_enum_value() zero-extends unsigned 32-bit enum data, but
btf_dump_enum_data() compares it with the signed enumerator field.
Known values with bit 31 set therefore fail to match and are printed
numerically. For example, HIGH = 0x80000000U is dumped as
"(enum flags)2147483648" instead of "(enum flags)HIGH".

Extend the enumerator according to the enum's signedness before
comparing it with the data value. Keep the signed arm at 64 bits so
negative enumerators are not converted to unsigned by the conditional
operator.

Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ea9a34db4c00..7608179aa0f0 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2373,7 +2373,7 @@ static int btf_dump_enum_data(struct btf_dump *d,
 		const struct btf_enum *e;
 
 		for (i = 0, e = btf_enum(t); i < btf_vlen(t); i++, e++) {
-			if (value != e->val)
+			if (value != (is_signed ? (__s64)e->val : (__u32)e->val))
 				continue;
 			btf_dump_type_values(d, "%s", btf_name_of(d, e->name_off));
 			return 0;

base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
-- 
2.43.0

