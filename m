Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D025F7A9;
	Thu, 29 Jan 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678229; cv=fail; b=sazUp/cAv9GMJ+i6nKIk4A4ouwe1sPQ7STLbHg7HCZgANyWYSAxj4K8WyC2OAqPOJrz0TN5tzgJ+dTR+/qL8XhPdg2mmMLr4y/ccWfBVD7Pbd5cQUePLy/zFV1+CtH/iCvPuNchZuh13tLYLeKF1gu2Yt1vB9PVW1y/GkeUNeVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678229; c=relaxed/simple;
	bh=H427v+mTgoCKxca/20demqdbOruIemHOXB2lOZKHRgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cNe6Kqod0EtNVshkZRPvOUx5W7DqXUFCUXFbrIYr0ZMdD5aPfSZgls1IIRGHYbe/YL0agnyum2PBk8LGS3K4BaCmFkscwOuHMkp7W42sBxnl0LdAoWTT5UUmFA2me7nWwVwFTrkD7kZQl+rc5Pt7zHtTHw2ouJL33qVP7HKwY8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQgnJAjV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nr1zqcGn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQgnJAjV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nr1zqcGn"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T6Hh3e1232018;
	Thu, 29 Jan 2026 09:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=c7k9UuCUHC+8MKMfsH
	/3rh0f6FcXQ9DYr5ca0mHBBiI=; b=AQgnJAjV2vtalSJLWRtEMTWRFWzUTLAHS2
	ykDinKCbUGFPYbildQI5oLWrgJp+oYN4MBiSg9X81ZPAT0cgMv9Rw9dDzapQZiRq
	RrlaH4wqtFLb7Tdl2S+UhQ+lTYZbACnV2QPuEn1aR13KXADcRRz9HK6pUikeva1h
	uwGLVj7x2jzZ4M7Z+3Y7AEVchkDXTEbo70J5+PSXvd0zQcaE2iwXD2DdHdp7JHh3
	VWcusMY1d51vLJ86te466u9vGlfvX9L4JFHnw9mS7IR/jv5MDhwhFc+vCjCVG/mD
	lNruUHMdNbmJPE11DkgiDX9FFe9rQDjsXvz+G26m/1nkA6RKUsqQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5t6ajj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 09:16:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60T7AHXu036075;
	Thu, 29 Jan 2026 09:16:44 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhrcc44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 09:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBXxDnM5887pZQ1AsOpbW/agSWZDvXU/puS+fcQ4ippeZ92Nbw0pQ5jrFtOaOtl16lOaIITTeESlXYJ0veu+pjzFEhFnYKMnLXJFHBQmFPNyKt5POqcab8it2jhawv5I2nWjhrN/vGZ3kEgLe81dzFsP0IvaMgHMDJf0H+tUdsJpaFeTNEwrzJ2LCupBNv6cqoZoHKJEqyRsfjJUIoosUpRpn7Pj1ii5IGWmTdNPom97QudaSNvVUrL7sW6SzVeX5egpTFUT1o0ax1O+wWPcfz8Pj5oyfgMvBqKNsDcD69qtkNd96JG8aHmiQrauldfTr5JXid79IXFcml0JPVw+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7k9UuCUHC+8MKMfsH/3rh0f6FcXQ9DYr5ca0mHBBiI=;
 b=C1M9nMF7JyGu43odKSXXKFQrpNJ8S8wTIMQx5yNvtG/LEbfjjToAM1I3JyDYbNr1CQwuDthsbJXd1IY+E2zrlwLJyHFqTz6dakSYQ85fbpgQitKvM2CzUayQ4XSJik/bc68jQRF1iXUimlGDoy664z64KHJDFvOI3wUN4HYOeRKkjc0+udUycT+TLKMEuDUwaMj8GnLX0HoY0kvnRRr1j4gBTEwn0vJehIBgFuOTSDAM3pupbXl3NKlSoFb026OwV7xunPgKAW2P8x0cKOlBA0o5ISpQaXmGjkG3KHQmGKwmqtrv9k8DXJAUY9eNPGlVQLl7/CSkKog4NHdc/I4JDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7k9UuCUHC+8MKMfsH/3rh0f6FcXQ9DYr5ca0mHBBiI=;
 b=Nr1zqcGnXQHx0bn+syHZBkw8dTRG7JxrfdxQF+XowcF2mBmeJlmYQIDt++tgoySwJoFalt7MFLioH9h6UNR5H9aRB44TLDb/anNzUwmCkQhh8hoBQAjdhOgqpn3+9PJDep5w/pGITSKNDrKNzrbklWzfdNDb8Z6tvgbKLRRT3ho=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 09:16:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:16:40 +0000
