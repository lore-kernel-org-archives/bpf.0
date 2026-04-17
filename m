Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69D342CB4
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776463821; cv=fail; b=ua6ZSaNivNv2CgsCJN2yzqeQWNp7wKyMKmgAE96PHi5lhFl53Bo/belCRMlZdxEAoZURI3IWXC+WT+8BuKcfcskkJuslP/JCHN+RPxHxvsqfRtrXOmyWN9uHnfX7sj42F8KPFmiL+jPzBixvSBKUNsPYmjXgcq0xx1VcPdexfwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776463821; c=relaxed/simple;
	bh=RSuq4C3jGx/r3n6SL7PfZlsC0y7Fu+OQ84xxbQzYorI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MgOpKnTLdHGtztt4+koMq7MQOwBcErD6S7V9mjyKca5P28mveGJqqCQDBbF8mFe9egx7v9lFZFssMNFGy0Kjpz//NGgd3+eD9L6sNAkrS1TAkrlKCa3QK7HvawkMfE11+/K9QTX0CGViorWRYTBY0u8wzxNcqnLkVdrTaBBuf64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQeYVLZ8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXfRAcXS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQeYVLZ8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXfRAcXS"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HKfg6v2215412;
	Fri, 17 Apr 2026 22:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lcXJHm+ASW1Byr7r5xLYQOnKtxofsqu3phhP6fQ5Fw4=; b=
	AQeYVLZ83uybY1FVznIgkjOsWTCYRBw+h+PDA/8OBoX7jXX6eEFQ+JPRbCKtqRTs
	c7yQySA1q7pURNvxKYu4qXtVGAw8qPQgblXFnMwTNogyYgWp8m8VfkpUm2ofZRyr
	a7RO3CYlyzPpv+xNQvqIHIi4spO0eCtXTDXDKmRZxD0RzpiMEeUQSu5YmgGwXU5Q
	uoI1WVBYOQWJcujuizVSm2HykQf1sRjDyng/XpVvwjsSk2IWR1DfS7G6CyXqcSNL
	JKskScSenzy+13GD17jGGHJy2Fv0Hs6E/Os/q5fTS1WPZ3J+8eFIICznPnGfomEC
	HpgA/iMRvOtKiwnexSU5KQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh87haja0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 22:10:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HM9Z3a021124;
	Fri, 17 Apr 2026 22:10:16 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqsjr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 22:10:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfJoNLHbvL83qQtawYIzAalKV6jwWZMOkhw0bThStmUZXBPXaq7aI78N0ABea0WGHNS6gtBUzaYhN2/co5PPsHxtnpzgLp+JCMSzBgHh+9b4N/XSeF1VLH5IgrN90Rc0NZJaY69Kqus87lUNGps7yXyMZXbTb2jXWQPJmpEMXtCcjq//cCJJOzc3I0cb8I5iEH1cZrFWw/l1ldnB/NVXZvrA2UL6Pk4Ww3cP3974cmRT0YqpUOLu/R+xfZBN2v/re4FTB2+PPEslYnSy/A8qRFyBCPYwf+/a03bF0MMhFafZJdWuWAd9ccfe85R2O4mQnSVqj8yeYr/5ID20iH07ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcXJHm+ASW1Byr7r5xLYQOnKtxofsqu3phhP6fQ5Fw4=;
 b=WI7luVfX4fbfKeSf/qi252nXKd/fDWpl2+5y3l+KZ1epUcCSa6ugsCdlD3I5xQAiABOAHuIeA9+vbmZIhqa6KVrQuemzgKU29B4hlS9FmYXHLwYmMYws46lpRy4ncwulcfuI3s54PxzGNpAxiFimAMBWbZ84qvGyvKaKQaHO8TALTkl9Gkzx5IPUvEKC7HY82kNSyHvivYm7Jtu++zygqdSe824uWhCGkTVvfPNQec3pH453uyd2A76IBWAPWqlx0x0UDbXPYcyav/qY3/3Z7HPFdHNQmDc6z+ugdUra0t4usyEZRzTq/KvEHHh5NI73JKsoa/uHdzLvVYJqu6/ARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcXJHm+ASW1Byr7r5xLYQOnKtxofsqu3phhP6fQ5Fw4=;
 b=aXfRAcXSn1QkSANuGXbvz3queO9J0u3MS4Z+qHp+IcZv+hvjBcMHMt1GdmijVS/RRM6YwfA1lq5I5pl5dJoXbc+cg32Trpp3/2ggu5n5+TJmpRgFSyBSZUvDG/hMuO+yZrPzGSbApf8pJFps2s4XUWDhIMeQ03PkxqREvsdD8pg=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH7PR10MB7783.namprd10.prod.outlook.com (2603:10b6:510:2ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 22:10:06 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Fri, 17 Apr 2026
 22:10:06 +0000
Message-ID: <bdffcc11-7664-4c09-87e5-f6ba2efe80b7@oracle.com>
Date: Fri, 17 Apr 2026 23:10:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] libbpf: fix deduplication of typedef with base
 definitions
