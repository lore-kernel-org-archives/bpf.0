Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608338;
	b=lrPxLB6hFVmUWo6cm6WbnB1RdsS/DYXiw6SA50DDaxNnddeccAowSPtFBE2Y5FgwR2tm
	 D83tZo2mkPz4r2Q3e6QltOmPWnEsv4YiSS4uGR01/YgXmv54cVb5aUCp8B739LyTx1NOh
	 b4kqwEM/hEXyiBHeeMiW0x55wUudsZZ4NXnXYy7KOkBoIKgHoQxOw069cxvjzWajb9RLI
	 1ZuKabq2QeH3aT4rQ9IyFaf00i72qiWSZ9XABdRZfeBPSJP8TcqIAJ4QwpFd4EzO//mn/
	 hW2B40jXuDpSYypU6GidHTE/1BsOb27fs0t8uvZCEVyTQvRRtze2pj/0cQy0WEc4+YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608338;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IYreqHUz2HQR2AUBnBbZcSxaTUlKTzbRYKcUs5sJV1I=;
	b=0NtpRVTcBO/0a5N78s2U5fZMcRdJCftHutllJHGckoRtNcM2wGPchH5dOqaw1NZdk5la
	 +Y5rsG7kHH78W5cnisp4B8PKy122+ziGddfotULDd/MD9kzzBxvsQZcMApAOVF2fPWlyY
	 3GyoX52pu5Zf0lYOuh3F7hlz5H6XdwH/QqSN4zgrBJR4o535k2f/DQziTceKntTVtEp4b
	 fmXh+OSpu5h3eoOynsoda+WaecUN5HZZ59GbDgHT6J3VzfqItnqOiEUX/M76N4Dzrbp/m
	 wRUsWoEon+rUs4YSrM8SWWWyEvtAWjDn838UzpFDbAyJtdGqRuF3hd5zKDrsWXk/yYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ds6Fln3l;
	arc=none smtp.remote-ip=95.215.58.81
Received: from mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B17606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 08:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B17606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ds6Fln3l
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2P3ROvsM82yhJ2gGF+tSdLtq7UlfUDARI+FzX4vCWJI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793608335; v=1; x=1794213135;
 b=ds6Fln3lPjT2pVFkMVnpUW34VbSJu7/oKSYKMxWcrvJaNQo76xr+hiufxkXcSqUoTUEkMj8O
 ro0gdx7xJwPcmy9yAEmjqY2USKm8t0zf0IsIg4uTgtFu1jBg7/ScKiPTaD6og7gW1ZUZ70KwqwA
 IgpXOTJSHz7jNKictxCdyGtg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 884a5ea4713e1463;
	Mon, 02 Nov 2026 08:32:15 +0000
X-Mizu-Trace-ID: 884a5ea4713e1463
X-Migadu-Flow: FLOW_OUT
Message-ID: <1d0cce30-28d8-43ee-b6b9-12e2660d4992@linux.dev>
Date: Mon, 2 Nov 2026 16:32:07 +0800
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
Subject: Re: [PATCH bpf v2 01/15] bpf, sockmap: Write sg.start when recvmsg()
 faults
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:20 PM, Alexei Starovoitov wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> __sk_msg_recvmsg() copies an sk_msg to the user buffer and starts at
> sg.start. After a full copy of an element it calls put_page(), unless an
> skb owns the page. It handles 0 copied bytes as a fault. It writes the new
> sg.start after the loop, but not when copy_page_to_iter() faults.
>
>   element    0: length 0, put_page()   1: fault here   2: not copied
>   sg.start   ^ today                   ^ this patch
>
> Each subsequent call copies 0 bytes from element 0 and returns -EFAULT. The
> user cannot read the rest of the data. sk_msg_free() starts at sg.start
> too. It calls put_page() for element 0 again and can free a page in use.
>
> Write sg.start in the fault path too. The commit in the Fixes tag removed
> this write. Do not write it for MSG_PEEK, which changes no element.
>
> Fixes: c9c89dcd872e ("bpf, sockmap: Fix partial copy_page_to_iter so progress can still be made")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

