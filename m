Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261A4E2F1E;
	Fri, 16 Oct 2026 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168182; cv=fail; b=kTqYmfrF2TUAyYicbn4NwJciaOA/E+UZy8zl7TdEmzGLEU3BMj6RDg9A3K9jaexowQWfuhvzRRXkI2ywT6w2hdsSGWFgj0e9CQP35Pv/WbK8K2SZBx4DHJndfbbM6lTi7iHebC7akdrGa2t8GSVAy8QuplLwvqwIrtU3hSL1S/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168182; c=relaxed/simple;
	bh=Zqjgpexp+wRNac4lGxBwjTkQjbsDm5vIej6RHp/CQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TuY1QU00PBekFqM0vrWS81V+9gf7qktosNOFRw19tBnPg6bOokP6FAtfpfGBWC83MGPIioHhR2vyPMqY/N0elYfJiAr0r9Ph4qW9dqLzd2GnXBIMf0d1zvSnjsP6c39kpfETjbONbzEtvYn4DMmd6Z4Cph1vkSjzfEP1aIhwkLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RO2NRzEx; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RO2NRzEx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUx6AOfhO5/lK03AXkKZdeLTY4Tv9cBnccObe7Jg2R0bPWwfxgHvdyJHyen6Hsy7Iscog/ggfScH3UnFgdCFVjtyzey1vUMTMWTAncio//3nwZSL7taDpc3oItnNNVay7SSpEC01rShQvz3FQ/cCK7NFv+KzBZFbkWu3iEymDyMOlhEePT/4kjvwuODYCd2Oor4eXX03t/4V/zI/OiuHYoOfrBu62VgZiv+xwOgWph9htDriTLvymAGXIrgX+lJJP8y74o2GFIIAMsILyprJez6DN4fSI9bjbRFo8Y8AnQfZk8QPXUkl9eyH36LyOoOOYnZ5BkajrV1P2srgyea3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqjgpexp+wRNac4lGxBwjTkQjbsDm5vIej6RHp/CQJ4=;
 b=ScSSPaeijYTN8xrvMJIpylfsguc84lYAMD2r0++H7sh7lj4mQYtCLcB0eiLQbijUJOCVSCWaY+eL5nzGSf4vjFDYu0OYCPIMY80s7LwN3gAANw/RnbyPf3kaOf76WaIVusGfrwsfkwZWK6Ycj13yM6MFFMDmLTQTuMkhosCuHks63ZWndEPchubF9jkY3Qo4zvKfc2BOmtlWWZOuQ806/OgiK95Bdf6uxQGHts+OovrTTkX85VnZhE4aaAyy5G0+Mc+Id6zsv+LAHqwVbDadM3Yz3jygaFxqSQtMJRDrtR/8kXl/Dc6HkfK2X4sHp/N2qiranP2p2d4CjEfEso1Jbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqjgpexp+wRNac4lGxBwjTkQjbsDm5vIej6RHp/CQJ4=;
 b=RO2NRzExnUWGu9y8duOcsReh9MeITwugf1Ik4DqRN3/RxJuvk3dUe9ixyfUrFxAF5cEFjrtaIFVEl3BdF81lZ34dV74yLCtUresHSo+Pja+vGWyZMLkHJr/SODMTXVTYvBqVLGpmPnlqV6Hd4RSlS9w2QE2bTfJTcM6LvnhxR5BXc5ed5iOpI1sTTE2PoUa2y5Ae99Aj2dgcOP8dx1owwtkLUPGxHIbRWpdD+T3KRcKii2m+4axyLZhRF6Zval5/s7GyuDoT8eS8UrHHUaDn3fQTaZhsrr7uuqlp6Y65JbrjyYcL3i/LYUfsfIqY2nhB4k9hgqxZt/QZonFQrnxmxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by BL4PR12MB9506.namprd12.prod.outlook.com
 (2603:10b6:208:590::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:29:35 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 16:29:35 +0000
Date: Fri, 16 Oct 2026 13:29:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Abhishek Shinde <abhshinde@nvidia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20261016162934.GI13920@nvidia.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
 <20261014000227.GV13920@nvidia.com>
 <8fb05f13-e770-41a4-af66-d239b4c95201@app.fastmail.com>
 <20261016144121.GA439341@nvidia.com>
 <5236ef55-28b4-4331-8c7d-a6d112aa185f@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5236ef55-28b4-4331-8c7d-a6d112aa185f@app.fastmail.com>
X-ClientProxiedBy: YT4PR01CA0501.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 1953eccc-d72d-4173-3f25-08df2ba2aa74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gtJKQtcfA2eI9fKGPzqnCxHkPKtI5FpUkPQ8fApt7f8Ro8tePdyZmj7xI+faBjNWmHsm0637UY4OEtI2uE9O4d7mb1gohy6ZX5yRIonlpFjpZnoel242Z2bH50b321YDfg/B+kNhgtcXteM5gkdRySk6e5X0XpzrAFFX0aXqaFCGblze0f2w622VmlGDg00VW7bPdqO1iKd4t89XNEUbV2FA08Xbl/z0X9Qh3cbtUGSr5y9f8eAahzi2qMNgoNBnx6IvGsHXrdREwhux+dwlXY/C16+KmxKSUzXWal0ZVpvehy6mT5LbFBrzsx2u/7PqkBBxeZ1kBkL9sEyl91ClopKPOY6+j/7Wg82/TozwcMkLZ6hVQCI79RkEoZFJIqIvZQSneseQfNtFS99+44+TGxbzQ5RXywCKiRCNfGVt2uGZnQkwCNbCFGG+t9X+O0xz/ZDm//1iTraKB9J+7WcHZkUMIw4hNqdc2OdjbcI6f0C2xa1vZ07KZrdsaGDpYUoOpGSNcbRxdYKx+YkLb06xmE9PVXKyu2h3QXT7lBh5efst/o38OTK04gQat4B1c4r3szzIxwUiVjyo9YLN7RnV0ND8QKYBBq1CgU9Udo8rAiBd4/ZQRqYS83nhdxe54JUg+yIhuopRLQMadLey7oXd1hlJKHSp2eQn3t7yjQJBrQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OeTiI52St9AE+OUkKKfCosOxLbOdV3yGstVk3kvCAdAxGftpxLHcxcR3b1UW?=
 =?us-ascii?Q?jm3IboxI4GIPAm2P6uBGTiAKaQncJXFCxf67CSqyY2z/gbizyVnhQ1F/LdlD?=
 =?us-ascii?Q?CaOFEJ5ZJU9/7kgGQwUO6AnHbTTdTslcCtyCL2i1trbBvrQ/fZk7OVLgf/0y?=
 =?us-ascii?Q?fpGCCOhcu82iyEi/kgZ5eZsdwAHAdlYjkiqk3Lhjy1gimS6IX2+KfyaJVHOG?=
 =?us-ascii?Q?AUctbZDeKV2ImEWgl8w7CgnHeNEZ0NfD2laQDGsOFaLvhkxIR9s0zUmHakPj?=
 =?us-ascii?Q?dN/6pe39FI1sV7f84lzbSqOKA3coVwSdl6ze3soU5oDHF5tJAeQ36D8ajO3H?=
 =?us-ascii?Q?GSDSLRYInrhbHrprTTRvWJ/b4dvMVliZD2GNCPLLzibks+YfDB2R/5gFZWKP?=
 =?us-ascii?Q?nIDrAJCZlpDeXvlq77ff17BAQBYs8F9g4RGdBiFFKQkYv20z5iDUuy5ktcec?=
 =?us-ascii?Q?FUSgdVfzLRYe72mFv4BYcBdhJboDG2y66dvlZ2FivwiXBcUQvqdpK3rzeMRt?=
 =?us-ascii?Q?0P3eLiYc5jYNB35URlIuGdxrsgM3sHJM7DxG/VcRzuQTMhp4EEvOHeBSkIHN?=
 =?us-ascii?Q?WvHCAakyQmwWyOw33xhXXbULCDKtCp8toxh+clkgMhR80t9S27uzjUPP2LDX?=
 =?us-ascii?Q?9vf6xvx5O7Iz0g3vB2XVIF6T7DrHSyYOazzDldD8YyJL0Tl5X3WR5/w37YU1?=
 =?us-ascii?Q?+vKF53y81jTOwEGBpNTd4mJUXhHftEtimh5/oeEcbXvMMY8eJRGYgobzaGg0?=
 =?us-ascii?Q?qur7lipCTYx2jRtz5peYAKnDXJX9OCZjH4BWZ2PM5AcyuPD2elnhqbbd6vfL?=
 =?us-ascii?Q?dIG7GbnHy6LcpQ4/VmsPvLWqZy94QFcIWGIMEG47RUT8DEBEWSCyP6G3AP7d?=
 =?us-ascii?Q?is6mWPpQxjmx0s/ugYKZou1i0CS3p7Fjhxkdyw+Xi8CZIBSrLF9ZC8E1KtbM?=
 =?us-ascii?Q?6BmuP1NNnVkvPqFCcA7KAUMrnNn5y39JRVCRQVMOZWKsaPWbL6SRRoHJbQ8o?=
 =?us-ascii?Q?qYC2STmYqDD+QYdg63YCAFaYFJIKc3KNsZwCmLxeh6uepzK1nMhTGv2rlS3/?=
 =?us-ascii?Q?guRnxPFlaCOr2BuCt89241I1mFQdboAeg1S4HuF0duxgsFB13+Ag+gWmTsm0?=
 =?us-ascii?Q?aiCI4KuSmK7KK/DJUm7ZbI2w14PJ3HEtqLAkXnaTQo/6gT70oIzffyupl3y4?=
 =?us-ascii?Q?V5xkalYl7R4VG7olHPcIGmByzxzD+IFgrRKmzC39aalPv+7/eqSjTtBU5onG?=
 =?us-ascii?Q?Muoxi5XN3dd5PjLQzaAeHAHwP+faltC/+lsJktOMEmCoRXojvzh3fXsPbHL+?=
 =?us-ascii?Q?xrsMZbbIyFxPolYGTcHsaUiaVOBE6vdVf5z7AMPL5Oj0nBq4EybBnrsbcHmB?=
 =?us-ascii?Q?rjeC6DCgZToA5TVJ1cPNAIYwQ7KDTEwXZYbrXFfpLqb15BKafPTwaJDTZlSU?=
 =?us-ascii?Q?GfBK8S0fKfH/fVm9mM78urDNZxquQy8W9bR0pDnKm3556JzT6UFFIPxRg3vn?=
 =?us-ascii?Q?A88S6eTzqQ3mBKLQiRapR3Z7os2TiOCckmIZKnelZwKVbmX3DvyK0avhZalq?=
 =?us-ascii?Q?vNBylKicr0ukfaU2Rip/ckftfXilhik05MOli2PDjkn6u4wIycOjb1Ia/2Hm?=
 =?us-ascii?Q?At2BR1AzEL7k9yoIgpA6PuiJ+N9iQc2qV0Igz4pRCYLugKF5ny4FpCJm24Pj?=
 =?us-ascii?Q?6Xilo6ILX7GogKkHJTeO+pPVne+crdlGShVLrx7D5yRAdLdV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1953eccc-d72d-4173-3f25-08df2ba2aa74
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:29:35.5511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hey8MYgov4TvFvn+SYaLYtBzgIQOaPF4irgUKq1QhXmOU9ypST11cD5CYMcG5FqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506

On Fri, Oct 16, 2026 at 05:56:13PM +0200, Ard Biesheuvel wrote:
> Interesting. I'm not sure this is a reliable workaround, though, given
> that the return from ExitBootServices() occurs as a result of another
> syscall(), and the kthread is long gone by then.
>
> I think the reliable approach here is taking down all the other cores
> before doing the kexec.

Yeah, both parts need this.

The DRTM spec requires invoking the launch SMC on the boot CPU and all
other CPUs must be powered off. The firmware is supposed to check this.

> In other news, I've added some other features to the prototype: x86_64
> support, support for UKIs including sidecars etc (the kexec image loader
> now accepts a cpio archive which can be presented as the ESP) and some
> other improvements. This is highly in flux so let's compare notes often
> so things do not diverge unnecessarily.

This seems great, please ping again and we can retest it. I also was
just told the UKI flow was demo'd through there too including DRTM. It
seems like a little change is needed on the DRTM series for UKI, I
ill remark separately.

I like the idea of cpio for of all the parts, that seems
flexible. Presumably we can do a signing check of each part in the
kernel for those that want that?

Also when you are ready to post it I can ask here for some rust
reviewers, we have developed quite a deep bench of experience.

Thanks,
Jason
