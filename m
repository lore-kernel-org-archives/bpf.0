Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300937FF75;
	Wed, 12 Aug 2026 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502567; cv=none; b=KiBALjczuTXx5cS/V7/MLRscttmIAMYCK6uquFHzALLgXr8SJDL1X1lLEnp9BPQeUmqqF7A22fpNEgqH3jkGctoU0xdQ9j5C/QmDJhQfmKmUaI4ZJGhXsvo9oX7V0tc4MnxNhEmGN86eYJmNBOMVG+s0NLkyq5Gig+L2nJO9f3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502567; c=relaxed/simple;
	bh=oDFHfulUycxw0DpuVWoTmGcGg/O7PDK/p0zxJMzO7cM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NUIIH8hVyhmhklhxLyBGt8R4SnkvHfywBKMssr9J3zfVAwMaJc7eiFzkurZdemz8GcF0i++J84Rpbajz00VeRwPx6GShQsNSVkYb3v/305VeVkA9ZTdJ6CoGbqmlg/JfNH5cpKywjz6UKNQV4fyeojTk8KsxyRKmyvjZRWccTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBJaMb9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBJaMb9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85321F00A3A;
	Wed, 12 Aug 2026 02:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786502565;
	bh=fW9z+0M9bop1+084NH5zPoksBBsVG+Jwh8OLDVcLER4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KBJaMb9J/3uLAMzdd2Jlbcl77MO9QSRmkKvP27H7/6AJ1d+YshRrdxbeFstUIQ9YP
	 BeYzeQkn8V27a4wN4B9j9Zexq5WxKWJuNWNxlL1kPiHZaNq5sVGS/ZF9ET6SwIf0XQ
	 XrkiSALtHYBCueu5jXEY85C9XEaR/hoE2mxnXZrOIQRCk18zGVmTK8BuOoUFw0QPei
	 Q3/pT9PlQIYfSGvO7WFiz9wASHJAowahOKZOJTBMenC2pXPp/Yr5K8V/wIU9jIsm0S
	 iWib3uJTvwhDEAw0WqbpDOF9l+brXC0SFalSB+MGETZFM8LpdE6DMExrvhWy8IxkRJ
	 qvdy0wCbIS5CQ==
Content-Type: multipart/mixed; boundary="===============6653839949441559299=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <97709c816a1c08068dc591e29a29a36d5ccdf56446ed96d8cac3e409b4057796@mail.kernel.org>
In-Reply-To: <20260807134209.3794735-4-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-4-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next 3/5] selftests/xsk: expand XSKMAP capacity and add length-based XDP program
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 02:42:44 +0000 (UTC)

--===============6653839949441559299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> index 023d8befd4cab..543b61df3a2b1 100644
> --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c

[ ... ]

> @@ -75,6 +75,23 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
>  	return bpf_redirect_map(&xsk, idx, XDP_DROP);
>  }
>
> +SEC("xdp") int xsk_xdp_shared_umem_length_based(struct xdp_md *xdp)
> +{
> +	void *data = (void *)(long)xdp->data;
> +	void *data_end = (void *)(long)xdp->data_end;
> +	__u32 pkt_len = data_end - data;
> +
> +	/*
> +	 * Route packets by total XDP-visible packet length (data_end - data):
> +	 * - Socket 0: packets <= SHARED_UMEM_LEN_SPLIT bytes
> +	 * - Socket 1: packets > SHARED_UMEM_LEN_SPLIT bytes
> +	 */
> +	if (pkt_len <= SHARED_UMEM_LEN_SPLIT)
> +		return bpf_redirect_map(&xsk, 0, XDP_DROP);
> +	else
> +		return bpf_redirect_map(&xsk, 1, XDP_DROP);
> +}

This isn't a bug, but could this comment be trimmed to a single line
like the one in xsk_xdp_shared_umem() above, and the trailing space
after the opening '/*' dropped so checkpatch stays quiet?

> diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
> index 45810ff552dae..bd9b5dcf8c8ee 100644
> --- a/tools/testing/selftests/bpf/xsk_xdp_common.h
> +++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
> @@ -3,7 +3,8 @@
>  #ifndef XSK_XDP_COMMON_H_
>  #define XSK_XDP_COMMON_H_
>
> -#define MAX_SOCKETS 2
> +#define MAX_SOCKETS 4
> +#define SHARED_UMEM_LEN_SPLIT 64
>  #define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */

This isn't a bug, but since xsk_xdp_common.h is visible to test_xsk.c
too, would it be worth deriving the test's short/long lengths from
SHARED_UMEM_LEN_SPLIT (or noting why 64 is the right split) so the two
sides cannot drift apart?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31554903166
--===============6653839949441559299==--
