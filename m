Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868146EC70;
	Mon, 12 Oct 2026 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795032; cv=none; b=vAfxqR77oDfInlvXMT8lS5XHtRJ9EKRCcoL9fNN3hTdg8tKwySySJYLWvAJarqZ54uvQY1Y0CyW1XhJ+ZnVYziYMqTPjNSLbwhUnkAwCoTG7uo3rPfryJdQe/hbdroG49VkniZjT4oT7EJjWvHGNcIUflm27pbifayQlxrGZL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795032; c=relaxed/simple;
	bh=L5MHKKgmTdbkr954/SCJFPKuLl3SxXeOxVP2Hy+eylA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzaDIvRYPd0mcqzybwHFplF0l8zOfGOb8cLWlZ2n5pq1405ENpg/qy5U0Se0jhapGl/K+/ZyClpNtLVDW0Voo8bWEKaKiDV3PwfUmn5KQ0lb4GdV/i7eujNixRAH+00DAbjXDW/RKVWlj8A2hez2IZh81pzzrL++u8BERo/1QOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9qInJuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9qInJuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20381F0089D;
	Mon, 12 Oct 2026 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795031;
	bh=ktDUI42geMzy8DIpwoJvhqfNcy6U/NkHXExoElXrZcc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W9qInJuLFB84qmbZ0EZ/tbkYTj/egVcnQZdlmcxP5cgl1YM1+VAYkovGvkmO4fXkG
	 xG6SordmSJ36kslgBtKKcZCdXcIKWIA/ctPQtjr3IL7RpAex+CiZxNTkcF0wl+MU8Q
	 xKINTFD6bLUiaYVgtoWvjnAh14St252ZgDy1glGPcS/eakuYYpr8CgmoS0k2SiOTIJ
	 giNd7yz+EVWTf75LDoTmrgxrV4ABo+jIQdwnKGLyOwSNIx63iru1458j9UXnN+PxiH
	 B0bwuVvm0AqeBX3/IOMNUdPyWynkwF3GTUQIav+5vhcJWfvUVeTk/GS55DrQ62HCbm
	 rwH3IojAl6yyA==
Subject: Re: [PATCH v2 net-next 14/14] selftests: xsk: document generic and
 hardware endpoint runs
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Mon, 12 Oct 2026 08:50:30 +0000
Message-ID: <179179503054.434549.3586703041532575389@kernel.org>
In-Reply-To: <20261008114909.734364-15-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-15-maciej.fijalkowski@intel.com>
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

- [Low] The new README describes XSK_REMOTE_DEPLOY and XSK_REMOTE_BIN as
  if each works on its own, but xsk.py does not handle them that way.
- [Low] The 'Generic veth test' section of the new README.rst ends with
  "The generic frame format is unchanged." That is a changelog note, not…
- [Low] The README says "The XDP programs redirect only the test flow and
  pass all other traffic to the stack, so the tested link does not have…
- [Low] The README says "The remote listens on all addresses for
  control." In test_xsk()…

--

selftests: xsk: document generic and hardware endpoint runs

This adds a README.rst under net/lib/xsk. It describes the per-case veth
launcher in test_xsk.sh and the two-host hardware setup driven by
drivers/net/hw/xsk.py, where the DUT uses AF_XDP zero-copy and the remote
xskxceiver uses SKB mode. It also points to the new document from
drivers/net/README.rst and xskxceiver.c.

> diff --git a/tools/testing/selftests/net/lib/xsk/README.rst b/tools/testing/selftests/net/lib/xsk/README.rst
> new file mode 100644
> index 0000000000000..d0a0a902ed783
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xsk/README.rst
> @@ -0,0 +1,138 @@

[ ... ]

> +The shell wrapper creates the veth pair. ``-m skb|drv`` selects a mode,
> +``-t`` selects a test by the name or number shown by ``xskxceiver -l``,
> +and ``-p N`` selects a fixed control port instead of the default random
> +port. The generic frame format is unchanged.

[Severity: Low]
This isn't a bug, but "The generic frame format is unchanged" reads like a
changelog note. Once the series is merged, someone reading this file on
its own has nothing to compare it against.

Could this sentence either describe the frame format, or move to the
commit message or cover letter?

[ ... ]

> +Both XSK endpoints generate and validate raw IPv4/UDP frames with one fixed
> +UDP port, so ntuple rules can steer the test flow. They do not use AF_INET
> +sockets. On DUT RX cases ``xsk.py`` reserves the last RX queue outside RSS
> +and steers test traffic to it. On DUT TX cases it steers traffic to queue 0
> +on the remote receiver. The XDP programs redirect only the test flow and
> +pass all other traffic to the stack, so the tested link does not have to
> +be otherwise idle.

