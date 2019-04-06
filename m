Return-Path: <SRS0=Rhtb=SI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F7C10F06
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 05:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2508F21855
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 05:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aCs4nsf7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="di8QtQID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfDFF6E (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 6 Apr 2019 01:58:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbfDFF6E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Apr 2019 01:58:04 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x365tJbs013681;
        Fri, 5 Apr 2019 22:57:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YiUHy61h4FwBpTASTT5Q90UFEnUUbBFeXtnVYcJBgdw=;
 b=aCs4nsf7zkCwBLb2/bVWTDN0iaW/yvybNeim94pccOetTUAgaAl/jkU5rI2bS8doSPh/
 yYrrG3MdlftyYX4gaWumOiuBgl0tVkh3zgqePtebH29DY4FKJCgKxf9xlfCxHPSrvSHp
 AZXF0e67Xef3eURy1XoUOoozRLFO0OZQlAA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rpp2cr1tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Apr 2019 22:57:38 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 5 Apr 2019 22:57:37 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 5 Apr 2019 22:57:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiUHy61h4FwBpTASTT5Q90UFEnUUbBFeXtnVYcJBgdw=;
 b=di8QtQIDubhNjP13hHEe6lY9vHd04SgonLLMbC8TOo3ZBAqJzInZSbWPfTe0IkqlOVzopvSxiBnFMhELkjC+KaJiN4FJRALk3xKXEluortqCCLbKjhQrxxeBhUVVXxIBOaQ04Zp2qn/n0yvAlL5BWAR8uz6spWW6aVcPF7alXaY=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1534.namprd15.prod.outlook.com (10.173.235.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Sat, 6 Apr 2019 05:57:22 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1750.014; Sat, 6 Apr 2019
 05:57:22 +0000
From:   Martin Lau <kafai@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>, Yonghong Song <yhs@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/16] BPF support for global data
Thread-Topic: [PATCH bpf-next v4 00/16] BPF support for global data
Thread-Index: AQHU6/KI1o6W+qh80ka0ZiskIMQCGKYuo0UA
Date:   Sat, 6 Apr 2019 05:57:22 +0000
Message-ID: <20190406055714.s6pibp6itim7vo3k@kafai-mbp.dhcp.thefacebook.com>
References: <cover.1554497408.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554497408.git.daniel@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:301:5f::37) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::63c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07dc6e39-092a-45af-a1d2-08d6ba54bc2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1534;
x-ms-traffictypediagnostic: MWHPR15MB1534:
x-microsoft-antispam-prvs: <MWHPR15MB153445C4963FBDFAAB8A1A8FD5520@MWHPR15MB1534.namprd15.prod.outlook.com>
x-forefront-prvs: 0999136621
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(189003)(199004)(6116002)(6246003)(102836004)(68736007)(8936002)(99286004)(6486002)(386003)(76176011)(6436002)(316002)(105586002)(6506007)(81156014)(446003)(8676002)(25786009)(14454004)(229853002)(46003)(6916009)(81166006)(97736004)(486006)(4326008)(53936002)(52116002)(186003)(106356001)(86362001)(54906003)(4744005)(2906002)(11346002)(1076003)(14444005)(256004)(9686003)(305945005)(71200400001)(5660300002)(7736002)(6512007)(478600001)(476003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1534;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dWpOsMmwQpbgQB1cQmk7QFutqhUfxzQo56tZ4iZbmOnBAywS5Q8YMPQlQJVEJGngvPjpbUkEeJAvaze8xYe9UtbLlZbsB3mo/3HWQ6BGaoHJyEvWT2ZzDjtKCqHwH48r6c5DubTgHFYzvabMIn2AZqpfXWriTuNuqdMkFPH3/vYebHqjk4F5dSlmYR2SxOC9fRIfeL0W3AafLRKEsjFrjoHyd5JXO4IsiF4P1sTiPE0fdpkzT4B68E6whpW6aYYlOpvnqX3Yj7GdOGwlFFuAXd5t1cWyi+0mYj3BsGdQEuIJLW2Y3jwKHH0XmJFlQV2xkJYIvekspqV0DyP8YplHf2Zj1amZE9cxVqVfCO410S9m62X4xfGeck7tg/L6Noe0l2Af0PiZDxiA03oDoBkClua/n1vuiFthvg4a7WHI5R8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82472CFF18E2874A88E04597E41981F3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dc6e39-092a-45af-a1d2-08d6ba54bc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2019 05:57:22.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1534
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-06_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 05, 2019 at 10:59:26PM +0200, Daniel Borkmann wrote:
> This series is a major rework of previously submitted libbpf
> patches [0] in order to add global data support for BPF. The
> kernel has been extended to add proper infrastructure that allows
> for full .bss/.data/.rodata sections on BPF loader side based
> upon feedback from LPC discussions [1]. Latter support is then
> also added into libbpf in this series which allows for more
> natural C-like programming of BPF programs. For more information
> on loader, please refer to 'bpf, libbpf: support global data/bss/
> rodata sections' patch in this series.
Finished reviewing.

Acked-by: Martin KaFai Lau <kafai@fb.com>
