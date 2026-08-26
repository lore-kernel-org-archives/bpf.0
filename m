Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534235C693;
	Wed, 26 Aug 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750089; cv=fail; b=P93JXcsZrIJFgstcsuCu0bz1ORdhoZulYaBTMWLvgbp0aomSv4pQcFekkf9BlcBzlOHNEgjV+s1HcUE//YBCmXPSVp4EOzBRgpJ1voazI5AAsvOMFhCbGornejfEGDLQo/Gjs9m92TF0RNYBNFXNHcTMH2ZRL8/BaL3dNGmeY/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750089; c=relaxed/simple;
	bh=7evAdjT1GxeOkSUZY+VQiCfnrX5A8IPLM2QENvDxoKk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gVMmhrbf9a1HA5m2VnO3a8Qp9+pgXv6VarOZK9mG3l6qFuVjEfEJ9cCldDKX0YJPLGHy3OFOx9+EYF0AL12oNGJlzvDlS1daZHhSs+Zx4hjjc7Td5EZBr174Flg/TKombJVzP5l8t3zDYjvc43LXFzRoQQhX73s+lr2y8Z9LQvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QYWLBieb; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QYWLBieb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qrtu2IikldjYHLJW9R0s/1IPG6xMu5d4s+4l/3svM+IqmfudSErHFUdMOgVZAQbZ9vpuDJwSiJWyL7ANwrGpOdhfmpcxqE6vMiPgYxqf23XexreI7NjgpTPHWrxz6c4zsicOFp2EQi/8Cnu0CJFt8fKSAfQ+FYXpZa6QXV/fTJZTFCkiwFibpu/QRaEl5J/vHT1NN182R0ERrrNTiANil8lewMuw9ESZtiyy10tYKwHPOaTD2DHS6T+wrocTN+0GVLjsy8+FT2LYpDz18tscw5UDC7LBzbZ/rMRsa6P9ucJNUNrxIbS3rurlT/iYa6IR63EzHCTslOdUTfF61yLnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5CPSj9haAR3DM+8c+2f+xKUdNIj1FaRK3ToRkjYMn8=;
 b=qB1H6D7J97Z5sVzb2dqdjnNSRFd4b45SvEZXGmMqhN8FJt9eLvp8MKm4n6t+LjVqu4k8paIE7xIckTlydJ9kPiaBxe8qj5CUIgH2Dcvfbx/rAr3ptO+clIkPvixELXyGqn3ukDihM6zazsypeKrUVKfI84g/EtbI8eb6W0C5IAT8IfGkgtFdHqQySOo2qfJiqkpQrRalL6Pjwalkz1NVLZDnCNqrqd3M5HzUsjiYSTiZzZP3K77kAbFlvFXPQuoVzW9B9nxYSKYzrAfAIg8xtV4yq/uSgKVGcpeWUUN/uiH7/pgJbP+0h7f5JvjdjQIfYH/lhIEBE9DWquA2OuW3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5CPSj9haAR3DM+8c+2f+xKUdNIj1FaRK3ToRkjYMn8=;
 b=QYWLBiebkChFzHaul/SwaSOhapRlmEBNBEavv5DI7m+wFjHR1yOoIndIPT0uaON9e62kz3ve79IR5p7cfa33uiqMycq+yXtY4KKGyUhDL6nRpSKlUyMsl4594Ns1Oh95oFnYRuDNkKNtpGa3ImIReRIEyO/WmBZ5/GcMZ9bMDUn+fUCggddR9z0zJK0qYKWx7QvdfshMDDp+Y1gB798j/1jyU1/NqhS3VDKAgwnU19rGAiTXy27LDXCwS3QMpbbuj8ZMm9C16nCbFxCo7EdrCbaDQMzvn8sRlBVWswntaGy4ypPIOZrU4ypNuENItr6O5D3EztMT9GQV6IQXjbCY/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB5866.apcprd06.prod.outlook.com (2603:1096:101:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 13:14:42 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 13:14:42 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org,
	eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v5 0/2] libbpf: Improve BPF load performance by selectively loading kmod BTFs
