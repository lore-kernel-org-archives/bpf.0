Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7C4C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 19:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218A320854
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 19:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lcwyoft6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="P/MzaplX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfCYTfb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:35:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729626AbfCYTfb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Mar 2019 15:35:31 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PJXNWS015219;
        Mon, 25 Mar 2019 12:35:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Oxv8CQQ/un27ki1OmW/uEBqWP5OQLQk4k1pDld0T9pw=;
 b=lcwyoft6wy7ng7NLtSlAo2z8BeV57nKdEog3M5aNcW0lgP3KTl4Eu+vfF0503Acy2CI0
 HhyOr9e2p4zwa8kxTQASd1n592xNxHfuaU6go1j5eS/oO3dT03/rWUxa7K5v7Fo6eOH6
 L2mbTSiqlHrVPnxMoj0pPhadpIJyOm4YVr4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf4chr8rn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 12:35:05 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Mar 2019 12:35:04 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Mar 2019 12:35:04 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Mar 2019 12:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxv8CQQ/un27ki1OmW/uEBqWP5OQLQk4k1pDld0T9pw=;
 b=P/MzaplXhKP2E2pFiZqOboBnTtSV0JHKCRC9jgHvnYh3xIu8rhFEnJF7v7rhXs431ngJu4gNou1hebag3OHZ2wt5KlZry/hROkkzpaU5gsFwQLv/0Cz9ssK3gRiKr4qIi/wxpCGCd35yz+fA+v5HqQKBkl25tzcd/3sB711Xo0s=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3016.namprd15.prod.outlook.com (20.178.238.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 19:34:42 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 19:34:42 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Michal Rostecki <mrostecki@opensuse.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        Brenden Blanco <bblanco@gmail.com>
Subject: Re: libbpf packaging
Thread-Topic: libbpf packaging
Thread-Index: AQHU4yRKu0OnEJTLWkS6qR49Y01dX6YcmASAgAAlRYA=
Date:   Mon, 25 Mar 2019 19:34:42 +0000
Message-ID: <e13f6295-e7ae-80c4-67af-6e8551a375a1@fb.com>
References: <20190325122134.GA14042@krava>
 <854218ad-ce5c-cd00-7772-97bd9bc379a1@iogearbox.net>
 <CAADnVQKvRz-EMPqB5oMiG=6N1-QwAhMGnpnQsgSyQuUcrA781A@mail.gmail.com>
 <20190325172115.i35nfrelzkwqgyoy@workstation>
In-Reply-To: <20190325172115.i35nfrelzkwqgyoy@workstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:101:1f::32) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:ec9a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73c704c6-f9f1-477c-f334-08d6b158ed98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3016;
x-ms-traffictypediagnostic: BYAPR15MB3016:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR15MB301652335AF5FB9EC906F157D35E0@BYAPR15MB3016.namprd15.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(366004)(376002)(199004)(189003)(6116002)(3480700005)(53546011)(110136005)(386003)(86362001)(6486002)(6506007)(97736004)(6436002)(76176011)(81166006)(31696002)(6512007)(2906002)(46003)(54906003)(8936002)(316002)(7116003)(68736007)(6306002)(7736002)(305945005)(229853002)(52116002)(93886005)(71190400001)(71200400001)(486006)(478600001)(446003)(81156014)(53936002)(105586002)(106356001)(11346002)(14454004)(186003)(2616005)(31686004)(966005)(221733001)(4326008)(6246003)(256004)(8676002)(25786009)(99286004)(102836004)(476003)(36756003)(5660300002)(111123002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3016;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Oe0w11iHtYgHZPBUYDOMXG5CocCFYRKStBYcxF9NLNXAQWivSHJ/6Gcpnf8ACNMZw3gosHZV//PDAMrPWomwFgF/vq22wR5OHrpclbzw0kENGNGhvK9Z/WbKZkuaw5IftW4eBpi82uhyWk1VhQlIPR9Lo21sHdmI6qk9NguGszP/Q5ya+1KVEoDlMkNSvPOFtIUwu8YO+oJXFYqZZKkaStEloGZhMYy3ThuZpTevIG5JK6cvf0GW5yosubXlduyxGXq50ReO476grZmBBrlc4uV6iIJ1QG+ijzQ4F3s3fJI78MqCPWWSjHsg9wyox93ZjZ2LRlftmh0Oe2tXov6eguHCroyQ6dAySb5qJ4GF2MhsAurf+puWiA8+1NyWjcc2QJKmp9/AIMNupwuk8wZjbyIkw2CM+CxIH1vIhiI/2qo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E261D19B2ED371478A567FB93B459543@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c704c6-f9f1-477c-f334-08d6b158ed98
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 19:34:42.4728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3016
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDMvMjUvMTkgMTA6MjEgQU0sIE1pY2hhbCBSb3N0ZWNraSB3cm90ZToNCj4gT24gTW9u
LCBNYXIgMjUsIDIwMTkgYXQgMDk6MDM6MTFBTSAtMDcwMCwgQWxleGVpIFN0YXJvdm9pdG92IHdy
b3RlOg0KPj4+PiAyKSBUaGVyZSdzIGFscmVhZHkgYmNjLWRldmVsJ3MgbGliYnBmIGxpYnJhcnkg
cGFja2FnZWQ6DQo+Pj4+DQo+Pj4+ICAgICAkIHJwbSAtcWYgL3Vzci9saWI2NC9saWJicGYuc28N
Cj4+Pj4gICAgIGJjYy1kZXZlbC0wLjguMC0xLmZjMjgueDg2XzY0DQo+Pj4+DQo+Pj4+ICAgICBz
byB0aGVyZSdzIGEgY29uZmxpY3QuLiBhbnkgY2hhbmNlIHdlIGNvdWxkIHJlbmFtZSBsaWJicGYg
dG8NCj4+Pj4gICAgIHNvbWV0aGluZyBlbHNlIGxpa2U6DQo+Pj4+DQo+Pj4+ICAgICBsaWJicGYy
LnNvDQo+Pj4+ICAgICBsaWJicGZvYmplY3Quc28NCj4+Pj4gICAgIGxpYmJwZmJlc3Quc28NCj4+
Pj4gICAgIC4uLj8NCj4+Pg0KPj4+IEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIHJlbmFtZSB0aGUg
b2ZmaWNpYWwgbGliYnBmIHBhY2thZ2UsIHRoaXMgd2lsbA0KPj4+IGp1c3QgY3JlYXRlIHBsYWlu
IGNvbmZ1c2lvbiBhbmQgd2lsbCBtYWtlIGl0IG11Y2ggaGFyZGVyIGZvciBwb3RlbnRpYWwNCj4+
PiB1c2VycyB0byBhZGFwdCBpbiB0aGUgbG9uZy10ZXJtIHNpbmNlIHdlIGFpbSBmb3IgL2V2ZXJ5
b25lLyB0byBjb25zdW1lDQo+Pj4gb2ZmaWNpYWwgbGliYnBmIGxpYnJhcnkgaW5zdGVhZCBvZiBo
YWNraW5nIHRoZWlyIG93bi4NCj4+Pg0KPj4+IEkgdGhpbmsgYmNjIGZvbGtzIGFyZSBtaWdyYXRp
bmcgdG8gb2ZmaWNpYWwgbGliYnBmIGFzIHdlbGwsIGF0IGxlYXN0DQo+Pj4gdGhhdCB3YXMgbXkg
aW1wcmVzc2lvbi4gSW1obywgdGhpcyB3b3VsZCBuZWVkIGZpeGluZyBvbiBiY2Mgc2lkZSB0aGVu
Lg0KPj4NCj4+IGJjYyBtaWdyYXRlZCB0byBsaWJicGYgc29tZSB0aW1lIGFnby4NCj4gDQo+IEFu
ZCB0aGUgbGliYnBmLnNvIGZpbGUgd2hpY2ggaXMgaW5zdGFsbGVkIHdpdGggYmNjIGlzICJvdXIi
IGxpYmJwZi4gYmNjDQo+IHNpbXBseSB1c2VzIGxpYmJwZiAoZnJvbSB0aGUgYXV0by1zeW5jZWQg
c3RhbmRhbG9uZSByZXBvWzBdKSBhcyBhDQo+IHN1Ym1vZHVsZVsxXS4gVG8gcGFja2FnZSBsaWJi
cGYgYW5kIGJjYyBwcm9wZXJseSBpbiBMaW51eCBkaXN0cm9zIHdlDQo+IG5lZWQgYSBwb3NzaWJp
bGl0eSB0byB1c2UgYmNjIHdpdGggc2hhcmVkIGxpYmJwZiBsaWJyYXJ5IC0gd2hpY2gNCj4gcHJv
YmFibHkgY2FuIGJlIGFjaGl2ZXZlZCBieSBzbWFsbCBjaGFuZ2UgaW4gYmNjJ3MgQ01ha2VMaXN0
cy50eHQuDQoNCkkgdGhpbmsgd2Ugc2hvdWxkIHJlbmFtZSBiY2MgbGliYnBmLnNvIHRvIGEgZGlm
ZmVyZW50IG5hbWUgKG1heWJlIA0KbGliYmNjX2JwZi5zbykgdG8gYXZvaWQgY29uZnVzaW9ucyBi
ZXR3ZWVuIGJjYyBsaWJicGYgYW5kIGxpYmJwZiByZXBvLg0KVGhlIGJjYyBsaWJicGYuc28gaXMg
ZGlmZmVyZW50IGZyb20gbGliYnBmIHJlcG8gaXQgY29udGFpbnMgc29tZSB3cmFwcGVycy4uLg0K
DQpJIHdpbGwgcHJvcG9zZSB0byBpb3Zpc29yL2JjYyBtYWlsaW5nIGxpc3QuDQoNCj4gDQo+IFRo
ZSBzdGFuZGFsb25lIHJlcG9bMF0gbWlnaHQgYmUgYSBiZXR0ZXIgYmFzZSBmb3IgY3JlYXRpbmcg
YSBwYWNrYWdlDQo+IHRoYW4gZnVsbCBrZXJuZWwgc291cmNlcy4gQW5kIHVzaW5nICVzb3ZlcnNp
b24lK2dpdCVzaGElIChpLmUuDQo+IDAuMC4yK2dpdDMzYjAxNykgbWlnaHQgYmUgYSBiZXR0ZXIg
dmVyc2lvbiBwYXR0ZXJuIG9mIHRoYXQgcGFja2FnZS4NCj4gDQo+IENoZWVycywNCj4gTWljaGFs
DQo+IA0KPiBbMF0gaHR0cHM6Ly9naXRodWIuY29tL2xpYmJwZi9saWJicGYNCj4gWzFdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9pb3Zpc29yL2JjYy9ibG9iL21hc3Rlci9DTWFrZUxpc3RzLnR4dCNMMTIt
TDE2DQo+IA0K
