Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013024.outbound.protection.outlook.com [52.101.127.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950F41A564;
	Mon, 24 Aug 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576008; cv=fail; b=i/ae/gIiTbxN/hxZz65SAakh7lp/zMimCB+wk9fFz+NRm1GeSB+7z+da41BeH1RfaM0b0fIG6L93okieiOc3PDplMvmnsY8uLBSvl+6J/VpT4Ww8G7KXQppl7LNMbnIhlGd4qqKnCXHJRJcI6CsX38DH42jtBUjEZI1d35N7Cj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576008; c=relaxed/simple;
	bh=xhGkj4QwKeDc7FfwIihbwcwSIJf0uyfZATtWESN7ZeI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AuK4dnBHsvJzBgxjGM2uA2GhnOtWclC/U56fuYerT6lc6vsZYJTTD8l1/JhQ0ICJ88HcRRuusLNLDAs2iliKrtW1jlMmzwpqi07Zte3QuMZdYtZsu9vBbuQ+0l3BpaMpgzVLwBM4aQb1H0BCIjgaRCmhLmru9guc7xMHPQls1W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MObtPQzw; arc=fail smtp.client-ip=52.101.127.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MObtPQzw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ld5NPF8mYtD0AhooX5IkAxrTh2jmb13/VZMoLo2K5u61wf4s7f6WGcjuClw+OZnjWygVvOfmtSeeVRuqEIHFqP+p9/A//8W9quEsxidtrt+tmhatGuEUYMn5hhdIvYeUaY9LqLzp0Zw13hWP/jwj/c40an8Ur2v86IclUyM4DSHPyp/s8PXBkKurTf8nqeCXHmG1jR6HAMFYoFXU4GqQhyMcgSy+6jTh5J/wMEPLru/I9ypZg0qJbGDmCS3JWpdgpQvXcDp9ZGxdt2UQj3o/laMJcXzGgBSEJgBT5fhJVHTqTR8fCUEUZ38+UcyGeDyAsmjt+bC/WH6FC0WPVkJTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdnuQkRMgaeJWX8olNjEJPYmUOjEkjX5GVIeYgXa3Kc=;
 b=PceaGI2srU+yHriYLiemt4piBtc0gEwARKmJuhCVShiMU9816AxQ9fRXhNptcEh8zCldH9KA9EQq789Aks3jkEV32Fg7M2fEgmQTGLG1XvjApwB9B/I8AfdDtARgVJWSCTXniJIe1gNvd8xkpCx+10v7sFR3TdXr4ykLhov7sqJjEpQHKcvSurZl14x2aBhTiHaQo/lntwkBEFXTXW3vn3ZhRD5wwhZkeVeCVzAXpUkcwny9ghfHJ7llNuKIa9WoTnz26DdtvtX+sxhgM0/c8trtnGZtfy04aRfl36comlsfzGeFdhL0T8ztMKJuy+mbgd8q9zjTiWnsOT9T2zCPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdnuQkRMgaeJWX8olNjEJPYmUOjEkjX5GVIeYgXa3Kc=;
 b=MObtPQzwSxKfTj142hroORBDwyOrVOIYXjc0wNJije091WhkKm9e00dVWsj2gKs3D8SvwrB6UXGUG5Q+qb2Ueu8uf3OY/cDff5BnF1tvl5yQAN/3KNLlh/ElWom6fhLoCUoQhoihNAD3y7+4kwj34M4w0ruhhQDpU+OZghd+VfSj7um5KIzIUACaBYQpwfwzgCJgE+yAoxD5xU4P9WJRTGAKGRTFQpIzJpfSvrK9q1pMqK/Gb2uY2YpHUzrWydp57WD4B2xIxvgn/TLKSzq5Cg4zyMuhMUL4AHnM41cqEwvkggQRg0kvcpTVxGinsB+i4sF2F775sh5eU9UvT6hc9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TY0PR06MB5210.apcprd06.prod.outlook.com (2603:1096:400:21c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:53:21 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:53:21 +0000
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
Subject: [PATCH bpf-next v4 0/2] libbpf: Improve BPF load performance by selectively loading kmod BTFs
Date: Mon, 24 Aug 2026 20:53:08 +0800
Message-Id: <20260824125310.1384-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TY0PR06MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4c50d3-78d7-4403-c65c-08df01dead67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|23010399003|18002099003|11063799006|56012099006|38350700014|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	x3wlF8DKNL9eUDployzE77iw7AEOOIXcOMjOEfHHGt9fNs3os5N3Qn8oYfTCJAd7NJmI9eEobbx7R3aedZnqppyeYaGHMnzvGn19wbobA7+4Yt4gKU58zPS2cjP3Lu0qpJWsX3p8y4Uvwu7dkaRYrkpEncbvsG7S0v/md4r+BJNSJgKziGj27v6kP3GP0RBTvPfuSNQp65uPiHA26i93dinHoLa5bszWqch9ryMjTgjMkJZina/r64fsxbjlVZYG0ARJR9XbmOPSgvaXh3tZCfustLmEq989FmaacVA061qdf6njapno4Ae9N7leyNLhpPRSo/kJXtidsUZIW829/9D1PqMmve1GK85UoA52gMMpSSOgHqrtTABmpSJ3zNcZsGTjSbMCHGgnfi/PQXVsx/fGWDG7XWvI5YF/bcGdBZyecq4eFqHhgVGBR6PBzDDpgd9s4NTu+v/dGUApFG9wBAz6WfGp6oyTGMO04sHPLkdR/gs7tzXNZ0JnxrEWPx3XB/gXqdODEOne+e3V4LwmkTosFU3XCMSRQ1sEIPwJj4Uz6H1EkbXudoyR/7HGjNV1mEDQisfi1EsFeMNtxWF2LFNvzyHWBAH0rC6/gcuxwTn+OoHRkXE5ikwNJM2YBqTF8tEFP2tU2D2RdNjHKuNrq0lRYt9/TiuCkY/0D8lHRx1jIvcfMvdO4tcsIcstJh0SbqFR18HsiEpn83LOrXMGalexpn7VnKlgcua/IR3/WEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(38350700014)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9AhPDqrMedHNQq37NL8an60Xp34Z3bxwkWE08dfEAu3CGQxMbHRgFxD0ZIc6?=
 =?us-ascii?Q?M1WvPd6CyJCSN+hZ9WEf4Gag0L04MyXUfwLUnVOMG0cJL3c/gMgDVVLWsvQO?=
 =?us-ascii?Q?9EPFwluJEGEBnC4BLP4K3TZgk98+3JdeY8zamSgasn39XFz3CYuiQfHeEnzX?=
 =?us-ascii?Q?JUdTUB10RHEsdVnskCpaLDKqGLb3BlbIuj3CQMTkpo9wuyzFTj8Q/WEVC9Xc?=
 =?us-ascii?Q?C1ts6xmrlOVUmhHTT1rBIqsaeNJj2mD9yJlOh3GyNPRylAxXHN+e6AhV7VN2?=
 =?us-ascii?Q?YPQnK2Gm9MHHUtcUo1lnDY2GNlhq7cnLi4PIUKg6008yM/JO7MGznzFLYChc?=
 =?us-ascii?Q?KS4AqbHy7+P106geA2KCPRi/sY2GUo3GcQlbGmU/gyFeCLj+2sBGhd0zsOne?=
 =?us-ascii?Q?6HcGnV3ox7luqMkUtmcsijrQLZ/5Z50KkJcsjvkpkpXxXXHB/E+1zmyCaMnX?=
 =?us-ascii?Q?sTQf/XcvcvMh8ImUspMszrMlmXyh97fHM8RuO4DRsHEIo5lqQAj029QTX/9k?=
 =?us-ascii?Q?yZjzWq828br3k3Pf5TaPPKPzgKj1myh03AI9zSN2yx4hkGxbh4KgEMuLBnqD?=
 =?us-ascii?Q?N9qp5V8LEx1oPBMtSC+bnXZT83yTqvLvQhw61QBXDpF26i2pD6z/EbVk2vM6?=
 =?us-ascii?Q?Vil0aZgdy1r47m4yuWuofgqsaWUFjpZhO7DUmXYsi90dE3YCmINCjncLqf5y?=
 =?us-ascii?Q?G9idCUhQFiFRcT3UGOl8G1rFUTdb+rWo5wiurXGI4SzBQVR/OyTinC8u4tPT?=
 =?us-ascii?Q?47rLj8z1f8/I/HJeopyLF/M6t9ZrPdJgDVS935iwaZR0Rv/C66TFbi0ToMcQ?=
 =?us-ascii?Q?aQQeIUNI08YUBW81b0cqiS6BwoKhuANfJmdLyHpQfUwx6ynx2tAPXZylOBvf?=
 =?us-ascii?Q?oe+6VkkgSIfExLfQPAWDKn/bZ+h4m7Y3oOLPHzEvFM2/xPDnQNMgIiQfLMKG?=
 =?us-ascii?Q?PdEPxWyZZdSFGDFvLE7c1VTCjx9jaR+3tZatt8kt5/UOZ8vL/N0sDwHdFhCC?=
 =?us-ascii?Q?jAFbVyZda8IXUbdJgDkDHFai6dzDG7Nin1NLkBYllr+TtisBn2Aza9Gz94go?=
 =?us-ascii?Q?cs2sptFGkjNWZzAIBEbIJtpOsEblkxDKnIi2k/kjs0b19xnGV0cqDvTfS5pI?=
 =?us-ascii?Q?i+aDy+CMy+gxrlgGJy76x8x/aRUzx9cGPCz2Stvt1m/bDvwZHCNhCgZ/VAc4?=
 =?us-ascii?Q?Q+3wgri/f9dJOOahA46ezKbZR9P+mRu7971jM2sG4U1/BocjYMIgGf4pjDbW?=
 =?us-ascii?Q?dD3yABwFG/HbZWdDA2DgYfAtw0XpgGogwlj+Gl96RrBfP+8QbG/3+bZRHtnx?=
 =?us-ascii?Q?blB3A8WXxxY2Sbc14tgdCb6rbDGvaKXGGl9SiKpOBsmw6gUtLknKLVzZdVgh?=
 =?us-ascii?Q?cuDutjUqhlgkMkhgGkSpQtscutQRtrYXIosdrGuV6upPIkG3yJd+UgeQbNzs?=
 =?us-ascii?Q?xFLVavuexgH0zRxAm+i/CZ3SfvH72KJsZtczO2wzCAANbCX55z3sMjvEW3rp?=
 =?us-ascii?Q?20cpfbVhwYlVs2cJ4Kzyn5IBvby1qEd7qyEBVfXzVpAQJyUpzKQ1MUwDBFq4?=
 =?us-ascii?Q?c57hW5V48Cc6ioosledbnsYrvFoRxyZeaLRQ8lBAOBC7iFMuWikZKTCyNrZM?=
 =?us-ascii?Q?QFtXUqS1RwIWtl2c8R8T2VZlJLFDccik6niutp3kVMRbCMDBpWJZYavI5swB?=
 =?us-ascii?Q?uOJtTEEF7hfkvFEoiomAQ2ihD7jxNSf0FUOFFHxmKHSehgV/GHrT7/koMBbH?=
 =?us-ascii?Q?9Fjk6GWq9w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4c50d3-78d7-4403-c65c-08df01dead67
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:53:21.4335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K76e54yj2Snsbkl5fTzMiNvbKgFfF9O4Z9++CWF152we1fOHhyNMyVeW6U1461+ddKt8goD3P2wF28sL1OxIRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5210

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
v4:
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

 tools/lib/bpf/libbpf.c                        | 105 ++++++++++++++++++
 tools/lib/bpf/libbpf.h                        |  24 +++-
 .../bpf/prog_tests/btf_module_names.c         |  93 ++++++++++++++++
 .../selftests/bpf/progs/btf_module_names.c    |  13 +++
 4 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_names.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_names.c

-- 
2.34.1

