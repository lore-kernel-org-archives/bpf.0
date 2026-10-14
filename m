Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3692571A9
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959242; cv=none; b=EKMZ8mg1E6j7YPAju//4/LMGYOMVw0FlVQdirCuw8LFn5m0MEZB/a9tXanR678elIV+BpESO7nbeEvvH1+oH88HGMWOq1TaPgdmDhHrxY5wpGg/BC9niVCpBMZ/Lwdn+VFjSQIl9QCQ9SsJ2LCRUpfVJ/yu2nsb2/VgLaQXNiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959242; c=relaxed/simple;
	bh=f+qohAJuN1F6Q1Y0tiY5g2sfEJf7RRk9kbfAPocR7c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gvVMYI5vjnVErc8p1tdac3fKZAmo1KOkICnC5KxC+YNDnxdKOoGZ7YjG3o9ShIDXwEhz9Jwh5z0bv1qTom03uMVBzTb84YMMH3YSfl1CPr5BCvicwGhIv6fAmdqCQi6pfSpVbp9Sz0HOmNF+xRNE6pxKtotqa4FpOGlDnNVe+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mINMR+5P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mINMR+5P"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so5612165e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959236; x=1792564036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WrZ4/u4jJEQM0ZlZpxNQ2Z1WiaeNhYEi18x7PW/q/M=;
        b=mINMR+5PXWd43jUHM9EHjImQt/B6OVF2YoYXSwNTes307c2+t9+qN5I/9U4hx5l5UP
         sh5GYLsCuhwnJzQzRf5T38jihxTgh/AOZY+c2IK9Wyq6+oASoNXH6sucSdr/d5rkQ3IN
         aaQmjzJHZNB/GKnwKKR5CymeFs+8LowxixRLXr73UvRliZZPWiZRKxAZX8VEXHQrysPp
         rqBBmJCbsjecn01wC8VyEdzysL7wzIQFq7MWpsu86hLGZAd9Wo8G96/P7PAlEK98dtYH
         FPILoK1lEhEBhyNl/c2x2/Vcmh57jwVqEpYx+5QCvDbuNGiMyQNEoKBArEdLsrjJOS/A
         xrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959236; x=1792564036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WrZ4/u4jJEQM0ZlZpxNQ2Z1WiaeNhYEi18x7PW/q/M=;
        b=LxT2qZvg32VnGHD36wYhtz0bltFiv24dQtmPbeNdcOcN9/Euq3+knwtQ/X5MsOB5TE
         16L91GWG1yQtZh6EJ6IYfQAOwWFz1jUn19UCcipQzEm1k35YpYP8OdvXvGpIxaNw82zz
         bQJqALwcHRQT76CIuUtszm7FnNqBjdZo13aWotVNosLKhirSLyxlRUFgMEhdpMxdKK9Z
         jaBQn+kqvaVNq3ohwjkJ7QFhpetunV24FvmvGi5UTn3+kq7FkPQmmxpdbVazZSHrZX0g
         25TZcWnWTugRdFnycAtrOLVoHLTtNtfnNxSOHf35vZaxocJ9Izsav7U0LgawTvAB5IKH
         yS1w==
X-Forwarded-Encrypted: i=1; AKwUvBz/wtuYzmAqA9Jq5JyVkwNgH2qPBeEaJHB+q9cwV8P6/0h4Pxe7UXtde00MnEIEXkh9b00=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO/vUv2JTGhqQ8lCGhA4eftIAc34OcEsD+Orkc1vdvjKZWoxvS
	Qsh7n6k0WQ3VpkXXimuqHbf0cC1e9SY2GnDXhRf7Woi8iH+Qm0cDoV/q
