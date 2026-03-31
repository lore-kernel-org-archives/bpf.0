Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDA364949
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921511; cv=pass; b=gMcnv1dKGP+Hcq55RhrqL6y2shQxbqSWpziMzcx6/qtO5hzEMqshENR/D7AFLdv9cgbyZq5n6qtbpOPBvq5V1dAP8in/HGEhCXUcYAC24BUQ42ab2wMyz40RvoKBSw6q7gRl0o8q4Y7WXR3kGUF1accMu+KSBWmkWaUfkmT6IkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921511; c=relaxed/simple;
	bh=Fd6QAcJI16f3MqUm0f9PMci/8jTCJThqTHKrceWrBx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vD2E/d1fCBqstTxDGJLb2dwc7FFX5Q5GU0n5Kxb5FPbwUI41VhXlKLoAbPyRjVVKg0iceqQPdlz1ukTYx1fY7OBWUc+ynVYi8oqnyCJ56j/ZXQn8nRfzOqbdyis3TOJAzs8MBocQX/470YRw7tuCAkwr2en0Jh/AJak2cwWpS5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcE0HBLK; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcE0HBLK"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67c20ed3076so2755349eaf.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774921509; cv=none;
        d=google.com; s=arc-20240605;
        b=Vf2xN2YoZQKW9HrnQVUfXjzzZXKSVsw9kT3tVmRjdhLoNm4mmMOQIVyswurAqUFLNi
         ysonHMOMFHbElH/mXknDzylbjxvFOEyMkF3Q9eym3CSklDzOKVBT6tW3/uoPwcRgjlIj
         TnCoZFUkAZhtOyl/9XVCLXLZ5N2miYI8n04JNu3YUff+dwsVSVq7y23Wu814+LRRyrER
         zmd1vMuIyp3HO4T8OrK5ljRZMaXpvpvfWNq0DF+uxcWEj7olK5d69aQXCWcNspZuIn/S
         DKFyUmCzg0k5iHxE+/qn+4KcqYyex0iHn2t67/MvHelqfBmZplOvGH+GkwwgfaGZnat6
         nKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=65uWDB0Qv6BzU+J5GLRhSZeSW/d9SMCtWTbJ9K48rfo=;
        fh=A807bsOnFkkDFqqTT3UVbKAfJmnuI/X17ik43FN4iog=;
        b=J+xXOn2zUIA3tPx65bPojRbfUJrcEhiQzonJ1DlnL27UDtAhji9SQvHtV1edzaiiMC
         L64wEg1qkvbJLZaf1E9t5NsVWD3zlrqCkydSLVKFUwtB7om3IhjNBzfLNys5/YZGU2GG
         /5Sr8Rhyv1tTC4ZEfDn5tIlBeWnLfQWtNgLU5pTApgmJlphb+AHOFBoyk4IO8IPeKgzx
         rjyhydsSnkw/NXFNHhczkR9Wfg8ooXqL6SNf+Ir8sm+jx+OYT6+EomRe35u2/gWBGt63
         yj20Hr7TCgE2Ag+HniCpdg7iPiOAWSJc7YdjDd3OWz8neBliTgz9QVvGKhLp2OAF77Bh
         a/mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774921509; x=1775526309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65uWDB0Qv6BzU+J5GLRhSZeSW/d9SMCtWTbJ9K48rfo=;
        b=jcE0HBLK4MaIisG+4dNnZ+0hmn1BLlRA0tM/9bYf7lNTOiWaiLr/sh1k767qfzqhmN
         6X8Z/KDHIo3Ysyoj6TZk6nIsdQKD5HB1xhWbNAmfqx4rVCZW9Qhwqyk0Oy+4BY9D/f8W
         4K7d7NC+cFHyfvZk/ACCK6XE7NuXyjRWg4FtWS3l6U2rp3x8BtAoplAPgtKpWIw0h678
         Psedbiy+85C/Q3Qfz6BPwmemyX7DV3xoIQJ1CggsiebNzqwE+4sKJGV/jx068FyXlUYd
         6hpHWOR1GkFuuXzPfULLVEFlo8lvXIVLeIuCwY+2ej/gRjWlDUrww7TdEtb7fQWYe1pS
         Mcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921509; x=1775526309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65uWDB0Qv6BzU+J5GLRhSZeSW/d9SMCtWTbJ9K48rfo=;
        b=buK8fJ4NWiWkiMnYcf2gicT2/2pPQK6VulLqBGnlnpY0UFfcXfmsTo9UD/BY8408l0
         RB2ZInu9vu+mgcZueQLFS/OQTB5Wfl26ov2SFXGbq2vv3yTnU4KDN1Hb0HJvDXsiCTTr
         mrgNJXeDJyCWPmyHrHbT57p1x6Whj+g/p1r1O4XkREhiE+x7Y+lUnInZK+n8jry667Fh
         e13OYlgpVaYiB7paDpq+IsqAkrIayFpFOh5YWMMAlHR+SpKFOcayrAeUfiSMVSLGhcew
         SvN5R41HnrhQB591DT4yy9CXpvHAfXRw26utlgXKGawZ3+jwA9xArf76lsDkEebUBQmZ
         LJMA==
