Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BD43F09C;
	Fri,  7 Aug 2026 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084230; cv=fail; b=l3Tfdp+Sfi0mCZzKgnhA4zY8nLDpX1GCqPPyyHHoBwh0vETD8nvKcvsKTbIn/GMzfrMb4qh6pkryuEEu+YiZ4BfeUwG/Az60g3AHUiLZc/N4jhxQRQ5D84ILL18OmHJjxrB6cVDURbqkGUWITSRHY7zF+lNXJCC8FiPFBD7LdL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084230; c=relaxed/simple;
	bh=gMSJXMj2VnWcl7eWaK12lz1d0PHZmfcPOuxu6XEmnJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bO3AwRai1gprGJcohdzV6/84LKV6D4+l19IDY5HalWIaZ3G9wgPIOAyAsUbsQsd4rvN59h/667/D+f1coIApLLXwDh+3JQJgW2uVS8mszGdBFxMKK5YyHk6QpdF4biNbBc03ciDChr/x/s717kriX54gPsvAQbVTIPIgmSUAcaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZUvT5ozr; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZUvT5ozr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuI4csIIAcscTDu3aS42FaqNiAi4kdPT9v9LiyltAhqTI3LVXb7Crg+UWQI9o6sABJ6PbK6nooY4rMPNv/syk9ZNkM49zkyRBpMFJ81z9cyvl9/nBOQaxUtBSySaTNk0CCLEozlYYyJDpW8ICxVK/02Myc0u8u5uSce855dWGNZbmzIJdPfuFBUov5FLly+ddo71N1VWiqO8sbN3GZay/8nSQgK3tWQgg3NEyDDCoZAzNFrFCWa+DAVTn4D5dXv1ELfil9LB44ufv2Al6WyxgUHTzGUFpo9B1CVSA+BFhaLsww7Ks8PhwsC1pReit0sseXL7j32A8VX9AtMP0XNMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNIfm5P7YkH72RWKgi/JoQt2b2XZ5J9cDUPk8v3OTk0=;
 b=eWAz55VIlIp5R/nxSnXC5Ayi7p3HMTSHY0mkK+VShSX9FG3B72LOZxAttm0IoCha9JGnHB32zEyAWM4/s9eGJg3s6XK5xCY3kkcVJCKvbcb1N114jiqddBBBNp4oyxDH5xxzR3YDdtW3TBJWjFWGATdEkUoAKPDDL/iNQz3VD+4ClMUYlfrHar4czjU22SN5etKg0/YV3LsCbChKpYDpNdFRtLrp4LFKhiqcQDO6P/KGXU9+MVRdfkMN4z6V4fMoiJi1Gb9bMyzzDTjfDBg6gLDOj/7RzJTPvCUXN9kJQOq599WOaSZnPslrTWKVWFibbmhpa+l5ip6hfkRUrEKTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNIfm5P7YkH72RWKgi/JoQt2b2XZ5J9cDUPk8v3OTk0=;
 b=ZUvT5ozrUmBXnGZlyQurqucG3ymlTc4rO+o3b/EaxOoONKZ/HNEGzCdVGE3maW2fNCM14QiHvzUHe/NrNXXGx9iDUeEUorzJNYKkvmnFqj8CF050/SciN21AbgljDMX1N+sjYk9aYMBHxus+xtvu7Q54IMa0omdHJMV3Oevup+D61JLvyRfGz4JNOUZdi5pCgEoRrTsh2I80jORATi+bYuT5/iBR3kis2ie8PoGAmBO16jNsPZ/xbx7XMKx4/PbCpEfBzKD1Qe5c7+QHzwLS4+7B9sYNy+1hjPkzNGXm66yK4nmrSpZ+mtE7fyWPFB3iFVZkaFKCy6CXTRNTZ6l+xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by AM8PR04MB7954.eurprd04.prod.outlook.com (2603:10a6:20b:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.22; Fri, 7 Aug
 2026 06:30:25 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 06:30:25 +0000
From: wei.fang@oss.nxp.com
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	liuhangbin@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 net 1/2] net: packet: fix wrong transport_header when sending VLAN-tagged frame
Date: Fri,  7 Aug 2026 14:34:04 +0800
Message-Id: <20260807063405.688780-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807063405.688780-1-wei.fang@oss.nxp.com>
References: <20260807063405.688780-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|AM8PR04MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 805a2fb2-5af3-42aa-9628-08def44d5d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|7416014|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Wf3+HCQ18Vy09R4ujq9/WIUW7HfOkDlGzsCMPq1UlaHssJ/rs+gQwoNAR3lyLFJHjvqRMTRmqzhnWDU1pTsodX8nJ89Bh5kaaOBknjbjikiN7UqUyPw2QmKgsh2ZOIO98r6Ew333AjHmt9B6+Fv9P3+g4Td7zQsV0ER3v1UX9hJ2d8kjmo0hXUAOXgi2XMHlNd4ERCkzeZDA91iTXkc430To92scfWQOtOuFWqZVeDAGzv7sVD34woPaKTHSl1Q56xIIAxBrGlwNb3LQKhNdKzU4tyTqBNqql72KJY6XPheow+SwNYTaFPhRAyp2Bb4Ru7hpzpEVRjMjtonADsod3C+BGtYWr+7OhXYlXJAxuxFikJ4i1afcrG4D24xGUg3Bpz4RkJy+5/Sz7fJiD4A4QU3oYeWrvofm1kj0b0kznQhramJWAeOCew5QWRiP3hrKtX+pw14qDOVjPvgVz4bxwMkkSxyo3Aj62cnxqZkjZOTsqouoExfX2/hzYDN6lVyBEcKezWjXX86m4+L6PEEykc0exnTTpWVCYoZHiV02snsYvQ5Ju88g1+wNq07U7og8F3hhERDZFFje/xZ8Sd+7p6xtrXMCO75LraFmFLNh7NvmD7r1gJw2l0xvCEfoTcN0UgigCFeXG34SuDy8eQerBo6GU12s530pHXnqXZOxsldUx/ZwnPtluX6Y3101P3bwgrhfkaNt16W/NMuTncLACQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(7416014)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZiaYj5LieEJvQL2Tgurl6Y36abi7FLgWu8TrNwYoNe4JCdif0Q7BJVGt+n9v?=
 =?us-ascii?Q?2IvaXRHUsG4HlepplWPbg+JW9lY+HzCRl+fyIQOQ6fmoqcbVphdBPxMCPL+A?=
 =?us-ascii?Q?gg8NaF4On3+2OFGuwuu/xGUxB9ZoqqG7ewYDXm0q7KeAt+x2eUBx59W7HImH?=
 =?us-ascii?Q?4iPkRwVOcmoKVkyIwpl0PenO/B+sgbM3FAXKvL9k1n9YVjtS00g6HI7G8GRN?=
 =?us-ascii?Q?KUX6ZtNCyShMqpDigNd+PUt4fQ1zEO99vuhn+bp+nO1XUM5tVMKQGPRu/IDg?=
 =?us-ascii?Q?tsDxIPuGOwSJv9urZEwgQgcVg2h66Uz3VNP8TtKX4L/JKWMucbplHiszhfd0?=
 =?us-ascii?Q?zxUbmByZErMOAvnB52W4+Hk9RwbvJKu5b3R2Dz5u9bwe4+Vpw4rSpeH9j12i?=
 =?us-ascii?Q?sqq7wPEv80u8JpAe72WRuMXhoPyUy8uwJdrzSHH3qoyHoKIBZr+9bAJch4uF?=
 =?us-ascii?Q?xqkswy5Dyyb77lgJQxWjcoXjtxBvvk4FKlyoNe5dlAbVhEeftJSLOO6hip93?=
 =?us-ascii?Q?HJWoA+Stx//olHQ6ARidTE2PI17ftdscLl+CzkEVRcaOQuINYCfMy6typP3Q?=
 =?us-ascii?Q?0B0o8UuPcrdR0QoaH6/uScn3f6UcZvIAtQWbA2LghLZONlZGW1wKCDiBnEe0?=
 =?us-ascii?Q?6stkctxnkEjrWCDgDBzUmvRVBo9jtG78U2D4HV1Xz12xWbLIGeUROk11udlp?=
 =?us-ascii?Q?xsSwo94KdGV5HFEN5Iu68mer1xYwUIcKSFhJZM2IEoMS5gXlJW7Ft/2qqx1F?=
 =?us-ascii?Q?s4QD5V5vRKMRhePAeGwyplPWgDWQbsH1XjY30WTnBmb/XDaHQh4+vM4MkjKT?=
 =?us-ascii?Q?jnhhoKn5ZQO1VFAiw1EmxpMttwC8ye/OUSE9ZlyAqve8pkfu6fxdIO1W6z3+?=
 =?us-ascii?Q?Wkl7kO3J7jJ0o9j6nwKKR0VaKi+fG1MkdaLvgpjTT+ltChIRI92vpRL+gzgF?=
 =?us-ascii?Q?0/3cH6y8D33jL9UV65Vd/afK3H6MuG9eshzLyhfIUVjh5pfe/5uAdbKVb/Lj?=
 =?us-ascii?Q?7kOJ26/Bj0EhmVQKE851Jku+Ljpf1W0XJ/eC9EVPhonTo0tluU9mV25+VWKl?=
 =?us-ascii?Q?SDb3uzH6xaIpFIErwbY3zO8JPmi4sWIGZyqeOvvz0EE4yOcd++jJhkv6E6B5?=
 =?us-ascii?Q?TEXAgti9FH6Mhr0nKpUcbiSsOFuDv0RxPTszpV9HCakqv17BbXtpwaz1FjSJ?=
 =?us-ascii?Q?kf4wFBtNVf+UbizjqvRn6dHix2pCdJcEfvErORujlihMRQ7Zh234cpcc6J3W?=
 =?us-ascii?Q?WbX9Wwv4JObwE5T4StQmVZE9RsVCPqyZZJcn8Kj12lPPVH2O4LLAamQAvRWa?=
 =?us-ascii?Q?+v0D/mHJhD/9oqINIyE1Xvj12PbcZ+h51xQuqAKBCI4RmwQExq4sx5BnbiS9?=
 =?us-ascii?Q?48Cin+5U07JkIpTegiadPojwYP3HE3yn4A/m40i9FEmanCsvcFX/dn1H6vg5?=
 =?us-ascii?Q?QHi3/ynbO16cnk98qX0IFRJhvlp3Bg1SOmW/zTfXHFNXINBkeNb9U9rkjS7/?=
 =?us-ascii?Q?SWGMPw+cq4/NdZeRvq3j9L05y0OM4KMVf5EVmVq4C5QWqFKQhIZbsxFhhYaW?=
 =?us-ascii?Q?ZLrD524z9TmOQeOB08VqA8Birpo83WMzZDva7LMMCY9b/MivJgV1jPKI2Ryr?=
 =?us-ascii?Q?YmruOaVn+odl/JduytrKhDrImkqE0jhI6oRPqvJzu0w1lx/hJvF3EJPRCR+R?=
 =?us-ascii?Q?mAfc/6wTaqvQTbUR1+/Tea62nDRNm+nNkaLL7WMIghoR3agKZRABGNmRrunl?=
 =?us-ascii?Q?kejtgfn+LJ0oni5mCzeF0Do+vwG1OwE7v1NIeiER20VHJhOSVq2Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805a2fb2-5af3-42aa-9628-08def44d5d15
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:30:24.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIQvdbAfv7FEytYdjJqT1vzUOluHW9j6k2qH5KYZS173dfJRqP0OwnibqzkxndWteTJlWkdZ6fffzHpRdqfGulGBU8Hs7PmVsT3EitYKOy1I1I99RtdtgFgohZm/HMT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7954

