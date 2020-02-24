Return-Path: <SRS0=zUS/=4M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868BDC35DEB
	for <bpf@archiver.kernel.org>; Mon, 24 Feb 2020 23:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4C920700
	for <bpf@archiver.kernel.org>; Mon, 24 Feb 2020 23:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582588561;
	bh=qSxvO83yPUMBZHDica16EBpMUR3Q5/GvMpAL3SOiWl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XZLCpLEz2Tw1I7Aibn7W1XLcHRmaDn2cI6UqNqIk1pizMrNOxprXncIs0VclaT1oQ
	 e3iMXMt5+GHbz/nyl+AqhLY/k/2ePkqXCrfwPd59dZVNIBq/ko7inlqzEDEmcFMi+l
	 dudFvSdASIFSMlRIzQ7IJ7bDQPkT9Ne0Ru5pn2go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgBXX4B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:56:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXX4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 18:56:00 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7872072D;
        Mon, 24 Feb 2020 23:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582588560;
        bh=qSxvO83yPUMBZHDica16EBpMUR3Q5/GvMpAL3SOiWl0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m4hZM7+93fO3YxJKmiH3cA86vJC3oAhNENDhnJTp3F2ncbUWb3GxuZpiWBlzQu2Hu
         PYTtOOYwTJulKvAP1YrZ3MYK6shPmst9lG7okX9whb9glvKkJ9vlauGQz12K76oe9C
         jqevc3EumyrMVQqLp0OGCpQiPr1Ihz+UkgJ+yS9I=
Received: by mail-lf1-f52.google.com with SMTP id y17so5069790lfe.8;
        Mon, 24 Feb 2020 15:56:00 -0800 (PST)
X-Gm-Message-State: APjAAAX3btdo8HotXeR66ACRtbX6eq3hleFpkOGe9rueFf+lW/dSAX7p
        od4udDYe1pCGPJx5Tv+gKtkCkB3plJzHv+5OZog=
X-Google-Smtp-Source: APXvYqye8mkPliO8/NBSwYoJpdeB48xo8SheaWufak88fAAMf7UbSP5x/9CpxechVZg2c3hWYE0QtPesG483NuNsaWs=
X-Received: by 2002:ac2:52a2:: with SMTP id r2mr28069533lfm.33.1582588558351;
 Mon, 24 Feb 2020 15:55:58 -0800 (PST)
MIME-Version: 1.0
References: <07e2568e-0256-29f5-1656-1ac80a69f229@iogearbox.net>
 <20200220071054.12499-1-forrest0579@gmail.com> <20200220071054.12499-4-forrest0579@gmail.com>
In-Reply-To: <20200220071054.12499-4-forrest0579@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Feb 2020 15:55:47 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7nCW5iu9rKowUWb33OLEe33mKD_uLTEdtX4B8v4cbTJA@mail.gmail.com>
Message-ID: <CAPhsuW7nCW5iu9rKowUWb33OLEe33mKD_uLTEdtX4B8v4cbTJA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add selftest for
 get_netns_id helper
To:     Lingpeng Chen <forrest0579@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Petar Penkov <ppenkov.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 11:12 PM Lingpeng Chen <forrest0579@gmail.com> wrote:
>
> adding selftest for new bpf helper function get_netns_id
>
> Signed-off-by: Lingpeng Chen <forrest0579@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
