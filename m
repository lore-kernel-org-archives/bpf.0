Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908B361953;
	Wed, 12 Aug 2026 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537837; cv=fail; b=IVpipY8FFU89ojzah1IPHQMI7YTy4AMDHGnP+B7oemVR3eulpJ1GSAza7CtYZ1R8iPB2NuGUwWDR4SZOO8JKDOy9DIKI1bAb8yt2PHQKzzsTCe8n1QgZFi452V6AK5WL0phOxKTsIM6sZGgbNklPPEsTZPuAaUZv9Hat67L08y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537837; c=relaxed/simple;
	bh=HTcYvsdohvyCT/11CeTTlcRs/4bJN20uIEbVynT2eBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qoVaDjAG5keMANzSf8CB7iBSJBAD4ajDnC1zyMKqALJnqQqZ7IqHamzkcXy+GDQZDyTFPxhxkvUZcRRE3MC4SWUDfy17L7LB60ThNe9JWpj/FnWu5SfSqk02IQ6EBONIw+1rpGfnq6TAq0Vwf4OUULcCERftCaFTVfMMagE6dJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=ZuCINsZx; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ZuCINsZx"
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
	by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67CB7Wl9628427;
	Wed, 12 Aug 2026 13:30:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=fU2FihzsYYhSD2d1UPgti9
	0ogUYLuDKIJgMJvlPJvB8=; b=ZuCINsZxvPddCKE6giZVRuT+FJdo2XOZ8F0/iR
	nYlPrDMtEKm07EwzPN6LS6a54sfetd6QUq+huQLDuAcKJ9p9i9ey8CzLACZutoGw
	3UjXPPP3SGG/Y1ByoATHl1hfAY1jJCenhEu0OmWxBeAyDuOolXIuE9QxkZffrc/k
	EAxx9b9r8linPUy2MGXKAl13lfWOj7j8Lidng9fXVNH1ff+uN1A6lk3q2vfbilth
	xXmikqI63em6PT3AqD+PugDfOEjU2rG5AeDQ/Ymm1H3kociWAjFe7KMQ1+Q6TNqr
	cDzBS9IUR2h3XMWzJHZYhmwoaVoSVUTdGKC/JCiy9uVQ8fwA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4fxdt1qcms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:30:30 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67CCJYBx011422;
	Wed, 12 Aug 2026 08:30:29 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.41])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 4fwystfwu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:30:27 -0400 (EDT)
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 12 Aug 2026 05:30:27 -0700
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 12 Aug 2026 08:30:27 -0400
Received: from BL2PR08CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 12 Aug 2026 08:30:27 -0400
Received: from SJ0PR17MB4711.namprd17.prod.outlook.com (2603:10b6:a03:378::6)
 by SA0PR17MB4522.namprd17.prod.outlook.com (2603:10b6:806:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 12:30:24 +0000
Received: from SJ0PR17MB4711.namprd17.prod.outlook.com
 ([fe80::bc8:ae55:d179:ebac]) by SJ0PR17MB4711.namprd17.prod.outlook.com
 ([fe80::bc8:ae55:d179:ebac%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:30:24 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 5/6] bpf: clear decap state on skb_adjust_room
 shrink path
Thread-Topic: [PATCH bpf-next v7 5/6] bpf: clear decap state on
 skb_adjust_room shrink path
Thread-Index: AQHdKjURTO/RCmHYfE63Y3/jXpUSxbaaNaIAgAAimQA=
Date: Wed, 12 Aug 2026 12:30:24 +0000
Message-ID: <2251A42A-AF45-485D-9842-9CB32D0578B7@akamai.com>
References: <20260812083115.73100-1-nhudson@akamai.com>
 <20260812083115.73100-6-nhudson@akamai.com>
 <20260812102624.BFC391F000E9@smtp.kernel.org>
In-Reply-To: <20260812102624.BFC391F000E9@smtp.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4711:EE_|SA0PR17MB4522:EE_
x-ms-office365-filtering-correlation-id: c240d2fb-95df-4b0a-82fd-08def86d7be5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|6049299003|23010399003|366016|1800799024|376014|4053099003|38070700021|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: S+9dRLNmsI/YR3R13hSH08IiHi7hpx/mQhpVH0zRgqG+Npk3ORvZAusxQCUb6OJ9nqixnd59YHGiUI8o5KWkW2soGxhlmwuMC9fcOrHeSRXXp4qbJUH2nPH6EHUO0MFk6C7a95BHgEdlZ0RVku9N9CxmCXue+Lsn5aTbSQvWxmKGa1ZGUzt0e4ftFGXvnf0HvX6F7U3mQh1J8c6GAtwl5eSPd0WiN+c/beLPh4ADm/D6NsmctBoQzeipmTowdKCsF3zje9zegncXfGUFe87L089aNgdJlT4sQuPODc6Fq1YhkFotMQNNSbDjkTJG/MWT7Yx40qQC9zORCPf3jmGy+sdvk4p/nmMIsc3Pocv5A00uhtw4O2zICYyQtW9OIA918MiAXGQqva6hRMfZtIzb2rsJoeWLPWOStVbyk8q6hdimJQ0R06mI9GbwRNg+WB9dQ9nCJHyqT0cMb5pkBDmaoSViwuRkvWCRFq48NC23IqwrDjAPIOCR5qJZbCsFcRe6DYwE9ZlC1EUD5Rx+NYRpRCmZwAAkFTAWK2P1kW0crZE8+Lj5L+RP0kPWDJz/2QNe9ZWe9lu7YurKuiynX6oFVn4cbMD3lS2gC9VurSbH5Qf2YJeQTAh7+HPNo+iD9POBLu4Ij4h7pERMxq9k5kSLdtavqjzdzMadk02tM23O0sOZ2EZJeiMt9xgLH7tOuvo1CvgLvtYyJXepNTNf0reUWY0ONkisj8ueAvYoZZF7rGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB4711.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(6049299003)(23010399003)(366016)(1800799024)(376014)(4053099003)(38070700021)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXJyVUtyMkd6bjRwQmoyR096TWpNZktxQXg2cU9xRUxML0ZJbWhweERZczFZ?=
 =?utf-8?B?TFUwZnZweE8vT05IWkpaTGhJblM2dXVkR1hLb0lZdWluQVAxSW84QUZHcExV?=
 =?utf-8?B?K2hxMEk4Q1FITnVYMW1uNHFrbkNURnVpTGhpRHo4UnJUTldIOHlLbXlESU52?=
 =?utf-8?B?aWNKenM3OFdjWGEzVklJdGdkWTFwa2lxOUNnajdpNXpvV2hVbllqMUNwSzMz?=
 =?utf-8?B?NzMya1lRREhNSWdCYnNPMURmZWtPQTZKd1Jka3J1SThhYlFKK0ttM3dqT2lr?=
 =?utf-8?B?ekV5eFFuR1M5OGcvbm5RTEpsUzF5dEJVYjk5WWVGa3FjZ2RxTW83T2VVOXVR?=
 =?utf-8?B?RUFRWGNyWCtITXBETVBnQlVqNU1jSXhkbGVJbWppWGh0TTdjMkUyQXFKblJR?=
 =?utf-8?B?ZkJ2WmtyRnU1V3Bxb2I5YUtPNTZDWWw3MEdlUkM1STgzUUZNbGFGUnJEVnAr?=
 =?utf-8?B?VTJWRVN1MVdMcUEwQzdvSk80RVFCeHJJSzI4QzdxdThvOFdJL2QvQUlDdWlm?=
 =?utf-8?B?am5XaG1zUTRESURMUGdnSE9GWjBkMGt6WS9ZeHJXU1gyZmgrTFZhL3hSR0Nj?=
 =?utf-8?B?R1phZEFhZituNlhWYWZTSWNIc0Y5MXNyUllsTHdyV3RaTlNVem1oQ09GTGhR?=
 =?utf-8?B?b09nRmJ5dWRJVGRDUm8rZEw3OWhWNXhhUTJpRHVPZFRWcm40TUhGclJiTnJl?=
 =?utf-8?B?d3lUWjdVdnQ4ZUh3cCsxQXdHOXFnZmY5djZDL3AyMXRRQkE5QkpCbTdld3JH?=
 =?utf-8?B?VkUrVWljZ1FkMWdia2tVY3oxRysrYWYvK0t5bmdyTitHbWZVYmQ4a2NTc0Zo?=
 =?utf-8?B?MUUzb3N0WnZ4SDIzem4zUzlMVkxmWEJUdjdzYTRPL3pkMS9RT0VxK3ZMSGtE?=
 =?utf-8?B?Y3ZhbzhoSVk1T2R6d1VCUXRocFFsViswaGFsY2V6WnNjK2NML1Y5RE9CYkJW?=
 =?utf-8?B?Z1pJNm1QNXBzY29JU3NHTDNvanRoQklKTFl6UCt3MXQ5Z3RqcldRck1JWm9C?=
 =?utf-8?B?VTBaenN5Snk1NWhrQlUzb3lQaTdtN3ZoK0RSYVJBQlVySGdTNTN6M3UrN1Rx?=
 =?utf-8?B?R0RIZmRDeWFET0JSaGJmQzh1R215UVk1ay9SWWJVNlFNK1dqMnVGcThRQm45?=
 =?utf-8?B?bm9GL3ZTN0hneWFDVVlPLzAzVUdHdW1PdXFET0oxMWVLTVAyYUZOaFJUZy9V?=
 =?utf-8?B?ckMySHh1Q1BCY3hCcmViTnZoak1YSW8zQ2ppQW5KSVNKZWJxRDJQc3h2N3Zu?=
 =?utf-8?B?STdOWWorb09OK1FJaHhFUWlnT1hCUHNiNEJqYXdrQVlGblB4ZDlVVGhvdE8r?=
 =?utf-8?B?akgydHVLVEphSkZKOStOeUNzZHF6NHorNjIrUXFkRU5tV2szYWxmQXB5Zm81?=
 =?utf-8?B?R2tHWVMzeWVNdGx3QWtTaXJabVRvWUtzYnUvUlA2SERSb3daZWVrMk10S1cv?=
 =?utf-8?B?UUNJRWtSalR2eThneWxGdk5iekVtVDB1RWdTZ1VoUnJHWTRvV2lmSU1jazc4?=
 =?utf-8?B?UUxmYW81YlhETVRQaDlNdFlocmNLY01laHVMMy8yMk02cmtydzdRbE15cVh2?=
 =?utf-8?B?aU80UkpydjIvOFF4UW5ZR0Yzc2draitQNjBBQjF0WWdRZXRjT0FUb2lKMVZE?=
 =?utf-8?B?V2ZRajlsTmdaZnRNaFg2YWtWSDZxbysxQ2VzUDNpQ25CZTNEdTcxN0FlS0VN?=
 =?utf-8?B?Rkw4REwvb3FkWlJhVVRLRnhHeTRMU0lBTitEVWxsODNpRmZOSmkzZjJWRGEw?=
 =?utf-8?B?RmZZVHZwREVuOStLRGNVUGpqWUFySDl1UnhDRWpRNTR0WnZKbXNPMHNKWTVO?=
 =?utf-8?B?blhyNk5VQzRWcXUvMmdaNGtKY3ZLYmxDMUQyVnRJbk5DNFF2OS9QeWFNQ0Fr?=
 =?utf-8?B?czYzdmZwaEIwNGRBL0tpRkJLcDFmUzg3d2FnWHdMSjEvRHhrUG1qemFmdjMv?=
 =?utf-8?B?aUV5dWZyUmpRZVRpaTMyTVlCVU5wTFN4VmxlZzlNTkFlQnkyQisyTHRTSDB3?=
 =?utf-8?B?Y0hLcnQ5bkUyR0ZoQlBzTUoyNXFOdjh0YjJLc01LUE5TOFhnTnJSSjhxWEg0?=
 =?utf-8?B?WGpzWEdYS2REbVQwSWwxNDhtRjYzVk03MlA0UGR6L2VJd2ZMbkdOUkZGNms1?=
 =?utf-8?B?UW4weXROemUyMEE5bitwUXkrM2pJUmFpVnhBNXhCTmc3ZkswZ1hPbVM4ZUU0?=
 =?utf-8?B?dDVZeWFKL2tDa1dFU2NFRU93andHRXhqUlU3VmFDeUZac2NTZ21wUnhLd05S?=
 =?utf-8?B?T0lRMmw3RVd2b0Y4WUh6bDUvQjVWVWJmT1FybTdTTVB5bnYwUENpNVpZMUdN?=
 =?utf-8?B?S1Nma2RDdDRJdXNyYjdEWHRocVZMVnlKSStPM0luMzVuWGlvV2VKN2tnYzhs?=
 =?utf-8?Q?UKnv0IeBK7TG83QWOjpRefgtUvGSWKYB5E51m5EE47dhf?=
x-ms-exchange-antispam-messagedata-1: DTlnB6JHwk6F2Q==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEmd1A6hXbYEawqniQfmmNU4V8Ujt4Ya8NhkzZHnL061kZitk6ja7uDRYXXZkVjK182tikEModBgllHrUu0/lch2bx0/5sgfHHuhkdkuOnKaAPrsM2jdVqPI1FhQbvA15qUbkkprhJgz36wlTyIy1X8UEi9IA7pzyiOwf2w2kMDifxS/pMmuUP44LwagBby54qcHwdIVxCppl57lvtI2nJRKTI26+fChx/+6XYEWdku04GpHpYJ3JBpcqYwNuYjEdcE2Q5apGAz4U5wilKQDUHEZTR7KgxU8shgpyU4+svl7exHc3j9whTokyc/gF2fwqzVr3aDE/AFBzUZChkl8SA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIKXAtvEXupm4C5iD9zE//FxPJMdhgMkv+QOKApGttU=;
 b=rPyqW03PIs0bJyky/nvD42Ob02tJujtep+47UJrdCDGSRWeKACTRgsqZCwCof67irKGG6EsZKKoapxirFP0to1iSsr+bVX9ppM+KmzHyoEQCV+cJ+jM3J9Xby4Ihbvpz2tYmY7RhMN2uTDA60vFlKGvH4h1cLqUvBQ4gEL6tQOutOxcXA5FoGohk7TDSlqT8ieYjL/Nrg8eQHycECoGEO0mV5XR9U9jmd4y9XbzG9xD1FBS8bs6y4PIZPwz9t2HD9icFVt7fb3+l3y9m/WL6E3h+vseeqNYWUUXPAHE+g2kN7uThtlfie4TCx+38ZxZwxbL8p8DnGbFYscQWW/f49Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: Pdpm7OciJWqYkrvYj6W5l1C6cMMH73ZSzREniwhjx1gbguNAfgyCM+YFURVPk11WKYD1xgh3+eQrWFNDZcGrifdxG6r3UtNu1FaVM85G7p4A809RuvHdZNgQ4xqOUMg3ztUJQkH4y+W/FcyR7sjnwWeoF2JLPB2tDUsZR4YX5WCKJUp9OzQ6CRkFcvH+KSx6yJAfIhfqvS0br18ZKPMLqmrSdZxoclvF7nOdCOgZSO/N5SRKT3c170PLgedyxPD0iYouOAMtUCHCfvVxUChqIXlAOEjqcLBzkbW6jDa8OyzTj8a2vry6Azxzh1gQUKQ8euPF/dUD6mxzG7AuWiuUtw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SJ0PR17MB4711.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: c240d2fb-95df-4b0a-82fd-08def86d7be5
x-ms-exchange-crosstenant-originalarrivaltime: 12 Aug 2026 12:30:24.6836 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: mUV7omhuaEW0CJONdXVqP6H9F6CQlgf2zJI3NHEURLek+WxT4e1ssBLBjL04VKG4aDL5cseV/wGBG69Bv3+XoA==
x-ms-exchange-transport-crosstenantheadersstamped: SA0PR17MB4522
Content-Type: multipart/signed;
	boundary="Apple-Mail=_A8ECA44D-0F30-4AE0-A44B-BC42DA23DFAF";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608120100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMSBTYWx0ZWRfXzf4kQk4oAg17
 rCwZKQd/y1YErnVdKmXoGjUlQu8NKgAxC/h+ZLbuf87WEml2JOv7ChIWwQnAwPfaZ4pwT+ehj8K
 QRFbzD/mrS+/t0G+CZ9VnaNu1eSijak2L2wS1Fnf0Vq6myQiqm8ijdqo7ZJdlDfNKfjcj17r7vY
 PQrhZNRxGZ1Pm2ENUhKlCnvBaAu4IIBvGsBMsrLNE5EovpLDzQ5Ty87LKiE4lPbn9DnbqsMrPD8
 bP0xetCS1BDHnmQaS7hv4tC1U+7b2GtsHANoBRP1g1hOaDuTjjS7NZxVXnl+FVw2App/SWP69Fa
 ENzkiwii1CXCVcEJzKjIdvU1epv/1PEAqu0Gm3A37zIIPXx+T48PONhv/f55DHK1crF1pn5wccv
 QB0aYWvpbspM4WIxYsPcxXmMKSqf42oii3xPPs/2VfEkH1Iob6TL543/DFl8V10rrzXf6PUAkjh
 b5NXRUcfiTBMyEoHZoQ==
X-Proofpoint-GUID: Rt8EIusjo9O9yqzq29w8xxyM6J6xrRIG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMSBTYWx0ZWRfX+eVljuFQ1XIK
 T1iW8nBKlS6PL6FlE8Xe3vJHvbG1AdhWiRp0aYWNhBkBkakfJCfb1tiz6p29J7W4uYq2rN6S2Oy
 SfG02o2RXJg0slyCiXwb3va4wMdxCjI=
X-Authority-Analysis: v=2.4 cv=Rvn16imK c=1 sm=1 tr=0 ts=6a7c6767 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=XKgOefoLEnF0tNwW78TB:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=X7Ea-ya5AAAA:8 a=qzIREHXYcExUOYsu--IA:9
 a=QEXdDO2ut3YA:10 a=r8IIKywE7cBH58aoeK8A:9 a=ZVk8-NSrHBgA:10
 a=30ssDGKg3p0A:10
X-Proofpoint-ORIG-GUID: Rt8EIusjo9O9yqzq29w8xxyM6J6xrRIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120101

--Apple-Mail=_A8ECA44D-0F30-4AE0-A44B-BC42DA23DFAF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 12, 2026, at 11:26=E2=80=AFAM, sashiko-bot@kernel.org wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> - [High] bpf_skb_net_shrink() leaves SKB_GSO_PARTIAL and =
SKB_GSO_TUNNEL_REMCSUM dangling in shinfo->gso_type after removing a =
tunnel.
> --
>=20
> --- Patch [5]: [PATCH bpf-next v7 5/6] bpf: clear decap state on =
skb_adjust_room shrink path ---
> commit 672aa1a359079a58d5e4d80fc47569e00a437a80
> Author: Nick Hudson <nhudson@akamai.com>
> bpf: clear decap state on skb_adjust_room shrink path
>=20
> This commit updates bpf_skb_adjust_room() on the shrink path to =
conditionally
> clear decapsulation state updates based on BPF_F_ADJ_ROOM_DECAP_* =
flags. For
> GSO skbs, it selectively clears tunnel gso_type bits and =
encapsulation, while
> for non-GSO skbs it directly clears the encapsulation flag.
>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 981b75941e7f7..89effff3bc525 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3754,9 +3754,48 @@ static int bpf_skb_net_shrink(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>> skb_increase_gso_size(shinfo, len_diff);
>>=20
>> + /* Selective GSO flag clearing based on decap type.
>> + * Only clear the flags for the tunnel layer being removed.
>> + */
>> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
>> +    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
>> + SKB_GSO_UDP_TUNNEL_CSUM)))
>> + shinfo->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL |
>> +      SKB_GSO_UDP_TUNNEL_CSUM);
>=20
> [Severity: High]
> Does this leave SKB_GSO_PARTIAL and SKB_GSO_TUNNEL_REMCSUM dangling in
> shinfo->gso_type after removing a tunnel?
>=20
> If an SKB acquires SKB_GSO_PARTIAL or SKB_GSO_TUNNEL_REMCSUM (for =
example,
> via software partial segmentation across a veth pair or GRO) and a BPF =
program
> uses bpf_skb_adjust_room() to shrink the SKB, it seems the base tunnel =
flags
> are cleared but the modifier flags remain.
>=20
> Hardware drivers like ixgbe or fbnic use SKB_GSO_PARTIAL to identify =
packets
> requiring partial GSO offload or special tunnel logic. Could leaving =
this flag
> on a decapsulated, non-tunnel SKB cause drivers to misinterpret the =
packet
> structure and corrupt the packet on transmit?

