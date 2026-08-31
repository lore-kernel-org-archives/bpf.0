Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013034.outbound.protection.outlook.com [52.101.127.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872247FAFB
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183505; cv=fail; b=afHamFsdWyEu+aPZ4EMgRynnSJwMRIB3agUwBVqrcEP7W6oeHf6eilsfbNpdn/FjLjpLe9IySgUFiDhQDV6dhBdiz8rhpB0Wz0kxUfDIiF2P26ECvp6d2//wLpEJ08L70nbfgVFHGBhvJjfvKH87EFZauzG+SI6Qv8PWWyiWQu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183505; c=relaxed/simple;
	bh=aum9o05hJvAMXcbpL+ATzOkRrBxUtVKMjl7zQKYN/aY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YGwVdJF0JRBi6PnZyCupHQUUFlXAimKWHAoN1esAstGDC6uPAWoBcY1/B7GujlGdJM9wuf8Fxcte2ygNsWEFSXBxy8duOPrpbFBWRucPEfHZNxkwAIppXrmOQg74cqmU7pOIqBg2MHXQsQ2YSGQMCJwixhS7myrxIHFR8XTW94U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fk657ezQ; arc=fail smtp.client-ip=52.101.127.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fk657ezQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqGVwcsa4oRDe8oiobwKRBLUw9XiWGIIjWfI6/PqHOUOM57M4NB7VbSmZm2ptjRJtf4Dwfh7Pn0ji9uFr/BIvqIee+4dlXabzmdf0etpGntHXnwzuHYpmyx9MPxAyRtKn1FewTugs76LADvS6HT16hqJX5ZDCaAluIJ3g5Wqt78CRFuTq/dLNXxwQlnqabJ/BgiRXy/dCbCx+yen8s6TJQ/dlN5UDWU0S5CmMyZx/D1Y1JAqS8aTPbcSFRkJix/uKj4yv96gJOOY0DzDh0xkZrmUH73ZpfOdQUSvQJzvNfBBsp5TiWphx0pEvqz0cpET1duSw6ej2dHnOZjuacRwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA2q4y1Lptlns0+ROOBMCIICwDVPjcUVGyay/QFV9tg=;
 b=I2puyfwF3dZnMSd40BGaY6lSidUdQ4v6QMboZCD0y9zKMn1DbdSaPKTO35vgvUkkJ6C+oQ/XugZFS90xN4mDkX90CXsF+GU+UziEsK1H80kYO4IfzfYaZ+tKwcVuCEKTlBv2/G+eahyi0RlpaPCL/08ESKKcFNOGgDX9MPz/IqDZg28Oxmbbag+FOsiF5KLcaG9+jgCKKyQEpni5gyri+VEcScJOir/tih3VcbEKgnYEGjjcbm68nzB+3EafWsvc8cPgTU6UCnkNExXvKcGWACXo5fsahlXMl20ggud0CZRWHVCMctg0QYdjLoTzLKKZ7045SUmUQ8OYw1KmgfX5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA2q4y1Lptlns0+ROOBMCIICwDVPjcUVGyay/QFV9tg=;
 b=fk657ezQaq6sm5W64LT95JvjSFlbxnXpdIaJIUQaAGrY8GQEfjNVfWxquKgbcOalQWjNLElJnUiLdctK7IwjVyX7DiHg/EQDrN5hmcU3Swy5gYTZMLQXB2+kDkpmahKr6LSO7erjRaGsyEv+MwV9Ex+V2QWPqi8O9HbV2fJhxUaP9hg6w23AT2Ru5KSfFtE28EWjWgwrJ7TnVbSHKmos3hp/9gvgmN2pfb4RWwmCzw2uEblnerk+1g3yqjugohgZKa4eAYur5NgiqC0ytYWjPOYt7WCCrgJUBQ0+aLZgBhwTvXZGp13K6bYXR6DZQ19Z9QHRas4agmPM4Hng4fENBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYNPR06MB9224.apcprd06.prod.outlook.com (2603:1096:405:3d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:38:20 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:38:20 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v6 0/2] libbpf: Improve BPF load performance by selectively loading module BTFs
Date: Mon, 31 Aug 2026 21:38:07 +0800
Message-Id: <20260831133809.1161-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYNPR06MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2e86c5-d530-4c41-796c-08df07651eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|23010399003|10067099003|56012099006|11063799006|6133799003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	igSyMb8B8oS868eUlhWoAOD+Q4gYI2KRaXeAh3/1bLWm43zwgasZUs7SVz9JbUPOE7D0y0DNiWcBpyEnHy/d5zUM7dryKnviqiU5BynkYSwL6+DCV4lCWyW0Fw+SN+tUG3Xz5yOA3uXybBBuGm+SM6n73uFFO/iJ574F3i/y6EHBpj9nNpdHITo2pwQHzKqxdGJ4f+hsDDdK6Sk1VJhUdN4bqaa29W/UXxLFk9M9+wi8BmQXtlrZ3ba5NUZMwNeKXTuKt6NSoXp8YbRwj/1H3xpxzCApd6V6YWvLswTYA0gE8JQELyG9gRaARi8YTFnqs7LUPotk4719biHwogVuGDx/yOb1gHh365pfR5o+GLHUbUQZ3cya9SUoRod8Fc0+UMTQLkB7paQEt0uBxW3EjmCaS6PlsnZA3qZ90AqzMdZahezwhPrHzwuu9KCiYKDYge4Yu2sZ04gwtiJom6U0FPV76b3CbKQ15/lA81K7/uqx4p8/0Gfw5aJ6Pxw7OvV364BLeACooZ2hSoMkG3ylLiulmNCvgEcjqU7xZ/hvpMLWdxHZCdWGd0fQvxOaamW1rT6yf1lgrLUOIuE5Te97BCS5DGt+gkrB9f+YNM+KZLLzZZG277xjQ/UXYh3virwXVzuvuVa7Z5+t5tDkmoHzh/t5PvGPS6nNZMenH0FRumFW2Q91AX1SFwqLIJf4e00XHAoT5QuJgDuSm+kvSzsRMskNlXpsc4tFLlAKRUSo5FI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5191axob2254TuveKobsU6zOfPIkJTJ6U+AV6igoIZcIFY8PrGDFk/N/1R5H?=
 =?us-ascii?Q?IMCdZVemHZnM3pi7JnZ0KloVvmCxCtzpeLrNUXh4gyiQB5dadqr1YVosNcTm?=
 =?us-ascii?Q?iLd5qF6Iqr+c7MUHVin7uCm0iW4EpUecQ9sx0w2QKKanVJBi4P3n9aW/0CFm?=
 =?us-ascii?Q?bgIr2Dy9xBXsqvEFmdPdAAizvGoWzGc17z7YuTtIUuHbGkVO4Ixdo9wHuhnN?=
 =?us-ascii?Q?MAC7ZYIWnxnts4iyxd+huMFtXdfoftNz2oBt/tqkeZDUYrP9RMmT8LBYsE91?=
 =?us-ascii?Q?1Hl53fv3+me7qNiCT011DgAuqWttiUn71jBg3yQPAY59UyS4X/LCCvXSxBZc?=
 =?us-ascii?Q?4+phXRiim0GgL11G7sZhhqzPHr6lW0yRs+mb6C4w17gdwhqK/tcY16ny7ro9?=
 =?us-ascii?Q?X9mlOw6g92uuuXuWbWm2sHffx8ONas5CSN/5j0R1ASZ62v9lhd8WmUxoxUW0?=
 =?us-ascii?Q?ItOX1SbWTfyVApyb9IYQGlEOSw8Yg8r/jfzVPI+LwH8koEt+TInk2spNq4pu?=
 =?us-ascii?Q?GO0CTWplOe0WfnAYo6v5qBUQ2FAlwX8t0usJZnhm8EfsLFGxAp23ikbVocOA?=
 =?us-ascii?Q?IHfQoqzxMCbA5paTwes1lghGIB+KZBJtECixGdnWNhRlHiSJzMgsbRh4b9a0?=
 =?us-ascii?Q?CWfUfzNppD1YfSPiI0KbnNs4x4RZEwPzhly8TAl/v8z0ytv7ceso0FHIOaTJ?=
 =?us-ascii?Q?308h9CnbGzZdHnaxxEzgl9C3Z1zUJKnIHPQjygWX/Cj5E+uWAKqhhokHvZhG?=
 =?us-ascii?Q?IlwJ0iIh6qGIGR1Nx5wNwp2HBNdM4eamzzCUypKEJQ9Os5SHgUlSq14nulZ5?=
 =?us-ascii?Q?N7ZITJ7qrixlRxdpZkzHnLFSvwq4A1Do7+VS13WpHsz5/GXzACYzF7rk0To/?=
 =?us-ascii?Q?EOdkHZ7wkyLLjlpKtypOhCuVDazBg392zzm91aRIerD8RMMWZU8PWbVLt4Us?=
 =?us-ascii?Q?26ay85ix8mp9jqc6wNg6wMhQY9n4CFunkM7dWlevRZKv89IWre91q2PwG61q?=
 =?us-ascii?Q?ciGMyHdEDFRLxUyc64JEUz7WnjElGAc8WzZlN9ZtnRY5+ucM941KDctpKeUI?=
 =?us-ascii?Q?kfmcFMZzwXu/gnMOoX5sO4l2eU5tPxtua5Q/jx/wxeg70f8dCGwHY35HvBt5?=
 =?us-ascii?Q?gABX+QaVZKQpySkqDpNkDuaWq5GYncEhSP6kWypWp7UPzQgHVT9+5lu5vP2g?=
 =?us-ascii?Q?2ktS1Hsr0TF/5VYe3/wJSOMarc854aSXTuQxSt73DZ+lXk+v8MUDAc1grwJW?=
 =?us-ascii?Q?wSPBiuN8iLrMxYocMGF3pulHaDjkVQuOHU3PfhPxpIk9iGupVYxs2dheLvaJ?=
 =?us-ascii?Q?suqXdrwCIBWy0DOTi8/8V4Z3m/W2tGAx+DXIJymBw1fV4YcdoBq7AzCbo38m?=
 =?us-ascii?Q?PpbKqnGefkqVGn2PfVf2sLFcNc8wiLN4n4SVuytf4ZpUER1194wuEpx2oVJH?=
 =?us-ascii?Q?yVSEHhx1cLXL4RAxvOG6vlynp95V9SR6IqfznpRxSD4ppCnCpym/XillLWzX?=
 =?us-ascii?Q?dD1s6PvQN0nV87U4m5L9XH2aRS9q6DKYjF/md4TQ21zdMrBnX8jt0kqUN2gE?=
 =?us-ascii?Q?SLlOkCKbzjHCRYTvP7mMH9axqfjMqu4wgOseWJ0Rgegj1Ba//Ddh5KVdDWHR?=
 =?us-ascii?Q?ZDjYizTCJ2W98h6y8cXyfSd+sHjVAOnTcJxYb6MGX+NdXrh1yydvSon5fOVl?=
 =?us-ascii?Q?Qlpi/BuNvhN4oPvNaiSXbmYyC0uWNJNYhjD2lTjX3baUWKqUVGJasENRab+o?=
 =?us-ascii?Q?9oM6FaoDBg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2e86c5-d530-4c41-796c-08df07651eb5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:38:20.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2m+IKRiJ28VGruU5mlI+xj4uQZehynQg1oAzI1/C6phLiTBM0LlJ7SYmhiNQxWigRJFwCghqe3jQCGFjK2Fxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9224

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

This series adds btf_module_names and nr_btf_module_names fields to
bpf_object_open_opts to support selective kernel module BTF loading.
libbpf uses this information to skip unrelated module BTFs during
iteration and stops iterating once all requested module BTFs have been
loaded. Without these options, the existing behavior remains unchanged.

Performance impact (BPF skeleton open and load time):

  Module BTFs | Default | Selective loading | Time reduction
  ------------|---------|-------------------|---------------
  1           | 35.6 ms | 35.6 ms           | Baseline
  10          | 37.2 ms | 35.7 ms           | 4.0%
  100         | 46.7 ms | 36.5 ms           | 21.8%
  300         | 65.2 ms | 38.5 ms           | 40.9%

Changelog:
v6:
- Document module-qualified tracing multi-attach targets and invalid
  module name handling. (bot+bpf-ci)
- Remove unnecessary `static` qualifiers from test module name arrays.
  (bot+bpf-ci)
- Check that bpf_testmod BTF is available before running the tests.
  (bot+bpf-ci)

v5:	
-Link: https://lore.kernel.org/bpf/20260826131428.302-1-zhaofuyu@vivo.com/
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

 tools/lib/bpf/libbpf.c                        | 117 +++++++++++++
 tools/lib/bpf/libbpf.h                        |  24 ++-
 .../bpf/prog_tests/btf_module_names.c         | 162 ++++++++++++++++++
 .../selftests/bpf/progs/btf_module_names.c    |  13 ++
 4 files changed, 315 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_names.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_names.c

-- 
2.34.1

