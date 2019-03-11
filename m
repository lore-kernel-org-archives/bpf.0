Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E8C43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 07:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F05205C9
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 07:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AsYZ2Pw3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ITfXRC5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfCKHCx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:02:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40298 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbfCKHCx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Mar 2019 03:02:53 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2B72QTY032538;
        Mon, 11 Mar 2019 00:02:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=82vM4F80izHxAc06H/LwvY3RDklQB+Pw9w3/k2XrKU4=;
 b=AsYZ2Pw34qjcqyVKwyXwakMcORHxDqclMrzysZoWAh4eDATTkcg2shRM/AN5dO0ZAFlv
 9gef3yWP+B0LjBBhS/reqEH4xe5Nx1DqpAr+zYFcqTAGx9XTc/Mq8bp4rzEew2N15t0v
 /KthR5U81uHLB0AefQVgcREHev0omfUgtbQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5f550g90-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 00:02:31 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 00:02:23 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 00:02:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82vM4F80izHxAc06H/LwvY3RDklQB+Pw9w3/k2XrKU4=;
 b=ITfXRC5ZuEer5Ylh3k/iuJmFZr3ZB4T6SJK8QnI8amwRy0Yk0FPmnh7xD/CTl3qxWLnRhSnWCYKdX+0bQCgKftyJbmuWUaqlHySWoFBAqs860fLz5SZuivz/jD1EiEred0lMBa7guB0EFGeDzUgDkfsE7fjmawYu/YUkE/ueivI=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2453.namprd15.prod.outlook.com (52.135.198.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Mon, 11 Mar 2019 07:02:20 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:02:20 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "Alexei Starovoitov" <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/2] btf: resolve enum fwds in btf_dedup
Thread-Topic: [PATCH bpf-next 1/2] btf: resolve enum fwds in btf_dedup
Thread-Index: AQHU16Og94VQQ1rhwESr4pk17UVsnaYGAXEA
Date:   Mon, 11 Mar 2019 07:02:20 +0000
Message-ID: <755d4871-f8a1-ec31-02bf-87ffe82cdd56@fb.com>
References: <20190311004410.3896503-1-andriin@fb.com>
 <20190311004410.3896503-2-andriin@fb.com>
