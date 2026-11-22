Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374068;
	b=dFGwRSksmLXutkvzGn3MybCg9J6HcjXvxU20BIRceTEGG+c9R1FVsbvdS0Nes7K5V8dx
	 8IntkoorJcpXtUTGIdqMVBqq2J5f42cf57f1wJWz25mUdawsShd3LdKsfPuwmNaFVUDdC
	 D2HkqG+jBSnQQxzQzfal5cgyt+KWAEYH0F25DOtIFUAmYQcF+U4heUk9ytG9+AgAjkqYJ
	 HTl7J2qrCeM5fMpEiBrU5aIQGooG8WMP7ulxk0YkYfR2DdJOCYD/IFPUUPbIQ4rbZA6PM
	 fqJr1MZhLgJ/mv2psfQAghZb09C2/NGNpbwkmVUPn1CL4XVAQ5qCTAbf6Mdqd6rmy6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374068;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BfevmL4Oh+NGbfVNDtJYmsCN5MA+HIS72JdqD1XFU0U=;
	b=j72vs4OseVqpHNseub7Cr2WRPjY1Qzps6T0JiQ49M8ZTd0YjwVAcpuRVyh6tpX4uZEJ9
	 ashyzVW6pnxko9SNTnX9belXQSnWhz5JG3UdeaN8XIKRQinPT9I92aPr3hnd7IHU6BIjR
	 yyutsIfPoYoi7UBasRoz5HDsDIRfBUF4syOG3RgWIbPMlxOL1kgfSXjqSZ1hZHBMIipyI
	 nCOWLfnNYTSFvQ9Pfo3EstED22b3+lgWEzvXtfSTbP63heqyw603ChXBQYNmLvA3jbswF
	 FEbWwWLboTdXLAdMOAohGvJgYzQoWlwkeIlrSzIkM6aq3SoB2Haa7fVfsVWt1JdVmhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYMUHm2h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB5606A683;
	Sun, 22 Nov 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYMUHm2h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EC61F000C6;
	Sun, 22 Nov 2026 19:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795374067;
	bh=BfevmL4Oh+NGbfVNDtJYmsCN5MA+HIS72JdqD1XFU0U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AYMUHm2hzcn8zfi6J/bIiZem+U4CLdnjh/lS5iIUZA0PDcpBJ3FYDzn1sbCMc5BhL
	 nKcPCdoq60vOmSqd8TZez8WLzLJtN88i+oBRRLcrB/f5790hykqFNIB0sXKfkd/EQn
	 zaVAXMID9nGtT3N84MouyEgI1BD3y5p4dmy2zMg+oQmICj+leyQurAdUybYRi0y5gY
	 MI+n7c6yF68LBaEL+DjAPx2LapTkldBXz4KliA5es8mdB74EL4CTFpPRVEECIZaz+8
	 18ht9xmheQROAJOEvnIUpksVxytBr6Mp1mnOVt98XLVnTPSmMWBGUo+HDoIlDnN1+7
	 FSpqOviFlKvew==
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool RX flow
 classification support
From: netdev-bot+sashiko@kernel.org
To: m-malladi@ti.com
Cc: marco.crivellari@suse.com, kees+treewide@kernel.org,
 laixiangwu@cmss.chinamobile.com, philippe.schenker@impulsing.ch,
 haokexin@gmail.com, devnexen@gmail.com, horms@kernel.org,
 jacob.e.keller@intel.com, sdf@fomichev.me, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, danishanwar@ti.com
Date: Sun, 22 Nov 2026 19:01:06 +0000
Message-ID: <179537406604.3135.2286814607338693538@kernel.org>
In-Reply-To: <20261118184729.2302130-3-m-malladi@ti.com>
References: <20261118184729.2302130-3-m-malladi@ti.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Installed RXNFC rules stop steering traffic after any firmware
  restart, and nothing reports it.
- [Medium] icssg_rxnfc_classifier_update()
  (drivers/net/ethernet/ti/icssg/icssg_classifier.c:620-652) zero-…
- [Medium] The rule-table size the driver reports does not match the
  locations it accepts and assigns.
- [Medium] ICSSG_FT3_RESERVED_SLOTS
  (drivers/net/ethernet/ti/icssg/icssg_prueth.h) reserves only FT3 slot…
