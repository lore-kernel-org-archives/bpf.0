Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EE0C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 23:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56988218B0
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 23:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oxHCtrWC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bcHArVzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCTXcV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:32:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36196 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726914AbfCTXcU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Mar 2019 19:32:20 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KNTVY3030890;
        Wed, 20 Mar 2019 16:31:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lp/tpiV+Mq13FOp+7podjQ6VqPUF69xa6npb1Oz+CA8=;
 b=oxHCtrWCwwgWQSEGIj8UPBCzgfmq08PLcumXpBY/b63rRAWBaUK0W12bhkxwCqT7S71N
 jvelFDZBr18naeFr6BRQwmXxPAaS7t9vmZYB3PZD9/6KPGKIoiu6waFIy8ewjo9sncXX
 b2I6j6x/bvy+SxRHxz5q9o+81YAoZPd5N6Q= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rbqk9sx9x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 16:31:57 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Mar 2019 16:31:56 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Mar 2019 16:31:56 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Mar 2019 16:31:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp/tpiV+Mq13FOp+7podjQ6VqPUF69xa6npb1Oz+CA8=;
 b=bcHArVzG4qC0pBNdvF9tEZolx446PlG3rwN0o0sts7vJ6qsvlJZt342fGbwB6BP8tjo+F5zfWK7A/bDn9FlR7qeaxcBOMZKLlenchspvBzI6LZIsLvTEZVjFEEBZfDdvfxJTbnVRJ/FO7/DlBNCLyjZZdslu0F7fNnNp2VlCbcs=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2759.namprd15.prod.outlook.com (20.179.157.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 20 Mar 2019 23:31:54 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1730.013; Wed, 20 Mar 2019
 23:31:54 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "xiao.han@orange.com" <xiao.han@orange.com>,
        "paul.chaignon@gmail.com" <paul.chaignon@gmail.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: remove incorrect 'verifier bug' warning
Thread-Topic: [PATCH bpf-next 0/2] bpf: remove incorrect 'verifier bug'
 warning
Thread-Index: AQHU3xyIW4YIQFbJxE29+gAm1XqSRaYVK/YA
Date:   Wed, 20 Mar 2019 23:31:54 +0000
Message-ID: <e84ec4b3-ea21-a2ed-d6fb-1c899ef748d0@fb.com>
References: <cover.1553085539.git.paul.chaignon@orange.com>
In-Reply-To: <cover.1553085539.git.paul.chaignon@orange.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:300:117::17) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1f74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6453c79-1ff7-4865-6d57-08d6ad8c3c5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2759;
x-ms-traffictypediagnostic: BYAPR15MB2759:
x-microsoft-antispam-prvs: <BYAPR15MB2759A54E70EA80A9FD148D49D3410@BYAPR15MB2759.namprd15.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(305945005)(6512007)(31696002)(478600001)(86362001)(25786009)(2201001)(36756003)(99286004)(31686004)(52116002)(4326008)(105586002)(106356001)(8676002)(81166006)(81156014)(14454004)(6486002)(68736007)(53936002)(229853002)(7736002)(8936002)(6436002)(46003)(97736004)(316002)(6246003)(6116002)(446003)(102836004)(2616005)(476003)(6506007)(386003)(11346002)(486006)(53546011)(2906002)(2501003)(71200400001)(54906003)(5660300002)(71190400001)(76176011)(110136005)(186003)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2759;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XJo70P7nNyd0jR7WSJgFMzvxcG+BQkWNlk9m5XADT7jUv5euuEjMbcEpzs0djuNNyEU9bSinYKocz9u2JLOxUpxoydqkwxxlnIVzlltXgC1/FAajMaSO+q3/sSN5MsabSmcGXXam4RcvG7idMjrIeEBmEn30oT0fEf52aKwKJvG5dlil1zP79y7q1uZdr/jYfM4HCv3MAIitKkP52OywqGAtWVg34HgOxS281pM3E3QgTF2I6TcONhexaxI2is/p1oubvmmzt0laV0/mBI/UcgKwqVohXh1RdCWFofim8hSHQcVgTVH5oig4CF2uDA0XYzlH29qc9P/GDf+vbMepUAvNbxE5tuA49Wmx5uctYLF8uroSneoECjycBzRwds1+tIfc76y2hZVXnBDZLOIEnCvMzhrkKPtYLvgDA7Vp07c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAF79A7CDFB4FA448D91DB73D659AC2A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6453c79-1ff7-4865-6d57-08d6ad8c3c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 23:31:54.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDMvMjAvMTkgNTo1NyBBTSwgUGF1bCBDaGFpZ25vbiB3cm90ZToNCj4gVGhlIEJQRiB2
ZXJpZmllciBjaGVja3MgdGhlIG1heGltdW0gbnVtYmVyIG9mIGNhbGwgc3RhY2sgZnJhbWVzIHR3
aWNlLA0KPiBmaXJzdCBpbiB0aGUgbWFpbiBDRkcgdHJhdmVyc2FsIChkb19jaGVjaykgYW5kIHRo
ZW4gaW4gYSBzdWJzZXF1ZW50DQo+IHRyYXZlcnNhbCAoY2hlY2tfbWF4X3N0YWNrX2RlcHRoKS4g
IElmIHRoZSBzZWNvbmQgY2hlY2sgZmFpbHMsIGl0IGxvZ3MgYQ0KPiAndmVyaWZpZXIgYnVnJyB3
YXJuaW5nIGFuZCBlcnJvcnMgb3V0LCBhcyB0aGUgbnVtYmVyIG9mIGNhbGwgc3RhY2sgZnJhbWVz
DQo+IHNob3VsZCBoYXZlIGJlZW4gdmVyaWZpZWQgYWxyZWFkeS4NCj4gDQo+IEhvd2V2ZXIsIHRo
ZSBzZWNvbmQgY2hlY2sgbWF5IGZhaWwgd2l0aG91dCBpbmRpY2F0aW5nIGEgdmVyaWZpZXIgYnVn
OiBpZg0KPiB0aGUgZXhjZXNzaXZlIGZ1bmN0aW9uIGNhbGxzIHJlc2lkZSBpbiBkZWFkIGNvZGUs
IHRoZSBtYWluIENGRyB0cmF2ZXJzYWwNCj4gbWF5IG5vdCB2aXNpdCB0aGVtOyB0aGUgc3Vic2Vx
dWVudCB0cmF2ZXJzYWwgdmlzaXRzIGFsbCBpbnN0cnVjdGlvbnMsDQo+IGluY2x1ZGluZyBkZWFk
IGNvZGUuDQo+IA0KPiBUaGlzIGNhc2UgcmFpc2VzIHRoZSBxdWVzdGlvbiBvZiBob3cgaW52YWxp
ZCBkZWFkIGNvZGUgc2hvdWxkIGJlIHRyZWF0ZWQuDQoNCk1heWJlIHdlIHNob3VsZCBkbyB0aGlz
IGNoZWNrIGFmdGVyIGRlYWQgY29kZSBlbGltaW5hdGlvbiB0byBiZSANCmNvbnNpc3RlbnQgd2l0
aCBkb19jaGVjaz8gVGhlcmUgY291bGQgc29tZSBvdGhlciBraW5kcyBvZiBpbGxlZ2FsIHN0dWZm
DQppbiB0aGUgZGVhZCBjb2RlLCBlLmcuLCBpbGxlZ2FsL3Vuc3VwcG9ydGVkIGhlbHBlcnMsIGV0
Yy4gSSBzdXBwb3NlIHdlIA0KZGlkIG5vdCB3YXJuIG9yIHJlamVjdCB0aGUgcHJvZ3JhbSwgcmln
aHQ/DQoNCj4gVGhlIGZpcnN0IHBhdGNoIGltcGxlbWVudHMgdGhlIGNvbnNlcnZhdGl2ZSBvcHRp
b24gYW5kIHJlamVjdHMgc3VjaCBjb2RlOw0KPiB0aGUgc2Vjb25kIGFkZHMgYSB0ZXN0IGNhc2Uu
DQo+IA0KPiBQYXVsIENoYWlnbm9uICgyKToNCj4gICAgYnBmOiByZW1vdmUgaW5jb3JyZWN0ICd2
ZXJpZmllciBidWcnIHdhcm5pbmcNCj4gICAgc2VsZnRlc3RzL2JwZjogdGVzdCBjYXNlIGZvciBp
bnZhbGlkIGNhbGwgc3RhY2sgaW4gZGVhZCBjb2RlDQo+IA0KPiAgIGtlcm5lbC9icGYvdmVyaWZp
ZXIuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKy0tDQo+ICAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3ZlcmlmaWVyL2NhbGxzLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKw0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo=