In-Reply-To: <20190311004410.3896503-2-andriin@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:301:3a::14) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::8d45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e38f8c04-5f0d-4c2b-ba46-08d6a5ef813a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2453;
x-ms-traffictypediagnostic: BYAPR15MB2453:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2453;20:fwdY8IiTl2Ia3iQAWmv+XqV1kst2TZUY7Gd1Cz3RhhDKoT+m9EfgAYae+eIStug9znxW0wEtZQDhrKISQQTGwLmGyxZW/qYvDiTZBgJDceTZHjY0BGPpqGyeqIRtEKgpinVqqqzT4vXnyncGx8LzASTDbOu12DReod/8uFJgIyg=
x-microsoft-antispam-prvs: <BYAPR15MB2453EC5D8512119680ABA346D3480@BYAPR15MB2453.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(8936002)(14454004)(2201001)(478600001)(97736004)(81166006)(81156014)(8676002)(68736007)(305945005)(229853002)(31686004)(7736002)(86362001)(6506007)(53546011)(52116002)(386003)(102836004)(99286004)(5660300002)(31696002)(76176011)(106356001)(105586002)(2906002)(2501003)(186003)(46003)(36756003)(486006)(256004)(6246003)(316002)(446003)(476003)(110136005)(6116002)(2616005)(11346002)(25786009)(53936002)(6436002)(6486002)(6512007)(71190400001)(71200400001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2453;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7ATTk09XecWk75PdRhIy1C2DqtRo71c1UaSn7E6v1E01YvF+dx4Nv2nUfykrQXtX5yD4drauhNQ6kXgCCOTp8TkIAitIWsVwRq9tjylr9GfXgS8YAzi+ROnFRFWTmu4Fw3hUnRaNxMcfK8wW5IzYg1Q5uGIY3cMtfQKOw7rTOc4K+90oHu6GYJ8glATEHzjLVAbKGTmabjW1gSc6bVfCKdynSGIlbFFs15xM+//vYxTkZyZfxQT8KhwFKNegZsBVdO2/f/tBKFR6sEc1fVonIKbaLDuwHvjZiMgDRKZ95P1C+t9nilxD4KSwgI/r3bFj4LyfctauZRdDx6KkuCagCsYPp7upSxp4JDfiPiFtoz99onOUyDiWaiYPwg/YLF2y6W+yDQT5N73iPvoOYPL24vICiCtgdnrRTbarnBGWluI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1814C935AAB214B8D0B61871D7488D3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e38f8c04-5f0d-4c2b-ba46-08d6a5ef813a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:02:20.6032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2453
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDMvMTAvMTkgNTo0NCBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBHQ0MgYW5k
IGNsYW5nIHN1cHBvcnQgZW51bSBmb3J3YXJkIGRlY2xhcmF0aW9ucyBhcyBhbiBleHRlbnNpb24u
IFN1Y2gNCj4gZm9yd2FyZC1kZWNsYXJlZCBlbnVtcyB3aWxsIGJlIHJlcHJlc2VudGVkIGFzIG5v
cm1hbCBCVEZfS0lORF9FTlVNIHR5cGVzIHdpdGgNCj4gdmxlbj0wLiBUaGlzIHBhdGNoIGFkZHMg
YWJpbGl0eSB0byByZXNvbHZlIHN1Y2ggZW51bXMgdG8gdGhlaXIgY29ycmVzcG9uZGluZw0KDQpU
aGFua3MgQW5kcmlpIGZvciByZXBvcnRpbmcgYW5kIHRyeWluZyB0byBmaXggZm9yd2FyZC1kZWNs
YXJlZCBlbnVtIA0KaXNzdWUuIFRoZSBjdXJyZW50IGFwcHJvYWNoIHRvIHJlcHJlc2VudCBmb3J3
YXJkIGVudW0gd2l0aA0KQlRGX0tJTkRfRU5VTSB3aXRoIHZsZW4gPSAwIGRvZXMgd29yay4gImVu
dW0gQSB7fTsiIGlzIGlsbGVnYWwgZm9yIEMsDQpzbyB2bGVuPTAgbXVzdCBiZSBhIGZvcndhcmQg
ZGVjbGFyYXRpb24uDQoNCkJ1dCB0aGlzIGlzIHByb2JhYmx5IG5vdCB0aGUgYmVzdCBzaW5jZSB3
ZSBoYXZlIEJURl9LSU5EX0ZXRCB0byBtYWtlIA0KZm9yd2FyZCBkZWNsYXJhdGlvbiBleHBsaWNp
dC4NCg0KQ3VycmVudGx5IEJURl9LSU5EX0ZXRCB1c2VzIChidGZfdHlwZS5pbmZvID4+IDMxKSB0
byBkaXN0aW5ndWlzaA0Kc3RydWN0L3VuaW9uLiBJZiBidGZfdHlwZS5pbmZvID4+IDMxID09IDAs
IGl0IGlzIGEgc3RydWN0LCBvdGhlcndpc2UNCml0IGlzIGEgdW5pb24uDQoNCldlIGNvdWxkIGV4
dGVuZCB0aGlzIHRvIGNvdmVyIGZvcndhcmQgZW51bSBhcyB3ZWxsIHdpdGggYmFja3dhcmQgDQpj
b21wYWJpbGl0eS4gV2UgY2FuIGV4dGVuZCBieSB1c2luZyBib3RoIGJpdCAzMCBhbmQgYml0IDMx
Og0KICAgYnRmX3R5cGUuaW5mbyA+PiAzMSAgIChidGZfdHlwZS5pbmZvID4+IDMwKSAmIDB4MQ0K
ICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICA8PT0gc3RydWN0
DQogICAgICAgICAxICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDw9PSB1bmlv
bg0KICAgICAgICAgMCAgICAgICAgICAgICAgICAgIDEgICAgICAgICAgICAgICAgICA8PT0gZW51
bQ0KDQpNYXliZSB0aGlzIG1heSBiZSByZWFzb25hYmxlPw0KDQpUaGlzIHdpbGwgcmVxdWlyZSBw
YWhvbGUgYW5kIGxsdm0gY2hhbmdlIHRvIHN1cHBvcnQsIGJlc2lkZXMga2VybmVsIA0Kc3VwcG9y
dC4gSSB3aWxsIHRyeSB0byBwcm90b3R5cGUgbGx2bSBzdXBwb3J0IHRvbW9ycm93Lg0KDQoNCj4g
ZnVsbHkgZGVmaW5lZCBlbnVtcy4gVGhpcyBoZWxwcyB0byBhdm9pZCBkdXBsaWNhdGVkIEJURiB0
eXBlIGdyYXBocyB3aGljaCBvbmx5DQo+IGRpZmZlciBieSBzb21lIHR5cGVzIHJlZmVyZW5jaW5n
IGZvcndhcmQtZGVjbGFyZWQgZW51bSB2cyBmdWxsIGVudW0uDQo+IA0KPiBPbmUgc3VjaCBleGFt
cGxlIGluIGtlcm5lbCBpcyBlbnVtIGlycWNoaXBfaXJxX3N0YXRlLCBkZWZpbmVkIGluDQo+IGlu
Y2x1ZGUvbGludXgvaW50ZXJydXB0LmggYW5kIGZvcndhcmQtZGVjbGFyZWQgaW4gaW5jbHVkZS9s
aW51eC9pcnEuaC4gVGhpcw0KPiBjYXVzZXMgZW50aXJlIHN0cnVjdCB0YXNrX3N0cnVjdCBhbmQg
YWxsIHJlZmVyZW5jZWQgdHlwZXMgdG8gYmUgZHVwbGljYXRlZCBpbg0KPiBidGZfZGVkdXAgb3V0
cHV0LiBUaGlzIHBhdGNoIGVsaW1pbmF0ZXMgc3VjaCBkdXBsaWNhdGlvbiBjYXNlcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpbkBmYi5jb20+DQo+IC0tLQ0K
PiAgIHRvb2xzL2xpYi9icGYvYnRmLmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwg
MTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9idGYuYyBi
L3Rvb2xzL2xpYi9icGYvYnRmLmMNCj4gaW5kZXggMWI4ZDhjZGQzNTc1Li44N2UzMDIwYWMxYmMg
MTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL2xpYi9icGYvYnRmLmMNCj4gKysrIGIvdG9vbHMvbGliL2Jw
Zi9idGYuYw0KPiBAQCAtMTYwMiwxNiArMTYwMiwxMiBAQCBzdGF0aWMgYm9vbCBidGZfZXF1YWxf
aW50KHN0cnVjdCBidGZfdHlwZSAqdDEsIHN0cnVjdCBidGZfdHlwZSAqdDIpDQo+ICAgLyogQ2Fs
Y3VsYXRlIHR5cGUgc2lnbmF0dXJlIGhhc2ggb2YgRU5VTS4gKi8NCj4gICBzdGF0aWMgX191MzIg
YnRmX2hhc2hfZW51bShzdHJ1Y3QgYnRmX3R5cGUgKnQpDQo+ICAgew0KPiAtCXN0cnVjdCBidGZf
ZW51bSAqbWVtYmVyID0gKHN0cnVjdCBidGZfZW51bSAqKSh0ICsgMSk7DQo+IC0JX191MzIgdmxl
biA9IEJURl9JTkZPX1ZMRU4odC0+aW5mbyk7DQo+IC0JX191MzIgaCA9IGJ0Zl9oYXNoX2NvbW1v
bih0KTsNCj4gLQlpbnQgaTsNCj4gKwlfX3UzMiBoOw0KPiAgIA0KPiAtCWZvciAoaSA9IDA7IGkg
PCB2bGVuOyBpKyspIHsNCj4gLQkJaCA9IGhhc2hfY29tYmluZShoLCBtZW1iZXItPm5hbWVfb2Zm
KTsNCj4gLQkJaCA9IGhhc2hfY29tYmluZShoLCBtZW1iZXItPnZhbCk7DQo+IC0JCW1lbWJlcisr
Ow0KPiAtCX0NCj4gKwkvKiBkb24ndCBoYXNoIHZsZW4gYW5kIGVudW0gbWVtYmVycyB0byBzdXBw
b3J0IGVudW0gZndkIHJlc29sdmluZyAqLw0KPiArCWggPSBoYXNoX2NvbWJpbmUoMCwgdC0+bmFt
ZV9vZmYpOw0KPiArCWggPSBoYXNoX2NvbWJpbmUoaCwgdC0+aW5mbyAmIH4weGZmZmYpOw0KPiAr
CWggPSBoYXNoX2NvbWJpbmUoaCwgdC0+c2l6ZSk7DQo+ICAgCXJldHVybiBoOw0KPiAgIH0NCj4g
ICANCj4gQEAgLTE2MzcsNiArMTYzMywyMiBAQCBzdGF0aWMgYm9vbCBidGZfZXF1YWxfZW51bShz
dHJ1Y3QgYnRmX3R5cGUgKnQxLCBzdHJ1Y3QgYnRmX3R5cGUgKnQyKQ0KPiAgIAlyZXR1cm4gdHJ1
ZTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgYnRmX2lzX2VudW1fZndkKHN0
cnVjdCBidGZfdHlwZSAqdCkNCj4gK3sNCj4gKwlyZXR1cm4gQlRGX0lORk9fS0lORCh0LT5pbmZv
KSA9PSBCVEZfS0lORF9FTlVNICYmDQo+ICsJICAgICAgIEJURl9JTkZPX1ZMRU4odC0+aW5mbykg
PT0gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGJvb2wgYnRmX2NvbXBhdF9lbnVtKHN0cnVjdCBi
dGZfdHlwZSAqdDEsIHN0cnVjdCBidGZfdHlwZSAqdDIpDQo+ICt7DQo+ICsJaWYgKCFidGZfaXNf
ZW51bV9md2QodDEpICYmICFidGZfaXNfZW51bV9md2QodDIpKQ0KPiArCQlyZXR1cm4gYnRmX2Vx
dWFsX2VudW0odDEsIHQyKTsNCj4gKwkvKiBpZ25vcmUgdmxlbiB3aGVuIGNvbXBhcmluZyAqLw0K
PiArCXJldHVybiB0MS0+bmFtZV9vZmYgPT0gdDItPm5hbWVfb2ZmICYmDQo+ICsJICAgICAgICh0
MS0+aW5mbyAmIH4weGZmZmYpID09ICh0Mi0+aW5mbyAmIH4weGZmZmYpICYmDQo+ICsJICAgICAg
IHQxLT5zaXplID09IHQyLT5zaXplOw0KPiArfQ0KPiArDQo+ICAgLyoNCj4gICAgKiBDYWxjdWxh
dGUgdHlwZSBzaWduYXR1cmUgaGFzaCBvZiBTVFJVQ1QvVU5JT04sIGlnbm9yaW5nIHJlZmVyZW5j
ZWQgdHlwZSBJRHMsDQo+ICAgICogYXMgcmVmZXJlbmNlZCB0eXBlIElEcyBlcXVpdmFsZW5jZSBp
cyBlc3RhYmxpc2hlZCBzZXBhcmF0ZWx5IGR1cmluZyB0eXBlDQo+IEBAIC0xODYwLDYgKzE4NzIs
MTcgQEAgc3RhdGljIGludCBidGZfZGVkdXBfcHJpbV90eXBlKHN0cnVjdCBidGZfZGVkdXAgKmQs
IF9fdTMyIHR5cGVfaWQpDQo+ICAgCQkJCW5ld19pZCA9IGNhbmRfbm9kZS0+dHlwZV9pZDsNCj4g
ICAJCQkJYnJlYWs7DQo+ICAgCQkJfQ0KPiArCQkJaWYgKGQtPm9wdHMuZG9udF9yZXNvbHZlX2Z3
ZHMpDQo+ICsJCQkJY29udGludWU7DQo+ICsJCQlpZiAoYnRmX2NvbXBhdF9lbnVtKHQsIGNhbmQp
KSB7DQo+ICsJCQkJaWYgKGJ0Zl9pc19lbnVtX2Z3ZCh0KSkgew0KPiArCQkJCQkvKiByZXNvbHZl
IGZ3ZCB0byBmdWxsIGVudW0gKi8NCj4gKwkJCQkJbmV3X2lkID0gY2FuZF9ub2RlLT50eXBlX2lk
Ow0KPiArCQkJCQlicmVhazsNCj4gKwkJCQl9DQo+ICsJCQkJLyogcmVzb2x2ZSBjYW5vbmljYWwg
ZW51bSBmd2QgdG8gZnVsbCBlbnVtICovDQo+ICsJCQkJZC0+bWFwW2NhbmRfbm9kZS0+dHlwZV9p
ZF0gPSB0eXBlX2lkOw0KPiArCQkJfQ0KPiAgIAkJfQ0KPiAgIAkJYnJlYWs7DQo+ICAgDQo+IEBA
IC0yMDg0LDE1ICsyMTA3LDE1IEBAIHN0YXRpYyBpbnQgYnRmX2RlZHVwX2lzX2VxdWl2KHN0cnVj
dCBidGZfZGVkdXAgKmQsIF9fdTMyIGNhbmRfaWQsDQo+ICAgCQlyZXR1cm4gZndkX2tpbmQgPT0g
cmVhbF9raW5kOw0KPiAgIAl9DQo+ICAgDQo+IC0JaWYgKGNhbmRfdHlwZS0+aW5mbyAhPSBjYW5v
bl90eXBlLT5pbmZvKQ0KPiAtCQlyZXR1cm4gMDsNCj4gLQ0KPiAgIAlzd2l0Y2ggKGNhbmRfa2lu
ZCkgew0KPiAgIAljYXNlIEJURl9LSU5EX0lOVDoNCj4gICAJCXJldHVybiBidGZfZXF1YWxfaW50
KGNhbmRfdHlwZSwgY2Fub25fdHlwZSk7DQo+ICAgDQo+ICAgCWNhc2UgQlRGX0tJTkRfRU5VTToN
Cj4gLQkJcmV0dXJuIGJ0Zl9lcXVhbF9lbnVtKGNhbmRfdHlwZSwgY2Fub25fdHlwZSk7DQo+ICsJ
CWlmIChkLT5vcHRzLmRvbnRfcmVzb2x2ZV9md2RzKQ0KPiArCQkJcmV0dXJuIGJ0Zl9lcXVhbF9l
bnVtKGNhbmRfdHlwZSwgY2Fub25fdHlwZSk7DQo+ICsJCWVsc2UNCj4gKwkJCXJldHVybiBidGZf
Y29tcGF0X2VudW0oY2FuZF90eXBlLCBjYW5vbl90eXBlKTsNCj4gICANCj4gICAJY2FzZSBCVEZf
S0lORF9GV0Q6DQo+ICAgCQlyZXR1cm4gYnRmX2VxdWFsX2NvbW1vbihjYW5kX3R5cGUsIGNhbm9u
X3R5cGUpOw0KPiBAQCAtMjEwMyw2ICsyMTI2LDggQEAgc3RhdGljIGludCBidGZfZGVkdXBfaXNf
ZXF1aXYoc3RydWN0IGJ0Zl9kZWR1cCAqZCwgX191MzIgY2FuZF9pZCwNCj4gICAJY2FzZSBCVEZf
S0lORF9QVFI6DQo+ICAgCWNhc2UgQlRGX0tJTkRfVFlQRURFRjoNCj4gICAJY2FzZSBCVEZfS0lO
RF9GVU5DOg0KPiArCQlpZiAoY2FuZF90eXBlLT5pbmZvICE9IGNhbm9uX3R5cGUtPmluZm8pDQo+
ICsJCQlyZXR1cm4gMDsNCj4gICAJCXJldHVybiBidGZfZGVkdXBfaXNfZXF1aXYoZCwgY2FuZF90
eXBlLT50eXBlLCBjYW5vbl90eXBlLT50eXBlKTsNCj4gICANCj4gICAJY2FzZSBCVEZfS0lORF9B
UlJBWTogew0KPiANCg==
