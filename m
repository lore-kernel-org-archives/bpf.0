Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF40AC10F05
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 00:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822D4218C3
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 00:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ApyMTtaL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f6ZW7nDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCUAYU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:24:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbfCUAYU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Mar 2019 20:24:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2L0MOHY010624;
        Wed, 20 Mar 2019 17:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FxRukFG76FvahOgUlvRJi/43Hkm/enVnv1JLf0QMhRA=;
 b=ApyMTtaLI/rnR5rAoHsb9wpXWNi7LrMS57EOzgetwdisUTfpta2tDbaTsJuEEtosUsDO
 fTK9RE65+JP8VDmQJNPpCuCbu6oMG525U7sWdtDF0C0e4YjBmrvJQh87ijSUUpVREH95
 d4IwyDCIvnqq1SZUw0VnqhbjadGtkLE5c1s= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rby3j85vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 17:23:53 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Mar 2019 17:23:52 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Mar 2019 17:23:52 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Mar 2019 17:23:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxRukFG76FvahOgUlvRJi/43Hkm/enVnv1JLf0QMhRA=;
 b=f6ZW7nDoNykFZAG3cl8dhkzH9i6zN8wZ/KGVzYiDiQQ3FwOwxGX+m0P2NYhhVuhotyZUBA/pjim1cxtrGn4UK51PIXtkHsmUKNuBhVYBneZK5S4rDYecqxEMUXBikdMH0tyDCofIoj+Jqb9RVWZt2CQV4A4EcUPz0CTyhpQ8+e4=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3416.namprd15.prod.outlook.com (20.179.59.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 00:23:50 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 00:23:50 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Thread-Topic: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Thread-Index: AQHU3xwCZC2TOonV6EyntesbokSF86YUwkQAgABV0oCAAAIKgIAABOwAgAAGVICAAA9XgIAABcIA
Date:   Thu, 21 Mar 2019 00:23:50 +0000
Message-ID: <d0fe9cff-9c28-e0ac-ae09-68e3c5426ad2@fb.com>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
 <4c6db4e5-8e77-2e01-a4ab-25808df2b857@fb.com>
 <20190320222759.GQ7431@mini-arch.hsd1.ca.comcast.net>
 <55387960-b50a-2f5f-1083-da2377558c2b@fb.com>
 <8ab21b4e-885d-e91e-1614-f1b15660ce4c@iogearbox.net>
 <20190321000309.GR7431@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190321000309.GR7431@mini-arch.hsd1.ca.comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0071.namprd02.prod.outlook.com
 (2603:10b6:301:73::48) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1f74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4db5370d-15be-4e87-6781-08d6ad937da7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3416;
x-ms-traffictypediagnostic: BYAPR15MB3416:
x-microsoft-antispam-prvs: <BYAPR15MB3416CD01A721AAC58C99FDCBD3420@BYAPR15MB3416.namprd15.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(43544003)(110136005)(14444005)(71200400001)(71190400001)(102836004)(97736004)(6116002)(6512007)(14454004)(106356001)(305945005)(256004)(7736002)(186003)(68736007)(5660300002)(2906002)(11346002)(446003)(25786009)(53936002)(478600001)(93886005)(316002)(81166006)(81156014)(31696002)(229853002)(486006)(6436002)(76176011)(54906003)(2616005)(31686004)(476003)(6506007)(6486002)(53546011)(36756003)(99286004)(105586002)(4326008)(52116002)(8676002)(386003)(6246003)(46003)(8936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3416;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wTzRgO9eRAj/fCbmuu0GCCJZ98dyUTHwbOdsupCrVXKo+RWl1H6PwfOgupx1olghCfguz0GRlfmyaHjImzfAMzbOw5fprLtXzMVGcpXrxeWDpjDxw6p8j+Psyvhbi4IYmo6QH+8G5N7uc4W8zsvhv1pT/jHNVxiFNykkTwYLRKKSLtyU2xyC7ML4Pj/8sDpqjFi6eqXC+YLN1ML0G3Tb7WwEsqa81WmDLWs8F9xe485WmTpPkE6kC5h7ILCBGb+T6HpnR0ZmHz1jrD9gA9ZSlQybsr3spUwJDXUGXtHeVfS/4FQ+s6UKuw5HQ7QIShCPtUW5eQC7xUXETDECyrBl0GX5vWUnPxRig2foGaPIvlmcPRfTWirbnU3aekX5w5+we0iogDKrdmiJ/R8m1Er5USj8Z389GB814prRg8DnV2I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D28114D8EF7DB45A655D8E953087AAE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db5370d-15be-4e87-6781-08d6ad937da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 00:23:50.2296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3416
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDMvMjAvMTkgNTowMyBQTSwgU3RhbmlzbGF2IEZvbWljaGV2IHdyb3RlOg0KPiBPbiAw
My8yMSwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPj4gT24gMDMvMjAvMjAxOSAxMTo0NSBQTSwg
WW9uZ2hvbmcgU29uZyB3cm90ZToNCj4+PiBPbiAzLzIwLzE5IDM6MjcgUE0sIFN0YW5pc2xhdiBG
b21pY2hldiB3cm90ZToNCj4+Pj4gT24gMDMvMjAsIFlvbmdob25nIFNvbmcgd3JvdGU6DQo+Pj4+
PiBPbiAzLzIwLzE5IDEwOjEzIEFNLCBTdGFuaXNsYXYgRm9taWNoZXYgd3JvdGU6DQo+Pj4+Pj4g
T24gMDMvMjAsIFNlcmdleSBTZW5vemhhdHNreSB3cm90ZToNCj4+Pj4+Pj4gTm90IGFsbCBjb21w
aWxlcnMgaGF2ZSBfX2J1aWx0aW5fYnN3YXAxNigpIGFuZCBfX2J1aWx0aW5fYnN3YXAzMigpLA0K
Pj4+Pj4+PiB0aHVzIG5vdCBhbGwgY29tcGlsZXJzIGFyZSBhYmxlIHRvIGNvbXBpbGUgdGhlIGZv
bGxvd2luZyBjb2RlOg0KPj4+Pj4+Pg0KPj4+Pj4+PiAgICAgICAgICAgIChfX2J1aWx0aW5fY29u
c3RhbnRfcCh4KSA/IFwNCj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIF9fX2NvbnN0YW50X3N3
YWIxNih4KSA6IF9fYnVpbHRpbl9ic3dhcDE2KHgpKQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGF0J3Mg
dGhlIHJlYXNvbiB3aHkgYnBmX250b2hsKCkgZG9lc24ndCB3b3JrIG9uIEdDQyA8IDQuOCwgZm9y
DQo+Pj4+Pj4+IGluc3RhbmNlOg0KPj4+Pj4+Pg0KPj4+Pj4+PiAgICAgICAgICAgIGVycm9yOiBp
bXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnX19idWlsdGluX2Jzd2FwMTYnDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IFdlIGNhbiB1c2UgX19idWlsdGluX2Jzd2FwMTYoKSBvbmx5IGlmIGNvbXBp
bGVyIGhhcyB0aGlzIGJ1aWx0LWluLA0KPj4+Pj4+PiB0aGF0IGlzLCBvbmx5IGlmIF9fSEFWRV9C
VUlMVElOX0JTV0FQMTZfXyBpcyBkZWZpbmVkLiBTdGFuZGFyZCBVQVBJDQo+Pj4+Pj4+IF9fc3dh
YjE2KCkvX19zd2FiMzIoKSB0YWtlIGNhcmUgb2YgdGhhdCwgYW5kLCBhZGRpdGlvbmFsbHksIGhh
bmRsZQ0KPj4+Pj4+PiBfX2J1aWx0aW5fY29uc3RhbnRfcCgpIGNhc2VzIGFzIHdlbGw6DQo+Pj4+
Pj4+DQo+Pj4+Pj4+ICAgICAjaWZkZWYgX19IQVZFX0JVSUxUSU5fQlNXQVAxNl9fDQo+Pj4+Pj4+
ICAgICAjZGVmaW5lIF9fc3dhYjE2KHgpIChfX3UxNilfX2J1aWx0aW5fYnN3YXAxNigoX191MTYp
KHgpKQ0KPj4+Pj4+PiAgICAgI2Vsc2UNCj4+Pj4+Pj4gICAgICNkZWZpbmUgX19zd2FiMTYoeCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+Pj4+Pj4gICAgICAgICAgICAgKF9fYnVp
bHRpbl9jb25zdGFudF9wKChfX3UxNikoeCkpID8gICAgIFwNCj4+Pj4+Pj4gICAgICAgICAgICAg
X19fY29uc3RhbnRfc3dhYjE2KHgpIDogICAgICAgICAgICAgICAgIFwNCj4+Pj4+Pj4gICAgICAg
ICAgICAgX19mc3dhYjE2KHgpKQ0KPj4+Pj4+PiAgICAgI2VuZGlmDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IFNvIHdlIGNhbiB0d2VhayBzZWxmdGVzdHMvYnBmL2JwZl9lbmRpYW4uaCBhbmQgdXNlIFVBUEkN
Cj4+Pj4+Pj4gX19zd2FiMTYoKS9fX3N3YWIzMigpLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBTZXJnZXkgU2Vub3poYXRza3kgPHNlcmdleS5zZW5vemhhdHNreUBnbWFpbC5jb20+
DQo+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pg0KPj4+Pj4+PiB2MjogZml4ZWQgYnVpbGQgZXJyb3IsIHJl
c2h1ZmZsZWQgcGF0Y2hlcyAoU3RhbmlzbGF2IEZvbWljaGV2KQ0KPj4+Pj4+IFRlc3RlZCB0aGVt
IGxvY2FsbHkgd2l0aCB0aGUgY29tcGlsZXIgSSBzYXcgdGhlIGluaXRpYWwgaXNzdWVzIHdpdGgg
LSBhbGwNCj4+Pj4+PiBmaW5lLCBJIGRvbid0IHNlZSBhbnkgZXJyb3JzIHdpdGggdGhlIG9sZGVy
IGdjYy4NCj4+Pj4+Pg0KPj4+Pj4+IE9uZSBsYXN0IHF1ZXN0aW9uIEkgaGF2ZSBpczogd2hhdCBo
YXBwZW5zIGluIHRoZSBsbHZtK2JwZiBjYXNlPyBIYXZlDQo+Pj4+Pj4geW91IHRlc3RlZCB0aGF0
PyBJIHRoaW5rIExMVk0gaGFzIGFsbCB0aGUgYnVpbHRpbnMgcmVxdWlyZWQsIGJ1dCBzaW5jZQ0K
Pj4+Pj4+IHdlIGFyZSByZWx5aW5nIG9uIHRoZSBzd2FiLmggbm93IChhbmQgaXQgcmVsaWVzIG9u
DQo+Pj4+Pj4gX19IQVZFX0JVSUxUSU5fQlNXQVAxNl9fKSwgSSB3b25kZXIgd2hldGhlciB0aGlz
IGRldGVjdGlvbiB3b3Jrcw0KPj4+Pj4+IGNvcnJlY3RseSBvbiB0aGUgbGx2bSB3aGVuIHRhcmdl
dGluZyBicGYuIChzaWRlbm90ZTogYnBmX2VuZGlhbi5oIGNhbiBiZQ0KPj4+Pj4+IHVzZWQgZnJv
bSBib3RoIHVzZXJzcGFjZSBhbmQgYnBmIHByb2dyYW1zKS4NCj4+Pj4+DQo+Pj4+PiBJbnNpZGUg
a2VybmVsIGNsYW5nIGNvbXBpbGVyIGhlYWRlciAobGludXgvY29tcGlsZXItY2xhbmcuaCkgZG9l
cyBub3QNCj4+Pj4+IGRlZmluZSBfX0hBVkVfQlVJTFRJTl9CU1dBUDE2X18uIFNvIGl0IHdpbGwg
Z28gdG8gdGhlICJlbHNlIiBicmFuY2ggaW4NCj4+Pj4+IHRoZSBhYm92ZS4gU28gSSB0aGluayBp
dCBzaG91bGQgd29yayB3aXRoIGNsYW5nICsgYnBmLg0KPj4+PiBIbSwgaXNuJ3QgaXQgdGhlIG9w
cG9zaXRlIG9mIHdoYXQgd2Ugd2FudCB0aGVuPyBJIHRoaW5rIGZvciBsbHZtK2JwZiB3ZSBhbHdh
eXMNCj4+Pj4gd2FudCB0byB1c2UgdGhlIGJ1aWx0aW5zIHRvIG1ha2UgaXQgcHJvcGVybHkgZ2Vu
ZXJhdGUNCj4+Pj4gQlBGX1RPX0JFL0JQRl9UT19MRSBpbnN0cnVjdGlvbnMuDQo+Pj4NCj4+PiBP
a2F5LCBJIHNlZS4gVGhlbiB0aGlzIHBhdGNoIHdpbGwgbm90IGFjaGlldmUgdGhhdC4NCj4+PiBU
aGUgZm9sbG93aW5nIGFyZSB0d28gY29tbW9uIHdheXMgdG8gY29tcGlsZSBhIGJwZiBwcm9ncmFt
Og0KPj4+ICAgICAtICJjbGFuZyAtdGFyZ2V0IGJwZiAuLi4iLCBtYXliZSBhZGQgbWFjcm8gX19C
UEZfXyBzb21ld2hlcmUNCj4+PiAgICAgICB0byBpbmRpY2F0ZSBidWlsdGluX2Jzd2FwMTYgYWx3
YXlzIGF2YWlsYWJsZT8NCj4+PiAgICAgLSAiY2xhbmcgPGhvc3QgdGFyZ2V0PiAuLi4iIGFuZCB0
aGVuICJsbGMgLW1hcmNoPWJwZiAuLi4iDQo+Pj4gICAgICAgaW4gdGhpcyBjYXNlLCBfX0JQRl9f
IG1hY3JvIGlzIG5vdCBhdmFpbGFibGUgYW5kDQo+Pj4gICAgICAgd2Ugd2lsbCBub3QgYmUgYWJs
ZSB0byB1c2UgYnVpbHRpbiBzd2FwIGZvciBicGYgcHJvZ3JhbS4NCj4+Pg0KPj4+IE1heWJlIHVz
ZSBfX2NsYW5nX18gbWFjcm8gKG9yIGdjYyBtYWNybykgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiBj
bGFuZw0KPj4+IGFuZCBnY2MuIElmIGl0IGlzIGdjYyB3ZSB3aWxsIGNoZWNrIGJ1aWx0aW4gYXZh
aWxhYmlsaXR5LCBvdGhlcndpc2UsDQo+Pj4gd2UgYXNzdW1lIGJ1aWx0aW4gYWx3YXlzIGF2YWls
YWJsZT8gVGhpcyBub3QgcHJldHR5IHRob3VnaC4NCj4+DQo+PiBJIHRoaW5rIHRoZSB3YXkgdGhp
cyBzaG91bGQgYmUgZml4ZWQgaXMgdGhlIGZvbGxvd2luZzogSW4gY2FzZQ0KPj4gb2YgTExWTSAo
YWthIGNvbXBpbGluZyBCUEYgcHJvZyksIHdlIHdhbnQgdGhlIGNvZGUgdG8gYmUgYXMtaXMsDQo+
PiBpbiBjYXNlIGlmIGdjYyBpcyBjb21waWxpbmcgdGhlIGhvc3Rwcm9nLCB3ZSBlaXRoZXIgd2Fu
dCB0byBrZWVwDQo+PiB1c2luZyBfX2J1aWx0aW5fYnN3YXAxNigpIG9yIGZhbGwtYmFjayB0byBz
b21ldGhpbmcgZWxzZS4gVGh1cywNCj4+IEkgd291bGQgc3VnZ2VzdCwgd2UgYWRkIGEgbmV3IGZl
YXR1cmUgdGVzdCBmb3IgdG9vbGluZyBpbmZyYSB1bmRlcg0KPj4gdG9vbHMvYnVpbGQvZmVhdHVy
ZS8gdGhhdCBjb21waWxlcyBhIGR1bW15IHByb2cgd2l0aCBfX2J1aWx0aW5fYnN3YXAxNigpLg0K
Pj4gQW5kIGluIHRoZSBicGZfZW5kaWFuLmggd2UgZGVmaW5lIF9fYnBmX250b2hzKHgpIHRvIF9f
YnBmX3N3YWIxNih4KQ0KPj4gd2hpY2ggZWl0aGVyIHJlc29sdmVzIHRvIF9fYnVpbHRpbl9ic3dh
cDE2KCkgb3Igc29tZSBmYWxsYmFjaw0KPj4gaW1wbGVtZW50YXRpb24gaWYgbm90IGF2YWlsYWJs
ZS4gSSBkb24ndCB0aGluayB0aGVyZSBzaG91bGQgYmUgbXVjaA0KPj4gb2YgYW4gaXNzdWUgYW5k
IGl0IHdvdWxkIGZvbGxvdyB0aGUgc3RhbmRhcmQgd2F5IHRvIGRvIGl0Lg0KPiBJdCdzIG5vdCBh
cyBlYXN5IGFzIGxsdm0gdnMgZ2NjLiBXZSBjYW4gY29tcGlsZSB1c2VybGFuZCB0ZXN0cyB3aXRo
DQo+IGxsdm0vY2xhbmcgYXMgd2VsbC4gV2UgcmVhbGx5IG5lZWQgdG8gZGlzdGluZ3Vpc2ggYmV0
d2VlbiB0aGUgdGFyZ2V0OiBiZnAgdnMNCj4gbm9uLWJwZjogYWx3YXlzIHVzZSBidWlsdGlucyBp
biBicGYgY2FzZSBhbmQgZmFsbGJhY2sgdG8gc3dhYi5oIGZvcg0KPiB1c2VybGFuZCAob3IgdXNl
IGZlYXR1cmUgZGV0ZWN0aW9uLCBidXQgc3dhYi5oIHNob3VsZCBiZSBlbm91Z2ggaW4NCj4gdGhl
b3J5KS4NCj4gDQo+IENhbiB3ZSByZWx5IG9uIF9fYnBmX18gZGVmaW5lPw0KPiANCj4gJCBjYXQg
dG1wLmMNCj4gI2lmZGVmIF9fYnBmX18NCj4gI2Vycm9yIGENCj4gI2Vsc2UNCj4gI2Vycm9yIGIN
Cj4gI2VuZGlmDQo+ICQgY2xhbmcgLWMgLXRhcmdldCBicGYgdG1wLmMNCj4gdG1wLmM6MjoyOiBl
cnJvcjogYQ0KPiAjZXJyb3IgYQ0KPiAgIF4NCj4gICAxIGVycm9yIGdlbmVyYXRlZC4NCg0KWWVz
LCB5b3UgY2FuIHJlbHkgdGhpcywgX19icGZfXywgX19icGYgb3IgX19CUEZfXy4gVGhlc2UgdGhy
ZWUNCmFyZSBjbGFuZyBwcmVkZWZpbmVkIG1hY3JvcyBmb3IgdGFyZ2V0IGJwZi4NCg0KPiANCj4+
DQo+Pj4+Pj4+ICAgICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvYnBmX2VuZGlhbi5oIHwg
OCArKysrLS0tLQ0KPj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4NCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi9icGZfZW5kaWFuLmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvYnBmX2VuZGlhbi5oDQo+Pj4+Pj4+IGluZGV4IGIyNTU5NWVhNGE3OC4uMWVkMjY4YjIwMDJi
IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvYnBmX2Vu
ZGlhbi5oDQo+Pj4+Pj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZfZW5k
aWFuLmgNCj4+Pj4+Pj4gQEAgLTIwLDEyICsyMCwxMiBAQA0KPj4+Pj4+PiAgICAgICogdXNlIGRp
ZmZlcmVudCB0YXJnZXRzLg0KPj4+Pj4+PiAgICAgICovDQo+Pj4+Pj4+ICAgICAjaWYgX19CWVRF
X09SREVSX18gPT0gX19PUkRFUl9MSVRUTEVfRU5ESUFOX18NCj4+Pj4+Pj4gLSMgZGVmaW5lIF9f
YnBmX250b2hzKHgpCQkJX19idWlsdGluX2Jzd2FwMTYoeCkNCj4+Pj4+Pj4gLSMgZGVmaW5lIF9f
YnBmX2h0b25zKHgpCQkJX19idWlsdGluX2Jzd2FwMTYoeCkNCj4+Pj4+Pj4gKyMgZGVmaW5lIF9f
YnBmX250b2hzKHgpCQkJX19zd2FiMTYoeCkNCj4+Pj4+Pj4gKyMgZGVmaW5lIF9fYnBmX2h0b25z
KHgpCQkJX19zd2FiMTYoeCkNCj4+Pj4+Pj4gICAgICMgZGVmaW5lIF9fYnBmX2NvbnN0YW50X250
b2hzKHgpCV9fX2NvbnN0YW50X3N3YWIxNih4KQ0KPj4+Pj4+PiAgICAgIyBkZWZpbmUgX19icGZf
Y29uc3RhbnRfaHRvbnMoeCkJX19fY29uc3RhbnRfc3dhYjE2KHgpDQo+Pj4+Pj4+IC0jIGRlZmlu
ZSBfX2JwZl9udG9obCh4KQkJCV9fYnVpbHRpbl9ic3dhcDMyKHgpDQo+Pj4+Pj4+IC0jIGRlZmlu
ZSBfX2JwZl9odG9ubCh4KQkJCV9fYnVpbHRpbl9ic3dhcDMyKHgpDQo+Pj4+Pj4+ICsjIGRlZmlu
ZSBfX2JwZl9udG9obCh4KQkJCV9fc3dhYjMyKHgpDQo+Pj4+Pj4+ICsjIGRlZmluZSBfX2JwZl9o
dG9ubCh4KQkJCV9fc3dhYjMyKHgpDQo+Pj4+Pj4+ICAgICAjIGRlZmluZSBfX2JwZl9jb25zdGFu
dF9udG9obCh4KQlfX19jb25zdGFudF9zd2FiMzIoeCkNCj4+Pj4+Pj4gICAgICMgZGVmaW5lIF9f
YnBmX2NvbnN0YW50X2h0b25sKHgpCV9fX2NvbnN0YW50X3N3YWIzMih4KQ0KPj4+Pj4+PiAgICAg
I2VsaWYgX19CWVRFX09SREVSX18gPT0gX19PUkRFUl9CSUdfRU5ESUFOX18NCj4+Pj4+Pj4gLS0g
DQo+Pj4+Pj4+IDIuMjEuMA0KPj4+Pj4+Pg0KPj4NCg==