[Severity: Low]
Does "does not have to be otherwise idle" hold for DUT TX cases with
REMOTE_TYPE=ssh?

In _setup_case() in drivers/net/hw/xsk.py, the TX branch reserves a queue
only for a netns remote:

    queue = _reserve_queue(cfg) if _netns_remote(cfg) else 0

With an SSH remote, the DUT zero-copy socket binds to queue 0, and queue 0
stays in the RSS indirection table. A later paragraph of this README notes
that the DUT TX socket fills no RX buffers, so its zero-copy queue drops
what it receives.

If unrelated traffic on the tested link hashes to DUT queue 0, wouldn't it
be dropped before XDP_PASS can hand it to the stack? That includes non-IP
frames such as ARP or LLDP, which many NICs put on queue 0.

The test still passes, because _control_addr() sends the SSH control
channel over the management link. Even so, this guarantee only seems to
hold for netns remotes.

[ ... ]

> +Configure the usual driver test variables in
> +``tools/testing/selftests/drivers/net/hw/net.config`` or the environment::
> +
> +  NETIF=eth0
> +  LOCAL_V4=192.0.2.1
> +  REMOTE_V4=192.0.2.2
> +  REMOTE_TYPE=ssh
> +  REMOTE_ARGS=user@remote.example.com
> +  XSK_REMOTE_BIN=/path/to/remote/xskxceiver
> +  XSK_REMOTE_SUDO=1

[ ... ]

> +The remote host needs AF_XDP in SKB mode and BPF. ``xsk.py`` copies the
> +DUT's ``xskxceiver`` binary to the remote, so both hosts must have
> +compatible architectures and libraries. ``XSK_REMOTE_BIN`` chooses a fixed
> +destination path for that copy. Set ``XSK_REMOTE_DEPLOY=0`` to use a binary
> +built on the remote from the same test case definitions instead.

[Severity: Low]
Does this match how xsk.py handles these two variables?

In _remote_binary() in drivers/net/hw/xsk.py, XSK_REMOTE_DEPLOY is only
checked once XSK_REMOTE_BIN is set:

    binary = cfg.env.get("XSK_REMOTE_BIN")
    if not binary:
        return cfg.remote.deploy(local_binary)
    if cfg.env.get("REMOTE_TYPE") != "ssh":
        raise KsftSkipEx("XSK_REMOTE_BIN requires the SSH remote backend")
    if cfg.env.get("XSK_REMOTE_DEPLOY", "1") == "0":

If only XSK_REMOTE_DEPLOY=0 is set, as this paragraph suggests, wouldn't
the DUT binary still be copied to the remote without any warning?

Also, XSK_REMOTE_BIN causes a skip for any remote that isn't SSH, and the
example config above sets it. The netns paragraph doesn't say to unset it.
If someone copies the example and switches REMOTE_TYPE to netns, wouldn't
every case be skipped with "XSK_REMOTE_BIN requires the SSH remote
backend"?

Could the README say that XSK_REMOTE_DEPLOY=0 needs XSK_REMOTE_BIN, and
that XSK_REMOTE_BIN only works with REMOTE_TYPE=ssh?

[ ... ]

> +With SSH, the DUT uses the SSH host name to connect to the remote control
> +listener.
> +``XSK_UDP_PORT`` changes the fixed test UDP port (default 42567). The remote
> +listens on all addresses for control.

[Severity: Low]
Is "listens on all addresses" accurate? test_xsk() in drivers/net/hw/xsk.py
starts the remote listener with:

    "-p", "0.0.0.0", "-P", str(control_port), *udp_args,

peer_open_tcp() in net/lib/xsk/xsk_peer.c resolves this through
getaddrinfo() with AF_UNSPEC. For "0.0.0.0" that returns only an AF_INET
wildcard, so the listener binds to IPv4 only.

With an SSH remote, _control_addr() makes the DUT connect to the host part
of REMOTE_ARGS. If REMOTE_ARGS names an IPv6 literal or a host with only
AAAA records, can the DUT reach the listener?

The remote still prints its listening line, so the case would time out or
fail rather than skip.

Should the README say the listener is IPv4 only, or should the listener
also bind an IPv6 wildcard?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114909.734364-1-maciej.fijalkowski%40intel.com
