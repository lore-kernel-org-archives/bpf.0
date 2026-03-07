Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BD28852B;
	Sat,  7 Mar 2026 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772864625; cv=fail; b=ju/x3OOE4nlpbJm/UXHP7MFeXlnH/rSEdzNLX/jZWtene7xejXycHPi2HfrnEgcps4aKBB3Vlr7hJkE6vxr5XtG6Zimltyc7Ttkm36OHtAcmjQ3QGB8L3UoNlwABm8y4zbsJF3FN88WKMrU+e2ePUI/8isf6rdU1sNYdGaJ9ooE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772864625; c=relaxed/simple;
	bh=PNMqACoK0DH6ENOCf4kyq3DYPl07osLFbonhNLdT9+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXmFXUkGT0bElZR+Opgl5UFSM3TQnZncVHKWQwtubPED3gj8IXKy91R3nR7jRalB04BejIlQvCHHliIZ2jM2VbZIfP+ukTITAK0hhnku//Ko74eopV+5S+5rzr/lNNzZSK70sn72CE0mzKZwCNNdMscPc9yCe+UEaIgprZSQA88=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IZ31N0AS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IZ31N0AS; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IZ31N0AS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IZ31N0AS"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RiYAK0ZSodEkmRjZZD+TkkyePqPN27o/067CsqM7GBwTGVigfcP94yCP6CJK+el2dsx2SLmkmntaJNHtzYUlGTBtFcEzQHEH+UEyLP1CdZccdkc/hnTjfGRReQpuq4QeeES81xej1kEThV0d1OLVhYag7F08GdQSd25WBl/ctMmRuc54JrXK7tYpZ5eTA6YxRdSgSMfunpSArG4zsdV4yr9IaE5lNUpDcabpScyx4fqg2ALWPzSTcYhf3W1aN5HCHJTiSXUKpIAtilJE4LTszqLUDEuK5urzUhpXXz2MEhYOKlandRdC6PsxONxfd8yD/+B9RMDLF9NnMf4wxo73Vg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC70BYY6Yxy7N5Cx2w+jP4L9VbQabiToB3vv27re7+c=;
 b=hiKpzqj/AWsQ1zHa153ay3nGfYadMVdpw5CtrJlCj+g8gG6EjkKHjhbRNpyNKdUOZ4TtiqlySNLHNdnuuUtrg1bF3GlTTWjy69mK4IPMqU7Tgr3KyfkTxyav2VW58ds0HJ/Ohx0eReGkn7eqNDkZqxuNDBw5SovLMNVssFspyteSMfjl+V/CL0GMh0M18eZceeyEvNyVt/+gw9EHRmYqCLtGbbv78L4BYnPZr7A7bmGnLTvEfASeyTAF/1J4BZycxt3wmEpsA7Lm8+agTH3CYGliNve1HhMQYU83/6J13LXSxYA9ZeeHfvRSwg7CjisMQl99QhVCOaWgUyGn+hKcuw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC70BYY6Yxy7N5Cx2w+jP4L9VbQabiToB3vv27re7+c=;
 b=IZ31N0ASNYw+kj/L8eWddbJZ+AtmUeyErX5wM6OXvQIWu8GudAZtSODrYgIwwtZfNsH1wFIul8cxX04h29Mc6VzEdiMlB95/oHuYtbXklZ98uiFvR5NjKffkC/RxTA2z514riFIseZgT2dhdop0LGP1rsTg1ibrdxFgi9Rt6t1A=