From: Wei Fang <wei.fang@nxp.com>

In packet_parse_headers(), when processing a VLAN-tagged frame,
skb_set_network_header() is called to advance network_header past the
VLAN tag to the inner protocol header. skb_probe_transport_header() is
then called with skb->protocol still set to the outer VLAN EtherType
(e.g. ETH_P_8021Q), while nhoff (derived from skb_network_offset())
already points past the VLAN tag to the inner protocol header.

In __skb_flow_dissect(), proto is initialized to ETH_P_8021Q and nhoff
points past the VLAN tag. When the dissector hits case ETH_P_8021Q, it
reads a struct vlan_hdr at nhoff via __skb_header_pointer(), but that
offset contains the inner protocol header (e.g. an IP header). The bytes
are misinterpreted as a VLAN header, yielding a garbage encapsulated
EtherType that matches no known protocol. The dissector returns false,
so skb_probe_transport_header() never calls skb_set_transport_header(),
leaving transport_header at its uninitialized sentinel value (~0U).

Move skb_probe_transport_header() to before skb_set_network_header(). At
the time skb_probe_transport_header() is called, network_header still
points to the VLAN header, so nhoff correctly points to the VLAN header.
The flow dissector can then parse the VLAN header, extract the inner
EtherType, and advance nhoff to the inner protocol header, allowing
transport_header to be set correctly.

Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
Assisted-by: WChat:claude-opus-4-8
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 net/packet/af_packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 435756877aba..213a8a3b7ee5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1943,13 +1943,13 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	    sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
 
+	skb_probe_transport_header(skb);
+
 	/* Move network header to the right position for VLAN tagged packets */
 	if (likely(skb->dev->type == ARPHRD_ETHER) &&
 	    eth_type_vlan(skb->protocol) &&
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
-
-	skb_probe_transport_header(skb);
 }
 
 /*
-- 
2.34.1

