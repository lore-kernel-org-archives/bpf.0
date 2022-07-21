Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FE4C433EF
	for <bpf@archiver.kernel.org>; Thu, 21 Jul 2022 18:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiGUSgs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGUSgs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 14:36:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CB489EA7;
        Thu, 21 Jul 2022 11:36:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 656C86D9;
        Thu, 21 Jul 2022 18:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 656C86D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1658428606; bh=7dY3CR0xZUh78ghGc8dadl08SEECEhHZ6yzAw7iakfc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fVZcRjpAQRak5k0dqUgacCXtEjsRXv3AwU52ypu5M/WwkuOL0Hw/0XYiWH2lYPBKG
         w76+EqYkDLkjJstI6nDZG4tyiHQLzG62a9TWRQu5V27igirSdBny/NVBtt2v7x+Obo
         JR0O8wk1VZ+ulH3/Kuu1Qb0zDcqwOPvqJ/WwZ3Qs6uVaTVbhWq0Afd7oTCAl1X1tb3
         nINa02w5Zv7EmgaxHRsRCw8EJ64g7A5FA5Uo+JsZwnDtatm7Wybw4jZ5HUKu0PVzgC
         u0GbSQaxgBtQqqD8yD51uyZSsao1tZsIssRU7lZ6AaUkOkJRgmmlqzRw3Rt72yjUol
         HXXAf1YDaDRSw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Slark Xiao <slark_xiao@163.com>, kafai <kafai@fb.com>
Cc:     Baoquan He <bhe@redhat.com>, vgoyal <vgoyal@redhat.com>,
        dyoung <dyoung@redhat.com>, ast <ast@kernel.org>,
        daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>,
        "martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>,
        yhs <yhs@fb.com>, "john.fastabend" <john.fastabend@gmail.com>,
        kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
        haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
        "william.gray" <william.gray@linaro.org>,
        dhowells <dhowells@redhat.com>, peterz <peterz@infradead.org>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        longman <longman@redhat.com>,
        "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>,
        bigeasy <bigeasy@linutronix.de>,
        kexec <kexec@lists.infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
In-Reply-To: <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
References: <20220721015605.20651-1-slark_xiao@163.com>
 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
Date:   Thu, 21 Jul 2022 12:36:45 -0600
Message-ID: <874jzamhxe.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Slark Xiao" <slark_xiao@163.com> writes:

> May I know the maintainer of one subsystem could merge the changes
> contains lots of subsystem?  I also know this could be filtered by
> grep and sed command, but that patch would have dozens of maintainers
> and reviewers.

Certainly I don't think I can merge a patch touching 166 files across
the tree.  This will need to be broken down by subsystem, and you may
well find that there are some maintainers who don't want to deal with
this type of minor fix.

Thanks,

jon
