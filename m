Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6DFC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC53218D3
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iI031A7A";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="T/T4Q+su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfCOQw0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:52:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728297AbfCOQw0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Mar 2019 12:52:26 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FGnokV012193;
        Fri, 15 Mar 2019 09:52:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8DCJ2Qeo9WksxFi/Oo5hZ8t5nMzSf10hwu7ypfVaEck=;
 b=iI031A7AoKDYe4ahLRnpIse5mYK1J7glnuUitR8FHvqgdSLH8i+8DzHOSfP5IZy6PjEX
 ti5AT37v3P8jtdB0iDKVcRjMST83CtDMyU6FK0UpcGZVhkntNA8DPeVJULKFXEk9aB0I
 a+488iDsAhunYSkGFe1dh5oV1s1fn91BpUU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r889phmgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Mar 2019 09:52:00 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 15 Mar 2019 09:51:58 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 15 Mar 2019 09:51:58 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 15 Mar 2019 09:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DCJ2Qeo9WksxFi/Oo5hZ8t5nMzSf10hwu7ypfVaEck=;
 b=T/T4Q+sutaviDZSgGLzTfgGo7sQbfRxLaU7Vc6zqLRrUCm9jLu2qCXzUk3MfYlD/J8jDZpNw6a9eNS1Z4x9Evt3I8xbuUBG39WM56yyT4nuZAJ/T1hnRr3YRN9fGF/mz5+buoxlx4/wDwRokyt8Ky9ZSHkS9bdFOcZLzlNoP1rM=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 16:51:56 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::28ff:27f2:89b9:efbe]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::28ff:27f2:89b9:efbe%4]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 16:51:56 +0000
From:   Martin Lau <kafai@fb.com>
To:     Peter Oskolkov <posk@google.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Lawrence Brakmo <brakmo@fb.com>, Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH bpf] bpf: make bpf_skb_ecn_set_ce callable from
 BPF_PROG_TYPE_SCHED_ACT
Thread-Topic: [PATCH bpf] bpf: make bpf_skb_ecn_set_ce callable from
 BPF_PROG_TYPE_SCHED_ACT
Thread-Index: AQHU2sYzRrZnImOQB0G568XOm+1JmqYM6TuA
Date:   Fri, 15 Mar 2019 16:51:56 +0000
Message-ID: <20190315165153.sostcwsrzkj4luff@kafai-mbp.dhcp.thefacebook.com>
References: <20190315002858.228416-1-posk@google.com>
In-Reply-To: <20190315002858.228416-1-posk@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0016.namprd17.prod.outlook.com
 (2603:10b6:301:14::26) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::be6f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c7dd2a3-17f0-4cea-79fc-08d6a9668848
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1134;
x-ms-traffictypediagnostic: MWHPR15MB1134:
x-microsoft-antispam-prvs: <MWHPR15MB11341085918E46348B4B7C7AD5440@MWHPR15MB1134.namprd15.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(71190400001)(71200400001)(486006)(476003)(99286004)(256004)(4326008)(25786009)(5660300002)(1076003)(6506007)(102836004)(76176011)(52116002)(386003)(558084003)(6246003)(7736002)(81156014)(8936002)(305945005)(8676002)(81166006)(68736007)(53936002)(106356001)(14454004)(6512007)(316002)(478600001)(86362001)(97736004)(54906003)(2906002)(9686003)(6116002)(6916009)(186003)(446003)(11346002)(46003)(229853002)(105586002)(6486002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1134;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mhrvd9Yk7r8lTUCykf36jva6q0sXFgOjKtQbhlYiZFc8QN7GN82kHumaR0sXrvGFFbiugRuz57CVwEYzal1+u3goFCgHEjpTXfGNWsTWjJjOl2lk+iJre7MHkQO7eHia57bFaOkrSyZWfpaIGdeAHomhAVj8myfjCv2YvW7umb7UlHTzlT//d0gnlkjHaZr1rMEze24EssSmfJXnPOJT6+nw68auMRmI47EREaVGNFsTK3dmamomd7NLggY4On1ZMpPhR2YM3YEV7rMcRYoz5GGnQQloqM7Pq+eeNJ5gojZ8/gkaXPFniE7oKeTnKzNwX+lAk8wbMkQ+MgjPVHPZ/1cZAja3GKeqWT8mRCR37lcbWX5gV2/w8ehJDvClaDyg/gF5A5r8nhqR4ttrNhTx4aai0H4rTazGYiuuJRwqSjM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2304C70973243B42B03DBA2DAC45E340@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7dd2a3-17f0-4cea-79fc-08d6a9668848
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 16:51:56.4889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1134
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 14, 2019 at 05:28:58PM -0700, Peter Oskolkov wrote:
> This helper is useful if a bpf tc filter sets skb->tstamp.
>=20
For the patch,
Acked-by: Martin KaFai Lau <kafai@fb.com>

Not sure if it should belong to bpf-next material though.
