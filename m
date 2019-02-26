Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CDC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 06:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9035A213A2
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 06:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rb5Tynjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfBZGq3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:46:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37892 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBZGq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Feb 2019 01:46:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1Q6ix7u128921;
        Tue, 26 Feb 2019 06:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=as0xw3J2SisAwFLxS+XDEczbUfHeBVp+TQYJFLOqkvQ=;
 b=rb5Tynjmm65RfjEFAIwIr/rmJqVvIOl3wXIIZy1z/TVFkvPaG/C3hMMz59MFqmXjLLUg
 iCxmXFyO4efgMbjgY42QdELl3kBgpc5ECymEG8sxZR5KzppWm39uNq5pQx9+9kcXpgkN
 2PfxFqQj9KUkZp/ZkrWc0UMTC70li7sISJq4Jgc9S8Fby8chxhZImWmZRsicxutGZkHT
 9aDisINl/5jp1/O6paZ2aQqQVDBzkTSigLvmIHhlxWjuqN3zxxuWGCiTD14mdFSB+tlV
 sDyw7qv0q5sNm1GV/yCOmk7yQFprcuoGESrTYsZI2irF0Tbavz+OhSXftchjmblVopOZ ag== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qtupe2ucw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 06:46:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1Q6k3ud007829
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 06:46:03 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1Q6k36Y031530;
        Tue, 26 Feb 2019 06:46:03 GMT
Received: from localhost (/10.159.211.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Feb 2019 22:46:03 -0800
Date:   Tue, 26 Feb 2019 01:46:01 -0500
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kris Van Hees <kris.van.hees@oracle.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH 0/2] bpf: context casting for tail call and gtrace prog
 type
Message-ID: <20190226064601.GE16689@oracle.com>
References: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
 <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260051
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 10:18:25PM -0800, Alexei Starovoitov wrote:
> On Mon, Feb 25, 2019 at 07:54:13AM -0800, Kris Van Hees wrote:
> > 
> > The goal is to further extend the BPF_PROG_TYPE_GTRACE implementation to
> > support what tracers commonly need, and I am also looking at ways to further
> > extend this model to allow more tracer-specific features as well without the
> > need for adding a BPF program types for every tracer.
> 
> It seems by themselves the patches don't provide any new functionality,
> but instead look like plumbing to call external code.

The patches are definitely not plumbing to call external code, and if I gave
that impression I apologise.  I overlooked the information you quote below on
allowing new functionality through modules when I wrote the comment above but
please note that it was a forward-looking comment in terms of what could be
done - not a reason for the patches that I submitted.

The patches accomplish something that is totally independent from that: they
make it possible for existing events that execute BPF programs when triggered
to transfer control to a BPF program with a more rich context.  The first
patch makes such a transfer possible (using tail-call combined with converting
the context to the new program type), and the second patch provides one such
program type (generic trace).  The new functionality provided by the program
type is direct access to task information that previously could only be
obtained through helper calls.  E.g. the new program type allows programs to
access the task state, prio, ppid, euid, and egid.  None of those pieces of
information can currently be obtained unless you start poking around in
memory using bpf_probe_read() helper calls.

> This is no-go.
> There were several attempts to do so in the past, so we documented it here:
> Documentation/bpf/bpf_design_QA.rst
> Q: New functionality via kernel modules?
> ----------------------------------------
> Q: Can BPF functionality such as new program or map types, new
> helpers, etc be added out of kernel module code?
> 
> A: NO.
> 
> The answer is still the same.

Thanks for pointing this out - but again, my reference to modules was merely
musing about the possibilities.  This information clearly closes the door on
that train of thought, but that is not directly related to what I am doing
with the patches I submitted.

	Kris
