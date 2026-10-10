Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E543CE51;
	Sat, 10 Oct 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623575; cv=none; b=IhVAhtMUqAsQR8UAqcV82xh6SbNXykQdPZqvWP2iP5Nv7cetPYEbDTkl+SNTvQB7l854EHZEe95dMofoaPHx0lEjfUNktxLbNHdijM+KV6iTNXa3eHBocvlnOJ10F100hEI0lNjXm2D2pNOWFkk2wD+PC+NSlH6qi3qDiVe/lVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623575; c=relaxed/simple;
	bh=w+e/d+wQw75cJdstYI7Azks7iyQurhcuMUttp4+JpZE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OddX0rrhTWJ2lCZRJdY7CgE3PwZHQ0gQtE5ZIWkWmz95pKnhBq8A51hxU8gmaouC4OECxutd5KepDgwrf6ROva3/1I/6t+SRTLVkUQFXRnIrBXDPk4IPfAe8/JlYYQmZGiYrLkR1zGqs9TyeyLVx3aUje5agKuXbI5a29J3kpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaHp22Qu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaHp22Qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B49B1F00893;
	Sat, 10 Oct 2026 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791623574;
	bh=9sxNpLCRy7SFX3hDkefEHGLKXPHk5XrB53mfGHysokg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SaHp22QugWnUGJS1a2wj3Bx96X+rEtDNL4aV5WJJZLJVy9b2X6U3oHhrYBRqbLAVc
	 oFQC7aFkn/FpX1UqAfNXuiUVaXqwPIDvf/MwS/OfkxtTYl2qwUpq5w5dVqcCBt7Wjx
	 ug4U7Eo4kF7O1hYpZV7Hg3EttxtW+2T9SeGNK0i/wyEqcUu6qOZNcIvHSRHxfTCKNo
	 ribGSUQSesMwIvW/WBDZALgRis+MIWdW7ix13kxOsMkdvIOztmhw+jJftABD+70yYs
	 kDDTAbuMBUzWLl1ldlGPaT7nb9XtwlgJat7FC8n8GvH5MgC+6rvafwBNv5l2sWdWwA
	 OHdomLtYdaNPw==
Subject:
 Re: [PATCH net-next v2 2/7] net: cap sockopt_expand_out() at MAX_RW_COUNT
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org,
 edumazet@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
Date: Sat, 10 Oct 2026 09:12:51 +0000
Message-ID: <179162357191.434549.9383804148666639080@kernel.org>
In-Reply-To: <20261009-sockopt_expand_out_v2-v2-2-8ac08c469ecb@debian.org>
References: <20261009-sockopt_expand_out_v2-v2-2-8ac08c469ecb@debian.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Most of this concern does not hold once the whole series is
  applied.

--

net: cap sockopt_expand_out() at MAX_RW_COUNT

This patch moves the size check in sockopt_expand_out() so it runs before
the optlen early return. It also lowers the limit from INT_MAX to
MAX_RW_COUNT. Any size that iov_iter_revert() could not unroll later is
now rejected up front.

> sockopt_expand_out() grows the output iterator up to INT_MAX, but its
> callers rewind it with iov_iter_revert() once they know the real reply
> size. iov_iter_revert() refuses to unroll past MAX_RW_COUNT:

[ ... ]

> Fixes: 0093f7db9c47 ("net: add sockopt_expand_out()")

[Severity: Low]
Is the present tense accurate at this point in the series?

At this commit, ip_mc_msfget() in net/ipv4/igmp.c is the only caller of
sockopt_expand_out(). It writes forward through opt->iter_out and never
calls iov_iter_revert(). The same holds at 0093f7db9c47, so neither
commit can reach the WARN_ON in iov_iter_revert().

The callers that rewind come from later patches in this series: "ipv6:
mcast: convert ip6_mc_msfget() to sockopt_t" and "ipv4: igmp: convert
ip_mc_gsfget() to sockopt_t". For example:

ip_get_mcast_msfilter()
    iov_iter_revert(&opt->iter_out, gsf_size);

ipv6_get_msfilter()
    iov_iter_revert(&opt->iter_out, len);

The same applies to compat_ip_get_mcast_msfilter() and
compat_ipv6_get_msfilter(). Once those patches land, the new cap does
protect these callers.

Would it be more accurate to say the cap is for callers converted later
in the series? Another option is to move this patch next to those
conversions. The Fixes: tag pointing at 0093f7db9c47 has the same
problem.

Also, the header comment above sockopt_expand_out() in include/linux/net.h
still only describes the kernel-backed -EINVAL case:

 * the head of optval. Only a user buffer can be longer than the optlen the
 * caller declared, so a kernel-backed optval is refused with -EINVAL.

Could it mention the MAX_RW_COUNT rejection as well? The new comment
inside the function already explains it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb%40debian.org
