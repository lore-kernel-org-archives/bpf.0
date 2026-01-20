Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020121.outbound.protection.outlook.com [52.101.196.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCA3A1D1A;
	Tue, 20 Jan 2026 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768953253; cv=fail; b=ieurZI0tofHsn0J9fp+BCSLA55JSlOdcFtF1Y48JpYYJGko0Jo1b0/T2tYun9/kN+QffNlMANiryhQj9qyliDCK4HuDA+8J09sXxcKHkXB/9KxP43cAl0kMBoPpBec4ubT+yOWoL4EqNlfL3tE3aDV40zyvYE32yECViobyawX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768953253; c=relaxed/simple;
	bh=e2eZ5vs67MPLXItOLEj5DdyaLmJkhrhjorhnKJvoPrA=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=AE7FveTLo3004ORemQynocRkCAY0OJtK3/7C9IEq2k9VC2N/jYdF+VbTfjW/YMkBldG8QmlAmBPWGIgKjPjj5wx4uZ8k0hFdY6jgB/Z1SPNc0ebK5YHekcRn+QhZTMU7uzyoj2skYsCQvS1rVnXMknsqBsAod6WvIVqfUoiQtJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fYzzO+i1; arc=fail smtp.client-ip=52.101.196.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fYzzO+i1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHgVtOCuTavvJE/yPnUAhtJZFyfs3ixfj4IwJZ3KFZ+Z8s5Leq8R2tAd8c8Fje6ObHVLuMznj/14JYmUo6bFRdHvY4riOCf+2YvG9NGmG5MSvqj6Z2okAlJ3ywu0PPY56MdRN5esnb+Vg+ZBEp5b6YJL0S/dyjG15R8R78YnFBC9f+udkF9hTrQKWh2xlvSrk3EY8Sa5b/oQNli9FiX9E17j0Px4DPU4eO7nVat9cMLoFD879TSZkBk6a7vWqG7eP/30vlPwolDGG81radmFv6GOXOCeKJ/Y69bUtUaBzXsDnfWGm7QkX0sOQFs77oexf/0GOL3Ytt2/yimhFZ2nQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O31jOTnJZaFB907aqnqME7pmuKAreGSH72ApPu9upL4=;
 b=yAlBMJ1XRzSc3bf9h5SxumEqR/YPIDb+j2dXBJDwgCxry/B9pUjzPpLPpaIHfETPjH8phxkJaOy1FSxayZZ+AhLo4QBDYAP4w/kwFa6hgHCn6AvuL5kiaYyleMBDY5eIREAqq4A5+zB0w8AnCb5XfW2t1ZnEbKBGvjbz60visLoPxojg5ambJxsNdGieUyG3zAONHJUoc4bfkkNgxeKlR/bkKOb6aux/YJDv+QNbYKqUJCKWuTzSG8GMeyMFeBM4I3rXYoTQerg6q7yjuFS+a2C9t909DNzKnL/2d7NMKQBwoUlGHxwCzwEZ/CQmRpMMX7atwCYGPbCwHy8yTMsd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O31jOTnJZaFB907aqnqME7pmuKAreGSH72ApPu9upL4=;
 b=fYzzO+i1D4rJ5ahth0Fj5Y9OAdQC7t6i1G9GlLiXKvDBP8sgzr260g9+E01BC48YGqYfJuTnGRJ47oxUTZEbFACxthfqoIZGwAi5uE39fpTAu2rpoyPG/jfm11kHorOxdz8bi3I7f6T9o2/VmGCRmcxpHPf+rxoX+ofic5jsytk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5144.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 23:54:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 23:54:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 23:54:07 +0000
Message-Id: <DFTTLB4I89PR.26SQVXWNG9U7@garyguo.net>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260120182034.3647092-1-gary@kernel.org>
 <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
 <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net>
 <ea83b91a-796c-4329-bcf5-2c49efa897fc@t-8ch.de>
 <5364d5ec-f30c-40d6-9a99-c251fec3868c@linux.dev>
In-Reply-To: <5364d5ec-f30c-40d6-9a99-c251fec3868c@linux.dev>
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e54e5db-7d3d-4af5-527d-08de587f3364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R09XWFFScDhaVUFNNHEvKzdtb0FiN3BCb3hISkkvQlVTcEVPTWsrcGg4Tlhj?=
 =?utf-8?B?ZlliRW5qQmlXUzdSbFZPTndRSVRKK3RIWlBidTA1d2xkRTlmbUpDYXNBRytD?=
 =?utf-8?B?Rkp2cmU0eG5UL09vbjRyU3VFMWxSdmR2M1VoMFF5L0ttUVhucU1FdUFaQ2Rh?=
 =?utf-8?B?aXFOdjMwbEx3OU5telBDRG9LeEJ6VjhUcWhMaXQ4Qk95dGlzbjNEZEZJdU5K?=
 =?utf-8?B?NkRlbnpFdHZ4bzdPNGlud3FLRmVzaTUyRVBpQ0JaOTFpckdaSUpoYzlqZ0ds?=
 =?utf-8?B?QThiejdiY2J0U0VmcDJvaFYvZVoxeHVnZitvQWY0V2pVQW54Tk1DbFZ4aVR1?=
 =?utf-8?B?cmhwMUJpd0ppVU1xUjZYdW9IemI4ak91bWs5MmJyYnZ1eGIxeGcrZmRTUzB4?=
 =?utf-8?B?SzhycHR0OW5sM0UzdHJVbE96MG5uMlRPWTdGaG9nR0VvNkxBWmVBWWNOL1Jm?=
 =?utf-8?B?Vk4xWkZ5TXovWUVpUmVYRkMwekhhajNzdENBYmQ3NVc4SEtsV0M1cVZxR3ZT?=
 =?utf-8?B?V3VCT0VmU3o5Q1B3bGRMYXJUSkZwV3lWQWZUbFBRTnJtdkNDMGw5OUNYLzNu?=
 =?utf-8?B?aVRFSEhRWHlUbUFvTE1HWEVVdjJ4TE1vMmt1b2haYXBJR08xdVlVSG04YnBV?=
 =?utf-8?B?ZWxQZ0RYVm85elR0VGtsaGJjQmRtekowUnRFWEVUTklQUDhWbm5qR2luRzd2?=
 =?utf-8?B?VEdqZ21hNTRlY25uRW8zajdoeEhpd04xWVJ0LzU3Q1dBN1dFRkYzbG1qaE51?=
 =?utf-8?B?OXNFeTlFN2ExNlBBYlNhWDJ5d0E0NGtVckZQb3hOQ2JzalJIYkRVbFFMcUdS?=
 =?utf-8?B?bmdKRlhmYnhVT281ZktvenB2S056dUtWcC90Y0QzdWE1OXFzMUhHUmhONGNS?=
 =?utf-8?B?RlVzS2E4YmJyWUxMNnhJbnVrdUdEUnJFZjE4WkwvZ3cvdDEwd3B6SGRJODJX?=
 =?utf-8?B?SXRmSkg3b29wVEZhK01pQ3AzTS9NdDJNOWtrZ1JlN3loQmRTOWl5dkt4ZW5Q?=
 =?utf-8?B?ZEtLM2ZFTWdaWXNOVlRURzd6eWFkK2tNWGw1UHJ6aGY2bndXOStTalhrQnVJ?=
 =?utf-8?B?eWhsT21wNVlDWXZsUUlXUzNMM25BT1g4Z296YndubXVpZ3EzeUxuQ0ZJQkVv?=
 =?utf-8?B?Z2wxa1JqbVZsbWkyQTRqZmJ2SG5BWmtMUVA0RUd0VVphc2VaOStoajZXREpr?=
 =?utf-8?B?ZXc0anBwOFhtL1FhSWM4R0RpNzRaSTJGblBKSzAyQzYrYi9ITlFhdnBqQ2FU?=
 =?utf-8?B?MG96S1R5Nk9nTnZhUW05SW1URnRYN1RTMmFLQm95eVJyQzZiem5EK3VLSVNY?=
 =?utf-8?B?Y3R0WEc4Y2dkNkpBRU5vRlZWdmNSc1VNaUhIcVcyVWdUVXVxNmhWV1Z1Ynpj?=
 =?utf-8?B?SjVlTEQwaEZtek0xam5RcWVBVDFxTElFak1mVWlLQUpaUkkwTVFoZTVLdDQz?=
 =?utf-8?B?VzBKMm9RNS9OWXdxVm9tMUFNakkvYXlWRFlIYStoK21NTks3Qy9pL05FWUFk?=
 =?utf-8?B?dkxNcExYcHcyYmNINDM2UVFRSGVYS3VkcFB0L0NjNkZPejNpaGNTK0RXYzV4?=
 =?utf-8?B?U3F0bVRoOHRnSy9CR3JaRFdqRlI1UTM0cHRtRUg3dWQzQjI0NlgwT2pJdEhV?=
 =?utf-8?B?N3U3bzBLSE1Fd0VTY0JydS9NTmJ4SkcxVk12aTRVa2QxMDhwWGl5SlRVd0k3?=
 =?utf-8?B?bDNPcjd3UTlGa2cxWVNITWxIWm0zOHo5dTRzOHhPajF5OEM1NHBYOWNlMzQz?=
 =?utf-8?B?aWlJZHowWHNzbVR1UVM2aG4wMTFkbEJmWUlRUFBtTjE2bHNQMHpJU0JqbHBK?=
 =?utf-8?B?QjhYYSt6aklKOFpjMGFjY3JCdTR4M2d6cWJBZG9yS2srcFNhYTVHMEZMTmJi?=
 =?utf-8?B?L2xNdnpXem4xNHlTQWc4MVZPcGZiV2kvenFqMS95cTA2bFZMZS9ocEY5SkRi?=
 =?utf-8?B?UE1sZEdlbUpEV2dTWVNGRkx0YTY2NEx0RFYzbjlrTkM5dEg1RkcvK2pQTnBt?=
 =?utf-8?B?M3NiNEVSTGVlTjJENkY2aFVsRVduYVo3a1g3VFFXTkMzS0oxUG93bTlxL0Jk?=
 =?utf-8?B?Z3RwZXFEVkl5aEdac25qa0V2cnY3Q241T1NVanNLbTY3Vm1aVk81VjFna1I0?=
 =?utf-8?Q?X2rA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTM2NGE2TWxEbHAySFg3QzNpbkJ1UjZ2Z3FBZ1F1WUMveHE4cWovOFVLSGJ5?=
 =?utf-8?B?RjZXclZJRWZFRnovQ3VvQUMyOUJNMEV1aE5iaWtxVzN5T0doUUZXSXRpMUtL?=
 =?utf-8?B?bjRqTnlLUFdQQW1zWE9YUDZKdFlwQUVzZ0tMK1FkRnU0K2Z6bXg1alpiRTJH?=
 =?utf-8?B?ZDhDQW5pT3lUa3N6QWpXS3lrb1M4bVJUNTlQd1ZpZXFhcUpBS08waThVWEs0?=
 =?utf-8?B?SVR6L1NjTXFTT25EREx6Unh6ZE9uQzVOWmdqd1FRNWc3T0FqNGhlK2dscHEx?=
 =?utf-8?B?cWh1dzJ0T3Nub1FmSXFIOTFYdTUyOUxlcVNJTDVrWnVsS21xQUlWTnVyaHc2?=
 =?utf-8?B?dGk4Z3hhSWg0UVI2cElWdUlIZVhya0ZreVN0MUNiM3U0dzZNbit3YjB3eUdy?=
 =?utf-8?B?VWpJLytqSEpVQXJVVDhQckJMVjZEYVBZcHVmcGtsN21yRzNCMlExalo3bytu?=
 =?utf-8?B?WC8wcXhlb2dRalRGc3dhem1USFc0NmlKV1psWTFLK2llTFNuaU1vOVMwWWlQ?=
 =?utf-8?B?Z1JiWnFSY09nU29INU5RS0JHQVoxbE14UGNrR3U4QXRXd3BEOStpY3BXUUtz?=
 =?utf-8?B?dmFtZHpGMVcwQzlyR3BoRjNvczRSaE1JUUt4eHVzS25lSE55Ymlpb3VOWFor?=
 =?utf-8?B?a0FtRVlOY1ZtajZXOFQvalNGWGxSZEdnZ1lFSU43OW1ROWlXQ0xMRXR2RVB6?=
 =?utf-8?B?Y0xrbmY2cFRkOERXNUlLVUFaNW95Y2dSSm03QlBZazRuQUt5R0QyUWd4OXJW?=
 =?utf-8?B?TWRuVXBsajQxZi9IVnNmSEV5d21mNmV5K3FmMGZkaXpSZE52eGlBaS93R1Fk?=
 =?utf-8?B?bkZSUnZNY3R4TUMxc3pjM09McFlUR1VycUVvNU84Wld0eS9YcGhjMGJlRGIx?=
 =?utf-8?B?VVpMcGJQYkd4SDNILzNXU08yVy8wYVBUbzRQcXJsaWFPVUFwWHptVE9Jajl4?=
 =?utf-8?B?MzFKSy9kWkxJUjRYbjNOVm1VcW9mU25wVElxTThvNXNobkpZWUsxYmxWaERu?=
 =?utf-8?B?V2R5cGt3aERhUnk3VGlucjc0V3hQVjZzeExZeG9FUktCbGhuK094L29CRlpF?=
 =?utf-8?B?WUtyQWhOc2dKT1dTa29rOFFsTWFOZjZ5YktSRndjVFVqUjExeHpXekUwODM4?=
 =?utf-8?B?dGdVbTdHQ3BFVEdCalMxcW1IdFFvc01lOWVlZkpwNzVvSEpzY0gweDRDb0I4?=
 =?utf-8?B?YVZPZ1ZjMG51WWQvdTl1YTM4WWs5Si9CQnE4QklmWXQ4N1dBUTY0MS9hNXBw?=
 =?utf-8?B?NUtsWjhhOVVRa0VqYVdFSTNIYUZHSEJVaFhCRzZVZUhqQUJXTE5mbEh0eWVQ?=
 =?utf-8?B?SHFzSG9ES2x6SUNTUmtNVlpxRTRCc0cxaC9HQ3A2c1R1WTBzQk5YMmJoa1p1?=
 =?utf-8?B?U096MFptRGROMmtDZndsZnVHOWtnMEJ1YTI1WSs2MUxQQllpWE45S0pSTDR1?=
 =?utf-8?B?RG5wcG1UbWJVUE0zM0llTWJkL081WUVxL2lERjI2T3k5a0w1MjJGejYwSXhl?=
 =?utf-8?B?UzdCd1lKZG1LR1dwbmd5YUtpakYvcmV3UkoxMEIzdmdYR0J2U2NicXp1cWxv?=
 =?utf-8?B?QXNKWE1XYzdYYk1VNjJEc0hBS3BWNTNWS1p4bG1FTXNDZ2R4dUltckg5Q1FX?=
 =?utf-8?B?UWxaV0htWFhkRG03bTRlc3BwZGI3Vy8rT3ZrOW9Rakh5RlNzZ2hmVjF5elZn?=
 =?utf-8?B?VzhJN3VabDNoQTRkT3REU0FENnNib2hOS0JWcytkdnJpTktIZ25Jc0YwNC9U?=
 =?utf-8?B?dWt6alI1TTEwVnlmMGJCeUR2bWFpUG40TndJditDUmIvNmhmcE1FenpMS3ov?=
 =?utf-8?B?MDVySXgwNWJ6VmF1a2VIaEFyaGdmSVp6cTdVci9xMzhGTVVXa0NmaVFrNTM0?=
 =?utf-8?B?SGlLNWUyME85RHQxdEw0VDk1R3VrbDRRZFVuSlJxd1p6NnNSc1o2VG9zWFZE?=
 =?utf-8?B?bThSS2ZFalgwbTFmWlJMaVdjellzNDhUVFl6dnJ6a0xRWWt0MmhLMm9leFQz?=
 =?utf-8?B?U3ExaUh1UE9FbG9nbTdkaEdyeEJDek5tcnJKbklSSlpaaFJYMzF5YXFqUHpS?=
 =?utf-8?B?N2xXY3dtOTFmRmNzWFZXWmx4TDZhb0E0U1hVekJoTDhSUnBWMGZOdGVWblFG?=
 =?utf-8?B?ZGhrZHFGMmJrVWt1VVluT0ZHV1BqVkpZeUJGcW5jdWVRa1JNcHBZZnBaQ0t6?=
 =?utf-8?B?cVNLR1dnZCtWWCtRemtpVHA3bXBNOVNoZHE4OUxpa1ZJa01nUmliQkZsZmlD?=
 =?utf-8?B?eTFOcldiMnFROG5YWUhlcFJ0eUNaT3BldDFIRzlEcTdQUVBpclFHRnBjQlRS?=
 =?utf-8?B?NVBicEZZR1JWZG5TZVE2QUFIMnlCa3RSK0VCZDdMd3RhbkRWOCtNUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e54e5db-7d3d-4af5-527d-08de587f3364
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 23:54:08.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGkWgEaDztPZQC+erJ+mMpGPxrWqGCF4bw9CBSLQlsBUz39THXQ3EjmYPeMt4ai8BtwywngM5Zw2Ou+NGiy9Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5144

On Tue Jan 20, 2026 at 7:53 PM GMT, Ihor Solodrai wrote:
> On 1/20/26 11:38 AM, Thomas Wei=C3=9Fschuh wrote:
>> On 2026-01-20 19:15:11+0000, Gary Guo wrote:
>>> On Tue Jan 20, 2026 at 6:59 PM GMT, Ihor Solodrai wrote:
>>>> On 1/20/26 10:20 AM, Gary Guo wrote:
>>>>> From: Gary Guo <gary@garyguo.net>
>>>>>
>>>>> NixOS only puts /usr/bin/env and /bin/sh at the standard location as
>>>>> required by POSIX, but not other shells. Other program that kernel bu=
ild
>>>>> depends on is supplied via PATH, so shebang needs to use /usr/bin/env=
 to
>>>>> find them.
>>>>>
>>>>> This has been done to a few other scripts already, e.g.
>>>>> gen_test_kallsyms.sh or decode_stacktrace.sh.
>>>>>
>>>>> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw=
 binary output")
>>>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>>>> ---
>>>>>  scripts/gen-btf.sh | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
>>>>> index be21ccee3487..4cd3159f2ddb 100755
>>>>> --- a/scripts/gen-btf.sh
>>>>> +++ b/scripts/gen-btf.sh
>>>>> @@ -1,4 +1,4 @@
>>>>> -#!/bin/bash
>>>>> +#!/usr/bin/env bash
>>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>>  # Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
>>>>>  #
>>>>>
>>>>> base-commit: 053966c344dbd346e71305f530e91ea77916189f
>>>>
>>>> Hi Gary, thanks for the patch.
>>>>
>>>> I'm guessing this came up because gen-btf.sh is part of the vmlinux
>>>> build, and link-vmlinux.sh has #!/bin/sh (not bash).
>>>
>>> My typical experience is that when I see an error about /bin/bash not f=
ound, I
>>> just use "bash <script path>" instead without putting much think into i=
t.
>>>
>>> gen-btf.sh is part of build so I don't get to invoke the script directl=
y, hence
>>> the patch.
>>=20
>> For the build we have $(CONFIG_SHELL) to stick before the script.
>> It is only 'sh', but it is the well-known variable users know to
>> override. IMO all script invocations should use this mechanism.
>
> There are two places where gen-btf.sh is invoked.
>
> In link-vmlinux.sh:
>
> 	if ! ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then
> 		echo >&2 "Failed to generate BTF for vmlinux"
> 		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
> 		exit 1
> 	fi
>
> And in Makefile.modfinal:
>
> quiet_cmd_btf_ko =3D BTF [M] $@
>       cmd_btf_ko =3D 							\
> 	if [ ! -f $(objtree)/vmlinux ]; then				\
> 		printf "Skipping BTF generation for %s due to unavailability of vmlinux=
\n" $@ 1>&2; \
> 	else	\
> 		$(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
> 	fi;
>
> So it's trivial to put $(CONFIG_SHELL) in front of it. But then it
> must be migrated to #!/bin/sh, right?

Documentation/kbuild/makefiles.rst says:

Make rules may invoke scripts to build the kernel. The rules shall
always provide the appropriate interpreter to execute the script. They
shall not rely on the execute bits being set, and shall not invoke the
script directly. For the convenience of manual script invocation, such
as invoking ./scripts/checkpatch.pl, it is recommended to set execute
bits on the scripts nonetheless.

Kbuild provides variables $(CONFIG_SHELL), $(AWK), $(PERL),
and $(PYTHON3) to refer to interpreters for the respective
scripts.

So I suppose it would need to migate to POSIX shell...

Best,
Gary
