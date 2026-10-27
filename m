Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132079;
	b=rOJ/Ki2YYCnCoSl4Ym0nJ5+VbOc9IwkIUBBhPgNf4fuUgMwnEhp+yeW22A/QUmQg7yYY
	 qVTxwSomMjVbU0yfxX1HN/74C7ncrkZugCXx3yWivAdBM+WG0E7x9eEO/frti0RhYtHZz
	 qRyRX8ehSQfZ+dz/V9zh8/h2PoWuk2wJ0oYZAqgVn4zEWNfWTd0pg2JF5TH2muiL2zbRi
	 x+YFqjJlqYBbi3Gve63SPFyFG4WTm/ct1T1+QvgCE4IjCKnR9mYzCIGdUKcnJ6Lx/8ozl
	 mLjTlnVVrtO8VITuxOlZV3VCjqJDoHPth8CsvlCFvfS91HNtLv7LELnvavdZabY7ZIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=G2D5Bs9MWvn9cEqLwS1RfnFMj13cUS9HBil+xgfP/+M=;
	b=fGOwBsqc5D91gkcx9HqgkeClqFMkGyNtM1VTgbu8fX4chpmPSHyut3JFtKymyCUADblv
	 uNyT78dv/LZWWOMtZo2t8eUUz7YUgmADWoSUtpOEjkm8guraysodsoPZSv3ucaktZ3/3k
	 dPi+0TEVUtkAFS4G2Eq1XDkEDuDVOQwoSrUo9+mcyy3Yja3LzBSFqt88wGJ94uy+gf4iO
	 Kb18yyFjhMfc1FFnKcy7zg3VFFI71QVP2M464Xi1++Y76tQVGvZYgiraKoMhtis+YTPoQ
	 X32TyvGKqQN9MuNG0zDs7TYRU6IBEtiiwLtGOcEQknT3UoHsCEZnXvaWnmQkfjfY/iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wG0DGred;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3367606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3367606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wG0DGred
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so169417a12.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793132078; x=1793736878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2D5Bs9MWvn9cEqLwS1RfnFMj13cUS9HBil+xgfP/+M=;
        b=wG0DGredc3z3jkjUFg0ehUNqJf2IcOX5N3XF/vAM5DRmwntV/ieyvPwR7VX5x7v2AF
         AXO0p8ol8AFg1XwaKY3SsX9jg8DNBANuCNwQfqScSeuMjk14ab23BaYGLfJZVJp2icao
         iSAWS31snq/FE9JctAQFuA6IR/rfzwjPDZPHZ+dOBqCi1zFNjD3AcykoqNi8JpPt+x2G
         OXKF/0cMttmWIswx1DhIJP/dFH4YkrqgnKOD5nkTphucdusRHAS4BHgBA2naBace4xdN
         qlvvpj7r++KtnRCnIW7GmW/VduVEDBPD8HkaxRfGOf912h267zkSo0LyylBx7qE+4hKK
         fjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132078; x=1793736878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2D5Bs9MWvn9cEqLwS1RfnFMj13cUS9HBil+xgfP/+M=;
        b=ieRe2pm6ZlZqNFuEFURjXtYjwpvhPygsNqkr67Zp+Zvl0B88zn5X+9QrdVPvIETYVS
         TkZRcIANosdS/REwXzEPWSa936xdZgYCyY/VrSHs+1YmxoTRT5/Mp1oWXQ1+KBEAsVLK
         SeH139eJdcnHP/W9rjJU3G4XUU0YumlGsN0g4CfmxZaPFZwmpNvQ4dL9t/ohzX3Ck/xH
         O7/TY4qB155qYQ/Pnz4lttcq2thiK1ulrc7tDhttMkn0LU7aXJsHftm6ET6Fs3Yt6rwX
         HXrNBepZ2KLA3LTYsdZk58u07yGbO8DFhQKXRgQVV6guDxkE4M92jaHH5VQxuDeFgJmP
         CfAQ==
