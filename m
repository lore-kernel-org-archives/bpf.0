Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FBC286D7D
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259604; cv=fail; b=jxotew8xhizRD1aXgudpOCniuTOr+nGul21dE6DHSeJTyN7oqgACqDCzeXOMYVvm+8Y32MncUomrQviLy4+0mhRCFOwLI+3N6yPESHtVKFPxnox6W/pSl2a3+vfGM2iyzg4hrxRs1Dueb/sPW7sjZclDgp4t4iSkwqNYuTeWtPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259604; c=relaxed/simple;
	bh=gxSVsrUblsbrQc7hJx/IqOJ6+84IacCnW1f3Pwnzo/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FAtAyjaP6S7Zm2215cOuwwNENfkSTr6gq8vJOunxaoC7pNUeEPaBqCJK8hURk/dPms/UiP+9oQSZN/bTBeKerf9Re8lS1yecfZuiRVFQRD9/b2ZuBcXKylKpre/jLON8Epw+aExIJFev30sMjyvVEYkI8NlL5oMFJnOxGpvs8n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sg0ikBKu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EkUxw0XS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sg0ikBKu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EkUxw0XS"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FCfROJ1429531;
	Wed, 15 Apr 2026 13:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ckIDzgQpSG40VBi/W0ZBOKMidP0+6D5oILfsXbh5DU0=; b=
	Sg0ikBKubWBzfjIyi5e9Tgd4a8U8tIxpZUi4LUEfmH4HYxb/kuW0/9OwBNSU8fFt
	84m6ibYBt1eQ0jE85R74aZ8FiiOJ1+f7SL5xtvznr+S+KNdTt19rR1YEOQ8UYFHy
	f72GuYMZOvyk5OkMwA32Il7THH775nzXhmEALtnPogWkpfq6OZBKJwWlLAaAVnIC
	JSAkFEKZYFO0wr3XqfwwLhEFV75uyz771ZezgHrrDluZ7tGugHIBOA4b4jl9+uHI
	BLp3tTI4OwA9MdDYfjUmU5hko6DVVUHbn9p+jRZ/ab1BanFpr7It76CLf2f1s01/
	8mlNi6NAp4xT6NHsXQfy9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh86859sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 13:26:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63FDONfP005551;
	Wed, 15 Apr 2026 13:26:25 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh9jqnx38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 13:26:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiPobosXkBD/4PCJWkIbKbCA9axJYJXakMRXGSkYOjC00ung/vNbfs5Vf9cN0RSXwD9jUC02SZi8HVey3Y7/UHnA5yUAlrQKd/mJjREQ5LkCJwjCefIeUdAMa7UxmhPoIZy7MJFAP1C89UOhyJUyWWfGgpC6zHApOg55sjFUC0VVCRfJ1vSSChZWMOW+J+7kMnch+gxVw8tiE/scSGqIHMN7QRICCpZ6Pio1lD/lGkaLmlpB0MGqoE4bIf34DceMYpbYts93MLW/+CLjqR0x+k4Sk5TY68bC3GUjGCo2MhBxR/G1JFMERiW7EpUcDLXpEi94dgIF3lNOBsiRFOxyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckIDzgQpSG40VBi/W0ZBOKMidP0+6D5oILfsXbh5DU0=;
 b=WkqQur6wpzteMHEPeOAqZxb/jNa8GLwnjeAXA1VIE5hpmb+RXUCQYpU5U1fXTXGCwneAAZ5zrS2BQ7WcXgzm0qqFo9wcqe1iIrsNNjlGiwPcaUkuwdil5HnIXxFTsIHDsWf9l1a5cOMP2Y2eRn0Tg7PnIMF8xKYNX/VcMIZZYEY6PGOXd7LwBmlORQGz2pSjeUYcPUmu74K4cu+2Ajt9CXS4XAXfvE5a5KUkFUlvrA7vHtv9i5fnfC1hDZZEfWYkzFTQ0HOCnHj7cn6ACglnN4Xox/rLFtflwrb2UwDW2Iq+5ZFm6klYeo5Ls1hfuuqxCq5yUSm2d1qz2mG1QklkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckIDzgQpSG40VBi/W0ZBOKMidP0+6D5oILfsXbh5DU0=;
 b=EkUxw0XSk/MkvBbKqta0vrdH1n5u0MMxkP/iVP3uCk55x7Z0AklRYCqbsEpkqW4CUH80Du0fr3unzw0jYxDS/kkvkBXsLDqdI5WCrFWYfcte4feJfKaCBNkEFL5uRn2osWwlmcRgcY3iKd4r5p3j22bEXgxUNKygApEnBU57NhM=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ5PPF2BB505D96.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Wed, 15 Apr
 2026 13:26:20 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 13:26:16 +0000
