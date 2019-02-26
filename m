Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725DCC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 01:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2476321848
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 01:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lnkKTM+u";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OAQ4D+Hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfBZBBB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 20:01:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfBZBBB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 20:01:01 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q0xYAq002605;
        Mon, 25 Feb 2019 17:00:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=L9VHWE4HkubLkMwdADViK+hYav+RazDUJYuRsls6RHU=;
 b=lnkKTM+u6Ziv7rqpSOGDqAtVdjlmZnQA0pYNxE61dBn3pG8WIQk8/ZU3GN2Q4TFd6+om
 75hKYVdexyDHLLGzxpjSkWJoDZuBw1ARAS77wEHS37ghFI1lBP4reLSaub9x6TqJmZA0
 DA2WAjV5URJ7UQJQDCjFeKGEIYhFXyrz5iM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvsk98b0h-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 17:00:58 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 17:00:56 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 17:00:55 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 25 Feb 2019 17:00:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9VHWE4HkubLkMwdADViK+hYav+RazDUJYuRsls6RHU=;
 b=OAQ4D+HdFyDxKg5zTyj/TcKAmFBb4QwRDnnEnC0alisJvoQqkepKRVJUTg+W4AqN6eNYFV2PjzD2lv7tls6sTQZTTPMTptXNjMd12BolEqvSUUzm/ckm9k/7NqjIJ7sWfA9hfpWB9mtrEdXjk4gzwQIs7vv5jaZKnTf8B6MiRJQ=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2808.namprd15.prod.outlook.com (20.179.158.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 01:00:54 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 01:00:54 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH pahole 2/2] btf_encoder: don't special case packed enums
Thread-Topic: [PATCH pahole 2/2] btf_encoder: don't special case packed enums
Thread-Index: AQHUzWdl+iRkEL62QUOxyR2TG1H1EaXxQqMA
Date:   Tue, 26 Feb 2019 01:00:53 +0000
Message-ID: <5096f3f4-7d1d-4f11-9ac7-bd23fcbf1e75@fb.com>
References: <20190226000815.385229-1-andriin@fb.com>
 <20190226000815.385229-3-andriin@fb.com>
