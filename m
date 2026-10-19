Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423878;
	b=oVWlJitolR+41XbxOOtsrAW5uVKRO8efxzeq7Y5XudQbMzPgOFGUjzGCDchEc98AMPJp
	 F7yKrlmMD178z9pham/TMmXcjednKnxPZ5HW/YbCL5aNrou2QG1u6SKB+0RjLAoG0LuE7
	 7SVGnHi+rQFSG2/ZPQUmtE30LaC1ig/mwRFAsT1al5XIEjm3xdX42jwFrNfpn/554XinD
	 MG36jL27vZTutVBzM3+XFbe+/yELQL7Vr8JQNKzERpKQ4KyOSXddfmvVmSMviTy1rMTf0
	 KM1pxx8OhA6Ep7xdA7yF6iUr0ZikqLAHK0SryUjJfm4GklVJTMf/2FnqvnHLfCYAWdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vH8K0tY0TTIHvq5G2+R9r502vTAhxsKA0mwhegsYO5c=;
	b=Hnn/gyz/uctx58vwG/SqEgDHYwW9YHMafI+YR1kWjGwI5knOl0S9xvWXtiPH3TxRX3Vi
	 Z/3aVRVh5TL+9xky+yw8cQehi74e2pi84Yg/FtZ9JdLZzMjA1eLdGbkvUfnmvHaVN8PGm
	 TenoYrQoH0xTg1ik10wHy8bgXQs7vFYrWm6qPj6VmH8Uv8QVH2rueRNTgWSGRJw6zPs7d
	 TN8CGLVNmrQdBAZ0tIXUHJ4J7WFEP6Skt04Bbt1WiX2jYk9IYSyLP5c3YJGKULSAS18af
	 WyT21jihGGvDH77RKcU5nCXR4rz7xx7phVCoCnCALUpvj7+auaaeWvkRN3IFy6uy/Vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UPpsJuHE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70660AA0FD
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E70660AA0FD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UPpsJuHE
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-533202fe429so557151cf.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 08:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792423877; cv=none;
        d=google.com; s=arc-20260327;
        b=Y4XwQp24wQRPVQs5/ejsMjQd0OlI1oe9X+LdWFn1ccHb+2PCYC9Bo4TJ9xka7eOBdI
         b5UbJQLpRtFFPx9MWmeJGlB+J+Xle6JgCBhbBvVsiYwya8DbvyczaO2I6oBgFB3LXAqx
         OHFTOybVAWhMGfWAz3jXPGp1BswUK7xxOpGCyTCkgcooRTFojkiwsUaEPn4ae6r4w+9L
         O5zdbws+3XcmjbR/uAmsZiXAbY2+AdG1g13m44SdYPB7/62Ck671e8/bg16pz/d9dzBf
         NCMIPuo7Zj1X4wPTWlrGKVclXhTYYFr11OUAQGJwmZ+G8jR39+h6YqwkAmFB879mEfJq
         U2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vH8K0tY0TTIHvq5G2+R9r502vTAhxsKA0mwhegsYO5c=;
        fh=r3Dlos9aB7jO6Y1NfhhiVKYZz5MhtLf4ConXZzxVA00=;
        b=J2VeJRrq4QeTGLhqduLKKpPYNFIVJ1hSA4x7Ci+XBnEaRF7nURA1aUA8YzyEeXZ5an
         GgIoSwcqy1CveFpTiLoPXNPw6XgPfpvozrMcb4vQH9u+rXKkx6ogIunkn8TS+9+GW4fW
         L4SIs96yCerq6CSVTJx8i1i61KHMVFoIigbAgdUOnShq077O5s2b6lRhgt3sqZoyVuCD
         5aeH9osT6GL1Um78TWLRf76kJOJ+EXGHdSV9TNEVfJwrhZlXeeeYhcSXn9GEwaobGwS/
         DsMvlGwXiiqXAMt1VC9S4GHR295h95eAOfHN3N8TLDa5cSLlr0fDswn/alERl9W2yLIA
         RkcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792423877; x=1793028677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vH8K0tY0TTIHvq5G2+R9r502vTAhxsKA0mwhegsYO5c=;
        b=UPpsJuHEPgv0ykjk6AgT2el3DqaUNvZ/ii74oL+fkA0VD4d6rEpTHFBb9Yd2m17Pyk
         NvgNWaGKTGRoSixKO+UmU1+kAex4grt/wH3hvHULqXf7DFv+QmNGEbYbvyJcIalXdOvH
         yU30rRb0q2rl7ASvSqCML4e4l9cJu0nDIwGfTjClRgIC22QiuYccXCQKX4tiRGQdVIhy
         DjyGSWl2fi5FdquSZMtl61xJv+z9ody6d+qyeeuXf73LgoJidyI7/CNBKnxw/J3Diear
         C9cFn7Eiav5vWJYbS6Bs08c29j4r4R9cj4DGj8Rq0kKo8ZDI7VusqfvvVCfNBY8+UIaa
         vxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423877; x=1793028677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vH8K0tY0TTIHvq5G2+R9r502vTAhxsKA0mwhegsYO5c=;
        b=PKEGhvlbH0UR77QzGuinoSwIfS0YEYLDDCiDPup5KGZGQDbBsh95IDl4RZz/vHscgS
         LUu0AAt7aMpBdT2PTKwx9zTqXhVLw3GGLwssTL0zRbf7rTfIqGzLtwOClCZ/TJPzPv7R
         54ikxs0ZPd58TtqqJ717d4QOJUxuqpbF7DUyYwZawHFoqgM9n1BVGHe8TVnF6uS57kCU
         YXVsGtCptoXs++o6WFO7iLupy4Y/fqYhOoKcFyp/nSmR/hMIjtOYreCwGMCbGfakdmZE
         /H3JGEhmb0IyMzA7gMCae0/ktSnM7nIp/gLOlfsjLglShW0z3SpSu+s040y46cOZg0lg
         tZrg==
