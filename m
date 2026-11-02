Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578675;
	b=e2m56Rvxvs4JSUzFWP0g9euaQpMbersn5MXcMfVnJcg6CjJ2CTqsi8V4Nnh5AcVQG2eS
	 GoCN3zAhtYLGaKd1WICpsGa6Gy94oM/qxphxV9VmmwBMy9zTzKh8WXCdfZ9NZnwO8zYRq
	 rIRjZwqeSwrmQPYFKj8j/HeUFR0Qq/1WGo/FxvPSJKZSAAXQ85EvoE9b6peD5WLAAa+O0
	 lFX38320piWgfe/32Rhlh7H0S+frwe1q0A/LZH7LggcTHlxjoXR1HKM7NEB9kOCBPAMgz
	 2sGLCnxX8aEQBi1U73cDtaK10mPZL5QborGYsU+Ervb7e+c0ML25bV4YpkpRR9WjJVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=OwpIzVCkDZcH3jbzH5HRsFx6n0SAUwWodTFAghsx2FQ=;
	b=EA70b9xj8M4R2PhvU6MxkiiqWJEEdWRwWHf8D8lHQCw4JpX9//FD4mOHCmbiRVB7l1/8
	 0NwrTM8PCbD/XwVO4rHSaIpKJfgI98bSkN+pFsr35jeWkmId9ps1HiQg7QMeUspwDXFwB
	 +SJPXUBrG7mWCyP9qnP98UeHbYRKXj986ugyIp2i7zb3sXAxIg06+JN4rrfybHyWkcfps
	 4/psSWwig9zmTAUgNC4c4PQAWSmQQyzZ2s8AmQ3H9R3FW0sONoQEQZ45Bwyr35Gi/hRvl
	 VbzEsCN5p9ccgmbS86qGGaHdaoxtOVWCGKJdR3lTDaaiqWW3r6ZtVkwSDYCGky1x4/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8Xmal1p;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACB606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 00:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7ACB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8Xmal1p
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1091202a91.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 16:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578674; x=1794183474; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwpIzVCkDZcH3jbzH5HRsFx6n0SAUwWodTFAghsx2FQ=;
        b=b8Xmal1pZmsWfudZnj13+issMjbPJd4AeE7jcfiwg2O3yS97AHIeoAUC3UcwTaI/GD
         5Gt98DAQ/aF8ml4hX1nz/2/8b1a8penArOUEg1/HpEWqCTAAs+6jDGqm6/2tdt7IwyEF
         H1HUCypPkQq/Wg5+oGXOUDVMrFhAsSLffJRyzxk+k3N4ysE3WytCOTFMi6G6SBdzltK9
         Orexaaj729fLGoUw2SG6XCWUbEVOyRP2GXXYNnC9+a7VonNqYl4nGYLX0eWG1CtUjTOJ
         s050ViSM5ka4YpuI3/J+0DtwljuWLw7qBLaChDRrps0jTIP455gfuoRR70PnyFDrnXLU
         IMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578674; x=1794183474;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OwpIzVCkDZcH3jbzH5HRsFx6n0SAUwWodTFAghsx2FQ=;
        b=sqXvT/U85BWkNi8tEp/PwqUMVcbcsKVnOi/oexSrUCAkS2MczAeM6DwtHEmnOf183Z
         t5b09z86bmuGsyoTaXKBRMi4s9lfdpdes6yo7xaRPO65Hgy7LQovJJtBVjpAx1B0bt3v
         wGUNdYyg2+o5SD7MY1QiSCsO5GLRo9rPp+uCzLWfo4onjIBvycR/PR7pnD5qGgBy96L9
         fxAcNT0Gu1tapo7dNYc6xgp3omfUv6QXetU33fTKIi960W06ZOl0fNwYgfyzmJjVmI+I
         MRnRlkqmC+36IZomQGNm67HzYFSqoVk4Nad0L9ulOW0Yon5mRzcLCy5S140v/9psSjOy
         h0Pg==
X-Forwarded-Encrypted: i=1; AKwUvBwbRJ6glSt5ZWktoXVPGgUCLZ3YiXyN/3b/MIKxBi03FW6RXztq/VokDAdxzTer+3RtOAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6wQQB4rij5gXb9vxSKGsqKZJHqkQ2MXNMDo9mOniU64FTyYaV
	yYuYCWYXUHTvqgGIk0j70RMMhCq8lcNKBCje92M0mAaTDDmCkdQNGR0z
