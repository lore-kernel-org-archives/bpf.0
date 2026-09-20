Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18313CB55C
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885923; cv=none; b=rRwGXROVB9dCaREeOaPHl6hfB/nNEuV8g1rXBxVc63GLPs0+edT1px9t0ZeupwlCekwXaRHR8TFgfwnqFb/a4W0NNKv0sHlqqzGMgmj+RFvx8itJfgrM35UTfI/YEp97c3iMoRbHmlBEmd0bID2aQvMh6crVvH7ILYBdeziUYkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885923; c=relaxed/simple;
	bh=avwxNtT40A34TM2YDGD8SvzjDMAo/ZYj98kw9wlcmGg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uyga3tMVPAMFlFs8tJp2m0dnfyQzdiuFx8DY9oZcCkqTNZm1YWKuUQ8NK7B+jT/lEgQNpi2D6x9Ld6/hzue2KW09ZmpSp5Pmdoh2iGP0I3pSHnx4Yc9cgnsm1534Phw5vbJ6eFibqqNMyr9J/asY05A72XCNxPWBCJau/Hbtr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maoIb0/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maoIb0/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099E21F000FF;
	Sun, 20 Sep 2026 06:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885922;
	bh=geNGn4C2pJqlTDqNkg0tZC7YIQlCrikiTrXh/7yv5LA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=maoIb0/717LoBRVlyKbm85RplU9KDwzB+PQF5hNh8seeqQje8B0iS5SPq596EjPEK
	 PBkAfJabZcjFVwr59oAoojObqJzSRZYibUK/b+m/R7+1H92kNVjcHkvV0d+WPtegHk
	 nJ3eJew2oze1QcLCp0AFfPQ47tGewXb8+1x4T/epOlBhXeaN/krjDHCohwqqbyCKCe
	 nJQzzP/Qhojt9yZFw49Qw8D118WylM1m8rFEVbvGf2VhvfTEXLi+VKyHomSBZqcEVv
	 s6/rDWdm+13BaCNWOs/MSJ7+IAdQt9dSxrUOvOL8J7/MPX1Kw8Q2S4D1YGYs8zGYk2
	 5/siKAldG+sog==
Content-Type: multipart/mixed; boundary="===============4297463096430455290=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07aee6cc56444ca1d1bf88284b8df9d9fdaa94ddd7f00c50eef6b7a20479632e@mail.kernel.org>
In-Reply-To: <20260920054231.865520-1-yonghong.song@linux.dev>
References: <20260920054231.865520-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 01/20] bpf: Accept the compiler's exception cleanup table at program load
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 06:32:00 +0000 (UTC)

--===============4297463096430455290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6330b7d745c5..a69cc0427575 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1669,6 +1669,9 @@ union bpf_attr {
>  		 * verification.
>  		 */
>  		__s32		keyring_id;
> +		__aligned_u64	cleanup_info;	/* exception cleanup table */
> +		__u32		cleanup_info_rec_size; /* userspace bpf_cleanup_info size */
> +		__u32		cleanup_info_cnt; /* number of bpf_cleanup_info records */
>  	};
>
>  	struct { /* anonymous struct used by BPF_OBJ_* commands */
> @@ -7599,6 +7602,12 @@ struct bpf_line_info {
>  	__u32	line_col;
>  };
>
> +struct bpf_cleanup_info {
> +	__u32	begin_off;
> +	__u32	end_off;
> +	__u32	landing_pad_off;
> +};
> +

This isn't a bug, but would it be worth a short comment on struct
bpf_cleanup_info spelling out that the offsets are instruction indices,
that the range is [begin_off, end_off), and that records must arrive
sorted and non-overlapping with the landing pad outside every range?

A producer other than LLVM has to read check_cleanup_info() to discover
the rules, and insn_off in struct bpf_core_relo in the same header is
documented as a byte offset (line 7750: "instruction offset (in
bytes)"), so the unit is genuinely ambiguous at a glance.

[ ... ]

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 6330b7d745c5..a69cc0427575 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7599,6 +7602,12 @@ struct bpf_line_info {
>  	__u32	line_col;
>  };
>
> +struct bpf_cleanup_info {
> +	__u32	begin_off;
> +	__u32	end_off;
> +	__u32	landing_pad_off;
> +};
> +

Same here.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538
--===============4297463096430455290==--
