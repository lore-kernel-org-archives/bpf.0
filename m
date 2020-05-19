Return-Path: <SRS0=8tVf=7B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE50C433DF
	for <bpf@archiver.kernel.org>; Tue, 19 May 2020 13:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80F420835
	for <bpf@archiver.kernel.org>; Tue, 19 May 2020 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589896767;
	bh=0IhArQVYM/6CbgtBJOhdd65fjzeUoMZcZUlX9Zz0pZs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=w+2YgFjoe0r6axKF3a0s+i8hnK/zrjKl2P7cH0aEkL1G2YBJixkaNvyRbcbRvdfQ9
	 LdcMhvqM/KnDxo/QX2MBK4Rb+jbuLJ1v3FMJ6EO4g8mFnT8alDCQw6H+KMKhUXC33b
	 QIR7ftlkhuwIG2bpJUIbAhXicO0vvCOQ0MmaU5Rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgESN71 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 May 2020 09:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgESN71 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 09:59:27 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F6F20825;
        Tue, 19 May 2020 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589896767;
        bh=0IhArQVYM/6CbgtBJOhdd65fjzeUoMZcZUlX9Zz0pZs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CQ4PmYLBQ7Gqf19gvVV46Jd4yTAk4AnXbl56srpjNvvfmLGRnL1tZ6HQ6oiP5xJmy
         m7P4DyJMdveb7ugRt4eefLoOg25kR95LBDIr+/SGo0P4umepd4f1elqAvL8Dx2jqn0
         IE+F2GmvwVrAIdRn7u8K110zrU5+aLD3eLWxZvXE=
Subject: Re: [PATCH v2 0/3] selftests: lib.mk improvements
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        shuah <shuah@kernel.org>
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <689fe06a-c781-e6ed-0544-8023c86fc21a@kernel.org>
Date:   Tue, 19 May 2020 07:59:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/15/20 6:00 AM, Yauheni Kaliuta wrote:
> 
> Yauheni Kaliuta (3):
>    selftests: do not use .ONESHELL
>    selftests: fix condition in run_tests
>    selftests: simplify run_tests
> 
>   tools/testing/selftests/lib.mk | 19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)
> 

Quick note that, I will pull these in for 5.8-rc1.

thanks,
-- Shuah
