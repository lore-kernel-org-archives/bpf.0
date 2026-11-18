Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795035135;
	b=VIo61CXKMhSwT0FsuLM84kLxe8fLmZLXca+z3L/MCA0++HhasvJkvMbmHKOrRY+yPNIG
	 kHgs7lRdAe4w1utQOM9r6oTlLpPoieZeLUkn/aDrJxu+AniuuQ6usUWiCP24BqIBumWNI
	 jAkq/DKCWVTpsGpOcTazUrmcAJrYPVv4h1KXrGLjZjmdAKHc40E9P60S3d+vtBXfDs2QY
	 jBKg1aGEy9Y+EzDkdOyFUpKNpYoNW7KAEBfS5jJQ7AJefXzDKVziUtCWjtUcaSJLOZ9P1
	 Gbqh6/oN43mutDjl96jMIGBB3kbudy7tdQCV342eH9/O0djVRB22Srx3PoLkE6Y8vgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035135;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jZehBwZCzA+8gvG6P9iLvbk3EEaZXrmbgIL69qwYRF0=;
	b=XOGeY+TlRmDO/rRGAQIYjvVojDSBYeRiFSMSuL4OAGYuproh9fGMSH3ZIKrp1ATUg6vZ
	 hLyUXiGNjh55kZ/Z1gBlyH3SBm77CsImKKFfM1vxEg7sHPH+2JRwhSEd072WJBFbqPH5G
	 92aRQdT6kIf+vAeDQhvB9Jqjwa2JHGj37Qoi58sUlyMrAhBpzVDso/QCHKE0oiBkAWGII
	 5MDWEOOKmDB1fNT/fn1SKp3Fji1ia5RuvszCZjTdNjzJSltBp421/pUs18LPzpJx+GkCu
	 dEXtFvZM8x7ePBYzWbuyoXFlPYW5XnTxHtJB59MMZk2Ygkmt73IwuIvhM1Ujv8wAqCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KDWyVeoS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.15
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E451606A32C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 20:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E451606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KDWyVeoS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9zV/wc6GeSolSlUwVpOEFVvr1SQdbmeTXIxZ+9aI7eumYxSyNl0p5flClwRG0m0u3OIXn+fmIzLzL8vMkEZfDHJdpC2PWuMiTy7yiGmrUrH0nXsUEG9mtAFYPsjmUqQ3KYRIOe42tFEcpqKMJ45dTO1hn4lzuNgLzT8TDGt9WHxAjK54wDHn5OS6BjlBdUaVhej8Z4GfSysEML08nEA4c9WazrckG24Yh4HmSu/3/GQZizNokypXXW8O3R4aRrCzVpGner5jku/6uvt72NQwsRb9UYuXULA6WqX4AHfMJyOJGZmjDI4DibnuXLrBIanwssv7HEZzkEE0cXmnus16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZehBwZCzA+8gvG6P9iLvbk3EEaZXrmbgIL69qwYRF0=;
 b=WRTwIRRAr+kvZde4npgHb8c64n+4OlTX8tD3ud6AlzULvnH6WdlFLjnsRvx93qqx3BT0dZxh0esEtiJCdRoXuEiXRaJjT0T8DWlPlkcyRvgZrbyDlfZMg7POYuSK5s0fFUc++GAsEehWcjXU55zsPX33HMDF7YoiVdD/ye9ir71Stzst0cOtKcZ/5rGSpNwTxJPxDol3iqvGQ/BueoPWbHMBbDURjlSauXFX1TWnxLLfPdOE7d2ThH2BjRCTq7OxNnR91xfWeJzb96Vw68jBDRVf4006i6wB9YhQ3Z35pbLVC8jqfCuwUvua7TB3zgguVvmW2UrkgiqIg4RNu8BOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=163.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZehBwZCzA+8gvG6P9iLvbk3EEaZXrmbgIL69qwYRF0=;
 b=KDWyVeoSoHhhCZqS6tmknorNN/BfMxwbIVl+0WvuOZ3ntf0WJBMqtL6DpiUMTW0//TKft1rPMIxvG8eQ9ztoGvk5bcYoD7L5I56bJ10UamvO8fkeyp4NC0aXCkqzQMSK+a7qxUaQKdJ3dmZPuBuuOYXAM4V8Ia3yDwYTt+OB2sk4djlZIUVqhcmWaEch/0duXWFuUxTVKY0mPamwEkzrPImXVZxA3C66qCMcFZAHi5BMrdljBy1Cl28CVH20DL3fFJ41uiWL55ErqAtxzzgqTlo/B+WRIrRt48iu6Z66CK5s6TDv0/6ljZFcc8iugc40eI/R7xkBIJulMYKu4SIruw==
