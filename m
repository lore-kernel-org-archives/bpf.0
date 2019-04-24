Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D64BC282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A77720652
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PoImcx3h";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VnO8kDKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfDXSGg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:06:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34788 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388263AbfDXRRp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Apr 2019 13:17:45 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OHCkPq015579;
        Wed, 24 Apr 2019 10:17:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4y2LuT3677yrHyJRnU/eXoi2PnMRLJ8n+nukaXRb+k8=;
 b=PoImcx3hAWi0E/XRvCneefyePRswNqvN+zd1ImJkxJqiZ6pr2iuINiNOa8tP6Iw5naEa
 PZGbL0415ds8Y+pKg3uRC42QachCDi/GUeS45Lj7InhCYKQ6xLUy9OA7ws18EntyciNJ
 EIGjAmG6TIEdP8WPdc6m6L3hL8LL8SILewk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2rkf8yb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 10:17:19 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 10:17:18 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 10:17:18 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Apr 2019 10:17:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y2LuT3677yrHyJRnU/eXoi2PnMRLJ8n+nukaXRb+k8=;
 b=VnO8kDKdiniRsowrxcjcrc8281eHxkvpeHvkcU5O8FNcW4ANJXvJ84jBCa6Ybs8V+VLLiHaXL1PY8E2TxEdWDQkZVKBzpbln5wS5UPrP22Ir6x5++UXATToHJKScIwJZ8xguk5/+5jjgKjP7C5WB7vAhFxk8+ibB7qm+2x1qca4=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2280.namprd15.prod.outlook.com (52.135.197.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Wed, 24 Apr 2019 17:17:14 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 17:17:14 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Martin Lau <kafai@fb.com>,
        "acme@kernel.org" <acme@kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: add ability to dump BTF types
Thread-Topic: [PATCH bpf-next 1/2] bpftool: add ability to dump BTF types
Thread-Index: AQHU+l5mzy/JVefHY02PsB35pRYTrqZLjl6A
Date:   Wed, 24 Apr 2019 17:17:14 +0000
Message-ID: <c149c047-7b6a-bb8b-d472-6ea01a9e4caa@fb.com>
References: <20190424052200.1625142-1-andrii.nakryiko@gmail.com>
 <20190424052200.1625142-2-andrii.nakryiko@gmail.com>
In-Reply-To: <20190424052200.1625142-2-andrii.nakryiko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:300:13d::17) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9af92f22-9353-4a6c-565a-08d6c8d8b1b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2280;
x-ms-traffictypediagnostic: BYAPR15MB2280:
x-microsoft-antispam-prvs: <BYAPR15MB2280DD7507593770A9038E64D33C0@BYAPR15MB2280.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(66446008)(6116002)(46003)(316002)(25786009)(68736007)(14444005)(2501003)(256004)(305945005)(186003)(64756008)(66946007)(73956011)(66476007)(7736002)(31696002)(11346002)(71200400001)(36756003)(86362001)(2201001)(486006)(102836004)(2616005)(2906002)(53936002)(8936002)(476003)(6512007)(229853002)(478600001)(76176011)(81156014)(6506007)(5660300002)(386003)(14454004)(4326008)(66556008)(6246003)(31686004)(81166006)(97736004)(71190400001)(54906003)(99286004)(8676002)(6436002)(53546011)(446003)(6486002)(110136005)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2280;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /qb8jhO6HnKv52RidWuOyVoylSyZ47yWdHKdKmxn+MLb6IcFqUGis+MafdldENKGM2IcVQ4b6v5/WmR6JlHlmTpY6LTrQhso+dK6yJ53zOEgEDC4r98TwgBplkf+702IM7e59ylD2nV6RV1UN9Ot3i7psq+yMdYLPzJ66qYvgg3muCRp128A3kDH1AadolyFaBjGTlTSmluB/3GThue4ICjNCyvHBZp89837T86Zfi9JEYZWiyA1dAo/xKh0Ic1Alok91QePmNWsEU/Q8H+DxHKwK1v00r9Dr4q63m5J4XO3C9tuIZnAmYudmCgq5To/nwcc5/UW8RukqBeq6snMnFeUzTs+iUsq255wFMHHroK6BeMohOq6luUShLldE9eSVkzwGSAYegAzEPvHFCh2MT2+cpEGFBt7iR6yKiZHKeU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACA867DDB34371468ACB911FB1497915@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af92f22-9353-4a6c-565a-08d6c8d8b1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 17:17:14.2689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2280
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjMvMTkgMTA6MjEgUE0sIGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20gd3JvdGU6
DQo+IEZyb206IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpbkBmYi5jb20+DQo+IA0KPiBBZGQgbmV3
IGBidGYgZHVtcGAgc3ViLWNvbW1hbmQgdG8gYnBmdG9vbC4gSXQgYWxsb3dzIHRvIGR1bXANCj4g
aHVtYW4tcmVhZGFibGUgbG93LWxldmVsIEJURiB0eXBlcyByZXByZXNlbnRhdGlvbiBvZiBCVEYg
dHlwZXMuIEJURiBjYW4NCj4gYmUgcmV0cmlldmVkIGZyb20gZmV3IGRpZmZlcmVudCBzb3VyY2Vz
Og0KPiAgICAtIGZyb20gQlRGIG9iamVjdCBieSBJRDsNCj4gICAgLSBmcm9tIFBST0csIGlmIGl0
IGhhcyBhc3NvY2lhdGVkIEJURjsNCj4gICAgLSBmcm9tIE1BUCwgaWYgaXQgaGFzIGFzc29jaWF0
ZWQgQlRGIGRhdGE7IGl0J3MgcG9zc2libGUgdG8gbmFycm93DQo+ICAgICAgZG93biB0eXBlcyB0
byBlaXRoZXIga2V5IHR5cGUsIHZhbHVlIHR5cGUsIGJvdGgsIG9yIGFsbCBCVEYgdHlwZXM7DQo+
ICAgIC0gZnJvbSBFTEYgZmlsZSAoLkJURiBzZWN0aW9uKS4NCj4gDQo+IE91dHB1dCBmb3JtYXQg
bW9zdGx5IGZvbGxvd3MgQlBGIHZlcmlmaWVyIGxvZyBmb3JtYXQgd2l0aCBmZXcgbm90YWJsZQ0K
PiBleGNlcHRpb25zOg0KPiAgICAtIGFsbCB0aGUgdHlwZS9maWVsZC9wYXJhbS9ldGMgbmFtZXMg
YXJlIGVuY2xvc2VkIGluIHNpbmdsZSBxdW90ZXMgdG8NCj4gICAgICBhbGxvdyBlYXNpZXIgZ3Jl
cHBpbmcgYW5kIHRvIHN0YW5kIG91dCBhIGxpdHRsZSBiaXQgbW9yZTsNCj4gICAgLSBGVU5DX1BS
T1RPIG91dHB1dCBmb2xsb3dzIFNUUlVDVC9VTklPTi9FTlVNIGZvcm1hdCBvZiBoYXZpbmcgb25l
DQo+ICAgICAgbGluZSBwZXIgZWFjaCBhcmd1bWVudDsgdGhpcyBpcyBtb3JlIHVuaWZvcm0gYW5k
IGFsbG93cyBlYXN5DQo+ICAgICAgZ3JlcHBpbmcsIGFzIG9wcG9zZWQgdG8gc3VjY2luY3QsIGJ1
dCBpbmNvbnZlbmllbnQgZm9ybWF0IHRoYXQgQlBGDQo+ICAgICAgdmVyaWZpZXIgbG9nIGlzIHVz
aW5nLg0KPiANCj4gQ2M6IERhbmllbCBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+DQo+
IENjOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBmYi5jb20+DQo+IENjOiBZb25naG9uZyBTb25n
IDx5aHNAZmIuY29tPg0KPiBDYzogTWFydGluIEthRmFpIExhdSA8a2FmYWlAZmIuY29tPg0KPiBD
YzogU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4NCj4gQ2M6IEFybmFsZG8gQ2FydmFs
aG8gZGUgTWVsbyA8YWNtZUByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyaWkgTmFr
cnlpa28gPGFuZHJpaW5AZmIuY29tPg0KPiAtLS0NCj4gICB0b29scy9icGYvYnBmdG9vbC9idGYu
YyAgfCA1NzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdG9v
bHMvYnBmL2JwZnRvb2wvbWFpbi5jIHwgICAxICsNCj4gICB0b29scy9icGYvYnBmdG9vbC9tYWlu
LmggfCAgIDEgKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNTc4IGluc2VydGlvbnMoKykNCj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvYnBmL2JwZnRvb2wvYnRmLmMNCj4gDQo+IGRpZmYgLS1n
aXQgYS90b29scy9icGYvYnBmdG9vbC9idGYuYyBiL3Rvb2xzL2JwZi9icGZ0b29sL2J0Zi5jDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uYWZlNWNiN2JhYjBj
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdG9vbHMvYnBmL2JwZnRvb2wvYnRmLmMNCj4gQEAg
LTAsMCArMSw1NzYgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKy8qIENvcHlyaWdodCAoQykgMjAxOSBGYWNlYm9vayAq
Lw0KPiArDQo+ICsjaW5jbHVkZSA8ZXJybm8uaD4NCj4gKyNpbmNsdWRlIDxmY250bC5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiArI2luY2x1ZGUgPHN0ZGJvb2wuaD4NCj4gKyNpbmNs
dWRlIDxzdGRpby5oPg0KPiArI2luY2x1ZGUgPHN0cmluZy5oPg0KPiArI2luY2x1ZGUgPHVuaXN0
ZC5oPg0KPiArI2luY2x1ZGUgPGdlbGYuaD4NCj4gKyNpbmNsdWRlIDxicGYuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9idGYuaD4NCj4gKw0KPiArI2luY2x1ZGUgImJ0Zi5oIg0KPiArI2luY2x1ZGUg
Impzb25fd3JpdGVyLmgiDQo+ICsjaW5jbHVkZSAibWFpbi5oIg0KPiArDQo+ICtzdGF0aWMgY29u
c3QgY2hhciAqIGNvbnN0IGJ0Zl9raW5kX3N0cltOUl9CVEZfS0lORFNdID0gew0KPiArCVtCVEZf
S0lORF9VTktOXQkJPSAiVU5LTk9XTiIsDQo+ICsJW0JURl9LSU5EX0lOVF0JCT0gIklOVCIsDQo+
ICsJW0JURl9LSU5EX1BUUl0JCT0gIlBUUiIsDQo+ICsJW0JURl9LSU5EX0FSUkFZXQk9ICJBUlJB
WSIsDQo+ICsJW0JURl9LSU5EX1NUUlVDVF0JPSAiU1RSVUNUIiwNCj4gKwlbQlRGX0tJTkRfVU5J
T05dCT0gIlVOSU9OIiwNCj4gKwlbQlRGX0tJTkRfRU5VTV0JCT0gIkVOVU0iLA0KPiArCVtCVEZf
S0lORF9GV0RdCQk9ICJGV0QiLA0KPiArCVtCVEZfS0lORF9UWVBFREVGXQk9ICJUWVBFREVGIiwN
Cj4gKwlbQlRGX0tJTkRfVk9MQVRJTEVdCT0gIlZPTEFUSUxFIiwNCj4gKwlbQlRGX0tJTkRfQ09O
U1RdCT0gIkNPTlNUIiwNCj4gKwlbQlRGX0tJTkRfUkVTVFJJQ1RdCT0gIlJFU1RSSUNUIiwNCj4g
KwlbQlRGX0tJTkRfRlVOQ10JCT0gIkZVTkMiLA0KPiArCVtCVEZfS0lORF9GVU5DX1BST1RPXQk9
ICJGVU5DX1BST1RPIiwNCj4gKwlbQlRGX0tJTkRfVkFSXQkJPSAiVkFSIiwNCj4gKwlbQlRGX0tJ
TkRfREFUQVNFQ10JPSAiREFUQVNFQyIsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3QgY2hh
ciAqYnRmX2ludF9lbmNfc3RyKF9fdTggZW5jb2RpbmcpDQo+ICt7DQo+ICsJc3dpdGNoIChlbmNv
ZGluZykgew0KPiArCWNhc2UgMDoNCj4gKwkJcmV0dXJuICIobm9uZSkiOw0KPiArCWNhc2UgQlRG
X0lOVF9TSUdORUQ6DQo+ICsJCXJldHVybiAiU0lHTkVEIjsNCj4gKwljYXNlIEJURl9JTlRfQ0hB
UjoNCj4gKwkJcmV0dXJuICJDSEFSIjsNCj4gKwljYXNlIEJURl9JTlRfQk9PTDoNCj4gKwkJcmV0
dXJuICJCT09MIjsNCj4gKwlkZWZhdWx0Og0KPiArCQlyZXR1cm4gIlVOS04iOw0KPiArCX0NCj4g
K30NCj4gKw0KPiArc3RhdGljIGNvbnN0IGNoYXIgKmJ0Zl92YXJfbGlua2FnZV9zdHIoX191MzIg
bGlua2FnZSkNCj4gK3sNCj4gKwlzd2l0Y2ggKGxpbmthZ2UpIHsNCj4gKwljYXNlIEJURl9WQVJf
U1RBVElDOg0KPiArCQlyZXR1cm4gInN0YXRpYyI7DQo+ICsJY2FzZSBCVEZfVkFSX0dMT0JBTF9B
TExPQ0FURUQ6DQo+ICsJCXJldHVybiAiZ2xvYmFsLWFsbG9jIjsNCj4gKwlkZWZhdWx0Og0KPiAr
CQlyZXR1cm4gIih1bmtub3duKSI7DQo+ICsJfQ0KPiArfQ0KPiArDQpbLi4uXQ0KPiArDQo+ICtz
dGF0aWMgYm9vbCBjaGVja19idGZfZW5kaWFubmVzcyhHRWxmX0VoZHIgKmVoZHIpDQo+ICt7DQo+
ICsJc3RhdGljIHVuc2lnbmVkIGludCBjb25zdCBlbmRpYW4gPSAxOw0KPiArDQo+ICsJc3dpdGNo
IChlaGRyLT5lX2lkZW50W0VJX0RBVEFdKSB7DQo+ICsJY2FzZSBFTEZEQVRBMkxTQjoNCj4gKwkJ
cmV0dXJuICoodW5zaWduZWQgY2hhciBjb25zdCAqKSZlbmRpYW4gPT0gMTsNCj4gKwljYXNlIEVM
RkRBVEEyTVNCOg0KPiArCQlyZXR1cm4gKih1bnNpZ25lZCBjaGFyIGNvbnN0ICopJmVuZGlhbiA9
PSAwOw0KPiArCWRlZmF1bHQ6DQo+ICsJCXJldHVybiAwOw0KPiArCX0NCj4gK30NCj4gKw0KPiAr
c3RhdGljIGludCBidGZfbG9hZF9mcm9tX2VsZihjb25zdCBjaGFyICpwYXRoLCBzdHJ1Y3QgYnRm
ICoqYnRmKQ0KPiArew0KPiArCWludCBlcnIgPSAtMSwgZmQgPSAtMSwgaWR4ID0gMDsNCj4gKwlF
bGZfRGF0YSAqYnRmX2RhdGEgPSBOVUxMOw0KPiArCUVsZl9TY24gKnNjbiA9IE5VTEw7DQo+ICsJ
RWxmICplbGYgPSBOVUxMOw0KPiArCUdFbGZfRWhkciBlaGRyOw0KPiArDQo+ICsJaWYgKGVsZl92
ZXJzaW9uKEVWX0NVUlJFTlQpID09IEVWX05PTkUpIHsNCj4gKwkJcF9lcnIoImZhaWxlZCB0byBp
bml0IGxpYmVsZiBmb3IgJXMiLCBwYXRoKTsNCj4gKwkJcmV0dXJuIC0xOw0KPiArCX0NCj4gKw0K
PiArCWZkID0gb3BlbihwYXRoLCBPX1JET05MWSk7DQo+ICsJaWYgKGZkIDwgMCkgew0KPiArCQlw
X2VycigiZmFpbGVkIHRvIG9wZW4gJXM6ICVzIiwgcGF0aCwgc3RyZXJyb3IoZXJybm8pKTsNCj4g
KwkJcmV0dXJuIC0xOw0KPiArCX0NCj4gKw0KPiArCWVsZiA9IGVsZl9iZWdpbihmZCwgRUxGX0Nf
UkVBRCwgTlVMTCk7DQo+ICsJaWYgKCFlbGYpIHsNCj4gKwkJcF9lcnIoImZhaWxlZCB0byBvcGVu
ICVzIGFzIEVMRiBmaWxlIiwgcGF0aCk7DQo+ICsJCWdvdG8gZG9uZTsNCj4gKwl9DQo+ICsJaWYg
KCFnZWxmX2dldGVoZHIoZWxmLCAmZWhkcikpIHsNCj4gKwkJcF9lcnIoImZhaWxlZCB0byBnZXQg
RUhEUiBmcm9tICVzIiwgcGF0aCk7DQo+ICsJCWdvdG8gZG9uZTsNCj4gKwl9DQo+ICsJaWYgKCFj
aGVja19idGZfZW5kaWFubmVzcygmZWhkcikpIHsNCj4gKwkJcF9lcnIoIm5vbi1uYXRpdmUgRUxG
IGVuZGlhbm5lc3MgaXMgbm90IHN1cHBvcnRlZCIpOw0KDQpXZSBzaG91bGQgcmVsZXggdGhpcy4g
SXQgaXMgcG9zc2libGUgdGhhdCBmb3Igc29tZSBlbWJlZGRlZCBzeXN0ZW0sIA0KYnBmdG9vbCBp
cyBydW5uaW5nIG9uIHNvbWUgeDg2IHNlcnZlciBleGFtaW5pbmcgYSBvYmpmaWxlIGZpbGUgdXNl
ZA0KZm9yIGFuIGVtYmVkZGVkIHN5c3RlbS4NCg0KPiArCQlnb3RvIGRvbmU7DQo+ICsJfQ0KPiAr
CWlmICghZWxmX3Jhd2RhdGEoZWxmX2dldHNjbihlbGYsIGVoZHIuZV9zaHN0cm5keCksIE5VTEwp
KSB7DQo+ICsJCXBfZXJyKCJmYWlsZWQgdG8gZ2V0IGVfc2hzdHJuZHggZnJvbSAlc1xuIiwgcGF0
aCk7DQo+ICsJCWdvdG8gZG9uZTsNCj4gKwl9DQo+ICsNCj4gKwl3aGlsZSAoKHNjbiA9IGVsZl9u
ZXh0c2NuKGVsZiwgc2NuKSkgIT0gTlVMTCkgew0KPiArCQlHRWxmX1NoZHIgc2g7DQo+ICsJCWNo
YXIgKm5hbWU7DQo+ICsNCj4gKwkJaWR4Kys7DQo+ICsJCWlmIChnZWxmX2dldHNoZHIoc2NuLCAm
c2gpICE9ICZzaCkgew0KPiArCQkJcF9lcnIoImZhaWxlZCB0byBnZXQgc2VjdGlvbiglZCkgaGVh
ZGVyIGZyb20gJXMiLA0KPiArCQkJICAgICAgaWR4LCBwYXRoKTsNCj4gKwkJCWdvdG8gZG9uZTsN
Cj4gKwkJfQ0KPiArCQluYW1lID0gZWxmX3N0cnB0cihlbGYsIGVoZHIuZV9zaHN0cm5keCwgc2gu
c2hfbmFtZSk7DQo+ICsJCWlmICghbmFtZSkgew0KPiArCQkJcF9lcnIoImZhaWxlZCB0byBnZXQg
c2VjdGlvbiglZCkgbmFtZSBmcm9tICVzIiwNCj4gKwkJCSAgICAgIGlkeCwgcGF0aCk7DQo+ICsJ
CQlnb3RvIGRvbmU7DQo+ICsJCX0NCj4gKwkJaWYgKHN0cmNtcChuYW1lLCBCVEZfRUxGX1NFQykg
PT0gMCkgew0KPiArCQkJYnRmX2RhdGEgPSBlbGZfZ2V0ZGF0YShzY24sIDApOw0KPiArCQkJaWYg
KCFidGZfZGF0YSkgew0KPiArCQkJCXBfZXJyKCJmYWlsZWQgdG8gZ2V0IHNlY3Rpb24oJWQsICVz
KSBkYXRhIGZyb20gJXMiLA0KPiArCQkJCSAgICAgIGlkeCwgbmFtZSwgcGF0aCk7DQo+ICsJCQkJ
Z290byBkb25lOw0KPiArCQkJfQ0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4g
KwlpZiAoIWJ0Zl9kYXRhKSB7DQo+ICsJCXBfZXJyKCIlcyBFTEYgc2VjdGlvbiBub3QgZm91bmQg
aW4gJXMiLCBCVEZfRUxGX1NFQywgcGF0aCk7DQo+ICsJCWdvdG8gZG9uZTsNCj4gKwl9DQo+ICsN
Cj4gKwkqYnRmID0gYnRmX19uZXcoYnRmX2RhdGEtPmRfYnVmLCBidGZfZGF0YS0+ZF9zaXplKTsN
Cj4gKwlpZiAoSVNfRVJSKCpidGYpKSB7DQo+ICsJCWVyciA9IFBUUl9FUlIoKmJ0Zik7DQo+ICsJ
CSpidGYgPSBOVUxMOw0KPiArCQlwX2VycigiZmFpbGVkIHRvIGxvYWQgQlRGIGRhdGEgZnJvbSAl
czogJXMiLA0KPiArCQkgICAgICBwYXRoLCBzdHJlcnJvcihlcnIpKTsNCj4gKwkJZ290byBkb25l
Ow0KPiArCX0NCj4gKw0KPiArCWVyciA9IDA7DQo+ICtkb25lOg0KPiArCWlmIChlcnIpIHsNCj4g
KwkJaWYgKCpidGYpIHsNCj4gKwkJCWJ0Zl9fZnJlZSgqYnRmKTsNCj4gKwkJCSpidGYgPSBOVUxM
Ow0KPiArCQl9DQo+ICsJfQ0KPiArCWlmIChlbGYpDQo+ICsJCWVsZl9lbmQoZWxmKTsNCj4gKwlj
bG9zZShmZCk7DQo+ICsJcmV0dXJuIGVycjsNCj4gK30NCj4gKw0KWy4uLl0NCj4gK30NCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL2JwZi9icGZ0b29sL21haW4uYyBiL3Rvb2xzL2JwZi9icGZ0b29sL21h
aW4uYw0KPiBpbmRleCBhOWQ1ZTllNmE3MzIuLmViYTU2ZWRkN2M3NyAxMDA2NDQNCj4gLS0tIGEv
dG9vbHMvYnBmL2JwZnRvb2wvbWFpbi5jDQo+ICsrKyBiL3Rvb2xzL2JwZi9icGZ0b29sL21haW4u
Yw0KPiBAQCAtMTg4LDYgKzE4OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY21kIGNtZHNbXSA9
IHsNCj4gICAJeyAicGVyZiIsCWRvX3BlcmYgfSwNCj4gICAJeyAibmV0IiwJZG9fbmV0IH0sDQo+
ICAgCXsgImZlYXR1cmUiLAlkb19mZWF0dXJlIH0sDQo+ICsJeyAiYnRmIiwJZG9fYnRmIH0sDQo+
ICAgCXsgInZlcnNpb24iLAlkb192ZXJzaW9uIH0sDQo+ICAgCXsgMCB9DQo+ICAgfTsNCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL2JwZi9icGZ0b29sL21haW4uaCBiL3Rvb2xzL2JwZi9icGZ0b29sL21h
aW4uaA0KPiBpbmRleCAxY2NjNDYxNjlhMTkuLjNkNjNmZWI3Zjg1MiAxMDA2NDQNCj4gLS0tIGEv
dG9vbHMvYnBmL2JwZnRvb2wvbWFpbi5oDQo+ICsrKyBiL3Rvb2xzL2JwZi9icGZ0b29sL21haW4u
aA0KPiBAQCAtMTUwLDYgKzE1MCw3IEBAIGludCBkb19wZXJmKGludCBhcmdjLCBjaGFyICoqYXJn
KTsNCj4gICBpbnQgZG9fbmV0KGludCBhcmdjLCBjaGFyICoqYXJnKTsNCj4gICBpbnQgZG9fdHJh
Y2Vsb2coaW50IGFyZ2MsIGNoYXIgKiphcmcpOw0KPiAgIGludCBkb19mZWF0dXJlKGludCBhcmdj
LCBjaGFyICoqYXJndik7DQo+ICtpbnQgZG9fYnRmKGludCBhcmdjLCBjaGFyICoqYXJndik7DQo+
ICAgDQo+ICAgaW50IHBhcnNlX3UzMl9hcmcoaW50ICphcmdjLCBjaGFyICoqKmFyZ3YsIF9fdTMy
ICp2YWwsIGNvbnN0IGNoYXIgKndoYXQpOw0KPiAgIGludCBwcm9nX3BhcnNlX2ZkKGludCAqYXJn
YywgY2hhciAqKiphcmd2KTsNCj4gDQo=