X-Forwarded-Encrypted: i=1; AJvYcCVaz99xvghBuhrjAXvEJU9MZY54HY844/hG5VyfdZoazXElF3/qnYXr2LnJvACiySYm98o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqyAEvZCPMQb7RtvviarxacpZzdiwBDyu4WE43h3lV/wGKzbeh
	yvmeh2ZY3Xx9tLNvHsKoGohk7mUeBONbMZwQSJQ7pt4z+dKcItCL3F6S7crGcbu9J8EeUsNztXY
	0euoHqdRtpaCCVLHbv9W70Ds+0Z+PHEk4xXQUqFvx9gkKClK1KQjyIWCP
X-Gm-Gg: ATEYQzxPZLMx4BydHgxLAIRsqeN8Sm5YFYI7Ihel0LX8jXpBJZpm3N/DquckTHxgjKY
	pauCiM9MeiTv37rxm3pgxE00sk03pkv2o1MqVEqnamCFnHDZYU9DxbGmmycZIwbaaGC7bZd61kz
	jcrrdMatDtNi49X8Ue/z7/EPRQ4w9m9YiIJdMJzS31yKkFgoIZrCqQzzP6YwU/V7uuNNPI16U3A
	n6677B52Pd03MI0ybcHNF/6I8zfSCQ3furQETObEblZRxKHQC5PwBqVDRnzgjFtWU1PdXGHRIsI
	PQwnFLs3m9efgl9HHAqyL4mxMGsDUra2voVE1qwyoOjZLG8F52atGebwMGdlRrCKnr0TFovy
X-Received: by 2002:a05:7022:220a:b0:12a:6c4b:9cf0 with SMTP id
 a92af1059eb24-12ab284bbddmr7115803c88.3.1774920966145; Mon, 30 Mar 2026
 18:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330080746.319680-2-jiayuan.chen@linux.dev>
 <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
 <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev>
In-Reply-To: <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Mar 2026 18:35:55 -0700
X-Gm-Features: AQROBzAoWaoGMz8lgwUE4cc5pzeu3Q6dad4Ef9SHjpneA1fRPQ9yGPYn9pz2kSE
Message-ID: <CAAVpQUD1n7L6LkP32H_Ct71RLNpJ2RQWFc8w08+c8h=U_tDjpQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, clm@meta.com, 
	martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 2:26=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 3/30/26 5:00 PM, bot+bpf-ci@kernel.org wrote:
> >> #if IS_BUILTIN(CONFIG_IPV6)
> >>      case htons(ETH_P_IPV6):
> >> +            if (ipv6_hdr(skb)->nexthdr !=3D IPPROTO_TCP)
> >> +                    return -EINVAL;
> >> +
> >>              ops =3D &tcp6_request_sock_ops;
> > For IPv6, ipv6_hdr(skb)->nexthdr gives the type of the header
> > immediately following the base IPv6 header. If extension headers
> > are present (hop-by-hop options, routing, etc.), nexthdr would be
> > the extension header type rather than IPPROTO_TCP, even when the
> > packet is a valid TCP segment.
> >
> > Would it be worth using ipv6_find_hdr() here, similar to
> > bpf_update_srh_state() in the same file, to walk past any extension
> > headers? The IPv4 check above is fine since ip_hdr(skb)->protocol
> > always identifies the transport protocol directly.
> >
> > In practice this is very unlikely to matter since TCP SYN packets
> > with IPv6 extension headers are essentially non-existent, but the
> > check as written would reject them.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READ=
ME.md
> >
> > CI run summary:https://github.com/kernel-patches/bpf/actions/runs/23735=
111188
>
>
> Thanks for the analysis.
>
> There are many places in the kernel that check nexthdr directly without
> walking extension headers.
>
> I'd prefer to keep it simple for now and leave ipv6_find_hdr() as a
> potential future improvement if needed.

+1.

Given this feature is to create a reqsk to process on this running
host, it does not make sense to support such ext options.
