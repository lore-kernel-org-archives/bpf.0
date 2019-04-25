Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E672C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 15:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ED5205ED
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 15:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="E2YVx5ZN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QCIk70xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDYPgj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:36:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33106 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbfDYPgi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 11:36:38 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PFY0WJ000457;
        Thu, 25 Apr 2019 08:36:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HFGBVmVnY18oOwRNAcJvRLln6WL2GP5shaju8MTy1qY=;
 b=E2YVx5ZNOpUM5vWEoU2Dbbg9fQlvd3mZR48o2oCPJqtSdf4mEX6GPXEhI+gzWzcUGDZ3
 OrbfJDA5qvUyjEsxfNk22CrK8J9Ux4xbKeCbns8KHgtYZSrJBVwd/XhsxhVNP4/ibDLW
 DngHpxGKL+1QOaWZ1UjF7vzTdvxuzKFvzNA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3b4eh3p5-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Apr 2019 08:36:14 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 25 Apr 2019 08:36:10 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Apr 2019 08:36:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFGBVmVnY18oOwRNAcJvRLln6WL2GP5shaju8MTy1qY=;
 b=QCIk70xnxuyOnZt9wai7yC3rpB0vkEnvepCxawix/lL2wHbV6YP+4O9b0DWUN2ONPgGjIoPVDDBF0/E4zgNP2IbFzHKcEcYdEr/6c4zCjSGcZWq5NOZtIxYbGOG+9oGm7gY13mka4k1g/F6oBAWwryhMxO37pRN/ML+mLmFA6fY=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2407.namprd15.prod.outlook.com (52.135.198.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Thu, 25 Apr 2019 15:36:08 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 15:36:08 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Martin Lau <kafai@fb.com>,
        "acme@kernel.org" <acme@kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpftool: add ability to dump BTF types
Thread-Topic: [PATCH v2 bpf-next 1/3] bpftool: add ability to dump BTF types
Thread-Index: AQHU+yUFgSsY+WrMT0+mpoWN/XQlfaZNAuaA
Date:   Thu, 25 Apr 2019 15:36:08 +0000
Message-ID: <7c2d6f26-1ed9-83f5-586b-3ce2a8782f94@fb.com>
References: <20190425050355.1359736-1-andrii.nakryiko@gmail.com>
 <20190425050355.1359736-2-andrii.nakryiko@gmail.com>
In-Reply-To: <20190425050355.1359736-2-andrii.nakryiko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:a55d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b06ad91-fa70-4045-e37e-08d6c993bc75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2407;
x-ms-traffictypediagnostic: BYAPR15MB2407:
x-microsoft-antispam-prvs: <BYAPR15MB24077EBFD5B070018BD72807D33D0@BYAPR15MB2407.namprd15.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(6506007)(6436002)(110136005)(86362001)(53546011)(486006)(102836004)(11346002)(97736004)(31686004)(54906003)(52116002)(76176011)(4326008)(386003)(476003)(46003)(36756003)(478600001)(2501003)(25786009)(316002)(446003)(14454004)(99286004)(229853002)(6486002)(186003)(66446008)(6246003)(8936002)(71200400001)(68736007)(6116002)(2906002)(66556008)(8676002)(81166006)(66476007)(53936002)(81156014)(64756008)(31696002)(71190400001)(7736002)(2616005)(2201001)(6512007)(73956011)(256004)(5660300002)(305945005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2407;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gQgeKIgt37UNPn4xmn8KE9n9gzCGZ4WaoCeDs0WxUGKS/7sk05lDh7qTwsaHLLKD2ABeTyK273XnWc8TAqGnY++Z8HETvPfDGxn4Bxip9FKQLiFg7RRO/+w/S/Pz5KRTo/ofRmCwGPmBVguxZMj/Cyc52amX2T5B4VPQNFIq9Svr07Pt5qN4K49Gyfc5yL/9OEFI5uOGoH9+vztwL4iBLEMkOxLrtjVFKGRvE8/Kqt5yX3FMH9XLSS/kUsypjnw26vEvnC6n9gcA/TdM1I5A9TwPYo0nqBfmKHtLxwNp5VIXExldm7ijdXabajJsbWmYkWblkTAQO6qiQNIU0aWo3fZEUWnCLtUHsZ4ONU2dqGB6l9OVaSGmBZL4GD9R1IrxgRIeop0UbZoSU79s/+j5FXqaTQLxpr0jslPLoPKWlKQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED60058D20B4BA46BE2D9EAAE0F128FD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b06ad91-fa70-4045-e37e-08d6c993bc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 15:36:08.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDQvMjQvMTkgMTA6MDMgUE0sIGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20gd3JvdGU6
DQo+IEZyb206IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpbkBmYi5jb20+DQo+IA0KPiBBZGQgbmV3
IGBidGYgZHVtcGAgc3ViLWNvbW1hbmQgdG8gYnBmdG9vbC4gSXQgYWxsb3dzIHRvIGR1bXANCj4g
aHVtYW4tcmVhZGFibGUgbG93LWxldmVsIEJURiB0eXBlcyByZXByZXNlbnRhdGlvbiBvZiBCVEYg
dHlwZXMuIEJURiBjYW4NCj4gYmUgcmV0cmlldmVkIGZyb20gZmV3IGRpZmZlcmVudCBzb3VyY2Vz
Og0KPiAgICAtIGZyb20gQlRGIG9iamVjdCBieSBJRDsNCj4gICAgLSBmcm9tIFBST0csIGlmIGl0
IGhhcyBhc3NvY2lhdGVkIEJURjsNCj4gICAgLSBmcm9tIE1BUCwgaWYgaXQgaGFzIGFzc29jaWF0
ZWQgQlRGIGRhdGE7IGl0J3MgcG9zc2libGUgdG8gbmFycm93DQo+ICAgICAgZG93biB0eXBlcyB0
byBlaXRoZXIga2V5IHR5cGUsIHZhbHVlIHR5cGUsIGJvdGgsIG9yIGFsbCBCVEYgdHlwZXM7DQo+
ICAgIC0gZnJvbSBFTEYgZmlsZSAoLkJURiBzZWN0aW9uKS4NCj4gDQo+IE91dHB1dCBmb3JtYXQg
bW9zdGx5IGZvbGxvd3MgQlBGIHZlcmlmaWVyIGxvZyBmb3JtYXQgd2l0aCBmZXcgbm90YWJsZQ0K
PiBleGNlcHRpb25zOg0KPiAgICAtIGFsbCB0aGUgdHlwZS9maWVsZC9wYXJhbS9ldGMgbmFtZXMg
YXJlIGVuY2xvc2VkIGluIHNpbmdsZSBxdW90ZXMgdG8NCj4gICAgICBhbGxvdyBlYXNpZXIgZ3Jl
cHBpbmcgYW5kIHRvIHN0YW5kIG91dCBhIGxpdHRsZSBiaXQgbW9yZTsNCj4gICAgLSBGVU5DX1BS
T1RPIG91dHB1dCBmb2xsb3dzIFNUUlVDVC9VTklPTi9FTlVNIGZvcm1hdCBvZiBoYXZpbmcgb25l
DQo+ICAgICAgbGluZSBwZXIgZWFjaCBhcmd1bWVudDsgdGhpcyBpcyBtb3JlIHVuaWZvcm0gYW5k
IGFsbG93cyBlYXN5DQo+ICAgICAgZ3JlcHBpbmcsIGFzIG9wcG9zZWQgdG8gc3VjY2luY3QsIGJ1
dCBpbmNvbnZlbmllbnQgZm9ybWF0IHRoYXQgQlBGDQo+ICAgICAgdmVyaWZpZXIgbG9nIGlzIHVz
aW5nLg0KPiANCj4gQ2M6IERhbmllbCBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+DQo+
IENjOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBmYi5jb20+DQo+IENjOiBZb25naG9uZyBTb25n
IDx5aHNAZmIuY29tPg0KPiBDYzogTWFydGluIEthRmFpIExhdSA8a2FmYWlAZmIuY29tPg0KPiBD
YzogU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4NCj4gQ2M6IEFybmFsZG8gQ2FydmFs
aG8gZGUgTWVsbyA8YWNtZUByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyaWkgTmFr
cnlpa28gPGFuZHJpaW5AZmIuY29tPg0KDQpBY2tlZC1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZi
LmNvbT4NCg==
