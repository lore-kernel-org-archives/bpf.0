Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712397;
	b=d3YvDT6dVVEcyVVXi7KRN3TgMQh31ZF6Img7mOuvyzVpVj5eI50vAtk3aUTPxMJ1cf22
	 pXS43l6LADienIqXub0RBPGE6Iptn3jNIv5T2HAb5T5v5CS7xWAW7+uqNYIGARf7eewiW
	 on8k5t59g1/eBqLd2zTDBLQaqFVj3KTM4V9Pleh4CtQLUipdwn+8FrD0/a/Yd9/COwmtB
	 PMDMAjk+YsaVHyGUGoKCIa5x4jg+H9DDWwgwSVrgFCrArIp5dU1QW0P3UXKxTq0AuYaKm
	 BchldqBqkl91e05dAll++nkfDme7UlvIe7ue22NWUBRzQCeAsanpSStUSIbav91ZHxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712397;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8lMZMIQfgxM1Y1sLfd9pmLbFTG91TDyafPfpoX4xnzA=;
	b=W06UD1uXN9JHOPoPjWhYF8kp99rexTmqPmxq6VejoTvmZBJnqwHgqG76pyuh0OKR7KAW
	 wLPX7SgmH4NXrIwuKIzX01QzK5T08ZbYggPWt/cA5k6aDez14qKhcn/Nvmz2ntTVqvZ/b
	 eCNY7fic8xS0vE9rKZKm4JTLRklR0V1Nm6Q/wPZF/7sdkk9f0BsLG1bKyzqatd3Vo5zKL
	 JmT+iq+CH+aYQhI+6ui7HlYrjfELIUre0aER7kYTaJi2OhTymC0eWfZMdNFktxxEoqViB
	 gONmVrhEcycvzzJaO6stZE0LRFnSsPwQxWlUSfTNRderIW1cejSwfUlbYRlWvXldV7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.22
Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A86606D825
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A86606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VwdILgRNSWIPkWDn3eJqPy63I1Bwv0LiB91pK15cOp4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793712391; v=1; x=1794317191;
 b=RKUEs0xXGMHXqpldvK6xKP9OgY/JkqJguHg9nwDITmPZYbZSfAdhCDOfLqEXbyxGkw5DOJg+
 sUpJMrY5rz4yDlReExV7mql76Heuw9veg2/T3jq7KFYQjb+PtZryeX40GnyotIZJX2ts1N6upNJ
 9H01i8xwDXIYfrtWX8KekVE4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 223b7a157b0f36b3;
	Tue, 03 Nov 2026 13:26:31 +0000
X-Mizu-Trace-ID: 223b7a157b0f36b3
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicopanda.com,
	axboe@kernel.dk,
	alexei.starovoitov@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kselftest@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	ameryhung@gmail.com
Subject: [RFC PATCH v12 0/4] blk-iocost: BPF struct_ops cost model
Date: Tue,  3 Nov 2026 21:26:09 +0800
Message-ID: <20261103132613.1952975-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
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

From: Tao Cui <cuitao@kylinos.cn>

This series lets a BPF program take over the cost model of one device.
The BPF model provides calc_cost() for charged IOs plus two transfer
coefficients for the completion-time sizing, io.cost.model selects
between the attached model and the builtin one, and enabling and
disabling the controller stays with io.cost.qos.

The builtin model is a linear formula derived from a handful of device
parameters, and the right formula is device specific.  A BPF model can
be adapted to the device and updated without rebuilding the kernel.

The series is based on next-20261030.

Patches:

  1/4 blk-iocost: add BPF struct_ops cost model support
  2/4 blk-iocost: add iocost_ioc_tick tracepoint for per-period
      device summary
  3/4 selftests/bpf: add iocost cost model test
  4/4 docs: cgroup-v2: document the iocost BPF cost model attachment

Changes since v11:

- dropped the cgroup callbacks (the models build their state in
  calc_cost() anyway)
- dropped the queue freeze from detach
- folded everything into blk-iocost.c
- the selftest now uses cgroup_helpers: the tests create their own
  cgroups and remove them on exit; io.cost.qos/io.cost.model are
  root-only cgroupfs files and the test reverts them on its exit
  paths

Tested on next-20261030 (qemu x86_64): the selftests pass, and the
2x example model doubles the charged cost over the builtin on a
rotational device (2.01x measured), returning to 1.00x after
"model=linear".

Link: https://lore.kernel.org/r/20261028143534.135968-1-cui.tao@linux.dev # v11
