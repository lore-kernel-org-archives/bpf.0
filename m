Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C55C61DA4
	for <bpf@archiver.kernel.org>; Thu,  2 Feb 2023 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjBBOj4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Feb 2023 09:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjBBOjz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 09:39:55 -0500
X-Greylist: delayed 418 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 06:39:54 PST
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD82B8B7DA
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1675348374; bh=s2mKM968wLyK2zWIfVNo5jk9hT9zSzoYCd8GqC8/9/A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=H3U1C6tBj42t50+GBU/Abq44hzHBRA89R4SBa2gqlJvAm+AzoxiSQ+ymJs8FJNfmA
         ommdGy2nRdasxt0LQJZas6ozLMHw20MmQrO/GneJQ+kzYgGMS/a76RlFMl9XKvorFd
         IIskESyCsGfkubutytjUSh908s7CDWOIInTLWdNbzmuoUT8uXW0Zc66DDmJJPK5PEo
         TBQxzDdo4c3noOi86pt1+W+3QW3GX8U+EYcWYCbhmx+IkhDkg/FY8c1fYJ05ZfMXpD
         2jnYckVSPeLyOf8I/0ED1tY/JkF83LodFHfnVG7cHTsDEmaoepTpi15gjR2sKFCKn/
         KrfRKxEE8bP/A==
Received: by gentwo.de (Postfix, from userid 1001)
        id 1704CB00210; Thu,  2 Feb 2023 15:32:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 1418EB00159;
        Thu,  2 Feb 2023 15:32:54 +0100 (CET)
Date:   Thu, 2 Feb 2023 15:32:54 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Yafang Shao <laoar.shao@gmail.com>
cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, akpm@linux-foundation.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/7] mm: percpu: introduce percpu_size()
In-Reply-To: <20230202014158.19616-3-laoar.shao@gmail.com>
Message-ID: <f18a3e-335c-ef3e-b572-73bd651138e4@gentwo.de>
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2 Feb 2023, Yafang Shao wrote:

> +	bits = end - bit_off;
> +	size = bits * PCPU_MIN_ALLOC_SIZE;
> +
> +	return pcpu_obj_full_size(size);

Dont you have to multiply by the number of online cpus? The per cpu area
are duplicated for those.
