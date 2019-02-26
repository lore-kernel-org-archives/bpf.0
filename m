Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA600C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 05:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786F62173C
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 05:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mPAAvSwS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VSDHX9f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfBZFiH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:38:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbfBZFiH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Feb 2019 00:38:07 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q5buSi031486;
        Mon, 25 Feb 2019 21:38:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JGaDKvTJZ+GoxICMCNoHobxcxmx23C2oPKTuzLQbh2o=;
 b=mPAAvSwScUH/DuQxbMt1salfy5P+oKpughwShvPB/Jh1IvhGNVWBNDDXUPCF/Gfuuq7G
 3SXiipZoqgJpV3jwriwRdXQAUfpeR9zC4Y73+lzhE+deMqIpPXvxPE/BDssFT2XV1Uij
 ulzQra+SeR2+Vdk2Aei1Msvjb+TzEDFClSU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvv94gg5s-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 21:38:04 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 21:38:03 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 25 Feb 2019 21:38:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGaDKvTJZ+GoxICMCNoHobxcxmx23C2oPKTuzLQbh2o=;
 b=VSDHX9f0KI1JDpd+YxN8hMFLBDwef5FSUSeXR5cnZ6igcrZCWhqChU/ZXlOm/b59EPEnlTsR8aRHfG8eBco5pnE7XnRSo5cDaotm1g5wINIDrfmN5dIYsE9tBHHG8O0jRjZBycQhmPW2/nlAJ0bv3o9A4PcVyaho6kUSU96XJzs=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2567.namprd15.prod.outlook.com (20.179.155.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 05:37:47 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 05:37:47 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling of
 bitfields in btf_loader
Thread-Topic: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling
 of bitfields in btf_loader
Thread-Index: AQHUyV718vJZBQQRBk+lN3pcSmGlf6XsYe2AgAAWrACABDu5gIAAMYCAgAAL64CAAAc8AIAAC/2AgAAMw4CAAIZHgA==
Date:   Tue, 26 Feb 2019 05:37:46 +0000
Message-ID: <9033db30-1aab-69ae-dc2c-7dfa2585ead3@fb.com>
References: <20190220205732.2514975-1-andriin@fb.com>
 <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
 <20190225200822.GB13100@kernel.org>
 <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
 <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
In-Reply-To: <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:20dd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51d1e24d-1fff-4083-1d1f-08d69bac8999
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2567;
x-ms-traffictypediagnostic: BYAPR15MB2567:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2567;20:ZK4DRzSDkjyoWG76mVvhabOGaGdy7m6y9UbvWhnVeAGP9Le7MfeeXSLfG9FxYS3QM+GLnfr/EDPrE/xjP4VRY/gIuaQIle5EqxqDJMLCgKvpvlQTnKoAOr4RFGh2OLwqCk2e8aEG9YebrIUK/4u2769+k8oz6EMvxsLYQqLsbVI=
x-microsoft-antispam-prvs: <BYAPR15MB25672AB3762195CAFCA68593D37B0@BYAPR15MB2567.namprd15.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(6116002)(86362001)(316002)(97736004)(8936002)(25786009)(110136005)(8676002)(81166006)(81156014)(54906003)(6512007)(6486002)(478600001)(305945005)(6436002)(31696002)(36756003)(14454004)(229853002)(71200400001)(71190400001)(68736007)(486006)(476003)(2906002)(7736002)(446003)(105586002)(99286004)(106356001)(186003)(53936002)(386003)(6506007)(53546011)(6246003)(102836004)(2616005)(11346002)(31686004)(93886005)(52116002)(76176011)(5660300002)(19627235002)(4326008)(256004)(46003)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2567;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UumLFVF08IufTpY8oymeHPV0aXD05WykSV9B618h+eAppx8yOeIuOfiWcglB1TQdOu7PlsP+OwHi5RlPTTZrNU78Oloog8g6adevyJEh5NI1sSZYpFpID1B4vJbDU8HvN8171DVF59+mLKxtOvqP6UffdGhZPX2AG2HpJdvYFzdBT1fkC41WOyRD8V0+/gomoCMeyehsAHSMBUgf97tzvdO0WcU0DEpZb+a7Rv03reWplvYebFvKedxGbg6D1eb3eUqAgGBhT3cM/+h7msW5xfKqEz6tjNiuQNWaKPx0f0+IkaoABMZWPXD8ErdqyqnnNnkr1Fz7BvkLUkTem8VWUk7xBAdiQ3LbRCRvwbPn4ZXvsR2ulNhQRtrYZMKyIFwDdzWudJ8+EpSE9fBTSE7gZ1+A3gZ9zzplOjNaAHsCf0w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3650AC4B8F7B1547B8ABC6B9DF0910CF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d1e24d-1fff-4083-1d1f-08d69bac8999
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 05:37:45.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2567
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjUvMTkgMTozNiBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBPbiBNb24s
IEZlYiAyNSwgMjAxOSBhdCAxMjo1MSBQTSBBbmRyaWkgTmFrcnlpa28NCj4gPGFuZHJpaS5uYWty
eWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIE1vbiwgRmViIDI1LCAyMDE5IGF0IDEy
OjA4IFBNIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPj4gPGFybmFsZG8ubWVsb0BnbWFpbC5j
b20+IHdyb3RlOg0KPj4+DQo+Pj4gRW0gTW9uLCBGZWIgMjUsIDIwMTkgYXQgMTE6NDI6MjlBTSAt
MDgwMCwgQW5kcmlpIE5ha3J5aWtvIGVzY3JldmV1Og0KPj4+PiBPbiBNb24sIEZlYiAyNSwgMjAx
OSBhdCAxMTowMCBBTSBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8+IDxhcm5hbGRvLm1lbG9AZ21h
aWwuY29tPiB3cm90ZToNCj4+Pg0KPj4+Pj4gRW0gTW9uLCBGZWIgMjUsIDIwMTkgYXQgMDE6MDI6
MzlQTSAtMDMwMCwgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIGVzY3JldmV1Og0KPj4+Pj4+IFNv
IHllYWgsIHRoZSBCVEYgZW5jb2Rlci9kZWNvZGVyIGlzIHdvcmtpbmcganVzdCBmaW5lLCB0aGUg
cHJvYmxlbSBpcyBpbg0KPj4+Pj4+IHBhaG9sZSdzIERXQVJGIGNvZGUsIGxlbW1lIHNlZS4uLg0K
Pj4+Pj4NCj4+Pj4+IFBsZWFzZSB0cnkgdGhlIHBhdGNoIGJlbG93LCBmb3IgbWUgYnRmZGlmZiBj
b250aW51ZXMgdG8gc2hvdyBubyBkaWZmIGZvcg0KPj4+Pj4gYWxsIHR5cGVzIGluIG15IHZtbGlu
dXggYW5kIG5vdyBpdCBhbHNvIHByb2R1Y2VzIHRoZSBzYW1lIG91dHB1dCBmb3INCj4+Pj4+IHdo
ZW4gdGhlIGZpcnN0IGVsZW1lbnQgb2YgYSBiaXRmaWVsZCBoYXMgaXRzIGJpdF9zaXplIGVxdWFs
IHRvIGl0cw0KPj4+Pj4gYnl0ZV9zaXplICogODoNCj4+Pj4NCj4+Pj4gWWVzLCB0aGlzIGZpeGVz
IGFsbCB0aGUgaXNzdWVzIEkndmUgc2Vlbi4gYnRmZGlmZiBvdXRwdXQgaXMgbm93IGVtcHR5DQo+
Pj4+IGZvciBteSBrZXJuZWwgaW1hZ2UuIFRoYW5rcyBmb3IgcXVpY2sgZml4IQ0KPj4+Pg0KPj4+
PiBSZXZpZXdlZC1ieTogQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWluQGZiLmNvbT4NCj4+Pg0KPj4+
IFRoYW5rcywganVzdCBmb3Igc29tZSBleHRyYSB0ZXN0aW5nIEkgdHJpZWQgZW5jb2RpbmcgQlRG
IGZvciBnbGliYyAyLjI4Og0KPj4+DQo+Pj4gW2FjbWVAcXVhY28gcGFob2xlXSQgcGFob2xlIC1K
ViBsaWJjLTIuMjguc28uZGVidWcNCj4+PiA8QklHIHNuaXA+DQo+Pg0KPj4gPHNuaXA+DQo+Pg0K
Pj4+IFszODYwNzVdIElOVCBsb25nIHVuc2lnbmVkIGludCBzaXplPTggYml0X29mZnNldD0wIG5y
X2JpdHM9NjQgZW5jb2Rpbmc9KG5vbmUpDQo+Pj4gQ2Fubm90IG9wZW4gbGliYy0yLjI4LnNvLmRl
YnVnDQo+Pj4gRmFpbGVkIHRvIGVuY29kZSBCVEYNCj4+DQo+PiBJJ3ZlIHRyaWVkIHRoZSBzYW1l
IG9uIGxpYmMtMi4yNi5zby5kZWJ1ZyBhbmQgaXQgd29ya2VkLg0KPj4NCj4+IEl0IGZhaWxlcyBh
ZnRlciBCVEYgZW5jb2RpbmcgYW5kIGRlZHVwaW5nIGlzIGRvbmUsIGV4YWN0bHkgd2hlbiBpdA0K
Pj4gdHJpZXMgdG8gcmUtb3BlbiBsaWJjLTIuMjguc28uZGVidWcgdG8gd3JpdGUgb3V0IG5ldyBj
b250ZW50cy4gTm90DQo+PiBzdXJlIHdoeSBpdCB3b3VsZCBmYWlsLCBhcyBpdCBzZWVtcyB0byBi
ZSBqdXN0IHBsYWluIG9wZW4oKSBjYWxsLCBidXQNCj4+IHRoZSBmYWN0IHRoYXQgd2UgYm90aCBj
YW4gcmVwcm8gdGhpcyBtZWFucyB0aGVyZSBpcyBzb21ldGhpbmcgdGhlcmUuDQo+Pg0KPj4gSXQg
YWxzbyBzZWVtcyB0aGF0IGxpYmMtMi4yOC5zby5kZWJ1ZyBpcyBjb3JydXB0ZWQ6DQo+Pg0KPj4g
JCByZWFkZWxmIC1uIC9ob21lL2FuZHJpaW4vbG9jYWwvYnRmL2xpYmMtMi4yNi5zby5kZWJ1ZyB8
IGdyZXANCj4+ICdVbmtub3duIG5vdGUgdHlwZScgfCB3YyAtbA0KPj4gMA0KPj4gJCByZWFkZWxm
IC1uIC9ob21lL2FuZHJpaW4vbG9jYWwvYnRmL2xpYmMtMi4yOC5zby5kZWJ1ZyB8IGdyZXANCj4+
ICdVbmtub3duIG5vdGUgdHlwZScgfCB3YyAtbA0KPj4gMTc5NTMNCj4+DQo+IA0KPiBJZ25vcmUg
ZXZlcnl0aGluZyBJJ3ZlIHNhaWQgKHRob3VnaCAnVW5rbm93biBub3RlIHR5cGUnIGlzc3VlIGlz
DQo+IHN0cmFuZ2UpLCBmb3IgbWUgaXQgd2FzIGp1c3QgcGVybWlzc2lvbnMgaXNzdWVzLg0KPiAN
Cj4gJCBjaG1vZCArcncgL2hvbWUvYW5kcmlpbi9sb2NhbC9idGYvbGliYy0yLjI4LnNvLmRlYnVn
DQo+IA0KPiAkIH4vbG9jYWwvcGFob2xlL2J1aWxkL3BhaG9sZSAtSiB+L2xvY2FsL2J0Zi9saWJj
LTIuMjguc28uZGVidWcNCj4gDQo+ICQgUEFIT0xFPX4vbG9jYWwvcGFob2xlL2J1aWxkL3BhaG9s
ZSAuL2J0ZmRpZmYgfi9sb2NhbC9idGYvbGliYy0yLjI4LnNvLmRlYnVnDQo+IGJhc2VfdHlwZV9f
bmFtZV90b19zaXplOiBiYXNlX3R5cGUgX0Zsb2F0MTI4DQo+IGNsYXNzX19maXh1cF9idGZfYml0
ZmllbGRzOiB1bmtub3duIGJhc2UgdHlwZSBuYW1lICJfRmxvYXQxMjgiIQ0KPiBiYXNlX3R5cGVf
X25hbWVfdG9fc2l6ZTogYmFzZV90eXBlIF9GbG9hdDEyOA0KPiBjbGFzc19fZml4dXBfYnRmX2Jp
dGZpZWxkczogdW5rbm93biBiYXNlIHR5cGUgbmFtZSAiX0Zsb2F0MTI4IiENCj4gYmFzZV90eXBl
X19uYW1lX3RvX3NpemU6IGJhc2VfdHlwZSBfRmxvYXQxMjgNCj4gY2xhc3NfX2ZpeHVwX2J0Zl9i
aXRmaWVsZHM6IHVua25vd24gYmFzZSB0eXBlIG5hbWUgIl9GbG9hdDEyOCIhDQo+IGJhc2VfdHlw
ZV9fbmFtZV90b19zaXplOiBiYXNlX3R5cGUgX0Zsb2F0MTI4DQo+IGNsYXNzX19maXh1cF9idGZf
Yml0ZmllbGRzOiB1bmtub3duIGJhc2UgdHlwZSBuYW1lICJfRmxvYXQxMjgiIQ0KPiBiYXNlX3R5
cGVfX25hbWVfdG9fc2l6ZTogYmFzZV90eXBlIF9GbG9hdDEyOA0KPiBjbGFzc19fZml4dXBfYnRm
X2JpdGZpZWxkczogdW5rbm93biBiYXNlIHR5cGUgbmFtZSAiX0Zsb2F0MTI4IiENCj4gYmFzZV90
eXBlX19uYW1lX3RvX3NpemU6IGJhc2VfdHlwZSBfRmxvYXQxMjgNCj4gY2xhc3NfX2ZpeHVwX2J0
Zl9iaXRmaWVsZHM6IHVua25vd24gYmFzZSB0eXBlIG5hbWUgIl9GbG9hdDEyOCIhDQo+IC0tLSAv
dG1wL2J0ZmRpZmYuZHdhcmYuYVY0d1NMICAgMjAxOS0wMi0yNSAxMzozMTo1NC43ODc5MjM2NzMg
LTA4MDANCj4gKysrIC90bXAvYnRmZGlmZi5idGYuMjJOUW1KICAgICAyMDE5LTAyLTI1IDEzOjMx
OjU0LjgwMjkyMzY2OCAtMDgwMA0KPiBAQCAtNDYxLDkgKzQ2MSwxNSBAQCBzdHJ1Y3QgTGFfeDg2
XzY0X3JldHZhbCB7DQo+ICAgICAgICAgIHVpbnQ2NF90ICAgICAgICAgICAgICAgICAgIGxydl9y
ZHg7ICAgICAgICAgICAgICAvKiAgICAgOCAgICAgOCAqLw0KPiAgICAgICAgICBMYV94ODZfNjRf
eG1tICAgICAgICAgICAgICBscnZfeG1tMDsgICAgICAgICAgICAgLyogICAgMTYgICAgMTYgKi8N
Cj4gICAgICAgICAgTGFfeDg2XzY0X3htbSAgICAgICAgICAgICAgbHJ2X3htbTE7ICAgICAgICAg
ICAgIC8qICAgIDMyICAgIDE2ICovDQo+IC0gICAgICAgbG9uZyBkb3VibGUgICAgICAgICAgICAg
ICAgbHJ2X3N0MDsgICAgICAgICAgICAgIC8qICAgIDQ4ICAgIDE2ICovDQo+ICsgICAgICAgbG9u
ZyBkb3VibGUgICAgICAgICAgICAgICAgbHJ2X3N0MDsgICAgICAgICAgICAgIC8qICAgIDQ4ICAg
ICA4ICovDQo+ICsNCj4gKyAgICAgICAvKiBYWFggOCBieXRlcyBob2xlLCB0cnkgdG8gcGFjayAq
Lw0KPiArDQo+ICAgICAgICAgIC8qIC0tLSBjYWNoZWxpbmUgMSBib3VuZGFyeSAoNjQgYnl0ZXMp
IC0tLSAqLw0KPiAtICAgICAgIGxvbmcgZG91YmxlICAgICAgICAgICAgICAgIGxydl9zdDE7ICAg
ICAgICAgICAgICAvKiAgICA2NCAgICAxNiAqLw0KPiArICAgICAgIGxvbmcgZG91YmxlICAgICAg
ICAgICAgICAgIGxydl9zdDE7ICAgICAgICAgICAgICAvKiAgICA2NCAgICAgOCAqLw0KPiArDQo+
ICsgICAgICAgLyogWFhYIDggYnl0ZXMgaG9sZSwgdHJ5IHRvIHBhY2sgKi8NCj4gKw0KPiAgICAg
ICAgICBMYV94ODZfNjRfdmVjdG9yICAgICAgICAgICBscnZfdmVjdG9yMDsgICAgICAgICAgLyog
ICAgODAgICAgNjQgKi8NCj4gICAgICAgICAgLyogLS0tIGNhY2hlbGluZSAyIGJvdW5kYXJ5ICgx
MjggYnl0ZXMpIHdhcyAxNiBieXRlcyBhZ28gLS0tICovDQo+ICAgICAgICAgIExhX3g4Nl82NF92
ZWN0b3IgICAgICAgICAgIGxydl92ZWN0b3IxOyAgICAgICAgICAvKiAgIDE0NCAgICA2NCAqLw0K
PiBAQCAtNDcyLDYgKzQ3OCw3IEBAIHN0cnVjdCBMYV94ODZfNjRfcmV0dmFsIHsNCj4gICAgICAg
ICAgX19pbnQxMjggICAgICAgICAgICAgICAgICAgbHJ2X2JuZDE7ICAgICAgICAgICAgIC8qICAg
MjI0ICAgIDE2ICovDQo+IA0KPiAgICAgICAgICAvKiBzaXplOiAyNDAsIGNhY2hlbGluZXM6IDQs
IG1lbWJlcnM6IDEwICovDQo+ICsgICAgICAgLyogc3VtIG1lbWJlcnM6IDIyNCwgaG9sZXM6IDIs
IHN1bSBob2xlczogMTYgKi8NCj4gICAgICAgICAgLyogbGFzdCBjYWNoZWxpbmU6IDQ4IGJ5dGVz
ICovDQo+ICAgfTsNCj4gICBzdHJ1Y3Qgcl9kZWJ1ZyB7DQo+IEBAIC0yMDQ0LDcgKzIwNTEsNyBA
QCB1bmlvbiBpZWVlNzU0X2Zsb2F0IHsNCj4gICAgICAgICAgfSBpZWVlX25hbjsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAvKiAgICAgMCAgICAgNCAqLw0KPiAgIH07DQo+ICAg
dW5pb24gaWVlZTg1NF9sb25nX2RvdWJsZSB7DQo+IC0gICAgICAgbG9uZyBkb3VibGUgICAgICAg
ICAgICAgICAgZDsgICAgICAgICAgICAgICAgICAvKiAgICAgMCAgICAxNiAqLw0KPiArICAgICAg
IGxvbmcgZG91YmxlICAgICAgICAgICAgICAgIGQ7ICAgICAgICAgICAgICAgICAgLyogICAgIDAg
ICAgIDggKi8NCj4gICAgICAgICAgc3RydWN0IHsNCj4gICAgICAgICAgICAgICAgICB1bnNpZ25l
ZCBpbnQgICAgICAgbWFudGlzc2ExOjMyOyAgICAgICAvKiAgICAgMDogMCAgNCAqLw0KPiAgICAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGludCAgICAgICBtYW50aXNzYTA6MzI7ICAgICAgIC8qICAg
ICA0OiAwICA0ICovDQo+IEBAIC0yMTQxLDcgKzIxNDgsNyBAQCBzdHJ1Y3QgdWNvbnRleHRfdCB7
DQo+ICAgICAgICAgIC8qIGxhc3QgY2FjaGVsaW5lOiA4IGJ5dGVzICovDQo+ICAgfTsNCj4gICB1
bmlvbiBpZWVlODU0X2Zsb2F0MTI4IHsNCj4gLSAgICAgICBfRmxvYXQxMjggICAgICAgICAgICAg
ICAgICBkOyAgICAgICAgICAgICAgICAgIC8qICAgICAwICAgIDE2ICovDQo+ICsgICAgICAgX0Zs
b2F0MTI4ICAgICAgICAgICAgICAgICAgZDsgICAgICAgICAgICAgICAgICAvKiAgICAgMCAgICAg
MCAqLw0KPiAgICAgICAgICBzdHJ1Y3Qgew0KPiAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGlu
dCAgICAgICBtYW50aXNzYTM6MzI7ICAgICAgIC8qICAgICAwOiAwICA0ICovDQo+ICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgaW50ICAgICAgIG1hbnRpc3NhMjozMjsgICAgICAgLyogICAgIDQ6
IDAgIDQgKi8NCj4gQEAgLTIyMTksNyArMjIyNiw3IEBAIHVuaW9uIHByaW50Zl9hcmcgew0KPiAg
ICAgICAgICBsb25nIHVuc2lnbmVkIGludCAgICAgICAgICBwYV91X2xvbmdfaW50OyAgICAgIC8q
ICAgICAwICAgICA4ICovDQo+ICAgICAgICAgIGxvbmcgbG9uZyB1bnNpZ25lZCBpbnQgICAgIHBh
X3VfbG9uZ19sb25nX2ludDsgLyogICAgIDAgICAgIDggKi8NCj4gICAgICAgICAgZG91YmxlICAg
ICAgICAgICAgICAgICAgICAgcGFfZG91YmxlOyAgICAgICAgICAvKiAgICAgMCAgICAgOCAqLw0K
PiAtICAgICAgIGxvbmcgZG91YmxlICAgICAgICAgICAgICAgIHBhX2xvbmdfZG91YmxlOyAgICAg
LyogICAgIDAgICAgMTYgKi8NCj4gKyAgICAgICBsb25nIGRvdWJsZSAgICAgICAgICAgICAgICBw
YV9sb25nX2RvdWJsZTsgICAgIC8qICAgICAwICAgICA4ICovDQo+ICAgICAgICAgIGNvbnN0IGNo
YXIgICogICAgICAgICAgICAgIHBhX3N0cmluZzsgICAgICAgICAgLyogICAgIDAgICAgIDggKi8N
Cj4gICAgICAgICAgY29uc3Qgd2NoYXJfdCAgKiAgICAgICAgICAgcGFfd3N0cmluZzsgICAgICAg
ICAvKiAgICAgMCAgICAgOCAqLw0KPiAgICAgICAgICB2b2lkICogICAgICAgICAgICAgICAgICAg
ICBwYV9wb2ludGVyOyAgICAgICAgIC8qICAgICAwICAgICA4ICovDQo+IA0KPiBTZWVtcyBsaWtl
ICJsb25nIGRvdWJsZSIgc2l6ZSBpcyBpbnZhbGlkIGZvciBCVEYuIEFuZCB3ZSBzaG91bGQNCj4g
cHJvYmFibHkgYWRkICJfRmxvYXQxMjgiIGFzIGFub3RoZXIgIndlbGwga25vd24iIGJhc2UgdHlw
ZSBuYW1lPw0KDQpCUEYgZG9lcyBub3Qgc3VwcG9ydCBmbG9hdGluZyBwb2ludCBpbnN0cnVjdGlv
bnMuIEFzIHRoZSByZXN1bHQsDQpCVEYgZGVzaWduIGRvZXMgbm90IGNvbnRhaW4gZmxvYXRpbmcg
cG9pbnQgdHlwZXMuDQoNCkxvb2tzIGxpa2Uga2VybmVsIGFsc28gdXNlcyBmbG9hdCB0eXBlcyAo
aW4gY2VydGFpbiBkcml2ZXJzIGFuZCBhcmNoJ3MpLCANCmJ1dCB0eXBlcyByZWZlcnJlZCBieSBi
cGYgcHJvZ3JhbSBtb3N0bHkgd2lsbCBub3QgY29udGFpbiBmbG9hdCB0eXBlcy4NCg0KQ3VycmVu
dGx5LCBib3RoIGxsdm0gYW5kIHBhaG9sZSB3aWxsIGlnbm9yZSBmbG9hdGluZyB0eXBlcywgc28N
CmZyb20gdHlwZSBjb21wYXJpc29uIHBvaW50IG9mIHZpZXcsIHdlIHdpbGwgYmUgZmluZS4NClRo
ZSBpc3N1ZSBtYXkgY29tZSB1cCB3aXRoIHBlb3BsZSB1c2luZyB2bWxpbnV4IEJURiBpbnNpZGUg
dGhlDQprZXJuZWwgZm9yIGRpZmZlcmVudCBwdXJwb3NlIHdoZXJlIGEgZmxvYXQgdHlwZSBuZWVk
cyB0byBiZQ0Kc3BlY2lmaWVkLCBlLmcuLCBmb3IgYSBmbG9hdGluZyBwb2ludCBmdW5jdGlvbiBh
cmd1bWVudCBpbiBmdHJhY2UuDQpCdXQgdGhpcyBpcyByYXJlIHRvby4NCg0KSSBhbSBub3QgMTAw
JSBzdXJlIHdoZXRoZXIgcGFob2xlIGR3YXJmL2J0ZiBwYXJpdHkgaXMgY29uc2lkZXJlZA0KYXMg
YSBzdHJvbmcgcmVhc29uIHRvIGFkZCBmbG9hdGluZyBwb2ludCB0eXBlIHN1cHBvcnQgaW4gQlRG
IG9yIG5vdC4NCg0KPiANCj4gVGhvdWdoIGZvciB0aGUgbGF0dGVyLCBpdCBwcm9iYWJseSB3b3Vs
ZCBiZSBiZXR0ZXIgdG8gcmVzb2x2ZSBiYXNlDQo+IHR5cGUgc2l6ZSB1c2luZyBCVEYgZGF0YSBp
dHNlbGYuDQo+IA0KPj4+IFthY21lQHF1YWNvIHBhaG9sZV0kDQo=
