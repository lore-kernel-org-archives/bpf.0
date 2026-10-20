Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524624;
	b=biuiF1V/LJ4y0S/Tlz7PKIK+2YCylHjFvcxmgPWqVeSJ3ngh7dvZZP3O9gk1A5piciQK
	 C68xwNii6PFiWNdEBWKURgEZuiwo7il1QsMbUtvebHgIawkK8reapsVQ8xO7J4uF/W+U6
	 6yEG8kM7DLXa+dp42ztIo/7BztuZevXEO/cWZpE8uiDwEd3S8eGUJRhzaB/+y+llqjKxe
	 SqLHPggy9llCv6DmJu7eS51XICbT5m9ITxAIgCnyoHtu44wpOhKWaaXjci/xjCfswOp54
	 BBacdXixbMIvVApslrs6g/M739xjNqBMGiVA6MVYgxzFjLqOFK2PoygzJVg8zBwqIMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524624;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2LYIs8aFRzc8aCCkLtrsuAXgCJ+0neQAn2pAIkJK0dU=;
	b=hZczzsAYVJn9jiPOOu1VrtnnEd4Shyu5QYbsfuZ7niw0lFJCcUwwqEJso3dbiMdlVoQ9
	 lbIWpW4Ehwtvf0f8MwYUp+0yQOOOpRnlLBINHe2jynTb94IRUWGaEzKRsLDHyFFYge8nD
	 TR1PS15Da2f98jqLua0dfAZy9xtRYofaLy1SPywIOyEXdlg54D7wLlN5TQO4zlRykQzyU
	 SenE+bzOgYwOcQf2FyOWX1dVKIXUrl/0PDH5atvhfVv/ysvCgWn/NvE6wSHF3+ifUGgHk
	 GR9doQopHcMtoACjSv3PVMtjYzA5VtK7oqYx3fThIVeiAH41qoRVjzzJMLYniX63AQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNeIl6Lq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40F606A31F;
	Tue, 20 Oct 2026 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNeIl6Lq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B21F000CD;
	Tue, 20 Oct 2026 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524624;
	bh=2LYIs8aFRzc8aCCkLtrsuAXgCJ+0neQAn2pAIkJK0dU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NNeIl6LqqtnHLej8cyJoytG/dYprnqoVr1tlqK1G2aNgHV2Kou2ZR6NSGgHCAXW4S
	 1tApnrKp1BWpky612yIDouXWES8eflVF761LpVRB++MxwLDjK1sk4nmWDy+dh4KlPl
	 aKADT/lmCPMiQUjPDq6P18/x7WMc54cMeLNEnl9RRSi1EV1asyzn97tPGvCqiJYkxa
	 tjg+woGAy2FeXRtbP/pcy1l+/5h6VkWk1Zg2OUFZ+mJnd2lGRynX6G5IB39SvHaRBR
	 AbFMn8+Ydk+VRDGACAAAn5dABpQLkPrw67AsMo/uVOpCT/dPwuFfm3ZS/dWHNC+HsM
	 ToHhpNrKh10Wg==
Subject: Re: [PATCH v4 net-next 06/15] selftests: xsk: move the AF_XDP test
 suite to selftests/net
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:22 +0000
Message-ID: <179252462291.3135.9171929520806354921@kernel.org>
In-Reply-To: <20261016174338.787135-7-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-7-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch moves get_hw_ring_size() out of
  tools/testing/selftests/bpf/network_helpers.c and appends it to…
- [Medium] The new $(XSK_BPF_OBJ) rule in
  tools/testing/selftests/net/lib/Makefile compiles xsk_xdp_progs.bpf.c…

Pre-existing issues:
- [Low] At this commit, test_exit() in
  tools/testing/selftests/net/xsk_prereqs.sh ends with an unconditional…

--

selftests: xsk: move the AF_XDP test suite to selftests/net

This commit moves xskxceiver, the AF_XDP library, the test definitions
and the XDP program from selftests/bpf to selftests/net/lib/xsk. It also
moves test_xsk.sh and xsk_prereqs.sh to selftests/net, and net/lib now
builds xskxceiver and its skeleton when a working bpftool is available.
The ethtool ring helper get_hw_ring_size() moves from network_helpers.c
into xsk.c.

> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> index ff83603397d06..c26088da04892 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile

[ ... ]

