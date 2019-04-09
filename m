Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40CAC282CE
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F342077C
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nTnn3mnm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Sz00hqe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDIS2k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:28:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39642 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbfDIS2k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Apr 2019 14:28:40 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39IJ7Db003177;
        Tue, 9 Apr 2019 11:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6E2J6y7utMqa40rfRCA2/KWaGMybpziu6D5ICeXBxDQ=;
 b=nTnn3mnmf/rvvsZlQ/5b46qYNQzFhk6MFXk3cXajL2R0OXm7XjlstJLPKs/sTTNzhvKS
 MCyrfdWQbniT6P+EXqGydvjtegYIYZuuoz2FVFPAVr2voHh4z981XXTteeo4CqprX/x6
 zkLKiNnV3IxoQF/bSr78iZ34VPrRfW4r4Yw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrynxra5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:28:14 -0700
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:28:14 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:28:14 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 11:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E2J6y7utMqa40rfRCA2/KWaGMybpziu6D5ICeXBxDQ=;
 b=Sz00hqe+r3Jd/ALJVti6hCiATlBFiTtx0nCRgPU/gqEtVHhxYtOkNnhDmJ0Zn2kSL5YfWUV03POIcRnEMqCCKmfxKEJ8r9geDh8qvRJIk6WL4t7n1h5RvdJU2OUeMauxFfMZcUB9VvvnAxKYybG2JY0jVlVNlRIIj73fIQPggM0=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1440.namprd15.prod.outlook.com (10.173.234.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 18:28:12 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 18:28:12 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: add support for
 ctx_{size,}_{in,out} in BPF_PROG_TEST_RUN
Thread-Topic: [PATCH bpf-next v3 2/3] libbpf: add support for
 ctx_{size,}_{in,out} in BPF_PROG_TEST_RUN
Thread-Index: AQHU7vmb5v1YtkPwsUC62e3YncnAiaY0Jf8A
Date:   Tue, 9 Apr 2019 18:28:12 +0000
Message-ID: <20190409182806.m4iyakipfjkz7bbx@kafai-mbp>
References: <20190409172739.242389-1-sdf@google.com>
 <20190409172739.242389-2-sdf@google.com>
In-Reply-To: <20190409172739.242389-2-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::8c82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5de7356a-7426-4fc9-45de-08d6bd191f7f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1440;
x-ms-traffictypediagnostic: MWHPR15MB1440:
x-microsoft-antispam-prvs: <MWHPR15MB144013E1A13F1FA0F872E5B4D52D0@MWHPR15MB1440.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(5660300002)(102836004)(106356001)(4326008)(97736004)(52116002)(305945005)(8676002)(186003)(25786009)(86362001)(8936002)(6506007)(105586002)(256004)(316002)(6436002)(9686003)(6512007)(53936002)(386003)(7736002)(81156014)(229853002)(71190400001)(99286004)(71200400001)(558084003)(81166006)(6916009)(68736007)(33716001)(1076003)(11346002)(478600001)(46003)(2906002)(76176011)(486006)(476003)(6116002)(446003)(6486002)(14454004)(6246003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1440;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uSxqhkLZs97XiE+HohM35ltHNF1O9c266jrDgUOyXpT+papKUUnA6nJ5i2EKkIfLgMPigo0rHgfbAGlfxCEtkeCRfLqKzk0i0JRsXRtvq8hBiGa7OWrtn84fu5uqIkWQbdvgk6JuXiK4LtIAx7zbT9EK56z4aXNs2xs1Mkk9qdWt/aHXG4g/nc39I4q2GOTHgdK90BgN0DhYEzlmPy27otyDVyQ30DjbJldZN/+OO8Ad3bktKqGRLXflg7MWsoP/bryDNrzWxtI0YNEbIex7yo04yEPyRdkFyG03VV59qu+jstQ/XmwXDA7sgBSfGle+FrIzOE+0r0Tz2y0j+a9h1b2kTDAFuZFce0Ls1sAoLLpPs3oyTW1ySJXSfbj5cMs6h1zkmvJigEYMMuJ1sSmfZ054iqQBtH9unTSzsxAmKJ8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35494D29C590DC43B3A62D2787C9E1CE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de7356a-7426-4fc9-45de-08d6bd191f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 18:28:12.2202
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

On Tue, Apr 09, 2019 at 10:27:38AM -0700, Stanislav Fomichev wrote:
> Support recently introduced input/output context for test runs.
> We extend only bpf_prog_test_run_xattr. bpf_prog_test_run is
> unextendable and left as is.
Acked-by: Martin KaFai Lau <kafai@fb.com>
