Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045372;
	b=JrRvDFysThJy/CqbtWZfTsIEpGrXXI3ESbXPHeZL//KqQjWusgNQpdVq5oJq4VsfQVDI
	 IKKhu9aEHi1QVjDPEzB2XuoD4H3Rljqm4nI12yl3heI/hf8YomSFCk7kKMwEVRjoSlZNQ
	 s47W+QT4Rr/ye7b4v4Vy/CrxwqB1iL4bYcODnoMW6uPHxLOF6levXLMmetBhUYqkuh2qf
	 b1Ss8aLDsOciiinYCIKhE3XgFg9aQ10aLxVZSt0JTNP/Qd6rqqlqg1T1mv3G8qxrPNrP6
	 VW23oVyvtp85GOExuP3fvCQI5GPrUV5qMQbB6SNIs/b1vYooRfQAV5u+0mU2Rkl2Wdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045372;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=79LC5Dl9AcWhahgzCfflFREgD/RZkgDqTUCwU/Mt7xk=;
	b=1c1g/jQIRsIpTmpcGiatwxGlAGB2Ul+u+R/iC0d2qALMy4lNm87aOEJE6BKKbCisYq1H
	 a5iMjdo39nbS1RRjjcdqyYQQIEwfwzCEJlcNm9hvj0+Gy4501ljMLyl//QZ2sGC2EIKm6
	 JeOldLVJsFXvYywzJ3AF6md4Uz+tNfsyTfnBP2N3QIHy4xavZpsJLE7CR+B4B72XO7xNJ
	 MTDZCt4M+Bz1r4HrO6aOzDsCvEuq5hWZ2ifrkGL+QIRSD/72gFQPoa4C9z/fXy7gN0YEO
	 Dc4A8eeMo/CMQUy+l4k/hAC8pOaEqkZ/VrqOx11wpExxpT5GSCVP2K7zKzypgpuC9eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=OgiiyLfi;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54352606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 20:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54352606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=OgiiyLfi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=79LC5Dl9AcWhahgzCfflFREgD/RZkgDqTUCwU/Mt7xk=; b=OgiiyLfiion4+fw2oq3EPhBFh6
	+7jGUNxBTn9BaIraruuuno+PKUZXeLSWLdBeP+enwZww//MbB/k5MSmuTPF0Z7pSAAKfRZWFOK+0k
	9aGajyIM9rsO6vfwEnw1JoVCSMAOAgSlHivUfIY0Wrc6zrKH00igiRg6iHeOJLffOGzVXT1Eqp87+
	5vo2dzJpBN+TYDHSFh4R4TFZup/1o8kftnPucH6YsSN9C/Z94POLk0jg4Y4KAPhQ9ocaheq7a76Gr
	OgNaBfXhOKhetWgHH+KTpWCZx7tSpZNnFNRRRe4HmrAdt2Fbi/je2WVfyJvIaGvtH/SW4gPyoP1W3
	VwAmQWQA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLR0T-0004jG-35;
	Mon, 26 Oct 2026 21:09:21 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLR0T-000JHk-1m;
	Mon, 26 Oct 2026 21:09:21 +0100
Message-ID: <c750f9be-f62a-49e4-8816-080601f7c192@iogearbox.net>
Date: Mon, 26 Oct 2026 21:09:21 +0100
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
Subject: Re: [PATCH bpf 09/81] bpf: Clear delta of a register that scalar
 evolution widens
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-10-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261026025943.404450-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28165/Mon Oct 26 07:27:07 2026)

On 10/26/26 3:58 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> After 'r3 = r8; r3 += 4' the verifier knows that r3 == r8 + 4. The two
> registers have the same id, and r3 keeps the difference in reg->delta. When
> the prog compares one of them with a constant, sync_linked_regs()
> calculates the range of the other register from the difference of the two
> deltas.
> 
> At a loop head scalar evolution widens a register: it replaces the register
> with its range over all iterations. Then the register is not linked to
> other registers. scratch_widened_reg_id() clears reg->id, but it does not
> clear reg->delta. A subsequent copy of the register gets the stale delta.
> Then the range of the copy is incorrect by this delta.
> 
>      r3 = r8
>      r3 += 4              ; R3=scalar(id=1+4)
>    1:                     ; r3 is widened: no id, delta is still 4
>      r4 = r3              ; id=2 and delta 4 in both
>      r4 += 1              ; R4=scalar(id=2+1)
>      if r3 > 10 goto 3f   ; R3 <= 10, R4 = R3 + 1 - 4 <= 7
>      if r4 <= 7 goto 2f
>      ...                  ; not verified, r4 is up to 11 here
> 
> The verifier does not verify code that can run. Clear delta together with
> id.
> 
> Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   kernel/bpf/scev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index fea77772ca96..b321bfee36c5 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -2390,6 +2390,7 @@ static void scratch_widened_reg_id(struct bpf_verifier_env *env, struct bpf_reg_
>   	switch (base_type(reg->type)) {
>   	case SCALAR_VALUE:
>   		reg->id = 0;
> +		reg->delta = 0;

small nit when you respin for bpf tree: clear_scalar_id

>   		break;
>   	case PTR_TO_PACKET:
>   	case PTR_TO_PACKET_META:

