Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793857165;
	b=tK1GonCig97KB0fNQvfnOuqvs0vuVXPcNrCKvo02Jt5gT44+22ZI4qDKRyHNBnGnLdb1
	 XXXt6zHyQoqmKlKlzgP5eOwJqC8rJAPRTtwj9cAnQK7uqI0+nt7fCiZURp9SAs86a/Q2x
	 CRLwNCGa+0/tjFT6uWA3LNsv5m5NZgWDPFGd3YfMeRyVxAblhkB88YfM+IM9e16Ci6eAU
	 N2ITslwnSu4nGDgys9Ae1KgGimrSNT/FR7bbni9GyomPJdbIJCw8OBDU9epXZdY6h/Yx+
	 GQWqjMQ9tYX76PY5CLLPJmER4qIDiRS0sXWg5JWcMa0mCSYzVZsTingvVQBjQDGNd6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857165;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xCuLV27Xk8S1aNk7y+ud/IujpXVyWAY+tdn8IQrFnsQ=;
	b=gBBuP3/bWpgyo1IdZrNE8j8+jT5wwsoZNuLJLPMlX+ikL/i1qXbTHGnW3lK8tW8cu+m9
	 XhFTVITkHS6fUBMsMvLPPKLncQszpfOfFrIQwuqjMqfuRC8lp0VHxB/hNOuY6pPxRd1v9
	 ypCKQlV2druLheDMGCfxvaR2nRrPXzNJABc0mwgFW8iIlVz6oEGW9Y6eE+WmbMMpFbXhn
	 qGOTQqQrpbHHTBZ3Z3pM3YAx8+nzaNRimxMEDXBmASQ/QAf7hYK/u6wUUmzZ4/v3pfG4u
	 579/4OKcavInvhB9nMSvfH4b0gBU496OeJsfp2Z8CAK1CQ3LHCDpzwUZm6FGYVMdR5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=LMwpWOSM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.39
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69726606A31B;
	Thu,  5 Nov 2026 05:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69726606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=LMwpWOSM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhvIuujdZYUYXU/G6Y3VJnUvn6dYIX7c7T9jr57GbXvQUTzK6sSCBBBpS7CBUzVlu4JGKd/MwZU/8QEPqIgYREszWgAeI6rPQI28CpgoW5zj0pFf/CO0pdWEhZD6H6DTwWnP3E7e2aqEyhxnxMmvsv1EoyjzIDuvf39rrT70g05lESptmNIjoQZ82oEbSGrmLbaJAJwWahT3vearZq0bZbbg3TiuSHpgumgGjK5veoV4z+PQjgq6UsRzWdWvTrJsTmlBQv+oDl93TiPkUR1cOo7e78VXpFZBcfAbK24xXkvJztw75yPCDZhYj4DCsy7AOsCO0v+jipGKnB5tKx1YPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCuLV27Xk8S1aNk7y+ud/IujpXVyWAY+tdn8IQrFnsQ=;
 b=KjoaJZGOGi6TWtkw+At5UEJDfc/9aL+6CYHNKBz4+V+PoHXO0lMlCNTFsD0rS642SDXDEOi/CN5eIxQC8EZievONv/MCxYBX5FAwqnR1DtqQO3hFYpYf3I7oXwX6tBLMEDVUDaJH470V+GyODsYxxr230omM/wEAk9x160Gdz2aY8hFKUkbPNoRawH6Jh9a3P8ybWc+2lrgO82AS4SKHAkk29jMy7NluL9/6hRnQrUhSISHOPC4UX08DTHLgxkvK3PcQO8HJNoTz4HxqB3NWw2HYhXuKzpc8uFFBhTcPzhIGcqW/cQffyz4+a1p/6NRTgmq4aWOp1SfRjuWjtov+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCuLV27Xk8S1aNk7y+ud/IujpXVyWAY+tdn8IQrFnsQ=;
 b=LMwpWOSM1bSRBCMVRV6RPG1F4mCnScA1urZ085YxInTSxW73TDFA4m68+67N+ElzzXXotPisgsdBVpmJXoepax3VJCeX1v4UzP7XSHbFlqJ15PQKOrT64QLut+zYWgn/S/wyO3FLXHOofIBElqvkgzq3sFDOY79RRMPa4iL6oVNA8nuje6S22+YRTr6ZjLm3O7jOfVciqXu/PJlE4IM2M2nIONjIJXg7m8Hjk+nBgDl/xV7mqno3aiTZCohSpIx60HKBYjmohnInUC4ihoD3f9M69gjnUNPyNflWrzEZXbEsW7W0WFrAJMXqWEI3K36hB2maEaz035uJmFONu2MBcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB5791.namprd03.prod.outlook.com (2603:10b6:a03:2d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 05:39:18 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0569.010; Thu, 5 Nov 2026
 05:39:18 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	ansuelsmth@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	faizal.abdul.rahim@intel.com,
	noor.azura.ahmad.tarmizi@intel.com,
	yoong.siang.song@intel.com,
	rohan.g.thomas@altera.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: Disable queues before netif_tx_disable in xdp_release
Date: Wed,  4 Nov 2026 21:39:16 -0800
Message-ID: <20261105053916.22353-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: b48d5bd9-3fcf-49d9-11ea-08df3aff226b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261026121527099003|261022075727099003|11063799006|261021123027099003|261021121427099003|261021135927099003|261009223027099003|261102123227099003|56012099006|261009221227099003|261026140227099003|261028144727099003|261022105027099003|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AxmT3K43NfK7tzD5C7Z27XOWQA00yVdFok9ixYBzEWtzfUAjrhQaPaK+wz+dDQ/E/iMlrtnY06AHearASv7k6g7dXQP1KChiiijh+i9nyeH9gFX71TC22D13lHSw83H85cAW/SuA7MZZg6bxQNy8jpSVLEYiCoNYvI3JXE6LF2Z287yqZ6yvfkBmAZ7SYm/8sH6gHa5URFE/RWixuikBgZqHha7fzWbXjmZ710eiU8C4qr/8sfxn6iJ/c4RdroK6av/Rnf9pELF7xHltiFenituv65Mo3lJfzLRtr3J/DXTwQK1rxkqRJ3vRDERXyyQ84jdW77DrYicg3g8eXdx87vzfM+WKs5X9xdTF0hraXrUc8DPDGspziFDgnVeEoNuDAVzuo2o9RD/Nf/mr7Ht+4Bu9LCdTp665SZWa8NzKgEdB3PGDVNQcjhEImip35AVR4K0pucpXolZ38uxlnVxF/m9u05tXFd1FZ6+77pBwf8LPVm6Q4Oin8gFV93j5iy4PMaNc4W3hfBqcf7D61LeSE6riuOGG2NBQ7d4Nv3aZ8XeHMzgYj8Gbs+bY76eEAjjrjmKDfv9PaAnOZG8i5+zD2Y/+cQXazecNNqsa9xPyiI8AGH66VYnNHkzs17jXDlQK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261026121527099003)(261022075727099003)(11063799006)(261021123027099003)(261021121427099003)(261021135927099003)(261009223027099003)(261102123227099003)(56012099006)(261009221227099003)(261026140227099003)(261028144727099003)(261022105027099003)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcg4+hwgNbEdBh3nFDv3eUvVk/X1YBHP0lwx1KKYurtkfFybu3yBdz/eHMVW?=
 =?us-ascii?Q?g5JZzmL9ZXEgjiTk/aRDgs18iQQwalPp9ZuuFlxVJUsGTPyXfUewO1lofANd?=
 =?us-ascii?Q?mPsP8pUf15RCJELrbwwN7ux8lVrqcKoF1qPxQMNs6OFkeZdGCyfXg2aCMxEn?=
 =?us-ascii?Q?X5jEiR5M7jB0qqwYT3+0ONbLOq5cbrHpUt+FIPFfXV6zZLmg/SLiEE/I0OeL?=
 =?us-ascii?Q?Gj1NSmmU+q2nHYMzOWXhrCHG5z+btVpf8JC0/fP329JYECZB/sUbjD+iJRrr?=
 =?us-ascii?Q?75ePbdnoFH+LR62hsqrqtRpX26s8ZDw77hwFCuq3kjXxf8pDwjAbLj8UIEE8?=
 =?us-ascii?Q?Hp5fs/UOYvOzbqARVedfTzU5H57RZEB9KAS9IEtjpgK5g820nzzcE5Q+jMcg?=
 =?us-ascii?Q?X+Fh0hdNVBqUcoOI3bxyeKtIIDOzRFXa+tMbFQznolD3o9xDeOz6nhYWxo88?=
 =?us-ascii?Q?kegKitB3yfXdrR+aALYQ9mCI1Vk3zXYc8XlPOvvQ+x+tnYSHBUzRRuxFZbOW?=
 =?us-ascii?Q?Dxd2B0izrfsVWITjDoxToYOlau9Oq0zVN0svhCvDBV3q8L+UF0MlQyLA5aF0?=
 =?us-ascii?Q?ir79cJJmTbyt6oqBmb4z3fcKFueCFuCcVCY96AeJdvvdBV0VZrOfsvKEZ26z?=
 =?us-ascii?Q?70jv32/SfALcvJXXgen+g+vJg2qWtHVQhnBFnNKksDdeOVkZhyU0B/J08jnK?=
 =?us-ascii?Q?fT2UE62VsqCb1FkwUIgFYZKXanbw0KcAczA85nzPPD/Jf1l0d339DpVrn437?=
 =?us-ascii?Q?i+2IgEwwhiD3JPptzYZN7JxEmToY09un6F5ZybHUaiII++lV21K56gZ+fHmv?=
 =?us-ascii?Q?M/eK//GTenoQDavazDkO3oRR5w0H91emkZqDQUZ/eHgCnHSUM4VvyxTYD7pI?=
 =?us-ascii?Q?1OrizW93t6QZpfccKHA1NRcBxrCbgqCC7zewl1jQMQ6fEsWcZKeUYALBCfdK?=
 =?us-ascii?Q?nhBazMrvYYHGPzANfBiBhxmUp0Liz1OsMnxXfB9QwvjJVlEOO89HkuLwB9qU?=
 =?us-ascii?Q?qlqrh+k1dKoVUZGSGJylTIZEu03O5QvP11/+dRre0JX2jnj/hpxHGnDQ8b9T?=
 =?us-ascii?Q?Zl+0XUCSvufSeh0ytXbnHdcVtA5NPIqscgk3tayXQQQnLWPIWdqPmYcEE1Yf?=
 =?us-ascii?Q?kyOdpFzEsNvIdKSchyoeNu2M0Bd8u9nn9p2fWLpHZ6sz/BivlB3BcCrPN1mB?=
 =?us-ascii?Q?H3Yb9cmYef1R69FYHVNoYsivjOwCXwnja4dI89Txf/NBeREZjMym86xsUqjk?=
 =?us-ascii?Q?s+SAHHy1+Vch8YdWyH5BRcXmPq6DTH1D7meJbv20aQuckHWN2cOJ2KmmVqES?=
 =?us-ascii?Q?daLCl+iVyl8KuxDHfHB5uHKNUFhx/S9hdQ2a81Ni3hcslsQMpPTn91OmF+cu?=
 =?us-ascii?Q?JQKd6H7u0iFXyb5HtqnHpaFeTzmQyJR032Hk9nPDd5RJxzv2oiiJTitaw+dX?=
 =?us-ascii?Q?3FFlbjgonbJhhuxNfotVIaS7/0IB+OPzZIwPg05sD8XudyHcm7NaZBmU2ZW3?=
 =?us-ascii?Q?+VqTbf5RjGnV7yu/Y9Vu0VadPnMxcuoNCL4hXuhYSWZOswvxKLltcefVaM5i?=
 =?us-ascii?Q?+mrm6+/+ZjI44DN6LTiaTK4JJoYRHtBYTApxiIOJQWDnglMHpQCfLex5uEfw?=
 =?us-ascii?Q?17MJIola3TBUtGjWgOZnawD2Nselrjew1UFwMnGtaVJ7r8f8BB9xj+EnzxF6?=
 =?us-ascii?Q?QA4QC4dKO9VRnCYleiST0N1ONpxRT/ckV5KXF0yoHLe2pDGQAIBieE/N+5cP?=
 =?us-ascii?Q?IUawp9v8g6sNrPDV0CwC3cVxme6rwJvISqCIl8iKZ41L/dKeQ5TfF/B6Ktxq?=
