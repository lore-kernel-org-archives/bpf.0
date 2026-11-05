Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838771;
	b=x/DTKZx2bLJ0gDrLdo3tCI5KG28YJMObStS7hpjKa3P3cn8AiSG13fdMhJhSlEBTWLmQ
	 4gIW+scMFF/EGsn3vR2WHNhxj0y7sMFH+eqVtZUBeLFXBDRDhvCUUgJ0kyF5KvWw/eSNb
	 7Kb9vKHuqFPvJBcrn8wS0YqVyP0g0XUc4PXffrd15HuTevEg0m60A0AyXBRxOQcZ4v+3N
	 CiKwnduiVdqGdo2bBTfXLj0eCqoDYzFQYQW+BanTiKkb40bYIoleKpSYiTS5HLqGkBevR
	 tupZv+oSAyY8z1phRJeZjNMkFAq1QBNjxWtd3iybFpNcNVyksE+sAPwILuVuCqvb7zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=wLwUT24mXvSMjpAv5StrqkMWXe1MF9M3C15I88UyEg8=;
	b=XMtnp3mBAqpTPCFdAUXnmfD8Dr0rzJwly/xlYPa9Gz1YL2LtfyDgForB5T+tXMQql1WC
	 /71+BDoY/BocQiZRRmRAF8kdpkNSDJ01NKNjh8v++uFUql+Ot1CXT5KP27uT7WtBwuUkx
	 njrlcZrre3PwVsv+x16Bs/hT4fmLYnbsCZyCuoDf1WI6UekuTclvBOI9NGZ8IhrdPGbdq
	 XfQi5+VgguU/xZUhCzlYaDOvrYMd6xpsEsahpKzdu5b0vVc8pWl7uiRcRGSUNJQPNuI0g
	 aRpn3hSAhG8Dcng4aLvDLAZAgLMUcNlczK5JLfyWx31WGHmhfGcWrDaGK5XgaF41Hmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zf8j9Nu1;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD965606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 00:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD965606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zf8j9Nu1
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e977109392so8112175ad.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 16:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793838770; x=1794443570; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLwUT24mXvSMjpAv5StrqkMWXe1MF9M3C15I88UyEg8=;
        b=Zf8j9Nu1DyKAu7DL7DvA4KEFt46kzcEH4rTqbBdgkUOgE/bT/39y0KMp+Y2N6FAfOj
         lCnVp2YCCbmv4rGcxv/K1SL+iUoximoeJDseuqeA7rRWCog4+w5O0O1S1FI155JMMiSE
         KZUds2PNgD0X1O+eKFQ+jGPzc+HQVkKjgZrlQlMMVX8tt5woOZbdNWdYKE3SafqY9m2p
         ayyfUXBVjWGM1kcJmybaI7A91A/LG+ySWbwg4GXYoTr2J77MLNhrkNrqWz02M97mO61U
         1ZkJ4JuvRX4bga5NNIrxbUHdwhyIiUsEFCxLW2+7GGA4HfvRHiFkzXak+rUovLjlV6BW
         yJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793838770; x=1794443570;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLwUT24mXvSMjpAv5StrqkMWXe1MF9M3C15I88UyEg8=;
        b=EPBNp0mB/hNF/KKWJjid0/Q+mwLDL+sX5QXee6ETw0EAzudztWG/IbLJ5EJhSke0Sh
         4nsnusCqGQLm8kJ8WRaX6RAqhKkAqU4XsVwFzKJkUC0MSiEd/tWMjxsXY8sHhcZqvxI9
         SvQqoAlQp8coE5iD87fFBY8hItffxx8MxHVU+IJ7faVo7i5k4AwEf4uULywo8pR7DHFi
         RpesWYOLArheSvy+3MlYjkinP5viQZpgeiPT2V3A0mAYOUwXdGHmvRGDYB63iTUz8WEF
         6aLnnmbDbbDWRZCEfbkKymO0rfHk03d2dAkFCGk7Oh50rZB0LKAJitGOJQycJ8flby2v
         auTA==
