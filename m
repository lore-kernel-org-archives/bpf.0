Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CDC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707FD20880
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 18:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zX0DUs/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfDOSiw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:38:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33804 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOSiw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 14:38:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id n68so10521508qka.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EQeMgyOWF37J+OfhkBm9SuoEClB5hgmAmK1vSnM9Jtg=;
        b=zX0DUs/FZ6Cv/WePWYITFUX6Mjo+E2oXl1zq7LsWj8iZH8bf22KKGWyYdWOGuA6vD0
         +DKMXLUJIfytdeGDNNswpLH0P99NVXoEJxAsc2ucWz7dYZj8v6xWZla+i5mfTT80k1Rw
         7gYYiYA6fI6j7NxvppLZaRJiSKiMrtzNT47nwszHdh1F6sqsVMimsQ/Ymae12fW2kJYv
         BbWRz0sFMguEIn8vY9/edYEoDUc0CSjKP/qe5/6k4Ox3TRrxdutzKlhc5AeE9nZ5G2/i
         We6FXN9JtQIB73+Yjd17rOu4W2F5g6qXwp0hceP0DSyIbmZhlnM+FOn9kcrZStOQeHbp
         9YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EQeMgyOWF37J+OfhkBm9SuoEClB5hgmAmK1vSnM9Jtg=;
        b=ZMungd6B5FGFCRLlcnPEhxepyY/8OOFSplF5d5e9YGnVOoM+YqkSx4wJK7HpFKa7Oj
         1XpvVzx//AVCWraHzI1Q/SKzvAz00gjLhDk9dxTprl7b+p4xCtBnJxnUdILtO5HvHVbo
         koW86I48PFsaMozBbi6dJajliVzjGVxN7dv10vpbGwjlhu5HcCuCbgvs/wON6nGuyZz/
         Af5nExhL2C1y/4+74W1+l+u02zWdOMXAHs9ucM+zKVUAQNyPWJJ8wGTk5gdwgryCBu4M
         Funw3cvnKHho4cpdHHjAY3c3udzBpu0KhIt1S6jWi02oyTMWXBFyvjctqi5Ek7VvMGhd
         mryg==
X-Gm-Message-State: APjAAAUxA3QMod02HNDR+5JIbkx2Z6jEaeGRovTlPResccTzIhm4Pdpv
        jBFZhGZtSseOit4ITwDjRKSzOg==
X-Google-Smtp-Source: APXvYqzENyeHh1XoGF7mKx/4tX9Yegyog02rT0q7v5PTRmTPSXYV0kZNqLphXL7asNg7DboWJllVGg==
X-Received: by 2002:a37:a310:: with SMTP id m16mr17089255qke.140.1555353531379;
        Mon, 15 Apr 2019 11:38:51 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i24sm34441722qti.76.2019.04.15.11.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 11:38:51 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:38:47 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Benjamin Poirier <bpoirier@suse.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 2/2] bpftool: Improve handling of ENOSPC on
 reuseport_array map dumps
Message-ID: <20190415113847.2c1dd062@cakuba.netronome.com>
In-Reply-To: <20190415071536.19287-2-bpoirier@suse.com>
References: <20190412030322.15494-1-bpoirier@suse.com>
        <20190415071536.19287-1-bpoirier@suse.com>
        <20190415071536.19287-2-bpoirier@suse.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Apr 2019 16:15:36 +0900, Benjamin Poirier wrote:
> avoids outputting a series of
> 	value:
> 	No space left on device
> 
> The value itself is not wrong but bpf_fd_reuseport_array_lookup_elem() can
> only return it if the map was created with value_size = 8. There's nothing
> bpftool can do about it. Instead of repeating this error for every key in
> the map, print an explanatory warning and a specialized error.
> 
> example before:
> key: 00 00 00 00
> value:
> No space left on device
> key: 01 00 00 00
> value:
> No space left on device
> key: 02 00 00 00
> value:
> No space left on device
> Found 0 elements
> 
> example after:
> Warning: cannot read values from reuseport_sockarray map with value_size != 8
> key: 00 00 00 00  value: <cannot read>
> key: 01 00 00 00  value: <cannot read>
> key: 02 00 00 00  value: <cannot read>
> Found 0 elements
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thank you!!
