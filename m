Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00EB1FF7C7
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907896; cv=pass; b=VPbNe5TLeqSY3pjbjIQkT0YXKR+q24LqYdQc3zzm/G5B3r/e3ERO1Jzwh0IEu4T5lEGaFVcp54kg6uecyeRjvS0pDDUOv6jLS7EWQYkebpeThtHXtJcghhlf4OYVIWnKIZecIsQi6nYKRiZD6ANt/RgNGxY4YJu27OPFcuP0Y8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907896; c=relaxed/simple;
	bh=IdT7Cnqlw0gbduzUyd6rGZsiu6oNpbZ6fLa8v0srGMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGLE6fh+swCOmzRX2cdPP2otU/TCUjZWN4vMCJl5ok0ELGgkwyIAXx4UJMwmjOWa6P1+aVsJQ/hcVwn8uiwtnWiCObK7+c2SkDVekPQJ3ynil+EI12HrMDCyp+bOAu7P6vvsP2v9I/tuxrK4kiaiSeMai0h70L6YwltynPmqyIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RuFIMCT+; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuFIMCT+"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5018ec2ae21so44951801cf.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907894; cv=none;
        d=google.com; s=arc-20240605;
        b=gv3Dra9aNBgMhrHP0Ipt5oXcFTPfy/Awbn4p1stOEB3q7g7pVM7vpeTqFA6n+vXZPn
         yRHTrgjBNhd0shWg4QyMYxF2j5pwDacPam0SgRYZFMlA0EVc1isqwfF+bdCu53vEtLWJ
         A/WXjncG399tByUXlwpMuLdEeJjOOohEEstn0tIvUI1TPRJA85Rl4ogR9gBCtcOuh3q8
         lTi2OYggb849+yJSJLfVFUoME4oLYtJqgf0PkqVnVJZGLO7B673MzPapUeoxlfJMzuCO
         VA6F6bpmTWYl6IoiQFRHgw2jkTQPp2g5h0ANMbhZFh5vcpYhZ4SrG9JGrJrrcSR09e0t
         1pZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LUXil22tiizCYyaIA03hv+e6KoZWp5K7Bky9alaR5BI=;
        fh=WrkMJnC5Poc+Ml4OQxbfYg2X4Yo/Ka7nJ0+NqzUQThg=;
        b=K5K57K81KFnnYlSo+hUzWhXF0/jmyoW8rCU6QRdzdngcogcW+4klWVf5O7aiSpfXxz
         T0teGk7uu7vEe78kl2X4825MKAwb9Re85tMVtdDl1PG3wg1PzAtziRtNXl04gZjFxP3H
         oSDmDZTSBepf9cIABH0oARvGOQoQz6zCORYpefPdofSAEqnr9qZF2LD0JBn1AhpRuIgG
         2nMAHxDP4eO0hD/1pucZhBaQHjV1Rb4Fcdy+H+/fI4mzcZyOroqUGF4U1MY4w+pNVMqh
         BaXM98kbTBBz67VCgxfRa/U1d6o989zYkIdCqni9Av3NVhK7f218am10/nUmGKzZUf4d
         c9Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768907894; x=1769512694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUXil22tiizCYyaIA03hv+e6KoZWp5K7Bky9alaR5BI=;
        b=RuFIMCT+LVz7niNHIRJQfbaoPRSsdO8Hqz0Z/J3m63nr6LKihwAtY76EjTAxL7Y5He
         DTI0+HBc2DA7Wws9P3a+ky+IPgAJiu38WkSpaLB9WI4HPkcQQJa1O5OABpYGa+wOaog0
         2Xbxu3SsZ+voGu4vgCZtfGmL2Jx9v9GWUY1tMOd4nk0RZVG6ynthaiaHNcQoixfRAI/x
         eQphwNh2B/mS+Kq3XTCmbTH89oN2NySA/zUtUdQYuoihubFh6NZjZW4Z0lv5RxuG5udH
         jlwtVEf9G+ok8ktVWOYSAZZ6NkFiMIZO0+uEHNZYn/kHcdsP++8gMj3Q8f5KClcKCmsF
         lhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907894; x=1769512694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LUXil22tiizCYyaIA03hv+e6KoZWp5K7Bky9alaR5BI=;
        b=LPcjBAhLTfLWCCqcSTpQkbv0A72c1Qw/1yq0bqjNfq4rUPE6xL9Oxn5QNYcvMX8MXN
         HsxbEyNG9EX2oN4uEhqpJ7e7HRkjcFZwax7XBNz+2KxpJdJ8R5KZkmMgEXblSUbuGTYS
         dG8g6z/ODLlGD35CwM7kHKVZXys536SvnXoiiGmhCKVnVcJdTA4HBAX1AajTKMJuwlOt
         qZY6PR22wPXJeoF3B1oTQKNd9+hTwEfcrwP+8dfA3iLFfKDa861fvHJbu5lpVP9x9nBf
         mzlSJfi1aUsWCU12axZJkweoi7HVoO21V4Zx6AbnQZbF0VM47qxg37xsSZT7UdfoCtiD
         iojw==