X-Forwarded-Encrypted: i=1; AKwUvBx9vQEvyfdNdeNRiU6+kZHVF2mqdrtBJGewbFQrYIJ6SFSy1PkSt13ot9jgbTl82df3fN8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXKkxQS4UO5xd8W/euoayKE5NDLhFT9Fu/0apY28jFS6Tkkbtg
	NlZFbGMo+v6bniSDgGL4f/g4o7XhAmx8+piQiS6so7eMsuMJQ0vtM9va2+lH0Z+lBAAzBc92gmo
	FPvjcQDo5EMHyHVkGwWR8+5np1wL2RWzs4jzkyW0X
X-Gm-Gg: AYBFou2GXcF1C7gGDeiA+eRf8C8nb4QUSyXvxPbCWEdi5BjLruxm+zJm9weFDua4Z+C
	6OjTAdp1OyDPhEfsYtBHg9LPzzK6e6s8oLw1WY78WjUDlvKcvW3KCSIl4V3XrPC8lFyk6A1Berd
	+gfnxUOY+5F/iRqRlGTr5zO0CpDgo8Po9KImVykUVHqV5WV38c0pyK8CjdIGDjlz3TrIta8eRWE
	+nDQTQ/iMhxw4CgZm5/yjGX/0AcF26DKrcdi15QFzWqcsLNFgEDqSetgyH5wjKUQYyJ+YVTW6S3
	1CHrX/DEagFGm+ip8BckkK4RHGutjlks8K9nN6qw6BH1IKCuvEuLQ/jk4BwRNQjIWd1TMpQiCcb
	OINj4ZHJ+d198O3FgvHeedKkSkH5wrHkvgykCy8U/KL+W
X-Received: by 2002:a05:622a:aad1:10b0:533:9746:9a86 with SMTP id
 d75a77b69052e-536499e8967mr30482911cf.5.1792423876418; Mon, 19 Oct 2026
 08:31:16 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com> <20261018211514.2817293-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20261018211514.2817293-3-chia-yu.chang@nokia-bell-labs.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 19 Oct 2026 11:30:58 -0400
