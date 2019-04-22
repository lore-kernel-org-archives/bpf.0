Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEB2C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857D121738
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Euu3j0z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfDVSIy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:08:54 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:9921
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728407AbfDVSIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 14:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYhGcePfVJb2QbE1XRzs4Hx5u0bN2b7BJu7YljOs77M=;
 b=Euu3j0z4bouyasU0aF+rELkbAnrrK+wlF/wL0/CreArWorLOE/Z8ryDeFOCNcFmjwagnHApUG6YnKw4WehNsGJcn1Rvpsa+V+xd0DneioCq0BTxq3IDe4HaxOO9JsAwpClNndRCAfML6UL8T4qkYkpbuHxWjeRt6HciY9wstWlM=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB5865.eurprd05.prod.outlook.com (20.179.8.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 18:08:48 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::85d8:bf39:8cc9:16c3]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::85d8:bf39:8cc9:16c3%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 18:08:48 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "sdf@google.com" <sdf@google.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "peterpenkov96@gmail.com" <peterpenkov96@gmail.com>,
        "willemb@google.com" <willemb@google.com>,
        "simon.horman@netronome.com" <simon.horman@netronome.com>,
        "ast@kernel.org" <ast@kernel.org>
Subject: Re: [PATCH bpf-next v6 3/9] net: plumb network namespace into
 __skb_flow_dissect
Thread-Topic: [PATCH bpf-next v6 3/9] net: plumb network namespace into
 __skb_flow_dissect
Thread-Index: AQHU+SPml1J0/MEzOUG4QzdUw6h1VqZIepGA
Date:   Mon, 22 Apr 2019 18:08:48 +0000
Message-ID: <67dc0b5f17c63281c88e9be44043765a2cd0cc17.camel@mellanox.com>
References: <20190422155552.222910-1-sdf@google.com>
         <20190422155552.222910-4-sdf@google.com>
