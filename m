Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73D3074AE;
	Sat,  7 Mar 2026 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865696; cv=fail; b=UD8GY5wvajy3J8GDcix09ScNWY51TmSJpzzBpixKIwr5kBNgqbzpGtl6sF27nVBEeAyvtEZ5Vey0XMIrfvfrI8/1FVH1RxbXtGujbwQU8X39Uk7+1avUd+zwajQ4zbLwQXxkWwtSPDMOAD3TQelgZ40AtOMV8/YqcaCNrFB0GVw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865696; c=relaxed/simple;
	bh=bUwvs3YmBkJluMeea6zqS1ZVwpc0OoPp2woJCB4hyQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3iC2LhJz9g8SGwHcieXsqH1TgGeCaJIPvFNU/zm4jvrOJfZ7yqR8xn0bwhXC/VcMPfEHamE+/cbW1LIrtOZYht1eVV7fjuU9ZROmBHIHFNzD3DBtAzdA42JNK15mBuu2LrMC89qrXYKpoNIDIjUFR3pGa2LY3pludKV1Sl4R4A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e8INY/63; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e8INY/63; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e8INY/63";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e8INY/63"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=af0oT415cpKjN74XCl3V53ot6q53Cwq6/lDYD2N3ceQWxOdNq2qtgs2xk30urK4u55KuWBZtESX0Kf8Y1bC+7oVNl1q9JtVg9ElbnpzrbEPXMdmO5hE16OADZ6Js8eoH8jG0HVzpSKMDV7uZTbz2drUaG4HY1g+WUy172pIObj6gu2Zluv/TwY5nVJpV2G6DcjJ+N/cbboeFsehSILpER/8HjOEroBG79+L8v2zcsPDXa7vJiJ9BjE+bRyZgm4YGw36ZrT4UyJBrpnO6Hn3WtqwMjS4DyoLm1K6t/UC3i7vt+XDZRaU8qu9tK4PcUuyrqpAvug4xEzOFgBTnbyNEnA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUwvs3YmBkJluMeea6zqS1ZVwpc0OoPp2woJCB4hyQI=;
 b=QUrOdduAD9PEsuZwL3p0MtHlg9WpSsWSjb4ywL0jQpak4x2NWlZwD9kJYGuiKcRBliGI8Uhh9y0etJK/6CZC3tmFTDGgZrWjU1URVzvFvf7pnZqYljJnupvo0FGYZmF393QB1y4/W1078sJR17aVQnGmL3d/H0tPkD50jKmb0vKzb801rosRQljyvIMSY5RR3hjnS84DOGSrUAQoBMJLfTZl5cgAMU8bBhldeAxM4sDzH96eg/oZ49l88O32gk2VwPNjJG4Ow/keK1BjUBKtd4op8fvaPEbXHVcj9M3VkyR+hnL5B8qbcCsyZgAMNoKBkJTUPwo7kOARk96K7L06lQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huaweicloud.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUwvs3YmBkJluMeea6zqS1ZVwpc0OoPp2woJCB4hyQI=;
 b=e8INY/630JA4nMwEfAPopFP79S0L+Wog/T7S+/hVEPyonLAcz4P9vBM7sgBEz0+KYdT/J0qTSQDKjI49yENjzX35RZE/XOPkgMJZBJFyBBBWpICHPIEMfs2sUnU1R7d163zyGmYx3jsrXJLLtvJ4qxvY/DNejTsGM3zcQ1I3iiw=
