Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424191;
	b=r8nOy6Af4+iPGS84WzZL8pv7S8X5VtGgb+nj2wQGN4tOLH1kqHzS47LHfR2kOGThqMau
	 /KlvrCjJw3eB+XaFnCkqTJAmT37/Fc4044shQcBGNoyWx/Xmc3rISwNBZclPyFq11rP+T
	 sNUQs2Vh+swGMGAH6nK1t80NYfjJTMEHPTcQMvTNWeNyb4v6PM6wqnDUOLFqqw4Korswo
	 ODMCgx9Xsg4UqcRWZzh03THiIZjgIVzQdCkpeSgtHrToNd2qZ9iEcVDJLWAEmapcI+Y7X
	 1B8wpFGWV/yHpbqOz/viw5Ts8LAFnopLA8kV0rZV8OBQJBdMUAdNCgVdGcSdksGBoQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424191;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=musYXh/y9YPvWwh9w5V0GXcRJcdGJuMMuP9cBcENcuc=;
	b=dR+L2uWauN1/sS/ZdpLLWfZ8YyN2RD16MIABMt4S+eJu/Ak0XaMX2J4avbpY5iSyrUL+
	 1uHTtIyhZxWyFrP9tts7MmaFaXeDihIRV3LB5vsQKJ24J6zEAuJWXE+xobl+si4GeGohy
	 ngOWPUJEicV3yF2KewHgWZw37v2V+pAl5AxUcuRQ0N8WsbWenGsvgi6JNpsKk7+SmzwlY
	 w9/gkYyeFzvpgTtl3ZDUoO4HfKeiaRsvYZZ6DCIAG2doepJwLHqGUtUpotRPTLlJ8JYEU
	 FQcfBrJO3ysChGOxj4QkCGXrcgYHSUN5Er03OnRFkKE18bZ2Xhitqozsegi6598kjCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608D606AAF1
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4608D606AAF1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=musYXh/y9YPvWwh9w5V0GXcRJcdGJuMMuP9cBcENcuc=; b=heKkbQscS++8wJQUUBa6j1kmJQ
	y9MHGMusE904X5ZOr0UEi+CA28Br59nKIre56I2/4IWvaJ9+wuRBoUPARSleGVRVl+n6AHJ+Bv92s
	LF0xjCiKYj6B6F1stvot3CGbI5B0JFxml9v4bIQAgA1CwwjbbjFRD5WdANNVhYX6VDIPRcGtKE2bE
	kqV69BzL8MJwrD0kse1/me6JAKaPSZnj/A/VWEmtQ1PO4ROL3z+ydhr3TAFQWIHjw1uAgf/8Ls9zL
	GMZyEJghIOmsIZZVmNtW9Er4ulyd62mR2w3sKqXqnhIDCCReW0DQ0qIXuxiUNrwDr9VQBJVG/rn14
	LzNr6QhQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIpPI-0003rd-1G;
	Mon, 19 Oct 2026 17:36:12 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIpPH-000CTw-2u;
	Mon, 19 Oct 2026 17:36:11 +0200
Message-ID: <7f44cb1c-c584-43ae-829c-8baa084b09ce@iogearbox.net>
Date: Mon, 19 Oct 2026 17:36:10 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Refuse CO-RE relocations for a
 signed program
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <20261019144851.4052056-1-memxor@gmail.com>
 <20261019144851.4052056-2-memxor@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261019144851.4052056-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28158/Mon Oct 19 08:26:01 2026)

On 10/19/26 4:48 PM, Kumar Kartikeya Dwivedi wrote:
> The signature of a program covers its insns as submitted, along with the
> frozen metadata maps of a signed loader, and bpf_prog_verify_signature()
> checks it before the verifier does anything else with the program. CO-RE
> relocations are the one input besides the insns that changes them: the
> loader hands them in with the program, and bpf_check_core_relo() applies
> them after the signature check, rewriting the immediate or the offset of
> every insn a record names with a value the loader chooses, a field
> offset, a type size or id or an enum value of the kernel BTF, or a type
> id of the BTF the loader supplies itself. Whoever holds a signed program
> can so change its constants once the signature has passed, the offsets a
> signed loader reads its metadata map with for instance, and run a
> program the signer never saw. The exclusive metadata map of a signed
> loader does not make up for it: the hash that binds the map to a program
> is chosen by whoever creates the map, so it can name the relocated
> program as well.
> 
> Refuse a signed load that carries relocations, before the signature is
> examined, like the other checks on the shape of a signed load. A signed
> loader has none to lose: the programs it embeds are relocated by the
> loader itself through bpf_core_apply(), and nothing relocates the loader.
> The BTF of the program itself can stay: without relocations it steers
> only the verification, through func_info, line_info and the annotations
> of global function arguments, and rewrites nothing.
> 
> Fixes: 349271568303 ("bpf: Implement signature verification for BPF programs")
> Cc: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
