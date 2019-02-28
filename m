Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74438C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 06:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369C32171F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 06:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="W02cT7fe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="W3/5NwvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfB1Gy6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:54:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56900 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbfB1Gy5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 01:54:57 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S6iPrm013948;
        Wed, 27 Feb 2019 22:54:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QRr2VXjgHZifTue2RFUsDAhmRvzwaNS4cRkodmAFs1g=;
 b=W02cT7feROfm04tft2jNAeTPJE7dTtLv6h577XAhil8YXSIzl/ClcdOLcG/5u3NVbAaB
 u7EVJ8e/aYa2mErcUuHobOoHSTiUco2lJzzwLRc+/484NFhe33muNncgqJdMLBnvsSjO
 rKfRs9q0TxLng3+ytCJ4sW8RoBApBfsmS64= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx8478d97-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 22:54:35 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 22:54:34 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 22:54:34 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 27 Feb 2019 22:54:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRr2VXjgHZifTue2RFUsDAhmRvzwaNS4cRkodmAFs1g=;
 b=W3/5NwvLzYH36/DWVJkwulaykY67XPajDACVoY0u6617Bq6WLM4R/U5WLRCxqb49mxV2ezWhp12YOt7aruY1Vs0UW7wnqdeljrJOrlr3mEhPOoG8S4NuDY+9j+o3yj/HYdZEemL4KS/98ILS6dnGdjXrUNyu+9IBy8ICDR5rk8U=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2550.namprd15.prod.outlook.com (20.179.155.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 06:54:32 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 06:54:32 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Jiong Wang <jiong.wang@netronome.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Subject: Re: [PATCH LLVM 3/3] bpf: disassembler support for XADD under
 sub-register mode
Thread-Topic: [PATCH LLVM 3/3] bpf: disassembler support for XADD under
 sub-register mode
Thread-Index: AQHUzt45gNlqyrVGyUOV/Je9pg55waX0xyqA
Date:   Thu, 28 Feb 2019 06:54:32 +0000
Message-ID: <8c5b9cd1-514e-493e-3ada-756e0e0a686e@fb.com>
References: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
 <1551300641-1727-4-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1551300641-1727-4-git-send-email-jiong.wang@netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::597f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e5e9814-bc66-4ac3-6606-08d69d49979d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2550;
x-ms-traffictypediagnostic: BYAPR15MB2550:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2550;20:glwWfBcAtywtLYIlEbDVhOaa9zLtZUpdX08Z4hjAuALby1jrQ6F2jxiq++5b75h9VwPo+pzfDJy779Q+ivPm2ZucxUqGoLv7Wj/mclbAdwqT61///+WIbhnyRtX+i4A726iWnv+xEniR/Z6AW7UkZsPd/687IO4m/QnywM+NLBs=
x-microsoft-antispam-prvs: <BYAPR15MB2550F8BFB4B76334D93768C6D3750@BYAPR15MB2550.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(446003)(476003)(2906002)(2616005)(6116002)(76176011)(186003)(53936002)(4326008)(11346002)(256004)(14444005)(6486002)(81156014)(229853002)(81166006)(8676002)(68736007)(86362001)(2501003)(8936002)(6436002)(6512007)(110136005)(71200400001)(71190400001)(106356001)(97736004)(316002)(14454004)(31686004)(31696002)(54906003)(105586002)(25786009)(53546011)(305945005)(52116002)(102836004)(6506007)(386003)(99286004)(36756003)(6246003)(7736002)(5660300002)(46003)(478600001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2550;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L67tegYFGcGLNMe1+vMJjZh9L1JlfEPFdl3UEkmyR+fdflM+C2XnuRafyuWpbk6wy7J64sjDKGKJkDz+8/PpOKAt7ws0IiR9jD7YUA7BUC6fBo0HoK51WY2EvAwO2uaQ3CUtWHwQ83OfXxBve+8QeIk661Rmz6Cwe46Z0kU06Xun5cuLns2ItqwneBrVmYcOEP5QuZm3Ty/KBtcCfvFgPJJYUK5YF41VGbxLRCMAeWClFH1X6c98E5FTU48JfvAnr+LWLjzc1P41zVLYZPIya6Y99MFeCSV478xIXAVRt/L3S8HGjnPf+QzuK8tcgWTO2CygIdKDRINW+tqf2D2Kto6a3J14lTlubulqym0KebZ+Bnc6/FY/tsrFXi/cQb2IkkqW7veJ5usdBdOGp7UvcpZf2NqQ0/JI1tXmB2bQkKA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <798AB81513C35447849197C84CCFAFA6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5e9814-bc66-4ac3-6606-08d69d49979d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 06:54:32.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2550
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjcvMTkgMTI6NTAgUE0sIEppb25nIFdhbmcgd3JvdGU6DQo+IExpa2UgdGhlIG90
aGVyIGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb25zLCAidyIgcmVnaXN0ZXIgaXMgcHJlZmVyZWQgd2hl
bg0KPiBkaXNhc3NlbWJsaW5nIEJQRl9TVFggfCBCUEZfVyB8IEJQRl9YQUREIHVuZGVyIHN1Yi1y
ZWdpc3RlciBtb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmlvbmcgV2FuZyA8amlvbmcud2Fu
Z0BuZXRyb25vbWUuY29tPg0KPiAtLS0NCj4gICBsaWIvVGFyZ2V0L0JQRi9EaXNhc3NlbWJsZXIv
QlBGRGlzYXNzZW1ibGVyLmNwcCB8IDMgKystDQo+ICAgdGVzdC9NQy9CUEYvbG9hZC1zdG9yZS0z
Mi5zICAgICAgICAgICAgICAgICAgICAgfCAzICsrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL1Rhcmdl
dC9CUEYvRGlzYXNzZW1ibGVyL0JQRkRpc2Fzc2VtYmxlci5jcHAgYi9saWIvVGFyZ2V0L0JQRi9E
aXNhc3NlbWJsZXIvQlBGRGlzYXNzZW1ibGVyLmNwcA0KPiBpbmRleCBlZDA5ZTQ0Li5jNWJlN2Ni
IDEwMDY0NA0KPiAtLS0gYS9saWIvVGFyZ2V0L0JQRi9EaXNhc3NlbWJsZXIvQlBGRGlzYXNzZW1i
bGVyLmNwcA0KPiArKysgYi9saWIvVGFyZ2V0L0JQRi9EaXNhc3NlbWJsZXIvQlBGRGlzYXNzZW1i
bGVyLmNwcA0KPiBAQCAtMTcxLDkgKzE3MSwxMCBAQCBEZWNvZGVTdGF0dXMgQlBGRGlzYXNzZW1i
bGVyOjpnZXRJbnN0cnVjdGlvbihNQ0luc3QgJkluc3RyLCB1aW50NjRfdCAmU2l6ZSwNCj4gICAg
IGlmIChSZXN1bHQgPT0gTUNEaXNhc3NlbWJsZXI6OkZhaWwpIHJldHVybiBNQ0Rpc2Fzc2VtYmxl
cjo6RmFpbDsNCj4gICANCj4gICAgIHVpbnQ4X3QgSW5zdENsYXNzID0gZ2V0SW5zdENsYXNzKElu
c24pOw0KPiArICB1aW50OF90IEluc3RNb2RlID0gZ2V0SW5zdE1vZGUoSW5zbik7DQo+ICAgICBp
ZiAoKEluc3RDbGFzcyA9PSBCUEZfTERYIHx8IEluc3RDbGFzcyA9PSBCUEZfU1RYKSAmJg0KPiAg
ICAgICAgIGdldEluc3RTaXplKEluc24pICE9IEJQRl9EVyAmJg0KPiAtICAgICAgZ2V0SW5zdE1v
ZGUoSW5zbikgPT0gQlBGX01FTSAmJg0KPiArICAgICAgKEluc3RNb2RlID09IEJQRl9NRU0gfHwg
SW5zdE1vZGUgPT0gQlBGX1hBREQpICYmDQo+ICAgICAgICAgU1RJLmdldEZlYXR1cmVCaXRzKClb
QlBGOjpBTFUzMl0pDQo+ICAgICAgIFJlc3VsdCA9IGRlY29kZUluc3RydWN0aW9uKERlY29kZXJU
YWJsZUJQRkFMVTMyNjQsIEluc3RyLCBJbnNuLCBBZGRyZXNzLA0KDQpUaGlzIGNoYW5nZSB0cmln
Z2VyZWQgdGhlIHVuaXQgdGVzdCBNQy9CUEYvaW5zbi11bml0LnMgZmFpbHVyZS4NCg0KRXhpdCBD
b2RlOiAxDQoNCkNvbW1hbmQgT3V0cHV0IChzdGRlcnIpOg0KLS0NCi9kYXRhL3VzZXJzL3locy93
b3JrL2xsdm0vdGVzdC9NQy9CUEYvaW5zbi11bml0LnM6NjA6MTE6IGVycm9yOiBDSEVDSzogDQpl
eHBlY3RlZCBzdHJpbmcgbm90IGZvdW5kIGluIGlucHV0DQovLyBDSEVDSzogYzMgOTIgMTAgMDAg
MDAgMDAgMDAgMDAgbG9jayAqKHUzMiAqKShyMiArIDE2KSArPSByOQ0KICAgICAgICAgICBeDQo8
c3RkaW4+OjI1OjI6IG5vdGU6IHNjYW5uaW5nIGZyb20gaGVyZQ0KICAyMjogYzMgOTIgMTAgMDAg
MDAgMDAgMDAgMDAgbG9jayAqKHUzMiAqKShyMiArIDE2KSArPSB3OQ0KICBeDQo8c3RkaW4+OjI1
OjY6IG5vdGU6IHBvc3NpYmxlIGludGVuZGVkIG1hdGNoIGhlcmUNCiAgMjI6IGMzIDkyIDEwIDAw
IDAwIDAwIDAwIDAwIGxvY2sgKih1MzIgKikocjIgKyAxNikgKz0gdzkNCiAgICAgIF4NCnByb2Jh
Ymx5IG9iamR1bXAgLW1hdHRyPSthbHUzMiBkZWNvZGluZyBpc3N1ZS4NCg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB0aGlzLCBTVEkpOw0KPiBkaWZmIC0tZ2l0IGEvdGVzdC9N
Qy9CUEYvbG9hZC1zdG9yZS0zMi5zIGIvdGVzdC9NQy9CUEYvbG9hZC1zdG9yZS0zMi5zDQo+IGlu
ZGV4IDczZWQ5ZmMuLmJlNTc2ZDIgMTAwNjQ0DQo+IC0tLSBhL3Rlc3QvTUMvQlBGL2xvYWQtc3Rv
cmUtMzIucw0KPiArKysgYi90ZXN0L01DL0JQRi9sb2FkLXN0b3JlLTMyLnMNCj4gQEAgLTE3LDkg
KzE3LDEyIEBADQo+ICAgICAqKHU4ICopKHIwICsgMCkgPSB3NyAgICAvLyBCUEZfU1RYIHwgQlBG
X0INCj4gICAgICoodTE2ICopKHIxICsgOCkgPSB3OCAgIC8vIEJQRl9TVFggfCBCUEZfSA0KPiAg
ICAgKih1MzIgKikocjIgKyAxNikgPSB3OSAgLy8gQlBGX1NUWCB8IEJQRl9XDQo+ICsgIGxvY2sg
Kih1MzIgKikocjIgKyAxNikgKz0gdzkgIC8vIEJQRl9TVFggfCBCUEZfVyB8IEJQRl9YQUREDQo+
ICAgLy8gQ0hFQ0stMzI6IDczIDcwIDAwIDAwIDAwIDAwIDAwIDAwIAkqKHU4ICopKHIwICsgMCkg
PSB3Nw0KPiAgIC8vIENIRUNLLTMyOiA2YiA4MSAwOCAwMCAwMCAwMCAwMCAwMCAJKih1MTYgKiko
cjEgKyA4KSA9IHc4DQo+ICAgLy8gQ0hFQ0stMzI6IDYzIDkyIDEwIDAwIDAwIDAwIDAwIDAwIAkq
KHUzMiAqKShyMiArIDE2KSA9IHc5DQo+ICsvLyBDSEVDSy0zMjogYzMgOTIgMTAgMDAgMDAgMDAg
MDAgMDAgCWxvY2sgKih1MzIgKikocjIgKyAxNikgKz0gdzkNCj4gICAvLyBDSEVDSzogNzMgNzAg
MDAgMDAgMDAgMDAgMDAgMDAgCSoodTggKikocjAgKyAwKSA9IHI3DQo+ICAgLy8gQ0hFQ0s6IDZi
IDgxIDA4IDAwIDAwIDAwIDAwIDAwIAkqKHUxNiAqKShyMSArIDgpID0gcjgNCj4gICAvLyBDSEVD
SzogNjMgOTIgMTAgMDAgMDAgMDAgMDAgMDAgCSoodTMyICopKHIyICsgMTYpID0gcjkNCj4gKy8v
IENIRUNLOiBjMyA5MiAxMCAwMCAwMCAwMCAwMCAwMCAJbG9jayAqKHUzMiAqKShyMiArIDE2KSAr
PSByOQ0KPiANCg==