Date: Thu, 29 Jan 2026 18:16:30 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 18/22] slab: refill sheaves from all nodes
Message-ID: <aXslbsUK1LXfx510@hyeyoo>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-18-041323d506f7@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-sheaves-for-all-v4-18-041323d506f7@suse.cz>
X-ClientProxiedBy: SE2P216CA0060.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: b268a218-4c2c-4839-c181-08de5f171cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhU6hyiqkC2okzsrwgL3Gz41Obn8ZhwLXVPPO+IG+iEsdbqfQ+DAK+txWiGO?=
 =?us-ascii?Q?bb0t09FpmKGNf4xAt0pvZFMjdZgWz/yuCryLFVJ6KJ2kh48p2NOavZJCFv9u?=
 =?us-ascii?Q?27pfRXf8Qn5mNyaMx9JfJ1S4Lff795Pq2dNXuPhQgoKZqlABW0dXNq8YnBsY?=
 =?us-ascii?Q?v7AhqW7H+Vd/baWLVXzlgdI0yUijTgnvo9c9J2PEv2IoAeeZx8q61K9oIY5T?=
 =?us-ascii?Q?q2mrZVnGRksheZC6rKnA9U0ykv/teDvvUvUgAsFXbXIR877BgG2Kcva7LTkx?=
 =?us-ascii?Q?wQJgQub2C7jTkMjoS8SWtY8rKlN1e3vlCn+8N9bGhNtZZYXnE9tQdZ5QsAut?=
 =?us-ascii?Q?GYlWnXOAeF4KghyEQuEk9N9DVHxDhpwosiLD1GXyUwQIGnEVPCINb0T5UcjU?=
 =?us-ascii?Q?yLz3ZnqUFQquPmUFItrQ/bieGj2I+4h312yfeJur9xfnVm/9AO6dCeVzsJS6?=
 =?us-ascii?Q?CrmOmW2/AyLoXGIAkXNFmQ4I2+DzSixprNghBqe98pbOswNuSVXtxJxavDe1?=
 =?us-ascii?Q?RuobMoQGvgDEP5fzXuGxiqZQ6sSgfM4chRo3TSVgXU0DS1NjpzBWLS8cLxpX?=
 =?us-ascii?Q?SPFrEDF0xh1hUz49vaOl52XhsiqxR8A2taWiGuo0+KyVXn+3GDsKwPpvpPuk?=
 =?us-ascii?Q?ZOal/Y+u4UWtCa77aUFjcR5x7tjYjYxSZC50bGZkK4ulwsitrFdZJdvjh7dI?=
 =?us-ascii?Q?l3B87N/GjOGKQRvA2jMTLpwi0gk/DdENa4S21YuapKgC9ZCHujf1EwbkC77C?=
 =?us-ascii?Q?ayQaQdNX/53SDD+k+JGEEJ6M3LrFCTwhSYKCb4LgRoco9qoAM5975oUvcymq?=
 =?us-ascii?Q?hVN+bL/uMvrpjZNt1PDtFkLCmCO8qX1cFzRF76RXE1Eo5vF7p9JLiRt6b9Z2?=
 =?us-ascii?Q?rk6+jkGBQip0puxzw2dUuWiCAARd7dWN1b4DPC15gfjaHff02Tm1Fw6mFExN?=
 =?us-ascii?Q?cgT9Vov1qywfTLrmy5haa7PXUU1hirQaNPnKzUVJaoU0wNXrZbIlB2fIsq+G?=
 =?us-ascii?Q?UslPOk/LOYFjdVidNppXQQTe2TKW4C3kfoGWuLbnvVgbfIC/YqiosGfCLVl3?=
 =?us-ascii?Q?uzimEVj4skuYjahyMhoKpQxIJFtC+zdmkIXabyjFXZLCehJnqWYziEk4dzsl?=
 =?us-ascii?Q?X4AbJkHSZCCQS6T9ZqnGJY2/NXvhbafxVgJF6CO58YRyFYEubb2mGxGo28Ue?=
 =?us-ascii?Q?SR5ZIkva0rTubOsGvDYzkWt1e9TdvE0LB3Tc+mDdUT8+mSsl2XBMSw3XcSc6?=
 =?us-ascii?Q?Z8TBLL6NLzhzS+KOXI7SKFiAfazgz+qQG4jlxG6rtLbjw/Nb72DmAegtlvtQ?=
 =?us-ascii?Q?hsx0006M+Vz3GoQUxjluNJ9ZTDmLKdJedLeV5XcQaHizMqLwfDLgNZdCdW0+?=
 =?us-ascii?Q?o/qce7ZmT7NNHrQANTgggQvl19ZC/D/LUIHOK12Xc8EBfAnTuxSIBr1KFLAe?=
 =?us-ascii?Q?sznIoKew1ynbT8yAG+2zli8PnWm5ecxGZkqhpxIZ+Gj1mF/tF7fimRCMrAc1?=
 =?us-ascii?Q?rjOZvyVsytOWj/x6C+WBf0geGNgweu+/qR74Z3tUWWYD22V7l530C0A8CfOv?=
 =?us-ascii?Q?dn+e5Mk6SKodWcrRSeA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3iVI+azNZyxhVAo6Hm6VFApMvFzDAlEGoizFoFKALIveq2bIittHfL+e7Xwa?=
 =?us-ascii?Q?UtfEYj8lldJ/NdmIlP0CKnv5OC84mgO2t8sniarflVSn3PUVl5mrlhEg2hk8?=
 =?us-ascii?Q?4kheY39UJBxvnVD31VWHdZIGhKvPYMan/inrUBwrARCCCIljUg+GzZ9xQpsG?=
 =?us-ascii?Q?hP/eVOGLNlNlTcmxJi47kDOCR9qlIea8H78p2W9vfQ/P4sebw8jtG+ZHBP7M?=
 =?us-ascii?Q?p7de3aqL8fU4j8ic4DfKp/bBeQ6RBWs87QEdn80tXTmZL8DLP7dS142bEwd5?=
 =?us-ascii?Q?3UbQuLtDbs6P1v+w1055vIdQS0/fzgEhoFx/25q/x/XyftZL6YnH+Wkj3OlG?=
 =?us-ascii?Q?KzA8k+4WDRnheQ/OVwT4zncOon003qB0xyz0XxdvyZDjYMAZBK4QYS7dwaSc?=
 =?us-ascii?Q?JHBV1XgO0+BA5O/eB4etyawSRL+f7h5diosdQ/ves2rBPmVL5WdyUQE8SV0o?=
 =?us-ascii?Q?9/je+XYAMVsKDBza2vUJ0NSo1n2GRhvPDkBx058noqDLy7I//1SqtDN0g9rb?=
 =?us-ascii?Q?490FR05QUpa+tDzhWGf2N7pAm+AI8GdGfqzKGEkbyjlp8Lj8CGoMWIrW1BwS?=
 =?us-ascii?Q?lqFcr1B0ISkgPMNUCdvLWFtg/Ar+L3hmrlY/bvRH6E2ujP8XnfdNLCd5ZAKE?=
 =?us-ascii?Q?wv4dh1Y9zy9gUA8+mXn628viydVvB5LUcm6E3RhfTCuOhO1u6RIlOejeVXWX?=
 =?us-ascii?Q?McZO/qPd82CmjzYO2V7J99Lm7zQViZuOPHYxy/8derIH5U18r2XGMiKlqsid?=
 =?us-ascii?Q?cLWOhinqZBnKIapkqjlDkXCTL5gl4w/yJp+mAajehYfwopBcmEpBebvuo+/j?=
 =?us-ascii?Q?TGOlLkMdgXvhxe+K9m8qUW10YIWSE8UrJfWbS8LqPM2EplsLqXqgz3d1Fovg?=
 =?us-ascii?Q?H3cFh9W1gLvNTrpR+GzQLKtNMfOPsXsEqc9hoU8KFT1ulAMCOKuPRnYrI1Ab?=
 =?us-ascii?Q?OQdxIb/AF8Evb203xcQgriEyNL1FQyvyjFHxXYmCTFdtLUYgp8eJ+IQr5fSU?=
 =?us-ascii?Q?xaMPTup+CAyZkNX/PJYWOFomuvolMT5ypc6bhkbM6g3wVy7YOar8RGfuKoNc?=
 =?us-ascii?Q?Z9fiBcSnArDNR2XOJc3Y+uWMD5RJtlwqbAa7VVSqjZFXYUs2wIsAxsrKXM0t?=
 =?us-ascii?Q?OW02d8aZYmOx4Ih4pF8YnNMvzSGPjjf0Tw3TJEj7KsfPeU2rMhuyvmysiSYb?=
 =?us-ascii?Q?A7ASSVLWKENkNAuQlt/Wydx7tsDssPrMVOlLDnTUgT7uzlCURDuWHvO1wHIy?=
 =?us-ascii?Q?qPr1HlNt4EN3Mgo6mSQMkc4i0kYPDu4LyTQBLH3BhqQOA9glYyJNInNVA1vN?=
 =?us-ascii?Q?qkQgtA3YA0JlHO4t1FqrwYVcujBDAz1H7tAItO9MjlltR+5iJBcAAQsSLpMV?=
 =?us-ascii?Q?AMs1IBsFjlCjkzD4H4hjrDDpwt6S+960HYQJCEzSjCPkxo5qQKjoErDTy8rX?=
 =?us-ascii?Q?Km+dJEYgz/Mo9KTYDInuB8W6Tbn/m/Xqh9UsTvVHC1D4XCVzV0/SJeBPXWcY?=
 =?us-ascii?Q?bHsqIUu6dzl/6oKYs6PJngJosjLc5Lsn8xF6r8Sx+V5zBX99HKh0/TK0cWm4?=
 =?us-ascii?Q?pEEVIr/iDoc9Cq74/F6uDfUB0x1hBeDir5yEiYpKcLA6GiTOp4iVUu6vYjL2?=
 =?us-ascii?Q?nAFsMI3SvMV891kfOWMGBYPc8Hy4DiKd3b/++DhB+x9M8eCCQXMlTAVFS0Ak?=
 =?us-ascii?Q?Wvb+Q7epjruvlcPEKCdmY5CQ3LSf6i+YxT8bNb+3sEdNFZHqN7GosgxC7grn?=
 =?us-ascii?Q?JC5CMG/P+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BsqeqUc/p1v+jlWPj6gpj5eMdjoQur4UNZ4mXOSUwXS5xfmP+1bPLn4MRW/IKgQY48M6kdQO3ctZla1NLSBt0Qz1mlRY/Y83rhDRuKGsy04TrZEZ3lx7S5L7zc+snxtAUGI81d9kRp8yLtyuhEsw2DlcHojgTox1us/oD8fnJqW8wAnxPLqrk+l6qsV4Oo9ueP6P249piNu53Vv8OJx4JvFRjVzIke0U2ZPK/v2BRZsPs5vvd0NFYihe7uNO0y77Wts0getz4uUJzwG9WYo++8671EmVwfEKEvDAsmb6GcUhM0hec7oEntcbHucmQ4HDcxn0XKAxX+harns8vAl+yx8GXC596DU7KF5XGNx6i911Jm6o2MLWAFUo77p0udlCFDM91UTqO1CRw3/2OM6RRcAI8TObMm7VPVIpuTsrHfGGYADF+HVd6PbtZHuJjJryYF4a1wQ2BBNKkq253gDuKnnkY4uc1Kbmo+xnhMpsFFOORs001d9EkYaTLk7877hCJOyvaTNp+5Z+vXWbsnwJnbXdBC+JZC5jQvExTr6Fl6zxw6bAkPFKsjXr+WCav17QVqrJhHYwrMKVWPUhTl+/pktgSFnvrbJV4bAYn+zx464=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b268a218-4c2c-4839-c181-08de5f171cbe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:16:40.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gH5UVRKVK00LcNS/o1iy8GOIKP27tiD+ypODtACbe2Bz/3OR8G3np8CASfMnfq6XyGBtnCvECjFDMqjCTJn5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=886 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290058
