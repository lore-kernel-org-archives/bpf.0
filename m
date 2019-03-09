Return-Path: <SRS0=imf1=RM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8789C43381
	for <bpf@archiver.kernel.org>; Sat,  9 Mar 2019 07:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644F6207E0
	for <bpf@archiver.kernel.org>; Sat,  9 Mar 2019 07:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M9EgzAgM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MleA58nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbfCIHbU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 9 Mar 2019 02:31:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48210 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbfCIHbU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 9 Mar 2019 02:31:20 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x297UQfk006825;
        Fri, 8 Mar 2019 23:30:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vU8/vWK2dtelRmZmIyiq/7PYa5nCDPAmdO+n2Sasff4=;
 b=M9EgzAgMPfjRVQ+yz+bX9HiDvC5AjTT1PuU8FC4qvFrTrpZ4OWf0/wTBlXNI2uVwzB2D
 oIWZN8IBZlaea76EG0Sm7vmyfL3SHqe/uE4V6gICxBDTqbN/TaF8U8+lCfHczAxJJCDD
 DIIdCeryTxU2Ikj9Z9SoMZEbriDNadY0V2o= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r458h8gk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 08 Mar 2019 23:30:58 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 8 Mar 2019 23:30:56 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 8 Mar 2019 23:30:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU8/vWK2dtelRmZmIyiq/7PYa5nCDPAmdO+n2Sasff4=;
 b=MleA58nYMXVrO1eXWa2r2C6fAc9ctT9gQ3HCxB6Bx+/QwAeYDWXxaiDewGdXnadDlt5+ozrsOeQmT4Qt6tW62f3zbrOHKc+AJ07yE72md4/i4co22lsiueNHExwmWEABl047Ot5pd9E3JrQUKgHFNxRQgi54vTJ3528UNy2Ed5E=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2245.namprd15.prod.outlook.com (52.135.196.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Sat, 9 Mar 2019 07:30:55 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1686.020; Sat, 9 Mar 2019
 07:30:55 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "Alexei Starovoitov" <ast@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>,
        "tehnerd@tehnerd.com" <tehnerd@tehnerd.com>
Subject: Re: [PATCH bpf] libbpf: handle BTF parsing and loading properly
Thread-Topic: [PATCH bpf] libbpf: handle BTF parsing and loading properly
Thread-Index: AQHU1grkLRjsKV+OxESIbJC/5rSib6YC5/QA
Date:   Sat, 9 Mar 2019 07:30:55 +0000
Message-ID: <aa7594b4-4394-8f5b-6af2-c3a4ecebf19d@fb.com>
References: <20190308235820.3854596-1-andriin@fb.com>
In-Reply-To: <20190308235820.3854596-1-andriin@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:300:129::13) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::eb92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eede24f1-62ae-40d9-4ba3-08d6a4612a3d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2245;
x-ms-traffictypediagnostic: BYAPR15MB2245:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2245;20:Ivdu0IzT0BBiHVZEh81Q9UFUHl/kEZte1lAaVgLQO0heZsUgfpBX1+mInO9pmdpT2IQ8hkkAcG/5px1emgcmmxKcyKh8tpWdKoSbiMEfDa3waFOdBjtxcJGsz60UYBK3tc2MMjZVNzGfwc+g0JJgN0UzGApoLIuz9uMdfR6QIXc=
x-microsoft-antispam-prvs: <BYAPR15MB224568C81C023AA4AFA0AFF4D34E0@BYAPR15MB2245.namprd15.prod.outlook.com>
x-forefront-prvs: 0971922F40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(316002)(99286004)(229853002)(52116002)(6436002)(110136005)(76176011)(6486002)(14454004)(53936002)(86362001)(68736007)(2906002)(2201001)(256004)(14444005)(8936002)(31696002)(478600001)(46003)(36756003)(25786009)(6116002)(6512007)(81166006)(81156014)(8676002)(446003)(476003)(486006)(31686004)(11346002)(2616005)(105586002)(6506007)(386003)(53546011)(186003)(106356001)(102836004)(7736002)(2501003)(305945005)(5660300002)(71190400001)(71200400001)(97736004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2245;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YGre+lQGNB/fR7U4ZLDL005Sgs+/UUVVSsV9MI6VKAg1ZvkMCsqMZShBIazEd+fdkIchn5tHUb3V6bn8WjWpiiGZopo5z+lgrX7znWOZ+BSVfnceK1BgtCVldqUoWezS4QSnosTHRQvBB4jWMfgPRhAhNTwRczrLpRXZd7go3Itm3ptpGerdxTHPgODAtm6lEJSZ/st2sXudBHNA9brXf77ezagZkxpUMoFGbS3x454sm77HtZ+QFH6VZhxtx5a3sR/nktVaWu9+e9z0Lcafb0HA+wQLsaJgI2GdKmiOrbFID4zKrD35T/C1gSkuSXMnD/z2K2mDLTKC39UW8BFMpBHBbpnlhvkwLxneBcPhX1Pz/0cwOhWq7TuwvTYBOxZm64enu4x0KtG/IgKnFrcR0qa9Xqh/nOSX0cqe7urCK0I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE78ED2A9510CB42937BD2B3AEEAF2BE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eede24f1-62ae-40d9-4ba3-08d6a4612a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2019 07:30:55.0439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-09_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDMvOC8xOSAzOjU4IFBNLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+IFRoaXMgcGF0
Y2ggc3BsaXRzIGFuZCBjbGVhbnMgdXAgZXJyb3IgaGFuZGxpbmcgbG9naWMgZm9yIGxvYWRpbmcg
QlRGIGRhdGEuDQo+IFByZXZpb3VzbHksIGlmIEJURiBkYXRhIHdhcyBwYXJzZWQgc3VjY2Vzc2Z1
bGx5LCBidXQgZmFpbGVkIHRvIGxvYWQgaW50bw0KPiBrZXJuZWwsIHdlJ2QgcmVwb3J0IG5vbnNl
bnNpY2FsIGVycm9yIGNvZGUsIGluc3RlYWQgb2YgZXJyb3IgcmV0dXJuZWQgZnJvbQ0KPiBidGZf
X2xvYWQoKS4gTm93IGJ0Zl9fbmV3KCkgYW5kIGJ0Zl9fbG9hZCgpIGFyZSBoYW5kbGVkIHNlcGFy
YXRlbHkgd2l0aCBwcm9wZXINCj4gY2xlYW51cCBhbmQgd2FybmluZyByZXBvcnRpbmcuDQo+IA0K
PiBGaXhlczogZDI5ZDg3ZjdlNjEyICgiYnRmOiBzZXBhcmF0ZSBidGYgY3JlYXRpb24gYW5kIGxv
YWRpbmciKQ0KPiBSZXBvcnRlZC1ieTogTWFydGluIEthRmFpIExhdSA8a2FmYWlAZmIuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaW5AZmIuY29tPg0KDQpBY2tl
ZC1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCg0KPiAtLS0NCj4gICB0b29scy9saWIv
YnBmL2xpYmJwZi5jIHwgMTMgKysrKysrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xp
Yi9icGYvbGliYnBmLmMgYi90b29scy9saWIvYnBmL2xpYmJwZi5jDQo+IGluZGV4IGQ1YjgzMGQ2
MDYwMS4uNWU5NzdkMjY4OGRhIDEwMDY0NA0KPiAtLS0gYS90b29scy9saWIvYnBmL2xpYmJwZi5j
DQo+ICsrKyBiL3Rvb2xzL2xpYi9icGYvbGliYnBmLmMNCj4gQEAgLTgzNSwxMiArODM1LDE5IEBA
IHN0YXRpYyBpbnQgYnBmX29iamVjdF9fZWxmX2NvbGxlY3Qoc3RydWN0IGJwZl9vYmplY3QgKm9i
aiwgaW50IGZsYWdzKQ0KPiAgIAkJCW9iai0+ZWZpbGUubWFwc19zaG5keCA9IGlkeDsNCj4gICAJ
CWVsc2UgaWYgKHN0cmNtcChuYW1lLCBCVEZfRUxGX1NFQykgPT0gMCkgew0KPiAgIAkJCW9iai0+
YnRmID0gYnRmX19uZXcoZGF0YS0+ZF9idWYsIGRhdGEtPmRfc2l6ZSk7DQo+IC0JCQlpZiAoSVNf
RVJSKG9iai0+YnRmKSB8fCBidGZfX2xvYWQob2JqLT5idGYpKSB7DQo+ICsJCQlpZiAoSVNfRVJS
KG9iai0+YnRmKSkgew0KPiAgIAkJCQlwcl93YXJuaW5nKCJFcnJvciBsb2FkaW5nIEVMRiBzZWN0
aW9uICVzOiAlbGQuIElnbm9yZWQgYW5kIGNvbnRpbnVlLlxuIiwNCj4gICAJCQkJCSAgIEJURl9F
TEZfU0VDLCBQVFJfRVJSKG9iai0+YnRmKSk7DQo+IC0JCQkJaWYgKCFJU19FUlIob2JqLT5idGYp
KQ0KPiAtCQkJCQlidGZfX2ZyZWUob2JqLT5idGYpOw0KPiAgIAkJCQlvYmotPmJ0ZiA9IE5VTEw7
DQo+ICsJCQkJY29udGludWU7DQo+ICsJCQl9DQo+ICsJCQllcnIgPSBidGZfX2xvYWQob2JqLT5i
dGYpOw0KPiArCQkJaWYgKGVycikgew0KPiArCQkJCXByX3dhcm5pbmcoIkVycm9yIGxvYWRpbmcg
JXMgaW50byBrZXJuZWw6ICVkLiBJZ25vcmVkIGFuZCBjb250aW51ZS5cbiIsDQo+ICsJCQkJCSAg
IEJURl9FTEZfU0VDLCBlcnIpOw0KPiArCQkJCWJ0Zl9fZnJlZShvYmotPmJ0Zik7DQo+ICsJCQkJ
b2JqLT5idGYgPSBOVUxMOw0KPiArCQkJCWVyciA9IDA7DQo+ICAgCQkJfQ0KPiAgIAkJfSBlbHNl
IGlmIChzdHJjbXAobmFtZSwgQlRGX0VYVF9FTEZfU0VDKSA9PSAwKSB7DQo+ICAgCQkJYnRmX2V4
dF9kYXRhID0gZGF0YTsNCj4gDQo=
