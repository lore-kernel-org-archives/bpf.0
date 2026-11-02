Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659500;
	b=gMjHWM7Gab0fiW2DInIfeWq+9WOXHqZlfhiYgHW0eykr31jqr2rgmcvrzUuHB+wvUlc9
	 TK5U6komq1SMDWdcLH3JUyjSLEpM8MzjPkOMlhENf0d78U6QFaWNHyhSW9px41GHa2bKy
	 AqxwdHta3Nwn4mLvFlqqKX45pG7rg6A/FlVV0mL4G5q/K1+Ou33XHG9HvgVt6hgEo6tZZ
	 NKHxMXNVJtrc8X6t/xbGhtUXTJZsBbRjqir0k2UciMwFWEOzOAJDf8ylidIX+cPmnKTnH
	 EwQ6d55KlQz09dGN3sOmWOAtPg7ae85ZJal4CIIaZgz3O4MaQzuxEANwkm1pGEZDQSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
	b=LQUzewAkm0XCElLGyr1EZ2OZs0ShJOkeqXC1hGhTQJ4JxSxeSvUsQmM4eO997DHFIyqZ
	 nEvQhpO9Sr0TtjdCqWi0l+toLsenO7KPR1HJzrpT1i5rbBXWOx099Uom6+eDSMTViBkDs
	 KjMnkZaM/aUAinZiEsds5toklQ5YQnr10fSwXSkx0lUARVJppiEzEH5V/z2YIATAgns6B
	 /c/j+e8MiaVW+ljgt3iJtqG7uDCwuokuEk9GcudbCGCryyfVnLKlZCtiicGrh+UrWBF/+
	 /t8V1ewN5zbxH3nJvvM7Uc4XK+cQ3DNdaxkyRTPX3bcfQOviSqmlH5w+R3KWzbPPnSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWAypKS6;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15694606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15694606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWAypKS6
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06454116eso1468138b3a.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659499; x=1794264299; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
        b=EWAypKS64YSe7zbnDh2J2Xks8FwquEFEljlLq3SM457UPvkpQJLTIgVbbNAC5o1XOE
         uYqQG4XUmfrn/dSMbrMMQWG9VHqCk9ZUBKsLAsT6/7IegjdogQn9+08isn8wdHKPwmr3
         GCLs61bvRp6JZ4LBsRoXg09pRaWFGxG5tLh4CGGQ2BdTKZcwuPKrxsak0QtikRuQjuc3
         tGCxDW17YfGsPj/E6D/nZtivGr5y8Ln8PlnH+GnHAVIJa8B2Cvb5U9lZBmYPn14O2l0r
         z12TqYW8cN/sHS0dgE/TaLdvHT6/sYu0ke0AnkKalTBGKLe9r+trF7HqdbXcyZKAuIbM
         yF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659499; x=1794264299;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
        b=QnWWNdsMPqXVJ4yZI2oeXlfaA0d9vrzeIUpvByM3vovPdXtXoJTXx3EEtR7MnpAt2a
         fF2DNAq8dv8OcW4h5TWcb5uovdNpyKhOSGCdnTZhKybXTlq7ErldaN3AfG4z4OzAHLaM
         213eD8Qel2uP6/ceW1u0wO2vtivX3WSXxPqAY544hDq493HgPt71Z8DkaUNVPPvZxAyZ
         SWiBl8tJJ9RU/7iGc+bmk8WvoFK33lqhSnku28VXokcar24JkmHCr2/EBewi9LsjMbrH
         I6IZtn86g4C0tviw4/EgEPm+RlxNKXsVTT8NtgjR+pDNOE0wcvyNYdUYh8f1Q4Amk+6j
         tYlg==
X-Forwarded-Encrypted: i=1; AKwUvBxEqBGBlnQiVs1PodYfjU1fEUo3tj+qblkSQo/sRqnB16YuliEIxzOeHMcUtxz7bmEmJ+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzY5ZVxo3QJ6lWb7rWOkGAVbusLcqj3qi5J6tMKZgp0tzNRcWQ
	4O7Bi3Nt1wsaK+ri3dBJstFpm11iQ7jSlNfWRT2nn0iACpEyyq+I8uio
X-Gm-Gg: AYBFou3ZEvHVIMsblwR4zorMY/y+7TJMxwFI2Q5aTh2R+atSOKmIdRfnR7d5Y223j9/
	7MIBxtFqYX1h/J1el6C1f7A/j+9v/131viMzQn/X3Um5Yt1VBscac7B4WwUuCiX2iKdOTviPHVw
	UJojhfsqrnIxW7PXUEmkrP8rTM9Q92hVKxQ+Z1jYJiyukPmij/2+5uPdWmuYTgr13LzL0ie2nAp
	Mq3gt37DqyuhB9VgwrFXODozFQcziz2xA3y0r5SRvEx2bYdO6VOsTc4ruz/ZWZoUxp20fVjlPXl
	IDhnZIP9pVVNXIr+Yjm0yoYzZ5UEM2xII0egzRz1pVtCKKdVMrLzTKJh3w2JoJSdwoy4IHxcLhI
	YniJu8TaghylkBUJ26K55xAAMm/3U8fT7KkDF9Tme5AVsw/tO8A+Ow2mLRArNnAeHSS1YMhZZw6
	pCY/0EeEx+ziT2/5Aw0/N/ksFe1hmuBzrCsYDXX9LyI7aIYyl60A2PrTvC/IhbWNXakr4uCcmYF
	5Tzx4un7vGpW1F11EsnR+wtjcAhK6k+bYyWsdyaR7dc7B3Li3cyeBgf3fNN1XJaNqDJcgTRbfAI
	KgOIwc+dHcBSoC8kQF0vGgz3dgN8/y/SSHc9IR/6n3MZUtIBpiFa/l9CSe+BM/W0/1xGZevLlBL
	w7oG5n4SB70oL5lR1+iEZzxmYabATfrQxKg==
X-Received: by 2002:a05:6a21:4e03:b0:3de:79fe:13f with SMTP id adf61e73a8af0-3e928d4d2bdmr9749200637.38.1793659499362;
        Mon, 02 Nov 2026 14:44:59 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb364cb821sm358389a12.29.2026.11.02.14.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:44:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:44:58 +0000
Message-Id: <DML3865PENEX.2KBDIHWGWBJ7N@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mason@kernel.org>,
 <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "John Fastabend" <john.fastabend@gmail.com>, <mptcp@lists.linux.dev>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
In-Reply-To: <tnw1v9.qyjuvdc9kq45@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <tnw1v9.qyjuvdc9kq45@gmail.com>
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

On Mon, Nov 02, 2026 at 10:51 AM John Fastabend <john.fastabend@gmail.com> wrote:
>>+			/* A part of it may have gone out */
>>+			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>>+			/* Another sender can use up the rest during the push */
>
> Interesting. We've never hit this with http parsers. We do use this to
> skip payloads some times.

That one needs two senders on one socket.
With one sender per socket you can't hit it.
A non-blocking send() fills sndbuf in the middle of the push.
N bytes go out and tcp_bpf_push() returns -EAGAIN.
Today apply_bytes still includes these N bytes.
Then the prog doesn't see the first N bytes after the payload.
There is no error and no splat, so it's easy to miss.
