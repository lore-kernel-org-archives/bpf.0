Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012001.outbound.protection.outlook.com [40.107.75.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E533BCD15
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476082; cv=fail; b=hTv1aMjsGXM4wAOh7pnPN3M21BPcG2bBJGGAV+M+1nWq+uuNtMdaoWcvd/YK/VTqFSlMHwbc4wsrdbCgrNd+7gB7x71TlFQ941bKq8z7vYYrlQGezvkb3LBJWyodUT53E0AaCaxN5IZ+Obgg4dMjMS712Un2oPUHLlhQT0xeHCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476082; c=relaxed/simple;
	bh=xPGFnKvev2NWW+kgqNlCqqIuelDVv89AOz5KX+rnhRE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SEK8r5RU7Nl4J30Y1eseKEP5EIaw1MSkoORxsM5xFK9xfRaaqmzMY5HtppyU3VEnY6DRkU40YcqAypG4h8kzEwn4qV1zTyuSUj2Pqd8ngK7yH9P9v9deJOUs8vUeKGITFMTfhfjTkWCH4FrZW+cUEyeg1ivHWisWCzopoZpAxaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Beid6Dcb; arc=fail smtp.client-ip=40.107.75.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Beid6Dcb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD5GTMl8yVNhOuOjEyEDODEyhgmueyvE9jR+gAqAMEMAfsJaAktjngMMtdLf6jJLX30io05oOmlI/KjXA6nUWYeZdWjyzV7F/I7w8m5G3BJNRH1STE01bCSSJX0+/I/gB3N9SYzCvRAv7nMnRDFxDesgKi6yP99U2CyqyMkP5NByTbcNNPaFxDrYp+wjgBWjhX2E7W+IHIRImYJHUaaUEviUXlvLo+i/+TMiKX1l2zPLIqYzN8pB7l2s64zNwHcY+eJPzXvu6ufLI2duekFThzTCgTNnvhMdRIrGZ0TrlguzZY+2tV7NL9XZU4Om2w+Vtfz3RAnLyzy/eafRZg+IOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYQEzzCoIzWuMMCv5HqAwDGLAv/HmyymZrCJC05ws74=;
 b=A19jaIkVhOhpcVB6QxMVOGm8Frk75XhD+jNxkSO0sGUTNuuJZetVREYcduyn3YrZK7GBpTUd+vuD4eSFQHh0RwOVPZJQUkQCFTshderKIcfmiKoKrD2KOpVN875MYJGApbb0wEyv2UberAN3ZJdIkX9c+p7KNzHuVIEt1WmrmbgHOym9xGSv2buWYxc1ND0pSB49arlJoCSbIvmdtshI901xr8PeDN+X+NoKTRwMmU/FYRi1X9ZL3snaVMZYHPrs3pAzwVjD81hcgzraUNHBwnOXd7ODH7wb8uZPBA9I17VMgNu5ojkZIsxm5SWXyMX3Hk5K1Vlv3MYczSTyzIoGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYQEzzCoIzWuMMCv5HqAwDGLAv/HmyymZrCJC05ws74=;
 b=Beid6Dcb1snqz0lval+s7WIjh7JXOmImwVr4bvApdglebjbAlrbmdfLtEx+1Iy4sPaVlJCBspydWOyCenNlJQC3ldXT1AZZQrHX3O/GdRekO27WeMRz9+RfOZRhfzen+5XhQaB0M3lrzrGsE1LKAazaCrhrjO/wAG6zqapCuYUqn3cEuRvri3XMMPK20b21mo5JgSwkTbBMO57DUOyQW7fSG8wOb5rohb3axcx017boMolEnRZn1X3nXO2j7QQCW0ibMdNdZeHeAf9C8uhMyxdXVm2v0WD951PxcPMtTrmZsadAniZ5GhXCJXWwN+0Oe7sm3D62odCwLvhWY01/4vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYNPR06MB8829.apcprd06.prod.outlook.com (2603:1096:405:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 12:41:16 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 12:41:15 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v9 0/2] libbpf: improve BPF load performance by selectively loading module BTFs
Date: Tue, 15 Sep 2026 20:41:02 +0800
Message-Id: <20260915124104.77287-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYNPR06MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: d401eaa4-12ba-45c6-4ff7-08df1326a18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|23010399003|6133799003|56012099006|11063799006|10067099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	yViseJblJnD5Q0blifXotGTHGtXlPr8krgyXv1dB1QHMk9UGkSFzRMx5tusGAUp4I8aWRmfFdp9hj9cv6im6X4BaM6hYi2ipYdMchrLuVsKPxRffoy0bnqDDLyWfbooGTDHtxX3P0cZ1ON0Y0nEaha8LJCE+Ca7XpZ15t4mHz1/1KHumDNCRe7xjHR09HS4vlFmumJlTbdB+P506K07KXth+Cz8WIaqbggWNEoK/BaCjD4MWTh9wrG6P83HP5nRW1DLhVTMcxeh/cHVMOmUpgh53x5mwOwjSgsCKQZrigRfg8QsoeOq+idHbyuxXheyiZbD07smZNlS5ONoKp9eZAJpPUM4CehaqH7mssA244YXn+wPVN3f4ORxbzYG1b0Ljm7H0LbouX28hTyPtsNKOLMVwAo+AUqGPgIfri1ARLxkOAwX/FGA9b/YRKUgfvrbCk74z2/2ybHNfnG2X67SZWbJpq/AiQi7zSNiCruzb+lM5EI5A9P9t6WvmFxeJDDemlcDq93jpNxTaGiSi2h5MBHGYpODy7Ye9gVlmqhI1h2/859cozNfo7vPkAGbEXzVpohIkxFBdpVIleG5C3yME7TacU0XvzpPH3vn5rfYALByLGlbPd5bH/pnfDmrN6L8tNCrQcj72FnG1INS8ojfQ/abDn+Na+gwIbEt0geOkcL9KsclaeGU7d4FIxTi9GPAYtT1SKbQ6EOMqzFCGyVqyN+M4CFfrUnWedLWEZFK9hLU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6HSgrvDwEJIh8Rgshq/flGNCgw95OOze30iy70ykofoG7j5N0CWrk2wlf5Bm?=
 =?us-ascii?Q?RuYszj3Y43NKMdllEXz1fTBHYJajPl0HapeHChDLpEQnqUbhe7VbiyVddSxC?=
 =?us-ascii?Q?ul2OT3k/Ry5VT0qJBjRn8Ljap00q2pLK+Ubf7KvrqG6dLrR7RSoQHBt5tDhU?=
 =?us-ascii?Q?ukd0y66yuw0xJLpajyBqDHcc6BowAiSawBA6TnMK/iKDU/fpTkXE5Lk4mhc1?=
 =?us-ascii?Q?R5TI+1BXIlAqOUQcAtSVvY815EYDtx8E/cuE5ZB9/R0+e2fP/F4B0dXZ3MJB?=
 =?us-ascii?Q?2PRSdCzWOCbHmMDRIUAhax/1cOcnxFijKgq4DN869WaE2UdEbJ+AebySYi9Q?=
 =?us-ascii?Q?tWYc3DLx/MWOozvzdCSqUoBycb3892dR67Cf8OTP25fLkGAmfUVcW9fXj7CC?=
 =?us-ascii?Q?hQLjnxjefwIxnm7WEz5yx0w6lN1vWFudNAdDpNvBSX9rHbp097Eq1BJtUA6G?=
 =?us-ascii?Q?O7xADU/jd/PuKmXnTStKgPcDMcnEEik8qJLRT3FtTkPuBVFvJbAMumIGnNf/?=
 =?us-ascii?Q?gmSIQGMDHqAdhMewrWg9GN3SPh1JEVD4y1TY/KZsFv+rMyX84dDO+fH5hjAu?=
 =?us-ascii?Q?OS9KhbsqGhYv81DSvRcjyh12s6kxIpVdRP2A8f7plKjLuMM4BQqI1T/aHscJ?=
 =?us-ascii?Q?YsakXkVjaeY52svM1JYlTukTWHaToMHATJT8m6dN3JTEfhs+FMePKu33IZQ0?=
 =?us-ascii?Q?HSej5Ter20vu1PURXGmSjftc3hVkKgdPeutMTZOqktmJuAhvKbZyKGUQc2VT?=
 =?us-ascii?Q?n6Nd/mZNVGe1i2Iq2/shdx1hbuVznVIbtnlOLseSvCLbqY1xoJlRL9BpjMGn?=
 =?us-ascii?Q?WmaGXoN7m8w0VpaLSIkU8A7KEncrxfUNDGsd+nOHWqkiDvWvtct6pYPiMvga?=
 =?us-ascii?Q?xjta+ztiJ5I75svkFyN3IZjd4IUBNxbLexujPtyBD5K2836oQr1pNksLbT3M?=
 =?us-ascii?Q?F/g/OL9VHchLza5ffXc7pr8QIue9EdJWukHP7aeMGGHavLH8E8PvwRpCZMGx?=
 =?us-ascii?Q?FpY3PlugszFu+H6QDMwAD3jo2dVBKQt8yJk+fScPQVx3VPrnuhu+3AjVwFPL?=
 =?us-ascii?Q?tn1YugOXw11kEvcM2gQAKwIzym7QSztynMoZv0Lna5ilEQiZXp5lB9LZk3kF?=
 =?us-ascii?Q?X4ASSbY0uKheoHLalfqfk/tYRDcvLbdYHJWQr8xi9Xk0fpnamwmN9H1iQGMv?=
 =?us-ascii?Q?9+4auT+/r4jIFDIo4HIT56FgkCA/EeiDGmktznzjFLC3luIHFwVh3wxC3E/h?=
 =?us-ascii?Q?yoLGFIHmVhgHui8c2oK7bk3I98/GLimMWAfc3h+Zbz8/+nE1Y2U5f7OweId1?=
 =?us-ascii?Q?V366QiEylLIkGgo6eCZS2tXuCB+d9SsKxBoU63X7W8c5cTBDW7Gr1rQr8JNU?=
 =?us-ascii?Q?zRQYUebvMkB1NU9w+QQ5jfEFCEqK7+NzfMMr7SKvkFjdmvJe91LUDCGSrUnQ?=
 =?us-ascii?Q?EGS+GGahfifsM3Md5Nt3g0IBk2DmU2pgtPNzKIvoITCo2RU7apIYB8ZePmNa?=
 =?us-ascii?Q?9M1hgc/KbBP+rElhc2DO5pHuF9BIlae6h9GdeUEIWTkyYZ+by8D/6NBDsUCE?=
 =?us-ascii?Q?lN8E2beE8d5fNxr5WUfuwj+3Zj02JxekcuQB9DKxQuTiVdrRBLYH1vnznWDh?=
 =?us-ascii?Q?hrDsS/Hl72XApKlsvPVjAQ2x8BnuuElS1lSDWfZJ3TFmFTgL73DdUfWA9y8R?=
 =?us-ascii?Q?03DYldIuEcWkRwG9qcQ91eSr2RIxaA0o/o/hUNH5iuIGDMU4Lc1tMloTe+fx?=
 =?us-ascii?Q?0gboU03Z2A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d401eaa4-12ba-45c6-4ff7-08df1326a18e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:41:15.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pvCutrhRAjGJ2px6P9TxM894jM+QxuV9knR56z3oG7FaciKyPnk9YtEmVwMd8jlf4A3prQw/ZaMTPXj9+hyYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8829

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
v9:
- Change btf_module_allowlist_cnt to size_t in opts and use ssize_t
  internally. (Andrii)
- Clarify the empty allowlist test comment. (bot+bpf-ci)
- Match subtest names with function names. (bot+bpf-ci)

v8:
- Link: https://lore.kernel.org/bpf/20260911120820.46900-1-zhaofuyu@vivo.com/
- Reset btf_module_allowlist_cnt on allocation failure to avoid a NULL
  pointer dereference during cleanup. (sashiko-bot)
- Fix errno handling in invalid input tests. (sashiko-bot)
- Remove the redundant default opts test. (Jiri)
- Test skipping unlisted module BTFs using bpf_program__set_attach_target(). (Jiri)
- Simplify module BTF loading logic by using btf_module_allowlist_cnt
  alone for subsequent checks. (Jiri)
- Fix remaining libbpf_get_error() usage in selftests. (Andrii)

v7:
- Link: https://lore.kernel.org/bpf/20260907053847.1115-1-zhaofuyu@vivo.com/
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

 tools/lib/bpf/libbpf.c                        |  70 ++++++++
 tools/lib/bpf/libbpf.h                        |  16 +-
 .../bpf/prog_tests/btf_module_allowlist.c     | 162 ++++++++++++++++++
 .../bpf/progs/btf_module_allowlist.c          |  13 ++
 4 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_allowlist.c

-- 
2.34.1

