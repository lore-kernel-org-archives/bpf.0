Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542266;
	b=ksE4rEP5bJ15TAfYlQAHYHR6DPu98zrnFq/TtUx92u2cQj0mgLU1xIka/CVJSqa0eD+X
	 lHsPJKMKT1TerfftWXyLXcrl7YynOWIjrAJHOgYCv/bZpECF1WcvzFvvxQs943FCwfiww
	 bws+GKUyF5nffpktg/tOfOmnCJvMiiT9vXshYqb9/Fij7hTgIZ8d0Yy1WaU5xtdPP/WIo
	 oXFH6Gzqb8ahGafiQDw9Gv00MAktnWvyzBM8P2REGp8uQVachYkiiG8kGiBpwZFxD/2Jj
	 5kYrZTBzEJIp1vbCGQqwA27AFTNqykzKi6t75/8JM2Jm94gV7GRU011Xx8v1KjK6YMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542266;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gPLta/nV5eQtNnkfwbLJs75/z2OZWm1tFtQ59yVOjqk=;
	b=uMfN8axV2zI4Jd+MYRM0GoEZnFaV0wvXZGw/Vj9n9nnyGv3fNCrYyo+ebZt5RUMafkKo
	 W6PjVCRlY9+zQKhvhzoMCUcmWOmPaFv8cTmE9OfxEpW3vwcFaCmjiJF8EWMtVHKizHB3V
	 fHMt2aMUmFpUxytYK6Ve5OAHQZJqy9TZzik4SBvbUxUmxLdmEOXy95U60G2lJ9lnp3btp
	 X7Or9p6JFBJz1yFhH2ZeuI/iPs2h1RbqT0dtMYe3EwDcqf52HaKvYcnlfnbYzyM4HJWqZ
	 PmpB9amEa+BS9w1tRCcALUzxTX54f6z4Fd1F90paVmtbPBFJ/1NYpDzYp3zXhfEAhpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dce7yyFP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FFB606A335
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dce7yyFP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B747F1F000D0;
	Tue, 24 Nov 2026 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542265;
	bh=gPLta/nV5eQtNnkfwbLJs75/z2OZWm1tFtQ59yVOjqk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dce7yyFP/WZ0V/I7uy3ZPuIgjW0nlgq4Q/Zy0hksMwCePX3/0Imlu9pUQO8lbhjyq
	 T73eD8a2n29gDMircogSaNaUj3sqd87G/3MqyHibwr+fKdGKCUAsmsq/VUpIwXQgwk
	 jyiEO123fpEXqjUWpbxx4+CBMOhprrW3HRxqflKnYT/DW70tv4/3wLf6hJI59V/7U0
	 ZTOtLJJTBt3lIgMOXq+sfhBtw/0EzbMRyNonn7Xo6FlYTEG2Qcm1Xj+SyzwcVQl4xA
	 itPtizpKDlCR34mFWOF3LwQVOQAZ6YrAZRMu5FDFkA2990qArEE3VUDuL02v6eXG2T
	 8ClxhlWOJMd0g==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v1 01/10] bpf: Order record data after the
 producer position in overwrite mode
From: Tamir Duberstein <tamird@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
In-Reply-To: <8a47c80b9a3dfa8ddd4788781b854357a15717b9.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <8a47c80b9a3dfa8ddd4788781b854357a15717b9.1795467315.git.memxor@gmail.com>
Date: Tue, 24 Nov 2026 12:44:15 -0500
Message-Id: <179554225568.72201.2792202997422939778.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=tamird@kernel.org;
 h=from:subject:message-id; bh=KHGjK+i6aa6EvugukQ52IU8Fq+JIU18ExM49cZ1HDdY=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNmsZz7xy8oZKX3wDXv4Jd/vwWHbK152PWahFm0Nuz9YH
 JErig3qmMjCIMbFYCmmyJIoemhveurtPbKZ747DzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjoGOsYMXJwCMNWiDAz/PU/7zzEOc5aetFzkA1vU+98BeRs/Ss9U9nRkPR/I/SfyDCPDE2fzN7I
 mrDkpDldeyDY151R3NsgxmW7WsL/yt23rxlIuAA==
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Mon, 23 Nov 2026 22:13:24 +0100, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> In overwrite mode the producer can reuse the memory of a record while the
> consumer is reading it. A consumer can only find out by reading
> producer_pos again after it has read the record: if the producer is less
> than a ring buffer size ahead of the record, the record was not
> overwritten.
> 
> This only works if the consumer cannot see the data of a new record before
> it sees the producer_pos update for that record. __bpf_ringbuf_reserve()
> updates producer_pos with smp_store_release(), and the BPF program writes
> the record data after it returns. smp_store_release() doesn't order the
> stores that come after it, so on weakly ordered architectures like arm64
> the consumer can read data of the new record, then read the old
> producer_pos, and take partially overwritten data for a valid record.
> 
> [...]

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
