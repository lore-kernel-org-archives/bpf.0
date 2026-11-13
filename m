Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794607836;
	b=mu9dS6WUUQCVJ3Bo+aFBknR+Hs6uN/HnyO01hAJvpKqiiZgt66MBsGkNYdGu+B9NTezl
	 KGcaL5Yiu+kOxLIuBHBatQTC9VAFKfvhlLROSNccboTb1txYkTxZ2wzNesIEOtsEInsYI
	 Tic8zdB2y+4t/oY/aoHbZ/uOIyQ+E1s8YtNluzURsDOIM/wBeNo/rweaRLfVNiAwAT4W7
	 j+y9HiujNt5g+tE/+gSsMk+TPtUj5WA/qQmdYf8kk48mTprVsStJIl1J4OfNRrnKF61/2
	 DADMJrEhpejMu7XDBuQ8Jnh56tPlltWbCeKRGhG/EddbZ5cMXmzfhku3YVCJIUgwoSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607836;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=IBoKhg5dBZ1DsKgj+CXErdE1bitj6h6neJBIp+o1CAs=;
	b=Tj2pnBc0yMOru69iqMYPAj57INfVDaQk0yge1Mae8Ylpq/QvzFNLI7DXtXtweNuBJaL/
	 h3XH7yiMnTwKhfxSVFudcrNUSq3yRfkDLHERKzTnyc1Wj30FnNZwUv83HFt/26LODa0gd
	 a1RyEIwM+50+snM7S0SnENaAnMBRKid5LlTtw4sg3Kx7xsFL7J5SJGashM5h1xVfU7Ie7
	 H8AW3lXARVbQdNID63qlE/HEvBe1SzlbEBOY/4hDp7gNeHu/dKqxZWYXwTLbc9S8FofHp
	 uD+V42U1UiH+R0FpMRIoG2A1amJoymkJG5Zf33Bbj7ZBwnQljJpHN5cjh9oQzRTGchA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="R/pSkdv/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.24
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA1606A331;
	Fri, 13 Nov 2026 22:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CDA1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R/pSkdv/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f72HXBikPkwMocn9Wigh3YEhmtxodrPiMoKinNw7rh5ombhyfkIGr4STf7ykuysD+7CRZ29hqzxkEK8uZtdz11lyVoXUmgs0EJLMeRV+MTTHWeMUWGwElw85Oi8PEpGo0oDQj//45vzKTxqNNMHI/ujiEw6wApNLhMeBclVq/y7KHDi/TE3hl0h1Ft+u6nNiD0d6sN0F4JnCgrm7BG60EN0S7vgmnGO0OmXNTO/6TOLrvgUSHniuhF/vSBSzUi7bFP0G5Xj8cfuwFoRbHkqyRrBMUSiN2LCjnvNHWJV1YIcSOIZe94HiO2n/50RXLpc7Y6ARAGGPkzgFf+k9x6TOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBoKhg5dBZ1DsKgj+CXErdE1bitj6h6neJBIp+o1CAs=;
 b=DpOpapR75QoQgsf+JqnC6yxu6uIcaP8VLfAlKjsPM9t8BNd6/a90bYstFrPGo97fvY8u0XhLR6GxQ3/o5dG6ey6B1zXF9k/BFSwEexF7sB/XU9lyr80cwyga6Lmz+JImIemCLnACyZalRbZdYB3kCh9OyTYtB1RYfHU5YDv95E+M4kqXtP+AJZ9hjGxlzgJQVS6rLH7FaRD+m927UUoTAVpf57zPpczxBMfS3m+AVb/RxCT1gdhOa9ufuUFOQbhLF1ZjyN+8XXc/L5PjMwOsW70+bAvMYmDZIMwc7LoFzX84dYis6IATYpvb4EtYqr0MvSHkM13XAIOys23w1yDwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBoKhg5dBZ1DsKgj+CXErdE1bitj6h6neJBIp+o1CAs=;
 b=R/pSkdv/nCOQ1HAMFmbIoJ57rKvGiuPDdGy05XFay8GUf3BLM3TpcnLCeaqaiDvMzQ9Sw0XxQJmcQnWJgQ0jVyhD1LR2p7EI8cxQ8137PWDugU4uRQ1DJddA94qmUaekCfqL3yFGuaf3lVRGZYJdi0v7gFDC0CB0yv8UjY1OVepEd6GrW27T9gzTNZJ+y715x7cYIeI0/nvVra9KFHIL8gVM0E7kqvqb51T5jD2P+Fcsh48rDetwwTn4lAxR/zeafJFRCD6PVTPIUZ18HCR7x+mTPej03F/bG+ttt53fi4eJSm7sfkfm6Gc/Oi1TSIt3KXPJTlGhorMC0IX+p45uFw==
