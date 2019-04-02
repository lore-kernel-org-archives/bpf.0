Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E003AC43381
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 02:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F3620830
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 02:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IaRwSdP3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ur/2y+Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDBCIk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:08:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfDBCIk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Apr 2019 22:08:40 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3228Dqv020815;
        Mon, 1 Apr 2019 19:08:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ILMBu6OSrc42H8qUrybDpgJXvsh4n6UU7QiRMf5wz3w=;
 b=IaRwSdP3blTQH99TRAGDiImwuqFPQHiy6yXVgEvv+a2ritvheCiRhlTXeeqX+bPthmXz
 5SQtLsFcnsqIzMSrke607wI7qVWjZ8X1iLhYsNpJWCuuYSD+BuWY1njMo/92kBavbCKf
 taqsdwHAdn4yKeKyrj12Y5KEVvtVtGV8geY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rkv0r0fyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Apr 2019 19:08:13 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 1 Apr 2019 19:08:13 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 1 Apr 2019 19:08:12 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 1 Apr 2019 19:08:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILMBu6OSrc42H8qUrybDpgJXvsh4n6UU7QiRMf5wz3w=;
 b=Ur/2y+Oy1Yuroz/wd/qyhpupzPO5koInWTP2YXpnXWwOg8Vd4VuE5CPnhgMXCEocHu70nqFt/xS9NmMUae+/muR7x+mliXflSpiptHuP2HmZLX4mDMs/RluvchWom/j4VVaQvHW6EHw3f+3V0zajA4/EFyeeuXgU6jBgV9+1D4E=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB3462.namprd15.prod.outlook.com (20.179.60.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 02:08:09 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::fcb2:5ce:1804:28fd]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::fcb2:5ce:1804:28fd%4]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 02:08:09 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "jannh@google.com" <jannh@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: add few verifier scale tests
Thread-Topic: [PATCH bpf-next 7/7] selftests/bpf: add few verifier scale tests
Thread-Index: AQHU5o3v1+EsT8KZqkG8DkQf9yNQbKYnXkmAgAAmjYCAAJ/gAA==
Date:   Tue, 2 Apr 2019 02:08:09 +0000
Message-ID: <b42e4d7f-a049-7487-98f7-4db901169ca3@fb.com>
References: <20190330001612.2354959-1-ast@kernel.org>
 <20190330001612.2354959-8-ast@kernel.org>
 <319e168a-6571-9a70-336a-6ecf8b61f040@iogearbox.net>
 <5753e047-163b-2a89-fb57-bdb1c01f1732@iogearbox.net>
