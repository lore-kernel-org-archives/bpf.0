Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FA284663
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325335; cv=none; b=Idi/9wCNf/tST8mkY00CdHQ+r4sFJVIiJ+FIJWFkXiS5FHfc+MAKLbfyadCwFQKrPwjsGhFbK15elREQBd70oszqtD8fM9+eKztrm2TKMnukLaQu52JP3ESWwf3hd3jCdVmfmmdEwN/q2/3HY4LOUYceJ2c1J1jlmmDMTadU0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325335; c=relaxed/simple;
	bh=jFJB3FUm5JxPCTLwP8OeL6k6txpAOi9pLBnk2FETw0Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OoWwahow0DYmLaqfealG2SRTWpDXihjJgu+PesnAgzqmb2mvnL8HFjMdcfKJU72zyqbYV6n74Z/5mLJtg56HwXv09c9jbWP0P4swSHH0CLq1bsaBpSWrHShOVUGYEgPeMJ6yo7sDbBMmPlHSI9HAHnUyfBdpqaqzAlBd8rqP9lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvKYwNyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvKYwNyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7BAC4CEF7;
	Thu,  5 Feb 2026 21:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770325335;
	bh=jFJB3FUm5JxPCTLwP8OeL6k6txpAOi9pLBnk2FETw0Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KvKYwNyP56t5RRwYcPFdnfskQtPsF3IkpiSsfzqwpksLdR2ulNAkwqkexqKUwX+Iv
	 ovxPApXpNXRyu2RZ0oM8SvZ1biV1owwKBi5y0MWdl9Hj26t4SUodfp12wjPTQAvKm9
	 sKFDbq9X0zz8xbZW1/imfLv7gipQQTxO1e2INKFj+46ww3Tslen2nZD5dFOLV2aN7Q
	 LCLwRnFeASGfcsFW+CEUWGDyx92WzjUdIXk6UDC7W3fiWQh3zTGauEbzcEB5MMB89k
	 KdJrfuSpARm/dwHWrlMr3tQq44iPshlqtVtLbhYH6YV5SmXY7beg5bIBcYY27+MAbv
	 5uhjZJxi8JXPg==
Content-Type: multipart/mixed; boundary="===============0241075186426314885=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8edc170e0ab6f569f367425356344d50da9155554829c1acdd7c29eb697a2fa@mail.kernel.org>
In-Reply-To: <20260205-rhash-v1-1-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-1-30dd6d63c462@meta.com>
Subject: Re: [PATCH RFC bpf-next 01/12] bpf: Register rhash map
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,ameryhung@gmail.com,memxor@gmail.com,puranjay@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 21:02:15 +0000 (UTC)

--===============0241075186426314885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index b13de31e1..56e4c3f98 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -134,6 +134,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_ARRAY, insn_array_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_RHASH, rhtab_map_ops)

This references rhtab_map_ops which is not defined until the next commit
(f027f41d1 "bpf: Implement basic functions for resizable hashtab").

The BPF_MAP_TYPE macro expands to an array initializer in
kernel/bpf/syscall.c:

    #define BPF_MAP_TYPE(_id, _ops) \
        [_id] = &_ops,
    #include <linux/bpf_types.h>

This causes a build failure at this commit due to the undefined symbol.
Should this commit be reordered to come after the one that defines
rhtab_map_ops to maintain bisectability?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21727734472

AI-authorship-score: low
AI-authorship-explanation: The commit message is characteristically terse in kernel style, and the code changes are simple mechanical additions following existing patterns, consistent with experienced kernel developer practices.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Build breakage due to undefined symbol rhtab_map_ops breaks bisectability, though it is fixed in the immediately following commit in the series.

--===============0241075186426314885==--
