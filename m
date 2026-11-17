Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794921710;
	b=CxajiCpxNj2eZ8BMuWXQFz9+gbWp77crzAn2q+PDwkhrX6ncvKgNMIJXIQgOUfVX8pDB
	 qbe6nbh1m8z8GJxk8NKlyNYFuuXVORo+DUmpVuoesmAmiRW+W8dlt5C4DXQ/L/towOxr2
	 w981FBB9H7CvP+ma5VErxTfo0d+xUVtq6TQZ9fJC1YZNmLNPOdJf0v10oND+/ZidKgfgQ
	 Xq5Dvfrpijo9o9ySN9/fofPkcjR/opp6ni/TPvqakTTs3oBbX2XAQJo62jMfo841Fm19a
	 HmL1smBOVqd64t8p+FPvk/I2KOBeK7jezKH9jU7GNitwoIhGvYvxcuJkpdbrAQQ7Y+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921710;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GGyFE5sVF+SgwZiMhtRoMLBV1bstRUW/abu3cH5hqmk=;
	b=diOzNU3jM0uZyH7GDl7pt/lKAY8YAgwPnVqJsHpD4MQbkOy1xriQksXPP3w2+lnpf4X6
	 0lqQiYM9dUafD7+XcX3dd7pA5RdQfUUqTaX0B2XGLvv8lD+9vvEMooDhB4fvnsw8s9B9R
	 IvGA+gp+QUr+FkT4EsUEMN1d8F43t5AWQ3JVCoTnjDCcek3qIHOAl5tzo1u2O9MZfHLVz
	 abUzGqHpFK5joJC5PmLk1tYNC8AiTwgSk/Pg5rN8w5/Wv0lBz68+wUQN24kRP8cs8Z2EX
	 ibnLjZYD/ZhPZNkvUEGDeELdJsCfigLBbBGBW56emoS36ZxWSWwb18pMWro3Ooy9ABA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	dkim=pass header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=DctW+dZA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.9
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7F606A323;
	Tue, 17 Nov 2026 13:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD7F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=DctW+dZA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2cn+a23ns7DJ4s40KSGOcaDCpwx+VmPCbiV1ZNMxsKYLMZfOkcyVx178AA20xPy0k5gX/mAM/p9jFy4ufGoRYW2Vmu2kk2NlOhQVVqPOP1S7TTe4kiG/izjsDRbQg2QTcoaYSDchtPNew3hqGC1oF2k3m90mhy0Nt0k/3YQRqsOjDLZqp9fuZwLlz8FMJcVi8ndbYH91R1tDF+fnOB+m0djl9euHGeyFDNOOqQzplnMyLeLMgIIBpn+iwO2sOLKqDkMk9aRgZlHKJd1+mTYK+Woj/fkhEZG64Rm/tFdWdIZVeNrlAuDZYXos1Fyg23BfhjfaVFAjL3C3Kzgx4hMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGyFE5sVF+SgwZiMhtRoMLBV1bstRUW/abu3cH5hqmk=;
 b=hIXsWZ1gRzLeeS+HjNNMx0T73bnsjKuT/u2XrMsCphRY21K4v07kOVPP6YWOqM/k82zSaQE3Zbl0ScZruQuFDrGb0ATBTTDCOobv1hSLOu2EfDBviXa6Sg2KO3oQmMy3eHxJjVp44oYqpAKtj55wn2vqO7/PyoliSoOM2Jv4uCUtSkVHV903dSP1PIEkU8FqK+X85FeWIv77j9dVxvsF/ZetPIafvq1R2jSgQxOozSFw8IbYBB/aD/1VepF4iQ6zvMiNZ4daN/EpsRtol6D/w9YMc0OZZ7MlzJRtjdNn3h0SMbTT4X2mKO5Ef2Md9zvrLo/pV2JtEeDO9Fic4BbRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGyFE5sVF+SgwZiMhtRoMLBV1bstRUW/abu3cH5hqmk=;
 b=DctW+dZAPUMnVpv5Vfba58xFsgUrKgudlBhtupBhcf7mOyA88b9MlesutOp0Y/mKPNSvjC/bem6YRdIaal+efRif7W4F7B022rOR86/cOOB011R/4Hoq8dhdRKnQvxiL8c+T84QvKURrvr4h5dvg3UmsLRu9F3hizhFdY1QlJak=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by AM7PR09MB3749.eurprd09.prod.outlook.com
 (2603:10a6:20b:108::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:21:43 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:21:43 +0000
Message-ID: <cf698431-8660-4dfd-8062-c54fc710c25a@mobileye.com>
Date: Tue, 17 Nov 2026 15:21:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] riscv: build kernel atomics from LR/SC when Zaamo
 is disabled
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Chao-ying Fu <chao-ying.fu@globalfoundries.com>,
 Conor Dooley <conor.dooley@microchip.com>, torvalds@linux-foundation.org,
 olof@lixom.net, aleksa.paunovic@htecgroup.com, arikalo@gmail.com,
 Boqun Feng <boqun@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>,
 Charlie Jenkins <thecharlesjenkins@gmail.com>, Nam Cao
 <namcao@linutronix.de>, rust-for-linux@vger.kernel.org
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
 <20261110-lrsc-only-v6-2-bafc3cc0fcae@mobileye.com>
 <20261110-revivable-saint-9bcfaa2fd0e7@spud>
 <3308062b-9d0f-436f-a22a-217cc1c59aed@mobileye.com>
 <20261116-manifesto-edginess-7f1663f9a76b@spud>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <20261116-manifesto-edginess-7f1663f9a76b@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|AM7PR09MB3749:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa92227-22b9-4e13-eae7-08df44adb8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gUmEIBPoBgQ9u/qbozAL6OXPQ24JZCnHfU6WfS5RNOxy4sV1wE2iKu+xBCzwxXpuCsdUhEGclidRqPPe/pAMCMW5/sBOBjlgr2SIj1WAjeVdoMStkwmzYrWAfCyoFvLCCAcEEIP+/70yLUHz+V3VWUuCKr4lDpwA3v4qSK29eTaYBZg7KplZoTeGtFAsMDnRAfoFX1yDxl2/81WZa1QLpxl+ZshEUQs8nmlMNZQwvNu4aLxYvDhFZFk6CsUUVPhuYvFAczR/MF8XfFE3vXYIuIV3z0mH0eeAd0CuR+qn9I+1HwKCyAi0xv1WnGKG4ClJBVHme20OU0lBVOJ9Z2RAQ3ydBTy8MON3hWRVJssA7fvJxvN7JIZSWX8oQsTnbIAkhUOlVY1OLEO7nekpmRU1+w/rLKbWJaD5M0aUymofE2ihS5OvDpWqdhmjaylRPuvocNSCJR/pNKPkFLdjNJsX8SWmYuz1BTkjYHKQ4QxsD8AvbrjLvsIw9f6Jft6rmVclgOBSreXk701AeDhuaYLf7BTV93ZvrpE/Zxv28t3v7iRrOTElVpNbt++JlBkA6e5ZWgjcMRPBnzQLqtn8et8Fc0I3EQSFgGfet6rUCUj8krI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDFQekx2NytrTTN0WnFKOEZXNzJjTGkvcThYRFVkV1ZZbUFYa2syWnNDdXNz?=
 =?utf-8?B?cnJiK3Y5Tkd2UWdXeTBuZWZLRFk2c29RcmdscHNiR3M2WDNtTjV3WWNWS3pB?=
 =?utf-8?B?MjhvTHF0Y3d0U2NNOW9QbmhvZ2tQTU5Ib2hFOFB0RmhCaFc0N1UrcWlNKzhw?=
 =?utf-8?B?ZWdYRnFwdHErRjFYc2Zhayt0Yk9KellqSlhvVEZnSWtNaXcyRVgzbDhxSHNp?=
 =?utf-8?B?NG9TUjJhUWo1WWY5dks5QXltbDloaHZKdTVDb2IxaVJGMS9MSENoTTZ3NVY4?=
 =?utf-8?B?c20vWHozMFRoNUI4eDlFOUh0dXFpRnpSSVhKU1h3TGU0Y3BscFV5Q01SZUYz?=
 =?utf-8?B?d3JESzNiL0ZYR0djeGdmWjc2Ni95aEFXTjI0TVpvU0RPMGNvZHRpUW9CZDkz?=
 =?utf-8?B?STZ3emllSDU3YkxrSGFkc1dWR0Vsa3ZWVmx2b3pQbDA4K2FSNEhZTkZUNEtD?=
 =?utf-8?B?bFM3MFNsemZtS1hFakNjM0FDQlZEdm0rdWZ5MUo5U1JPcmxYeituUDI4TTI0?=
 =?utf-8?B?eHBrY2ZPUFR2SEVtZzYzTGhYVGhZakw0VjJ0clV0ZjZOYkQvTjltQ3U4SGZu?=
 =?utf-8?B?dVNyUHB4SEF3NTYyVnpVM3NKdWg4K1AyKy96MHNIQ2pHcGd3SHhOQkxzbkFU?=
 =?utf-8?B?aEpYS0orWEc1Ym1Hanh6c3RPMG1GUittSWdSV2ExQlZGa09NbWVzMTl5ZHhM?=
 =?utf-8?B?UzErdkJvUm1tYVF0eHJ3Nm8yRktmcWZlV2I3TlFWTklGV29xMXA0NWIrR3ZE?=
 =?utf-8?B?TXkxVmJqRnZsU0tFQnBrbUNUc3NFWEQ1eHp0N2x3UlhXdmlSOURwZmk1MGRD?=
 =?utf-8?B?RVBob0d6TCtDYzRDeUhLSTZqcjlOYzdVWkJCMXE1OURPT3A5SVRwSjFqaWlN?=
 =?utf-8?B?RURnZGhEbVlJeG1haWtPUWdpa2g5cHU2VGZQK1E4N2N0Qi9sWUw4OFhUY2p3?=
 =?utf-8?B?ZFFXQnNXa2h1MlplSjhYU0lZUHBwQUd1aFRQMFFxYVdiaVAyV3RBOFUzU1RT?=
 =?utf-8?B?ZFZGN3B3Qit1SWNXQzJhUHFKZ3RZdEpiTndBKzlxS2g0VkcxRHhjS0ZkM1R4?=
 =?utf-8?B?dTNLVTNtZEluSk9pa3BBRTVpUXJ0TUJ2d3d3QW45enJtNkNQQlVKNWZkSXR3?=
 =?utf-8?B?K3VzOUR1WDJXczRhNHVneDhUQVVTQmQyTGVmZ0M5dXM3bUd0VElERnB3R0NK?=
 =?utf-8?B?Zzl2QjdCY0RqTUw2dHcxYmlNUVQzNFpNbFNTaFRlV0E4SERzSUE5b1lUZkVG?=
 =?utf-8?B?S01UcEVUUW8wa1lLQ3Vic0VvZTNOV050cDFMZENSTlBDNnk0eWZIZWgwbFpH?=
 =?utf-8?B?V2xERzVDamo1SEJ0MHkzdjE1OFdIVW15YVljZ1UrY05sMVlmMTJRRlBzbnY3?=
 =?utf-8?B?ZDJZcHJZNm4rdU9pQWk4TkhqSGcwUEpQU1hDbkEyM2lkdjZXVUNINGxQRVg0?=
 =?utf-8?B?TC8xa0ZGbnZDdmoxRkJtNDY3eCs5MmhoZnVpeXVnVlVxVS9CVlpqbzNOTmto?=
 =?utf-8?B?MnpDM0RiUHEvcjVoT2VSLy9rNFl4QlRuNVhKSFdEa1Z2SlJCdUFYL0dpZEox?=
 =?utf-8?B?TVVrUitRQkVNOTBmQ0kxV1BXV0RwdzFib2FXcEh4V0RSRGdrNDI3eWZDUDhC?=
 =?utf-8?B?RXVKc0tlSmdFSmx6U0F2Q2RCOUFRZE5Ud285MXpGZS9NamIrQW40eWF6M1Vt?=
 =?utf-8?B?NVlYeE5KN3RyKzI5NXhsdGcvNW00Qk1tWUV1NVFvOEJpWnA3QUpDeFpJOTFH?=
 =?utf-8?B?aTExSGRqOHAwaXB5WVpHSGlXeXVWKzdtRDNHMW1NVEtETDRObkl4M1BWSy9j?=
 =?utf-8?B?Sm1sMlhtbmRrZ0VJOG9xTXNKeUVrdS9scWVDSHlUVks4Q2t5bkRIcE0rTENC?=
 =?utf-8?B?TjNIQmQ0RnE3b1ZHQ3JzZTdxSGdFTk1oMFQ0OHFkbXVZMGlWbWsra3lQTHJk?=
 =?utf-8?B?WGR2eEdxSk1YQk5JbWluTm1GNGNGYWVDMjZKUHQyTzZXK2J6eURsVlBsU2cz?=
 =?utf-8?B?c0J5Tk1XVGdpOUhWNkVQTTdVWWRuUW1NcHdtZHVpcExuS1FmUEIwaTlpTzNi?=
 =?utf-8?B?VTNkN0xVSXFLR1BpSnhPcWFZMWFqcHB0VVRqZ0RTSUhTajRaRHBDU1hJY0tP?=
 =?utf-8?B?RzNDckF1cTdkVXM3S0lBdVpqeXluQ2FNM29wc1pwdHQvRUVmK2twT1o4SDhP?=
 =?utf-8?B?dm1vcTd2UjBUMXhaaFR5cWtPZkUraHM3QzVKYUhSUlY5bjBvSCtHVzdxVjlV?=
 =?utf-8?B?Nis5Y2cxeDZiaEMzTHQ5bitINEpicndGdXBXL21pTjhEY3hsK1h0UytUWDNu?=
 =?utf-8?B?R3pSVW9sWWlsejNjd0JGdXFLbG5iTVcrTEVpL2xSMldQbUpwMGlhUT09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa92227-22b9-4e13-eae7-08df44adb8cf
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:21:43.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnyiLZ/cUiCm+B6TpOuQm0eryN0B+/LpDcNYWelt7qmUdIlFLO/8JQFExbxMzcLYGUCueMd28L4UIhknm9hUmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3749

