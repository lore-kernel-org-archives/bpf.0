Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84D4279E0;
	Wed, 12 Aug 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530792; cv=none; b=rvspTz3FpwlR/ve8YFsLggUMN7G88tZbEg9WqBogzPagoI66uWbB25uGHNkorNQhNmZuz4/4qfgJAJFBroOFZt9L/NSTtwUpyguU20Lwytv5rsfKwgRo13txZHepfW/lo0ZrNm8Pz/MBA6OJKbeoEJlKAOE7T+eJ93nfcuQBEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530792; c=relaxed/simple;
	bh=L9kU3eWHPmllo2FE3iEh/JMRvhyQoAzmZg1wmJ7UeW8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VW1QRqvSXjTM7Djix2lqJmmc5ccd8AVqbbyseb1xZg9soaLJVyoHX3QbrVNZ8STG6DDFck7HvvzPzEuIAIejibEB4/O5G3UFKdruB/xx+ectj5nGmvFRS3b7C1EFhiNfIAwqg2zEIXo4s170Il/XeRjKEK0kQRMPbGIQQ6oA4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA/MGoqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA/MGoqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE9C1F00A3A;
	Wed, 12 Aug 2026 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530790;
	bh=QjDYgYv8spa1aKJrEz0o3Ej9iM3oLC7CW9VMnPyawAE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hA/MGoqL2872WN3xiOXj1XMNihgvHrqRlTyQYEuzfzquLqAyZPVHOqbWD7CyifS9k
	 0/p2mIE4FZi3btQsFFJil50xvrGkkhlUtS2PajtxeglZiGfRJJvkHNltgs41MZsHvw
	 se8HSevqjxU0m81lzGv0ufRjEN356tOOaEbOLI0U1gmsufBqpwcynOrzpFI1H44OoT
	 hdEWT/BsBAhePlI1jMG3RCZ48OMQSwha89qzfcdcydAzCd8Hug2CzofJ8di3qkdM81
	 Qjw07k/sQFhkiFxpe8RBKTKjENuwiPCXkt5xY+nT023bsSNdNHQaVeVLIC207BEcIA
	 mJI6+5qItRheg==
Content-Type: multipart/mixed; boundary="===============0750524201368509597=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3fca04caea0b155d2b15e0914622f905af892ba5e2ce0f75dc9d998f3fb2226d@mail.kernel.org>
In-Reply-To: <20260812083115.73100-3-nhudson@akamai.com>
References: <20260812083115.73100-3-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v7 2/6] bpf: refactor masks for ADJ_ROOM flags and encap validation
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 10:33:09 +0000 (UTC)

--===============0750524201368509597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: refactor masks for ADJ_ROOM flags and encap validation
>
> Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
> validation logic and introduce:
>
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
>
> Refactor existing validation checks in bpf_skb_net_shrink()
> and bpf_skb_adjust_room() to use the new masks (no behavior change).

Does the subject line accurately describe what is being refactored?

The subject claims the patch refactors "encap validation", but no encap
validation is refactored anywhere in the diff. The only encap validation
in this file is in bpf_skb_net_grow() (around the middle of filter.c),
and it is untouched. It still open-codes the pairwise mutual-exclusion
tests:

    if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 &&
        flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
            return -EINVAL;
    if (flags & BPF_F_ADJ_ROOM_ENCAP_L4_GRE &&
        flags & BPF_F_ADJ_ROOM_ENCAP_L4_UDP)
            return -EINVAL;

The newly introduced BPF_F_ADJ_ROOM_ENCAP_MASK is never used in a
validation expression. Its only consumer is the composition of
BPF_F_ADJ_ROOM_MASK. This is still true at the tip of the series.

The commit body itself only claims refactoring of bpf_skb_net_shrink()
and bpf_skb_adjust_room(), so the subject, body and diff disagree.

Could "and encap validation" be dropped from the subject (e.g. "bpf:
refactor bpf_skb_adjust_room() flag masks"), or should bpf_skb_net_grow()'s
encap checks be converted to the new mask in this patch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31584739682
--===============0750524201368509597==--
