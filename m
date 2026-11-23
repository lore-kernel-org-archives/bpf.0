Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795463166;
	b=2wwlWNWiHT//ccLJT+XbBbA5w+MC3p/00zCPTA+rxkb8yFXJtz+TjzIu5qr68LNrGpes
	 fSgTgLlc1n7JIazVYYM+Rk3/r22Qyg6ajKCSugyA105kWJxUeis+gwkuKN4v0Ve27wRLG
	 ikGmazsgPx5OLJNeDiXYNciH5vcLatSnoJSw3g++sZHIfASROvUwOko037Ol5lav/X8UX
	 JSrM9lEnt9U+Ke8Oa1Yc1ZrmQsM7B48Q4j1kfP3rc3Vkqpo/GUjmGGLki0Z+thMcQ9Jji
	 lJHtegPaRTpbRjEbnswmhpD5W6kMJJD/09UM+Nf0tHZPA39c+KYR6VvvAu/18by7c9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463166;
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
	bh=4O7Yh56fKh/q6/tnTMLnj/3/E0wZbOBEq8RccLPoCDk=;
	b=5pYD/mvPZN/PDApa2Ys9qpkbSCY+/ZYJa/GL66WDAMJ3TzxzFJE8Xah/8v8QjqmfAIUa
	 46Zdbx9LJVUrp8/zaUUAQrFqh1VrpJ+ikVAglfws/bFbj/hgybfP/6ZxgWK1WG6MRC14t
	 H54Ghg/n/ZsYAftGbAEzRsgVNakD93UBHj1R5baqJ2nURYBrcGBq5pNu8Mz4mRn+leth5
	 gC+E6peuykDJmvq5Y0UkKEXyUQpRw/OfBSBk+HvHLWUP88pmeKJZKbJbNveVJJsnurZp5
	 8FFJYLUJNMOb2jtf6oMZ2851wJormyoZur2FTX0eGzmnwqfS2ASWjDghq+2faoJDgdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s15NEf91;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.46
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFE606A31A;
	Mon, 23 Nov 2026 19:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DEFE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s15NEf91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e00IKdXZWR1AsIXgMaktZ1jbLyT9HnFAJklFyyeXQ8xjPwku7mM4ZdxbBL8UMDWLBvhIqDsrVxJ9RfS//nZsbQSVDQV+34kOeH8l4GkAGOA70ngdpxvA1dPm4ueDYpMEXP7xNwHNxNu5IV0AI2JK9hQLE18fTv4pjr7FgcNLLKzvB+B51xZ5f9iERq+HnAJxXmKgPABW3lghvzIkCQK9njH9pKE/fqwtsqu2IOudlgqb7YaMJRyXcIujRAnb8j+Z4EerTF57UTZg0L8IrNXUTzA9CXO0u72nmqFIRHEv76LGB91b+2f/BYqiRN/hUUVibAKiG4cYXsQJuE0Zo+h14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O7Yh56fKh/q6/tnTMLnj/3/E0wZbOBEq8RccLPoCDk=;
 b=aTOwDwso9jKNhhrK85ZLRARXz2UHIvVx7wBX6fCKXTsxFk33JrfL0B7QbQFlAWRefo7eyxiIizTiYZ3a0tzTOsvItBFqtebT2sts5c/d9SV9xDVlF0JlM1V+jp2mtk0hoLBu0mMZXeGUMD/o9nui0BU3BIH2uiqjyc8vn2ILpt+N54dv1w9DGrZTmLnOpDRiuug36udrJ1kpOxN1hs6VEheHvLg5A1fYh4OBRdDfCIC/Rq3fXjjjfjNmPFomShpOuS41OtWmCcKmty59YcPcHCABY3FxCO2WuhIgVQCNXSWMvzmkm4CanpL4wonCrzyBLSnqb4bO7JuBeUDRglpw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O7Yh56fKh/q6/tnTMLnj/3/E0wZbOBEq8RccLPoCDk=;
 b=s15NEf91BZ5yKdybAh8Ast2EVOoYiEAOaA74PLhz/e7MsvDzBuKIXzcRlPZ1OCjdEr+lszDD9BCcoGgzKU5s5VtYdISQgHKN4LkP9rLx0rxfOU/FAW7h3ERxmL8vRmRNh6og6FkqKuzcceyinx7+XZQ48//s/w4RrPKZ156Cg/ETCTj8dl3L8El6mSev4IFWkOTDn+rngoefQ+UwrOZcpJZbdzp6hHnbbMMQ6TFMeWgOJDWFP3EqhmqgJ2+kqmHIUypAuFgCGvgMACQhkHVIyUoJkUJhuQgfCnUmFrjfXGxexKnyST9FWRhY+ZVECIAojBJXQKSW4dU/39oq1VpCGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by SA0PR12MB4352.namprd12.prod.outlook.com
 (2603:10b6:806:9c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 19:45:59 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 19:45:58 +0000
Message-ID: <9e4c9d14-f653-4f49-a9ed-f423d2b96976@nvidia.com>
Date: Mon, 23 Nov 2026 20:45:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/9] eth: mlx5e: drop the now-dead HW-GRO and
 LRO vs XDP handling
