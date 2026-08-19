Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013034.outbound.protection.outlook.com [52.101.127.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCF3793D5;
	Wed, 19 Aug 2026 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130286; cv=fail; b=G89QLNqE/A+tUMOJCpoYFPHXRmqGL94SG8MiQsjntgp6/jOE+EdZhBN+TiKgCwkoECeoKsLV72ikBlUrEcBfv8DCIJ9AvCinYHLkm71ed/coG5XuZTIBvJwtFS3rq1mpip6upyXCXKr6glX/t2iSvw7eeurO/G2GxtqecSlRLGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130286; c=relaxed/simple;
	bh=2e12ss7vDErqkxflgWk4L6EZid8xZNTItN7LhkNzntM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h27wpSitrgnINeGtlm0BsQZDeR+RGCc0ikpmhAx1GhNIJnL2An/BDQG18ZoFH5Z5TDm2yy+8vtTq8eRWrXeMsHO03dC5fg6oynGDaNroQCncrAh8cp8ZN2rSH0jwZxfGDfiJYOZr/5oFcNJBwlwjy4KA7HE68v0LSW+n1KnoQgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UXEPBEou; arc=fail smtp.client-ip=52.101.127.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UXEPBEou"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmMWIad7vPI7VGOFnOB9EwxN5znRKaTlWJcE1DY0q9kVK15imi6WtEiyPD4dN729oU7wrtVHp0QbfhVnboHXLSmPhScVo4YuvYvkegZyUutSu+H9349ZuPu8CW3PHjIM6FfG9ooMNX+Wkdbsqsp/L/eUw1AsQPlEehBtEyYy7l3RSy8ZSeu/6kXyySK2y4NSZryvqAj0HUoRx1rpcfhsP845LchS5aNNLP6rhHSbtHZtjLhuPNQXs+YdJwUcQ0ku4sO8Xbt+TdlkSOYd9Su32hq34wQFnYQ4jiNtXnJQtkEw2yTd/xtwgIURreKg7v+9SLMNBKKg7VYguN5EamunTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFt3qr4UIOWKeDDA2TlOGfotGXQP9Ob6+3PWWxbw0DM=;
 b=wgWJvESaqfBcGUdRSq1c7SoUf7Zwg1VWiK7j+SqKmlyY+h/BtpnPuEZ76ILrlHbHxe1YfZ7AwOdvQ16LmoVGf8IbABUnFGeTeH1wMUgxNQXnQdMUGa5EgTqcBHOCj0KVCIO1zXKj5ZaXawYXboIlg2sRZFD0/XPkzfXb/jBfq2AvLf7zrw54qSHIa8Ono/nu6Bzm+lNdFIIdVgAnmA0figZ+0P/1XRJFE7HeWEmBWWc89Ki9Gtqfg0kJGQr8iDclu/HFf1BShPHuocveyA5k+FI3sVsvH4DaxhgLbX8neQppsAhkOeURuCfCDLP9RKJQsR2/LCs2DcdjBeCk+++XVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFt3qr4UIOWKeDDA2TlOGfotGXQP9Ob6+3PWWxbw0DM=;
 b=UXEPBEou8wBjQXmsQ4kCJ2ekpu7vMpU7ynM8TqY52hQs/p7UxBRNnBZJ0brl8vyc/fukrWc25IQzZeMgog/et7HggEYKT+gP8nPfah/Jbb5J0XZ2SrviM9nAtOf1S03dO602DfW2JsphYOrEyxROyMIbqJPLvs2Jnix+Wej5kjiZY9ljJbUO0QFruZtuY23dp0quC5eeFFJe1LqgmbOkekVRlP3bjlBMjp9TpFDtgw8awQNcfaAkNUJv3Hid7mCVQHkwaxTfXeNUtOsL8PCwa07jEVy/NszX3DUOMSddLuzmPmXZWFGiTpNBxqGncf5nRvVL96VbxYr5E9Dqqm65XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:04:40 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:04:40 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	yatsenko@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [RFC PATCH bpf-next v3 0/2] libbpf: Improve BPF load performance by selectively loading kmod BTFs
Date: Wed, 19 Aug 2026 17:04:24 +0800
Message-Id: <20260819090426.267-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SI6PR06MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3f9a1b-9fe0-4727-8189-08defdd0e6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|52116014|11063799006|56012099006|10067099003|6133799003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	vRbg924mH6QKpnONMGps2xOTz5P1BuLDeTPVejw5U1k2WesqZvfJ5WyK2q8Tx02K6BN4cA/xAdv4Qi3ZZEphP18HzDRY+XbfPzI7r4VUcxyYIl0/Y+Wfn8AGpY19w2hZNFRJw1UP00GWssxee0pNe9Y9wOqE2EWCCdchfzw+pTe2ySSme5HjemYWfw8Re+j7aGfV2uObvG+Lv4P4LesPjxZ++M8C0Yaq8M91Avc1lmV6aQmXDyhNR5nWLOl/Hd5yUrgBXXze23aHMz3tLq6Ek33vaiKNh38bcbsuzYsvQPI0RNs0Chh+MnY5HuG1FRdqplRKRAhqlWxLHeohZWuBKipNCj4OhveKUv2OTJqlyPrt7NLA6Z5UXkqe723GeWZsMK4GjuYbctMCdtjJbaUWrcueItTnuHdS0MTLM9DDkE6v0IGdP1f6O/ROQvjU7pV3WU+YC49SczgMLqF3plHtULs202j72KEaiRB0EGjtPO6b9WeFWA94V+trHa/vVlTFBjmd2F3PvIh8wy3kDvm5en2cBl9+tvtYxsQDonVDR3apsmxtvHZvXtXOgD5bK1LmoUYgj07Fn6B1QIrMn8FPQXlTdrFTWTRMPG3EY1cdPYlLqw392L47lk1bI5Ku5YSM89onKA1KqvyTLiEQ1IL/ZFrrLZmH3wa3ktOMhE0UmIEa7U5TZujGreRuLIZ20ZtQpDyCcAf1IrBHAEax1glElJxPfI/36Ki3ykJq8Zx62QI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(52116014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQUVIX+IY9Jq+g8webxto4Xv2vVGUOHrzFzSffJuoVLQL0OoW7RGJPLImrIG?=
 =?us-ascii?Q?UT82JgBgE/7TfT3WfDvddUDwSID+kJqumNBoo9gjQoUwBx3bOztm15l6gsCO?=
 =?us-ascii?Q?6rDbiMCPsau87pywK7ucuweAtFcMDaWi0xF2+3wJ942IG+oPAtIlhQRtcO6R?=
 =?us-ascii?Q?jjVPTOxCyAzA7aWnsL5ypY4rVcaolj7RzGDcSPTznlLrP8w7hgS0HnvgF5gu?=
 =?us-ascii?Q?AvQFE0JcaYzA3LQlVo5zaDy+aYOw/75mBvUUrTbIINVvBHLcWZMa8nmjbjWS?=
 =?us-ascii?Q?VU3Tgl1bRTkoqy89C01G26Eu+y6N7zN+E/n5X8CLE75rkeXwJDhXEGpk4h9h?=
 =?us-ascii?Q?pkSjXOzPir/ihjMYlHfjSaXC6Ex+lg7/h9kp+vqRzb9ALMv9VYvraXBrhZSc?=
 =?us-ascii?Q?db9XzTaFI+OTXJIr/m51aCJapKhKFC0F8wSkzMl2M1fguji0pGgBDzjutPj+?=
 =?us-ascii?Q?Vq0mF2xGQEOFdsbMKk0KHswHSdKMIfUtr+i/rcQ4o4/xUc23SW8d4SZJZpaV?=
 =?us-ascii?Q?/o7fll6n4rmWCEoVdbnnz+WJAaWqGStvVl35x/68IwBrszER7ewMld1l7jlt?=
 =?us-ascii?Q?ZPwEHxWpsFZZo/dWRcvnSDKiASFH/rvX2Pam2lee8HoF+UCdKms/sTdIvkvU?=
 =?us-ascii?Q?gMpDT9T8Fgfp3hFPXFmgpjSKLuWaPz4k99F7VZ1hRqLZ2QAUJuDi2Gs71s0b?=
 =?us-ascii?Q?zFtse+YKkOEw9JwyjiOi95omsCAYW0NB5EdWtELDPcCKhIaNCFDsLDqJDz+n?=
 =?us-ascii?Q?2sO1pLEKGidbIc8upx0LTOTkozQbc8zfKueFcmQTZ2yCqHRokywVH8WEA7jn?=
 =?us-ascii?Q?idIkeBuN6RdmqFVKmkKUdTZos/OXOgG5HfNHSLEQI7KWmw7uHcksOTvJkjxA?=
 =?us-ascii?Q?cNkemCbQ41t4yXnDHDiMDymy+eIpGGMPFLXo670QcDnS0X20cjxW1wpcDF5X?=
 =?us-ascii?Q?kQZFKr5HhlMkPqDkaB8lS/fgSrMnUbD6PsSDSjVpnrtx/ua5q6mGuRkIWcG2?=
 =?us-ascii?Q?E6ZyK1nWqhu0UrCrs4sInsssvMpYr7xO1+XLsWa6CfH+Gsplc46fZTCNuceS?=
 =?us-ascii?Q?WxCCLwnmWX0XfahkToH6GsN3vbKi8+ZiWxlQu+QGtw5/QDLuiIy+UuUMd1lU?=
 =?us-ascii?Q?4t1SruYZndlQ+k+rXVkd9hWfknHU4kqba2eVFK0BwxGi7GxlntjHAL+C9shH?=
 =?us-ascii?Q?EY/ieHkKme1DXMQf0nqix8pivsO/UAZUI7lLijeKLGXqBqur7rhtUZGPtMV2?=
 =?us-ascii?Q?Q+osV7CYV/8HcW/AjVO589Bb+ozpj9VexLZhpeKhdnqm/lDIQ649ldmFORpX?=
 =?us-ascii?Q?+myoQMZqA2j6eIWgkFrsdfmivRMAnS70nPXn777mL2s1Ph1ssFb+rj7VyMek?=
 =?us-ascii?Q?Y2OEzYlq+5TP8aSWwR8uLoyJcWaUVMx8Kz7XNzABog5jR8iYLoWlhGV1iZn3?=
 =?us-ascii?Q?LtK7AOGaqKxkDhWX+N9Y/zds1Rlw0pzgad0nbqds7ltxEwF60lw/u2ZW8+/i?=
 =?us-ascii?Q?Zqy4IuM4WT5BCwplsoMsYtfPImuK/eo9R9yLpgjVorF6lHPi12BLy7Al6TPD?=
 =?us-ascii?Q?z1lGRfrv1h/erqbZ0xN7qphPeIzs21uvA5Lgb7h3TC/DSA1YZkx65y5KDu6f?=
 =?us-ascii?Q?ZA2hZYPIcjeq8xWCJDVU6/c90iPQGpwsk+ZnrEB7GntwSugBHjQpQXaNGpf2?=
 =?us-ascii?Q?FUbTyrkd1LqYj28mMcAViPXmb/4IDDrNZZ0I35H52opKBIu5N64azxHjsI2D?=
 =?us-ascii?Q?unc+HTuB9A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3f9a1b-9fe0-4727-8189-08defdd0e6c6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:04:40.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/VCYZsr7FfVVshmJVFFwOdcgMB5g9wcNi3Rw67foSym/Ltbtuhiq7aGXFhSzaYANFesvcflp4PxHryHd6d+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165

Currently, during BPF object loading, load_module_btfs() unconditionally
iterates over all kernel module BTFs and loads each one. This introduces
unnecessary overhead when a BPF program only needs BTFs from a specific,
small subset of modules. In environments with hundreds of modules,
loading all module BTFs can measurably increase the loading time.

In our Android testing, BPF programs are loaded on demand rather than
preloaded to avoid unnecessary memory usage from unused programs. With
93 module BTFs present, the total BPF loading time exceeds 300 ms, with
module BTF loading accounting for around 69% of the total loading time.

The existing module qualification in SEC(), such as
SEC("fentry/mymod:foo"), does not address this issue. It only affects
BTF ID lookup after module BTFs have already been loaded by
load_module_btfs(), and does not reduce the number of module BTFs loaded.

This series adds kmod_btf_names and kmod_btf_names_cnt fields to
bpf_object_open_opts, allowing users to specify a list of kernel modules
whose BTFs should be loaded. libbpf uses this information to skip
unrelated module BTFs during iteration and stops iterating once all
requested module BTFs have been loaded. Without these options, the
existing behavior remains unchanged.

Performance impact (BPF skeleton open and load time):

  Modules loaded | Default (load all) | With kmod_btf_names | Speedup
  ---------------|--------------------|---------------------|--------
  1              | 35.6 ms            | 35.6 ms             | Baseline
  10             | 37.1 ms            | 35.8 ms             | +3.5%
  100            | 46.7 ms            | 36.7 ms             | +21.4%
  300            | 65.1 ms            | 38.7 ms             | +40.6%

Changelog:
v3:
- Use bpf_object_open_opts to specify kernel module BTFs to load rather
  than introducing a new .kmod_btfs ELF section, as suggested by Andrii.

v2:
- Link: https://lore.kernel.org/bpf/20260813032613.2755-1-zhaofuyu@vivo.com/
- Addressed issues with allocation error handling, multiple .kmod_btfs
  sections, the transient stack pointer in is_kmod_btf_needed(), and
  selftest dependency and comment formatting. (sashiko-bot)
- Removed KMODS_BTF_LOADED and KMODS_BTF_UNLOADED and simplified the
  related logic.

v1:
- Link: https://lore.kernel.org/bpf/20260806042042.3239428-1-zhaofuyu@vivo.com/

Fuyu Zhao (2):
  libbpf: support selective kernel module BTF loading via
    bpf_object_open_opts
  selftests/bpf: add tests for selective kmod BTF loading

 tools/lib/bpf/libbpf.c                        | 133 ++++++++++++
 tools/lib/bpf/libbpf.h                        |  16 +-
 .../selftests/bpf/prog_tests/kmod_btfs.c      | 196 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/kmod_btfs.c |  13 ++
 4 files changed, 357 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c

-- 
2.34.1

