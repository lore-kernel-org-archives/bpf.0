Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F447F3D7;
	Mon,  5 Oct 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217638; cv=none; b=DfUc8gNjsZsvmsNsGRjVsjqMnx/H98zS0ERYdveWRgsPDiNUp5BTbueDny78Ffle2fHm9UO8jy1ZzUOx59lqKc9fUbwzr19ZlzJvgOBApTUAIMsx3nP6EKq2PNi1OPLe0egeRGob2jUazTII53Ejbqy15AzCb5R8lJdtaLbrhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217638; c=relaxed/simple;
	bh=nnQjx7eVynYa2IRFZwwTz+5fbfHl4ao1Wh9Em/tBzvM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NEAmSs5sg5OpxqLfxSp9Y+Pg/SXrdYcDDHujSjZi684ZJcu/A/lyqJFnW8gDYUdNAdOCGdEW0V/5kaZE04v7bXnwzBxH1mKJ8P3LyQL88a2+Jpg2rFqck6SphSv8vrOnd0pC0eTRAoj18ZVLqZuW6IC/eQSfchqJmZ04YMlMqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHbqQ/XD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHbqQ/XD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EEE1F000FF;
	Mon,  5 Oct 2026 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217636;
	bh=wa+W30oC1s4RlHb2Hb+fH+MzyXYF3Gcm2grKCI8PcgI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hHbqQ/XDNXbTlgp6s1RQZqd+jOuUPCatQMS6iolLyQxt8H2zzESvtwKrHWujn6Zkf
	 5woKjH07GF711sgiz6x/2nQKAZyWlzwS3T2D8v5TwtorH1ktiHeiPrQ+5rYdE4dbl/
	 dL3VQ5sUqEiTo7OE2xWQb9Nn+IByJKcDcurK7/SMSpBC4c+90rjCGxSxhR9A1EtB/g
	 IUt7BvC0d77UQVMzwdyGXb8/ynwYdJszOKlwGWrupaUg2HP7c67yfZv7Rh5XDvjLxF
	 Ujqk4Vl5XuSwdGeHClQubgPmIrbePTSg+PxCv1vsikt46CA2hxiryICY5KyGJ6CQGx
	 LkzznYNQdasNA==
Content-Type: multipart/mixed; boundary="===============0237022867043872673=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f2dd53b9e73dcd22f0241f1895682fd088338f9358ca4fce1421e00db842319@mail.kernel.org>
In-Reply-To: <20261005154533.4147685-5-kuniyu@google.com>
References: <20261005154533.4147685-5-kuniyu@google.com>
Subject: Re: [PATCH v3 bpf-next 4/9] bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: ameryhung@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@kernel.org,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  5 Oct 2026 16:27:14 +0000 (UTC)

--===============0237022867043872673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.

TL;DR: Documentation only, not a bug: the bpf_tcp_ops kernel-doc for rtt,
parse_hdr, hdr_opt_len and write_hdr_opt doesn't say sockets must now opt in
via BPF_TCP_OPS_FLAG_*, and the UAPI flags are undocumented.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index a12766e38ad4..0f2ceda58319 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3142,7 +3142,8 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
>  {
>  	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
>  		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
> -	bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
> +	if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), RTT))
> +		bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
>  }

This isn't a bug, but the kernel-doc in struct bpf_tcp_ops no longer matches
what the code does.  It still describes rtt() like this:

	/* Called on every RTT sample.
	 * @mrtt: the measured RTT, in microseconds.
	 * @srtt: the updated smoothed RTT.
	 */
	void (*rtt)(struct sock *sk, long mrtt, u32 srtt);

but it now runs only when the socket has BPF_TCP_OPS_FLAG_RTT set.

The same applies to the other three callbacks this patch gates:

- parse_hdr() is documented as parsing the options of an incoming skb on an
  established connection.  It now runs only with
  BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL set, or with
  BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN set and rx_opt.saw_unknown true.

- hdr_opt_len() and write_hdr_opt() now run only with
  BPF_TCP_OPS_FLAG_WRITE_HDR_OPT set.

None of these comments say that the socket has to opt in, for example by
calling bpf_tcp_ops_set_flags() from the listen() or connect() callback.  The
BPF_TCP_OPS_FLAG_* enum in include/uapi/linux/bpf.h has no comments either,
whereas the legacy BPF_SOCK_OPS_*_CB_FLAG values document which callback each
flag enables.

As a result, a program that attaches a bpf_tcp_ops with only .rtt, .parse_hdr,
.hdr_opt_len or .write_hdr_opt, as the struct comments describe, will see
those callbacks never run, with no error.  Before this patch they ran
unconditionally.

None of the later patches in the series (up to 3cb5919af2b2) update these
comments.

Could the rtt, parse_hdr, hdr_opt_len and write_hdr_opt comments say which
BPF_TCP_OPS_FLAG_* has to be set on the socket for the callback to run, and
could the UAPI enum values be documented as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37336989320
--===============0237022867043872673==--