X-Gm-Gg: AYBFou32ScN55+rvkn2rq5Fbt+CdV4DPelrcdYGkg7vvrhx5zVs4Oo1yQE714twOUja
	KFM8Xco1bkHczUGUDIieBk5eZSsTj3vKq2iFwZOqyiZ9pzRqIoM6XeFzLlGsPb8MyIk0bt4I3TM
	g9NXtd5OkSzIAgdhBYse6QnsxgbFtcP6OXuCpS5CtgHJeZuBLJHDFyzoFPNgZ7GnvF3kdzPkDfB
	27lZjmTSTtf04+F19cJVFe/AIglX3A/ZVGdb3IqQflrYts9LJ96eNQmdifiVdYYt/s2CTqofwgR
	BMAOoT4gAoiuIonzvrvMoG5z13eTf3j7QPi3mF5U6WU8q//MZ0eldoXhAZWGqw1ci/paHTGs2Wr
	QUQnMQX6qFt1NNMaSFgC0F44bCkPSDGqHC5sUG67xa+EQG50x89yWKDeHF+2wYLZ8+VBFgBECO2
	HrtqgSCu62NFROUY/DxCPGKRYEoWh5reG2dgqEI5gUwNnuLwal47qWehD7FUkkm0lTNcebI9LzK
	7bMm3RRdmOWQqYIRXU3J9plJoWBYp9/WpWAkAINasjdnu4D1Vbxy+0PQL9eLc8AfMvpSlDyUyjw
	NsfCQCPA6ntT+5FU4HmpSiaUxVHe0TK5sT1Hegxbd+oD85SIqy8Znl9YBbQG2lfYpp9SX5tYikT
	EQkAnBaf08McXccyV41QmiA3zjvwKGWgC+fHcuzhE9tuB1gAY6Wzidrc=
X-Received: by 2002:a17:90b:52cd:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3ae897ccacemr6470813a91.12.1793578674003;
        Sun, 01 Nov 2026 16:17:54 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm15965674a91.9.2026.11.01.16.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:17:53 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:17:53 +0000
Message-Id: <DMKAKRM51QKN.34OI7DN57OAV7@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Cc: <mptcp@lists.linux.dev>
Subject: Re: [PATCH bpf 06/15] bpf, sockmap: Give no progs to a TCP listener
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <sashiko-outbox-192637@kernel.org>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com> <20261101192057.2296489-7-alexei.starovoitov@gmail.com> <sashiko-outbox-192637@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 11:51 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
>> +		goto no_progs;
>
> Because sock_map_del_link() checks the unlinked map's progs rather than
> whether that map actually installed programs on psock, won't removing the
> socket from Map B stop Map A's active verdict or parser callbacks (and
> potentially call sk_psock_stop_strp() on an uninitialized strparser if
> Map B had a stream_parser while Map A only had a verdict program)?

Not from this patch. sock_map_del_link() looks at the progs that the map
has at the time of the delete. Add a socket to map B, attach a prog to
map B, delete the socket. That stops the progs of map A today.
strp_stop() only sets a flag, and sk_psock_done_strp() checks
SK_PSOCK_RX_STRP_ENABLED.

> Wouldn't sock_map_link() then see TCP_CLOSE instead of TCP_LISTEN, skip
> the goto no_progs branch, and attach the map's programs and callbacks to a
> socket that can subsequently re-enter TCP_LISTEN?

It doesn't matter. connect(), connect(AF_UNSPEC), listen() gets to the
same state without a race. The tcp_bpf_clone() hunk is for such sockets.

>> +	if (!is_insidevar(prot, tcp_bpf_prots))
>> +		return;
>
> If sock_copy() copies the already-restored sk_prot alongside the
> not-yet-restored sk_data_ready or sk_write_space, won't
> is_insidevar(prot, tcp_bpf_prots) evaluate to false in tcp_bpf_clone(),
> leaving the child socket with the psock callbacks and allowing the same
> unbounded self-recursion if the child is later added to a sockmap?

The window is there, but it's tiny and it's not from this patch.

> How does a socket that transitions from TCP_ESTABLISHED to TCP_LISTEN while
> remaining in a sockmap wake up accept() when new connections arrive?

It doesn't. It's an old bug, not from this patch.
