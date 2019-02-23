Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41FEC43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 04:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89D32084F
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 04:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2VePbyId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfBWEY0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 23:24:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWEY0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 23:24:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1N4J1aX072353;
        Sat, 23 Feb 2019 04:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=vtODrFGYTG5WleGG1y4TSNo/Fd2O8gtzcokaVN2QwRU=;
 b=2VePbyIdOhEJ2DwHWSPcLRNjBKw2Q3gVNNcQee+wzBANdXYBm3oXX1lL1PIs//TQP2z9
 /4BRBQ1QM7TsEXRobeBiye0cqNSjPRBuVGIIikf2SwbxaV2Mr9YUb91njnVAtEPjkUF6
 wv7+Ke9/Ty/eE2b6uIKIyYy1Sx996z394lderZ4+/GGvmgQlsrI3EHRW/OxzNKDQav6K
 BCu3QKVw0R2BzlkGqQQc7p/vhePkYNsvn/ZozskHim78N3f7wZFMWT+ciG3BrnULZJVM
 c/XeuQiYxsWPxmoBBfGDF1qXwL8YwnpdXFgxryiNDxMql+dE45X0d2SKZ0xlNmVIwuZh uw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qtxtr80k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Feb 2019 04:24:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1N4OMR5029345
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Feb 2019 04:24:23 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1N4OMma015719;
        Sat, 23 Feb 2019 04:24:22 GMT
Received: from localhost (/10.159.211.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2019 20:24:22 -0800
Date:   Fri, 22 Feb 2019 23:24:12 -0500
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [LSF/MM TOPIC] BPF: Extending eBPF as a generic tracing engine
Message-ID: <20190223042412.GV25582@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9175 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=858 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902230028
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Topic: Extending eBPF as a generic tracing engine

My presentation covers a few new features to the eBPF implementation in
support of tracing tools.  The main goal is to allow tracing tools the
ability to encode actions with probes/events, beyond the context of what
the current probes/events provide.

The features to discuss are:

    - Allowing BPF-to-BPF tail-calling between BPF programs of different
      program types (ussing a context conversion/casting mechanism that
      BPF program types can provide.  This patch is being posted to the
      netdev group this weekend, along with an example on how to use it.
    - Using the context conversion mechanism to associate task info with
      probe/event context, and have a BPF program operate on that, which
      reduces the dependency (or need) for helper functions.
    - Consider the option of having BPF program sub-types (for some program
      types), which could even provide for loadable modules to implement
      some specific extensions to a more generic BPF program type.
    - Extending the context handling code and access checking to allow
      for pointer references to auxilliary structs (to an arbitrary depth).
      This makes it possible to do a lot more with contexts, such as
      having it store a pointer to a trace output buffer so you can have
      BPF instructions store to it directly.

The talk will focus on why this will help tracing a lot, and how it will
advance BPF as a tracing facility.  I want to solicit feedback on these
features so there can be common road forward to enhancing tracing based on
BPF.
