Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020126.outbound.protection.outlook.com [52.101.195.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797846AED3;
	Tue, 20 Jan 2026 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936519; cv=fail; b=SMAXoe8elW6DPse9KP7naYDwTgIWrGOJN9Dp0n5SvkbFTncLAUzrwM5kMmMSgZwmuPph+DP658Ulz7cROSm+tljaGMZfnvpDPbYCABSHXfvkFRoRekmiRm4sG8ulUtR0tqA1a/TeXKSMV5kewUdlLsHI6i/A5S1f/2JEwRPfz48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936519; c=relaxed/simple;
	bh=QwtDtARqcTOjSj4NLJr4fojjKRhE79FA1POB+BTCEK8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=HDnQfszShSJdCisEre67Gcb1eaNIXI90FMHbaVve0bdHIL/YHqftllMAjysDvQeeugchJd1WhffcCaUs6h7d69NtwwZtAq0+2oA/SUUWqDGF0U0B3/zKINO7ZVndslUa/nTRZNjm9lsAVN9A1r5gTiyHC/vrceBI4agdJ9CUnrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=V35wREwC; arc=fail smtp.client-ip=52.101.195.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="V35wREwC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmQ1/LmBnIije9XgMzBVUaETwfliyPSxC9t4WkDlE/NZXDxlsIX3+4tCGwkhdIAFY9UKukWYEybGQAVHPXHUKhQOb2zudpA/CRHN/xxtzaxoMzJUy1NrMglIbLWKdLnFuDKTyZ5PDrNNYuVqa6JLl6ojA8XNRGBvIdfDLXUnMYOnGZfq3G7BSIYiaNizE436N29IfPcca8ibaec1+AiGM8lRT7GWfMXa7UbWMIesBaV20IGXEDaAF+UD7Kr/0oKTXzVldbxIeGaqNNuSWsHL+Sb602ib5S3oPbEWA9kclzLid/jN3VntWX6mGJy0mGxOsxnueJPEczITVwo+JIte2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Llb9T+feRYTVBmtwQdHQZRG2cb8mYKfiJN6oM5gJqMQ=;
 b=HkrInVwraUsepVQTIYe8JSDUMEAFBQzEWt0HMlSb4NhliD4ku4eEdwyhaX4ef977EJud/JiLWUBph3Hn6rcHFZwuSJSEX9FlrPVhsRE3dLVzuwdDMsWmVdc9yzXsuZieczVOMenC28qIcRNetdws7ByYYnjm/9VNh/Iq91UZFh6jQ+5Ycp+J654jrk39UIo4VT7M2YKCJajUOqjwoKJhtLrOGhKGb4AImpEF+2ivbBL6U0XmyxrmHSYL6p7sSXC2TwUeymyAZbn8i7LhGlFehLkrOwYffvbWzVhUHX2Iz0pZ3oPdnfSDvYfv8nmm95wQgWaDVbQZRN1R4Cr4/XpFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Llb9T+feRYTVBmtwQdHQZRG2cb8mYKfiJN6oM5gJqMQ=;
 b=V35wREwCDkPzHc87T5k6NXLUv+YThjWI6da+L6H/+qc0M4oUSY3fXDHJiCfLNElsMgGBnzKVEe8Bab+CHNk953C3UBV+ZhXMGNz6kU7Ju3o98BjR4r/hP7+r3VVAqJYI2DFSe4Qgdx1BYJzehsLxbwbg5RbElhq270gJVX/TJCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO0P265MB5653.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 19:15:12 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 19:15:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 19:15:11 +0000
Message-Id: <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Gary Guo"
 <gary@garyguo.net>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260120182034.3647092-1-gary@kernel.org>
 <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
In-Reply-To: <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
X-ClientProxiedBy: LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::34) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO0P265MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 690afcd2-ad07-4859-361b-08de58583bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEJ6KzJsRXZLQUhDUjBkMk5DQ1FnVmg1bGFvaUtIMDN6dWhvSDF3L3R0c1Q2?=
 =?utf-8?B?QlIwNGtVdEY4OXZHbitieVd1aEl4ak5Yc3dONEJ0NTJYc2JmL2plTmo3bndW?=
 =?utf-8?B?aGNCL1JHeHk0b3BUZHZhMkpjTW5Td1VZTVFRNzZGRDI2dUZocjdrRUdad2pr?=
 =?utf-8?B?UE5BOVQzRFJEMHNPUENhTkFrZDZ0dFkyUy82YUlSQ1I1VVhnWVVHMUwweWlL?=
 =?utf-8?B?bkpQRjFBSzB4Vko2ZXdXMHR2d05LQi9UMlZ5dkV6M1BwcDlyZitzaXhTdlBn?=
 =?utf-8?B?ZzZrNWd0Q3EvTithUENVa0pIeU9qU2l2b1NTWVh6d2pTOVl4clhXMFQzSnNs?=
 =?utf-8?B?SE9HK1BuK1B4VFlieG50dUtzUy9iQ0Q5ZlV4dWQ1T1RqS3AzemI1c0xCOFNU?=
 =?utf-8?B?ZkR0RyszYkx6TWJGdjhXZHhuQ29IU25zTWFPdGZYQnFYaWJITkpoMmV0SklV?=
 =?utf-8?B?dWZpTFpJN2k1c25Gek5YQkdoK293WXA0ZXVGSk5nazlZZ21pU1ZVaWJqUXlR?=
 =?utf-8?B?ZnVIRHc2eHk1c2ZKaUc1UXJJcTN3MXVCVWx3VDlueGNXMW5qWGxHZExOVlVE?=
 =?utf-8?B?a2ptZlpVNEdDVEQ0MS8xdm8vYlFPZFc0aXZZSWlWS2ZlcmxwK1BpZjRBeGZq?=
 =?utf-8?B?NTV1aDZRK0NxODhockFieUR3MjN5azlNLytQMWFpOGtUbWh1UjNFZzBpVGsx?=
 =?utf-8?B?T0dqaXlEWFJRMUxQYnVDZWU3Z013TFRobVRnVjhWK25Ydk5iUU5COW1PbGk5?=
 =?utf-8?B?cFh4bGtNaC83Rmx3L0ROYlRLdlVIWHcrTktLQ1FyeEt1UllJa284LzVjK3VJ?=
 =?utf-8?B?ekxsenordFNUN2lMUVJtZGROTkw3cXdRbHNTb2pXV2lGcEZaWDNHaDlxZmNi?=
 =?utf-8?B?enpEbE5OWmlYYlZiNjFpaHhXdkRsSVVmNlFRZ3BabnFxRjMyZzkzVzRLamRa?=
 =?utf-8?B?SkpadU1XYTFzdUx5RlpiNWM4VnoxUHROaGdJUlY4YmxOa3RaWmxiTnhJSDFo?=
 =?utf-8?B?cWFSMXl6ejRhNUx4bnB6ZElkb0JIREQxNXdUS0Q5eVlDVXJCc2JRdkgwbmVP?=
 =?utf-8?B?SjVQMWRXRDUrTG8wREFLVWJTa05xV2VaWHd2TCt1aDg0NUxYODFjL1g2Mkpq?=
 =?utf-8?B?RmZVRGNUY2ZaT1dxR0hJKzlrRU1maEV3YzJ6WlhpNWVCUFNDeVo1VkhnRXQz?=
 =?utf-8?B?UkdBZXRIbnNHZGptUkVONVVjbFZkSWE4TXhDVHk4cHhOVVRHazJIcXNzaU84?=
 =?utf-8?B?NDVJaTJobnE1a0NlUzhMVHJqMHU3YWFORVZjNFl6NHFmS1o2LzVsUS9SZEdT?=
 =?utf-8?B?VkhobitDTFZpbGROQTczZGt1Sk9RZWhnVlVBTHIrUkptUmVUTXluQVQ2UDFP?=
 =?utf-8?B?T1hnN3NWT1Z5aUxhaENHelV4L1lzZVorUkd0ZnFwUzVUWS83ZWNtTnZFLzN2?=
 =?utf-8?B?QTdQQUdhQUxvWjVJV2RUQ1g1QTJ1bzVhWFNXRjVsSGlGVitsMmphMlEya2Y4?=
 =?utf-8?B?Z1p3aE1OTmdneDlpMzJtT05tNnFpRksyYlB1UjRQVUZmTDRWdUU1QlBKR3Zz?=
 =?utf-8?B?dldyWG5YMHNLN0t4aUdTdFpvb3IxUGJNWG5yRzlPWmhTeFI2OFNwRXQ2amdw?=
 =?utf-8?B?NVFLT3BlQjZpZFZvT0RwWVJ0ai9wOTJQQVpmaDFiTWxPbDVEN0VPVldZYzNJ?=
 =?utf-8?B?enBodm5HMStjWVh2bWJoRXhvU3VzVXJJb3pmRnM2YVdzWkU3U3ovdkVCdHNo?=
 =?utf-8?B?Y0R0OEVUVWxtdW9VTkdpUUd4cCs0NDFFOG5WOWdrKy9kNnQ4bks3N3I3cWty?=
 =?utf-8?B?Y3dQa3dtR085SU1Obzg0MUZ6UEVXUzFiYjQxQ3NPNXYxK0FMd2dwSzJIc1dM?=
 =?utf-8?B?d2thTmxKd1Q4K1hPQ3VKUldCUjZzSVVKVHBGN2ZVcFc3VzFFVEJLbCthZnJR?=
 =?utf-8?B?bHZldmNkV3E2NHJCTHVrNitOMVVuSVJHTEdacXJOL2Zhbk5VblFOaElWbmxH?=
 =?utf-8?B?ckNTZTJ2VmJGUWhmRTRsVkhWc0swbzlQcEwxOVRVUWtQNHVSSU1UKzZucmhR?=
 =?utf-8?B?OHFkZkRQOXdCU28wbUVuNWJXeTNlYnE3QzlEV1NhdlNOMG13YkRXT1FOUS9i?=
 =?utf-8?B?aVBWeWdseXNieFZmaGxYWDdjTHlVdVAxNXVjeDBJU1V5T3IzeHVQaGpBN09Q?=
 =?utf-8?B?UWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3FWamxLdVV4TE9hWGdGNDhJUEx3RE01MXZMeFBpWU5VQU5aZFdlZ1g0Q2FD?=
 =?utf-8?B?aTcvZ2RmZlgzOTBNQzhSMVBQU2E1SmtBU2loWTdwQzczUXloN1pFN1VYTDZY?=
 =?utf-8?B?YTdOQmdKUzI1T2UvSWxuVngzeFh4bjExVlpkMHRiSDNOWVpRdVFNSTdsTDFp?=
 =?utf-8?B?OFVKTUZ3L05lRFBkUEkvYm91UTVWeVVXTWx5bHZ0dzRjN1p5Wi9yMXZUc29s?=
 =?utf-8?B?MzR2UjhheUJvTzJ6RDVpRDJvRkRneDJMOFhLZjByY3ROYjROREdzajU4L1R5?=
 =?utf-8?B?VW81eGNUT2l2ZjNLVHFKWmtqc1duMUxNN0dJMHFpLzExODNXM2ZJSW1PbzBF?=
 =?utf-8?B?dHVzYkNzdm9WalArUi9uZEoxY0U4K0t1UWtZVktCbEV2aGd3bjYwMmVoR3o3?=
 =?utf-8?B?bUY1ZzVGVGVLKzkyN1gwT3pzbytOZno0SG40S0ZtTHJmbUNZR1c1YnFlT1dS?=
 =?utf-8?B?YnlGa2pGUC9meWRxRFVKcEw5cFdabFM4aDZIakxBVDV3RitxRU5zc1RLRUdj?=
 =?utf-8?B?NlFlZzFvdnVFMDlVTTU3cFJmeVJXZGZYbmZWaU5lL0REUlpjYkdNMTF6NjFo?=
 =?utf-8?B?Nk1JeFhyb2RFaU1MT3RKVkxVRUo4QzdlZHQ5NFZjTCtZaDZXLzNUa1RFb2lM?=
 =?utf-8?B?TEMvWWNKRC9POEIzcXpOOWlOTUdWcE9mZE44NDgwVWo4UEZEejRuaWtBczJR?=
 =?utf-8?B?ekEwNEZjQitkbGltMXZyMytsZjltb0hqdS85SksvQ1VCbUQ2KzRINlFrbzMy?=
 =?utf-8?B?Yjd5bklVMzZOb1BWdTB6MjhJUFoyVUlDaXFBKzl4V3gxQXRadWN6cHRBN0N1?=
 =?utf-8?B?SzFFV2g0TC8wckRQTzFKeWNhbEYxOEVpckdXb1RGSHFUMnpSY1R4anNsTXZl?=
 =?utf-8?B?NkZuMFlVTjJWbFpjNDhOSndMeFFEUnZ5NWVPakRjQW5Dc09aMzlzS1IvSkk4?=
 =?utf-8?B?QjhxcDZhbDhNTVZ4Q2NLVm1LVHRTQVdJVUxFR1JrcXVkWHNXN0wzbTlWdFh6?=
 =?utf-8?B?aDdYbFRGV3laV01oM3NReXhza2UvQWFEVmR0ZVZ3L0h4NGxhTzIxeWJVYzFH?=
 =?utf-8?B?bDRXZXNvRjJMcnVVRUswNEw2aXh1ZFFUV1NCelREcVg2cGpMYjY1eXZnbkFB?=
 =?utf-8?B?TXRJaXVjcDgvRDN5c3lITjRGTi9sWmlvcktYZGxORmhmM1BCU2t5YklTWjA3?=
 =?utf-8?B?YTV5YnFtakQ5ZERYbWxPblllR21sNXRWU3M5UEdOR3lTeGQwUEdMZUxaL2VJ?=
 =?utf-8?B?d2lIZWZoMDVDelkrSVJ5a084L1dTMGlOVEkrSkRrV1RYT2lPelpXdmh3WnBi?=
 =?utf-8?B?ZkF3N05zOHYwN1ZMYnpISm5TNHp3aWNIZnhPa3dkOTdxUksycXdvUHZqQnJL?=
 =?utf-8?B?dk1ScHg1SlhlbVcvbzRPZnMxV0hLL0lDd3JWK0ZZNmVmOUorc1gwZVVBM2Ez?=
 =?utf-8?B?MndMMlowY3lrRjhUeDJMT3cyMHAyVTVWVXFHQVVXTC9lTzFtenBZZFB5UjFW?=
 =?utf-8?B?VmRvL0tjb0lFZE1XbkJCc2xFa1c2V0VBaXRHQThMd3V3a1FPUTBPR1Y4N1Uz?=
 =?utf-8?B?Zy90L2duNEdXYVVkUUtoWExJWnlUcVFKMU9lWWNsNi9lUmwrT0dSeHZRNlRm?=
 =?utf-8?B?TlhtcTBYTm1iOWxOOXFJc2JVUUlHVFBqVWFOSnVyc1F0QnRjTWU5TCtwNE1q?=
 =?utf-8?B?SVB3akxjTklpY2Y2aGZidHg3alB0NC9uSTZTd2ttYzZJYytHbkl5VHRLRkIv?=
 =?utf-8?B?d1hoYURybzdpV1IxRXA5YmpFenh6NEFNZFFTK2dMSkpCclFzMjVaMitqaURG?=
 =?utf-8?B?WU14eFZWbWQzMHFhY0t1L0ozSXd5SzBBK2NBYWVmYzlDVUNuV2N6RFRUdGVJ?=
 =?utf-8?B?UVl0Q2Q1QTdFb0VOQk9Tbm1KdU41ZzZRTm84bHp6K3U0OVFwcnRuN2tyL1A2?=
 =?utf-8?B?SU9keEsrcVAwSVQvMjVGUnFvam93Vm1UVTBQWmpjYjJnRVNzMThnWVNEckxo?=
 =?utf-8?B?WEZHc0ZTZ240TUhjYUF3WElPOFkzNVFjUUdzQ0pabTF3SEtZdDlHTE9CM3ZW?=
 =?utf-8?B?eStYRGVRdkZCT2tGaU5meHBsaC9mbmhrV1RWMmVHODYrRngwR3VyemdCVEVU?=
 =?utf-8?B?TnZhb2lmWC85ZG1sSHQyK3ZlZHA3dFhzMElhTnk4Z0pXV2JEd1c2YStpaGh5?=
 =?utf-8?B?SXVxUXJwcTdCeUxyZGZudWVoQnFJcm1YZGRKTUpsY0N4YkdPejVHb3ZydmFI?=
 =?utf-8?B?UC9aVHlwWUZLbXc2T3pIRUs3QnNYdDV5OStMWkRlaTdpWUQvZE5vdmgwK0hU?=
 =?utf-8?B?QkRZc0lMTEtqaVB0eGJ2azdUTGhtVUN1U0lTM0JmeHpsSHJLK3VsUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 690afcd2-ad07-4859-361b-08de58583bd9
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 19:15:11.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aclCozWj2aXCfFTA8f0SsUvftAsHDJhw1+bk7BXcM9l2KuhVHon2QJD6YijRH4gMqx0RvuB0fU81gfa6CsJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5653

