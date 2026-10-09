Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68849AA3D;
	Fri,  9 Oct 2026 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536837; cv=none; b=n/UTXrqRjK2o3nyUSelHCfLQDVymprtNCS3ntZWGyX0Gw3YanrYg/leQxv4YQsB6z+6ESPUPbmeMr+1uqSBwRuvbf2R/VTUA5GFAOVvx13Z6MjFi8DBSi33btisCe3C63+wIvKjkQVQdY2s9fC9WtpHAFDXODgGoX0dqcp7o++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536837; c=relaxed/simple;
	bh=M4yQQp2c4hqBfuD4lPz28Or5PCvY5ToidFbuqMdBTgo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TqbYMIovn85s0WfqCKWcvSX67KkECiViP6di5BzCiMuOCSMZkn0mii/5Kexu+cGqD1PaHkN1juKBP9G9ygPxodudQjJ9MqpD1i9r3zWZGqKh9NHkqchKJjsGzho8RFWPvFysuTg4v9T+BIjtX4/PJ3gS5XsL/f6DONdkTv4nE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z15tYIFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z15tYIFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3449C1F00899;
	Fri,  9 Oct 2026 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791536823;
	bh=1vjgACArY1cpH1//1yksYo85oD0arQPVKFNjR+zxkNA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z15tYIFEWrB2xTfPlWnqDP1pE9AKf9p6LR90SbaQ5UNFX6f0DixPw/B+1M7W3aU3p
	 5t+22jUhGItBDb2bO4lpdIgHDFigOpnS9wdiKh5w9jRf141uvMae1IHbkh9KMNVBiG
	 XjZRFAcZFSumSoMNl+GwvgNkYLPrBDA9DTKL7OORxHWWYBTzR2hzM/QRnsjZg2DuTD
	 bBP+AHfbw6x3+o0RGi+X4v4RbJS5pdSGtBzlfuw4HlzJrYKUFHvHkGu5+IFnLyCzSJ
	 xHXgi2AE3+cOvPH4Jnk5wUfDiBzD8geSiF0i4X5x3QLEaskB8WVj4kL6YsFZKg4BTP
	 7l/rD0dZyjt8A==
Subject: Re: [PATCH net-next v4 6/6] netlink: specs: rt-route: describe
 seg6-local attrs
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 edumazet@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Fri, 09 Oct 2026 09:07:02 +0000
Message-ID: <179153682273.434549.16560900955866234642@kernel.org>
In-Reply-To: <20261008-ynl_rt_encap-v4-6-4ed2ccf7f949@kylinos.cn>
References: <20261008-ynl_rt_encap-v4-6-4ed2ccf7f949@kylinos.cn>
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

- [Low] The patch adds the `seg6-local-flv-ops` enum to
  Documentation/netlink/specs/rt-route.yaml with `unspec` as its first…

--

netlink: specs: rt-route: describe seg6-local attrs

This commit adds two enums to the rt-route spec: the SEG6 local actions and
the seg6-local flavor operations. It also changes the bpf, counters and
flavors attributes in seg6-local from binary to nested attribute sets
(seg6-local-bpf, seg6-local-cnt and seg6-local-flv).

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 82e59af56ecdb..48d1659f20f34 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -116,6 +116,45 @@ definitions:

[ ... ]

> +  -
> +    name: seg6-local-flv-ops
> +    type: enum
> +    name-prefix: seg6-local-flv-op-
> +    enum-name:
> +    entries:
> +      -
> +        name: unspec
> +      -
> +        name: psp
> +      -
> +        name: usp
> +      -
> +        name: usd
> +      -
> +        name: next-csid

[ ... ]

> @@ -618,6 +661,50 @@ attribute-sets:

[ ... ]

> +  -
> +    name: seg6-local-flv
> +    name-prefix: seg6-local-flv-
> +    attributes:
> +      -
> +        name: operation
> +        type: u32
> +        enum: seg6-local-flv-ops
> +        enum-as-flags: true

[Severity: Low]
With enum-as-flags set, should unspec still be the first entry of
seg6-local-flv-ops?

YNL turns each entry's value into a bit position in this mode:

tools/net/ynl/pyynl/lib/nlspec.py:EnumEntry.user_value() {
        if self.enum_set['type'] == 'flags' or as_flags:
            return 1 << self.value
}

The flag values come out as unspec=0x1, psp=0x2, usp=0x4, usd=0x8 and
next-csid=0x10.

The psp through next-csid bits line up with the kernel's
SEG6_F_LOCAL_FLV_OP(flvname), which is BIT(SEG6_LOCAL_FLV_OP_##flvname). Bit
0 (UNSPEC), however, is not a real flavor operation. The supported masks in
net/ipv6/seg6_local.c contain only NEXT_CSID and PSP:

#define SEG6_LOCAL_END_FLV_SUPP_OPS	(SEG6_F_LOCAL_FLV_NEXT_CSID | \
					 SEG6_LOCAL_FLV8986_SUPP_OPS)
#define SEG6_LOCAL_END_X_FLV_SUPP_OPS	SEG6_F_LOCAL_FLV_NEXT_CSID

parse_nla_flavors() rejects every bit outside these masks:

	if (rc < 0 || (fops & ~supp_fops)) {
		NL_SET_ERR_MSG(extack, "Unsupported Flavor operation(s)");
		return -EOPNOTSUPP;
	}

As a result, the spec offers an "unspec" flag that the kernel never reports
in a dump. When it is sent in a request, the kernel always rejects it with
-EOPNOTSUPP.

devlink.yaml's reload-action enum is also used with enum-as-flags, and it
handles this by leaving out unspec and setting value: 1 on its first entry.
Could this spec do the same? Dropping unspec and giving psp value: 1 would
keep every real bit in place.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-ynl_rt_encap-v4-0-4ed2ccf7f949%40kylinos.cn
