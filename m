Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C22FE58C
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482662; cv=fail; b=uQD4xF+BUdvwjSv4eNcdTBe+l6I+V1Z9JHtOi6nxQ4tt/IDpEIZ4D+8CSmourCOOn3SnFs47LrY/9a/09vGweQS2eaOjVROU+nKdyNDmvdhBT8E8VgnFBxK/oOJi4mP8B4vu6tCk1//gr9lgqQOJ0bLcDxY3hLDwKVhVnWRZsPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482662; c=relaxed/simple;
	bh=h4eAkI9y+xQgsOjI9OMkTAkQFOXsz8NfLrVvqZ9N1uY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANEfpEL5yei/+xHOfTrwPWoUrQRV5Hx/zIowG+3d3VhoqOrB54csfcWiUiSUWqXuCWN532YLVqKIjTag1hGORy8TgtZ6En5mAJZsVn0OVxczTk78hM7xyx0Tk2xManbD8p8Dv5hPL2J/iDrP3jtGWWftXH4Z0z434hALtUoNSLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=loUU7fdq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dr4lb2xx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loUU7fdq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dr4lb2xx"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFlGsB720964;
	Wed, 29 Apr 2026 17:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EzH4SZS7GMrLPZi0Wcwf4Qe7KlX1y51TBcWfBbcvUHE=; b=
	loUU7fdqMAf9jvKxIO88TgU59xmFVczEdzLJTLydyBK3v1moCSvH4ma8h3jlQYcc
	ElP8IZvKG8e8efvfyG5fTFj3MyyD6nVpE+76QQIt+bM0WyyvLYpY2yOc9+hNL6xe
	sy/tB4QEO9mEhtZeA1aECfMCXeXVnEWSvoxxyONRoCy6ynQXVhf01hkJ34KOwp2m
	Il2w2y7zrVuNpnYnkm+rBpQ2Xx5LQLIYJbfItBN+L6MIJTV33flCoTih6u3TWJXi
	Ns2IXP0PYXmgm4Y/9nKS32FzCGquUN6F9zecdkVpNIqVErT1LmCTUbJlx+IGbhlM
	2+d6j2Qle7F91o4yQTZ0ig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drp5t3e1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 17:10:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63TH1ESK003941;
	Wed, 29 Apr 2026 17:10:31 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2eh0bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 17:10:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRY/Z5reGUdvR951Tvd8NKBLBsCzvwDW3/AMQ735w5T4i8c25yqqcIjUvYEIuNIpX9dAtdZU7GjDakaO3V+q6JBagd+XYSbBV0w5RB+i9rS+KJr80e/50J2WCjrY0Mpw/mrjLCjMAKBSbnta2y3yoAVdlG8lywKuTfqrrVm0Rl5SrpgzvfJz8MBm2iGioYmM5SlRmz1oHldiwwgUzB7a7qt8ivi29WxiPe28aO/LzJTKY4l1Dxo5ZHZT0vZFMIZYwzwN+pLMLnpcEywg8SXP6HS2UA6QrnL+vX3L2u9CWmw9sxwrSXFw63WQT2LuOLm0hqe7EJERat03uq0+1cKEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzH4SZS7GMrLPZi0Wcwf4Qe7KlX1y51TBcWfBbcvUHE=;
 b=bCm6EEQQUrVPgEC8v4+kry/7SbB84O+WHlpF4Ezr9xGwpAHlCwwbHZIcn92SrnUHPB11baazP9arA2K6CZH5YSihOX5WwuvdXwFYKHw513nQWL9mCHhbRqbC5efnSs3NyHI9Y09ODQEwzIkM8456Q9BUA11d1jumtfvvv4OituQ1V7DXhEioZNxlPOx8XHrmgpcfPrImlyGGoKO7UgK02BLRUbkCC3TxKHNCZov4H/e7xohw0sKK2KaKetqHR+ITi1OZZEobxagu0Hl3DQyah85XM8UpE9nWJBR4rlDFjiIYgQku0O4vJRd3nevFwQalBQ7OxKYQshL/ggElbQjJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzH4SZS7GMrLPZi0Wcwf4Qe7KlX1y51TBcWfBbcvUHE=;
 b=dr4lb2xxYh1fHShSYmRqKIjer42b8x6lK9gaROnHoobk2y0zYXbtMkIC+b5b4GUkwB86cQCPShqxDoLWm82+iOQ9MrnjQbbmJDhfrCnQ09/Vp9r9Pqz/XZg5+DBvF7lFjOJJ2DR6LPeV7ELXbAfLhNHaY3aqBgeoct20vq96nck=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 17:10:25 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 17:10:25 +0000
