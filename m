Return-Path: <SRS0=RxXm=XG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48CBECDE20
	for <bpf@archiver.kernel.org>; Wed, 11 Sep 2019 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11B92085B
	for <bpf@archiver.kernel.org>; Wed, 11 Sep 2019 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfIKISE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:18:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57630 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfIKISE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Sep 2019 04:18:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i7xpC-0003x6-MR; Wed, 11 Sep 2019 02:18:02 -0600
Received: from 110.8.30.213.rev.vodafone.pt ([213.30.8.110] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i7xpB-0007og-QA; Wed, 11 Sep 2019 02:18:02 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Carlos Antonio Neira Bustos <cneirabustos@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "brouer\@redhat.com" <brouer@redhat.com>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>
References: <20190906150952.23066-1-cneirabustos@gmail.com>
        <20190906150952.23066-3-cneirabustos@gmail.com>
        <20190906152435.GW1131@ZenIV.linux.org.uk>
        <20190906154647.GA19707@ZenIV.linux.org.uk>
        <20190906160020.GX1131@ZenIV.linux.org.uk>
        <c0e67fc7-be66-c4c6-6aad-316cbba18757@fb.com>
        <20190907001056.GA1131@ZenIV.linux.org.uk>
        <7d196a64-cf36-c2d5-7328-154aaeb929eb@fb.com>
        <20190909174522.GA17882@frodo.byteswizards.com>
        <dadf3657-2648-14ef-35ee-e09efb2cdb3e@fb.com>
        <20190911043225.GA22183@frodo.byteswizards.com>
Date:   Wed, 11 Sep 2019 03:17:41 -0500
In-Reply-To: <20190911043225.GA22183@frodo.byteswizards.com> (Carlos Antonio
        Neira Bustos's message of "Wed, 11 Sep 2019 01:32:25 -0300")
Message-ID: <87impz8cwq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i7xpB-0007og-QA;;;mid=<87impz8cwq.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=213.30.8.110;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ilPKkxouOU5Llp9axJ+W3QKaRnY6WDSs=
X-SA-Exim-Connect-IP: 213.30.8.110
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH bpf-next v10 2/4] bpf: new helper to obtain namespace data from current task New bpf helper bpf_get_current_pidns_info.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Carlos Antonio Neira Bustos <cneirabustos@gmail.com> writes:

> On Tue, Sep 10, 2019 at 10:35:09PM +0000, Yonghong Song wrote:
> Thanks a lot Yonghong.
> I'll include this patch when submitting changes for version 11 of
> this patch.

Please see my reply to Al.

Eric


