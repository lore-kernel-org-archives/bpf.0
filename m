Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76E337BAC;
	Tue, 23 Jun 2026 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185994; cv=none; b=JOLtR/AprX5ek0+Tp5SpWB61bly4RiQAFJEIxT6gcMA3wrAz9Mc2cI0kOLf4GJisTYg6pNqvIfyo6LzajhlhTqcYzbRJfSnpIQBnBBAYDxXVU7ERouRM7pbOtyDvJa5JusTxYrTU374NnjdDKQaiFEdH/Haxnk7PXHk6hdcJl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185994; c=relaxed/simple;
	bh=4rDFDSWIPN+GaR3KuHk5JKqQr8cXRoTADue0mfXb99k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cRX7XtPOJSnjyC0INsDFm48lwmlI3qP2qBXo9Y4aM+US4xh4wwvClEfTPhWr9T2r7MtztXyGe/8edwAVs4dEqK5vs/r3O8sU3QceLiu1c7OgWCJsn0B1InE4KztUCGX7DHc6hbgkj7x5WtB/j4QbN02mJMSOxWXc60t8FPHPQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE+cMsR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE+cMsR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5772A1F000E9;
	Tue, 23 Jun 2026 03:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185992;
	bh=X6sng07jg3BJFP9zD+bLGFxsbWYewF/i5x/VM+aUpb8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UE+cMsR12FbJmKUyPZnM2m//3XJEePFGV8KxLAOykD7wnKf8dJYTOcd5x7ekwJrcG
	 JsiR69tTYC2XNsCVGG9S2Ji1p4ZMk0mvmYDcDIzNJEayhxcMdl6INzlicl8sZvFCHN
	 hKSOjCx0xAo3q2RO9OzQuyYcPcFyWBnS+rBlQ8vcMIXVhmGHXhHSvkAkU0i06R/hTc
	 r9PuxGx1/GxC6qo4L5MYP2/ol/0Y3vbzBSa96ZSk619fK+BuX8FpnztMNKsxsgDvk8
	 hNJVABPkZ9bxvMC/i0r+pI83beTeXJHgA/vwzosc6xTV5ZqKPYNrOwUgBfwFNYMfWA
	 PffxLPuEjZkHQ==
Content-Type: multipart/mixed; boundary="===============6750014670296811348=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d7ccd7fa70ea8bf65dfbe87cd55c796c40088e4b2cb8dd690ad9a8681385168@mail.kernel.org>
In-Reply-To: <20260623025147.1001664-4-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-4-avinash.duduskar@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
From: bot+bpf-ci@kernel.org
To: avinash.duduskar@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,hawk@kernel.org,yatsenko@meta.com,leon.hwang@linux.dev,kpsingh@kernel.org,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,eyal.birger@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,toke@redhat.com,dsahern@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 03:39:52 +0000 (UTC)