Received: from DUZPR01CA0201.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::12) by PAWPR08MB10308.eurprd08.prod.outlook.com
 (2603:10a6:102:369::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Sat, 7 Mar
 2026 06:41:28 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::5b) by DUZPR01CA0201.outlook.office365.com
 (2603:10a6:10:4b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Sat,
 7 Mar 2026 06:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via
 Frontend Transport; Sat, 7 Mar 2026 06:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBqG+46vEmu1kxdnWYc/aSw24fJ259FM9kI0RZx1VziGIiALXVu969NpZdfNHKsxsyKYdJFIdQ6RV3kDxQRozLeRfyklBBujT7mjdjE8HsqROYqi9mvtUDHnKVOzBjEucWIi+pROqlt7n8Ull4ZtgWZkrLScaT0c0n1Y4SONzcFDKOeMQ9LDsCwUrziAWU66sjN4Bhf+vN+9TKTm/xavYf0qxSv0bqJDBzBVmNiLf2KNLZjNSGszO3cUy+pLttAMmO7hdRyrUBqP9ZaBPLImPaAgXXmV6XNvZ/x6eWtONyX8x6HFa+5zTt4o7o2wMjLHd5Rik/91zRda3YJoqkjRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUwvs3YmBkJluMeea6zqS1ZVwpc0OoPp2woJCB4hyQI=;
 b=Tt896Gnl95VMp4rZ5EZ1Y6hmQq9riBfQhukQVwWEwBK6NYUUU0jcl9KGEXoFnmREb9F4PamIP9KqErEWt6hSwwi9gyybZH6/BSYnOrJ4EoUyyXI+KjYdxp0lwKh6Qvzem9rC9BmXFILzBARB4dAZHpW18HFobvW/Sek3n1PtYeIulLkbulst37hnUffVOprKRNYhxByEiqsaBWu1m+JZddp4StKKVex515Y7rn0cj4WBSGMcq4bnXgbSPbd218QifKSU1TG4bzuAQNNydLSmgluFBJOs3SwsoNPtjMsmwfd8yeAcJgH7TpLmz+VjkJc3Zn5gBlfGdgyKnPG7HiwHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUwvs3YmBkJluMeea6zqS1ZVwpc0OoPp2woJCB4hyQI=;
 b=e8INY/630JA4nMwEfAPopFP79S0L+Wog/T7S+/hVEPyonLAcz4P9vBM7sgBEz0+KYdT/J0qTSQDKjI49yENjzX35RZE/XOPkgMJZBJFyBBBWpICHPIEMfs2sUnU1R7d163zyGmYx3jsrXJLLtvJ4qxvY/DNejTsGM3zcQ1I3iiw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DBBPR08MB6074.eurprd08.prod.outlook.com
 (2603:10a6:10:1f6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Sat, 7 Mar
 2026 06:40:23 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9654.022; Sat, 7 Mar 2026
 06:40:23 +0000
Date: Sat, 7 Mar 2026 06:40:20 +0000
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
Message-ID: <aavIVDaVYy/tr7/s@e129823.arm.com>
References: <20260306102329.2056216-1-xukuohai@huaweicloud.com>
 <20260306102329.2056216-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306102329.2056216-3-xukuohai@huaweicloud.com>
X-ClientProxiedBy: LO2P265CA0512.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DBBPR08MB6074:EE_|DU6PEPF00009523:EE_|PAWPR08MB10308:EE_
X-MS-Office365-Filtering-Correlation-Id: caa0cf3c-26ef-41e7-fb05-08de7c148f3a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 F0agj/WKd8bEIRUl+gyrZ85VdRgR/h97AT778fzpSP5WJE49AyUrio+XZjrEKvKh3PpT1oXvsBtUzbuRY3qFtELGdcAtknPen48B6FsH+yTJQjkeO7WxjUq1VHIRIwTkX6zQsX7sWOa6s2UNoMVg9eN/4i04aaNmws+zHlP4Lt3lCu3Zpl4hEtbTUAVYQMqun8Bw9+wZpp4Jv8zy3dyHPPEaUyNibYStSS70n7OAj3k4TSehB61JRfeJHzg77bHJNRUkDXcKc5fWjaYQz5MnNNuK+9OE5WUPZcs0/CP0CuJ42QO20FvuAhulerzBA/EJalNJPEDXsP0glwKawPVWPX9BFmYirKb96XxyI3BTq/JG2HV3MTCHLJcZsie8ukDDUR5EUwHjRAeQiTWBXIHH/xkRJZhI0MQd1cwBWU3evZ6QPxpFd59TVyUBv0kfFvF36Q/725wA3A/7K3WLEjVjYDi3EBh4DDvEkqXHZhRtTtl4IsKbOHX51HsFI9uvYt6uyFp4oXpOot2OjPsrYyzn4bkULqZpIv2OkOtAjgaERZd1pyIAICCg/XBvtM4WWcmjszcs3CsxAi3YSyuALCK30WtPQEJuc0w8xHlUJjexxIFU8jvA7B2GK0155pBZlwzl53KHVWwMuf3ZTE1VFVmytPEy2+qqoMQT41VaiJen+uOpe+QOEV3MV9HY0IS+SfLgaB7yB14p+yRTEqtnI+Tbatlz+/Mb2dpb7hnnv86mkq4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 atBU5yPOVOqR3IyX9fietxO3SIadS+/XmDuZL1qtOIVeGPMrBc+Mol/AheP4d4gNCS6+wmory3VXY00Jzrb2caHiDPRmpBgXub2ej/88ycVFZAB+EMAqJVmGl+jpAb9grCTi9smtBIqMmyIVeJzAQY5x+Ey1YxcL0LYSjJv3HnwHtRMvGIljA0Z7eMoGB8uIxE0mL02rd6liw7KK1Ps3jm5x91CWyh8jb2wKsO0X4Ndeuxk1BCavL04fP3o0zGoBfQQmZCgphxSMCp/BjyWxrQGz5W26DlSGO4Tz4s4shAdE9VGZTlf/A8Gw68pZtbohqNzjrGYMn/KiPAl2lP7n0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6074
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	acb8a4b7-4c4e-4ffd-4fc7-08de7c1468f0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|14060799003|35042699022|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	ICPIlfwb3o8gycLojk7R8tfangwcfVi9EkdlerWzdu1SURMU2Hky8eofLpkZX2RyilFAt7jiCPv+U7UeOO9ctgSI4JL0gF4msXx7WD59e58G9TKRqoXIuUthoNR4EoiWlp/Sxp25tdzqg278dvoT9u6zj4I7rwyO4uOlD9VSuSLhnQWEmq+3n1uVn1jcbX7HDa9Ses8hSH2NzBDi0Zkkx6b6rmTnP21L97GI0Xt39n7kgUfV/EozEee5mN4rNRtu0xoHu3MaprLPGDmOGyc0eOvsvNgtOHwDzAgbiHufBQMcbgoEPYPVkjGnMcM7xQGOLB82lVWrAn3ZQgZzTicBA0XkYl4JpPkkvzynwloc+FSqW2m8alAaijlIL3JPe+n36zktxQ8kXm0+55meFvuoUhqgz81+SEIphOJDa7GpX+bOtjYtr6/6JfaimkUpiWf+G87erkiRSdhL/7ldYdp/1MWEGOBKQYcvbYmF0hPqjW7W/CZzTv2awtumSQjyes2XunoFDX119zldKOaBgmEk2HBbbaFIpQnPVLDGFtITErEZzotc2+xUFjrzCSgdHY5aP2JdFip/xeq0eBXnJiEU/Q2pvI9Ca2KkFDdwsVcmXYzTjw8RogaRENa2YRKiCLrnCEp6P2ri6ED8kMNXDi0Yb0smxmBj5T8H8xnjP4/dQYtHM6alyrhG+/MvoMLKJIGJuvUDD5AxcbpIHPIASyWAfZzddcKjHQp/faIQtMRcO2UdB47btZJEU7QVYut6TGL6SaEDvuUf0Qja0NMbC/SE5A==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(14060799003)(35042699022)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lALykVqjGhQW79fDlVUu/KtFFYjRmxDzRQ65kc+54GI36Dc5yaUHoY3v9FnT0gWm+1YH/FN+aaBK83Z1Ede6p8PTe+JQ3pAyLzDwXATFgzToAFZ0Z14AwT4NpwQ/E5llbYxNb31tVZSSF0LQrD1Lh9151mdQFfkH5naebwJLBiUm6X+wqa3pW2DyVkidqP/BIfDOWAZPRjaX5sO2c/A+4ZiM55JoKg/BUdftCRQfiJc34HZmLc7p3l26TQejpsh7nq6767ZAJN4U3z+LHcVIFZsjq0l0OHkPs8nFeohUKj+FvLoeBLMQ2MSGbPzw2ODOGcdfmj30Ayow6IoiO7UFTvabmq5knE3qed9tgGpIpUypoDOhQwWPUnk4CBQBWwv6dqi8YGBG7vma+/hG7zvldrJvIMqr8lx4hUZxKs2qzgBhH/aGUUwB+Sg7leJXE0M9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 06:41:27.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa0cf3c-26ef-41e7-fb05-08de7c148f3a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10308

Hi,

[...]

> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)

Does this also work for bpf_prepare_filter()?
For example, ptp_classifier_init() calls it without invoking bpf_check(),
so there is no env available in that context.

[...]

Thanks.

--
Sincerely,
Yeoreum Yun