Message-ID: <43c97aa6-9858-46e5-a972-717cd529a0e6@oracle.com>
Date: Wed, 15 Apr 2026 14:26:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 bpf] libbpf: Prevent double close of btf objects
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <20260415082452.1489147-1-jolsa@kernel.org>
 <3cb314b6-7dd4-4a49-9d7e-5021c7773936@oracle.com> <ad-KltDa7xMA1EC1@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ad-KltDa7xMA1EC1@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ5PPF2BB505D96:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f953226-85aa-46de-f794-08de9af2925d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yynPbupCpdddt+fJedgBBvthZxXLEKQmhB7+x7BOC0xbu7y8OhzgQRpWLmiF1b0sD/qQERf8VJ75ATqwEu8sNkMOHzMyWDWYKbHRPkRJ4k3ScCUjYGs7TFOgWjmwHL7DUMXSG3iyl/RYJ7PgjIE7xNMrhFgQ/F5MyU2F3yPs7obwBMd0+Uo7vsDYaWuDRVoo7/SLar0nKTB6fSMpOpq0P7Jv2JyYHvb20YxPwc1GXQs+12ZIlxku7m9wIdYKNmMJq9hNF4EQJInSUBnhYOIF2d/FQdVdXgxqB1UBmYCuLs8IzPwAASxCx4uo+pzQmM30Iu4OyaqCBIodcT+hmw7vVHTwFSRlknFYONucI8GxngdKsFRGGWXabRmlEQymaRGyLSi5ggKkCZQa0iyoQkLqj6WPYnLRPUBI+X7LfQloAWfwc8LAd+pRnU7x9gXsOHumNPohDEsAfwRhZ3DTEg2/uOgZrQoLpi9aLWn6BuG4DUxHX2PmUVX0974Cxccqmk7/a6EwnRNEiyygPLvkw4cxifVt6Ae2+bkrv+dFtfgSKAuZBBlZXAeg39MnFCYrtZyAFVCYwGdje86uconlxqcRxTQ1UCENs/WxJnxBO7RadxEUIMox83wUZu0fKv5UdUW6jp9fAQ+44oPGIHjB/OSZu4OYk9PbhiwfCkQPcRL3JEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1U3Y0VhRWxZeEc0eG1NbWdUK0Q4RmpleVdBOXVSekVEcjlzb3ZFR2s2MWIv?=
 =?utf-8?B?dXl3QklJNFFuSHE4VldtcVM4d2xPZWFTcjAxNHBEZXl5RFNIN2NMTHhmdmNy?=
 =?utf-8?B?YzdtTWYyV3Rkei80cmFxSHgyZkh6a01tZXFVeG9rQVVpaTlkeSs3V3d2TnNp?=
 =?utf-8?B?RDVISEhtaDVFM3FRNjRVMVZPeG5xcGRoaU5XOUpkcFVIN3J6VDJVWUlyVW9h?=
 =?utf-8?B?ZUV5WEZZcE9LMFNIQVlMTnYvMmZNTjhiYjFTMjVVUGptRmlMTXV2U0IxSDkv?=
 =?utf-8?B?WVRoSUFMVlArZmN6Qmc3YVNsZC9YSXhMRTVzVjhHREJoVGY4N1U0UU9IZDFE?=
 =?utf-8?B?aVJTRkwrazZGRHNBTE1JRllUcnJGd2RzaWVHRFkwaktTVVJSV1pONVZLZ2Zh?=
 =?utf-8?B?NXVvK1hsNzZuVFFoeStaKzJOSVJSd3lPTzlwa1Ftekxnd21Vc2hFNTBPWmxN?=
 =?utf-8?B?WTRFSkphNnExQTN1OVVqRlYxVUdKQnNudUI1anV2MFdXOCsrUnNBYWUvQjFr?=
 =?utf-8?B?NTF4ZS90VU1DbEVEMVREbXlBbVNXUFF1cG83enJnQVRyMzVVYU82dXNJdktX?=
 =?utf-8?B?ZkR4Tzk4aVZOS3N5bjFlcWpFU2NVUGc5OHMyN3hDUGI2VXVpNDRUc2w1MGYw?=
 =?utf-8?B?KzlYVWNNRFAvSWZTRmowaFhHSGRLWUVoTUZpMjM1dWd4NVg2dFBvS0FSTDhH?=
 =?utf-8?B?MWpEbXJzU2dKL0hSMmhBRlpYVndYMmpuSHErNHlLZUsrY2tzVEtVYmZNTmov?=
 =?utf-8?B?WnVyQ2hmTkNsV2JKTUZTNXhLUTBHZy81a1RRa3JQNjV4U3huWjNkblppanJr?=
 =?utf-8?B?UVdBbUVVNWRidi9NQTFCdFdtZDZoYVdxT2lubWt1dCtaWk1keUZkY3Y1TlIz?=
 =?utf-8?B?ZER1YkF5RjlLQXVvMEN6REZNUzJPK2lrbGxxdytsZkcyNXJ6QXZLM0hFR2VP?=
 =?utf-8?B?L0ZsV2RYSFB5OWMxNUtvTkhGWCtpblJXM0ZSMURsYjVVZjZCcGllUDJHUjAw?=
 =?utf-8?B?UUVMZ29TNVgwYXZuQ0lleGhBeHBINCtvK3NxcHA5SFNZTVFmWnpndzFnbzQ5?=
 =?utf-8?B?VFIyWEVrNkxINWJXOTVtUTB6YzBkajRreUVHcm41THFlSFk4K0ZiUmh0KzFZ?=
 =?utf-8?B?WFpyZTZtVmxWR09RbnBPVE9pNUZYaWhFUHpnTjZnVFV0ay8rWEJGcWlNQnBR?=
 =?utf-8?B?SWdZelhOL2I1WUswbENGazNqQ3I1M0FnbXVsVlA3MkdLSGJ1TTJ5elU5R2Q5?=
 =?utf-8?B?MUl1VmUyUVFqSTNDUTkxaHhVNDNCZGxobU5XTk9zZ1hUbnQvUHBFTms3bmdG?=
 =?utf-8?B?L0M4MHd0cFVvTFcrMkFmK09ub28rdGM3UFJJMmlXZHFLVjlZRmlFRWQxdUgz?=
 =?utf-8?B?QTVjUUdRSnFPazE4NjVoKy92aEpFencvRGx4M3FnTndRRTJheVpRSzNXQnVz?=
 =?utf-8?B?cXJHd3Z3WDFMS042SHN3UHZMUkZucU5Ca2YzcExDL2gzdEozZGJGckFSUzdk?=
 =?utf-8?B?NEk4aG8xRU1veUFmMS94UEdaeGlDcFhGQTVTMjluNitMekgrZTcydFpLOEYx?=
 =?utf-8?B?RlU1Zms4WjJkUm1vT0dEamtvSDBJVWhXbkZPZnV4NHlGNUtyWnk2L3lVcXli?=
 =?utf-8?B?aTNzWThFVDJvNEFiN3BOVzEvajB3dzdVQjZFR0JESk9EMzNucHo5dzNSRDV0?=
 =?utf-8?B?M0E0STAxdk1Vd2hUZ1ArL2RKdGk2NFk3YnBWRlhTdHdtSFY0Q3NFZnlXQ3FB?=
 =?utf-8?B?b05uS3h2UE1WNUtTVXdjYVlQNlJLaVczWVY4R2EyZFRld2F6Q0xYMEt5Sk0v?=
 =?utf-8?B?OFIvbDN0eFFCWk5wME5wcDJOK2NsaXlrL1pZYTYzVUc0U1JQTkJFU3YyYU8v?=
 =?utf-8?B?MTVyZ1JpN2ZqYTB6QlNxMVZLaUdBSXJHVHhtdVFZOFJhMTJ3Y0Ztb2pOOHRM?=
 =?utf-8?B?aFFycFpVanJUR202RFluSXNMYlIrKzFvdU1oRXhiRVZ5dWJQZ1ZRcklJQzhQ?=
 =?utf-8?B?eWx1T0hNTkVrSW41c3hESVdLZG9jRTBjYVh6QlozNkdSZ2FJYUFla3kxZnhS?=
 =?utf-8?B?dzVYQ0dBVjRJUUlVM2hoNWd3Y3NQY0RtN0d0aVlVbmxNN1R0TzBCTEJMbyti?=
 =?utf-8?B?NHk4bTR6eEZERjBVZ1hwbWhLYTZuNy9PVHgySUJ1NGpXUllBSHpyTXpEMm5Z?=
 =?utf-8?B?T0NidjQydkJmdDA5Wm5FWE10YjZVTlVpekVKd1hHbDd3dDFCanlPQWxYbHZJ?=
 =?utf-8?B?MXl4cUdUKzVudGN0UDZCNS8yb1lSLzMwSFNwRlMrSXA3dlNLdmdtTXU2d1NG?=
 =?utf-8?B?S2JwUkhLYXcxTWc2VlZQbHhaWVh0MWE0TFVwZ1EvQ1l0a3FRQjM5UT09?=
