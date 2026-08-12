Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BD339388;
	Wed, 12 Aug 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563042; cv=fail; b=c+pp34wQAexV4FApmIqDeiTeR9SiSDwQzfilCW6EHCm+OAbIF1eD3HK7QX3J7zqFUxDQ3ZQCW5K8fpkvKHvLNvlgSkn6fIfyRMojxJgD8xllh+OUedSUg2Pi4KUCqZCoFBMGWF6snxD/KLBZJTDYqGxfYbh3uUyww4o9OkGCtJ4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563042; c=relaxed/simple;
	bh=FTSrFSAMG67Zokag51h2/HwGiUUZWHktNWEsFV025no=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m1kEK1tMV1lIMGn6FagNhU9FcMbLpYAU0DwuHbEbu+4+MILkFXrv7QxQtEph6kbU3WtSVk752f461aYuDmBGeRL4pGkXcnY2jMXVyltdSytASVf+/8y/fl7iTlkoTz2cs4Np6mb3h9QNSkzd6Sw87BtGgohyGztdCoxcDr705yg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M7aGLOsW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M7aGLOsW; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M7aGLOsW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M7aGLOsW"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GQAm73bB/iY+2UNNBI5r+1asn8zRa2FzOd9zoUqMLs7fnwwjOS38LbKZok9Gh7+f9QXXHBQAs3Pdlm6KPRNnn2OEbJwddKgS++/kA6YuJUs+igrsviJQBGSTu5IUsqh0EQ49alvR1OVPjeYkDQq1h2uSDwpAt54JZZtDhlcReh1ku786KPD8jwdwR8aGJi3A5fv+ucxWnhv0zFAjH9HqY6RrzGvMbFVa3cUPbKJhKCPC1XEdB+RhRh9MfSq2ApgX7Tn4Dv+TU6L399/nuWQPzUBp9XJfXkyJfMKgQ8nkLF36y83uiF6GnkJsTnx4oUB+YLi+MWCgzQzs4WW8ODUG0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBeP66ozKSvmorSl0FZyztO29Pozt39bOLmckur6lI4=;
 b=Rs014/esHd/vd29jLMrB1O3sQ5Qvn24NUmr54g+4U19Or6jH0ntYy99Psy8j5z76DzpFlRWBzCHd3E2i/vB8aR1DYs4YBxOsZiXRywmj2zm72R9W12xvdaC5SAeDFdSykncwqJhCY31fCm/vXKE5C2ExgvKGWCF3O3dX0pIBzUPpRno+zdc/OP9V+UNJ00d0AlG8mEXpR/C1D1lBsrwSaT76syywQFV+v92mygiCo47XHIrEdF7W4VC6OYUCJMbQsQiaVIPUfSWHAaGISZRV6p8A/u5YBGnOdIt6LT9MAvyf1K9EEICgpt2MnS8Ekbw7B1yZoRP4J+p3BObcqeGdZw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBeP66ozKSvmorSl0FZyztO29Pozt39bOLmckur6lI4=;
 b=M7aGLOsW+Z45eRUnRuUl00u/GU4OL5h147NmDWSYDECUhdl54NxUUDvfve7S1b+BegTYcdfr3p7sj4wJ15NH6pIHTmHsiOoNcR+e1rBH+WsBhvPqiLH/fYOwkV4WGnTZdJCiKauS/OWqqbDAVPnraMqug2iOy4BXToRaTeiuMFE=