X-Gm-Gg: AYBFou3geijrvmpSrZvrt8abDs1NQIETmzN4p6k93qSTZ1lvcTRdMpQeTlee8KwJu9X
	0KYz+hdg1+D8C5OdXJOPF8KGzqVR9GN+ro7I41nL0fUvjhvxz8nD61RU4QznS2NdIq8KaWtjl1z
	IgZjhlrC0rKLhHm2Zptco3NgLW6nzHMTKnJNDLZ8UKJD49AFHv9iHLPyoFdp1ktviM4BDWTwtsC
	aR+8ikIhsM6qTB994LrLlEBIbl+9DNRnmztFuLx1jlaFkvBSSuhqJ1+Ms/z4vQsD/NKDOgIhxOC
	pyqsd5nQp+sSAzJURLTOpEySghhn+6n9+kDdczbHKUGf/8yPmJq2SKkcAblSihLl+vFpEZrEyRZ
	zpg3Hz/+Y55T0jgnXy+FcW/KKL/Whxr5Mj86DXUjhFBzlWUvJkeP1UbzsPF0yoxHFfPdMBd15WS
	88Vu6J0xc4fgQ/LfpVJSU7W1e74PkLjYtatANrkBO8WLdOnEiUqQAsbiF9QvvH9FNJPakaDVtY8
	7uQmEQEQe1IOde5cgdtRMogtHLxQgWcXAnJmuzrgLlFwt90I8fp8WQQ8ZOQdGJRzJbMUaRGyzAv
	WHpmioXx28Rr9ElTm89H33cq4Y4o8iqSJr30w6nWzwr3dFBxXG8kdt4Ju9qaGm94oQfUMqVTX6A
	6m8DkgsrEiH0x
X-Received: by 2002:a05:600c:19ca:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-4a18e4487b5mr298737055e9.1.1791959235651;
        Tue, 13 Oct 2026 23:27:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aed1-da01-ddff-863b-8308-ab16.310.pool.telefonica.de. [2a02:3100:aed1:da01:ddff:863b:8308:ab16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm528846745e9.4.2026.10.13.23.27.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 23:27:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: stmmac: fix DMA allocation and IRQ failure cleanup
Date: Wed, 14 Oct 2026 08:26:58 +0200
Message-Id: <cover.1791958735.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DMA error-path review for the BeagleV Ahead found three bugs in the
common STMMAC code. Partial allocation can call buffer cleanup without
the metadata it indexes. A later TX allocation failure leaks the RX
resources allocated first. IRQ registration failure can release
descriptors and packet buffers while DMA remains active.

Patches 1 and 2 fix allocation cleanup. Patch 3 fixes the IRQ failure
unwind independently.

Testing:

- BeagleV Ahead, TH1520 DWMAC 3.70a: guarded baseline/fixed boots for RX
  and TX allocation failures and normal-open IRQ failure. Baseline runs
  reached the guarded unsafe boundaries. Fixed runs cleared the tracked
  resources and stopped DMA before cleanup.
- A matched follow-up applied the same RTL8211F-VD resume repair to all
  baseline and fixed kernels. At both 100 and 1000 Mbit/s, each variant
  passed eight close/open cycles (32 total), delay-register checks,
  pings and bidirectional 1 MiB SHA-256 transfers with no RX CRC or
  DMA-API errors.
- Native-XDP IRQ failure was exercised on the same board. The baseline
  reached IRQ unwind with DMA active and required a test-only rescue;
  the fixed kernel stopped DMA before unwind. Both reached descriptor
  cleanup with DMA inactive and no DMA-API errors.
- The physical native-XDP pair used CONFIG_BPF_JIT=n in both variants
  to bypass an independent RISC-V execmem Oops after the STMMAC unwind.
  The default configuration's XDP-open path remains covered by the QEMU
  fault-injection matrix.
- The exact combined code passed 24 of 24 checked 64 MiB transfers on
  fresh BeagleV Ahead boots with no DMA-API errors.
- QEMU orangepi-pc/dwmac-sun8i: 36 of 36 cold boots passed across the
  allocation and IRQ matrices, including XDP-open IRQ failure.
- The exact combined code cross-built the STMMAC objects and BeagleV
  Ahead DTB with a RISC-V defconfig and DWMAC_THEAD enabled.

The guards and fault-injection hooks are test-only and are not in this
series. The RTL8211F-VD repair is being submitted separately.

Based on 24a19b953e2a (Linux 7.3-rc7).

Karl Mehltretter (3):
  net: stmmac: handle partially allocated DMA queues
  net: stmmac: free RX resources when TX allocation fails
  net: stmmac: stop DMA when IRQ registration fails

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.39.5 (Apple Git-154)

