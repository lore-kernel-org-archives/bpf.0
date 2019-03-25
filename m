Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02CCC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5839720879
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 15:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NNbdgoV4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Yysd1Rnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfCYP7p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:59:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46654 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbfCYP7p (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Mar 2019 11:59:45 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PFxC1p031913;
        Mon, 25 Mar 2019 08:59:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WnlQ9h8JbVGBhUnxB2Qi3sQz8WLrj9016dwrdWuStsw=;
 b=NNbdgoV4B31aR5AjvVeB5K3No+W0NkcMZ8UAVO1yOcxlO15ChAXgpmweDslQwzHuLEww
 X+bBmpSJEyedw+/pJ/02B28AUidzCSAKR5GJtYtBRwcWPK8JHIF2HFq5mrtZ1J5o+svA
 C/daglSdbAnYFqTjkO9Tohfx2wwNCgGVmkA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf15rgd1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 08:59:18 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Mar 2019 08:59:17 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Mar 2019 08:59:16 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Mar 2019 08:59:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnlQ9h8JbVGBhUnxB2Qi3sQz8WLrj9016dwrdWuStsw=;
 b=Yysd1RnbFVVacwMeTEP0LZ2aTOJlYvaaHwsiU+veVQPB32WcsnZG8lKEYzm7tYslT1SBZSlyd9pOLGPaOOTL4PGaQBhoZBycjLCu7tM27diZKJQESmXJMnphg4lgiz8OjAdyKaSQDailOri7RumKCokZn7ON/zrYv7NEQSnymeE=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2245.namprd15.prod.outlook.com (52.135.196.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 15:59:15 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::fcb2:5ce:1804:28fd]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::fcb2:5ce:1804:28fd%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 15:59:15 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
Thread-Topic: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
Thread-Index: AQHU22xGkm6hF1+QwEKk37ihWDAYRKYckIcA
Date:   Mon, 25 Mar 2019 15:59:14 +0000
Message-ID: <51e9776a-a0c2-fb69-6b8c-82b220c3e18f@fb.com>
References: <20190315201749.556085-1-andriin@fb.com>
In-Reply-To: <20190315201749.556085-1-andriin@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:b0d9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 319a3d3e-c91f-489a-1313-08d6b13ad3f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2245;
x-ms-traffictypediagnostic: BYAPR15MB2245:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR15MB224554ADC9CE47A5462736F4D75E0@BYAPR15MB2245.namprd15.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(199004)(189003)(305945005)(105586002)(8936002)(386003)(6506007)(6306002)(256004)(14444005)(53546011)(25786009)(68736007)(36756003)(81166006)(8676002)(4326008)(102836004)(7736002)(486006)(71190400001)(2906002)(99286004)(81156014)(6512007)(446003)(2616005)(11346002)(476003)(71200400001)(46003)(31686004)(6436002)(229853002)(31696002)(316002)(110136005)(5660300002)(106356001)(6486002)(186003)(54906003)(966005)(76176011)(97736004)(52116002)(86362001)(478600001)(53936002)(14454004)(6246003)(2201001)(2501003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2245;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CXQAkN+gSjv+nNPOodrw+6rtGJF2kTKxwAuCP8XWzGPkdLPcR81bna7lcCRBXYDhdpJLHVSeYIMdSxZpGfJUj3+b+fQEVw+ICVGKBQX19QBQc/mPdmB+qaZg9wqyucr6VUnff+d/FmfD1OHRU5ch5BU29qrK/79U4ZGKQ1v7mbFd3iOLCysuKfxRQ20yTPOdtiiLkgLimzs/ibIwlyWFGiy1eRnuup3ZO8WnELqMU/ktCp9eXrtv+EsS+cx3D9Zhl2hAiSUKQnhbbpB6LFZFkXR+pXLzumonOzjyjeCxnK6FHMIoXcNdO7oXl+9E/GIKtMHfwvuwOfOX4c3J7tl8dJbwv5IaldCU+H1TmkkkWn7EWur4d+k7WxZVBpj1ExvXZ2KLo7sfDOj5S1SVME0WZ8UlKWMy74ComVHURIswN5U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFC1D0F2099FFF42B21797D78F5AF733@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 319a3d3e-c91f-489a-1313-08d6b13ad3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 15:59:15.1446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMy8xNS8xOSAxOjE3IFBNLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+IFRoaXMgcGF0Y2gg
YWRkcyBuZXcgY29uZmlnIG9wdGlvbiB0byB0cmlnZ2VyIGdlbmVyYXRpb24gb2YgQlRGIHR5cGUN
Cj4gaW5mb3JtYXRpb24gZnJvbSBEV0FSRiBkZWJ1Z2luZm8gZm9yIHZtbGludXggYW5kIGtlcm5l
bCBtb2R1bGVzIHRocm91Z2gNCj4gcGFob2xlLCB3aGljaCBpbiB0dXJuIHJlbGllcyBvbiBsaWJi
cGYgZm9yIGJ0Zl9kZWR1cCgpIGFsZ29yaXRobS4NCj4gDQo+IFRoZSBpbnRlbnQgaXMgdG8gcmVj
b3JkIGNvbXBhY3QgdHlwZSBpbmZvcm1hdGlvbiBvZiBhbGwgdHlwZXMgdXNlZA0KPiBpbnNpZGUg
a2VybmVsLCBpbmNsdWRpbmcgYWxsIHRoZSBzdHJ1Y3RzL3VuaW9ucy90eXBlZGVmcy9ldGMuIFRo
aXMNCj4gZW5hYmxlcyBCUEYncyBjb21waWxlLW9uY2UtcnVuLWV2ZXJ5d2hlcmUgKFswXSkgYXBw
cm9hY2gsIGluIHdoaWNoDQo+IHRyYWNpbmcgcHJvZ3JhbXMgdGhhdCBhcmUgaW5zcGVjdGluZyBr
ZXJuZWwncyBpbnRlcm5hbCBkYXRhIChlLmcuLA0KPiBzdHJ1Y3QgdGFza19zdHJ1Y3QpIGNhbiBi
ZSBjb21waWxlZCBvbiBhIHN5c3RlbSBydW5uaW5nIHNvbWUga2VybmVsDQo+IHZlcnNpb24sIGJ1
dCB3b3VsZCBiZSBwb3NzaWJsZSB0byBydW4gb24gb3RoZXIga2VybmVsIHZlcnNpb25zIChhbmQN
Cj4gY29uZmlndXJhdGlvbnMpIHdpdGhvdXQgcmVjb21waWxhdGlvbiwgZXZlbiBpZiB0aGUgbGF5
b3V0IG9mIHN0cnVjdHMNCj4gY2hhbmdlZCBhbmQvb3Igc29tZSBvZiB0aGUgZmllbGRzIHdlcmUg
YWRkZWQsIHJlbW92ZWQsIG9yIHJlbmFtZWQuDQo+IA0KPiBUaGlzIGlzIG9ubHkgcG9zc2libGUg
aWYgQlBGIGxvYWRlciBjYW4gZ2V0IGtlcm5lbCB0eXBlIGluZm8gdG8gYWRqdXN0DQo+IGFsbCB0
aGUgb2Zmc2V0cyBjb3JyZWN0bHkuIFRoaXMgcGF0Y2ggaXMgYSBmaXJzdCB0aW1lIGluIHRoaXMg
ZGlyZWN0aW9uLA0KPiBtYWtpbmcgc3VyZSB0aGF0IEJURiB0eXBlIGluZm8gaXMgcGFydCBvZiBM
aW51eCBrZXJuZWwgaW1hZ2UgaW4NCj4gbm9uLWxvYWRhYmxlIEVMRiBzZWN0aW9uLg0KPiANCj4g
QlRGIGRlZHVwbGljYXRpb24gKFsxXSkgYWxnb3JpdGhtIHR5cGljYWxseSBwcm92aWRlcyAxMDB4
IHNhdmluZ3MNCj4gY29tcGFyZWQgdG8gRFdBUkYgZGF0YSwgc28gcmVzdWx0aW5nIC5CVEYgc2Vj
dGlvbiBpcyBub3QgYmlnIGFzIGlzDQo+IHR5cGljYWxseSBhYm91dCAyTUIgaW4gc2l6ZS4NCj4g
DQo+IFswXSBodHRwOi8vdmdlci5rZXJuZWwub3JnL2xwYy1icGYyMDE4Lmh0bWwjc2Vzc2lvbi0y
DQo+IFsxXSBodHRwczovL2ZhY2Vib29rbWljcm9zaXRlcy5naXRodWIuaW8vYnBmL2Jsb2cvMjAx
OC8xMS8xNC9idGYtZW5oYW5jZW1lbnQuaHRtbA0KPiANCj4gQ2M6IE1hc2FoaXJvIFlhbWFkYSA8
eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+DQoNCk1hc2FoaXJvLA0KDQpjb3VsZCB5b3Ug
cGxlYXNlIHJldmlldyB0aGlzIHBhdGNoPw0KSXQncyBiZWVuIHBlbmRpbmcgZm9yIDEwIGRheXMh
DQoNClRoYW5rcw0KDQo+IENjOiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAcmVkaGF0
LmNvbT4NCj4gQ2M6IERhbmllbCBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+DQo+IENj
OiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBmYi5jb20+DQo+IENjOiBZb25naG9uZyBTb25nIDx5
aHNAZmIuY29tPg0KPiBDYzogTWFydGluIEthRmFpIExhdSA8a2FmYWlAZmIuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaW5AZmIuY29tPg0KPiAtLS0NCj4gICBN
YWtlZmlsZSAgICAgICAgICAgICAgICB8ICAzICsrLQ0KPiAgIGxpYi9LY29uZmlnLmRlYnVnICAg
ICAgIHwgIDggKysrKysrKysNCj4gICBzY3JpcHRzL2xpbmstdm1saW51eC5zaCB8IDIwICsrKysr
KysrKysrKysrKysrKystDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUNCj4g
aW5kZXggZDU3MTNlN2IxZTUwLi5hNTUzMDgxNDdhMDkgMTAwNjQ0DQo+IC0tLSBhL01ha2VmaWxl
DQo+ICsrKyBiL01ha2VmaWxlDQo+IEBAIC0zODcsNiArMzg3LDcgQEAgTk0JCT0gJChDUk9TU19D
T01QSUxFKW5tDQo+ICAgU1RSSVAJCT0gJChDUk9TU19DT01QSUxFKXN0cmlwDQo+ICAgT0JKQ09Q
WQkJPSAkKENST1NTX0NPTVBJTEUpb2JqY29weQ0KPiAgIE9CSkRVTVAJCT0gJChDUk9TU19DT01Q
SUxFKW9iamR1bXANCj4gK1BBSE9MRQkJPSBwYWhvbGUNCj4gICBMRVgJCT0gZmxleA0KPiAgIFlB
Q0MJCT0gYmlzb24NCj4gICBBV0sJCT0gYXdrDQo+IEBAIC00NDIsNyArNDQzLDcgQEAgS0JVSUxE
X0xERkxBR1MgOj0NCj4gICBHQ0NfUExVR0lOU19DRkxBR1MgOj0NCj4gICANCj4gICBleHBvcnQg
QVJDSCBTUkNBUkNIIENPTkZJR19TSEVMTCBIT1NUQ0MgS0JVSUxEX0hPU1RDRkxBR1MgQ1JPU1Nf
Q09NUElMRSBBUyBMRCBDQw0KPiAtZXhwb3J0IENQUCBBUiBOTSBTVFJJUCBPQkpDT1BZIE9CSkRV
TVAgS0JVSUxEX0hPU1RMREZMQUdTIEtCVUlMRF9IT1NUTERMSUJTDQo+ICtleHBvcnQgQ1BQIEFS
IE5NIFNUUklQIE9CSkNPUFkgT0JKRFVNUCBQQUhPTEUgS0JVSUxEX0hPU1RMREZMQUdTIEtCVUlM
RF9IT1NUTERMSUJTDQo+ICAgZXhwb3J0IE1BS0UgTEVYIFlBQ0MgQVdLIEdFTktTWU1TIElOU1RB
TExLRVJORUwgUEVSTCBQWVRIT04gUFlUSE9OMiBQWVRIT04zIFVUU19NQUNISU5FDQo+ICAgZXhw
b3J0IEhPU1RDWFggS0JVSUxEX0hPU1RDWFhGTEFHUyBMREZMQUdTX01PRFVMRSBDSEVDSyBDSEVD
S0ZMQUdTDQo+ICAgDQo+IGRpZmYgLS1naXQgYS9saWIvS2NvbmZpZy5kZWJ1ZyBiL2xpYi9LY29u
ZmlnLmRlYnVnDQo+IGluZGV4IGQ0ZGY1YjI0ZDc1ZS4uY2NlNzhkY2QxOWEyIDEwMDY0NA0KPiAt
LS0gYS9saWIvS2NvbmZpZy5kZWJ1Zw0KPiArKysgYi9saWIvS2NvbmZpZy5kZWJ1Zw0KPiBAQCAt
MjAwLDYgKzIwMCwxNCBAQCBjb25maWcgREVCVUdfSU5GT19EV0FSRjQNCj4gICAJICBCdXQgaXQg
c2lnbmlmaWNhbnRseSBpbXByb3ZlcyB0aGUgc3VjY2VzcyBvZiByZXNvbHZpbmcNCj4gICAJICB2
YXJpYWJsZXMgaW4gZ2RiIG9uIG9wdGltaXplZCBjb2RlLg0KPiAgIA0KPiArY29uZmlnIERFQlVH
X0lORk9fQlRGDQo+ICsJYm9vbCAiR2VuZXJhdGUgQlRGIHR5cGVpbmZvIg0KPiArCWRlcGVuZHMg
b24gREVCVUdfSU5GTw0KPiArCWhlbHANCj4gKwkgIEdlbmVyYXRlIGRlZHVwbGljYXRlZCBCVEYg
dHlwZSBpbmZvcm1hdGlvbiBmcm9tIERXQVJGIGRlYnVnIGluZm8uDQo+ICsJICBUdXJuaW5nIHRo
aXMgb24gZXhwZWN0cyBwcmVzZW5jZSBvZiBwYWhvbGUgdG9vbCwgd2hpY2ggd2lsbCBjb252ZXJ0
DQo+ICsJICBEV0FSRiB0eXBlIGluZm8gaW50byBlcXVpdmFsZW50IGRlZHVwbGljYXRlZCBCVEYg
dHlwZSBpbmZvLg0KPiArDQo+ICAgY29uZmlnIEdEQl9TQ1JJUFRTDQo+ICAgCWJvb2wgIlByb3Zp
ZGUgR0RCIHNjcmlwdHMgZm9yIGtlcm5lbCBkZWJ1Z2dpbmciDQo+ICAgCWRlcGVuZHMgb24gREVC
VUdfSU5GTw0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9saW5rLXZtbGludXguc2ggYi9zY3JpcHRz
L2xpbmstdm1saW51eC5zaA0KPiBpbmRleCBjOGNmNDUzNjJiZDYuLjczYmI3ZGZkYzJjOSAxMDA3
NTUNCj4gLS0tIGEvc2NyaXB0cy9saW5rLXZtbGludXguc2gNCj4gKysrIGIvc2NyaXB0cy9saW5r
LXZtbGludXguc2gNCj4gQEAgLTQwLDcgKzQwLDcgQEAgc2V0IC1lDQo+ICAgaW5mbygpDQo+ICAg
ew0KPiAgIAlpZiBbICIke3F1aWV0fSIgIT0gInNpbGVudF8iIF07IHRoZW4NCj4gLQkJcHJpbnRm
ICIgICUtN3MgJXNcbiIgJHsxfSAkezJ9DQo+ICsJCXByaW50ZiAiICAlLTdzICVzXG4iICIkezF9
IiAiJHsyfSINCj4gICAJZmkNCj4gICB9DQo+ICAgDQo+IEBAIC0xMTQsNiArMTE0LDIwIEBAIHZt
bGludXhfbGluaygpDQo+ICAgCWZpDQo+ICAgfQ0KPiAgIA0KPiArIyBnZW5lcmF0ZSAuQlRGIHR5
cGVpbmZvIGZyb20gRFdBUkYgZGVidWdpbmZvDQo+ICtnZW5fYnRmKCkNCj4gK3sNCj4gKwlsb2Nh
bCBwYWhvbGVfdmVyOw0KPiArDQo+ICsJcGFob2xlX3Zlcj0kKCR7UEFIT0xFfSAtLXZlcnNpb24g
fCBzZWQgLUUgJ3MvdihbMC05XSspXC4oWzAtOV0rKS9cMVwyLycpDQo+ICsJaWYgWyAiJHtwYWhv
bGVfdmVyfSIgLWx0ICIxMTMiIF07IHRoZW4NCj4gKwkJaW5mbyAiQlRGIiAiJHsxfTogcGFob2xl
IHZlcnNpb24gJCgke1BBSE9MRX0gLS12ZXJzaW9uKSBpcyB0b28gb2xkLCBuZWVkIGF0IGxlYXN0
IHYxLjEzIg0KPiArCQlleGl0IDANCj4gKwlmaQ0KPiArDQo+ICsJaW5mbyAiQlRGIiAkezF9DQo+
ICsJTExWTV9PQkpDT1BZPSR7T0JKQ09QWX0gJHtQQUhPTEV9IC1KICR7MX0NCj4gK30NCj4gICAN
Cj4gICAjIENyZWF0ZSAkezJ9IC5vIGZpbGUgd2l0aCBhbGwgc3ltYm9scyBmcm9tIHRoZSAkezF9
IG9iamVjdCBmaWxlDQo+ICAga2FsbHN5bXMoKQ0KPiBAQCAtMjgxLDYgKzI5NSwxMCBAQCBmaQ0K
PiAgIGluZm8gTEQgdm1saW51eA0KPiAgIHZtbGludXhfbGluayAiJHtrYWxsc3ltc299IiB2bWxp
bnV4DQo+ICAgDQo+ICtpZiBbIC1uICIke0NPTkZJR19ERUJVR19JTkZPX0JURn0iIF07IHRoZW4N
Cj4gKwlnZW5fYnRmIHZtbGludXgNCj4gK2ZpDQo+ICsNCj4gICBpZiBbIC1uICIke0NPTkZJR19C
VUlMRFRJTUVfRVhUQUJMRV9TT1JUfSIgXTsgdGhlbg0KPiAgIAlpbmZvIFNPUlRFWCB2bWxpbnV4
DQo+ICAgCXNvcnRleHRhYmxlIHZtbGludXgNCj4gDQoNCg==
