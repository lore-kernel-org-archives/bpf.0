Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114245;
	b=p7QsDsDfME9QkHlzbX9eK2VvAURGfRY8N+xGPyKPjNHrgV0IMEA/Loqb1OvIB5WDRLvk
	 QjEjeFgZ5Wby9kwYrjhfbjGMH48ky+zB/Hxkk4WjqvNBSHs5kY98WiOpbPBYUga5Wurcw
	 TEeCVrrA2Gg1hDAT2f2TTLZ++YW8eWGWH2GJ7mo0yQwaSwUJAl301u5fL0tV/y1Oky6B+
	 fIMZoEBEt9dXbbWp2ZlpK4mBiEgen8Vs+GHIi/wsUE3cAWUocHaf4r8js81lQgZTBA2UX
	 mF43zBbs+KllTZ4VswCV/keKfah9Y/y62JWqijeE86v0nJnVmGMEjM1LpFvlg/RwP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9e4+IQjeB/o9Yi3faOCevDuYUnllPZqnJ7EeMTDiCuM=;
	b=dwHwkNrdjIXAmwqxqdO7p56D1YYN/W7PExeRlQs5zKn96YWd5Fw8+iC2bpaln6B1jkm1
	 /XbzVregTqqyTB0jZ9BdH85+HB54S2lCmMC1WDXNcUW+tUCPfPfGWH/Iir5fbFjmLpNUy
	 EbPHCz5klePuB5jLV3QZ0I8GpujCUyWhlE/vqWrlbXWZdqlXc96bhkn79hFGPyvtdLJFZ
	 PH/5R5hqbhKQvDYvRe+a6NAS5/uC2LDfzoxTeQd0TIAbZTwGp/LVn5TUEDrRIkIarE8iR
	 n2ropAY7lea3aUkEyNZfhnf17zkrJbJgiEJLy0NBNUfxvgwpMzuubeMYBRxa6L9Ng5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTPSxDqF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93B606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTPSxDqF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9EB1F000C7;
	Thu, 19 Nov 2026 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114245;
	bh=9e4+IQjeB/o9Yi3faOCevDuYUnllPZqnJ7EeMTDiCuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTPSxDqFf1ZigD/2P/t4Eoiu/d1unpodkQ6VJm9y2Fav8MqsR+EL0GENwujwMo6Uz
	 9dVz62glZjC3MBRi7gYSCtvCy+H4H3ZESUdwAjysfHVPkikewfiRfd1/fSQPkw4egX
	 yLep2RrEy7hDjlwQoEaPZ1Pb62ajjvUFetZAcepaXMO2/5O1M3gMir7jwMFwa9RUU8
	 xbT6IoMqLpHJa6fWR9SBowiApNT6N8bXISz/X6MzJyi962jwU8VhQuDIKeDQ5XtIpO
	 zAT7znJmNeVq76gcdiGxhwf2nOBiLG8d/PAkSPUmKfWerrugP3sTNL4JLsxIE+bkLZ
	 MxZkFjpBCxdXg==
Message-ID: <sashiko-outbox-223806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool RX flow
 classification support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Meghana Malladi" <m-malladi@ti.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261118184729.2302130-3-m-malladi@ti.com>
References: <20261118184729.2302130-1-m-malladi@ti.com>
 <20261118184729.2302130-3-m-malladi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:50:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] net: ti: icssg-prueth: slot 15 rejected in
  icssg_rxnfc_rule_add()
- [Medium] net: ti: icssg: broken ETHTOOL_GRXCLSRLALL contract in
  emac_get_rxnfc()
- [Medium] net: ti: icssg: RXNFC rules wiped and not restored in
  prueth_emac_restart()
- [Medium] net: ti: icssg-prueth: missing icssg_rxnfc_rule_restore() on
  fw restart
- [Low] net: ti: icssg-prueth: sparse __be16 warning in
  icssg_ft3_program_filter()
--

commit 9fd710bfddff4882ecad02b113fc08db59485950
Author: Meghana Malladi <m-malladi@ti.com>

net: ti: icssg-prueth: Add ethtool RX flow classification support

