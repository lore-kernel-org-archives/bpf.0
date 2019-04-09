Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC1C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3962084B
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 20:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GuwEaEV7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f8I/u/0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDIUu2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:50:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48654 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbfDIUu2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Apr 2019 16:50:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39Ko27i002128;
        Tue, 9 Apr 2019 13:50:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7fwmMTiDsqqCdLxmc70RKXBRv/Gb7Z5WQYJHsy7PEyw=;
 b=GuwEaEV7G363RSxgqXatqhgd2+7CDdrCup7YFZdgYNFajoCby6wcJpVJ3RCD0AlQ1XT5
 n4NFR6bGHSELvTyH0JkXpVexB2e3jEsu9F8bNiObdJVFy2hwCBH8HD4KPGpTZ+bE3mQy
 59hnbrrOS3T/9Yb4PPRqRE2SkmjWzoMN9Uc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrynxrv70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 13:50:03 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 13:50:03 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 13:50:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fwmMTiDsqqCdLxmc70RKXBRv/Gb7Z5WQYJHsy7PEyw=;
 b=f8I/u/0ofQqUXpa0UrlWLNi0o15ULjMKqhrVR16B/fqEGO2lUVYrlmfti80ZDEMArG4s7DznpeSo/kpPDF15kzKMyvvuatfdq9e4RjO22FGv2+dxY6itfV0YvUPPoLxy4FAEMXAo65Z/rEjXpMVhT3MtKKY8f394RQe6/45aqE0=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1486.namprd15.prod.outlook.com (10.173.235.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 20:50:01 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 20:50:01 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Topic: [PATCH bpf-next v4 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Thread-Index: AQHU7wT5Gl8oMT/IrU21ycO0HKdZLaY0TYcA
Date:   Tue, 9 Apr 2019 20:50:01 +0000
Message-ID: <20190409204954.z567zman56o3yzsg@kafai-mbp.dhcp.thefacebook.com>
References: <20190409184911.97485-1-sdf@google.com>
In-Reply-To: <20190409184911.97485-1-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:300:4b::20) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:8cf5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7ebc67e-1e2a-4a4c-5c68-08d6bd2cef00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1486;
x-ms-traffictypediagnostic: MWHPR15MB1486:
x-microsoft-antispam-prvs: <MWHPR15MB14869763EDAA770D6790F447D52D0@MWHPR15MB1486.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(71190400001)(446003)(476003)(53936002)(97736004)(14454004)(102836004)(46003)(6486002)(6506007)(11346002)(386003)(76176011)(186003)(4326008)(1076003)(86362001)(71200400001)(6246003)(478600001)(558084003)(316002)(6116002)(54906003)(25786009)(52116002)(9686003)(81166006)(7736002)(81156014)(8936002)(6512007)(229853002)(6436002)(6916009)(305945005)(68736007)(105586002)(8676002)(99286004)(2906002)(106356001)(256004)(5660300002)(486006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1486;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XWM9IkoB6OZUJ67nnOmq+ah3nQd7OiztwfZdS47F6OoparMd+MCatp09bKiIdNGZ+D33Fu4X+Dy1CIyiVnvO7LWQ55oHyzcTNsC3fZcrDgdRsp6VJXMFhB61j2bho5YpbIId7fuamkjPVJ+Es+A4GwhV7e3aZvVZyYtMdOWBBOy8Dj9rKZBC4tK0Yw2SI96KyHudwYeTFsaXDaqFQgTowhKkabB+0g85m57Hy3vTiICKXC7RlNd/i+lPmKiUcwRZSLMMr8+vgTks6kYtMCJoT5tcD1os5+jPZWUQZKX7Mef1meTLRQM8DTPRNj6J+PmArVWCbaMeGNJLBi2dV3OxyaXs5skQSkQZZEpgcGdoOEc5EuPobnNljxFAD+RNOIaqPVKN8TbqoPpte5nNbFjqQJVYGnWWGkh4q+UeFDdHlwI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB612F3ACC45794889D11B25BC5EBBD7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ebc67e-1e2a-4a4c-5c68-08d6bd2cef00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 20:50:01.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1486
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 09, 2019 at 11:49:09AM -0700, Stanislav Fomichev wrote:
> Add new set of arguments to bpf_attr for BPF_PROG_TEST_RUN:
> * ctx_in/ctx_size_in - input context
> * ctx_out/ctx_size_out - output context
Acked-by: Martin KaFai Lau <kafai@fb.com>
