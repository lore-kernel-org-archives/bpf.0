Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441469;
	b=2ZqLS31LxpJAOdRtlEObagYp0qHw67HHqUqwCglIEcmzjhuLIhYMOsJIstuVAZCmPrIg
	 cNefFKribJLsWkQJ79wHZQdNY039JzaE6D+Eonav7VvC5FNCMpCOYcyj2T6MDdT0O5ndI
	 N4gTOGWIHmuDe5S2Uj4534+pcvCPc5kGlMTOYaXQn1tKJuq2+CsyP3EYkdBomlBVLpA3L
	 sAVqG0LmQrZP9elQ606WqLQ3/ZMjbLwQgmVv5GzPCjvHtkV/pjDEHKwmr/xrncDTA0Y+w
	 fwtEcrB37rx2alwcEOMoWZsdFKKdUPHYyMIyW3SdmnFGkSpRSJdr+UtJdpc9Lo2X5Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441469;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A+YiHUTki4bDGGgRmQeDt9PjYtsBOdN0VCnv6q2ut8Q=;
	b=4VWF9aaYHEV94yS0eeXkcLfYHc4w5+sjwtx1Hvc5LvpYIjBfv86D9ntqVvA+UUlN5WVP
	 quWi8sVnCYiSDhx3XE70WAlcdSxoHw9ryH0ttfT9t4gAG8qq8k+nmEIZ3+Vqif5LTEP+n
	 BqMuCeoifhmAoIEW7X+7lzad5Zml96J5XI2td3kb0P60b7sg1yTXsRHeTS3g+MM4dK7tO
	 b6ozWRSa5McVKRPxe4rhr80iNRf5wUCsqOiF8K6pW9vSByZ6U3HPcLcJNmdPoYNvF/99z
	 yPxxUKuhyII1R7iV+q1KkAH5/dj1lNyVTqYYl+4KfLdA706BOtVoR04r0X5ngf0o3iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pk0hb0L8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A1606A327;
	Wed, 11 Nov 2026 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pk0hb0L8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7101F00A06;
	Wed, 11 Nov 2026 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441469;
	bh=A+YiHUTki4bDGGgRmQeDt9PjYtsBOdN0VCnv6q2ut8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pk0hb0L84zPQELS2w9R5RPHIh9EwBrM+Hx76RRIpdPa6ZgXB+hu+Sj2YQc/4puXEL
	 2L2XInLgaArawzUI1NloSbc6qPcQ81M6WBy8uqsZLa39QufxDyDpgAhxrXidCB9uVj
	 kq5Q+KxOJZ6kWgVK8JSCm4DqPckL/yDLo4RdSo1sK8onLbWTzZ+Mdc8Nkd+iTY3mpd
	 lsYEqmz76UWQTTB0zBSBgKlV5kUYaBPbOh2DuHNPyBiShJLhmrjz8nM0cv2TqX53hO
	 +YeGl6Xyi191npQZryCI9kd4gnIYM5jJX1iOl8I5BprH1NWPfpR34UUmDLiiKHjSMf
	 yNH1y0K9smLXA==
Date: Wed, 11 Nov 2026 15:57:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 pabeni@redhat.com, tushar.vyavahare@intel.com, kerneljasonxing@gmail.com,
 bjorn@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/4] selftests: move the AF_XDP test suite
 from bpf to net
Message-ID: <20261111155748.11b92b7b@kernel.org>
In-Reply-To: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 20:30:44 +0100 Maciej Fijalkowski wrote:
> As the maintainers asked, this series is the first step of moving the
> AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
> builds from its new location, without changing what the tests do. The
> rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
> net" (v4) will follow on top of this move.

