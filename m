Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647067;
	b=XWWWNvG07q74L89XAsRUZBI2/iMs2UrUbhf6WVOuwXEdh9zfzB9yTqk1RRgaH5KMz8rL
	 tWvM68G4jP8c708wRHY2Y+TkaVOSX5hFKACuD4mtevISA7YxDL1fZpYjFC/xroThfgeLb
	 jd/gsphs3jWiivlI/VC0qObB5T+XIl2cTNjpd7Fji3izsTWiCb/Xmf0vejbnAnyn0e4VN
	 n8je/004/IJeXbEcX7mqmxZIyU7a9PZuvh30ic4C6leqE2KR8TOjiygmwaKnU9a+k1E2f
	 BFe/Kan4r27UXBCyfF5RAHRgQCPeXxwOKr9NDzm695OGCuX4tIrW7cJ3eIvC2LBQFJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
	b=IuM4+Z9hvMYOzc4sG0BkphyUTekBWuTTqtgAaHWur0StC8D2v3zz5FSlTD/ONQxCMzTF
	 c95jSix5gzIXBFdgMZlFVkJA0DpuKq8S2tkS/bcR/1tiw0gURw8fJWK8u6THYfnWik009
	 qev6gXTa5WRvQpM4YN3bQ0RXUt5e8n09KPreSBtwjjg2VKwhvxKy9ftqPLv2EcT/dm4Ga
	 Vid9rcwkz6ZKd3ZESn/CxWFVzZmA21WI7qt8Fwe8aOobf7K2pcPUYC+fgW2EVUNAjw2ac
	 YPCH4rOijhIYPUncgtebDbZov9BCysKd/Mp+zd2eZuCAXumcCLVD5hfbFK3WEDFWeog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJaSOX2f;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA6606A32C
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39FA6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJaSOX2f
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7987517aso22612095ad.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647067; x=1794251867; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
        b=yJaSOX2fHm9Juwmq4JUqoq2YUiIBtyUVoOmlcmVoBrELsNCPbLTMw9rO4vLs0MhZMG
         HTvB/tLqyscvajIJjgD6/cPDUx/LkVkZPpVEfVxgXmXIlft+0McDPvdaqF6XZOLXacyH
         Ang6zqa1IQfCrYrT8Md40UVXLxx/Bf/lF4+5eI96hHQ2A4o81YQyVR9/6aST0pq6Gwwl
         8ozlggmL8sw+3up/7ETIfUKIjVuQlGOuwk+S2+X2nPzSOqDegfLQHFHzkV4iAC02s7WG
         Fk8JIVPjWmrs3FU2mmVvS4Sy74pzkJgosxvGuJzW3pF40R7QywgdD8b2hRupemNnX/Uw
         n5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647067; x=1794251867;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
        b=truLo1W/xjjMTtPf9iSz5si0kcSB/x+x9agGDoqj2MZMe3NlmDFI81diiAZE2zrvHK
         xE9y8p9SkUqUBroALDVHuxs4MLDtS5/DWV2pIZz9MaZrekRZPXMZZrq06HIsfgnX0w50
         tGrbGJrROTVfowaE9IBmozsLO+GbwWUMkxECuhRPMGjvU3Q5eKKXInGVcu/Snj8SM4jl
         sibm/J2nwYAMJBe7KE4BKyh7GJ3u2ZTB/X+lf3QycY7bBwz9Zaj7BkPMq7yLgCHD3tqV
         YDHdtOVb4pbsvrwaNq3Ub7DzSrP7jfYuxlDxKYXaX51DC9uiQdntVKkixQtcr+RNdQRW
         vSdw==
X-Forwarded-Encrypted: i=1; AKwUvBwUNTP0Kx9QtFvVTkG+W4dkn0lACTv0Q8bm40qIug+QC0eWngMobtJHUWF1k0JyISrPAOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dsEXqdfYvVGJjQ4j9KjwMOUaWG4JzCeHYsylmy9wiQrx9eHo0
	fMlnE7WSUTQXsY3bCmDRyXfLMxTpWgsIyNojr/MbUCisSylyWX0yWISl
X-Gm-Gg: AYBFou3g7XfDTjVQonjC5F6TzWpilh0d4WEaAiQpjg/FtuGRhq9sFoQh5Qab/tLtJTu
	cLySLcBlYFAP6LA+gCX2ICC1C1M7vbeY+g21XgU63v4UyXOSgOLORP9opcWQjt1sIzDYWrFu9r1
	RGzrXYNy+Pfb00OEhP9k/vWT3HSqzcvpE6wy8CgoXlX4LHr/muxAuraimNwnx1zjrXTdzZgALNi
	W3QrIFUHrNIMNt5XxduwG854sMxBY2emz3vFnubBd4C+AvcOU5ZKsQp+4EnJ5hymcNrZISuIQcO
	xJ95JEeW/BnMlRa8Ya0L0hitYrEKliIXr5Lbh30w2V6zfLSLVjmtQHNkDdhM+HYT8r2At6diNeS
	mL7CrTl/H+kIhZnrRhdrdf66PeeEkiH/QY/BkbfTHfsJo3ydGqRflgtiiUCWSxZLeopmhU846vC
	fBDiIGIGEJJhWhDwPGPYH0VV8bszl+SH96HWJQQiGLoZy/U6Je1nxnLzdi3onTyd+L6VD97OWeJ
	GlrUoQnJXSEXIf2jbLpCSxQf9qo07LiFYqio88a1/AfU88/PwZi7YPK0FH5MIZkfPsmCM1eeH/J
	v7fccm63eikTOgJKzvRAPQkcCOVemX3vsjNDOWZK9rjM2VxgBuVwa3zTtoPTUdYkcxWD
X-Received: by 2002:a17:903:1b2c:b0:2ea:a2ea:5f62 with SMTP id d9443c01a7336-2eb364b8c96mr101881445ad.24.1793647066596;
        Mon, 02 Nov 2026 11:17:46 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39231422sm32617295ad.23.2026.11.02.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:17:46 -0800 (PST)
Date: Mon, 02 Nov 2026 12:16:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 05/15] bpf, sockmap: Clear the resume state of a stopped psock
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-6-alexei.starovoitov@gmail.com> <9d399d69-1dfd-4848-bd55-be099b6dd792@linux.dev>
In-Reply-To: <9d399d69-1dfd-4848-bd55-be099b6dd792@linux.dev>
Message-ID: <tnw2xl.1p1r2tdvgc3bg@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 04:40, Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
>> the psock. When the socket has no room, the function saves the length and
>> offset of the remaining data in psock->work_state. A later run continues at
>> this offset and clears the state when the skb is complete.
>>
>> sk_psock_skb_state() saves and clears the state, but only while
>> SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
>> each skb. If the socket closes during the loop, sk_psock_stop() clears the
>> flag. The loop continues, but the state of the completed skb stays. The
>> loop uses this state for all subsequent skbs and sends only part of their
>> data. A closing socket may lose the end of a stream, but not the middle.
>>
>> The state belongs to the skb at the head of ingress_skb. Always clear the
>> state when this skb is complete. A stopped psock still saves no new state.
>>
>> Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>  net/core/skmsg.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index f03519468ad1..a5d498982848 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
>>  			       int len, int off)
>>  {
>>  	spin_lock_bh(&psock->ingress_lock);
>> -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>> +	/* No new state once the psock is stopped, but never keep an old one */
>> +	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>>  		state->len = len;
>>  		state->off = off;
>>  	}
>
>
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
