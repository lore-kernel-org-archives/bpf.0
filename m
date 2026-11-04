Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800008;
	b=jmE46bavBdCvORuR8plztPlRlIjUA0rqS7PkTHxRLs9WGxidrbPqfRD9Cu+TFwjQfPg2
	 ap/Y0hOsKxNkBh40fnUEW288RqBgQYvGN4/8WEt4+RXlbmJshRKjkSG9e7MLMJGntK4DA
	 q0pTvrlbLeIc6mN3vDrqrUln52nTl3ScoDvQAp+UfACLtGTZTSQMxsT7yMz3pVcnI2emQ
	 HXrT5D2CIslwV6f/4xKVTnWKt9WUetebGE/jtH7komCatfN00vxfF3btPvM/Riv5+Nuze
	 sdxoekxwbMN1EfReM60BF+j8r1EIg2FbKb7/4gGp3xOfbod4PBh4oYv7F8JOS2QO47g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8X3xdx4LAVWaOtkTT2nNXBYt75fASyvB/XY5OBCB788=;
	b=RxLaFs6fudvvHi8fqIoK/EYvm3fdswNKkfusJfNbHYDWUT3ThbjmTnHpAL/z8gIw4rvH
	 0eWV9bp9lOBCBP4z15XknW8tEd6KaDbTbTYbGqNVHerlbae0lNqbYJjFA3VTe9nka3n2D
	 aXer8PdxhKWdJGLDrP4t2OsaX933y9FkkV77VpsYx4a6KK9WVNOQrZGL2WtgejHpQvIv3
	 hxAOcWIo7bGTho2dK5VZLSzyXinTea3xaaxu4rMawR/v+IPk9Wb2yCbQj/feWeLhWJVcK
	 puOqxwL4HWfQionbi+RGgFHS17/fpvuDMWyjzOXrmLAt7pHu7hlA+DU5fjf35DnQKVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SOrN/qIf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA25606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOrN/qIf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5221F00919;
	Wed,  4 Nov 2026 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800008;
	bh=8X3xdx4LAVWaOtkTT2nNXBYt75fASyvB/XY5OBCB788=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOrN/qIfLaq3mQT1mfg+RGm/NkCRc6uv38A1WVuaJCNcHMsg1qUTFsniWj37NP3Kx
	 NjKj+4xwtMjt/D+d8pchH7E5coZm6RRQDPyu96rErVKClbHHtN/Tpaw1trBSCS9/D6
	 exgQSyiJ23TZQl0hEpmTWCo6fx2lq1FzUpK0qGUza3kBdHfuYjb368zlfq4xMy04BO
	 2VPQxpZMfwpmSm9dCGV5QvO5q9Ozt230vuExybKK0AeOoei/zLEPTvpsLUKR81AEr1
	 O0lWxn+Qe8vYf0MuiL/PLA3V60o8cbKjBvMn3UODCFfC9aOuGoRRdIty4LOE3haFnZ
	 j2y3LXV0Zd37A==
Message-ID: <sashiko-outbox-197354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 2/2] icssg: Add ethtool RX flow
 classification support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Meghana Malladi" <m-malladi@ti.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261103134501.4123194-3-m-malladi@ti.com>
References: <20261103134501.4123194-1-m-malladi@ti.com>
 <20261103134501.4123194-3-m-malladi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 13:46:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [Critical] net: ti: icssg: heap overflow and NULL deref in icssg_rxnfc_ru=
