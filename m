Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186B24071D6
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538759; cv=none; b=l9IWmQeZzJb2Nk1CUFWh7uGzpTrBYu1s8KVk7hyJMmAJK5eFNPRY+UXhJ1ETC78oGyp13XxT/FKhgU4dYDThH3F9MhrcYw5W9ok74FFPMxbQc/uHjChL48tRrg/GOayGPhmYgOPDjiDEiGJcnhWB4bgYwpZm/AeoNgZ6ykAkG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538759; c=relaxed/simple;
	bh=gVCzstdGdJHforHW4RhCYTTN0c3nLSAJ9c8rWzvGcUU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fBpznImkdg+Mpuvs3/E0ddaPGA7aEtoDDM9WoQw4ZSD/q6uc9jbIkMKocjywmt9G1NZa77QbUD5GH1ReWZqmRkBTY5toXx7SWQs3UeEXC1POWBPpNowSVPmCC015U8xFqFGyuUuQLGqBNLYmi5B9hrSBwp1qgSl4JUPul7Ht8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHfTa2SK; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHfTa2SK"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6fa36a1b6so3030225a34.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781538757; x=1782143557; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVCzstdGdJHforHW4RhCYTTN0c3nLSAJ9c8rWzvGcUU=;
        b=cHfTa2SKBJW/DuvPVURpMajouETppdl6WJG0b2biQgyyT9yj58FkG0H2Hvnr9bN6Qj
         3iwNKzisS2/7s4XM3quSi0MldqVmMN4OwqWFwQI677UqZU0oZPA+oChwuTefNrUI1Qe1
         LXq443/4yXO9qpY6+g+GTKdgB3QZxzRUz6yE6sBJ66z9T7R3iu6CFRUKt4gKjc8Dk61T
         ki0ketiUmvWzkQ0ZPBaMdOfG3wZ2EXyBKeO7jXBciuGkJRhtAKbkeEV9vuICYpe8dT/4
         s7JNvUYr+tdhCrlxOF11xVpGTkK7DWyHsFqId9rqXcrMtytk3atT9ir1vgjrVyDxLj57
         xDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538757; x=1782143557;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVCzstdGdJHforHW4RhCYTTN0c3nLSAJ9c8rWzvGcUU=;
        b=JiPD8u1XulZFJMUg5H1Py6BMQqwvmYg/vC93Os1Ogz+UGS5tB2OmwjgMV5PVJLC11g
         gRZW8UaMbKXykdusKMEFWwGDpy4nsQU86bsH7pyDx+ttMSNW1qJZtsZwXUw+OyaKQcr4
         XUt6ePr5sA/vmOp763g3bn4vgt5jrDeX4t3JHrylNyp3Njs6OVba0pOZHdvQCNx7H8dA
         lXAuhR6vVfuOc7AJ40p4YHFCHN6ME7ufqAOjgy/YSBbbF+/pboAhJ/qw5WOY8VoY9X9U
         banC+BdS+zZ/xpnucnU/jM+zEzW5zlvUrgMOB8Bg11hiZZr6Kpganr47LUh9GH4dGfkq
         //5w==
X-Forwarded-Encrypted: i=1; AFNElJ8nGkGro6ny25zOny9Mq66fgLqVsCuTuX0mnRSzVlSJLTElZFV9L5YZbMkKTWfa7KfXII0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7DO0fKHT2wdEw0IhrJA4hAE5L6SjeB7U7U7A/mmt29y4RjniX
	P4RxSDVCuBRz0l/+oFDOqo5i4eUpJKueq7glhvDy0nwasBiRP5UG5bd0
X-Gm-Gg: Acq92OEQJrw6f64Fu7oiCJ1jFJdr3VSvYWPMfYnUWMLWyYKEc3eChqTDZu6gnHFr2oZ
	+nPJ2/n5GmxtKYwmU8cXFqvNWjhNAbrrue05Ijpz9C3MdkXWwDwPdJhwxQ+E86D+uLHjM41iqXa
	psxDsfHx9AWCh/rSlobGprg2hdBsNAL1gDFoXysdMNB/FLzdff6pHLYjqA50a7dgGoTHPGF8f2V
	AD+QJT1ys0yz4PjooiZQic2tDNjXAb9varz7Im7BNILavIlxk4UxzP4v9FwrlpSwwG091HOBIuc
	IHzFu7Yt8yj1LwJph0nL7YecLYLPJdFi0Iq/xOIRT7CyTkRpYKixTLeR2FeHWSbCWwVmi+gVUDM
	ErBv4OiJ6HGvFJE/FJL/w9+Enioxub4MhePLcxmTJ1ns+f74idrM77QtwawnmeK4VGz08iwwNin
	QjXbzJFgBZXbnH/2QPsV3MqyJzPO1+wb/C7ksQ+AIj0R62kdVZiRC58z3bL65XG4CVE2JfMT90s
	Yms78NfpxHLV0X5rw==
X-Received: by 2002:a05:6830:3c0d:b0:7e4:163:49cc with SMTP id 46e09a7af769-7e784660540mr10242231a34.7.1781538756976;
        Mon, 15 Jun 2026 08:52:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfde9sm4374723a34.24.2026.06.15.08.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 08:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 08:52:35 -0700
Message-Id: <DJ9QS5OUJTSG.1DSRYHG6GAG3H@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix packet pointer invalidation for skb
 dynptr writes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
 <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
 <baea5363a0e35d1dc16d41b972d9a9e89cc85b46.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <baea5363a0e35d1dc16d41b972d9a9e89cc85b46.1781531784.git.chenyy23@mails.tsinghua.edu.cn>

On Mon Jun 15, 2026 at 7:14 AM PDT, Yiyang Chen wrote:
> skb-backed dynptr writer kfuncs can mutate packet data, but the verifier
> leaves checked direct packet pointers usable after kfunc calls.
> The bpf_dynptr_write() helper already invalidates packet pointers
> through clear_all_pkt_pointers(). Make skb dynptr writer kfuncs
> follow the same rule.
>
> Keep two verifier predicates for this. CFG analysis runs before register
> states are available, so conservatively mark dynptr writer kfuncs as
> packet-changing for subprogram summaries. The normal verifier path uses
> the checked dynptr argument and invalidates only when the written dynptr
> is, or may be, skb-backed.
>
> Global subprogram dynptr arguments are prepared as unspecialized local
> dynptr pointers, so treat CONST_PTR_TO_DYNPTR local dynptr writer
> destinations as possibly packet-backed. This keeps packet pointer
> invalidation sound both after global subprogram calls and inside global
> subprogram bodies.
>
> Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
> Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
> Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

nack.
pw-bot: cr
