Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5737A831;
	Thu,  1 Oct 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863814; cv=fail; b=LD0nuMGxpCLjF1tXb4w/h6tO40DnIx0qK5fjiWs90SW2oJxIvJcEJNnkowT7FaDjo0dnP1BzmjdmH+H++nR/WHoAMd1+Ay2kNUu/mq5kJOT940MZthgvPkE90aJCniLRL173Qw8J1/GF3ytCuVxXeHuyVlK4JFwwF0un6sCnuoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863814; c=relaxed/simple;
	bh=ZhWyuPP1cQVlj4FKWkJ/K9LZmpYso2yl8et7lx71TTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCWr0r6ZGzc2NkubhmflZ6QuQS3zSpcO/UBp2VU/vqgn5ddDBJ0UhjaebCqj9uGydSMNTpfb6F6I7P0X6MEmQUNUw0bgXe3Td2JK8E0tUNjKFwkNN+hvF/K/FCNWGfKxyYy8NSgcMJV3QKnUvSZupR0sgMoIXBEyaCN1OYS9aIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KW1mICqF; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KW1mICqF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOJos4ionIQ0FXxo+e2qtS2TDljHRjnrP7D7V1z0KCuk2ddG/h155NDdP1zTm02nObaMlahTFDOCVJPwqDc+x8WLUPKy3sgEJ534G+kFAPi2uE5CTWd9mtgq49rjKAJF13HuBhSt9KdSSwGPVgKT3pQALTLlmaabG6jlgBW6q3UVmrrVG7CEUb4vOUggkvVVu3FhEUl0KLwaJM/dx7WiWeIIxJo9bvGp8ZEOtB0rC90DkJpU6kAM3FPM4ODyvKRplMtUKsI3dA5csTw9VcebwnwYeYV6ssxWEguW/ENB8hgmpWgIutwjKYgyxFpC8XObL50DO05doVNfPdZ089hPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+CdleMGgSJMIRIJZR1skoYx75Co74eOfctxV4n4E2U=;
 b=xU1YuZKqxS8UMMbfzpACCoLi5pEYNOjRoarFK28SFqJVxGuAI8nwVgDFKWVXW8UiMBd4W8/bLJb2td7DKCvMe9/PNmUDx1xqxTxjrVeYr7fRSbg3aEzjc+3ayJqr59xp85/a9DhODJXNBiNtAuhC6nj6hzMgIC9YdXwbWrDIz8acMEcW3Kef3opKE+MuwBSMC8AHfo/RZnq6Oa/9q5RJkVJX98N+905gZe188oadhJOcZIirhxQv9v4E+X3LdZBjxmEzBX3MAAjxrRUOKqeNV0ck4fGKjwjH0VdBBaXqMAcG+FT232pWcHz2oHjDsuHff/OLm2hzvuqfuWuQF5tRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+CdleMGgSJMIRIJZR1skoYx75Co74eOfctxV4n4E2U=;
 b=KW1mICqF44CQ048Dhgug54qXsw4jxLkTurBRbVnHQi8eRycD2GLhYqba5OjcoTEbZ6Ow1nrIWg0n25bU5/rUicIAJu+wMOgyUw4QqnmTlwQN94Z3B9ejNLLoGBFiK7bUyjR8WMvqdjgwC1QMvtC6kxYdnsvxDZR5ldix1h0u905O5zAV9DxGktlBTBERkVST1rj2FJMdGnPcwAc5PDj8ro05AfORzLwBxky2m5ct/ATEgaXjpPenzuHubGs0LCfv1j9h69mjHOT7vQX9wZloQuuYtAy6Z4nq9Uvathv7TDoNlTJOfIpEy1dM1TPPyXeY+OpnETqbtqbxjllJtJu4lA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 14:10:07 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 14:10:07 +0000