le_get_all()
- [High] net: ti: icssg: icssg_rxnfc_classifier_update() clobbers HSR class=
ifiers
- [High] icssg: uninitialized rxnfc lock and list on SR1.0 via icssg_ethtoo=
l_ops
- [High] icssg: RXNFC rules wiped on open/restart and deleted across suspend
- [High] icssg: icssg_rxnfc_classifier_update() clobbers HSR/PRP classifiers
- [High] icssg: premature page_pool_destroy() and FDQ race in prueth_destro=
y_rxq()
- [High] icssg: napi_disable() hang on prueth_create_rxq() error and FDQ ov=
erflow
- [Medium] net: ti: icssg: missing location validation in icssg_rxnfc_rule_=
add()
- [Medium] net: ti: icssg: unvalidated ether_spec masks and queue 0 in vali=
date_rule()
- [Medium] net: ti: icssg: unreachable ETHTOOL_GRXRINGS in emac_get_rxnfc()
- [Medium] icssg: memory leak of rxnfc rules in prueth_netdev_exit()
- [Low] net: ti: icssg: sparse endianness mismatch in icssg_ft3_program_fil=
ter()
- [Low] icssg: undocumented UDMA RX completion drain in prueth_destroy_rxq()
--

commit 21ba5b8fca0b052692d50b8d741061eff437183c
Author: Meghana Malladi <m-malladi@ti.com>

icssg: Add ethtool RX flow classification support

This commit adds ethtool get_rxnfc and set_rxnfc support to the ICSSG
driver to steer packets to RX flows using FT3 hardware filters and RX
classifier OR tables, and drains the UDMA RX completion ring during RX
queue teardown.

>     icssg: Add ethtool RX flow classification support
>    =20
>     Enable dynamic RX flow classification via ethtool set_rxnfc/get_rxnfc.
>     Users can install/remove filter rules to steer packets to specific RX=
 flows
>     based on EtherType patterns via FT3 hardware filters.
>    =20
>     - Add RXNFC rule tracking structures and lifecycle management
>     - Implement ethtool get_rxnfc/set_rxnfc callbacks
>     - FT3 slot allocation and hardware programming for pattern matching
>     - RX classifier OR table updates based on active rules
>     - Max 15 rules per EMAC, using FT3 slots 0-13,15 (slot 14 reserved)
>    =20
>     Signed-off-by: Meghana Malladi <m-malladi@ti.com>

[Severity: Low]
This isn't a bug, but prueth_destroy_rxq() in
drivers/net/ethernet/ti/icssg/icssg_prueth.c also adds a loop to drain the
UDMA RX completion ring before calling k3_udma_glue_reset_rx_chn() so that
page_pool_destroy() does not stall waiting for inflight pages. Should that
change be documented in the commit message or split into a separate patch?

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/n=
et/ethernet/ti/icssg/icssg_classifier.c
> index 87a8577093dbb..f11539611df75 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
[ ... ]
> +/* Program FT3 filter slot with ethertype pattern */
> +static void icssg_ft3_program_filter(struct regmap *miig_rt, int slice,
> +				     int slot, struct icssg_rxnfc_rule *rule)
> +{
> +	const struct ethtool_rx_flow_spec *fs =3D &rule->flow_spec;
> +	u16 ether_type;
> +
> +	/* Extract EtherType from flow spec (network byte order) */
> +	ether_type =3D fs->h_u.ether_spec.h_proto;

[Severity: Low]
Does assigning fs->h_u.ether_spec.h_proto (which is __be16) directly to u16
ether_type trigger a sparse endianness warning when building
drivers/net/ethernet/ti/icssg/icssg_classifier.c with C=3D1, while the
(__force u32) cast further down in icssg_ft3_program_filter() is applied to
what is already a plain u16?

> +
> +	/* Deactivate filter before programming */
> +	regmap_write(miig_rt, FT3_N_REG(slice, slot, FT3_CFG), 0);
[ ... ]
> +static void icssg_rxnfc_classifier_update(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth =3D emac->prueth;
> +	struct regmap *miig_rt =3D prueth->miig_rt;
> +	int slice =3D prueth_emac_slice(emac);
> +	u32 or_table[ICSSG_NUM_CLASSIFIERS] =3D { };
> +	struct icssg_rxnfc_rule *rule;
> +	int n;
> +
> +	if (slice < 0)
> +		return;
> +
> +	/* Build per-classifier OR table: classifier index =3D target queue ind=
ex */
> +	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
> +		int cls =3D rule->queue_index;
> +
> +		if (cls < ICSSG_NUM_CLASSIFIERS)
> +			or_table[cls] |=3D RX_CLASS_FT_FT3_MATCH(rule->ft3_slot);
> +	}
> +
> +	/* Write OR tables for user-rule classifiers; skip classifier 0 (defaul=
t flow).
> +	 * Use RX_CLASS_N_REG with RX_CLASS_OR_EN =E2=80=94 NOT RX_CLASS_OR_REG=
 which uses
> +	 * rx_class_or_base (=3D rx_class_base + 4), causing an off-by-4 that l=
ands on
> +	 * AND_EN of classifier n+1 instead of OR_EN of classifier n.
> +	 */
> +	for (n =3D 1; n < ICSSG_NUM_CLASSIFIERS; n++) {
> +		regmap_write(miig_rt,
> +			     RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN),
> +			     or_table[n]);
> +	}
> +}

