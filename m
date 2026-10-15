Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC62857F0;
	Thu, 15 Oct 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058663; cv=none; b=TLtF9xeZMkUVxdEUPGUvxj1Mt068aJkze+DLbHMHwX+di7YCkmpvQMDzSGh9gcnW76pyTO0xzVMnDafcqW84xQ1X2/H3aedgUegCZ02rPA369Ih/41+Yb/4MOUmYNVQJkqy4WoNB5QfOhXQCCYwfwpDFC1sBLUNKbel+HIfxb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058663; c=relaxed/simple;
	bh=KqNNxD2OjJPw4D8B5cKRGXuUpP91XbDtKcjJq+PdqbM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEeHBncHFAOCVLu0gURGZQkb/z9ED4ghascIswlDzFP9pmGnD0FkyEa30/8rs8X0DKnJ0fBm4bVeXQAEONje+S5C7U28wiC293s1nYozd5eBGpL1TXWjrrQw4VCBTsDro/Nl2pt7sjEj4Vq0A5j8O+bU8FjdGEFl3+hm266F9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hBzv9aHw; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hBzv9aHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792058648; x=1792317848;
	bh=KqNNxD2OjJPw4D8B5cKRGXuUpP91XbDtKcjJq+PdqbM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hBzv9aHwSJ1kvYuliY1sUFd/brMd3gbHUbBpUp1Kknbpqer6SyeKvqxm8pTbKa0co
	 t148/qDf+IpxUC6Le6P4Ol0HKqxpPwgXGt3zDGwnAdMIXNPmHgs5jciGcuYrc4qxDN
	 plb+3pylJbYoJFGjEF5qxu0P/PR85xeVIZGqvh+667eoO2T25EZGpV8JaR0mJKSZBW
	 U0c1kJnlCimH9ttMi+JJnwN6qrHGP4ej6oXFfptqzJJKUkd0COJ4VGMJu6B3ftlNYD
	 8zYWThlKX6HeJ62h/tGwo1R3WQLDdTnOQXwEM+yILT7YHEAcv64zm6rOBiwhk6d70X
	 BLh7qOMu9aM5g==
Date: Thu, 15 Oct 2026 10:04:03 +0000
To: netdev-bot+sashiko@kernel.org
From: quanyeyang <quanyeyang@proton.me>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: annotate lockless writes to sk->sk_err
Message-ID: <yVQN6TUqMA6BBX56Q88K9w5fbBFb-krlHV8Js-WIDc1hDa4eJarrpechiGSr5ACp1IhDk1ERWbVNkhdf0zEZmKU8dGpscTGYkEoYRpfQTQQ=@proton.me>
In-Reply-To: <179173140698.434549.7333602875262073825@kernel.org>
References: <20261010-tls-fix-sk-kcsan-err-v3-2-e28aadeb31ad@proton.me> <179173140698.434549.7333602875262073825@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 04702fdd5f9fa0f3f7cd89e0b59677c27c8fe7f9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, October 11th, 2026 at AM 8:10, netdev-bot+sashiko@kernel.org <ne=
tdev-bot+sashiko@kernel.org> wrote:

> Does this cover every writer on the TCP sockets that strparser
> runs on?
>
> KCM still reports errors on that socket with a plain store:
> report_csk_error() { csk->sk_err =3D EPIPE; }

report_csk_error() is a leftover unmarked store on the lower TCP
socket that strparser is attached to. This series only pairs the
writers on the TCP/TLS and sockmap paths Paolo asked for:
sock_dequeue_err_skb(), strp_abort_strp() and
sk_psock_report_error().
KCM, SMC clcsock and UDP/raw/ping stores are pre-existing and
are left for follow-ups. I will not fold them into this series.

> The subject line reads as a general annotation of lockless sk_err
> writes, but the body doesn't say that the conversion is partial.
Agreed that the conversion is partial. The remaining writers above
are intentionally out of scope here.
> report_csk_error() above never uses its err argument and always
> stores EPIPE.

That is independent KCM behaviour: userspace sees EPIPE through
SO_ERROR by design, going back to the original code. Not changed
here.

> Should this read also be a READ_ONCE()?
> __entry->error =3D sk->sk_err;

The inet_sk_error_report plain load is pre-existing. A stale
errno in the trace event is acceptable for this patch.

thanks
quanyeyang