In-Reply-To: <20190422155552.222910-4-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e24223ee-a93a-4e25-0d58-08d6c74d9148
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB8PR05MB5865;
x-ms-traffictypediagnostic: DB8PR05MB5865:
x-microsoft-antispam-prvs: <DB8PR05MB58657BB247E9AE196724B319BE220@DB8PR05MB5865.eurprd05.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(51444003)(199004)(43544003)(76116006)(91956017)(446003)(476003)(73956011)(8936002)(66476007)(66556008)(64756008)(66446008)(54906003)(66946007)(68736007)(58126008)(6116002)(11346002)(2201001)(110136005)(5660300002)(2616005)(3846002)(316002)(2501003)(8676002)(2906002)(36756003)(71190400001)(71200400001)(486006)(256004)(5024004)(97736004)(81166006)(81156014)(7736002)(99286004)(478600001)(6512007)(66066001)(6486002)(53936002)(6436002)(305945005)(25786009)(14454004)(6246003)(6506007)(102836004)(26005)(76176011)(186003)(118296001)(86362001)(4326008)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB5865;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X+nhj1DgvlSjKera62P7ak9lVuC90q8DiL6ZI8P245CHisIC0NrhstAC6xn1I/knVRGbci4cOriyHodX4F0vzIWrUK9QBtMxy1QzCcoqwSlQVdR+M1uDKu2ZGvisazDuD2SE4KncwdpmeBiiWQkTuCNzCU2GpvAjmpg85JRS05DNV9jQAqpyVGnswfN+uTx7TIdjlKbmV429XCwTraE+B1XQ8vg1nRuE7XjpU7DOah/na6raigp8hHU0H+wFYO9qTpWbweOR9oJQoVKQ1ItZtr3fl5FV+x+C+fF4YnhBh6cMb8dYr2iDhIblm3G7YIvi29IU/ERRFJi6n6d/96ZYx4ZACMKy5K0368eroioLq55mx4hp2YVR4wJ4vSggIKQec6DtPMH9blAdHk0LRfVPpAx+k+vgbZ0Xmp1wowLDqXQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F04B74C91F006440906B9C877FF761F1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24223ee-a93a-4e25-0d58-08d6c74d9148
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 18:08:48.2710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5865
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTIyIGF0IDA4OjU1IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IFRoaXMgbmV3IGFyZ3VtZW50IHdpbGwgYmUgdXNlZCBpbiB0aGUgbmV4dCBwYXRjaGVz
IGZvciB0aGUNCj4gZXRoX2dldF9oZWFkbGVuIHVzZSBjYXNlLiBldGhfZ2V0X2hlYWRsZW4gY2Fs
bHMgZmxvdyBkaXNzZWN0b3INCj4gd2l0aCBvbmx5IGRhdGEgKHdpdGhvdXQgc2tiKSBzbyB0aGVy
ZSBpcyBjdXJyZW50bHkgbm8gd2F5IHRvDQo+IHB1bGwgYXR0YWNoZWQgQlBGIGZsb3cgZGlzc2Vj
dG9yIHByb2dyYW0uIFdpdGggdGhpcyBuZXcgYXJndW1lbnQsDQo+IHdlIGNhbiBhbWVuZCB0aGUg
Y2FsbGVycyB0byBleHBsaWNpdGx5IHBhc3MgbmV0d29yayBuYW1lc3BhY2UNCj4gc28gd2UgY2Fu
IHVzZSBhdHRhY2hlZCBCUEYgcHJvZ3JhbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xh
diBGb21pY2hldiA8c2RmQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9za2J1
ZmYuaCAgICB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0NCj4gIG5ldC9jb3JlL2Zsb3dfZGlzc2Vj
dG9yLmMgfCAyNyArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIG5ldC9ldGhlcm5ldC9l
dGguYyAgICAgICAgfCAgNSArKystLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25z
KCspLCAyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Nr
YnVmZi5oIGIvaW5jbHVkZS9saW51eC9za2J1ZmYuaA0KPiBpbmRleCBiZWFlZGQ0ODdiZTEuLmVl
N2QxYTg1ZjYyNCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9za2J1ZmYuaA0KPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oDQo+IEBAIC0xMjg0LDcgKzEyODQsOCBAQCBib29sIF9f
c2tiX2Zsb3dfYnBmX2Rpc3NlY3Qoc3RydWN0IGJwZl9wcm9nDQo+ICpwcm9nLA0KPiAgCQkJICAg
IGNvbnN0IHN0cnVjdCBza19idWZmICpza2IsDQo+ICAJCQkgICAgc3RydWN0IGZsb3dfZGlzc2Vj
dG9yICpmbG93X2Rpc3NlY3RvciwNCj4gIAkJCSAgICBzdHJ1Y3QgYnBmX2Zsb3dfa2V5cyAqZmxv
d19rZXlzKTsNCj4gLWJvb2wgX19za2JfZmxvd19kaXNzZWN0KGNvbnN0IHN0cnVjdCBza19idWZm
ICpza2IsDQo+ICtib29sIF9fc2tiX2Zsb3dfZGlzc2VjdChjb25zdCBzdHJ1Y3QgbmV0ICpuZXQs
DQo+ICsJCQljb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiAgCQkJc3RydWN0IGZsb3dfZGlz
c2VjdG9yICpmbG93X2Rpc3NlY3RvciwNCj4gIAkJCXZvaWQgKnRhcmdldF9jb250YWluZXIsDQo+
ICAJCQl2b2lkICpkYXRhLCBfX2JlMTYgcHJvdG8sIGludCBuaG9mZiwgaW50IGhsZW4sDQo+IEBA
IC0xMjk0LDggKzEyOTUsOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgc2tiX2Zsb3dfZGlzc2VjdChj
b25zdA0KPiBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiAgCQkJCSAgICBzdHJ1Y3QgZmxvd19kaXNz
ZWN0b3INCj4gKmZsb3dfZGlzc2VjdG9yLA0KPiAgCQkJCSAgICB2b2lkICp0YXJnZXRfY29udGFp
bmVyLCB1bnNpZ25lZA0KPiBpbnQgZmxhZ3MpDQo+ICB7DQo+IC0JcmV0dXJuIF9fc2tiX2Zsb3df
ZGlzc2VjdChza2IsIGZsb3dfZGlzc2VjdG9yLA0KPiB0YXJnZXRfY29udGFpbmVyLA0KPiAtCQkJ
CSAgTlVMTCwgMCwgMCwgMCwgZmxhZ3MpOw0KPiArCXJldHVybiBfX3NrYl9mbG93X2Rpc3NlY3Qo
TlVMTCwgc2tiLCBmbG93X2Rpc3NlY3RvciwNCj4gKwkJCQkgIHRhcmdldF9jb250YWluZXIsIE5V
TEwsIDAsIDAsIDAsDQo+IGZsYWdzKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlubGluZSBib29s
IHNrYl9mbG93X2Rpc3NlY3RfZmxvd19rZXlzKGNvbnN0IHN0cnVjdCBza19idWZmDQo+ICpza2Is
DQo+IEBAIC0xMzAzLDE4ICsxMzA0LDE5IEBAIHN0YXRpYyBpbmxpbmUgYm9vbA0KPiBza2JfZmxv
d19kaXNzZWN0X2Zsb3dfa2V5cyhjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiAgCQkJCQkg
ICAgICB1bnNpZ25lZCBpbnQgZmxhZ3MpDQo+ICB7DQo+ICAJbWVtc2V0KGZsb3csIDAsIHNpemVv
ZigqZmxvdykpOw0KPiAtCXJldHVybiBfX3NrYl9mbG93X2Rpc3NlY3Qoc2tiLCAmZmxvd19rZXlz
X2Rpc3NlY3RvciwgZmxvdywNCj4gLQkJCQkgIE5VTEwsIDAsIDAsIDAsIGZsYWdzKTsNCj4gKwly
ZXR1cm4gX19za2JfZmxvd19kaXNzZWN0KE5VTEwsIHNrYiwgJmZsb3dfa2V5c19kaXNzZWN0b3Is
DQo+ICsJCQkJICBmbG93LCBOVUxMLCAwLCAwLCAwLCBmbGFncyk7DQo+ICB9DQo+ICANCj4gIHN0
YXRpYyBpbmxpbmUgYm9vbA0KPiAtc2tiX2Zsb3dfZGlzc2VjdF9mbG93X2tleXNfYmFzaWMoY29u
c3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gK3NrYl9mbG93X2Rpc3NlY3RfZmxvd19rZXlzX2Jh
c2ljKGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwNCj4gKwkJCQkgY29uc3Qgc3RydWN0IHNrX2J1ZmYg
KnNrYiwNCj4gIAkJCQkgc3RydWN0IGZsb3dfa2V5c19iYXNpYyAqZmxvdywgdm9pZA0KPiAqZGF0
YSwNCj4gIAkJCQkgX19iZTE2IHByb3RvLCBpbnQgbmhvZmYsIGludCBobGVuLA0KPiAgCQkJCSB1
bnNpZ25lZCBpbnQgZmxhZ3MpDQo+ICB7DQo+ICAJbWVtc2V0KGZsb3csIDAsIHNpemVvZigqZmxv
dykpOw0KPiAtCXJldHVybiBfX3NrYl9mbG93X2Rpc3NlY3Qoc2tiLCAmZmxvd19rZXlzX2Jhc2lj
X2Rpc3NlY3RvciwNCj4gZmxvdywNCj4gKwlyZXR1cm4gX19za2JfZmxvd19kaXNzZWN0KG5ldCwg
c2tiLCAmZmxvd19rZXlzX2Jhc2ljX2Rpc3NlY3RvciwNCj4gZmxvdywNCj4gIAkJCQkgIGRhdGEs
IHByb3RvLCBuaG9mZiwgaGxlbiwgZmxhZ3MpOw0KPiAgfQ0KPiAgDQo+IEBAIC0yNDk0LDcgKzI0
OTYsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCj4gc2tiX3Byb2JlX3RyYW5zcG9ydF9oZWFkZXIo
c3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gIAlpZiAoc2tiX3RyYW5zcG9ydF9oZWFkZXJfd2FzX3Nl
dChza2IpKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gLQlpZiAoc2tiX2Zsb3dfZGlzc2VjdF9mbG93
X2tleXNfYmFzaWMoc2tiLCAma2V5cywgTlVMTCwgMCwgMCwgMCwNCj4gMCkpDQo+ICsJaWYgKHNr
Yl9mbG93X2Rpc3NlY3RfZmxvd19rZXlzX2Jhc2ljKE5VTEwsIHNrYiwgJmtleXMsDQo+ICsJCQkJ
CSAgICAgTlVMTCwgMCwgMCwgMCwgMCkpDQo+ICAJCXNrYl9zZXRfdHJhbnNwb3J0X2hlYWRlcihz
a2IsIGtleXMuY29udHJvbC50aG9mZik7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL25ldC9j
b3JlL2Zsb3dfZGlzc2VjdG9yLmMgYi9uZXQvY29yZS9mbG93X2Rpc3NlY3Rvci5jDQo+IGluZGV4
IGVmNmQ5NDQzY2M3NS4uZjMyYzdlNzM3ZmM2IDEwMDY0NA0KPiAtLS0gYS9uZXQvY29yZS9mbG93
X2Rpc3NlY3Rvci5jDQo+ICsrKyBiL25ldC9jb3JlL2Zsb3dfZGlzc2VjdG9yLmMNCj4gQEAgLTcy
Miw2ICs3MjIsNyBAQCBib29sIGJwZl9mbG93X2Rpc3NlY3Qoc3RydWN0IGJwZl9wcm9nICpwcm9n
LA0KPiBzdHJ1Y3QgYnBmX2Zsb3dfZGlzc2VjdG9yICpjdHgsDQo+ICANCj4gIC8qKg0KPiAgICog
X19za2JfZmxvd19kaXNzZWN0IC0gZXh0cmFjdCB0aGUgZmxvd19rZXlzIHN0cnVjdCBhbmQgcmV0
dXJuIGl0DQo+ICsgKiBAbmV0OiBhc3NvY2lhdGVkIG5ldHdvcmsgbmFtZXNwYWNlLCBkZXJpdmVk
IGZyb20gQHNrYiBpZiBOVUxMDQo+ICAgKiBAc2tiOiBza19idWZmIHRvIGV4dHJhY3QgdGhlIGZs
b3cgZnJvbSwgY2FuIGJlIE5VTEwgaWYgdGhlIHJlc3QNCj4gYXJlIHNwZWNpZmllZA0KPiAgICog
QGZsb3dfZGlzc2VjdG9yOiBsaXN0IG9mIGtleXMgdG8gZGlzc2VjdA0KPiAgICogQHRhcmdldF9j
b250YWluZXI6IHRhcmdldCBzdHJ1Y3R1cmUgdG8gcHV0IGRpc3NlY3RlZCB2YWx1ZXMgaW50bw0K
PiBAQCAtNzM4LDcgKzczOSw4IEBAIGJvb2wgYnBmX2Zsb3dfZGlzc2VjdChzdHJ1Y3QgYnBmX3By
b2cgKnByb2csDQo+IHN0cnVjdCBicGZfZmxvd19kaXNzZWN0b3IgKmN0eCwNCj4gICAqDQo+ICAg
KiBDYWxsZXIgbXVzdCB0YWtlIGNhcmUgb2YgemVyb2luZyB0YXJnZXQgY29udGFpbmVyIG1lbW9y
eS4NCj4gICAqLw0KPiAtYm9vbCBfX3NrYl9mbG93X2Rpc3NlY3QoY29uc3Qgc3RydWN0IHNrX2J1
ZmYgKnNrYiwNCj4gK2Jvb2wgX19za2JfZmxvd19kaXNzZWN0KGNvbnN0IHN0cnVjdCBuZXQgKm5l
dCwNCj4gKwkJCWNvbnN0IHN0cnVjdCBza19idWZmICpza2IsDQo+ICAJCQlzdHJ1Y3QgZmxvd19k
aXNzZWN0b3IgKmZsb3dfZGlzc2VjdG9yLA0KPiAgCQkJdm9pZCAqdGFyZ2V0X2NvbnRhaW5lciwN
Cj4gIAkJCXZvaWQgKmRhdGEsIF9fYmUxNiBwcm90bywgaW50IG5ob2ZmLCBpbnQgaGxlbiwNCg0K
TEdUTSwNCg0KUmV2aWV3ZWQtYnk6IFNhZWVkIE1haGFtZWVkIDxzYWVlZG1AbWVsbGFub3guY29t
Pg0KDQpTaWRlIE5vdGU6IGl0IGlzIG5vdCB0aGlzIHBhdGNoJ3MgZmF1bHQsIGJ1dCBJIHRoaW5r
IHRoYXQgdGhlcmUgaXMgbG90cw0Kb2Ygcm9vbSBmb3IgaW1wcm92ZW1lbnQgaW4gX19za2JfZmxv
d19kaXNzZWN0IHBhcmFtZXRlcnMgc2V0LCBpdCBzZWVtcw0KdGhhdCB0aGUgZnVuY3Rpb24gY2Fu
IHJlY2VpdmVzIHR3byBzZXBhcmF0ZSBzZXRzIG9mIHBhcmFtZXRlcnMgYW5kIGVhY2gNCnNldCBp
cyBvbmx5IHVzZWQgd2hlbiBhIHZhbGlkIHNrYiBpcyBwYXNzZWQsIHdoaWxlIHRoZSBvdGhlciBz
ZXQgaXMNCnVzZWQgd2hlbiBza2IgaXMgbnVsbCBidXQgZGF0YSBwdHIgaXNuJ3QsIHRoaXMgbWFr
ZXMgdGhpcyBmdW5jdGlvbiB2ZXJ5DQpoYXJkIHRvIHJlYWQgYW5kIHRyYWNrIGl0J3MgZmxvdy4N
Cg0KTXkgMiBjZW50IGlzIHRoYXQgd2UgbmVlZCB0d28gdmVyc2lvbnMgb2YgX19za2JfZmxvd19k
aXNzZWN0LCBvbmUgdGhhdA0KdXNlcyBza2IgYW5kIHRoZSBvdGhlciB1c2VzIGRhdGEgcG9pbnRl
ciwgYW5kIHRoZSBza2IgdmVyc2lvbiBjYW4NCnBlcmZlY3RseSB1c2UgdGhlICJkYXRhIiBwdHIg
dmVyc2lvbiwgaXQgY291bGQgYmUgYSBoYXJkIHJlLWZhY3RvcmluZw0KdGFzaywgYnV0IGkgdGhp
bmsgaXQgaXMgZG9hYmxlLg0KDQo=
