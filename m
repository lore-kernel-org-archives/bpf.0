Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AD27B34E
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907102; cv=pass; b=llWxkNtF2Eil43Z7Twcp1MCS8TwFXJ7msuL701ZJ2HbJ/ryTfBPRhdbzW5J5Fk4tUtE0/PapjwSWajrrhi99M6h37GyP5ZBEPPjRPIc8nW/4mBLZdjst9xXCpKBJSsMaTOeINjPdnUTM4C8I13MMjKEB126D9vxwEs6FrfwMwo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907102; c=relaxed/simple;
	bh=cnNo9W12NhCz5DB49rDqOpnrfJrsY5xjkCHj5l6IZJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vl2HVm3DQkWo1AYvRnG6e/bUiYlEh17tJkz0N1r62C2K47qCW2E+N2z15uQqNWgH7QBn8bbwfIpiI2E5IdZpUkE1YWrVQzGEKJ5Xz5VRCs9qmTq6wzjsNFP76NCWOf00UdKbWgYCOfGQFGRB09Zo+q7U+bSqgf0+fS++eytGe/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0OvX2ojV; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0OvX2ojV"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014e1312c6so24747131cf.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:04:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907099; cv=none;
        d=google.com; s=arc-20240605;
        b=ibcMFPZ6wucWbAoOtQvZ5U/MCQBfBWkwSaMU0CB7rj8Yf3Q4ORUBrjf4mHcBg4cxcc
         bPfHNTgAXyT2ldM5/QvZN+ekUDNqj5Nxgu5llr1eRyG+bLXuOUqxoyLqG6zfmV7t9AhI
         MuZIenALlhRLAzO9cUwNdlAAsDGfAzGTmTxB2NxbXCzqQHfMbb7gyh4awGlqimVtdLkH
         3Gx8Wavpw0Ivgf/+sMMCguACSXbA4+2UZ8GqvKIjW3+/Q6smUzABfyugZecfgWUsmnoB
         iA++TY7FcJjpou34GI719vF9QonxoaHryB3Ou1zq5twAhcQAiIP6vDdUHDjbkz/56HB8
         bhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KC9nK0KpQPdmvTA7SrKRg+ar3wUw4irfinZL9hXebI=;
        fh=FhAfTG8XKOSdjjU8Tz5008sXXp8sKUfwpHw4RNmYXSM=;
        b=T422mQ+qXICuw2BuPgHUWBgE3NsJRS/OZgufNOhGvAOyea12TBtK/ZjXbSIveOli03
         T6Ep5Ntm1Gfuf8qSpDe5kPsQEvgsOWjK05uWnpoj2P9K0OHA4lp3i96mOSt9WzI90ZMS
         Np2XqttfI8kfCjVZMkC17H4wKllBHUDfeylvU74OUCrQ29b/YV3lMu2OVXsBTwrLxVR4
         IvNN6JMI6PYvDQPGx1shMUQb7DPNEQNDA+72lfzQE3vIoDWNWHBkzcGzcYZ6ou9pPW5D
         Z3RPBt+elr8RWYw3NfKKV4Fvqqa8T20owugyLYJmkdzDBqDGbS0y9g/DWTbikZPFmvRn
         cp/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768907099; x=1769511899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KC9nK0KpQPdmvTA7SrKRg+ar3wUw4irfinZL9hXebI=;
        b=0OvX2ojV+3vqnvaV4xrU6+G21Qtn1xnc8WGr/gIJe+4bn+fcki/sjEKNHo8NMJyx47
         lO6rtKPsXDPBNdKbbIR52kzsu4CqavaVN41ag7XrJoBrk3KyeKRE6ciMwQmlnC37eYwk
         hxASpdqgH7dcK0K3GUIS3ZrhPc6IfRQVb9/kRU9wV11pCQobB3Vhc2TOuWulkikpYZNr
         +5VboIYew+Rpj3rQglzEGBaJnMgGWLkcbEoQiXC867qs7S47Gi/WTsA/Ywb6cyCJf2jU
         m+X5kYYAzc/ZpAiryj+Z+Gf8PfSpC8Iq4s+ANsF0FI5ZdNZ+CsBWJAgoSxfljAAM8MQP
         F+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907099; x=1769511899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KC9nK0KpQPdmvTA7SrKRg+ar3wUw4irfinZL9hXebI=;
        b=n/EBKfoq1u8MSztQrjN1c5cQuXcZNFRCxIqFZUcKvQDTUN18gAzmApfy2ySKE62/7u
         nr+nCUhgp1338V/D+OR1NxuPc/ubHL3npWfO2Ykb2h8WJnKgSNCFtSY9fYR55GXUt1Ae
         RLs+G9t2jeGRy3O+mFoZZOz0yMOVGA/1r2UapewwxjUNvvtbBl0vWNLR67gttTzQ3AOE
         uS0fb+xj7oChYsroGoEjx02j5dKG8y7ye1IVjTb2SSZPxR7FR8ElcvHU9SLtMcR1O9+9
         ezkqX3fIU/DZeO5n54Mzg3UzqFwKgn+qUHhrT9ukxMpM9Y2MVw67g8R7aPYvBAf0igF7
         3o9A==
