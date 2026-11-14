Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665480;
	b=WDYtOL9OJX7dNdVWiLzH33hmGMyi+HT1BI54xyZsZOM04DvCJLGyH+8gSSWbJw5ZV4Gf
	 IDxHUr6W2p7vDrJwJynPDk3YtzXUC6TPvfZlrWnlK5VidKjCsCwb7RqZe1iqSxmxU/Iwa
	 D6c7cE1h3zGo37gvQZYv6N1xjeTaWx1OeRfbU3/s/YLJHAfGR+9qRAuxFmUujX8RP1FJN
	 /K9ONwFY8I88uTRZNEfZ9e4pE7evUHCw7OjR2/38UwV3Edt5PFTvEWyvN+4T8P/WCAdbX
	 ZEiqgj8tPg9s0u5yUv+a9s/NVu08Nh+R82ChMyuvvN4PDFGcwRxNXMZIyoGycenZg5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=X1aNKxDcC9Su/sKRcb+fwZwTfaJYdtOu8vWxOSG4H9Q=;
	b=nJOtscLIS+ZYd/6uwj788oOZ1maOfNHKN4QBgZuqPnHkG2x0srUbi5uZUlBPE+h1Fu4r
	 8AP+/mgIpmuwziNtMCo8VWvy2YdmRh3EW4QVf5t611WaWNP80Lmdtw4C1u/He33IkSua+
	 d9jANw2czA55JK9yQwyHuIGold/dl8TuwlJOK5RU/NVO8RpfX7ZTfk2MC5BX1znLZOwJb
	 WExVfJ6KyDY/t5nxU5oG745OSFwoPB4CDi7E4bpxr/TAS5agaj4QvkhmeH/8dcuAcQBlH
	 41QiowveZqxSjpz74wNyeANLhHU1uNO8bOFEIoHhRVUUdjuSs6rxC9r3AlsydZwCPQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIuTSlCz;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E6606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA9E6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIuTSlCz
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so742480b3a.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794665479; x=1795270279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X1aNKxDcC9Su/sKRcb+fwZwTfaJYdtOu8vWxOSG4H9Q=;
        b=VIuTSlCzI5+jZy6lhUJ3NdFy8QfvKvOumfxqXf/KsHSm7q7qnrtm0TQKMxcAu58t9e
         lgjYrX7X+fgOz0yW7XFscKcImqrdxA74UWS9CrBbqZFuQT5Xjd5qBFmUFrQGTROrNBmo
         j3HbrMQ9X6q0EiaKeeaJowpKByG3xCk7OAAinrnWahFvw3jTJfK6+Arw7kgFbveE7bcn
         cWEdrRwRmJsazex6ce+lvFzkV6lLEguXk6GoJ8/v93AWykNVZdy1xFS6PSwqBHVADnKn
         cowtQuqrBknj2KZWxJU5/xk+xdXxpzhtDkAlhXlKc/iEhax4HpKwerl5PO0Bnrx0eFp0
         sXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665479; x=1795270279;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X1aNKxDcC9Su/sKRcb+fwZwTfaJYdtOu8vWxOSG4H9Q=;
        b=VDySiSkT2KFKtJASbpSxks22ilpd5gUzV0rOmfZME4zFhj1vTFvKhTtBJ0tgGnBogh
         tl1jQk7AwCtj43A76bKDIv6VKCIh/04XZPNhVEKAf9T/xaM5diBD14jlJ6CDWeJRlRqH
         GqDaJpbY7rlTHdJwsWTSSt37Tns43wAv9VA+3Yu9u3pF4fC89JX+RHEbWtWFYfb0jrat
         afgd3seJeAkAGrmSSrhNSvXhBUXpmoP4dcv2EHsbctd9dSj+sTx5cuWJB0is7sVk82y4
         tKrqu0f6msIv/6diUa0B29k3Qskic5/7Vn885ksq4OiqOKlHYGA8VMWz6uG0KQL0GZet
         O6ow==
