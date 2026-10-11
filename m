Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07E26159E;
	Sun, 11 Oct 2026 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749612; cv=fail; b=SkfdSEEWrpAqY9tnPPKQDoBdAEfMUPvCcVnMa8KdzVhHMh85HA1oMF7EuVrbKJJjyvStTutgRj5IPvq1PCRuTxzHdTwQoXsWZeWRBQ1glq+cWbixFs5DLaOwWs64QjsSZfgW3jDZtNj6Yne4z3b4IguyTKjjbqHcA7uu6Ce5AU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749612; c=relaxed/simple;
	bh=o0BnzF8A3AWKbGYslK1nu9ZKF3arU24PHfdjNp8SfYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kx+xFAgHdbyLsyDjoGvi3ms5xlOnm/4sKQVr/HPruQtS6p7QTAKSqb16xq+brZNiiC6G2VaMvmkOjLsiCywCv+0wfRgOitXEh/QdYKpcOthdfYhY3LIsebkoVwxUJ3HJdvb0p/EWIgivRjKRcTdWS9KncZ6sqtVZNqPsqh0w0m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWgJcuMa; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWgJcuMa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YirTkQewx1mmIn8T/TYgP/l42jtRkXSLdxu7e33fqDnAC9Uiu6fOHztOY0v5YLpTK3bUWlfqGQakTqKezHShqGUpVx4dZxT9aKSBttBZPexMXGI1kFFWKL9NTyiMQuPFF8eNy8dkxH5btoMmuT6tmA94pgZmQrqfscrqMXeE/J4rMo4Zykxdrl9smHP9ujfysq3j3hrfFczeZe2EJD7MVuPas3COyYRrz7h+QIflkmb9Qg8DwI2Jxy6uFCS9TR1EX1JGYXWKh1HCwpK1NrCYevtZhr7mfKMI7thFibMokvrhlNjNrUai0HHrjignZIaNIc7/rYR9IELtQt2rok3hgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmAM5xLaftpRNj6Du93N7EC09cIF/yyoTyxPszIgBgw=;
 b=YpTFetv6ZfVIZiedxmOiY8PjVXY4TTXo6zr16rszPVOELKw0J1sJAoGHy0UeLbMqW6Tm3dUTdQdVdwdeSbamTrSjfs0p4w6M6WMy6ub2B16wK+WgKGC9b/1KBSsqcwiD0VH6B4uo7KHXYL0JXWbwC1LkYVB4337+8sRwafH8nBuYSK8IBzVIWX21rMpuamtXlcyWrQDI1LK+NJ1ziNfFzJ8RTt4dW0R/2N35oOj9e2AdfVn5Grm1K60AoPNZFccKvnLRBOOe4oLpbuzhjJL+PnPhRkSdiJkqQUBni3cYFkP9nMmufzmhUjISQ/ZCTc7rxH7JUNGlUZNZCaSBoDz0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmAM5xLaftpRNj6Du93N7EC09cIF/yyoTyxPszIgBgw=;
 b=CWgJcuMaTXFYlBV3uDbc347RNWBQbvZOqfzRBeMjo+Gms8tMfKKWzeoW3mRLcl2xPb74m/Db+4OrHkspydq8B+YZFiIUEylo58l9ZS1fIxYR7q4UXvhUCMITTxfzk49+2DHYWBwcxpDYcj+GHDCYSzmT3c+tea9rEjR94Zq61KHgUhNLFUI1MLGnbuAqoN0jRQm86uHCnVZeArN5ADCGxobahrlwkR33G6MVRjSdr9hsmAEUW/fbGbDMm1Tj/avvZftZM8BI1Izd6e48VAhDJtacQ3yvq2btr44Xg8nnmEabBQyhEDnjxOspQZ8LXsRKX8pbS3b7nUgq0aVhDcaXxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB8979.namprd12.prod.outlook.com
 (2603:10b6:a03:548::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 20:13:26 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Sun, 11 Oct 2026
 20:13:26 +0000
Date: Sun, 11 Oct 2026 17:13:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pingfan Liu <piliu@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20261011201325.GA918242@nvidia.com>
References: <20260322014402.8815-1-piliu@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
X-ClientProxiedBy: YT4PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::29) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 83446118-c180-4a58-ec83-08df27d41ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kh+Z2yfpKPAdMO4xGhyDvVcgfehAmDydMNbvBXruisHW4l05kH7aJbaOOiDIJp0UKgSxaUf9fOap/mGS/muq6t6IlaHWe1RKDpeEOK78B/73T8CAdMzMnojYlFsI0PL46oeJHWWcDMoET9MrrICh/HzgqhM2raWc/bX1ITw31GJdwSkgZ05HGDnECTSUcDCVSPCh/atIlC9dbUsmV2nQyVcyG7t5Uz3wtL/ej8VyDR9SceeStxTheEnrzIWESuhbwk8jq9/4xWRv9y2hXqoktbrOKjKAPJ1NBOwelzs3jGgtGCUG8s5rF1oIhv0wkGUFUiHdcwdNQKIy2ElKyzXcmOUwsVaOiKY2bLmLFRJ9UXz6ASCuQVdPrHfwz0WSvn7zbnJ4cv7nIpewRy9/3inx4zGsGTRhm6lSeR5CyENDXGdIL4sU5esBeedGyt0+KWL87EEZSNGgQkj6LFXlxhZHjNYML2XonokrXL1K/NDaOg9mZsaaK438V2rc9qFJyB0qyLzqZSWK2OUwn/T4ag/o6eMpBpEvGR4B82CHykQswV6xOcaAdddSh1uqaC5yCGqS5Dgzhi6DS0kDcqIEUw/6ORQkaRBqpXFDZgcMsyU5mwwsJlGdceeGxUQpJ3Jr0L9HtfIx4mJz6o7mBpHCRHwTlNIKIQ0n6H7/rRUlsCuNiuc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zo2sO7j5WttnCBXoo9gin6n/r2Zl/ksAvowKUMRnp5KCpNL8aG0oQJyhPpFH?=
 =?us-ascii?Q?kyK3mH7Tmq5gsiKcP7eqUw65pNXYPPOeLxzKF+5jmo/KOaufhXC3LFnzvByj?=
 =?us-ascii?Q?PRCTlbwbgAReT5zvRGBW+0jVtgUwrkhtyuZKan1/fhKpOgUYCAyP77tyo78M?=
 =?us-ascii?Q?IC0OqIe4qFi5jEEIyAkJsAH3bEDKeNKsBeD1LZk5xqGgiapvNJBD6cjGZ0Ju?=
 =?us-ascii?Q?Z+fUfYxTDhKO9ojy8R3/Lrmfk5QA3iCCLRtWh0ezr/gzrup+nzOwpdtzxv5q?=
 =?us-ascii?Q?ewaZS/gYK0kqYmRNKW0MSzcAZS/HLVLy29vvIoKxo3HrBljbZSAfttrAg/5i?=
 =?us-ascii?Q?AErXxD5onRXT95SCUZzqRl8feTjNxnBVIvHB5hrgPZNQeEYBi01/hfZVEtII?=
 =?us-ascii?Q?XR5Wgrfbf/Gu0qxqKSZhHnM4EZCSm82+CDlcNyBie3DG+uT2RiG4Ommilu6k?=
 =?us-ascii?Q?D95nWgvr2Uj9c3US5u1SbNoF4EEE2+XmZJrpCdCyMemk0nUFfjbh95sULNER?=
 =?us-ascii?Q?LDxb65YLp9H0LdvW/w/q1qGqLYSUH7SzUYMRlNH4BPVF1AWNH1tXIW/2OBM+?=
 =?us-ascii?Q?bs79F+fDum6A8TOBWsu9m3LMI93tYHY2mjnLA4XLFJR49xyGUQLYBT4dEK3Z?=
 =?us-ascii?Q?1u3wvZyKmRXy3S5lsWRbWaC1z2fdJ2APr1K9lcdj4lg8HBHx8Movc9vrAzLW?=
 =?us-ascii?Q?eRouZbrX+WNzAVgsS74d5DoM//kZwawVkpPkEkyIKBLcHf2ep/qyX2MEmZH8?=
 =?us-ascii?Q?QG8emhDIxXbfEvqDOLA6/WIAnfgRW2T0oACYt80mk6Wejy1TpvJB2+vqz/tz?=
 =?us-ascii?Q?44m5JFqKmigf0AbyiksfmsFD1K8gUz74dPjI0bECkKMlC0GWuvflGubInlLE?=
 =?us-ascii?Q?k+8QjYchZ1Y4R+ff3lNEXqioJtiwoX54WhbbMC5Aqot+ZbSow7MlRJZd8w1y?=
 =?us-ascii?Q?5WvUeSrsqjiT92AUeSarrCS325pa9JbffexBF/cdHLsC3Trr/y+3p5Rzx/va?=
 =?us-ascii?Q?ZYmqcRry4AEZb4aio4aYVtidpdk6kB5fm4J/Z+madzcdMZS1zDWtDInsZ3g3?=
 =?us-ascii?Q?qdqEi6AYf4eXu+aSjcbvLo3VLJDpp6AHns2CqHu4ZtQKPsugHxYwLNwO5keH?=
 =?us-ascii?Q?3rFKTVUwHX7JfpXKgu+GE2HlqISmrnfFiIBnEyCoycI2Ix43GT9U19Y7qIcV?=
 =?us-ascii?Q?BxPk1IGsaI9SWPdgg1GEi/YHbIwdOx6TpcalajWtptDpd/wTGhE396glP8GX?=
 =?us-ascii?Q?UC2dskZgVLEGcSOjnLL792URNgGXV0j1rXdnP420dxvurh4kohP7CHIZpPxX?=
 =?us-ascii?Q?cr7/JwP26GL3JjfpAPxxrseruZ1fiNbEAigWWusSFaW+QZM2szmw+SGZVg/n?=
 =?us-ascii?Q?US1Pt2zsuk/anLGd3aZODZLG+uxx3xYzChlyuTGAmaG25qhevI3+EsntlBFC?=
 =?us-ascii?Q?jiA9B3L1Hxl8FFc495mE6VGbf6DaHjnvf7VKRf3G78/C5fbW4hY1W53e2dGD?=
 =?us-ascii?Q?h22echJ6sZhfA1ZXfsnt57m+DKdjzyBvxcIUpj765+aae+xojgA20N6AxiO1?=
 =?us-ascii?Q?nsuVVzm9xt98lv3RQ5drJY/9Obc0mRgnTeJ/yZqC74fudXsmJnQQi0mOYEcs?=
 =?us-ascii?Q?skERT9XkWqpugfYuABJxdADF1IKdQCXc1TPeasdrADxxbhn4yDwYnHsGOcUx?=
 =?us-ascii?Q?JpvrH495MUusfUd/VQLEbpAMrewFgRWL4r0azSbpiAnPU/B/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83446118-c180-4a58-ec83-08df27d41ba8
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 20:13:26.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Az3QIS9LzzUuuGGSJD/fq/axPVkbzY4FI3hSMVn4Nfam/1F/8WbHcQtMbqXKZ8hq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979