Received: from PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 22:10:31 +0000
Received: from PH7PR12MB8794.namprd12.prod.outlook.com
 ([fe80::275a:bcb7:918e:7313]) by PH7PR12MB8794.namprd12.prod.outlook.com
 ([fe80::275a:bcb7:918e:7313%3]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 22:10:30 +0000
From: Daniel Trujillo <datrujillo@nvidia.com>
To: "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "memxor@gmail.com" <memxor@gmail.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org"
	<song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "emil@etsalapatis.com"
	<emil@etsalapatis.com>, "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "martin.lau@kernel.org"
	<martin.lau@kernel.org>, "mason@kernel.org" <mason@kernel.org>
Subject: Re: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper loads
Thread-Topic: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper loads
Thread-Index: AQHdc6uzG1gpx7ZaXkuKXK5YXvYSNLcseM4AgAATr60=
Date: Fri, 13 Nov 2026 22:10:30 +0000
Message-ID:
 <PH7PR12MB879438580EC303DBBC3EC0DBB27F2@PH7PR12MB8794.namprd12.prod.outlook.com>
References: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
 <651acc6e21aae9067dd3b8ccce4aa38da032b57324836cc75a1fbaa959e2ef10@mail.kernel.org>
In-Reply-To:
 <651acc6e21aae9067dd3b8ccce4aa38da032b57324836cc75a1fbaa959e2ef10@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8794:EE_|SJ2PR12MB7992:EE_
x-ms-office365-filtering-correlation-id: e093e549-abd9-4c1a-4f64-08df41d2ee6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|38070700021|10067099003|11063799006|4143699003|56012099006|261026140227099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 WkOXW9WR1Q4/QqUKHccBO0xLonfBQIVqsw4FDaV5QqzMag7bh4Z96Y7T/0ajfz+Y408IkqHsURTL04VkfCsag7bflVrXYE6f1oiDUzIBZAploBDA8j2soE/4HBU9y/SD2lC/NfOf8dz0CNvLTLXbgMAibR8Zi3AZregBsiMnYFh+dhSIT3qKyAF21tAxZnPOOC0GhoMKZ2GEHTnwPW7IqawV5u2KiUn4D2Zph9u6JvNdBJGFzwVAdC8qqjWKtfEJ4eV4Sk4OBveAWa6Iz2qvKMOXmNqx3dg0MEP7Dz2UfrcIk7xY3AEEqHWYQmdbnkMaOBBPsbqfltK2PlzTj5DaX1/2mg2PGHbFJW8BxjW2EOykNrmRVuiOR/7enQpgr9+wbQM2LUsSSIySgiAmb3cH6UnCzbuCxs2a5axVvv7uglrDV8MpvHzJa/DAaec3k1Da/X9aR9f5NsEKwQpstuG4qDk1WDzt0nHSo4kz7ytAAhrp1jBqeikt6ZX0bu/zPqP+klUXahNeWhIWZV2FOTzw0nBNMgAxqz07zXdAYXDRDtTUxaIUddqcTbREIAerTSiDu3DMlj3cgxSW6RlktnfyRl2fojtZfw9mZ/FaG8FtGnk4EGviCeu0LQ+ZtnY9Pw7x6woPdFjOM1T/ygsZ3lNMCXptBlL6ZRQygu4mDxCgvh/B0Fl5rD4QnVOsPr0nxBtDsnEKJxy669YlKRjHt9bQONkJHE2eYtOh3iLwcAwan7L7kGO3eLFCu9ZnQi5c+MsL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8794.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Nx5/L7huWa+Mk8a5n0tdEvreo5ZtuX/oi4qlTc8BPFimNgpLYVJ9PlAPsB?=
 =?iso-8859-1?Q?qlf2ZjHOVbcYupMgFsbvn3L0BoyVojdkYiZWaPKf/N5/IqHssLNTKztOWl?=
 =?iso-8859-1?Q?rLD8cVcGdlMg8R3Kyyj0C3PDDXkFxZDkgSN3heV+Aru5s8goj4JSBcZSQ9?=
 =?iso-8859-1?Q?FQA3ddorIviOZ79ZqBi94+73sZFNnYNxzhT+4W89ygWiIHg1HkH93PiQN0?=
 =?iso-8859-1?Q?KieRnsyvP9BVO8x3+yuu0wwsAG7zB+lTfJtvUIuZJfuP7pmK+prXDldFpq?=
 =?iso-8859-1?Q?C6XgvMONDiYtcq85lHKJQjxFnLgRWDTixQES4pBg2unleeTnhLHMokxQxF?=
 =?iso-8859-1?Q?WjWi4QgXxU0h6iZiC/vBwE8JCtCPKyirPGGE3Q9UYXfEme57YuUgImk96P?=
 =?iso-8859-1?Q?FqwE292uUxD0OzwGFj0puUtkyJUMKs+8L0gRka+D1nfTkG4FNe/tqPanda?=
 =?iso-8859-1?Q?F4wSbiKk/16jP0WIWmvgcq7Q4hyxqu27WKv9JXVZ/NJsl/QG+3biWK8gq7?=
 =?iso-8859-1?Q?SGAEMLA1A4JvrQPyIx/8iXbkLCY62vA+9ZbOeHKNyK4iZwluuQtlLTq/Ez?=
 =?iso-8859-1?Q?qT68OOTchiT3VYgTgcAQyRgC4aBG9gwUSg01/LdmzbBhyOtP3gA12LppL1?=
 =?iso-8859-1?Q?AvL7l6ceTUtFeMYDN0eHgYSv/c5vp9rdfMFmUSOPImPxhEv9ooK3CwVEBn?=
 =?iso-8859-1?Q?qlAbjAJZ+JjP2sfnOHuyMYSva8Co0PZyXCVNyiOy08HV/MzcA0sLswXxzX?=
 =?iso-8859-1?Q?8FIYCKaNmjgaommtuG9F9hZ0XKy+r+T+vMHEQE5ikDpBno10x5stg8fp3Z?=
 =?iso-8859-1?Q?0jjCBSh6q3UTRIS95Yu4XMXsRNxGKAFRoLhD6gBK+XXoKEEQNpGSZTDM66?=
 =?iso-8859-1?Q?rFJby0AWpLb3RG0kXrNtHBkZs48tNfklFUZ389YPQsCYpr4fihna+pwX0+?=
 =?iso-8859-1?Q?FymKswbsj1xgq/xnrg7B5Pa5mOFrG/U1A6Jue+vFvZl9mVYYnHRMqT6Gh7?=
 =?iso-8859-1?Q?MQUMqQoIcohZ4DhTNipUSS8DzAbEwKgpgql2lptitSfgn9oTi1SDOzMf2T?=
 =?iso-8859-1?Q?rZccZK7a0IR/WDWHGXlaDPUYGC2R3rdsrzeVNIhX3XR9gktrOVfXK3FFhH?=
 =?iso-8859-1?Q?D+udfF5UsgXqAYgXOpE8KfDRqaNwc4YOCkMVCqZrZyV8AQuRoEPiYI/zDG?=
 =?iso-8859-1?Q?s/n8vLLSDGW57m4qBzfZmqRvF83YSNk+3oykZGcZOwkFSEroV0IeSvO3yq?=
 =?iso-8859-1?Q?GC+6vB2wQvkTL8B6nGmcnvzBp3PJStKhGiU5A+Q7B/jCPDjMhSGzkCP8UB?=
 =?iso-8859-1?Q?ukjqaIXv7W86oDq7Jo9hM6OvDFkA7rBDsMaDxHBGSrpXguXdiTPvKg00ee?=
 =?iso-8859-1?Q?u7vnE3znd2EDC7pHipFlTziVTIIhzNEV7KBjfG0u1Njsp3+GzKAgIubpSe?=
 =?iso-8859-1?Q?5n0fRwb1XGPbgEbHXcdnu62GF+Zemvsvs5CPE9GsKPSWKoI+TTumM3fPgF?=
 =?iso-8859-1?Q?ZPZ6LaD6H356jcBJUlwAvptiSOHQn7/3o5X1jC+ltv/9lerLIK/mlvBl87?=
 =?iso-8859-1?Q?HrmYN4e6FIc+DSiL0YE3bCGNLXRsCSTPo93zkj3MpztAPd9wv6Er+gCqN3?=
 =?iso-8859-1?Q?7QwXPugPQ++2GmuYDGcaREETl8jtAlCO7TiN6T+D/3OgXxK0i64npchf38?=
 =?iso-8859-1?Q?cEB1DyyMBk61i6XS085//kCysf1UvDIZzW2IzBbotdZYpIiNHTqZ6CjGYI?=
 =?iso-8859-1?Q?6GsINcT5XcAFHmPCMA0G5ERLxFyZAl/x6dS+oS98XHy64yRQVaO+/p0Rmj?=
 =?iso-8859-1?Q?Vh5aph15xQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e093e549-abd9-4c1a-4f64-08df41d2ee6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 22:10:30.8668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPaX6AnWP5L45XdPfVYIzdVoW1oU0a5a3dC+NHN01etq/GldeaZfpJh1uIPQtCqvrii7He4v4C8UE68CyYAYjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
X-OriginatorOrg: Nvidia.com

> Should convert_bpf_ld_abs() get the same treatment, or should the=0A=
> changelog explain why constant-offset loads are out of scope?=0A=
=0A=
Thanks for pointing this out. This patch only hardens the helper fast=0A=
paths used by the leakage demonstrated with added CLFLUSH instrumentation.=
=0A=
=0A=
The offsets for inline ABS/MSH loads are fixed by the installed filter,=0A=
so changing an offset requires replacing the filter. In the proposed=0A=
long-packet/short-packet scenario, the offset must also fit within the=0A=
training packet's linear data. Neither should prevent exploitation;=0A=
they should just make it less convenient. But I have not demonstrated=0A=
leakage through the inline ABS/MSH path experimentally, so I scoped this=0A=
patch to the demonstrated helper path.=0A=
=0A=
Before deciding how/whether to harden the inline ABS/MSH path, I'd=0A=
appreciate the maintainers' views on it and on the patch as submitted.=