Willem de Bruijn said to not add it to this series.

REMCSUM was previously not included in the series.

It is a non-obvious and rare enough feature that I would exclude it,
or move it to a separate patch.

=
https://lore.kernel.org/all/willemdebruijn.kernel.245c592e6d270@gmail.com/=



>=20
> [ ... ]
>=20
>> + /* Clear encapsulation flag only when no tunnel GSO flags remain */
>> + if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
>> +     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
>> + if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
>> +  SKB_GSO_UDP_TUNNEL_CSUM |
>> +  SKB_GSO_GRE |
>> +  SKB_GSO_GRE_CSUM |
>> +  SKB_GSO_IPXIP4 |
>> +  SKB_GSO_IPXIP6 |
>> +  SKB_GSO_ESP)))
>> + if (skb->encapsulation)
>> + skb->encapsulation =3D 0;
>> + }
>=20
> [Severity: High]
> If all base tunnel flags are cleared and encapsulation is set to 0, =
which
> confirms the packet is no longer a tunnel, is it expected that =
SKB_GSO_PARTIAL
> and SKB_GSO_TUNNEL_REMCSUM might still be set in gso_type?
>=20


Any change to force-clear REMCSUM/PARTIAL would be done as a separate =
follow-up with dedicated justification/tests, rather than folded into =
this decap-flag series.=E2=80=9D