X-MS-Exchange-AntiSpam-MessageData-1: 2gQR8xGm9BTPjQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48d5bd9-3fcf-49d9-11ea-08df3aff226b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 05:39:18.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJMu43mrpIIqeR6De/Q+Nnt84EXA16pTlWI5sOPzndhOET9IhrJgfgfHXhHbIONzLudbHgcliuCO5Exl+0YDrEE8J3+0tHRoQhl/iF4LLszoTpnlJnBgK2Bto+tAhPFh8ngRXNEJGuZu/ID9YtDNXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5791

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

stmmac_xdp_release() calls netif_tx_disable() while NAPI is still
running. A TX completion handled in NAPI context can then restart the
queue through netif_tx_wake_queue() in stmmac_tx_clean(), so the stack
may call ndo_start_xmit() while the DMA rings are being torn down,
leading to a kernel panic.

Fix this by disabling NAPI with stmmac_disable_all_queues() and
cancelling the TX timers before calling netif_tx_disable(). This
matches the teardown order already used in __stmmac_release() since
commit 7028471edb64 ("net: ethernet: stmicro: stmmac: first disable all
queues and disconnect in release"), so both release paths stop NAPI,
the TX timers and the TX queues in the same way.

Once NAPI is disabled, NAPI_STATE_SCHED stays set, so
stmmac_tx_timer_arm() takes the hrtimer_try_to_cancel() path and new
transmissions cannot re-arm the TX timers after hrtimer_cancel().

Fixes: 77711683a504 ("net: stmmac: ensure tx function is not running in stmmac_xdp_release()")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v2:
- Fix the Fixes: tag to point to the commit that introduced
  netif_tx_disable() in stmmac_xdp_release()
- Describe the queue wake-up race in the commit message, and why the
  TX timers cannot be re-armed after hrtimer_cancel() (Sashiko review)
- The other two issues reported by Sashiko (ndo_xdp_xmit() racing with
  stmmac_xdp_release(), and stmmac_xdp_set_prog() ignoring the
  stmmac_xdp_open() return value) are pre-existing and not affected by
  this change; they will be looked at separately.
- Rebase on latest net/main

v1: https://lore.kernel.org/netdev/20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com/

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7ffed295eb14..7d1497392b8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7264,15 +7264,15 @@ void stmmac_xdp_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
 
-	/* Ensure tx function is not running */
-	netif_tx_disable(dev);
-
 	/* Disable NAPI process */
 	stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
+	/* Ensure tx function is not running */
+	netif_tx_disable(dev);
+
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-- 
2.43.7

