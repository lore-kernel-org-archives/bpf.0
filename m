Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF6DC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 18:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A718321929
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 18:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lRdtbXN4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iW4Pv82J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfBOSr2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:47:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54376 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbfBOSr1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Feb 2019 13:47:27 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FIiws6023599;
        Fri, 15 Feb 2019 10:47:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4OG0iobpjvSoRFHXwlQLnYjzJW01Y0QTHa8An4a8ZIs=;
 b=lRdtbXN4OgMiLMLX/3lgt4N/qqexGehooBojXjo65hY5dfY+RITAttmvLO8PQVDV/6Mj
 buWTG7FwmQpW3Q5/HsAoB2s1gwv7D0DHYtvjzdh62bqRyaL7ZtOntbBulbGye61AqLyF
 AXFSDeKHus0bl3KS8iVFE7uoIn0cC08KA2w= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qp1qyr9jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 10:47:24 -0800
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 10:47:23 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 10:47:23 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 10:47:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OG0iobpjvSoRFHXwlQLnYjzJW01Y0QTHa8An4a8ZIs=;
 b=iW4Pv82JcJQxu5LvsTU1iyu63yRtuwGkO8ojJGcJMKLv0NM26BHUencEo0Jwuz0MjplcRtTuwi6xh0e2DfD+elBV8tmPcHUYKF0tE3oyoLGwgYQWtPENjha3vv1nDaq25MKbkcGE5Ac1efAqdryyi/nQqWzEHwx71gJzGLRX+j8=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB3223.namprd15.prod.outlook.com (20.179.56.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 18:47:21 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d%3]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 18:47:21 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Thread-Topic: pahole: soliciting naming suggestion for struct btf rename
Thread-Index: AQHUxChLVv4T+yGODkyBwEnD4D+fuqXfPrSAgAFXgQCAAIhOgIAAFu6A
Date:   Fri, 15 Feb 2019 18:47:21 +0000
Message-ID: <0b1583e1-5e19-0685-7206-ab3e4bb20b70@fb.com>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
 <b156837f-ed18-caf6-7120-5ecfabd4c5ed@fb.com>
 <20190215172515.GC31177@kernel.org>
In-Reply-To: <20190215172515.GC31177@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:d1b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d16bcb9-c74c-4036-e4e3-08d6937604ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3223;
x-ms-traffictypediagnostic: BYAPR15MB3223:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3223;20:fwp3ZnTPI6Sz6s+aPHAExXWYpi400K8fZ8rZ57JescONtlEFTvBA8hqg2vfo9HvMlzuic+meY44NVOMV8virhjL915nrw3Q3Xi1ekrDt0u11/Bnxq13aqJ3Hv/5+LgGDqJrd/65UpUyfUf4lzXr2MlNUecKDQFtGGvUpsHmQ8M0=
x-microsoft-antispam-prvs: <BYAPR15MB32237E48E5B318C273689D5DD7600@BYAPR15MB3223.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(54094003)(68736007)(81166006)(105586002)(229853002)(14454004)(6436002)(478600001)(53936002)(31686004)(8676002)(81156014)(106356001)(476003)(6486002)(2616005)(71190400001)(8936002)(6512007)(93886005)(71200400001)(36756003)(25786009)(486006)(316002)(52116002)(4326008)(6246003)(256004)(446003)(102836004)(7736002)(305945005)(46003)(86362001)(4744005)(11346002)(186003)(53546011)(99286004)(386003)(6506007)(97736004)(76176011)(2906002)(54906003)(31696002)(6116002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3223;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VErG1IxU0XeTOCZarW9gMAGV5rjr74VctDq9yfp84f7RweXF0bRf4eb/XAVfxKfOipbGPAAcVec7ubKnNLlo8acwjjyci3BjhS0ckaAn4DdYA3AzUDuyOHlqYGFVW/P1DFkztiMus5PZPpsy14m/GLV/Wdw0OHKUFFFfTnQyzsOF25KfHHPZTUCgBH6pmzeYVIitqtKYqvdsweQndtrFdFc9LEBh8FwoNJe0rdXD44OG1nwz2MhcurJTgPFltvNmDLGYyNpiw2q/kMKAf9TImF6coHT60+IJlwA5woB9CaqboU6ltSab+Sin022I5OWudpPmRzTQVStRjvhTaGgD4sqGSQsfn0aKWUUPuwebk+9M1gvhR1CKvaonYnFYm/NqCQEhTx4qhL2q8P2ERyq9bGlZWPUR0ZWFGSuP4OWzmNc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FB3973A7BF6404D9BEFBCD4D959DF00@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d16bcb9-c74c-4036-e4e3-08d6937604ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:47:21.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3223
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMi8xNS8xOSA5OjI1IEFNLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gd3JvdGU6DQo+IEVt
IEZyaSwgRmViIDE1LCAyMDE5IGF0IDA1OjE3OjI3UE0gKzAwMDAsIEFsZXhlaSBTdGFyb3ZvaXRv
diBlc2NyZXZldToNCj4+IE9uIDIvMTQvMTkgNDo0NyBBTSwgQXJuYWxkbyBDYXJ2YWxobyBkZSBN
ZWxvIHdyb3RlOg0KPj4+IEkgd29uZGVyIGlmIHdlIHNob3VsZCBoYXZlIGEgbGliYnRmLCB3aXRo
IHRoZSBzYW1lIGxpY2Vuc2luZyBhcyBsaWJicGYsDQo+Pj4gYXMsIGZvciBpbnN0YW5jZSwgcGFo
b2xlIHdvdWxkIGJlIGludGVyZXN0ZWQgb25seSBpbiB0aGUgYnRmIHBhcnRzLCBiZQ0KPj4+IGl0
IGVuY29kaW5nLCBsb2FkaW5nIGFuZCBwcmV0dHkgcHJpbnRpbmcuDQo+Pg0KPj4gSSBkb24ndCB0
aGluayBpdCdzIHBvc3NpYmxlIHRvIGRvIHN1Y2ggc3BsaXQuDQo+PiAuYnRmLmV4dCBzZWN0aW9u
IG9ubHkgbWFrZXMgc2Vuc2UgdG9nZXRoZXIgd2l0aCBicGYgcHJvZy4NCj4gDQo+IFdlbGwsIHRo
YXQgcGFydCwgdGhhdCBpcyBub3QgYWJvdXQgdHlwZXMgYW5kIG9ubHkgbWFrZXMgc2Vuc2UgdG9n
ZXRoZXINCj4gd2l0aCB0aGUgQlBGIHBhcnRzIGNvdWxkIHN0YXkgaW4gbGliYnBmLCBubz8NCg0K
SSBkb24ndCBzZWUgaG93Lg0KLmJ0Zi5leHQgaXMgdXNpbmcgc3RyaW5nIHNlY3Rpb24gb2YgLmJ0
Zg0KSXQncyBhbGwgY29ubmVjdGVkLg0KDQpFdmVuIGlmIGl0IHdhcyBwb3NzaWJsZSB0byBzb21l
aG93IHNwbGl0IHRoZW0NCkkgdGhpbmsgb25lIGJpZyBsaWJyYXJ5IGlzIGJldHRlciB0aGFuIGEg
YnVuY2ggb2Ygc21hbGxlciBvbmVzLg0KSXQncyB3cml0dGVuIGluIEMgc28gLnRleHQgc2l6ZSBj
b25jZXJuIGRvZXNuJ3QgYXBwbHkuDQo=
