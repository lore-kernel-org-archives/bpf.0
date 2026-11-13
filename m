Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605057;
	b=p59ES3hKGYq5RhLdAj5VEF53lDZ1mN/QtnnC7SwUQ/fpCa5C/Y/zQQ+scCdtEul4hBVH
	 zw+kqkECY+sI6LTm2hig3ia/fqzfoohSAvVjnjSZxxNRfPjmZ1PPS2KfuhdbcOEgDh4Uu
	 scO3Sqea7dpc9BoWzj5KYwCq9VQtgUYhkr9z8k5keN/VnKFf/3ik7ST10GN0rnBUboxgi
	 +ijldx58wLGC1nGQq3MWrzSJlDSrQhqYzLB+m+rCTQQDCa3el0JIKpEN22OpTxiMs+fLn
	 8ZewHX99FraMBngoTTkf72NCXCCrCN4RYUGeAqKof8W5tJbg9VQBfDG3OGImY+UXZ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=FhWFPAhlx3PkfOPSMdfzvg8lxyB1LM9Yi9ZslgJUh9M=;
	b=uSGqV1xoKgGwl8zrt84JfyOh2EQmcmnYWX/inTQJVkDECkVLvy1sof9Vr9nD9bdntzVq
	 zWclkWivn7ciTXx10DQgox+k85a+K6SCd6sA6a7RZLV00NfSCNPW9A1XJd2De9rf/wSm6
	 OJVfk1HFyFjb5vlw4H2ujSu0u8j/r11+sEtIWELv+ZsMQ4z0LJPJl3xN1W1PaKOqAA6Fa
	 mI7iWSC7bJJVosAtGw3LCYlcq5pi2ZDUw2iQBJQ2OT3LckaU9XQpNfpsjkcRaY1nDLLgU
	 1zWcXQWXCLZwY/U6joyS9PGsuNicIA3cDe1RWdTOMrVUP6+SJOJsbWWd/QWlaSY4VEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJy5rvJa;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78B606A88A
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC78B606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJy5rvJa
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0d63f60bcso17807947b3.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 13:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605053; x=1795209853; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FhWFPAhlx3PkfOPSMdfzvg8lxyB1LM9Yi9ZslgJUh9M=;
        b=BJy5rvJafPobbIoLVUPKhs/edjpptbPAdPiHxbFipHFNLc6IWl5aVRky/uZQ5Qv7K1
         Yp3cN+17qsLDQQJ2pmqG+twcpw80Od1KARNILW8J/fvaIEnKwYAUSEsD3RMv3bSg73D1
         Tg/cxg3hQ2ZmfbzOMqqcKDHbBAIdBWnrlPuzatSmQEYfbZ3wAChPQYdE4puz9NFhpAvB
         OaSnUxFVw3Nfz8WiIbvTP4uclKOsiYneTmwX4LboB2sd3ZYI2ulaknNAlmMGa6GZQoEH
         d/S6Zxx4I55awJ/ilUwqjdkKoODHB6hHgw14Vz/orE4ynHp2iQEShG1WoT7baWTzpEGh
         NnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605053; x=1795209853;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FhWFPAhlx3PkfOPSMdfzvg8lxyB1LM9Yi9ZslgJUh9M=;
        b=JoGDYMDPOlOcJaH71rUCN8ZQZTX0C2XohUFktGz178sGLAd6wwU8vr+8t/CE69f/7L
         zVidjrurcqXbX4tMiPS9ts6LzSMvYhILZWkZydfwgCyJE/oqmtpdm7/lSfQd5NXElqFE
         fLtPBQQzLfgyONZeFcyVDYpBdZshFS/HfY4zqsrY+vSS8B36mx4+hobdko0U0nQFY8JK
         ZZ1K1fXj/IwoEGlTs/gezmK9Px8adK1SawByjdYvFtgyoxXGFyHibfgez7wjeQ3lJvdi
         FMpC0+CRT2fIKD5/tASDn/Xt4iZT4pP0MqawzHwfhYekDiPIxYsVOXGGRjg16jkiY72o
         6XzA==
X-Forwarded-Encrypted: i=1; AL+hErH3146NIS+bq7ZRxF0x6J1EZyBBrGOQTmDs7XDFhCMXQ0T6vgqEodrwkIbF3hMCnG9D6VA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9odTjSImu0gB6pTotx+ZNg2VDI6BhWg5F5qi+rWMMsuRcRB4Dt
	wzvFX0naonxKpsi2flHZ9HlxdDzR/jiM5s7t6b2+oSioB0IutxKF2HJk
