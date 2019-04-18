Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871E1C10F0B
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 04:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A36220643
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 04:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SpO0B++6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BVB0W7lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfDREeR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:34:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53532 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725710AbfDREeQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Apr 2019 00:34:16 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3I4Vu7P002670;
        Wed, 17 Apr 2019 21:33:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wl90SChen2MUbyPggwnLm4eKQtgUude3gBW/D2k/boo=;
 b=SpO0B++6T9UaF8ZXg4hsBw9OOjDo/E2j2StQY9IxkSiV98oELncTb3JrbiYz1f5NLzru
 A/2lx90vXBpeeg4JLSNh1zyDvver5LGis7AIElwMk9jcTgCOQa274NGUlD/QqoqMH6Z8
 Uz/6u6OaeeMHAoJk9YcMNVnOaMeNDw858rk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2rwm8mdtme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Apr 2019 21:33:52 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 21:33:51 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Apr 2019 21:33:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl90SChen2MUbyPggwnLm4eKQtgUude3gBW/D2k/boo=;
 b=BVB0W7lhsI/JmsILzyJuhIs3Q/gtIZA7O9kKQk9Oi16yTlvlh79I2Md2+ll/VRPomd+oVqJl6bvk2rFwWsQXGVGcE7rhAzzQtbjE5IWGVFzzzIDVMuYW1XQIgAseFaCK8hw278sulEGgD7JcO1KWNGad+CzwrizOrG2E5qywOmA=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2422.namprd15.prod.outlook.com (52.135.198.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Thu, 18 Apr 2019 04:33:50 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 04:33:50 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: document the verifier limits
Thread-Topic: [PATCH bpf-next] bpf: document the verifier limits
Thread-Index: AQHU9YXh8AUN/lSMckCE1qh1sryey6ZBVLoA
Date:   Thu, 18 Apr 2019 04:33:50 +0000
Message-ID: <36270681-17f7-1c13-9d9a-7b90973cfcba@fb.com>
References: <20190418012701.2965338-1-ast@kernel.org>
In-Reply-To: <20190418012701.2965338-1-ast@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0054.namprd08.prod.outlook.com
 (2603:10b6:a03:117::31) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::c88a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b49e89e8-dec7-4458-d5f5-08d6c3b70dda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2422;
x-ms-traffictypediagnostic: BYAPR15MB2422:
x-microsoft-antispam-prvs: <BYAPR15MB2422F30C9FE9749FC9B8428BD3260@BYAPR15MB2422.namprd15.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(189003)(316002)(76176011)(53546011)(46003)(97736004)(99286004)(102836004)(305945005)(6486002)(186003)(31696002)(386003)(446003)(36756003)(5660300002)(110136005)(229853002)(86362001)(7736002)(6506007)(25786009)(54906003)(6246003)(6512007)(11346002)(256004)(81166006)(6436002)(71200400001)(4326008)(2616005)(476003)(478600001)(2906002)(486006)(53936002)(31686004)(6116002)(2501003)(52116002)(81156014)(14454004)(8676002)(14444005)(68736007)(71190400001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2422;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mi1Wm9PdF58idwKPR8LEvmTekeNbyfkbw6gb1OV9jJXSRu1I1ZzsoJThiTLTgyYHSC6uhsXd/d6bPFycDt8xwQjm4vWMkzZW0oEh1aUhSNwXgdGzi3jSFu+1blb0CsAn84OMa96qAelzO9fQo54jv6xQ8QE7W2o8hunAIWxw2a87SEvpFdW7rAvPOCKA/fxXNWTWJjSBiPX1CYttE37Y88+1ktyUXaS/KnKSUao92KCQEkBPiqd/xA2nI0MWfFUcwnjzX65G6nwyyo8C9imLS/8JNT1R8rdBPoH0c39e/k9R8NF9QjoSkO01KIIixM8hQ2PZ4a/S6W3h9pxAf0nKd+J7we1Wi41YmkSZxw+vZuqjXIVqemgxqKzy7hA5/N0gOYRXDrm6Oda7K2heVVh/9YxXZisRtdneV50hE3jKFo8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F96F3CCFF12F94688B72AA722373DB5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b49e89e8-dec7-4458-d5f5-08d6c3b70dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 04:33:50.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2422
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMTcvMTkgNjoyNyBQTSwgQWxleGVpIFN0YXJvdm9pdG92IHdyb3RlOg0KPiBEb2N1
bWVudCB0aGUgdmVyaWZpZXIgbGltaXRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGVpIFN0
YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz4NCg0KQWNrZWQtYnk6IFlvbmdob25nIFNvbmcgPHlo
c0BmYi5jb20+DQoNCj4gLS0tDQo+ICAgRG9jdW1lbnRhdGlvbi9icGYvYnBmX2Rlc2lnbl9RQS5y
c3QgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vYnBmL2JwZl9kZXNpZ25fUUEucnN0IGIvRG9jdW1lbnRhdGlvbi9icGYvYnBm
X2Rlc2lnbl9RQS5yc3QNCj4gaW5kZXggMTA0NTNjNjI3MTM1Li5jYjQwMmM1OWVjYTUgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL2JwZl9kZXNpZ25fUUEucnN0DQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vYnBmL2JwZl9kZXNpZ25fUUEucnN0DQo+IEBAIC04NSw4ICs4NSwzMyBAQCBR
OiBDYW4gbG9vcHMgYmUgc3VwcG9ydGVkIGluIGEgc2FmZSB3YXk/DQo+ICAgQTogSXQncyBub3Qg
Y2xlYXIgeWV0Lg0KPiAgIA0KPiAgIEJQRiBkZXZlbG9wZXJzIGFyZSB0cnlpbmcgdG8gZmluZCBh
IHdheSB0bw0KPiAtc3VwcG9ydCBib3VuZGVkIGxvb3BzIHdoZXJlIHRoZSB2ZXJpZmllciBjYW4g
Z3VhcmFudGVlIHRoYXQNCj4gLXRoZSBwcm9ncmFtIHRlcm1pbmF0ZXMgaW4gbGVzcyB0aGFuIDQw
OTYgaW5zdHJ1Y3Rpb25zLg0KPiArc3VwcG9ydCBib3VuZGVkIGxvb3BzLg0KPiArDQo+ICtROiBX
aGF0IGFyZSB0aGUgdmVyaWZpZXIgbGltaXRzPw0KPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gK0E6IFRoZSBvbmx5IGxpbWl0IGtub3duIHRvIHRoZSB1c2VyIHNwYWNlIGlz
IEJQRl9NQVhJTlNOUyAoNDA5NikuDQo+ICtJdCdzIHRoZSBtYXhpbXVtIG51bWJlciBvZiBpbnN0
cnVjdGlvbnMgdGhhdCB0aGUgdW5wcml2aWxlZ2VkIGJwZg0KPiArcHJvZ3JhbSBjYW4gaGF2ZS4g
VGhlIHZlcmlmaWVyIGhhcyB2YXJpb3VzIGludGVybmFsIGxpbWl0cy4NCj4gK0xpa2UgdGhlIG1h
eGltdW0gbnVtYmVyIG9mIGluc3RydWN0aW9ucyB0aGF0IGNhbiBiZSBleHBsb3JlZCBkdXJpbmcN
Cj4gK3Byb2dyYW0gYW5hbHlzaXMuIEN1cnJlbnRseSwgdGhhdCBsaW1pdCBpcyBzZXQgdG8gMSBt
aWxsaW9uLg0KPiArV2hpY2ggZXNzZW50aWFsbHkgbWVhbnMgdGhhdCB0aGUgbGFyZ2VzdCBwcm9n
cmFtIGNhbiBjb25zaXN0DQo+ICtvZiAxIG1pbGxpb24gTk9QIGluc3RydWN0aW9ucy4gVGhlcmUg
aXMgYSBsaW1pdCB0byB0aGUgbWF4aW11bSBudW1iZXINCj4gK29mIHN1YnNlcXVlbnQgYnJhbmNo
ZXMsIGEgbGltaXQgdG8gdGhlIG51bWJlciBvZiBuZXN0ZWQgYnBmLXRvLWJwZg0KPiArY2FsbHMs
IGEgbGltaXQgdG8gdGhlIG51bWJlciBvZiB0aGUgdmVyaWZpZXIgc3RhdGVzIHBlciBpbnN0cnVj
dGlvbiwNCj4gK2EgbGltaXQgdG8gdGhlIG51bWJlciBvZiBtYXBzIHVzZWQgYnkgdGhlIHByb2dy
YW0uDQo+ICtBbGwgdGhlc2UgbGltaXRzIGNhbiBiZSBoaXQgd2l0aCBhIHN1ZmZpY2llbnRseSBj
b21wbGV4IHByb2dyYW0uDQo+ICtUaGVyZSBhcmUgYWxzbyBub24tbnVtZXJpY2FsIGxpbWl0cyB0
aGF0IGNhbiBjYXVzZSB0aGUgcHJvZ3JhbQ0KPiArdG8gYmUgcmVqZWN0ZWQuIFRoZSB2ZXJpZmll
ciB1c2VkIHRvIHJlY29nbml6ZSBvbmx5IHBvaW50ZXIgKyBjb25zdGFudA0KPiArZXhwcmVzc2lv
bnMuIE5vdyBpdCBjYW4gcmVjb2duaXplIHBvaW50ZXIgKyBib3VuZGVkX3JlZ2lzdGVyLg0KPiAr
YnBmX2xvb2t1cF9tYXBfZWxlbShrZXkpIGhhZCBhIHJlcXVpcmVtZW50IHRoYXQgJ2tleScgbXVz
dCBiZQ0KPiArYSBwb2ludGVyIHRvIHRoZSBzdGFjay4gTm93LCAna2V5JyBjYW4gYmUgYSBwb2lu
dGVyIHRvIG1hcCB2YWx1ZS4NCj4gK1RoZSB2ZXJpZmllciBpcyBzdGVhZGlseSBnZXR0aW5nICdz
bWFydGVyJy4gVGhlIGxpbWl0cyBhcmUNCj4gK2JlaW5nIHJlbW92ZWQuIFRoZSBvbmx5IHdheSB0
byBrbm93IHRoYXQgdGhlIHByb2dyYW0gaXMgZ29pbmcgdG8NCj4gK2JlIGFjY2VwdGVkIGJ5IHRo
ZSB2ZXJpZmllciBpcyB0byB0cnkgdG8gbG9hZCBpdC4NCj4gK1RoZSBicGYgZGV2ZWxvcG1lbnQg
cHJvY2VzcyBndWFyYW50ZWVzIHRoYXQgdGhlIGZ1dHVyZSBrZXJuZWwNCj4gK3ZlcnNpb25zIHdp
bGwgYWNjZXB0IGFsbCBicGYgcHJvZ3JhbXMgdGhhdCB3ZXJlIGFjY2VwdGVkIGJ5DQo+ICt0aGUg
ZWFybGllciB2ZXJzaW9ucy4NCj4gKw0KPiAgIA0KPiAgIEluc3RydWN0aW9uIGxldmVsIHF1ZXN0
aW9ucw0KPiAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCg==