On Tue Jan 20, 2026 at 6:59 PM GMT, Ihor Solodrai wrote:
> On 1/20/26 10:20 AM, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>=20
>> NixOS only puts /usr/bin/env and /bin/sh at the standard location as
>> required by POSIX, but not other shells. Other program that kernel build
>> depends on is supplied via PATH, so shebang needs to use /usr/bin/env to
>> find them.
>>=20
>> This has been done to a few other scripts already, e.g.
>> gen_test_kallsyms.sh or decode_stacktrace.sh.
>>=20
>> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw bi=
nary output")
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  scripts/gen-btf.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
>> index be21ccee3487..4cd3159f2ddb 100755
>> --- a/scripts/gen-btf.sh
>> +++ b/scripts/gen-btf.sh
>> @@ -1,4 +1,4 @@
>> -#!/bin/bash
>> +#!/usr/bin/env bash
>>  # SPDX-License-Identifier: GPL-2.0
>>  # Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
>>  #
>>=20
>> base-commit: 053966c344dbd346e71305f530e91ea77916189f
>
> Hi Gary, thanks for the patch.
>
> I'm guessing this came up because gen-btf.sh is part of the vmlinux
> build, and link-vmlinux.sh has #!/bin/sh (not bash).

My typical experience is that when I see an error about /bin/bash not found=
, I
just use "bash <script path>" instead without putting much think into it.

gen-btf.sh is part of build so I don't get to invoke the script directly, h=
ence
the patch.

Best,
Gary

>
> But I wonder if all of these need the same change then:
>
> $ git log --oneline -n1
> 24d479d26b25 (HEAD, tag: v6.19-rc6) Linux 6.19-rc6
> $ grep -r '#!/bin/bash' ./scripts/
> ./scripts/check-uapi.sh:#!/bin/bash
> ./scripts/decodecode:#!/bin/bash
> ./scripts/extract-fwblobs:#!/bin/bash
> ./scripts/gfp-translate:#!/bin/bash
> ./scripts/git-resolve.sh:#!/bin/bash
> ./scripts/mkuboot.sh:#!/bin/bash
> ./scripts/objdiff:#!/bin/bash
> ./scripts/objdump-func:#!/bin/bash
> ./scripts/prune-kernel:#!/bin/bash
> ./scripts/tags.sh:#!/bin/bash
> ./scripts/tracing/ftrace-bisect.sh:#!/bin/bash
> ./scripts/livepatch/klp-build:#!/bin/bash

