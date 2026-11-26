Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722240;
	b=QiMYE2rvNYFOgZBbzjb2ANVCSM40OROpD/j1Fp2Ql0s+PwnrLhW146Fkl3kHhQbnqsfC
	 qlR62QyJeRLXsz6sXWsrixv7zQkTsQWsrcWMngng0S2m5MBm5cJiluZJCgCjpGIp5VGM9
	 gbXJrCHPd8lC3Iq3RP9DMETB2k9pPFaqZwjqUV3z01MGuPrzQbaaqrLITP8+SfuE/3spj
	 qLorgzgeDzfuOI9SfYfr1u4KBh3RI3snnitOfo/1W40mKYuC511uOz4Ry1G1InvfZlyjR
	 oYjVvSkQ+0ReaFdn9rybaWBv+wChyWHsMaudyQkjbLA6MjHw8evzLn+Uvwz8N8Rcsng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cTlGczEpqnTOct8RsrZ/gODErZ8owqpFldUbfmAHspI=;
	b=N/MA8xqgm1Z3LMZt2waAHH9QW9HhE2/BMnFFzpDp9qkIR/VtMu2YZQVSbtPtspR/aik1
	 MGe9ll3EfvgDctvu53BTWnWmRj/fGJlTV9gruorWLOc1rn832PhWCCXvglist6k2H6q7h
	 n7qN93R3nakiU0f157rBOGOsniSjZWI/F+v+TSH8sbskZnyDsVCuIalRZHN+PTFmxx+5i
	 pxaSHM++RnZ1u0VTxPSKJhP3xyXqCxHQ6h06xg0VArZrPG5Dv+qcG6TBn+bhnnXeauRZ/
	 bGpWSFyyQtHUvR0P2I3zxAFuXvCVwx4jpsem8LnXN95Vhb7jR2LsZze/FQA8U3x2Wow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D/RCqXQS";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E62606A334
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 19:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E62606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D/RCqXQS
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso4653527f8f.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795722238; x=1796327038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTlGczEpqnTOct8RsrZ/gODErZ8owqpFldUbfmAHspI=;
        b=D/RCqXQS4UeN6v20Z+VlBVJK/ZZX/cCGhIw/ilwIJBaJwk1qthCZOB7Hg/2I7i+4b3
         gXFQ4bI37t5xPPDFsxIZCp3undzL8liJl1dhk9x26M+SkiFQiV+7Vrud1K9saTD8x0sH
         UQMiTIPG1dCkfQb0PxR6z9D5p8o7O1YzP64p0tMKDD4z4PSjcjwQijNF5MccAC+MyA1q
         gLfW5lTkUooix1E3K7bTU9lw8/aq1xp6zPR8L2TbturBUIa7a3UOJhiI/2hrCU8Srmvz
         xoxkVJVoMSNteiXv1w98CN7QNYMr+TYloJe8vE9eCeJR5FzLV7xl1p9CdamhuhxKADyZ
         bRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795722238; x=1796327038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTlGczEpqnTOct8RsrZ/gODErZ8owqpFldUbfmAHspI=;
        b=0XvF4Hfzss2/mqhOAlvAlC0HHJeMW5j8ZPfAqrCDo7hNhYcavc6eSL7hMCnmqCYyZ4
         Q69kMmy7TzfZf61tsj2H7F5AcFs/rVoUYL2jyN7DkJBSD5MIQz3ZNLYjfHfoba3xgBt1
         nDnLwOVVbVHLOZD1EQnAEdSKalVmhRIjaPol0WgXV4c5rBOW/6m0n2vwQz/Ktgsdr8Wc
         YG7dqJ9DYID2Retwr+IzApY3enycVspqWl3vKa0rAKkHHg64Uk8KbMRl9ix4trpNRqYD
         hAotgrTDHuQ+GOmKIshYmUcClIuR8Bilx7XA9ZHrneZtWaoGxPiYKKKXewHMMvgVzjLb
         zRHw==
X-Gm-Message-State: APuU4Z9MImXrf6KD6QXIZOT7KX70AGYgOWTGcroRDb5wo8GmZwRGSjeq
	TuSc7gCPdaTL+HULz6dhTrfOQ6BEZmp2RimMJxCZtbargTlfxC8s40bM1Dvk0kQ=
