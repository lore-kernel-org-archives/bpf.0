Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CCC43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3652184E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 22:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OWj6SqDO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PZcvqbQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCTWVL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:21:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50428 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727507AbfCTWVL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Mar 2019 18:21:11 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KMGwb2025519;
        Wed, 20 Mar 2019 15:20:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LvevtNyyN8I8qq329cz5CF3Z9SZaiw9UqPCKnG9mW5w=;
 b=OWj6SqDOFt3R+1N6QBHfFkAgdF8YPNmxs3FgVxvTxNjCKnBfG/khOwtPQQ4+rhk3SQSI
 Tf/01UJHpr+tueNYhxxaUeBfmvW5wWI8nRVSnv/pjOviY/7V+pg/NafmIwnPJuMQKrRg
 dIgmuKeyYAimeO5PUGot7DvzSbg285rXGu8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rbss2h29p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 15:20:48 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Mar 2019 15:20:47 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Mar 2019 15:20:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvevtNyyN8I8qq329cz5CF3Z9SZaiw9UqPCKnG9mW5w=;
 b=PZcvqbQvLCn3cJ2tBq8G7TS9kkHmiDpeKVQfDRe0eqLS7/LLBmw3bZ5li/cN4tegE7F+fKMY3pJ7pfuSDpI94njK3v2F9bkYrNczFU95DoapabgHyzKqk2ynTrqKoxMKBztDznoOtR2vuPlOt8y9VikMPxdTCf+fbYc9zQhkVyM=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2437.namprd15.prod.outlook.com (52.135.198.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Wed, 20 Mar 2019 22:20:45 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1730.013; Wed, 20 Mar 2019
 22:20:45 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Thread-Topic: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Thread-Index: AQHU3xwCZC2TOonV6EyntesbokSF86YUwkQAgABV0oA=
Date:   Wed, 20 Mar 2019 22:20:45 +0000
Message-ID: <4c6db4e5-8e77-2e01-a4ab-25808df2b857@fb.com>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0095.namprd22.prod.outlook.com
 (2603:10b6:301:5e::48) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1f74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 688c5a3a-9d8c-4d82-9653-08d6ad824bbc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2437;
x-ms-traffictypediagnostic: BYAPR15MB2437:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2437;20:sDvUUdsnk6WLoHXYxkbuRjHE9hSpiF76NXlRrsVdFjrvka+lEaADprPN3TOJNSVr+qiEdeY8IgTKUGo/Bt4q4JXhCoK3v+6jv5Jn+85pKBUhCkZGqoZSwUYI9llVB8vNtbc+0yqhnu8usQzRDnyEIKZyHUbe0gCo3WNMhDCZZFU=
x-microsoft-antispam-prvs: <BYAPR15MB24373B89474E4FDB39DC6206D3410@BYAPR15MB2437.namprd15.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(376002)(396003)(43544003)(199004)(189003)(46003)(11346002)(81156014)(6436002)(486006)(106356001)(105586002)(68736007)(8676002)(6116002)(71190400001)(6506007)(5660300002)(31686004)(99286004)(2616005)(478600001)(186003)(97736004)(36756003)(6246003)(54906003)(4326008)(386003)(53546011)(86362001)(316002)(53936002)(305945005)(76176011)(81166006)(6486002)(25786009)(7736002)(2906002)(14454004)(31696002)(71200400001)(102836004)(8936002)(256004)(14444005)(229853002)(6512007)(52116002)(110136005)(446003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2437;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7E8JO7b9Ek75iWaKKltce1isPTBF99MaQUC82aGtb3mWWh8ziIzXcksn3HLnm3FNFjlUH25przIz9nmzrSu1jpCy9jWYXzHXIYRTzEZ2bUxn66LlGFm4Tt776T1Uj7xIoFOVlkNitssWx+QOO9dKJ3OOPuNyHOYTDlpn42927wOKiZVQ6meob19KBQ4uLha3T5+vjXkfneA/aos/mCKmDgqxszBemSH4fc7B5CTczzNkow1m+0PQvio8FdhJ1rLuzSHyEW6SE/qR/Q2K7PZdGS59Vx4Zh+UVk8hjuH04b0/Xgcy0L0r+vSxTPRG0tZZ8uWtkoKOrZpbnYAz3MRj45cnOGglp4xO+gIiK4bCVm2wG8/f879T/iAWKxON9PrHncvF6iTKc1kroummZTen60Mi3SIvLXUoYKIN5yFK4fz8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E755D6F41B43A4ABD39E762404F24EC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c5a3a-9d8c-4d82-9653-08d6ad824bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 22:20:45.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDMvMjAvMTkgMTA6MTMgQU0sIFN0YW5pc2xhdiBGb21pY2hldiB3cm90ZToNCj4gT24g
MDMvMjAsIFNlcmdleSBTZW5vemhhdHNreSB3cm90ZToNCj4+IE5vdCBhbGwgY29tcGlsZXJzIGhh
dmUgX19idWlsdGluX2Jzd2FwMTYoKSBhbmQgX19idWlsdGluX2Jzd2FwMzIoKSwNCj4+IHRodXMg
bm90IGFsbCBjb21waWxlcnMgYXJlIGFibGUgdG8gY29tcGlsZSB0aGUgZm9sbG93aW5nIGNvZGU6
DQo+Pg0KPj4gICAgICAgICAgKF9fYnVpbHRpbl9jb25zdGFudF9wKHgpID8gXA0KPj4gICAgICAg
ICAgICAgICAgICBfX19jb25zdGFudF9zd2FiMTYoeCkgOiBfX2J1aWx0aW5fYnN3YXAxNih4KSkN
Cj4+DQo+PiBUaGF0J3MgdGhlIHJlYXNvbiB3aHkgYnBmX250b2hsKCkgZG9lc24ndCB3b3JrIG9u
IEdDQyA8IDQuOCwgZm9yDQo+PiBpbnN0YW5jZToNCj4+DQo+PiAgICAgICAgICBlcnJvcjogaW1w
bGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ19fYnVpbHRpbl9ic3dhcDE2Jw0KPj4NCj4+
IFdlIGNhbiB1c2UgX19idWlsdGluX2Jzd2FwMTYoKSBvbmx5IGlmIGNvbXBpbGVyIGhhcyB0aGlz
IGJ1aWx0LWluLA0KPj4gdGhhdCBpcywgb25seSBpZiBfX0hBVkVfQlVJTFRJTl9CU1dBUDE2X18g
aXMgZGVmaW5lZC4gU3RhbmRhcmQgVUFQSQ0KPj4gX19zd2FiMTYoKS9fX3N3YWIzMigpIHRha2Ug
Y2FyZSBvZiB0aGF0LCBhbmQsIGFkZGl0aW9uYWxseSwgaGFuZGxlDQo+PiBfX2J1aWx0aW5fY29u
c3RhbnRfcCgpIGNhc2VzIGFzIHdlbGw6DQo+Pg0KPj4gICAjaWZkZWYgX19IQVZFX0JVSUxUSU5f
QlNXQVAxNl9fDQo+PiAgICNkZWZpbmUgX19zd2FiMTYoeCkgKF9fdTE2KV9fYnVpbHRpbl9ic3dh
cDE2KChfX3UxNikoeCkpDQo+PiAgICNlbHNlDQo+PiAgICNkZWZpbmUgX19zd2FiMTYoeCkgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+ICAgICAgICAgICAoX19idWlsdGluX2NvbnN0
YW50X3AoKF9fdTE2KSh4KSkgPyAgICAgXA0KPj4gICAgICAgICAgIF9fX2NvbnN0YW50X3N3YWIx
Nih4KSA6ICAgICAgICAgICAgICAgICBcDQo+PiAgICAgICAgICAgX19mc3dhYjE2KHgpKQ0KPj4g
ICAjZW5kaWYNCj4+DQo+PiBTbyB3ZSBjYW4gdHdlYWsgc2VsZnRlc3RzL2JwZi9icGZfZW5kaWFu
LmggYW5kIHVzZSBVQVBJDQo+PiBfX3N3YWIxNigpL19fc3dhYjMyKCkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogU2VyZ2V5IFNlbm96aGF0c2t5IDxzZXJnZXkuc2Vub3poYXRza3lAZ21haWwuY29t
Pg0KPj4gLS0tDQo+Pg0KPj4gdjI6IGZpeGVkIGJ1aWxkIGVycm9yLCByZXNodWZmbGVkIHBhdGNo
ZXMgKFN0YW5pc2xhdiBGb21pY2hldikNCj4gVGVzdGVkIHRoZW0gbG9jYWxseSB3aXRoIHRoZSBj
b21waWxlciBJIHNhdyB0aGUgaW5pdGlhbCBpc3N1ZXMgd2l0aCAtIGFsbA0KPiBmaW5lLCBJIGRv
bid0IHNlZSBhbnkgZXJyb3JzIHdpdGggdGhlIG9sZGVyIGdjYy4NCj4gDQo+IE9uZSBsYXN0IHF1
ZXN0aW9uIEkgaGF2ZSBpczogd2hhdCBoYXBwZW5zIGluIHRoZSBsbHZtK2JwZiBjYXNlPyBIYXZl
DQo+IHlvdSB0ZXN0ZWQgdGhhdD8gSSB0aGluayBMTFZNIGhhcyBhbGwgdGhlIGJ1aWx0aW5zIHJl
cXVpcmVkLCBidXQgc2luY2UNCj4gd2UgYXJlIHJlbHlpbmcgb24gdGhlIHN3YWIuaCBub3cgKGFu
ZCBpdCByZWxpZXMgb24NCj4gX19IQVZFX0JVSUxUSU5fQlNXQVAxNl9fKSwgSSB3b25kZXIgd2hl
dGhlciB0aGlzIGRldGVjdGlvbiB3b3Jrcw0KPiBjb3JyZWN0bHkgb24gdGhlIGxsdm0gd2hlbiB0
YXJnZXRpbmcgYnBmLiAoc2lkZW5vdGU6IGJwZl9lbmRpYW4uaCBjYW4gYmUNCj4gdXNlZCBmcm9t
IGJvdGggdXNlcnNwYWNlIGFuZCBicGYgcHJvZ3JhbXMpLg0KDQpJbnNpZGUga2VybmVsIGNsYW5n
IGNvbXBpbGVyIGhlYWRlciAobGludXgvY29tcGlsZXItY2xhbmcuaCkgZG9lcyBub3QgDQpkZWZp
bmUgX19IQVZFX0JVSUxUSU5fQlNXQVAxNl9fLiBTbyBpdCB3aWxsIGdvIHRvIHRoZSAiZWxzZSIg
YnJhbmNoIGluIA0KdGhlIGFib3ZlLiBTbyBJIHRoaW5rIGl0IHNob3VsZCB3b3JrIHdpdGggY2xh
bmcgKyBicGYuDQoNCj4gDQo+Pg0KPj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvYnBm
X2VuZGlhbi5oIHwgOCArKysrLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9icGYvYnBmX2VuZGlhbi5oIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2Jw
Zl9lbmRpYW4uaA0KPj4gaW5kZXggYjI1NTk1ZWE0YTc4Li4xZWQyNjhiMjAwMmIgMTAwNjQ0DQo+
PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvYnBmX2VuZGlhbi5oDQo+PiArKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvYnBmX2VuZGlhbi5oDQo+PiBAQCAtMjAsMTIg
KzIwLDEyIEBADQo+PiAgICAqIHVzZSBkaWZmZXJlbnQgdGFyZ2V0cy4NCj4+ICAgICovDQo+PiAg
ICNpZiBfX0JZVEVfT1JERVJfXyA9PSBfX09SREVSX0xJVFRMRV9FTkRJQU5fXw0KPj4gLSMgZGVm
aW5lIF9fYnBmX250b2hzKHgpCQkJX19idWlsdGluX2Jzd2FwMTYoeCkNCj4+IC0jIGRlZmluZSBf
X2JwZl9odG9ucyh4KQkJCV9fYnVpbHRpbl9ic3dhcDE2KHgpDQo+PiArIyBkZWZpbmUgX19icGZf
bnRvaHMoeCkJCQlfX3N3YWIxNih4KQ0KPj4gKyMgZGVmaW5lIF9fYnBmX2h0b25zKHgpCQkJX19z
d2FiMTYoeCkNCj4+ICAgIyBkZWZpbmUgX19icGZfY29uc3RhbnRfbnRvaHMoeCkJX19fY29uc3Rh
bnRfc3dhYjE2KHgpDQo+PiAgICMgZGVmaW5lIF9fYnBmX2NvbnN0YW50X2h0b25zKHgpCV9fX2Nv
bnN0YW50X3N3YWIxNih4KQ0KPj4gLSMgZGVmaW5lIF9fYnBmX250b2hsKHgpCQkJX19idWlsdGlu
X2Jzd2FwMzIoeCkNCj4+IC0jIGRlZmluZSBfX2JwZl9odG9ubCh4KQkJCV9fYnVpbHRpbl9ic3dh
cDMyKHgpDQo+PiArIyBkZWZpbmUgX19icGZfbnRvaGwoeCkJCQlfX3N3YWIzMih4KQ0KPj4gKyMg
ZGVmaW5lIF9fYnBmX2h0b25sKHgpCQkJX19zd2FiMzIoeCkNCj4+ICAgIyBkZWZpbmUgX19icGZf
Y29uc3RhbnRfbnRvaGwoeCkJX19fY29uc3RhbnRfc3dhYjMyKHgpDQo+PiAgICMgZGVmaW5lIF9f
YnBmX2NvbnN0YW50X2h0b25sKHgpCV9fX2NvbnN0YW50X3N3YWIzMih4KQ0KPj4gICAjZWxpZiBf
X0JZVEVfT1JERVJfXyA9PSBfX09SREVSX0JJR19FTkRJQU5fXw0KPj4gLS0gDQo+PiAyLjIxLjAN
Cj4+DQo=