In-Reply-To: <5753e047-163b-2a89-fb57-bdb1c01f1732@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::4669]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0474013f-81f8-4845-df1b-08d6b7100d16
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB3462;
x-ms-traffictypediagnostic: BYAPR15MB3462:
x-microsoft-antispam-prvs: <BYAPR15MB3462337CD91FEAE17398E1ADD7560@BYAPR15MB3462.namprd15.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(39860400002)(396003)(199004)(189003)(31696002)(316002)(186003)(5660300002)(97736004)(52116002)(14454004)(14444005)(6506007)(386003)(93886005)(256004)(53546011)(102836004)(46003)(486006)(99286004)(476003)(71200400001)(36756003)(110136005)(8936002)(446003)(8676002)(2616005)(11346002)(81166006)(6436002)(71190400001)(6512007)(53936002)(68736007)(6116002)(54906003)(478600001)(106356001)(31686004)(81156014)(6486002)(2906002)(25786009)(305945005)(7736002)(86362001)(2501003)(229853002)(76176011)(105586002)(4326008)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3462;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3AOa6QAT9PA34AglUBVQxbY2Uuji2ANfNLqJX5EBTUIM6ggSd3VcMw2QFCj2RpM6+VbDcDzQvXOzuNgCMYcuOYUIdrxo/k3FOaNTtU88YjoCMNR2ta1ZCi5N72XlbEtvnfJTktk/c/FKKcC91kvO3Xz+clt0XKLet2jvUJ8DOUd7rflvzr0yF8trY3StT1x/x0RVOVNb9Uydl0AIC2+V6B6d0jYINV49VncBdYWDzDwRdgrvHxZ8jj/Qv8nAgCasF7G5Iv9q3xKdzWYWQUWO4UH9Pn1ejRTIylcMQBLfKQZrwPACxlR/FmRiDQa4bn9Alj3SSorAH0R+co2nCQA10t8QrN/H8U0kiWTaG1nuaGl4H6/CKxLEPwwoYCZp07RuozPADbYWfKY20Wr17OLO5CH8ijhO8qNa0WREMHLDC74=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0E47A9A89F684A843C895984866088@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0474013f-81f8-4845-df1b-08d6b7100d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 02:08:09.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3462
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gNC8xLzE5IDk6MzUgQU0sIERhbmllbCBCb3JrbWFubiB3cm90ZToNCj4gT24gMDQvMDEvMjAx
OSAwNDoxNyBQTSwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPj4gT24gMDMvMzAvMjAxOSAwMTox
NiBBTSwgQWxleGVpIFN0YXJvdm9pdG92IHdyb3RlOg0KPj4+IEFkZCAzIGJhc2ljIHRlc3RzIHRo
YXQgc3RyZXNzIHZlcmlmaWVyIHNjYWxhYmlsaXR5Lg0KPj4+DQo+Pj4gdGVzdF92ZXJpZl9zY2Fs
ZTEuYyBjYWxscyBub24taW5saW5lZCBqaGFzaCgpIGZ1bmN0aW9uIDkwIHRpbWVzIG9uDQo+Pj4g
ZGlmZmVyZW50IHBvc2l0aW9uIGluIHRoZSBwYWNrZXQuDQo+Pj4gVGhpcyB0ZXN0IHNpbXVsYXRl
cyBuZXR3b3JrIHBhY2tldCBwYXJzaW5nLg0KPj4+IGpoYXNoIGZ1bmN0aW9uIGlzIH4xNDAgaW5z
dHJ1Y3Rpb25zIGFuZCBtYWluIHByb2dyYW0gaXMgfjEyMDAgaW5zbnMuDQo+Pj4NCj4+PiB0ZXN0
X3ZlcmlmX3NjYWxlMi5jIGZvcmNlIGlubGluZXMgamhhc2goKSBmdW5jdGlvbiA5MCB0aW1lcy4N
Cj4+PiBUaGlzIHByb2dyYW0gaXMgfjE1ayBpbnN0cnVjdGlvbnMgbG9uZy4NCj4+Pg0KPj4+IHRl
c3RfdmVyaWZfc2NhbGUzLmMgY2FsbHMgbm9uLWlubGluZWQgamhhc2goKSBmdW5jdGlvbiA5MCB0
aW1lcyBvbg0KPj4+IEJ1dCB0aGlzIHRpbWUgamhhc2ggaGFzIHRvIHByb2Nlc3MgMzItYnl0ZXMg
ZnJvbSB0aGUgcGFja2V0DQo+Pj4gaW5zdGVhZCBvZiAxNC1ieXRlcyBpbiB0ZXN0cyAxIGFuZCAy
Lg0KPj4+IGpoYXNoIGZ1bmN0aW9uIGlzIH4yMzAgaW5zbnMgYW5kIG1haW4gcHJvZ3JhbSBpcyB+
MTIwMCBpbnNucy4NCj4+Pg0KPj4+ICQgdGVzdF9wcm9ncyAtcw0KPj4+IGNhbiBiZSB1c2VkIHRv
IHNlZSB2ZXJpZmllciBzdGF0cy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhlaSBTdGFy
b3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+DQo+Pg0KPj4gRG8geW91IGFsc28gaGF2ZSBzb21lIHRl
c3QgY2FzZXMgd2l0aCBhY3R1YWwgMU0gaW5zbnMgcmVzcC4gc3VjaCB0aGF0IGhpdA0KPj4gdGhl
IG5ldyBjb21wbGV4aXR5IGxpbWl0IHRvIGNoZWNrIHRpbWluZyAvIHJlc291cmNlcyBpdCBjb25z
dW1lcz8gSSB0aGluaw0KPj4gdGhlc2Ugd291bGQgYmUgZ29vZCB0byBoYXZlIGFzIHdlbGwgYXMg
cGFydCBvZiBzZWxmdGVzdHMuDQo+IA0KPiAoQW5vdGhlciB0aG91Z2h0IG9uIHdoeSBpdCB3b3Vs
ZCBiZSBnb29kIHRvIGhhdmUgc3VjaCB0ZXN0cyB3b3VsZCBiZSB0bw0KPiBzZWUgaWYgd2Ugd291
bGQgb3RoZXJ3aXNlIGJyZWFrIGxvbmcganVtcHMgYWdhaW4gZHVlIHRvIG9mZnNldCB0cnVuY2F0
aW9uDQo+IHdoaWNoIHdlIGhhZCBpbiB0aGUgY29yZSBhcyB3ZWxsIGFzIGluIEpJVHMgaW4gdGhl
IHBhc3QuKQ0KDQpsbHZtIHRydW5jYXRlcyBqdW1wIG9mZnNldHMgZm9yIGxhcmdlIHByb2dyYW1z
Lg0KVW5mb3J0dW5hdGVseSB3ZSBuZWVkIHRvIGludHJvZHVjZSBKQSBpbnN0cnVjdGlvbg0Kd2l0
aCAzMi1iaXQgb2Zmc2V0IG9uIGtlcm5lbCBzaWRlIGJlZm9yZSB3ZSBjYW4gZml4IGxsdm0uDQpU
aGVyZSBhcmUgcGxlbnR5IG9mIG90aGVyIHNjYWxhYmlsaXR5IGlzc3VlcyBvbiB0aGUga2VybmVs
IHNpZGUuDQpUaGlzIHBhdGNoIHNldCBpcyB0aGUgZmlyc3Qgc3RlcC4NCk9ubHkgbm9uLWp1bXB5
IHByb2dyYW0gb2YgMW0gaW5zbiBsb2FkcyBhbmQgd29ya3MuDQpSZWFsaXN0aWNhbGx5IHdlJ3Jl
IHN0aWxsIGZhciBhd2F5IGZyb20gYWNjZXB0aW5nIGxhcmdlIHByb2dyYW1zLA0KYnV0IHRvIGdl
dCB0aGVyZSB3ZSBuZWVkIHRvIGJ1bXAgdGhlIGxpbWl0IGFuZCBleHBlcmllbmNlIHRoZXNlIGlz
c3Vlcy4NCkkgbm90aWNlZCBhIHR5cG8gaW4gcGF0Y2ggMSwgc28gd2lsbCByZXNwaW4gYW5kIHdp
bGwgYWRkIGEgdGVzdC4NCg==