> @@ -23,3 +33,28 @@ TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
>  include ../../lib.mk
>  
>  include ../bpf.mk
> +
> +# AF_XDP test engine used by net/test_xsk.sh.
> +XSK_DIR := xsk
> +XSK_BPF_OBJ := $(OUTPUT)/xsk_xdp_progs.bpf.o
> +XSK_SKEL := $(OUTPUT)/xsk_xdp_progs.skel.h

[ ... ]

> +$(XSK_BPF_OBJ): $(XSK_DIR)/xsk_xdp_progs.bpf.c $(XSK_DIR)/xsk_xdp_common.h $(BPFOBJ)
> +	$(call msg,BPF_PROG,,$@)
> +	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
> +		-Wno-compare-distinct-pointer-types -c $< -o $@

[Severity: Medium]
Could this produce a BPF object with the wrong byte order when
cross-compiling for a big-endian target?

Plain --target=bpf uses the build host's byte order. xskxceiver itself
is built with $(CC), and lib.mk sets that to $(CROSS_COMPILE)gcc. So a
build for s390x on an x86_64 host would put a little-endian object into
the skeleton of a big-endian xskxceiver.

On the target, xsk_xdp_progs__open_and_load() would then fail in
bpf_object_load():

tools/lib/bpf/libbpf.c:bpf_object_load() {
    ...
	} else if (!is_native_endianness(obj)) {
		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
	}
    ...
}

The bpf selftests Makefile, which built this program before the move,
picks the target based on $(CC):

BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)

The existing rule in net/bpf.mk also uses plain --target=bpf. Should
the new rule pick bpfel or bpfeb the same way the bpf selftests do?

> +
> +$(OUTPUT)/xskxceiver: $(XSK_SOURCES) $(XSK_HEADERS) $(XSK_SKEL) $(BPFOBJ)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
> similarity index 97%
> rename from tools/testing/selftests/bpf/xsk.c
> rename to tools/testing/selftests/net/lib/xsk/xsk.c
> index 25d568abf0f20..660540efc46e0 100644
> --- a/tools/testing/selftests/bpf/xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/xsk.c

[ ... ]

> @@ -779,3 +778,27 @@ void xsk_socket__delete(struct xsk_socket *xsk)
>  		close(xsk->fd);
>  	free(xsk);
>  }
> +
> +int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)

[Severity: Medium]
Can this function move into xsk.c without its license being addressed?

get_hw_ring_size() comes from tools/testing/selftests/bpf/network_helpers.c,
which carries:

// SPDX-License-Identifier: GPL-2.0-only

xsk.c carries:

// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

The function was contributed as GPL-2.0-only in commit 90a695c3d31e1c
(Tushar Vyavahare). After this move, the xsk.c file tag offers it under
LGPL-2.1 or BSD-2-Clause. Neither the SPDX header nor the function gets
a license note.

The commit message only says:

  "Move the ethtool ring helper from network_helpers into xsk.c"

It does not mention a relicense or carry an ack from the original
author. Could the relicense be acked explicitly, or could the helper
live in a GPL-2.0 file such as test_xsk.c instead?

> +{
> +	struct ifreq ifr = {0};
> +	int sockfd, err;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/net/test_xsk.sh
> similarity index 98%
> rename from tools/testing/selftests/bpf/test_xsk.sh
> rename to tools/testing/selftests/net/test_xsk.sh
> index 69fac65f073c5..fbf4551d596a4 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/net/test_xsk.sh
> @@ -97,6 +97,11 @@ do
>  	esac
>  done
>  
> +if [ ! -x "./${XSKOBJ}" ]; then
> +	echo "xskxceiver was not built; skipping"
> +	exit $ksft_skip
> +fi
> +

[Severity: Low]
This isn't a bug introduced by this patch, but the new check exits with
$ksft_skip, while the other skip paths go through test_exit() in
xsk_prereqs.sh, and that always exits 1:

tools/testing/selftests/net/xsk_prereqs.sh:test_exit() {
	if [ $1 -ne 0 ]; then
		test_status $1 $(basename $0)
	fi
	exit 1
}

validate_veth_support() and validate_ip_utility() both call
"test_exit $ksft_skip". So when veth support or the ip utility is
missing, the result is a failure rather than a skip.

Later in the series, "selftests: xsk: run one test case per xskxceiver
invocation" replaces test_xsk.sh and xsk_prereqs.sh with test_xsk.py,
which skips with exit code 4. By the end of the series this is gone.

Should test_exit() pass its argument to exit for the commits in
between?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
