Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDA547069;
	Wed, 14 Oct 2026 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791936154; cv=fail; b=TJHOZhlp2u59On5qHfd5kONX419E5h4wlMesNK8UTJB3TbF4NWMu7Mae0zDjAxbU8V/LtFywDjAPsCVRQ5tggVk6DYHi0OT2+kv8myvzzzmXlx67ROtFj3unNQNoaxYbedblmEfysUtKFnx4Ttb1jwNRNTa6sf2vQT+wfdb4Txw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791936154; c=relaxed/simple;
	bh=JXiwhRri4MXF8PQmqrj505iRkkbcXb1/UGpQ8qRveH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DEf6p/BDYOzE/aV/rUrNoWKnDqkyGF8Ge5GIThmhIJSCvHREE1MGAFuDhmxz5ik2CcvGULn9s196ygrqzRie0NxqwjRc1x7dLxQhD6D0ultq4PPcMNHBmHlXmgwwOV2sYl0OLVyNoUGdfF7OHirdcWwUp2rbcm3C3lpWe1foVCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/4jY/5o; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/4jY/5o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsXQAZbrFzZOMvFck7+zb6CEnyFoCau3ycXJ43sqgtbW2XjcAes8M1r3euzp+Cu2A/+JwhCgcjEZWWQdOzN/LUdkkTGnASN1CPnxqWyGe77ucQpyRn+0CH/ZLoFBHndVzOub0FH1rTL3ET0M79stFihdfHEaFUSEyNtN5WqXICLVmwXCKfZ9DtkRVpkQsAnxxuFImRKgJT58CYQNojW+n2RfYFScTp+eyuYWRzySxeam7/FQsJQuZhDBWToP7rkRH8+zh0cIe21AfcKJ3gkl+ZChi035DTabJc40jc+AQyaNl6qHP1sWobHXNHe9W82xNJOxE953cpWiyaOphdPuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydIF+NGzq5LdYpg4pBaXHz3znT+yc0+yVkaN6HwJ1iI=;
 b=KXIGlaNQ4aIhOV68tSOa6DN7iZIhjDYFKNTKvlBB+TugGucPzA1HrkPIrvpnF/evG2jr4ARIOgSEINU8ao1fBvUg1wiNdkVgmd9NdBSFouJWoD9LQVUrIc95yQ00I1B4fDoZGGNI/ej31R3UWyADX7smD8Ue/UX673rMA74RsNs7tExpyHJYTv473Z0EGKr0U3uBvPmRWa2qGh89wrTk4EHAj78iK7EKZ0PUnlamN55v0DkiQFNGCH7KmxMtacn4LWrv7A8pnPTJZcWcdOWZxRulaB4oKJ4jeEOphmknpyKBfzJiK/7eeIwlpT8Fqync1JaTfOzEzDD96E38wFvirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydIF+NGzq5LdYpg4pBaXHz3znT+yc0+yVkaN6HwJ1iI=;
 b=j/4jY/5oOsVWvAsvwKOkew9i3IjrgK6Sjb4PLvMyVokotVBnc17hh8sYzTm/gfzaymT5W/FJaPCua+4kzNyvSMP7OfdZmh+JlHOSpbTIhXsx6T1A+/0MFByxz+Mk07qf2DVeDEd/vqO3PBQvHTyjQHFMHp8d7eo85yWIEYH8K/Yje/DozA6lyMSj8PwYG/bjzSfUBD1FarDXxEg7oPTUg24oIf67uAz/x+/HwS8+S1jtjqEnUp+0sycaUhgMxN4y+0geTpay6999JUgvd3o1m19AvdxRdMdgSefC9b1pNm8wzCR74hJiK6rqGQJf7DJKJNqHMw1dloYi+xBUrmSc7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by BN7PPF0D2C72F0D.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 00:02:28 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 00:02:28 +0000
