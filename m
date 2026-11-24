Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555038;
	b=Yvj6wspMi2WiPskOTvtshzHf5CKREr11IHYMPoAfL9c28e4W3kL/inhWmUQAcLw2CKQJ
	 g0x7UzSTyXne0ngzDQY1bFNf7+AfLhctbpXPijrDfCnogvjxNcgpTI7eD5A3xO31QhTaG
	 +lTqyEAgqBkz44U6ShEvAMflCC/KYD+D3j/IEfRbZhlfostwv/Em18KURZeFfXHpmymYh
	 wn1Hy0JvLT0yiQ/wCBJjQwqptNE6mc51DkZ7QuyhGsTzvOXcjPG8rXli8YBEdziR8G8Gr
	 kg8nFE8ci7r8EWvGXq0iZ4dJvKSNlH3/5mMkTvVWcDIfg18a4vf73QqUXKB1K9nfP4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jOH1sHCSl4JZmkGS3KDfp8Hz65+JfTUi1CKpKg9AkuE=;
	b=5iCtKShHVGeK80MGnZsuExGgmOUW11SuWTQwM+LtoKGbGetGj87eq6L+XLc9s3p65CbL
	 oF8QJlE02mD865AnZqeFoE0qxaa2fxe5BNcTOZ3ksNA0ZWIxpRy9944BhUEa9PiJe4ply
	 XcSK83o6TJgO/m/AbtsLqt69jgWML7+vCxIOdL9H+3NeWdCIqVKEtfffLUwdfl4Z8g4pO
	 Xg42uOrcjun8UHM8Rfj6MGhJn0JFaQyK8Lbym0kTdC/7upxYfAYZXWTNwwNh1ERIWqb6t
	 +f20GaB0mojIinWamTYFmc6fFlQY5Z4HsCiTr6CCla05gqrAxV+Zq25bDnV2VwIA0VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DuhBzzSQ;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0092606A6B9
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0092606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DuhBzzSQ
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490b7266f7bso187048f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795555026; x=1796159826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jOH1sHCSl4JZmkGS3KDfp8Hz65+JfTUi1CKpKg9AkuE=;
        b=DuhBzzSQIOmob5iiMXjAspZZK4dRaT2eyOggvVWtx6Q2OP9Sp9y1lBkgw3uul1qzE8
         72OVbG5PhPpYZvJFMgS+BwcIMli2L1YWDlhKq7lWJSxudTX+FsbdrAkU3tL/a7w8iYF7
         EfSNMKPJewpaHr+dqkGZ4QIUryrR37cEwbpbXVe7V2mo0HmNGPRdYJWUlCglGvpGW0AI
         w13htGx8cAnyPv7+ZYp1LEBujYn3k+wFzQEaR4NkKYsdcpc91DvcN4CBOpl10aWiN/cn
         pCE+bsI2P6xoVECfHM2Gx9sebBeOFe58Qi16fFvFYFZtKKlcbeZDzBJ2fNUa17IiM//k
         +YwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795555026; x=1796159826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jOH1sHCSl4JZmkGS3KDfp8Hz65+JfTUi1CKpKg9AkuE=;
        b=EZ+IMSPxLarwpmcAQwV9WbMCgJAXXfjbznrKlY4LUW+09LkNqoSzEAzTxk0S0hn8nT
         VuLoDJkItt95cxRds9HZ8yfRD2nwLGn6Uj1r1C2t/W96v2eh4vt0xBbCOObU15yNIdVA
         5qdWqq4JF7xbYwGQEO/E4wqLX1vATa9fOxeEvN02J3Hqcosn2eIFbBLWoRc3Gm09qGz7
         uS8peP6FdmImkjvNbpCWRtmeugLQfMKS9tcoMTzAo6OsKjodSpRjw2nXk74EiNFB8UGb
         kea8ODgSklpZj1QQiwd4UHR4Ac4IYmP9fcuPua/GDYZium2JnUDatNLnNNZ+M+h9OWhz
         Oz0g==
X-Forwarded-Encrypted: i=1; AL+hErG7g/X1YILFf2zezDABpPs4mc7FsdLRhWF6OocWa77euUzBrRgaEp1A1voXqYTG/QP5j74=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5gEItsDdBgkhctPeh7AimwFSPMVFSkYtzui+IGEaFDV8OLwV8
	tifIQ888gSey0sNdEMCWpmCybaITfqc1ZCPEG7oAOanjdlcJtVu5b+8z
