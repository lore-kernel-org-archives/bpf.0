Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624074;
	b=BGHFtgO9BXAcUrzLd0fiojXSBDCYp/yZL6HtMTtd5ipQfnks932GVE1441cZFYhZWGsn
	 wiAY6yVwNjgly0ZL6ZcE6Q+szTm3DeNY0ru9wpBR0uWSMKy1ReJEIVTknIru7DOefJx6i
	 kOdhoQhhNpdEUFGvTc9OrRZ9gjvwxvKwdocivPjk/yB+vbcO/sMx9wDpTqgXDatyTmgsn
	 b/8yl2BtG5C1GYNDUhf0SBT0zMpdeeqkiNg9L5zhwK7MtA6PrHv8HMG9z93LqJkqsPnWK
	 5MbkXXiFfSZ2OdkDnR9h5ehq+Vcmml2ZCO3npbpMZo5qsFEQsCg7Bi8pazju4C3S/aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624074;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=T1YaZ5CVMpRh5cBJyHT2XXxbUm0f+Lg1DdVX03Xf44w=;
	b=HAn4OC3mjbCsg5Zg/m5rsWuMmu+Gx64CYvy8vBZZNVmWGglStKnwmmUvB+9Z2m/F4ttX
	 JcBM/QMaY9JyuXHPfvcV9MqM5WNXBUJ3zy60Dnr+WmAr4neTwVIaW0xksJumLlVR2A9oM
	 rHt26kmivVPQ1XF4F5e4Mnyen2/PU/f1WuyU+hs/vYDCts5I68y5p8dhsEpzmJr2MJO+B
	 vHe4apCAooEBp/GIBS+8ptKm0Zo32WPX+LEthtyAvpkGhlK7qdvOt1u8/lvxPBTkLOKRU
	 Z3Gn8+bMaCADVxV7jeDffSV3/ZTtgKyqUE5gGESavaRLk/9Jg5xoXcEGH3PBfrKr4ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="CBoNTm/0";
	arc=none smtp.remote-ip=91.218.175.102
Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89261606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89261606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CBoNTm/0
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f8NRbaKzFnIAovB9R1DkWIJvuMxfGpSyRGnC9JEfYgA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793624069; v=1; x=1794228869;
 b=CBoNTm/0wYY66KVTGoqmZEpP+CTkY4BxVtiIhtgXQVmBFuRHyyupdrgR6r+BvDDOtRzq1nff
 vIBLw3x71ZY8x8fhag4zHDEZM9C60Jr+fhgE6A/pN9Rv5hrEyCN2H2gUzRHjRkmLzU2ZKuxMFQU
 9e8Yf2Q9Ik+cBqOR7Z12mTEE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d66616fbbe63938d;
	Mon, 02 Nov 2026 12:54:29 +0000
X-Mizu-Trace-ID: d66616fbbe63938d
X-Migadu-Flow: FLOW_OUT
Message-ID: <40d46734-8195-421f-b14c-b4b07adf3380@linux.dev>
Date: Mon, 2 Nov 2026 20:54:21 +0800
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
Subject: Re: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once the
 socket is dead
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> When an sk_msg prog redirects data to the egress of another socket, the
> sender calls tcp_sendmsg_locked() on that socket. The sender holds a
> reference to the sock, but not to its file. Thus __tcp_close() can call
> sock_orphan() while the sender sleeps in sk_stream_wait_memory().
> sock_orphan() sets SOCK_DEAD and sets sk_wq to NULL.
>
> After the sleep the loop continues and does not test SOCK_DEAD. The
> subsequent sk_set_bit() can dereference the NULL sk_wq. The tests of sk_err
> and sk_shutdown do not always stop the sender. sock_error() clears sk_err,
> and __tcp_close() can call tcp_disconnect(), which clears sk_shutdown. The
> sender then adds data to the write queue of the dead socket, and
> inet_sock_destruct() warns.
>
> Leave the loop with -EPIPE when the socket is dead after the sleep. The
> function already tests SOCK_DEAD before remove_wait_queue() for the same
> reason. A caller that has the socket open never sees SOCK_DEAD.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/core/stream.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/stream.c b/net/core/stream.c
> index cb255e2a3a5d..334124d683a7 100644
> --- a/net/core/stream.c
> +++ b/net/core/stream.c
> @@ -150,7 +150,11 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
>  				    (sk_stream_memory_free(sk) && !vm_wait),
>  				    &wait);
>  		sk->sk_write_pending--;
> -		if (ret < 0)
> +		/*
> +		 * A sender which sockmap has redirected to sk does not keep it
> +		 * open. A dead socket has no sk_wq.
> +		 */
> +		if (ret < 0 || sock_flag(sk, SOCK_DEAD))
>  			goto do_error;
>  
>  		if (vm_wait) {