[Severity: High]
Won't looping up to ICSSG_NUM_CLASSIFIERS (16) in
icssg_rxnfc_classifier_update() overwrite the HSR/PRP classifiers with 0?

In icssg_ft3_hsr_configurations(), HSR/PRP offload configures FT3_PTP_SLOT
(slot 14) and programs CLASSIFIER_PTP_DUP (classifier 10) and
CLASSIFIER_HSR_TAG (classifier 11):

drivers/net/ethernet/ti/icssg/icssg_classifier.c:icssg_ft3_hsr_configuratio=
ns() {
	...
	regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_PTP_DUP, RX_CLASS_=
AND_EN),
		     RX_CLASS_OR_DUP_PTP);
	...
	if (prueth->hsr_prp_version !=3D PRP_V1) {
		...
		regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_HSR_TAG, RX_CLASS=
_AND_EN),
			     RX_CLASS_OR_HSR_TAG);
	...
}

Although FT3 slot 14 is reserved via ICSSG_FT3_RESERVED_SLOTS, user RX
queues are bounded by emac->rx_flow_num <=3D ICSSG_MAX_RFLOWS (8, classifie=
rs
0..7), so or_table[8..15] are always 0. When a rule is added or deleted via
emac_set_rxnfc() -> icssg_rxnfc_rule_add() / icssg_rxnfc_rule_del() ->
icssg_rxnfc_classifier_update(), writing or_table[n] for n =3D 1..15 zeroes
RX_CLASS_OR_EN on classifiers 10 and 11.

In addition, when prueth_emac_common_start() runs during emac_ndo_open() or
prueth_emac_restart(), it calls icssg_class_default() ->
icssg_class_disable(), which zeroes RX_CLASS_OR_EN across all classifiers
without calling icssg_rxnfc_classifier_update() to restore active rules in
emac->rxnfc.rules.