X-Exchange-RoutingPolicyChecked:
	qYmSi13o3elHekF4XMZaQzTYy61mqdioNVJfi9tJ0Og3rs4cLD17HaP5V6JVj8XYUsl+0TvHiiMTeJQx9Lgk4T+/TMaEYretng/zT/ePJSmv7d7LYOPEVLXbIHBc5Jj7qG7EGL4fXnmrDnEbdQL1qgUZa6h0K7m3okG7Cs3iCvWJNm5BDiL4rb/ciklFArLBwUctKdHMzH2Sp276Ig+G7hxKVbQA9zIbDDkfkuWxcFap/2dLhGpiu4n328i3SakkwFW1wz6nZenA2M8xyytXCNm7gHHLQXl1hrnSVkezyMh6JbrJVgyOvDKcOenr33AdOad3J/btW/BxgRWwd1ielg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jO8rW5jrPahZwu/qEay42kYmxcJzb9bpLk0egw64o8Otk5hWsJnH84nrCZb2V19eX9rcQVXnsd+Y57kgt0B5hxnbOgw9pvuIVeMQE9X3mGRipw6St+mjd2AFTP+AGPRI5vDeaonGTwjjy8p0OwaAvqsaClZdUudASMEPaW3nouQAK0Bobkb7Y/V6QetKvz3ZYV+VQ/zQkGW2CccAOOQ1iH3y222uWpypyD7korfkMsttJagZalyL8w8+uYcs7IZcvOXCe+V6pnDzg8X44NveU0hxNG8A5TAHPMJ7L0kchKlSatDJ8glcF40QfyAwoPS+iNRmajD2SndGnitk7JUHxZVXvshUWHsji3inYcdaUacqgZ7WDeHAkl8tOn2Qpu1hiQ1n8IG52UxQS6/hpN9BAzu2iXpMayYY33QhKdtoSEP0DVZlKum3r/KV77pd0NYw6fA6P0prYkjn8hDUB/UYmpPGbAMheunDwBkEIif9GGYV2d10+FX6j2705YUAsjbRLRkXhy8i0q81vXtCKA7conqcU3SnZKKlh1nneVxnjgz650mCZ0SWb2yi/cgWj9kYqeyxkXppWeRBH+F8D3exk98f7+7WIJdyuNqHXnJlkFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f953226-85aa-46de-f794-08de9af2925d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 13:26:16.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0cEuEAuRGRuXmU6j7B+ukvH92RNRP8Ju6/im4stRETPztS8axs/xlPbOEZH56jtENsB/YjachX8LI8ZlD4PiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BB505D96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604150125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfXx/iW/BBo/Z6I
 YfJ5sO860qit5D0vwxEzze3usbUzdkbl6x3FM6XPXNivX+9Gnmg9yyQ0fD8A7ex28nfxeDCndzR
 rBgGs42JqrIbe91c0ZYqpBrHGnE50hO4ZTcKypvAIHitnU26/fAkz/nbaemQXdWS59sVyMrka5+
 +7KgwDV/Al26GugQvIDUb+OLMEX2nlyV26rmYh7ZMUGJ68lIwNptkRo5gjd+wMiwCbyPSFJblwv
 bT/fqnEBfRPdAzCEP+AAaGsfnGjj/89pnYmE0PT8jHP5AA3dpKCEWdbf8Rs8B1qnIUdnW9J4PZJ
 IkybA7PHNvF/4EY4Sx0Ir4G6B16b+F8PlZYZ2v2fnnmCMc2t7XgJBJImg6pGfWgEsbQiZGjn57A
 iuM+ehdCO6EEXS43pRa60eyu0bQKyis8jzm9jWXpaL55WTBpEY1iRcMctikvfmxiu91KLodbJcF
 hv43D2F5QH49ptzXCew==
