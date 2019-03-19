Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA5C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FBA20863
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 18:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="WI7u56pX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCSSyP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:54:15 -0400
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:3143
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbfCSSyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 14:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FpZz6a6TRPDegfBqSFzK8PrW+Q9zFcNyn998nXesWs=;
 b=WI7u56pXfAePGfRWClatSr1/XpX0dSIzXsZM5mSGibEPdMiDORAmuTFtrZCVp6EkfUBEBV2Eo5EZhXBdqeYpSmf79+BUpYfheOMznAavuDw4cT0jLGUk3/Mtly8lV4j1ypCeIhTU4Q6RdcrHRFeULlfyl4Bsddsv7it4pdsKtu0=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB5867.eurprd05.prod.outlook.com (20.179.11.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 18:54:09 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 18:54:09 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "toke@redhat.com" <toke@redhat.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrew.gospodarek@broadcom.com" <andrew.gospodarek@broadcom.com>,
        "jesper.brouer@gmail.com" <jesper.brouer@gmail.com>,
        "bblanco@gmail.com" <bblanco@gmail.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "iovisor-dev@lists.iovisor.org" <iovisor-dev@lists.iovisor.org>,
        "bjorn.topel@gmail.com" <bjorn.topel@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kafai@fb.com" <kafai@fb.com>
Subject: Re: [RFC][Proposal] BPF Control MAP
Thread-Topic: [RFC][Proposal] BPF Control MAP
Thread-Index: AQHU1fCkExRpj7FhXEuQCQPQJa8CMKYTJwsAgAA3RgA=
Date:   Tue, 19 Mar 2019 18:54:08 +0000
Message-ID: <ea4391584d2321f8bf5a0e61ed1e05e5665bbf17.camel@mellanox.com>
References: <df010a2772ae07af29c9aac1c6d329b14203710c.camel@mellanox.com>
         <20190319153603.qfhp3nc5dxwgptlh@ast-mbp>
In-Reply-To: <20190319153603.qfhp3nc5dxwgptlh@ast-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59706a94-342e-4ce8-f47b-08d6ac9c44fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB5867;
x-ms-traffictypediagnostic: DB8PR05MB5867:
x-microsoft-antispam-prvs: <DB8PR05MB5867F59FACEEDF9EB8657653BE400@DB8PR05MB5867.eurprd05.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(97736004)(6916009)(106356001)(118296001)(2906002)(71190400001)(7416002)(71200400001)(6116002)(229853002)(3846002)(6246003)(2501003)(6512007)(316002)(1361003)(6486002)(4326008)(5024004)(54906003)(53936002)(256004)(14454004)(14444005)(99286004)(58126008)(6436002)(478600001)(476003)(7736002)(11346002)(5660300002)(2616005)(25786009)(86362001)(305945005)(446003)(2351001)(186003)(561944003)(66066001)(81156014)(486006)(6506007)(105586002)(68736007)(8676002)(8936002)(5640700003)(76176011)(26005)(102836004)(36756003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB5867;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 55oTaIzwEjbRBYw5U001z5qpnFgdoHbTnC0LsF5CXQwWm5rE9wA+X4BLuvW7mFYSH90kYj/2neNsN8ZQToBBfgVFRsOhHug+xA6BpsNdz18/6kIORaJ63q9n+MTAnqOj1HZ+NdF1JF5C499eSnCDtdec4beUm8XgLLTq+jCldJ7lSqB1Kd95lrSO0i2QnMsxjKvCmwI9iz/XUcI3AdwtJyZPrzMJ7ddBCnEQGC9p/LaLT2WHHHFGcE8SmtUheg5b0id8svYBuzFRFESYfGyI+/K0bk1nhK8padyim2nZsG6ubTJdkxoiwbnWge/myMFfoUoR8shIpDCDJ4+rA+USvXKS+rEDlkwq35HqxP8hzc08rHn0LAFa+O7P3eweHuVoFwSo+WpBpON3n/oQX4y9N32DVaGK8k2azhHtArkMHeA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32BE0A84D9138F4595C93DD8567E535F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59706a94-342e-4ce8-f47b-08d6ac9c44fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 18:54:08.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5867
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDE5LTAzLTE5IGF0IDA4OjM2IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIEZyaSwgTWFyIDA4LCAyMDE5IGF0IDA4OjUxOjAzUE0gKzAwMDAsIFNhZWVkIE1h
aGFtZWVkIHdyb3RlOg0KPiA+IFRob3VnaHRzID8NCj4gDQo+IEl0J3MgY2VydGFpbmx5IGFuIGlu
dGVyZXN0aW5nIGlkZWEuIEkgdGhpbmsgd2UgbmVlZCB0byBhZ3JlZSBvbiB1c2UNCj4gY2FzZXMN
Cj4gYW5kIGdvYWxzIGZpcnN0IGJlZm9yZSBiaWtlc2hlZGluZyBvbiB0aGUgc29sdXRpb24uDQoN
ClN1cmUgd2lsbCBkaXNjdXNzIG1vc3Qgb2YgdGhlIHVzZSBjYXNlcyB0b21vcnJvdyBpbiB0aGUg
aW92aXNvcg0KbWVldGluZy4NCg0KPiANCj4gPiBFeGFtcGxlIHVzZSBjYXNlcyAoWERQIG9ubHkg
Zm9yIG5vdyk6DQo+ID4gDQo+ID4gMSkgUXVlcnkgWERQIHN0YXRzIG9mIGFsbCBYRFAgbmV0ZGV2
czoNCj4gPiANCj4gPiB4ZHBfY3RybCA9IGJwZl9jcmVhdGVfbWFwKEJQRl9NQVBfVFlQRV9DT05U
Uk9MLCBtYXBfYXR0ci5jdHJsX3R5cGUNCj4gPiA9DQo+ID4gWERQX1NUQVRTKTsNCj4gPiANCj4g
PiB3aGlsZSAoYnBmX21hcF9nZXRfbmV4dF9rZXkoeGRwX2N0cmwsICZpZmluZGV4LCAmbmV4dF9p
ZmluZGV4KSA9PQ0KPiA+IDApIHsNCj4gPiAgICAgICAgIGJwZl9tYXBfbG9va3VwX2VsZW0oeGRw
X2N0cmwsICZuZXh0X2lmaW5kZXgsICZzdGF0cyk7DQo+ID4gICAgICAgICAvLyB3ZSBkb24ndCBl
dmVuIG5lZWQgdG8ga25vdyBzdGF0cyBmb3JtYXQgaW4gdGhpcyBjYXNlDQo+ID4gICAgICAgICBi
dGZfcHJldHR5X3ByaW50KHhkcF9jdHJsLT5idGYsICZzdGF0cyk7DQo+ID4gICAgICAgICBpZmlu
ZGV4ID0gIG5leHRfaWZpbmRleDsNCj4gPiB9DQo+IA0KPiB0aGlzIGJpdCBzaG93IGNhc2VzIGFk
dmFudGFnZSBvZiBCVEYgbmljZWx5Lg0KPiANCj4gPiAyKSBTZXR1cCBYRFAgdHggcmVkaXJlY3Qg
cmVzb3VyY2VzIG9uIGVncmVzcyBuZXRkZXYgKG5ldGRldiB3aXRoIG5vDQo+ID4gWERQDQo+ID4g
cHJvZ3JhbSkuDQo+ID4gDQo+ID4geGRwX2N0cmwgPSBicGZfY3JlYXRlX21hcChCUEZfTUFQX1RZ
UEVfQ09OVFJPTCwgbWFwX2F0dHIuY3RybF90eXBlDQo+ID4gPQ0KPiA+IFhEUF9BVFRSKTsNCj4g
PiANCj4gPiB4ZHBfYXR0ci0+Y29tbWFuZCA9IFNFVFVQX1JFRElSRUNUOw0KPiA+IHhkcF9hdHRy
LT5yaW5ncy5udW0gPSAxMjsNCj4gPiB4ZHBfYXR0ci0+cmluZ3Muc2l6ZSA9IDEyODsNCj4gPiBi
cGZfbWFwX3VwZGF0ZV9lbGVtKHhkcF9jdHJsLCAmaWZpbmRleCwgJnhkcF9hdHRyKTsNCj4gDQo+
IHRoaXMgb25lIHN0YXJ0aW5nIHRvIGJlY29tZSBhIGJpdCBvZGQsIHNpbmNlIGlucHV0IGFyZ3Vt
ZW50cyBhcmUNCj4gc3BsaXQNCj4gYmV0d2VlbiBrZXkgYW4gdmFsdWUuIGlmaW5kZXggaXMgcGFy
dCBvZiB0aGUga2V5IHdoZXJlYXMgY29tbWFuZCwNCj4gcmluZ3MubnVtIGFuZCByaW5ncy5zaXpl
IGFyZSBwYXJ0IG9mIHRoZSB2YWx1ZS4NCg0KVGhlIGlkZWEgaXMgdGhhdCB3ZSBuZWVkIHRvIGtl
ZXAgYSBtYXAgc2VtYW50aWNzIChvYmplY3QtPnZsYXVlKS4NCmluIHRoaXMgY2FzZSAoIG1hcF9h
dHRyLmN0cmxfdHlwZSA9IFhEUF9BVFRSICkgb2JqZWN0IChrZXkpIGlzIGlmX2luZGV4DQphbmQg
dmFsdWUgaXMgeGRwIGF0dHJpYnV0ZXMgb2YgdGhhdCBpZl9pbmRleCwgd2hpY2ggcGxheXMgbmlj
ZWx5IHdoZW4NCnlvdSB3YW50IHRvIGl0ZXJhdGUgdGhyb3VnaCBhbGwgdGhlIG9iamVjdHMgKFhE
UCBuZXRkZXZzKS4gc2ltcGx5IHRoaW5rDQpvZiBpZmluZGV4IGFzIGEga2V5IGFuZCBub3QgYW4g
aW5wdXQgdmFsdWUuDQoNCmRpZmZlcmVudCBjdHJsIG1hcCB0eXBlcyBjYW4gaGF2ZSBkaWZmZXJl
bnQga2V5cyBhbmQgdmFsdWVzIGhlbmNlIHRoZSANCm5lZWQgZm9yIG1hcF9jcmVhdGUgYW5kIHBh
c3NpbmcgbWFwX2F0dHIuY3RybF90eXBlIGF0dHJpYnV0ZSB3aGljaCB3aWxsDQpkZWZpbmUgd2hh
dCB0aGUgdXNlciBpcyB0cnlpbmcgdG8gYWNjZXNzICh3aGljaCBjb250cm9sIG1hcCkgYW5kIHdo
YXQNCndpbGwgYmUgdGhlIGtleSAob2JqZWN0KSAmIHZhbHVlIChjb25maWd1cmF0aW9uKSBwYWly
IGxheW91dC4NCg0KPiA+IDMpIFR1cm4gT24vT2ZmIFhEUCBtZXRhIGRhdGEgb2ZmbG9hZHMgYW5k
IHJldHJpZXZlIG1ldGEgZGF0YSBCVEYNCj4gPiBmb3JtYXQNCj4gPiBvZiBzcGVjaWZpYyBuZXRk
ZXYvaGFyZHdhcmU6DQo+ID4gDQo+ID4geGRwX2N0cmwgPSBicGZfY3JlYXRlX21hcChCUEZfTUFQ
X1RZUEVfQ09OVFJPTCwgbWFwX2F0dHIuY3RybF90eXBlDQo+ID4gPQ0KPiA+IFhEUF9BVFRSKTsN
Cj4gPiANCj4gPiB4ZHBfYXR0ci0+Y29tbWFuZCA9IFNFVFVQX01EOw0KPiA+IHhkcF9hdHRyLT5l
bmFibGVfbWQgPSAxOw0KPiA+IGVyciA9IGJwZl9tYXBfdXBkYXRlX2VsZW0oeGRwX2N0cmwsICZp
ZmluZGV4LCAmeGRwX2F0dHIpOw0KPiA+IGlmIChlcnIpIHsNCj4gPiAgICAgICBwcmludGYoIlhE
UCBtZXRhIGRhdGEgaXMgbm90IHN1cHBvcnRlZCBvbiB0aGlzIG5ldGRldiIpOw0KPiA+ICAgICAg
IHJldHVybjsNCj4gPiB9DQo+ID4gLy8gUXVlcnkgTWV0YSBkYXRhIEJURg0KPiA+IGJwZl9tYXBf
bG9va3VwX2VsZW0oeGRwX2N0cmwsICZpZmluZGV4LCAmeGRwX2F0dHIpOw0KPiA+IG1kX2J0ZiA9
IHhkcF9hdHRyLm1kX2J0ZjsNCj4gDQo+IGhlcmUgaXQgZ2V0cyBldmVuIHdlaXJkZXIsIHNpbmNl
IGxvb2t1cCBhcmd1bWVudHMgYXJlIGFsc28NCj4gc3BsaXQgYmV0d2VlbiBrZXkgYW5kIHZhbHVl
Lg0KPiBpZmluZGV4IGlzIGluc2lkZSB0aGUga2V5IHdoaWxlIGFkZGl0aW9uIGluZm8gaXMgcGFz
c2VkDQo+IGluc2lkZSB4ZHBfYXR0ciB3aGljaCBpcyBwYXJ0IG9mIHZhbHVlLg0KPiANCj4gSSB3
aXNoIHdlIGNvdWxkIGRvIG1hcHMgd2hlcmUgZXZlcnkga2V5IHdvdWxkIGhhdmUgZGlmZmVyZW50
IGxheW91dC4NCj4gVGhlbiBzdWNoIGFwaSB3b3VsZCBiZSBzdWl0YWJsZS4NCj4gVGhlIGV4aXN0
aW5nIG1hcHMgcmVxdWlyZSBhbGwga2V5cyBhbmQgdmFsdWVzIHRvIGJlIGluZm9ybS4NCj4gSSBn
dWVzcyBvbmUgY2FuIGFyZ3VlIHRoYXQgc3VjaCAnY29udHJvbCBtYXAnIGNhbiBoYXZlIG9uZSBl
bGVtZW50DQo+IGFuZCBvbmUgdmFsdWUsIGJ1dCB0aGVuIHdoYXQgaXMgdGhlIHB1cnBvc2Ugb2Yg
J21hcF9jcmVhdGUnDQo+IGFuZCAnbWFwX2RlbGV0ZT09Y2xvc2UoZmQpJyBvcGVyYXRpb25zPw0K
PiANCg0KVGhpcyBpcyBleGFjdGx5IHRoZSBwdXJwb3NlIG9mIG1hcF97Y3JlYXRlL2RlbGV0ZX0g
dG8gZGVmaW5lIHdoYXQgdGhlDQprZXksdmxhdWUgZm9ybWF0IHdpbGwgYmUgKCBpdCBpcyBub3Qg
Z29pbmcgdG8gYmUgaWZpbmRleCBmb3IgYWxsDQpjb250cm9sIG1hcHMpLCB0byBtYWtlIGl0IGNs
ZWFyLCB0aGUga2V5IGRvZXNuJ3QgaGF2ZSB0byBiZSBhbiBpZmluZGV4DQphdCBhbGwsIGl0IGRl
cGVuZHMgb24gdGhlIG1hcF9hdHRyLmN0cmxfdHlwZSB3aGljaCB0aGUgdXNlciByZXF1ZXN0IG9u
DQptYXAgY3JlYXRpb24sIHNvIGRpZmZlcmVudCBsYXlvdXRzIGFyZSBhbHJlYWR5IHN1cHBvcnRl
ZCBieSB0aGlzDQpwcm9wb3NhbA0KDQpleGFtcGxlcyBvZiBkaWZmZXJlbnQgbWFwX2F0dHIuY3Ry
bF90eXBlOg0KDQpmZCA9IGNyZWF0ZV9tYXAoQlBGX01BUF9UWVBFX0NPTlRST0wsIG1hcF9hdHRy
LmN0cmxfdHlwZSA9IFhEUF9BVFRSKQ0KLy8gS2V5IGxheW91dCA9PSBpZmluZGV4LCB2bGF1ZSBm
b3JtYXQgaWZfeGRwX2F0dHJpYnV0ZXMNCg0KZmQgPSBjcmVhdGVfbWFwKEJQRl9NQVBfVFlQRV9D
T05UUk9MLCBtYXBfYXR0ci5jdHJsX3R5cGUgPQ0KQlBGX1BST0dfU1RBVFMpDQovLyBLZXkgbGF5
b3V0ID09IHByb2dfZmQsIHZhbHVlIGZvcm1hdCBzdHJ1Y3QgYnBmX3Byb2dfc3RhdHMNCg0KZmQg
PSBjcmVhdGVfbWFwKEJQRl9NQVBfVFlQRV9DT05UUk9MLCBtYXBfYXR0ci5jdHJsX3R5cGUgPQ0K
QlBGX1NPQ0tfQVRUUikNCi8vIEtleSBsYXlvdXQgPT0gc29ja2V0X2ZkLCB2YWx1ZSBsYXlvdXQg
c3RydWN0IGJwZl9zb2NrX2F0dHINCg0KZXh0ZW5kaW5nIHRoaXMgY2FuIGJlIGRvbmUgaW4gYW55
IGxpbnV4IEJQRiBzdWJzeXN0ZW0sIGJ5IGludHJvZHVjaW5nIA0KbmV3IG1hcF9hdHRyLmN0cmxf
dHlwZXMgYW5kIG5ldyBrZXkgdmFsdWUgbGF5b3V0cyBvZiB0aGF0IGNvbnRyb2wgdHlwZS4NCg0K
b24gbWFwIGNyZWF0aW9uIHdlIHdpbGwgYXR0YWNoIHRoZSBidGYgZm9ybWF0IG9mIHRoZSAoa2V5
LCB2YWx1ZSkgcGFpcg0KdG8gdGhlIG1hcCBjcmVhdGVkIGZvciB0aGF0IHVzZXIuDQoNCg0KPiBJ
IHRoaW5rIHdlIG5lZWQgc29tZXRoaW5nIGVsc2UgaGVyZS4gVXNpbmcgQlRGIHRvIGRlc2NyaWJl
DQo+IG91dHB1dCBzdGF0cyBpcyBuaWNlLCBidXQgdXNpbmcgQlRGIHRvIGRlc2NyaWJlIGlucHV0
IHF1ZXJ5IGlzDQo+IHByb2JsZW1hdGljLA0KPiBzaW5jZSB1c2VyIGNhbm5vdCBrbm93IGJlZm9y
ZSBoYW5kIHdoYXQga2VybmVsIGNhbiBhbmQgY2Fubm90IGFjY2VwdC4NCj4gaW1vIGlucHV0IHNo
b3VsZCBiZSBzdGFibGUgdWFwaSB3aXRoIGZpeGVkIGNvbnN0YW50cyB3aGVyZWFzDQo+IHN0YXRz
LWxpa2Ugb3V0cHV0IGNhbiBiZSBCVEYgYmFzZWQgYW5kIHZhcnkgZnJvbSBkcml2ZXIgdG8gZHJp
dmVyDQo+IGFuZCBmcm9tIG9uZSBuaWMgdmVyc2lvbiB0byBhbm90aGVyLg0KPiANCg0KV2VsbCwg
d2UgY2FuIGRlY2lkZSB0byB1c2Ugc3RhdGljIHN0YWJsZSB1YXBpLCBhbmQgc3RpbGwgdXNlIHRo
aXMNCnNwZWNpYWwgbWFwIHRvIGxldmVyYWdlIHRoZSBtYXAgQVBJIGFzIGRlc2NyaWJlZCBpbiB0
aGlzIGRvYy4NCg0KYnV0IGFsc28gd2UgY2FuIGFsbG93IGR5bmFtaWMgdmFsdWUgbGF5b3V0cywg
YnV0IGFueSBleHRlbnNpb24gc2hvdWxkDQpiZSBkb25lIHRvIHRoZSBlbmQgb2YgYW55IHZhbHVl
IHN0cnVjdHVlciBhbmQgb24gbG9va3VwIHdlIHdpbGwgb25seQ0KY29weSB0aGUgc2l6ZSB0aGF0
IHRoZSB1c2VyIGFscmVhZHkgcmVjb2duaXplcyAuLiA/IG9yIHdlIGNhbg0KYXNzdW1lL2ZvcmNl
IHRoZSB1c2VyIHRvIHVzZSB0aGUgbWFwX2F0dHJpYnV0ZXMgdG8gZmlndXJlIG91dCBmb3JtYXQN
CmxheW91dHMgYW5kIHNpemVzLCBidXQgc3RpbGwgd2Ugd2lsbCBndWFyYW50ZWUgYmFja3dhcmQg
Y29tcGF0aWJpbGl0eQ0KaW4ga2VybmVsIGxldmVsIGJ5IGtlZXBpbmcgb2xkIGZvcm1hdCB0aGUg
c2FtZSwgYW5kIGV4dGVuc2lvbiBpcyBvbmx5DQphbGxvd2VkIHRvIHRoZSBlbmQgb2YgdGhlIHZh
bHVlIHN0cnVjdHVyZXMuDQoNCg0KDQoNCg==
