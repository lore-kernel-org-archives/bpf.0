Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F2AC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 18:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330102082A
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 18:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TmBD14DM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="C1abG0Jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfDJSgR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:36:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38262 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730931AbfDJSgQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Apr 2019 14:36:16 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AIUdCp026394;
        Wed, 10 Apr 2019 11:35:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=q6EV6JKGBrZYgasFTNMpi9jrX6H+jlEtnGWQe6RZiFg=;
 b=TmBD14DMa61MBPlaMSw3NHotHlS8vg2cP1QjEtXMIagqhyGsmUm+mlsN1Pz3Y16Uazbt
 nFUvHE7FmspZ0zYS9/woVPfuxpvDDjuhYuxPiQlyNp5Tnx/2dEdT6XeniTfdooPAx7OM
 EyqKZi7GelDjnATACGsvGPnJsrJ90reboz4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rsmdwrehp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Apr 2019 11:35:24 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 10 Apr 2019 11:35:23 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Apr 2019 11:35:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6EV6JKGBrZYgasFTNMpi9jrX6H+jlEtnGWQe6RZiFg=;
 b=C1abG0JyR0Ot8YFe/ZTiubM0bq4JgUqFMZaHj1+PYXTTAD2DQ1hBRG2xI8yIw0C4H2aYCSz8RRvJr8i5SaVS5I9dIpRBs4c2wSbvkysSOaDc4I+yKzX3bYQHIJG5E7MkIuRcN/BE7VW+xf2EErGynGCP1Zp7NmYh+buGaEIVAtE=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3512.namprd15.prod.outlook.com (20.179.60.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 10 Apr 2019 18:35:22 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e%5]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 18:35:22 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
Thread-Topic: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
Thread-Index: AQHU76oCY0hWPKPN/k284b75C7IYIKY1K1yAgAB4aYCAAAcQAIAADiKA
Date:   Wed, 10 Apr 2019 18:35:21 +0000
Message-ID: <a3777ba4-467d-b24e-ec7c-91da09c10f10@fb.com>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
 <813645e9-6a09-4aa4-0e2e-9b68359b83db@fb.com>
 <4150a0db-18f9-aa93-cdb4-8cf047093740@iogearbox.net>
 <20190410174444.26ebmnwpsiw6eicz@linutronix.de>