Date: Wed, 26 Aug 2026 21:14:26 +0800
Message-Id: <20260826131428.302-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEYPR06MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af8d91c-0783-4143-ee19-08df0373fd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|366016|1800799024|18002099003|56012099006|11063799006|10067099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	GehPpO6EVqO5iw72b1LicOOkFVXlHLmDMNBr4szuRwYMsxetrbg0PNaOwBoglc/8249r0y8e8lIUFCpCILDL+bsHvP4bWoppWvqMZdhBqMi4n9bP39OFy6z/gmq9P8l8pJiPQR9ZjN+JFUDNC3eC7r5ZUTdzvxgGZCCqFI/HR5l3qk+IlST0JSVm9ad91dv6DxYtK3axW1aUGoKnJUQX8MqFE/VSN/HxAX8AmfiQmGfFn6VW5ulQECfNsGRRi7lUer4E3EuFrOTCrnFBYIprg2hUACu0M3n7Sv/tV4eT7k1Xj1kFD7vokm+M9ndV8Mg9xQf/0gSG4XWxvBL6kGncbH2V0brDbYAVzwpDN2rlWGEosyhRc6czUr1vUtBf4MA0ECsms5WmwQ0SLgXIE7vXU2npcGedIbVZGhV9TN82o/PjSAIxOvLypUKoPBIbE8+aeMpsziRwEiE3SMJ+hk3IBydmqBRTlRX7vQ2WPfVcGFRL17wuwsUEqh4Dv3DqWcx6K+Z0fOR+iZJY1zP/KEZiLpRdm1T7mNtx4E2J+a9y6mJzii9C7zJ3adUbBsoFzVnYA/zZHDfOaEJBkknhlBpYMieXksafKlXFbxyAyn+ZoC7zmL25XgyKjRXfL+DRq68lAlQXG9xvaxJtRtzwXY1aPGC1F6QGkOb5Ko9n9yS/urW799Lke8TQI4qgjqRwSGHTm2C5RGOyXfj1pIxlIxU6rgEy6cjQv3L6sM3AK7Y9ucM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z+cZdvEWDWOazJbdTZBPF6Uo63VgHUtrHwgkmmy9gDQi3ms11jwlcOQOPcQE?=
 =?us-ascii?Q?yPCCP5qr83SJFG40ZpZGrVMp/3Y1q/Hoa6/+ihBEklsRV15jqFnVrWBmv4jx?=
 =?us-ascii?Q?DG8NNSY/rBLPAKGqiwgeGDWrkamXczSInQH0YSBu94SBH1RD1wH3yRzADvyz?=
 =?us-ascii?Q?ReKGXWoIRWZpwV15s1S1QWnt07c8Yn/aUI6jwMU10gxA1Y8IluLFlr6zUuxO?=
 =?us-ascii?Q?kb8Uy9JOX0F4ucIpjvijtO/uIwa1w+N/nLpusP+Bxhkhx5End59LR6ioUzye?=
 =?us-ascii?Q?0YoLlZ4D+dZXfIFndcyYRnHrbMXPMeFTqVvDuRSTYqfqhXcq6mPsxzYYvPF+?=
 =?us-ascii?Q?zMMnWApLTZ42OEkun/GkBTlVhdKnz04MFtXWhUNkKZjpy/cP4WF0PTDBUtDe?=
 =?us-ascii?Q?o5troDmlXRPipf/9dkRgV+7zUvvqlxIVtExW9TiN9nh1OZ5p7+U6GHeZP3vU?=
 =?us-ascii?Q?dpDbGh4T93VPep1nzNsEqg3Nqr7PIGYRkcdHsyo6mIQoFQxx1IQqsjWLbgTB?=
 =?us-ascii?Q?qXks+qdI863KeNC5o61KoolbyxRtw/yIGSJjrd1nHrozjeanS7seTaHWVdgv?=
 =?us-ascii?Q?n6ndWwPnpJuVM3eaaQ7yZVOUmlO8L6vJHr0iE+vf0Jb3VuD4rWMEMGnjZoq9?=
 =?us-ascii?Q?3Smb4GJEstnaTdHx4eeyFBJVA8Ft07S6tLeSbBmGjyig7WGZ5GrxX28sUoEv?=
 =?us-ascii?Q?9HS0zJ6xJD0qW4wrhfvBz7AYOH7R50rXn3FoaK53lB7uVFRPkJuqeWQlo8we?=
 =?us-ascii?Q?w8/vRPTd0d1N2JVWScDfn0DioxB7hwNe5AKxjeR1krEqi9Jyx/S96k/d2iIg?=
 =?us-ascii?Q?1JRIoSUFtb0CCErCiYhqiFQNw+zIecvxBtVELsRyrLy8B6l2VOGThVtM3SF1?=
 =?us-ascii?Q?H2o7z/zaVpXWe2sAXquW1Y/iinYk/aX2+z2yL4nKVpvCgxfJyKwcnPKUVh96?=
 =?us-ascii?Q?h4FVF/xb/+tIOyCB/UDEzx/byN9fPXo/1VyZALPWFXJHRSLKzkOLyJChK8ba?=
 =?us-ascii?Q?GcZU2szKJLRd3pJAVnpbF+WVUYehXljEstzwhuxhWf6w7bqPMPqT47UchPUh?=
 =?us-ascii?Q?OI2+5Hhw6vWRTiBQ2khs5F0rHjPmCKVpE1e88QHk41vluT14jJ1LTrqRKomy?=
 =?us-ascii?Q?gmGT54w5KLz78XKV7I2RCYeVTqfJ4rLGxa/vfEI+Sg7NffcHZwvv70fbditM?=
 =?us-ascii?Q?V1a2RWaeD4jjbDENoJYy5gzb/73le9DV0vE/d4iS3aaThIOWtCNX6GGt0gEh?=
 =?us-ascii?Q?WrCZDQTZ69XHjCjPow40viWFrstE3CgykDfTcx9maE0h52/ZV8Q/fhexZSJ2?=
 =?us-ascii?Q?Ec10jHPFJ5IZdNi3IX8UW+J/qshe6s4OucxKeUPePmqlQLCycKUQ0Ema642J?=
 =?us-ascii?Q?4nyt5iR5C1te+ft5fEXLP7nLrVqEFI3XorqhHhJ5P5aLlPyNsE+wQNNHSBHz?=
 =?us-ascii?Q?67aTtj/hxz04l7R2CHOn26ts8oaCL95s4xga78JR+N49PgEV0vbFi0HpuRQt?=
 =?us-ascii?Q?SGeJ6U7+QHJR8zXqhO2tPfLnJsv2OznMxIqIQygy89zVn7scGEPUHeydi6sC?=
 =?us-ascii?Q?3vKiw00ZL5TMwFjPL0DPR7lFsdOE8/+qSiTWtTQaNoBQxqXVfrqXBXwgs/ke?=
 =?us-ascii?Q?3vRCbD9p8sV51mduAQPU0qpJiRXCQpEgNtU89YjFAdzDTBkJqR+jiery3AOV?=
 =?us-ascii?Q?PzOOkgnGg7TNUyt6jL64gtoGisg6t9rKYu2jtjBKGX5IZzmo3wjSftdAuKpR?=
 =?us-ascii?Q?rNKZCwLzCg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af8d91c-0783-4143-ee19-08df0373fd39
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:14:42.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhpUYQrHYkQS3qcOlSu93mYr/terJ5H/N6TMFOh6FkI5OL9B+t7kx6DmwummhmAcVSLMVxZBhhSZ56Mapu+Zug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5866

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
bpf_object_open_opts, allowing users to specify a list of kernel modules
whose BTFs should be loaded. libbpf uses this information to skip
unrelated module BTFs during iteration and stops iterating once all
requested module BTFs have been loaded. Without these options, the
existing behavior remains unchanged.

Performance impact (BPF skeleton open and load time):

  Modules loaded | Default (load all) | With btf_module_names | Speedup
  ---------------|--------------------|-----------------------|--------
  1              | 35.6 ms            | 35.6 ms               | Baseline
  10             | 37.2 ms            | 35.7 ms               | +4.0%
  100            | 46.7 ms            | 36.5 ms               | +21.8%
  300            | 65.2 ms            | 38.5 ms               | +40.9%

Changelog:
v5:	
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

 tools/lib/bpf/libbpf.c                        | 113 ++++++++++++++
 tools/lib/bpf/libbpf.h                        |  24 ++-
 .../bpf/prog_tests/btf_module_names.c         | 139 ++++++++++++++++++
 .../selftests/bpf/progs/btf_module_names.c    |  13 ++
 4 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_names.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_names.c

-- 
2.34.1

