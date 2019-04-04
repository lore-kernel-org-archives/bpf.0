Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6241CC4360F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 05:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27307206C0
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 05:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I8sHOXcy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZDFMepQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfDDFDD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:03:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfDDFDD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Apr 2019 01:03:03 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x344tVfI007012;
        Wed, 3 Apr 2019 22:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uocYLg7Eqk3QpBwSfyhTqNg5LIer4wITpllcgvuLI+w=;
 b=I8sHOXcyHc4guYwis+hsSCd8/H5huQ3rJqFm6n4gzAXVJ9gH0Bwoc96AmGdV/Cw0DU+o
 hCaw80a5zKeZWqiQ4AYcMb5vA/uyrT0hHh9KanYz2djnmcJ3qoEODHmWl2gfqHRBjavO
 Ve18dif07NhSFNxwHppklxk5/++35tN4mkE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rn548926n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 22:02:38 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 22:02:37 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 22:02:36 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 22:02:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uocYLg7Eqk3QpBwSfyhTqNg5LIer4wITpllcgvuLI+w=;
 b=ZDFMepQcxIzRoiyeh5zm8qhYPHFHAm2/XNF7ZeKC4QixSCLGM6/XERWDTtkFk3vAqhaYMA8Fd3qPp1rqZBLhz1akFAt/v3dDfiSRyPL6akBwO79C9B+Zu95PBy0FifECwJsAq5+kPjNf0OedwGzx8w0LHH4TG3CbPzgrEG9vB+A=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1535.namprd15.prod.outlook.com (10.173.235.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Thu, 4 Apr 2019 05:02:35 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1750.014; Thu, 4 Apr 2019
 05:02:35 +0000
From:   Martin Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] flow_dissector: rst'ify documentation
Thread-Topic: [PATCH bpf] flow_dissector: rst'ify documentation
Thread-Index: AQHU6l94JIsPuWOfy0W3YyoGZ6C6mKYrcnkA
Date:   Thu, 4 Apr 2019 05:02:35 +0000
Message-ID: <20190404050232.57oaauyhrzb734op@kafai-mbp.dhcp.thefacebook.com>
References: <20190403205318.123125-1-sdf@google.com>
In-Reply-To: <20190403205318.123125-1-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:104:6::33) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::9119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 095acbf0-154c-48ad-67a8-08d6b8bac030
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1535;
x-ms-traffictypediagnostic: MWHPR15MB1535:
x-microsoft-antispam-prvs: <MWHPR15MB1535EE90F08CC5BE7B5AE441D5500@MWHPR15MB1535.namprd15.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(2906002)(52116002)(6916009)(53936002)(76176011)(25786009)(86362001)(99286004)(476003)(54906003)(6116002)(106356001)(256004)(46003)(6506007)(316002)(11346002)(6246003)(486006)(186003)(6486002)(8936002)(81156014)(81166006)(446003)(97736004)(5660300002)(8676002)(102836004)(6436002)(6512007)(386003)(1076003)(478600001)(68736007)(558084003)(71200400001)(105586002)(305945005)(7736002)(229853002)(14454004)(9686003)(71190400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1535;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t8Ljb44HdQ7rMz+H+xvt0IEC55GORKW3mR7GvT5omnNuA4/Wpelj550C33+D/E76f6fBtXH56roFiywtsS1F4oIYUT8zC27GdoqlR9vFYNC+iIcOJZ0sPkWwZegK2LyFPHJdefwgiJ3Zb987K5E7Soe9paFqSjsbp7zhoE1xaVPvkukIfgucU1L8Vm6ONeccpAILn5FgCOql+ZDsfb7e9l8me9HmidsLuqvbgLvseUP4jsiPq+ZNfWAOYQfAMi7CWFnmEO8vKucO501Z0E5Xyq1JIlFRkhUzOWrHmfb+7S0DJM1D0q83blWSR338WkdBh0zCWQ7wKLjZvn2jOMsBbiXahqJsUlONeIgTrPfHXY4miB3dYi4niOey/T2VK5ZmNulLsnTEJ/03G+uMqp1PCYX5VRV4XUm89o/KsQzr33U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9AB4DE07E7D034184D7ED509E437474@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 095acbf0-154c-48ad-67a8-08d6b8bac030
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 05:02:35.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1535
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 03, 2019 at 01:53:18PM -0700, Stanislav Fomichev wrote:
> Rename bpf_flow_dissector.txt to bpf_flow_dissector.rst and fix
> formatting. Also, link it from the Documentation/networking/index.rst.
Acked-by: Martin KaFai Lau <kafai@fb.com>
