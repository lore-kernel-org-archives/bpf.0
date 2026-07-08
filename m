Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E52E3FE
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485799; cv=none; b=Fs15i5yNjzKWCIJJOe21MXPLacmt1uFsjv61LKye7BA8+tqpajErMIVx6NITiue/v3Vucrz/7fJvYbaxAZ5Ihe533JKznbwludRb3aOjFUVZ2UjvTR1TqWO24Fg2q98JirBx4jGDv0uGewL8pr1gj0Bcghrbj//h5eYvx4o4deM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485799; c=relaxed/simple;
	bh=FAoptCMB2sR5zqcHYSt82rCp/yEQWpVdGexkr86eBYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Eua+AGT0yvM9vzBSBQ5lCJ0OTPF0jeeCC3O3eRZOfoJuZtlckLiULbK5JNPfqMhGGcTp/pwWfoayGKHpj8MfNAt/zQmpdOYjlTNSTHnrKkWzlZGDErwP+zYmf1ewYpNuZ2UirDUuqwMiQR3RyeOZkZYf+fFKUybYv6h/5cauwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBniLzzD; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBniLzzD"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-493e63f4ef6so616705e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783485796; x=1784090596; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FAoptCMB2sR5zqcHYSt82rCp/yEQWpVdGexkr86eBYQ=;
        b=LBniLzzDF8R1Mu7A5VE9jTEzkiRIhCUyrX3TbdeWmA2VwinaInalmdB0sTsR+2XZP0
         5Ac2twMDJhT7Gi1YZ9wzM1oGl+jbbbx3vMsn64/xwx/nC7bjZZ6KKBxhNUGDxs3VcVze
         AuY9HJfA/FnuG7ZDsaY+XAlJUdC7bhcxUc/Lqztbb/bc6jbArOOeGEWxczsuN4P7xskP
         wPovmAzyP2MHOMVZ6pNOY5fh62GVLCR+44/VrihAgrkrDbNEP2Us8cdcSwH8O6ItHC8O
         p6lKMQqD02LGAJs6C5/sfhHvQoZ8kf0RgxOtLvDxXtIRG+CkedCj20zTWXP94eYAYjI8
         YalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783485796; x=1784090596;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAoptCMB2sR5zqcHYSt82rCp/yEQWpVdGexkr86eBYQ=;
        b=tCP8Q55Bb/inCq/WpILQnFn1MASgymy+3GyfhhqlhKwf/WZI4l+j3ZlmcSzug1KBU7
         W1HgXUsICutMe0s4sBzuB/9hj+Kz3i/pkRhdjYRwLN5SnVWHIvztv4zoXo98+KKg8bfM
         zZvrgm4286dC0RL9lo8vFWxj5Gs+1NUKtp4M35cnMfpG+13hOTtvV979viLkKt0wXclT
         xXwPrvahLA3b5Zqx/OO0m8HnsQcTUitzRu7DzxtjVK7bAiKk1bKVH3D0mEjtPUvp9NTv
         pG6vv5azl8c2I48Dajy9iuiKTlhJbSswC7QZsqmLxrclU0eQeCaDJXUFv8x8DVS84zUS
         4t3A==
X-Forwarded-Encrypted: i=1; AHgh+Rqe31RRvKsK/ClU8OHRglEOG0ZsSddgE/Caw56v3T6fXKwHmL5cpCK3QVeB+EZ40HkvHH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypkaaNGQqfB6049N1UCTnJO0i8xQgr5ZuixkjmCsO8mVrTD872
	udgnfnFZA/NAv6aTJXoC53czNemlPr2CZrDmoGilUw5LVME7sPVeIFvl
X-Gm-Gg: AfdE7ckMoEEeQxciidfqk88BxkF4ZXQvGa2Bcoh3koib1ZccNkD0jBDh7E5sjHjReKU
	LT7HSjvIHEozVh5T0r22PgfnE0A3tV09BCdzyJXQtfWwMDreVMBdzINSURZlMdqjerVF4EA5D5z
	Qu953XAiY9A0GzfAWh4Spi15Urvz8F4+ut6sPdKzpRODTaDwv/5BBAVt0Vd6PZD8h8IlyidLJBg
	2poMb5HYmUIOXlY2rKo/rhK176/9NA4qrCELAZd5HJmEdPnpjh80mAjn5JvUplQ3rDdqkr2gpil
	qWdxti2dAD60SZxTb1m8tQ1PDcTKRk170IPMX/d1By0VOrYWlMPD8vwmAjAMdIENAa4J1NUxO9I
	tQJLsTWrfoRtrPB92lSZcBZ8/biPRdZR3mT3fGliyCGnXL3i52iKI6JRalQ/EzDaHV5uA5xm/+w
	pFE+8FnQO2RlXw6t86uke2Ri/74iWZVBfUtmGi5j53kHSThrPzGOxTdt2Vs9yijurXyiVuhMl8D
	lACiPtyKeitWcWjekcOckLdxB7sugixU1RnHOvxOOi95K2cYHWBjLIRlmfd0PHHEw==
X-Received: by 2002:a05:600c:4fd4:b0:493:c0c1:3930 with SMTP id 5b1f17b1804b1-493e6898af0mr6142695e9.1.1783485796334;
        Tue, 07 Jul 2026 21:43:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5ca1fsm116627765e9.15.2026.07.07.21.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 06:43:15 +0200
Message-Id: <DJSWY7PQZK30.UZVS6AUU453U@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <mattia.meleleo@coralogix.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
In-Reply-To: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>

On Tue Jul 7, 2026 at 6:15 PM CEST, Mattia Meleleo via B4 Relay wrote:
> From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
> tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
> counts bytes in ingress_msg. Without a stream/skb verdict program
> nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
> returns 0 even though read() returns data.
>
> Add tcp_inq() to the reported value when the psock has no verdict
> program. The two queues are disjoint, so bytes redirected into
> ingress_msg from other sockets stay correctly accounted through
> msg_tot_len.
>
> Add a selftest covering FIONREAD without a verdict program.
>
> Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
> Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
> ---

Please respin with the fix and selftest as separate patches, but still targ=
eting
bpf tree. You can add the Reviewed-by: tags to both.

pw-bot: cr

> [...]