- [Medium] User classifiers 1..rx_flow_num-1 (rx_flow_num can be up to
  ICSSG_MAX_RFLOWS via emac_set_channels) are left in the state…
- [Low] The patch adds FT3_CFG_REGISTER_EQUAL (1U) and writes it to the
  per-slot FT3_CFG register in icssg_ft3_program_filter(), with the…
- [Low] net: ti: icssg-prueth: sparse __be16 warning in
  icssg_ft3_program_filter()

--

net: ti: icssg-prueth: Add ethtool RX flow classification support

This commit adds ethtool get_rxnfc/set_rxnfc support to the ICSSG driver.
Rules steer frames to specific RX flows by EtherType, using FT3 hardware
filters and per-flow classifier OR tables. Up to 15 rules are supported per
EMAC, using FT3 slots 0-13 and 15, with slot 14 reserved for HSR/PRP.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> index 87a8577093dbb..520b3f3377784 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> @@ -105,6 +105,14 @@ enum ft1_cfg_type {
>  	((BIT(slot) << RX_CLASS_FT_FT1_MATCH_SHIFT) & \
>  	RX_CLASS_FT_FT1_MATCH_MASK)
>  
> +#define RX_CLASS_FT_FT3_MATCH(slot)	\
> +	((BIT(slot) << RX_CLASS_FT_FT3_MATCH_SHIFT) & \
> +	RX_CLASS_FT_FT3_MATCH_MASK)
> +
> +/* FT3 Configuration registers and modes */
> +#define FT3_CFG_REGISTER_EQUAL		(1U)
> +#define FT3_CFG_REGISTER_VLAN_SKIP	BIT(2)

[Severity: Low]
This isn't a bug, but it will produce a sparse warning. h_proto in
struct ethhdr is __be16. Assigning it to the plain u16 ether_type
drops the restricted type with no __force. make C=1 then reports
"incorrect type in assignment (different base types)" for
icssg_ft3_program_filter().

The (__force u32) cast in the FT3_T regmap_write() further down does
not help. By that point ether_type is already a plain u16, so the
__force sits on the u16 to u32 widening and not on the __be16
conversion it is meant to cover.

The changelog says this was skipped as low priority. The fix is one
line, though: declare ether_type as __be16 and keep the (__force u32)
at the regmap_write() site. That is where the network byte order
value is deliberately written raw into FT3_T. The variable's type
would then also document what the long comment above that write
explains.

As noted earlier, FT3_CFG_REGISTER_VLAN_SKIP is also added without
any user. Can it be dropped until something needs it?

[Severity: Low]
This isn't a bug, but FT3_CFG_REGISTER_EQUAL has the same value (0x1) that
icssg_ft3_hsr_configurations() already writes to the same FT3_CFG register
under a different name:

    regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_CFG), FT3_VLAN_MODE_BOTH);

Which of the two names describes what bit 0 of FT3_CFG actually does? Also,
FT3_CFG_REGISTER_VLAN_SKIP is never used.

> +
>  /* HSR/PRP protocol frame filtering */
>  #define HSR_PTP_ETHERTYPE_OFFSET	0x12
>  #define PRP_PTP_ETHERTYPE_OFFSET	0x0C
> @@ -532,3 +540,402 @@ void icssg_ft3_hsr_configurations(struct regmap *miig_rt, int slice,
>  	}
>  }
>  EXPORT_SYMBOL_GPL(icssg_ft3_hsr_configurations);
> +
> +/* RX Flow Classification (ethtool) rule management */
> +
> +/* Allocate free FT3 slot, avoiding reserved slot 14 */
> +static int allocate_ft3_slot(struct prueth_emac *emac)
> +{
> +	u16 used = emac->rxnfc.ft3_slots_used | ICSSG_FT3_RESERVED_SLOTS;
> +	int slot;
> +
> +	for (slot = 0; slot < ICSSG_NUM_FT3_SLOTS; slot++) {

[Severity: Medium]
Is slot 14 the only FT3 slot the HSR/PRP configuration uses? The existing
PTP duplicate classifier mask also covers slot 9:

    #define RX_CLASS_OR_DUP_PTP		0x4200

RX_CLASS_FT_FT3_MATCH_MASK is GENMASK(15, 0) with shift 0, so OR_EN bit 9
is FT3 slot 9. In HSR offload mode, icssg_ft3_hsr_configurations() writes
this mask into classifier 10:

    regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_PTP_DUP, RX_CLASS_AND_EN),
                 RX_CLASS_OR_DUP_PTP);

