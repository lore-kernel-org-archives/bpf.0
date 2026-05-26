Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5613C4B86;
	Tue, 26 May 2026 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837063; cv=none; b=hN/VdOcrWbhq0vaNw/jn/AloMr14X1OTbu0EwrNtAO/r9wwpC0x6lxThFJ13Y1gguy3dKt2XcSfMig9UayA6vQtrLqtCOfMz1quZ/ACOkrcKRo6GcXjXHYuHdJ58iq3RvhJou5rYT8JtplMtb5DmwIhnVIo98cMyGqCXNuc50Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837063; c=relaxed/simple;
	bh=bc6+1BBrKtJ+ow8zT5hzg4AJG9zCu5/Qd7LFR0Jmlho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtiKcX4wxnM/JMBQB800wnPlDip0UuTkjIYcw0oEbuoiAqTWN4TOXIiaRPIjRnEKR7VjRESaCgzhrzIegyIFZ1igZawdbJcatfNQ+oXFuhRVVeKO7Ku7dzKSoyoK9Wg55575p4FvkKsM/9g5Xi2Qzbn1XMyp2WpJEYIte4/39no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuQyOPGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuQyOPGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D076A1F000E9;
	Tue, 26 May 2026 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779837062;
	bh=AzggQS+B8+GNoAyc/brbiV6G8bezGg+0C+i59qC/4LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PuQyOPGZJ5praIkU9vszxj9Wl8ds06s6StGnfA2raglzdxYtU0SV5xSrC91Hrh1Fp
	 0XSolYs8ROLVWutxEBXi4C0oTjneLrT+zQVbTnl8QEVSf7B5VEHMoTzgzSHkoVYQc4
	 9r3IsaxrIGGI6HS3+191CSTAU35Dm6m54agmdBQZ7Ev5h2rR4lNzuKwQcfdAIXuKQb
	 zcs/1GbKpUl4YsKktIlgZ5ftOnohApxhPNxGeksa6cHv74dBGXlECbCOvtsP36IJnR
	 dvMP6Si0wzzFQA1c3Zv74GrtOr8Qo2P1Fdo7EjncU2uNTjrSiHpqR3Cxbw8ZssCvxF
	 CaC8sWbps67BA==
Date: Tue, 26 May 2026 16:11:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Christopher Lusk <clusk@northecho.dev>, John Fastabend
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Message-ID: <20260526161101.691d4cb7@kernel.org>
In-Reply-To: <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
References: <20260526025154.60607-1-clusk@northecho.dev>
	<d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 14:44:24 +0800 Jiayuan Chen wrote:
> If async_capable is set to 1, the zerocopy path in tls_sw_sendmsg() is 
> skipped.
> Unfortunately ktls with bpf_msg_pop_data() does not work correctly under 
> this
> copy path.
> 
> tls_clone_plaintext_msg() aliases msg_pl onto msg_en's plaintext area 
> (in-place encryption).
> 
> BPF runs bpf_msg_pop_data(msg, 0, 2). This shifts msg_pl's SG entry 
> forward by 2 bytes.
> The two SGs now point to the same page at different offsets. Physical 
> memory overlaps but the start of
> address differ.

Ugh, do you mean that the memcopy path is broken? There are other
conditions under which we may fall into it than just !async_capable :(
Small send with MSG_MORE is probably the easiest?

So we need to fix that one way or the other.

> I think selecting a sync provider via mask = CRYPTO_ALG_ASYNC is 
> sufficient to
> remove the -EINPROGRESS return path.
> 
> May be time to remove skmsg from ktls? (disable by default first, 
> re-enable via a new ktls module_param?)

Yes, we asked John F off-list to get his attention and I think there's
only a vague plan to start using kTLS + sockmap, no current user
(sorry if I misread / misremembered).

module params aren't a great API. If we want to deprecate it let's just
remove the integration in net-next. You have my vote..
