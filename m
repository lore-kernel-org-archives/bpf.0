Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246719;
	b=QYGAL8Pgfl9HNXkAFvF4jCxsCOXQKJuw1SClGQrtM7K1V5rqvKWg4O3deE9o831+9dPK
	 7W0rAUqRgBoXOOZAjCwjTtksPyGIFPy2JqSGJLQZl5XBnEIKXZu4Ip76fyZ4uaJwu70P+
	 A58bQu/yiOAtbxNypegW6VOmWPEFSEBcG0GaQ+komHFGf87AsB6PQp7WBAI4O6v4GNWuf
	 MDZMs2qgiBzShOVGuxr5zHEZv7LQq2eWOW+RcYoi8O2HRNaD7ouAQi50aPKHTqvTKSb4x
	 mRapJ0lImz9cxoEaCuivj5SkiDV1HFppLkD/0QwIkF7PHv7EMhvU2ZZM10zIfLpOwow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246719;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i9Nv6xGB8Ae4NNlgpZyPMXjBlowBRSDkMgoiPDc8DSo=;
	b=k8Vo4ej4R/ZsFzQl2SnPEz4dOXAo3UXoXg1K8g1Co/co098JdtOcgS2lcMiCyBbJvgFh
	 GI/aThaXgnhO0dKUJkYylUEKqwzZ/1zmhfVlUNKMDcKV7O+dVcN39ZOuJnSY7DtP4kH0O
	 EYkhYaUZjHCESSrU6aBgo0Dtf1FLtYmB0aM3LGsB6MBmkpSW/I2jYVgm6MZ6b84Insgp+
	 0VuYpX0ILyKmyhaHo61S6/irKIjAmiospA1BOWr4WwR6wLe2nF3dyHs2vFuOS9L+IAUEq
	 BRP6AEBB4FmgNTQKSaUOGxn27/F+sBKM1G0R3NdB7RO5v+UQGrUsTqgJhzcRcXRnoTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYB6xKK7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745A606A33C;
	Mon,  9 Nov 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYB6xKK7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECD01F008A5;
	Mon,  9 Nov 2026 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246718;
	bh=i9Nv6xGB8Ae4NNlgpZyPMXjBlowBRSDkMgoiPDc8DSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZYB6xKK7ikHLcp12dpkvJj5Weru/Un6Bp2RAV9c3ZnLngBPdNf7jlFa/6pacFIadc
	 d/pGjG87WyjjJobuh5kFUC1OQAoc9bRk4WC1pDEeCGQuKci+PF+Uw0eYMsHcnjtlLP
	 s++NIZ8IZuJTW/rEM1mTa4fGTme1jNwWHMubKfSQJSK6DIM7cFtopEW3DmaocUcma+
	 CZXeDcWWnJz/AQVG1Gi3dP+iUzHahrZq6fKhJALiuBAIAGyYp7ziI2PuiuN8h+dcYJ
	 nZjhtm8jNVudg+OXggV+9PHXgsxCrRE+ebIE0fV+E434lKUuqdYNDEcCFPIw0naYPj
	 J7wdNcnd9Gi2g==
Date: Mon, 9 Nov 2026 14:51:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Alan Maguire <almagui@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	llvm@lists.linux.dev, ast@kernel.org, yonghong.song@linux.dev,
	bpf@vger.kernel.org, kuba@kernel.org, tj@kernel.org
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
Message-ID: <avIIO1JOVnK8y3a7@phoenix2>
References: <au27Y9m78_3EH2v1@gmail.com>
 <a69dd097-7e71-41f0-9a6b-eda001773236@linux.dev>
 <au347UiVUe5oUuxM@gmail.com>
 <au4kpSGVSH3tYiZm@google.com>
 <avG9bk0kxRUvonhD@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avG9bk0kxRUvonhD@gmail.com>

On Mon, Nov 09, 2026 at 04:33:40AM -0800, Breno Leitao wrote:
> On Fri, Nov 06, 2026 at 07:05:25PM +0000, Kuniyuki Iwashima wrote:
> > On Fri, 06 Nov 2026 07:58:01 -0800, Breno Leitao wrote:
> > > On Fri, Nov 06, 2026 at 09:16:24PM +0800, Jiayuan Chen wrote:
> > > > Thanks for the report !
> > > > 
> > > > 
> > > > On 11/6/26 7:38 PM, Breno Leitao wrote:
> > > > > My arm64 KCSAN builds of linux-next fail since next-20261015, because
> > > > > bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
> > > > >
> > > > >   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
> > > > >   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
> > > > >   Failed to generate BTF for vmlinux
> > > > >   Try to disable CONFIG_DEBUG_INFO_BTF
> > > > >   make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
> > > > Has pahole fixed this issue?
> > > 
> > > I don't think so, see the line below:
> > 
> > Could you try this ?
> 
> Thanks, it fixes my build. I tested it on top of pahole master (9eb594d)
> with next-20261105 and clang 22.1.3:
> 
>  - arm64 KCSAN, CONFIG_WERROR=y: vmlinux links again,
>    bpf_tcp_ops_set_rcvlowat() is back in BTF, __bpf_tcp_ops_init()
>    returns 0, and progs/tcp_autolowat.c from the selftests loads.
> 
>  - It also brings back scx_bpf_tid_to_task() that was work arounded by
>    tejun.
> 
> Feel free to add my "Tested-by: Breno Leitao <leitao@debian.org>" tag.

thanks, I'll check this later today,

- Arnaldo