Close enough, but why did you skip CCing bpf@ :(

BPF folks, I made a tag for both of us to merge / pull to avoid
Makefile conflicts in selftests, the original series is here:
https://lore.kernel.org/all/20261109193048.1006986-1-maciej.fijalkowski@intel.com/
PR text follows. Please LMK if / how you'd like to proceed.

The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/bpf-net-xsk-move

for you to fetch changes up to d01fb5c8113055e3d1b7f573261ae6a30abf4e53:

  selftests: net: move xdp_hw_metadata from selftests/bpf (2026-11-11 15:50:02 -0800)

----------------------------------------------------------------
Maciej says:

As the maintainers asked, this series is the first step of moving the
AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
builds from its new location, without changing what the tests do. The
rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
net" (v4) will follow on top of this move.

Patch 1 drops the test_progs wrapper of the AF_XDP tests, patch 2 adds a
generic BPF skeleton rule to net/bpf.mk, patch 3 moves xskxceiver, its
library and test_xsk.sh to selftests/net, and patch 4 (new, not covered
at [0]) moves xdp_hw_metadata, which is built from the same library.

The xdp_metadata test stays in test_progs: it covers BPF core
behaviour, and moving it would mean rewriting it for the kselftest
harness. It keeps using xsk.c from net/lib/xsk.

xskxceiver and xdp_hw_metadata are the first users of bpftool at build
time in selftests/net. NIPA has bpftool, but 0-day and KernelCI build
net without it, so both tools are skipped with a warning when bpftool
is missing or does not run.

test_xsk.sh is installed but not run by run_tests, so NIPA does not pick
it up: it runs every case, including flaky ones, and some cases leak
page_pool pages after skb_pp_cow_data() in generic XDP mode on
veth-based runs. Until a later step makes the suite fit for NIPA, no CI
runs the AF_XDP tests. test_xsk.sh is being removed by [0] but it is
kept here as there is no other feasible way to run the test suite (if
needed) until we come up with an upstreamable Python runner.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Maciej Fijalkowski (4):
      selftests/bpf: drop the test_progs AF_XDP wrapper
      selftests: net: add a generic rule for BPF skeletons
      selftests: xsk: move the AF_XDP test suite to selftests/net
      selftests: net: move xdp_hw_metadata from selftests/bpf

 Documentation/networking/af_xdp.rst                |   6 +-
 Documentation/networking/xsk-tx-metadata.rst       |   2 +-
 MAINTAINERS                                        |   4 +-
 tools/testing/selftests/bpf/.gitignore             |   2 -
 tools/testing/selftests/bpf/Makefile               |  29 +---
 tools/testing/selftests/bpf/Makefile.buildvars     |   6 +-
 tools/testing/selftests/bpf/network_helpers.c      |  48 ------
 tools/testing/selftests/bpf/network_helpers.h      |   2 -
 tools/testing/selftests/bpf/prog_tests/xsk.c       | 170 ---------------------
 tools/testing/selftests/net/.gitignore             |   2 +
 tools/testing/selftests/net/Makefile               |  22 +++
 tools/testing/selftests/net/bpf.mk                 |  13 +-
 tools/testing/selftests/net/config                 |   1 +
 tools/testing/selftests/net/lib/.gitignore         |   2 +
 tools/testing/selftests/net/lib/Makefile           |  25 +++
 .../{bpf/prog_tests => net/lib/xsk}/test_xsk.c     |   2 +-
 .../{bpf/prog_tests => net/lib/xsk}/test_xsk.h     |   5 +-
 tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c |  49 +++++-
 tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h |   4 +
 .../{bpf => net/lib/xsk}/xsk_xdp_common.h          |   0
 .../lib/xsk/xsk_xdp_progs.bpf.c}                   |   2 +-
 .../selftests/{bpf => net/lib/xsk}/xskxceiver.c    |  17 +--
 .../selftests/{bpf => net/lib/xsk}/xskxceiver.h    |   0
 tools/testing/selftests/{bpf => net}/test_xsk.sh   |   5 +
 .../xdp_hw_metadata.bpf.c}                         |  35 +++--
 .../selftests/{bpf => net}/xdp_hw_metadata.c       |  81 +++++++++-
 tools/testing/selftests/net/xdp_metadata.h         |  67 ++++++++
 .../testing/selftests/{bpf => net}/xsk_prereqs.sh  |   2 +-
 28 files changed, 309 insertions(+), 294 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.c (99%)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.h (99%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c (95%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h (97%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk_xdp_common.h (100%)
 rename tools/testing/selftests/{bpf/progs/xsk_xdp_progs.c => net/lib/xsk/xsk_xdp_progs.bpf.c} (98%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.c (96%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.h (100%)
 rename tools/testing/selftests/{bpf => net}/test_xsk.sh (98%)
 rename tools/testing/selftests/{bpf/progs/xdp_hw_metadata.c => net/xdp_hw_metadata.bpf.c} (75%)
 rename tools/testing/selftests/{bpf => net}/xdp_hw_metadata.c (92%)
 create mode 100644 tools/testing/selftests/net/xdp_metadata.h
 rename tools/testing/selftests/{bpf => net}/xsk_prereqs.sh (98%)