Date: Thu, 1 Oct 2026 17:09:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net-next v3 1/6] net: lwtunnel: change encap fill order
Message-ID: <20261001140954.GA1574391@shredder>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
 <20260930-ynl_rt_encap-v3-1-4106c21b9ee7@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-ynl_rt_encap-v3-1-4106c21b9ee7@kylinos.cn>
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: c95c3119-1c10-439b-2de3-08df1fc5b296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|4143699003|56012099006|11063799006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2OQnRm+/ErIiKgwQp5sQS60O/PF4cYybRxZTThSvr0znuUWRFR6h+125WPd3UZKLEX0dOoPuFABhsLnFq7nb1z+bbORFmIHMnx9bZe+nNEsiEDovyrvlv8UwN+xtJxtRRh4XIprEfmi3vODYEbx3lrtj6qJoBQHt5NXF8a08O95SygG1LN+Htreo6Z+7sr/ZUMYxtxhFh2ULOU/mAodjOmS9vPiS7v1Cj26UoZt4JoMtoHNQ3u+LWyZl9n7Z3z8g/Vz/3xJUkFqYOJFxNaQ32sXEn/a8mN20RnQ8MLwVSVNaxXT7i9OPswgUPtnn8g3HKSRLllskOD4Ff6ZinAWYR+ZRecP1z+qdE2wAe4YrWliFrptA0Pcx3+ZLjmYmVsFn4wCaWbtLX0Alf/sBIYomT0Bkk6ozkO3pW6rz+V+DJrrRd/rqcH4NuWLMuqDi8mCre6cqi7AyayC+IM//fy1foVVlpomPiGGrRvgpjBe6FPElU8ZdAvNBS4/ECdgUC1QsmAbuFv0IH4oICr/0vAe4gftViuk7jkTbTc0JSvD5E7msoaHx8yQoj1+hoB2pDOqP8eeVg1flNCC+lY/n4oUPoZ5lQh7FfNM6iyB//FlROsDLP9Il+uKuFSQQxmLfUDOTUicOMC9M9CqiZXGZCZY8oqt9twf93MegVil0X9JPabU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(3023799007)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IX40ZVGNMi1JCoU4Kfq87SD4kS6ezsLhAhRLr2NO/OHr0d57ZVLsTm/pygJf?=
 =?us-ascii?Q?6xOzRUgAoMaRsW0bxQn1l/OX6xInzX2D9pqgfD1H1fT3ReHV9RoLOwcIYQG1?=
 =?us-ascii?Q?2AQilcGONOWqiQTyw1U3EpOW/om5eZXtS4xKItwBW7dS9/xmFF8B1YlZoKVX?=
 =?us-ascii?Q?ecgEmWR1IXmxaMjSctkTRvFJId7Sr7/aBRJlxFF1tp9znX1eNdpVrnySwLpW?=
 =?us-ascii?Q?kyOhRBOqpfEKHiqbSRg4fUIBEu6ErkzDwvK2oPW8+I0nshz+M74mGecSxlJZ?=
 =?us-ascii?Q?Y8K0zenErohROHvLCfUAzgAfUT+JfnLiIseETaoIv9GriY0T8Ln88r+8XV4v?=
 =?us-ascii?Q?Wg5GiFLv4Ez+SDUcOw4sywYCwR3P0fcq42eSFWu4KFPBszVPLleBWrE8AJAz?=
 =?us-ascii?Q?lFIAlA5eN1T9ibivyrDJCSIt1h3yxcSEkoqnuKPGceOzTiBuJfH46UKRFSGq?=
 =?us-ascii?Q?Twb69YHp/QWNKDyFUPF8HpGynLcDz8T2VW3EhjrV+mzaUpOesLpvO0qK47jy?=
 =?us-ascii?Q?sGXQTyQpbNFeHVWbdv6Bw7h9Yf5F4EJfkYpsj3LyMZRWTogQdypWUG4Svcx4?=
 =?us-ascii?Q?tdh0NRCOqUBjMJs1IntFricbU1nK+1HbIUtCs3JYawD8HKemZmN2ccmhFjOe?=
 =?us-ascii?Q?HbjA4xd3WAmIMNlyHAVa5C409hUL7tOa4VDRaZFM2NpY4YQGCMlKd969TM1v?=
 =?us-ascii?Q?ZwvTmU9J10UJOMsvT1YETZdb7ygwyGmLsLmrU9lTKTHUcxjeGyOCEwiAdJd5?=
 =?us-ascii?Q?GeORC8rKrhnb7BVC0cUbPm6s9YnFg800OjOFVUPi4WlGxzbZJK5Wxb5sxraS?=
 =?us-ascii?Q?8o0+8XnX9QungsED8fgvtEb7i4F8UWHt5Dj8gRIWjzhD7M8ktK6yPgRkyYQN?=
 =?us-ascii?Q?9jghbOJD6V+C6Y+87rWf0pctLqTiBKFYKolAIgeWKvCXs3zvMlRi4LOLyEYE?=
 =?us-ascii?Q?kRj4bCBdahgUQy39d6NkUhlr7eGNMljBCL0+bA5Xdk0oOfpctVLefq1Ym9W7?=
 =?us-ascii?Q?Ib1jhRBNwIABWf7aqdZ3tKEhdz1oYneRzUFtDaYYfoBFklf8ybjmujcvil/R?=
 =?us-ascii?Q?DLAXZ882WPY42uRaQWyDUm4kHlNz0L4V8DvwF6q/luyvammSHu/dQBH1HPqN?=
 =?us-ascii?Q?yXuWyyDHIsa8udhoX9OvAmh4czPvp0KHKMHbFnVjeh4k5cv7OCbNfZhhUXMD?=
 =?us-ascii?Q?IU6bQgpB3qCuzwmFpbcCMbdx9y5nI17cu+p/eICpE6/jQENu2IVOPWLhyuxm?=
 =?us-ascii?Q?1aV/cr/HfMwJH5kCK95dibByaoB2w92wKCh9PY77A+yBNvGbgOopZvjQbj3U?=
 =?us-ascii?Q?ETOrmpduMfejEhOLAgZczgIky3RTpSgrocSR6TKkkwqC3A+JKPzdW6bD/Xv0?=
 =?us-ascii?Q?2CJ/9fVLycMHySRgGtOU8u2zYQi6Hi8UIXu4jjOM/d5tZ5Ob4DHtXVscW7Y6?=
 =?us-ascii?Q?WeeGqrm0DV+rsksDpEhGT21QaTlejj1sP69FnteZFoaQGBANO0vGse3ilRCh?=
 =?us-ascii?Q?FFQ7rBbHuUaMKFf7WcuAUTgW4jEQKtuse8Oh4/OGLSs/cCDgkItOVyU3Qd2S?=
 =?us-ascii?Q?JT5a2OuGpiQfVTrn4Xb77YjeWqPup7m/5OOjYKD0DBRKy28YnmxryC58t5d/?=
 =?us-ascii?Q?1pdBLr3e4NGE78E1sCklaMeb0y5ZeUvAJdwjupdndykBiIOyr7vYKUlcNFrA?=
 =?us-ascii?Q?njc+Utz87Chmuk5nMDHr5Ss3jczp39BU9/9O71qgCmasthBuzF0RueNS1dFf?=
 =?us-ascii?Q?us3b0ytGPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95c3119-1c10-439b-2de3-08df1fc5b296
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:10:07.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isXl0h48ljhEKg3rMgOtSnoHqXfSzCm7VY4+slFNCapXpOaSCVmPPburph6SEB2+ts0Bcy4BkBABx1EhLjBXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866

On Wed, Sep 30, 2026 at 09:50:52AM +0800, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> I plan to add lwtunnel encap attributes to the YNL rt-route.yaml spec.
> When decoding submessages, YNL expects to read the "selector" (encap-type)
> first. Currently lwtunnel writes the encap payload first, which makes YNL
> fail to parse the lwtunnel encap message.
> 
> Fixing this within YNL itself would be complicated. Instead, reorder the
> netlink attributes in the kernel to output encap_type first.
> 
> This is a preparatory change for the upcoming rt-route spec updates.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

In case the bots will complain: It's OK not to trim the type attribute
upon fill_encap() failure given that the callers cancel the entire
message.
