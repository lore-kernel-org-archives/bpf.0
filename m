Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013053.outbound.protection.outlook.com [52.101.127.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56EA1A6806
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759544; cv=fail; b=XWMg2ESVvI07BxDdjE4aKhB/YfHJNiVkz9DAzdspE3krdHqq9Ae7hM8i7oO03UOsB07yr6qkcswl/35JF41ZmlrhiVffjdL2BpyBTjE6EMk48yuGujp31Cld5m42RXTJgUnjuoHmTRqGrXWvg6wg7nSFmGiKsVBDha2Tm81MA1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759544; c=relaxed/simple;
	bh=sMMatBMJQNvBzXT986DL0bCc9lWnnFL1tG5HzqDjo0A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NQaWn7yv48Zal5UZsy/HBdteP8p1yesoGZ47duNHk/3ARFbjOC4luQf0tqThbPEe6sos4mKt7diZ6TQrimUxfTbK2V3Hbrq/mVcnnqwxJ3CAkg9EM88T/cdYnnBejk5QbVjfBUTv+yqjWgCAWKi8KuYDUn/PhL5P6PrOSqGBrOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iILQ+/Xc; arc=fail smtp.client-ip=52.101.127.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iILQ+/Xc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdEkN7MXU79tpkPxpG40KVLEClsC3YIvJH21MKl6QBa6Vj/Xex68PTBKqu4x0vxbo5FS919PnJ7MHvZafQy1BjjZ+G+qTEy9UDrl+9TZk3p33vc5KGW/EWt68L76rY1Gseqs/Ba768zbLaPpeYpIDh++aW+UwAAuXwKinm5PPnWNynIJwvTjSOGBYKhQAcTltF6O1Xk5oRebvImMne7/dBh28V9EonO+7V6t/x7UR0U78xH6jHid/oavTN3rVseTX6jVO1UypQmUVKBUzuy6Tr6NmTTosSxgUQP2cZvYEi0i2bRg+J7fc8LMwVZZJwPxkmRzyJk7SWzi0ZzpC3Q24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6cbHVWeNZgJwLMsLY9iM44yS+hOP4/iChLZAODyxOc=;
 b=kTGQn3dliE0D//wi8n7rGYD2pVxJfN5VcLEMIE0tcYN2+UTHQYDYXrlUmxh2RC8Y46U8/1k5S8J4Z2+XWTkBseY2FbjWYISoS7O626J4euyzjGXtBipw/axNOVc3bj9TNBikDUg8446/GSJs4kmUzgShxBVHaGSLToHvlAaM7Wi87hJHCSaL1SetYebT4OIDMds/ViPvpTCqQrvmdaTwcrVg7xOX4t+J9/AlLl7J1qp9ZoYrxpUn2mUiqxFtZJU4xR77eJHVj1RYhYEpad/L/Mkp8AwggCPAVSQgNz0ylMcDj6cY2cgkYPuGDTnVo5nW6W9ughDSC1iMmrlVB/9+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6cbHVWeNZgJwLMsLY9iM44yS+hOP4/iChLZAODyxOc=;
 b=iILQ+/XcQXcSM5gsoG3tnBISbyzBkrOOlIwH0G1ICc+isL69czOu16tIeuZ4vcvGmkP0qFP3TQShyaMNGTgC+H6jrFSwoDBccirb9loT5v4pV8QKqyEUq69u0VHFoKXfkJZ2GMmMgFmAxFexlR5jBtH8oRi0ryOb5WFMvOx74Xt8ZSjBB+ANqyC1QCckChFsrVYI3Y8zD/zCwFD/3FTiQ7Xy4tBPvXlVdY/qbjCqss/vPYk0dUXMuuICNx9PhH/4M5E2ePP+C3LSz4Vsa09umBs1JorwuLgJ+R3W2jHy31eH+MuPvXxrBG/a4jCm2teirLCdc2KYTTXbBpzNMLqyBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYZPR06MB6913.apcprd06.prod.outlook.com (2603:1096:405:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 05:38:58 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 05:38:58 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v7 0/2] libbpf: improve BPF load performance by selectively loading module BTFs
Date: Mon,  7 Sep 2026 13:38:45 +0800
Message-Id: <20260907053847.1115-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYZPR06MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc4ec6d-991c-4baa-dfcb-08df0ca25027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|10067099003|6133799003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	RGNjcnnxc2qm4HhJ3OGkvVIsgHplrEbFEhdiF1uquaXTohOqajGCq2lasl2aQiOQuGOkAlY+SOS7W3BuTw2fIsR389pLCOqDUH2V/JjYGAuHvcff8/iaLYkldLLGHf2Rp5etWj/HDzK0H/OY5VjfieCzwfNT0MFIS4SmEc1af5wiPpSvZNXG6E3+Mp5AmyDYjAHCugYnfgWryPBMvZ0OeVJLunNEDyhIYGfJlR4/FvYkUtmFaFQmlDpHXbpFHtuEEAA1z1MQiX4JoR3gLhwgNzbT3ZYD6xFJNA3XC0VtfX9KqoPInW0F2i0+ORD2Ft5J7ZhyPgmZA5U4+RxFB/CPARGOJOKUhievgKviI+S/N7iS2GOeAK1+q5u09PFE5f0cpaEiFJ2Mu7VtnPYF7mQSUN6ZFf26pp2/WKma8QjLabtIgH9xiZFkP/oJYv1KypEw2TN7IsW1nNwfIcPIEdlvXD4qP5vm/bolfzFgEkd9cuqtAyHyrI44ZNVFFHCcYuVbTi6nNT86Rx46V0LbXVe8JP3eODmDy5MBW9wKa7EiywXl9xFDEdIF8jduO0SUeWyIM3IwnowzCw4vtR8B4+pLBOlxBDWGEjsoWXktp9hOPr4ShgOyJDM9CEqAcYW3lTPlFoCccF+9Nr7QDluP8qOz5OXF8NDbx3a25+XIZUmvm7vwuIWFdTVcYiThKSVV/1XcK/fNVbtT1ogC87vIIqWJ8612cmZaZ+0tCTKEUrqQEMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BjhZBtC2vbr9RIHdT3Nno56NEHqTAHqggWMABdltKJGMY12nQcqoT7tK94QK?=
 =?us-ascii?Q?7z4lIaonQjPnq1XtkOWgxnQvIyWuN2KE66qR/kHXMnOyQAkvlIUSgkxAT9sU?=
 =?us-ascii?Q?Rb4lhjqqU84kqjdrc+W6drNKh63E3y12VNvw6ylRJ7jn+nFViU9hZ8Gf1kL2?=
 =?us-ascii?Q?3ZqBCZZzOi9+6BYywWdw47OLKm+OZxb92SeZt2HzFO6zDpTgsAm1WsJIpx99?=
 =?us-ascii?Q?V1mSKwkqynNcY8ImUbepz5P2SVQ6lfH/Njii6+2hNnzr9JHa1dBkBGL/Yv7s?=
 =?us-ascii?Q?/c4Tg1wj+/rFr8jYFLM9HehiMHm4J8NnYed27N0Xnj+ZlwWRBR8pp+FfykdX?=
 =?us-ascii?Q?zZvoIY58J/XjiMAu/+ynzeYPRb35Iiwy40UlCWhjXBppAzd3tGTLVTo4LyFt?=
 =?us-ascii?Q?dRjRaiik3yj3lbZ6hPI/QFA1HpYOPc0See+QgHEbIGNJRzO5O6Iab7Wk4YJn?=
 =?us-ascii?Q?8Q0c+0FwvzqnJpQVtFmez/Go0TulzxbnIkgR26UVTcvrcsAcyfK4jXSDtL3t?=
 =?us-ascii?Q?AqkFqGfRUdRS4Y9UE6s5XxXG5p3E0epOPjYWwYQy449ZqUT5Icbo2yawjIRb?=
 =?us-ascii?Q?mYqYPrnDabQN/sJ/Nrc9ryLL6QXwXn3NZmNS9FuAIWZtml5W6UN40C66BWYK?=
 =?us-ascii?Q?1peziiZJXUXO0PkI2ngLK1r0nmq2+p+afNt2DwjP1EJjzEWxxz25epCZzri/?=
 =?us-ascii?Q?2tAbJ4v3uaMit1YSt2XtMuKpfVsF9Yiii6U0LJrDGFQRbZM9JUGUWXj07XV6?=
 =?us-ascii?Q?wVrWPliZrPeyPa+tX+BHjBWYLLU6ZcXrIG9rAAUyjxjqFWMAreM1w3FYEBoA?=
 =?us-ascii?Q?5HnChVtYuXH7ChnPxX5it0FYygJjT1XDX8UYeAplolt+ieSjYXX2xTuvY99x?=
 =?us-ascii?Q?oy7QDQluX9J9yDpoBFkJDodGpieikrPVe6DTTTOidFLoUxTniltjx4u6RuYp?=
 =?us-ascii?Q?Rac6k+vR6IH4OWo5CE2Tmdf1OEcwE0eoFVno5p3VYlPaXmd3sBL9m4F9ThXP?=
 =?us-ascii?Q?CJYZ9K555dK/03tkZQw3UynzQiLRnL8ifyg42Zp6sudnLhSsDXYFZ4ZUGAJs?=
 =?us-ascii?Q?kd3rrdUsglp0k8osAksLYHbdS/tD+/jKoIhj8G1pSMmBIXkixSkw8uyqhLfB?=
 =?us-ascii?Q?UkakUD334JI6CrZGuI02/I+0TiKCBNjOwsfhyU0ZJI4mMVe7harSHijibYKU?=
 =?us-ascii?Q?g09aoSHz3T6fbuhQrA5jTET8hAn/oTAAQbG77B1i6318RZxx0EGbgl9kd6sx?=
 =?us-ascii?Q?RLhkS0kNy6BfKYatf51oFRa0VkbVwXd+SeV6yKUFMCPrm9rbmrZNQUgl9u7I?=
 =?us-ascii?Q?5s1AWe/wa7k61Tdh2XsJ5KqKXpERSdEuz/vsUnMvztBxvKcLWuCFZpl2R/+4?=
 =?us-ascii?Q?ywkPIglBLbso2+M2upmRKApj3O01Zv3eBI3vMtEcjfeUoptb/MFknMOQYUIa?=
 =?us-ascii?Q?fL1xrKTGB7Ty5zzmTDJeYWq2LHdjtzrDELgnNbuWVhohdkYE1r63lXGHRBHx?=
 =?us-ascii?Q?AjPtWcPlmfwjKMyTkeZ2tFuZiwM6+MyZtarWfD802tSpY0RdiTMlEJGV6bv+?=
 =?us-ascii?Q?XI18xA2HrlbNuGuesHCesDkoU/zMGIV9anM/wYoy0rUarOTtUu/2XCgBGBlv?=
 =?us-ascii?Q?3LW0rT/cKG8PaNGvnctGslM/1xN48BNzuxTbQmJPwCGreGDpNgJWlbOun64a?=
 =?us-ascii?Q?DngCZ36P4NciMxFgUdoow4044uDvnhLDbkb+Nx1iKycZSgsAZL6+UIfda6vM?=
 =?us-ascii?Q?/cdk+dcDlw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc4ec6d-991c-4baa-dfcb-08df0ca25027
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 05:38:58.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSb29QXpkC/ieU7uWsUFljpXQYavaCrEUUIH4SU8rDFsWjq8dZgYOITd5Af6WylZ1TKpK/vUlTReBZP83wCXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6913

Currently, load_module_btfs() unconditionally iterates over all kernel
module BTFs and loads each one. This introduces unnecessary overhead
when a BPF program only needs BTFs from a small subset of modules.

In our Android testing, BPF programs are loaded on demand rather than
preloaded to avoid unnecessary memory usage from unused programs. With
93 module BTFs present, the total BPF loading time exceeds 300 ms, with
module BTF loading accounting for around 69% of the total loading time.

The existing module qualification in SEC(), such as
SEC("fentry/mymod:foo"), does not reduce this overhead, as module BTFs
are loaded before the module-qualified target is resolved.

Use btf_module_allowlist and btf_module_allowlist_cnt to skip unrelated
module BTFs during iteration and stop once all allowed module BTFs have
been loaded. When the allowlist is not specified, the existing behavior
remains unchanged.

Performance impact (BPF skeleton open and load time):

  Module BTFs | Default | Selective loading | Time reduction
  ------------|---------|-------------------|---------------
  1           | 35.6 ms | 35.6 ms           | Baseline
  10          | 37.2 ms | 35.7 ms           | 4.0%
  100         | 46.7 ms | 36.5 ms           | 21.8%
  300         | 65.2 ms | 38.5 ms           | 40.9%

Changelog:
v7:
- Rename btf_module_names to btf_module_allowlist and use _cnt naming.
  (Andrii)
- Simplify allowlist handling and documentation, and drop unnecessary
  logging, cleanup, and helper logic. (Andrii)
- Simplify selftests, add invalid allowlist/count coverage, and add skip
  reasons for missing BTF prerequisites. (Andrii, bot+bpf-ci)

v6:
- Link: https://lore.kernel.org/bpf/20260831133809.1161-1-zhaofuyu@vivo.com/
- Document module-qualified tracing multi-attach targets and invalid
  module name handling. (bot+bpf-ci)
- Remove unnecessary `static` qualifiers from test module name arrays.
  (bot+bpf-ci)
- Check that bpf_testmod BTF is available before running the tests.
  (bot+bpf-ci)

v5:
- Link: https://lore.kernel.org/bpf/20260826131428.302-1-zhaofuyu@vivo.com/
- Add no_module_btfs_needed() to skip loading module BTFs early when the
  module BTF name list is empty. (sashiko-bot)
- Document struct_ops as an affected use case for btf_module_names.
  (bot+bpf-ci)
- Add invalid input tests and assert expected error codes for negative
  cases. (bot+bpf-ci)

v4:
- Link: https://lore.kernel.org/bpf/20260824125310.1384-1-zhaofuyu@vivo.com/
- Simplify and rename newly added struct members and their documentation.
  (Eduard)
- Use array search instead of a hashmap for module name matching to
  simplify the code. (Eduard)
- Allow an empty module name list to skip loading all module BTFs.
  (Eduard, sashiko-bot)
- Move btf_module_names option handling before bpf_object__elf_init().
  (Eduard)
- Rename internal helpers to follow libbpf naming conventions. (Andrii)
- Reject duplicate module names and document the rejection rule. (Andrii)
- Replace log interception with functional tests and simplify selftests.
  (Andrii)

v3:
- Link: https://lore.kernel.org/bpf/20260819090426.267-1-zhaofuyu@vivo.com/
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
  selftests/bpf: add tests for selective module BTF loading

 tools/lib/bpf/libbpf.c                        |  72 +++++++-
 tools/lib/bpf/libbpf.h                        |  16 +-
 .../bpf/prog_tests/btf_module_allowlist.c     | 155 ++++++++++++++++++
 .../bpf/progs/btf_module_allowlist.c          |  13 ++
 4 files changed, 254 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_allowlist.c

-- 
2.34.1

