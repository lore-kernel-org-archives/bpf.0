Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02F19D07E;
	Thu, 24 Sep 2026 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216251; cv=fail; b=Qyb0JObuaPE/1WNgZLCaJnY2O7ftV5uJNaLWyjf4oWwimrmzItCJgHzQ8oijwtNtNPRDn62/QrmdGCAq4DrZao6rjmMwMBrr98u8+14hv4TtqMhO+BwdOn3uowWH+HBhsJWpy4Z0nZVvJVpHbFGYGDtmUtHepxTG5v1aB5wWbTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216251; c=relaxed/simple;
	bh=BPES/plzgXyF+tpt+ng2MePFyb2/H1QT1UoOVNJaePg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwcMOINsGxWNQAwgrUHPOVvmWXTOGTPwwCIEo4zEtLb3PW98ic6PacbeXDV+rnuwYoUQp+HNzVZwRe+glSg6LxwK1iyuA/FS7FhyP/V4AdOLGnYWQgIedDGLAE4LR8PIZR12/KDpeE66QuKh8zBdsPxSMyqlrUJcD9TbyUrUzog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=aD+YZllJ; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="aD+YZllJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s56VKO62ljZpOQ9yVkf/Fc2G+AwZ3oArrIawWkXs5dmN8knUt79LfPBc5pDbpsafrDJd5O3fAWPIJeE9/o34fGEBFg1QNLbBor1ymmvU7NH6EJzi608K4Q39acqSjnmdL6F3MTiXLyPUmXpnnhUFA3DlDIhkURbcFgLvAAYvldByN+KWeNvEoigmQegftBgYkzAA0symK6NxG6eRC1uk+uWp2wzdsrE8DXfvIlsqEksqvvscrYY9VSWpMa5f9MwIOCz5Y4vMioTP7cS6cHvN4S07Ez/X6ND+EocrHKhc5xmIJpFLlLxluOI+18KVNon6quIoh+SLcbd9jmdR1UFdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX08ripU8vgAFUyYqjOV66FDETcJdOUp15JCpGumlm0=;
 b=Cn0cV8bWN+TDm3B3p4FJ5zQViFHu8iveBAc58JZZ3NMgdPiIZSn8ZcN2EmuTRTFCdhiEJD8ZBjJQMQCgrplNY9XAXcTkoWXA+joil69VDTlaRl8wjDe0Y/D7HCKRuf0Di2kG87t9wtGA4jxL7RET98HXx1JRp5C2Dpxa0zyrC/5x7tI3SLcT/2GhiCjYCSrTiApmULmXUQX1ewzA9ncla0AB/IH1EoJ1uAbAqNQPiJzV77x1JDVjXUl7K1TQxePAT8oohVn9qn5AAe1zGSmbQjN2/h4VDUbh2Z6eNTOOLRJKY1oycmhLN2Z0kgT9jQ4Ze8hljImG2QtZmZHuJqLsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX08ripU8vgAFUyYqjOV66FDETcJdOUp15JCpGumlm0=;
 b=aD+YZllJj26+vqxOOcr4oqBukI1nqgjqX1AJ9rta3HzkbEDcypsB5vmoQlANMUDu0BlQawZ0v3G1T8mi4vt6KB94r60p2YTk1UyV0PeSFxkB95ahRexhzqa7LNM7nTBZaopoOPfQlN3kC/mqRG+TYIKQeFiUC0OWjSatDamurJPMLkU4oFTrOMKs55iJG4IBEWPrp1v9m1mdV2yHuUyhgpIzis3LE/G4sdoUePTjg4GHhKg3HACqhhWJrcfkVrOszD2Snv58RWFiZwIegzPT/InTaJADDNVRd8btn4bw8/tEMt2rP4DL4RIB5YlqKHnlfvQzGtqnt3EUll4vV/7r9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH7PR03MB7194.namprd03.prod.outlook.com (2603:10b6:510:246::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 02:17:25 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 02:17:22 +0000
Message-ID: <47f7d038-3e14-45b3-be72-68c12e64dc19@altera.com>
Date: Thu, 24 Sep 2026 10:17:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Disable queues before netif_tx_disable
 in xdp_release
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Cc: ansuelsmth@gmail.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org
References: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <1e258c0f-8663-4dfe-a0aa-7c8be67d6afe@bootlin.com>
Content-Language: en-US
From: "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: <1e258c0f-8663-4dfe-a0aa-7c8be67d6afe@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::16) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH7PR03MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: e743abaf-78ef-4bcf-7272-08df19e1f7c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|56012099006|11063799006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sHZmNlKu/uklIpeOXYp+RhbDJDS4tvBpeNBVM+w6RX1YOaHz8F71Qu6wT0Z608hu8OEkikefCl4+SgVvyoUYNykMen30ui99LF8Ez6xE/sTzca+r+iyvvbXAO2rOz977ddgSZaipmtHA+VthsYjNBSZt/tTNed5KxnheTn5vWg3KdkdvH8GZ76OadGR6Ndn9tgXhn3yTP1fHOer96VQyi7eFv1JW9LP/psF7NNQs12WeYfz77GbnNrAzwOMviYDqbzx1Gon6ezLM8G72DIjUI/5WMhBXfVsKb/hkqVyUOH01zPOby3+bswOBMEXxtpNp/sE9eL5xW8XviLGZDCnOWL1HwkyAPAkoevywOxoKeCTDiqvL+KnZUq4OTZUsPIerUg+w/lv/OLbxV495YPaRlyY39plZ9USrM4SvyhhEEu9UidDPZJwhU9nDICOQzWL5UWei6ZlUS/+LTUNDT/K3SEl+wFscEVTwf+liiZVwPyHzCkaVjYudJ/RFETSpgvNnXAV3DoKDP5Ku1xxYqhZIZ4H50pDx7ucGOHZc/CpsYR18nBs/W4vzqg+HYvKa6Wbop+MqEorhoAJLWwTS4p2usYnqOPJBZKBnjykMYtV8GpBSG+lQmcsUVIdffWJSpMJBz2h8v+VSkMqNRJIFWtHcC1fA1QckIM4eo9v1wlYqveY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUNCVUdJT1JMaFNlc0R1OTQ0WVQ2TktuTno1MHg2dFZhaDJGYkRqYVJ2UFNW?=
 =?utf-8?B?ZWhKWjgrQTZFZXRqc0NuNjgrVm90WkxGalF4U3VHUWhLQkpONzY4OVNnTEEv?=
 =?utf-8?B?YkdWajhBWjhlVDlXYWZmTkZJb1g5NnhWbFRlZlJvWlVCZU9qWnVEb3hUVkxB?=
 =?utf-8?B?dEM3QjEvazVuT05CYjVSRGZiaVNmUFgyQXVoQ0NwWDBsNXFJUmpLaSs4VTJx?=
 =?utf-8?B?OThMWkZ3Z1VxMlgySVhGajNYeUhrK1I2TGFNNXRkeVJVZmVRVU1QQkkwQWJI?=
 =?utf-8?B?YS9xNGpxTTVIQ2x3dVNYQUdFL2NkYnJpdHpsMDFZYWE4azhmZmx0ZGFYY3dq?=
 =?utf-8?B?b1Y2d1ExYjkxV1o4UlRzUUdrWXFNS0pUQkZpRUQxOWU0TkFhaFp2c1RyZjFq?=
 =?utf-8?B?T0RWM1hsdGZDWGk0ZmU3OHFBeExNU3BJanVIRmRRRUFlb2JuL1FmYzRXT1BO?=
 =?utf-8?B?cmJoakJVNW1OQTdFRzJTYWJoU2U3dXE5NU9NMzNPZytEbjY1d0t1QXowUVZM?=
 =?utf-8?B?SUt4c2l2SVE2bVl6Rk45bGVhNzN1eHYyNFJiUmdBRFhRZDRBbGFMbElLZU4y?=
 =?utf-8?B?RnljcUx1bGEyUnhUSXpJT3NmQ0lINCs3U3lIM0p2N1ZzVDd4TGFZdHM4ZTBH?=
 =?utf-8?B?OGZLZHZLRnNPcUFINWZrd0gyRzBQdTJ5WUdSWXNOUmdVbU9GaUlhSVdRTTBD?=
 =?utf-8?B?NTE5cmtnTnk4NjZNZGVYTXArU2tQZzlTVG1IWUc4Q3VGUlpJakh4b2pOalE1?=
 =?utf-8?B?OEIzZjQ3QlpoNlFkeEc5TVRHbEx0ekxCdFdOUERzSHh4VEFhRUZBWTAvRHQx?=
 =?utf-8?B?YmtGbXprS3BiaVFBZ3FvcytaNUtTbFZrN05mMjUxdWM1Y3BONTFaTU85RFpX?=
 =?utf-8?B?N3REODNrQjc0eTlSY1F6TGkzM09SUUNvTk9JZTZvNUhUQXFRNENuTjBBVEtX?=
 =?utf-8?B?NVh6WHJFaWZxekZLZGtWbFIrMkp6WEdpZE5BS2g4UVU1SExOUkk1ajF0U0pt?=
 =?utf-8?B?T2RLV1ovamhJM1NNc1VCRms0S1VLQTNIRzBEeWhiVFFXeGRJMzdHaGMrMkR2?=
 =?utf-8?B?L2F2aXBkRjZzOTBlL0VnbXFGTzRVbkMyeU4yT3dMeXJDdHBheWRvS0VEWEZL?=
 =?utf-8?B?RG04RWJlOGlzTDFmMzhqV21wWU9kS1VvTkYyOVdpWk9BdjBmM01wczVzMU5u?=
 =?utf-8?B?aE5mMzFEeGx2eVFKT2Q4ZVI0Sm5OTzVmSGU3R1RDRU1MOFJwYVU0OGNYRkhl?=
 =?utf-8?B?WWV1TE4xS082cWQ4M3dCbmVqUG9VYWd2NzBjS1hFUnJmZkxRY0twNmc2cDZx?=
 =?utf-8?B?ekNJSVplUW1hTDJRZGVkZS8razJJRUxEOFVIYnA1dG1JN1hFV1ZtcHZDNUtU?=
 =?utf-8?B?TDg2VE1oem1QVlFkYk0wU2lZS0E4UWFSclE1MWR1M2RObEs0WlRYcUlJK0Iy?=
 =?utf-8?B?bmZ0QzZqY0pGYXNaOEdBTE1rVlNQUTFvVnpyNy9TcHUrVFRGcDRtcUtFMnNt?=
 =?utf-8?B?RFNENVRYalhvdHN2MnJyb3ZPU1VaVC8xTFhRU0FXSk9mekNTK3d0dU9sSUk4?=
 =?utf-8?B?R3pkSStabXl0V0FidzE0bVFiOGpaVUZaRzRZSk9xUVFNS09mQVJLcGVSU291?=
 =?utf-8?B?SmtkbUQvT2draVJUVGorZ29PTWhadXZZTTYzbWVLamt2ZkhpcWEzYVc2bFFv?=
 =?utf-8?B?dGpEdVBOVGh6Ulltalk3VThDRXIzdm1JYlErWDdNSFVMRmN3MGtDb2lDWnlG?=
 =?utf-8?B?cW1QQ1REU3NsVittbkVBdy9qT2VsZTRLWXUrb0crTXlqN1ZPR3NBU0NDSE1z?=
 =?utf-8?B?cXBnVVFCUTlGT3FMc2xVOTA5ZzZub3ZWQ0JSTTZZRzEzMVhSNk1hSTNEc1BS?=
 =?utf-8?B?RlNoS1pQc2pVUUxwMnAva0FyanN3K1p3ZEJNWWN5OElYVXN6YVY4cm5SNGJD?=
 =?utf-8?B?aWJUNlNWM2FsNk5xN0REMnFWamJxMDU2U3FKcWwrMWpxWS8ycmxnM3NaWFlu?=
 =?utf-8?B?QzVDNXNxaDI0b0I3a3ViTUJqZUYwZmVzbVZ3cEE1QU8vS2ZlMTFzZ29mUW9X?=
 =?utf-8?B?RnF0aGVTYXR6YkxXMmR4SENsbHNPM05uVm5ZdjgzdDNxWkhvSkFYYW1MdjVu?=
 =?utf-8?B?MytVd0RFYi8zUjBNM0x1WHRmbDVUMVRYSjJzUUZvejI4R1pteGdMQjdtUDdD?=
 =?utf-8?B?UGVuT3RMNXpPZk5HWTE2ZnkxWXZhYlNTbU1nMWZwOW42anFGazdkVE1iaXNF?=
 =?utf-8?B?TGN2cTVJOHpOUVZRdGdKTXpuWFBIaTlRbkE2UERiQU16RDZVYlpIVVhEeit0?=
 =?utf-8?B?QStlTTZnaDIvL1VMWGQ0NFlCcWJ0QUllUzdUUXhGZWRWUjNjTTRmYW1XMzBS?=
 =?utf-8?Q?+LsMRuIR5YhowvPGsFCZnKG72JEFvUGoykjhHKnwaN4W9?=
X-MS-Exchange-AntiSpam-MessageData-1: VXeSIuPybd2hwA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e743abaf-78ef-4bcf-7272-08df19e1f7c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 02:17:22.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOl4EdMkUaIIHqYkzjBLAoc8bhQ/e//rSYiMxcqsky3aK5CGrQ5W3VkON34DkYDlzkP4SE764+HrVzguq+dehelU2rtUIOvvR44OtDGs/K3OgfowXrC86CeTUq+EA9COpDX4EeIgu73rUb9YsOjH7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7194


On 27/7/2026 4:00 pm, Maxime Chevallier wrote:
> Hi,
>
> On 7/27/26 05:06, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
>> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
>>
>> stmmac_xdp_release() calls netif_tx_disable() before
>> stmmac_disable_all_queues(), which creates a race window where NAPI
>> is still running while TX is being disabled. If a packet is still
>> queued at that point, it can be processed after TX is stopped,
>> leading to a kernel panic.
>>
>> Fix this by calling stmmac_disable_all_queues() first to stop NAPI
>> processing before disabling TX, matching the order already used in
>> stmmac_release() since 7028471edb64.
>>
>> Fixes: 7028471edb64 ("net: ethernet: stmicro: stmmac: first disable all queues and disconnect in release")
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>
> Maxime


Hi Jakub,

Is this patch good to merge or require any attention on my end, please 
let me know if any :)

BR,

Nazim

