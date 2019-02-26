Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0772C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6862184D
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DXBr0n+D";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZkaCHKVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfBZRZP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:25:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49606 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfBZRZP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Feb 2019 12:25:15 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QHJ0r7027374;
        Tue, 26 Feb 2019 09:25:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+GjUMXOIHK7VkyT/c2hIKIkAA1Eiyv+yAbDgT+Lz0rY=;
 b=DXBr0n+DZ5BI4+9etltx6GEXi1Egaj8AtH8JIOKQfnQnBpvRG4I5/eW8Nw8FBw+7tnUJ
 8Zd8/g6BlGouJpLradTuqEN8yQ/jSv/MXWnCGyt9+yw5V5Y1XUrp2EVAfHKUjXlYl8Uo
 A8CHc6VJG4VS8nv3fN0yDdGK0YS4wesUSG0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qw8bwrpqp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 26 Feb 2019 09:25:13 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 26 Feb 2019 09:25:02 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 26 Feb 2019 09:25:01 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 26 Feb 2019 09:25:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GjUMXOIHK7VkyT/c2hIKIkAA1Eiyv+yAbDgT+Lz0rY=;
 b=ZkaCHKVpfllS2edFQkFQi+waPwOETuF5UnHxxG13MaeJ45ptiap7uDepYMN7CAwZYq3i9ZTkW+4wFwNVE0s2bNAKKFJnyXngNEB0VWrHqDTBN+PS6ScobWZAQArTSWk5iKaGzHJw27SpIlYZFbArO/hLZ28+MH2pxq8VjA4DFq0=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3478.namprd15.prod.outlook.com (20.179.60.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Tue, 26 Feb 2019 17:24:58 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 17:24:58 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling of
 bitfields in btf_loader
Thread-Topic: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling
 of bitfields in btf_loader
Thread-Index: AQHUyV718vJZBQQRBk+lN3pcSmGlf6XsYe2AgAAWrACABDu5gIAAMYCAgAAL64CAAAc8AIAAC/2AgAAMw4CAAIZHgIAAAiUA//9+9QCAAUPjAIAAAK2A
Date:   Tue, 26 Feb 2019 17:24:58 +0000
Message-ID: <5183cb3f-4ab9-f7d6-6148-71856435569a@fb.com>
References: <20190220205732.2514975-1-andriin@fb.com>
 <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
 <20190225200822.GB13100@kernel.org>
 <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
 <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
 <9033db30-1aab-69ae-dc2c-7dfa2585ead3@fb.com>
 <CAEf4BzZOC9O=ho2cdi2aY=BuXwcBBTO7zBCkW3zKbN7DMQ-a9Q@mail.gmail.com>
 <00483f56-1bb8-6b6b-c408-f6d37cc58764@fb.com>
 <CAEf4Bzb-L1Cu6y6GKH0gYv611EA1qmvk=h=cnndtqEGydRwhNw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb-L1Cu6y6GKH0gYv611EA1qmvk=h=cnndtqEGydRwhNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::f2ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 055a7632-f2ce-4dec-f5fd-08d69c0f54f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3478;
x-ms-traffictypediagnostic: BYAPR15MB3478:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3478;20:G5QsLWXFt5q/aaLynrlHZ6rxtBgGU87+XJmfeYLlV6jQWbolt32y0GSfBgg0o/PXp2FE/c1oa7TC/bJr2RbSijc4Fa2vAdD14VUFycjF6vYROA94vdVbcJFLmHffG0ABTDLliaXL5aNBn4hxwkM+wOXgP9bHnRiWlw4z3wZcw0g=
x-microsoft-antispam-prvs: <BYAPR15MB347890BB6DCAA09F8324AB0AD37B0@BYAPR15MB3478.namprd15.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(11346002)(476003)(2616005)(446003)(7736002)(46003)(186003)(76176011)(6486002)(31686004)(52116002)(229853002)(305945005)(81156014)(81166006)(8936002)(8676002)(486006)(99286004)(36756003)(6512007)(68736007)(106356001)(54906003)(6436002)(105586002)(316002)(53936002)(6246003)(256004)(71200400001)(71190400001)(97736004)(6916009)(6116002)(2906002)(478600001)(86362001)(102836004)(31696002)(5660300002)(25786009)(4326008)(386003)(6506007)(53546011)(93886005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3478;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UAnrjCDDwqfnEYaPn5pEwHzv1j+WkUMlkcfNkR0WvvG77F3hIS3wH2N5SjT8v9/SuwTBwUWHAc8SDDjTuXxZUEvcrvJGdADtW1SDscLYOp4oIYj2KAS6+6QH9rz7QgDl+sPHWhXGmwcTv/31Z9S0bW23AhSUT5PVezLpWDw0xfLIyXJ7lYWRYWFy4Al/mG/ajESvHio2Q885uVwZ/snfJ4bCvSyKHJjj86m0a5s3u2Nb8ciu6d9ulocTrUCz5evt1MCfKtr07PMdjGpVFF/OpZ2PtWTbKv6PcFo5ssh4cND8Fk2t6ZxNNXnRUAEovGr+sWSjlEbymVTwU2D3L/6j32IAZYA0SUShEr6uMN9b6Lswyqi3ComDH/rrGvAMJNuVbki7pJ036PDXc9mfTZP7uWhndjblCn0IvffnnuwIE/g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C816207DF48ADB4797D3C26499BBB853@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 055a7632-f2ce-4dec-f5fd-08d69c0f54f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 17:24:57.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3478
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjYvMTkgOToyMiBBTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBPbiBNb24s
IEZlYiAyNSwgMjAxOSBhdCAxMDowMyBQTSBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPiB3cm90
ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDIvMjUvMTkgOTo0NSBQTSwgQW5kcmlpIE5ha3J5aWtvIHdy
b3RlOg0KPj4+IE9uIE1vbiwgRmViIDI1LCAyMDE5IGF0IDk6MzggUE0gWW9uZ2hvbmcgU29uZyA8
eWhzQGZiLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDIvMjUvMTkgMToz
NiBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPj4+Pj4gT24gTW9uLCBGZWIgMjUsIDIwMTkg
YXQgMTI6NTEgUE0gQW5kcmlpIE5ha3J5aWtvDQo+Pj4+PiA8YW5kcmlpLm5ha3J5aWtvQGdtYWls
LmNvbT4gd3JvdGU6DQo+Pj4+Pj4NCj4+Pj4+PiBPbiBNb24sIEZlYiAyNSwgMjAxOSBhdCAxMjow
OCBQTSBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4+Pj4+PiA8YXJuYWxkby5tZWxvQGdtYWls
LmNvbT4gd3JvdGU6DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEVtIE1vbiwgRmViIDI1LCAyMDE5IGF0IDEx
OjQyOjI5QU0gLTA4MDAsIEFuZHJpaSBOYWtyeWlrbyBlc2NyZXZldToNCj4+Pj4+Pj4+IE9uIE1v
biwgRmViIDI1LCAyMDE5IGF0IDExOjAwIEFNIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbz4gPGFy
bmFsZG8ubWVsb0BnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4+IEVtIE1vbiwg
RmViIDI1LCAyMDE5IGF0IDAxOjAyOjM5UE0gLTAzMDAsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVs
byBlc2NyZXZldToNCj4+Pj4+Pj4+Pj4gU28geWVhaCwgdGhlIEJURiBlbmNvZGVyL2RlY29kZXIg
aXMgd29ya2luZyBqdXN0IGZpbmUsIHRoZSBwcm9ibGVtIGlzIGluDQo+Pj4+Pj4+Pj4+IHBhaG9s
ZSdzIERXQVJGIGNvZGUsIGxlbW1lIHNlZS4uLg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gUGxlYXNl
IHRyeSB0aGUgcGF0Y2ggYmVsb3csIGZvciBtZSBidGZkaWZmIGNvbnRpbnVlcyB0byBzaG93IG5v
IGRpZmYgZm9yDQo+Pj4+Pj4+Pj4gYWxsIHR5cGVzIGluIG15IHZtbGludXggYW5kIG5vdyBpdCBh
bHNvIHByb2R1Y2VzIHRoZSBzYW1lIG91dHB1dCBmb3INCj4+Pj4+Pj4+PiB3aGVuIHRoZSBmaXJz
dCBlbGVtZW50IG9mIGEgYml0ZmllbGQgaGFzIGl0cyBiaXRfc2l6ZSBlcXVhbCB0byBpdHMNCj4+
Pj4+Pj4+PiBieXRlX3NpemUgKiA4Og0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFllcywgdGhpcyBmaXhl
cyBhbGwgdGhlIGlzc3VlcyBJJ3ZlIHNlZW4uIGJ0ZmRpZmYgb3V0cHV0IGlzIG5vdyBlbXB0eQ0K
Pj4+Pj4+Pj4gZm9yIG15IGtlcm5lbCBpbWFnZS4gVGhhbmtzIGZvciBxdWljayBmaXghDQo+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4gUmV2aWV3ZWQtYnk6IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpbkBmYi5j
b20+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoYW5rcywganVzdCBmb3Igc29tZSBleHRyYSB0ZXN0aW5n
IEkgdHJpZWQgZW5jb2RpbmcgQlRGIGZvciBnbGliYyAyLjI4Og0KPj4+Pj4+Pg0KPj4+Pj4+PiBb
YWNtZUBxdWFjbyBwYWhvbGVdJCBwYWhvbGUgLUpWIGxpYmMtMi4yOC5zby5kZWJ1Zw0KPj4+Pj4+
PiA8QklHIHNuaXA+DQo+Pj4+Pj4NCj4+Pj4+PiA8c25pcD4NCj4+Pj4+Pg0KPiANCj4gPHNuaXA+
DQo+IA0KPj4+Pj4NCj4+Pj4+IFNlZW1zIGxpa2UgImxvbmcgZG91YmxlIiBzaXplIGlzIGludmFs
aWQgZm9yIEJURi4gQW5kIHdlIHNob3VsZA0KPj4+Pj4gcHJvYmFibHkgYWRkICJfRmxvYXQxMjgi
IGFzIGFub3RoZXIgIndlbGwga25vd24iIGJhc2UgdHlwZSBuYW1lPw0KPj4+Pg0KPj4+PiBCUEYg
ZG9lcyBub3Qgc3VwcG9ydCBmbG9hdGluZyBwb2ludCBpbnN0cnVjdGlvbnMuIEFzIHRoZSByZXN1
bHQsDQo+Pj4+IEJURiBkZXNpZ24gZG9lcyBub3QgY29udGFpbiBmbG9hdGluZyBwb2ludCB0eXBl
cy4NCj4+Pj4NCj4+Pj4gTG9va3MgbGlrZSBrZXJuZWwgYWxzbyB1c2VzIGZsb2F0IHR5cGVzIChp
biBjZXJ0YWluIGRyaXZlcnMgYW5kIGFyY2gncyksDQo+Pj4+IGJ1dCB0eXBlcyByZWZlcnJlZCBi
eSBicGYgcHJvZ3JhbSBtb3N0bHkgd2lsbCBub3QgY29udGFpbiBmbG9hdCB0eXBlcy4NCj4+Pj4N
Cj4+Pj4gQ3VycmVudGx5LCBib3RoIGxsdm0gYW5kIHBhaG9sZSB3aWxsIGlnbm9yZSBmbG9hdGlu
ZyB0eXBlcywgc28NCj4+Pj4gZnJvbSB0eXBlIGNvbXBhcmlzb24gcG9pbnQgb2Ygdmlldywgd2Ug
d2lsbCBiZSBmaW5lLg0KPj4+PiBUaGUgaXNzdWUgbWF5IGNvbWUgdXAgd2l0aCBwZW9wbGUgdXNp
bmcgdm1saW51eCBCVEYgaW5zaWRlIHRoZQ0KPj4+PiBrZXJuZWwgZm9yIGRpZmZlcmVudCBwdXJw
b3NlIHdoZXJlIGEgZmxvYXQgdHlwZSBuZWVkcyB0byBiZQ0KPj4+PiBzcGVjaWZpZWQsIGUuZy4s
IGZvciBhIGZsb2F0aW5nIHBvaW50IGZ1bmN0aW9uIGFyZ3VtZW50IGluIGZ0cmFjZS4NCj4+Pj4g
QnV0IHRoaXMgaXMgcmFyZSB0b28uDQo+Pj4+DQo+Pj4+IEkgYW0gbm90IDEwMCUgc3VyZSB3aGV0
aGVyIHBhaG9sZSBkd2FyZi9idGYgcGFyaXR5IGlzIGNvbnNpZGVyZWQNCj4+Pj4gYXMgYSBzdHJv
bmcgcmVhc29uIHRvIGFkZCBmbG9hdGluZyBwb2ludCB0eXBlIHN1cHBvcnQgaW4gQlRGIG9yIG5v
dC4NCj4+Pg0KPj4+IElzbid0IGZsb2F0IGFuZCBkb3VibGUganVzdCBhbm90aGVyIGJhc2UgdHlw
ZSB3aXRoIGNvcnJlc3BvbmRpbmcgbmFtZT8NCj4+PiBGdW5kYW1lbnRhbGx5LCBob3cgaXMgaXQg
ZGlmZmVyZW50IGZyb20gaW50IG9yIGxvbmc/IEl0J3Mgc3RpbGwganVzdCBhDQo+Pj4gY29sbGVj
dGlvbiBvZiBiaXRzIGluIDMyLWJpdCwgNjQtYml0LCBldGMgbnVtYmVyLCBleGNlcHQgaW50ZXJw
cmV0ZWQNCj4+PiBkaWZmZXJlbnRseS4gRG8geW91IG1lYW4gdGhhdCBmb3IgQlRGIHRvIHByb3Bl
cmx5IHN1cHBvcnQgZmxvYXRzLA0KPj4+IHdlJ2xsIG5lZWQgdG8gZXh0ZW5kcyBzZXQgb2YgcG9z
c2libGUgZW5jb2RpbmdzIGluIElOVCB0eXBlIChpbg0KPj4+IGFkZGl0aW9uIHRvIHRvZGF5J3Mg
Q0hBUiwgU0lHTkVEIGFuZCBVTlNJR05FRCk/DQo+Pg0KPj4gUHJvYmFibHkgYW5vdGhlciBraW5k
IGxpa2UgQlRGX0tJTkRfRkxPQVQgd2l0aCBhZGRpdGlvbmFsIHUzMiAoaW4NCj4+IGFkZGl0aW9u
IHRvIGJ0Zl90eXBlKSBpbmRpY2F0aW5nIHRoZSBzaXplICg0IGJ5dGVzLCA4IGJ5dGVzIGFuZCAx
NiBieXRlcykuDQo+IA0KPiBUaGlzIHNvdW5kcyBleGFjdGx5IGxpa2UgY3VycmVudCBmb3JtYXQg
b2YgQlRGX0tJTkRfSU5ULiBXaGF0DQo+IEJURl9LSU5EX0ZMT0FUIHdpbGwgaGF2ZSB0aGF0IGNh
bid0IGJlIHJlcHJlc2VudGVkIGJ5IEJURl9LSU5EX0lOVD8NCj4gV291bGRuJ3QgaXQgYmUgZXF1
aXZhbGVudCB0byBqdXN0IGFkZGluZyBCVEZfSU5UX0ZMT0FUIGluIGFkZGl0aW9uIHRvDQo+IGV4
aXN0aW5nIEJURl9JTlRfU0lHTkVELCBCVEZfSU5UX0NIQVIsIEJURl9JTlRfQk9PTCB0bw0KPiBC
VEZfSU5UX0VOQ09ESU5HPyBCdHcsIHdoaWxlIEJURl9JTlRfU0lHTkVEIHNlZW1zIGxpa2UgaXQg
ZGVzZXJ2ZXMNCj4gc2VwYXJhdGUgYml0LCBiZWNhdXNlIGl0J3MgbW9zdGx5IG9ydGhvZ29uYWwg
dG8gQ0hBUiB2cyBJTlQgdnMgRkxPQVQNCj4gdnMgKG5vdCBzbyBtdWNoKSBCT09MLCBCVEZfSU5U
X0NIQVIgYW5kIEJURl9JTlRfQk9PTCB0YWtlIHR3bw0KPiBpbmRlcGVuZGVudCBiaXRzIHNlZW1z
IGV4Y2Vzc2l2ZS4gWW91IGNhbid0IGhhdmUgQk9PTCBhbmQgQ0hBUiwgcmlnaHQ/DQo+IFNvIHdo
eSBkb24ndCB3ZSBqdXN0IHJlcHVycG9zZSBiaXRzIDEgYW5kIDIgdG8gYmUgYSBzbWFsbCA0LXZh
bHVlDQo+IGVudW06DQo+IA0KPiBlbnVtIGJ0Zl9pbnRfZW5jb2Rpbmcgew0KPiAgICAgIElOVCA9
IDAsDQo+ICAgICAgQ0hBUiA9IDEsDQo+ICAgICAgQk9PTCA9IDIsDQo+ICAgICAgRkxPQVQgPSAz
LA0KPiB9Ow0KPiANCj4gVGhpcyBpcyBiYWNrd2FyZHMgY29tcGF0aWJsZSBhbmQgY292ZXJzIGFs
bCBmbG9hdHMgKGxvbmcgZG91YmxlIHZzDQo+IGRvdWJsZSB2cyBmbG9hdCBpcyBqdXN0IGEgcXVl
c3Rpb24gb2YgYml0bmVzcykuDQo+IA0KPiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nIGhlcmU/DQoN
CmZsb2F0IGlzIG5vdCBhbiAiaW50Ii4gRW5jb2RpbmcgImZsb2F0IiBpbiBJTlRfS0lORCBkb2Vz
IG5vdCBzb3VuZCByaWdodCANCmluIG15IG9waW5pb24uDQoNCj4gDQo+Pg0KPj4+DQo+Pj4+DQo+
Pj4+Pg0KPj4+Pj4gVGhvdWdoIGZvciB0aGUgbGF0dGVyLCBpdCBwcm9iYWJseSB3b3VsZCBiZSBi
ZXR0ZXIgdG8gcmVzb2x2ZSBiYXNlDQo+Pj4+PiB0eXBlIHNpemUgdXNpbmcgQlRGIGRhdGEgaXRz
ZWxmLg0KPj4+Pj4NCj4+Pj4+Pj4gW2FjbWVAcXVhY28gcGFob2xlXSQNCg==
