Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85E370AC7;
	Tue, 19 May 2026 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187559; cv=fail; b=ZVAxYltKUs8sN5WEnr4Dc8LTfFJjZCb4GnoCEJoifBut7eptNINHRWInAuP0s27cK/rp7MdW/XYxIwZV0/J+ndHueZt0i0JwOvktMiB5Hmoo3uZgu3hH3rCZ7PVtIm3OKff5QGp1gxLuykPALDMua0wUeGKhoxIHOEW7rKvZQEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187559; c=relaxed/simple;
	bh=Jq6RiEo41JQSBQT7f/u1T+K0TVLFBRnHt80KbYdRMLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S6KnZk/hgJlmrakCSWq+JEOKlGZ0hKAfXkK6acRI75aCJSDLDJFf5UyW5KU6wPqeHS5oGXRj7QIb72Ri+7q916FGJ1iXWn2foNcIyb7vd20gwD2ccEph+uytXglDQf2f+oG40EF/V9+OKQCN+XT8mkcy0WBrWB/NRvYco9sGzPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=VVXMVUsm; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="VVXMVUsm"
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J4tSfN3017171;
	Tue, 19 May 2026 11:45:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=jDHHT0hJwVSyyQr/HHgiu8
	e0bhY5TOSkYQ0exh4xF6c=; b=VVXMVUsmTXGF0bhsDET30B7Bn2UG87ph2VEp7Y
	2Eimpfi6Ilwe+rA3D0TNV6vmpd811dsjUggPP0NKQKacZRfTi+54lUn1CAZMJdmD
	+ThSSqg4si0+515sJv8w6bHIB3+wgCcDmsplKGd+w7EwNuQlIaxoQjgaLcIqtB9b
	2RicsoGgCBdye3hV5K+8nzDcRvwbos32STuf+b47uux8aTntPjEUsjYokzt+iJJM
	bu7RMOQI3FnNKdCm9ZumPXbJg2i5lRLy9qFKw6HAk+GQE+q17X4n2vF3X4s3UV/9
	OhlpSgfDiB9UAg6BU9VgyxBK2fQqoJ6Ldm9nxeh8aNw8Kgtg==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4e6gyhjshe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:45:50 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAMBND014631;
	Tue, 19 May 2026 03:45:49 -0700
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4e6pj8ves4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 03:45:49 -0700 (PDT)
Received: from ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:45:48 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:45:47 -0700
Received: from SN1PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 05:45:48 -0500
Received: from SA1PR17MB4708.namprd17.prod.outlook.com (2603:10b6:806:19b::16)
 by SA5PR17MB7787.namprd17.prod.outlook.com (2603:10b6:806:474::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 10:45:46 +0000
Received: from SA1PR17MB4708.namprd17.prod.outlook.com
 ([fe80::9fa:d156:893e:6287]) by SA1PR17MB4708.namprd17.prod.outlook.com
 ([fe80::9fa:d156:893e:6287%5]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 10:45:46 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel
 decapsulation
Thread-Topic: [PATCH v6 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel
 decapsulation
Thread-Index: AQHc269PG7Zl5pyz0kCWKDRoZFIn1rX+0/MAgBZt7gA=
Date: Tue, 19 May 2026 10:45:46 +0000
Message-ID: <F85DE72B-48D1-43A1-A188-5B69E65A6DAB@akamai.com>
References: <20260504101759.3319427-4-nhudson@akamai.com>
 <20260505041427.787D0C2BCB4@smtp.kernel.org>
In-Reply-To: <20260505041427.787D0C2BCB4@smtp.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR17MB4708:EE_|SA5PR17MB7787:EE_
x-ms-office365-filtering-correlation-id: c738f0c3-ad49-4e36-a919-08deb593c8ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|6049299003|1800799024|10070799003|4053099003|8096899003|56012099003|18002099003|22082099003|38070700021|13003099007|4143699003|4133799003;
x-microsoft-antispam-message-info: +aTuujlY3/fzF6zYIMVGGpLWoqKSR+Z3ZQDkXwZf6e/R5TPYsJpA4t0bRXigltzFItR40kRyOV7JtmPCKG1gC6T9+xL8assUcznNEVzdhtOUMczBSBomBz0SiMpNFtjBc1rjrbgWfiwcaVmEQuwvdhUSyYO4e9G7NZCcRvFczIhYslvZPmF4QM5KFQp7WfwEFggYd2qm4TVDBgVpT2jaY5vWtlATlx6fu0+swU79in38Jr/WL8BBYC6T1FW8FBufXVf+wziJSCH2m144nJ5WRBHnDiZnxy81ZjEh97Ia8bCwXCbUovgiU2kMbMgi7WawkO1gq7HmWfzh13dnXToYhBZjyy2k6ChT5mxPSq0Tq8JqdwTWIRR3Cp473L6fWMkBso8vp8WpCG0svarSax/goK8E6no04TV6sGJydjowOfn0pKuzukTLjeuKFx5S8RCqBJ/P4lxpee0PtCJVFrkUdhVU+OSa+i4d0v9GYFNoKeYwTNSJiopzBswEO2pELxu0cOX/RmIfv+FrQax8gtWMx+i1+AFYAQgueTMFFtibfHjWoqBPDFE68OcEEs/cdNahN2VrF+RcFe4Wd3H045N/ixRAkqA8FtCCBDd/FlaDtSrC4O/Hnt2OT2d4DzaK5VEkItkf8FzzaxvN5OmzFdo0AQ9nJKr0CvMK0wH4eh/HEBLkF85CicfMhflo7h7dI3PE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR17MB4708.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(6049299003)(1800799024)(10070799003)(4053099003)(8096899003)(56012099003)(18002099003)(22082099003)(38070700021)(13003099007)(4143699003)(4133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFA5TytwZEpFajc3aENUSzY2dDNIN2RNUHNQT1RJRkFpdFBCSGxpZWh4V0hE?=
 =?utf-8?B?U3pZTC9HanFOdTdsZjU4RTkvYlFiL1ZwR2lXY05oTUxDWE1mOHpHbkpuWVVL?=
 =?utf-8?B?T0ltTVlndHpaeGlPTEFKK08raDZ0S003RndiYXlmV282cUxRSC9jK2czZk1h?=
 =?utf-8?B?WjJJYkpDdTJUWWxLNVgyZm82YzlDVDJCY0dWcTJaMmZoZ2NBKzJYUkdhN0lw?=
 =?utf-8?B?SFVFNW1qcTVYYUJHZnhvcUxENGUwcU50d3J4TEdKT1NSUDRRNy9KVWtaVWNr?=
 =?utf-8?B?NytnU0NubkIvWjBmWnB0VlN4TWwwcHU4Zm9GM1Q2c3gybGZqRFlmcXpwSzlV?=
 =?utf-8?B?bjB4Z2NKclUwU05DUGNhbU4wZnEvVTBZRUJYN0JRbklldHBiZTAyTnhmS1Zs?=
 =?utf-8?B?TDVCcFBiczZGVFBSelUxQWRaWGV5QUptWG1ySTljcjV5SWpBT0hqS3JHSWxi?=
 =?utf-8?B?RkZPeFk4dU52NGI3dEJxWDQxZzlPOHJ4ZGJqRmlXKzJ2ZGo2MXpZcEVCWHBx?=
 =?utf-8?B?d0VqdE5IbWRCTDJQSHlDOExJVFRFRU1ibkdjSU04MzNPczRlc2NmZEUwc2di?=
 =?utf-8?B?STlBT0JURWwvRmlNa05MdmJwWjB6cFlpZmF6NGJNcU5VdWRBWXVCbnRRV28w?=
 =?utf-8?B?WHZJZlN5VHpYSnZoOTJ2U3FCREdPS1J5MkJPcG1nVnlRYkZNVnJCb1R0c3ZW?=
 =?utf-8?B?Vm1STlZQdG9vN0dVdlpHTXhqQ3NPMng4aFY5SGlMekhKMkM0MGJGUGhqWGp2?=
 =?utf-8?B?M1lQN0cwMmk5VEc2enNRejZOK25ERVNYb2libDJzWm9kUVRDYXArZ1ZLT05Q?=
 =?utf-8?B?bGdZa1lTbHFCcS9Za0F6SHd2SitKK3ZyTFNTaXpOa29nVXNQM0puSzNqT3JB?=
 =?utf-8?B?SmZaTW52RWs4dU95b0Y3Qk51cFZWcWRJcjk1WmdJZnVJcWVZTmhNMVI2ekZ4?=
 =?utf-8?B?T2N5ZFljOThsN1Z3cHRvejFYazl0cmhxYlpFWVZ6UHAvQkRyTjRGUzlUZmlq?=
 =?utf-8?B?NnNYNUE4WHJQUmF3R3dvQWNGRXV2bVpHRWV3Z3FsaEgreVRjWFIrakVraTdl?=
 =?utf-8?B?bWZ1RHVHVVpwTXNqckI1OEFqNGt5ZHNhMjJ0Uk55aytOb1YrZ0ZkWmVKQkw3?=
 =?utf-8?B?SWwwNWFVSjFldEdsQ2RIVEtLTE1hSGQvWmF3bnhzRmNmYkNHSWVGU2wzNDZo?=
 =?utf-8?B?aHJXTkZIVWVaelltZHh4ck11U1k1c2pSMTJldHN6bDVSa255M3ZaQWx2VjJa?=
 =?utf-8?B?L29kdm9mU0FhWlZPNy9FcHZzd0ZVdjFuSXljU3pwUnZyN2JGTzRsK1d6dTJU?=
 =?utf-8?B?RzFMMWgrRHRJT0cvRlNvdUQ5MC8yZEZTbUZHNHAyVlpCVTFxakcvMjZzdGgv?=
 =?utf-8?B?dnlUdnVPMlhKd1BZdndKaFVuV08yYjVEZW9veGRjbFZXa2R2TjVpbFJNRE5x?=
 =?utf-8?B?RnJ0QTB0U2dkcFgwemplMHVQaGlSMnVTVFFxNnl5VVlHSFkyZUVMNUJFUERJ?=
 =?utf-8?B?UGdXalM0YU9aL0hZcDFydzR0QUVTNk9vTHp3MXRwKzZYUU9VT21LMThRRlk0?=
 =?utf-8?B?THVWM2VGWGJjMzFIZlhFQzR5MW03YS92QnhPNUtvYm5xMlRWTThIUDZNWFZO?=
 =?utf-8?B?dC9Tc09yaHRPc3FLS3hnTXdpcG54alRGMXFoQ2J2eDkxWmwzMVY2NUxFOFMv?=
 =?utf-8?B?SS9PdGE1UEo5QnhUZmR3T2lyRXJJelJnOFJmSzNXdWdLeTB2a2hoUlgxNTJ6?=
 =?utf-8?B?TXNETGVRZ0YrcDNCbzZVMDhnOFNrckV1ejgybmhWNVVUM1JOWW8wS28wSUVK?=
 =?utf-8?B?ZWtMd2VoUUlqb3ZJekF4Um5RTG5YKy9hVHllWnI4a1A2dmtZbXhJYjBadE5u?=
 =?utf-8?B?MFNhKzE4bWJXbGJWZTZLbUhzREh2NWhXeGE5MlQzNEZycW5rZXQrb0hNZmkv?=
 =?utf-8?B?a2ZNOHNoYlhUR3RTVTloU1pXU1NySnJIbzBKb2ZwY2IxMmRza0FVTkkwazlI?=
 =?utf-8?B?T09aUzlEbTBVZ3VDRmxUQy9RVVM3TnNpVjM5ZVoxcTUrOEVrWEVldVp3QW1v?=
 =?utf-8?B?Z3FWUHFBMHJCRW5Eb091MnY2Y2Q2Z2dIZm5TQWdQMkYzaytvbkFwM05Vd3NH?=
 =?utf-8?B?Mm5ndlQrM0ZNU1RsdzNBTFgvcVE2dTRWOFlKc3dzV0x6ZjhGOExsa3V6RGxu?=
 =?utf-8?B?d1lyeXI3L3BBM0lHemdaUDdUU3A1Vjgybll5dkVqK0JDNzd3dFBsWGZMRDFP?=
 =?utf-8?B?N0x6NDJYemJiOS82VlFobGswSWhqcmh4V05EOHd6ekptVlZOaExMak9MamJm?=
 =?utf-8?B?OXJwKzlIa2N0N2lwUmhHS1Faa2p3Smw2SHoxWVZyQmVLT2MzZHlhcGJGYjdL?=
 =?utf-8?Q?mXCUE9lfkBHLwGRmtjuC3jr7lXBwMUjXY810HAr7qLDVO?=
x-ms-exchange-antispam-messagedata-1: ynMfuSDb/xdJQg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZJKm3Zbca2PQ+5Qr8+np3ZUUn4kEFHAdJAP7XmSzr6wndv6PnW5SCxN3brIwWIr1/fyAP37ATU6kslofL6euha6LS/GZgf2NAOCJZY+ryhP9Bz/U5VffSSQyQ64E6v8CPPuPBrJrrltUmqTdWyt/tfnE82NR+rAuyjgqiapJwPIQVNR9x8N9Jmn1B2OHOoIHsdTg1++aOwSPdRwoCU4qLk4FAWHUc8b6eKXvE+O0uYT5uaXGD3GSMjD6V7nb66ENYWeJIMmJO1R7zaGGoOyriivOiTpeBzOFWgE79nxMWJ4py5jRae1omxX8dpO2WcMREpRQUihAzVS0r8/fNPixQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNiflA41qvkiemRxgJ5Ghvvu3+KzV+mri8HVkdA1n1k=;
 b=TOaMTlhnNUjCyMeyBoDkbVv4CFQm8Zv3n162sRiEoJ8C+XlrrSQLT8hJsY8ft+w86wEq3tIvx245tByTkc4DUN3a0i6DOuG1m/3qXnH0d10hzzgaCRFW5bn3fY2TXfKaDMOLbnCfqCbah0jp/mK9AJSSZamYKggEP7Im8SDPsMowNBJPcM0PqCRx4T2sl46AYfp4de2wqgX6wu8Nc/ip5VZuDbArRnKmU2XI4GTw/nA06a/S6s/BUAcBKY2h4g3gG+C6JlRSVyNEF78WF4qlxj5jHaL8cmNEW4AxG27hylTXl20rAEKxC12NWVF4QBfAt2p4tw/iBpVSk0Xxxw+Ghw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: SGfF0TM/b4Na9C0io0YvWuZZuO0zCTOFzoKZBbLfmFAR7wk7iShGZueUnj99mv+7Z+7X2MhJ487Nf3GNMGiLoUtoBksf81FWFFy4hTar0uIvCjpFsuW4W5l1EyJOMeOANVs6MPKvHo6mEqFlfUMaS/2qSvm3Y4vgBTioA76GVKJEEJdUpEdNqIDKo9vN1iQY3rp6R3RRy7czFfo0WNRVyntm3zZsVmMjx6x5MuJUu9nRKP3sJQSH2qgUFKLrG29JDjgbxDxI9J6TGy3tu894+JeblpSpNrO0TK7/VyynbkesMDKQCMGidbkCYKQJv4CEGFLC+ECXsG9yRjZSiStVFw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA1PR17MB4708.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: c738f0c3-ad49-4e36-a919-08deb593c8ab
x-ms-exchange-crosstenant-originalarrivaltime: 19 May 2026 10:45:46.3989 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: nniP6bgdqj+Oih3TaS+lFNLOqwtYPBkHFFJYNViUpT3fynwZALSdutS9FCTS/nuGeS6VsT7xbtYlBdhWxQ15nQ==
x-ms-exchange-transport-crosstenantheadersstamped: SA5PR17MB7787
Content-Type: multipart/signed;
	boundary="Apple-Mail=_BDE7C93C-EE7F-44A6-8F60-3CE067AED8B5";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605190102
X-Proofpoint-GUID: 31QeXWTU-Vi27ETAE-zWiRkGyCPyva79
X-Authority-Analysis: v=2.4 cv=IdK3n2qa c=1 sm=1 tr=0 ts=6a0c3f5f cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=4OENtXgxWbduB0e82o7S:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=c92rfblmAAAA:8 a=X7Ea-ya5AAAA:8
 a=MZbc7PV4E1MeRYVY5AsA:9 a=QEXdDO2ut3YA:10 a=piTD3JZmPnuBVwMvRaUA:9
 a=G5rUFaunSO1I5xy9:21 a=_W_S_7VecoQA:10 a=aUQEjLJJORIxqg3IqZUA:9
 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 31QeXWTU-Vi27ETAE-zWiRkGyCPyva79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNiBTYWx0ZWRfX7D5hMzIxndNV
 6m8FupAx0Pz+7MLNMEbM3EosLVkoL7UZe7p6AtyfQH3ZCThGtjOWRJFXKoqd0zucFyU50IQMmjc
 tsAXBzewUY7dYrJCNKZQVrXHrEO6vogonI7Awo2l3/f4tyd/L4RUOhpodAb52LHzyZX/LVIaJF9
 bilCPbw/fZzkc2sVz+VDgcyJdK2YhUNfgRqc0okf60rQRgz4udSZqmvrsBn7PDNglJkD2VlDSeG
 4ezcbYG9GAVCKmMV4RSIYyzM0EDG6IX3aAD40hchRr0O4uNo9pVHIGsQ4B8Gkf37yMeXbABX3hH
 Kc6+Sm8nJkpwrpf1IUCTSZshMoL7eazkkUaB24F+IVWqrHwpR1dLdMObObpRYH87AXa3U5tN3ZV
 G/zlAaXgn85FthYu8cCOJKySsPpUbJ7csA+gIBgqr1g8jlquZC6KdwGobM2h++8qkQ6BlWS8f7R
 swFvb2hht6WRI6YeSDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190106

--Apple-Mail=_BDE7C93C-EE7F-44A6-8F60-3CE067AED8B5
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_F196DE3E-781D-4C80-BA94-BBEF43B7D978"


--Apple-Mail=_F196DE3E-781D-4C80-BA94-BBEF43B7D978
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 5, 2026, at 5:14=E2=80=AFAM, sashiko-bot@kernel.org wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> - [High] The documented API behavior fails to clear tunnel modifier =
GSO flags, leading to SKB GSO state corruption.
> --
>=20
> commit b28df908f04d4d037671bd0f85e9d43e6c3ddef9
> Author: Nick Hudson <nhudson@akamai.com>
>=20
> bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
>=20
> This commit adds new bpf_skb_adjust_room() decapsulation flags to =
describe
> which tunnel layer is being removed. This allows later changes to =
update
> tunnel-related GSO state accordingly during decapsulation.
>=20
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
> [ ... ]
>> + *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
>> + *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
>> + *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP =
tunnel.
>=20
> If a tunnel packet has remote checksum offload, does this =
documentation
> imply that tunnel modifier flags like SKB_GSO_TUNNEL_REMCSUM and
> SKB_GSO_PARTIAL are left intact when the base UDP flags are cleared?
>=20
> [ ... ]
>> + *		When using the decapsulation flags above, the =
skb->encapsulation
>> + *		flag is automatically cleared if all tunnel-specific GSO =
flags
>> + *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, =
SKB_GSO_GRE,
>> + *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have =
been
>> + *		removed from the packet. This handles cases where all =
tunnel
>> + *		layers have been decapsulated.
>=20
> If the base tunnel flags are cleared but tunnel modifier flags like
> SKB_GSO_TUNNEL_REMCSUM remain, will the packet be left in an invalid
> state where skb->encapsulation is 0 but tunnel offload features are
> still present? This might cause the network stack's segmentation code =
to
> process a packet with tunnel offload features but no actual tunnel.
>=20

REMCSUM was remove as per maintainers advice:

"
REMCSUM  previously not included in the series.

It is a non-obvious and rare enough feature that I would exclude it,
or move it to a separate patch.
=E2=80=9C

=
https://lore.kernel.org/bpf/willemdebruijn.kernel.245c592e6d270@gmail.com/=



> Also, SKB_GSO_ESP appears to be missing from the list of =
tunnel-specific
> GSO flags that prevent clearing skb->encapsulation. Could this result =
in
> skb->encapsulation being cleared prematurely if an ESP tunnel is still
> present?
>=20

The code in v6 5/6 handles SKB_GSO_ESP  correctly.


> --=20
> Sashiko AI review =C2=B7 =
https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260504101759.=
3319427-1-nhudson@akamai.com?part=3D3__;Iw!!GjvTz_vk!XtvRB5f4u7U30_eGAxcoo=
z-ntTaRbpqZLQdXKnJxBlHKlpwg28UOtr33DUpjhYdnKIgstpZu2LU_fwJYC6ak$


--Apple-Mail=_F196DE3E-781D-4C80-BA94-BBEF43B7D978
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On May 5, 2026, at 5:14=E2=80=AFAM, =
sashiko-bot@kernel.org wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>!---------------------------=
----------------------------------------|<br> &nbsp;This Message Is =46rom=
 an External Sender<br> &nbsp;This message came from outside your =
organization.<br>|--------------------------------------------------------=
-----------!<br><br>Thank you for your contribution! Sashiko AI review =
found 1 potential issue(s) to consider:<br>- [High] The documented API =
behavior fails to clear tunnel modifier GSO flags, leading to SKB GSO =
state corruption.<br>--<br><br>commit =
b28df908f04d4d037671bd0f85e9d43e6c3ddef9<br>Author: Nick Hudson =
&lt;nhudson@akamai.com&gt;<br><br>bpf: add BPF_F_ADJ_ROOM_DECAP_* flags =
for tunnel decapsulation<br><br>This commit adds new =
bpf_skb_adjust_room() decapsulation flags to describe<br>which tunnel =
layer is being removed. This allows later changes to =
update<br>tunnel-related GSO state accordingly during =
decapsulation.<br><br><blockquote type=3D"cite">diff --git =
a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h<br>--- =
a/include/uapi/linux/bpf.h<br>+++ =
b/include/uapi/linux/bpf.h<br></blockquote>[ ... ]<br><blockquote =
type=3D"cite">+ *<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:<br>+ *<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and<br>+ *<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP =
tunnel.<br></blockquote><br>If a tunnel packet has remote checksum =
offload, does this documentation<br>imply that tunnel modifier flags =
like SKB_GSO_TUNNEL_REMCSUM and<br>SKB_GSO_PARTIAL are left intact when =
the base UDP flags are cleared?<br><br>[ ... ]<br><blockquote =
type=3D"cite">+ *<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>When using the decapsulation flags above, the =
skb-&gt;encapsulation<br>+ *<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>flag is automatically cleared if =
all tunnel-specific GSO flags<br>+ *<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>(SKB_GSO_UDP_TUNNEL, =
SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,<br>+ *<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, =
SKB_GSO_IPXIP6) have been<br>+ *<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>removed from the packet. This =
handles cases where all tunnel<br>+ *<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>layers have been =
decapsulated.<br></blockquote><br>If the base tunnel flags are cleared =
but tunnel modifier flags like<br>SKB_GSO_TUNNEL_REMCSUM remain, will =
the packet be left in an invalid<br>state where skb-&gt;encapsulation is =
0 but tunnel offload features are<br>still present? This might cause the =
network stack's segmentation code to<br>process a packet with tunnel =
offload features but no actual =
tunnel.<br><br></div></div></blockquote><div><br></div><div>REMCSUM was =
remove as per maintainers =
advice:</div><div><br></div><div>"</div><div>REMCSUM &nbsp;previously =
not included in the series.<br><br>It is a non-obvious and rare enough =
feature that I would exclude it,<br>or move it to a separate =
patch.</div><div>=E2=80=9C</div><div><br></div><div><a =
href=3D"https://lore.kernel.org/bpf/willemdebruijn.kernel.245c592e6d270@gm=
ail.com/">https://lore.kernel.org/bpf/willemdebruijn.kernel.245c592e6d270@=
gmail.com/</a><br></div><div><br></div><br><blockquote =
type=3D"cite"><div><div>Also, SKB_GSO_ESP appears to be missing from the =
list of tunnel-specific<br>GSO flags that prevent clearing =
skb-&gt;encapsulation. Could this result in<br>skb-&gt;encapsulation =
being cleared prematurely if an ESP tunnel is =
still<br>present?<br><br></div></div></blockquote><div><br></div><div>The =
code in v6 5/6 handles SKB_GSO_ESP =
&nbsp;correctly.</div><div><br></div><br><blockquote =
type=3D"cite"><div><div>-- <br>Sashiko AI review =C2=B7 =
https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260504101759.=
3319427-1-nhudson@akamai.com?part=3D3__;Iw!!GjvTz_vk!XtvRB5f4u7U30_eGAxcoo=
z-ntTaRbpqZLQdXKnJxBlHKlpwg28UOtr33DUpjhYdnKIgstpZu2LU_fwJYC6ak$ =
<br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_F196DE3E-781D-4C80-BA94-BBEF43B7D978--

--Apple-Mail=_BDE7C93C-EE7F-44A6-8F60-3CE067AED8B5
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCc8w
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJjCCBMyg
AwIBAgITFwALeewU5YRKbvcMWwABAAt57DAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI2MDMyMDEzNDgw
MloXDTI4MDMxOTEzNDgwMlowUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1FIVDEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAx+gvYqVaQAmc/yNlMv3t5CK6FN7++3ZChJpOElnFyZWj3h+VwSqN
5WD4VQn5DL515KovgCiv63DeQ1NuXNu3XKKeakHyssixhIL2hqjlPFnsrwXJ2R9B9hAGIiOBy2rK
Var+w87AFUZ70jsZlI70IBnJOYsPYnZRmXBytTxVWk9V7Nnh10RuUfkZE2Ry+P18Z7glHYoQeksi
hz/9uqRUEqt23qDYBR1J7bB+SSW5A3LmoTEugWYzayxb9iM0vVleEHqeuN5nihGn8Y7nIrs5sIo8
6AG2Bjl0O2VgWWVfqhl9IMQlx1ZxHAicuMvDN49LD1yMkqx+LeBLboiFQQ0MVQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUD8PIZa7GFc+oX4RLtUq8oUrOL/IwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIBZ79THtRc/r
DXpg8rSeL4tPy9/eLjXnJvYW5Ek2SUJ8AiEA5j0Wa0K9P2Vumn7N4F5MpbHW2t/kxsdwUu2Vzp6S
5BUxggHpMIIB5QIBATBTMDwxITAfBgNVBAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEXMBUG
A1UEAxMOQWthbWFpQ2xpZW50Q0ECExcAC3nsFOWESm73DFsAAQALeewwDQYJYIZIAWUDBAIBBQCg
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkxMDQ1MzZa
MC8GCSqGSIb3DQEJBDEiBCCPpE0pjJxwwLLN3vK5UckPYToD/pWSW72aQ8Dv24oH+TANBgkqhkiG
9w0BAQsFAASCAQCZlsqdyJPtZrA4HnICBy2ZAqv8CPlXwvSXDM419OtFb66ZHp+ohCid9DUGyA3B
bSsQUdlc9L2Q5YWRD0vQeFjDnTY4U9K7w8QyDuGWHV/d2P7ZNG+X2DeIUXtEEJbhbkFVhSx22r4x
7CoM8vKU1VQ/OKkiDMnLz5YDFCPLPFZxT1zRoXGj4RwaNwTm2sGI0up60RMeTFttpeaxzjK6+dqn
jaWUlVDUeJ5Iarkpcs5kGZiYSbeyishuhiku78HTtxZkyeJdl+8jbh+CX+jjPjvTdULVFJlyEpsm
zYqYNjnvWeJesOq4Bcbi/GgOxbsc9E2f6itb0dzFs6062dVnJw7CAAAAAAAA

--Apple-Mail=_BDE7C93C-EE7F-44A6-8F60-3CE067AED8B5--