X-Gm-Gg: AZFdTZf2QCYvVZogET7cBcbKcsM31DlduO+In20bQDkbAcbKknXpEsPBbzn6eCHH0MC
	oVQsYoVMivrRMNYxvn761pA1DxUIqpqHy6o1/SRIS1MYdDiC5BqBcRDPGoL4Ze/gEti6ljx4st4
	dSCgmAccXpZLSYDCgxKvJ+528EE2ksvU3fkNaIalKfMIMZUBGqvnu/5VEoCyHxDgEAEtzKNH1wM
	+aHKIcPnejcyzG0KWwKtYqW86QfhbOhvNIuI95oAOcYz19RvGoChvnnNFA41D3l0L7fJQf9sXcu
	XzzOGBgOftUjfw30L9t7UkGsWl0vhyjHDtlM4bg27y+XIsSYE0XQzE08AK8OdQ78CRCH6SuhEVb
	FFEBfVhUjmvnhSZ1ls1nNrLQpyHeRF87KLNO3hQpgPuac08objfQXYgj5z15kSOQYWcHREdy4SW
	bBQI4O0QLZF9IRnbIrPxfXC+se3l1239sGz4IKX9UaxPt8uH8KxJjsnsu1jYm0aECI2iPIwZQ/C
	XepKc4lS7UaIGy+4vmm00tNQNNgP9k6Yz30wDOs5ADNMJWG1aEjQQLrXDDEgzCcVWvaFMSwing1
	ECyNUgSbZPInrNZ7kX05Wyf3nT4APNhI0gIDPbEjm5/Fk63U1tgGVsHlfHH8goqbSLWQrH+f72z
	S4CrZZQ4o4/skqKXzOarEp161pTEfBNbDWksbOusUbojMYEZqBZh3fIDMMFCmHuS1tOL3Iaw7ds
	TTHDH+OVY3eZMrmzj0pA9fAUUojs2/cije
X-Received: by 2002:a05:6000:25c2:b0:4a6:7781:b064 with SMTP id ffacd0b85a97d-4abb51457e8mr54433934f8f.31.1795722237966;
        Thu, 26 Nov 2026 11:43:57 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-2317-a900-4811-d431-309f-6626.310.pool.telefonica.de. [2a02:3100:2317:a900:4811:d431:309f:6626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm43663924f8f.3.2026.11.26.11.43.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 11:43:57 -0800 (PST)
From: Tobias Philipp <tphilipp@gmail.com>
To: bpf@vger.kernel.org
Cc: Tobias Philipp <tphilipp@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	=?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks@slashdirt.org>,
	Stijn Tintel <stijn@linux-ipv6.be>,
	Daniel Mack <daniel@zonque.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/4] bpf: Align devmap values to 8 bytes
Date: Thu, 26 Nov 2026 20:43:46 +0100
Message-ID: <20261126194347.42466-4-tphilipp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126194347.42466-1-tphilipp@gmail.com>
References: <20261126194347.42466-1-tphilipp@gmail.com>
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

dev_map_lookup_elem() and dev_map_hash_lookup_elem() return &obj->val
as the map value. In struct bpf_dtab_netdev, val follows
"unsigned int idx" and is at offset 52 on 64-bit and 28 on 32-bit
architectures, so it is only 4-byte aligned.

devmap is read-only for BPF programs, but the verifier assumes that map
values are 8-byte aligned and accepts a 64-bit load-acquire at offset 0
of a struct bpf_devmap_val value on 64-bit architectures. The arm64 JIT
emits LDAR for it, which raises an alignment fault on CPUs without
FEAT_LSE2. The fault is not fixed up.

Mark val as __aligned(8). On 64-bit it moves to offset 56 and the size
of struct bpf_dtab_netdev stays 64 bytes. On 32-bit the verifier
rejects 64-bit load-acquire, so the misaligned value is harmless there.
Aligning it anyway keeps all map values 8-byte aligned and grows the
struct from 36 to 40 bytes. Entries are allocated with kmalloc, which
provides at least 8-byte alignment.

This patch was written with the help of an AI coding assistant
(Claude Opus 5.5).

Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
Signed-off-by: Tobias Philipp <tphilipp@gmail.com>
---
 kernel/bpf/devmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 1b8f0d7f8..c92aa81e4 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -70,7 +70,8 @@ struct bpf_dtab_netdev {
 	struct bpf_prog *xdp_prog;
 	struct rcu_head rcu;
 	unsigned int idx;
-	struct bpf_devmap_val val;
+	/* The verifier assumes that map values are 8-byte aligned */
+	struct bpf_devmap_val val __aligned(8);
 };
 
 struct bpf_dtab {
-- 
2.54.0 (Apple Git-157)