X-Proofpoint-GUID: EOzBJJuCiTmIi0W5r14yTZlkULFA0Ian
X-Proofpoint-ORIG-GUID: EOzBJJuCiTmIi0W5r14yTZlkULFA0Ian
X-Authority-Analysis: v=2.4 cv=JY6Ma0KV c=1 sm=1 tr=0 ts=69df9202 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=5boGSWnKHZgLSiHxyV4A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22

On 15/04/2026 13:54, Jiri Olsa wrote:
> On Wed, Apr 15, 2026 at 12:35:59PM +0100, Alan Maguire wrote:
>> On 15/04/2026 09:24, Jiri Olsa wrote:
>>> Sashiko found possible double close of btf object fd [1],
>>> which happens when strdup in load_module_btfs fails at which
>>> point the obj->btf_module_cnt is already incremented.
>>>
>>
>> nit: maybe the subject should be something like
>>
>> libbpf: Prevent double close, leak of btf objects
>>
>> ...to reflect the leak fix too?
> 
> so the btf object leak is introduced by moving the obj->btf_module_cnt++
> below, because before that it was released in bpf_object_post_load_cleanup
> even when the strdup failed
> 
> now if strdup fails, obj->btf_module_cnt is not incremented yet and
> bpf_object_post_load_cleanup won't release it
> 
>>  
>>> The error path close btf fd and so does later cleanup code in
>>> bpf_object_post_load_cleanup function.
>>>
>>> Incrementing obj->btf_module_cnt only if there's no failure
>>> and releasing btf object in error path.
>>>
>>> Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")
>>> [1] https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>
>>> ---
>>> v2 changes:
>>> - squashed patches together, because they depend on each other [ci]
>>> - added Fixes tag [ci]
>>>
>>>  tools/lib/bpf/libbpf.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 8b0c3246097f..79d9607d26e2 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -5806,7 +5806,6 @@ static int load_module_btfs(struct bpf_object *obj)
>>>  {
>>>  	struct bpf_btf_info info;
>>>  	struct module_btf *mod_btf;
>>> -	struct btf *btf;
>>>  	char name[64];
>>>  	__u32 id = 0, len;
>>>  	int err, fd;
>>> @@ -5825,6 +5824,8 @@ static int load_module_btfs(struct bpf_object *obj)
>>>  		return 0;
>>>  
>>>  	while (true) {
>>> +		struct btf *btf = NULL;
>>> +
>>>  		err = bpf_btf_get_next_id(id, &id);
>>>  		if (err && errno == ENOENT)
>>>  			return 0;
>>> @@ -5878,7 +5879,7 @@ static int load_module_btfs(struct bpf_object *obj)
>>>  		if (err)
>>>  			goto err_out;
>>>  
>>> -		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
>>> +		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
>>>  
>>>  		mod_btf->btf = btf;
>>>  		mod_btf->id = id;
>>> @@ -5888,9 +5889,11 @@ static int load_module_btfs(struct bpf_object *obj)
>>>  			err = -ENOMEM;
>>>  			goto err_out;
>>>  		}
>>> +		obj->btf_module_cnt++;
>>>  		continue;
>>>  
>>>  err_out:
>>> +		btf__free(btf);
>>>  		close(fd);
>>>  		return err;
>>>  	}
>>
>> the err_out label within the loop is a bit confusing, needed more now I guess
>> since btf is in loop scope. only way round it would be to haul btf back up
>> to global scope and explicitly NULL it at the start of each iteration. That way 
>> we could break out of the loop to do error handling. Not a big deal though.
> 
> I guess you mean something like below (untested).. looks better, will check
>