Message-ID: <306beaf8-48e9-496a-a42e-9bae2ce293b0@oracle.com>
Date: Wed, 29 Apr 2026 18:10:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] Fix undefined symbol references for module build
 post cnum changes
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kaitao Cheng <pilgrimtao@gmail.com>
References: <20260427112205.1346733-1-alan.maguire@oracle.com>
 <686d51d3081a3c34ce644ac6d52c8b8e41864192.camel@gmail.com>
 <81b78478b1345151539578cd486b7c656249b441.camel@gmail.com>
 <CAADnVQKuCr-w0d34vPyU=G8NHHiV7GkEY+=QPUSQmSm_nkWv+A@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQKuCr-w0d34vPyU=G8NHHiV7GkEY+=QPUSQmSm_nkWv+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0590.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::6) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d008f6-b786-47e2-30ef-08dea6123447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JgLw4yNf7ePEkNGvHH54utgviF1zs0LJb/fqRdhY6gIHbejBYAAFSKQETq9qxuEfB7HkOAJTe0u/l0g1maD6jbNL6E8/m0ZspGDivicfxJ9WS8s2LEsA1/bH/ejT8uES+Xwzim+BAPGBSwT2YzZ98KU6vDGwBzXZWepHUWkgiOmS3TRA2mk7ywjHYHNRdfXix/foqZZDGxr2lK4rDQUqp6q8szlu9lVHgyvmAhDJKJmk7Mbt0+x7Y/0BqYkla0houBWpeeEDaP8EIoo7IdwzSKDnBuYrdEIM6lAXHWVDNJ5zK4uTxDcjCHklQ+zyXbO733CNk6EWxWL3qw73YkamQ93+yHktaX0zV7xil7qXrxJ4JLGZd0lKGZsP0yEeu2V8tPHhzv8ByWEq9e4W1vlIL/vQd4qKWMO2w+uCeLJtnnX5h0T+Kt11IcD9ZTtxbMdJ770W4KUV1dV25aH+hgmfUSFXONXp1jKEhNkKyK9woPMb5ufX8jJ12675TdOUnGeNdXzJgId1AtAYnq5YMfVZ08qXgpRUv5PCL4JlZZ8F+smiac+sReyHsk9nIQN0fFH7pXduA9shgQ+zNKm30zxqCba5rmFEFOd8ypuyXLDttmAypzt5esVsqylv5gqrbKZ83SQ7Mbm1/xi+qiQBvJyPSn9SfwpgiHRvj6urd096sYYdKWVJizur43EDknVKzuuwrgOc8KiZFlut9ZzSSuH34zGLy4kcP3mCaLMli8FeI/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGRublp1T1p6eVppcC9lRnFYU0VYd2pwa2loNWRra2FZMGp4c0g0clhyQmRN?=
 =?utf-8?B?ckJVbldDQTQ1WFJEMkpFeVdJUzFibzRBSDAvbHZKZEJHOTlqOW1oRTZpQk5G?=
 =?utf-8?B?Y2QyaGRNY01XbXNibi9nUi9xMEtWUDhObnpxalYrT0k0RkZ6R3c2aVJJeUdX?=
 =?utf-8?B?MTVyNDU2K1B0cTdLNFpZU2RtTC8yNnpRYzl5bkJnbEJpbUdzcUU1eFdPbG5h?=
 =?utf-8?B?azdhUzhOcTIvZi9zaWd4Wk5GeVR1a2VsUFdoVWxiM0VCNUE1UjZmV0hvUXZy?=
 =?utf-8?B?ZS9IdnhDZDRzTzNCWFV6SXBNaVJWZFUySW0zRmI2WnZkQW1SYmgzOGg5aCtG?=
 =?utf-8?B?QjEzV1NUT1IvYlNkWkJqY1VjSU9kTGFiTjdjU1REbUVBZWlVTVpob1RVNVhH?=
 =?utf-8?B?T01CWFRqcm9wZkN4WDl4Z0k4TTlJQmtBNk9lU0NJM0RzVkFwVlltbnE4Z2Ni?=
 =?utf-8?B?NEd2emJSbTBUOVV1U250U050L2JyaWNuVFBvMkV3WVk1U2JXKzVRWW5NRkVn?=
 =?utf-8?B?VTNJeXZZNitvaGtSQ1JZL09yR0FiYnpJZ3h0RnNGeFMxRnlOMkduVkdBQjRv?=
 =?utf-8?B?Y3UzQXdmaG9OaUZsVGJaSk96UlNHOXZMVmkvcVl0TUpIQm1JUStUQld4V2JC?=
 =?utf-8?B?a2hjL013emxTM3pJVkRTSm8zeWVNSmtIT2NyNUowZ2V2c2FYTjhRV0hYNWVi?=
 =?utf-8?B?QTUwcDdaT0dhYzVVbStkaC9sVGwyVTFrYnFqNzlDRlQ5U1BEem1nVHh5MEZl?=
 =?utf-8?B?MmxPSXdURUZ4ckVSVEtHeExzaERqcit2aHYwYTQrUFFlT0VNWkZ3cDZXUFVp?=
 =?utf-8?B?dDRtZ01EQjJPM0o3OEtsdGNtNThXZThQM0tPZW1zaHNhNDdJM1ltODRKZDMr?=
 =?utf-8?B?UnoveGFNNU94WEVrVXJFdjk4UnNSUVE5VnIySlVGdVI1QU9DWTlIWFJFMUpT?=
 =?utf-8?B?TnJXOFBZT3VzKzU2WGtmRVhXZGRHQlVndk1WdnVhdERJWHB6UGVrUUszL1ow?=
 =?utf-8?B?T3NMNFdyZDdDK1YyOUlWSmgxckdQZFJmaUJDR2RPaXFsZ2VZc0IwYzNhU0R4?=
 =?utf-8?B?U2ZDd3dGWkhQT1ByRGc3Nk55dUVzNCtrdDluK3M3alUrcGxhV2RMd2Z4YkZo?=
 =?utf-8?B?eFpHVmlGV3V1bjQ5R3E2ZFpJbnJMbUpKWVE0YU9iNm5KRi9TbjU3eUs4TXNL?=
 =?utf-8?B?Sk8rR2dtaElUZEovZlVyL1FBVkNZNnRvNjNJek5YT3AvS1VjVENERlV2SjRx?=
 =?utf-8?B?OVpjSHJLV1J2RUlNeTZMOHIxZ3ZSNWFtaU82cTd4YmwwdGlWUXZJaHl2ZXly?=
 =?utf-8?B?NnYyVGVPeFVFamVReDVPcFY5dExsbE5yYnJHMWlBOUNGMFRFLzNSbCs4NWZI?=
 =?utf-8?B?L1lZYU1yMDV1YnJiY2NpM1Q0aENyMUZZR2RpVnlFdmZBWEh6ZzE2aVpwL2VZ?=
 =?utf-8?B?TmMweXdBTWV2MWhuYzRjakhVWFplbHQvbHk3Z3NveDBtVmlPOXk2dlREMTZr?=
 =?utf-8?B?a1luRStNWG4wais3bDBYWVBZOHhOQ2M2VFJuUUd1VmxTSnRZdWRwa28zMThD?=
 =?utf-8?B?dkh6WmZzaWhVeFFkMFAxc1hCeU9qa3FQcDJJeXU4ZWlGVXRGdS9DKzZDVTU5?=
 =?utf-8?B?aU5zakV6ZzNUUndBS0d6UkhVcVZLZEsrc0xKRnhGeVUwYzdxNUs1MTRnbFpJ?=
 =?utf-8?B?WmFZdm4yNU9DaThLYnFGSE45M3hrYTltTkJ6SXdWbTRpcUdaWWV3cm5zeVJY?=
 =?utf-8?B?aW8rK0F4TGJWTGxISzJYNERQOXNHR2YxQ2JvUVMrRC9vblpzUEFpL1luNDdJ?=
 =?utf-8?B?QkRrYmpGdG15K2lNRjN3S0cxbTRrM0NQenplMWVFYTJjR1hpR3l2MkgrQW1r?=
 =?utf-8?B?RlVRTXdkc3Zud0RjaE5yaGQrcG1CZDF2MEd2K0RnaG1KR0g0TVJveG5qUVU2?=
 =?utf-8?B?QnRMUVZ6TUxGdHdWZUw0Vis3RDl4MVlGMG5OMG84OTdSSlBwTnJUdVI5aVNP?=
 =?utf-8?B?dXlwd1hrVjJNTmxFemhzclU4d1lhRno0Sm5IUGY0c2ZhMVBJSlVpLy9rczlE?=
 =?utf-8?B?Q3hJcUlxRm5Bc2h4SGRJS2pCZThIcnJvZUlEVFgyWXpraGZXd1VlTTRqdFlt?=
 =?utf-8?B?MTlBRmVPQVhubmY3TGJadytRN2JVbWZ1S1pLTVpaQTdENnVsL2czMWpNYzQ5?=
 =?utf-8?B?dmRrZGhUS3Y1UU15VmpxbmtJaWRVZ0E4M3NtcWFJcW90V0QzUHc4dWNKUGxw?=
 =?utf-8?B?ZmNkcTh1VzJ6bmtST2pUSTE0SnJWMFJJZFJlM1lmV3Z5cU52N05vUTJETk41?=
 =?utf-8?B?R25wczZyV0VvNGxBL3ZMRDg3VitEZlNZWUtHZXJVNThuSDdHWERKdz09?=
