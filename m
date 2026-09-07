Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013053.outbound.protection.outlook.com [52.101.127.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFC3839A9
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759546; cv=fail; b=hSlYBcMKGww+YFSbk66X5HvUBQ11OoK1BMEiwDCRUcIeMehv8uWagmmNXM0eAO77fxg3dov/wmj8D3ZS3asJx1xCyEKy9YmS3jvb4P/MauB7xre1ILgHPcwS9ilsD7sJp9STgtaK/yOkcGinIWmuZHwBRop6WLmTHgDUySTijws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759546; c=relaxed/simple;
	bh=H5hRxTsfw2vbzbfm2zrBCSymbaNjYsZv+vLN3iD3FRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNO1cNKnwfinccmrj6C7WaDHxAX1uXpISaumuJa+oiAad0rER2JzxwwvN3eMbDJ0o+WqkWYnQI43YMP7xcaxOAzE056ikI2ymrBAz0xJYsGRtnhncM5LyDIITP6Dmrg7YpbBtJaMNiyZOsOjE45Pw0uge9k8bLBC3pyT/8tSTuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FkcFVuhp; arc=fail smtp.client-ip=52.101.127.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FkcFVuhp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSakFERtXMxIZb16llhVgaRwW1b1HFkY16enZevjluLMCUHd7I7esqw5EqTS8Ba5zvY/UhExMQmfsHItfxUwWCVY3iJ1bTacCXG0x5QKFNwapRIVtOAvKHqzLui/BOF69fw0LUtUfg85T14Mp4RgYZBCR9d4/81+4qSAFWSYzHpSsblJ30jO5oOJ2WvDAf4AuNZeOx+nVVFPj/Js5sCb3d2bz5cAHZabGG912H8BzI+IO8pL/uIbwp97/Jcj+7jpB0YWq6wB2y6Jzq0vvB4cV9oExYmQP5jge6WZ6MsBitkmKYr7YCi/EfQ4uuX4PJDw+V5DFxYKNsgQW7I3HC7+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHgsuVDmjVC3LuL1UedIq+gQNyd5XedpN2OQP0On/aM=;
 b=a2l06AtMHwaNu3P8mi8XSkL6nh4d4t5TKQlE6BzLkyD7QTpv9luHjdEBE1wCodmXpmX4ikJfz+DbdpUgBsPoN1KatHY3k7+hLY4VPQtlFkF3DI5ao9wcM0DpgmYgRgwqpsXNOC8hmQFGzAGLrJrtZVrccQx4VkG8L/NMvUDIw4WxcxTTebre64+R2jmHoIBhAhBZ8cQ+goQlR840eX36feTcIisYqnaOMvw5iDvsGCkv01PyrPYZ7PSe95SVNVE1n942eiw/2xuwSUrVGD6dQjyFNI4ihs9/S1AEJb61TOptcXUUmIVRFr1eR3NLU/W6EhE/aBY0yQJ9tItSoGYkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHgsuVDmjVC3LuL1UedIq+gQNyd5XedpN2OQP0On/aM=;
 b=FkcFVuhpP6dVpJxUf96VJL6I9uQiRCgU/JkxYT9wXMDBLwfQeJghmwpbWZq71Mw25KMFTSGjMIJoFOiid4hKv9Mkdtw5ya/CTFaWqGZBR/jdvyrnv/5oGTIb9thjFksdB8FolYLcI4RtwHHe/4k5g+gTuB9fbK7+m2+CQfok05DtG/gNjJZdXPDfLIDfObI5Cv48ls9Od/NRH63UBbao9nRsgyIOtaThQumXwiDA8lPYt7m4ZL2pTLZVmRo0410rlCiEjTyBU8x9BxS87iIO8W2gWk8K+2artYgezT4dNxGYBLCxnYww834EWm+LIak1ZXAgE+xC8XxzlRvBtglu6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYZPR06MB6913.apcprd06.prod.outlook.com (2603:1096:405:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 05:38:59 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 05:38:59 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	Fuyu Zhao <zhaofuyu@vivo.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v7 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
Date: Mon,  7 Sep 2026 13:38:46 +0800
Message-Id: <20260907053847.1115-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260907053847.1115-1-zhaofuyu@vivo.com>
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59c8678b-83c8-4352-9c56-08df0ca25120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	RC/X0rfDIT+1Qh4v2CN+2+a3B8TGNhLozqAwj+a3g2MtwcxYf9OkCFvyn6UzD4V5QU6gHj51pTLLqkbcJ7yJhoF9h9EZYugqcowrVUMy1zyGHuFjGCyAplGdds8OwAuV3+xxvSRfKI6FOeYXMaYez/tKxdPNWNaZrutwczM5E86aexNYC2rIa8H6WxURLLI1TV7oMRrxsID+St1iFKTy7NF4flp5SlnDP0guTfdh0HWhUBXMeEDSv2Dpdf7Ss4backp9cDrn0ZinFXC/Qglx7Lh8ZVzIwNpJwyyxSyje0OX36JjwJkmNSMv4t2axTx9f9sqBySZ6FiQRrHnjXvYJLV+JX0Zm6J3k77r+ygk9AArQzl/KHbEdaknPuLFKv/pCuU3j0NxKEpaos3OaTI/bhuvws6EZ8Xq1uhJbmeCOfjpDcGDt5hP1WjY1yUDrV2vUSlzljlPOe0l1ejn2fLcTGqodZLXYztmUSxQ2yPElNKnGFH5u+4xghRoQxxARBHiO3FpdCydTx8mU8W1bw84r8h1qSzrRFzFJ88Lte6xYvTmBcYv9FVnr8KcLLVaM61U2O5pEE4MejbhCtnjUfUA+u6wMkpNWGiKKCsAvUaCavcMwIYClCAaht0bEJIi3vremLYY5zVYKcouodFq/YP2PGfHwy80BPpHniMOhBAAT77nFxGCqbcZZhdfV0OPlac+IZc4laTI0AzDeyiC02b6xlFW6+c0LqSAVYyLuJtasdTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mr3sRNlk/6F/f0AMHgQRBeujhV3i4/1BkXqhU1hFRfrs27r4jllynaGt/CSE?=
 =?us-ascii?Q?dlIuRX9u2J2ZzlXqFWKs9Z7uSaOLjFT1OKEPl/DrHju/LOF5kadvy7S1lvkD?=
 =?us-ascii?Q?pZ4U3NhtQdl7fRGnCYdZwdI9tvWH92jCJb3t5AKXd+7MWNLlqqlba6zZf6g9?=
 =?us-ascii?Q?ls0RhRZIG4IwqTRb7/uc+rmYV9BmsBwWfz3kY+TL7m00Ob0jh8m/I3TJcVLG?=
 =?us-ascii?Q?d1HXu0ONKb4gx5k8jfMImJNmHrNbh0LgXtzGIj4KvQyzGj/fraxi8TgeuB8H?=
 =?us-ascii?Q?9aIgC7Q0/qqdUqQ5BWCdkA301kZCs4sadDmRTPlOCOrovXhyRNzz6xeIpbrk?=
 =?us-ascii?Q?QphK5OTF/SVBYytHbuNYK/N+01wNpTYlFJBz5ykIba4uC5zoq8+qFPwmdBgm?=
 =?us-ascii?Q?iifiJvocvTnd2iNKxR98T7SbZ49HYBSkmtmEALaHW9pdEVwtQZ08O8IHW00b?=
 =?us-ascii?Q?kTVzolr5tKW35GAQR8NtnBqcbWTRD8fbd9ejeYN5HKrdjocoTvHUEyraPY/9?=
 =?us-ascii?Q?uq/vnS2MuOamsp3yHZnVMzMI7qWLed+qXR39jndmDJILycyWIcgVVsXLm/kn?=
 =?us-ascii?Q?ZZDbx2NK8y8+9OATT3nqxtiaJ29EC+8RYsiKuxVMti4502bmSC8rrMuiVnqJ?=
 =?us-ascii?Q?W4mkQslK3ZVliBFEks4EdMkPrsz8xjT2ZyDOUyyX2j8cWzleSzWTLUjBH9PU?=
 =?us-ascii?Q?sOLIksJeSOIm0Eu6kJrsmN2WBx/kUyoA7Vo4rlc64CcCqVL35/68B0jm0d00?=
 =?us-ascii?Q?e2qBQnE9BQB0tDDboubY50rAaI7t329Y5ScatjYWy6PAb1vE+FH/XzTBHj8m?=
 =?us-ascii?Q?JdvTttKquGf6l5Fl04wytcdHtWR3MFI176hJM6zadJ7I9AknaU86023QQagT?=
 =?us-ascii?Q?zR0CgmA6EqnZdT4nVs1ne+EM+7R/hAkRQbKX05UyOx0LaJFKfRPS4xFjS1d2?=
 =?us-ascii?Q?h4XfKmnRcY9dOqB1eqZLrGmcN2jU4ut4zG5MKZw+hyopRmkcXpgAxCNc6qTE?=
 =?us-ascii?Q?qYtPZPrrt9dKvjS2bUg0ixnb7XrT9avEzOxlLgyJvbxFXfmZlTm0IOo0PZeK?=
 =?us-ascii?Q?5m82eFr47lTZimFHGYjEv6N1PAelLpEU8OyemIfRvi8iy9J/sagPSY+9+u/g?=
 =?us-ascii?Q?RXYPyEzjXeh2ucdXsNS0I6rTls7dUD78iym6VoMSHIlVxoyFxrl0/WzUP/th?=
 =?us-ascii?Q?MyKoTzkGXxO1scZl7GLutjm9XB6+tFU+i26Lz6zY+SMZa+SHiGMLcpwJ5U1a?=
 =?us-ascii?Q?fxI/aELGqkmHB1VyEGVunJs1kWINARnkr/cRCDVXDJANVK5/Da8BMIQ6sNpE?=
 =?us-ascii?Q?OSgzx2ImaJpK7Y7rrT0C7N7e5fYhnSYmnUgP/ZYIPkY2NK3a9Dao8iRoqNDq?=
 =?us-ascii?Q?o+PEjdHRfIDEONE585+8Z1nX5aDoimXc7ZxayXi1HMkeHVeDgPho9qB08/L6?=
 =?us-ascii?Q?ccejXjxYT0oIAYqQh4Gh80jBTukvqqzHrNKQSo2xC8Im2Z6aclgM8koz6NGt?=
 =?us-ascii?Q?wFW7i7weON9VuZthlV5GcbM+OvHS4+PVlWEYh2vtoaA8F6Edmxsb3uBx2zci?=
 =?us-ascii?Q?i3Q1ZVjf0Hxc9/uHaut4/f7VtfSO9q0Tc8DA25fLtRhG0dvqIvWpBxgUAMll?=
 =?us-ascii?Q?mpMgY++usyovVE0Ar2Q244Rbm5C4xfdlUos7q3MF+rVgLklqr5eR+wwTsnej?=
 =?us-ascii?Q?xLeI5kRYvEyJ1rMoK/Q5NDpI/pvj7u7c7wa0vVRNt/b1uiocOOXgizlBLVuS?=
 =?us-ascii?Q?OQJn+NQveQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c8678b-83c8-4352-9c56-08df0ca25120
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 05:38:59.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQ5MP6VOxeDvrv0HlaHaEJz3Y6hBv69UN19Je7kThr3URXNQM478sgm3KeTqKvttYTv9VMtkyc/UOmwl8Bdbcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6913

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
 tools/lib/bpf/libbpf.c | 72 +++++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h | 16 +++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514e4e9daa82..581a4d8ee124 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -748,6 +748,8 @@ struct bpf_object {
 	bool btf_modules_loaded;
 	size_t btf_module_cnt;
 	size_t btf_module_cap;
+	char **btf_module_allowlist;
+	int btf_module_allowlist_cnt;
 
 	/* optional log settings passed to BPF_BTF_LOAD and BPF_PROG_LOAD commands */
 	char *log_buf;
@@ -5803,6 +5805,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	return 0;
 }
 
+static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)
+{
+	int i;
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
@@ -5825,6 +5842,9 @@ static int load_module_btfs(struct bpf_object *obj)
 	if (!kernel_supports(obj, FEAT_MODULE_BTF))
 		return 0;
 
+	if (obj->btf_module_allowlist_cnt == 0)
+		return 0;
+
 	while (true) {
 		err = bpf_btf_get_next_id(id, &id);
 		if (err && errno == ENOENT)
@@ -5867,6 +5887,11 @@ static int load_module_btfs(struct bpf_object *obj)
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
@@ -5891,6 +5916,10 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (obj->btf_module_allowlist &&
+		    obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
+			break;
 	}
 
 	if (err) {
@@ -8426,8 +8455,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 					  const struct bpf_object_open_opts *opts)
 {
 	const char *kconfig, *btf_tmp_path, *token_path;
+	const char **mod_allow;
+	int mod_allow_cnt;
 	struct bpf_object *obj;
-	int err;
+	int err, i, j;
 	char *log_buf;
 	size_t log_size;
 	__u32 log_level;
@@ -8470,6 +8501,22 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	if (token_path && strlen(token_path) >= PATH_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	mod_allow = OPTS_GET(opts, btf_module_allowlist, NULL);
+	mod_allow_cnt = OPTS_GET(opts, btf_module_allowlist_cnt, 0);
+
+	if ((!mod_allow && mod_allow_cnt > 0) || mod_allow_cnt < 0)
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
@@ -8508,6 +8555,24 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 		}
 	}
 
+	obj->btf_module_allowlist_cnt = mod_allow ? mod_allow_cnt : -1;
+	if (obj->btf_module_allowlist_cnt > 0) {
+		obj->btf_module_allowlist = calloc(obj->btf_module_allowlist_cnt,
+						   sizeof(*obj->btf_module_allowlist));
+		if (!obj->btf_module_allowlist) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		for (i = 0; i < obj->btf_module_allowlist_cnt; i++) {
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
@@ -9571,6 +9636,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 void bpf_object__close(struct bpf_object *obj)
 {
 	size_t i;
+	int j;
 
 	if (IS_ERR_OR_NULL(obj))
 		return;
@@ -9629,6 +9695,10 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	for (j = 0; j < obj->btf_module_allowlist_cnt; j++)
+		zfree(&obj->btf_module_allowlist[j]);
+	zfree(&obj->btf_module_allowlist);
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..b1602c769f3d 100644
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
+	int btf_module_allowlist_cnt;
 
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field bpf_token_path
+#define bpf_object_open_opts__last_field btf_module_allowlist_cnt
 
 /**
  * @brief **bpf_object__open()** creates a bpf_object by opening
-- 
2.34.1