Date: Tue, 13 Oct 2026 21:02:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20261014000227.GV13920@nvidia.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
X-ClientProxiedBy: YT4P288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::20) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|BN7PPF0D2C72F0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 489c62a3-f4f2-4d06-c31e-08df29866f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|56012099006|11063799006|5023799004|4143699003|3023799007|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	z9+R0ZxHf6327UIbEHQB4iNxEFlFBypJQNyCiGYEC769bzgOBj6G6GXy8BA9ygWPviiBi+qtu2kfBFcqjlgxxK+bCYXYeP0cfydvpkkCk0Rqgx0rnAiwJel3kDj1U4PYg2p+/YJiDa5qE7U5SIjHuQ3Uxi/OIZFuGYWsU1Be3d1ee+D0IY9bG1w5lcjbASqyOXK+Q5C+ww5lyL2tZkR0cO/aqWEkRIEIJUJtwCxBuvAYi0ieOBH6rf3FjKtoAxwNxeErqoMfym2PpgVLERXeZFX4polXAxTbOQ5yRrqWU+ErA2wtoBzp5DsXLxNgfUgkH4QX9KlP1D5d9+fDcX6wVxoJt55efVXzx34EWvPlabHbyDKjnIgIg96e4enZYQPyvUkeVLqC0Iy0mQc3c8LghOSWNj/RJYw7UBleS8Ip+DDaT9NDqdlyQvCOcCqMlBuP9ST0Qo8WM+AH7PH9JsyEAt7KXq+597PGJIVhn/yaxRGl8/zDSrGbyEXL+yavqEuQT4XjYtizh9J1uf0z8XKA5ROEMywLItFaJN8E0RhT6efa9PDKmNEyCSTqT5edu66dk/7RUlskBmjSaT5DxkJLKoQ8H7CYszfmma9TqcI14BOossT9YddwMFHkQ/HmGpJVZ25KDHXIuJh0jaYviytxvXSm/7Bjtg5AMkfZoHUXQh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(56012099006)(11063799006)(5023799004)(4143699003)(3023799007)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hH2pHYTgSUu6kc/j9FX/Zec4Ex0hw84+N9n8qayP97NhrAwdTZ6QRGml1LZy?=
 =?us-ascii?Q?R1X54N6Nv8t4q9tD9JI45eCKc1lsZYTQujzMIxjRn7i1VspCHJrGV2iisQgg?=
 =?us-ascii?Q?oIztRsXekKL3WMh+nQvxb3fIMsmEDnNNsqvHrIbDtpwNkTD7SH5viO5cOQor?=
 =?us-ascii?Q?OCOqu49yfYUFV/vnG8yMv2zR1+86HVIiZ2yw65F1HooQJJhe/mokfXf3vxjh?=
 =?us-ascii?Q?WPK3I/WET/KoSQyzISF8unWyU72mRxG3+FWLAefOCQjtOzJk3dbrfNHgC015?=
 =?us-ascii?Q?HcuYiVbbpgyC8WSjyA3wJnDv/tvMF4OaI5oG2xmjnqN5CoODTJ2+PUYC+2R6?=
 =?us-ascii?Q?KMZrhTDp2iz502zhzMi40oORHPlt3NSk2LfGomcY5/fDe7v1rAZFDvzZCO1V?=
 =?us-ascii?Q?Y3AonUiKG6a2bk3xxpUJoHM1eZMYdcymtPjLWUsgnKV4ZcqspRQJsmRLCp3G?=
 =?us-ascii?Q?tp8ZQhWtmABbCC/NPvfry/rFEOu1DMpqVJWllwcmwQKHbaBxtDZb3QOpr87I?=
 =?us-ascii?Q?Thp6k66vLRWyfm9xRxLYNwreR6YWmiGZ9vnUdMPAbICSyoAYqq4ZMC60wM8C?=
 =?us-ascii?Q?9ZrF89tllzJmjy1lrQOzAhFOVla1kj8WSbScbGnbFvGVemfNoBksjrqoggW1?=
 =?us-ascii?Q?W3dsoewL5eIzN+nJGNS0tuVxMkarFCnK1U4M3Gsc32tmMOBr6fIj7g/EXEYJ?=
 =?us-ascii?Q?+GJCu7gxuAlEEZ5SV82ugj+Zvmk5tndHKJOLwzn2rqeczbcjcAt6mxi3TK+0?=
 =?us-ascii?Q?xfayqAA6UqbjWxvoTVZr4c6VKGdswaYQsvG3LlL4hlXjXJNTktxPWBgn37c0?=
 =?us-ascii?Q?S8xadTvexFSth03n/5HOJ+EVBDoUWiQeHv7JZUn6cIxOF2uv7KqOsWYgz8p5?=
 =?us-ascii?Q?1QLkIzCNEWiSfF84AI56KNLrC9McMf+E2fXrnC4VzsJt2eLLJH2a3lW7m8Y+?=
 =?us-ascii?Q?nDGBmWDPBomp4fkMt/Mo6XcvVyiVqCpdrc0rnysK/FkBkNyQq+WLfVr8Zzhr?=
 =?us-ascii?Q?urhPGlcPd3Q+zDTM8UQ6SbB+8+Nl4zq2ZlsMjQn4/u9i5VmlXdCefhdbHwh+?=
 =?us-ascii?Q?BtPn488B0SoeMfe9Byr6VvNnutwpHJabA+t1gyOpmD2SI4KxBQGrrE8qFZ3O?=
 =?us-ascii?Q?Ygg+Tf2NL5LG0dAa+DT/F2V37Fb3Oz20qcehdL0b71o+Qr/JCJtS36RtQnQp?=
 =?us-ascii?Q?lMo4CMd1I21Ut1Pb3OF/XGkVoyvxmyw62X7ADqs3QAjQEGIB5+tZuZJVYgp6?=
 =?us-ascii?Q?afvxAT6UG76AGI9T8RlGjMakbsqnXCnXT4luLNZ/39srAkmtZy4OYO78/3uV?=
 =?us-ascii?Q?uFbFAdM594c4wpTX/e5mngzKyD3USw1FfNFJ3TEZ6zgOF8fEJ1VVpmgcyXdN?=
 =?us-ascii?Q?I5f9MC8aHsW1LgP9muYx07vD/umj186KJFy/jIl5LcjnmDI/xVp0c3L0lW5G?=
 =?us-ascii?Q?0ia/yAarw/yTHa5e0KUuyTxTwbVQJRBph/ATeqlNuqAao43D7JOVwPcUnZrO?=
 =?us-ascii?Q?2AY2aEtVXEQrxh/N7NNED16EBENsMZEPX778RyLt3Foj35EpdfYNEBOW9+hd?=
 =?us-ascii?Q?KLa6AyTdhxEY5ENfmVHOItBCSECpf1jqwOXaqF/mt55s7CUwHxVF8ZFJO8JA?=
 =?us-ascii?Q?8YJas7tJFTlj/h5+ZJ3zmG+Vd3uf3+aVoLjgSYdaVq1kNEGqKgZ7cXmPE4z0?=
 =?us-ascii?Q?yCmiUf3GqlFvRtbVDcEaq8rk1dagAyteTmGHO1mlhdkPfhao?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489c62a3-f4f2-4d06-c31e-08df29866f4c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 00:02:28.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF/plYiUF4Cy37Ch/6zuE+TMJyLwDTysCiUcLuul0EfmF6Q5C8Ywj/TF4MVF8G86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D2C72F0D

On Tue, Oct 13, 2026 at 09:19:28PM +0200, Ard Biesheuvel wrote:
> > Given those constraints entering the successor kernel through the
> > normal EFI entry point is highly desirable. This would allow x86 to
> > continue to provide the DRTM trampolines through an EFI mechanism and
> > means the Linux EFI stub always handles the launch with identical code
> > in all scenarios.
> 
> With some help from my friend Claude, I've prepared a prototype that
> reuses my efiloader Rust crate to boot EFI stub images (bare Image,
> zboot, UKI) in the kernel: the EFI boot phase is invoked at kexec
> load time, and runs under the preceding kernel up until the point
> where ExitBootServices() is called. Then, the actual kexec call
> will return from ExitBootServices() after shutting down the first
> kernel.

Running it inside a kthread is such a novel idea, I would have never
thought to attempt that!

I've asked some folks here to take a look and try to test this with
real DRTM capable HW. It seems very promising that it will work to me,
and I surmize this is also close to boot a UKI?

Seems amazing! Thanks a lot for drafting it!

Jason
