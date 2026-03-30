Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB17377551;
	Mon, 30 Mar 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888679; cv=fail; b=GFrEucFs7DMgEQZTdoUDQdWJhF3wVPdfb/Kwgmn5FQLcN8yK8/sozcJI/aqk7dkGP1PPSGQbapU/pDSyVdslAjpFEEAzS7TH02muNlnJWGtxYdYX5InkU7GokzzDUW9sXBPFiMFFPc7imMglBXs2yibtkrFAipHx/s3PR9uE0K0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888679; c=relaxed/simple;
	bh=ZQZcOHQs1WbPgo0CHtHVeeg3nzm9tpDvfAF/Cc5+LZ4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZZusL6BhUNuweozcyYV3V3UX4UlgD1PN3N67WnL9/ezvqo9oTKQsGtWMx9YUpfvN5R8sCec0/yY6VZwMR1YGM1FEZpCsP7y2lL6vCtyScr5SsyKLMrhi4p4ZCO4yCIEnY7dTW0pBW6GIRK7HKykGQ0ZLPxWl7eZmg0871z3P6Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GrJA2We+; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GrJA2We+; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GrJA2We+";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GrJA2We+"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FDSj8H5ozhqXhAjh9HSGAAs6epVxztoRZnQ7l0RAPEMswfiRAUDj22sdvcfVRDJp8M1nUsuAO7pyBbqMOEOM135thLQQPAJ6QaMGiEpZ58NGF7i8aFT09jVMXPlsBax6+AjGhN4ffd1/ySBzJjwAuQG4Zo6waxzrX56EuZ0MpAf+LI5L/7eDsHHW4u7h6uwrqy+tGOY8yDqxl2WwJwZWtrXPHG+51mam9pC0us6g2uy0YldTtthWaBv6SlG9n2b8WWcBzBr6PpdQMDhzJOZlJGA0KbF0E5jSqA7UM8Y5oIjuyg4pmmEbFArQIcB+AQtggoWOFPtr9j4xwl7BHpdkVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5WuJnllT7q7Nqh41kIUJY6DVgaQyF1no6/rOpIbybc=;
 b=qEZ+8vdsLfD0rZPdWVSK2bnmsYmw+6pntfICV3KXbsR2KtOMsxFWE6Ty/XoNlwpTL/hNLzHi5AyInBWsKoH3LtHOUulNwb940KWcfYLhAmAYqEneS3Yz/l1OCPJn55tTqdP2VxqowzKAgUauKraI9UJ3HGQzkIsTH5vfbxd76EgwxO2UsMqb7NNzaaZFTAniOxu3P1uUiPoQdQ+LXPe+klfkmaXdX2ZJEgZ57wrSQ5xD+bjTJc+MEvbrP93E9QhV5V1kg4RG8H6JOVFV/5l0XwShTNudfP6Faqlm8YOjGWjCPWa9BHaxAA9hreeqP1g2sTy/eV7RTLVYSCCeC/WfxQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5WuJnllT7q7Nqh41kIUJY6DVgaQyF1no6/rOpIbybc=;
 b=GrJA2We+35WMiwUr4IKCqgBS5+hmf0Id607OvZfmlJJqc5TKvwWnD4KEoa9Iz0o46rcFQf5MKEQFLEa26lvcLOLAKmEDtHgjHR2qawfpdtTURKlJvlmuVKhlv1x6c18o+14nAkCZA0YIa8foaUEakxCOZiWbTQznXMBDVe2aq/A=
