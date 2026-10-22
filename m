Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668229;
	b=EVjmKxy9LthJyg5d69SAMN5nJ6fF5heX2b9ElcV4DqZuQvndfMSkzBjT/ppkvlG1CoZl
	 C2GtBTIslZuFxmPH5Nt5BkxwKja+/jS9Em1pFamyRAvLVxuqe9nRLQCeH1YSOtNKW+A54
	 3WiLBByf/43d/7WeAT+lRUBmEIUMCRbFAXrdKN3gsZtfH24blCJQ6OB3VqQHpRp1SnKHG
	 gTgvI/FH31nWxMFu7Lybqzn4Yd4ZUELTDTqFHXFJE12YbykPLurD0vVzbtjnt3fkHpUeS
	 O/yMSNYvMD/QQCpfCskGLpIk8E7mEDNsc41alePcNHObbkdLoBG7xKUvyeJbNoJ+yfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xPX5Pyvu3KPuA/BeOQ2DAl4emTBwilJ3yODW3aKnjPs=;
	b=TYvU0CcMfQxPfCd/OXb+SE09E6QBpJGOIozPh2LAncJS+DXmP1qJU/ZbMiLmzeSprsXk
	 PjRpjBVqpi9Lz1bZSyZINOas/A+4fJNaUgBabvcBLqphO85sU+6yELQqJ0s4+KkEkR6L3
	 z31ZnycfaqLOf7XX2FNlmQr3MZ8rrZnDVUfbMlfaRYTkTUuJwdMXWrhHISXWmudlLBPja
	 xxkZng6niICJMthYvk4BdtQ+rv0ilyA+1lx4eE1IeUCDeACemUimjxXZvTEhQLewmHrJZ
	 Any1VEL3GSuZysfzYOI8ulIKxb1xvE6PuUdakzDAKLeKQb7WsMHeZCi/cCW/jQ4wWww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qnMao6zB;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D62606A31D
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 11:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D62606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qnMao6zB
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15dd124bbe7so3239726c88.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 04:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792668228; x=1793273028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xPX5Pyvu3KPuA/BeOQ2DAl4emTBwilJ3yODW3aKnjPs=;
        b=qnMao6zBmkB8laPqkwE731uNdh2Rfbbc/wwRETP88zq+ppjznHTWEr74A9TFIiCXKs
         8QTyqZmT91XGxm47SdmAOIzeCMOFOlxkkg0GbWzlUDocTOnSqkK1gzuTirc/ts5/jfBg
         jrjSM5OdRHUF0wwJnas3KFENmnU0Dvz2EtprKgPTymzylLeVcq5wIKvVeUGRrdtYpRoY
         TdiyFajkatu7UxuFuOxvT3PVmTH+ErB4kS7LsXyIwale85eQm+5E8u1r3RbpYo++PQoR
         bguTebPwKYv7/iWhGZ8xFpD0xTGIgDf5do/g/wMJapjt+qG/8M4L5A0HTIP7ql+3dpw0
         qePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792668228; x=1793273028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xPX5Pyvu3KPuA/BeOQ2DAl4emTBwilJ3yODW3aKnjPs=;
        b=Yzr0fWMs3fiugfJ1k7m1RR8WwvI/iEG8jdUIAaDAvX7MxwkTN+u4rGcO17Tpr96kXk
         cWi9KoStZjHi6Y+Jir9BgJ3PjK9g5Floo3hPoB0itspkmDAGkL5kvjfq/0fVShvJczj4
         ONiQUJUgTRs/rPm4vno/EW86qyB/ooZM5D+ZOXhxLrRV8TpoJ3RYIo1VfIesZ/qciTce
         a7AA86PcXvxM1QUA8tt84HdCahSB+viQPNvKMW4oIAntZZ0OgMmdByJWMrUICm6qd1Jf
         R5XDKOEB2HDBICrO9kelYDAlsKNsn8h/rj2u8jBQ6CgNo4VlkkTJKp16vWS1J2jZDpNL
         /7jQ==
X-Gm-Message-State: AFq9FYIr5uwZYWnAwZh0RrFi/jwr0Aq+7zakm8o9Xj2vlXZiDbHp6XR3
	ULaR7knloCDthQ40gyMrq4jsZQr0KC31dfsf90qI+6AmzJ3Nmp9Jksd4wxBQ/cUJ
