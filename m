Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003148BD59
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007489; cv=pass; b=uttTwmQbyswTaPjpiNMXIiTwPCeDx0lckNSgADrNPlpc/hx6plsWUVNJbSnvEvTWAwLVG05AFpBjNPGyhlPVQlR3nK7jgbsh5Rn+JNiHREfB1vjbIb41PpFDTSEdlKBuqa1Ov6KJlLSVMM1Uq3cVR2x5vFhFhVqCptCErzG19go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007489; c=relaxed/simple;
	bh=pXnTl94BbhB/76UcLMWFQmfo8hdhUhMeAxYtkkN1M+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLr2p9fX/mES7UrbNOUXfEIg4VVeocCx2KwkX58tmN5URaWrsVITnyBO72BwF3Updt/bDCbopKtq3kjGFy8zUy6N491HT/IB5ZQoWLENWCNmKYE1wN1BmiGz1UhyPLr9BOZUcIo6QzYWlz/QuHdsFhr7iyOonk3ieyqjwEkJPh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjExIxLc; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjExIxLc"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014d4ddb54so71410241cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 06:58:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007486; cv=none;
        d=google.com; s=arc-20240605;
        b=NGUYhfJEjQNSeNtfjlRlvAbWBJiUoGVsuzpRzZoBQQZx0Bse1pc8kk/pCez+QBgZTT
         e/akz2RyOVyiw+or0PkGPEugiJkBTmRYXKCMz25snIhdMWkOztF4hQkg0kvgxWaL/Tt2
         Bdn7bffZRr2yfauYnL+Bn+Y5Veaxc43G8+8Hsoa/WOytfbH2q76ufl45VcpJSJAUgbTK
         ZIzdTiPFIpOTRhdJH5kzc86hwQiQupkOYZ0u5JjOXCNkqnw9LutWPMqtrXY3lINGVN5x
         kEqfQByqhH4GyExTPxdEG5ow0Mp7CU+ZzR4Zxj5zKKVtApQsLdVBIkMLNf6xxFbt2Nnb
         Sngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F/VqqIhXdgX7j/dXUyWw4LxUrc07WTrCM45z7FHNuOc=;
        fh=oyhpgn1tEl18eMfdcKAYZzt3UYyvvL3HcSvbnG8aKwk=;
        b=CjnP49Ryl/pz+omYXdOLRUUkcYIaCln9aP1xKR90/4ZHjbEDEkSP3lD/oewv3UwiiV
         3sOMTw0xAAKk3VpjWMDlz2/WiTzWmabemEj5SeTCUItbceJ2pBk/RH76ePW9daoUvEXF
         ujrc/NqGuqUHOsQsjiw1o+4gaSn7jepZTVZ4WMk6Ny1T8GFG6XI118ZM/DM6ZM4eeXdz
         moZqdMeexlp5NG8TChVSAOrbZLb/Uq8KtIB60x1bTbW9Zg84fZ6gmmpCUGKZ569NFBdv
         hICYEaq/XN1Usz4nwG3GTjWymlhIJuub5+MzLUp04a3kAfSZzU+opsKtF+WUCLTT5J0p
         wVCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769007486; x=1769612286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/VqqIhXdgX7j/dXUyWw4LxUrc07WTrCM45z7FHNuOc=;
        b=ZjExIxLc2LNqlP24QAI+e6v0pZxcrEgpu+95SusdGyi51+bDN1XnBwncQP1b0ZlZUy
         HQH1KhN4CzuV41ctbFYWvDmZ4TWXX4kHgXU3DH1EIUgxX2Ud+34hG2A55SeTLmqKw9c1
         xnSA+aOQIIPWSvVGNDVLVmsIFwOFlyKyj7G9UJgbULURinDg1hgwAFme6ZzFNbfz4Ef9
         54O0ojMRsFrIZOCsXVmWH/wmVupVjp+L05gNkjOHsl73Nf7cDtHXpqZYLIov2KCctP8m
         kzLCuiZIAzeZo0n+Zh+KLbGphBEyzIwMC/HNlRnPyKtj39Cv/lnT0vaOOZapIHLFhZtU
         Jm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007486; x=1769612286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/VqqIhXdgX7j/dXUyWw4LxUrc07WTrCM45z7FHNuOc=;
        b=jCgLr7OQimUdp3yTqbkQWFyMLDXXqRxUSWIxtC3VD6/fJ7v0xuK6MAEuq9y6s9DZDD
         LNVNzKKbBXWqOAyLhSK8nWX2XJzXrmJ8WmV80j0m/pEbDjsNMj76XPxNYI+LDSEk381G
         TES7P0N1pS/ty4shNOhn7OtfmVRgKW82JjEpKEs8xxbL7Z/q8GTWojqWDgMXUNydPQkf
         JfudfUjx7IDA2ilFcmDxqL1iyLCkI5cMQpWvMwXHgVBbWpIuL5TYsfqmAKqjBWxoXGRs
         kzgGb7wwqu3x/Cd44yiqUfgifZfQ+cXW8/lFF1WDZDcVm0rufTPmgsseAF0bO71kHILg
         lxmw==