X-Forwarded-Encrypted: i=1; AKwUvBw1RSC3Y0xLIwoWyPBdLGlEgBsZnZKOEK+9adU5+BTd1XLR4+w9PIgz+XeXFO5dgtnPp94=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xkljnp9/BHXeqZQ7PsyptwH5i9b93DmrhLic0TKmYNgrusvOq
	zXmA3zMlMJF/Ynzo/eGTkwyvXpJpEXw2eWa8YJFP9eZV8ApYyXwQN30E
X-Gm-Gg: AYBFou35oSt9ByCrbRAriFpq8STNI3TTlIJideE4b4LdEr4TOObzSMgpImPlt/6ryi7
	8qmVUa3uXG1ANyy6wRlr3moJBxqT1LLv7uDS+2WufZ/tUI2h2lzy1aZv1wSmYssdWvaYayhU9vl
	OH4cmuARn6Jg5m2jVPRf79ZBOBuDaRty0VvzTNa6x6Dq2R5iYrjYIBBkTH+JLVRN+9dJQKrJrEe
	e2lWnRhKcp0dLxvy/u0H+wEkfLbDXdG40golar4Rd1L8WiQHu+cVUiH3Oj6vViXRAVuS++V2r0N
	UXJxQpRiSRB9hrnXscVS2WS0XftVpgT605gYJh7yOinGYPgTMsDxTyY3IGydPp+YPr5fA6EmGvI
	O94EkAlFQxzziOy2u3PqTNkoW8n4Xn7/rxNRiM27po3g0En4NYuuvl956xk45DB0XSWgLSdc9iM
	JKBueGhsninml6z4GdnUTPk4SYhj5IOagm9BvjzmrRC6Jvohj+HqvBn2KaA4uWrnSzWVMTK+8Pm
	xmq0aEQdRzGQvOwT7LqZH+EL/v5ozuMkny9936Mdd89nE99pY8TeBBU62w5vgGHWrhVb2XuYMBP
	5msOQcSLb2QK3Y79bMrV4X8lkV85jcrgUxajFl4QJ7kkc8pEFPRuZyVGUS3HAt5XiYHeZBrhk4a
	S1RGwKzNm3+fW299Ib8Oe1XPi29kAYOk0Cg==
X-Received: by 2002:a17:90b:3d83:b0:3ac:9176:e82b with SMTP id 98e67ed59e1d1-3ae89838772mr13624395a91.54.1793838769945;
        Wed, 04 Nov 2026 16:32:49 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32baf86sm931033a91.17.2026.11.04.16.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 16:32:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 00:32:48 +0000
Message-Id: <DMMURTRBZ7LP.17GBF0P67G20T@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 8/9] bpf: Bump MAX_CALL_FRAMES to 32
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <a87dc20e1ec5a9b71efac37998600cdf8449e5cfbfdba8391138f2a79089c90e@mail.kernel.org>
References: <20261104215523.1852636-9-alexei.starovoitov@gmail.com> <a87dc20e1ec5a9b71efac37998600cdf8449e5cfbfdba8391138f2a79089c90e@mail.kernel.org>
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

On Wed, Nov 04, 2026 at 02:40 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> Can the combination of 32 frames and tail calls overflow the kernel stack
> at run time?

Not from this patch. It's an old bug.
MAX_CALL_FRAMES is what the verifier tracks. It doesn't limit the frames
at run time. A call of a global function resets the count since
commit ad95d3c758d8 ("bpf: Only enforce 8 frame call stack limit for all-static stacks").
Make f1 .. f31 global and add more of them. Such prog loads without
this patch.

The follow up (the verifier rewrite) series address it.

> Would it make sense to limit tail_call_reachable chains to
> MAX_CALL_FRAMES_INTERP frames, or to add a per-frame cost to the 256-byte
> tail call check?

No. dinfo[s].frame is 0 in a global function, so a limit on it doesn't help.
A cost per frame rejects progs that load today, like
tail_call_caller_stack_ok() with 240 bytes in the caller.
Not for this series.
