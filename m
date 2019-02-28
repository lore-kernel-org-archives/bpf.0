Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA392C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE3520C01
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M2LuQBuQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UQk/aOmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfB1Tmi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:42:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfB1Tmh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 14:42:37 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SJXCLG008405;
        Thu, 28 Feb 2019 11:42:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Am2gLAMAW1Kp+7kM4b7fd88k3cZf80En9IGavELaSNo=;
 b=M2LuQBuQH7u8q8Z6C95f290Tt9UjjdBBm2zteHpnw4QbesLbrCFAK/oDitY/PMj+I6+9
 W1I2cXJPAGFbieLfXcZXcGYG8+bJnum/NowRvIw2qehTXKnPGcCAOzzDD4XURdozKDUE
 plcG+JeaWkIGcofa6oxQhswxWXft0a3KC4Y= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxkn5gncm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:42:14 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 11:41:58 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 28 Feb 2019 11:41:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am2gLAMAW1Kp+7kM4b7fd88k3cZf80En9IGavELaSNo=;
 b=UQk/aOmj2E9ZQTPWm1GkVHwzXJPAaCBIGMjvuEctf/JgApqYUt38MlXLfSuqhCUmUQQbZJOX0fLs43kQ5uZ389T4wgscK0+h5cyJv5ZhFUMs0+9WfJ9fF86W0vPGljksvsTy+OvHxGm4G6ttbvUIKLDLE0fmxfxT70qE+3ckOGY=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3109.namprd15.prod.outlook.com (20.178.239.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 19:41:56 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 19:41:56 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <Kernel-team@fb.com>,
        "Alexei Starovoitov" <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 4/5] btf: fix bug with resolving STRUCT/UNION
 into corresponding FWD
Thread-Topic: [PATCH bpf-next 4/5] btf: fix bug with resolving STRUCT/UNION
 into corresponding FWD
Thread-Index: AQHUzu6LxMJBC3QSWkCA7/52JYSkCqX1ABMAgACTogCAAAm6gA==
Date:   Thu, 28 Feb 2019 19:41:56 +0000
Message-ID: <44bbdc82-7678-0b8e-bc55-390daf9be4e4@fb.com>
References: <20190227224642.1069138-1-andriin@fb.com>
 <20190227224642.1069138-5-andriin@fb.com>
 <797b56c0-2178-a0b1-3070-721c2fd4d38c@fb.com>
 <CAEf4BzZRHJQEC7Z8JReDeoa1w3DV9dtq-pajOA_RFGYucaRU=Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZRHJQEC7Z8JReDeoa1w3DV9dtq-pajOA_RFGYucaRU=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0034.namprd22.prod.outlook.com
 (2603:10b6:300:69::20) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:e2ab]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37483661-bee7-4ae0-8b16-08d69db4cbf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3109;