X-Gm-Gg: AYBFou2NKtFdxYJT+oc8lfvWXrGva3JQHbOJ5c8jhIO8PQ7gDko49glWU48mC1wdi0T
	/R8TXvVO96yZV9+biVK/UuHyU4eo3SdeanXuAEm5IXRONSQh89pPWMoxVNxAEwAE8iaZ2omA9/Z
	fwjU3kyEA4aPH1JBZamsB24ZxxhM+DBJ1v/PufXtLdtHeA1f0SpetMSP0eOxjucja0R7MzOPoJO
	1gSXr5VXTdJ73q28+YFvuoqpeGiQk7sicmcFl8OyUB01pKHJWCU9i8UqwBiVELK8LofezpxhaB/
	K2JjeUFMrK0rERHQGN9Ik5ywsyJmkljvvr+mZLdoEsR62LlVEey79tZnflt1Q/Je+Q2bLHO/W7w
	V/G2l3MCr1TSpqdZxHfIyVElI1fSDObQnjjO6nWU6B4vEdaedkZB2X3gE72l6v2/3SmQfN03kTy
	wHMtzGDEEa/8yS7WaY+Ppa92xuKBoSQx778nWZAlp+bYqi0Tzz7236kHBTmcC/c4ETS1zM78mBJ
	NLHZkSq6K8nh13JPu+PTQLGbeEZQ4q6JQrNDnyl42OZwmdx8OwGhqYhPBCDfo7WlxN3n3pq2usK
	38p9pJNk0J8WG3wR6Q1A3Xd6OUtjOJWwbw==
X-Received: by 2002:a05:690c:289:b0:8b3:5969:f245 with SMTP id 00721157ae682-8b4aa0cf2a7mr23640207b3.4.1794605053410;
        Fri, 13 Nov 2026 13:24:13 -0800 (PST)
Received: from [127.0.1.1] ([187.15.141.223])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aaa1361fsm29539357b3.43.2026.11.13.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:24:12 -0800 (PST)
From: Nicholas Dudar <main.kalliope@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf, parisc: Add support for BPF_MOVSX in the
 JITs
Date: Fri, 13 Nov 2026 16:24:09 -0500
Message-Id: <20261113-parisc_bpf_jit_movsx_20261112-v1-0-7ecc33cdf1b2@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWM2wqDMBBEf0X2uaHG0ov9FSkhl7WuYJRsKgHx3
 5v08jgzZ84GjIGQ4V5tEHAlptnnIA8V2EH7JwpyOUNTNxcp5UksOhBbZZZejRTVNK+c1G9thGn
 duXX17SqdhOxYAvaUPv4O8kd4TBEe34VfZkQbi76wRjMKE7S3Q6n+9HHSHDHAvr8BZCBbXa0AA
 AA=
X-Change-ID: 20261113-parisc_bpf_jit_movsx_20261112-b9d59d0871d1
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicholas Dudar <main.kalliope@gmail.com>
X-Mailer: b4 0.16.0

Both PA-RISC JITs compile BPF_MOV | BPF_X without looking at the
offset, so a sign-extending move (offset 8, 16 or 32) is emitted as a
plain move. This series adds the sign extension to the 64-bit and the
32-bit JIT, one patch each. It follows the signed DIV/MOD series [1];
the parisc32 gap was pointed out by Sashiko in review of that series
[2].

Tested under QEMU on a 32-bit and a 64-bit kernel, with test_progs
built as a static 32-bit binary with jit_insns only. jit_insns/movsx
fails without and passes with the patch for the respective JIT, and no
other jit_insns subtest changes. jit_insns/helper_calls is left out on
the 64-bit kernel, where it does not complete with or without the
series. Not tested on physical hardware. The commands and output are in
the patches.

Claude Mythos 5.2 assisted with this patch series.

[1] https://lore.kernel.org/bpf/20260915022905.1535566-1-main.kalliope@gmail.com/
[2] https://lore.kernel.org/r/20260717192714.25C241F000E9@smtp.kernel.org

---
Nicholas Dudar (2):
      bpf, parisc: Add support for BPF_MOVSX in the parisc64 JIT
      bpf, parisc: Add support for BPF_MOVSX in the parisc32 JIT

 arch/parisc/net/bpf_jit_comp32.c | 41 +++++++++++++++++++++++++++++++++++++++-
 arch/parisc/net/bpf_jit_comp64.c | 11 +++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
---
base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
change-id: 20261113-parisc_bpf_jit_movsx_20261112-b9d59d0871d1

Best regards,
--  
Nicholas Dudar <main.kalliope@gmail.com>

