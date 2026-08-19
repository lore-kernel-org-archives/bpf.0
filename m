Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9D146D2C9;
	Thu, 20 Aug 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247907; cv=fail; b=kT7foSiurXhE05K3iCS5AfSSGe8RAALihiMJ3TvrYRXF04vMHvuxRb06HfDs87BTPSrGmS6r+c/gs0V9NoyADYobm9qjtJdROf5Ka60zaDgE2lqdLfHs4fQmvSm9GC1F4tN8pzXJGEe2zcBpNNfm6x+Oe+3Hnd+OijiiyyX3Nlg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247907; c=relaxed/simple;
	bh=C9pZyXVNV2qGraiPqZKUiKt/gxUInIwHLwzqvrsne3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YYPBcHLLEXGjUqH5SyyfpUJPnP5zB0IOJQV3+/TjK3XJrsQ9ImNzrgnVy93E/ZxlByi+0gBq0Rc3g+B3cE8COvyIOn/v2BwxAhgfIDGtYimM+pBsqzrBBr+tqyJoJ/Pnwbv7+o0Iule3ROm1y0qaWYOVAbuudiiUykEbhohScEU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fLNZsPfC; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fLNZsPfC; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fLNZsPfC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fLNZsPfC"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QRMafLEW6SDg9UF1jxdJ+8koolcQg8tP2571/j5O9cm76OAhVK6bf8tGQdLvEXHFILjh1I7fBkJ8XKsJlWrncpwqJufGJ67+kM2/bjB9v66lz/M8Iwto6PY1fQ4tnbb80wPVo18gK7sF7OejcfOTVbfLl8gd9zuk6PcKUhxUYaGX45DzqM7hKAX+pflXt7CaqfEmcgoxmZLaWsfwAbeNyCKn5UdAmRyJsSd+jpIHXVF9PQ9YwfgZF0TPw8KOQnKR1FOkw3hvtmeX463QgCp5srzzLn/QZsA7cWnVAAE7C0o5ShSNcaMwu3D9O3ydkPTAokOHfqysc91PVVqWyMhzXw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tsJNllLwum4Pfubf/Qlgef6WZ37zyq7wmMc7geL7e4=;
 b=UgHeSNZv9PQ+6eOy7Jh/6Nf1pSziyBH1M+uVJHSV+olywmPgcfcW2UewQ4thvE4N6nM35zXCXxXRTjz7k7ju+zaje4MAFMnAUUBRC/BY3tYRo5pFC0rc9pBeCglb21U6RGmL+3l2wb3gOrPaqcoSk5DxSvINVSblonOLUYJjdTnQrVlkQsQjVmaXfGjW8P/mL5bYu+FLkcsOedLq3rDATy52LBjFgBhRuDxZw9eRwTkHWlj4lj2FEmV0VXR0kHWoeo7nxcmV+0357VhsJUNR/FTFVzOumIi1kyprHWSM6z1xdQugHyrQ7PGRHbOqErUPjf1tXrnxPW5rVy0cFD3z2Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=zytor.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tsJNllLwum4Pfubf/Qlgef6WZ37zyq7wmMc7geL7e4=;
 b=fLNZsPfCsP/zgoFuujL/S0lggNNgj7cpKf5ZMl0wNVt4Vqn0Lg9xFwIJSisr7QbqkMXWIVTDKGleIJQpZfOFu9eL4pn2JVRx/LjMxk+12vqeYNmhHAJnEL/A4vTpqxtZXt9OJ/B/7KQifgEa4lyhlStlf26YxXWcLi8t5OJF41s=
