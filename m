Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F915499F0E
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215717; cv=none; b=CnWN26KVEpkX3G/Ra+8GpGXVQN2TCXnzQwPpAj0WyGeRQODGEgM3noTWvEW2lyTmAna0BYcrw6evuD2/7SCfknR57++8KQP0XGdrQPDahDEyn5k30evuGHH++lnYjc5LYL7VashrgwHqsufVssvmuMvNHZpW1gXVr7rfUgVf850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215717; c=relaxed/simple;
	bh=OItHQTxpJydXgBe7Aq8mnzJt89ss63u0izxaIZUdGWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpjGwHrw3G2ikHnH37fpGAF0PBbymRAj2TUaE+V958sNJq1knHUIg9hdyRyqrJwpn4+ykCru7Un3Nm0Y/rcvFsOSc+lEYik1VLHMoGJ+nYYFis41AwtmA5Q7U6i3fG7lErcBcg49yXJ/SmsHe71k7cxwxftrE9KxzOBF2+LWpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBXYJrRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBXYJrRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05E81F000FF;
	Mon,  5 Oct 2026 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215714;
	bh=QL+0q7AoyDveXwdlbJa/sjkik64DigNWdajB1VzhiF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GBXYJrRd7vLl0KQeuvF6v1iY80w1LXVH27PNhOkBuIrgyndKQ5t89FM0q67OXS0Jm
	 9orXBVl3MbmljMK78nLA55S2jZc+7R+dcT8dGHXZ7DhgBNVFcJzo+Xm3uf5OqFvGks
	 Nle0PkBE+AqYQd8bnvFVuN3qweGIf0TnLihGU89+3vZe0eK19ncMNlsy5j8cbiq+Tf
	 gtg462ECkmiKpwk3vG/Gee1tPIy4IcKIcVdV1akBoj9lAIBbbpMj4LY8rbYIt8TlTw
	 uO8I0JbIuWR3d6VRM83vtdfFz6X/lfHPEX7Cv+H1tMJXc3wwqt+cVPoxsR+74UjhTj
	 n4Vc26Vdn3jGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261005154533.4147685-3-kuniyu@google.com>
References: <20261005154533.4147685-1-kuniyu@google.com>
 <20261005154533.4147685-3-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 15:55:14 +0000
Message-Id: <20261005155514.C05E81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tcp: missing documentation update for tcp_sock cacheline
--

commit a581d0e37015bf601147a1857ac83871b8f4eae9
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.

This commit introduces a new per-socket flag field, bpf_tcp_ops_flags, to
struct tcp_sock to avoid the overhead of the legacy SOCK_OPS approach and
support fast-path callbacks. It also adds a new kfunc,
bpf_tcp_ops_set_flags, allowing BPF programs to atomically enable or disable
these flags. The new field is placed within the tcp_sock_read_txrx cacheline
group.

Link: https://lore.kernel.org/netdev/CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX832=
wUFOQ44fOwDnQ@mail.gmail.com/

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h

[ ... ]

> @@ -233,6 +233,13 @@ struct tcp_sock {
>  		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
>  		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
>  		recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
> +#ifdef CONFIG_BPF
> +	u32	bpf_tcp_ops_flags;

[Severity: Low]
This isn't a functional bug, but should
Documentation/networking/net_cachelines/tcp_sock.rst be updated to reflect
the addition of the bpf_tcp_ops_flags field to the tcp_sock_read_txrx
cacheline group?

The tcp_sock structure header explicitly mentions that the document should =
be
updated when adding new fields.

> +#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) \
> +	(READ_ONCE((TP)->bpf_tcp_ops_flags) & BPF_TCP_OPS_FLAG_ ## ARG)
> +#else
> +#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) (0)
> +#endif
>  	__cacheline_group_end(tcp_sock_read_txrx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005154533.4147=
685-1-kuniyu@google.com?part=3D2