> +
> +/* Validate rule parameters */
> +static int validate_rule(struct prueth_emac *emac,
> +			 struct ethtool_rx_flow_spec *fs)
> +{
> +	/* Only ETHER_FLOW supported for Phase 1 */
> +	if (fs->flow_type !=3D ETHER_FLOW)
> +		return -EOPNOTSUPP;
> +
> +	/* Check RX queue is valid */
> +	if (fs->ring_cookie >=3D emac->rx_flow_num)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[Severity: Medium]
What happens in validate_rule() when userspace passes an ETHER_FLOW rule
with MAC address masks or a partial EtherType mask in fs->m_u.ether_spec,
flow_type extension flags (FLOW_EXT or FLOW_MAC_EXT), or fs->ring_cookie =
=3D=3D
0?

In validate_rule(), fs->m_u.ether_spec.h_dest, fs->m_u.ether_spec.h_source,
and fs->m_u.ether_spec.h_proto are not checked before
icssg_ft3_program_filter() programs FT3_T with fs->h_u.ether_spec.h_proto
and FT3_T_MASK with FT3_ETHERTYPE_MASK, so MAC filter requests are silently
accepted and programmed as EtherType matches (matching 0x0000 if h_proto was
not set).

Also, validate_rule() allows fs->ring_cookie =3D=3D 0 (which is the only va=
lid
queue under the default emac->rx_flow_num =3D 1 in prueth_netdev_init()). A
rule with ring_cookie =3D=3D 0 allocates an FT3 slot and sets or_table[0] in
icssg_rxnfc_classifier_update(), but the register write loop starts at
n =3D 1 and never writes or_table[0] to hardware.

[ ... ]
> +/* Cleanup RX flow classification */
> +void icssg_rxnfc_rule_cleanup(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth =3D emac->prueth;
> +	struct regmap *miig_rt =3D prueth->miig_rt;
> +	int slice =3D prueth_emac_slice(emac);
> +	struct icssg_rxnfc_rule *rule, *tmp;
> +	int n;
> +
> +	if (slice < 0)
> +		return;
> +
> +	mutex_lock(&emac->rxnfc.rxnfc_lock);
> +
> +	/* Disable all active FT3 filters */
> +	list_for_each_entry_safe(rule, tmp, &emac->rxnfc.rules, list) {
> +		icssg_ft3_disable_filter(miig_rt, slice, rule->ft3_slot);
> +		free_ft3_slot(emac, rule->ft3_slot);
> +		list_del(&rule->list);
> +		kfree(rule);
> +	}
> +
> +	emac->rxnfc.rxnfc_rule_count =3D 0;
> +	emac->rxnfc.ft3_slots_used =3D ICSSG_FT3_RESERVED_SLOTS;
> +
> +	/* Clear all user-rule classifier OR tables (classifier 0 =3D default, =
skip) */
> +	for (n =3D 1; n < ICSSG_NUM_CLASSIFIERS; n++)
> +		regmap_write(miig_rt,
> +			     RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN), 0);
> +
> +	mutex_unlock(&emac->rxnfc.rxnfc_lock);
> +}
> +EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_cleanup);

[Severity: High]
Similar to icssg_rxnfc_classifier_update(), doesn't the loop in
icssg_rxnfc_rule_cleanup() clear RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN)
for n =3D 1..15 (ICSSG_NUM_CLASSIFIERS - 1) instead of stopping at
ICSSG_MAX_RFLOWS - 1 (7)?

Because offs[slice].rx_class_or_base is offs[slice].rx_class_base + 4
(RX_CLASS_OR_EN), RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN) is the same
register as RX_CLASS_OR_REG(slice, n, RX_CLASS_AND_EN) programmed by
icssg_ft3_hsr_configurations() for CLASSIFIER_PTP_DUP (10) and
CLASSIFIER_HSR_TAG (11), so calling icssg_rxnfc_rule_cleanup() clobbers both
HSR/PRP classifiers.

