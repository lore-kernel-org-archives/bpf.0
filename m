Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425AEC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 06:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC897214D8
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 06:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FwFPQSdB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PdcYKrcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfB1GwU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:52:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbfB1GwU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 01:52:20 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S6iUTG013961;
        Wed, 27 Feb 2019 22:51:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sI5Q3X3p3l44FD+Uq/On0hMwwnXtasTJTIhido90MtM=;
 b=FwFPQSdBElflu5LH9Orm7Xn1UFitaCnce64WoomNoG8Sls8fK3zD4E3M3mcy4Ih+zK33
 19jtdzmne6HkI8BJNsWU0NgtKjKhilYoLIsaDp5yFmAG6OXjL0nB5TlQcWcZaQ+oAeNc
 O8HUU272S6aRTwrPmz7k2L7SMpH4Err7y2E= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx8478d2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 22:51:42 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 22:51:41 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 27 Feb 2019 22:51:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI5Q3X3p3l44FD+Uq/On0hMwwnXtasTJTIhido90MtM=;
 b=PdcYKrcCdIWk4PixWTJqk8PbLMBwV9ossdCP4n9KqcT1xj4TKr0vsUhMay5AX76p4GG4D81n2k+3Zr49Dt31lYXXdQgv0YAcKyzWf694kl2TdHfKDSg1kv/uMXfNZeM6dYP5EDvLi1dyhF480C3MDAbHThIMnaaDkpH+ubY4doE=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2839.namprd15.prod.outlook.com (20.178.206.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 06:51:20 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 06:51:20 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Jiong Wang <jiong.wang@netronome.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Subject: Re: [PATCH LLVM 2/3] bpf: enable sub-register code-gen for XADD
Thread-Topic: [PATCH LLVM 2/3] bpf: enable sub-register code-gen for XADD
Thread-Index: AQHUzt44oCVj2IRMykalrE7VAob5U6X0xkQA
Date:   Thu, 28 Feb 2019 06:51:20 +0000
Message-ID: <8f8ef640-4af0-80d1-fd66-ee3f92016972@fb.com>
References: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
 <1551300641-1727-3-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1551300641-1727-3-git-send-email-jiong.wang@netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::597f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d97f2b4-ac89-4c8e-2ec6-08d69d492521
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2839;
x-ms-traffictypediagnostic: BYAPR15MB2839:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2839;20:Zt/LFs1bAsup9BM4NwhVT3v2WXafi7dGtCH7ZLaUI08EmseuFvdjm0fb1MajUH2mrEXxnZ0y03oeKKh8MnW9fmSVxr6+O1kmlg+QkE1W/QJFfFhPc6MQTvr5M3y6mwZNzt54VxPdA4du01F+S0KIyx2WJ0fVJAvFcB5l61JPKLo=
x-microsoft-antispam-prvs: <BYAPR15MB28392782273119783C625546D3750@BYAPR15MB2839.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(11346002)(31686004)(105586002)(25786009)(486006)(8936002)(4326008)(36756003)(6436002)(6486002)(76176011)(476003)(46003)(229853002)(186003)(2616005)(52116002)(99286004)(478600001)(6246003)(68736007)(14454004)(110136005)(86362001)(8676002)(6506007)(102836004)(2906002)(446003)(71190400001)(31696002)(6116002)(386003)(53936002)(53546011)(81156014)(54906003)(97736004)(71200400001)(256004)(81166006)(2501003)(316002)(305945005)(6512007)(7736002)(5660300002)(14444005)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2839;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WkgcU9qKCp/aftJfDYfEW0okGZFGOc2+3aIMGthyFiL9QsUAxifJmYMtOF7c57NZeb9JeAp+R+r6igVPFn6EigZdQMndHRu45ywt1tGczWlKpWJoJR2BGT+yEo8ZmpJQou5miWLVSL6NzfxqnYWenHCLirTHoZTUTHF9hLgkAvgZfHSkMofyFHTo0ePAscMSky2ni1qBLMZL0rZUSk5T4AHV2Uu3J47IfDULMfQE2I9fpnSHaCd72aXyLZkn/JnljyhtTl3JMkp5070zc6sWpEdr9lhVYQf2FPtftaYwGSw6LPklj9y50d6ARIQaDGRlFA0f0gvpY5JFYeREPE91uKJ6pbepFQ7iuYIMW8yEwlOpFSWt8lHOSZxuwWe2o1fZPWSOzrF9hN4Qfe7k6Kzv1dkNbQQRckIAmudeG7XLKDI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B545901F26F8147908535CDBD4E17A9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d97f2b4-ac89-4c8e-2ec6-08d69d492521
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 06:51:20.3370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2839
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjcvMTkgMTI6NTAgUE0sIEppb25nIFdhbmcgd3JvdGU6DQo+IFN1cHBvcnQgc3Vi
LXJlZ2lzdGVyIGNvZGUtZ2VuIGZvciBYQUREIGlzIGxpa2Ugc3VwcG9ydGluZyBhbnkgb3RoZXIg
TG9hZA0KPiBhbmQgU3RvcmUgcGF0dGVybnMuDQo+IA0KPiBObyBuZXcgaW5zdHJ1Y3Rpb24gaXMg
aW50cm9kdWNlZC4NCj4gDQo+ICAgIGxvY2sgKih1MzIgKikocjEgKyAwKSArPSB3Mg0KPiANCj4g
aGFzIGV4YWN0bHkgdGhlIHNhbWUgdW5kZXJseWluZyBpbnNuIGFzOg0KPiANCj4gICAgbG9jayAq
KHUzMiAqKShyMSArIDApICs9IHIyDQo+IA0KPiBCUEZfVyB3aWR0aCBtb2RpZmllciBoYXMgZ3Vh
cmFudGVlZCB0aGV5IGJlaGF2ZSB0aGUgc2FtZSBhdCBydW50aW1lLiBUaGlzDQo+IHBhdGNoIG1l
cmVseSB0ZWFjaGVzIEJQRiBiYWNrLWVuZCB0aGF0IEJQRl9XIHdpZHRoIG1vZGlmaWVyIGNvdWxk
IHdvcmsNCj4gR1BSMzIgcmVnaXN0ZXIgY2xhc3MgYW5kIHRoYXQncyBhbGwgbmVlZGVkIGZvciBz
dWItcmVnaXN0ZXIgY29kZS1nZW4NCj4gc3VwcG9ydCBmb3IgWEFERC4NCj4gDQo+IHRlc3QvQ29k
ZUdlbi9CUEYveGFkZC5sbCB1cGRhdGVkIHRvIGluY2x1ZGUgc3ViLXJlZ2lzdGVyIGNvZGUtZ2Vu
IHRlc3RzLg0KPiANCj4gQSBuZXcgdGVzdGNhc2UgdGVzdC9Db2RlR2VuL0JQRi94YWRkX2xlZ2Fs
LmxsIGlzIGFkZGVkIHRvIG1ha2Ugc3VyZSB0aGUNCj4gbGVnYWwgY2FzZSBjb3VsZCBwYXNzIG9u
IGFsbCBjb2RlLWdlbiBtb2Rlcy4gSXQgY291bGQgYWxzbyB0ZXN0IGRlYWQgRGVmDQo+IGNoZWNr
IG9uIEdQUjMyLiBJZiB0aGVyZSBpcyBubyBwcm9wZXIgaGFuZGxpbmcgbGlrZSB3aGF0IGhhcyBi
ZWVuIGRvbmUNCj4gaW5zaWRlIEJQRk1JQ2hlY2tpbmcuY3BwOmhhc0xpdmluZ0RlZnMsIHRoZW4g
dGhpcyB0ZXN0Y2FzZSB3aWxsIGZhaWwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaW9uZyBXYW5n
IDxqaW9uZy53YW5nQG5ldHJvbm9tZS5jb20+DQo+IC0tLQ0KPiAgIGxpYi9UYXJnZXQvQlBGL0JQ
Rkluc3RySW5mby50ZCAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgIGxp
Yi9UYXJnZXQvQlBGL0JQRk1JQ2hlY2tpbmcuY3BwIHwgIDQgKysrLQ0KPiAgIHRlc3QvQ29kZUdl
bi9CUEYveGFkZC5sbCAgICAgICAgIHwgIDIgKysNCj4gICB0ZXN0L0NvZGVHZW4vQlBGL3hhZGRf
bGVnYWwubGwgICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgNCBmaWxlcyBj
aGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0ZXN0L0NvZGVHZW4vQlBGL3hhZGRfbGVnYWwubGwNCj4gDQo+IGRpZmYgLS1naXQg
YS9saWIvVGFyZ2V0L0JQRi9CUEZJbnN0ckluZm8udGQgYi9saWIvVGFyZ2V0L0JQRi9CUEZJbnN0
ckluZm8udGQNCj4gaW5kZXggMzY3MjRiOC4uYzQ0NzAyYSAxMDA2NDQNCj4gLS0tIGEvbGliL1Rh
cmdldC9CUEYvQlBGSW5zdHJJbmZvLnRkDQo+ICsrKyBiL2xpYi9UYXJnZXQvQlBGL0JQRkluc3Ry
SW5mby50ZA0KPiBAQCAtNjE0LDExICs2MTQsMzEgQEAgY2xhc3MgWEFERDxCUEZXaWR0aE1vZGlm
ZXIgU2l6ZU9wLCBzdHJpbmcgT3Bjb2RlU3RyLCBQYXRGcmFnIE9wTm9kZT4NCj4gICAgIGxldCBC
UEZDbGFzcyA9IEJQRl9TVFg7DQo+ICAgfQ0KPiAgIA0KPiArY2xhc3MgWEFERDMyPEJQRldpZHRo
TW9kaWZlciBTaXplT3AsIHN0cmluZyBPcGNvZGVTdHIsIFBhdEZyYWcgT3BOb2RlPg0KPiArICAg
IDogVFlQRV9MRF9TVDxCUEZfWEFERC5WYWx1ZSwgU2l6ZU9wLlZhbHVlLA0KPiArICAgICAgICAg
ICAgICAgICAob3V0cyBHUFIzMjokZHN0KSwNCj4gKyAgICAgICAgICAgICAgICAgKGlucyBNRU1y
aTokYWRkciwgR1BSMzI6JHZhbCksDQo+ICsgICAgICAgICAgICAgICAgICJsb2NrICooIiNPcGNv
ZGVTdHIjIiAqKSgkYWRkcikgKz0gJHZhbCIsDQo+ICsgICAgICAgICAgICAgICAgIFsoc2V0IEdQ
UjMyOiRkc3QsIChPcE5vZGUgQUREUnJpOiRhZGRyLCBHUFIzMjokdmFsKSldPiB7DQo+ICsgIGJp
dHM8ND4gZHN0Ow0KPiArICBiaXRzPDIwPiBhZGRyOw0KPiArDQo+ICsgIGxldCBJbnN0ezUxLTQ4
fSA9IGFkZHJ7MTktMTZ9OyAvLyBiYXNlIHJlZw0KPiArICBsZXQgSW5zdHs1NS01Mn0gPSBkc3Q7
DQo+ICsgIGxldCBJbnN0ezQ3LTMyfSA9IGFkZHJ7MTUtMH07IC8vIG9mZnNldA0KPiArICBsZXQg
QlBGQ2xhc3MgPSBCUEZfU1RYOw0KPiArfQ0KPiArDQo+ICAgbGV0IENvbnN0cmFpbnRzID0gIiRk
c3QgPSAkdmFsIiBpbiB7DQo+IC1kZWYgWEFERDMyIDogWEFERDxCUEZfVywgInUzMiIsIGF0b21p
Y19sb2FkX2FkZF8zMj47DQo+IC1kZWYgWEFERDY0IDogWEFERDxCUEZfRFcsICJ1NjQiLCBhdG9t
aWNfbG9hZF9hZGRfNjQ+Ow0KPiAtLy8gdW5kZWZpbmVkIGRlZiBYQUREMTYgOiBYQUREPDEsICJ4
YWRkMTYiLCBhdG9taWNfbG9hZF9hZGRfMTY+Ow0KPiAtLy8gdW5kZWZpbmVkIGRlZiBYQUREOCAg
OiBYQUREPDIsICJ4YWRkOCIsIGF0b21pY19sb2FkX2FkZF84PjsNCj4gKyAgbGV0IFByZWRpY2F0
ZXMgPSBbQlBGTm9BTFUzMl0gaW4gew0KPiArICAgIGRlZiBYQUREVyA6IFhBREQ8QlBGX1csICJ1
MzIiLCBhdG9taWNfbG9hZF9hZGRfMzI+Ow0KPiArICB9DQo+ICsNCj4gKyAgbGV0IFByZWRpY2F0
ZXMgPSBbQlBGSGFzQUxVMzJdLCBEZWNvZGVyTmFtZXNwYWNlID0gIkJQRkFMVTMyIiBpbiB7DQo+
ICsgICAgZGVmIFhBRERXMzIgOiBYQUREMzI8QlBGX1csICJ1MzIiLCBhdG9taWNfbG9hZF9hZGRf
MzI+Ow0KPiArICB9DQo+ICsNCj4gKyAgZGVmIFhBREREIDogWEFERDxCUEZfRFcsICJ1NjQiLCBh
dG9taWNfbG9hZF9hZGRfNjQ+Ow0KDQpUaGUgWEFERDY0IGlzIGNoYW5nZWQgdG8gWEFEREQuIEkg
Z3Vlc3MgSSBhbSBva2F5IHdpdGggdGhhdCBzaW5jZQ0KaXQgaXMgY29uc2lzdGVudCB3aXRoIExE
RC9TVEQuDQoNCj4gICB9DQo+ICAgDQo+ICAgLy8gYnN3YXAxNiwgYnN3YXAzMiwgYnN3YXA2NA0K
PiBkaWZmIC0tZ2l0IGEvbGliL1RhcmdldC9CUEYvQlBGTUlDaGVja2luZy5jcHAgYi9saWIvVGFy
Z2V0L0JQRi9CUEZNSUNoZWNraW5nLmNwcA0KPiBpbmRleCA3YTRiYTk2Li45MzhlNTM5IDEwMDY0
NA0KPiAtLS0gYS9saWIvVGFyZ2V0L0JQRi9CUEZNSUNoZWNraW5nLmNwcA0KPiArKysgYi9saWIv
VGFyZ2V0L0JQRi9CUEZNSUNoZWNraW5nLmNwcA0KPiBAQCAtMTY1LDcgKzE2NSw5IEBAIHN0YXRp
YyBib29sIGhhc0xpdmluZ0RlZnMoY29uc3QgTWFjaGluZUluc3RyICZNSSwNCj4gICB2b2lkIEJQ
Rk1JUHJlRW1pdENoZWNraW5nOjpjaGVja2luZ0lsbGVnYWxYQUREKHZvaWQpIHsNCj4gICAgIGZv
ciAoTWFjaGluZUJhc2ljQmxvY2sgJk1CQiA6ICpNRikgew0KPiAgICAgICBmb3IgKE1hY2hpbmVJ
bnN0ciAmTUkgOiBNQkIpIHsNCj4gLSAgICAgIGlmIChNSS5nZXRPcGNvZGUoKSAhPSBCUEY6OlhB
REQzMiAmJiBNSS5nZXRPcGNvZGUoKSAhPSBCUEY6OlhBREQ2NCkNCj4gKyAgICAgIGlmIChNSS5n
ZXRPcGNvZGUoKSAhPSBCUEY6OlhBRERXICYmDQo+ICsgICAgICAgICAgTUkuZ2V0T3Bjb2RlKCkg
IT0gQlBGOjpYQURERCAmJg0KPiArICAgICAgICAgIE1JLmdldE9wY29kZSgpICE9IEJQRjo6WEFE
RFczMikNCj4gICAgICAgICAgIGNvbnRpbnVlOw0KPiAgIA0KPiAgICAgICAgIExMVk1fREVCVUco
TUkuZHVtcCgpKTsNCj4gZGlmZiAtLWdpdCBhL3Rlc3QvQ29kZUdlbi9CUEYveGFkZC5sbCBiL3Rl
c3QvQ29kZUdlbi9CUEYveGFkZC5sbA0KPiBpbmRleCBjNWYyNjIwLi40OWYwYzEwIDEwMDY0NA0K
PiAtLS0gYS90ZXN0L0NvZGVHZW4vQlBGL3hhZGQubGwNCj4gKysrIGIvdGVzdC9Db2RlR2VuL0JQ
Ri94YWRkLmxsDQo+IEBAIC0xLDUgKzEsNyBAQA0KPiAgIDsgUlVOOiBub3QgbGxjIC1tYXJjaD1i
cGZlbCA8ICVzIDI+JjEgfCBGaWxlQ2hlY2sgJXMNCj4gICA7IFJVTjogbm90IGxsYyAtbWFyY2g9
YnBmZWIgPCAlcyAyPiYxIHwgRmlsZUNoZWNrICVzDQo+ICs7IFJVTjogbm90IGxsYyAtbWFyY2g9
YnBmZWwgLW1hdHRyPSthbHUzMiA8ICVzIDI+JjEgfCBGaWxlQ2hlY2sgJXMNCj4gKzsgUlVOOiBu
b3QgbGxjIC1tYXJjaD1icGZlYiAtbWF0dHI9K2FsdTMyIDwgJXMgMj4mMSB8IEZpbGVDaGVjayAl
cw0KPiAgIA0KPiAgIDsgVGhpcyBmaWxlIGlzIGdlbmVyYXRlZCB3aXRoIHRoZSBzb3VyY2UgY29t
bWFuZCBhbmQgc291cmNlDQo+ICAgOyAkIGNsYW5nIC10YXJnZXQgYnBmIC1PMiAtZyAtUyAtZW1p
dC1sbHZtIHQuYw0KPiBkaWZmIC0tZ2l0IGEvdGVzdC9Db2RlR2VuL0JQRi94YWRkX2xlZ2FsLmxs
IGIvdGVzdC9Db2RlR2VuL0JQRi94YWRkX2xlZ2FsLmxsDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAuLjBkMzAwODQNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0
L0NvZGVHZW4vQlBGL3hhZGRfbGVnYWwubGwNCj4gQEAgLTAsMCArMSwyNiBAQA0KPiArOyBSVU46
IGxsYyAtbWFyY2g9YnBmZWwgPCAlcyAyPiYxIHwgRmlsZUNoZWNrIC0tY2hlY2stcHJlZml4PUNI
RUNLLTY0ICVzDQo+ICs7IFJVTjogbGxjIC1tYXJjaD1icGZlYiA8ICVzIDI+JjEgfCBGaWxlQ2hl
Y2sgLS1jaGVjay1wcmVmaXg9Q0hFQ0stNjQgJXMNCj4gKzsgUlVOOiBsbGMgLW1hcmNoPWJwZmVs
IC1tYXR0cj0rYWx1MzIgPCAlcyAyPiYxIHwgRmlsZUNoZWNrIC0tY2hlY2stcHJlZml4PUNIRUNL
LTMyICVzDQo+ICs7IFJVTjogbGxjIC1tYXJjaD1icGZlYiAtbWF0dHI9K2FsdTMyIDwgJXMgMj4m
MSB8IEZpbGVDaGVjayAtLWNoZWNrLXByZWZpeD1DSEVDSy0zMiAlcw0KPiArDQo+ICs7IFRoaXMg
ZmlsZSBpcyBnZW5lcmF0ZWQgd2l0aCB0aGUgc291cmNlIGNvbW1hbmQgYW5kIHNvdXJjZQ0KPiAr
OyAkIGNsYW5nIC10YXJnZXQgYnBmIC1PMiAtUyAtZW1pdC1sbHZtIHQuYw0KPiArOyAkIGNhdCB0
LmMNCj4gKzsgaW50IHRlc3QoaW50ICpwdHIsIHVuc2lnbmVkIGxvbmcgbG9uZyBhKSB7DQo+ICs7
ICAgIF9fc3luY19mZXRjaF9hbmRfYWRkKHB0ciwgYSk7DQo+ICs7ICAgIHJldHVybiAqcHRyOw0K
PiArOyB9DQo+ICs7DQo+ICs7IE5PVEU6IHBhc3NpbmcgdW5zaWduZWQgbG9uZyBsb25nIGFzIHRo
ZSBzZWNvbmQgb3BlcmFuZCBvZiBfX3N5bmNfZmV0Y2hfYW5kX2FkZA0KPiArOyBjb3VsZCBlZmZl
Y3RpdmVseSBjcmVhdGUgc3ViLXJlZ2lzdGVyIHJlZmVyZW5jZSBjb21pbmcgZnJvbSBpbmRleGlu
ZyBhIGZ1bGwNCj4gKzsgcmVnaXN0ZXIgd2hpY2ggY291bGQgdGhlbiBleGVyY2Vpc2UgaGFzTGl2
aW5nRGVmcyBpbnNpZGUgQlBGTUlDaGVja2VyLmNwcC4NCj4gKw0KPiArZGVmaW5lIGRzb19sb2Nh
bCBpMzIgQHRlc3QoaTMyKiBub2NhcHR1cmUgJXB0ciwgaTY0ICVhKSB7DQo+ICtlbnRyeToNCj4g
KyAgJWNvbnYgPSB0cnVuYyBpNjQgJWEgdG8gaTMyDQo+ICsgICUwID0gYXRvbWljcm13IGFkZCBp
MzIqICVwdHIsIGkzMiAlY29udiBzZXFfY3N0DQo+ICs7IENIRUNLLTY0OiBsb2NrICoodTMyICop
KHIxICsgMCkgKz0gcjINCj4gKzsgQ0hFQ0stMzI6IGxvY2sgKih1MzIgKikocjEgKyAwKSArPSB3
Mg0KPiArICAlMSA9IGxvYWQgaTMyLCBpMzIqICVwdHIsIGFsaWduIDQNCj4gKyAgcmV0IGkzMiAl
MQ0KPiArfQ0KPiANCg==