To: Antoine Tenart <atenart@kernel.org>, andrii@kernel.org, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, Paul Houssel <paulhoussel2@gmail.com>
References: <20260417083319.32716-1-atenart@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260417083319.32716-1-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0002.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::8) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH7PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6928e7-758a-4314-d311-08de9cce1513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VIBW9u2OgBMJkt9a5Kk/KaXBTxrMto+Nfgni8BqlKdgZanapYoZZ7BzK4/KG2QVkM2RXo0EjlxohDpwVJb1LsI+GDkY7ChakcF45Z8g9QWtijnUJd/t7zsZyNaUDUj+NUc+z/Bvoh7Tkm5pRpKDz9+0pou6zs4goOPN1yNsM62KJZrjgoM5cC8TzVDdaduKeqGOMjfzdu+6OWdr+dXLw+snj0EcLwBH25XXGApIryt3Xvw4lYCUvKp0cnHBwnnyaVmEG+C6qN2wowofIdL2wrr9h1zLeMuJpL5e/bc42fowigpLvZsJb2noa3FnRzDWFeV7h0R4AKqIRCS/Tc9IcLbtuwYFack6yAibGiK2+ra0APoynFTj2QaQMeuECWjvKyWVDovPuCxRGlR/5Sf4AVZ2SkhiM125BKPazFz/Y6aDXEzVJRG22i43ILZEVTGfus03naZfwdIVqSl/k9idYc+1fbzeQA4dxr1U/xPwufFR7SC4c/7fvEPM6mAgdLfAnOECEKnjZpL3bpyyLKzvvwbWYC+WlZL2UnMFJ67nAttDvihGcu9UzjEpnrVT6k+P3s2zuGKlYKXE0cVDdtQPKTnjWSCPyOK4V9CGivkSQGhzm2i6rA5iImXX+8zR3E5IL9/IhD3nAFAZWmuixdD0GbQMEqdMaSDStyVyE6HRRqnhCWihDqjJWir1oZ81wUsb7cFg1X560Sz5xJx3Nh8ztnu4I3STusTK6QukUonV9TLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a21qQUlybU9LR0owbXNzUFdydWZtdzlpL1hIaG56dkJYS2lCd0hRb1IxN0hn?=
 =?utf-8?B?eVlHMk02K1BQUlNKYWdCN2J2M3l6cDRuUWVuRXZMY1IxU29mQTZvdENzY3Rt?=
 =?utf-8?B?NjZrOHcrcUdpQUtsejZ3NS9tWEgzZHVyM3IzMFFlTTZvU2I4aUJVZTlEWnJ6?=
 =?utf-8?B?UlE3K1J0ZSt2RkdHaWNSdWpqNVhjRXBGWSs1dGxXZzJtWG4rc0RLVXU3WnBJ?=
 =?utf-8?B?TGRKSE5wODdHSk10bVhsOG9KWHZ5YnhYWUs4eVVVc0xmZ3VSZXZ3UDVjTGRT?=
 =?utf-8?B?dE03emVnN3VQa3lDZ0RtbllpdFVVNFFVM21kMWVYT2NaRC9xdjRhclA1MXc3?=
 =?utf-8?B?a0FrTnBsZWkvWFd4VDRiMG9rTU1NbzJuTlJiMUxJOHRNR2l4Z3hIdXZ4MFhM?=
 =?utf-8?B?RHUzQmRlNFhSWWYrTHJiR0lpdjlSUlZETXFVZ1dvQktQS05FaGJMSHFRV2dk?=
 =?utf-8?B?U1pWQi9VYkx2RUo3RkxyRUxyaTkyRjBzZUZORjBYRThNbjcvRk15clkwejBC?=
 =?utf-8?B?ZGpkWERVLzNqMVNZNExPVUc1UlZjbkVrVkNFelhMc254aFlsb1V3VUZpTVRp?=
 =?utf-8?B?QVUxYU5taVdnODFWU3JyUTZrckZZZ0RZeVVPek0xWGMyWCs5ZUVHK0V5eXds?=
 =?utf-8?B?YnBCdUVIN0VEaGdjVEg5ZTdkUC9HRGR4YVlFeXNLcy91ZkM3R1NlOFI0cVl3?=
 =?utf-8?B?aVhQclJlcTIrZkFTYjRqVUNxMnVxM1JsT2VZQmJSSi9mVmlSWFFRYjFac1F1?=
 =?utf-8?B?N1Brd3dvRmZRQVNVRFc4T3lUWVRMeWcxOCtVcmMzZk10c2ZXWVNnSEs0enYv?=
 =?utf-8?B?Vjk1b2s4WmdCUE5LMUsxYkwrcm93RU1FRjNGcGtZZ1dmUU9vbkJpbGF2YzNv?=
 =?utf-8?B?MUVMR2lpc3g3cTd6d2Z1Njd5ekNsZ2NqWjNiK25tamZ6dDJ2NndGeFJ1clNa?=
 =?utf-8?B?NCt6SUJQcFVXZkU4b1haQjBEWmtQSURsVGVrYmsvcDZETFduSDdKUXJPR3d1?=
 =?utf-8?B?M2hGemFHN0Yrc2tvVlJCYWZLYlRzd0Q1R1k4SCtTamRyVElvMHk5Mkw0VDhO?=
 =?utf-8?B?RzdCNy9kcG9RQ1REU1Q0ZTFpdFpxbGR1VWFqaVBreUdjVGxVb1ZvMnI2eUJT?=
 =?utf-8?B?SUtqTkRTUUZTaW84TWd4ZEt4QUVJWkxrMVFkZ0k2MU1PSWtzYkppbjd4c0VX?=
 =?utf-8?B?dVZaaDdhOVhxcXU0Q3BXbzdTUDl1MzZZNm5LMm1JSWhreS9PUzQ2L3BFNEJH?=
 =?utf-8?B?L3RvZ1I2U0hXRHpIVGR5NGs0RHdSMEhEb0NHNUpvaGxiRElNQ1dZcU05L2ZM?=
 =?utf-8?B?eXBVWmo0RWZPR3oySU55NmsrSnVNangzNlNZY1g0VHBtTEp6Ym9UUkZpWUNQ?=
 =?utf-8?B?Mk96R0drVkRzbldkZjg2M1dNamkxRU5xRFFYRDBZckFXSWtJTHBRWlpWUUtU?=
 =?utf-8?B?ai9sYlRudVkrSXJvNkg0WGNsWVlmaktqc3FBM2xSeUM4dGlMR0NKUUxLMG5i?=
 =?utf-8?B?MDAzckoyMHMzb1dCR0lGWUJpbEhKT0hJamNlVmFQTmthbHBETTB1OFBLYmo0?=
 =?utf-8?B?TkVmNW1oQ2tldDJodmcrNFhHd1lVeTNuSjY2VzFIVXZHT094bk5pdUdyTFBU?=
 =?utf-8?B?SUl2ODRTM1diY1VtTFI5Y3NiVlR0Y3M2VFE4VWdaUHJOdHU5Tks5cmppdFQ5?=
 =?utf-8?B?V1ZxZjB6ZjVYaG5VU1RtSmJ0MHkwVTVpYzRPMmkwWXBIRGhQRlE3M1VTN2dE?=
 =?utf-8?B?eThFTDF1UEk0Z2xhdWRaLzE1QTBuVHo0c0cwZVFYTHJhaXozbEFuRDk1OGJM?=
 =?utf-8?B?Q0QrcGUyWk8xUk13dzJvUnozZnViTU9jVGV6RCtydEVaN2VpUDhCZ3lKVVpL?=
 =?utf-8?B?T3VybnJ4Y3lFS2hhd2V0WnIralNpNkkvYzVBQ1VpenI1cnduYUkvQVpFb3BH?=
 =?utf-8?B?UDJwZDhETUlVLzFoZUs4anNHeCtqVXRnM2h6ME4rcXlxbVd6N0VrV3JoSmxh?=
 =?utf-8?B?TldPSHgwWFZPc2h1SkVXTUE1NlM0UFVQdFZldkNjMCs0dTd2ZE1MVC9HYjJW?=
 =?utf-8?B?QTRpQUNRNHVSamhRTDcyTzIzcXdRclhRdG15NjR1SGdGODV3cGtBVS9RYzY1?=
 =?utf-8?B?bWNJeFlsVWFxQnFCamQ0SStnZUl2ZGY4NmlJMEx4RlFqc0I4WWdOVHBVNkpu?=
 =?utf-8?B?TWN0VGlWcHNabm1jUkRBa1pYUHpLQlFNUDlrT0tpeGVvVklzaHFod1liM09a?=
 =?utf-8?B?S3Fzbk1vdE05cWpQN25weG0vRXlzZVQ1RlhUTldjVlF4aVA2MTBjWlJJTGJK?=
 =?utf-8?B?TENVZmVwZElhZUF5V2hPQVJ3SmM5TkFxODZ0cVlLU0ZYUG1GRXEzZz09?=