> +
> +/* Add a new RX flow classification rule */
> +int icssg_rxnfc_rule_add(struct prueth_emac *emac, struct ethtool_rxnfc =
*info)
> +{
[ ... ]
> +	/* Check for duplicate */
> +	if (rule_exists(emac, fs)) {
> +		ret =3D -EEXIST;
> +		goto unlock;
> +	}
> +
> +	/* Allocate FT3 slot */
> +	ft3_slot =3D allocate_ft3_slot(emac);
> +	if (ft3_slot < 0) {
> +		ret =3D -ENOSPC;
> +		goto unlock;
> +	}
> +
> +	/* Auto-assign location from FT3 slot if RX_CLS_LOC_ANY requested */
> +	if (fs->location =3D=3D RX_CLS_LOC_ANY)
> +		fs->location =3D ft3_slot;
> +
> +	/* Allocate rule structure */
> +	rule =3D kzalloc(sizeof(*rule), GFP_KERNEL);
> +	if (!rule) {
> +		ret =3D -ENOMEM;
> +		free_ft3_slot(emac, ft3_slot);
> +		goto unlock;
> +	}
> +
> +	/* Program FT3 hardware */
> +	rule->flow_spec =3D *fs;
> +	rule->ft3_slot =3D ft3_slot;
> +	rule->queue_index =3D fs->ring_cookie;
> +	rule->location =3D fs->location;

[Severity: Medium]
How are explicit or special fs->location values validated in
icssg_rxnfc_rule_add()?

In emac_get_rxnfc(), ETHTOOL_GRXCLSRLCNT sets info->data to
ICSSG_RXNFC_MAX_RULES | RX_CLS_LOC_SPECIAL (advertising 15 locations,
0..14, plus special location specifiers). However:

1. Neither validate_rule() nor icssg_rxnfc_rule_add() validates fs->location
   when fs->location !=3D RX_CLS_LOC_ANY, so RX_CLS_LOC_FIRST,
   RX_CLS_LOC_LAST, reserved slot 14, or values >=3D ICSSG_RXNFC_MAX_RULES =
are
   stored directly in rule->location.
2. When fs->location =3D=3D RX_CLS_LOC_ANY, allocate_ft3_slot() skips reser=
ved
   slot 14 and returns ft3_slot =3D 15 for the 15th rule, assigning
   fs->location =3D 15 (>=3D ICSSG_RXNFC_MAX_RULES).
3. Because allocate_ft3_slot() picks the lowest free FT3 slot independently
   of an explicit fs->location and rule_exists() only checks flow_type and
   h_proto, adding a rule with explicit location 1 (getting ft3_slot =3D 0,
   rule->location =3D 1) followed by a rule with RX_CLS_LOC_ANY (getting
   ft3_slot =3D 1, rule->location =3D 1) or another rule with location 1 cr=
eates
   duplicate rule->location entries in emac->rxnfc.rules. Since
   icssg_rxnfc_rule_get() and icssg_rxnfc_rule_del() stop at the first match
    from list_add(), the older rule is shadowed and also hidden from
   ethtool_get_max_rxnfc_channel() when reducing channel count.

[ ... ]
> +/* Get all RX flow classification rules */
> +int icssg_rxnfc_rule_get_all(struct prueth_emac *emac, u32 *rule_locs,
> +			     u32 *rule_cnt)
> +{
> +	struct icssg_rxnfc_rule *rule;
> +	u32 count =3D 0;
> +
> +	mutex_lock(&emac->rxnfc.rxnfc_lock);
> +
> +	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
> +		rule_locs[count++] =3D rule->location;
> +	}
> +
> +	*rule_cnt =3D count;
> +
> +	mutex_unlock(&emac->rxnfc.rxnfc_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_get_all);

[Severity: Critical]
Can icssg_rxnfc_rule_get_all() dereference a NULL rule_locs pointer or
overflow the rule_locs[] heap buffer when called from emac_get_rxnfc() for
ETHTOOL_GRXCLSRLALL?

In net/ethtool/ioctl.c:ethtool_get_rxnfc(), when info.cmd =3D=3D
ETHTOOL_GRXCLSRLALL, the kernel allocates rule_buf based on the
user-supplied info.rule_cnt (or leaves rule_buf as NULL if info.rule_cnt =
=3D=3D
0):

net/ethtool/ioctl.c:ethtool_get_rxnfc() {
	...
	if (info.cmd =3D=3D ETHTOOL_GRXCLSRLALL) {
		if (info.rule_cnt > 0) {
			if (info.rule_cnt <=3D KMALLOC_MAX_SIZE / sizeof(u32))
				rule_buf =3D kcalloc(info.rule_cnt, sizeof(u32),
						   GFP_USER);
			if (!rule_buf)
				return -ENOMEM;
		}
	}
	...
	ret =3D ops->get_rxnfc(dev, &info, rule_buf);
}

In emac_get_rxnfc(), the ETHTOOL_GRXCLSRLALL case ignores the caller's
info->rule_cnt capacity, passes a local rule_cnt =3D 0 to
icssg_rxnfc_rule_get_all(), and does not set info->data to the rule table
size (ICSSG_RXNFC_MAX_RULES). Inside icssg_rxnfc_rule_get_all(), the loop
writes rule_locs[count++] =3D rule->location for every active rule without
checking if rule_locs is NULL or if count has reached the caller's
info->rule_cnt capacity (where it should return -EMSGSIZE).

If rules are installed and userspace passes info.rule_cnt =3D=3D 0,
rule_locs[count++] dereferences NULL. If userspace passes 0 < info.rule_cnt
< emac->rxnfc.rxnfc_rule_count, rule_locs[count++] writes past the end of
the kcalloc() buffer and updates info->rule_cnt to the larger count, causing
ethtool_rxnfc_copy_to_user() to read out-of-bounds kernel heap memory back
to userspace.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/=
ethernet/ti/icssg/icssg_ethtool.c
> index 5c2936ecd595c..9f0a1116e530c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -299,6 +299,52 @@ static int emac_set_per_queue_coalesce(struct net_de=
vice *ndev, u32 queue,
>  	return 0;
>  }
> =20
> +static int emac_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc =
*info,
> +			  u32 *rule_locs)
> +{
> +	struct prueth_emac *emac =3D netdev_priv(ndev);
> +	int ret =3D 0;
> +
> +	switch (info->cmd) {
> +	case ETHTOOL_GRXRINGS:
> +		info->data =3D emac->rx_flow_num;
> +		break;

[Severity: Medium]
Is the ETHTOOL_GRXRINGS case in emac_get_rxnfc() reachable?

In net/ethtool/ioctl.c:ethtool_get_rxrings(), ETHTOOL_GRXRINGS is handled by
calling ethtool_get_rx_ring_count(), which checks ops->get_rx_ring_count in
struct ethtool_ops and returns -EOPNOTSUPP when it is NULL, rather than
calling ops->get_rxnfc(). Should icssg_ethtool_ops implement
.get_rx_ring_count instead?

[ ... ]
>  const struct ethtool_ops icssg_ethtool_ops =3D {
[ ... ]
>  	.nway_reset =3D emac_nway_reset,
>  	.get_rmon_stats =3D emac_get_rmon_stats,
> +	.get_rxnfc =3D emac_get_rxnfc,
> +	.set_rxnfc =3D emac_set_rxnfc,
>  };
>  EXPORT_SYMBOL_GPL(icssg_ethtool_ops);

[Severity: High]
What happens when emac_get_rxnfc() or emac_set_rxnfc() (or
ethtool_set_channels() -> ethtool_check_max_channel() ->
ethtool_get_max_rxnfc_channel()) is called on an SR1.0 device?

In drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:prueth_netdev_init(),
SR1.0 net_devices also use icssg_ethtool_ops:

drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:prueth_netdev_init() {
	...
	ndev->netdev_ops =3D &emac_netdev_ops;
	ndev->ethtool_ops =3D &icssg_ethtool_ops;
	...
}

However, icssg_rxnfc_rule_init(emac) is only called in
drivers/net/ethernet/ti/icssg/icssg_prueth.c:prueth_netdev_init() and not in
icssg_prueth_sr1.c, nor do emac_get_rxnfc() / emac_set_rxnfc() guard against
emac->is_sr1. On SR1.0 devices, emac->rxnfc.rxnfc_lock is uninitialized and
emac->rxnfc.rules has NULL next/prev pointers, so any RXNFC call will lock
an uninitialized mutex and dereference a NULL list_head. (Note also that
drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:emac_ndo_open() and related
RX channel calls in this series still use the old struct prueth_rx_chn
fields and helper signatures, breaking the build when
CONFIG_TI_ICSSG_PRUETH_SR1 is enabled.)

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.c
> index 8338402597b21..f234198d4cc42 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -874,10 +874,29 @@ static void prueth_destroy_rxq(struct prueth_emac *=
emac, int qid)
>  {
>  	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
>  	struct prueth_rx_flow *flow =3D &rx_chn->flows[qid];
> +	dma_addr_t desc_dma;
> =20
> -	/* reset napi and hrtimer, and free all pending buffers */
>  	napi_disable(&flow->napi_rx);
>  	hrtimer_cancel(&flow->rx_hrtimer);
> +
> +	/* Drain the UDMA completion ring for this flow before resetting
> +	 * the free ring.  k3_udma_glue_reset_rx_chn() only drains the
> +	 * free ring (descriptors pushed as empty receive buffers).  Any
> +	 * frames that the hardware already DMA-completed but NAPI hadn't
> +	 * popped yet remain in the completion ring with their pages still
> +	 * counted as "inflight" in the page pool.  Draining them here
> +	 * ensures page_pool_destroy() finds zero inflight pages and
> +	 * completes immediately instead of stalling for 60+ seconds.
> +	 *
> +	 * The caller must have stopped new frames from arriving (e.g. via
> +	 * icssg_set_port_state(ICSSG_EMAC_PORT_DISABLE)) before calling
> +	 * prueth_destroy_rxq() so this loop terminates.
> +	 */
> +	while (!k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, qid, &desc_dma)) {
> +		if (!cppi5_desc_is_tdcm(desc_dma))
> +			prueth_rx_cleanup(rx_chn, desc_dma);
> +	}
> +
>  	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, flow->id, rx_chn,
>  				  prueth_rx_cleanup);
> =20

[Severity: High]
When multiple RX flows are active (emac->rx_flow_num > 1), doesn't calling
prueth_destroy_rxq(emac, i) sequentially in prueth_destroy_rxqs() destroy
flows[0].pg_pool before higher flows' completion rings are drained?

In prueth_init_rx_chns(), all RX flows share flow 0's Free Descriptor Queue
(ringrxfdq), so descriptors pushed by flow 0 (with swdata->flow_id =3D=3D 0=
 and
pages from flows[0].pg_pool) can be popped by UDMA when packets are steered
by FT3 rules to flow qid > 0 and placed into flows[qid]'s completion ring.

When prueth_destroy_rxqs() runs:

1. On qid =3D=3D 0, prueth_destroy_rxq(emac, 0) disables only flows[0].napi=
_rx
   while flows[1..rx_flow_num-1].napi_rx are still enabled and can push
   requeued descriptors into the shared ringrxfdq concurrently with
   k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, 0, ...).
