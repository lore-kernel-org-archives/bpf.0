Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC9C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77462083D
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="d9a6oQVo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ww5CvwgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfCBAXv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:23:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfCBAXu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Mar 2019 19:23:50 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x220NF9T022703;
        Fri, 1 Mar 2019 16:23:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4hjW6H7IEiZFrS4l7+2iobjXOUTpczgGY/KNZ36RLq0=;
 b=d9a6oQVoaC9hAKK7q4rqGnxSPRb0Uq34XOWZV4WG/WbPv6vzwjABn9FYkttnjF/x5xFP
 2vf59x8qUjcSXvjk/2bsBoX0kVFSQHMICJuJSpZG2VbDqf55z3ZG50IYUFrZgj4U7Gzk
 SqMMQPuKfmYbduh4HUo7jsLBZuEhMugohAA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qycu1reuh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 01 Mar 2019 16:23:19 -0800
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 1 Mar 2019 16:23:16 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 1 Mar 2019 16:23:15 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 1 Mar 2019 16:23:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hjW6H7IEiZFrS4l7+2iobjXOUTpczgGY/KNZ36RLq0=;
 b=Ww5CvwgSc7IU58e+yFVV2lf8dUWi6YXCJs5wBV4MR4j4JsXBu5/kjCfVMbDyl0gKbwAsSXlKfSEBK4deZsqHLlZ9QYsjlpAbP1M9YlVTrgF2nkwGcYWvE1pKwoCQDXfnzOrHFwL6hnQ6mfY2gAzQVbydJgnRHg3NKK8f7xg6eMo=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3493.namprd15.prod.outlook.com (20.179.60.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Sat, 2 Mar 2019 00:23:14 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.017; Sat, 2 Mar 2019
 00:23:14 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@fomichev.me>
CC:     Alexei Starovoitov <ast@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "tgraf@suug.ch" <tgraf@suug.ch>, Andrii Nakryiko <andriin@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
Thread-Topic: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
Thread-Index: AQHUz7wVyvWwKXwnbUuxMyCVCB5fAqX13qeAgAAKqwCAAZNygA==
Date:   Sat, 2 Mar 2019 00:23:13 +0000
Message-ID: <6169a2e0-ee95-58ec-5e96-7562e070e99a@fb.com>
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-6-daniel@iogearbox.net>
 <20190228234101.GA10108@mini-arch.hsd1.ca.comcast.net>
 <f1b4a42e-12da-1a40-60c9-cc81c8926e40@iogearbox.net>
In-Reply-To: <f1b4a42e-12da-1a40-60c9-cc81c8926e40@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:cd24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59b6acc7-6d34-476a-8d30-08d69ea54225
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3493;
x-ms-traffictypediagnostic: BYAPR15MB3493:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3493;20:4OY7et00f7jmYcShc0hvwsPk3h9PLGz+IuxHP9ft6Biqy2C6cEwL3EgYa+/jdkF8yMDmaGIFArensMs0wCHTXRQxsd0UUdF7QeSiuSixde9qJGh/a5OYc3dUO1DpDUOaSYPVucB/s3WTcYPWmTyphC0MzqXH0tMekO0qRazjI9k=
x-microsoft-antispam-prvs: <BYAPR15MB3493FB5735BF1F9C527D02BAD3770@BYAPR15MB3493.namprd15.prod.outlook.com>
x-forefront-prvs: 09645BAC66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(36756003)(6116002)(81156014)(81166006)(6246003)(93886005)(25786009)(86362001)(2906002)(4326008)(7736002)(305945005)(31696002)(6486002)(229853002)(8676002)(8936002)(71200400001)(71190400001)(105586002)(31686004)(256004)(110136005)(14454004)(5660300002)(6512007)(53546011)(68736007)(106356001)(14444005)(6436002)(2616005)(446003)(486006)(476003)(52116002)(53936002)(97736004)(11346002)(76176011)(478600001)(186003)(316002)(99286004)(46003)(6506007)(386003)(102836004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3493;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YRBAvow010+x3wGqz2Wqm6A+MgsdEGyy6mDqKXkLNIlZJW6tkFLFBDCJMQwN/zF4m8AFGvW8q1DpDgXLBLtjuNvc9rMoMnVYBEiYomL6d0SU6eO1TmlrATdQUC09Es6jmT08Ed9uD+ot2wFKZDMFx7HUIvVN3ZVSRK1t1IppmaJS0l/VQ8rOwJxNOQPubQ2vA0EWTuqWJqKB1sjZtXE0XOv4jB8YA/21N7+dKpmnOifFVVAHUJ8890KyRUOJ5GsFGEq7rUxgIYlon8hMBCgKDdZSiNNksE3BUnTbXCUHAx9o3l/YJPeqnf/b7sta1AF/jRgCgT3F9ezw2Z01EVsU9Yzii675MQYjWvVEqDuZ64tSJXBEL0CnvZe20o62DuYL3iRgk2gTIryoLGDY0EiuIUv4kK/kSO+Gjc6FbLsTlak=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F8746609DB2484FAF2AB58F87EF7619@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b6acc7-6d34-476a-8d30-08d69ea54225
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 00:23:13.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3493
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjgvMTkgNDoxOSBQTSwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPiBPbiAwMy8w
MS8yMDE5IDEyOjQxIEFNLCBTdGFuaXNsYXYgRm9taWNoZXYgd3JvdGU6DQo+PiBPbiAwMy8wMSwg
RGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPj4+IFRoaXMgd29yayBhZGRzIEJQRiBsb2FkZXIgc3Vw
cG9ydCBmb3IgZ2xvYmFsIGRhdGEgc2VjdGlvbnMNCj4+PiB0byBsaWJicGYuIFRoaXMgYWxsb3dz
IHRvIHdyaXRlIEJQRiBwcm9ncmFtcyBpbiBtb3JlIG5hdHVyYWwNCj4+PiBDLWxpa2Ugd2F5IGJ5
IGJlaW5nIGFibGUgdG8gZGVmaW5lIGdsb2JhbCB2YXJpYWJsZXMgYW5kIGNvbnN0DQo+Pj4gZGF0
YS4NCj4+Pg0KPj4+IEJhY2sgYXQgTFBDIDIwMTggWzBdIHdlIHByZXNlbnRlZCBhIGZpcnN0IHBy
b3RvdHlwZSB3aGljaA0KPj4+IGltcGxlbWVudGVkIHN1cHBvcnQgZm9yIGdsb2JhbCBkYXRhIHNl
Y3Rpb25zIGJ5IGV4dGVuZGluZyBCUEYNCj4+PiBzeXNjYWxsIHdoZXJlIHVuaW9uIGJwZl9hdHRy
IHdvdWxkIGdldCBhZGRpdGlvbmFsIG1lbW9yeS9zaXplDQo+Pj4gcGFpciBmb3IgZWFjaCBzZWN0
aW9uIHBhc3NlZCBkdXJpbmcgcHJvZyBsb2FkIGluIG9yZGVyIHRvIGxhdGVyDQo+Pj4gYWRkIHRo
aXMgYmFzZSBhZGRyZXNzIGludG8gdGhlIGxkaW1tNjQgaW5zdHJ1Y3Rpb24gYWxvbmcgd2l0aA0K
Pj4+IHRoZSB1c2VyIHByb3ZpZGVkIG9mZnNldCB3aGVuIGFjY2Vzc2luZyBhIHZhcmlhYmxlLiBD
b25zZW5zdXMNCj4+PiBmcm9tIExQQyB3YXMgdGhhdCBmb3IgcHJvcGVyIHVwc3RyZWFtIHN1cHBv
cnQsIGl0IHdvdWxkIGJlDQo+Pj4gbW9yZSBkZXNpcmFibGUgdG8gdXNlIG1hcHMgaW5zdGVhZCBv
ZiBicGZfYXR0ciBleHRlbnNpb24gYXMNCj4+PiB0aGlzIHdvdWxkIGFsbG93IGZvciBpbnRyb3Nw
ZWN0aW9uIG9mIHRoZXNlIHNlY3Rpb25zIGFzIHdlbGwNCj4+PiBhcyBwb3RlbnRpYWwgbGlmZSB1
cGRhdGVzIG9mIHRoZWlyIGNvbnRlbnQuIFRoaXMgd29yayBmb2xsb3dzDQo+Pj4gdGhpcyBwYXRo
IGJ5IHRha2luZyB0aGUgZm9sbG93aW5nIHN0ZXBzIGZyb20gbG9hZGVyIHNpZGU6DQo+Pj4NCj4+
PiAgIDEpIEluIGJwZl9vYmplY3RfX2VsZl9jb2xsZWN0KCkgc3RlcCB3ZSBwaWNrIHVwICIuZGF0
YSIsDQo+Pj4gICAgICAiLnJvZGF0YSIsIGFuZCAiLmJzcyIgc2VjdGlvbiBpbmZvcm1hdGlvbi4N
Cj4+Pg0KPj4+ICAgMikgSWYgcHJlc2VudCwgaW4gYnBmX29iamVjdF9faW5pdF9nbG9iYWxfbWFw
cygpIHdlIGNyZWF0ZQ0KPj4+ICAgICAgYSBtYXAgdGhhdCBjb3JyZXNwb25kcyB0byBlYWNoIG9m
IHRoZSBwcmVzZW50IHNlY3Rpb25zLg0KPj4+ICAgICAgR2l2ZW4gc2VjdGlvbiBzaXplIGFuZCBh
Y2Nlc3MgcHJvcGVydGllcyBjYW4gZGlmZmVyLCBhDQo+Pj4gICAgICBzaW5nbGUgZW50cnkgYXJy
YXkgbWFwIGlzIGNyZWF0ZWQgd2l0aCB2YWx1ZSBzaXplIHRoYXQNCj4+PiAgICAgIGlzIGNvcnJl
c3BvbmRpbmcgdG8gdGhlIEVMRiBzZWN0aW9uIHNpemUgb2YgLmRhdGEsIC5ic3MNCj4+PiAgICAg
IG9yIC5yb2RhdGEuIEluIHRoZSBsYXR0ZXIgY2FzZSwgdGhlIG1hcCBpcyBjcmVhdGVkIGFzDQo+
Pj4gICAgICByZWFkLW9ubHkgZnJvbSBwcm9ncmFtIHNpZGUgc3VjaCB0aGF0IHZlcmlmaWVyIHJl
amVjdHMNCj4+PiAgICAgIGFueSB3cml0ZSBhdHRlbXB0cyBpbnRvIC5yb2RhdGEuIEluIGEgc3Vi
c2VxdWVudCBzdGVwLA0KPj4+ICAgICAgZm9yIC5kYXRhIGFuZCAucm9kYXRhIHNlY3Rpb25zLCB0
aGUgc2VjdGlvbiBjb250ZW50IGlzDQo+Pj4gICAgICBjb3BpZWQgaW50byB0aGUgbWFwIHRocm91
Z2ggYnBmX21hcF91cGRhdGVfZWxlbSgpLiBGb3INCj4+PiAgICAgIC5ic3MgdGhpcyBpcyBub3Qg
bmVjZXNzYXJ5IHNpbmNlIGFycmF5IG1hcCBpcyBhbHJlYWR5DQo+Pj4gICAgICB6ZXJvLWluaXRp
YWxpemVkIGJ5IGRlZmF1bHQuDQo+Pj4NCj4+PiAgIDMpIEluIGJwZl9wcm9ncmFtX19jb2xsZWN0
X3JlbG9jKCkgc3RlcCwgd2UgcmVjb3JkIHRoZQ0KPj4+ICAgICAgY29ycmVzcG9uZGluZyBtYXAs
IGluc24gaW5kZXgsIGFuZCByZWxvY2F0aW9uIHR5cGUgZm9yDQo+Pj4gICAgICB0aGUgZ2xvYmFs
IGRhdGEuDQo+Pj4NCj4+PiAgIDQpIEFuZCBsYXN0IGJ1dCBub3QgbGVhc3QgaW4gdGhlIGFjdHVh
bCByZWxvY2F0aW9uIHN0ZXAgaW4NCj4+PiAgICAgIGJwZl9wcm9ncmFtX19yZWxvY2F0ZSgpLCB3
ZSBtYXJrIHRoZSBsZGltbTY0IGluc3RydWN0aW9uDQo+Pj4gICAgICB3aXRoIHNyY19yZWcgPSBC
UEZfUFNFVURPX01BUF9WQUxVRSB3aGVyZSBpbiB0aGUgZmlyc3QNCj4+PiAgICAgIGltbSBmaWVs
ZCB0aGUgbWFwJ3MgZmlsZSBkZXNjcmlwdG9yIGlzIHN0b3JlZCBhcyBzaW1pbGFybHkNCj4+PiAg
ICAgIGRvbmUgYXMgaW4gQlBGX1BTRVVET19NQVBfRkQsIGFuZCBpbiB0aGUgc2Vjb25kIGltbSBm
aWVsZA0KPj4+ICAgICAgKGFzIGxkaW1tNjQgaXMgMi1pbnNuIHdpZGUpIHdlIHN0b3JlIHRoZSBh
Y2Nlc3Mgb2Zmc2V0DQo+Pj4gICAgICBpbnRvIHRoZSBzZWN0aW9uLg0KPj4+DQo+Pj4gICA1KSBP
biBrZXJuZWwgc2lkZSwgdGhpcyBzcGVjaWFsIG1hcmtlZCBCUEZfUFNFVURPX01BUF9WQUxVRQ0K
Pj4+ICAgICAgbG9hZCB3aWxsIHRoZW4gc3RvcmUgdGhlIGFjdHVhbCB0YXJnZXQgYWRkcmVzcyBp
biBvcmRlcg0KPj4+ICAgICAgdG8gaGF2ZSBhICdtYXAtbG9va3VwJy1mcmVlIGFjY2Vzcy4gVGhh
dCBpcywgdGhlIGFjdHVhbA0KPj4+ICAgICAgbWFwIHZhbHVlIGJhc2UgYWRkcmVzcyArIG9mZnNl
dC4gVGhlIGRlc3RpbmF0aW9uIHJlZ2lzdGVyDQo+Pj4gICAgICBpbiB0aGUgdmVyaWZpZXIgd2ls
bCB0aGVuIGJlIG1hcmtlZCBhcyBQVFJfVE9fTUFQX1ZBTFVFLA0KPj4+ICAgICAgY29udGFpbmlu
ZyB0aGUgZml4ZWQgb2Zmc2V0IGFzIHJlZy0+b2ZmIGFuZCBiYWNraW5nIEJQRg0KPj4+ICAgICAg
bWFwIGFzIHJlZy0+bWFwX3B0ci4gTWVhbmluZywgaXQncyB0cmVhdGVkIGFzIGFueSBvdGhlcg0K
Pj4+ICAgICAgbm9ybWFsIG1hcCB2YWx1ZSBmcm9tIHZlcmlmaWNhdGlvbiBzaWRlLCBvbmx5IHdp
dGgNCj4+PiAgICAgIGVmZmljaWVudCwgZGlyZWN0IHZhbHVlIGFjY2VzcyBpbnN0ZWFkIG9mIGFj
dHVhbCBjYWxsIHRvDQo+Pj4gICAgICBtYXAgbG9va3VwIGhlbHBlciBhcyBpbiB0aGUgdHlwaWNh
bCBjYXNlLg0KPj4+DQo+Pj4gU2ltcGxlIGV4YW1wbGUgZHVtcCBvZiBwcm9ncmFtIHVzaW5nIGds
b2JhbHMgdmFycyBpbiBlYWNoDQo+Pj4gc2VjdGlvbjoNCj4+Pg0KPj4+ICAgICMgcmVhZGVsZiAt
YSB0ZXN0X2dsb2JhbF9kYXRhLm8NCj4+PiAgICBbLi4uXQ0KPj4+ICAgIFsgNl0gLmJzcyAgICAg
ICAgICAgICAgTk9CSVRTICAgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMDMyOA0KPj4+
ICAgICAgICAgMDAwMDAwMDAwMDAwMDAxMCAgMDAwMDAwMDAwMDAwMDAwMCAgV0EgICAgICAgMCAg
ICAgMCAgICAgOA0KPj4+ICAgIFsgN10gLmRhdGEgICAgICAgICAgICAgUFJPR0JJVFMgICAgICAg
ICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMDMyOA0KPj4+ICAgICAgICAgMDAwMDAwMDAwMDAwMDAx
MCAgMDAwMDAwMDAwMDAwMDAwMCAgV0EgICAgICAgMCAgICAgMCAgICAgOA0KPj4+ICAgIFsgOF0g
LnJvZGF0YSAgICAgICAgICAgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAw
MDMzOA0KPj4+ICAgICAgICAgMDAwMDAwMDAwMDAwMDAxOCAgMDAwMDAwMDAwMDAwMDAwMCAgIEEg
ICAgICAgMCAgICAgMCAgICAgOA0KPj4+ICAgIFsuLi5dDQo+Pj4gICAgICA5NTogMDAwMDAwMDAw
MDAwMDAwMCAgICAgOCBPQkpFQ1QgIExPQ0FMICBERUZBVUxUICAgIDYgc3RhdGljX2Jzcw0KPj4+
ICAgICAgOTY6IDAwMDAwMDAwMDAwMDAwMDggICAgIDggT0JKRUNUICBMT0NBTCAgREVGQVVMVCAg
ICA2IHN0YXRpY19ic3MyDQo+Pj4gICAgICA5NzogMDAwMDAwMDAwMDAwMDAwMCAgICAgOCBPQkpF
Q1QgIExPQ0FMICBERUZBVUxUICAgIDcgc3RhdGljX2RhdGENCj4+PiAgICAgIDk4OiAwMDAwMDAw
MDAwMDAwMDA4ICAgICA4IE9CSkVDVCAgTE9DQUwgIERFRkFVTFQgICAgNyBzdGF0aWNfZGF0YTIN
Cj4+PiAgICAgIDk5OiAwMDAwMDAwMDAwMDAwMDAwICAgICA4IE9CSkVDVCAgTE9DQUwgIERFRkFV
TFQgICAgOCBzdGF0aWNfcm9kYXRhDQo+Pj4gICAgIDEwMDogMDAwMDAwMDAwMDAwMDAwOCAgICAg
OCBPQkpFQ1QgIExPQ0FMICBERUZBVUxUICAgIDggc3RhdGljX3JvZGF0YTINCj4+PiAgICAgMTAx
OiAwMDAwMDAwMDAwMDAwMDEwICAgICA4IE9CSkVDVCAgTE9DQUwgIERFRkFVTFQgICAgOCBzdGF0
aWNfcm9kYXRhMw0KPj4+ICAgIFsuLi5dDQo+Pj4NCj4+PiAgICAjIGJwZnRvb2wgcHJvZw0KPj4+
ICAgIDEwMzogc2NoZWRfY2xzICBuYW1lIGxvYWRfc3RhdGljX2RhdCAgdGFnIDM3YThiNjgyMmZj
MzlhMjkgIGdwbA0KPj4+ICAgICAgICAgbG9hZGVkX2F0IDIwMTktMDItMjhUMDI6MDI6MzUrMDAw
MCAgdWlkIDANCj4+PiAgICAgICAgIHhsYXRlZCA3MTJCICBqaXRlZCA0MjZCICBtZW1sb2NrIDQw
OTZCICBtYXBfaWRzIDYzLDY0LDY1LDY2DQo+Pj4gICAgIyBicGZ0b29sIG1hcCBzaG93IGlkIDYz
DQo+Pj4gICAgNjM6IGFycmF5ICBuYW1lIC5ic3MgIGZsYWdzIDB4MCAgICAgICAgICAgICAgICAg
ICAgICA8LS0gLmJzcyBhcmVhLCBydw0KPj4gQ2FuIHdlIHVzZSA8bWFpbiBwcm9nPi5ic3MvZGF0
YS9yb2RhdGEgbmFtZXM/IElmIHdlIGxvYWQgbW9yZSB0aGFuIG9uZQ0KPj4gcHJvZyB3aXRoIGds
b2JhbCBkYXRhIHRoYXQgc2hvdWxkIG1ha2UgaXQgZWFzaWVyIHRvIGZpbmQgd2hpY2ggb25lIGlz
IHdoaWNoLg0KPiANCj4gWWVhaCB0aGF0J3MgZmluZSwgd2UgY2FuIGNoYW5nZSBpdC4gVGhleSBj
b3VsZCBwb3RlbnRpYWxseSBhbHNvIGJlIHNoYXJlZCwNCj4gc28gPG1haW4gcHJvZz4uYnNzL2Rh
dGEvcm9kYXRhIG1pZ2h0IGJlIG1pc2xlYWRpbmcsIGJ1dCA8b2JqPi5ic3MvZGF0YS9yb2RhdGEN
Cj4gY291bGQgYmUuDQoNCk5vdGUgdGhlIG1hcF9uYW1lIGZpZWxkIG9ubHkgMTYgYnl0ZXMgKGV4
Y2x1ZGluZyBlbmRpbmcgJ1wwJywgb25seSAxNSANCmJ5dGVzKS4gSWYgPG9iaj4gZmlsZSBoYXMg
YSBsb25nIG5hbWUgbGlrZSB0ZXN0X3ZlcmlmaWVyLm8sIHlvdSBtYXkgaGF2ZQ0KdG8gc2hvcnRl
biB0aGUgPG9iaj4gcGFydCBvZiB0aGUgbmFtZS4NCg0KPiANCj4gVGhhbmtzLA0KPiBEYW5pZWwN
Cj4gDQo=