To: netdev-bot+sashiko@kernel.org, kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org, nktgrg@google.com
References: <20261122010112.1471146-7-kuba@kernel.org>
 <179539763134.3135.16178645255065325636@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <179539763134.3135.16178645255065325636@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f748ac-c693-40ef-72a2-08df499a6590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|4143699003|5023799004|11063799006|56012099006|261021135927099003|261021121427099003|261026140227099003|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261022075727099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TqClx0Jvkbz2TdRyIQE7CTN+EZyrGCrZPX8Uey1uotQWOixwnWlJqW2dvRGIMr8M67ZtBSCdmtds9KaxJsyI9jXgkq2ylq8o6xdb4YadQBxHiz9kyNJ+qlg5DHO7UWlU38bW4IFHyIyCKQ/Cxw7pI45reBdPVyJXuCRS+Wr8FDbTgymFzFIVZ3iK/3aTrNvuK3DKYld6lkVW5jWjm+6wEfuD8bEIbJlDWCnCcJIXoooAh+l6NRuSvXxu3hX6Zi8Zynk8acbh1q1ylHamjvBE9ze0n2WbW8ZPtWixHSSSTV4gVcJP7meB9Udsb2VIzYdKmWROqpxd2zMDJvriTksRp3gT9DX/LBEXjOUZVCyH5E4yu2tVgtVj1rWNUCxLAtZ8Bq5b54H2XC0YdA+I+nVck1w1PmTUww3+APuClH51D2Ttw89SFt9dje6JnDZluHA2WtErTwrS9KMRNx94nuM37utTpfS35oJ8nDfcxvKV7LQP9I24+/D8pAnEQ/5uWt6PGDm/Ar0gtIdmt04x00kpH4euMyFum1efh8ANzOOU/0PqePJa+TxFNC/mgBbEu9oXisjH+VwbolDnmTPKTybzlAwyZwHsqWXuvkfQ6QPl1qhBxma2D+iZi517TQqOOaHN2zfWRDcgjTCe+RFFKOSzrSbEDGeC7KUah0fajkcIJMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261026140227099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHdwS0pmdmVyMHMrZXRsM1RTcEpTOThoSHhWczRPdEpVbE5wRDFtSWtnS01X?=
 =?utf-8?B?ODdRZ2tJOHBRTDlyNFhQenBUUVpvb0NUNk1Gd0tKeEVXVDh0UXdoaUNjOGF0?=
 =?utf-8?B?YjE2eEVnS2FoSnJueEErWEUxdEZobm5hKzVxRW1oSy9rblY3Z2swY1pVRDA5?=
 =?utf-8?B?dDc1Vm5oWStVRVIreWNzYktkZ2cwcU1BTW43eDF3K0lWUk9GNmxmTDkrY2Fh?=
 =?utf-8?B?cTlPS081VGxCNXd5d3pEZ2x4aEgwMWhUVWtsN0QxaDlMT1M3SnhlRFNVUHY4?=
 =?utf-8?B?SWptZWtIYTZyMVBhSkJXRXIvOTRUajh1ZTFUZkNCZ2R1QWIzZlhldmdNV2NE?=
 =?utf-8?B?QXU1M05FRFdqSzVxRDhFb0JielpRNkRBM3QwT0ZTbnUwenFXdW01MThkYklm?=
 =?utf-8?B?ekU2MVgxcGhabk1rL1JYVERPWXFjRXZzOW1lQWpiRjhFalZKWEtYQXZWd3F4?=
 =?utf-8?B?NGdSNitEeEVpZ1ZpcGpQTjBjdWJmQXlzaWczTXczNDV0anAzcEdZbjZmZWZR?=
 =?utf-8?B?bnhpQms4cEtCMzc0eWwzdXluTVVTL1p4OFZlcWdqaStET3JMT1RtVzNEVDRF?=
 =?utf-8?B?NVFiYU5GZHdCZlZpZDU0Rml2ck9PdjZyU2NKbm9mV1VOTWRBNS93QlhXMVJE?=
 =?utf-8?B?bTd2L0h5T1J1ZUlUUXlwZ0wvR1BKZ2hZMzJsS2hobHZxTi9TWWpyeTlkK1ZS?=
 =?utf-8?B?dWhPSWNrTlVuUmUxanpCSzVkVmRoQkVGWXkrZ2ZuTFZDU0syUnNLODVpK1cz?=
 =?utf-8?B?REZlZ01hSldYU29TVEJqaXUwVUF1N0xTM1gxeTgzdjAvc0hHMWNlT201NlBC?=
 =?utf-8?B?dm5LdytuMnVVUExYUHRIWStPbkFQMkFiNDVXSkRMQVVvbkY3dXE2ZWMyWFJO?=
 =?utf-8?B?RCtaTzVTejRvMFpkUVgwYU1jaU5hcWJ6VlBGTDhKWWdTN0d4Zm5Ud3ZEWnE2?=
 =?utf-8?B?dUF5bWxvMWxFWHVvd3oxNTlqTEp5TFZBTHVhdGhXcFBNM0ZJVkpPbTZhd2Z2?=
 =?utf-8?B?UHBoT2tRd2xpL3I1K3lrSm1IckJNbkgzdldlc1NNQWFOdS8za2o0bTN0WGNJ?=
 =?utf-8?B?azJmcU1ST1lueXBqSkZSUFgwMnllKzdTbmwwcmM1b2EvUVkwWmJ1M2V0ZDAr?=
 =?utf-8?B?MWdDK21BY0dTa3IrK010SWtDTUU0Wm1Xa1RmdzBhcXdXdUc3d0dyTmlDR21Y?=
 =?utf-8?B?cHBiSVd3cXluNVdVZERDQ1ZNK2dsMDVLUEQzdjFlQ2M2djQ4THBtR0c2cFhj?=
 =?utf-8?B?SXFWdFFUOUZIN0lGQzBrMFc1a2RoVUNneGZMWXlBSnpBZjdZVXBDZXRib3ZC?=
 =?utf-8?B?VVYyYmhGdGQzRmsyNVV6ZGNtTkNRbEJUcU1aNEZMcG81clJ1dDY5TXlLeVVa?=
 =?utf-8?B?QWFubWJjYmJPOU9rWjcyWlp2SVIraFFIa1AyMEpuMnRlZUdaT3Z0QmZxT21z?=
 =?utf-8?B?Z3NMRWJTaGFzMXhzYWhsMXFyRVZrVmptaDhpTXNTQTdBaEU5cTNXNzAvdjFO?=
 =?utf-8?B?dTZ6azd2OVhTL2VxdElnQlh5NkZQSHJ6WjlUZnZuRzFYN0ROSnAxbThKQWpv?=
 =?utf-8?B?T1JWR0dmelUrN0JFdElxM2pKQWFlS1p6ZEQ5T2ZxNEpwdCtQMDJaL2IzODBN?=
 =?utf-8?B?dmRBUU9TTS83WUwwNmZ4VUlIRFZZR0dnYmtZcnpxNEFNbFZpaEI4NmVGNjJ2?=
 =?utf-8?B?ZmdwQ0ZxSTZsbE9Lam8xMzVVWUJYbE9XSjN2N1JibFNtZnNiN0JoOXA4cDNQ?=
 =?utf-8?B?UCtrQ0kxNEFITmdVSVlJUXpRSWp0RzhJTlZJNXpraEh2eTV3T3BiQ05UN3FE?=
 =?utf-8?B?MFlLSzFhNWpDdzFpUVl5UjJtaU01RFlpTUl3dC9zREdxUnJpVWQ4NmRLMmZr?=
 =?utf-8?B?bUxUWmNJRi9ScXlGY1VIWmhybHZ3QWE1NkxWVmo3MEJhNVd0bk9ZaG54aHpP?=
 =?utf-8?B?K2Z6WWJGSFhHSlNlOHZUd1BYdXB2NXFTajFMejZLYTF3T3lPZGFzOExvdk5v?=
 =?utf-8?B?RDVzblpTeG0vYjh0NkVtajNmL1VQaTA2c3hHKzBSb0NFMlNjOWtucVAxalhz?=
 =?utf-8?B?Tk1PaW40S3pBekF5RnVrMHpwVXZXK1ZkL3RyQ1lvbE5aSEM1TWM0bmR4ckhr?=
 =?utf-8?B?WCtOUmN0R011YzdYUFNiL2RUKzZqMXZhY3VsOEFZb3ZPM0ZvL0g0M3BnT0tG?=
 =?utf-8?B?dXI2bDVUTS9XYUlSUEZsUDhBblNISGs4aTBwanlTVDNoMUpiVUR2R3JSejlH?=
 =?utf-8?B?enhyR2F2enFzcDhVSDY3YUM4UER1V3hZTWNTVlk3dWNTdkpNRFBTYUNXanVI?=
 =?utf-8?B?enVzdnRwKzB0KzJDTm9mYzNYUGd1RHUyWHN6LzBHNGhQUFNFbDlvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f748ac-c693-40ef-72a2-08df499a6590
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 19:45:58.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2eYQvo2vRHNeuV/xZgFl0LqYo/giekyXyOego3PUYDLAtpTdKeOsOW5/HTaDBIebQhCDpJlbMp1fIWKOk1kmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352