2. prueth_destroy_rxq(emac, 0) drains only flow 0's completion ring and
   immediately calls page_pool_destroy(flows[0].pg_pool) and sets
   flows[0].pg_pool =3D NULL while descriptors with swdata->flow_id =3D=3D =
0 are
   still sitting in flows[1..rx_flow_num-1]'s completion rings.
3. When prueth_destroy_rxq(emac, qid) subsequently drains flows[qid] for
   qid >=3D 1 and calls prueth_rx_cleanup():

drivers/net/ethernet/ti/icssg/icssg_common.c:prueth_rx_cleanup() {
	...
	} else if (swdata->type =3D=3D PRUETH_SWDATA_PAGE) {
		pool =3D rx_chn->flows[swdata->flow_id].pg_pool;
		if (pool) {
			page =3D swdata->data.page;
			page_pool_recycle_direct(pool, page);
		}
	}
}

   rx_chn->flows[0].pg_pool is already NULL, so page_pool_recycle_direct()
   is skipped and the inflight pages from flows[0].pg_pool are never
   recycled, causing page_pool_destroy() to stall and leaking the pages.

[Severity: High]
Can prueth_create_rxq() also hang in napi_disable() when its error path
calls prueth_destroy_rxq()?

In prueth_create_rxq(), if prueth_prepare_rx_flow(), xdp_rxq_info_reg(), or
xdp_rxq_info_reg_mem_model() fails, execution jumps to err before
napi_enable(&flow->napi_rx) is called:

