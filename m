Return-Path: <SRS0=imf1=RM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDF2C43381
	for <bpf@archiver.kernel.org>; Sat,  9 Mar 2019 06:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D812081B
	for <bpf@archiver.kernel.org>; Sat,  9 Mar 2019 06:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nBBd3/ad";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aoe7DlD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbfCIGKq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 9 Mar 2019 01:10:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725681AbfCIGKq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 9 Mar 2019 01:10:46 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x29640Ld029523;
        Fri, 8 Mar 2019 22:10:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ApRpf1CJ+QwIK4F1yDmNHb3AcHnIcaJeGGpKIWo145w=;
 b=nBBd3/adpqAL5YxLZGhrQrVQcWzJQ5VfQzAkN1zrY4T3XICR5iIQamI6mjhpaIRgGJ9H
 eRRivnUNMharOt6XkQcUPrf5BkSnzBhpi9+WqhaMj+y1DA7vldjxRp6abKg92svmrFGZ
 vXENZHSUGNAlMhn0mij8OEZMrenNJxfpyEU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2r44kprgt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 08 Mar 2019 22:10:25 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 8 Mar 2019 22:10:24 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 8 Mar 2019 22:10:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApRpf1CJ+QwIK4F1yDmNHb3AcHnIcaJeGGpKIWo145w=;
 b=aoe7DlD+LqQpZFqf9A7YfaQDrwh5cDAAtmHXwLKe0rBk2DdkJig+/uDtJfbhwNq/lpjzKL1w2dRYNphO4Yx+pOpsYWFYL7ToLLja+G1DnzfCvRokZgycY8cZdJrFsQglmyN/dmtIE9RRbyo9gz2L6YJ8OmPNqtlwo5XsLpHHNMo=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1597.namprd15.prod.outlook.com (10.173.235.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Sat, 9 Mar 2019 06:10:23 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::28ff:27f2:89b9:efbe]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::28ff:27f2:89b9:efbe%4]) with mapi id 15.20.1686.020; Sat, 9 Mar 2019
 06:10:23 +0000
From:   Martin Lau <kafai@fb.com>
To:     Andrii Nakryiko <andriin@fb.com>
CC:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "tehnerd@tehnerd.com" <tehnerd@tehnerd.com>
Subject: Re: [PATCH bpf] libbpf: handle BTF parsing and loading properly
Thread-Topic: [PATCH bpf] libbpf: handle BTF parsing and loading properly
Thread-Index: AQHU1griTM/bZqtBR0KNPTqXrJwRQaYC0XYA
Date:   Sat, 9 Mar 2019 06:10:23 +0000
Message-ID: <20190309061020.fiv5vk6mh4453dkt@kafai-mbp.dhcp.thefacebook.com>
References: <20190308235820.3854596-1-andriin@fb.com>
In-Reply-To: <20190308235820.3854596-1-andriin@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:300:13d::28) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::db67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12cbbcb6-18cd-4462-4d17-08d6a455ea2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1597;
x-ms-traffictypediagnostic: MWHPR15MB1597:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1597;20:4LoL/SB6OeL9ZqVwk34JWaCQM/bLRo3RUJY7vyP6Gwiny8ss2fOtAS3eHsSkvBcWo1Evk17e91xPNV5wKwlfdwP95GEu/rWkLzh8qLmesLMGg8SvtBivw8hm3Vj0b/B/gyNDhTqvx8VZBgDzIDuol6Q4nmex6ByYVmEEvBvvtqg=
x-microsoft-antispam-prvs: <MWHPR15MB1597599AAC0082B5BC629E35D54E0@MWHPR15MB1597.namprd15.prod.outlook.com>
x-forefront-prvs: 0971922F40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(9686003)(6512007)(53936002)(99286004)(52116002)(46003)(71200400001)(71190400001)(97736004)(6486002)(14444005)(76176011)(256004)(1076003)(2906002)(5660300002)(106356001)(105586002)(446003)(102836004)(11346002)(486006)(386003)(6506007)(4744005)(6436002)(186003)(476003)(4326008)(6246003)(25786009)(6862004)(14454004)(68736007)(229853002)(316002)(478600001)(86362001)(8936002)(7736002)(6116002)(6636002)(54906003)(81166006)(81156014)(8676002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1597;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vBmv82qqQMPh0uiWcdhHeumSXj7Xt+1j/lVkC0Z5G4jEhQTLSMtpo7zD5p6KNYX2DoRh1e7vyalEPZXktv8B2O+N14yHgQCROzwv6lbklJ8EJFrwp8vJSOcPDW/Xv77FA1wUsIW8R1f9mfvNxYpG79bZkqpnwmSiQurPGVzrjCzbxHzaYFw8zQ68gmIoxrJEt7kx8g+2K1GjEmQKVG8sel7SNK/s1CwXbedVHGlNhNf489SJ7SCK8Ix2QbwxlFi4YUX7MQeO6U/Jlq06bXcVfIdaT8ZOI73M+3vu0TXIZYPIwVpYZHcARZH/8Q0b1TfPrz1CPACdmZRN4suOs8CEZCwU/6byMv8bfmzGfd2zikUvkGDeB9aL0SvpGCjx5I70g88l2JQhP4tieqQdTu4RXdEQTMn4dSbatZtl/6gA+K4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E89F90ADBD41E4D9EC3249FDA64FA33@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cbbcb6-18cd-4462-4d17-08d6a455ea2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2019 06:10:23.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1597
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-09_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 08, 2019 at 03:58:20PM -0800, Andrii Nakryiko wrote:
> This patch splits and cleans up error handling logic for loading BTF data=
.
> Previously, if BTF data was parsed successfully, but failed to load into
> kernel, we'd report nonsensical error code, instead of error returned fro=
m
> btf__load(). Now btf__new() and btf__load() are handled separately with p=
roper
> cleanup and warning reporting.
Acked-by: Martin KaFai Lau <kafai@fb.com>
