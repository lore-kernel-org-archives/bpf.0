Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF491C19F28
	for <bpf@archiver.kernel.org>; Wed, 27 Jul 2022 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbiG0SNm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Jul 2022 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiG0SNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 14:13:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55015B79E;
        Wed, 27 Jul 2022 10:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A5EFB821D9;
        Wed, 27 Jul 2022 17:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C82FC433D6;
        Wed, 27 Jul 2022 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658942047;
        bh=Drc9VoiDq38c+VVgzDBjh8/IAt7o9BlTSKd0SiJ3oqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uprA+ZNKeyCHIz4uy8mx8IkkYx5msEEx/B2RjukVnKT1YACfSJJguFLEpGl9X1HgE
         Wpp4oedO9iktPby0g7SLYZYiIKra+IQlvPlLqJuY6N0bLk3ZtvL5bw4u2JLYQM+Iqt
         FrcdEy7rze9387gMYnoyS4h99zsj+NRFATkeijfpBuy0WovSDIcGOf3LsRsPFuDpud
         IArDHB4Yw8uyQuC79IE2DwwVn29Hd68XrHbYpJm5Sj7BZww/goMy8xeyjjKjgrLIe6
         D2GBfWpMypYltrggbLQA87YXnAUbprclT3qAI6fK4zg1MWXI9fAPhIbCJrRuX8Lsw+
         trVACJRtEjWZw==
Date:   Wed, 27 Jul 2022 10:14:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 00/14] bpf: net: Remove duplicated codes from
 bpf_setsockopt()
Message-ID: <20220727101405.6e899947@kernel.org>
In-Reply-To: <20220727060856.2370358-1-kafai@fb.com>
References: <20220727060856.2370358-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 26 Jul 2022 23:08:56 -0700 Martin KaFai Lau wrote:
> bpf: net: Remove duplicated codes from bpf_setsockopt()

nit: "code" is a mass noun, uncountable and always singular