X-Exchange-RoutingPolicyChecked:
	F+ugwCazPDIihgMvXPSM2/FzOOdN92ClRw7pdtmi/mB6T+58bZm9jy1HhPHE5IdiqS/cJ8lQVeisoyER7G+sPeD0QBcDS/FJ9kY5jByVUBOTEuMF9wMA1R/Y4Fzz4myWwKuBMurlYm4tVzDohpkEVLHnIPznZFlvrGNeNxOdUk4zMUAOZNJHhe4axcZ2eZvgteZcV9tnf9tlkQ/KogMv8QZfVz0IRDdV9nPBppXbTzFYxGuDnSvuX0me/CwuYJfcFaUbcX7PwESNaxoODXZ8Vb8my3VvSNmev0XFjtTcF7727gMWIudTxIFaHaAo9WUkRDag3tD0ZVc1Wlw3mi/k9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xXP109/8jSG7WyOs8KTF2YYDV2CyrndQMXet5TTyfKBBMFHzvUhLqkSDi9WizLAvXitF0DAbKapjnreEObHrwRK0/bFF8uq76Gwwsu6uhduIPGTSj1kpZiHpn+k65ms6ePre71xD/wnvU+k4w0vkvZrOMnj4O9/J/NOX2UGGhk6xOEkf9eJPGsnwsmNPeTjQtPdAAJAI5zsnuCNQOqMVjhV7NC3O0rT5tcIHJl/jsiPXjfzT6slmuQZHtVezmtX5I+pFwxKCz9IXj3JMPWXUfo0FwML7ox4AF51cizYVYAti1l/TwvJTC9ooiot9d3OsDIzUcbCm+funZ7TzCTNzHvkU6tG/OWwsv1+P8oF6aiKGwuLCd4Bibpf5DGQHuAYbO73xvGNfjgTZJz7IkNlLAoKJZ8RNS8mvXAMowy6P7czT2IiXxF9ytCe3m3wWKVIPMStrUDOuJWvuCHyBxIu8lCbHFSOVuhMB2S1d6/lxJ0uMRDD8dojXKGhU33qPe+hTjKxW2/che0sm5b2UFPaEfe1xhFM+V6+V8lFe8JgABwbI2214jRlsKdJQzF3MhTiong5j7cqcURxUdP2eaA/K01xQcdSYKeaVBkylwBHZtj8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d008f6-b786-47e2-30ef-08dea6123447
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:10:25.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOIDAu/1UiC0YuVITsBANZg9C5CshkHuCcIw20BPboGjwfW3gc6J/3+EH6vjaA9vlB1GXsd9Gihb95Utpoo+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604290172
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3MiBTYWx0ZWRfX+1gsNKHFMMvM
 CyiVNdRvhst1D68tsZCRdvVuZ81m1Ta53YEtjsWrMVtjhJHAPja13NVEB3qwDheWk2ukaBE2bZS
 VrCte3EDjPWQPvpMPJxExlYVgP+ptIaKpx1kiGe4tL8xmLaaw/LrPHXfRVP3JHXsX9nul4zuFqF
 PfC/3KNS3/7XCf8op5pRgfch3OsWNws9kgAfnWvLyFmqCRZPYcNTVXdHreelXzqiol5P8n3Et5m
 3yPgdMiDZEktsHLxqambw9IYA2L79s7oHjZ95EQa+EVxfboW6XtGyu/gU+iOncp8QNuQJM5qYCa
 JCfJV4VnTfTgLNR09YCd2n7kstwQyhbnULFcHyZpHQKqN2MNfCdBysP2W6e4APH1wFlf23j7NHf
 yufNUYxa2jZgmjLU/bYoCJjRG2vh3cio6NqTFPGsl3kJM0xQN+vM0E+XzpU37VAjr2dKdvnaZq6
 l7waUOiQx/qHSaqCMlA==
