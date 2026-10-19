Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8504908C9;
	Mon, 19 Oct 2026 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398432; cv=fail; b=A4eO+PgZZfIwXIFrjtryQsAXD3ydaBoRUPKZxrVfHj9jorAEraFklWWYUVNbUsqh4Nm6XVTT9Bv0zQxEiylOZyH9FGzNRWrK7M+v95yI35aMTV2/Bu8fLopYQJJVD3LmngPO/TGmKNNu3rSujF1mtLiAirsyQq+wBKb+/Md/0kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398432; c=relaxed/simple;
	bh=pIgph5Mb4jECy/bY54mDFW8xT6I0d4lXY9oCC+G9uSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vk6BASaNdsiUdsp75juEazRQXMva1qvghYltZtgf9CCMnAbmsTj+cm2vmEZy/mowc07ZdQCxbWi1pgXJGSkyuflt+tCuwxixU0wDonX9Ln9evTb7SzXzL40OcyrjwpbeoIGaEqh+llruazSCf/oJkyY4wnNXNmfeN0s8XiOgG44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8creEqT; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8creEqT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf1h8zyjxcwFVUO40U9ypO+YC4K98AROZJ99LaF1dqa3AlmDw0+duJaRvzIMiMgueJYGK+Z+8fpMdjZW/VCW03P8Xjh/L/ETV7/fHy29LhASMH/ozG6Vp1JTbqnzX4g2MvFTjJe1M/xpm5z5ahXCQhM56qgwRp6lkQFcO5VtVe++crkwKo3+0/LcHEkrMsTD54DWRw1/rjA0zmnVrSPs/eACd2H31DHkSCOGqLiDD84zODEwoCC3HhwCn/GoxV+ZTBbgXZUauOuAk3exV9P1FBA9FglLup5WR8DkefU6JIHwDwNL1rkG3mUcbWNXmxGjgrMBKT5JCFzFjlywc80+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIgph5Mb4jECy/bY54mDFW8xT6I0d4lXY9oCC+G9uSg=;
 b=L4uodLcgWaVOZ1cJdCe6Js8FZFVWfUB8AFxhyNYEiKQvB4phHdtIGJFnVmGeTcI5rf9Zhlt7FGswAnJH453iY0afr1PBmNYWofkpd6IkqVCUyAdn7OjQpnyln482PxrmYEQs3tLyqo2toqVA8Lf7yTw0QtdirnwujrAwK5IXfKY4g93ucXC0N8YezxLfdE4LAUHQDw0f2ZFfedvUGD0qNxsMuEeas+sAz69o6TKoUGZdw4G81JSpMUSsSu24KLPcS1UoXybVUaNcYmYePm5Mufdic9QPNb/W6N5Db7mgpWoPY+CXyFIE9071tdfz5Muve79i8vXey16Q6OFlLqetHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIgph5Mb4jECy/bY54mDFW8xT6I0d4lXY9oCC+G9uSg=;
 b=f8creEqTNhaWDP0Muo7omH9pLkfD6g67eMDSY6yFvrygyO8Hl3rvGo4aG3CO/7cmgrFBJNIa3i4sCEbXfyw0wkQD72ibwccLjagY1v1A69nr4m6IJwcAJDU4N3+q2ZYpX5zVhORAXuuPBHl9XKfOGvpqfDvWU8OdOOY6H3zg3ZL1iuP12pXwbOl7Zw2lRIesorOtMpGcmzZw4JnwgSLY3iQjBf6BKHoXWAiS+ivWjvHqD1lQRBDxzLxxn7pDxtNAgSaoj5u61LxPaRdK3ec3caZNr1T6/Xv4ChRNR2PKESmCw0p5ejyZagUbtDD70QZWiY3UT3n6DGmgbRyVgKBy2A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:27:06 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:26:58 +0000
Date: Mon, 19 Oct 2026 11:19:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/7] ipv4,ipv6: convert the getsockopt
 switches to sockopt_t
