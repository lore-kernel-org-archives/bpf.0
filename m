Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0261F9F7A;
	Sat,  7 Mar 2026 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868229; cv=fail; b=ONqU7LqOVyKPKN8yd63JPOX4itG/8eCfl0CH+Vr6O2+NBLtGbs9uFYn9xd7V1THmVfi+YDuFEk6rG7HJ84d3zf6Ixz0+m9nI8lqsuhonvXzm8eSDfkxDqGO/QPX4hsP6ssXJyPB7SL65RKjsLDS+hs3qqgekN1rembRoqq8wVPc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868229; c=relaxed/simple;
	bh=k4XCuvnU7cY8J93aYGxX/++iV4bRQmSsHuUVkKNJbdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iPmgg7eEApLZlRi77gJJ4U6yYbtwqxe/myD6ZzeGLY6WEp8kLCxf3oKeUtluAspjkPWBt/RQfbJlICMv+gZIVMFsGCjijZiMCIfkVsvCC34xvNQlSAXFoQdlCCxR3osTpcv62xCeDxwsfk4PRGaQOjVjB4khrp11cpbpjP0Cig8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lsWSWnOF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lsWSWnOF; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lsWSWnOF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lsWSWnOF"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=euVdubGfqRNiPAbjYMghKjASCo+8B2t39iLSmUVCtKQJzZDtxkgosPEJUMGJlbnzkaCIZN1GJZvFytrkQrhNmX5PfytIG8QLI/VrdzqLqFZGTMF0BVwlBpZpI6+sbUOm/yADE7fyRJ2NcKowLGRWl52K3aG8UXsME7/CEb3BGNLdfWvJG1+1VU3om1Rsh3MVUhPrxV0tbYOt/p7HQ2w97TUg4WBj17gc+BlIdvAg2d7a4XpIt7brQmDMslTI1ZmRoRs/r/LKT1ECH7LrjVDrZ7hqjGYD65MF8NhY/R0vo+LX3bWfcqjW6Mwt2q0yxiY+hLilZQOaeR123XFnkoYo3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4XCuvnU7cY8J93aYGxX/++iV4bRQmSsHuUVkKNJbdU=;
 b=tbynhf+tKSA5gSFTjwLFsMYjot4n1LJgICKFhAy7i+kDWbimMTOeKW9J+W+m4o1Wofg3Bxf9s9Okfi/ysJGjSg8qvoJJJjUo8CK3uTOu1xlope5aykMDr9tTbZUlaVhL5Zw5AMPdDa0aqPDKgi24FrjNDubrQJZl76HebzUyEIm/DLvh38SN88LAOuiNr/zz81qwDJxErdcxBe1bif36XXd2BuBSv0ha2BW1VuD6VWo77mBJVXZrsw3Z0XNTWFzYppv6MG7Y79PiAA3MGZi60AoF8vC4f4txwq/e7sbTiF8DS/8nErctULMzXfNA2+sy9MtuhVsdvNLb1SMP0cTWWw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huaweicloud.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4XCuvnU7cY8J93aYGxX/++iV4bRQmSsHuUVkKNJbdU=;
 b=lsWSWnOFtCbhzJhs0Och+Bukw0IQMUTkX/Em7ZWzI4QdTDov6qNqR7Y2E05x1UuyhEvLkKFO3Fl/F/w+O3G90upOKwMruL7Gr95lVXFtmpVvyIXeISpQQINURRcTmoBGNy4OV2gINxnDMU6E+wxiSTKWTuHnEoWY3stnKTb4VWs=