In-Reply-To: <20190410174444.26ebmnwpsiw6eicz@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:300:ee::19) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:61dc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba4a819e-0ec2-4c89-5ba7-08d6bde349f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3512;
x-ms-traffictypediagnostic: BYAPR15MB3512:
x-microsoft-antispam-prvs: <BYAPR15MB35124EFC72ABAED8FD9F7915D32E0@BYAPR15MB3512.namprd15.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(52314003)(8676002)(6116002)(31696002)(478600001)(99286004)(305945005)(110136005)(68736007)(71200400001)(71190400001)(14454004)(105586002)(2906002)(7736002)(316002)(93886005)(106356001)(97736004)(54906003)(6486002)(229853002)(6436002)(256004)(53546011)(76176011)(14444005)(52116002)(102836004)(4326008)(46003)(53936002)(31686004)(6506007)(36756003)(86362001)(476003)(186003)(486006)(6246003)(11346002)(81166006)(446003)(6512007)(81156014)(2616005)(386003)(8936002)(25786009)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3512;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: maVagpr8TpaA+9VrivZ27F9B9x2M6O1ejII7taje4c8NSkC92Yg6VRUP0YBNKrRYu/WpqCDhP6gyeO9w3zBhkfG9L8BIUQtbkTYO/t3Q/wVZPCs9INNO+KTsdJJ7U2TC9GLM4cP2u/B3z2hx02EBU0tEV245cq8z2Sp6dU5LaT1hOqyrdeCwxnHI19ncZdgYLNpP5FYNNrcBNJp7rgmCHKx97saoDAZhPjETLW2sTINGOqg7QhcYXJi0Cc1yu9nfBnlLW0sgXx3wtKrdVyMjdsyq3Md4+PlT3jfSlaG1+ycg+ue7m7Z4xwLl+xXc4qR9dP+mWu3uPRHyPBSHBguRoEodlUc5P7B0y5yVB25E7FVeMUdH78BoTekpunnuiRugF5HVT7AlKa5UdELDs5f9oDY/GsEYtWDx1Nlx15+TwVU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0DA1DFEDA6FFD45AE1DE12DAD3BFA09@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4a819e-0ec2-4c89-5ba7-08d6bde349f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 18:35:21.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMTAvMTkgMTA6NDQgQU0sIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6
DQo+IE9uIDIwMTktMDQtMTAgMTk6MTk6MjcgWyswMjAwXSwgRGFuaWVsIEJvcmttYW5uIHdyb3Rl
Og0KPj4gT24gMDQvMTAvMjAxOSAwNzowOCBQTSwgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4+PiBP
biA0LzEwLzE5IDc6MzAgQU0sIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+Pj4+
IFRoZXJlIGlzIG5vIGRpZmZlcmVuY2UgYmV0d2VlbiBzcGlubG9ja190IGFuZCByYXdfc3Bpbmxv
Y2tfdCBmb3IgIVJUDQo+Pj4+IGtlcm5lbHMuIEl0IGlzIHBvc3NpYmxlIHRoYXQgYnBmX2xydV9s
aXN0X3BvcF9mcmVlX3RvX2xvY2FsKCkgaW52b2tlcw0KPj4+PiBhdCBsZWFzdCB0aHJlZSBsaXN0
IHdhbGtzIHdoaWNoIGxvb2sgdW5ib3VuZGVkIGl0IHByb2JhYmx5IG1ha2VzIHNlbnNlDQo+Pj4+
IHRvIHVzZSBzcGlubG9ja190Lg0KPj4+Pg0KPj4+PiBNYWtlIGJwZl9scnVfbGlzdCB1c2UgYSBz
cGlubG9ja190Lg0KPj4+DQo+Pj4gQ291bGQgeW91IGFkZCBhIGNvdmVyIGxldHRlciBmb3IgdGhl
IHBhdGNoIHNldCBzaW5jZSB5b3UgaGF2ZQ0KPj4+IG1vcmUgdGhhbiBvbmUgcGF0Y2g/DQo+IA0K
PiB5ZXMuDQo+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9y
IDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+Pj4+IC0tLQ0KPj4+PiAgICBrZXJuZWwvYnBmL2Jw
Zl9scnVfbGlzdC5jIHwgMzggKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+Pj4gICAga2VybmVsL2JwZi9icGZfbHJ1X2xpc3QuaCB8ICA0ICsrLS0NCj4+Pj4gICAgMiBm
aWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+
Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvYnBmX2xydV9saXN0LmMgYi9rZXJuZWwvYnBmL2Jw
Zl9scnVfbGlzdC5jDQo+Pj4+IGluZGV4IGU2ZWY0NDAxYTEzODAuLjQwZjQ3MjEwYzM4MTcgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2tlcm5lbC9icGYvYnBmX2xydV9saXN0LmMNCj4+Pj4gKysrIGIva2Vy
bmVsL2JwZi9icGZfbHJ1X2xpc3QuYw0KPj4+PiBAQCAtMzEzLDkgKzMxMyw5IEBAIHN0YXRpYyB2
b2lkIGJwZl9scnVfbGlzdF9wdXNoX2ZyZWUoc3RydWN0IGJwZl9scnVfbGlzdCAqbCwNCj4+Pj4g
ICAgCWlmIChXQVJOX09OX09OQ0UoSVNfTE9DQUxfTElTVF9UWVBFKG5vZGUtPnR5cGUpKSkNCj4+
Pj4gICAgCQlyZXR1cm47DQo+Pj4+ICAgIA0KPj4+PiAtCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgm
bC0+bG9jaywgZmxhZ3MpOw0KPj4+PiArCXNwaW5fbG9ja19pcnFzYXZlKCZsLT5sb2NrLCBmbGFn
cyk7DQo+Pj4+ICAgIAlfX2JwZl9scnVfbm9kZV9tb3ZlKGwsIG5vZGUsIEJQRl9MUlVfTElTVF9U
X0ZSRUUpOw0KPj4+PiAtCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZsLT5sb2NrLCBmbGFn
cyk7DQo+Pj4+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbC0+bG9jaywgZmxhZ3MpOw0KPj4+
PiAgICB9DQo+Pj4NCj4+PiBUaGlzIGZ1bmN0aW9uIChwbHVzIG1hbnkgb3RoZXJzKSBpcyBjYWxs
ZWQgYnkgYnBmIHByb2dyYW0gaGVscGVycyB3aGljaA0KPj4+IGNhbm5vdCBzbGVlcC4gSXMgaXQg
cG9zc2libGUgdGhhdCB1bmRlciBSVCBzcGluX2xvY2tfaXJxc2F2ZSgpIGNvdWxkDQo+Pj4gc2xl
ZXAgYW5kIHRoaXMgd2lsbCBtYWtlIGJwZiBzdWJzeXN0ZW0gY2Fubm90IGJlIHVzZWQgdW5kZXIg
UlQ/DQo+Pg0KPj4gQmFjayB0aGVuIGluIGFjMDA4ODFmOTIyMSAoImJwZjogY29udmVydCBoYXNo
dGFiIGxvY2sgdG8gcmF3IGxvY2siKQ0KPj4gWWFuZyBTaGkgY29udmVydGVkIHNwaW5sb2NrX3Qg
dG8gcmF3X3NwaW5sb2NrX3QgZHVlIHRvIGV4YWN0bHkgdGhlDQo+PiBhYm92ZSBtZW50aW9uZWQg
aXNzdWUuIEkgcHJlc3VtZSB0aGF0IGhhc24ndCBjaGFuZ2VkLCByaWdodD8NCj4gDQo+IEFoLiBJ
IGNoZWNrZWQgb25lIG9yIHR3byBvZiB0aG9zZSBhbmQgaXQgbG9va2VkIGxpa2UgaXQgd2FzIHJh
dyBzaW5jZQ0KPiB0aGUgYmVnaW5uaW5nLiBBbnl3YXksIGl0IHdvdWxkIGJlIG5pY2UgdG8gQ2M6
IHRoZSBSVCBkZXZlbG9wZXIgd2hpbGUNCj4gZmlkZGxpbmcgd2l0aCBzb21ldGhpbmcgdGhhdCBv
bmx5IGNvbmNlcm5zIFJULg0KPiANCj4gVGhhdCB1c2FnZSBwYXR0ZXJuIHRoYXQgaXMgbWVudGlv
bmVkIGluIGFjMDA4ODFmOTIyMSwgaXMgaXQgdHJ1ZSBmb3IgYWxsDQo+IGRhdGEgc3RydWN0dXJl
IGFsZ29yaXRobXM/IEluIGJwZl9scnVfbGlzdCBJIHdhcyBjb25jZXJuZWQgYWJvdXQgdGhlDQo+
IGxpc3QgbG9vcHMuIA0KRm9yIHNvbWUgc2tld2VkIGhhc2ggdGFibGVzIHdpdGggYSBsb3Qgb2Yg
ZWxlbWVudHMsIHllcywgaXQgaXMgcG9zc2libGUNCnRpbWUgdG8gdHJhdmVyc2UgdGhlIGxvb3Ag
Y291bGQgYmUgYSBsaXR0bGUgYml0IGxvbmdlci4uLg0KDQo+IEhvd2V2ZXIgaGFzaHRhYiBhbmQg
bHBtX3RyaWUgbWF5IHBlcmZvcm0gbWVtb3J5IGFsbG9jYXRpb25zDQo+IHdoaWxlIGhvbGRpbmcg
dGhlIGxvY2sgYW5kIHRoaXMgaXNuJ3QgZ29pbmcgdG8gd29yay4NCg0KVGhlIG1lbW9yeSBhbGxv
Y2F0aW9uIGluIHRoZXNlIHR3byBwbGFjZXMgdXNlcyBHRlBfQVRPTUlDIHdoaWNoIHNob3VsZCAN
Cm5vdCBzbGVlcC9ibG9jay4NCg0KPiANCj4gU2ViYXN0aWFuDQo+IA0K