X-Forwarded-Encrypted: i=1; AJvYcCXH4O+qy0B6XVNxRUkklTjrPNwPWpDewt2mZqHUk3Vuoi5Yo2qcCddwPomEOHO1adyt5IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiM2qseeiY+YMRQ+eCQjp7VAsxcB0QhD7TMBj90H3X14tz9ZjQ
	hMpWo3EhzTc3NUBl/14b7kdhP7vlWEkZOfunM1EQ+E4U8O2CNDaRzw8v8b3ou3tHa+0+BjyFTw2
	s20Yh76s9agfyWPM/UDrwgIfCOylYC1QPy34MnOWc
X-Gm-Gg: AY/fxX7bQ1rA80Y5uIoHg8Lj18x+HOs6oHIiaDxWzGX22TPf+u7le+hGzPLSiSTxeai
	kV2NjdJUlt4GF0c89HuzejW0ustE1Df2o83eKMut1kpBhFhqiUcCOMN9ypMrxNweWVJFeTMkfoV
	TjssV1R/EhWIFKA8EyWTuenyLnAPKAl6zu0EYa2X6FoR7qSKWnP/DzFVs8eXQxBUx4j97DAnlF5
	6gkKcVETNeLyvFj8c/ei7jUAA+Ze8wOAlLkesXQV2WZAEcZBNxmusn1uJcnayptuJ6lxww=
X-Received: by 2002:a05:622a:148:b0:4f3:5961:3208 with SMTP id
 d75a77b69052e-502d82776d6mr12850331cf.12.1768907098103; Tue, 20 Jan 2026
 03:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 12:04:47 +0100
X-Gm-Features: AZwV_Qgu9ZDw1Q07OvyxlnkIP9uze425ltlSjgpCGKeRZRntsHDU01ieZ5kjIGg
Message-ID: <CANn89i+NEyZ+1R1pouUcroarCfNrQEN01azsEhOuZoeR0Y3mhA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
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
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
> AccECN mode MUST NOT set ECT on any packet for the rest of the connection=
,
> if it has received or sent at least one valid SYN or Acceptable SYN/ACK
> with (AE,CWR,ECE) =3D (0,0,0) during the handshake.
>
> In addition, a host in AccECN mode that is feeding back the IP-ECN
> field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
> latest valid SYN or acceptable SYN/ACK to arrive.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> ---
> v8:
> - Add new helper function tcp_accecn_ace_fail_send_set_retrans()
>
> v6:
> - Do not cast const struct request_sock into struct request_sock
> - Set tcp_accecn_fail_mode after calling tcp_rtx_synack().
> ---
>  include/net/tcp_ecn.h           |  7 +++++++
>  net/ipv4/inet_connection_sock.c |  3 +++
>  net/ipv4/tcp_input.c            |  2 ++
>  net/ipv4/tcp_minisocks.c        | 36 ++++++++++++++++++++++++---------
>  net/ipv4/tcp_output.c           |  3 ++-
>  net/ipv4/tcp_timer.c            |  2 ++
>  6 files changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 796c613b5ef3..f5e1f6b1bec3 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -97,6 +97,13 @@ static inline void tcp_accecn_fail_mode_set(struct tcp=
_sock *tp, u8 mode)
>         tp->accecn_fail_mode |=3D mode;
>  }
>
> +static inline void tcp_accecn_ace_fail_send_set_retrans(struct request_s=
ock *req,
> +                                                       struct tcp_sock *=
tp)
> +{
> +       if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
> +               tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
> +}
> +
>  #define TCP_ACCECN_OPT_NOT_SEEN                0x0
>  #define TCP_ACCECN_OPT_EMPTY_SEEN      0x1
>  #define TCP_ACCECN_OPT_COUNTER_SEEN    0x2
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 97d57c52b9ad..9d16cb9c3db4 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -20,6 +20,7 @@
>  #include <net/tcp_states.h>
>  #include <net/xfrm.h>
>  #include <net/tcp.h>
> +#include <net/tcp_ecn.h>
>  #include <net/sock_reuseport.h>
>  #include <net/addrconf.h>
>
> @@ -1103,6 +1104,8 @@ static void reqsk_timer_handler(struct timer_list *=
t)
>             (!resend ||
>              !tcp_rtx_synack(sk_listener, req) ||
>              inet_rsk(req)->acked)) {
> +               tcp_accecn_ace_fail_send_set_retrans(req,
> +                                                    tcp_sk(sk_listener))=
;


Ouch.

I think you missed the fact that a listener is shared by many SYN_RECV requ=
ests.

Consider it as read-only here.
