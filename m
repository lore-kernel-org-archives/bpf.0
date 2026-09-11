Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013005.outbound.protection.outlook.com [52.101.127.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE854582F6
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128516; cv=fail; b=YbZCzHls+9ldIG42KqF9k3OLjPjNf0Ul2K0BYDbcNZmyhBy3LTaFEt7g1YIT7j3CHvjqDcOhoKZtbAmLYGzz8lcn4e06IxEB6ya6h7TJ/wwrrsTOd2enohLRY59AvNRYSbmWJaONLssf/0/5aIUtTe7KRS+Hj3UvIzVzL1VJHKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128516; c=relaxed/simple;
	bh=VZho9qSDRaXbzntJ42vgHEyUJPh4sOq6PYSJmpbQ4LA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pyTQGWCJaGV6ueGepJxUNNXENkEF6moPomPhXYV9kdNpcrPUthPbA5tCyd9G5Ppld44B1X1NOq2QnnemIFxOKyp402MuME2XEqXtiepH6kU9IBxqHa7JMYFgrzmMz0+cvwxNbhe6ecpe0VPgGblNZOlsSKxvyQ37Q0/X7XlSIrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nc/v7CJl; arc=fail smtp.client-ip=52.101.127.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nc/v7CJl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol4gOgXrK3e4pZXMfZQD1jifL4LX0RipaiY3eVhwSdNZkeK+V+M+8st95CLwSnGZH0V4H0QI0Lwnrgbgw7KJAcIWeCwr1VRJLDes703sVb+I7pQuGhma85sdN53XbtL3mDtch7EgGfyM/rBIAV4vkdW5AUnTSQCgOZZGgoP9Lo2W7jShDgGbg8bIdzRe0/B4C7osjY7vBYKkYCmL1QuI7Y4YFmxo8k/Qn135B6t96JcEL1PfTiPuP3P1Los6yvDLgpMBajDubIUO2muhCCvtjOhL0vHfwNJk2KzzmMZRt8GvLGzs/AVAwmdPSlfFblfnCHgmiU0XAychy8ELnwEbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMdebXZHipY+mJY8PHS7a73u5M/iWzvE6/2INf7X9hs=;
 b=f8N661EaD7dtBo6IC+0rFJyJeT7JvUwGJoG3M09cuDWQwjtYuk2eEn5ykL3uC1+vq3Ov0sJNrKAKhI3/qAWGDrPUZLVeZRtnIvouVbPbuiz8e3iMRq7hu8gC9HC/GGQUPDxMWZaTXb4r5bEOIxT///QhCPzb1xOuL5tyX9BTgsaqNQZo3mUNYMSi3nax1mqO3Lhk3fR77RFr2tAAigiygIrj4xIpAsMzcf4cbUaxRPxzW2PHPAMN6ykht3mwrPPkoz5N54j9iJl9Jx5BkLBJkscWplcX3mb8GasYDWY64D1iiYCexBlJ8RwV/kjBR1o3C2/7srsu34jTD98mp7sFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMdebXZHipY+mJY8PHS7a73u5M/iWzvE6/2INf7X9hs=;
 b=nc/v7CJlqmClRa6/+kJvRlEQTrIZUOqEfAz4PwKQM6lVV1a70jJyK/BBQLWRqQbqRVFgo1U4pzUulMHegUaViQQbhlKcEcUrsIYe2DHwuK+bNIW3E+KKF0mCDLvskozqOTt3fcH/vcw7ZlUi/1TwHcf9PYwGIbXARHpOeV3DTDK4tnBlke88Om8GQ+YMkJoMD8I2OYqyrIo0mQUwlWOj9dtJP0Lj8yEQA4H2YV4eXQqVTVZpdgJpyoB43/W/YMu3Ek0NxsAHNuRGQZctm1LgLq/28VsyEGFsMzs/Te0i1H0aO1Crc41jJIRR2RMjnzZLhAk3UjQugl6WjeWPq89rmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB6755.apcprd06.prod.outlook.com (2603:1096:101:165::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:08:30 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 12:08:30 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v8 0/2] libbpf: improve BPF load performance by selectively loading module BTFs
Date: Fri, 11 Sep 2026 20:08:18 +0800
Message-Id: <20260911120820.46900-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEYPR06MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 435eadbe-8a80-4bf1-da36-08df0ffd64a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|52116014|6133799003|18002099003|56012099006|11063799006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	0+0vLpHONAZCA2g88dReIOjwnl1VGBBZ1PCsHMc/tLmjusJH0CslDn0U151HdXFPNKn1VEDi9iq6Q1sQRF1zpyZnq54+79ASsQLhvAMvPTsyVtFhnRa6xKGRttduX9g+aKquEUPO+csUxhK33W2kkJmFYPZyaAKu5q6urEbfpA46cZs/Cbx7AE8iLJK2DpT7sle+aAAvaRTE2ey9zs98gp6kqyoGM/WRxahP+W1uHLROW4Fs4obIqgFCGjas9Ex4gznYbuFdsLjkS4gF0cs2xfxAC7CuKAc7CgQFnmrV3MotZB0FHBYfad/jRHK/ypax1/XDokkxCTqoB/27sfaX4MJtahQL3TiKFEheIEOhBe4tkyQhI/hQPFpg0ZQi0PJCqI3Y2eLylsbgJG8dSEJgdus/hWmi1RVg4QI6VdbsqphjCMiFB10CfP4yBUrZqbKMU3LuCVIXdPTiq2YDg7f54JwEVCez5bD8/BA5c6pHh3dUS1Su1xvB8Sqo7czxv7yvKixV37Fsu3bZROM7BIO/mPhRc+HdBURE+sTWbPIFgkdBvChq7Ei0l+Lex19khPP39XUuVeCUyVE+8Ep1GR2wzPldYjlQOwytQ81kEFjr1wlJYSoFADmyMiQuqDJ5D+yxeXbUXfpp2LhLJxv1CvByNIIXroEoNAsDbkI6rON8PbsyVXHD/e56z+NjeHdprH44mP2MOY/+p0+UT1Rqvob2ODscKopjRucwrRMYLkUKLpc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(52116014)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LbyHFrPY0Cl32reAknL+qKMzyqV0U5ywYDhuJkthded7M5phV5bZDJaN1kSo?=
 =?us-ascii?Q?SuCu+FU9fts9MbUnKdlKxjuuOUYOY7tdjMNe0z1Ryvv/JC2OJzCOwBwNeqcc?=
 =?us-ascii?Q?jf3OAWHLm4DM/71L5fggcW+iRoRXp9QU1XfiuZ2vS+TORy+2AAnmnb1QbjGp?=
 =?us-ascii?Q?sk08BoInILd6VLmAiI0vKAL0GUoCOtLK+LF5ZwquqbtcJZmdpgjRB7hHbFmO?=
 =?us-ascii?Q?WU7GFyEjAGCcf/juvNYT3LvP1yZCtt2cWxK/kxpp2u8Vj9DS0omI6SXhUPbr?=
 =?us-ascii?Q?L8QQlYh/i/I0lazb0hY3UISjU2YDTbs9KDRkZ8ik7c7fhwI80INliUuAfCjw?=
 =?us-ascii?Q?8sYiHYCNkVrgcNl8TquPzjuIpLgNPgfEeVLoQeMXmda58csQUDw1tCryu7Iu?=
 =?us-ascii?Q?lK9O65AHKVy1OZBCfiDLUvhZcI2LRE+g1GkDMgxWMjVbw9uT/newEdInzTSy?=
 =?us-ascii?Q?xOMRl341xT3w7deHdMDFhhyyNfpYCqxhpM8/fBjawaVIOE/XGMpOM27+dozu?=
 =?us-ascii?Q?qHRsKZmwyS6eQpmytZRu2EEB1mk+OxASeBJhHsDttiXEddPbgai8w4DNJBsp?=
 =?us-ascii?Q?Xe7wW0cleiUyLn+Hqq4FoHbrj+8/EJ8tT4UDaRq3z6QNmmqE7znxaD2ihxQj?=
 =?us-ascii?Q?D4YoLm+LquJLNlXgH+jlgcuDTcZ5P8IH/cmjLO+qqkCpCUOuUA59LnX5HEuQ?=
 =?us-ascii?Q?l4jZEeAlpeVILLOckrUt+oPQoZ5fu/OQhyz6lgwfJMaEih7gKTXY0qry0agD?=
 =?us-ascii?Q?O3vGHDKEkN/VlZzjyfPZLVFpFJ1S0+ELogPNgEuzRjal8J1hxp3Ql0we1nLQ?=
 =?us-ascii?Q?0yLWU2KKszjpVJaE6UAbf8bgEcimTVXZ6iP9ZnOAiY980PSIofWtiRAJPnzC?=
 =?us-ascii?Q?TmDXdpSjW8u1JNcdZxJqCpXuYcKwZxlxCijFXmYqDmrzWl4Iw0nSzA3QTZSX?=
 =?us-ascii?Q?Gr1T1wzWi1/3Mc9Wms/9/oYyHBtD2EWU3HWts2cbydKO2g/F7IO24Us5G1bq?=
 =?us-ascii?Q?xxN+NmfpuF27/5odgjUiDHDfyQW24WSzUtBMBSw0XcuV20vkwD1m52TvXF49?=
 =?us-ascii?Q?ySarOWNW512FQa1ybyWv9nnV0CCjL/NTKgZ4N+PZ+1u6s+v2R2qDFbPL9i6K?=
 =?us-ascii?Q?CDDZPjKg/lFP0o4yyVjIdP4qb3aY2mc+8du845PGSCN8Ov0GhnC1rlAlhG90?=
 =?us-ascii?Q?Cnqtg9GTZizFHk5wKYkXA2xCZSAN0B4wnZYjfIu439tQMoptqT1s3Su8EkWX?=
 =?us-ascii?Q?xk1Gq3J8Q8iLb44X6WL0H3uAG2WsuCv0l/nlmJ51oBPdvWJM6/gl3fgE5Bk7?=
 =?us-ascii?Q?NzULOw/HMNI+GHBY1+WxECMtqFcQt99REpS16GQ1b1xAn8ueb8LhWUtIY/w7?=
 =?us-ascii?Q?D2/NT4/TG+GXqFqLVSB3Ju4sVYXB+ABM10z4J+rljVtoJPP9PRJy/lFcV3uo?=
 =?us-ascii?Q?Q0s7UFpm1NDuOvF/KNJZlTwliOWWaeRlWHP1PHvBLY2/S+SZWe1onBMOO95z?=
 =?us-ascii?Q?n+CDbwT3WbbmwCvsYGt5x1AwuHEKsmbu3JNsI2vVsioOsZAL59707rhUXwmu?=
 =?us-ascii?Q?kL0/PGtB2+o2+5NI7w1yVAiGCbKnptpyKyNKnSQRMrdaa1ux5uRKfbqdKPQa?=
 =?us-ascii?Q?mwxvYqVjSsvnbHrjc9X6DXHRUsVF6NoFHi8vHxHz10fQ7fGsJPxQJxLErA6O?=
 =?us-ascii?Q?AbqyYPjogrEEN2wibt99XyJO1ljkX89Sliiqnw6TQX6c8I/prOd/ecs3Snvz?=
 =?us-ascii?Q?uNGR77KBDg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435eadbe-8a80-4bf1-da36-08df0ffd64a7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:08:30.3857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG5xoi6ao7OfyBJsMHSncqp18pw8zzaku7Zc9kQxlbvC2Y6Fe/7gNVDzRcuP0NR5GJXckNY3yFFUBFWehd3afg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6755

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
v8:
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

 tools/lib/bpf/libbpf.c                        |  72 +++++++-
 tools/lib/bpf/libbpf.h                        |  16 +-
 .../bpf/prog_tests/btf_module_allowlist.c     | 159 ++++++++++++++++++
 .../bpf/progs/btf_module_allowlist.c          |  13 ++
 4 files changed, 258 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_allowlist.c

-- 
2.34.1