X-Exchange-RoutingPolicyChecked:
	m4dqdHd6F7XLWq8E1+hkloJIrYe+kMgvryJvBC3r3J2B6DjCQPWxJmNs7k5mi42p1cxows0mUH377b9b5TX6ZgeSvBFeQYGVptiu1MQftSqMdABfqqKznakaho8RWzgTBot06/D5jF4fSOeTYzoOcOPU9oZWVL7maTu7qWFNLJFYtCvMZkhtJcqqhEm//ROVfKpSBUFOwDeKJhJ5IL/ed5OIolnW3TJhGYUKL3UiIdjvjdnQX755Rmy3Taj6kcqBHvgYg3OgKpJCLwKO3WU+jrjWbjQPwBpoq2VO5p1UiJoMkMbh1+71QbOF8PkOwYMoP+T6TvqIHFDXCkUmYyyJeg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	84A5cEEM+Vw0zYTcO/1KE49fAjDaOM6OjmKBVfQPuwBm8XtKmESpJCqIFksmO1N2XdFbgwQZGbGlelap4IwJouClf7B0GROcQOkgIGBZ7+dZ51jxbyGLQhuQRpvd/0bItYyi4/d+l2IIkI61+JxTWUfV/LW77byGdt0Qvsn2mT2VS4yGw/QWRVNC1BWsCu/TZHsfpS6C1mPS+Ns9aTWLhn6DrnAghlWlFqVmAyUKzPnSSjzJs/PS7b9SUzEa9qYZfUUNNZ7vAUnVWn+PowmvYCyHXa0CqJWT9bCB/OXVOwSApDqrtDrDAnasyvqhRJBSxJpEL9rXSGyrA3QZQqMpNrYzYA+H1G0WUe9RDmfnDgpPiGNlm0dTJwNwe2JNx7VqtFgIimgBar0d+iLcW8S8jc/S05c0W23wuuEyYsMe3o5qJm3qpK/b060/FhDMaLEeoFc8xQHassnU29B0c7G4Myu3MvOuLYXzD5rE3FbXL3+ePEKcvMOWEyWi/LocDUw1tSsPtGpEcfycnIef4sW0a2c94ADlOdz5liE/cuCHpsDYDGXSdw5+Tz76t0gjwSMQlx1y6Cc0R+tneKLn0nmA7/qX45cYyH86Z62U9ZWmW7k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6928e7-758a-4314-d311-08de9cce1513
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 22:10:06.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOtRsroJvzHp7Qt0VLmKYfD6DGtTbbD0ylUMVGjG4V1WRxLuNnM++GYPa+vYjxe0uCkInh/3KUadAlSqOTAp0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604170223
X-Authority-Analysis: v=2.4 cv=eJUjSnp1 c=1 sm=1 tr=0 ts=69e2afc8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=x3nQLAhleA4GWQyVkFwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIyMiBTYWx0ZWRfX3k/gk4lcJJzf
 K5IL3UOvHOpemZYfe1aljo3WoRAAwm323eHgT6guW/1R43SD0pE/+2siYu2QQMLuPiVD3UaN4hC
 ptumRelNEMm9Dc37M1xngABgftn1JLPx5nJxviENi6Ys6aAQrsc/nTb7cWmDQl/iHN8nKLFxN/t
 DmKP09JQYUFNpCWbH1f58RhFWlw2ynUtLiew+KiovvQ4EKgNl/rx3nPIcoUQhZWu8M6srV/vdHx
 ERuXU9wpn7g+P6opFNII/madrrEdIl0fGn++8uGaZqAg004FXAm9HhUumRJmoCYsW2UpEQI02Uv
 tWr//USIpu9Mudm5qTNrClPKJ+4A8vKRaTkmlq2ltuK8fO7xBxJ8MOHx8U8vR81E2YrVwLTInMT
 lw3DbGL9oUadIoPg+ToqeX2/YMdhRZRnqSwOw0RxULqM/DQvLRAbsRUJd7i+XSVwHvqCTqgbkqz
 4yID+o62ypUphwa0dBQ==
