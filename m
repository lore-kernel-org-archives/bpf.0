Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94B4973BD;
	Fri,  9 Oct 2026 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539181; cv=none; b=uF2cWyMgUc0zzx4u2JE5+n25utOyUOwJC3ut5VD4EPtrwJ5VWirGwUKM5e8lrH2/uesFmfJTeZ8n3UuyRwbxtkUvZBNw8aX3KGjvCeTwoq8hTLtq2cz55XHp1Nq1o1g13s4kqhNleS9edc+BqPXKidLoG5zy3oP/kFIB6v5e11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539181; c=relaxed/simple;
	bh=WfE++gUhAlPuNalTpCjqS5a5h1siT2X5fZdoO85kX+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPcQtWqyuV9H5CoEWTQX1kZhT3B/woDcmjLe29ih5xGYEKauO8HYLj2qSjoaNn3igINpY6jdtAYt5qN7xxL+GmN0Sm5z4mcXEyv8Qf9wxXzoByZ309koPskc7/tlvubGEPuoLrvy7vDPw7JtXO0k0pzbWgjSFIfs07QCQilvj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8VfNaaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8VfNaaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CD21F000FF;
	Fri,  9 Oct 2026 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791539177;
	bh=WfE++gUhAlPuNalTpCjqS5a5h1siT2X5fZdoO85kX+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=l8VfNaaVZpPap4QzG9w8nFypVOQchkcb76RbY2I7xKiR5lgKQEmxScn1SINrJ5ygw
	 rsRW/Iy5UnruaR+1u48Bozs3Q3NSM6eT7yx/IJoX9LDSePKRdv2eICRJPslyoruhqa
	 eBr/IGBOBEwFtzvFUdquxYU+ld+DD1q+OOYoNkvXvEnWiqjuTT7K7oUMAhUFNirxNU
	 aNCjH096/UYnzxWjn5joMj3hQpveRxqw4bMleb8koZPWUzdTJI9zKl5Er3BMXzqoFP
	 k14rjbOaugvEospdpSluDdmuuDYWFqsgdOAG67SmBua+hiCO6NOkhe/wdD2iUunTMU
	 MK923p7ihiq3g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net-next 02/14] selftests: xsk: drop the
 single-interface loopback mode
In-Reply-To: <20261008114909.734364-3-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-3-maciej.fijalkowski@intel.com>
Date: Fri, 09 Oct 2026 11:46:12 +0200
Message-ID: <87wlrrqk9n.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> xskxceiver -i ethX -i ethX was dedicated for HW tests and both sockets
> were bound on queue 0 of one interface, which the kernel only allows
> with a shared UMEM setting. That mode is going away: the endpoints are
> about to become separate processes and would have to share the UMEM
> mapping and the socket fd across them.

I'm *not* asking you to add anything, but curious if the HW
loopback-plug mode is supported running two processes?


Bj=C3=B6rn