ICSSG_FT3_RESERVED_SLOTS is only BIT(14). That means this allocator (once
slots 0..8 are taken) or an explicit "loc 9" can put a user rule in slot 9.
Nothing rejects new rules while is_hsr_offload_mode is set.

Would frames matching the user's EtherType then also hit the PTP duplicate
classifier? And if the firmware uses slot 9 itself for HSR, would a user
rule there overwrite that configuration?

> +		if (!(used & BIT(slot))) {
> +			emac->rxnfc.ft3_slots_used |= BIT(slot);
> +			return slot;
> +		}
> +	}
> +	return -ENOSPC;
> +}

[ ... ]

> +static void icssg_rxnfc_classifier_update(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	struct regmap *miig_rt = prueth->miig_rt;
> +	int slice = prueth_emac_slice(emac);
> +	u32 or_table[ICSSG_NUM_CLASSIFIERS] = { };
> +	struct icssg_rxnfc_rule *rule;
> +	int n;
> +
> +	if (slice < 0)
> +		return;
> +
> +	/* Build per-classifier OR table: classifier index = target queue index */
> +	list_for_each_entry(rule, &emac->rxnfc.rules, list) {
> +		int cls = rule->queue_index;
> +
> +		if (cls < emac->rx_flow_num)
> +			or_table[cls] |= RX_CLASS_FT_FT3_MATCH(rule->ft3_slot);
> +	}

[Severity: Medium]
For rules targeting queue 1 and above, what limits classifier N to frames
actually addressed to this host?

icssg_class_disable() leaves classifiers 1..15 in this state:

    rx_class_set_and(miig_rt, slice, n, 0);
    rx_class_set_or(miig_rt, slice, n, 0);
    rx_class_sel_set_type(miig_rt, slice, n, RX_CLASS_SEL_TYPE_OR);

Only classifier 0 gets the BC | DA_P terms in icssg_class_default(). This
function sets OR_EN to FT3 bits only and never changes AND_EN or the select
type, so classifier N becomes a pure EtherType match.

Take rx_flow_num > 1 (set through emac_set_channels()) and a rule such as
"flow-type ether proto 0xXXXX action 1". Could unicast frames for other MAC
addresses that carry that EtherType then reach host flow 1, for example
flooded traffic in switch mode, even though classifier 0 would not accept
them?

validate_rule() requires zero h_dest/h_source masks. In ethtool, a zero mask
means "don't care" among frames already received. It does not mean "accept
regardless of destination".

When a frame matches both classifier 0 and a user classifier, is the
priority between them defined?

> +
> +	/* Write OR tables for classifiers 0..rx_flow_num-1. Only update
> +	 * classifiers within the user-flow range to avoid disturbing HSR/PRP
> +	 * classifiers (e.g. 10/11) beyond it. Use RX_CLASS_N_REG with
> +	 * RX_CLASS_OR_EN — NOT RX_CLASS_OR_REG which uses rx_class_or_base
> +	 * (= rx_class_base + 4), causing an off-by-4 that lands on AND_EN of
> +	 * classifier n+1 instead of OR_EN of classifier n.
> +	 */
> +	for (n = 0; n < emac->rx_flow_num; n++) {
> +		regmap_write(miig_rt,
> +			     RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN),
> +			     or_table[n]);
> +	}

[Severity: Medium]
Does this write wipe the default host-receive terms in classifier 0?

or_table[] starts zeroed and only gets RX_CLASS_FT_FT3_MATCH() bits.
Classifier 0, though, is the default classifier that icssg_class_default()
sets up on non-SR1 parts:

    data = RX_CLASS_FT_BC | RX_CLASS_FT_DA_P;
    ...
    rx_class_set_or(miig_rt, slice, n, data);

emac_ndo_open() calls icssg_rxnfc_rule_restore() on every open, even when
the rule list is empty. So classifier 0's OR_EN is set to 0 every time the
interface comes up, the same value icssg_class_disable() uses to disable RX
traffic. If a rule targets queue 0, classifier 0 matches only that
EtherType.

