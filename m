Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012001.outbound.protection.outlook.com [40.107.75.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B23BFAF5
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476084; cv=fail; b=RIayLJYtfzku5PfbUl8eEB44COWHwJ51s1m3H9H+2c302pup+esAHameKihU5wjeyQTwRF0AoEMPCPrNcOnbuIl2IqcRj4lZyQ10aEpBqLhgA8zArHRYts4yLU7r71LNtukkp4724dhtKc8Vilk4djW5kWh5KPVJgm2TZFOjoSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476084; c=relaxed/simple;
	bh=QjeegJtThoazlm4tStjr6fWLmPtMb2To9gBYXE5dJuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNaTUMEwBrAGYqz/ezitxHBYTrlZcM/x/c1hST82G/rG3d0w2VDqqTkxw3vB88UR3odpCF4QeKeInWBy5ChIIzpYDRLg+F5tkawQWK+hpMBFL2coa3lCBiqW4jn35kchTqxO1KXXKgXcziOehTFrYyklwZj3Hk3nClS0Aovkw5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aubtaPP5; arc=fail smtp.client-ip=40.107.75.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aubtaPP5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qloazGTRWjsmwfIbBf0QfR3d83hl+Ghn0HSCx2xkiaB/ZAedMZZCKT+FUkZzkvhBlhAsIsACySWFLeEy1y0RCFgOzBdkN9JiuldwURyK5V1q5rB9QH5x86WPCTbiw082dYc6rCxjM7u1/htZxmWv+2XTmad/X0EtxZObmUE2QOEuJaY9gdXKHPtlWYwnExQk3b+Gftw+VhT5IdPLzOy16TChwprjrI5o/sQQFLxiyHDfu1SZORTbKHBpVRny5n/Edkkdzdv91Yq9MVXkQhK/sG3xDK/mJzvU81bo5thFR3Xvlm5md/I7pSGm9GiekY9wXpvaVL+GNAtvkUJIajiKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6w6TQxNuY86lD0aQEthmWithBFzV/kH+YGREfns89s=;
 b=TZyL+OZG+DJ8oYwxGyoP7XSTt5dfHz2V35oWQPvHL+A2zv39hLHnBqA1PKdQxIVA91rS4eorhG662I4pingze0efusmhYYbqOvcv3G3mtlFEVtAefkFpplye8bmFLGFzjf68kkEmwPbeERRBrGlkG6V86GoozSYxhZ//8mq/nnnckEd47KSY/uXxnrBHrmZKltPD5PtLEajMEdHOoX7E0DV2X2epr7CcpSZI+h8VU1qCgWC2ETYOHYipJKl3Ty1HZ+jXjqo33//BLO+GP3bAiq7HQaE5e44l4Kkk2smZxMDY85unSQH4hF7PNd8/Lgo0I4E8NtOeRxWuAOfbbV9mTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6w6TQxNuY86lD0aQEthmWithBFzV/kH+YGREfns89s=;
 b=aubtaPP5bixerXQQ1n9NTswS6WSteamx/hyTaDBf/scw4WKK5kDwa7sBRo7exJ/pwDyagi5b5SozRCQAdLtT4HsgAkWAbgpLkci4KuTA3HybbcNozWKiF8NSLN/am5ck3CTVn5+s89Wza+oX8H7Edqpe9vZc1E7tFnADdkaDLa8/EwJv1s3jAPW6UhdzPOWrUx410qnkduUAimaFyOh4NDFz1K4/PUTgI+iEZFlMld3DxgScapgGpHBqwXDBVlmZqNqEDLi6yW3DkU8GoIX+Kx0tmEwU4GzcLoJB1HTgV0fxNGG6ZLVqgoIoB916BlBUgIx+tMFuq6m9TcIcINf3Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYNPR06MB8829.apcprd06.prod.outlook.com (2603:1096:405:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 12:41:17 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 12:41:17 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	Fuyu Zhao <zhaofuyu@vivo.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v9 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
Date: Tue, 15 Sep 2026 20:41:03 +0800
Message-Id: <20260915124104.77287-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915124104.77287-1-zhaofuyu@vivo.com>
References: <20260915124104.77287-1-zhaofuyu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3efc919f-8716-475c-57cd-08df1326a2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|23010399003|6133799003|56012099006|11063799006|3023799007|22082099003|10067099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	YuWpsPf+bmAAJcGHUVvnSS2u27vX/rF9MJFdSxeIsEbArL6sxYCtYwndHVsHSJHlSoRJIOGCgqksr/+1Uq2QQHYNoGeQwIcBjNfofanyn8L3JqYrNDzhBVdmm2+hvQym5xlY+juo9DMIFZwXSuCBx1oouNJyZYjPCDvL6bRkqW22fCBHGQE5bcloPjlOyw5IVPItPKoyk3YB+iELk73LM5Ucv/Kv8uRBtbATZa9z3yek94cGNAgT3SSBZhPnHsOc3NVjt76n0Kit7VR8gNQeo6WxfZvTRpRSuKrieyZos6TyDgDh/8+R7Wo7H0f8LrH0Ny9Bb9VFp96wx0XIUZwWYn0i9b8eUXmqlXESKmCpA0esa4PJY7smma9oMiePjBrz1rYicv1eqPziktklxoBT3tK/57r9IkPmyhw3e+9hvL4l9bW5uYI9GaJbq90jBPWUGEulKposVtA6tH5qFaaZS9/uW8N1U8dx6dGdfKGRdySl0SumCxYR0cL75XUikIDnCk9eGZV2KZ7gX+VkqT2KW/wRvld/Fha/6T7COeIuH+mkA+GziLp91ziCWn3rYLwDzuOrMP4MQOqiMd/c5/i8v0/ULpSZROY6oWL2O/8mocVEcl+xWVqYnI/U7lPtP+Qikv3sOjkemqIvimSkrqODtYvvNq15ttkQ/m4nmrrExQKZA/SNeSd0+sV69n8ia+Smsiwsz0y5DtFPGbmjWUdY94lxt0Zb5+GlVTK12fT/h84=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(3023799007)(22082099003)(10067099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/fWM1L0mLSAU1D6dC3+dbmCRYxKphqBAymL21UdjudQaUr6neCkdsXVnNBU?=
 =?us-ascii?Q?pK4XNXRGxktxN71MfobexY6jToXmy2zbpcwYUQLXRXjuwdNG+lUHwuEg+m8b?=
 =?us-ascii?Q?yaye1pozrP6ReIRvSppZRz2Cv589xeO7oqV+HNZJ6rjplrG3Od5F6JQJ5jdg?=
 =?us-ascii?Q?OhdKsYLSY2aVCmIVY+2yg2RrXKl9N6Qbg/k4nLw4pXUnKVJJDXS3FcLYISEx?=
 =?us-ascii?Q?Z2YX+rt8Em7cqb1/sQCDX5fDzzCE/hPvFT1t9hwy5F1lNjZaH4Ij7BSrTq/h?=
 =?us-ascii?Q?zrkELP6YySe3bLX0WdywWB4Od1FBg3CD/44lkvBVSrpPdcdnuiJtI9BzsmBj?=
 =?us-ascii?Q?+AWWYCYFXJ6AqebaSj/oXHdWXX8edzf/EOVM/QGT6gGgozRM2WTslhzNX0Iu?=
 =?us-ascii?Q?EroA52pNFdr0eo/DxvxERhBy6wzbNwnBJIlouhLyOvXahyn8SXhhlQw62z/X?=
 =?us-ascii?Q?aeEss2T5Km931X0lBkxKpr/5hqkUT9kTZ9fjOJvtnJ2NKhNzvA5uhfJt4LYE?=
 =?us-ascii?Q?CkSJSYoMgXQIGzaPCnZ1TQacIvX/uj3xjmiAuhTCdW1VKa+92NZEh84h/M7A?=
 =?us-ascii?Q?oqHzsCBGFJLY4tMAhqZDDSJOlMUEJwZASQbjIQZgxVbsWcFPkM1KBpEkY0pv?=
 =?us-ascii?Q?lWKRAIaETDe0A5vjFuiPUmjiOHTPxYQ9gHdN4jte9JofxLBiXmzrEykgYEig?=
 =?us-ascii?Q?YnCL4ztMGys31jX05P1kQubfySbRbsG0QcG0kQcIVoWSMpQfJMGfwTKGA9wP?=
 =?us-ascii?Q?2Q2y72oZ2Frna9OHIvIJKFouWBvxPz+Tt5bBjC9sfpzE2ziS/BYj4KAFag2q?=
 =?us-ascii?Q?n4Uj8urnpEFjhx7tBXxFbXFN3OYGe/zDofb6xH+gNYiqNu78+Q1Y0Si6Zyy+?=
 =?us-ascii?Q?M1m1ccX/UDhdueJfJez33owXI/LGoXtAFKfluD35hZ7rDz/8gqG8tOvGfoRr?=
 =?us-ascii?Q?AqvWbW77BsO18f12WkUfXQnGzWY6TWaRzf32UiNTifcXoDzKej//C/dPs/ZI?=
 =?us-ascii?Q?PIBPoRc8UjRxBQtD+XYzxa3S6ObKMJcYO+5+cpMqitMEGwTXMD0szuVcNVCV?=
 =?us-ascii?Q?BtIsH3GKn1vczE4sbp5L1ZbigEGAA9ok6id1ZRI18HtWi4LGZ9IDqEw1bGB5?=
 =?us-ascii?Q?5F2bUCpmnojbMmVCoPLdmLwuBqkSFP1AyYsHJo4CA9yYFI5CnHtBnnWE8P8v?=
 =?us-ascii?Q?07SWqXftj5LCoLZwhLzFUd9tq1Yd3c9nmiwSj9CZXp63zfu4nhQN9Bzd57LX?=
 =?us-ascii?Q?sLoJYpzKieok8ps5HMwyBuFaV6/LRS7NI0vCYRfGNrI1/e/Tzl+KpSKUHRDQ?=
 =?us-ascii?Q?Rw3mOBsU7ZllBa3qH4X0wCJVRfXczJYx2idHeH3VbSYm5S1YRgAg7NQ5msHv?=
 =?us-ascii?Q?YKbv/TudLhpo8Rtf8UUy3Pphx9DW86koJsgBHM7d0LOUo8Z0Jr1DvUckp0yM?=
 =?us-ascii?Q?kNFxUIfqLaAJYbnOnIBhCMvcZzixGbNvrNhfUsNV2313KvzcOL5uBHRgTr5w?=
 =?us-ascii?Q?pWOANnT5W4doa0Igtcr6WKdPH2lQ4v23zSpj2uqoHz3yBiJlDGNSedLy/Fun?=
 =?us-ascii?Q?MixMjDYZ3ythVKnBjuWtEC3TZg+FQUW71jJHoQ5lFv242+Qf7otNNPxCBSAX?=
 =?us-ascii?Q?/5BUytHVUK+pUKo6rZUuVrxfRtMcGz2v104lgFZX0ZNfk8oaX0diROmD5MF6?=
 =?us-ascii?Q?USQ+dytv3zQ/tZUMLOBuMnQwTpdkRjl8jE1M2gwyC8Mg+i/JTpkIJjcOyOdW?=
 =?us-ascii?Q?tmrnuk9BkQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc919f-8716-475c-57cd-08df1326a2d6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:41:17.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNXRv7HAxgxreydb/olWi+LatSXEh/NYbRmvzbCezSzstR/6jDjgm6ACQdjKqcK8yuAGd4A2zFAsLsuSuI4e1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8829

Add btf_module_allowlist and btf_module_allowlist_cnt fields to
bpf_object_open_opts to limit which kernel module BTFs libbpf is
allowed to load.

When the option is not specified, the existing behavior remains
unchanged. An explicitly specified empty allowlist prevents libbpf from
consulting any kernel module BTFs.

The allowlist limits which kernel module BTFs libbpf will consult
wherever module BTF might be needed.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 tools/lib/bpf/libbpf.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h | 16 +++++++++-
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c036e8a91ed8..a77115e1b171 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -751,6 +751,8 @@ struct bpf_object {
 	bool btf_modules_loaded;
 	size_t btf_module_cnt;
 	size_t btf_module_cap;
+	char **btf_module_allowlist;
+	ssize_t btf_module_allowlist_cnt;
 
 	/* optional log settings passed to BPF_BTF_LOAD and BPF_PROG_LOAD commands */
 	char *log_buf;
@@ -5851,6 +5853,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	return 0;
 }
 
+static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)
+{
+	ssize_t i;
+
+	if (obj->btf_module_allowlist_cnt < 0)
+		return true;
+
+	for (i = 0; i < obj->btf_module_allowlist_cnt; i++) {
+		if (strcmp(obj->btf_module_allowlist[i], name) == 0)
+			return true;
+	}
+
+	return false;
+}
+
 static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
@@ -5873,6 +5890,9 @@ static int load_module_btfs(struct bpf_object *obj)
 	if (!kernel_supports(obj, FEAT_MODULE_BTF))
 		return 0;
 
+	if (obj->btf_module_allowlist_cnt == 0)
+		return 0;
+
 	while (true) {
 		err = bpf_btf_get_next_id(id, &id);
 		if (err && errno == ENOENT)
@@ -5915,6 +5935,11 @@ static int load_module_btfs(struct bpf_object *obj)
 			continue;
 		}
 
+		if (!is_btf_mod_allowed(obj, name)) {
+			close(fd);
+			continue;
+		}
+
 		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
 		err = libbpf_get_error(btf);
 		if (err) {
@@ -5939,6 +5964,9 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
+			break;
 	}
 
 	if (err) {
@@ -8481,6 +8509,8 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 					  const struct bpf_object_open_opts *opts)
 {
 	const char *kconfig, *btf_tmp_path, *token_path;
+	size_t mod_allow_cnt, i, j;
+	const char **mod_allow;
 	struct bpf_object *obj;
 	int err;
 	char *log_buf;
@@ -8525,6 +8555,22 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	if (token_path && strlen(token_path) >= PATH_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	mod_allow = OPTS_GET(opts, btf_module_allowlist, NULL);
+	mod_allow_cnt = OPTS_GET(opts, btf_module_allowlist_cnt, 0);
+
+	if (mod_allow_cnt > SSIZE_MAX || (!mod_allow && mod_allow_cnt > 0))
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < mod_allow_cnt; i++) {
+		if (!mod_allow[i] || !mod_allow[i][0])
+			return ERR_PTR(-EINVAL);
+
+		for (j = 0; j < i; j++) {
+			if (strcmp(mod_allow[i], mod_allow[j]) == 0)
+				return ERR_PTR(-EINVAL);
+		}
+	}
+
 	obj = bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
 	if (IS_ERR(obj))
 		return obj;
@@ -8563,6 +8609,24 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 		}
 	}
 
+	obj->btf_module_allowlist_cnt = mod_allow ? mod_allow_cnt : -1;
+	if (mod_allow_cnt > 0) {
+		obj->btf_module_allowlist =
+			calloc(mod_allow_cnt, sizeof(*obj->btf_module_allowlist));
+		if (!obj->btf_module_allowlist) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		for (i = 0; i < mod_allow_cnt; i++) {
+			obj->btf_module_allowlist[i] = strdup(mod_allow[i]);
+			if (!obj->btf_module_allowlist[i]) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
+	}
+
 	err = bpf_object__elf_init(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
@@ -9684,6 +9748,12 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	if (obj->btf_module_allowlist) {
+		for (i = 0; i < obj->btf_module_allowlist_cnt; i++)
+			zfree(&obj->btf_module_allowlist[i]);
+		zfree(&obj->btf_module_allowlist);
+	}
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..89768244d5d9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -224,10 +224,24 @@ struct bpf_object_open_opts {
 	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
 	 */
 	const char *bpf_token_path;
+	/*
+	 * Optional allowlist of kernel module names whose BTFs libbpf is
+	 * allowed to load. The allowlist limits which kernel module BTFs libbpf
+	 * will consult wherever module BTF might be needed.
+	 *
+	 * When the option is not specified, the existing behavior remains
+	 * unchanged. An explicitly specified empty list prevents libbpf from
+	 * consulting any kernel module BTFs.
+	 *
+	 * The list must contain valid, non-empty module names and must not
+	 * contain duplicate entries; otherwise -EINVAL is returned.
+	 */
+	const char **btf_module_allowlist;
+	size_t btf_module_allowlist_cnt;
 
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field bpf_token_path
+#define bpf_object_open_opts__last_field btf_module_allowlist_cnt
 
 /**
  * @brief **bpf_object__open()** creates a bpf_object by opening
-- 
2.34.1