looks good to me, but let's see what the bots say ;-) . Thanks!
 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8b0c3246097f..3a80a018fc7d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5852,11 +5852,12 @@ static int load_module_btfs(struct bpf_object *obj)
>  		info.name = ptr_to_u64(name);
>  		info.name_len = sizeof(name);
>  
> +		btf = NULL;
>  		err = bpf_btf_get_info_by_fd(fd, &info, &len);
>  		if (err) {
>  			err = -errno;
>  			pr_warn("failed to get BTF object #%d info: %s\n", id, errstr(err));
> -			goto err_out;
> +			break;
>  		}
>  
>  		/* ignore non-module BTFs */
> @@ -5870,15 +5871,15 @@ static int load_module_btfs(struct bpf_object *obj)
>  		if (err) {
>  			pr_warn("failed to load module [%s]'s BTF object #%d: %s\n",
>  				name, id, errstr(err));
> -			goto err_out;
> +			break;
>  		}
>  
>  		err = libbpf_ensure_mem((void **)&obj->btf_modules, &obj->btf_module_cap,
>  					sizeof(*obj->btf_modules), obj->btf_module_cnt + 1);
>  		if (err)
> -			goto err_out;
> +			break;
>  
> -		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
> +		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
>  
>  		mod_btf->btf = btf;
>  		mod_btf->id = id;
> @@ -5886,16 +5887,16 @@ static int load_module_btfs(struct bpf_object *obj)
>  		mod_btf->name = strdup(name);
>  		if (!mod_btf->name) {
>  			err = -ENOMEM;
> -			goto err_out;
> +			break;
>  		}
> -		continue;
> +		obj->btf_module_cnt++;
> +	}
>  
> -err_out:
> +	if (err) {
> +		btf__free(btf);
>  		close(fd);
> -		return err;
>  	}
> -
> -	return 0;
> +	return err;
>  }
>  
>  static struct bpf_core_cand_list *

