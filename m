Return-Path: <SRS0=LuT0=7I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F6C433DF
	for <bpf@archiver.kernel.org>; Tue, 26 May 2020 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6572A20870
	for <bpf@archiver.kernel.org>; Tue, 26 May 2020 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590511449;
	bh=uF8fArU4V3d0gRDmpvRFyjvlsGovSmDM0Tikgs5AV38=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=TAv3KNXKR4/fbaOXSBmmIBp7NgKRBzJJQZOmMkadktfy8tHJDqF6m1XYIoLJw6cEN
	 JRWOUKMOGr7DV0Hva6hwKNlYza6GP7J8LguLYLxP+nMzNfeAPhsodwgdMQX8+xCQlZ
	 0kyeuNweeXRA4kONnjcBLtG4a0lAdjCSQLKr92ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgEZQoJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 May 2020 12:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgEZQoI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 12:44:08 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2241A20723;
        Tue, 26 May 2020 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590511448;
        bh=uF8fArU4V3d0gRDmpvRFyjvlsGovSmDM0Tikgs5AV38=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uoD034meFsUWPg/ub4LFxiQAsudQfzkCzZs8FxcyEtzwsloP+zD8WyCaY1nzXqoXP
         4S+EhrAruBA651BrPiGTsvSknZPN3X1vX/ZGlIFbpWnmOkCtXll1ZtNyLxMXRA6pfM
         rX8Z+Z9rqhBvAl03zvkKf2voyxYgmgXK3J6ufm+4=
Subject: Re: OUTPUT and TEST_CUSTOM_PROGS
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <xuny367osf2z.fsf@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c049c93e-d962-ac15-e623-34df9af10a8b@kernel.org>
Date:   Tue, 26 May 2020 10:43:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xuny367osf2z.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/25/20 12:28 AM, Yauheni Kaliuta wrote:
> Hi!
> 
> lib.mk expects TEST_GEN_PROGS, TEST_GEN_PROGS_EXTENDED and
> TEST_GEN_FILES to be in local directory and tries to handle out
> of tree build adding OUTPUT to it at the beginning.
> 
> commit be16a244c199 ("selftests: lib.mk: add TEST_CUSTOM_PROGS to
> allow custom test run/install") adds TEST_CUSTOM_PROGS but it
> handles it differently. Should it add OUTPUT as well?
> 

Individual tests apply OUTPUT to TEST_CUSTOM_PROGS. lib.mk rules
can't build TEST_CUSTOM_PROGS and it is left up to tests to
handle them as custom.

So no on adding OUTPUT to TEST_CUSTOM_PROGS in lib.mk.

thanks,
-- Shuah