X-Gm-Features: AclHuK_qCj8A5BQKckfNFBVvGNcKwP79HUqCKtNoolioGZCyxzrnsutbLK1QZbo
Message-ID: <CADVnQykcesPYsRFmZGRJm93knNbPnWf81s6qu30g8Et-rYjsYg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] tcp: ECT_1_ESTABLISH identifier for CA
To: chia-yu.chang@nokia-bell-labs.com
Cc: ihor.solodrai@linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, horms@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, stephen@networkplumber.org, davem@davemloft.net, 
	edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	kuniyu@google.com, ij@kernel.org, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, Mike_Rudolph@comcast.com, 
	Jeff_Howe@comcast.com, srichard@netapp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 5:15=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> When connection is initialized after ECN negotiation, this patch
> enables CA to control whether ECT(0) or ECT(1) should be used.

AFAICT this should be "When congestion control is initialized" rather
than 'When connection is initialized".

> A new identiifer (TCP_CONG_ECT_1_ESTABLISH) defines the expected
> ECT value in the IP header.

Using "expected" here is not as clear as it could be. It sounds like
the expected incoming value rather than a value that the CC algorithm
is specifying should be sent.

Also, the name TCP_CONG_ECT_1_ESTABLISH is quite verbose, and not 100%
accurate AFAICT, since it is used in tcp_ecn_send(), which is called
when the SYN bit is not set, which can be in a number of TCP states
other than ESTABLISHED.

I would suggest calling this something shorter and more clear and
correct, like TCP_ECN_SEND_ECT_1.

Putting that all together, how about something like:

"""
This patch introduces the new TCP_ECN_SEND_ECT_1 bit, which enables a
congestion control module to control whether the connection transmits
using ECT(1) (if the bit is set) or ECT(0) (otherwise), when
congestion control is initialized after ECN negotiation. A congestion
control module, such as the upcoming TCP Prague using L4S ECN, can set
this new TCP_ECN_SEND_ECT_1  bit if it wants to send the ECT(1) code
point in outgoing IP headers.
"""

> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp.h     | 1 +
>  include/net/tcp_ecn.h | 6 ++++++
>  net/ipv4/tcp_cong.c   | 4 +++-
>  net/ipv4/tcp_output.c | 2 +-
>  4 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 1838389a9d8a..b9def462479d 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -428,6 +428,7 @@ static inline void tcp_dec_quickack_mode(struct sock =
*sk)
>  #define        TCP_ECN_DEMAND_CWR      BIT(2)
>  #define        TCP_ECN_SEEN            BIT(3)
>  #define        TCP_ECN_MODE_ACCECN     BIT(4)
> +#define        TCP_ECN_ECT_1_ESTABLISH BIT(5)
>
>  #define        TCP_ECN_DISABLED        0
>  #define        TCP_ECN_MODE_PENDING    (TCP_ECN_MODE_RFC3168 | TCP_ECN_M=
ODE_ACCECN)
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 865d5c5a7718..210ec63538f8 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -38,6 +38,12 @@ static inline void INET_ECN_xmit_ect_1_negotiation(str=
uct sock *sk)
>         __INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
>  }
>
> +/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_ESTABLISH flag =
*/
> +static inline void INET_ECN_xmit_ect_1_establish(struct sock *sk)
> +{
> +       __INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_ECT_1_ESTABLI=
SH);
> +}

This function name is quite verbose, and a little confusing, since it
may or may not set the ECT code point to ECT(1). I realize the name is
chosen to be consistent with INET_ECN_xmit_ect_1_negotiation(). But
that one is confusing in the same way. :-)

Also, using "establish" in this way sounds like a verb, making it
sound like this function is establishing something.

How about something like:

(1) a new preceding patch in the series can rename
INET_ECN_xmit_ect_1_negotiation() to INET_ECN_xmit_negotiation_ect()
(2) this patch can rename its INET_ECN_xmit_ect_1_establish to
INET_ECN_xmit_established_ect()

Thanks for the patch!

neal