Received: from CWLP123CA0129.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:87::21)
 by PAXPR08MB6560.eurprd08.prod.outlook.com (2603:10a6:102:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 16:37:51 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:401:87:cafe::54) by CWLP123CA0129.outlook.office365.com
 (2603:10a6:401:87::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 16:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 16:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO6iBG2qgtHY506w8QOC7lZQ0wd/m0LqGY2TfoSNdEP7sLu6e3X33HVGuCXu7USlAN2Z11Iw2LWUH8iH0cSmjU8LuxAvRCLM+444HB+ds6GqHmyF3csgUDPiI/JYVyCmTwN3Z7aAkIZ5QlLDky15jEiLyTmoCW9mrM9YVqz9XOkYlYoVJDh0cnnix8cZ6LGm8NhgvMuTmAT7AaRhBckrt7HejbMRsfVtfZpanIMmJZRI63i4tNoinTx+QEfoi1Bpr3Vw2yrh6gZeyHKrBClm8RgQZzxZfikxKqJXE+6hFNdp78SIINeA3Vol5GZ5ul6BtAqLxreblH0ljkpScgxkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5WuJnllT7q7Nqh41kIUJY6DVgaQyF1no6/rOpIbybc=;
 b=B8Dyf529sXpEvnHq+uQNC/SqFMvRXivHDcx/IbUw/RBQNKxBfCoXGSHet2haxSmF6wfYTDxHOFVevvakBmvnp3Lz0KxcJNeQM8FjAEUqWZy9eAU6IcZPELipJrQbFwWjj6AA9Z2V7R8hvnqduZ1XP7p3SfZ0xatN4m99RVaY07Pr3W0CFSL1kyteR1FqX7leyuxzCIFQ3VZ0eUML8q7x8zuHyWQon5h4gP5hzjk4rhDXlaV/irYE5FkcGXvG4cUcBEvxy1JG556o1lhwV/T/kaNoTniWEOdtBBF2RGZiM6mFcrxE/sdTPQV84rt/d6hmIRchoEcsk4aKs5/bK7i71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5WuJnllT7q7Nqh41kIUJY6DVgaQyF1no6/rOpIbybc=;
 b=GrJA2We+35WMiwUr4IKCqgBS5+hmf0Id607OvZfmlJJqc5TKvwWnD4KEoa9Iz0o46rcFQf5MKEQFLEa26lvcLOLAKmEDtHgjHR2qawfpdtTURKlJvlmuVKhlv1x6c18o+14nAkCZA0YIa8foaUEakxCOZiWbTQznXMBDVe2aq/A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by VI1PR08MB5311.eurprd08.prod.outlook.com (2603:10a6:803:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 16:36:46 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%4]) with mapi id 15.20.9745.019; Mon, 30 Mar 2026
 16:36:46 +0000
Message-ID: <3ca98546-d123-4d6c-8b19-4e07af03ee2e@arm.com>
Date: Mon, 30 Mar 2026 17:36:45 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com
Subject: Re: [PATCH v4 1/3] mm/page_alloc: Optimize free_contig_range()
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Vishal Moola <vishal.moola@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
References: <20260327125720.2270651-1-usama.anjum@arm.com>
 <20260327125720.2270651-2-usama.anjum@arm.com>
 <b8bac0eb-17cc-4e0d-b7f0-a8e7e0da0d67@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@arm.com>