--Apple-Mail=_A8ECA44D-0F30-4AE0-A44B-BC42DA23DFAF
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
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MTIxMjMwMTRa
MC8GCSqGSIb3DQEJBDEiBCBqzoF/lSj2Pc7bS/HPWtjWrQM1D6R/wV7CJ8nr13mYZTANBgkqhkiG
9w0BAQsFAASCAQBpYtoqPQGDyHbfPQJRd4Za9+x6otgAxM8lPL6i69yZIR6hdOAiEeYw104m3Lt9
iZ7fIBa6WsoPu3UijpUN6aSu9WppcQ6SX4qFcgM8vqHFAcOphODl8GrKrtq1bDEdTo0D/ZU2/foa
EqgT6hgn3KAseiIrj7rgumBG8PQoKX8DLRYskuPJAKVdEipg3kRpazElht+pb/vue59hveF/aD9/
GcWXz0XIJW2YZHuzf9wCb0VJP9sW+IfmMU99jOrHhEa2syFssjF13QaAQB07twpLWpna/QQ3wqc6
Yr/xoUvmInaPXGCA2GvpROTlsSxipTYrLihR2W/zzot3Fzugyea7AAAAAAAA

--Apple-Mail=_A8ECA44D-0F30-4AE0-A44B-BC42DA23DFAF--
