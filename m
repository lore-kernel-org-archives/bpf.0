Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B6C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 20:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7212064A
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 20:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Jhd8wR8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCHUvL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:51:11 -0500
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:32132
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbfCHUvL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 15:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fndf2RQjk6VFlRhv7cxKgaoaglW5h1Z4bSH3gNsFDMk=;
 b=Jhd8wR8jcDQWL/7BSnboWEa2fpNn0FkJsJNkLGiu4SbI1Dy6YGZn04ZGkx3o+DGpXH5na2o3DKhL+Cx/qvqs3zSXDYrciJAWKFlR4X7WA6HGliSvIJ1hFF7Zb3AHCV6MGRzlTrQ2PRE+4kZyEIn+xbno4Kn1v6CfB3UfltNTcOw=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB6057.eurprd05.prod.outlook.com (20.179.10.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 20:51:03 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1686.018; Fri, 8 Mar 2019
 20:51:03 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "toke@redhat.com" <toke@redhat.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrew.gospodarek@broadcom.com" <andrew.gospodarek@broadcom.com>,
        "jesper.brouer@gmail.com" <jesper.brouer@gmail.com>,
        "bblanco@gmail.com" <bblanco@gmail.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "bjorn.topel@gmail.com" <bjorn.topel@gmail.com>,
        "kafai@fb.com" <kafai@fb.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "iovisor-dev@lists.iovisor.org" <iovisor-dev@lists.iovisor.org>
Subject: [RFC][Proposal] BPF Control MAP
Thread-Topic: [RFC][Proposal] BPF Control MAP
Thread-Index: AQHU1fCkExRpj7FhXEuQCQPQJa8CMA==
Date:   Fri, 8 Mar 2019 20:51:03 +0000
Message-ID: <df010a2772ae07af29c9aac1c6d329b14203710c.camel@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ea2242f-9265-4a93-97b3-08d6a407c743
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB6057;
x-ms-traffictypediagnostic: DB8PR05MB6057:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjhQUjA1TUI2MDU3OzIzOlN6em4rdTVnYmc3TlNEcTZsSVAzNmpjRWJD?=
 =?utf-8?B?RGFwbXNVUm12M09icExaZFRvRkZmMDZac0hDVysvZWxla3dXc1pVY0VpODFi?=
 =?utf-8?B?TlR4M3BVM1I4TzA4RTNadGcyWmN5TTIrWEUvRHVPM2oweXZJVDJlQXlrVm5R?=
 =?utf-8?B?cjJ2Y0d3MGxRUzc5akNROEI5WE9kWkl6akNRSGtjYVh3ODk3Y1hEb1FYUFZS?=
 =?utf-8?B?NW5QL3NjS3pvc2tGb2dCWG1TKzFUVHBJUUwvYy9MOGJHeDA3RFZvTnhuVFFt?=
 =?utf-8?B?SkZPeUJNMVJ5dnJZcFZZdDN4L2tVV0MwcGNOdmRDNUladnhZRE1mNE92UEFF?=
 =?utf-8?B?U0hoQTBhU2Z3dmwwWFJPTDJZQS9BUnlVYzRWYi9ZZFVQZTFrMGpYWmVrak1Q?=
 =?utf-8?B?NVlEMUFDWlgrNm1HWGIvdEJ3SjRsMXQwZFFsVzBxaUFrSC82cDdsdkdEeG9G?=
 =?utf-8?B?OG45Z1NmNVRweHVzNVZ1c2ZlNXNkbTRadUtUdzZXVU0zc2l1REg4bEhzajNh?=
 =?utf-8?B?d3JtdFk4YUV0aUlleW8yQTRQa2dVS1RQRW1DWVNCOEJ0UmI0RXdDRkJKMitq?=
 =?utf-8?B?bVBoRUNhaGoyZUVCbi8rdHJkZzdhYyt0ckJpOUszaUlpQW9IZUIzcFNpOEs2?=
 =?utf-8?B?TWtMVXVoOW9Gd1h0TldvMTgrTGV0TUlvQ1dmeU50S2U1WmZZamN2bUZFV3ZC?=
 =?utf-8?B?ak8zeUZhc3BCZ3FPVXdIN2pUMzdacTdHUDBhZTdZc1gwaXQ3TjkxeTgrUFM5?=
 =?utf-8?B?ZURhMkREYWs0eDhzck8yTDlYalBNMXFWajlCd3Q1QUwvU3BhUUZweWhCelZt?=
 =?utf-8?B?SGVOaWV0NVFodmlCY1lOS1hiK0Rwcm0zY25odjV6cGY0L1ZnQ0wwbzh1aDJv?=
 =?utf-8?B?cFBmZzNqZEpESHc4S0FXUEV4NVlHR01aOXFrYVZudzN0R1ZidTRpL29jdklC?=
 =?utf-8?B?UHBzNUVoRlcxbmhsUWI1RmpUV3pOdUNrU1U4enFVUWhMVU9zZFN0d3p4N2Rs?=
 =?utf-8?B?RlF3U2haSnJQVzNsQjVvT3dkb2UyeHpObzc2dVNPQUhIS282UTZiZjFOZER1?=
 =?utf-8?B?YUdoVSsvOFNzUWJUTDRuajFVV1RDM2hRNDdNV1ZETVpkREs3S0pzUFlkek5E?=
 =?utf-8?B?djdJaXRBUTlDMGRwcFZhNXlsUjVyYnRLaEhxdkpyUlM0ZFhKZXBsVkU2R2pM?=
 =?utf-8?B?cHg4VFkxM0hPNU1GZmU3OTQ5d1RRVjhnK1hTaWR0VUZXVTJoUis0ZUxYRi9C?=
 =?utf-8?B?ZkxVV05iVS9pbzh1NXg4WkxQcSs0OEN0cFdpMGZIaGdqK0I0djVUbDk2Qm1j?=
 =?utf-8?B?NEhPMUlMdXRDMnY3enUydUQ3eWdzYnZmS3kxZ1hQNkIweDhWc21sdTg2Vnpm?=
 =?utf-8?B?ellaVlF5a051YlFTaTU2NUM3S1pTdklqSkY5VlZXRDI5S21wb1FiZzJoR2ZJ?=
 =?utf-8?B?ekJ2bWdtOUtpSFZqckdwYkFpSEQ5NVN2TWtBQ1huckYxMWp6TTlnU1VUci9N?=
 =?utf-8?B?WUx4czg1U25zZ0NNcWJ2QVlPWGhzYjZWc3hxOUlPcDdlOGJKWVNrRnpCN0Mr?=
 =?utf-8?B?WDMwSGRuZTZ1enhoYXc2N2czWEk0U1pQNXo4VFdzYytZV1ZUS2NqZ1BuMkFy?=
 =?utf-8?B?cjZLbUNJZmk5cExEK2Rxc3g0amJEc05temlUYTcwZGljL3diUkZSMVdaRFQ4?=
 =?utf-8?B?eXQwWlFHc2crL1hCSmFtSmNSUmpEbGdxVDVJdmtySHJYTkZTak1hZDRQalpY?=
 =?utf-8?Q?fu9Yo2jBzXupjaquAfUVaKpA6EOteIIL3Mkfs=3D?=
x-microsoft-antispam-prvs: <DB8PR05MB605797DDA79BF2EBFBB492E9BE4D0@DB8PR05MB6057.eurprd05.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(36756003)(25786009)(68736007)(2501003)(106356001)(4326008)(105586002)(118296001)(2906002)(8676002)(66066001)(81156014)(2201001)(81166006)(86362001)(5660300002)(478600001)(5024004)(14444005)(7736002)(256004)(966005)(6506007)(97736004)(58126008)(6512007)(14454004)(54906003)(110136005)(6486002)(99286004)(6436002)(102836004)(3846002)(6116002)(26005)(8936002)(561944003)(7416002)(186003)(53936002)(2616005)(305945005)(476003)(316002)(6306002)(71200400001)(71190400001)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB6057;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f7g3eE8RYsO1N1r0cN47CPPaT7/Z1ZlIahS4LEiG4gbuFGj2TY7j5ZXIRFiSPS53pzWE0c87dVqQzp2x8paznA1k9imuNki4tU8WVVphWBb4V8H98zmVmsFYglY5r25kF4sf/jErmMDrd21vt5pDEPPBVBaFgw95Lz1S9s55cGct9V5dahMwNXfaS/n0ljAHYKDpmjGucEXKr5SJMLSyo5f+AflsqSd8U1rU3J8+XJ6Uf5lUKYhLUd9dxpb9E++LWmOGFiqJ+1OTRCMP0r1f2DgnXl5Vng5GqEqyFppyvnZznEZ3PML/p1EE45+eigyE2uvgkUeZA98Uz/ObTRtKEAwyzNv9OhFiA8aPUjQiXQcnKSJncjhee+TNUrqVJF8RugivKxCEjM1W9CfwbH3qLvhSf/HQ7SItcmmBL7aZGzg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4CD654609D2CB4E82727708B4E2B19C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea2242f-9265-4a93-97b3-08d6a407c743
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 20:51:03.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6057
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SW4gdGhpcyBwcm9wb3NhbCBJIGFtIGdvaW5nIHRvIGFkZHJlc3MgdGhlIGxhY2sgb2YgYSB1bmlm
aWVkIHVzZXIgQVBJDQpmb3IgYWNjZXNzaW5nIGFuZCBtYW5pcHVsYXRpbmcgQlBGIHN5c3RlbSBh
dHRyaWJ1dGVzLCB3aGlsZSB0aGlzDQpwcm9wb3NhbCBpcyBnZW5lcmljIGFuZCB3aWxsIHdvcmsg
b24gYW55IEJQRiBzdWJzeXN0ZW0gKGVCUEYgYXR0YWNoDQpwb2ludHMpLCBJIHdpbGwgbW9zdGx5
IGZvY3VzIG9uIFhEUCB1c2UgY2FzZXMuDQoNClNvIGxhdGVseSBJIHN0YXJ0ZWQgd29ya2luZyBv
biB0aHJlZSBkaWZmZXJlbnQgWERQIG9wZW4gaXNzdWVzLCBuYW1lbHkNClhEUCBzdGF0aXN0aWMs
IFhEUCByZWRpcmVjdCBhbmQgWERQIG1ldGEtZGF0YSwgd2hpbGUgdGhlIGRldGFpbHMgb2YNCnRo
ZXNlIGlzc3VlcyBhcmUgbm90IHJlYWxseSByZWxldmFudCBmb3IgdGhlIHNha2Ugb2YgdGhpcyBw
cm9wb3NhbCwgYWxsDQpvZiB0aGVtIHNoYXJlIG9uZSBjb21tb24gcHJvYmxlbTogdGhlIGxhY2sg
b2YgdW5pZmllZCB1c2VyIGludGVyZmFjZSB0bw0KbWFuaXB1bGF0ZSBhbmQgYWNjZXNzIHRoZWly
IGF0dHJpYnV0ZXMuDQoNCkV4YW1wbGVzOg0KMS4gUXVlcnkgWERQIHN0YXRpc3RpY3MuDQoyLiBY
RFAgcmVzb3VyY2UgbWFuYWdlbWVudCwgU2V0dXAgWERQLXJlZGlyZWN0IFRYIHJlc291cmNlcy4N
CjMuIFNldHVwIGFuZCBxdWVyeSBYRFAtbWV0YWRhdGEgLSAoQlRGIGRhdGEgc3RydWN0dXJlKS4N
Cg0KSmVzcGVyIEJyb3VlciwgZXhwbGFpbnMgc29tZSBvZiB0aGVzZSBpc3N1ZXMgaW4gZGV0YWls
cyBhdDoNCmh0dHBzOi8vZ2l0aHViLmNvbS94ZHAtcHJvamVjdC94ZHAtcHJvamVjdC9ibG9iL21h
c3Rlci94ZHAtcHJvamVjdC5vcmcNCg0KWWVzIEkgY29uc2lkZXJlZCwgbmV0bGluaywgZGV2bGlu
aywgZXRodG9vbCwgc3lzY3RybCwgZXRjIC4uIGJ1dCBlYWNoDQpvbmUgb2YgdGhlbSBoYXMgaXQn
cyBvd24gZHJhd2JhY2ssIHRoZXkgYXJlIG5ldHdvcmtpbmcgc3BlY2lmaWMgYW5kDQp3aWxsIG5v
dCBzZXJ2ZSB0aGUgQlBGIGdlbmVyYWwgcHVycG9zZS4NCg0KV2hhdCB3ZSB3YW50IGlzLCBhbGwg
b2YgdGhlIEJQRiByZWxhdGVkIGtub2JzIHRvIGJlIHByZXNlbnQgaW4gQlBGIHVzZXINCnRvb2xz
OiBiY2MsIGJwZnRvb2wgYW5kIGxpYmJwZi4gSWRlYWxseSB3ZSBkb24ndCB3YW50IHRoZXNlIHRv
b2xzIHRvDQppbnRlZ3JhdGUgd2l0aCBhbGwgZGlmZmVyZW50IHN1YnN5c3RlbSdzIFVBUElzLCBl
c3BlY2lhbGx5IHRoZSB3aWRlDQp2YXJpZXR5IG9mIHRoZSBuZXR3b3JraW5nIFVBUElzLCBhbmQg
aW1hZ2luZSB3aGF0IG90aGVyIHN1YnN5c3RlbXMgYXJlDQpnb2luZyB0byBiZSB1c2luZyAuLg0K
DQpTbyB3aGF0IHNlZW1zIHRvIGJlIHRoZSByaWdodCBwYXRoIGhlcmUgaXMgYSB1bmlmaWVkIEJQ
Rg0KY29udHJvbC9jb25maWd1cmF0aW9uIHVzZXIgaW50ZXJmYWNlLCB3aGljaCB3aWxsIGhvb2sg
dGhlIGNhbGxlciB3aXRoDQp0aGUgdGFyZ2V0ZWQgc3Vic3lzdGVtLg0KDQpUbyBiZSBhbGlnbmVk
IHdpdGggYWxsIGV4aXN0aW5nIEJQRiB0b29scyBJIGFtIGdvaW5nIHRvIHByb3Bvc2UgdGhlIHVz
ZQ0Kb2YgQlBGIHN5c2NhbGwgKE5vLCBub3QgYSBuZXcgQlBGIHN5c2NhbGwgY29tbWFuZCwgSSBh
bSBub3QgcGxhbmluZyB0bw0KcmVpbnZlbnQgdGhlIHdoZWVsIC0gImFnYWluIiAtKS4NCldoYXQg
aSBhbSBnb2luZyB0byBzdWdnZXN0IGlzIHRvIHVzZSBhbiBhbHJlYWR5IGV4aXN0aW5nIEFQSSB3
aGljaCBydW5zDQpvbiB0b3Agb2YgdGhlIEJQRiBzeXNjYWxsLCBCUEYgTUFQcyBBUEkgd2l0aCBq
dXN0IGEgc21hbGwgdHdlYWsuIEVudGVyOg0KDQoNCg0KQlBGIGNvbnRyb2wgTUFQOg0KDQpBIHNw
ZWNpYWwgdHlwZSBvZiBNQVAgIkJQRl9NQVBfVFlQRV9DT05UUk9MIiwgdGhpcyBtYXAgd2lsbCBu
b3QgYmVoYXZlDQpsaWtlIG90aGVyIG1hcHMgaW4gdGhlIGVzc2VuY2Ugb2YgaGF2aW5nIGEgdXNl
ciBkZWZpbmVkIGRhdGEgc3RydWN0dXJlDQpiZWhpbmQgaXQsIHdlIGFyZSBnb2luZyB0byB1c2Ug
aXQganVzdCB0byBob29rIHRoZSB1c2VyIHdpdGggdGhlDQp0YXJnZXRlZCB1bmRlcmx5aW5nIHN1
YnN5c3RlbSBhbmQgZGVsZWdhdGUgdXNlciBjb21tYW5kcyB0byBpdCB0aHJvdWdoDQptYXAgb3Bl
cmF0aW9ucyAoY3JlYXRlL3VwZGF0ZV9lbGVtL2xvb2t1cF9lbGVtL2V0YyAuLi4pDQoNCg0KDQpS
ZXF1aXJlbWVudHMgYW5kIGltcGxlbWVudGF0aW9uIGRldGFpbHM6DQoNCjEpIEhvb2sgdGhlIHVz
ZXIgd2l0aCB0aGUgdGFyZ2V0ZWQgc3Vic3lzdGVtOg0KLSBPbiBjcmVhdGUgbWFwLCB1c2VyIHNl
bGVjdHMgdGhlIEJQRl9NQVBfVFlQRV9DT05UUk9MIG1hcCB0eXBlIGFuZA0Kc2V0cyBtYXBfYXR0
ci5jdHJsX3R5cGUgdG8gYmUgdGhlIHN1YnN5c3RlbSBoZSB3YW50cyB0byBhY2Nlc3MgYW5kDQpt
YW5pcHVsYXRlIChLUFJPQkUvQ0dST1VQL1NPQ0tFVF9GSUxURVIvWERQL2V0Yy4uKS4NCg0KMikg
U2V0IGFuZCBHZXQgb3BlcmF0aW9ucyBvZiBhIHNwZWNpZmljIEJQRiBzdWJzeXN0ZW0gb3IgYW4g
b2JqZWN0IGluDQp0aGF0IHN1YnN5c3RlbSAoZm9yIGV4YW1wbGUgYSBuZXRkZXYgaW4gWERQKS4N
Ci0gdXNlciB3aWxsIHVzZSB0aGUgZmlsZSBkZXNjcmlwdG9yIHJldHJpZXZlZCBvbiBtYXAgY3Jl
YXRpb24gdG8gYWNjZXNzDQooU2V0L0dldCkgdGhlIEJQRiBzdWJzeXN0ZW0gYXR0cmlidXRlcyB2
aWEgbWFwIHVwZGF0ZV9lbGVtIGFuZA0KbG9va3VwX2VsZW0gb3BlcmF0aW9ucywgdGhlIGtleSB3
aWxsIGJlIHRoZSBvYmplY3QgaWQgKGV4YW1wbGU6DQppZmluZGV4LCBvciBqdXN0IHRoZSB0eXBl
IG9mIGNvbmZpZ3VyYXRpb24gdG8gYWNjZXNzKSBrZXlzIGFuZCB2YWx1ZXMNCmFyZSBzdWJzeXN0
ZW0gZGVwZW5kZW50Lg0KDQozKSBJdGVyYXRlIHRocm91Z2ggdGhlIGRpZmZlcmVudCBhdHRyaWJ1
dGVzL29iamVjdHMgb2YgdGhlIHN1YnN5c3RlbSwNClVzZSBjYXNlOiBYRFAgQlBGIHN1YnN5c3Rl
bSwgZ2V0IEFMTCBuZXRkZXZzIFhEUCBhdHRyaWJ1dGVzL3N0YXRpc3RpY3MuDQpjYW4gYmUgZWFz
aWx5IGFjaGlldmVkIHdpdGg6IGJwZl9tYXBfZ2V0X25leHRfa2V5Lg0KDQoNCg0KQWR2YW50YWdl
cyAmIE1vdGl2YXRpb246DQpXaHkgQlBGIE1BUCBhbmQgbm90IGp1c3QgYSBwbGFpbiBuZXcgQlBG
IHN5c2NhbGwgY29tbWFuZCBvciBhbnkgb3RoZXINCmV4aXN0aW5nIFVBUEk6DQoNCjApIEFsbCBC
UEYgdXNlcnMgbG92ZSBtYXBzIGFuZCBnb3QgdXNlZCB0byB0aGVtLCBhbmQgc2ltcGx5LCBldmVy
eXRoaW5nDQppcyBhIG1hcCwgc3lzdGVtIG9iamVjdHMgY2FuIGJlIGtleXMgYW5kIHRoZWlyIGF0
dHJpYnV0ZXMgY2FuIGJlDQp2YWx1ZXMuDQoNCjEpICoqQlRGKiogaW50ZWdyYXRpb24sIGFueSBt
YXAgKGtleSwgdmFsdWUpIHBhaXIgY2FuIGJlIGRlc2NyaWJlZCBpbg0KQlRGIGluIGtlcm5lbCBs
ZXZlbCBhbmQgY2FuIGJlIGF0dGFjaGVkIHRvIHRoZSBtYXAgdGhlIHVzZXIgY3JlYXRlcywNCnRo
aXMgd2lsbCBiZSBhIGh1Z2UgYWR2YW50YWdlIGZvciB1c2VyIGZvcndhcmQgY29tcGF0aWJpbGl0
eSwgYW5kIGZvcg0KZGV2ZWxvcG1lbnQgY29udmVuaWVuY2UgdG8gbm90IGNvcHkga2VybmVsIHVh
cGkgaGVhZGVycyBvbiBlYWNoDQphdHRyaWJ1dGUgc2V0IHVwZGF0ZXMsIGFuZCBzaW1wbGlmeSBB
QkkgY29tcGF0aWJpbGl0eS4NCk5ldyB2YWx1ZXMgb3IgYXR0cmlidXRlcyBjYW4gYmUgZHVtcGVk
L3BhcnNlZCBpbiB1c2VyIHNwYWNlIHdpdGggemVybw0KZWZmb3J0LCBubyBuZWVkIHRvIGNvbnN0
YW50bHkgdXBkYXRlIHVzZXIgc3BhY2UgdG9vbHMuDQoNCjIpIEJQRiBtYXBzIGFscmVhZHkgbGFp
ZCB0aGUgZ3JvdW5kd29yayBmb3Igb3VyIHJlcXVpcmVtZW50cyBhcyB0aGUNCmluZnJhc3RydWN0
dXJlIGFuZCBoYXMgdGhlIHNlbWFudGljcyB0aGF0IHdlIGFyZSBsb29raW5nIGZvciAoc2V0L2dl
dCkuDQoNCjMpIEFscmVhZHkgaW50ZWdyYXRlZCBpbiB1c2VyLXNwYWNlIHRvb2xzIGFuZCBsaWJy
YXJpZXMgc3VjaCBhc2gNCmJjYy9saWJicGYgYW5kIGZyaWVuZHMsIHdoYXQgaXMgbWlzc2luZyBp
cyBqdXN0IHRoaXMgc21hbGwgdHdlYWsgKGluDQp0aGUga2VybmVsKSB0byBob29rIG9uZSBzcGVj
aWFsIG1hcCB0eXBlIHdpdGggdGhlIHVuZGVybHlpbmcgQlBGDQpzdWJzeXN0ZW1zLg0KDQpUaG91
Z2h0cyA/DQoNCg0KW1NvbWUgRVhUUkFzXQ0KRXhhbXBsZSB1c2UgY2FzZXMgKFhEUCBvbmx5IGZv
ciBub3cpOg0KDQoxKSBRdWVyeSBYRFAgc3RhdHMgb2YgYWxsIFhEUCBuZXRkZXZzOg0KDQp4ZHBf
Y3RybCA9IGJwZl9jcmVhdGVfbWFwKEJQRl9NQVBfVFlQRV9DT05UUk9MLCBtYXBfYXR0ci5jdHJs
X3R5cGUgPQ0KWERQX1NUQVRTKTsNCg0Kd2hpbGUgKGJwZl9tYXBfZ2V0X25leHRfa2V5KHhkcF9j
dHJsLCAmaWZpbmRleCwgJm5leHRfaWZpbmRleCkgPT0gMCkgew0KICAgICAgICBicGZfbWFwX2xv
b2t1cF9lbGVtKHhkcF9jdHJsLCAmbmV4dF9pZmluZGV4LCAmc3RhdHMpOw0KICAgICAgICAvLyB3
ZSBkb24ndCBldmVuIG5lZWQgdG8ga25vdyBzdGF0cyBmb3JtYXQgaW4gdGhpcyBjYXNlDQogICAg
ICAgIGJ0Zl9wcmV0dHlfcHJpbnQoeGRwX2N0cmwtPmJ0ZiwgJnN0YXRzKTsNCiAgICAgICAgaWZp
bmRleCA9ICBuZXh0X2lmaW5kZXg7DQp9DQoNCjIpIFNldHVwIFhEUCB0eCByZWRpcmVjdCByZXNv
dXJjZXMgb24gZWdyZXNzIG5ldGRldiAobmV0ZGV2IHdpdGggbm8gWERQDQpwcm9ncmFtKS4NCg0K
eGRwX2N0cmwgPSBicGZfY3JlYXRlX21hcChCUEZfTUFQX1RZUEVfQ09OVFJPTCwgbWFwX2F0dHIu
Y3RybF90eXBlID0NClhEUF9BVFRSKTsNCg0KeGRwX2F0dHItPmNvbW1hbmQgPSBTRVRVUF9SRURJ
UkVDVDsNCnhkcF9hdHRyLT5yaW5ncy5udW0gPSAxMjsNCnhkcF9hdHRyLT5yaW5ncy5zaXplID0g
MTI4Ow0KYnBmX21hcF91cGRhdGVfZWxlbSh4ZHBfY3RybCwgJmlmaW5kZXgsICZ4ZHBfYXR0cik7
DQoNCjMpIFR1cm4gT24vT2ZmIFhEUCBtZXRhIGRhdGEgb2ZmbG9hZHMgYW5kIHJldHJpZXZlIG1l
dGEgZGF0YSBCVEYgZm9ybWF0DQpvZiBzcGVjaWZpYyBuZXRkZXYvaGFyZHdhcmU6DQoNCnhkcF9j
dHJsID0gYnBmX2NyZWF0ZV9tYXAoQlBGX01BUF9UWVBFX0NPTlRST0wsIG1hcF9hdHRyLmN0cmxf
dHlwZSA9DQpYRFBfQVRUUik7DQoNCnhkcF9hdHRyLT5jb21tYW5kID0gU0VUVVBfTUQ7DQp4ZHBf
YXR0ci0+ZW5hYmxlX21kID0gMTsNCmVyciA9IGJwZl9tYXBfdXBkYXRlX2VsZW0oeGRwX2N0cmws
ICZpZmluZGV4LCAmeGRwX2F0dHIpOw0KaWYgKGVycikgew0KICAgICAgcHJpbnRmKCJYRFAgbWV0
YSBkYXRhIGlzIG5vdCBzdXBwb3J0ZWQgb24gdGhpcyBuZXRkZXYiKTsNCiAgICAgIHJldHVybjsN
Cn0NCi8vIFF1ZXJ5IE1ldGEgZGF0YSBCVEYNCmJwZl9tYXBfbG9va3VwX2VsZW0oeGRwX2N0cmws
ICZpZmluZGV4LCAmeGRwX2F0dHIpOw0KbWRfYnRmID0geGRwX2F0dHIubWRfYnRmOw0KDQpUaGFu
a3MsDQpTYWVlZC4NCg==