Message-ID: <20261019081907.GA2725184@shredder>
References: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c2f494-8b0b-437a-e29a-08df2dbabe1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SLUtyGINJKdtS5agy65u6mQsIRt7ycL27dmGe1c522VtofE2c7M3HnuFo12duPTU/rjyn+RWuf18B164lZhwI3nONw+E4rjqnxpR5dNWI6939SNVvjSU3jQQur6gVLVxlp5hquGzLH/MbuJNB2rnMzFrTLt4zvCEESCdzceZiFNX2epAzfCPSs+l2seMBtImMkYwP+LWKTFQkEOfmTVS067zopcht+6ZY4lIAm0/eCv61np5r/Kigo+y4jLTxDAMSEW9aZXC+7tJB0icbJ21+Z90zGucBawoZZiqDYaan7jbyTndiT1/b7PQtWMkTsPP9mwZ69Sb74myeKul3flKkCAw/6h1JfKINNd8M/tbO7wVn9aY9iAB4md+douyDePuemZQ/Qcfxng1s6B3O+Rm+UmP9RU1eEDO526VhlvgmTaHg/DYb6hIoH3jKlOb9lFhHlKSO3M/GY/uw0Le0eL2scmCpTVxtwyPsdo+i1B9Bnvd5ISP47J6+VhozYHwuuWIZMgqQt3tcW9aBRZesSDB8u1KbfZAgedsaVTu4oTMPgBjWSbZihhvx47/DuAPj35GFW+Qfl3oJ/EGx9WLqE4K1hnBbOuYXyUnlLOZ3TWOsqT/BWSjA9vZeAs2O2wxAsK9JobIhzpoKCOZhHVFxlEbxJrUbDsZSvmwJMkEGPfyIxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ov4FDyl6PacIaQXjN9jCoA4snNbNhVzmkss9aqU0uxh6VtUujnm8jV789OK3?=
 =?us-ascii?Q?xN2jtXpAcKvNcL1RhyfbSD9V1ygytoXwmGRiPXSvqB4UwBbbokXMRCxKBmts?=
 =?us-ascii?Q?eQEcvSNNtweB60UE0GGP0CnS0xZoMTiKto+/O/6mN0eGgsRISueumTSY+fgd?=
 =?us-ascii?Q?l19URc/m8AVgyHkVLAUWH4QiL/PP5PpXGABa0mLbuajXyAe4416PWUc9/16G?=
 =?us-ascii?Q?pe5/+sQie2VfGP+/3ibDGK8l+Em/tsdDLRfokQHF6HMQsedOSKC7W80Np0cf?=
 =?us-ascii?Q?QNuX6oidD/KBE72usERPnN02nGvJQMcOIHxWxU3bffdF8XmvyOUOtKfvO5oQ?=
 =?us-ascii?Q?5NfnWq4q7BsSnhQoLHguQzEgDb98x0Buc2vF8TtAy/UbjYkDLA7U7zFi5ObF?=
 =?us-ascii?Q?P84xESyiO5DHGqicLPJQf/Stt4tbvi9pr/fNvHDirbhIi3P7LiHsn/U+LCr7?=
 =?us-ascii?Q?Bj27PhMv9oQVhPKWxYnS9wpTNrmlNqIpXLy5ENfFtZPWG5kKvPn30pSOmp0c?=
 =?us-ascii?Q?MEoTCwI116LDkwc/i7255tk9sOzVGiVMymfRyecYMBYlbxoeUEkJeLcwlDod?=
 =?us-ascii?Q?rIalYX6wh9vC9vEf6NA8PvrEi42GNMgs14rY3m6P/HO99geEBRpiCXxn79BJ?=
 =?us-ascii?Q?GfVqL1Gq4RmpPQqKXu73GlOT/6IIcEHkvjYCs34bv+p9kdJWhFWuAsZocumy?=
 =?us-ascii?Q?L96uvTAnayfnrFeLEtrKXnjnnVPo2TKTqfCrgs7N+VGpJPhvHhSB+knSNWTw?=
 =?us-ascii?Q?UhsMdjDS1rP9JaS72rRNVMsKohQJCz+ugdvlFwFouA5EC7aZSlwqA6kvKSXb?=
 =?us-ascii?Q?8bjHlbU/ikFgq/1i56uq167qz+jQWwdOGxpWO3OHq3Uk7494BimRaAwZVUUA?=
 =?us-ascii?Q?dh2vXb+EyL5LqDrnvnmj/xn9lEtNCR5h8aWy6U9EhNGCXHAeyUX+qTT49FvM?=
 =?us-ascii?Q?qRkx7nHAK2POSdlxG2CsAN+pwfwGYlj1KE2zR0ewi+D8nAz+pvXeq90qEtaQ?=
 =?us-ascii?Q?BFtS6Iyauec3clse2kuEdoYf7Ws09U5OP/b/JzttR108WCETj8zo81wwALh6?=
 =?us-ascii?Q?WG8k0HN3ajsLURG7PTk3b+AlOSN4woKC3a7HV98G/DZaE0oEyyjPuXk+ujfz?=
 =?us-ascii?Q?A2KUUKzdWpUF4EBDMkjcHMVxrnq0CPtiu3w0sQk0VnXkqMIb+Y2uDBAAlOtd?=
 =?us-ascii?Q?0F9V5WscKIOFW78Z5slGSBrDLJKju0ZgzcvMS0ZXv48WNSZvuqHqmAJ058Ey?=
 =?us-ascii?Q?7ljaQrwwVvdj48Yt9o0pFOMzNjyA88pB4HIqBeybPK5mxTtShXsbUsXyZbqN?=
 =?us-ascii?Q?p8ASpox4JYjwToRieN25nggEZ38IOJOr1YZ71K5gltjeCpXKg+mdFDTlQlRY?=
 =?us-ascii?Q?7J89Ue9EOBibwh+nhdx10l2p6+vw123ZlZstSmnBHc6mxzFLb4Q3D7OYZc/v?=
 =?us-ascii?Q?4KhUR35dhl4uyC0mpXYFolAHmOp51cmv/hH3FoZoWEzAiZ0R7OjmPRbBL7t5?=
 =?us-ascii?Q?ET8UyWBlzbEn50rEAOpdlaexOr+TJ1e64da34w1Vlpk88wtX5upyDuxR7QNP?=
 =?us-ascii?Q?tS5HVuNuFDJUpxVISgytkpkUl83QDShCZWWJZ1BSuapEGPwzO/VjFmolKy3a?=
 =?us-ascii?Q?+Ky72+8ThvPPl+h7rDMJKp30HRsmguqiD/o4lIjujXLRYrM/vhH67PMyn+3E?=
 =?us-ascii?Q?Y70LwLIFaeX7kLrsJORVRUbOWnJXJ40HVX26PZC7fdrGQ1LR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c2f494-8b0b-437a-e29a-08df2dbabe1e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:26:58.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujEv1GFbpGI9cZYGE2hrpZGLHZaKuSaMeu4x+WNaklglUUiTwqFQoyhbpMrtqG/7HuAun73mFwdXNtkTzwRWyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

On Thu, Oct 15, 2026 at 03:05:29AM -0700, Breno Leitao wrote:
> This series continues the migration to sockopt_t, as described in [1].
> do_ip_getsockopt() and do_ipv6_getsockopt() still take a sockptr_t pair,
> and everything they forward to now takes a sockopt_t, so convert them
> both.

Acked-by: Ido Schimmel <idosch@nvidia.com>

Given the user visible changes, the fact that the merge window is now
open and that this isn't the last part of the conversion, my preference
would be for this to be re-posted after the merge window.
