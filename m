Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EDA377AA1;
	Mon, 21 Sep 2026 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972701; cv=none; b=RuG0UGORsRAtVB45RAlzBd7nKxqiTu1t9qi4gLX7wV9NXb+eo8I8gZ5bTR8vWWP7alMFx1c4cKMv5jz6LUq4MU7BxkIX1/9dgWfM0mcyFxFBiGE1G8U1zyBscAaXCbLd8s7GJKUu/hxvq1pteB1QFVzYZpoTs6iv3GGn5BRjJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972701; c=relaxed/simple;
	bh=av7b8k4TaDZ78d2UuXsX8d+SrVCoNudj09wDyVqYdCo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iryWw7qoU8kg6JuBkaDWc8NRy5bWw14EGs8NB5zNUxNysQnQJzpg5arhO3dGWUkpx+sF3Pq0dGqa4e93grBzTZmaUPDFKdOSL5DeD2jyZFkH8gGZ9YFeDFD8CCNJYjidcAtvuJ5Wwf3eYBc5Cs7dJfsAnjTAOj7Ikpla6BlpTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMoV12BC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMoV12BC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC0C1F00893;
	Mon, 21 Sep 2026 06:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972699;
	bh=Y4jE66NJS02PB9RnKwqWmkL3qkxjOW4XR7o+CYDXN5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HMoV12BCIjFyf0D04FW2dy8S/bYJcqK9PWFoqlwbvhjk8gJZQ1zy2bU2C85Nn5fKO
	 E9AuKQ4n7S8N7FsRTYEsnQvLCyM2F15MsP/eKitcA56tcqAkNpFd8kXrKKTLtpJ1oo
	 rwHg4Y7APX/QhL4L/uXbs6t0hhn5i1WDGNHXAl/LAsmlIHrYviM8qph3VhSGQ6jKLN
	 saQdrJYXeTnPLmDypojDDJvsr18nr1gLb8TCOQnfwP9vv6bfXpkULDrwtngHXziSWH
	 fc6hvo0NyeJARWWnTf2dFS1P127qhUknKn7UAfRHIbKuLyMGALXi4Q3wsffd0nsYXn
	 CdHtM7zFEXIDw==
Subject: Re: [PATCH net-next 6/6] netlink: specs: rt-route: describe
 seg6-local actions, counters and flavors
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Mon, 21 Sep 2026 06:38:18 +0000
Message-ID: <178997269841.2160803.16028415760620210470@kernel.org>
In-Reply-To: <20260917-ynl_rt_encap-v1-6-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-6-fbbe6e680571@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete/misleading description of the SEG6_LOCAL_FLAVORS
  operation field: the newly added `seg6-local-flv` attribute set…

--

netlink: specs: rt-route: describe seg6-local actions, counters and flavors

This adds a seg6-local-actions enum definition, annotates the seg6-local
action attribute with it, and replaces the binary counters/flavors
attributes with nests described by the new seg6-local-cnt and
seg6-local-flv attribute sets.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 5e9537f7dfad4..3929a877aa279 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -116,6 +116,29 @@ definitions:
>        - rpl
>        - ioam6
>        - xfrm
> +  -
> +    name: seg6-local-actions
> +    type: enum
> +    name-prefix: seg6-local-action-
> +    enum-name:
> +    entries:
> +      - unspec
> +      - end
> +      - end-x

[ ... ]

> +      - end-bpf
> +      - end-dt46
>  
>  sub-messages:
>    -

[ ... ]

> @@ -624,6 +650,35 @@ attribute-sets:
>        -
>          name: name
>          type: string

[ ... ]

> +  -
> +    name: seg6-local-flv
> +    name-prefix: seg6-local-flv-
> +    attributes:
> +      -
> +        name: operation
> +        type: u32

[Severity: Medium]
Should the operation attribute here also carry an enum annotation, with
enum-as-flags: true?

SEG6_LOCAL_FLV_OPERATION does not carry an ordinal, it carries a bitmask
built from the flavor-operation enum in include/uapi/linux/seg6_local.h:

enum {
	SEG6_LOCAL_FLV_OP_UNSPEC,
	SEG6_LOCAL_FLV_OP_PSP,
	SEG6_LOCAL_FLV_OP_USP,
	SEG6_LOCAL_FLV_OP_USD,
	SEG6_LOCAL_FLV_OP_NEXT_CSID,
	__SEG6_LOCAL_FLV_OP_MAX
};

net/ipv6/seg6_local.c turns those into bit positions:

#define SEG6_F_LOCAL_FLV_OP(flvname)	BIT(SEG6_LOCAL_FLV_OP_##flvname)

and seg6_local_init() confirms the u32 attribute holds one bit per
operation:

	BUILD_BUG_ON(SEG6_LOCAL_FLV_OP_MAX + 1 > BITS_PER_TYPE(__u32));

parse_nla_flavors() reads the attribute and validates it against the
per-action supported-ops mask, and put_nla_flavors() writes finfo->flv_ops
back, so both directions are masks.

As written, a user-space client generated from this spec sees an opaque
integer, and setting it to 4 for next-csid means BIT(2), i.e. USP, or
gets rejected with EINVAL depending on the action.

The sibling rt-* specs describe such fields with a flags definition plus
enum-as-flags, for example ifa-flags in
Documentation/netlink/specs/rt-addr.yaml and ifi-flags in
Documentation/netlink/specs/rt-link.yaml.

Since the same patch does add enum: seg6-local-actions for the action
attribute, the two enumerated fields of the same uAPI header end up
described inconsistently: action decodes symbolically while operation
stays a plain integer.  Would it make sense to add the matching
type: flags definition (unspec/psp/usp/usd/next-csid) here as well, given
that the generated enum names are themselves user visible and changing
them later is awkward?

> +      -
> +        name: lcblock-bits
> +        type: u8
> +      -
> +        name: lcnode-fn-bits
> +        type: u8

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571%40kylinos.cn