This commit adds ethtool RX flow classification support (get_rxnfc and
set_rxnfc) to steer EtherType matches to specific RX flows using the ICSSG
FT3 hardware filters and RX classifier OR tables.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/n=
et/ethernet/ti/icssg/icssg_classifier.c
> index 87a8577093dbb..520b3f3377784 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> @@ -105,6 +105,14 @@ enum ft1_cfg_type {
>  	((BIT(slot) << RX_CLASS_FT_FT1_MATCH_SHIFT) & \
>  	RX_CLASS_FT_FT1_MATCH_MASK)
> =20
> +#define RX_CLASS_FT_FT3_MATCH(slot)	\
> +	((BIT(slot) << RX_CLASS_FT_FT3_MATCH_SHIFT) & \
> +	RX_CLASS_FT_FT3_MATCH_MASK)
> +
> +/* FT3 Configuration registers and modes */
> +#define FT3_CFG_REGISTER_EQUAL		(1U)
> +#define FT3_CFG_REGISTER_VLAN_SKIP	BIT(2)
> +
>  /* HSR/PRP protocol frame filtering */
>  #define HSR_PTP_ETHERTYPE_OFFSET	0x12
>  #define PRP_PTP_ETHERTYPE_OFFSET	0x0C
> @@ -532,3 +540,402 @@ void icssg_ft3_hsr_configurations(struct regmap *mi=
ig_rt, int slice,
>  	}
>  }
>  EXPORT_SYMBOL_GPL(icssg_ft3_hsr_configurations);
> +
> +/* RX Flow Classification (ethtool) rule management */
> +
> +/* Allocate free FT3 slot, avoiding reserved slot 14 */
> +static int allocate_ft3_slot(struct prueth_emac *emac)
> +{
> +	u16 used =3D emac->rxnfc.ft3_slots_used | ICSSG_FT3_RESERVED_SLOTS;
> +	int slot;
> +
> +	for (slot =3D 0; slot < ICSSG_NUM_FT3_SLOTS; slot++) {
> +		if (!(used & BIT(slot))) {
> +			emac->rxnfc.ft3_slots_used |=3D BIT(slot);
> +			return slot;
> +		}
> +	}
> +	return -ENOSPC;
> +}
> +
> +/* Free allocated FT3 slot */
> +static void free_ft3_slot(struct prueth_emac *emac, int slot)
> +{
> +	emac->rxnfc.ft3_slots_used &=3D ~BIT(slot);
> +}
> +
> +/* Program FT3 filter slot with ethertype pattern */
> +static void icssg_ft3_program_filter(struct regmap *miig_rt, int slice,
> +				     int slot, struct icssg_rxnfc_rule *rule)
> +{
> +	const struct ethtool_rx_flow_spec *fs =3D &rule->flow_spec;
> +	u16 ether_type;
> +
> +	/* Extract EtherType from flow spec (network byte order) */
> +	ether_type =3D fs->h_u.ether_spec.h_proto;
> +
> +	/* Deactivate filter before programming */
> +	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_CFG), 0);
> +
> +	/* EtherType is at byte 12 in standard Ethernet frames */
> +	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_START),
> +		     PRP_PTP_ETHERTYPE_OFFSET);
> +	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_START_AUTO), 0);
> +	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_START_OFFSET), 0);
> +	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_JUMP_OFFSET), 0);
> +	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_LEN), 0);
> +
> +	/* FT3 compares a 32-bit LE word at FT3_START. EtherType occupies the
> +	 * lower 16 bits of that word. FT3_T_MASK=3D0xFFFF0000 masks the upper
> +	 * 16 bits (payload bytes), so only the lower 16 bits are compared.
> +	 *
> +	 * h_proto is __be16 (network byte order). On LE the raw integer value
> +	 * equals the lower 16 bits of the LE 32-bit word at the EtherType
> +	 * offset in the frame =E2=80=94 e.g. IPv4 0x0800 BE =E2=86=92 h_proto =
=3D 0x0008 on LE,
> +	 * which is exactly what FT3 sees in the lower 16 bits of the word at
> +	 * byte 12. No conversion needed; using be16_to_cpu() here would invert
> +	 * the byte order and break the match.
> +	 * Reference: FT3_PTP_PATTERN =3D 0xF788 =3D htons(0x88F7) =3D raw h_pr=
oto value.
> +	 */
> +	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_T),
> +		     (__force u32)ether_type);