X-Proofpoint-ORIG-GUID: 81ixt-BAKrQt3ahORWFwg7haD2QKZJ14
X-Proofpoint-GUID: 81ixt-BAKrQt3ahORWFwg7haD2QKZJ14

On 17/04/2026 09:33, Antoine Tenart wrote:
> When deduplicating definitions for a module, typedef defined in the base
> are not removed. This is because the hash used for base types differs
> from the one used in the deduplication logic in btf_dedup_struct_type.
> 
> This was introduced by the referenced commit when moving the typedef
> deduplication logic handling from btf_dedup_ref_type to
> btf_dedup_struct_type, as this also changed the hash logic
> (btf_hash_common to btf_hash_typedef).
> 
> This also impacts other types referencing those typedef (e.g. const). In
> my test, the BTF section size of the openvswitch module went from 31KB
> to 45KB.
> 
> Cc: Paul Houssel <paulhoussel2@gmail.com>
> Fixes: 3781413465df ("libbpf: Fix BTF dedup to support recursive typedef definitions").
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Thanks; verified that this patch resolves issues with duplicated typedefs
in modules. Selftest in patch 2 fails prior to this patch, and succeeds after 
it is applied. So for the series

Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/btf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ceb57b46a878..771aeaa0262b 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4578,12 +4578,14 @@ static int btf_dedup_prep(struct btf_dedup *d)
>  		case BTF_KIND_RESTRICT:
>  		case BTF_KIND_PTR:
>  		case BTF_KIND_FWD:
> -		case BTF_KIND_TYPEDEF:
>  		case BTF_KIND_FUNC:
>  		case BTF_KIND_FLOAT:
>  		case BTF_KIND_TYPE_TAG:
>  			h = btf_hash_common(t);
>  			break;
> +		case BTF_KIND_TYPEDEF:
> +			h = btf_hash_typedef(t);
> +			break;
>  		case BTF_KIND_INT:
>  		case BTF_KIND_DECL_TAG:
>  			h = btf_hash_int_decl_tag(t);

