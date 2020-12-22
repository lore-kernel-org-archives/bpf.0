Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9571FC433DB
	for <bpf@archiver.kernel.org>; Tue, 22 Dec 2020 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F922CB2
	for <bpf@archiver.kernel.org>; Tue, 22 Dec 2020 22:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgLVWMb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:12:31 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:59352 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgLVWMa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 17:12:30 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2020 17:12:29 EST
Date:   Tue, 22 Dec 2020 23:05:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1608674737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=Bbm14hiwDsi4Ajvr+3/C1a/BwWXtSIxwxALWrNmLeYg=;
        b=CWxMsJlyzl+iIAEkBCNaiQ9XuBd9U21pFR7lGmueuTR1P+DmMEcYzB9/lbG1nlviaC1H3D
        IpV1rfOZoTPk9elesYegpD/dShFBIIpO+XqVqRMT1AuFt40maI2ZMvrFcGT9r2TJuToUqd
        knk0PbbpHtf7zHs166hT/GZsmQlEbb/EqhIIfadhOGwUfjZZgqbWeEAAEKxswcv/ltbu+1
        AfHdXJ6FJXpO+lqQKTFLPpVcg8iHBUNmCQjnJZT9QnKnjFEYhoC5kG6tNp7qF1Q9BqvlRa
        vl0TH9RdaEvVCXp7mllN71p6FwaveAbZM3MWokgCUQqrlTGsLX3B4/hhMiIT0w==
From:   Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To:     tcpdump-workers@lists.tcpdump.org, bpf@vger.kernel.org
Subject: Performance impact with multiple pcap handlers on Linux
Message-ID: <20201222220533.GA5758@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I was experimenting a bit with migrating from the use of
pcap_offline_filter() to pcap_setfilter().

I was a bit surprised that installing for instance 500 pcap
handlers with a BPF rule "arp" via pcap_setfilter() reduced
the TCP performance of iperf3 over veth interfaces from 73.8 Gbits/sec
to 5.39 Gbits/sec. Using only one or even five handlers seemed
fine (71.7 Gbits/sec and 70.3 Gbits/sec).

Is that expected?

Full test setup description and more detailed results can be found
here: https://github.com/lemoer/bpfcountd/pull/8

Regards, Linus

PS: And I was also surprised that there seems to be a limit of
only 510 pcap handlers on Linux.
