Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794484910;
	b=QJFJfwwRMng3WYj/b7RX3XEqWAWfl3bxGaCyaB566rhSYBJhB8s+arbdBpZ4uwMYk+Dg
	 u3v4lfA5yQIakBaiuRGSaePOgUchdYeJUYCPdABRBmbCohX7tjvpg4kmCS8eUHFRJI5Er
	 4N8MBJOqoc9CPlf+PahegTEyXdzCrFEZztv5XgGBNo95bTfVbNA/54JZWWk0a5rTL5pOv
	 FsDfwa3Mkdud+RW0WXK7SOlGY49YfQxBCE1DHzdgZVBgf2jsyLslH7ai47rTXHKtmwGO+
	 M+yQfi4SXL5CSuK/rLemW+lkUyZjMCyRUDQ7Je87DUHeNRAcwYTIU0bIjfhmggOVnvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484910;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SBNr0+2AZlTPbKS0W4NWIJtpVcidq1lREuI4uftiBvo=;
	b=aa/Jj0djw4AFvIUhw0kGjQOP6mEe8wdlA9wysb2SgRHe0/MqqW6amwv8xnOxHxPOh57E
	 V2vhY/O3ZFmYunrOqhioIr0uePVH2R+YxU0p+/5knZij4jwb9u3Ff7YgWH0lH8rO9mi12
	 R1HgUvRd598uh7F7biWCmZEE/c+qklONPEznqPGwaiBnL3XbFNDUpYFw1sXhyw6CH5iwy
	 aSU5/uXnOIVVrSSzv4/PfKNDpIqf0TRA8jifhFzpPS2NoMzG3P3jMoluHDB/tbB6Wabb8
	 s84cKGSxZX2AFbeo0PHMqnGZyN6TK2LsLgXhw6t/zeaKwsVrwTRM3rSdnmbGcV+E6qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vecima.com;
	spf=pass smtp.mailfrom=vecima.com;
	dkim=pass header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b="Lkr/qYsy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.114
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020114.outbound.protection.outlook.com [52.101.85.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63501606A884;
	Thu, 12 Nov 2026 12:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63501606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vecima.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vecima.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=Lkr/qYsy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBCHF/sZympPRBahO3ljcRnvRmHFKTPXhY/C2W8gQkzKZA9eL/FR3Edg4lHXZDVjtfkLimRx763rVgTflE83Uk2q5tHt3kfZpA6D3WVxuYKEdrVfaqAYeeiaQaq412SFk9HbIoHyonWIS4XtvBqUOFHBUPzG0pIZnmsbm2BfE7DhSPAL8HeWjYRIIRnGRmJiWEKCVr8HJCR9YtS+1JgXgJUq0ZJCFVvIM5CXKAE1YQw8rx3yXm3HbJiJlXRlzCVYaCxnZVt3ZUDrUF436tDagYAEYoDRCMfyi9TmFuTTtsAT/VC2+raawvWIcJmCtPrWYRDze1FALN5sC1dgz8tXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBNr0+2AZlTPbKS0W4NWIJtpVcidq1lREuI4uftiBvo=;
 b=i6fQ3Xn+1TskUHg9dKCFTFTTP5e9onM+0IgwvH5WFGMjBieZxXBNB5fyXymjEBhRHsvgvGTstINdlCn896/PLMDgHXL2opJwRuF/E+LFxb55FkIrlHLNAPPpbKmR5Av6tplQYTJUIGlYv7woy8e0K3UamVj86UFuG9dcXmdwboH35r1r/p5KkpTkSuBuK5Z+19Cy7LJyNOIefdVDK45JnxdScWK/K8vSyiKPG5pPYm5FIThGojlcpBteh7CoYlhfIlQh/LybVRog8jvGWo0yZShYXs8ODFaXthjxAdMXbXAb/z3PND7ozY+BjPwmFOsqy3CSDvCa8KTrj4FGlCCSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vecima.com; dmarc=pass action=none header.from=vecima.com;
 dkim=pass header.d=vecima.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vecima.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBNr0+2AZlTPbKS0W4NWIJtpVcidq1lREuI4uftiBvo=;
 b=Lkr/qYsy1CgVXzuN1VGTllHiik7WmvzkH6kieEMEqLOItgKDhqSYWd8xocoAkAT8dEHf02bpruC4WgjYnnfr/8704IC3TCaLgZC6FsqvgBZa0Zb5jz6+Sla3x8v8h/s1YP+HjuUA/ml2QtpkwnovRwUZFJ0b0xWoEjgTe5JKpk1Yc/+Cpp1wVElUs36lKN+RvR+C0FI7/HAd4RsarvrYpOMyoYIGJWZzjpYaoH47mXgtvCtCLKavPZJlqOXvqTBPKUsRzjkVkHJOo6NssDm5wbWQvM2NXVSdEgDdx5s90ByCVlbRWr6xiRpFQXqivs93YtpsX3vC6S4veimFmeRuPQ==
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::ad2) by SN7PR18MB4062.namprd18.prod.outlook.com
 (2603:10b6:806:10f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 12:01:44 +0000
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::9899:92e0:30cd:fe31]) by DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::9899:92e0:30cd:fe31%8]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 12:01:43 +0000
From: Marcin Knap <Marcin.Knap@vecima.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, "jtollet@cisco.com"
	<jtollet@cisco.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Jason Xing
	<kerneljasonxing@gmail.com>, Nitin Shetty J <nshettyj@marvell.com>, Joshua
 Washington <joshwash@google.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan
	<bbhushan2@marvell.com>