X-Proofpoint-ORIG-GUID: -kvUnwhSXUj94FOWVuX99pxegStuCUUU
X-Proofpoint-GUID: -kvUnwhSXUj94FOWVuX99pxegStuCUUU
X-Authority-Analysis: v=2.4 cv=E7v9Y6dl c=1 sm=1 tr=0 ts=69f23b88 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=lgPgrCv1VBxmo7sTsBUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 27/04/2026 18:11, Alexei Starovoitov wrote:
> On Mon, Apr 27, 2026 at 6:07 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Mon, 2026-04-27 at 09:44 -0700, Eduard Zingerman wrote:
>>> On Mon, 2026-04-27 at 12:22 +0100, Alan Maguire wrote:
>>>> Seeing the following on bpf-next:
>>>>
>>>>  DESCEND objtool
>>>>   DESCEND bpf/resolve_btfids
>>>>   INSTALL libsubcmd_headers
>>>>   INSTALL libsubcmd_headers
>>>>   MODPOST Module.symvers
>>>> ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
>>>> ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
>>>> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>>>> make[1]: *** [bpf-next/Makefile:2089: modpost] Error 2
>>>> make: *** [Makefile:248: __sub-make] Error 2
>>>>
>>>> Further investigation suggests nfp indeed does pull in those symbols,
>>>> likely due to references in include/linux/bpf_verifier.h:
>>>>
>>>> static inline s64 reg_smax(const struct bpf_reg_state *reg)
>>>> {
>>>>         return cnum64_smax(reg->r64);
>>>> }
>>>>
>>>> static inline u64 reg_umin(const struct bpf_reg_state *reg)
>>>> {
>>>>         return cnum64_umin(reg->r64);
>>>> }
>>>>
>>>> ...
>>>>
>>>> Export symbols for these references.
>>>>
>>>> Reported-by: Kaitao Cheng <pilgrimtao@gmail.com>
>>>> Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,64}")
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>
>>> Hi Alan,
>>>
>>> thank you for the fix, apologies for breaking this.
>>>
>>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>>
>> However, Alexei raises a valid question.
>> Netronome code uses the following accessors:
>> - cnum{32,64}_reg_umin
>> - cnum{32,64}_reg_umax
>>
>> However, this patch also exports the following on top:
>> - cnum{32,64}_from_{urange,srange}
>> - cnum{32,64}_reg_smin
>> - cnum{32,64}_reg_smax
>>
>> Why export extra accessors?
> 
> I left only 2 while applying and rewrote commit log.

Yep, I just added the accessors as they are potentially available to consumers
via bpf_verifier.h. No actual users today though as far as I could see. Thanks!
