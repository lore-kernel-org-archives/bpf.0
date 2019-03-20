Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED0C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 22:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BCD218AE
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 22:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TWluEQ0K";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fwsl9z55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCTWqJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:46:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727538AbfCTWqJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Mar 2019 18:46:09 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KMcvTP004369;
        Wed, 20 Mar 2019 15:45:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cuZqkNTFiVETmbzW9YNf78vrQR+Nh6umYsjttREjhqI=;
 b=TWluEQ0K00tm24dIEPs4t+RepMDrA5nEehB0AOR+BDT228GIyg3Hp46CW03Yv4wvaE0U
 MprlwVCJhpO1tv9ovvzzuMMRVotlsg5uUh0+9zx1IrGrHU77IBzGDsAWQEK+LkGVrV9E
 14t+sa4zvS7+vY5BzMuJX7/wDBKEwBGMC3U= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rbvr8reqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 15:45:43 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Mar 2019 15:45:42 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Mar 2019 15:45:42 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Mar 2019 15:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuZqkNTFiVETmbzW9YNf78vrQR+Nh6umYsjttREjhqI=;
 b=fwsl9z55aroJW5R3ETeK8wCB9EqE+ynCRDabMRxgbbeSSDgJpODk1iWl+Chr/SBE+FUg4hadZr0pq53A/SHBQm8G6DloyCrx8VUlBCHKEPVwR8xhFj93ePu8kIYgSdTkF9v9v2+enJ5uVgm/StqGxMaZBZ51224VDj5ueBfIXc4=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2966.namprd15.prod.outlook.com (20.178.237.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Wed, 20 Mar 2019 22:45:39 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1730.013; Wed, 20 Mar 2019
 22:45:39 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
CC:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Thread-Topic: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Thread-Index: AQHU3xwCZC2TOonV6EyntesbokSF86YUwkQAgABV0oCAAAIKgIAABOwA
Date:   Wed, 20 Mar 2019 22:45:39 +0000
Message-ID: <55387960-b50a-2f5f-1083-da2377558c2b@fb.com>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
 <4c6db4e5-8e77-2e01-a4ab-25808df2b857@fb.com>
 <20190320222759.GQ7431@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190320222759.GQ7431@mini-arch.hsd1.ca.comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0076.namprd17.prod.outlook.com
 (2603:10b6:300:c2::14) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1f74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce6c1834-bc6d-4ed0-6ef1-08d6ad85c687
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2966;
x-ms-traffictypediagnostic: BYAPR15MB2966:
x-microsoft-antispam-prvs: <BYAPR15MB2966829B97C00A423C36A2F0D3410@BYAPR15MB2966.namprd15.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(43544003)(53546011)(76176011)(102836004)(6436002)(386003)(6506007)(53936002)(6512007)(52116002)(6246003)(4326008)(2906002)(93886005)(105586002)(486006)(106356001)(446003)(6116002)(8676002)(11346002)(316002)(54906003)(2616005)(476003)(71190400001)(71200400001)(31686004)(25786009)(81166006)(5660300002)(86362001)(81156014)(14454004)(99286004)(31696002)(8936002)(478600001)(68736007)(7736002)(36756003)(186003)(97736004)(46003)(6916009)(256004)(14444005)(6486002)(229853002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2966;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0iPgdFpBtowoJzHqedAbTJCXmMjQgdmoIUDYyS1GhUUoeaCkStEs/Oz4Q1mbqp45T6IHYHbaJFJpLiq0V2J+hiHVMYT8igBATiS7MasGxpYyq5zVdXPns/jHaGSROFlnMIN2dSr6Sq9x8LVZxPEzI5tY5MiUf6jp1UfA6yxE6eWdVCda5ZuXpH7xGAThHnJiH6t3n98Zu4qbO/m1mYZRebuvu2FZawcaRfU+lULyqYkwpJXrpNhRyzZmaIzWrnMqL4jM5BrBO4k64Er0/+/pCPwsQiRzbRccLFdfXHOzL7xpGapgL73DmUnOB6T/phKCPLR+hqty+SlnA9UnO3ac9P47bDDSZ8NImeyg/H79gbyL7MP8htS3ucWoqaBOQXOBkNg+h+p36l+5srJlUKbUronCSIwrvZEPReRgeInHjXw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <836C3CC3A186524DB06B6C958F8F63D2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6c1834-bc6d-4ed0-6ef1-08d6ad85c687
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 22:45:39.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2966
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDMvMjAvMTkgMzoyNyBQTSwgU3RhbmlzbGF2IEZvbWljaGV2IHdyb3RlOg0KPiBPbiAw
My8yMCwgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMy8yMC8xOSAxMDoxMyBB
TSwgU3RhbmlzbGF2IEZvbWljaGV2IHdyb3RlOg0KPj4+IE9uIDAzLzIwLCBTZXJnZXkgU2Vub3po
YXRza3kgd3JvdGU6DQo+Pj4+IE5vdCBhbGwgY29tcGlsZXJzIGhhdmUgX19idWlsdGluX2Jzd2Fw
MTYoKSBhbmQgX19idWlsdGluX2Jzd2FwMzIoKSwNCj4+Pj4gdGh1cyBub3QgYWxsIGNvbXBpbGVy
cyBhcmUgYWJsZSB0byBjb21waWxlIHRoZSBmb2xsb3dpbmcgY29kZToNCj4+Pj4NCj4+Pj4gICAg
ICAgICAgIChfX2J1aWx0aW5fY29uc3RhbnRfcCh4KSA/IFwNCj4+Pj4gICAgICAgICAgICAgICAg
ICAgX19fY29uc3RhbnRfc3dhYjE2KHgpIDogX19idWlsdGluX2Jzd2FwMTYoeCkpDQo+Pj4+DQo+
Pj4+IFRoYXQncyB0aGUgcmVhc29uIHdoeSBicGZfbnRvaGwoKSBkb2Vzbid0IHdvcmsgb24gR0ND
IDwgNC44LCBmb3INCj4+Pj4gaW5zdGFuY2U6DQo+Pj4+DQo+Pj4+ICAgICAgICAgICBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ19fYnVpbHRpbl9ic3dhcDE2Jw0KPj4+
Pg0KPj4+PiBXZSBjYW4gdXNlIF9fYnVpbHRpbl9ic3dhcDE2KCkgb25seSBpZiBjb21waWxlciBo
YXMgdGhpcyBidWlsdC1pbiwNCj4+Pj4gdGhhdCBpcywgb25seSBpZiBfX0hBVkVfQlVJTFRJTl9C
U1dBUDE2X18gaXMgZGVmaW5lZC4gU3RhbmRhcmQgVUFQSQ0KPj4+PiBfX3N3YWIxNigpL19fc3dh
YjMyKCkgdGFrZSBjYXJlIG9mIHRoYXQsIGFuZCwgYWRkaXRpb25hbGx5LCBoYW5kbGUNCj4+Pj4g
X19idWlsdGluX2NvbnN0YW50X3AoKSBjYXNlcyBhcyB3ZWxsOg0KPj4+Pg0KPj4+PiAgICAjaWZk
ZWYgX19IQVZFX0JVSUxUSU5fQlNXQVAxNl9fDQo+Pj4+ICAgICNkZWZpbmUgX19zd2FiMTYoeCkg
KF9fdTE2KV9fYnVpbHRpbl9ic3dhcDE2KChfX3UxNikoeCkpDQo+Pj4+ICAgICNlbHNlDQo+Pj4+
ICAgICNkZWZpbmUgX19zd2FiMTYoeCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+
Pj4gICAgICAgICAgICAoX19idWlsdGluX2NvbnN0YW50X3AoKF9fdTE2KSh4KSkgPyAgICAgXA0K
Pj4+PiAgICAgICAgICAgIF9fX2NvbnN0YW50X3N3YWIxNih4KSA6ICAgICAgICAgICAgICAgICBc
DQo+Pj4+ICAgICAgICAgICAgX19mc3dhYjE2KHgpKQ0KPj4+PiAgICAjZW5kaWYNCj4+Pj4NCj4+
Pj4gU28gd2UgY2FuIHR3ZWFrIHNlbGZ0ZXN0cy9icGYvYnBmX2VuZGlhbi5oIGFuZCB1c2UgVUFQ
SQ0KPj4+PiBfX3N3YWIxNigpL19fc3dhYjMyKCkuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IFNlcmdleSBTZW5vemhhdHNreSA8c2VyZ2V5LnNlbm96aGF0c2t5QGdtYWlsLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+DQo+Pj4+IHYyOiBmaXhlZCBidWlsZCBlcnJvciwgcmVzaHVmZmxlZCBwYXRjaGVz
IChTdGFuaXNsYXYgRm9taWNoZXYpDQo+Pj4gVGVzdGVkIHRoZW0gbG9jYWxseSB3aXRoIHRoZSBj
b21waWxlciBJIHNhdyB0aGUgaW5pdGlhbCBpc3N1ZXMgd2l0aCAtIGFsbA0KPj4+IGZpbmUsIEkg
ZG9uJ3Qgc2VlIGFueSBlcnJvcnMgd2l0aCB0aGUgb2xkZXIgZ2NjLg0KPj4+DQo+Pj4gT25lIGxh
c3QgcXVlc3Rpb24gSSBoYXZlIGlzOiB3aGF0IGhhcHBlbnMgaW4gdGhlIGxsdm0rYnBmIGNhc2U/
IEhhdmUNCj4+PiB5b3UgdGVzdGVkIHRoYXQ/IEkgdGhpbmsgTExWTSBoYXMgYWxsIHRoZSBidWls
dGlucyByZXF1aXJlZCwgYnV0IHNpbmNlDQo+Pj4gd2UgYXJlIHJlbHlpbmcgb24gdGhlIHN3YWIu
aCBub3cgKGFuZCBpdCByZWxpZXMgb24NCj4+PiBfX0hBVkVfQlVJTFRJTl9CU1dBUDE2X18pLCBJ
IHdvbmRlciB3aGV0aGVyIHRoaXMgZGV0ZWN0aW9uIHdvcmtzDQo+Pj4gY29ycmVjdGx5IG9uIHRo
ZSBsbHZtIHdoZW4gdGFyZ2V0aW5nIGJwZi4gKHNpZGVub3RlOiBicGZfZW5kaWFuLmggY2FuIGJl
DQo+Pj4gdXNlZCBmcm9tIGJvdGggdXNlcnNwYWNlIGFuZCBicGYgcHJvZ3JhbXMpLg0KPj4NCj4+
IEluc2lkZSBrZXJuZWwgY2xhbmcgY29tcGlsZXIgaGVhZGVyIChsaW51eC9jb21waWxlci1jbGFu
Zy5oKSBkb2VzIG5vdA0KPj4gZGVmaW5lIF9fSEFWRV9CVUlMVElOX0JTV0FQMTZfXy4gU28gaXQg
d2lsbCBnbyB0byB0aGUgImVsc2UiIGJyYW5jaCBpbg0KPj4gdGhlIGFib3ZlLiBTbyBJIHRoaW5r
IGl0IHNob3VsZCB3b3JrIHdpdGggY2xhbmcgKyBicGYuDQo+IEhtLCBpc24ndCBpdCB0aGUgb3Bw
b3NpdGUgb2Ygd2hhdCB3ZSB3YW50IHRoZW4/IEkgdGhpbmsgZm9yIGxsdm0rYnBmIHdlIGFsd2F5
cw0KPiB3YW50IHRvIHVzZSB0aGUgYnVpbHRpbnMgdG8gbWFrZSBpdCBwcm9wZXJseSBnZW5lcmF0
ZQ0KPiBCUEZfVE9fQkUvQlBGX1RPX0xFIGluc3RydWN0aW9ucy4NCg0KT2theSwgSSBzZWUuIFRo
ZW4gdGhpcyBwYXRjaCB3aWxsIG5vdCBhY2hpZXZlIHRoYXQuDQpUaGUgZm9sbG93aW5nIGFyZSB0
d28gY29tbW9uIHdheXMgdG8gY29tcGlsZSBhIGJwZiBwcm9ncmFtOg0KICAgLSAiY2xhbmcgLXRh
cmdldCBicGYgLi4uIiwgbWF5YmUgYWRkIG1hY3JvIF9fQlBGX18gc29tZXdoZXJlDQogICAgIHRv
IGluZGljYXRlIGJ1aWx0aW5fYnN3YXAxNiBhbHdheXMgYXZhaWxhYmxlPw0KICAgLSAiY2xhbmcg
PGhvc3QgdGFyZ2V0PiAuLi4iIGFuZCB0aGVuICJsbGMgLW1hcmNoPWJwZiAuLi4iDQogICAgIGlu
IHRoaXMgY2FzZSwgX19CUEZfXyBtYWNybyBpcyBub3QgYXZhaWxhYmxlIGFuZA0KICAgICB3ZSB3
aWxsIG5vdCBiZSBhYmxlIHRvIHVzZSBidWlsdGluIHN3YXAgZm9yIGJwZiBwcm9ncmFtLg0KDQpN
YXliZSB1c2UgX19jbGFuZ19fIG1hY3JvIChvciBnY2MgbWFjcm8pIHRvIGRpc3Rpbmd1aXNoIGJl
dHdlZW4gY2xhbmcgDQphbmQgZ2NjLiBJZiBpdCBpcyBnY2Mgd2Ugd2lsbCBjaGVjayBidWlsdGlu
IGF2YWlsYWJpbGl0eSwgb3RoZXJ3aXNlLA0Kd2UgYXNzdW1lIGJ1aWx0aW4gYWx3YXlzIGF2YWls
YWJsZT8gVGhpcyBub3QgcHJldHR5IHRob3VnaC4NCg0KPiANCj4+Pg0KPj4+Pg0KPj4+PiAgICB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvYnBmX2VuZGlhbi5oIHwgOCArKysrLS0tLQ0KPj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4+
Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2JwZl9lbmRp
YW4uaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZfZW5kaWFuLmgNCj4+Pj4gaW5k
ZXggYjI1NTk1ZWE0YTc4Li4xZWQyNjhiMjAwMmIgMTAwNjQ0DQo+Pj4+IC0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZfZW5kaWFuLmgNCj4+Pj4gKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL2JwZl9lbmRpYW4uaA0KPj4+PiBAQCAtMjAsMTIgKzIwLDEyIEBADQo+
Pj4+ICAgICAqIHVzZSBkaWZmZXJlbnQgdGFyZ2V0cy4NCj4+Pj4gICAgICovDQo+Pj4+ICAgICNp
ZiBfX0JZVEVfT1JERVJfXyA9PSBfX09SREVSX0xJVFRMRV9FTkRJQU5fXw0KPj4+PiAtIyBkZWZp
bmUgX19icGZfbnRvaHMoeCkJCQlfX2J1aWx0aW5fYnN3YXAxNih4KQ0KPj4+PiAtIyBkZWZpbmUg
X19icGZfaHRvbnMoeCkJCQlfX2J1aWx0aW5fYnN3YXAxNih4KQ0KPj4+PiArIyBkZWZpbmUgX19i
cGZfbnRvaHMoeCkJCQlfX3N3YWIxNih4KQ0KPj4+PiArIyBkZWZpbmUgX19icGZfaHRvbnMoeCkJ
CQlfX3N3YWIxNih4KQ0KPj4+PiAgICAjIGRlZmluZSBfX2JwZl9jb25zdGFudF9udG9ocyh4KQlf
X19jb25zdGFudF9zd2FiMTYoeCkNCj4+Pj4gICAgIyBkZWZpbmUgX19icGZfY29uc3RhbnRfaHRv
bnMoeCkJX19fY29uc3RhbnRfc3dhYjE2KHgpDQo+Pj4+IC0jIGRlZmluZSBfX2JwZl9udG9obCh4
KQkJCV9fYnVpbHRpbl9ic3dhcDMyKHgpDQo+Pj4+IC0jIGRlZmluZSBfX2JwZl9odG9ubCh4KQkJ
CV9fYnVpbHRpbl9ic3dhcDMyKHgpDQo+Pj4+ICsjIGRlZmluZSBfX2JwZl9udG9obCh4KQkJCV9f
c3dhYjMyKHgpDQo+Pj4+ICsjIGRlZmluZSBfX2JwZl9odG9ubCh4KQkJCV9fc3dhYjMyKHgpDQo+
Pj4+ICAgICMgZGVmaW5lIF9fYnBmX2NvbnN0YW50X250b2hsKHgpCV9fX2NvbnN0YW50X3N3YWIz
Mih4KQ0KPj4+PiAgICAjIGRlZmluZSBfX2JwZl9jb25zdGFudF9odG9ubCh4KQlfX19jb25zdGFu
dF9zd2FiMzIoeCkNCj4+Pj4gICAgI2VsaWYgX19CWVRFX09SREVSX18gPT0gX19PUkRFUl9CSUdf
RU5ESUFOX18NCj4+Pj4gLS0gDQo+Pj4+IDIuMjEuMA0KPj4+Pg0K