drivers/net/ethernet/ti/icssg/icssg_prueth.c:prueth_create_rxq() {
	...
	ret =3D prueth_prepare_rx_flow(emac, id);
	if (ret)
		goto err;
	...
	napi_enable(&flow->napi_rx);
	return 0;

err:
	prueth_destroy_rxq(emac, id);
	return ret;
}

Because netif_napi_add() sets NAPIF_STATE_SCHED and napi_enable() was not
called to clear it, calling napi_disable(&flow->napi_rx) at the start of
prueth_destroy_rxq() loops forever waiting for NAPIF_STATE_SCHED to clear.
Furthermore, in prueth_init_rx_chns(), the shared ringrxfdq is sized to
PRUETH_MAX_RX_DESC (512) while each flow pushes 512 descriptors in
prueth_prepare_rx_flow(), so opening an interface with emac->rx_flow_num > 1
deterministically overflows ringrxfdq on flow 1 and hits this hang.

> @@ -1160,6 +1179,9 @@ static int emac_ndo_stop(struct net_device *ndev)
>  	prueth_cleanup_rx_chns(emac);
>  	prueth_cleanup_tx_chns(emac);
> =20
> +	/* Cleanup RX flow classification rules */
> +	icssg_rxnfc_rule_cleanup(emac);
> +
>  	prueth->emacs_initialized--;
> =20
>  	return 0;