X-Forwarded-Encrypted: i=1; AL+hErHUgi5zdrxUytSHyfjt71xiwRfFzKhZMV2uXwc+X8l0WauGb7k3xvrbjcnBvZ9ulkLDk2M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pDlV6gtu9oy52hLPlcHTmndZy4OAjd88HLQB8mxR44G60dGD7
	Ard98PHMAu8In1Skb4fcaWOXUAou0CpTesZu5XfR/IGLRsDLguThBS7N
X-Gm-Gg: AYBFou0nMSpsUtfAsE5+OAMPi2vM8PEWkhI0BcsWBbgMlIhlv2lom1jEUlF13PBKhKy
	xkxo+X4RXxtRU+hG75RzPUC3t+seQ+bGJFgYCj5hJS+qnVe5t/zUR/gcpgNB828taL1zABm+A5m
	u2TWHvclCXt9fWx6qsjXiJButx5Lg33cdfkb94RLX2r4ouA94f1mh7Y6YxJqqrqxu7iTlpfmWTX
	GvvTrNLpNXpQ86p0m42hwYKj+MBQV2/9ThowczogAsISEDxefeQ1o9RcbvtVB21mwcyGesQGMck
	07KXdQMC2YCPaWokZupoBKC97Ph9tGlSO7ju0zvGowju6poXpdMLnzE0Pr5022uHRUuWcbGlrJB
	kHp0Fhmw0zJ7UMkUwopemgULBDe4K96Am/6eB1/+yFxSUmJZqoU8N7d29ZJeBB9XtnA3Wj/A55I
	1S0tixS7LdEcAV+2rQeYfx0IwgDR7T4pjV/jJ8gtdi8Rmg05rpPVbGmvlFURyVxqjcQ39aP0Ghv
	SElAqMvJNoeCAspXGF4rqzLP+bFoL1ljbhg5b/klD2ABHNIuWosprmBut8vRFZcjccll+8gJ4VY
	JiSMfYSvdfOUlLIHeehpY1jWwZr/LHg9h3UZkYifau4kjgwXQ1msPTtUc2EtiPczs60=
X-Received: by 2002:a05:6a21:118e:b0:3eb:b103:6ec0 with SMTP id adf61e73a8af0-3f7a72ba2e9mr5274932637.14.1794665479089;
        Sat, 14 Nov 2026 06:11:19 -0800 (PST)
Received: from [192.168.35.40] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18b4e68sm2442814a12.25.2026.11.14.06.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 06:11:17 -0800 (PST)
Message-ID: <2d8dbfaf-46d3-4d05-b052-5e8a8670931e@gmail.com>
Date: Sat, 14 Nov 2026 23:11:05 +0900
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
Subject: Re: [PATCH 3/9] devfreq: Use trace_call__##name() at guarded
 tracepoint call sites
Content-Language: ko
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>, Aaron Conole <aconole@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alexei Starovoitov
 <ast@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Chanwoo Choi <cw00.choi@samsung.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Danilo Krummrich <dakr@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eelco Chaudron
 <echaudro@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Ilya Maximets
 <i.maximets@ovn.org>, Ingo Molnar <mingo@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Oded Gabbay <ogabbay@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 tipc-discussion@lists.sourceforge.net,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 Xin Long <lucien.xin@gmail.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org, dev@openvswitch.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org
References: <20261027153658.703730257@kernel.org>
 <20261027154413.039021489@kernel.org>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20261027154413.039021489@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/2026 12:37 AM, Steven Rostedt wrote:
> From: Vineeth Pillai <vineeth@bitbyteword.org>
> 
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Original v2 series:
> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/
> 
> Parts of the original v2 series have already been merged in mainline.
> This patch is being reposted as a follow-up cleanup for the remaining
> unmerged pieces.
> 
> Link: https://patch.msgid.link/20260515135920.2238808-1-vineeth@bitbyteword.org
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 82dd9a43dc62..9f71d9dc4a70 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -370,7 +370,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  	 * change order of between devfreq device and passive devfreq device.
>  	 */
>  	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> -		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
> +		trace_call__devfreq_frequency(devfreq, new_freq, cur_freq);
>  
>  	freqs.new = new_freq;
>  	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);

Applied it.

Thanks,
Chanwoo Choi
