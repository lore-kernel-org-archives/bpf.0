Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F481C10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB85218C3
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HhR0XPDJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AiUvZueu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbfB1STu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:19:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbfB1STu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 13:19:50 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SICjB0003922;
        Thu, 28 Feb 2019 10:19:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=G766Aw8MJxPvfCQdfHRqS3CCpK/TQF5lxNKgQSL8NbY=;
 b=HhR0XPDJlZGNPtnpKlg1jubFkTyt9XbZIe1OKDbUDKJW8gWCmcYv6oZAa5TTuyF/SbVk
 xRNqG9OYsmu6yc0n6oXEebL50DqwbpmxF5XGZHzcHWewx9R8q+QePIaR4Cpsm0DH9+bX
 y5Nk1UgBwaDfBZaUw/SsAbqoQN43LGF6QWI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxjqt8j4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 10:19:27 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 10:19:26 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 10:19:26 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 28 Feb 2019 10:19:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G766Aw8MJxPvfCQdfHRqS3CCpK/TQF5lxNKgQSL8NbY=;
 b=AiUvZueu41hpzJAmls5iuSm1Vq6/NnZUV1oPJQnLmlfVa+D/rq3IgyVv2YCr7kLy5W4HjjBSEIzJsf4KJj66HiU/Fsbogy3ffF6OkNl4nVz0HCnGp82AJja4AlE0M8XrIgmu1as2rtOuZi8i/6Yeug2yzHF6g12t32gWm8S4T5o=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2918.namprd15.prod.outlook.com (20.178.236.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 18:19:24 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 18:19:24 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "Alexei Starovoitov" <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: fix btf_dedup testing code
Thread-Topic: [PATCH bpf-next 1/5] selftests/bpf: fix btf_dedup testing code
Thread-Index: AQHUzu6HObzxqJSy0E6ARu/SXWTSJqX1hmyA
Date:   Thu, 28 Feb 2019 18:19:24 +0000
Message-ID: <44ac0073-0414-5e06-17c8-8568e3b3107e@fb.com>
References: <20190227224642.1069138-1-andriin@fb.com>
 <20190227224642.1069138-2-andriin@fb.com>
In-Reply-To: <20190227224642.1069138-2-andriin@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:907:1::22) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:e2ab]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21fa0682-6b15-4855-cb2f-08d69da94454
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2918;
x-ms-traffictypediagnostic: BYAPR15MB2918:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2918;20:z5QV+rSW+h/i7b68AmgxueQZ9FurQPJCHJLXVXoq59w5cqV6IH7Yk9iU9R9h6fTWacVa1ETK7goE3Q3luVOTiaRK/bIT87Xc82aNMiaqU8A4m1eTqmHEiZXhKgSegHhILu5lSAMdzA/GHlS9JOgQkh/DiO9ya4oU/rIA6wwk/jk=
x-microsoft-antispam-prvs: <BYAPR15MB29189D93EADEE6AC851CD3C2D3750@BYAPR15MB2918.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(14444005)(6436002)(2906002)(71200400001)(86362001)(8676002)(31686004)(71190400001)(386003)(14454004)(478600001)(5660300002)(229853002)(6512007)(81156014)(316002)(8936002)(31696002)(6116002)(105586002)(110136005)(2201001)(6486002)(7736002)(106356001)(256004)(97736004)(52116002)(486006)(99286004)(186003)(446003)(2616005)(476003)(11346002)(81166006)(6246003)(25786009)(305945005)(53936002)(2501003)(76176011)(46003)(36756003)(68736007)(53546011)(6506007)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2918;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KUN+h7LmUNwOBuXPWHom6RjPpE4K/Pbbj5DsZS/KKpqua3g0ccjyU8xzMaIdl8DqlBCXwGMMUC2c2usvmM+DOVqE1sosr71iUYjToJdr3tEz9D+pbaEoCLVVb2piKuggF3ndgXSbszYFRWYe6eMQ6oRT67VDZHiAGT4RFHbDpbyHg54pVaH9W0RCOSCx1w47sJ7TBis9CRCgZA61AmAEnPtMhqtWYQnDGdPZSBsFvUOpi9VbarTULyljh6DeSOGw18UIkI8n8ZN1Q9+6pMGvNkuRMoK3SHM4yZWGU282/fI0K3MCi8MKfPztjKPHIS34hKZlHsnpXxWE9ZbQHrrujQ+0sU2NBBiOHCzhKXO/pdQAzenpEFtgAmVJ7jhFW7WBstKR9EugwuBM/Md5D/51+tNVzzAHeqBgo1XB6OWKq1I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4D227A10179EE4798553551A5E55373@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fa0682-6b15-4855-cb2f-08d69da94454
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 18:19:24.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2918
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjcvMTkgMjo0NiBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBidGZfZGVk
dXAgdGVzdGluZyBjb2RlIGRvZXNuJ3QgYWNjb3VudCBmb3IgbGVuZ3RoIG9mIHN0cnVjdCBidGZf
aGVhZGVyDQo+IHdoZW4gY2FsY3VsYXRpbmcgdGhlIHN0YXJ0IG9mIGEgc3RyaW5nIHNlY3Rpb24u
IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcw0KPiBwcm9ibGVtLg0KPiANCj4gRml4ZXM6IDQ5YjU3ZTBk
MDFkYiAoInRvb2xzL2JwZjogcmVtb3ZlIGJ0Zl9fZ2V0X3N0cmluZ3MoKSBzdXBlcnNlZGVkIGJ5
IHJhdyBkYXRhIEFQSSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlp
bkBmYi5jb20+DQoNCkFja2VkLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPg0KZm9yIFBh
dGNoICMxIC0gIzMuDQoNCj4gLS0tDQo+ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmLy5n
aXRpZ25vcmUgfCAxICsNCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9idGYu
YyB8IDQgKystLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi8u
Z2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmLy5naXRpZ25vcmUNCj4gaW5k
ZXggZTQ3MTY4ZDEyNTdkLi4zYjc0ZDIzZmZmYWIgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi8uZ2l0aWdub3JlDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi8uZ2l0aWdub3JlDQo+IEBAIC0xNCw2ICsxNCw3IEBAIGZlYXR1cmUNCj4gICB0ZXN0
X2xpYmJwZl9vcGVuDQo+ICAgdGVzdF9zb2NrDQo+ICAgdGVzdF9zb2NrX2FkZHINCj4gK3Rlc3Rf
c29ja19maWVsZHMNCj4gICB1cmFuZG9tX3JlYWQNCj4gICB0ZXN0X2J0Zg0KPiAgIHRlc3Rfc29j
a21hcA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfYnRm
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9idGYuYw0KPiBpbmRleCAwMmQz
MTQzODNhOWMuLjE0MjZjMGE5MDVjOCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL3Rlc3RfYnRmLmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBm
L3Rlc3RfYnRmLmMNCj4gQEAgLTU5MzYsOSArNTkzNiw5IEBAIHN0YXRpYyBpbnQgZG9fdGVzdF9k
ZWR1cCh1bnNpZ25lZCBpbnQgdGVzdF9udW0pDQo+ICAgCX0NCj4gICANCj4gICAJdGVzdF9oZHIg
PSB0ZXN0X2J0Zl9kYXRhOw0KPiAtCXRlc3Rfc3RycyA9IHRlc3RfYnRmX2RhdGEgKyB0ZXN0X2hk
ci0+c3RyX29mZjsNCj4gKwl0ZXN0X3N0cnMgPSB0ZXN0X2J0Zl9kYXRhICsgc2l6ZW9mKCp0ZXN0
X2hkcikgKyB0ZXN0X2hkci0+c3RyX29mZjsNCj4gICAJZXhwZWN0X2hkciA9IGV4cGVjdF9idGZf
ZGF0YTsNCj4gLQlleHBlY3Rfc3RycyA9IGV4cGVjdF9idGZfZGF0YSArIGV4cGVjdF9oZHItPnN0
cl9vZmY7DQo+ICsJZXhwZWN0X3N0cnMgPSBleHBlY3RfYnRmX2RhdGEgKyBzaXplb2YoKnRlc3Rf
aGRyKSArIGV4cGVjdF9oZHItPnN0cl9vZmY7DQo+ICAgCWlmIChDSEVDSyh0ZXN0X2hkci0+c3Ry
X2xlbiAhPSBleHBlY3RfaGRyLT5zdHJfbGVuLA0KPiAgIAkJICAidGVzdF9oZHItPnN0cl9sZW46
JXUgIT0gZXhwZWN0X2hkci0+c3RyX2xlbjoldSIsDQo+ICAgCQkgIHRlc3RfaGRyLT5zdHJfbGVu
LCBleHBlY3RfaGRyLT5zdHJfbGVuKSkgew0KPiANCg==
