Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7CC10F0E
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2A420652
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 21:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="o9YfHaY4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KOsvszZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfDRVph (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:45:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45964 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbfDRVph (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Apr 2019 17:45:37 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ILXlXe011931;
        Thu, 18 Apr 2019 14:45:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kYm/jmh4LA7J0KHgR8eW0+5h6QItpZFmQOHQT3vha1o=;
 b=o9YfHaY4jrH8ijcX4JgaGeneklALgc3TWPPfo1GOC/RqIRHxy/IhIesvDJ+iuqiqg8S2
 bH/s7JkYaZZZiO4VfnaeqheeXyDRiQmOXSmUka8Ubo5fMp6thnIbNGgGkDl6O7ULu3Yr
 98+WJjcbHNlPARnzIAG557UvuHSo53X3p2M= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rxw6490da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Apr 2019 14:45:17 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 18 Apr 2019 14:45:16 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Apr 2019 14:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYm/jmh4LA7J0KHgR8eW0+5h6QItpZFmQOHQT3vha1o=;
 b=KOsvszZz8ecMx96D1Ia+RwgUYu6ntht4a2kgnuHvOHyD9kbNmCAa+QAMKaVOsAxpOYHjPjGlozePccwhCpre7E9/DpeCDjTvOlhgNmyUT+veAwPvo6B7whtZD+whE+12PpwzHctJEXlqQyjw27dnEpTcMNv+pyaFzQKNOE+RxAQ=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3109.namprd15.prod.outlook.com (20.178.239.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 21:45:14 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 21:45:14 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Increase MAX_NR_MAPS to 17 in
 test_verifier.c
Thread-Topic: [PATCH bpf-next] bpf: Increase MAX_NR_MAPS to 17 in
 test_verifier.c
Thread-Index: AQHU9i5mEyyRvwEhAUyEzsKrXlxzKKZCc6KA
Date:   Thu, 18 Apr 2019 21:45:14 +0000
Message-ID: <3f73ba99-c345-a7c5-b7ca-10efd10f4ddb@fb.com>
References: <20190418213330.225474-1-kafai@fb.com>
In-Reply-To: <20190418213330.225474-1-kafai@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:102:2::37) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:2ecd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4466baca-da01-458a-4246-08d6c44723cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB3109;
x-ms-traffictypediagnostic: BYAPR15MB3109:
x-microsoft-antispam-prvs: <BYAPR15MB3109B016E8AED9893D6CE848D3260@BYAPR15MB3109.namprd15.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(256004)(46003)(31696002)(25786009)(2501003)(110136005)(36756003)(86362001)(2201001)(316002)(6486002)(97736004)(478600001)(6436002)(4744005)(229853002)(14454004)(6116002)(66476007)(66556008)(54906003)(446003)(11346002)(305945005)(81166006)(8676002)(81156014)(7736002)(476003)(2906002)(5660300002)(31686004)(4326008)(68736007)(486006)(6246003)(8936002)(53936002)(6512007)(99286004)(102836004)(6506007)(14444005)(71190400001)(386003)(71200400001)(2616005)(76176011)(52116002)(66446008)(53546011)(186003)(64756008)(73956011)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3109;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pBxrmDKrkx2WXYJTxBv3aWaRhS37gnUCj9qyCbBsaq8DH3fTqGz6Ko1qQPAvgPd2oqS6r7bVs1b4rTxhiXg4adfJI9Lm6YHmrmfbITwrHw9CWtVey0Blg3PY4pWxPa4GoV+8U5j32e77URsMVNzcuVxBl3EJldfr4yMlD72RCgSPVoVUgcBCv4PT9x251ayvuoxYJPQCyhnPiy8ROdUMWLmikzIIW5KAutR3Flrg9sQB8F3JBHif4/xqz/+N/rgFLDqbD99Bg6QXc7VhIeknnWZjOYjaafKZ8xDp/Ua0duGv9GjmdtKWlHroVoXV1PDph4k+J51FAh1lcxXF2grVTTPlzOh1XJrWVEkNf/a2UBG5lUEcb/LcpmxMpMZlMbZ18TTwEiimAHZiTQKT+xJtsG+/SuWMvApvXQdNG0oLagg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57C91E524907EA4588CFBAE7B286F79E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4466baca-da01-458a-4246-08d6c44723cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 21:45:14.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3109
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMTgvMTkgMjozMyBQTSwgTWFydGluIEthRmFpIExhdSB3cm90ZToNCj4gbWFwX2Zk
c1sxNl0gaXMgdGhlIGxhc3Qgb25lIGluZGV4LWVkIGJ5IGZpeHVwX21hcF9hcnJheV9zbWFsbC4N
Cj4gSGVuY2UsIHRoZSBNQVhfTlJfTUFQUyBzaG91bGQgYmUgMTcgaW5zdGVhZC4NCj4gDQo+IEZp
eGVzOiBmYjJhYmI3M2U1NzUgKCJicGYsIHNlbGZ0ZXN0OiB0ZXN0IHtyZCwgd3J9b25seSBmbGFn
cyBhbmQgZGlyZWN0IHZhbHVlIGFjY2VzcyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBLYUZh
aSBMYXUgPGthZmFpQGZiLmNvbT4NCg0KQWNrZWQtYnk6IFlvbmdob25nIFNvbmcgPHloc0BmYi5j
b20+DQoNCj4gLS0tDQo+ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfdmVyaWZp
ZXIuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVz
dF92ZXJpZmllci5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfdmVyaWZpZXIu
Yw0KPiBpbmRleCA2Y2I2YTEwNzRmZDEuLmVkOWU4OTRhZmVmMyAxMDA2NDQNCj4gLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfdmVyaWZpZXIuYw0KPiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF92ZXJpZmllci5jDQo+IEBAIC01Miw3ICs1Miw3IEBA
DQo+ICAgI2RlZmluZSBNQVhfSU5TTlMJQlBGX01BWElOU05TDQo+ICAgI2RlZmluZSBNQVhfVEVT
VF9JTlNOUwkxMDAwMDAwDQo+ICAgI2RlZmluZSBNQVhfRklYVVBTCTgNCj4gLSNkZWZpbmUgTUFY
X05SX01BUFMJMTYNCj4gKyNkZWZpbmUgTUFYX05SX01BUFMJMTcNCj4gICAjZGVmaW5lIE1BWF9U
RVNUX1JVTlMJOA0KPiAgICNkZWZpbmUgUE9JTlRFUl9WQUxVRQkweGNhZmU0YWxsDQo+ICAgI2Rl
ZmluZSBURVNUX0RBVEFfTEVOCTY0DQo+IA0K
