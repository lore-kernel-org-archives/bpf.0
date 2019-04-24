Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94752C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5743F20811
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="nod8fYiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfDXVpC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:45:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41705 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfDXVpB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 17:45:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id f25so13424615qtc.8
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 14:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=MURBuwK5cKzf/WaLcGoFl8cod+DLP3iO5p8VUU5MZ4o=;
        b=nod8fYiP2spLk32EN3kBNK6ifJf1dKrcbIbDqEg59WMYhU0LzRotnc25ZRwWbdfvr9
         X2oz9cu38my6dBJpXsf8jSiIDN6zFbVafTSwEh0UuFyjmiz1MTJzMk6exWOaNw+UplFX
         tSKK8bt2RKpisd4T4m3LpX3SSZFgIufZJ6WiAtNZEzcPtEZChwoNo38QRBBls6jL7+8M
         3KHV8bqy08OSotV0JgvCea0TchDSecrOe0z1WAQktzfW0fkhHF/HnnVrGn/xdo11GBEz
         1RDirTSNkpNjc/3NcZBIDpGpjBldmgc4g8SbmeDoO/eJ6+Wt+97v2jcwJfXACRYstxD0
         0LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MURBuwK5cKzf/WaLcGoFl8cod+DLP3iO5p8VUU5MZ4o=;
        b=RN8Pf1S8PJC8/HiQMT7gQ4LDVl9U5aj2OUaMaMyvSjiVC7Wao0LK3CxPGSB2EyO/RN
         OInuyLdmdCwgdbwLoZtkegi7V3s0tGjwNRWrjly1xlUAANf+luKKGz1+DKh0Pz/Kx+IJ
         jQptPMkOl3feDTJeYg2UyiOIMNZrDKIVP3HACi9jArv5iqb289l8zXckI80SGw+TKmIk
         rNUomLFzgmw0egM+fcPgtYpISmXWyFcyjR8GeMsYqZLBETHETqtb18ZUpDksnfA7ydbf
         JoAoNHh8EY5yx8d73MaNLIo6btICqRtZ+Dw15jIHNm2DjpP48/IFLlVzBKcs2RxAfYF6
         NNwg==
X-Gm-Message-State: APjAAAVZe9BIFWk1wOqh8zI9/tu2lzREdRswNZgHeAU7ClKYuHgyXM0R
        O5M6GgqCUg5h5fAAdl/m79DlyQ==
X-Google-Smtp-Source: APXvYqyEu35nL1Io7OTIBaDj3dOMCv9d0cAA0O8Kxo9kjNMus4+uoXmR69Scn5qA9kQGM7iVqpn9xA==
X-Received: by 2002:ac8:2a51:: with SMTP id l17mr27974776qtl.76.1556142300975;
        Wed, 24 Apr 2019 14:45:00 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 56sm13387913qto.57.2019.04.24.14.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 14:45:00 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:44:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, quentin.monnet@netronome.com
Subject: Re: [PATCH bpf-next v4 2/2] bpftool: show flow_dissector attachment
 status
Message-ID: <20190424144457.2a893e1d@cakuba.netronome.com>
In-Reply-To: <20190424213141.201134-2-sdf@google.com>
References: <20190424213141.201134-1-sdf@google.com>
        <20190424213141.201134-2-sdf@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Apr 2019 14:31:41 -0700, Stanislav Fomichev wrote:
> Right now there is no way to query whether BPF flow_dissector program
> is attached to a network namespace or not. In previous commit, I added
> support for querying that info, show it when doing `bpftool net`:

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