Received: from AS9P194CA0015.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::14)
 by DB9PR08MB9948.eurprd08.prod.outlook.com (2603:10a6:10:3d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Sat, 7 Mar
 2026 07:23:41 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:46d:cafe::7a) by AS9P194CA0015.outlook.office365.com
 (2603:10a6:20b:46d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Sat,
 7 Mar 2026 07:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Sat, 7 Mar 2026 07:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eT+LzjTqlBbNnybqaprULBMjQQN17/8bkh844kAheXIaT1oNr0Hvjqe70j//33T9jdaB1mjjDY9jWSpzthilwwKKdYuMaqtaYanN3scg0X2btVyB/8oyGi/vi727SdEyecC+1DHgIEDB86a5qXA3vx6cmx7x2VJl5q0FP2TNUnB21tgDymqMf0mcLB18s44r0PsDgR+DqTIgJ4i5hgiijdGk9Fk8mNHm1ye1i+4mIcPLIjK4MSYZfUf7p2j93mDVAuRl/+6+/0xFBxDrIvaE1kr2Yy2zft9/3z/MKM1S3bdQOlnARjJITVVMtjeww5uhxYb/6S1EoJN7JAfhdqWzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4XCuvnU7cY8J93aYGxX/++iV4bRQmSsHuUVkKNJbdU=;
 b=snuhQEo1ivAsbyHfOKBomRlqRedC9n9CzCwOsrfbOcK5Bho/t0EpZQbO2oHMHq0n4LRfmYx+tY9yPyO7eCoiljx6nXnSU5k2bJZ5AW7rDGC/SDE1hntFjb820LBPlVQDPDqc+ZzGtT4KbQZ/9i1iG1jwRdyScCuCqhUhqked79778g4jZZhmzxtCnte+rasRjyF20NbzVK82nZjpsLkp4V7fKddCwQU+PhrT16mzGTa6ydRee4NeLEtN78o1Y8DAXWImzWux0I45shsuxdRmO+1LP/A92wUhSlpoZZWU1jLOD7tYP+kr3tBhWhp3sDVFt4g+3DAfKg4QiT/Xl82HaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4XCuvnU7cY8J93aYGxX/++iV4bRQmSsHuUVkKNJbdU=;
 b=lsWSWnOFtCbhzJhs0Och+Bukw0IQMUTkX/Em7ZWzI4QdTDov6qNqR7Y2E05x1UuyhEvLkKFO3Fl/F/w+O3G90upOKwMruL7Gr95lVXFtmpVvyIXeISpQQINURRcTmoBGNy4OV2gINxnDMU6E+wxiSTKWTuHnEoWY3stnKTb4VWs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB7994.eurprd08.prod.outlook.com
 (2603:10a6:10:3e1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Sat, 7 Mar
 2026 07:22:36 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9654.022; Sat, 7 Mar 2026
 07:22:35 +0000
Date: Sat, 7 Mar 2026 07:22:31 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: Re: [bpf-next v6 2/5] bpf: Pass bpf_verifier_env to jit
Message-ID: <aavSNxiY3PlGNeWV@e129823.arm.com>
References: <20260306102329.2056216-1-xukuohai@huaweicloud.com>
 <20260306102329.2056216-3-xukuohai@huaweicloud.com>
 <aavIVDaVYy/tr7/s@e129823.arm.com>
 <1ca67134-011b-416e-b632-4ad061b76c28@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca67134-011b-416e-b632-4ad061b76c28@huaweicloud.com>
X-ClientProxiedBy: LO4P123CA0328.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB7994:EE_|AM3PEPF00009B9F:EE_|DB9PR08MB9948:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cc3f5f-e27b-48c4-46ba-08de7c1a750f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 6jg8+F+1nWYvIuNRqn6jfL6aTHnoaKEkx5109epUX533GAJN4q4uDldNOkkLNAjqI2VcQuE39Z23FS5WrKxRPGbX02JGKHWemOCiLuglo+FJ2neY1NcfoGycomicByDK6+SVSARYk7AABho/bwkCkyFLkUGpqwShiWWokUIZHauBjcILgCgooK65jp1uWa5AKMDray4L2pjjoaLW56Iw/akS/+Mhz6PRvgZUHkYcSkPrOByzM9crZoQkPhMaM+dYhbgUz70gCVuNbILHWQIQphkH7BMAeGOq0Dg4WjSYWQVgWHRzAXMVl+WAogg+2dafzFzL3Mt31564eeS0or5/qowZNLORYYP2gGAyoi2AAbGnYfQdllsarup/cC2Ze21RhWGtaByE16GpBTjfa9y1E9n6FA98PKYmNBxMk0EuNgp0OKQ2kBYmYg59MOxBhGpywOjRfyMQz1hPnjpTXx9/y4tu9sifsIekVJTE3O4NIZKjVr8FaXc1BGsrnmmLuyY1v5qbDNnjXeSsbxuu+i6PwPy8YAe6O8B8PatUMVDiMjFjx0npv3N4VgSg4AW8YHrZd2ipAjI03iJUJb/kWQQRiHrwZnR/jrq/eEM/Kjcs0DMdQpAdRx51308R9b+w9jdT9NFl5ySrx3hokXQa1EIBpi0HylmqgDE9o3fOwY25EOAWaeXEYeUHqyrUspen8Qxm2AYUMKMwYwx/e1HVHea7cwEE0M0l157nSVu9caSg3CA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7994
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	284254b8-5116-4afc-0a51-08de7c1a4e1b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|376014|35042699022|1800799024|7416014|36860700016;
X-Microsoft-Antispam-Message-Info:
	KVmTMDSHT8hLh23DXpJlo66/vwC2ODS9yhtQHX3o2+UZK+by5iD5CjBR5cQuQtFc30Ir95Q7xX7yytC8foUSAZ+Xtt1pi1zkwsoMwwN4rxktXLD6hr8EoyXHBVrLJTydc3oEzjqlplHMvMSZb5I39OQzuIkBZoovpIDwgm6OwQEiC/weNxVGWrqlbSGw4R+y9bFLA5gg2ebNfCnE+C7MjgiW0YGZ8ikk8nTC6cJjTx7Lj/bCSz2HYQJguuseM6GwNmKEaXgIEWNp0w1gl4bgT/pAgVPjrnx6yh1rk+1F6irnTfEgSeiE+FPk5PyX81rx3pdeJxX2E5zNEBBH5EksQfNmTqRwtHirF2BkWrJ2BADBYPo/Fcx91cYm3C41QVNDVFXIpS164UV0SM80v1ZQgZb7+/hrVrQI3kVO0+Lqkh18psHphCFZfk8OOw8BtykkPj6v7N5P0T2f0xy8nnJqL0Xzv/f8UKn9sb5F3jd367jnmKPuHGZNL69BgkQTwpyr0TsTlnqGH43BgRxwMx/G/zhKNRfEiHf4Vz8yuyElaNP+Xd+oSf+qO5nhVWgU+JwiLboW6RikQ8CAvJY8g1f77Mu2ipvg/dFBxlnQCEBBBEBFv3vGbOChp37Zq3ZE08NfsF4iY7tBv7qFMn9Dep4qLyHq8Zvlv5OQhFAgzUYSaD3AlImfqWu35jHAltinBzhgqFP4at0LOi0RlMXNBn1JQ8/I9ux70rqVU7xvHUzGfqoMqFmy233xY292RhwSEwbduv66A+4cRIGOc9HGt3KDNw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(376014)(35042699022)(1800799024)(7416014)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n3+upi6yQTi0CCnr2PVkQPYE937pOc9NkGoMeK1FC+wN5NvmrqY0BnZSItlXOUDatUGvAgfwTdetaQSyjdAvtdXuxoymgYiWKdDuIFMImOKDltqDCtZmEnJ/fPni1TdxVePf+cj1IxNbUksdGqRRK90rZ0h4Quk9XiQfbKutduAR2eOHaIjPrTVhkd0fbC+WtTNdpunI8Q+jLAxBCNBXxLo48RmlEsm/gsuOqpo9PVTLlsT6N/yw01maGmrMQiXCsBXgHDPQ9iWvioA7rdhu4ZMTyRtE4rtNEShN25+pFHudYw+rHCEMEiZAdX3rc14xTFn7n3KdWWCZ5y9js4yBRjCAA5suWxyFk7pMhqDXZBU60lTIpcPngZDLnl+mvuLBggJHo/GbvWEJMu+Rv5pAZfuCZ3HynTcIPcLgoPPFq1FojNe8V1+QjzqPAgwDsIo/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 07:23:40.7182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cc3f5f-e27b-48c4-46ba-08de7c1a750f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9948

Hi,

> On 3/7/2026 2:40 PM, Yeoreum Yun wrote:
> > Hi,
> >
> > [...]
> >
> > > -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> > > +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
> >
> > Does this also work for bpf_prepare_filter()?
> > For example, ptp_classifier_init() calls it without invoking bpf_check(),
> > so there is no env available in that context.
> >
>
> It works. The original bpf_prog_select_runtime() is preserved for
> cbpf and test code, and passes NULL env to bpf_int_jit_compile().

Yes, I agree it work with the NULL when I see you patch but
I mean I couldn't find out modification in bpf_prepare_filter()
-- bpf_jit_compile(fp) -> bpf_jit_compile(NULL, fp)




>
> > [...]
> >
> > Thanks.
> >
> > --
> > Sincerely,
> > Yeoreum Yun
> >
> >
>

--
Sincerely,
Yeoreum Yun