On Sun, Mar 22, 2026 at 09:43:49AM +0800, Pingfan Liu wrote:
> *** The history ***
> 
> Nowadays, UEFI PE bootable images are becoming increasingly popular
> among distributions. Currently, we have several kinds of image format
> parsers in user space (kexec-tools). However, this approach breaks the
> integrity protection of the images. To address this integrity protection
> concern, several approaches have been proposed to resolve this issue,
> but none of them have been accepted upstream yet.
> 
> The summary of those approaches:
>   -1. UEFI service emulator for UEFI stub
>   -2. PE format parser in kernel
>   -3. Signing the arm64/boot/Image

I recently had an interesting discussion with Ard around DRTM for
kexec and we sort of independently concluded that #1 would be the best
(only?) option there.

All the implementations of DRTM today live in the EFI stub and
intercept the boot process as it goes along. After ExitBootServices
the DRTM implementation will launch the kernel in a different way.
Even worse today's x86 version strongly requires EFI boot services to
connect the Linux stub with a trampoline helper provided earlier in
the boot chain.

A kexec flow that only works on decompressed vmlinux, with no option
to run any EFI code, is going to be difficult to support. There is
enough information and choices involved in DRTM that it is undesirable
for the predecessor kernel to try and DRTM launch it on behalf of the
successor, let alone trying to get the insane x86 trampolines into a
kexec successor kernel.

