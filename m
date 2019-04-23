Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DFAC282E3
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824FB218FC
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qHHVsaQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfDWX3B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:29:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36106 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfDWX3A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 19:29:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so3483054qtk.3
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 16:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=YdMWVgOKi0a78ABqSJTV4VF6psM/g+2ctHrxrJOuRgc=;
        b=qHHVsaQ/+FcUJb9z+nVkwLIC40X+YwLLFiAyBXst23iq3dLOmzXDKL8XXAo/GcqKvX
         UkX472TYNaHMieECrhczk1UNaC8z0lb98N9wunDXd9W2UMOgUlEyrjH9OSC9a3bUbzxF
         YuEAgslkBHz/wmWN8Yun5PBxL8QFQAhrcvE+z+MMe1ulJbwnWbLDGbwq/f3H8VfyOWHU
         tkYo13ZrnzheU7SxE/VX0uoAYPEl9xKY0Suhf7e86oDYhahawsL31hYQ2MObDDXfSVB3
         akzbGJxgFA1Uwmrh73p2SOrv2AFiwDaRmD2Kb9JeCbUwvroWbWtODIfpgR7MyWl1Ox9o
         wsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=YdMWVgOKi0a78ABqSJTV4VF6psM/g+2ctHrxrJOuRgc=;
        b=WUMstCLzdjr8FNK4bc6h7hwgy2l8l+LDW67yDKIdxdzD4RPyZm7b6yIn7RmMIdJn4w
         7gSCLrfgv/j7qLJv7dQY6LGdcxssUdQosEEYYkqewQcfIjtRVlcVSGk7Ek4t181pdPx+
         A6oaiYS7OBN0hTBujA8uIMHJG9YoK9iI6wUyStJR0i92dOvMomywLP5nBKSjOLEg/lAC
         ielZtflmX1+7qJhfTFKAJqDbh+sXXU04FJtTtNAykLy8rV8hhx5Tth5ZDKyD1Rp0Vizn
         QjxCswts0H6XQ9Kkw0kf5XxZoDZe7pcr4UZwaazWsF6+iP90FJ91WgaD5mJFYehNoSFX
         VdvA==
X-Gm-Message-State: APjAAAWkVbRwivZxfe4quuoUwMSbADSy8kZAn1ikb4XgwgwBkMeMbjoI
        +4Ll87e5X6YhuQOfG3gKWOejDQ==
X-Google-Smtp-Source: APXvYqwTRl+NQkKZspVZUNI0jpvtvape8iqiS6pdFPDjj6yiL899qULOGcKqQ7W6JXrIrbSNQujYyw==
X-Received: by 2002:aed:2571:: with SMTP id w46mr4283892qtc.222.1556062139503;
        Tue, 23 Apr 2019 16:28:59 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n46sm10766622qtn.75.2019.04.23.16.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 16:28:59 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:28:55 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, quentin.monnet@netronome.com
Subject: Re: [PATCH bpf-next 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
Message-ID: <20190423162855.4580667d@cakuba.netronome.com>
In-Reply-To: <20190423232200.101627-1-sdf@google.com>
References: <20190423232200.101627-1-sdf@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Apr 2019 16:21:59 -0700, Stanislav Fomichev wrote:
> +	rcu_read_lock();
> +	attached = rcu_dereference(net->flow_dissector_prog);
> +	if (attached) {
> +		cnt = 1;
> +		if (prog_ids &&
> +		    copy_to_user(prog_ids, &attached->aux->id, sizeof(u32))) {

Not sure you can do copy_to_user inside an RCU section, doesn't it
sleep?

> +			rcu_read_unlock();
> +			return -EFAULT;
> +		}
> +	}
> +	rcu_read_unlock();