[Severity: High]
Does calling icssg_rxnfc_rule_cleanup(emac) in emac_ndo_stop() cause rules
to be lost across system suspend/resume, while rules added before
emac_ndo_open() or before prueth_emac_restart() lose their hardware
classifier programming?

Specifically:

1. Changing RX channel count in emac_set_channels() requires the interface
   to be down (!netif_running(emac->ndev)), and emac_set_rxnfc() allows
   adding rules while down. When emac_ndo_open() or prueth_emac_restart()
    subsequently calls prueth_emac_common_start() -> icssg_class_default() =
->
   icssg_class_disable(), all RX_CLASS_OR_EN registers on both slices are
   reset to 0 without re-applying emac->rxnfc.rules via
   icssg_rxnfc_classifier_update().
2. During suspend, prueth_suspend() calls ndev->netdev_ops->ndo_stop(ndev)
   -> emac_ndo_stop() -> icssg_rxnfc_rule_cleanup(emac), which frees and
   deletes all user-configured RXNFC rules so they are gone upon
   prueth_resume().

> @@ -1676,6 +1698,9 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	emac->ndev->pcpu_stat_type =3D NETDEV_PCPU_STAT_TSTATS;
>  	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
> =20
> +	/* Initialize RX flow classification */
> +	icssg_rxnfc_rule_init(emac);
> +
>  	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
> =20
>  	ret =3D pruss_request_mem_region(prueth->pruss,

[Severity: Medium]
Can struct icssg_rxnfc_rule entries in emac->rxnfc.rules be leaked when the
driver is removed in prueth_netdev_exit()?

Because icssg_rxnfc_rule_add() allocates struct icssg_rxnfc_rule via
kzalloc() even when the interface is down, and icssg_rxnfc_rule_cleanup() is
only called in emac_ndo_stop() (and not in
drivers/net/ethernet/ti/icssg/icssg_common.c:prueth_netdev_exit()), any
rules added while the interface is down are never freed if the device is
unregistered and freed without being opened and stopped first.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103134501.4123=
194-1-m-malladi@ti.com?part=3D2
