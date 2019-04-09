Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC1C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9A2084F
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Wn1zbMWL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="L3Nbbb0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDIS3p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:29:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48362 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbfDIS3p (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Apr 2019 14:29:45 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39IOl8B022704;
        Tue, 9 Apr 2019 11:29:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Hg8i5LdDTfZmN/p7VwLAg6XtJ311JbOjneQ6cS43juo=;
 b=Wn1zbMWLoLoDp2EqWl0mQ5xADWYSYlHqbcXwUWh4ipmyHdaCaiuYY6FumqHhRg4k5skP
 RteYCYXPgqfXgJvJMvS8207n/y6VVPhvkYCmWcjBjplliMNr0FDbmf+RFid6K4gsWzX1
 yw2LHZJL1pXbUT8om4w5vflRph2uacRnt8k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rs0nb80k7-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:29:22 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:29:09 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 11:29:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg8i5LdDTfZmN/p7VwLAg6XtJ311JbOjneQ6cS43juo=;
 b=L3Nbbb0LCsIIV5NsC/pL5kQ4+1Pi+gh40rcmkMGE1QYMIn7pRdCVWfNUFVSyOufQKxxW27TgUiuJMtogdeVmfu5nwcCpe5+ZfA3EbN7HqdGzH+Q9npQmJsmGOUyEqFXQtcMUMMqpZPfmfBdsqMGsCwpj1Hi5u35uNYpTa6END1A=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1440.namprd15.prod.outlook.com (10.173.234.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 18:29:07 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 18:29:07 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 3/3] selftests: bpf: add selftest for
 __sk_buff context in BPF_PROG_TEST_RUN
Thread-Topic: [PATCH bpf-next v3 3/3] selftests: bpf: add selftest for
 __sk_buff context in BPF_PROG_TEST_RUN
Thread-Index: AQHU7vmWlNf/WxLMyU6xcMTkJJNS0KY0JkcA
Date:   Tue, 9 Apr 2019 18:29:07 +0000
Message-ID: <20190409182906.htjo7u3vmuo2sawu@kafai-mbp>
References: <20190409172739.242389-1-sdf@google.com>
 <20190409172739.242389-3-sdf@google.com>
In-Reply-To: <20190409172739.242389-3-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:300:94::25) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::8c82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d7ce8da-9c7b-4d43-e140-08d6bd19406c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1440;
x-ms-traffictypediagnostic: MWHPR15MB1440:
x-microsoft-antispam-prvs: <MWHPR15MB1440A06753F1976CA7653BF6D52D0@MWHPR15MB1440.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(5660300002)(102836004)(106356001)(4326008)(97736004)(52116002)(305945005)(8676002)(186003)(25786009)(86362001)(8936002)(6506007)(105586002)(256004)(316002)(6436002)(9686003)(6512007)(53936002)(386003)(7736002)(81156014)(229853002)(71190400001)(99286004)(71200400001)(81166006)(6916009)(68736007)(33716001)(4744005)(1076003)(11346002)(478600001)(46003)(2906002)(76176011)(486006)(476003)(6116002)(446003)(6486002)(14454004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1440;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v/t28UpTKs7FHnuSmIDHjoWdBiHNPPwRiY/uFHbYwN1ZpjX4ohfe1Jmpz4YaQ6jOcIoP5NHLPse5gdfuU1W2q4Jf8com3ijIBRCrf13JmUBiDH4mBEiRcKTe3TzcyjSV+TYFgjUvQdB2UwOKzJvHm52HfEmIZV2Cf/SsAwhkpC7cWw6ViYsRlen6hCT9mTP+uT4FdGPbCJghyXA15w3rlpQhIXf5wqY+Ovd4CHk5eM7L0HIgszrp1njMNFLXXi4AeDQsY8pltYmHHYvvpSeIlhURjXSDQ8C7FUB9XnWGOz0HfcSOoRdZogSbEFWFWcY0YQeKaiZsMlCVC+SE9mPqngfQoZ0UfSzqvGTFU+LRu2LMm1ui4NBjJhSueMhKN20um+0dK6ca5ZmOg/vS0G4CJh0OsMhmhSyPufpV3XX8220=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29FE0A858AA49046846496AC875FDE71@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7ce8da-9c7b-4d43-e140-08d6bd19406c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 18:29:07.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1440
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 09, 2019 at 10:27:39AM -0700, Stanislav Fomichev wrote:
> Simple test that sets cb to {1,2,3,4,5} and priority to 6, runs bpf
> program that fails if cb is not what we expect and increments cb[i] and
> priority. When the test finishes, we check that cb is now {2,3,4,5,6}
> and priority is 7.
>=20
> We also test the sanity checks:
> * ctx_in is provided, but ctx_size_in is zero (same for
>   ctx_out/ctx_size_out)
> * unexpected non-zero fields in __sk_buff return EINVAL
Acked-by: Martin KaFai Lau <kafai@fb.com>
