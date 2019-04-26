Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA5FC43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 03:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CBC206DD
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 03:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AbC6wBtw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LVBzpzHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfDZDeb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:34:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbfDZDeb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 23:34:31 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q3RKgx030135;
        Thu, 25 Apr 2019 20:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=elayj4RqSfcWPzKYmuZ8YP8ClTxPab6n/mFtPCTCOig=;
 b=AbC6wBtw5Jjh0oSsCOaSMjuEJwU1tQ1o9fPlnubqBf2ipN8N/q+9EHPAzW/lV2Zj2ChB
 9xtSJMnMV9RZRk9S+p1BXajW1HvLIUg7Fv5v1G1YPAU3tcqcJ54iXapHe+A/9bbX42VN
 H64CYxyxVrBKNEwjkQgmMR/xJCpwyNmb8uA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2s3mmah117-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Apr 2019 20:34:25 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Apr 2019 20:34:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Apr 2019 20:34:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elayj4RqSfcWPzKYmuZ8YP8ClTxPab6n/mFtPCTCOig=;
 b=LVBzpzHK7ZEB/lfwrkbDr0qmDrfoqifI6cZ96Cm4c0F2FWU8wVBNrXZWNXgVo8b5UoxIjHMcIU1KVUjKI98FqDuWCJ2rPYhjz2gn4bqfR1lYiS0F9vio/FHy7KK9HQnNIq5ESopW87VKsz8NnMsP5CcJXdkwwwgW62SL8xzy3bA=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3014.namprd15.prod.outlook.com (20.178.238.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 03:34:23 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 03:34:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: [LSF/MM TOPIC] [BPF] Auto-detachment of bpf programs on cgroup
 removal
Thread-Topic: [LSF/MM TOPIC] [BPF] Auto-detachment of bpf programs on cgroup
 removal
Thread-Index: AQHU++DwsKTC+NDa5k2cKTPQ8VdQQQ==
Date:   Fri, 26 Apr 2019 03:34:22 +0000
Message-ID: <20190426033415.GA6680@castle.DHCP.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0031.namprd15.prod.outlook.com
 (2603:10b6:300:ad::17) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::20e9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e57e4290-7b3d-40ce-992a-08d6c9f812d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3014;
x-ms-traffictypediagnostic: BYAPR15MB3014:
x-microsoft-antispam-prvs: <BYAPR15MB30148A58481FA9DD18C501DDBE3E0@BYAPR15MB3014.namprd15.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(7736002)(2906002)(6486002)(71200400001)(8676002)(8936002)(81166006)(5640700003)(6436002)(9686003)(6512007)(97736004)(33656002)(478600001)(81156014)(52116002)(99286004)(25786009)(6506007)(186003)(386003)(68736007)(102836004)(316002)(66946007)(4326008)(66446008)(64756008)(66476007)(2501003)(1076003)(73956011)(5660300002)(66556008)(14444005)(6116002)(6916009)(71190400001)(476003)(2351001)(86362001)(53936002)(305945005)(256004)(486006)(5024004)(46003)(14454004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3014;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zPOqSUP+1rec3PGey+KlZALJmtDlnEOK9QSwGnLiaCy5eJBHrjr/LTq64qfIhNeNuFCRsSGQIP6a+Qs7f6MJ+Wfj2SWMMlDZh+jqr55SPi/YU3Fu9s747F5PCbhEnAKooL6wB6/7T4GwoM9fAlBJnVxEhVbqDGemdvJlWS6pc/MnKj5/oJ52FEoAQjs1Vl1c1Pamcf+6g4sRO+1Ls1eIQc4fYk7BPrnS7qMiobx9bBykzZa9usoY2lBlDlUfkddtnzi5BsL76t4U3ZDTSmq4v4l9XVeayfF9xUmLnrN5SAlTz1xRr0jrS5Mnv4xeNB5yWbFpncPlSJqNJNlhFMAMHYuDQ5AL5ldOoKmAl4lEYsPc5N4q5M7WyHLkWGasHaZNy/JcxyABW8TJTrktPx98XpRqjw78Qr3SGX542igK+AA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E48880E8279F84418C8464A630E9C6C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e57e4290-7b3d-40ce-992a-08d6c9f812d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 03:34:22.7883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3014
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=647 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260024
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently a bpf programs attached to a cgroup stays attached after removal
of the cgroup. The goal of such design was to allow capturing and handling
events which are happening with a cgroup after being deleted by a user.
For example, an active socket can belong to a dying cgroup, and generally
we want to be able to handle it with cgroup-bpf programs. Some program type=
s
(e.g. device control) have no chances to be executed after cgroup deletion.

This ability doesn't come for free, and there is a couple of related issues=
,
which we're facing in our production.

I. Sometimes we do accumulate a large number of dying cgroups, and if each
of them is holding few attached bpf programs with their maps, cgroup storag=
es,
etc, it's just a large waste of memory. The reason why sometimes we do
accumulate dying cgroups is a separate topic, which is planned to be discus=
sed
on LSF/MM.

Currently we're solving this problem by detaching programs from userspace
before cgroup removal. It usually works, but in some cases it fails
(e.g. is userspace crashes) and we end up with many loaded bpf programs
wasting the memory.

II. It makes challenging the implementation of memcg memory accounting for =
bpf
objects. The problem is that any charged object is holding a reference to
the corresponding memcg, memcg obviously keeps the cgroup in place,
and cgroup is holding a reference to the bpf program, which underlying memo=
ry
is potentially charged to the memcg. So it's a circular reference.

So the question I'd like to discuss is if we can detach bpf programs
automatically on cgroup removal (or at some arbitrary point afterwards),
without waiting for the whole cgroup to be released? Do we need a fine-grai=
ned
mechanism to detect if a bpf program has any chances to be executed for
every program/attach type, or there are simpler solution? Do we really
need an ability to execute bpf programs attached to dying cgroups?

Solving this problem is essential for implementing of a proper memcg-based
memory accounting for bpf objects, which can be a significant improvement
(or addition) over the existing memlock rlimit-based accounting.
