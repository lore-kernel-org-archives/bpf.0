Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572B9C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B2F2084D
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Me6/8OfN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Zpv9sQMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbfB1STR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:19:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbfB1STR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 13:19:17 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SICjAn003922;
        Thu, 28 Feb 2019 10:19:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ajfpcswFJbaibqQJsm2dGI4pKewfJjBePpi7z7egxcI=;
 b=Me6/8OfN6as6gcdjInLLjOf86v+VYjDcBW4dl+wW4wxWayjkgkyR/FilgvB9rOX4AMjF
 fLjL3c4zKcc8w2anuMWRr33MoUFdSuHCDVMVNny6N6vlsYM8oSa60UXd2Zl8SrbtmJ8o
 ouAP1UWY6iRHgmclvXd7GiK5q26mnAJ+FZs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxjqt8j1j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 10:19:02 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 10:18:35 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 10:18:35 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 28 Feb 2019 10:18:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajfpcswFJbaibqQJsm2dGI4pKewfJjBePpi7z7egxcI=;
 b=Zpv9sQMv3MB/V962kX67AuOSiRMgUtPJgWs6ODQKylIr+7wiiOLubIlCzzS+637VI5J23joFM3s3p25yyuNq9e8pToSstw17euD83r9r+EHLYGxfydvDES1sJ6bVlfSwd2k5Fir1da+ZUmv627WLekGJYbx3FvrfIwaUmdrM4/g=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2918.namprd15.prod.outlook.com (20.178.236.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 18:18:33 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 18:18:33 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "Alexei Starovoitov" <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 4/5] btf: fix bug with resolving STRUCT/UNION
 into corresponding FWD
Thread-Topic: [PATCH bpf-next 4/5] btf: fix bug with resolving STRUCT/UNION
 into corresponding FWD
Thread-Index: AQHUzu6LxMJBC3QSWkCA7/52JYSkCqX1hi8A
Date:   Thu, 28 Feb 2019 18:18:32 +0000
Message-ID: <797b56c0-2178-a0b1-3070-721c2fd4d38c@fb.com>
References: <20190227224642.1069138-1-andriin@fb.com>
 <20190227224642.1069138-5-andriin@fb.com>
In-Reply-To: <20190227224642.1069138-5-andriin@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0070.namprd16.prod.outlook.com
 (2603:10b6:907:1::47) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:e2ab]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81e4a9eb-64ec-48c2-45e5-08d69da92594
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2918;
x-ms-traffictypediagnostic: BYAPR15MB2918:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2918;20:6N15YsR3l3NBXu3TZx+N4BFkgwAGRxXN5W1EVFCvSelf/NS4kJeEjYU/laIfqIU6i3xhqgVYZwpYEcGL+ATTAkLUvkfpibCwrJ5Ykw0hCume37faUlTei/e7oCrqSJ2jHl4y/sxTM9Pya3r2+P3THsrXxZCbeMu6yc893MB0puw=
x-microsoft-antispam-prvs: <BYAPR15MB2918F834B0C4DF089D58B702D3750@BYAPR15MB2918.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(14444005)(6436002)(2906002)(71200400001)(86362001)(8676002)(31686004)(71190400001)(386003)(14454004)(478600001)(5660300002)(229853002)(6512007)(81156014)(316002)(8936002)(31696002)(6116002)(105586002)(110136005)(2201001)(6486002)(7736002)(106356001)(256004)(97736004)(52116002)(486006)(99286004)(186003)(446003)(2616005)(476003)(11346002)(81166006)(6246003)(25786009)(305945005)(53936002)(2501003)(76176011)(46003)(36756003)(68736007)(53546011)(6506007)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2918;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eljzHKgXVbOA0lcI2c5BeiAWyLHQ3u9LciCFDV57IZhVXrhzP7Ownu7Jmon0FwJlfz7OTAwK037GlTzewQOqhkQrShuBEWDpf/NhfJJwIWU4KaOUAa26GyZK7uQN5kJpEp/h04s8RKwzi7QjppGBR+S84+mHKAkyNaLi3aRSiStLz+a3bmhzGlO9MG34TQKJHTPFq6n4h/vFNaaYdVeSmeQqObS5nvXLK/DN79x8IttzgGQk/DRRO/QAyIeXUP6MwvLFpw2/crCRbPdnro81c7daUVRgCWXGsrO8ptqF1kra0lFBnXPyAYu4hTl8F2a13YvTlSEZ7inwjOApNPpCnNwuCb43uQcKdfAcMVDAz7IFWeQFzrUmsgbidFMO+wb5glyDayAE95yQlWHHGttNyfZra1GKZcm8a1dNdRqbkqE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC76694F67F3A245BB58562738D44C9E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e4a9eb-64ec-48c2-45e5-08d69da92594
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 18:18:32.9184
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