Received: from DU2PR04CA0156.eurprd04.prod.outlook.com (2603:10a6:10:2b0::11)
 by DB9PR08MB11377.eurprd08.prod.outlook.com (2603:10a6:10:60b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 19:30:35 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::2c) by DU2PR04CA0156.outlook.office365.com
 (2603:10a6:10:2b0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 19:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Wed, 12 Aug 2026 19:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGRwkgP+zA3MDlwg5ZzdpBvSZurUmCTM4VtNka8COAZbTXJD1Vl+hrNpqQTKNj1ELYMkSczisYfRzKwhfgs5Y+Eb75vejF2ENVTDN2qnc31vQuSZpgR54luW5Ue9bzfANDCoccgyMJT2KRCDZVogsIrew7UqAbX7Cv7GLa7I+FXdUtIJ7L5DkxOGM/JqY81BLvSungiidtFhncUH9bDMpoMG2b6Kwo/1ZgbIkPEULT0TZHyiUrVgw20zuzZDpQ4k+hE4fVL6sww6ruBFbUcR+welJrRLgRMkVUD/xnz7MgPN/tnvfzM6SeR8kkwqStCj55xIZBxNa6UUhZNFStW+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBeP66ozKSvmorSl0FZyztO29Pozt39bOLmckur6lI4=;
 b=vMKg37IDTHtAY1KQmtJbo/cpnAi+9LOZ/pC7EQ0MW1gn3If4i23Ro1mpNSFQqvmgxiqUel7bdXjUSGc/m83zKBxiag3PvC8LQggHKTZ9f1R0xj0ziS8lFO9ekp8Xad+2kV0HixPDqZAqURsKwyVzZAbTE+gxWq2NZayAobk4jGht5TbPPm+hUOY8uMG2G/cY4p1meRoA5i9WoKlMlUArjDdjM4+g1rtTTnznPCv2HqdHf5COUWsNfjg+9sf52g2cCuzXn1TUk8tB3QbA0Hl6yqdybY/tEAaNezBGixg3tMk0Fe6Nvu6Ob+SDhquzwY7iKCx4pJBWsGdDsDeQa5Kh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBeP66ozKSvmorSl0FZyztO29Pozt39bOLmckur6lI4=;
 b=M7aGLOsW+Z45eRUnRuUl00u/GU4OL5h147NmDWSYDECUhdl54NxUUDvfve7S1b+BegTYcdfr3p7sj4wJ15NH6pIHTmHsiOoNcR+e1rBH+WsBhvPqiLH/fYOwkV4WGnTZdJCiKauS/OWqqbDAVPnraMqug2iOy4BXToRaTeiuMFE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9829.eurprd08.prod.outlook.com (2603:10a6:102:2e6::10)
 by GV2PR08MB11371.eurprd08.prod.outlook.com (2603:10a6:150:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 19:30:02 +0000
Received: from PAWPR08MB9829.eurprd08.prod.outlook.com
 ([fe80::5cca:dab9:827e:c7bc]) by PAWPR08MB9829.eurprd08.prod.outlook.com
 ([fe80::5cca:dab9:827e:c7bc%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 19:30:01 +0000
Message-ID: <b8c6b70c-4718-45d9-bd08-a837599868d4@arm.com>
Date: Wed, 12 Aug 2026 14:29:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/x86: add generic prctl shadow stack test
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pjw@kernel.org" <pjw@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "mingo@redhat.com" <mingo@redhat.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "shuah@kernel.org" <shuah@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20260812171940.1046116-1-bill.roberts@arm.com>
 <20260812171940.1046116-2-bill.roberts@arm.com>
 <c5d5c26c-eaa3-4fd3-891b-808b6efe3c25@arm.com>
 <ca8465e2e006d31a4fc728707cb679f25a3fa7f2.camel@intel.com>
Content-Language: en-US
From: Bill Roberts <bill.roberts@arm.com>
In-Reply-To: <ca8465e2e006d31a4fc728707cb679f25a3fa7f2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0112.namprd11.prod.outlook.com
 (2603:10b6:806:d1::27) To PAWPR08MB9829.eurprd08.prod.outlook.com
 (2603:10a6:102:2e6::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB9829:EE_|GV2PR08MB11371:EE_|DU2PEPF00028D0E:EE_|DB9PR08MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: 568efa4b-9ff5-4e9d-1650-08def8a82e57
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info-Original:
 3j8Rhy03cQa2+12N/y7dZ7i634fGwM5o+TVWUi/Ze9bqsxrfpwXLa4QSJIQ/n1tPx1B/KEyxVATASLStcCUp4qP8YLnl59m1zR1kA/2uGKiCFneY4NGYIccv8//ShOhyathfr6hZGzq/9we/v+S1GTt7UxbGbQR92eg1Py9LH9x0cqnjC22LT/Rsj2e1ByY41NHyBKIntk2qMm4+YfFBApxa64idPLSm1spgMMY+I0j3lqpIs1modLpV3qV68GL/cDzmZ2NF1eRRQET3J2ORxU9b40JeZGGGeZTXKqZLg8Tk6kkrQ1vKEDss1epNxQPAcyIbPvN/Qo/gzasj/4vxybCsNVB2/vFJ5RTmNp1Xyjg1k2Tplhlxva4/xcSJDxN10Ky1suD4JSslREy0wR8BEqSZZUPd73IsFVg5+8iAy4oPUpM6b10ZXxrGF+j0soWsdWRn9U3CoS9y6sEx9d3ID5ATz6bg44rE0QorCMatTaSr1ltL0LwYuUs2CFhksEMn8f/avdxoSG4pWPdfnQF05/yf+sIur/jaZJWgcAH0YsIAvuzH82yuOBaKDb3CEfVqnbU6aGJN3n6UBxr1vP68gLPKhz0vMBbgPm0ngm025lztIgg3iNnnEXBi5sKhaGDpFnRDNfM+Iq/lj+nzRU/dUUY1BMfU0sPo+R3sTvNH/0E82hcMe7qJ9jJGxYTq+X878rhb1be2YXJ3dT6aF9p/2w==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB9829.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 fetRtjB+9hPerobkUv4vfigS9LFw4cxS4RJjg1QtUf/deEA0pVcoZqP5fJwOHuSbumxkF3QPzleyc9hNaQllyOL7+0hOdFxDOStLja373+5k0jIaVsWBEj5ZN5MUXGWsiqNluZ5tGD49QsNrvhKaA8Oq6cj07fFIr6GLgvAzsuRougUuyBBssd9QU73JkYzxWuB3Avtko7t7Mbcbm5ENudWdQnX0UGZctOBKW0ydLFu6Ss/XIO3GqEDeETtBIiVlOev4S4Ed0xQC/3y/ws0wmRqFvkAzsOLx5nbbe/R2e/kXWoLERMBOru/oa6qlRC7FesAcMpKsKfNABudcyPWpHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11371
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	17064bde-2367-481e-28a2-08def8a81a7e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|35042699022|82310400026|14060799003|7416014|376014|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	oKEY0uk42SMSxKvzhrTuhJVb30pToLTrhk8fT657AQHr0Q5e8bmWEkYLczhjZg2UCzxinKJ7m8JpsDqNcenT7Ba5RcAxZWGRPulT4aBek0mOvvI1eiM4Q117tu97qACyN0JL9wKZ58bQgIddEmwOFCeGACFyneLmsdsx17OW8hFmvwiCF89Ad/83Hdh6C75jGHBA3hKMxQHfnp+1HS9c/Z6hD/EI9o6hYC+D1dT0A6AcqO0K6RZzUXR90OO0ErD+EVCMWxC+aYzzp5VMIbsyvXjcCJgoT06CLMFrqdabZeqYn2hOfJGJLFRapyW8qWq8+gR3VkUByXa62OPcJ5vXk+JUssoHtexQlEDBpMgvO2vmuAWcZXTK+uVi5ayPpJuO+m1FY1iNGbIljiuQ9x2PitTtvAG81BmCUAQDGb4EK5HV6kEFyr/ZnFDg/wVC5alNgYwwjfchCvLih+AQijWrsJvEbeQiOSQlBKek11SI1PJv05xb+Wh7o/0h/M/zF+kIR2eTBlIdZnNFLs6W1YF9NIF+21ydKm4JW+QA5Q9mHRZduzOK2gvjJg91Dma/c/xQO3e9WIrhhRx4mZpT9onNm5J9rp5w6nfDdd6t7gnVSoz31ALStQiM+s1KhijCYhvHNtubOwUCDaUmDPHTdmN7RSmXVSu4KMS77wshFy8yBu8+55iapJEIxten18wVQrFZL+TqnRL6weEmPK8Dwqdx8jeLn3AkpLIIyjo2lhI3OHuA4ZjjL0tLhdh16SZpiMA0
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(35042699022)(82310400026)(14060799003)(7416014)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SfPzftmw4qVBuipktha5BeSBuB1u7cCDjSHsOs9TYkWkNAg6100dLZGgF7ct/hiqGI8PBb0aTaAxYzPXuZ9lTB5lNaIOTLXh/K2XYzZYrhW1ZvXhjMRSiAmijFPyQd+ecVRhGNpSmT5tMADHvxqlmcU/mZXEL/CQj1DseB2wkPo8nfc2h/O3e5YxHlCWbLGivwg+H3BDNVCBROXOo9EXq7+flj8WFEmFZY3u3VbBF44PgrgKvhL/g9bAd8TzvMQFCXbeUGbqg/ccguv0rG5ZUieAWTwEm5K4E3Nx5Ml1uhtX8LWaA3vNm4EVtwESu6pyHmDWwf2Jgsbo/HvjssbA8C8q8zyHEELdmU8623yt975ssH8Y8XV1LkLb3t1PQsvc4aOOz9BnMlC0bqoGk6P3vr2REaZiRRoApRcBvo+QArDAlNP5JJfcsACkF9KKNH8O
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 19:30:34.7819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568efa4b-9ff5-4e9d-1650-08def8a82e57
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11377

> On Wed, 2026-08-12 at 13:03 -0500, Bill Roberts wrote:
>>> +}
>>>
>>>
>>> Nack'ing my own patch, Sashiko found a few useful things to fix.
> Please trim the mails. That was a lot of quote to search through.
>
Sorry each of the many communities across my world want it differently...

But, I would take a review while I re-spin patch v3. I am going to add 
get status and lock tests
to cover those cases as well as fix the spelling mistake in patch 2's 
commit message, "consisteny".
As well as fix the fork bug where -1 can be used in kill and send the 
signal to everything.

Shashiko FTW