--===============6750014670296811348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
>
>     Cover both directions of the new VLAN flags in the fib_lookup test,
>     38 table cases plus dedicated cross-netns and XDP-redirect subtests.
>
>     For BPF_FIB_LOOKUP_VLAN the egress cases assert: without the flag the
>     lookup returns the VLAN netdev's ifindex and zeroed vlan fields, with
>     the flag it returns the parent's ifindex plus the tag (including via
>     a neighbour resolved on the VLAN device, in OUTPUT mode, over a bond,
>     and through a DIRECT|TBID table), with the flag on a non-VLAN egress
>     it changes nothing, for a stacked VLAN (QinQ) it returns
>     BPF_FIB_LKUP_RET_VLAN_FAILURE with params->ifindex left at the input, a
>     lookup without the flag returns the inner VLAN device's ifindex, and
>     a frag-needed return reports the route mtu in mtu_result while leaving
>     the swap unwritten.
>
>     The VLAN_FAILURE arms are IPv4. bpf_ipv6_fib_lookup() restores
>     params->ifindex with the same save/restore the IPv4 arms exercise, so an
>     IPv6 VLAN_FAILURE arm would only re-test shared code.
>
>     For BPF_FIB_LOOKUP_VLAN_INPUT, an iif rule on the subinterface routes
>     the same destination to a different gateway, so the asserted gateway
>     shows which device the lookup used as ingress: without the flag the
>     main table answers, with a matching tag the subinterface's table
>     does, with or without SKIP_NEIGH, and BPF_FIB_LOOKUP_SRC selects the
>     subinterface's address. A VRF-enslaved subinterface selects the VRF
>     table through the l3mdev rule and, with DIRECT, through
>     l3mdev_fib_table_rcu(). One case sets BPF_FIB_LOOKUP_VLAN as well and
>     asserts both directions work in a single lookup. Resolution semantics
>     are pinned: an 802.1ad tag resolves its device, PCP and DEI bits in
>     h_vlan_TCI are ignored, a VLAN ifindex resolves the inner QinQ
>     device, a tag on a bond master resolves while the same tag on the
>     bond port does not.
>
>     The error cases assert -EINVAL for an invalid h_vlan_proto on both
>     address families, for the TBID and OUTPUT flag combinations and for
>     an unknown flag bit, and BPF_FIB_LKUP_RET_NOT_FWDED for a VID with no
>     configured device on both families, for a VID-0 priority tag and for
>     a device that exists but is down. The failure cases also assert that
>     params is left untouched. By contrast, a no-neighbour case whose
>     input and egress devices differ asserts NO_NEIGH reports the egress
>     ifindex, not the input: only VLAN_FAILURE rewinds params->ifindex to
>     the input.
>
>     A separate subtest moves a VLAN device into a second netns while it
>     stays registered on its parent, and checks both directions refuse to
>     cross the boundary: the input flag fails closed with the tag and
>     ifindex untouched, and the egress flag returns
>     BPF_FIB_LKUP_RET_VLAN_FAILURE without publishing the foreign parent's
>     ifindex.
>
>     The tbid read-back check is skipped for DIRECT cases that set
>     BPF_FIB_LOOKUP_VLAN, since a successful swap packs the vlan fields
>     into the union the check reads.
>
>     Re-run the cases through bpf_xdp_fib_lookup() as well: the egress flag
>     exists because VLAN devices have no XDP xmit, so XDP is the primary
>     consumer. bpf_prog_test_run uses the netns' loopback for the xdp context's
>     device, so the lookup runs against the test netns' FIB, and the
>     path-independent results (return code, swapped ifindex, vlan tag, gateway)
>     are asserted to match the skb path.
>
>     A live-frames subtest (test_fib_lookup_vlan_redirect) drives real
>     frames through the XDP redirect path with BPF_F_TEST_XDP_LIVE_FRAMES, the
>     native xdp_do_redirect() plus xdp_do_flush() path. A reducible VLAN
>     egress is redirected to the physical parent and delivered to its peer;
>     a QinQ egress returns VLAN_FAILURE and is passed to the stack, since
>     redirecting to the VLAN device would drop the frame at xdp_do_flush()
>     (no ndo_xdp_xmit). The redirect program distinguishes SUCCESS from not;
>     the table and netns arms pin the exact VLAN_FAILURE value.

This isn't a bug, but could the changelog be tightened?

The description runs roughly seven paragraphs that walk through what each
group of test arms asserts: the egress arms with and without the flag,
the input arms and VRF table selection, the error arms and their failure
modes, the netns subtest boundary checks, and the XDP redirect subtest
behaviour.

Much of it carries rationale, so this is a soft observation, but someone
wanting to understand the per-case behaviour can read it more quickly from
the test table itself. Could the summary focus on the why (the two new
flags and the invariants worth pinning) and lean on the test table for the
per-arm specifics?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27999579457
--===============6750014670296811348==--
