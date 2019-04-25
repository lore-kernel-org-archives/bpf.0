Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65437C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B2A206C0
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 15:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jUJyC+jc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ATqZAvf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfDYPjF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:39:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48284 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfDYPjE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 11:39:04 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PFbrQr014296;
        Thu, 25 Apr 2019 08:38:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=E91U8Z2Dks8oApr+K7l4U09vWrHpunjtodU3K3kvNT0=;
 b=jUJyC+jcA1TEB9JhcRvnT/hIhcaE78Sgqb0xh+ThYOycQPMzS1XqlTAYZzPUjYQJaJLR
 9xOxtsWppoaPDqkbacJP9iHVFUr5azV6vsZIifI0NJWc0yszKF0LdKZ1qJIpPyAodAvl
 a+na/6ZlWGVZ/PFfhj7OayCnqJbd8v32dvw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3f6hg4ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Apr 2019 08:38:43 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 25 Apr 2019 08:38:42 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Apr 2019 08:38:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E91U8Z2Dks8oApr+K7l4U09vWrHpunjtodU3K3kvNT0=;
 b=ATqZAvf9sEcJ8YH52CLSnzKaan2mVPFPS/sYF9dTgWEqUZivdf1gnAZfY6RgL3l+P/H9MfxZKzykzVdpwMbscMzq0ztSTc4811dToeFkrflOBdhUamWCMEL9VZlZ8ZkdAq5WsgBK2mBd4Pizw18RBdW5n/Rz4dGQisYIAQkz80Y=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2261.namprd15.prod.outlook.com (52.135.197.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Thu, 25 Apr 2019 15:38:40 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 15:38:40 +0000
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
Subject: Re: [PATCH v2 bpf-next 2/3] bpftool/docs: add btf sub-command
 documentation
Thread-Topic: [PATCH v2 bpf-next 2/3] bpftool/docs: add btf sub-command
 documentation
Thread-Index: AQHU+yUSaOLwpF/Nlkei+ZKytYugKqZNA5MA
Date:   Thu, 25 Apr 2019 15:38:40 +0000
Message-ID: <e1d02ba8-a7fd-3af1-4a87-ac8d5ea1efae@fb.com>
References: <20190425050355.1359736-1-andrii.nakryiko@gmail.com>
 <20190425050355.1359736-3-andrii.nakryiko@gmail.com>
In-Reply-To: <20190425050355.1359736-3-andrii.nakryiko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0085.namprd19.prod.outlook.com
 (2603:10b6:320:1f::23) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:a55d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fb13834-be74-4652-7fb5-08d6c994171b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2261;
x-ms-traffictypediagnostic: BYAPR15MB2261:
x-microsoft-antispam-prvs: <BYAPR15MB22612C33382F2EE354942330D33D0@BYAPR15MB2261.namprd15.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(31696002)(305945005)(7736002)(71190400001)(71200400001)(46003)(25786009)(8676002)(229853002)(31686004)(4744005)(14454004)(8936002)(6116002)(81156014)(68736007)(2201001)(2906002)(6246003)(81166006)(86362001)(5660300002)(4326008)(2501003)(6436002)(256004)(97736004)(64756008)(66556008)(110136005)(54906003)(73956011)(66476007)(66946007)(6512007)(99286004)(478600001)(36756003)(316002)(76176011)(386003)(52116002)(53546011)(102836004)(446003)(11346002)(476003)(486006)(2616005)(53936002)(186003)(6506007)(66446008)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2261;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KQaFvOu/igrNshGEyHFV43FSO1QINWYCV1M4R9S3UA6TuBFxXInmT3HpohX4IB2XOKwEcC5l8qs5bqQkjWmqj/4Juvb3D9AXI+7Q8qT6B5SL93ZzxUYROY3rRflR+1DU62in4fNWYqkTEkfEtfsDelmPc6h0e+szSUpKdhCsEjOjiO3PUCqdxa/8QaVUEqTK2ySSc71s3HH3Z4Jsf6/z+ANG9L9MldlJYD8clz22can42z0ulmJta8vW9G78dK+c7LkCrUBo2IgTPAkmJFBJe3iOVCFpoJFDQB6zcmaxn5Q9CYupxybN8KoSENun2yWhNqxkQ5QBQJMrU3V0htlZLZ0Lea9oDloT1R/39T+woECajQy7EwEnMHDWJYBWkndkL00SxBXLWm743bAYH0I/MiHvikLtzsb20LlHwXDRoEc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08670498D337644592FF674EA1D3E59D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb13834-be74-4652-7fb5-08d6c994171b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 15:38:40.7180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2261
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
DQo+IEZyb206IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpbkBmYi5jb20+DQo+IA0KPiBEb2N1bWVu
dCB1c2FnZSBhbmQgc2FtcGxlIG91dHB1dCBmb3JtYXQgZm9yIGBidGYgZHVtcGAgc3ViLWNvbW1h
bmQuDQo+IA0KPiBDYzogRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4NCj4g
Q2M6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGZiLmNvbT4NCj4gQ2M6IFlvbmdob25nIFNvbmcg
PHloc0BmYi5jb20+DQo+IENjOiBNYXJ0aW4gS2FGYWkgTGF1IDxrYWZhaUBmYi5jb20+DQo+IENj
OiBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPg0KPiBDYzogQXJuYWxkbyBDYXJ2YWxo
byBkZSBNZWxvIDxhY21lQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJpaSBOYWty
eWlrbyA8YW5kcmlpbkBmYi5jb20+DQoNCkFja2VkLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIu
Y29tPg0K
