Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163982;
	b=QZKwE+62W6EnH8xJKRiaxFhJ04Oz3AZM6i8sjjRR0Mf9LfZyNz6KC08T8jAJPiRlr77l
	 Xc9K4WXqMZ/k0yOUXfM5m7HHdTvV1zddcyYETe6NKSCXMzAyd1SjTeZjFQmUDiBlI8Fho
	 2cjKEVIvYkQ6g8BFPFECcAMb5TpjLtF89rNA5PGXD85VdfGHY+1NPp61qCt7Aq2aLtZ6Y
	 xTaVN9IOlpeBRkv+ejkv/4fd7w1w2N6ggjyR8mW0WLYgd10S8BbBWhK/+NR9AyUGIT6k9
	 ANT+pIgR2G62OnYAhvidR8LOYLJvwiWj3NnIgVQe7Jb4rg6sA3YxPyGFQnmHY1WOAdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=ER8olpKlUM65rcx/RjWGKbrvwVsdi0Y2mK49p29gawA=;
	b=qhqJkpJSbU9hOc9z4iVml1L40N5O2Sm2esgKdfFiten2lybOC8F2WzWSrJOVB6SbhHZ0
	 WqQ0Yikb7PwIQop2LfJY/16CIAXaiQf6GmqQCgp5SN5KGOfQbUhHo2aRpCddDYTqhHH8Z
	 S20i3ajg0Lhqnk8vYUrp4tiSxoY1xv/K4Ol/k25t5U7dvxwiLxV6YRTvgbbEXxCIXbgH0
	 SqR9jV8U7uXPEmFDmMkcXIVC3SSBMPXMt3ixdkiM9zROuVgMoCCutGKncDNcxlqgBcIVs
	 qpmcw24lgl/LsWiIzaYWp5k/+eBjnTaRgVenH6FqCT3Q6cUmkmAlvhlZpSW5/WJfOUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjTcKvBr;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB722606A31F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 05:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB722606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjTcKvBr
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso385646a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 22:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793163981; x=1793768781; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ER8olpKlUM65rcx/RjWGKbrvwVsdi0Y2mK49p29gawA=;
        b=fjTcKvBrQh1JOZU+XNEy3CpJgCxqLI/bl083DRWQjdlUrI7WTP6ilZ95ZAFFcgofT5
         uDUx51iZ8BGV8n2BzIijwdWMQdRaSP17wlLMH6gPyDEvEqNC0nEN98agVoKB/k5dBK5F
         hZCbNP14hujBhVu163hRXYerRAq1HQqQYMxz2WruEp4Tkc4curFbyYd/t7GTbZ4OCrys
         ypU5QLFeAPOtjJN0ihSIw5fk1gZn9gD1kNqRRTAhnWM3GhI/yQhdXm1x5T9jgCExMAqN
         kNozj4whgacqwIeKrLFSW+tp7L0xOG8Jkq9xmETFjkotSekzd8msufSpeSiJaXJ8Yko3
         xzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163981; x=1793768781;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ER8olpKlUM65rcx/RjWGKbrvwVsdi0Y2mK49p29gawA=;
        b=x7Y6/hTAcIEiyA/KgW03HBZva7TB0Da1Ro0OIpFDbI4YuMzkPOWpRrMD0qX+/dqI1W
         hPdowpXM9eeka6YDiuch+1Z24bHud05y+JYKB9IHFWlG1SHyjkMyoNDC6SX4mZ0nAAyk
         yqI1rUxAkLpgaUMpdwFgG6S3xyVespupP1EQ4QlRyeQB3ugqJZxEN//HfSJT39Kq+wVE
         /iDakzn8Ep5LhOBgQL2Z1ebIT/SIlU0roZakPsZgxNaEIjBcEEUu2fnnFiIHrIBzrZd0
         QALY/Oy6bWIImP1zhAuqYGQw0XLWEUS+rJODZ7SVVTRk301rLQDsgNBtmfg8jgEjWYsJ
         qy3A==
X-Forwarded-Encrypted: i=1; AKwUvByvZPiwnAZxI5Do8GMFjAh/C7v86Q5nvJY5Sk+RTYaF2prnUPNfrahj/pYamhHSWkzHRXo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIblflwL/422Xx7DprtmYX4C8GymBlCYlcqiaesRSYTVpZ9XYdB
	FafSOgVvOWeJFG6+pIYpRzxGSdizBO6OKltXcJo+YLKzrK5hVd3N3vVK
X-Gm-Gg: AYBFou3BzvYTJKsTrsJPguYHgij/McP6v71bZCwm0Yi7X1kmsYFtGmUfdOuI78Ot4oq
	PKvNSSD25alJadHrwXYVSkwlGoqPpcmT6QJeX1WvwrakeRr7NHLH6w4Gyl8zDOviMZzJ+Uv+2ju
	PrXgMZvO0Q3pZXgrOaKyJnehZBN6hk+KlKX/wsTMRXQnxLHJvENYiFLEV/U6l+iCnJFYvM0emrP
	+iI1jaz0X65BG0tcmaywpzIEFi3o/DVpAEMlnncQvTAD/tWysOrzmMZX6hgS06cRtu+6HDpLZiZ
	qkv9qQiTlORbgSGXcq7k2UtSsab7CJnrGYtRHcV3Vp1xY6CIsER2SMmW4p8pn3hVU7x5rezojX9
	8UiX+bW8R5MjI6DYYMrSv0mS9YVhAfHfMYMOF8TyQd3ucGuvNMj5DZ7aeSpOvbcCZ0GjcwUiPDK
	Rd8PgFt6O4vM0CHuH3gCHxcdQkmaIfjXH3X9oR2Ya6BnpF7gwQqjdH65FfAC+9ezqL4n2Bolu9G
	EqniygPuaGfiOf5hixIYT3CvZW0HBBCu+xlW79byJfH9hlgVteb0jiO8LzFj6Ic/Z4xlHSkJMDH
	1+5luYalyV7q40j4nfrKDQBfCgDchgFc1kfgSJDigxKdFEtuoQOYaUhne3lEzkPbAfY9/rdZCga
	useKTrH3bpB2rUJTf8CoKp+1ztFJWWX0ZOw==
X-Received: by 2002:a17:90b:440d:b0:3ab:e588:c288 with SMTP id 98e67ed59e1d1-3ae57f9b14bmr879093a91.11.1793163981010;
        Tue, 27 Oct 2026 22:06:21 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a5d3fccsm1126185a91.15.2026.10.27.22.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 22:06:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 05:06:19 +0000
Message-Id: <DMG7KVUM9TV8.3QO4MU310J4CU@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH bpf-next v1 00/11] Unwinding for synchronous
 callbacks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
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

On Tue, Oct 27, 2026 at 05:44 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> Code that unwinds due to panics or exceptions doesn't often control
> where they can be invoked, and reusing the same code in callbacks would
> lead to verifier rejections since unwinding across such synchronous
> callbacks is not supported.

I feel that you're too attached to bpf_throw concept.
The code was quite intrusive earlier and it is still today.
I told my agents that bpf_throw is a dead end. sorry.
I really think it's not a kernel job to solve it.