x-ms-traffictypediagnostic: BYAPR15MB3109:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3109;20:wMb6tFxH18ERoHrWiSPNvB97NfZ19yF1b+gWlLni1zNHfiH0Vv6Gq203FWnOxoP8FJDlK2/oyIpoi0NTZfBcVcAWSdQBhknRQXLDeQq0/dxDMMWcDQyRGrLaliehq3g0F8wba+zTCFiGLqFzYDds0sHKpT/TJdpElLeaWlPMakA=
x-microsoft-antispam-prvs: <BYAPR15MB3109C7DD4C14F0173446F119D3750@BYAPR15MB3109.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(2906002)(71200400001)(106356001)(46003)(229853002)(105586002)(71190400001)(36756003)(14444005)(186003)(446003)(68736007)(11346002)(486006)(256004)(8936002)(6116002)(86362001)(102836004)(53546011)(7736002)(31686004)(31696002)(6436002)(81166006)(305945005)(8676002)(386003)(81156014)(6506007)(5660300002)(6512007)(6486002)(76176011)(25786009)(53936002)(14454004)(6916009)(478600001)(6246003)(4326008)(93886005)(52116002)(99286004)(54906003)(2616005)(476003)(97736004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3109;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g7OMyKLDjlhNMohV5S8SeQVFoodrL4LFBWJhlu9uLafGe3GWURrNearTWA7zn6++EgJ9KGAYFKh/Zcuw9uZJ4KNvGwjYGtU7q4W9UUoFqLCAEavthGaytFjXT3PstWgrZojUb9ZEeGqdidB+h77j/B7ENnfszLTWsKMpmrfBdx3PPdswV2gRaz2FzPTDcLtj4e+7BNMc8DHM4dbP0zzjmzqzgr5cvw0U4vnLvIIuTvHRlkwMH/ZTmXAzQ9bl/Anx8wftLr8yPzrxwQ3Z/jrxIUmmGU2URyRyL/B2xbwRveu5BYsPQZzRXmNsn04GOYW9GtkSwW+VWZV2hG3uJ0womZQc99rGVpP/OwEOGhFbR/yNMKkFgx7UtWNgn96SBmf6VvfSpamUmDOd+4b2coYjp8kcuX+Ey2j4AYtHEZ0XOfM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29A599CE53C87749AF357FBA2A101CC8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37483661-bee7-4ae0-8b16-08d69db4cbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 19:41:56.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3109
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjgvMTkgMTE6MDcgQU0sIEFuZHJpaSBOYWtyeWlrbyB3cm90ZToNCj4gT24gVGh1
LCBGZWIgMjgsIDIwMTkgYXQgMTA6MTkgQU0gWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4gd3Jv
dGU6DQo+Pg0KPj4NCj4+DQo+PiBPbiAyLzI3LzE5IDI6NDYgUE0sIEFuZHJpaSBOYWtyeWlrbyB3
cm90ZToNCj4+PiBXaGVuIGNoZWNraW5nIGF2YWlsYWJsZSBjYW5vbmljYWwgY2FuZGlkYXRlcyBm
b3Igc3RydWN0L3VuaW9uIGFsZ29yaXRobQ0KPj4+IHV0aWxpemVzIGJ0Zl9kZWR1cF9pc19lcXVp
diB0byBkZXRlcm1pbmUgaWYgY2FuZGlkYXRlIGlzIHN1aXRhYmxlLiBUaGlzDQo+Pj4gY2hlY2sg
aXMgbm90IGVub3VnaCB3aGVuIGNhbmRpZGF0ZSBpcyBjb3JyZXNwb25kaW5nIEZXRCBmb3IgdGhh
dA0KPj4+IHN0cnVjdC91bmlvbiwgYmVjYXVzZSBhY2NvcmRpbmcgdG8gZXF1aXZhbGVuY2UgbG9n
aWMgdGhleSBhcmUNCj4+PiBlcXVpdmFsZW50LiBXaGVuIGl0IHNvIGhhcHBlbnMgdGhhdCBGV0Qg
YW5kIFNUUlVDVC9VTklPTiBlbmQgaW4gaGFzaGluZw0KPj4+IHRvIHRoZSBzYW1lIGJ1Y2tldCwg
aXQncyBwb3NzaWJsZSB0byBjcmVhdGUgcmVtYXBwaW5nIGxvb3AgZnJvbSBGV0QgdG8NCj4+PiBT
VFJVQ1QgYW5kIFNUUlVDVCB0byBzYW1lIEZXRCwgd2hpY2ggd2lsbCBjYXVzZSBidGZfZGVkdXAo
KSB0byBsb29wDQo+Pj4gZm9yZXZlci4NCj4+Pg0KPj4+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlz
c3VlIGJ5IGFkZGl0aW9uYWxseSBjaGVja2luZyB0aGF0IHR5cGUgYW5kDQo+Pj4gY2Fub25pY2Fs
IGNhbmRpZGF0ZSBhcmUgc3RyaWN0bHkgZXF1YWwgKHV0aWxpemluZyBidGZfZXF1YWxfc3RydWN0
KS4NCj4+DQo+PiBJdCBsb29rcyBsaWtlIGJ0Zl9lcXVhbF9zdHJ1Y3QoKSBjaGVja2luZyBlcXVh
bGl0eSBleGNlcHQNCj4+IG1lbWJlciB0eXBlIGlkJ3MuIE1heWJlIGNhbGxpbmcgaXQgYnRmX2Fs
bW9zdF9lcXVhbF9zdHJ1Y3QoKSBvcg0KPj4gc29tZXRoaW5nIGxpa2UgdGhhdD8NCj4gDQo+IFll
cywgZm9yIHN0cnVjdC91bmlvbiB3ZSBjYW4ndCBjb21wYXJlIHR5cGVzIGRpcmVjdGx5LCB0aGF0
J3Mgd2hhdA0KPiBidGZfZGVkdXBfaXNfZXF1aXYgaXMgZG9pbmcuIEkgdGhpbmsgYnRmX2VxdWFs
X3N0cnVjdCB3LyBjb21tZW50DQo+IGV4cGxhaW5pbmcgdGhpcyBwYXJ0aWN1bGFyIGJlaGF2aW9y
IGlzIGdvb2QgZW5vdWdoLiBJZiB5b3UgaW5zaXN0LA0KPiB0aG91Z2gsIEknZCByYXRoZXIgZ28g
dG8gc29tZXRoaW5nIGxpa2UgYnRmX3NoYWxsb3dfZXF1YWxfc3RydWN0IG9yDQo+IHNvbWV0aGlu
ZyBhbG9uZyB0aG9zZSBsaW5lcy4NCg0KYnRmX3NoYWxsb3dfZXF1YWxfc3RydWN0KCkgd2lsbCBi
ZSBmaW5lLg0KDQo+IA0KPj4NCj4+Pg0KPj4+IEZpeGVzOiBkNWNhZWY1YjU2NTUgKCJidGY6IGFk
ZCBCVEYgdHlwZXMgZGVkdXBsaWNhdGlvbiBhbGdvcml0aG0iKQ0KPj4+IFJlcG9ydGVkLWJ5OiBB
cm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAcmVkaGF0LmNvbT4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaW5AZmIuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIHRv
b2xzL2xpYi9icGYvYnRmLmMgfCA2ICsrKysrLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS90b29scy9s
aWIvYnBmL2J0Zi5jIGIvdG9vbHMvbGliL2JwZi9idGYuYw0KPj4+IGluZGV4IDZiYmI3MTAyMTZl
Ni4uNTNkYjI2ZDE1OGM5IDEwMDY0NA0KPj4+IC0tLSBhL3Rvb2xzL2xpYi9icGYvYnRmLmMNCj4+
PiArKysgYi90b29scy9saWIvYnBmL2J0Zi5jDQo+Pj4gQEAgLTIyNTUsNyArMjI1NSw3IEBAIHN0
YXRpYyB2b2lkIGJ0Zl9kZWR1cF9tZXJnZV9oeXBvdF9tYXAoc3RydWN0IGJ0Zl9kZWR1cCAqZCkN
Cj4+PiAgICBzdGF0aWMgaW50IGJ0Zl9kZWR1cF9zdHJ1Y3RfdHlwZShzdHJ1Y3QgYnRmX2RlZHVw
ICpkLCBfX3UzMiB0eXBlX2lkKQ0KPj4+ICAgIHsNCj4+PiAgICAgICAgc3RydWN0IGJ0Zl9kZWR1
cF9ub2RlICpjYW5kX25vZGU7DQo+Pj4gLSAgICAgc3RydWN0IGJ0Zl90eXBlICp0Ow0KPj4+ICsg
ICAgIHN0cnVjdCBidGZfdHlwZSAqY2FuZF90eXBlLCAqdDsNCj4+PiAgICAgICAgLyogaWYgd2Ug
ZG9uJ3QgZmluZCBlcXVpdmFsZW50IHR5cGUsIHRoZW4gd2UgYXJlIGNhbm9uaWNhbCAqLw0KPj4+
ICAgICAgICBfX3UzMiBuZXdfaWQgPSB0eXBlX2lkOw0KPj4+ICAgICAgICBfX3UxNiBraW5kOw0K
Pj4+IEBAIC0yMjc1LDYgKzIyNzUsMTAgQEAgc3RhdGljIGludCBidGZfZGVkdXBfc3RydWN0X3R5
cGUoc3RydWN0IGJ0Zl9kZWR1cCAqZCwgX191MzIgdHlwZV9pZCkNCj4+PiAgICAgICAgZm9yX2Vh
Y2hfZGVkdXBfY2FuZChkLCBoLCBjYW5kX25vZGUpIHsNCj4+PiAgICAgICAgICAgICAgICBpbnQg
ZXE7DQo+Pj4NCj4+PiArICAgICAgICAgICAgIGNhbmRfdHlwZSA9IGQtPmJ0Zi0+dHlwZXNbY2Fu
ZF9ub2RlLT50eXBlX2lkXTsNCj4+PiArICAgICAgICAgICAgIGlmICghYnRmX2VxdWFsX3N0cnVj
dCh0LCBjYW5kX3R5cGUpKQ0KPj4NCj4+IFRoZSBjb21tZW50IGZvciB0aGlzIGJ0Zl9lcXVhbF9z
dHJ1Y3QgaXMgbm90IHF1aXRlIHJpZ2h0Lg0KPj4gLyoNCj4+ICAgICogQ2hlY2sgc3RydWN0dXJh
bCBjb21wYXRpYmlsaXR5IG9mIHR3byBGVU5DX1BST1RPcywgaWdub3JpbmcNCj4+IHJlZmVyZW5j
ZWQgdHlwZQ0KPj4gICAgKiBJRHMuIFRoaXMgY2hlY2sgaXMgcGVyZm9ybWVkIGR1cmluZyB0eXBl
IGdyYXBoIGVxdWl2YWxlbmNlIGNoZWNrIGFuZA0KPj4gICAgKiByZWZlcmVuY2VkIHR5cGVzIGVx
dWl2YWxlbmNlIGlzIGNoZWNrZWQgc2VwYXJhdGVseS4NCj4+ICAgICovDQo+PiBzdGF0aWMgYm9v
bCBidGZfZXF1YWxfc3RydWN0KHN0cnVjdCBidGZfdHlwZSAqdDEsIHN0cnVjdCBidGZfdHlwZSAq
dDIpDQo+Pg0KPj4gSXQgc2hvdWxkIGJlIHR3byAic3RydWN0L3VuaW9uIHR5cGVzIi4NCj4gDQo+
IFllcCwgZ29vZCBjYXRjaCwgd2lsbCBmaXghDQo+IA0KPj4NCj4+PiArICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+Pj4gKw0KPj4NCj4+IEkgZGlkIG5vdCB0cmFjZSB0aGUgYWxnb3Jp
dGhtIGhvdyBpbmZpbml0ZSBsb29wIGhhcHBlbnMuIEJ1dCB0aGUgYWJvdmUNCj4gDQo+IENoZWNr
IHRoZSB0ZXN0IGluIGZvbGxvdyB1cCBwYXRjaC4gSXQgaGFzIGEgbWluaW1hbCBleGFtcGxlIHRo
YXQNCj4gdHJpZ2dlcnMgdGhpcyBidWcuIEl0IGhhcHBlbnMgd2hlbiB3ZSBoYXZlIHNvbWUgRldE
IHgsIHdoaWNoIHdlDQo+IGRpc2NvdmVyIHRoYXQgaXQgc2hvdWxkIGJlIHJlc29sdmVkIHRvIHNv
bWUgU1RSVUNUIHggKGFzIGEgcmVzdWx0IG9mDQo+IGVxdWl2YWxlbmNlIGNoZWNrL3Jlc29sdXRp
b24gb2Ygc29tZSBvdGhlciBzdHJ1Y3QgcywgdGhhdCByZWZlcmVuY2VzDQo+IHN0cnVjdCB4IGlu
dGVybmFsbHkpLiBCdXQgdGhhdCBzdHJ1Y3QgeCBtaWdodCBub3QgaGF2ZSBiZWVuDQo+IGRlZHVw
bGljYXRlZCB5ZXQsIHdlIGp1c3QgcmVjb3JkIHRoaXMgRldEIC0+IFNUUlVDVCBtYXBwaW5nIHNv
IHRoYXQgd2UNCj4gZG9uJ3QgbG9zZSB0aGlzIGNvbm5lY3Rpb24uIExhdGVyLCBvbmNlIHdlIGdl
dCB0byBkZWR1cGxpY2F0aW9uIG9mDQo+IHN0cnVjdCB4LCBGV0QgeCB3aWxsIGJlIChpbiBjYXNl
IG9mIGhhc2ggY29sbGlzaW9uKSBvbmUgcG9zc2libGUNCj4gY2FuZGlkYXRlIHRvIGNvbnNpZGVy
IGZvciBkZWR1cGxpY2F0aW9uLiBBdCB0aGF0IHBvaW50LA0KPiBidGZfZGVkdXBfaXNfZXF1aXYg
d2lsbCBjb25zaWRlciB0aGVtIGVxdWl2YWxlbnQgKGJ1dCB0aGV5IGFyZSBub3QNCj4gZXF1YWwg
KCEpLCB0aGF0J3Mgd2hlcmUgdGhlIGJ1ZyBpcyksIHNvIHdlJ2xsIHRyeSB0byByZXNvbHZlIFNU
UlVDVCB4DQo+IC0+IEZXRCB4LCB3aGljaCBjcmVhdGVzIGEgbG9vcC4NCj4gDQo+IEluIGJ0Zl9k
ZWR1cF9tZXJnZV9oeXBvdF9tYXAoKSB0aGF0IGlzIHVzZWQgdG8gcmVjb3JkIGRpc2NvdmVyZWQN
Cj4gImVxdWl2YWxlbmNlcyIgZHVyaW5nIHN0cnVjdC91bmlvbiB0eXBlIGdyYXBoIGVxdWl2YWxl
bmNlIGNoZWNrLCB3ZQ0KPiBoYXZlIGV4cGxpY2l0IGNoZWNrIHRvIG5ldmVyIHJlc29sdmUgU1RS
VUNUL1VOSU9OIGludG8gZXF1aXZhbGVudCBGV0QsDQo+IHNvIHN1Y2ggbG9vcCBzaG91bGRuJ3Qg
aGFwcGVuLCBleGNlcHQgSSBtaXNzZWQgdGhlIGNhc2Ugb2YgaGF2aW5nIEZXRA0KPiBhcyBhIHBv
c3NpYmxlIGRlZHVwIGNhbmRpZGF0ZSBkdWUgdG8gaGFzaCBjb2xsaXNpb24uDQo+IA0KPj4gY2hh
bmdlIGlzIGNlcnRhaW5seSBhIGNvcnJlY3Qgb25lLCB5b3Ugd2FudCB0byBkbyBkZWR1cGxpY2F0
aW9uIG9ubHkNCj4+IGFmdGVyIGV2ZXJ5dGhpbmcgZWxzZSAoZXhjZXB0IG1lbWJlciB0eXBlcykg
YXJlIGV1cWFsPw0KPiANCj4gV2VsbCwgaWYgbm90IGZvciBzcGVjaWFsIGNhc2Ugb2YgRldEID09
IFNUUlVDVC9VTklPTiB3aGVuDQo+IGRlZHVwbGljYXRpbmcgc3RydWN0cywgYnRmX2RlZHVwX2lz
X2VxdWl2IHdvdWxkIGJlIGVub3VnaCwgYmVjYXVzZSBpdA0KPiBhbHJlYWR5IGNoZWNrcyBmb3Ig
YnRmX2VxdWFsX3N0cnVjdCBpbnRlcm5hbGx5LCB3aGVuIGJvdGggdHlwZXMgYXJlDQo+IHN0cnVj
dC91bmlvbi4gSXQncyBqdXN0IHRoZSBzcGVjaWFsIGJpdCBhdCB0aGUgYmVnaW5uaW5nIG9mIGlz
X2VxdWl2DQo+IGNoZWNrIHRoYXQgYWxsb3dzIEZXRCBhbmQgU1RSVUNUL1VOSU9OIHdpdGggdGhl
IHNhbWUgbmFtZSB0byBiZQ0KPiBkZWNsYXJlZCBlcXVpdmFsZW50LCB0aGF0IHRocm93cyB0aGlz
IG9mZi4NCj4gDQo+Pg0KPj4gSWYgdGhlIGJ1ZyBpcyBkdWUgdG8gY2lyY2xlIGluIHN0cnVjdC0+
ZndkIGFuZCBmd2QtPnN0cnVjdCBtYXBwaW5ncywNCj4+IG1heWJlIGEgc2ltcGxlIGNoZWNrIHdo
ZXRoZXIgc3VjaCBjaXJjbGUgZXhpc3RzIG9yIG5vdCBiZWZvcmUgdXBkYXRlDQo+PiB0aGUgbWFw
cGluZyB3aWxsIGFsc28gd29yaz8gSSBhbSBub3QgcHJvcG9zaW5nIHRoaXMgZml4LCBidXQgd2Fu
dA0KPj4gdG8gdW5kZXJzdGFuZCBiZXR0ZXIgdGhlIGlzc3VlLg0KPiANCj4gVGhhdCdzIGVzc2Vu
dGlhbGx5IHdoYXQgd2UgdXNlIGJ0Zl9lcXVhbF9zdHJ1Y3QgZm9yIGhlcmUsIHJlYWxseS4gV2UN
Cj4gY291bGQgZXF1aXZhbGVudGx5IGp1c3QgY2hlY2sgQlRGX0lORk9fS0lORCh0KSA9PSBCVEZf
SU5GT19LSU5EKGNhbmQpDQo+IGV4cGxpY2l0bHksIGJ1dCBJIGJ0Zl9lcXVhbF9zdHJ1Y3QgZmVl
bHMgYSBiaXQgbW9yZSBnZW5lcmljIGFuZA0KPiBvYnZpb3VzbHkgY29ycmVjdC4NCg0KT2theSwg
SSBzZWUuIFNvIHRoZSBnb2FsIGlzIHJlYWxseSB0byBwcmV2ZW50IHByb2Nlc3NpbmcgRldEIGlu
IHRoZQ0Kc3RydWN0L3VuaW9uIGRlZHVwIGNhbmRpZGF0ZSBsaXN0LiBJdCB3aWxsIGJlIGdvb2Qg
dG8gc3VtbWFyaXplDQp0aGUgYWJvdmUgZGV0YWlsZWQgZXhwbGFuYXRpb24gaW4gY29tbWl0IG1l
c3NhZ2UuDQoNCldpdGggdGhlIGFib3ZlIHN1Z2dlc3RlZCBjaGFuZ2VzLA0KICAgQWNrZWQtYnk6
IFlvbmdob25nIFNvbmcgPHloc0BmYi5jb20+DQoNCj4gDQo+Pg0KPj4NCj4+DQo+Pg0KPj4+ICAg
ICAgICAgICAgICAgIGJ0Zl9kZWR1cF9jbGVhcl9oeXBvdF9tYXAoZCk7DQo+Pj4gICAgICAgICAg
ICAgICAgZXEgPSBidGZfZGVkdXBfaXNfZXF1aXYoZCwgdHlwZV9pZCwgY2FuZF9ub2RlLT50eXBl
X2lkKTsNCj4+PiAgICAgICAgICAgICAgICBpZiAoZXEgPCAwKQ0KPj4+DQo=