X-Gm-Message-State: AFq9FYImbWQ6bdgPyqGbRMjViANmPxEm6+jOPNFD7fVKZvGoV8A6sdhi
	AHmA6wxNc3nIsNrT8kSRfI/ZzmZBHy+xZdqxufrI3rJUwzJvBh36Gd2U69l4Bw==
X-Gm-Gg: AYBFou3b4R/cE55H6jzdSMq9WNeu0IfNCDGrvke0EMWvHQ2pGhoBKn4Z0HwlIpTL64p
	H+ACxUqcBTA1yPIb5tXUlU5wm5YbdMO2E/NcAjlXQjvQOHcO3XHjk2Gwtrn6mMkgHooVL31piJ4
	cmWKIGEfFMZmSggA+wg/4yzPnTZEcBYjemETf4d6pGyZ93fo3vbWeTwxaHBfUL8TB4ZSzwRFRKN
	JC+loTMqqRN+lyNh/xfo4St7kmCAllV6+/bpdf51ZJ8mk9WurG3Xp0aofB3IMlrzZeuj7ioXHnO
	bVfMhvrtds415xvhVXMXb0yuOi1X6/d4x34iIo46X1DMTBxpF9F0BGHMyxrX+bLM0Ke4iNzf8wn
	tRFx5NtYYRBSUaqogcQCRK9XG6UbVM4xCRlqE7+uGNooanH683Tc/YiLLhbk28GNzynbu2U4ZpL
	IpMtntK+UrZiqJIJVGVjWbCUKiglFCeJNYOkrN3a2bJ/umunCT4+k2qXJLR0WL4sQvA93AXjW12
	HpLVBsYUCKuiC+ipQVJwHTYTjLBuKaWlAPTVQXREzEcjP3DkyVqtOGnNkoVzBocR6DDvxJbA5rS
	gQxsVXYqADr6KzANgmLnyn6ymyW1TDdWEqi4e/YiTXJIn0l+ZfWOptfF8teZOymHnvOfB/k84Qh
	5nGJrwQc9gu+9dN0CGgDJmrFv
X-Received: by 2002:a17:90b:2f4f:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3ae58181a3emr120622a91.46.1793132078127;
        Tue, 27 Oct 2026 13:14:38 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5780e2fesm338420a91.8.2026.10.27.13.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:14:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 0/2] bpf: Keep the valid bytes of a packet pointer in scalar evolution
Date: Tue, 27 Oct 2026 20:14:34 +0000
Message-ID: <20261027201436.3192716-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Sashiko found a bug in the review of patch 14 of [1]. It is in the tree
since scalar evolution widens packet pointers.

'range - umax' bytes from a packet pointer are in the packet. At the head
of a counted loop scalar evolution sets new bounds, and reg_bounds_sync()
makes umax smaller: 58 becomes 56 when the step is 8. The range does not
change. Then the verifier accepts 2 bytes that are not in the packet.

  prog                               bpf tree  [1]    this fix
  ---------------------------------  --------  -----  --------
  r6 += 8, access in the loop        loads     loads  rejected
  r6 -= 8, access in the loop        loads     loads  rejected
  access in the second iteration     loads     loads  rejected

These patches apply on top of [1].

veristat shows the same verdicts and the same number of insns for all progs
of 36 weekly builds of Cilium (5032 progs), of sched-ext/scx (563 progs)
and of the selftests. test_progs, test_progs-no_alu32, test_progs-cpuv4,
test_progs-bpf_gcc and test_verifier have no new failure on x86-64.

[1] https://lore.kernel.org/bpf/20261027190314.1440199-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Keep the valid bytes of a packet pointer in scalar evolution
  selftests/bpf: Test the valid bytes of a packet pointer in a counted
    loop

 kernel/bpf/scev.c                             |   3 +
 kernel/bpf/verifier.c                         |  18 +-
 .../selftests/bpf/progs/verifier_scev.c       | 158 ++++++++++++++++++
 3 files changed, 177 insertions(+), 2 deletions(-)

-- 
2.55.0

