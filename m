Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D73B4EAB;
	Sat, 17 Oct 2026 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206374; cv=none; b=C198w7zR1yt56x+d5YzzhrwYjPcvLDgXKE3Jt/GbkGKdQ9Zm3A77VtLXPj5TJhV2E5260RUI6NJQVtfdjv+iZjt9QYRoKYZzXhmOku08d9kd5FNMLHpNQoRtxv4D5bxsIFAobMXuyZQrnUtvTXCCW9jjczh25PioWMBaIF1hm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206374; c=relaxed/simple;
	bh=hmUlaEToS4X/xMPVcwVUUI5HypLjBS4C3XQ95uTikZ0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/ikKWCMv6KHOoMPBw+RBSvnsLzQSE3gf1gR/iE77PXSLxnPG2YfGtVEt2nmPC8cN9QnMRHhQA4oTYkrAXuWJcSO7JIshy32TxTEFLu0PF8HEDkRQ7obNFAeQz/Y1/4tdKVCo+gy6JcJi9UbDG1x3UbiVmatgfds37yEL/h6lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9UJNdxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9UJNdxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377DE1F000C4;
	Sat, 17 Oct 2026 03:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206373;
	bh=m6hTExQZOxzKhFq8KNvZvjiXLqIeXz7nSivZVa8007E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O9UJNdxmo3mGIdse0KNrp6Igu3w2spPCtCqmSHIYZ5Nrn7Dbe51TMmp6RTR9zCygr
	 1e0h+c6plrJGvbyEj03SCXz87BCpw1E7n9L2JfEVWeOQ4RTQ9OOZahGJhAftj6/dUf
	 04fhVmea/G2ntvgM0vihh1izTSc37M8I7Md57LwQ4JjiyhAeSZRxZ+MvpdRWgaUSk7
	 yvN3VoA7q/S2OlOv6MY1kYFpiIdAcmkGQEoTkzTkcdrwS6ADCS9iczlTI0SQGDu62N
	 Hc/5TR+by+8laow7F75tDW9CW9xLto1TZtyWhQKn9Fem96tHtCqWegQxshIq1tQL3I
	 c8Xw9rJ2ZoKGA==
Subject: Re: [PATCH v3 net-next 15/15] selftests: xsk: document generic and
 hardware endpoint runs
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:12 +0000
Message-ID: <179220637280.434549.17272583874427101673@kernel.org>
In-Reply-To: <20261014184539.774708-16-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-16-maciej.fijalkowski@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new README tells users to build the engine with a plain `make
  -C tools/testing/selftests/net/lib`.

--

selftests: xsk: document generic and hardware endpoint runs

This commit adds a README.rst for the AF_XDP engine in net/lib/xsk. It
covers the per-case veth runner (test_xsk.py) and the two-host hardware
runner (drivers/net/hw/xsk.py), with a zero-copy DUT and an SKB-mode
remote. It also points the xskxceiver.c header comment to the new README.

> diff --git a/tools/testing/selftests/net/lib/xsk/README.rst b/tools/testing/selftests/net/lib/xsk/README.rst
> new file mode 100644
> index 000000000000..2bbd11711cee
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xsk/README.rst

[ ... ]

> +Setup
> +-----
> +
> +Build the engine on the DUT::
> +
> +  make -C tools/testing/selftests/net/lib
> +

[Severity: Low]
Does the README need to say that this command only builds xskxceiver
when a working bpftool is on PATH?

tools/testing/selftests/net/lib/Makefile only adds xskxceiver to
TEST_GEN_FILES conditionally:

  # xskxceiver needs a working bpftool to generate its skeleton
  BPFTOOL ?= bpftool
  HAS_BPFTOOL := $(shell $(BPFTOOL) version >/dev/null 2>&1 && echo y)
  ifeq ($(HAS_BPFTOOL),y)
  COND_GEN_FILES += xskxceiver
  else
  $(warning excluding xskxceiver, bpftool not installed or not working)
  endif

If bpftool is missing, make prints that warning and finishes without
the binary. The skeleton rule in net/bpf.mk also needs clang with a BPF
target, plus $(BPFTOOL) gen skeleton.

With no binary, both test_xsk.py and drivers/net/hw/xsk.py print
"1..0 # SKIP ... was not built" and skip the whole run.

The same build command appears in the generic veth section. The opening
line also says the engine "is built as net/lib/xskxceiver" without that
condition.

The prerequisites paragraph further down lists AF_XDP in SKB mode, BPF
and timeout(1) for the remote, and RSS and ntuple for the DUT. Could it
also list bpftool and clang as build-time requirements on the DUT?

> +A top-level selftests build with ``TARGETS=drivers/net/hw`` includes
> +``net/lib`` as well.

[ ... ]

> +The remote host needs AF_XDP in SKB mode, BPF and ``timeout(1)``. In a
> +namespace, the remote endpoint runs the DUT's ``xskxceiver`` binary. With
> +SSH, ``xsk.py`` copies that binary to the remote, so both hosts must have
> +compatible architectures and libraries. The DUT needs RSS support, and
> +both hosts need ntuple support. The test uses ``NetDrvEpEnv`` and the
> +networking selftest Python helpers for setup and rollback.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