Subject: Re: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Topic: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Index: AQHdcDm2vnnEhLN5t0qvtxpdZuY27LcprD2AgABoNOGAADHmAIAACgcy
Date: Thu, 12 Nov 2026 12:01:43 +0000
Message-ID:
 <DS4PPFFD8A841C2E4D23FCBC4BAB8C3951180702@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
References: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
 <20261111173715.75bccc04@kernel.org>
 <DS4PPFFD8A841C21E59BFBD0D40DF2C5EA380702@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <avWZkOvpKXVzpALX@boxer>
In-Reply-To: <avWZkOvpKXVzpALX@boxer>
Accept-Language: en-150, pl-PL, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Enabled=True;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SiteId=9d639caa-2d40-486d-ac82-e59b0005382f;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SetDate=2026-11-12T12:01:42.575Z;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Name=General;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_ContentBits=1;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vecima.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFFD8A841C2:EE_|SN7PR18MB4062:EE_
x-ms-office365-filtering-correlation-id: aa758b6e-d173-42d3-5c0e-08df40b4b7d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 JaWfUibF4rNPmuC2wnpVVQcOx8Ut6yIR83olaBJbgnybQ7/VWvpF+Ii/yvdit/w+CnnXdJQYFAbzbn50cVOWHkyRlwjZx3BI0RALRZY79tN1uF55abIaeN43nblofmOPQM14hGi3+kJ/iCmaMelndpvrWX8XrF6Jbl/ciK4Zidns4nybaw8+QvH8/2EMI/TE6n8Ev6KTwStewHie1XyLoWwLoO2C0QMyOHygWP9nlfQlnv/u6QKUHNYvJXUtkeAzMKbi/o9ZA6BSaV3uvjftoaoI0DriJqfxM3uBqoE43+bFfHieD4AFMW9+Ci+DqjAtKeIhRb1pWY9oJk1mJ7VDgZCuCj6pRv9G7w0hdknKqxI9bT7wE9GtHYc63P5gYvyNFo9KDOLBXXp7CDfZ2EAVIBWPgYiw2Zg8Vd0wvGyTmeT1bUhwnBJBh4g69VtL0fJOaee7TJPWpSlyMzTUxlmgaIRXzONV9NVlVNc3cGwkBTTj155XwAFNPRUa2m8U5wjt8+PsCRfE8Xd2I9Ej/4r7lvmhH25UaRdxUhbVQat9OXEtNfT8nqt/Hs+7GsEFMdVNHD264hY0f0taYSKCaA22IoBAsKO4/WHAeX1dwB5N5iQUB26totD/waAILeW6qkQ9n9jk9nlqgbQd06ky9JfPQ3Cj01SYH9HL1i/u1u3jT9e65O6D3Q4KmtZxSEV8kf8/NBejevusud8eyItK+6/K6PIOewT2QCRc1JpDwWgwJPQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFFD8A841C2.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sWZaIkGcn58nx8NvvxYM79Au9bCKyxD72o+RaG9rz9CvoiCcs4wdIyYuxP?=
 =?iso-8859-1?Q?OYmvJEGzuy65k4h6dgbvyeLe3SDXG5y7jrtXhfVbSQY6ohx83TAHxMnrfQ?=
 =?iso-8859-1?Q?pruJLOiE2QI7JHZx5sCqJBHeuoBVMRH/DwT2FAS2b+j+xtuJKoRBkBvzYX?=
 =?iso-8859-1?Q?UAF0PWCeOMfa5w+SEeoBl+9sxhh7y2XfGL0X3aoGUCk35LC8SkLwAKeykZ?=
 =?iso-8859-1?Q?BzImo7lcl+wVwGm9DlQ6FVHhzQlajC4LsjLDwX+eaJGj6jHFixQ9+iVX0o?=
 =?iso-8859-1?Q?24x2uRnHbs0jQNDycxTPdTabedk/PBaF0ZzPmyBqBXWt4+pADPnhjFELBJ?=
 =?iso-8859-1?Q?XlvPwGtdJaQoBjGyHBwFPGmIjgjM64thqD+lv85iK++uB553/vvQjdzFub?=
 =?iso-8859-1?Q?ENCrPqJ3GDsLOZZUDpjwmCcEKbYcqV/hoNkF+SBVfEeLZPDP8Ry8A5SPbT?=
 =?iso-8859-1?Q?W5/bIQ6j5XkO2Q+MVZ9DoL7lZ29zn0FIUf3IW/FKDb0FudNmCUlkFyaurj?=
 =?iso-8859-1?Q?ruV58Q1RId9arU3j3a5tSz2Wr7rZPkn+D1kFgUwuPx86roDhm7X3VMrLDn?=
 =?iso-8859-1?Q?9+eF0hS+Q48eXGKwZg0QrJthn+phgZ8xqpFzw1Pf720bX6xQnxPRHKe72g?=
 =?iso-8859-1?Q?NxKL/ZUbKb67vaX07nxZBV0D0WiQGL4dSH4dpcaW5Yfpc+rsn/XKZqRAnB?=
 =?iso-8859-1?Q?gUHXUif/d1VyIfZPRj9wsjgr5lwh6a06gwvURtpRHbd66qguVj4Al+qaYE?=
 =?iso-8859-1?Q?X+FwiPrVBgpRoeflBJclQRDIg6BkzUtL2F6s9FlYJ9fJc8qVmt+vAUZnlf?=
 =?iso-8859-1?Q?5is3OhuCKXTRWGBRupT81Bet8uuzrgdZVJ8JpdydJS/mrX43yIPH7K5JCn?=
 =?iso-8859-1?Q?ErkrUItPwXXsZN1I8oYxnGfjASAyjte9jf4LMNM01l9jeNOtICzNPvL2W9?=
 =?iso-8859-1?Q?i8dfaPOv6/f2lZYaYaiqh83rE3AXKE2mUg0unnUXbeJTUmrQe5ss78WB7D?=
 =?iso-8859-1?Q?g5g3SWn2ZaWJYiXudUkHZJeA7D449f05+s7i8AUp3Hz79lf9RvFlocKSF9?=
 =?iso-8859-1?Q?qOzPg496Uih3kcYrS1RCVCPF1aXmKdl8lCQJ62pcjYLbdEBMj97azzn+3H?=
 =?iso-8859-1?Q?HVsCCiNkeAHacFZurtq8EodkZI616iNHtzZWlAXFyX/t8BHHdZs2He393O?=
 =?iso-8859-1?Q?BrKm/0U6o+VlFtS9V9MGoWramjtysCLT7Y7sDxO4t8z2o/PO9aBfatT5gk?=
 =?iso-8859-1?Q?5EADdnHs8Uz2jY7vL8cF1Kz1KsThtV2X0eabKI3jHSDx1lZ/7CdpXtSSXj?=
 =?iso-8859-1?Q?19/Un77t9PN2RunbPCblZrr+5eY9hdF2KTF3kkT2bBTDqr0aw+8mtxBU8d?=
 =?iso-8859-1?Q?nLfXL1I+15PG1TfdRQeHAKQmZUTHUV8+zr5PeayKlRIjXlIgAN/YSr6C1d?=
 =?iso-8859-1?Q?4zRyuAlPexEFlZ4Hg0+lIV25yJmbLGr7cnztInA4oLcVwmVm0aXEbO9FGe?=
 =?iso-8859-1?Q?gv3bWhYIl6hplofriD7TcTzZ5tn30OJ75fgTbrZYdJ72yJ8/BctMaPG529?=
 =?iso-8859-1?Q?3jK/u3SCmNdHHDGaYn+CEGX6LVYRwn1vOOHJ782scw20mJxLdfzBwYlNbO?=
 =?iso-8859-1?Q?BjEjxPH1TFRdezduFhqjlje84Snz4OY90p9FfMrhmnq0QUwNCKqPyOqsli?=
 =?iso-8859-1?Q?4/g7vetHa4RnnvxkoX2svK8XdpFKzRzpZDRHSdvVpf+iDJ3Qp3hr+dPbJ6?=
 =?iso-8859-1?Q?+A6OhRa6XTnIXbNvm0K6BTIioRvghbywIBwSrFrPld9WY6?=
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
X-OriginatorOrg: vecima.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFFD8A841C2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa758b6e-d173-42d3-5c0e-08df40b4b7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 12:01:43.1584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d639caa-2d40-486d-ac82-e59b0005382f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTJunQnnpDxT6ihTCGFWfShJMH/leWBq2KZlIdE0EdfnQdD7RchFNAsluNG/Z6feqp++aAkyPeUsG99LAtIYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4062