X-Forwarded-Encrypted: i=1; AJvYcCVuPN6pAlsyUSpeVyzEARX8gdGGA+CHO733hfOgxre0jAkRJum1icEvvgsIYJ5iMqUpvPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirgKB93oTRb5A51gnrUbdyhlyQShD8psSfX8VyZIl8aLdK2EG
	5sD7ai2XZXJ3a+PctpfKNbhnWeaNRqHx092xZanuQcAP9x4FYG+2Iqy/h12vUIO+bqcnbbOdcsD
	7tLQmTEKPh8H3f2MebvT/mmAhGehu2BTdbhMwzg60
X-Gm-Gg: AZuq6aJP7+EKtI/W2l27WXto7bYYszHKjxfoqxbpYwMuovDJhjX4f4dDCqFNofJqmCs
	6I2ErVvRIzyyI+NR5K/8OGMIg/3PQi+KInW2gwgZYIkFCkz+Uljd5tasLwINgtRf8qIo4xeJYDC
	y7OF8zgtgJHz4fsC7C+xy7UViNGrGAlXkv0PXiiSXQVRJYmcLlmdWY6sr/K1W4YsW4BbEJN0JDZ
	5ZY/mQ4mt7wPgCa5fMLaq5HxrzytL9r8WK2/LgB5BexS6MqO/go8P8ghh8MJS7C03IXJ3o=
X-Received: by 2002:a05:622a:1b8d:b0:502:a026:3157 with SMTP id
 d75a77b69052e-502a1757181mr221595791cf.41.1769007486020; Wed, 21 Jan 2026
 06:58:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-14-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-14-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:57:53 +0100
X-Gm-Features: AZwV_Qj20kr6mRoNXbwQWdkosCn3zjOMui9Vi7kFMCTUHw3XP2Q1RPMTHZwkrjA
Message-ID: <CANn89iK3DOU4DX4=S-C7cKy-57DemUjToYVpYMT926mjFmyajg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
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

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
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
> ---
>

 +
>  struct tcp_info {
>         __u8    tcpi_state;
>         __u8    tcpi_ca_state;
> @@ -316,15 +334,17 @@ struct tcp_info {
>                                          * in milliseconds, including any
>                                          * unfinished recovery.
>                                          */
> -       __u32   tcpi_received_ce;    /* # of CE marks received */
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
> +       __u32   tcpi_ecn_mode:2,
> +               tcpi_accecn_opt_seen:2,
> +               tcpi_accecn_fail_mode:4,
> +               tcpi_options2:24;
>  };

I guess this is fine, iproute2 got no support yet for
tcpi_accecn_fail_mode / tcpi_accecn_opt_seen

Reviewed-by: Eric Dumazet <edumazet@google.com>

BTW, are you planning to patch iproute2 misc/ss soon ?
