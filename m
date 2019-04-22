Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AB4C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893ED214AF
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V3tr0IDO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dvWyU0yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfDVQ5h (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:57:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39036 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfDVQ5g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Apr 2019 12:57:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MGn3Ek025541;
        Mon, 22 Apr 2019 09:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IQkkbHWNYOooFuAfWo+JDighgkJ4szhZc97W9J55SDM=;
 b=V3tr0IDOqwsBs6+Y0yuk7mDKWrrQ+XsqWdX1yUVLu/YAA5v9nDN1+yaWkOCru5orbwrK
 vXUmg1Fx8QAQ9CDTof2a311LqTSWpXM+Uag7wXRQt9DpNZW8tb37Zw2Rz2hXRMXsKRqn
 NmpKk/B8puDla7cEjC7berhezrHbYqFFdmU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s00xdpxew-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 09:57:13 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 09:57:10 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 09:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQkkbHWNYOooFuAfWo+JDighgkJ4szhZc97W9J55SDM=;
 b=dvWyU0ykmUCPZAs84gg81GO6z0YQ5l23N6sQdUCH02gOqAaqS2LRsaeXrtwnbnOheNMZhR0XvpqZLjNAddMG59rOOZxwcQweKqakHtAukON1Q3xLM8wCd2O1dEWp9TKe7KWQywMgngmTMaNFdHlkO7V8zM1AvGUynJmdj6Nkt5k=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2294.namprd15.prod.outlook.com (52.135.197.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Mon, 22 Apr 2019 16:57:08 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 16:57:08 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Xiao Han <xiao.han@orange.com>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf 0/2] bpf: mark registers as safe or unknown in all
 frames
Thread-Topic: [PATCH bpf 0/2] bpf: mark registers as safe or unknown in all
 frames
Thread-Index: AQHU93X+hmTsthcbZEOdkDzBcg66IKZIadwA
Date:   Mon, 22 Apr 2019 16:57:08 +0000
Message-ID: <83ac6441-526c-94bd-c818-3316809f25c3@fb.com>
References: <cover.1555761008.git.paul.chaignon@orange.com>
In-Reply-To: <cover.1555761008.git.paul.chaignon@orange.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0052.namprd15.prod.outlook.com (10.175.176.20) To
 BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:70ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c94d7cf-d9f3-4bd2-9df7-08d6c7438e2d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2294;
x-ms-traffictypediagnostic: BYAPR15MB2294:
x-microsoft-antispam-prvs: <BYAPR15MB2294022351BC17762FF937A8D3220@BYAPR15MB2294.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(54906003)(4326008)(2501003)(71200400001)(71190400001)(186003)(11346002)(36756003)(110136005)(66946007)(73956011)(66556008)(66446008)(64756008)(2616005)(229853002)(6506007)(386003)(256004)(86362001)(25786009)(6116002)(31696002)(66476007)(446003)(2906002)(2201001)(102836004)(53546011)(14454004)(46003)(81166006)(8676002)(5660300002)(486006)(6436002)(81156014)(31686004)(53936002)(7736002)(478600001)(476003)(99286004)(8936002)(6486002)(97736004)(76176011)(52116002)(68736007)(316002)(6512007)(6246003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2294;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OQAatebsMVFz5K5UMtnbfyLjejPzVDpabBKqHk+6mBz5bqY7JGSiuIWL9uPyDSSjozqTkUa5kAmLVCu01NIkM37OlETQ+s+PxUqwyyt0lK85Zv4qzlNltUVR8mTARzQ6+9uPDytesKoS0zSnFq6jDK4vDDoc8dt2PD5DG6MYoi5VqgdDuu7LS1PDkc1bGhI2O7XXJcOl5O24TR/5LYQFrdkZD0TR9WwOz5quxHYKQ7X1ZyMWGSqDqB9KOnT4lO7ty99liQySTfIy6LUYuPyG1ZR1jL9aBYM/Cx5qL9EWYpjd37qSU19dFi4IgjRQA3DDuPNn79I0nA3xT27SOzmnMq5XAlkTBXn8Ik3i+dGRZ6rHj7XjpJ0+s3D8xQZxrsBoIitBLxx8rQaW2Cv/A4oMuyUDKcrvsYEynNQb0ymxV/4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD8BCC1C34EA024AB3E2F727324A8BF7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c94d7cf-d9f3-4bd2-9df7-08d6c7438e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 16:57:08.4986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2294
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjAvMTkgNTozOCBBTSwgUGF1bCBDaGFpZ25vbiB3cm90ZToNCj4gSW4gY2FzZSBv
ZiBhIG51bGwgY2hlY2sgb24gYSBwb2ludGVyIGluc2lkZSBhIHN1YnByb2csIHdlIHNob3VsZCBt
YXJrIGFsbA0KPiByZWdpc3RlcnMgd2l0aCB0aGlzIHBvaW50ZXIgYXMgZWl0aGVyIHNhZmUgb3Ig
dW5rbm93biwgaW4gYm90aCB0aGUgY3VycmVudA0KPiBhbmQgcHJldmlvdXMgZnJhbWVzLiAgQ3Vy
cmVudGx5LCBvbmx5IHNwaWxsZWQgcmVnaXN0ZXJzIGFuZCByZWdpc3RlcnMgaW4NCj4gdGhlIGN1
cnJlbnQgZnJhbWUgYXJlIG1hcmtlZC4gIFRoaXMgZmlyc3QgcGF0Y2ggYWxzbyBtYXJrcyByZWdp
c3RlcnMgaW4NCj4gcHJldmlvdXMgZnJhbWVzLg0KPiANCj4gQSBnb29kIHJlcHJvZHVjZXIgbG9v
a3MgYXMgZm9sbG93Og0KPiANCj4gMTogcHRyID0gYnBmX21hcF9sb29rdXBfZWxlbShtYXAsICZr
ZXkpOw0KPiAyOiByZXQgPSBzdWJwcm9nKHB0cikgew0KPiAzOiAgIHJldHVybiBwdHIgIT0gTlVM
TDsNCj4gNDogfQ0KPiA1OiBpZiAocmV0KQ0KPiA2OiAgIHZhbHVlID0gKnB0cjsNCj4gDQo+IFdp
dGggdGhlIGFib3ZlLCB0aGUgdmVyaWZpZXIgd2lsbCBjb21wbGFpbiBvbiBsaW5lIDYgYmVjYXVz
ZSBpdCBzZWVzIHB0cg0KPiBhcyBtYXBfdmFsdWVfb3JfbnVsbCBkZXNwaXRlIHRoZSBudWxsIGNo
ZWNrIGluIHN1YnByb2cgMS4gIFRoZSBzZWNvbmQNCj4gcGF0Y2ggaW1wbGVtZW50cyB0aGUgYWJv
dmUgYXMgYSBuZXcgdGVzdCBjYXNlLg0KPiANCj4gTm90ZSB0aGF0IHRoaXMgcGF0Y2ggZml4ZXMg
YW5vdGhlciByZXN1bHRpbmcgYnVnIHdoZW4gdXNpbmcNCj4gYnBmX3NrX3JlbGVhc2UoKToNCj4g
DQo+IDE6IHNrID0gYnBmX3NrX2xvb2t1cF90Y3AoKTsNCj4gMjogc3VicHJvZyhzaykgew0KPiAz
OiAgIGlmIChzaykNCj4gNDogICAgIGJwZl9za19yZWxlYXNlKHNrLCAwKTsNCg0KVGhlIHNwZWNp
ZmljYXRpb24gZm9yIGJwZl9za19yZWxlYXNlKCkgaW4gdWFwaS9saW51eC9icGYuaCBpczoNCiAg
aW50IGJwZl9za19yZWxlYXNlKHN0cnVjdCBicGZfc29jayAqc29jaykNCg0KRG8geW91IGV4cGxh
aW4gd2hhdCBpcyBicGZfc2tfcmVsZWFzZShzaywgMCk/DQoNCj4gNTogfQ0KPiA2OiBpZiAoIXNr
KQ0KPiA3OiAgIHJldHVybiAwOw0KPiA4OiByZXR1cm4gc2s7DQoNCklmIHNrIGhhcyBiZWVuIHJl
bGVhc2VkLCB0aGUgcHJvZ3JhbSBzaG91bGQgbm90IHJlYWxseSByZXR1cm4gc2ssIHJpZ2h0Pw0K
DQo+IA0KPiBJbiB0aGUgYWJvdmUsIG1hcmtfcHRyX29yX251bGxfcmVncyB3aWxsIHdhcm4gb24g
bGluZSA2IGJlY2F1c2UgaXQgd2lsbA0KPiB0cnkgdG8gZnJlZSB0aGUgcmVmZXJlbmNlIHN0YXRl
LCBldmVuIHRob3VnaCBpdCB3YXMgYWxyZWFkeSBmcmVlZCBvbg0KPiBsaW5lIDMuDQo+IA0KPiBQ
YXVsIENoYWlnbm9uICgyKToNCj4gICAgYnBmOiBtYXJrIHJlZ2lzdGVycyBhcyBzYWZlIG9yIHVu
a25vd24gaW4gYWxsIGZyYW1lcw0KPiAgICBzZWxmdGVzdHMvYnBmOiB0ZXN0IGNhc2UgZm9yIHBv
aW50ZXIgbnVsbCBjaGVjayBpbiBzdWJwcm9nDQo+IA0KPiAgIGtlcm5lbC9icGYvdmVyaWZpZXIu
YyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKystLS0NCj4gICB0b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9icGYvdmVyaWZpZXIvY2FsbHMuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAN
Cg==