On 11/16/26 19:14, Conor Dooley wrote:
> On Wed, Nov 11, 2026 at 08:37:23AM +0200, Vladimir Kondratiev wrote:
>> On 11/10/26 21:02, Conor Dooley wrote:
>>> I had a quick glance at this revision, and I think you've at least tried
>>> to resolve the things I was pointing out. Did I miss something, or why
>>> have you kept the NAK after having resolved the things that I was
>>> objecting to?
>>
>> I'll be happy to remove it. Was not feeling right to do this without
>> your permission.
> 
> IMO, if you sort out what the NAK was complaining about, you can drop it
> without permission. Worth calling out in the cover maybe.

Sure, will mention in cover

> 
> I'll take another look at this later in the week..

I have v7 in preparation. Need to complete test cycle before sending it.
In order to save your time, these are changes planned.

    Changes in v7:
    - remove patch rejecting probes inside LR/SC block (was patch 1),
      submitted on its own
      Link:
https://patch.msgid.link/20261111-probes-in-lrsc-v1-1-4f99ddea5f68@mobileye.com
    - Drop Conor Dooley's Nacked-by from patch 1, as agreed on the v6
      thread.
    - hwprobe reports RISCV_HWPROBE_BASE_BEHAVIOR_IMA only when every
      selected hart has A, so a Zalrsc-only hart is not described as IMA
      (patch 2).
    - BPF JIT: the fetch and xchg LR/SC loops are fully ordered the way
      emit_cmpxchg() is, plain lr, sc.rl and a trailing fence rw,rw,
      instead of lr.aqrl/sc.aqrl (patch 4).
    - New patch 5: refresh the vDSO hwprobe data after the boot-time
      speed probes; fixes the stale MISALIGNED_*_PERF values in the vDSO
      since v7.3-rc1.
    - AMO speed probe: refresh the vDSO data when done, report a CPU
      without Zaamo as unsupported even with amo_speed= on the command
      line, and return 0 from the __setup() handler on a bad value
      (patch 6).