Given those constraints entering the successor kernel through the
normal EFI entry point is highly desirable. This would allow x86 to
continue to provide the DRTM trampolines through an EFI mechanism and
means the Linux EFI stub always handles the launch with identical code
in all scenarios.

I reviewed the earlier threads and it wasn't clear why this was
abandoned? The points Ard raised are legitimate, but I would respond
to them:

https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/#m8519beebccb252861b257db390a1686686b27aeb

> 1)  Implementing UEFI entirely is intractable, and unnecessary.

Yes, I think that is the entire point of the general idea, that we
should strive to have some limited EFI that is just useful enough to
boot a UKI through to the kernel EFI entry point.

> 2)  Running the UEFI emulator on bare metal is not going to scale.

Well, I don't think everyone will have that choice. At least DRTM
requires things like ARM SMCs, and x86 requires ACPI parsing, it would
be really tricky to get those things into a userspace context.

I would recast this idea as "having the kernel community own a UEFI
emulator for every kind of bare metal is not scalable"

> 3. We need to figure out how to support TPM and PCRs in the context
> of kexec.

AFAIK it doesn't really work today. DRTM significantly fixes it, and
passing more PCR logs fixes it even more. Though I don't see that it
has much to do with using the EFI entry point.. It is a good question
what should systemd-shim do in a kexec case, or more generally when
DRTM is being used. (for drtm it should probably not do anything with
PCRs)


IMHO, the kernel shouldn't get involved. It shouldn't try to integrate
an EFI emulator. The kexec path in the kernel should allow userspace
to provide a signed executable which is the emulator it wants to use
and let other people sort it out in their own projects. Distros can
sign the emulators they like.

There are already two examples of emulators that can EFI Boot the
kernel so there is definitely something achievable that many people
can use. If someone wants to go crazy and support Grub, console,
userspace EFI, etc, they can do that on their own git :)

Down this path the kernel work should simply be supporting a signed
executable (not vmlinux), and a robust way to pass more information
through a FDT to that executable. Such that userspace can get the EFI
emulator, the UKI, side cars and anything else nicely organized and
labeled in a FDT so the EFI emulator has an easy job.

In the current AI fueled world this looks much more tractable than it
did in 2024 when this was last brought up.

Regards,
Jason