In-Reply-To: <b8bac0eb-17cc-4e0d-b7f0-a8e7e0da0d67@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::13) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|VI1PR08MB5311:EE_|AM4PEPF00027A5F:EE_|PAXPR08MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7365e8-65aa-40ba-e0f6-08de8e7aaf42
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 1NB6LVSNHnywYGgL+DpH8nRiyFbJn0F/PWz/iTgIGJirfWPR2JSkbYbJ2wWETBZkywbxF3672VMJr7GNjggEeJ95Vghm3KaLYkz6+kBYa12889nq7iEJusZd54mWfPAudWfj7g12Oi1Kc+yKrbeTm6nVRMW6pmKKgEqOvAKiQAKq/O7mInZQ9CcKiOKdP9w+PwzeUA1ZOyEH7MD0OnMP3cXM0wV1t+577KkiyLO5Qo3a81uk44N/Kra1t0Tzt/gDq0g4DJT1u1hnNZESY9u3mOnQ5U89xU6Ozhje3jyaBLSBbgnSGkxXWhfBq92iy3BRFT3tLr3QQ5YBUHTwPkt4zCnfkmq3AaTOsDXG2h8yRrv8MiJ3TmG9BhUMoLGhAn6znEXeovtYLh3EiTezHRqEU57W9lYEk8FA8l3qye8rEJacK0QEybGbREw64wDpTvVrNR4Ckf3KPVU/7Qaky+LpRM2nEuo9jmjPtfITUX/As22WUt9gMEetY7YQaHovEF4Q9xEoTTnyvhzsihIQYBFvkYNoGWlR0Z/MOO/PpZeGha+0tphuerd5qfn6drIjnun3Ek2ACDGTqBBV22CzDqWBELC9dMlP5V3wr+q8byd32WJRKu8sicr5x/TXpihfOSSJMk3UFFF/bIVj1mFufkwt7FQaW+F5b75PuaVuqeX5ewFUkuXWaqFsVCOBWpLgkXl1zHRmKehdXGM9YqThHE63sHxCFCvhTbeVvXZk9U0viW3I+n4vcYgp4H45R9jR78N0CiHdiBAH33bNjvXqhMS9Gg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 utp7mXkQTaeMRsUcYI5ur70iQsaC1u7HUUcc3i+hquhKnQfwCsswy7JYOHyQ8iPMi+OTfDijZs1RuOMLOkRetxj2jxWbHIIEnBYlgHoG1IcSx44RAGMOnCkiTO3bWXU6mKh4sfVd7AIVdej/y8fsYQshrgPE8xWclExmhou7EAFLsdzhHiZ+8OY6NyubMcJ8QXtHjzMW05bl6RzvQLRYZu8MJwDBwIAFuiCDNB+GFSNdrmzJGvupAiMO93qQboM3+9Qdnfrz0qgdUUE9uDa9dpfdl7KrdG7qqcyYSUZLCXvTaU7g6XsCclXPnAX/fdRSU93+jvEVvdGH0ikSlowssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5311
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0adbecc1-d1b2-4b75-3166-08de8e7a88d9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|35042699022|376014|7416014|1800799024|82310400026|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	D9erQmhZi1NJiIVS0bGCQVK6g59bgFZOZx8FJMOj4/Abyc++3J+8FwQJhqRhhxVgerRnrbGH6EcPFUjzyDZw8DxrgrCHRNFkmMduNd7aTjsCjOhIB5GOKYOh3wYxY3LrKVylcdW8L4Ay4dQp9CIURKHb1WGRUqARjH+ur5/L62P1lnhTxPF9TZGngvzXPKFoeOzhaWjSvXr+oTSgZGNuyLnJILN9Uflb40FEkHzsoObUvtamB8AF7OwbgFAcD/GXCxob29SnxayuJd32aIlfj1aZrltWrtAAqxh4n8+E5HEcKUZl9dgqwOVijq8jogc9B5lVq9h3PuS0wD0NbtfGctvHK+BDu/K2jkm+CCRT6v4cDHWwSBezdyBfCQzHT4piIzVWr3lz6dTBTz3E3jgmnXEtiA0PonR0w1lZCip60ula7K8C8n/85I4NIIRcx5kkh6vHEMAwEsa1i/F5GCFhqqtkXuKFkeSrnDwW5qhhyMT76zdWfGccvVGJxPhI9nokO7s6qvm0KXO8kaowce6kZfNiISdKqbbrcJ+5m8QzO/KNDKTRek/V4YOjYSLsOSmRQYxaiCYImbG1ZEUW17S99CEQFQjTsvYE4JNO5nsNYU8X7wvUnvRGAYPCG48jjqWTwcMDyLF18wBV3bB12SqA74m0PHub17dBmHyfDP3XHajvkMmWDjeDWgKsRTmHwaIz/x1wdhUOM3OmaAx5yljv6kTfUYXjzDynezpCMVNbH+4hEtSr6H/6KEgGW7DFRaXvGF69qW2LeeR4enlWYDAnW4JVV3Ma80lXk6pQYemRZaviD0rUYGQHQy+W59emEXnU
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(35042699022)(376014)(7416014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lFcnSIDPlldy8JTBYb7opH9wGAWaHAxhID88CvAQ6HGC80Kd1IBxyi5YLvz+ZpTbRk1LeUa/QqEO2jl2DT26AJvHToZltP5xP4GnfAgfzkQrQpvcrw/kZXNn+qrKr2YdntOsl5ZO8GE42Mcc9i/Gu7xzdpcw3XK+pusm3d951pNNaTaaZXiWY0wV6zx/fpx3wkqQQ0VOgF0znWzPF6cSakqlgz93UARrJJosuX9YSXmtrdAf5ixTI0sSfwFF1ORGUWAROKSAHiTVFp7Rp8zpIE4qKzwRDpfhyatuwqEqRwwebOmdihQEe74DVi0wR7DCFaJEG/WyiYk43dn0FpdHuvti9mB+lC+AhHBf/2NNPkc2kxLKuCXTzChHOB/NeH35FXvuHANfr5DRpTa3giKjh4N8SwF1DKxkx6NOoQYA/HiM8PImxXml020J8Mpq3dsd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:37:50.9694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7365e8-65aa-40ba-e0f6-08de8e7aaf42
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6560

On 30/03/2026 3:30 pm, Vlastimil Babka (SUSE) wrote:
> On 3/27/26 13:57, Muhammad Usama Anjum wrote:
>> From: Ryan Roberts <ryan.roberts@arm.com>
>>
>> Decompose the range of order-0 pages to be freed into the set of largest
>> possible power-of-2 size and aligned chunks and free them to the pcp or
>> buddy. This improves on the previous approach which freed each order-0
>> page individually in a loop. Testing shows performance to be improved by
>> more than 10x in some cases.
>>
>> Since each page is order-0, we must decrement each page's reference
>> count individually and only consider the page for freeing as part of a
>> high order chunk if the reference count goes to zero. Additionally
>> free_pages_prepare() must be called for each individual order-0 page
>> too, so that the struct page state and global accounting state can be
>> appropriately managed. But once this is done, the resulting high order
>> chunks can be freed as a unit to the pcp or buddy.
>>
>> This significantly speeds up the free operation but also has the side
>> benefit that high order blocks are added to the pcp instead of each page
>> ending up on the pcp order-0 list; memory remains more readily available
>> in high orders.
>>
>> vmalloc will shortly become a user of this new optimized
>> free_contig_range() since it aggressively allocates high order
>> non-compound pages, but then calls split_page() to end up with
>> contiguous order-0 pages. These can now be freed much more efficiently.
>>
>> The execution time of the following function was measured in a server
>> class arm64 machine:
>>
>> static int page_alloc_high_order_test(void)
>> {
>> 	unsigned int order = HPAGE_PMD_ORDER;
>> 	struct page *page;
>> 	int i;
>>
>> 	for (i = 0; i < 100000; i++) {
>> 		page = alloc_pages(GFP_KERNEL, order);
>> 		if (!page)
>> 			return -1;
>> 		split_page(page, order);
>> 		free_contig_range(page_to_pfn(page), 1UL << order);
>> 	}
>>
>> 	return 0;
>> }
>>
>> Execution time before: 4097358 usec
>> Execution time after:   729831 usec
>>
>> Perf trace before:
>>
>>     99.63%     0.00%  kthreadd         [kernel.kallsyms]      [.] kthread
>>             |
>>             ---kthread
>>                0xffffb33c12a26af8
>>                |
>>                |--98.13%--0xffffb33c12a26060
>>                |          |
>>                |          |--97.37%--free_contig_range
>>                |          |          |
>>                |          |          |--94.93%--___free_pages
>>                |          |          |          |
>>                |          |          |          |--55.42%--__free_frozen_pages
>>                |          |          |          |          |
>>                |          |          |          |           --43.20%--free_frozen_page_commit
>>                |          |          |          |                     |
>>                |          |          |          |                      --35.37%--_raw_spin_unlock_irqrestore
>>                |          |          |          |
>>                |          |          |          |--11.53%--_raw_spin_trylock
>>                |          |          |          |
>>                |          |          |          |--8.19%--__preempt_count_dec_and_test
>>                |          |          |          |
>>                |          |          |          |--5.64%--_raw_spin_unlock
>>                |          |          |          |
>>                |          |          |          |--2.37%--__get_pfnblock_flags_mask.isra.0
>>                |          |          |          |
>>                |          |          |           --1.07%--free_frozen_page_commit
>>                |          |          |
>>                |          |           --1.54%--__free_frozen_pages
>>                |          |
>>                |           --0.77%--___free_pages
>>                |
>>                 --0.98%--0xffffb33c12a26078
>>                           alloc_pages_noprof
>>
>> Perf trace after:
>>
>>      8.42%     2.90%  kthreadd         [kernel.kallsyms]         [k] __free_contig_range
>>             |
>>             |--5.52%--__free_contig_range
>>             |          |
>>             |          |--5.00%--free_prepared_contig_range
>>             |          |          |
>>             |          |          |--1.43%--__free_frozen_pages
>>             |          |          |          |
>>             |          |          |           --0.51%--free_frozen_page_commit
>>             |          |          |
>>             |          |          |--1.08%--_raw_spin_trylock
>>             |          |          |
>>             |          |           --0.89%--_raw_spin_unlock
>>             |          |
>>             |           --0.52%--free_pages_prepare
>>             |
>>              --2.90%--ret_from_fork
>>                        kthread
>>                        0xffffae1c12abeaf8
>>                        0xffffae1c12abe7a0
>>                        |
>>                         --2.69%--vfree
>>                                   __free_contig_range
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Co-developed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>> Changes since v3:
>> - Move __free_contig_range() to more generic __free_contig_range_common()
>>   which will used to free frozen pages as well
>> - Simplify the loop in __free_contig_range_common()
>> - Rewrite the comment
>>
>> Changes since v2:
>> - Handle different possible section boundries in __free_contig_range()
>> - Drop the TODO
>> - Remove return value from __free_contig_range()
>> - Remove non-functional change from __free_pages_ok()
>>
>> Changes since v1:
>> - Rebase on mm-new
>> - Move FPI_PREPARED check inside __free_pages_prepare() now that
>>   fpi_flags are already being passed.
>> - Add todo (Zi Yan)
>> - Rerun benchmarks
>> - Convert VM_BUG_ON_PAGE() to VM_WARN_ON_ONCE()
>> - Rework order calculation in free_prepared_contig_range() and use
>>   MAX_PAGE_ORDER as high limit instead of pageblock_order as it must
>>   be up to internal __free_frozen_pages() how it frees them
>> ---
>>  include/linux/gfp.h |   2 +
>>  mm/page_alloc.c     | 103 +++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 103 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index f82d74a77cad8..7c1f9da7c8e56 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -467,6 +467,8 @@ void free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages);
>>  void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>>  #endif
>>  
>> +void __free_contig_range(unsigned long pfn, unsigned long nr_pages);
>> +
>>  DEFINE_FREE(free_page, void *, free_page((unsigned long)_T))
>>  
>>  #endif /* __LINUX_GFP_H */
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 75ee81445640b..18a96b51aa0be 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -91,6 +91,9 @@ typedef int __bitwise fpi_t;
>>  /* Free the page without taking locks. Rely on trylock only. */
>>  #define FPI_TRYLOCK		((__force fpi_t)BIT(2))
>>  
>> +/* free_pages_prepare() has already been called for page(s) being freed. */
>> +#define FPI_PREPARED		((__force fpi_t)BIT(3))
>> +
>>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>>  static DEFINE_MUTEX(pcp_batch_high_lock);
>>  #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
>> @@ -1310,6 +1313,9 @@ __always_inline bool __free_pages_prepare(struct page *page,
> 
> Hm I noticed the function isn't static, but it should be, and this is a good
> oportunity to make it so.
I'll make it static in the v5.

> 
>>  	bool compound = PageCompound(page);
>>  	struct folio *folio = page_folio(page);
>>  
>> +	if (fpi_flags & FPI_PREPARED)
>> +		return true;
>> +
>>  	VM_BUG_ON_PAGE(PageTail(page), page);
>>  
>>  	trace_mm_page_free(page, order);
> 
> ...
> 
>> +/**
>> + * __free_contig_range - Free contiguous range of order-0 pages.
>> + * @pfn: Page frame number of the first page in the range.
>> + * @nr_pages: Number of pages to free.
>> + *
>> + * For each order-0 struct page in the physically contiguous range, put a
>> + * reference. Free any page who's reference count falls to zero. The
>> + * implementation is functionally equivalent to, but significantly faster than
>> + * calling __free_page() for each struct page in a loop.
>> + *
>> + * Memory allocated with alloc_pages(order>=1) then subsequently split to
>> + * order-0 with split_page() is an example of appropriate contiguous pages that
>> + * can be freed with this API.
>> + *
>> + * Context: May be called in interrupt context or while holding a normal
>> + * spinlock, but not in NMI context or while holding a raw spinlock.
>> + */
>> +void __free_contig_range(unsigned long pfn, unsigned long nr_pages)
>> +{
>> +	__free_contig_range_common(pfn, nr_pages, false);
>> +}
>> +EXPORT_SYMBOL(__free_contig_range);
> 
> I don't think the export is necessary for anything? Please drop.
No, I'll drop it.

> 
>> +
>>  #ifdef CONFIG_CONTIG_ALLOC
>>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
>>  static void alloc_contig_dump_pages(struct list_head *page_list)
>> @@ -7330,8 +7430,7 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>>  	if (WARN_ON_ONCE(PageHead(pfn_to_page(pfn))))
>>  		return;
>>  
>> -	for (; nr_pages--; pfn++)
>> -		__free_page(pfn_to_page(pfn));
>> +	__free_contig_range(pfn, nr_pages);
>>  }
>>  EXPORT_SYMBOL(free_contig_range);
>>  #endif /* CONFIG_CONTIG_ALLOC */
> 