Received: from MW4PR04CA0338.namprd04.prod.outlook.com (2603:10b6:303:8a::13)
 by AT6PR12MB025998.namprd12.prod.outlook.com (2603:10b6:170:116::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:52:11 +0000
Received: from MWH0EPF000DD30F.namprd05.prod.outlook.com (2603:10b6:303:8a::4)
 by MW4PR04CA0338.outlook.office365.com (2603:10b6:303:8a::13) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13
 via Frontend Transport; Wed, 18 Nov 2026 20:52:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000DD30F.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 20:52:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:51:48 -0800
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 18 Nov 2026 12:51:47 -0800
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Yuan Chen <chenyuan_fl@163.com>
CC: Nirmoy Das <nirmoyd@nvidia.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v6 0/2] bpf: Fix kfunc implicit arg injection and add selftest
Date: Wed, 18 Nov 2026 12:51:28 -0800
Message-ID: <20261118205130.3014100-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609125214.3096351-1-chenyuan_fl@163.com>
References: <20260608142618.3064380-1-chenyuan_fl@163.com> <20260609125214.3096351-1-chenyuan_fl@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30F:EE_|AT6PR12MB025998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3ccccd-d98c-4adb-9a19-08df45b5d13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	a6Di7gHbRdxZoRGt/yAsra95KPAL+0x4FnhWRziG9f175JzaOTcfj+aWF4+4gCxBgLSiq3HEBz4JU/60uAW14SpJtcLSXOT384WR3pENMOgGWlsfIcSNbSHzJmpcxENeVt2UCDLReGTZLPu6yPrL61So5kCNpScHN0SVxZ1lwLjQ7p19xsFJud8z5vwU5MsdZ/4MDGHT6YuEYt89t6U9bp9y80Tz6l+XuhLF0QeaNeNWWYiApSEhAZ+llXgWgCXOIAsB36KF4aa8FYppm0tnSgRmrJhwEWORzfjg9ZC+WKAEjxvliqOVXUCpSGBx+P7Je6ju+GVCKRZ6Vdz+n8Kg/cQVDeFsX9BnXWse0TubmZk7IviA0ryBV8xGACsiH6+64UmLmIrzjwYHINWZz5X/alIAKAFg/SYEXIkfp8/JV3ufGttqdwe9TJsuSTJhsvtOnuFPNdoHQQYgxNIxK0/46XjkmhglkvWP2ENk91fJyohpL4t37L4s3Y32so2swimKUnz7PfgFVH8IkXNcpWn1uUGWzCtRST6+U/46JXWpa0EUWa13lCEM03mn+BqcBhQkNmn7WC0bfLwnj0tCizReQT49akYZyuIda3nc2JlYlBcLOBoFDUfcJ5pP0dk4hVPzcjzlStl52Cf8sIIz4he+wFFaUmGLR2VYpm5ShWYeumM+F5P416LGveoOJs3y+k77eKH4c1g31PNgqspKhCXidg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TxgGBADYQQtMF4Ol/QRUcCpdy+Wyf8kaYaNbLNKkpCX8K19Qm14Ovp4GaWumCz0h89zcG2jzSSFlYSlYJ60XmBLDyxKv6efKYDBMdSHD++URMgocqtb2tgqzDN9fuJv/hzeWHkZONMUgj/fu+l7vxxjoXaIZbJn5gSB26SBa46jyjfjlCcnyUPCBAz6/K7+3QEGQL/hkZbukxvc0Kby8+krfYtKJu/T0SU9rdDIdgc/IH56wSPkEXaXAI/DNjvY16Uek2P8V5uLRDJgLATeThKIMksVNlnrPjXFNcHSPU10dWM33LQ4FI2XLS3/ALbZVlLxJ/NtGt9QlAMAFkfXaNwsaVwbKCyIVcSuwOGh103ymlCGXfpyHM7Y30V47ageB3b863NZnqPfCqavQdcL0rt7tFi0gSq2Ytve8gFbjw//4lVSy6vMNcUoCmSikap9A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:52:11.0834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3ccccd-d98c-4adb-9a19-08df45b5d13f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000DD30F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB025998

Hi Yuan,

I tested v6 on a 7.3 kernel with a module BTF mismatch. The unpatched
kernel oopsed, and v6 rejected the program at load time.

Are you planning to post a v7 of this series? We'd like to get this
fixed upstream, and I'd be happy to test the next revision.

Thanks,
Nirmoy
