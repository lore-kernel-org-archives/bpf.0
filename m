Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22A6C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 23:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947AE218B0
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 23:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oJT3wwW/";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DqyVMKGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfBYXxZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:53:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbfBYXxY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 18:53:24 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PNpbFH020145;
        Mon, 25 Feb 2019 15:52:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CPnYp8lRZC+ZILR2DmBgKSDz7u/57n75nK3c4sky18o=;
 b=oJT3wwW/YQlNTuRNN9x2W/7JHh3iBkKW27jkvF1Je5vtDv13c+4uHrJUbMIwUy2o67E9
 8xk0XlEvjAR26j4w9t3A3rYb4u+Djs27AhU0lCG6wXGXtVOl7asImej0mCCu0nUkkAoe
 1J1M5suPy2fOs56O5vnOt3Ixzwezdpmb5Pc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvrtpra6t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 15:52:57 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 25 Feb 2019 15:52:47 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 25 Feb 2019 15:52:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPnYp8lRZC+ZILR2DmBgKSDz7u/57n75nK3c4sky18o=;
 b=DqyVMKGmuI3X5R+WtIJE8KT2g/IAejiyhR5OZ/pBAgxd88cVRt20e+QJqwVEAFqr6ZNOmbtFXI0Mgwv+Oc6wNjJ6Xm+RxtYYQ+XG9VVk8r55+N53gwITmAcpYtnzrXu/wdAZfWphi6FShfEt903ReiNh9tQn8rxr294V4ptyfJM=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2904.namprd15.prod.outlook.com (20.178.236.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 23:52:46 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 23:52:46 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>,
        Alexei Starovoitov <ast@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: enable program stats
Thread-Topic: [PATCH v3 bpf-next 1/4] bpf: enable program stats
Thread-Index: AQHUzVl+TgA+w9+HAkOXAbBOtH+zIqXxIvCAgAAMwoA=
Date:   Mon, 25 Feb 2019 23:52:45 +0000
Message-ID: <2eeb7f8d-d184-07d1-2b7b-76c93b4b1bfe@fb.com>
References: <20190225222842.2031962-1-ast@kernel.org>
 <20190225222842.2031962-2-ast@kernel.org> <20190225230703.GB32115@mini-arch>
In-Reply-To: <20190225230703.GB32115@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:ebe2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2d5c9a9-e1a1-41f1-9398-08d69b7c56ef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2904;
x-ms-traffictypediagnostic: BYAPR15MB2904:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2904;20:kudqNMG3xuFtvsHtILtYt/ozl8Sv8+NoajlcKn9Dm54+NFhK+eeoiCZUHazvvio1VRZTymKyl4qjaEnzqXhTYvUZIchdQivtV1M7kLoswKdxvLEythAzUtue5oLwJs0IYLt47izhTW7dKxDRGSCEfVkdMCJOyYcrh71rewc8IKQ=
x-microsoft-antispam-prvs: <BYAPR15MB2904823EE77AD78FDB79591BD77A0@BYAPR15MB2904.namprd15.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(76176011)(5660300002)(4744005)(52116002)(256004)(8936002)(2616005)(86362001)(99286004)(476003)(31686004)(11346002)(446003)(53936002)(81156014)(81166006)(186003)(6116002)(8676002)(31696002)(71200400001)(46003)(71190400001)(6246003)(54906003)(305945005)(97736004)(102836004)(7736002)(6436002)(14454004)(386003)(6506007)(25786009)(478600001)(106356001)(110136005)(105586002)(6486002)(6512007)(2906002)(486006)(36756003)(68736007)(229853002)(316002)(4326008)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2904;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wkonujB3MKffa7umKMP/RCoBDgcD1KNmsrFjIZEZaNoRffdzyrgBr7mro6/hk8Sz5P14MyzykJIuq2+2ck5SQGEyek/de4rjYL6/GHXGMKmS8qGjLf9duwoFcCQipowQbU5skUPNHM9oGEX27Zm9S3OjtS8f2v3AD4gnflyCsrBRA7WYrkXrEBzvvd4D+APweYVVDIaJix7gWj9Fdaxo3/XTiT+jCuJjmoWU0F71N7P5Vgz/+FFrSqVyrjgUnopJ1axobmHriqa6OgYoUq110wprCgRlDO+E5UvO0JzU4uIBcBGwcFo00WmAk93IsMCaEFh9zFbYuiLU3DDXglZOfrEuv489CL7qhWavvgWxnsEyR5tgd7CEiQIzXXjAYsRt9d5tbVV26Rp7J9Uio61MIk5EG4c4VQTu0CBRmdYddk4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35591142E9121643A87A9024B7AF8577@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d5c9a9-e1a1-41f1-9398-08d69b7c56ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 23:52:45.1481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2904
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMi8yNS8xOSAzOjA3IFBNLCBTdGFuaXNsYXYgRm9taWNoZXYgd3JvdGU6DQo+PiArI2RlZmlu
ZSBCUEZfUFJPR19SVU4ocHJvZywgY3R4KQkoewkJCQlcDQo+PiArCXUzMiByZXQ7CQkJCQkJXA0K
Pj4gKwljYW50X3NsZWVwKCk7CQkJCQkJXA0KPj4gKwlpZiAoc3RhdGljX2JyYW5jaF91bmxpa2Vs
eSgmYnBmX3N0YXRzX2VuYWJsZWRfa2V5KSkgewlcDQo+PiArCQlzdHJ1Y3QgYnBmX3Byb2dfc3Rh
dHMgKnN0YXRzOwkJCVwNCj4+ICsJCXU2NCBzdGFydCA9IHNjaGVkX2Nsb2NrKCk7CQkJXA0KPiBR
UTogd2h5IHNjaGVkX2Nsb2NrKCkgYW5kIG5vdCwgZm9yIGV4YW1wbGUsIGt0aW1lX2dldF9ucygp
IHdoaWNoIHdlIGRvDQo+IGluIHRoZSBicGZfdGVzdF9ydW4oKT8gT3IgZXZlbiB3aHkgbm90IGxv
Y2FsX2Nsb2NrPw0KPiBJJ20ganVzdCB3b25kZXJpbmcgd2hhdCBraW5nIG9mIHRyYWRlIG9mZiB3
ZSBhcmUgZG9pbmcgaGVyZQ0KPiByZWdhcmRpbmcgcHJlY2lzaW9uIHZzIHJ1biB0aW1lIGNvc3Qu
DQoNCg0KSSdtIG1ha2luZyB0aGlzIGRlY2lzaW9uIGJhc2VkIG9uIGRvY3VtZW50YXRpb246DQpE
b2N1bWVudGF0aW9uL3RpbWVycy90aW1la2VlcGluZy50eHQNCiJDb21wYXJlZCB0byBjbG9jayBz
b3VyY2VzLCBzY2hlZF9jbG9jaygpIGhhcyB0byBiZSB2ZXJ5IGZhc3Q6IGl0IGlzIA0KY2FsbGVk
IG11Y2ggbW9yZSBvZnRlbiwgZXNwZWNpYWxseSBieSB0aGUgc2NoZWR1bGVyLiBJZiB5b3UgaGF2
ZSB0byBkbyANCnRyYWRlLW9mZnMgYmV0d2VlbiBhY2N1cmFjeSBjb21wYXJlZCB0byB0aGUgY2xv
Y2sgc291cmNlLCB5b3UgbWF5IA0Kc2FjcmlmaWNlIGFjY3VyYWN5IGZvciBzcGVlZCBpbiBzY2hl
ZF9jbG9jaygpLiINCg==
