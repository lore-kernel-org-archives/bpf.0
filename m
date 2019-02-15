Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26C1C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749D02190C
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Awm4FKww";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hU1R0m/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfBORS0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:18:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfBORS0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Feb 2019 12:18:26 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FHAUeJ031796;
        Fri, 15 Feb 2019 09:18:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=VYtEUYYiqJxgqYBKzpWNt7Ast0GaUj4xq7kmA6ljkcQ=;
 b=Awm4FKwwNjIXZgJtRTcgNfAaRPdZJ1PkCiFmDADu7aAWcIJoktHewWiGs3Llj2T5GWuX
 mD//r3dnyFGTMNlkAWR0uQ+A2EPg23LqwvA/If2OtufRSnCrPc6wopXjToDJmCU+ygUa
 zj+u33oPNXHDN33NUE90mXje9ILfi2sN35I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qnxvb0kuv-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 09:18:24 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:17:29 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 09:17:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYtEUYYiqJxgqYBKzpWNt7Ast0GaUj4xq7kmA6ljkcQ=;
 b=hU1R0m/UO9QM8sptxOqkw5hry6HdwZDc5IEYxH1MrPyTe+/gNIBRXyOsSOwBQBgBky+36C6wjVkP73UqoODLnhylL+ITBNvgxKUL6VkIqLBEevv9pk4S7wEOILNdOVFMBkmg+sukAYrEWJqjUGy8R1o+sXOR7sj/WznZ44s/Ltg=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2662.namprd15.prod.outlook.com (20.179.156.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 15 Feb 2019 17:17:27 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::5d5b:6c9d:ce40:ed1d%3]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 17:17:27 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Thread-Topic: pahole: soliciting naming suggestion for struct btf rename
Thread-Index: AQHUxChLVv4T+yGODkyBwEnD4D+fuqXfPrSAgAHdnQA=
Date:   Fri, 15 Feb 2019 17:17:27 +0000
Message-ID: <b156837f-ed18-caf6-7120-5ecfabd4c5ed@fb.com>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
In-Reply-To: <20190214124757.GP3269@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0005.prod.exchangelabs.com (2603:10b6:a02:80::18)
 To BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:117e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4824c3ad-026f-4969-157a-08d693697568
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2662;
x-ms-traffictypediagnostic: BYAPR15MB2662:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2662;20:dzN0PTkqJylyj1WTOLNuTyTUccqml7/kg5AqCsFKwdZZ/aD40CIZcRvnVzrSFR/LMi4wqnvLMiOZ1TH8dfq8jRPwLCHtMxidhpMWXAbrw8znKEXBpp0zjYNK7afk/tgEMiDOUO9+l5IqcRgtWYQ2uMe0Gt8+HrOWibWsQh+zI4A=
x-microsoft-antispam-prvs: <BYAPR15MB2662E980E40C89A487EDF789D7600@BYAPR15MB2662.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(54094003)(199004)(14454004)(53936002)(6506007)(6486002)(386003)(53546011)(7736002)(99286004)(305945005)(97736004)(81166006)(6246003)(186003)(256004)(102836004)(6436002)(4326008)(6512007)(2906002)(478600001)(81156014)(25786009)(8676002)(68736007)(52116002)(4744005)(76176011)(446003)(6116002)(476003)(54906003)(110136005)(46003)(71190400001)(71200400001)(106356001)(316002)(36756003)(31686004)(11346002)(486006)(105586002)(86362001)(2616005)(31696002)(229853002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2662;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6rvkJmB8rc9WTFcD8fG8AdcbbOsLMVg6w6E+jh6m9TBxIxDyw7TZ1qxiu3wLXs8pdhWlv+FibBvxrbe3w/N8aEaAXokb+abyp45HAMiUhDRjmDlEdLoCcB6sbKXFwchv+eLFtQ3hlpt9xtSSrOEufC0GS1bA5XJ3cMAl1ohSEwNaiTKkChCPY8aWWlPePudeKUg8Jn9geLZsbFSvck7J9uCpQw/w6ZuVwqUfQdu1liMwJKdDTHUs6mhMRHhwf1yG4z99JpN1dm5mXVXgA6zoC7fmay+M87yp+TEbcTQi6LDmWIfagGQR7jGUnbZDMbd7vWrkRhLbkcMBnhQvAuNIxUwIy4c0nGCaDFsUM/smicutf0NKahpgFTlTwMCgbtbC0uz02fVzF475uFtZow6spn0wnVj3GRkZXGSKpCKPYoY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98C6D1DB618D2B4280A33BA5CD8C0EA5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4824c3ad-026f-4969-157a-08d693697568
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:17:26.3754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2662
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMi8xNC8xOSA0OjQ3IEFNLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gd3JvdGU6DQo+IEkg
d29uZGVyIGlmIHdlIHNob3VsZCBoYXZlIGEgbGliYnRmLCB3aXRoIHRoZSBzYW1lIGxpY2Vuc2lu
ZyBhcyBsaWJicGYsDQo+IGFzLCBmb3IgaW5zdGFuY2UsIHBhaG9sZSB3b3VsZCBiZSBpbnRlcmVz
dGVkIG9ubHkgaW4gdGhlIGJ0ZiBwYXJ0cywgYmUNCj4gaXQgZW5jb2RpbmcsIGxvYWRpbmcgYW5k
IHByZXR0eSBwcmludGluZy4NCg0KSSBkb24ndCB0aGluayBpdCdzIHBvc3NpYmxlIHRvIGRvIHN1
Y2ggc3BsaXQuDQouYnRmLmV4dCBzZWN0aW9uIG9ubHkgbWFrZXMgc2Vuc2UgdG9nZXRoZXIgd2l0
aCBicGYgcHJvZy4NCg0K