X-Proofpoint-ORIG-GUID: hmc3tpE8Ew6vowrNd5uieps5_YkpchUT
X-Proofpoint-GUID: hmc3tpE8Ew6vowrNd5uieps5_YkpchUT
X-Authority-Analysis: v=2.4 cv=IIcPywvG c=1 sm=1 tr=0 ts=697b257d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=JuDMzERyrGprox_VUIoA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA1OCBTYWx0ZWRfXxZwSFitjTIea
 xOZGQPwegVZ7xhrqIYOcwAjfjfKX7bF+q4c9QIiPxGKQVnups/kkBvzVGO9LM8afYfwKSvf3rLt
 aZFQToF1z3+kL3Xw0+/NaTfkezu4189qufPxrn16RsMAy8V5f626I1kmZjgfn96xMHxOpF+Oiae
 7uzh/O6UhYrWrBjrQWT/7bK/CspHCeBqjlyinDhFR1KErqO9CM4SkUQsMy7h9vhkjwNPwKEPS6Z
 DVWUYaUZ57tGhLjZMhUeUneokuwOtaMp58PpeA3XfrFVUq6Wvid86Koc18eXLN1KdZ6BnmB+YAz
 3mQA0Olj1drnG4dwS3tCmuTkz2clK6F+xnM5jbeMDbmSsVc4JG7mgjooNjdTI+s/Tsq/PkKiuFg
 MuLE9bNXk3iHVBFbkw+dWmi7hnb/dVTdEVOnWJCRHvdGqcoL0wLnrCXpGOGB9VXyZqNklYyHKZH
 ZG/8XDVj3IuhSXURXYpINoiMiYf4Dj3i1oAjUAfo=