On 23.11.26 02:33, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch removes mlx5e's own HW-GRO/LRO vs XDP handling.
> - [Medium] The patch keys the whole NETDEV_XDP_ACT_XSK set
>   (BASIC|REDIRECT|XSK_ZEROCOPY, plus RX_SG) in mlx5e_set_xdp_feature()…
> - [Medium] mlx5e_set_xdp_feature() now dereferences
>   priv->netdev->cfg_pending->hds_config.
> 
> --
> 
> eth: mlx5e: drop the now-dead HW-GRO and LRO vs XDP handling
> 
> This patch removes the mlx5e driver-side refusal of an XDP attach while
> HW-GRO or LRO is on. It also removes the XDP clause in mlx5e_fix_features()
> and relies on the core to clear those features and keep them off while a
> program is attached. XDP features are now advertised based on
> tcp-data-split rather than packet merge, and mlx5e_set_ringparam()
> refreshes them when hds changes.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 06a8a4be4be7c..08568137d044d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -4487,12 +4487,14 @@ static int mlx5e_handle_feature(struct net_device *netdev,
>>  
>>  void mlx5e_set_xdp_feature(struct mlx5e_priv *priv)
>>  {
>> +	struct netdev_config *cfg = priv->netdev->cfg_pending;
> 
> [Severity: Medium]
> Is it safe to dereference netdev->cfg_pending here without the netdev
> instance lock?
> 
> Two callers run mlx5e_set_xdp_feature() on a registered netdev with only
> rtnl_lock held: mlx5e_nic_init() and mlx5e_build_rep_params(). Both follow
> this pattern:
> 
> 	if (take_rtnl)
> 		rtnl_lock();
> 
> 	/* update XDP supported features */
> 	mlx5e_set_xdp_feature(priv);
> 
> 	if (take_rtnl)
> 		rtnl_unlock();
> 
> Both callers are reachable from mlx5e_netdev_change_profile() during
> eswitch mode changes.
> 
> ethnl_default_set_doit() allocates, swaps and frees cfg_pending while
> holding only the instance lock. It does this for the commands mlx5e does
> not opt in to rtnl, such as COALESCE_SET, PAUSE_SET, RSS_SET and
> LINKMODES_SET:
> 
> 	ret = netdev_reconfig_start(dev);
> 	...
> out_free_cfg:
> 	__netdev_free_config(dev->cfg_pending);
> 	dev->cfg_pending = dev->cfg;
> 
> Could the following interleaving read freed memory?
> 
> CPU1 (COALESCE_SET, instance lock)
>     dev->cfg_pending = P;               /* fresh copy */
> 
> CPU0 (profile change, rtnl only)
>     cfg = netdev->cfg_pending;          /* P */
> 
> CPU1
>     __netdev_free_config(P);
>     dev->cfg_pending = dev->cfg;
> 
> CPU0
>     cfg->hds_config                     /* reads freed P */
> 
> Reading dev->cfg instead doesn't look safe either. On a successful SET,
> the old dev->cfg is swapped into the pending slot and then freed.
> 
> Would taking netdev_lock() after rtnl_lock() around these calls work here?
> That is the same order mlx5e_nic_enable() uses.
> 
>>  	struct mlx5e_params *params = &priv->channels.params;
>>  	struct net_device *netdev = priv->netdev;
>>  	xdp_features_t val = 0;
>>  
>> +	/* XDP can't run with HW-GRO, and tcp-data-split keeps HW-GRO on */
>>  	if (netdev->netdev_ops->ndo_bpf &&
>> -	    params->packet_merge.type == MLX5E_PACKET_MERGE_NONE)
>> +	    cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED)
>>  		val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>>  		      NETDEV_XDP_ACT_XSK_ZEROCOPY |
>>  		      NETDEV_XDP_ACT_RX_SG;
> 
> [Severity: Medium]
> Does keying these bits off hds_config also change how AF_XDP zero-copy
> bind behaves?
> 
> Together, BASIC, REDIRECT and XSK_ZEROCOPY make up NETDEV_XDP_ACT_XSK, and
> xp_assign_dev() checks that set before it allows a zero-copy bind:
> 
> net/xdp/xsk_buff_pool.c:xp_assign_dev() {
> 	...
> 	if ((netdev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
> 		err = -EOPNOTSUPP;
> 		goto err_unreg_pool;
> 	}
> 	...
> }
> 
> Before this patch, a zero-copy bind on mlx5e with LRO or HW-GRO on was
> refused, or fell back to copy mode. Now it reaches this path:
> 
> ndo_bpf(XDP_SETUP_XSK_POOL)
>   mlx5e_xsk_setup_pool()
>     mlx5e_xsk_enable_locked()
> 
> mlx5e_xsk_enable_locked() registers the pool and bumps priv->xsk.refcnt
> without checking packet_merge.
> 
> Nothing on that path calls netdev_update_features(), and
> dev_xdp_clear_rx_agg() only runs for XDP_SETUP_PROG. So the commit message
> says "The AF_XDP check stays", but the priv->xsk.refcnt clause in
> mlx5e_fix_features() is not applied at bind time. LRO or HW-GRO stays on
> while an XSK pool is bound.
> 
> This also seems to open a sequence that was unreachable before:
> 
> 1. Bind a zero-copy XSK with HW-GRO on and tcp-data-split=auto.
> 2. Set tcp-data-split=enabled. mlx5e_ethtool_set_tcp_data_split() accepts
>    it because GRO_HW is still in dev->features.
> 3. mlx5e_fix_features() clears GRO_HW in the XSK clause, then the HDS
>    clause forces it back on.
> 4. mlx5e_set_ringparam() calls mlx5e_set_xdp_feature(), which withdraws
>    XSK_ZEROCOPY while a zero-copy pool is still bound.
> 
> The commit message only describes the XDP attach change ("used to fail
> with -EINVAL and now succeeds"). Should the AF_XDP zero-copy bind change
> be handled here, or at least described?
> 
> [ ... ]
> 
>> @@ -4604,17 +4606,6 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
>>  		}
>>  	}
>>  
>> -	if (params->xdp_prog) {
>> -		if (features & NETIF_F_LRO) {
>> -			netdev_warn(netdev, "LRO is incompatible with XDP\n");
>> -			features &= ~NETIF_F_LRO;
>> -		}
>> -		if (features & NETIF_F_GRO_HW) {
>> -			netdev_warn(netdev, "HW GRO is incompatible with XDP\n");
>> -			features &= ~NETIF_F_GRO_HW;
>> -		}
>> -	}
>> -
> 
> [Severity: High]
> On mlx5e, does the core really keep HW-GRO off for as long as a program is
> attached?
> 
> __netdev_update_features() strips NETIF_F_XDP_DISABLES only before it calls
> ndo_fix_features, and doesn't check again afterwards:
> 
> net/core/dev.c:__netdev_update_features() {
> 	...
> 	if ((features & NETIF_F_XDP_DISABLES) && dev_xdp_prog_count(dev)) {
> 		netdev_dbg(dev, "Dropping HW-GRO and LRO features since XDP is attached.\n");
> 		features &= ~NETIF_F_XDP_DISABLES;
> 	}
> 
> 	if (dev->netdev_ops->ndo_fix_features)
> 		features = dev->netdev_ops->ndo_fix_features(dev, features);
> 	...
> }
> 
> Later, mlx5e_fix_features() adds GRO_HW back unconditionally for HDS:
> 
> 	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> 	    !(features & NETIF_F_GRO_HW)) {
> 		...
> 		features |= NETIF_F_GRO_HW;
> 	}
> 
> Can this sequence leave SHAMPO active with an XDP program attached?
> 
> 1. Enable HW-GRO and tcp-data-split.
> 2. Run ethtool -K <dev> rx-fcs on (or rx off). netdev_fix_features() drops
>    GRO_HW after the driver hook, and set_feature_hw_gro(false) sets
>    packet_merge to NONE. hds_config stays ENABLED.
> 3. Attach a multi-buffer native XDP program. dev_xdp_install() only
>    refuses hds for !xdp_has_frags, and dev_xdp_clear_rx_agg() sees no
>    GRO_HW or LRO. mlx5e_xdp_set() now only calls
>    mlx5e_params_validate_xdp().
> 4. Run ethtool -K <dev> rx-fcs off. The core strips GRO_HW, then
>    mlx5e_fix_features() forces it back for HDS, and netdev_fix_features()
>    no longer drops it. mlx5e_set_features()->set_feature_hw_gro(true)
>    then switches packet_merge to SHAMPO with params.xdp_prog set.
> 
> With SHAMPO, the RQs use mlx5e_handle_rx_cqe_mpwrq_shampo(). Header-split
> packets go through mlx5e_skb_from_cqe_shampo(), which never runs
> rq->xdp_prog, so that traffic would skip the attached program.
> 
> The removed xdp clause had the same ordering problem, because it ran
> before the HDS clause. However, this patch removes the driver-side
> handling on the basis of the core guarantee, and the gap still seems to
> be there at the end of the series.
> 
> Is anything on this path meant to reject SHAMPO while an XDP program is
> attached?
> 
> [ ... ]
> 
Most of these issues are coming from accessing hds_config in
mlx5e_set_xdp_feature() which is called in several places.

Why not drop the hds check in mlx5e_set_xdp_feature() for
packet merge / hds and simply reject the XDP program installation
in mlx5e_xdp_set() when netdev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED?

Thanks,
Dragos
