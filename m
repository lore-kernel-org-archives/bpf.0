Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35584C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFAC20685
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 16:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Tj3DTZeQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="erL88kv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfDVQ7A (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:59:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60140 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfDVQ7A (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Apr 2019 12:59:00 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MGwG7F020914;
        Mon, 22 Apr 2019 09:58:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2NPb1aLSxGJH2zl72+gVfzN6IkFazNEWT+S1mKx/e9M=;
 b=Tj3DTZeQtCRCwfa24Mtt9NpxLagkeKUNn37GqThnCMn36zlzrouUaavK6Puyb2B7fts0
 H2ciOAMMW72sV2BGOW9a31e+qjrH/5yNrBVP/bowoCcrasm6iBx2lxkAot0dPk7b64Qc
 A1chFO1f9Z0yOJMXaYzYUjAWPHn5HoFb+5A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s1fxc0euh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 09:58:38 -0700
Received: from frc-mbx04.TheFacebook.com (192.168.155.19) by
 frc-hub05.TheFacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 09:58:38 -0700
Received: from frc-hub02.TheFacebook.com (192.168.177.72) by
 frc-mbx04.TheFacebook.com (192.168.155.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 09:58:37 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 09:58:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NPb1aLSxGJH2zl72+gVfzN6IkFazNEWT+S1mKx/e9M=;
 b=erL88kv6vvyJNuSfB0zmmq5p8RDGQDUxar3WrR6YrrZjy62iVb20pq7nkZiHNi8ZlbSNawx3Uar9aQVFZCRDY44UtQKiStLW7Ov7GxUE/b4EYH/EkPk3WQBdWfThr+4NOq6uv1o/3TEygYuWp68ff6UQmPBK2QDeF1c4lJVoWEw=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2725.namprd15.prod.outlook.com (20.179.157.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Mon, 22 Apr 2019 16:58:36 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 16:58:36 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Xiao Han <xiao.han@orange.com>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf 1/2] bpf: mark registers as safe or unknown in all
 frames
Thread-Topic: [PATCH bpf 1/2] bpf: mark registers as safe or unknown in all
 frames
Thread-Index: AQHU93YysLhhpQKBzUGR+aIwsmjvGaZIak4A
Date:   Mon, 22 Apr 2019 16:58:35 +0000
Message-ID: <118d6725-56c6-7578-1984-5427c809e024@fb.com>
References: <cover.1555761008.git.paul.chaignon@orange.com>
 <06e9f9c4c3cb780459fa22e552fe65328726e55c.1555761008.git.paul.chaignon@orange.com>
In-Reply-To: <06e9f9c4c3cb780459fa22e552fe65328726e55c.1555761008.git.paul.chaignon@orange.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0043.prod.exchangelabs.com (2603:10b6:300:101::29)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:70ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc8f6ce9-e090-45ef-9a02-08d6c743c250
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2725;
x-ms-traffictypediagnostic: BYAPR15MB2725:
x-microsoft-antispam-prvs: <BYAPR15MB272500595011D633F3F95AA9D3220@BYAPR15MB2725.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(136003)(346002)(199004)(189003)(2616005)(6512007)(446003)(53936002)(476003)(305945005)(11346002)(316002)(7736002)(6246003)(36756003)(6486002)(486006)(478600001)(6436002)(86362001)(31696002)(2201001)(5660300002)(229853002)(68736007)(110136005)(54906003)(52116002)(14454004)(2501003)(31686004)(25786009)(2906002)(102836004)(71200400001)(6506007)(71190400001)(386003)(8676002)(81166006)(81156014)(4326008)(53546011)(46003)(66946007)(256004)(14444005)(66556008)(66446008)(97736004)(64756008)(6116002)(8936002)(66476007)(99286004)(76176011)(186003)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2725;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: swwboRvZZmnsAU5IGgiBEFAJHJtmWmZx4wnFrvm0MBJfnHLbWXdIpweE0pcseyaAbcb6VAR39OD9TMd82SviJicRjv7/RfM8Uu3Y/icflmU37OYiAm7tN0N/soMgbbO6tOjZHW2NJhwfTDWJO3DaInN2Ud7bo0+lFd7SzmwO5ymwKEWMz+K6JjYaIGPyXYB12/OErf80GO7TA8mOEGsFczvHagoDzCPtem1CWtBUaM5D1HcF4DcxNqoG83NjpiKMY/R9c4+8vsJROi8JSXswGNHnTkhfXJWmvQjLfEbJMWMjyhHwfkPTVbeU0czVX2V6au+Py4A7sn0WXj8ktcSJomUrRRW14eMAJzaqn6WrsVIGSBeUXzs+gOvGPgVxnuKMTgNWKFaRJZqPP3Kg2WMu5oB6wylp/Xjmm691TkldXcI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58F8EFE47DE9304AB874A23AD0A46D9D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8f6ce9-e090-45ef-9a02-08d6c743c250
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 16:58:35.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2725
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjAvMTkgNTozOSBBTSwgUGF1bCBDaGFpZ25vbiB3cm90ZToNCj4gSW4gY2FzZSBv
ZiBhIG51bGwgY2hlY2sgb24gYSBwb2ludGVyIGluc2lkZSBhIHN1YnByb2csIHdlIHNob3VsZCBt
YXJrIGFsbA0KPiByZWdpc3RlcnMgd2l0aCB0aGlzIHBvaW50ZXIgYXMgZWl0aGVyIHNhZmUgb3Ig
dW5rbm93biwgaW4gYm90aCB0aGUgY3VycmVudA0KPiBhbmQgcHJldmlvdXMgZnJhbWVzLiAgQ3Vy
cmVudGx5LCBvbmx5IHNwaWxsZWQgcmVnaXN0ZXJzIGFuZCByZWdpc3RlcnMgaW4NCj4gdGhlIGN1
cnJlbnQgZnJhbWUgYXJlIG1hcmtlZC4gIFRoaXMgcGF0Y2ggYWxzbyBtYXJrcyByZWdpc3RlcnMg
aW4gcHJldmlvdXMNCj4gZnJhbWVzLg0KPiANCj4gQSBnb29kIHJlcHJvZHVjZXIgbG9va3MgYXMg
Zm9sbG93Og0KPiANCj4gMTogcHRyID0gYnBmX21hcF9sb29rdXBfZWxlbShtYXAsICZrZXkpOw0K
PiAyOiByZXQgPSBzdWJwcm9nKHB0cikgew0KPiAzOiAgIHJldHVybiBwdHIgIT0gTlVMTDsNCj4g
NDogfQ0KPiA1OiBpZiAocmV0KQ0KPiA2OiAgIHZhbHVlID0gKnB0cjsNCj4gDQo+IFdpdGggdGhl
IGFib3ZlLCB0aGUgdmVyaWZpZXIgd2lsbCBjb21wbGFpbiBvbiBsaW5lIDYgYmVjYXVzZSBpdCBz
ZWVzIHB0cg0KPiBhcyBtYXBfdmFsdWVfb3JfbnVsbCBkZXNwaXRlIHRoZSBudWxsIGNoZWNrIGlu
IHN1YnByb2cgMS4NCj4gDQo+IE5vdGUgdGhhdCB0aGlzIHBhdGNoIGZpeGVzIGFub3RoZXIgcmVz
dWx0aW5nIGJ1ZyB3aGVuIHVzaW5nDQo+IGJwZl9za19yZWxlYXNlKCk6DQo+IA0KPiAxOiBzayA9
IGJwZl9za19sb29rdXBfdGNwKCk7DQo+IDI6IHN1YnByb2coc2spIHsNCj4gMzogICBpZiAoc2sp
DQo+IDQ6ICAgICBicGZfc2tfcmVsZWFzZShzaywgMCk7DQo+IDU6IH0NCj4gNjogaWYgKCFzaykN
Cj4gNzogICByZXR1cm4gMDsNCj4gODogcmV0dXJuIHNrOw0KDQpUaGUgcGF0Y2ggYmVsb3cgbG9v
a3MgZ29vZCB0byBtZSwgYnV0IEkgd291bGQgbGlrZSB0byBoYXZlIA0KYnBmX3NrX2xvb2t1cF90
Y3AoKSBleGFtcGxlIGZpeGVkIHNvIHdlIGNhbiBmdXJ0aGVyIHZlcmlmeSBpdA0KaW5kZWVkIGZp
eGVkIHRoZSBicGZfc2tfcmVsZWFzZSgpIGlzc3VlLg0KDQo+IA0KPiBJbiB0aGUgYWJvdmUsIG1h
cmtfcHRyX29yX251bGxfcmVncyB3aWxsIHdhcm4gb24gbGluZSA2IGJlY2F1c2UgaXQgd2lsbA0K
PiB0cnkgdG8gZnJlZSB0aGUgcmVmZXJlbmNlIHN0YXRlLCBldmVuIHRob3VnaCBpdCB3YXMgYWxy
ZWFkeSBmcmVlZCBvbg0KPiBsaW5lIDMuDQo+IA0KPiBGaXhlczogZjRkN2U0MGE1YjcxICgiYnBm
OiBpbnRyb2R1Y2UgZnVuY3Rpb24gY2FsbHMgKHZlcmlmaWNhdGlvbikiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBQYXVsIENoYWlnbm9uIDxwYXVsLmNoYWlnbm9uQG9yYW5nZS5jb20+DQo+IC0tLQ0KPiAg
IGtlcm5lbC9icGYvdmVyaWZpZXIuYyB8IDYgKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwv
YnBmL3ZlcmlmaWVyLmMgYi9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMNCj4gaW5kZXggZGIzMDFlOWI1
Mjk1Li43Nzc5NzBkOGMyNDUgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYw0K
PiArKysgYi9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMNCj4gQEAgLTQ4NzYsMTEgKzQ4NzYsMTEgQEAg
c3RhdGljIHZvaWQgbWFya19wdHJfb3JfbnVsbF9yZWdzKHN0cnVjdCBicGZfdmVyaWZpZXJfc3Rh
dGUgKnZzdGF0ZSwgdTMyIHJlZ25vLA0KPiAgIAkJICovDQo+ICAgCQlXQVJOX09OX09OQ0UocmVs
ZWFzZV9yZWZlcmVuY2Vfc3RhdGUoc3RhdGUsIGlkKSk7DQo+ICAgDQo+IC0JZm9yIChpID0gMDsg
aSA8IE1BWF9CUEZfUkVHOyBpKyspDQo+IC0JCW1hcmtfcHRyX29yX251bGxfcmVnKHN0YXRlLCAm
cmVnc1tpXSwgaWQsIGlzX251bGwpOw0KPiAtDQo+ICAgCWZvciAoaiA9IDA7IGogPD0gdnN0YXRl
LT5jdXJmcmFtZTsgaisrKSB7DQo+ICAgCQlzdGF0ZSA9IHZzdGF0ZS0+ZnJhbWVbal07DQo+ICsJ
CWZvciAoaSA9IDA7IGkgPCBNQVhfQlBGX1JFRzsgaSsrKQ0KPiArCQkJbWFya19wdHJfb3JfbnVs
bF9yZWcoc3RhdGUsICZzdGF0ZS0+cmVnc1tpXSwgaWQsDQo+ICsJCQkJCSAgICAgaXNfbnVsbCk7
DQo+ICAgCQlicGZfZm9yX2VhY2hfc3BpbGxlZF9yZWcoaSwgc3RhdGUsIHJlZykgew0KPiAgIAkJ
CWlmICghcmVnKQ0KPiAgIAkJCQljb250aW51ZTsNCj4gDQo=