[Severity: Low]
Does assigning fs->h_u.ether_spec.h_proto (__be16) to ether_type (u16) trig=
ger
a sparse endianness warning because the __force cast is placed on the
subsequent u16-to-u32 conversion instead of on h_proto?  Also,
FT3_CFG_REGISTER_VLAN_SKIP defined above is unused.

[ ... ]

> +/* Restore RX flow classification hardware state from the in-memory rule=
 list.
> + * Call after icssg_class_default() resets the classifier registers on o=
pen or
> + * after firmware restart so that existing rules take effect again.
> + */
> +void icssg_rxnfc_rule_restore(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth =3D emac->prueth;
> +	struct regmap *miig_rt =3D prueth->miig_rt;
> +	int slice =3D prueth_emac_slice(emac);
> +	struct icssg_rxnfc_rule *rule;
> +
> +	if (slice < 0)
> +		return;
> +
> +	mutex_lock(&emac->rxnfc.rxnfc_lock);
> +
> +	list_for_each_entry(rule, &emac->rxnfc.rules, list)
> +		icssg_ft3_program_filter(miig_rt, slice, rule->ft3_slot, rule);
> +
> +	icssg_rxnfc_classifier_update(emac);
> +
> +	mutex_unlock(&emac->rxnfc.rxnfc_lock);
> +}
> +EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_restore);

[Severity: Medium]
Should prueth_emac_restart() also call icssg_rxnfc_rule_restore() for both
ports after prueth_emac_common_start()?  During bridge or HSR mode transiti=
ons
on running interfaces, prueth_emac_restart() calls prueth_emac_common_start=
()
-> icssg_class_default() without going through emac_ndo_open(), which resets
all RX_CLASS_OR_EN registers and silently disables active RXNFC rules in
hardware while leaving them in emac->rxnfc.rules.

[ ... ]