>Hmm. So it seems like currently, when we managed to properly copy from zc=
=0A=
>the 'normal' page and redirect failed, we would interpret this as (based=
=0A=
>on ice implementation, not sure about other zc drivers) ICE_XDP_CONSUMED=
=0A=
>which would do another xsk_buff_free() which would be a no-op on this=0A=
>xdp_buff at this point but 'normal' page would indeed leak?=0A=
=0A=
Yes, that's my understanding too. xdp_convert_zc_to_xdp_frame() puts the=0A=
ZC buffer back on the free list right after the copy, and when=0A=
__xdp_do_redirect_frame() then fails nothing frees the copied frame,=0A=
so that page leaks. On ice the following xsk_buff_free() for=0A=
ICE_XDP_CONSUMED is a no-op, since xp_free() skips a buffer that is=0A=
already on the free list.=0A=
=0A=
That only works because ice frees right away, before anything else is=0A=
allocated from the pool. Drivers that release the buffer later, like=0A=
mlx5 on Rx WQE refill, can still free a buffer that has been handed=0A=
out again in the meantime, the same way as on the XSKMAP path.=0A=
=0A=
If the copy itself fails, the ZC buffer is not freed and the driver=0A=
frees it once, so that case is fine.=0A=
=0A=
In short, for failed __xdp_do_redirect_frame():=0A=
- the copied page leaks, in every ZC driver=0A=
- the ZC buffer is freed twice, which is harmless when the driver=0A=
  frees it right away (ice, i40e, ...) but can corrupt the pool when=0A=
  it frees it later (e.g. mlx5).=0A=
=0A=
The patch does not affect that path.=