On Fri, Jan 23, 2026 at 07:52:56AM +0100, Vlastimil Babka wrote:
> __refill_objects() currently only attempts to get partial slabs from the
> local node and then allocates new slab(s). Expand it to trying also
> other nodes while observing the remote node defrag ratio, similarly to
> get_any_partial().
> 
> This will prevent allocating new slabs on a node while other nodes have
> many free slabs. It does mean sheaves will contain non-local objects in
> that case. Allocations that care about specific node will still be
> served appropriately, but might get a slowpath allocation.
> 
> Like get_any_partial() we do observe cpuset_zone_allowed(), although we
> might be refilling a sheaf that will be then used from a different
> allocation context.
> 
> We can also use the resulting refill_objects() in
> __kmem_cache_alloc_bulk() for non-debug caches. This means
> kmem_cache_alloc_bulk() will get better performance when sheaves are
> exhausted. kmem_cache_alloc_bulk() cannot indicate a preferred node so
> it's compatible with sheaves refill in preferring the local node.
> Its users also have gfp flags that allow spinning, so document that
> as a requirement.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

My only concern is that it allows sheaves with remote objects
to be returned back to the local barn by freeing local objects to them.

But the impact of that should be limited because remote frees bypass
sheaves layer anyway and we can revisit it if it causes a real problem.

That said,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon
