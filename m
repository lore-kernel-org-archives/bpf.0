Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725216;
	b=Dqv768T8W5QqNZ7yWcnJH2OmUcNnf4qbZZUxa7mb6MCQhetv6DtzTo9+9UEUQ9aHnOoH
	 galuvQxfYEDIit4IeeLc41UZ+5/qDpTKqWnBMaXYEwiMpk7LLdurtvZsW5ViNysNbKvx1
	 7GqH/1s0mW7u83IiRwOPJUgp+6k33Vq1/qwsfw5SNFY7z703WDhGAqOq/b9hb1LTRCWAP
	 ZiZA0vJV4ZP6Se6kdS37G9mj4oxwKmeCf60YPj9ZC2CIL3UDjyngxJrkGST+ewY/ps20q
	 stwQAO/Uut2I2vQ1crXEFLBG6uOeJvq7MJXcdPS68MK2QJwIrzgDIPB9ftTogZbKovQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725216;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=j0lOazSlpqZPrAY6B6EZh8T8S4V13+7bnpdjejE/rFU=;
	b=CyNJGgKsfLPUI2AQiH0k/tPZTMfmckcncc1Xo0Mz0O7sZN2e5zo5hWOz9+6YuU1iQjZx
	 L/ZHXbC6kdhcOChwZfM3XD52dx+wzzrxMj+B0lKSfl2/qLcBB71QTDZVipDnfwgIL2yf1
	 cDBT0UxmvBD5sgo30imXBNBCKuaJ7gDKoFf2tYLXh+SfvnqbYzVrzDatwpaN1MoVOlCiD
	 wzIeDbQ7IY8oHdb+gYNOrIAbSXnljZh3/gdFlJ4g4pKr2elL1P7Mk5Y+UKhzswzRN76r4
	 m6dfXTQdiQtGfYDMQTPiMlCX7fbI8kp69E4BYeT0q57lwmVAPfXCWdlWfpEvsEiqdqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/AG4Jqv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655B606A31E;
	Thu, 26 Nov 2026 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/AG4Jqv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300F21F00923;
	Thu, 26 Nov 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725216;
	bh=j0lOazSlpqZPrAY6B6EZh8T8S4V13+7bnpdjejE/rFU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z/AG4JqvEW2GjgD3GVwYfKM4atObtDtAPdofFEwV1awXHaqrpIiZbWlrmfU9lHKCl
	 AI3/BnmQkTBvmj2qbSeATlJ1dyRsDqA0msGnDO6SzzsaeEkeYGygZ1T79I7gBIG8EK
	 VY1Ypz7R9yq9pqDCzNJtcAJtpWitK6sxmqTZSiVthcdeEiqXCrh6xe0zSKv4POQt+e
	 7A9y20cWBvSYwH7fmx/b82zlo//jmubnJ/RXNimCaIjHa9YJ3c3idEfru53fEOxuVi
	 lOhfVc+ZvsY5GGkzUCo2uDylbsuFsaAk5TkQMDSfGOB89TRgm88G26UcWu/MG2cKaC
	 7MReOUDYgbckw==
Content-Type: multipart/mixed; boundary="===============0196374796151550525=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b2b87080b87c640725acc68ec507cf39cc2ed37d2524036c52326923c8d1eb0b@mail.kernel.org>
In-Reply-To: <20261126194347.42466-3-tphilipp@gmail.com>
References: <20261126194347.42466-3-tphilipp@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Align lpm_trie map values to 8 bytes
From: bot+bpf-ci@kernel.org
To: tphilipp@gmail.com,bpf@vger.kernel.org
Cc: tphilipp@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,emil@etsalapatis.com,ihor.solodrai@linux.dev,hawk@kernel.org,davem@davemloft.net,kuba@kernel.org,shuah@kernel.org,nbd@nbd.name,hacks@slashdirt.org,stijn@linux-ipv6.be,daniel@zonque.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 20:33:33 +0000 (UTC)

--===============0196374796151550525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Align lpm_trie map values to 8 bytes

TL;DR: Commit message only: the claim that lpm_trie nodes don't grow looks
wrong for data sizes with remainder 5-7 mod 8, where nodes get 1-3 bytes
bigger, possibly moving to a larger kmalloc bucket. Code looks correct.

> Place the value at the next 8-byte boundary after the key bytes. So
> that nodes don't grow, shrink prefixlen and flags to u16: prefixlen is
> at most 2048 and flags has one bit. data[] moves to offset 20 (64-bit)
> or 12 (32-bit). Bytes that bpf_mem_alloc asks from kmalloc on 64-bit:
>   data_size  value_size  before  after
>   ---------  ----------  ------  -----
>   4          28          64      60
>   4          60          96      92
>   16         16          64      64
>   20         12          64      60

Is the statement "So that nodes don't grow" accurate for all key sizes?

The bytes in front of the value change from sizeof(struct lpm_trie_node) +
data_size (24 + ds on 64-bit, 16 + ds on 32-bit) to
round_up(offsetof(struct lpm_trie_node, data) + data_size, 8), which is
round_up(20 + ds, 8) or round_up(12 + ds, 8).

The difference is (padding - 4), with padding between 0 and 7.  When
data_size % 8 is 5, 6 or 7, the node becomes 3, 2 or 1 bytes bigger on both
64-bit and 32-bit.  For example, with data_size 6 (an IPv4 address plus a
port), 24 + 6 = 30 becomes round_up(26, 8) = 32.

The growth can also move a node into a larger kmalloc bucket.  On 64-bit
with data_size 5 and value_size 27, the request is 24 + 5 + 27 + 8 = 64
before and 32 + 27 + 8 = 67 after, so the node moves from kmalloc-64 to
kmalloc-96.  The table only lists data_size 4, 16 and 20, where nodes
shrink or stay the same.

The code looks correct, so this is about the rationale.  Could the wording
say that the u16 shrink keeps the alignment padding to at most 3 bytes and
makes IPv4 nodes 4 bytes smaller?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45888065586
--===============0196374796151550525==--