Received: from DB9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::9) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Sat, 7 Mar
 2026 06:23:37 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::1a) by DB9PR01CA0004.outlook.office365.com
 (2603:10a6:10:1d8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Sat,
 7 Mar 2026 06:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Sat, 7 Mar 2026 06:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ntgg5TOz/xxiT+JXWcFBzLyec5dFSZM9wQp9/LWafX3HN5xwCvdZR684HqIXKkSK4oo/QU9LJQxZvsu6sv/WtJjjxsd0Kz6uGrB9pailTHsGNPjag7Ng9w9t36gsRhgYVOkTsLhHHWRusp79wQNN7mD4Sg0EIfNy+ZQK+I5HZ+vzo3vIMB9355m+3AHNXF4kGgW/HxZH+3bjXFHzGVaApyxePzHo+9U2Nm67puN7rlyGu/wPO9KSeqBKMtm9lKGMadvYCcdCt26WRWwUJYSzfAJlrxb6OHIqP3U8h1OaLachImvVOsMBki/a3CnXoDtqImGbi9P5ZWhPzAUE8tznvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC70BYY6Yxy7N5Cx2w+jP4L9VbQabiToB3vv27re7+c=;
 b=kJSaVnkz19a6V6yvnNm10TRGzcLxA5G+3IMlDy3LweBjwo50L9XKsOPXcMfx1JBMeZ28ZKIUUuW5v29EwYbJ9ZSBjsSv8bkqXp82IKI1pwrxnXJQV8YZ1uqW2lx1NrlfgWIP2kCISIwgxa0IZNgKxqm5vkh1oi38eEmIA8ebEf8FPDW+tRjw3eWI9IToPQC5tHZJG2kI8ezUOJ0Ve1Lnzp2rhPUZGXfm7ueFrH1FRkrHg1J9aCc8v0P4bTh4EV9RStm/dtMY507qAWBXi78TQDsnJ+IYfEUuQq5VQMuHGmFRGbQyMzH/VMIH+w8PJs928yULayoFNmi1yaLKHvv2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC70BYY6Yxy7N5Cx2w+jP4L9VbQabiToB3vv27re7+c=;
 b=IZ31N0ASNYw+kj/L8eWddbJZ+AtmUeyErX5wM6OXvQIWu8GudAZtSODrYgIwwtZfNsH1wFIul8cxX04h29Mc6VzEdiMlB95/oHuYtbXklZ98uiFvR5NjKffkC/RxTA2z514riFIseZgT2dhdop0LGP1rsTg1ibrdxFgi9Rt6t1A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA4PR08MB7411.eurprd08.prod.outlook.com
 (2603:10a6:102:2a3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Sat, 7 Mar
 2026 06:22:33 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9654.022; Sat, 7 Mar 2026
 06:22:32 +0000
Date: Sat, 7 Mar 2026 06:22:29 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
	xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
	richardcochran@gmail.com, a.s.protopopov@gmail.com,
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/3] bpf: introduce bpf_jit_insn_aux_data
Message-ID: <aavEJTfOrnTtYTMh@e129823.arm.com>
References: <20260306221330.630971-3-yeoreum.yun@arm.com>
 <f4c177fb8f90a85b0b47de382630947ca8ac2d04febc56c7b8698041050355d3@mail.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c177fb8f90a85b0b47de382630947ca8ac2d04febc56c7b8698041050355d3@mail.kernel.org>
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PA4PR08MB7411:EE_|DU2PEPF00028D0C:EE_|DB4PR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee9d636-0311-4f0e-561a-08de7c12115b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 VWdagLe0/il2i2FCuXqCi3bLbuPeg0skJ0zCzLFgmfoGpFbVxq2hA/JARUBh2YJuLXLQSQrvYChXht9wSvGaBY5nOQaUTTX73ZCpAVU8Tyls8BfDSd1XEOhqZ33cU8qPjiRMYqg9Ghxmy7Rzf5WMLWsWVx46TPG2yrZBbebparQHTKUVBLGzyIkrw3Z1z/0uwfRGj/bFx1fG7u33IHIKDZFmiXACo2zVtlCv23fXtersmkwnEYSAIaM8/uOHIxoZ9MaSo/tZnQ5/mkWnLmLcrFW9c+U6FpHRdXdIv5dmtSnmn7nAwA+3fxeeygDhVl5Qau2g2z6D6j/0bIsfobOJ4zWsbw5zjYVjsYuCxRbPW7GhUqqwbx8XW8zjuq2kpS5CkJzL4ZHwIrN8XuJFDpUnxHL3zifTKldzCr9p7y5mwMqdRUh3jBGdkqS7ixFeDOePTit1Ft+5PkJmRMzDMvwdsRskCeoOORjcRUnvzTrjohUs/MW3Ls8RA2XN2IJlcFAApxiS0IOylKBxv999lCQm6DUbwlqUJFv8kwjr5+57XHdorxfUfSPQZArfhAUu54lRPMmrA87QUpbLqocKLVe31PADTlOOkfcBMSRhegJWMfO/rA7xX0PHoA2R1UPIXOFBPu5KBnFn5DgiHGGCDdDIOK6DDJeSTm0T/Fz/EdyNiunEVsc8SfH0aHyj3+kwSP0xcqk5MUea2nMWiHXyy4gosh/aRuGbqA9PnNgDlk6wvtA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 GYvnFG1N+Cn7BW1LQjUY5pXSvQQZZqkpw+fx8yLX5C32HeIUfqAdgNI6tnz/I8HsHHMrrYzy/HF4OTNDlHTBDRyRYT55t5g0HSpq8Sb2jbZTtQ1KXMInapx+Mvcw/L63ylpEr+sfOPx8tUOT2iOcV41m+K1YAgLOZ6WuaLCtbfCSKRM41SPB31T9yfsdgAZ4hLR+7Fbuw/LabR5bhm5sF4szTJRqiRi3kFcHB2Fx6+gGZxRbMNtHUzxL655gQWIdzTIkRIc4VaxR9ecrQEuVvDnQvItooVXh9m6SJDodLeG8bgXohQ4nBQR/gr31I8uk8T3viLuGmPMFviTQArJdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7411
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cffd21eb-6331-4857-9b01-08de7c11ea81
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|7416014|1800799024|14060799003|36860700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	FN70JjlDcLZMEX8NiQ14bm8hV6M3TdTj5xLf9egGv48yLDICyeQEYIlV2QRjePOFMKpdOcR5QzYhgOj8ZK3Vj6HdAAyvoC8p9CjZIZ3Itxz3eoW9WCIiA+E45kcqDwUjFxK3/7feaDjzPseb+X7RZ0Onar0FRtnCexRe9DoWumI/krZpt52jkKb2zXFpPyBPqZeUzjW8uxhtKU2ByL8pX0fMys20/b+nGzGLFn30iQ5CQ2ELLrG4bR73hGqV28NLIhVqGRP9yRQJFqh1jS1GrrcYBcWVj3zH5FdZcVvo5+1djkzuwjngew0osZMuU3qFfnD+eTBZwYdNGGEbyw7sW0wv6axX1M6lqg9sm/Ax28LaYlBjDuilTHwj9ZvEqD4DLcKhxPtH/H1joJgkBj7DWo0MhV3GWZtLqJTS/NTIn9YIiVHiYt7FkWotanAaZeerzLrB7teK2H2wco424pzklX8BKXBL0YxrOdxB2eCZlipXxhixVi6QyjxCccNpzQthHgeziwLIeSZX0LRvl+ZyOh/Qyd52G2RquEPaoP1oDZHosquFF5/bkd8tB5H7l0+ATy4vwbuRYTyZGWLf1+XpFePo9XsQ64iV+biE//Z7qrwmN8TZsU4WqokaFWQ8eLKo2bTjH/ZQwLdvfuPK2TmWlQcXVU25/D+IH9kqoDdT+r3m4/fILyP7IJk5npFXUYMJ99RIdO2wQ5/PswyZsm2gVocPkYhwMj1Qzmft02s3HShOLdlR/mKRRz34rZJBmkYDRoJ4+5SKrN876B8u/1/2cA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(7416014)(1800799024)(14060799003)(36860700016)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FNSS9McDdtNSux+l2+uHAvqJEi4E4YQJiU3K0VZxhTDffcvJ360SqTcjai0SqpC6VglSYtGzt0lbw2b/flnJHqcWWbf191RUBkrPM+gJD6bPMcVo3qWLMHMTJNVT033UJ6sFLHEQlc0oe0QhAltfeCfx5g6eiExf9N7TaoiJdSbg9T5QMttZfUMzBiUGhCq/apxgdOAR/M317aJ0sdrfcF2VaUI+L6If78Ok9URTP4oh+Qt8DxmCGi3/iQNjL8YdpN/yZCNfJS8nz/t2FP2UgnjY/UD5yaNBoKfJ1pqStWIjGsrXGYk3UQ+6ivGNx4ul8GlHbvfOtpTdj1ii/rwjLJINWd+wdJhhw93Bmbsfn3ofJLKGjsd05cYBdLRgatRtYkKxlFiMGXYbUBd56FWyIA16WFx5hXs+PzQSAOVG8+ZRDfA8vH0+ehtQw2pQ1VSb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 06:23:37.4626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee9d636-0311-4f0e-561a-08de7c12115b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261

> > @@ -23020,6 +23026,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >  	for (i = 0; i < env->subprog_cnt; i++) {
> >  		func[i]->aux->used_maps = NULL;
> >  		func[i]->aux->used_map_cnt = 0;
> > +		func[i]->aux->insn_aux_data = NULL;
> > +		kvfree(func[i]->aux->insn_aux_data);
> > +		func[i]->aux->insn_aux_data = NULL;
> >  	}

Oops. This's my mistake. If i need to send next-version, I'll fix it.
Thanks.


[...]


--
Sincerely,
Yeoreum Yun