In-Reply-To: <20190226000815.385229-3-andriin@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:40::42) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:bbec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0a47529-ae80-497d-b263-08d69b85dba6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2808;
x-ms-traffictypediagnostic: BYAPR15MB2808:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2808;20:1da6A+A7MgtdE6fiUiRUaoC85zEc6Ba8AdMqQnA5t7Go6B04kCfYTwzysuS3PowGL1XEMrIZo5sy4OSblIffIsAM0Jd9MwP4uTENSu3QUkI97DiGZ2bwyh5GpiMNaVMOMGaqRQeks2SRWskcqyDyQuzyzF6JXMl5aJCymogtbFo=
x-microsoft-antispam-prvs: <BYAPR15MB2808CE2C3E531D90B86C78A8D37B0@BYAPR15MB2808.namprd15.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(51914003)(199004)(189003)(2201001)(386003)(6512007)(53546011)(6506007)(25786009)(68736007)(36756003)(81156014)(6436002)(31696002)(81166006)(102836004)(6486002)(31686004)(86362001)(2501003)(8676002)(8936002)(71200400001)(110136005)(14454004)(71190400001)(256004)(2906002)(14444005)(478600001)(97736004)(316002)(11346002)(446003)(486006)(46003)(476003)(2616005)(6246003)(105586002)(6116002)(229853002)(106356001)(5660300002)(7736002)(76176011)(53936002)(52116002)(305945005)(186003)(99286004)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2808;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0uWNxb/MCQ1b5s0fTm12E/4cWJ57yN2xbXfnNZBMVBn+hqx2bNI+XxFdCOyHjPsh/7ohBk6Y6TExG5tDAQrp3dQyHuBPuC6UyvPiMyI7xiqgKZvzWP6O6FzTaZ3/TJJvVxPdcN2u0d+juEquUspSwdcJKvLq/BImwub2DSkPUGvDmT0WxONo49csXVHke33XCGHhXCakepnjjfXbXRJSVb/ZfchFI1B1lR6RaIAWlABTxykjsxMeMGZBB/1iX1CyZJ21nxyzHlh39XYfNrtnWFKjOqLHvbUzovu5OwHchbsHoyqrVMLmNL2Fj05RzwmAKy8Iek//QgzGUMORf36MbMFF+3+zmacIXMSi+Ebmb0JzRtda5ULQ38OjVHibPfRJVAsLLhDoUM+glR6oxLQIm7dhjwWHnbIM+Vy7V4OYZ6o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B06071F6C77BE74899A0764C34BDF42B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a47529-ae80-497d-b263-08d69b85dba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 01:00:52.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2808
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDIvMjUvMTkgNDowOCBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBCVEYgZGF0
YSBjYW4gcmVwcmVzZW50IHBhY2tlZCBlbnVtcyBjb3JyZWN0bHkgd2l0aG91dCBhbnkgc3BlY2lh
bA0KPiBoYW5kbGluZyBmcm9tIHBhaG9sZSBzaWRlLiBQcmV2aW91c2x5IHBhaG9sZSdzIG93biBg
ZW51bSB2c2NvcGVgIHdvdWxkDQo+IGJlIG9taXR0ZWQgY2F1c2luZyBwcm9ibGVtcy4NCj4gDQo+
IFJlcHJvOg0KPiANCj4gJCBjYXQgdGVzdC9wYWNrZWRfZW51bS5jDQo+IGVudW0gcGFja2VkX2Vu
dW0gew0KPiAgICAgICAgICBWQUxVRTEsDQo+ICAgICAgICAgIFZBTFVFMiwNCj4gICAgICAgICAg
VkFMVUUzDQo+IH0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7DQo+IA0KPiBzdHJ1Y3QgcyB7DQo+
ICAgICAgICAgIGludCB4Ow0KPiAgICAgICAgICBlbnVtIHBhY2tlZF9lbnVtIGU7DQo+ICAgICAg
ICAgIGludCB5Ow0KPiB9Ow0KPiANCj4gaW50IG1haW4oKQ0KPiB7DQo+ICAgICAgICAgIHN0cnVj
dCBzIHM7DQo+ICAgICAgICAgIHJldHVybiAwOw0KPiB9DQo+IA0KPiAkIGdjYyAtZyAtYyB0ZXN0
L3BhY2tlZF9lbnVtLmMgLW8gdGVzdC9wYWNrZWRfZW51bS5vDQo+IA0KPiAkIH4vbG9jYWwvcGFo
b2xlL2J1aWxkL3BhaG9sZSAtSlYgdGVzdC9wYWNrZWRfZW51bS5vDQo+IEZpbGUgdGVzdC9wYWNr
ZWRfZW51bS5vOg0KPiBbMV0gSU5UIChhbm9uKSBzaXplPTEgYml0X29mZnNldD0wIG5yX2JpdHM9
OCBlbmNvZGluZz1TSUdORUQNCj4gWzJdIFNUUlVDVCBzIGtpbmRfZmxhZz0wIHNpemU9MTIgdmxl
bj0zDQo+ICAgICAgICAgIHggdHlwZV9pZD0zIGJpdHNfb2Zmc2V0PTANCj4gICAgICAgICAgZSB0
eXBlX2lkPTEgYml0c19vZmZzZXQ9MzINCj4gICAgICAgICAgeSB0eXBlX2lkPTMgYml0c19vZmZz
ZXQ9NjQNCj4gWzNdIElOVCBpbnQgc2l6ZT00IGJpdF9vZmZzZXQ9MCBucl9iaXRzPTMyIGVuY29k
aW5nPVNJR05FRA0KPiANCj4gJCB+L2xvY2FsL3BhaG9sZS9idWlsZC9wYWhvbGUgLUYgZHdhcmYg
dGVzdC9wYWNrZWRfZW51bS5vDQo+IHN0cnVjdCBzIHsNCj4gICAgICAgICAgaW50ICAgICAgICAg
ICAgICAgICAgICAgICAgeDsgICAgICAgICAgICAgICAgICAgIC8qICAgICAwICAgICA0ICovDQo+
ICAgICAgICAgIGVudW0gcGFja2VkX2VudW0gICAgICAgICAgIGU7ICAgICAgICAgICAgICAgICAg
ICAvKiAgICAgNCAgICAgMSAqLw0KPiANCj4gICAgICAgICAgLyogWFhYIDMgYnl0ZXMgaG9sZSwg
dHJ5IHRvIHBhY2sgKi8NCj4gDQo+ICAgICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgICAg
IHk7ICAgICAgICAgICAgICAgICAgICAvKiAgICAgOCAgICAgNCAqLw0KPiANCj4gICAgICAgICAg
Lyogc2l6ZTogMTIsIGNhY2hlbGluZXM6IDEsIG1lbWJlcnM6IDMgKi8NCj4gICAgICAgICAgLyog
c3VtIG1lbWJlcnM6IDksIGhvbGVzOiAxLCBzdW0gaG9sZXM6IDMgKi8NCj4gICAgICAgICAgLyog
bGFzdCBjYWNoZWxpbmU6IDEyIGJ5dGVzICovDQo+IH07DQo+IA0KPiAkIH4vbG9jYWwvcGFob2xl
L2J1aWxkL3BhaG9sZSAtRiBidGYgdGVzdC9wYWNrZWRfZW51bS5vDQo+IHN0cnVjdCBzIHsNCj4g
ICAgICAgICAgaW50ICAgICAgICAgICAgICAgICAgICAgICAgeDsgICAgICAgICAgICAgICAgICAg
IC8qICAgICAwICAgICA0ICovDQo+ICAgICAgICAgIG5hbWVsZXNzIGJhc2UgdHlwZSEgICAgICAg
IGU7ICAgICAgICAgICAgICAgICAgICAvKiAgICAgNCAgICAgMSAqLw0KPiANCj4gICAgICAgICAg
LyogWFhYIDMgYnl0ZXMgaG9sZSwgdHJ5IHRvIHBhY2sgKi8NCj4gDQo+ICAgICAgICAgIGludCAg
ICAgICAgICAgICAgICAgICAgICAgIHk7ICAgICAgICAgICAgICAgICAgICAvKiAgICAgOCAgICAg
NCAqLw0KPiANCj4gICAgICAgICAgLyogc2l6ZTogMTIsIGNhY2hlbGluZXM6IDEsIG1lbWJlcnM6
IDMgKi8NCj4gICAgICAgICAgLyogc3VtIG1lbWJlcnM6IDksIGhvbGVzOiAxLCBzdW0gaG9sZXM6
IDMgKi8NCj4gICAgICAgICAgLyogbGFzdCBjYWNoZWxpbmU6IDEyIGJ5dGVzICovDQo+IH07DQo+
IA0KPiBOb3RpY2UgaG93IHBhaG9sZSdzIGxvZyBkb2Vzbid0IGhhdmUgYSBtZW50aW9uIG9mIGVu
Y29kaW5nICdwYWNrZWRfZW51bScNCj4gKGFub255bW91cyBpbnRlZ2VyIGlzIGdlbmVyYXRlZCBp
bnN0ZWFkKSwgd2hpY2ggY2F1c2VzICduYW1lbGVzcyBiYXNlDQo+IHR5cGUhJyBvdXRwdXQgYWJv
dmUuDQo+IA0KPiBGaXggdGhpcyBjaGFuZ2U6DQo+IA0KPiAkIH4vbG9jYWwvcGFob2xlL2J1aWxk
L3BhaG9sZSAtSlYgdGVzdC9wYWNrZWRfZW51bS5vDQo+IEZpbGUgdGVzdC9wYWNrZWRfZW51bS5v
Og0KPiBbMV0gRU5VTSBwYWNrZWRfZW51bSBzaXplPTEgdmxlbj0zDQo+ICAgICAgICAgIFZBTFVF
MSB2YWw9MA0KPiAgICAgICAgICBWQUxVRTIgdmFsPTENCj4gICAgICAgICAgVkFMVUUzIHZhbD0y
DQo+IFsyXSBTVFJVQ1QgcyBraW5kX2ZsYWc9MCBzaXplPTEyIHZsZW49Mw0KPiAgICAgICAgICB4
IHR5cGVfaWQ9MyBiaXRzX29mZnNldD0wDQo+ICAgICAgICAgIGUgdHlwZV9pZD0xIGJpdHNfb2Zm
c2V0PTMyDQo+ICAgICAgICAgIHkgdHlwZV9pZD0zIGJpdHNfb2Zmc2V0PTY0DQo+IFszXSBJTlQg
aW50IHNpemU9NCBiaXRfb2Zmc2V0PTAgbnJfYml0cz0zMiBlbmNvZGluZz1TSUdORUQNCj4gDQo+
ICQgfi9sb2NhbC9wYWhvbGUvYnVpbGQvcGFob2xlIC1GIGJ0ZiB0ZXN0L3BhY2tlZF9lbnVtLm8N
Cj4gc3RydWN0IHMgew0KPiAgICAgICAgICBpbnQgICAgICAgICAgICAgICAgICAgICAgICB4OyAg
ICAgICAgICAgICAgICAgICAgLyogICAgIDAgICAgIDQgKi8NCj4gICAgICAgICAgZW51bSBwYWNr
ZWRfZW51bSAgICAgICAgICAgZTsgICAgICAgICAgICAgICAgICAgIC8qICAgICA0ICAgICAxICov
DQo+IA0KPiAgICAgICAgICAvKiBYWFggMyBieXRlcyBob2xlLCB0cnkgdG8gcGFjayAqLw0KPiAN
Cj4gICAgICAgICAgaW50ICAgICAgICAgICAgICAgICAgICAgICAgeTsgICAgICAgICAgICAgICAg
ICAgIC8qICAgICA4ICAgICA0ICovDQo+IA0KPiAgICAgICAgICAvKiBzaXplOiAxMiwgY2FjaGVs
aW5lczogMSwgbWVtYmVyczogMyAqLw0KPiAgICAgICAgICAvKiBzdW0gbWVtYmVyczogOSwgaG9s
ZXM6IDEsIHN1bSBob2xlczogMyAqLw0KPiAgICAgICAgICAvKiBsYXN0IGNhY2hlbGluZTogMTIg
Ynl0ZXMgKi8NCj4gfTsNCj4gDQo+ICQgUEFIT0xFPX4vbG9jYWwvcGFob2xlL2J1aWxkL3BhaG9s
ZSAuL2J0ZmRpZmYgdGVzdC9wYWNrZWRfZW51bS5vDQo+IA0KPiBBbHNvIHZlcmlmaWVkIG9uIHBh
aG9sZSwga2VybmVsIGFuZCBnbGliYzoNCj4gDQo+ICQgUEFIT0xFPX4vbG9jYWwvcGFob2xlL2J1
aWxkL3BhaG9sZSAuL2J0ZmRpZmYgfi9sb2NhbC9idGYvcGFob2xlLmRlYnVnDQo+ICQgUEFIT0xF
PX4vbG9jYWwvcGFob2xlL2J1aWxkL3BhaG9sZSAuL2J0ZmRpZmYgfi9sb2NhbC9idGYvbGliYy0y
LjI4LnNvLmRlYnVnDQo+ICQgUEFIT0xFPX4vbG9jYWwvcGFob2xlL2J1aWxkL3BhaG9sZSAuL2J0
ZmRpZmYgfi9sb2NhbC9idGYvdm1saW51eDQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJpaSBO
YWtyeWlrbyA8YW5kcmlpbkBmYi5jb20+DQoNClRoYW5rcyBmb3IgdGhlIGZpeC4NCk1heWJlIGFk
ZDoNCkZpeGVzOiBiMTgzNTRmNjRjYzIgKCJidGY6IEdlbmVyYXRlIGNvcnJlY3Qgc3RydWN0IGJp
dGZpZWxkIG1lbWJlciB0eXBlcyIpDQoNCkluIGNvbW1pdCBtZXNzYWdlLCBhZGQgd2hhdCBDb21t
aXQgYjE4MzU0ZjY0Y2MyIHRyaWVzIHRvIGRvDQphbmQgd2h5IGl0IGlzIG5vdCBuZWVkZWQgYW55
IG1vcmUuDQogIEl0IHRyaWVzIHRvIGdlbmVyYXRlIGNvcnJlY3Qgc3RydWN0IGJpdGZpZWxkIG1l
bWJlciB0eXBlIGlmIHRoZQ0KICBtZW1iZXIgaXMgYW4gZW51bS4gVGhpcyBpcyBkYXRlZCBiZWZv
cmUga2luZF9mbGFnIGltcGxlbWVudGF0aW9uLg0KICBsYXRlciBraW5kX2ZsYWcgc3VwcG9ydGVk
IGlzIGFkZGVkIGFuZCBwYWhvbGUgYWx3YXlzIGdlbmVyYXRlcw0KICBCVEYgd2l0aCBraW5kX2Zs
YWcgPSAxIGZvciBzdHJ1Y3R1cmVzIHdpdGggYml0ZmllbGQsDQogIHdoZXJlIGJpdGZpZWxkIHNp
emUgaXMgZW5jb2RlZCBpbiBidGZfbWVtYmVyLA0KICBzbyB0aGlzIHdvcmthcm91bmQgaXMgbm90
IG5lZWRlZCBhbnkgbW9yZS4NCiAgUmVtb3ZpbmcgdGhpcyAiaGFjayIgY2FuIG1ha2UgaGFuZGxp
bmcgcGFja2VkIGVudW0gY29ycmVjdGx5IHRvby4NCg0KV2l0aCB0aGlzIGNoYW5nZSwNCiAgIEFj
a2VkLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPg0KDQo+IC0tLQ0KPiAgIGJ0Zl9lbmNv
ZGVyLmMgfCA5IC0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2J0Zl9lbmNvZGVyLmMgYi9idGZfZW5jb2Rlci5jDQo+IGluZGV4
IDljZjA4MzEuLmQ4ZGMzNjggMTAwNjQ0DQo+IC0tLSBhL2J0Zl9lbmNvZGVyLmMNCj4gKysrIGIv
YnRmX2VuY29kZXIuYw0KPiBAQCAtMTE2LDE1ICsxMTYsNiBAQCBzdGF0aWMgaW50MzJfdCBlbnVt
ZXJhdGlvbl90eXBlX19lbmNvZGUoc3RydWN0IGJ0Zl9lbGYgKmJ0ZmUsIHN0cnVjdCB0YWcgKnRh
ZykNCj4gICAJc3RydWN0IGVudW1lcmF0b3IgKnBvczsNCj4gICAJaW50MzJfdCB0eXBlX2lkOw0K
PiAgIA0KPiAtCS8qIGlmIGVudW1lcmF0b3IgYml0X3NpemUgaXMgbm90IDMyLCBnZW5lcmF0ZSBh
biBpbnQgdHlwZSBpbnN0ZWFkLiAqLw0KPiAtCWlmIChldHlwZS0+c2l6ZSAhPSAzMikgew0KPiAt
CQlzdHJ1Y3QgYmFzZV90eXBlIGJ0ID0ge307DQo+IC0NCj4gLQkJYnQuYml0X3NpemUgPSBldHlw
ZS0+c2l6ZTsNCj4gLQkJYnQuaXNfc2lnbmVkID0gdHJ1ZTsNCj4gLQkJcmV0dXJuIGJ0Zl9lbGZf
X2FkZF9iYXNlX3R5cGUoYnRmZSwgJmJ0KTsNCj4gLQl9DQo+IC0NCj4gICAJdHlwZV9pZCA9IGJ0
Zl9lbGZfX2FkZF9lbnVtKGJ0ZmUsIGV0eXBlLT5uYW1lc3BhY2UubmFtZSwgZXR5cGUtPnNpemUs
IGV0eXBlLT5ucl9tZW1iZXJzKTsNCj4gICAJaWYgKHR5cGVfaWQgPCAwKQ0KPiAgIAkJcmV0dXJu
IHR5cGVfaWQ7DQo+IA0K