X-Forwarded-Encrypted: i=1; AJvYcCXrwXpR2FxkQnvDRO1nqtvBrtjXstORj+A9l3mZkvHchT4DAzchMb8jiDGUvMqz6fY/0hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfeg9M0Atpa0nTscmzaZibMJFh/KoNJ2m7nGx6pRS4OXDY4Iwj
	lKxm5asyLyCjxl02pfFPvzOw2Ccaz+9txhl/dsWgjhMdYXzbYk5vOTiJyMgpN+mib140ecXqFvT
	58u8HfOYCPxRpPDSh1bjI4sEfup3FlQ8pvV6hj2ZP
X-Gm-Gg: AY/fxX5+FGKlSdpTecszufI982XZ8nBIvNE0b793kuhOgco2KNqzpK+zaUkDPc2WjbH
	d0zif3Kykrq+uVScRYXMu05JIluqxjJ6lX9vjdt0K6hdwLGOAfhbcA9VSXuNdRwD1gUBkEfNewu
	WcGePZ7Li/RxFS/Lfdy7QwYVt6xQUSnUGS+fuH+3t8lKB3QupKxQCmjiTG7Dqeu30KKnyghwYaC
	xY79mYJM4I4b4YEkcL98F6AzETfCNdH4mCNwzztzCAtU8n3HDTGzlFnAwR48/ri07LRQfs=
X-Received: by 2002:ac8:598d:0:b0:4f4:de04:2434 with SMTP id
 d75a77b69052e-502d84b0bdfmr14314171cf.11.1768907893248; Tue, 20 Jan 2026
 03:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-14-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-14-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 12:18:02 +0100
X-Gm-Features: AZwV_Qgc8lwWGTeaXcXgJnQwinHD3Ss17Aa4vUO4GXRwqkl214KVxmDeii_C688
Message-ID: <CANn89iKhAs3rMWFdmM-rma1wS-Xd7mf9PBUQKL8YMKhB81Jkkw@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
 tcpi_option2 in tcp_info
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Add 2-bit tcpi_ecn_mode feild within tcp_info to indicate which ECN
> mode is negotiated: ECN_MODE_DISABLED, ECN_MODE_RFC3168, ECN_MODE_ACCECN,
> or ECN_MODE_PENDING. This is done by utilizing available bits from
> tcpi_accecn_opt_seen (reduced from 16 bits to 2 bits) and
> tcpi_accecn_fail_mode (reduced from 16 bits to 4 bits).
>
> Also, an extra 24-bit tcpi_options2 field is identified to represent
> newer options and connection features, as all 8 bits of tcpi_options
> field have been used.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>

Are you sure Neal Cardwell really is ok with this patch, saw it and
gave his SOB ?

> ---

>  struct tcp_info {
>         __u8    tcpi_state;
>         __u8    tcpi_ca_state;
> @@ -316,15 +334,17 @@ struct tcp_info {
>                                          * in milliseconds, including any
>                                          * unfinished recovery.
>                                          */
> -       __u32   tcpi_received_ce;    /* # of CE marks received */
> +       __u32   tcpi_ecn_mode:2,
> +               tcpi_accecn_opt_seen:2,
> +               tcpi_accecn_fail_mode:4,
> +               tcpi_options2:24;
> +       __u32   tcpi_received_ce;    /* # of CE marked segments received =
*/
>         __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters *=
/
>         __u32   tcpi_delivered_e0_bytes;
>         __u32   tcpi_delivered_ce_bytes;
>         __u32   tcpi_received_e1_bytes;
>         __u32   tcpi_received_e0_bytes;
>         __u32   tcpi_received_ce_bytes;
> -       __u16   tcpi_accecn_fail_mode;
> -       __u16   tcpi_accecn_opt_seen;
>  };

tcp_info is ABI.

We can not add/remove fields in the middle.

You must add fields at the end of it only.