DQoNCk9uIDIvMjcvMTkgMjo0NiBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBXaGVuIGNo
ZWNraW5nIGF2YWlsYWJsZSBjYW5vbmljYWwgY2FuZGlkYXRlcyBmb3Igc3RydWN0L3VuaW9uIGFs
Z29yaXRobQ0KPiB1dGlsaXplcyBidGZfZGVkdXBfaXNfZXF1aXYgdG8gZGV0ZXJtaW5lIGlmIGNh
bmRpZGF0ZSBpcyBzdWl0YWJsZS4gVGhpcw0KPiBjaGVjayBpcyBub3QgZW5vdWdoIHdoZW4gY2Fu
ZGlkYXRlIGlzIGNvcnJlc3BvbmRpbmcgRldEIGZvciB0aGF0DQo+IHN0cnVjdC91bmlvbiwgYmVj
YXVzZSBhY2NvcmRpbmcgdG8gZXF1aXZhbGVuY2UgbG9naWMgdGhleSBhcmUNCj4gZXF1aXZhbGVu
dC4gV2hlbiBpdCBzbyBoYXBwZW5zIHRoYXQgRldEIGFuZCBTVFJVQ1QvVU5JT04gZW5kIGluIGhh
c2hpbmcNCj4gdG8gdGhlIHNhbWUgYnVja2V0LCBpdCdzIHBvc3NpYmxlIHRvIGNyZWF0ZSByZW1h
cHBpbmcgbG9vcCBmcm9tIEZXRCB0bw0KPiBTVFJVQ1QgYW5kIFNUUlVDVCB0byBzYW1lIEZXRCwg
d2hpY2ggd2lsbCBjYXVzZSBidGZfZGVkdXAoKSB0byBsb29wDQo+IGZvcmV2ZXIuDQo+IA0KPiBU
aGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBhZGRpdGlvbmFsbHkgY2hlY2tpbmcgdGhhdCB0
eXBlIGFuZA0KPiBjYW5vbmljYWwgY2FuZGlkYXRlIGFyZSBzdHJpY3RseSBlcXVhbCAodXRpbGl6
aW5nIGJ0Zl9lcXVhbF9zdHJ1Y3QpLg0KDQpJdCBsb29rcyBsaWtlIGJ0Zl9lcXVhbF9zdHJ1Y3Qo
KSBjaGVja2luZyBlcXVhbGl0eSBleGNlcHQNCm1lbWJlciB0eXBlIGlkJ3MuIE1heWJlIGNhbGxp
bmcgaXQgYnRmX2FsbW9zdF9lcXVhbF9zdHJ1Y3QoKSBvciANCnNvbWV0aGluZyBsaWtlIHRoYXQ/
DQoNCj4gDQo+IEZpeGVzOiBkNWNhZWY1YjU2NTUgKCJidGY6IGFkZCBCVEYgdHlwZXMgZGVkdXBs
aWNhdGlvbiBhbGdvcml0aG0iKQ0KPiBSZXBvcnRlZC1ieTogQXJuYWxkbyBDYXJ2YWxobyBkZSBN
ZWxvIDxhY21lQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJpaSBOYWtyeWlrbyA8
YW5kcmlpbkBmYi5jb20+DQo+IC0tLQ0KPiAgIHRvb2xzL2xpYi9icGYvYnRmLmMgfCA2ICsrKysr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2J0Zi5jIGIvdG9vbHMvbGliL2JwZi9idGYu
Yw0KPiBpbmRleCA2YmJiNzEwMjE2ZTYuLjUzZGIyNmQxNThjOSAxMDA2NDQNCj4gLS0tIGEvdG9v
bHMvbGliL2JwZi9idGYuYw0KPiArKysgYi90b29scy9saWIvYnBmL2J0Zi5jDQo+IEBAIC0yMjU1
LDcgKzIyNTUsNyBAQCBzdGF0aWMgdm9pZCBidGZfZGVkdXBfbWVyZ2VfaHlwb3RfbWFwKHN0cnVj
dCBidGZfZGVkdXAgKmQpDQo+ICAgc3RhdGljIGludCBidGZfZGVkdXBfc3RydWN0X3R5cGUoc3Ry
dWN0IGJ0Zl9kZWR1cCAqZCwgX191MzIgdHlwZV9pZCkNCj4gICB7DQo+ICAgCXN0cnVjdCBidGZf
ZGVkdXBfbm9kZSAqY2FuZF9ub2RlOw0KPiAtCXN0cnVjdCBidGZfdHlwZSAqdDsNCj4gKwlzdHJ1
Y3QgYnRmX3R5cGUgKmNhbmRfdHlwZSwgKnQ7DQo+ICAgCS8qIGlmIHdlIGRvbid0IGZpbmQgZXF1
aXZhbGVudCB0eXBlLCB0aGVuIHdlIGFyZSBjYW5vbmljYWwgKi8NCj4gICAJX191MzIgbmV3X2lk
ID0gdHlwZV9pZDsNCj4gICAJX191MTYga2luZDsNCj4gQEAgLTIyNzUsNiArMjI3NSwxMCBAQCBz
dGF0aWMgaW50IGJ0Zl9kZWR1cF9zdHJ1Y3RfdHlwZShzdHJ1Y3QgYnRmX2RlZHVwICpkLCBfX3Uz
MiB0eXBlX2lkKQ0KPiAgIAlmb3JfZWFjaF9kZWR1cF9jYW5kKGQsIGgsIGNhbmRfbm9kZSkgew0K
PiAgIAkJaW50IGVxOw0KPiAgIA0KPiArCQljYW5kX3R5cGUgPSBkLT5idGYtPnR5cGVzW2NhbmRf
bm9kZS0+dHlwZV9pZF07DQo+ICsJCWlmICghYnRmX2VxdWFsX3N0cnVjdCh0LCBjYW5kX3R5cGUp
KQ0KDQpUaGUgY29tbWVudCBmb3IgdGhpcyBidGZfZXF1YWxfc3RydWN0IGlzIG5vdCBxdWl0ZSBy
aWdodC4NCi8qDQogICogQ2hlY2sgc3RydWN0dXJhbCBjb21wYXRpYmlsaXR5IG9mIHR3byBGVU5D
X1BST1RPcywgaWdub3JpbmcgDQpyZWZlcmVuY2VkIHR5cGUNCiAgKiBJRHMuIFRoaXMgY2hlY2sg
aXMgcGVyZm9ybWVkIGR1cmluZyB0eXBlIGdyYXBoIGVxdWl2YWxlbmNlIGNoZWNrIGFuZA0KICAq
IHJlZmVyZW5jZWQgdHlwZXMgZXF1aXZhbGVuY2UgaXMgY2hlY2tlZCBzZXBhcmF0ZWx5Lg0KICAq
Lw0Kc3RhdGljIGJvb2wgYnRmX2VxdWFsX3N0cnVjdChzdHJ1Y3QgYnRmX3R5cGUgKnQxLCBzdHJ1
Y3QgYnRmX3R5cGUgKnQyKQ0KDQpJdCBzaG91bGQgYmUgdHdvICJzdHJ1Y3QvdW5pb24gdHlwZXMi
Lg0KDQo+ICsJCQljb250aW51ZTsNCj4gKw0KDQpJIGRpZCBub3QgdHJhY2UgdGhlIGFsZ29yaXRo
bSBob3cgaW5maW5pdGUgbG9vcCBoYXBwZW5zLiBCdXQgdGhlIGFib3ZlDQpjaGFuZ2UgaXMgY2Vy
dGFpbmx5IGEgY29ycmVjdCBvbmUsIHlvdSB3YW50IHRvIGRvIGRlZHVwbGljYXRpb24gb25seSAN
CmFmdGVyIGV2ZXJ5dGhpbmcgZWxzZSAoZXhjZXB0IG1lbWJlciB0eXBlcykgYXJlIGV1cWFsPw0K
DQpJZiB0aGUgYnVnIGlzIGR1ZSB0byBjaXJjbGUgaW4gc3RydWN0LT5md2QgYW5kIGZ3ZC0+c3Ry
dWN0IG1hcHBpbmdzLA0KbWF5YmUgYSBzaW1wbGUgY2hlY2sgd2hldGhlciBzdWNoIGNpcmNsZSBl
eGlzdHMgb3Igbm90IGJlZm9yZSB1cGRhdGUNCnRoZSBtYXBwaW5nIHdpbGwgYWxzbyB3b3JrPyBJ
IGFtIG5vdCBwcm9wb3NpbmcgdGhpcyBmaXgsIGJ1dCB3YW50DQp0byB1bmRlcnN0YW5kIGJldHRl
ciB0aGUgaXNzdWUuDQoNCg0KDQoNCj4gICAJCWJ0Zl9kZWR1cF9jbGVhcl9oeXBvdF9tYXAoZCk7
DQo+ICAgCQllcSA9IGJ0Zl9kZWR1cF9pc19lcXVpdihkLCB0eXBlX2lkLCBjYW5kX25vZGUtPnR5
cGVfaWQpOw0KPiAgIAkJaWYgKGVxIDwgMCkNCj4gDQo=