icssg_rxnfc_rule_cleanup() also writes 0 to classifier 0's OR_EN:

    for (n = 0; n < emac->rx_flow_num; n++)
        regmap_write(miig_rt,
                     RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN), 0);

The restart path leaves classifier 0 at BC | DA_P. The hardware therefore
ends up in different states depending on whether the last reset came from
open or from a restart.

Should this do a read-modify-write instead? It could keep the non-FT3 bits
from rx_class_get_or() and replace only the RX_CLASS_FT_FT3_MATCH_MASK
field.

> +}

[ ... ]

> +/* Restore RX flow classification hardware state from the in-memory rule list.
> + * Call after icssg_class_default() resets the classifier registers on open or
> + * after firmware restart so that existing rules take effect again.
> + */
> +void icssg_rxnfc_rule_restore(struct prueth_emac *emac)

[Severity: High]
This comment, and the one added in emac_ndo_open() ("rules must be restored
here on every open/restart"), say rules should also be restored after a
firmware restart. emac_ndo_open() is the only caller, though. Are the rules
lost when prueth_emac_restart() runs?

prueth_emac_restart()
    prueth_emac_common_stop()
    prueth_emac_common_start()
        icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
        icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
            icssg_class_disable()   /* OR_EN = 0 for all classifiers */

Nothing on that path calls icssg_rxnfc_rule_restore() for emac0 or emac1.

Several paths reach prueth_emac_restart() while the interfaces are running:

    icssg_change_mode() (bridge join with both ports, and HSR offload
                         enable via prueth_hsr_port_link())
    prueth_netdevice_port_unlink() (bridge leave)
    prueth_hsr_port_unlink()

After any of these, the rules are still on emac->rxnfc.rules and ethtool -n
still lists them. The classifier OR_EN bits that steer FT3 hits to the
target flows are gone until the next ifdown/ifup.

Should prueth_emac_restart() restore the rules for both ports after
prueth_emac_common_start()?

> +{
> +	struct prueth *prueth = emac->prueth;
> +	struct regmap *miig_rt = prueth->miig_rt;
> +	int slice = prueth_emac_slice(emac);
> +	struct icssg_rxnfc_rule *rule;

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index 68646cb7df442..35eb056dab6d9 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c

[ ... ]

> +static int emac_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *info,
> +			  u32 *rule_locs)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int ret = 0;
> +
> +	if (emac->is_sr1)
> +		return -EOPNOTSUPP;
> +
> +	switch (info->cmd) {
> +	case ETHTOOL_GRXCLSRLCNT:
> +		info->rule_cnt = emac->rxnfc.rxnfc_rule_count;
> +		info->data = ICSSG_RXNFC_MAX_RULES | RX_CLS_LOC_SPECIAL;

[Severity: Medium]
Does the advertised table size match the locations the driver accepts and
assigns?

ICSSG_RXNFC_MAX_RULES | RX_CLS_LOC_SPECIAL advertises a 15 entry table, so
locations 0..14 should be valid. icssg_rxnfc_rule_add() rejects explicit
locations of 14 and above:

    if (fs->location >= ICSSG_RXNFC_MAX_RULES ||
        BIT(fs->location) & ICSSG_FT3_RESERVED_SLOTS)
            return -EINVAL;

That leaves only 0..13 available as explicit locations.

allocate_ft3_slot() loops up to ICSSG_NUM_FT3_SLOTS. Once 0..13 are in use,
an RX_CLS_LOC_ANY rule gets slot 15 and is reported back with
fs->location = 15. That is outside the advertised table, and "loc 15"
cannot be requested explicitly.

> +		break;
> +	case ETHTOOL_GRXCLSRULE:
> +		ret = icssg_rxnfc_rule_get(emac, info->fs.location, &info->fs);
> +		break;
> +	case ETHTOOL_GRXCLSRLALL: {
> +		u32 rule_cnt = 0;
> +
> +		ret = icssg_rxnfc_rule_get_all(emac, rule_locs,
> +					       info->rule_cnt, &rule_cnt);
> +		info->rule_cnt = rule_cnt;
> +		break;
> +	}

The ETHTOOL_GRXCLSRLALL case never sets info->data. The ethtool uapi
documentation in include/uapi/linux/ethtool.h says this command returns the
rule table size in @data. Should this case set info->data too?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118184729.2302130-1-m-malladi%40ti.com