Received: from DUZPR01CA0322.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::20) by PAWPR08MB9097.eurprd08.prod.outlook.com
 (2603:10a6:102:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 17:45:00 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::20) by DUZPR01CA0322.outlook.office365.com
 (2603:10a6:10:4ba::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 17:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Thu, 20 Aug 2026 17:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zG3yrmUegB+GRsQn8UKaZXpwh9JbLBwLjrRFo1KTSqI6o69zYvHvL3j8cSHqsU2oWhs5/oyjWMQ5sYEieapzdius6L3KWh0UvdsJTm3Xw74tHNnwosITxcTZErIIJR2Yen4tnGqczGpHR4VrDPy0u1IAosR3mWrHaqhLhdWyVdG+d9Z2PJl1pfpZJxtocUsh/BA4Iddxj2WEzNp9vgk96BBm9l3sjx1d3v6bRnduaiM4KnmHVNT4Te8voxar7TCFzQz+Cd55tfjnMb6ezya/tDbpOL+gr62AabBGTTDfmrFcZWGI/c3K86vh5aFsHEF9UNosho2bLP+iNg3KqGUc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tsJNllLwum4Pfubf/Qlgef6WZ37zyq7wmMc7geL7e4=;
 b=S4PXY5QmJ0dP+Np44cdkfc5kMdOJdOtpzH/JD0QKOQpqYTMDv6H9OwrCB5hPpOxzc0ZH6CgfxzxEI8pp8YggJoLxP1ChdPSPEMoaGbsWAPDK32wGlIdEYSeT7gOYV6S7adJ/LdKpCgwrHAglTRW0oirL2/yzJ6jtM+WkBrKgGPaMi9M9nbraUOUMHUa+I8zuHcYGQFju9UauOT5ZpMrkhpVVNevp79BdIwcIE3qxuPWlsErWyYqD20olapUB6YWJz4V94Srvtm6oHUkRBEZUKLbn3S9vpTMo5hv2WyobBlWq8dWtMeTqj52RjzEcCsafp6RN/4L5jtAhAzT1734lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tsJNllLwum4Pfubf/Qlgef6WZ37zyq7wmMc7geL7e4=;
 b=fLNZsPfCsP/zgoFuujL/S0lggNNgj7cpKf5ZMl0wNVt4Vqn0Lg9xFwIJSisr7QbqkMXWIVTDKGleIJQpZfOFu9eL4pn2JVRx/LjMxk+12vqeYNmhHAJnEL/A4vTpqxtZXt9OJ/B/7KQifgEa4lyhlStlf26YxXWcLi8t5OJF41s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9829.eurprd08.prod.outlook.com (2603:10a6:102:2e6::10)
 by AMBPR08MB492128.eurprd08.prod.outlook.com (2603:10a6:20b:787::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 17:44:28 +0000
Received: from PAWPR08MB9829.eurprd08.prod.outlook.com
 ([fe80::5cca:dab9:827e:c7bc]) by PAWPR08MB9829.eurprd08.prod.outlook.com
 ([fe80::5cca:dab9:827e:c7bc%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 17:44:28 +0000
Message-ID: <34a23a33-0c2e-49b6-b7c1-e8652e9b7241@arm.com>
Date: Tue, 18 Aug 2026 20:07:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] x86: Support shstk via prctl
To: "H. Peter Anvin" <hpa@zytor.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 rick.p.edgecombe@intel.com, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20260818225428.1983328-1-bill.roberts@arm.com>
Content-Language: en-US
From: Bill Roberts <bill.roberts@arm.com>
In-Reply-To: <20260818225428.1983328-1-bill.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::21) To PAWPR08MB9829.eurprd08.prod.outlook.com
 (2603:10a6:102:2e6::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB9829:EE_|AMBPR08MB492128:EE_|DU6PEPF0000B61E:EE_|PAWPR08MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f05d67c-226e-4f51-210b-08defee2c1d9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info-Original:
 83NiEdIk72jmA4yGYLJWMYsvzo29X8XiJI3/IxNbsnqNKrYgQ2dIwpe/eC1deWgYwfLkvMD8950rElxQkPlpkq3D8Z3QcMo83INH2ucTgOjqj8OZ2Fe3jIMNUcv+zJQ6oa0IduTD1HAH0oWwYFcawB/W4qcB49Jq6VIEDkDDX6PpgnqZVtXKCQBtXvtfoma+nuW+q/xBwPT00Ji7ZUodN7QveoQhGZgaf1AJJd02M6/MEbBw0Mo/jn2dalHfod+3gscqICH/1tPNO86a50kznxTDiVH+ZWX1dRTxZbqac7INMcSh6U+/txrMqoYi2AFBUUwuwXcuehW0PfmlmThQ5q/M8P8Ao3jUXA81x7TLtih4hMwsiGWVbphX7+QN0ESue6Lrcg88qWY+hL+vNhwnaBdDanKdlA9GmDm2U5dDH11WErano4xVk9SxLglmyeY0/vMwx9BKn+FputRRLwpgRislYoxATqNtij6tVodRun2wfUZ+4mmnZlFtOdCxYkqa2KgcEp3V/4R+z+H+lle4HAU4CWyd0oGRSl9JO1WDvnf3+WwsOu+zL2MeLlddRyRAoL5UmfTrM0J8b3QGLfNl6SAOJoo5HAXgJFyQXUbyopKUsfhd4vee3BZILi1hAn6KRbzSTXLx/G8MfEkh4GJcnmrnYcC0s/C9xkxlKZUBuJ5zQSoOsa7qGq7lCo2035FuPasVUdQaYaY2y452MGaTew==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB9829.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 L6TWAvFnxtbVW14B1/pZMVRaO+YqXoPzIXaUQPP5eXG1K7vyM6LaY+UTxjN1yHyNsGSuzE2YgrFHJOPQK1fGX/k4OZFPGbVSLkfMkIjypD6o2kKUOwCR9Vzb9sDFOxsqDqn1uSFZ5smMmQjubvhb26AH1j9eDhzyJeQRwDtoXD1xQwV6eWP0ykrreykxY/aRh38QAehumV/jM/S3Bt9g0tXChv3+NvryBSIxc+FEWBNPqfMC4AJ4xmGfSiMgqgCsX8oglj1sMxXQ2VFM6b/6frpnwchDj03vDH4RIBu9hsBGZBqOCSp4dvRWLFGMSX/PJtjAfdRYLa12SRpBwasCgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB492128
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	861db1f4-4184-4e1f-7f6d-08defee2aeaa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|14060799003|35042699022|82310400026|1800799024|376014|36860700016|921020|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EvSZlITc5IFY+6z0c9fLNtcPUh8STvRiEV0iJBKDs4KdkWeGc6qpRzGOxXItZIAfVr7p3aX6jVXbQY9OVcVyxvumpUk0mf1hHEKnL/mOrio7cBH3Ib6WHJTlyLrSMhJpDk9Zvp57GZZ6Kbv5PNXUOvJ6A6muUnMEMiu9Vc7HpjbmRVCMMn94XD+HcOl6hoV03ew/TjgmRcSxE++skH5TpDRY2jXmkp2cC5ztdHcWWbyOWh6UoMoX/NZ49UKXnTjR/QIMSBZyHVoU25A308SuHORfywyrNQff53qLKP2NGBTrP07e9Sa25AjtFU2y4joZqMa7/nuJpkHy+6KnUMSYmYXiDZ2yd2nSAYDJZBKewnh3ucDpEtrHIHutJ4OyPhnipIw6NAUZdO60tZN6/uH6S0KLA+56/NKX1A2AQ7AjZhO7Hs8D7DUvWETXVMnlnP6d+2eNbaIgyHa7duXcUOpUrI+HostThpc8CSeVg8aIayPpOcu5RRQq3c2wV3///aBLoPJI4NpCAe3onNldRtobxNO8p+oEIVdNdmBWYsABCrGnbllqrUmi7d9VKB5J/YtZz4zglpDR3NA5ewSx8EDXDZL0PrLanUs4GnqVt0k8WxShr//5DFHS4hcXs6eCUbOGGq96XSJ2wvCr/kkizqcqwKs3KpcRUKygHY9vqoY3PzDdh51zPAA1oBpuWa4o86Jg0Nx9oi5HZ909J4ZuNMidqGvanVAGKfNlsQ93RlHRRx23LveH9Z+K7XspDd1lhj5P
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(14060799003)(35042699022)(82310400026)(1800799024)(376014)(36860700016)(921020)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	54QyhI86edKVZ6gpeQxtfsR3szv1FlNGloMI1wPCDAOk1lQDsZ4wOI8hPiNlneMXqOkLxAa2k3exea3d9EU0ax0Mm1qgdVngvzRgV2b5RnKA2Qm5w05DVzg7XPv3A6ww+b06z63HXX3OONUC04NVuTzknhKLC4l5+TrJ+6+ptwZqcrj68o6yeGwoRpwyeEMFNuSYcAGUzEL0QUTcwJXizirT+TYQgGSEjlDVCTV/9ptfz0W1NyDDCIIGtZiAiEJ5pXqGmIWGs+wLY2CzDpe1bwibmROeGqs4kPyPLiXOZCaZNuAFr5H8zSr6ADOTUo+AFx5Lj3Op41cSa1fvCnBOlvZIeffBdZH2Kbj15N37M4Mr294w8c6uSNzCPtkK8RPFYAHZwahkz7VDxmNX9v0uuLqOdqbVBzput+EZ/p/RHnGuVHXMFuOp+Qjo16D2Aa/2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 17:45:00.0517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f05d67c-226e-4f51-210b-08defee2c1d9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9097

> FWIW X86 Maintaners and Rick, I structured this so you can just pull the bug fixes only
> (up to but not including commit "x86/shstk: support via prctl") if you have concerns
> on the other patches for me to address, this will allow you to take the bug fixes
> and additional test now if desired.

Nack'ing again, Shashiko has valid concerns and some minor nits in the 
commits.
Sorry for the spam, just realized I can get this bot running locally I 
believe via
https://github.com/sashiko-dev/sashiko

Maybe that will help someone as we battle the era of bots.

Thanks

