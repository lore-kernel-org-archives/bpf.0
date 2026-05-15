Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4230568A;
	Fri, 15 May 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860920; cv=none; b=ergXxe+7AHhtLkrZ2mt55kweusFh+0VmhmeMWafR0CjB9bB0nXVc2Rq0fc5/xHZafOLvG6uWWYi0TgFjeGDOMX0kvrY+99fJ/Et1gnLXOsqs7tQXB0Dp+KSGjcFQaLa426tNcd4bDQvzlsGAFxUopzcDay+oiaGKqePXsnJUzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860920; c=relaxed/simple;
	bh=Xt1Dal9QBZdl4hYiEVqvJ+og0H7MInhWhEjKEAiXxp0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WCBABGHAT/93IiEVK8ePIbxmrl1rpYZsBcU/9bBkZiHmy6QUGNlzlwLxKYKKzQi31hPJXroHuJYCo4kuXTyW0s8CV4acz+q/cMRcklQy3oSi7psL4j1DIBqCl2DWAVoWi9a06Rn6RXkWpeuf4H67ow1Fvz/pYoNbfmoMogLCTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRTjZEni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRTjZEni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D222DC2BCB0;
	Fri, 15 May 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860920;
	bh=Xt1Dal9QBZdl4hYiEVqvJ+og0H7MInhWhEjKEAiXxp0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FRTjZEniQkgJRPmE7Njd1hCN69NxFjtK31RAyok3RoHqvbdA8SIwxmc78RZfkUUMa
	 MTJTcUjJwNEgTJsDdRpYhAvzsvoRTuUr0PR+mkQkjk9F8VubH0bmh2oPsOHftRP3nI
	 A+0DZgJ6F9Jqj+r/Bzjb5IlRAHZZvSdquqv1SnwH8fqIBJwmS2xcij6Fkc/kLu9NuB
	 UdEiHXUOhd/8x8poN6MbGsW3hlkUE/753q6QTx2xN8FcQJQH8igsAmjgCw4B9rowEI
	 wq04p7OHJINKT7ntVIdCKkSiSGjukYk20bbal9osgZm5LqK5sx3zVLih+CENeGNAwq
	 +Dh8bGZ5/b9ow==
Content-Type: multipart/mixed; boundary="===============5271935997963645921=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fcc86800bb58349e766263afc346616b862fa7b660facba32abecb8e8e7083c6@mail.kernel.org>
In-Reply-To: <20260515151830.711129-1-faisalbukhari523@gmail.com>
References: <20260515151830.711129-1-faisalbukhari523@gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix tunnel option size in ip6geneve_set_tunnel()
From: bot+bpf-ci@kernel.org
To: faisalbukhari523@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 15 May 2026 16:01:59 +0000 (UTC)

--===============5271935997963645921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 5f750f9a85fff89d7c4960e06d838efe58b8a805
> Author: Faisal Bukhari <faisalbukhari523@gmail.com>
>
>     selftests/bpf: fix tunnel option size in ip6geneve_set_tunnel()
>
>     Pass the correct size to bpf_skb_set_tunnel_opt() in
>     ip6geneve_set_tunnel().
>
>     sizeof(gopt) returns the size of the pointer instead of the
>     actual Geneve option structure, resulting in an incorrect
>     option length being passed to the helper. Use
>     sizeof(local_gopt) to provide the proper structure size.
>
>     Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>

This isn't a bug, but does this actually change the size passed to the
helper? On the 64-bit eBPF architecture, pointers are exactly 8 bytes.
struct local_geneve_opt consists of a 4-byte struct geneve_opt and a 4-byte
int, totaling exactly 8 bytes.

Thus, the exact same length (8) is passed to the helper before and after the
patch. The patch improves semantics but does not appear to fix an incorrect
length.

This looks like a bug fix. Should this include:

  Fixes: 5ddafcc377f9 ("selftests/bpf: Fix a few tests for GCC related warnings.")

> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 30f1de458669..ca04d1d1ade4 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -674,7 +674,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
>  	gopt->length = 2; /* 4-byte multiple */
>  	*(int *) &gopt->opt_data = bpf_htonl(0xfeedbeef);
>
> -	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));
> +	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(local_gopt));
>  	if (ret < 0) {
>  		log_err(ret);
>  		return TC_ACT_SHOT;

Does this construct a malformed Geneve packet? According to RFC 8926, the
length field defines the option data length in 4-byte multiples, excluding
the 4-byte header.

Thus, length = 2 indicates 8 bytes of data (12 bytes total option length).
However, only 8 bytes total are passed to bpf_skb_set_tunnel_opt() via
sizeof(local_gopt).

This results in an option that claims a length exceeding the available option
space. Should the length field be set to 1 instead?

Looking at ip6geneve_get_tunnel(), does the receiver test silently fail to
read the Geneve options?

The kernel helper enforces that the buffer size must be at least the size of
the options present on the packet. Since the sender set 8 bytes of options,
bpf_skb_get_tunnel_opt() with a 4-byte buffer will fail with -ENOMEM:

ip6geneve_get_tunnel() {
    struct geneve_opt gopt;

    ret = bpf_skb_get_tunnel_opt(skb, &gopt, sizeof(gopt));
    if (ret < 0)
        gopt.opt_class = 0;
}

It seems the test might be ignoring this error and bypassing the verification
of the Geneve options entirely.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25926759989
--===============5271935997963645921==--
