Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406366;
	b=rWe9owb70/r0AjxP6oOZuN5uxgCOVOiTWlz+W0vb23FGS119e0m8kfaiCjkW3FubNHPh
	 P2GOXIGj6F4gPKTTklsX0XmWD/k3vFpd6rIcgSYGygJ0bAY4Vj4QOUW9MMDgl4MTzK950
	 vaktNuk8zn68NChH8NdojJNxr3rVXCtORBFcDbLfYpWSAL1xB+oTUWogrJ1lIO4j3eVDR
	 WHu5FJ9c33KWZzIMBYhIf6I/mqA3P1h519fgCT4TJnXv0uYKm/x+KkxCcpc2EZHzr2gVD
	 PfWO3Fi83OowBn6YLB6ZeZtITo140QrHZg306joZ5E9JlZ9isPTuJhs3IEfEsfa1yAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406366;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vegiDY49ZcYgORuJO1fhtRNIMkQaGPWJGKKu4gUfQQ0=;
	b=bnWsUPB24pjRvlri28mw3eOSn9JXcd4IXFY5q7kQuAIcyYTHoBfJTpYeIEnGPRx69hE9
	 kmH6zcuhHJzkOhW2ZIGALQPWrcoSzOqGtq2004AqsDUDosyW91N9ZblDmKduTvLnWAgqW
	 AW09mx73ySGY/0Op5LisDaflCIZv7jYgmvAziF6J2lNuoU28vb9TREroPl11jb8w7v+AF
	 w3BdVJwy4pPRs13iKjRPABtmICISKFnZPidbzbVy/nrGPHJ5g2LmYHKGEmvVCEyLViRYh
	 fTg1Miuccfr5ciXJnzvCZDRu6eWf04fxxVFgF74j8C00ysIU/qkFOq+dBDR/95sbQbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ld7KzfY2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4876606A327;
	Mon, 23 Nov 2026 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ld7KzfY2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B2E1F000D4;
	Mon, 23 Nov 2026 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406365;
	bh=vegiDY49ZcYgORuJO1fhtRNIMkQaGPWJGKKu4gUfQQ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ld7KzfY22dAo+OphJpVbhEbsc7tWwIDdOUc+e60ahqoz1ksrlIqsWr2WvtFloVTY9
	 EeSNO+QHhELGG7+swr0AcNRWT7lBzENDaNR+p9L7lu17jvIBN4Xoh2oSdWgN0Oe9QM
	 wafZExCnX4CvU6SVIujaAxbTZ6iku8+xkpYCmIHZSIAjIdUMRkyR4VVqEJwgHID8as
	 RBQbudNomNtMb996gLYhDtSOM+o4kYYJGzSXo2rA/zi6lOyuXRpU18bqQtg/uWB/d8
	 fU38daeySbI6l+C1cUQ/emGwck49pbrGPwThzi8o7SkSDFvz7mHu/NsvstgZ9GPiyn
	 9JWqynaDeGrjA==
Subject: Re: [PATCH net-next v2 06/11] bpf, tcx: Set tx_extra_headroom from a
 decl tag on egress programs
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, horms@kernel.org, dkeogh@amazon.com,
 hawk@kernel.org, daniel@iogearbox.net, dwmw2@infradead.org,
 dtatulea@nvidia.com, noren@nvidia.com, alasdair@mcwilliam.dev,
 willemdebruijn.kernel@gmail.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, magnus.karlsson@intel.com, dsahern@kernel.org,
 idosch@nvidia.com, ast@kernel.org, john.fastabend@gmail.com,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, corbet@lwn.net,
 skhan@linuxfoundation.org, shuah@kernel.org, rdunlap@infradead.org,
 leitao@debian.org, ast@fiberby.net, danieller@nvidia.com, kuniyu@google.com,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
 nh-open-source@amazon.com, stephen@networkplumber.org, gustavoars@kernel.org,
 one-d-wide@protonmail.com, ameryhung@gmail.com, andrii@kernel.org,
 aroulin@nvidia.com, anilkaushikwireless@gmail.com, demosthenes.ra@gmail.com,
 eddyz87@gmail.com, emil@etsalapatis.com, hangbin.liu@linux.dev,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev, jolsa@kernel.org,
 joe@dama.to, memxor@gmail.com, lirongqing@baidu.com, louis.scalbert@6wind.com,
 mkl@pengutronix.de, martin.lau@linux.dev, mkarsten@uwaterloo.ca,
 mattbobrowski@google.com, michael.bommarito@gmail.com, razor@blackwall.org,
 runyu.xiao@seu.edu.cn, song@kernel.org, linux@leemhuis.info,
 wang.zhan@smartx.com, yonghong.song@linux.dev, n0ps1edzz@gmail.com,
 tianyi.gao@linux.dev
