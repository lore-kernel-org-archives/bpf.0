Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822683939B9;
	Thu, 17 Sep 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613162; cv=none; b=lxfefCsbuddx9VE8ilOQ9TSi+0gqFxxJSTIjwpX1rQYuJAuqQVuUohRISq74wUEoVWqETkp8OqDVpOOPNFWmshLVxShQEvYRGcdYNej8+SDofwdsBcBEY/nLwRuZc7RcUT/lwi2IDIETha7RF5Cl2PE3jbEpvqw7R1c8pfG+N5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613162; c=relaxed/simple;
	bh=k8mdepo+LHmJaUPQ7ITaM42/OK/sEwnG8bbAD1/kL40=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DzFhoN5a+OVogf8eOpjqi9+Ht5ljUDtdmTYq2uTZH6Lvm6+tuwVxQmEGlgVriRkGZX3I1sUFWek1KjQXQNt5PVJ1XGaVfoneLbf0WzuPK962kCZnB0d3TVwbTL2eyJEKN60FIDX0Yb6POolNrS0CSEwQf8JxD7f357U+pblp6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJFGmPdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJFGmPdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B0E1F000FF;
	Thu, 17 Sep 2026 02:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613147;
	bh=O7Pked6faZaXAmPzx8lccuWK2wBmLZscq9kB5V+HbGQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nJFGmPdMYn0MpXF/osDB+ufPLYABlheD+J1zjJfrJjLg+hDMq6aZc0inMpXGStj8q
	 9ktKThytUySYKmYFC5lCU4PGfZ9pMpj5IBDw5jg0yidIle7h3PvujlV1uHsN7YH+PV
	 JAYp91+Wo69DDTp980/y3zeecmvwe9mIIgag+6c6JIMYAT30KD11kGzkic2+Iyz/hc
	 ZBRP3oo1GjkHEQr+q6uVhAo72D0NXvwiJ8E1JmeTxf+VXV+rItQMR5/wAQvK+LtJie
	 ptBD6YO9F1S+oIHUe1qDkxN0dgY2Nh82FiBDoNP5/dktRtGDgwJnvD9b1hLlvCLVVd
	 NeR/eQZjhZrCQ==
Content-Type: multipart/mixed; boundary="===============1014664889274575926=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3111203b94441ef41565b0b9523a33db24a52fd66b8d309030cd1cfd4c595a12@mail.kernel.org>
In-Reply-To: <20260917015605.2464043-1-eva.kurchatova@virtuozzo.com>
References: <20260917015605.2464043-1-eva.kurchatova@virtuozzo.com>
Subject: Re: [PATCH 1/2] selftests: bpf: run test_xdp_features in its own netns
From: bot+bpf-ci@kernel.org
To: eva.kurchatova@virtuozzo.com,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,eva.kurchatova@virtuozzo.com,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 02:45:46 +0000 (UTC)

--===============1014664889274575926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
> index 0aa71c4455c0..1f6be4af6718 100755
> --- a/tools/testing/selftests/bpf/test_xdp_features.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_features.sh
> @@ -1,6 +1,19 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>
> +# The device under test listens on the veth address of the namespace this
> +# script runs in and the tester connects to it, so a firewall on the
> +# machine can refuse the control connection:
> +#   Failed connecting to the Device Under Test control socket
> +# That side of the pair is also always called v1, and cleanup only runs
> +# on a signal, so a failed run leaves the device behind and every later
> +# run stops in setup.  A namespace of our own has no such rules, and
> +# takes the leftovers with it when the test ends.
> +if [ -z "${XDP_FEATURES_NETNS:-}" ]; then
> +	XDP_FEATURES_NETNS=1 export XDP_FEATURES_NETNS
> +	exec unshare -n sh -c 'ip link set lo up; exec "$0" "$@"' "$0" "$@"
> +fi

The comment and commit message both state "everything the test made goes
away with the namespace when it exits", but does the anonymous namespace
actually reclaim the persistent named namespace created by ip netns add?

unshare -n only unshares CLONE_NEWNET. The mount namespace remains the
host's, so when setup() later runs:

    ip netns add ${NS}
    ip link add v1 type veth peer name v0 netns ${NS}

ip netns add deliberately creates a persistent namespace by bind-mounting
/proc/self/ns/net onto /run/netns/${NS}. That bind mount is visible on
the host and pins ${NS} with the v0 veth inside it.

Exiting the anonymous netns from unshare -n doesn't remove the named
netns -- that's why cleanup() must explicitly call ip netns del ${NS}.

cleanup() is still only reachable from the signal trap or the fully
successful path. All failure arms are [ $? -ne 0 ] && exit, and there is
no trap cleanup EXIT. On a failing run after the patch:

  - v1 and the anonymous netns: reclaimed
  - /run/netns/ns1-XXXXXX and the netns holding v0: leaked on the host

The practical breakage described in the changelog (name collision
causing later runs to fail in setup) is fixed because ${NS} is
randomised.

But the claim of complete cleanup is not accurate. Should this either
narrow the claim to the device and firewall rules, or make cleanup
complete with trap cleanup EXIT (in addition to the signal trap), or use
unshare -n -m with a private /run/netns so the named namespace really
does die with the test?

> +if [ -z "${XDP_FEATURES_NETNS:-}" ]; then
> +	XDP_FEATURES_NETNS=1 export XDP_FEATURES_NETNS
> +	exec unshare -n sh -c 'ip link set lo up; exec "$0" "$@"' "$0" "$@"
> +fi

A subsystem pattern flags this as potentially concerning: the new code
hand-rolls network-namespace setup (re-exec under unshare -n plus
ip link set lo up) in a script that already hand-rolls ip netns add,
ip link del, and ip netns del.

tools/testing/selftests/net/lib.sh already provides this: setup_ns
generates a randomised namespace name, creates it, brings lo up and
normalises rp_filter; cleanup_ns and cleanup_all_ns tear the list down
and register teardown to run on normal exit as well as on a signal,
which is the gap the patch's changelog identifies.

Worth a maintainer's call on whether the shared helpers should be used
here instead of a second implementation.

The alternative view is that this may be defensible: bpf selftests do
not currently source tools/testing/selftests/net/lib.sh (no bpf/*.sh
does), pulling it in would add a TEST_FILES dependency, and setup_ns is
not a drop-in substitute for what this hunk does. setup_ns creates a
named peer namespace, whereas the hunk moves the script's own process
into an anonymous namespace so the DUT-side v1 device and the host
firewall rules stop mattering. The parts net/lib.sh would genuinely
replace are the pre-existing ip netns add and cleanup lines, not the new
ones.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35173519344
--===============1014664889274575926==--
