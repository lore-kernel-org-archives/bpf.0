Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC023BE140
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062230; cv=none; b=pyA8KWsP58MxuA4BOD73l2WHIoerd7WFO9YdnClD7kveCmQPB0jwfhMQKdKvN6ibmmHmDBgCYv1/GG+SosyMXuRYsab5E6dW7QwPeIdpAj2FbAZcehdpleGbgvRVpRA6gLdAC6p3VXurW+ViKjaXZEzmHTsYUNTUTxMUZWys18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062230; c=relaxed/simple;
	bh=eE4B3grRprR6TmX4MIFwIWPoY7LZpyUe5/n6NX397TU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fletier2pTLjlMhy/UxxcBriSZRAUd0OMosWMjEDVDHtVK1XzRU4cfLgUV4D3uRpE/VXAIgKBSc5Rzb/i/64HJYxuD6tNOQr8RFIKgJZ7jnpAqzSm8PxPd3a1rv3kXwHNsYfwV1j/xpo7srcBMkSIAh1qbW3A2nhjjkFVA47CbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imof9u52; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imof9u52"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48539d21b76so9088905e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773062227; x=1773667027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0x32ghOx+4U/hItWNH94kB5dUQUYxKukptmRgOwqO8o=;
        b=Imof9u52Qoaqw/cuPw941sU/1k9DMsoAssahfyycuDpeRa7uMrmzWBVdWOlcBQVI3q
         MSndlBFxlj92JUS4kjLCP6A3xCZ25+/FgawoGF7AKtS2cFn4JFMuji5rTjxBmEJzJhvu
         ohinXKfzi4Ayam4wEWofEe2M64r1PBSNi6NnJ5b74ONUaDVywLaMuK9p+llpI3eyWMq7
         vSdrmHeyjpOAYQ9ZxjVP9Xp2s7PPcOOIDH58tHdF/mqlwJT4f8ZD352V06oj+016e8R0
         GiJtSwaojQ1OXWBzz+HvKaBoIgOYN8tOYmIvrwLDpcdm9GyOECBoYbw5V7jEmi+hksOZ
         smJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062227; x=1773667027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x32ghOx+4U/hItWNH94kB5dUQUYxKukptmRgOwqO8o=;
        b=Q+L3FW8/ttmiVRyoBcT2K9U15tPKvykdnbujYv8DJ6rZ0maKlax9b/jjJx3ZSMdCza
         GNyO6qLgwgNdJ3lw4c0+RMHLTdbS4hYGvNZzqWtZFx40poAGr/X8ezEEVsZqrj82ksMu
         W7vhd5P1Xpo7RRLsIyCZ+kb8+XPgqmcWKJOeNj7UPADgVdHpnViJ+h0z6zphKe0ed+P7
         XECJHCE98rkYhmMdZg1JbfEj/xEhM6o4L739eMRTrmEUHyPSxIWwcZZ8cy9Nbf0poZAl
         ccK8ReIL30o+4Q+o1qIOTVgpyBdLJ+G+TgK1d+YXODr47QkGwyGjTUgaxCHl8/D4uVSn
         DobA==
X-Gm-Message-State: AOJu0YwQRpXDkaqhEUtEl/DS+/5TMRM4//oPYMqzEhFkeEV5vBl4nc6e
	YSVmC20dKBhCYiDBXgL+89kUImDy8KSammerDAuRlrIPJRrhOsbBir7RSMxbdpAE6OM=
X-Gm-Gg: ATEYQzx8tiExFUPo3GWQa0aoO81GmPoGQDgJQ7ooWMeLK9SbtX8pdR3KhHcAc1RsuRY
	aADJopz3QtDBR9QnubAKS5THFUG48Lxr7FyQBlSphoQtwvARO0oLomosRxZTP6CAIvBLK5a8Dvv
	dUFWCn4PVEEfISmF0M+mm7nqxdJxL23RopodzhWnWEJlahyjolIK2lHMN4QxQFaeQzmzzK873dj
	LICKvtFFwP9PYZFiQdvd3AJIQ5EhKGuZzqDUUMnlwl/dKevupz5y+YhA+2xL226PhOnl6bNzXw8
	03eFR8SKzq1ghGa050xIneUfGKvRrN3CZchHN5YEEU2ziPeZAcOp+2gxGLOp+HHvqH9Y1YTMUVW
	SyNgmzrG1Zy8XgmihD3n940Sd2aSl4rrGI1z/s7uJLvIbGXyYUvWMx2cXywPapNAbQNfGTm/DMy
	AM77HIjnN119pM6TgbOPuTFfkCL14=
X-Received: by 2002:a05:600c:46cb:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-4853dfc073cmr31526615e9.21.1773062226848;
        Mon, 09 Mar 2026 06:17:06 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-485246ece8bsm128506395e9.4.2026.03.09.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:17:06 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [RFC PATCH bpf-next 0/4] bpf: Introduce bpf_netpoll
Date: Mon,  9 Mar 2026 13:16:31 +0000
Message-Id: <20260309131635.302424-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces bpf_netpoll, a set of BPF kfuncs that allow
BPF programs to send UDP packets via the netpoll infrastructure. This
provides a mechanism for BPF programs (e.g., LSM hooks) to emit
telemetry over UDP without depending on the regular networking stack.

For reference, this was discussed at LSF/MM/BPF 2025[^1] in Montreal,
and again at Plumbers 2025 in Tokyo. Liam Wisehart mentioned this work
during his presentation of BpfJailer[^2].

The main use case is to be able to completely dispense with
agents/daemons for BPF programs after startup. In the case of
Isovalent's Tetragon, the idea would be to be able to emit security
alerts or export data from BPF even when the agent is down. For meta,
according to Liam presentation[^2], this could replace logging via
ringbuffers which created cross-binary versioning issues.

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration), for example used by the network bpf_crypto kfuncs.

Further patches would extend the bpf_netpoll_send kfunc to more program
types. Note that network program types should not encounter recursion
issues as netpoll bypasses the network stack and sends directly to the
driver.

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lpc.events/event/19/contributions/2159/

Mahe Tardy (2):
  selftests/bpf: Add netpoll kfunc IPv6 variant test
  selftests/bpf: Add netpoll setup basic tests

Song Liu (2):
  bpf: Add netpoll kfuncs for sending UDP packets
  selftests/bpf: Add netpoll kfunc sanity test

 drivers/net/Kconfig                           |  11 +
 include/linux/bpf_netpoll.h                   |  38 ++++
 kernel/bpf/verifier.c                         |   3 +
 net/core/Makefile                             |   1 +
 net/core/bpf_netpoll.c                        | 209 ++++++++++++++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/netpoll.c        | 140 ++++++++++++
 .../selftests/bpf/progs/netpoll_basic.c       |  47 ++++
 .../selftests/bpf/progs/netpoll_common.h      |  64 ++++++
 .../selftests/bpf/progs/netpoll_sanity.c      | 135 +++++++++++
 10 files changed, 649 insertions(+)
 create mode 100644 include/linux/bpf_netpoll.h
 create mode 100644 net/core/bpf_netpoll.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netpoll.c
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/netpoll_sanity.c

-- 
2.34.1