X-Gm-Gg: AYBFou0AvCib8FIx8bObor6/83oX8RFOknAfuzqz8HG61hVVmr1rDZXyWwZQO41CGv/
	5N06vGAgPLSeVZw9j0cVzg+exSI/eJBooZXs6pMvf7G452TViXfaAaCYMNzzCwd5PK4ZQrMKmZ6
	0BDOk3Kzl9ohPPgDvfW8OFjN8fZiWuJCGhr00rlfXs1ogjVP3hjqkGxpsUqVAUKlE2fkr7JUhDP
	cWTbsl+fxv7HG0HNbRNbpHEKjIy2sV2psi2YEiz27DVssQ3cpU6xBdvsUzNXSQAxuPzgCjdfVwd
	8gXFYu9oYy5Yf4YHZy8kPZN10Yoauv2Zom+EBw5wQyZKrb7I/K5zYJDNKisIZRyBdGtLR54VoEV
	+46532YwlwuIEiUBcySN5SUM3cknR6hszg+9qS9iCQBrGL8rewaPBpZ2ISn5+1iRGdeVm406w/A
	l1INGzCdo9V573L9rmZ4v3E7kKSAFkvKYFTV/rC9xGmnFq0CvJUuU+fqp+7+FKbLSabWFiink29
	KeelbGnSrfVAOWhbBtCeBqKvXX9oCdFtvWrzmxWdcnrQZrlRhZa5oUK6aWv+2NUIAD8UynQ4Qe/
	wKCtVArDbStwGaA2ZeZUkRrDhDLTnhhklK1MlVHt08WKMOH3PD7J0QQjX9MfgWM/yisptYY9SIs
	=
X-Received: by 2002:a05:7022:1187:b0:194:3a84:e67d with SMTP id a92af1059eb24-1943a84ea04mr1111760c88.44.1792668228302;
        Thu, 22 Oct 2026 04:23:48 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:d12e:70e6:689a:f754])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm21529104c88.5.2026.10.22.04.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:23:47 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Rosenberg <drosen@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Use memmove() to load bytes from an skb and an xdp_buff
Date: Thu, 22 Oct 2026 16:53:11 +0530
Message-ID: <20261022112312.31563-1-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
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

bpf_dynptr_read() on an skb or xdp dynptr ends in bpf_skb_load_bytes()
or bpf_xdp_load_bytes(). The destination can be a slice of the same
packet, so it can overlap the source, which memcpy() does not allow.
On x86 with FSRM memcpy() copies forward, so a destination above the
source gets the first bytes repeated:

  p = bpf_dynptr_slice_rdwr(&ptr, 8, NULL, 64);
  bpf_dynptr_read(p, 64, &ptr, 0, 0);

leaves bytes 8-71 of the packet as bytes 0-7 repeated, not bytes 0-63.
Reproduced with BPF_PROG_TEST_RUN on both an xdp and a tc program.

Use memmove(), as the store side does since commit 1db084f42884
("bpf: Use memmove() to store bytes in an skb") and commit ab08863c58b1
("bpf: Use memmove() to store bytes in an xdp_buff"). A read that spans
xdp frags still goes through bpf_xdp_copy_buf() and is not changed
here.

bpf_skb_load_bytes_relative() has the same pattern and is reachable
from tc and sk_filter programs, so use memmove() there as well.
Reproduced with BPF_PROG_TEST_RUN on a tc program: loading into a
slice at offset 8 gave wrong bytes before the change and correct
bytes after.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
Assisted-by: LLM
---
v1: https://lore.kernel.org/bpf/20261021103957.17532-1-ayushmanrout27@gmail.com/
v1 -> v2: also use memmove() in bpf_skb_load_bytes_relative() (review by bot and Alexei)

 net/core/filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b7ac145b68b1..09c60a58c82a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1789,7 +1789,7 @@ BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
 	if (unlikely(!ptr))
 		goto err_clear;
 	if (ptr != to)
-		memcpy(to, ptr, len);
+		memmove(to, ptr, len);
 
 	return 0;
 err_clear:
@@ -1871,7 +1871,7 @@ BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
 	ptr = start + offset;
 
 	if (likely(ptr + len <= end)) {
-		memcpy(to, ptr, len);
+		memmove(to, ptr, len);
 		return 0;
 	}
 
@@ -4298,7 +4298,7 @@ BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
 	if (!ptr)
 		bpf_xdp_copy_buf(xdp, offset, buf, len, false);
 	else
-		memcpy(buf, ptr, len);
+		memmove(buf, ptr, len);
 
 	return 0;
 }
-- 
2.54.0