Date: Mon, 23 Nov 2026 03:59:21 +0000
Message-ID: <179540636180.3135.12677199986882977729@kernel.org>
In-Reply-To: <20261119013830.36935-7-tianyi@cloudflare.com>
References: <20261119013830.36935-7-tianyi@cloudflare.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new documentation in Documentation/networking/netdevices.rst
  names only one load failure for the "tx_extra_headroom:" decl tag:…
- [Low] This patch adds tcx egress decl tags as a source of
  tx_extra_headroom.

--

bpf, tcx: Set tx_extra_headroom from a decl tag on egress programs

This patch lets a tcx egress program declare how many bytes of headers
it pushes, using a "tx_extra_headroom:" BTF decl tag on its main
function. The verifier parses the tag at load time into struct
bpf_prog_aux. The tags of all programs at tcx egress are summed into
dev->tx_extra_headroom whenever an egress program is attached, detached
or replaced.

> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index 53ca8439f73bd..128a93303a6d3 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -459,12 +459,27 @@ values:
>  
>  * ``XDP_PACKET_HEADROOM`` (256 bytes) minus ``needed_headroom``, when the
>    peer of a veth or netkit device has an XDP program
> +* the headroom that the programs at tcx egress of the device declare
>  
>  When the peer has an XDP program, locally generated UDP, raw and
>  AF_PACKET packets and AF_XDP packets in copy mode have enough headroom
>  for it. ``tx_extra_headroom`` is not recalculated when a bridge or
>  openvswitch changes ``needed_headroom`` later.
>  
> +A program at tcx egress declares its headroom with a BTF decl tag on its
> +main function. The value is a decimal number of bytes:
> +
> +.. code-block:: c
> +
> +  SEC("tcx/egress")
> +  __attribute__((btf_decl_tag("tx_extra_headroom:64")))
> +  int prog(struct __sk_buff *skb)
> +

[Severity: Low]
Should this paragraph say which packets actually get the declared
headroom?

The XDP paragraph above lists UDP, raw, AF_PACKET and AF_XDP copy mode.
The tcx paragraph does not limit the earlier statement at the top of the
section, which says tx_extra_headroom is extra headroom for locally
generated packets and that the stack adds it when it allocates such a
packet for the device.

The commit message makes a similar claim:

  A locally generated packet gets only LL_RESERVED_SPACE() of
  headroom, so bpf_skb_adjust_room() reallocates every such packet.

The only readers of dev->tx_extra_headroom are
netdev_get_alloc_headroom(), netdev_get_alloc_headroom_hlen() and
netdev_get_alloc_needed_headroom(). These are called from:

  __ip_append_data()
  raw_send_hdrinc()
  __ip6_append_data()
  rawv6_send_hdrinc()
  the AF_PACKET TX paths
  AF_XDP copy mode

TCP sizes its headroom with MAX_TCP_HEADER and never reads the value.

Say an encapsulating egress program carries "tx_extra_headroom:400".
TCP packets still get no extra reservation. bpf_skb_adjust_room() will
still reallocate them whenever MAX_TCP_HEADER leaves too little room.

TCP was left out on purpose in "net: add tx_extra_headroom and
netdev_get_alloc_headroom()". Could the tcx documentation, and the
commit message, state that scope?

> +The tag of the attached program covers the whole tail call chain. Tags on
> +tail call targets, freplace programs and programs at tcx ingress are
> +ignored. Loading a program whose tag is above 512 or does not parse fails
> +with ``-EINVAL``.

[Severity: Low]
Is this list of load failures complete? The loader also rejects a main
function with two "tx_extra_headroom:" decl tags, but the error is
-EEXIST, not -EINVAL.

btf_find_decl_tag_value() returns ERR_PTR(-EEXIST) for a duplicate:

kernel/bpf/btf.c:btf_find_decl_tag_value() {
    ...
	/* Prevent duplicate entries for same type */
	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, id);
	if (id >= 0)
		return ERR_PTR(-EEXIST);
    ...
}

bpf_find_tx_extra_headroom() returns that error unchanged:

	if (IS_ERR(value)) {
		if (PTR_ERR(value) == -ENOENT)
			return 0;
		verbose(env,
			"multiple tx_extra_headroom tags for main subprog\n");
		return PTR_ERR(value);
	}

The error goes back through add_subprogs(), so BPF_PROG_LOAD fails with
-EEXIST. The tag_twice selftest in verifier_tx_extra_headroom.c, later in
the series, expects this rejection. The documentation is still unchanged
at the end of the series.

Could the documentation also list the duplicate tag case and its error
code?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119013830.36935-1-tianyi%40cloudflare.com