X-Gm-Gg: AZFdTZcUEP6mA92CiaXNKnJ8u2e2IPrTI+6fTluA6IjXDlLI9pLJSel+lQT3VjfDLgh
	SsN6p0dn44+OIhi9h7PFoNEBsf4dAq180e7cbvuH8Numpw3/kc7nIL4YRyKgxwegLSqJGIgxe8r
	HAPodXDKwiELmXtx8rnyIKIw/yyPLeX6IWRELMUkFbfYY0aywv70wKwcFWsx7/hW5JH6G7zInsH
	6byTChKWS/mFXHTYOzPDbn4qz8g3Hj+7qRpPpGGD1+9ROdi4cK/a6ZXZ/dCjVV43Nfzaa5DBOzp
	kV1a3uOIivoMrInfgcRCaPHmnLk0FDk4ufiAFTT5VACcE72hWT7Apxfw5B4eWZQ9bHJIQ+heTv3
	rq36qlwN+O0dhAsZa10+Xojw7mC7ZlHCi7j1lbGuw1tyZk6HRdvmd05pyoFZ3xhuJw9EH9DmZKv
	8GTfkGTaTsC4VHwIQNHtV41MlZcodbj6sQTL+k+nNhtizM3/4MAFhE4lVHZQQsSbQ/PXRoT30qx
	KbEJUuhRGktXe7aGxIY3STdqmLMyjL9l8reIsOCL2Mg7jBP5WCb6R4g0lbc/s+jaRXMFuDKT+uc
	oN9bQY9MB+YV6tyISiFGVSl+3bSHaoyEVGxgXFKVnsTg+oHOtN3fSL/oFjL/+HzRpEvD
X-Received: by 2002:a05:6000:2505:b0:492:3672:eea5 with SMTP id ffacd0b85a97d-4ababda5370mr33797353f8f.2.1795555026024;
        Tue, 24 Nov 2026 13:17:06 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.4.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm29347713f8f.36.2026.11.24.13.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:17:05 -0800 (PST)
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
Subject: [PATCH net-next v6 0/2] selftests: net: veth: propagate check failures to exit status
Date: Tue, 24 Nov 2026 22:16:43 +0100
Message-ID: <20261124211645.5751-1-emmaonana18@gmail.com>
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

Four checks in tools/testing/selftests/net/veth.sh report failures
without setting ret, allowing the script to exit 0 even when a check
fails. Set ret=1 in chk_channels() and the three "bad setting"
negative tests identified by Tianyi during review of v2.

Patch 1 fixes the invalid TX channel test, which used nproc + 1
to determine an out-of-range value. However, nproc can be lower
than num_possible_cpus() when CPU affinity or cpusets restrict
a process, meaning the kernel may accept the requested queue count.
This could cause false failures on a correctly functioning
kernel once the propagation patch makes failures honest.

Use the kernel-reported max_tx + 1 instead, ensuring the
attempted value always exceeds the device's supported maximum.
Spotted by Sashiko AI review of v2.

---
v6:
  - Squash the two propagation patches into one  and add
    Tianyi's tags.
v5: https://lore.kernel.org/all/20261121182217.4609-1-emmaonana18@gmail.com/
  - Retarget to net-next and drop the Fixes tags
  - Move the invalid-tx fix first, so no commit in the series can
    report a false failure on a correct kernel.
  - Fix the subject prefix on the invalid-tx patch, lost in v4's
    send.
v4: https://lore.kernel.org/all/20261119003003.40482-1-emmaonana18@gmail.com/
  - Patch 2: use if/else instead of "&& { ...; } ||" chains, keep
    lines within 80 columns (thanks Tianyi for the review).
  - Add patch 3 deriving the invalid tx value from the kernel maximum.
v3: https://lore.kernel.org/all/20261116084107.6675-1-emmaonana18@gmail.com/
  - Add Tianyi Gao's Tested-by to patch 1 (thanks!).
  - Add patch 2 fixing the remaining three checks.
v2: https://lore.kernel.org/all/20261115214702.50817-1-emmaonana18@gmail.com/
  - Correct Fixes tag to 1ec2230fc721.
v1: https://lore.kernel.org/all/20261115212117.48496-1-emmaonana18@gmail.com/
  - Initial posting.

Omokefe Emmanuel Onanaroghene (2):
  selftests: net: veth: derive invalid-tx test value from kernel max
  selftests: net: veth: propagate check failures to exit status

 tools/testing/selftests/net/veth.sh | 31 +++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.43.0