> +/* Add a new RX flow classification rule */
> +int icssg_rxnfc_rule_add(struct prueth_emac *emac, struct ethtool_rxnfc =
*info)
> +{
> +	struct ethtool_rx_flow_spec *fs =3D &info->fs;
> +	struct prueth *prueth =3D emac->prueth;
> +	struct regmap *miig_rt =3D prueth->miig_rt;
> +	int slice =3D prueth_emac_slice(emac);
> +	struct icssg_rxnfc_rule *rule;
> +	int ft3_slot;
> +	int ret;
> +
> +	if (slice < 0)
> +		return -EINVAL;
> +
> +	/* Validate rule parameters */
> +	ret =3D validate_rule(emac, fs);
> +	if (ret)
> +		return ret;
> +
> +	/* Validate explicit location: reject special specifiers, out-of-range
> +	 * values, and the reserved slot 14 used by HSR/PRP.
> +	 */
> +	if (fs->location !=3D RX_CLS_LOC_ANY) {
> +		if (fs->location >=3D ICSSG_RXNFC_MAX_RULES ||
> +		    BIT(fs->location) & ICSSG_FT3_RESERVED_SLOTS)
> +			return -EINVAL;
> +	}

[Severity: Medium]
Does checking fs->location >=3D ICSSG_RXNFC_MAX_RULES (15) instead of
ICSSG_NUM_FT3_SLOTS (16) reject valid slot 15 with -EINVAL?  Because slot 14
is reserved by ICSSG_FT3_RESERVED_SLOTS, the 15 usable FT3 slots are 0..13 =
and
15 (which allocate_ft3_slot() assigns for RX_CLS_LOC_ANY), so bounding expl=
icit
locations by ICSSG_RXNFC_MAX_RULES restricts explicit insertions to 14 slots
(0..13).  Similarly, ETHTOOL_GRXCLSRLCNT in emac_get_rxnfc() reports a table
size of ICSSG_RXNFC_MAX_RULES (15) in info->data instead of
ICSSG_NUM_FT3_SLOTS (16).

[ ... ]

> +/* Get all RX flow classification rules */
> +int icssg_rxnfc_rule_get_all(struct prueth_emac *emac, u32 *rule_locs,
> +			     u32 rule_locs_capacity, u32 *rule_cnt)
> +{
> +	struct icssg_rxnfc_rule *rule;
> +	u32 count =3D 0;
> +	int ret =3D 0;
> +
> +	mutex_lock(&emac->rxnfc.rxnfc_lock);
> +
> +	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
> +		if (!rule_locs) {
> +			/* Caller passed rule_cnt=3D0: just count active rules */
> +			count++;
> +			continue;
> +		}
> +		if (count >=3D rule_locs_capacity) {
> +			ret =3D -EMSGSIZE;
> +			break;
> +		}
> +		rule_locs[count++] =3D rule->location;
> +	}
> +
> +	*rule_cnt =3D count;
> +
> +	mutex_unlock(&emac->rxnfc.rxnfc_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_get_all);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/=
ethernet/ti/icssg/icssg_ethtool.c
> index 68646cb7df442..35eb056dab6d9 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -300,6 +300,62 @@ static int emac_set_per_queue_coalesce(struct net_de=
vice *ndev, u32 queue,
>  	return 0;
>  }
> =20
> +static u32 emac_get_rx_ring_count(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac =3D netdev_priv(ndev);
> +
> +	return emac->rx_flow_num;
> +}
> +
> +static int emac_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc =
*info,
> +			  u32 *rule_locs)
> +{
> +	struct prueth_emac *emac =3D netdev_priv(ndev);
> +	int ret =3D 0;
> +
> +	if (emac->is_sr1)
> +		return -EOPNOTSUPP;
> +
> +	switch (info->cmd) {
> +	case ETHTOOL_GRXCLSRLCNT:
> +		info->rule_cnt =3D emac->rxnfc.rxnfc_rule_count;
> +		info->data =3D ICSSG_RXNFC_MAX_RULES | RX_CLS_LOC_SPECIAL;
> +		break;
> +	case ETHTOOL_GRXCLSRULE:
> +		ret =3D icssg_rxnfc_rule_get(emac, info->fs.location, &info->fs);
> +		break;
> +	case ETHTOOL_GRXCLSRLALL: {
> +		u32 rule_cnt =3D 0;
> +
> +		ret =3D icssg_rxnfc_rule_get_all(emac, rule_locs,
> +					       info->rule_cnt, &rule_cnt);
> +		info->rule_cnt =3D rule_cnt;
> +		break;
> +	}

[Severity: Medium]
Does ETHTOOL_GRXCLSRLALL violate the ethtool_rxnfc UAPI contract by leaving
info->data unset and returning 0 instead of -EMSGSIZE when rule_locs is NULL
and active rules exist?  For ETHTOOL_GRXCLSRLALL, info->data is supposed to
return the rule table size, and passing info->rule_cnt =3D=3D 0 (which makes
ethtool_get_rxnfc() pass rule_locs =3D=3D NULL with capacity 0) should hit =
the
count >=3D rule_locs_capacity check and return -EMSGSIZE when rules are pre=
sent.

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.c
> index 716f1b9195d67..b08e74e24a5a3 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1101,6 +1101,12 @@ static int emac_ndo_open(struct net_device *ndev)
> =20
>  	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
> =20
> +	/* Re-program FT3 filters and classifier OR tables from the persistent
> +	 * rule list. icssg_class_default() called above resets all classifiers,
> +	 * so rules must be restored here on every open/restart.
> +	 */
> +	icssg_rxnfc_rule_restore(emac);

[Severity: Medium]
As noted in this comment, rules must be restored on every open or restart,
yet icssg_rxnfc_rule_restore() is only called here in emac_ndo_open() and n=
ot
in prueth_emac_restart().  When prueth_emac_restart() runs (for example, via
icssg_change_mode(), prueth_netdevice_port_unlink(), or
prueth_hsr_port_unlink()), prueth_emac_common_start() calls
icssg_class_default() on both ICSS_SLICE0 and ICSS_SLICE1, resetting
classifier 0 back to RX_CLASS_FT_BC | RX_CLASS_FT_DA_P and clearing
classifiers 1..15 without restoring the RXNFC rules for either port.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118184729.2302=
130-1-m-malladi@ti.com?part=3D2
