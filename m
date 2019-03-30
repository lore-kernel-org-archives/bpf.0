Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B647EC43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECB52183F
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ehu7lj24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfC3DQK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 23:16:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44505 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfC3DQJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Mar 2019 23:16:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id y5so2564148qkc.11
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=R7pgB20bVE4R48Np/IpUdMDJQM6G4kh3IdxMpZS0e2k=;
        b=ehu7lj24rW3ZmhcWRpkTSIW8d8gnkWGDW5JpDw7Zx/G5AlESA54oiNj9mndCByzGOD
         zVgVjHSprn+eEFUOdkwd5EgEy5LJj6oJpjU66Xa7cs1hO7h4olSxT0Hmq/kb0FtOQVKO
         vbQwob7ZvWgwF41rcO7vN24UjA/yqMfn7AlsSISf36w0kDLjEj75L/mtrxpIlK1fag3s
         MVnH75TcIR3zCNajqMtvi9UtMFe/X4kvG+qZBdOnEwG6VGi4SeKANubI9wFW7hE9OCgt
         +48TEcsl9YgVKLN5krPeEvZu1bSiGrr957gPeQBsVILkB1xkeOG68viWouFO5t3t4Gem
         tAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=R7pgB20bVE4R48Np/IpUdMDJQM6G4kh3IdxMpZS0e2k=;
        b=lv52DGNQCIkh1Dd5/0iVLUIMgqHKOLZQbMILXBzfYt8yhyAOmhhKMPYwJ/YcKH+Tjk
         w2x886Jk9NNcZNlmi0yvK9uNt2WGUw5tC3yEncf3gHMc/zQftl0F0+KYrO2zk/VZ1RJR
         D954Z078+9DSND0C72M7vY8ZNHKQb/+y60qo3K+Z8fI4IUDh853Iks6o515POjaI2Wzp
         EOQvgt0OBUdXwzbtgfP4phjcdNuQQzuflOebw/J46lobLjmPzAxJSBVkJ/Jth7+b26BE
         3soDlxEm+AoGd+MFTWqwsncinOYeWZzCOEft/rXGd4NTt87kwOh3UY5OuDESaW2noJrg
         lipQ==
X-Gm-Message-State: APjAAAUL/YYuhlzKEZY6PP1g2OMWaVzq659yAe5eCyUPam9XBZ3gZc6g
        Qk1T8a2+YdSpvgXUwdkF+bn0gA==
X-Google-Smtp-Source: APXvYqyoABKqUHVRYSXGEuYtBHel1laGWr2n8j/ca7uRXtiKqrx/UX8qftHB5+3da+VVinGp/1hHrQ==
X-Received: by 2002:a37:b587:: with SMTP id e129mr42071469qkf.145.1553915768973;
        Fri, 29 Mar 2019 20:16:08 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i24sm2098176qtm.3.2019.03.29.20.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 20:16:08 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:16:04 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     <davem@davemloft.net>, <daniel@iogearbox.net>, <jannh@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: increase verifier log limit
Message-ID: <20190329201604.600d8d86@cakuba.netronome.com>
In-Reply-To: <20190330001612.2354959-6-ast@kernel.org>
References: <20190330001612.2354959-1-ast@kernel.org>
        <20190330001612.2354959-6-ast@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 Mar 2019 17:16:10 -0700, Alexei Starovoitov wrote:
> The existing 16Mbyte verifier log limit is not enough for log_level=2
> even for small programs. Increase it to 1Gbyte.
> Note it's not a kernel memory limit.
> It's an amount of memory user space provides to store
> the verifier log. The kernel populates it 1k at a time.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
