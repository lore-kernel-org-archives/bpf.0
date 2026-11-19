Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122736;
	b=TgzpZdgpE6X1mATWG+3rtzyQDCzwn/PC8LaSVuMTCTofT+s+c7iVndiixxncSYVNnUAc
	 ykrXWkVi4u+dTp+PPch21MeU38MKn0OPNO1Ha785UovVEf2RtDxCPWAjqlzzZ6BQLCnKe
	 AxfOAvNm/o79KYElbar+pW37la67VoWcGnVwvy8i7gfmkwFuZqzfM383zzr/HnRhdHisd
	 N2SEnCR6ddgQJaET9cqR3q40OMIVrG6bj9fG1OIKTkYWUMkBmplb2OdclOuy0umvIH/P1
	 ZIVkYmMY3B1ACziUQjs/G6zXMd0zY2kdlbxqfIVZJxdlZELSa8oLWCOWF6uVSRPdQcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PPsz8EPWKcdeEfKVGYp9pwNeSXYhC2IpPyvOQ8qfLNU=;
	b=JbmqiDiZTcltR87ei8+enNQsk8SXXWrQIe5+lzeljI5q4TUTPBGFUax0HJm9wiB1Jtgg
	 F2xRaaZKlzSSoXuJPDmYmb8ffNtgB6Z8NV0YAA+MIDyswznc6NBHrJ958idXn66+KejbY
	 eaZLCau1lH0u4jj/wRvWUqdC+Ouwtkrukp75NxJSutCh1nVZMxIlI741HhTnMdjQe8db1
	 9uL+nM5w4TiQgX5RO3qbp1Ek2Yo8xfAWtUuclseMWI/EDZOqzyjlPfCewkOTysH+/DN1v
	 2zoLRkrgjUrWC2TbVS3Kg3xC9JRpijGdFTWer1Z2qBu0wXf9yWLGZiTZLfCIrHwwrCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elTwXLSY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F07606A320;
	Thu, 19 Nov 2026 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elTwXLSY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E37F1F000C0;
	Thu, 19 Nov 2026 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122736;
	bh=PPsz8EPWKcdeEfKVGYp9pwNeSXYhC2IpPyvOQ8qfLNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=elTwXLSY2aQ/A+on2z7+cdJtgueL4VgRLQN+A9ICWwwxPjwPJt5sImilvUU0BuatH
	 rICfaY7p6i5P5KRW6mdIoaDnnW7oWNd4gFZwrm7vdEPIqvj1sEmabAqPTdYFFHqRMb
	 W/mMV3GUtefPaqviMy9Jh5qJ8hC/vES7L+FsfjU9OcmczAUVRvCu5dP+UveU4NPV3m
	 4DlKgRV3Q1pLF/1aGwIh5G7HncJ+2oK3qSBghlTd68IJVccimHqpDBhrkxavVcJJ1f
	 8IEY6O9MDETdER51fkzGoHiPdwxRG+bfa9mYJOTDcpJW4SyHKg+VVoyEY/+KOq+9hA
	 CcNfekYXW2rDA==
Date: Thu, 19 Nov 2026 13:12:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: Tianyi Gao <tianyi@cloudflare.com>, Hangbin Liu <hangbin.liu@linux.dev>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
Subject: Re: [PATCH net v4 0/3] selftests: net: veth: propagate check
 failures to exit status
Message-ID: <20261119131214.0b38c1ae@kernel.org>
In-Reply-To: <20261119012940.32838-1-tianyi@cloudflare.com>
References: <CAG4wq-d_30-B4wQZu48ZQXAORM4QxRqPfmYsmoHS0hiYp1EtTA@mail.gmail.com>
	<20261119003003.40482-1-emmaonana18@gmail.com>
	<20261119012940.32838-1-tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 01:29:40 +0000 Tianyi Gao wrote:
> On Thu, 19 Nov 2026 01:29:59 +0100 Omokefe Emmanuel Onanaroghene wrote:
> > Changes v3 -> v4:
> > - Patch 2: use if/else instead of "&& { ...; } ||" chains, keep
> >   lines within 80 columns (thanks Tianyi for the review).
> > - Add patch 3 deriving the invalid tx value from the kernel maximum.  
> 
> Sorry for being annoying, but I see three problems with how v4 was
> sent:
> 
> 1. Patch 3 lost its subject prefix. It went out as "[PATCH] selftests:
>    net: veth: derive invalid-tx test value from kernel max", so
>    patchwork put it in a series of its own [1].
> 
> 2. Patch 3 should come first. Patch 1 makes a chk_channels() failure
>    fail the script, and from then on the nproc + 1 check can fail on
>    a correct kernel. With the fix first, no commit in the series
>    reports a false failure.
> 
> 3. v4 was posted as a reply to my review of v3. A new version should
>    start a new thread, and its change log should link the previous
>    postings [2].

On top of the points Tianyi Gao already made:

 4. Please target all your "fixes" for selftests at net-next rather
    than net and remove the Fixes: tags. None of this is worth applying
    to the current release.

I'm tossing all your submissions from patchwork.
Please don't forget to wait at least 24h before you repost anything.
