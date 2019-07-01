Return-Path: <SRS0=ay3l=U6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BBC06510
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 22:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2B421479
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 22:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ngPjHjPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfGAWEt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:04:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33723 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfGAWEt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 18:04:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id h24so13354147qto.0
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=tdUJDpmJyvTyeb2mvnZzsOk0Mh/UFIrC52wTJgenPBA=;
        b=ngPjHjPjpNCHd7ucjfiB48oO80YydCY0C0m5i4eBV8XYrvqS8wjAdUwpqfaGYSNUiD
         u0BaC1zom9Fyy33qYW36qKcM6jBQuZpnZlmdBci7aJQI/YEMufwdWn9lBMLLRX5jhz79
         a/lyndwNF4HUNurrmrWDf23Yz+YkimBB2UATbrJ9us8nXlaUUT5PKAhzELHYZmLfLD+w
         3T3NiblDqq7KoPiM0qBimCXnyE+vhHd0RVjN9FWTD5tbZDAn+cKsB7VsShhIP8uJSzkZ
         87N2A++hNwF6ARLVYO2BZEREcZNTfTEwrxCekaHPX3UO71dP8+Zz5RX43ubaU8xIaX5t
         2lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tdUJDpmJyvTyeb2mvnZzsOk0Mh/UFIrC52wTJgenPBA=;
        b=GnTuGZKjSld2wj+wMwEZh0ddrQQ00+uYAg35bkx7Dew/OZGUNbHYRd2+XrrhAHEGjV
         4k8KQl5QRVWWFQy2W5BfJMOvpFSKRIyQ7z02XJSa0lOiDQaWc71dDYf++MiCtmlL0+rh
         yzzfpUyceKN7RhBMPDIJlVOFo+yOLS0bVQTAdpRiivJV33t2dPAFDW6KEOr1txhp1BBm
         S0tDE5siU3aWAPjGOeNi3QvqXVsB0yvxUfHZg1CF6M/7vYlvYqEbhb8YUuqsQTW6XxqZ
         nbgJVR9blbAwbdiIK73tErp7cGjjsefEGCuZGjUD0jbZBufLG+2BfMk65LrbEoFMg7T8
         Hehw==
X-Gm-Message-State: APjAAAUfCYVvn6EQXyaaVecl8M8bG3pjME/iY6ER5joxaWdhR0g5PX0W
        XGyPKl0p3ujXNSLAtBpsMoEbww==
X-Google-Smtp-Source: APXvYqx3+GhEhtESPFn48ANSzScSbB75065DoJ4pPYAmOGTNF/GY53Z5/Kv/tSHv7WO3EZt1FJeR2Q==
X-Received: by 2002:a0c:9274:: with SMTP id 49mr23532847qvz.119.1562018688252;
        Mon, 01 Jul 2019 15:04:48 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id g53sm6488457qtk.65.2019.07.01.15.04.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 15:04:48 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:04:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 4/4] tools/bpftool: switch map event_pipe to
 libbpf's perf_buffer
Message-ID: <20190701150443.1e43e818@cakuba.netronome.com>
In-Reply-To: <20190630065109.1794420-5-andriin@fb.com>
References: <20190630065109.1794420-1-andriin@fb.com>
        <20190630065109.1794420-5-andriin@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 29 Jun 2019 23:51:09 -0700, Andrii Nakryiko wrote:
> Switch event_pipe implementation to rely on new libbpf perf buffer API
> (it's raw low-level variant).
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

> -int do_event_pipe(int argc, char **argv)
> -{
> -	int i, nfds, map_fd, index = -1, cpu = -1;
>  	struct bpf_map_info map_info = {};
> -	struct event_ring_info *rings;
> -	size_t tmp_buf_sz = 0;
> -	void *tmp_buf = NULL;
> -	struct pollfd *pfds;
> +	struct perf_buffer_raw_opts opts;

I'm slightly worried we don't init the ops, but we can wait and see if
it bites us or not.

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
