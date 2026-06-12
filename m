Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FD3769EA
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252544; cv=pass; b=I+53fIvB3Z05wxJIf5cH8dQG5WsDAx0DX+6Z8jUYy0fEnx7LPyg9F1NbXgGe4Pd2IboNkCxfVNOMzFYkR/pgm6w+EDNa/Kun+9sdVVDs7CJdYneCIn/JO5b6acOY1JdRK7yl3ruN4f/dU1sNa3TwvxsHIONNQ6aKPCVF/PLhAMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252544; c=relaxed/simple;
	bh=aZ2msG6bBpRSdvBS/f6pbbPMHjxvTzTeADXUE0xMIaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWEBpjZT6IU7a+vttBlhWbOZWeP5itR/HstO78LcpOW44ajEFhA5i9KtbcRW3IRtoaRm5I4D56ZUzqWz/u04sSoTSrZZGyM3BVsmbZK45TIDJMgHHgRHgN8twNq4u4cPB3MRr+QS49AUXR7xatJUmhmrjgeOOWYrUr5PuxqykVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cn/AYVRo; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cn/AYVRo"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9156b74006aso48429785a.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781252539; cv=none;
        d=google.com; s=arc-20240605;
        b=QzHyQuIhMCCilWfJ2PMfbQ9ZRQTil1cvuyibe6niXes71bLmD0eFUYdIa0hHZR+y6u
         rfEZEgD1Xq3o0Ov0X8u/LKoSrbcYdLwSpFkx1V+3CnHbzrKKJfctPk++F3FVO+TM68RP
         Q12yS+3UKG7RymrYuqt2QUCRNg7gdLH4yLXOaln1B83SQKMtXj1+dskFM2ze0URCOBGP
         g/5OkDdHyaPRu1VJcWVkPt45HOSGJsR+q3WpXMHAyIJ8ylYHuHBgTxkxci6flWxx3vE+
         G7iEp8fx1Q9NA3qGzN18bTUDI8tZmC/3CC1/IboRi0zdQSxPf+3Pq/HNvQUfKoUJ9tod
         EuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZ2msG6bBpRSdvBS/f6pbbPMHjxvTzTeADXUE0xMIaM=;
        fh=b/we2ND83hZkpPhzuymmXGT03A70muhEY/fFUY2TDzc=;
        b=ElM9XAqk57whrRKP3Ho/rLIKjP875doky6TrpDeZXjHsqeBSMFZXnpBfeckmdT6Nrs
         RMwVtpGTN1OUVemb/5etsVAyMxDvQmTrib/+/hngqqFvBaYyPBtG5vtCtm+SrYbMLF3r
         8F8UOt/jmnReVzI7YRZo26zRdRwnjNhTD8r+Sx6DNIirPt3GRYsuxbopMV1Wpl5w16FO
         xLbBA1UUmhr8xYwIcm95AXRM+Gr/AL05VBtAMUs52Oqt/lTegVtKx9MlE+c+DwFLvu7e
         YUJ1xu2PRnDziL3sW9X9wLjmcEodc/41F6Pn1xm5GV8BZ47jGrmcsl19g2OO3Eu8N3Kl
         pTvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781252539; x=1781857339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ2msG6bBpRSdvBS/f6pbbPMHjxvTzTeADXUE0xMIaM=;
        b=Cn/AYVRoyh21E7qSI9pna3+8YvVMq0CtYosp2X39DW2zGHHScw1Vodgsf4CBMcaXzJ
         aTm15rAaL3/rElU9cuuElIDNezSD/va+VNekszVeml5wun8ZP1+B7qawRISlnAuYupu9
         gkqOFNjCjbkCKxIxg7q9UWMFV3P0zRNBEBQz1dHizV4zaQifIjOhiDdGSq9PE/A5OAy6
         y7OBRSGTm8DW9eCU4iUHZo83hXCVAZMZPs2C9ziAUdzZgXbS/Ge+3B8OlaOyDPZDqo95
         by1TZqtSaZv/Ebntu4BpQ+vCOrDwkfq+nKW+oqZLMy33Xvlabl7nwOqKGvhUVPVX1r7C
         YLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252539; x=1781857339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZ2msG6bBpRSdvBS/f6pbbPMHjxvTzTeADXUE0xMIaM=;
        b=eZnfoAitGzSdNRoEuqfmAm8I/EYHWTxG2315OHTt2+T4RXY02VAW0Bi9OZWR8X087W
         oMocAJOsNz4khcUpXTar4MX/S7H5zQpody7KeQzhLBVv1Ygj+3Uu8Cym/L6lMgjwMerr
         VZPVERFch/p9UGQM77HH0eCbDcqoD6MTE643wFv1IWRLR+Tcrn18h/20k4pzFtj/F7Mw
         9s40LZlYZkJcuRDN4P81bDMbcQQOrBfBTSLU1rpJokxjFNIcMnBkSOttSNWtPMVG+0Iz
         myDblefhsa71gt2NYi3bDjuTXwa1yyrfbsqjBRFUQO70gUMXXBLQ43Zid1y4ge9RPwAh
         oIEw==
X-Forwarded-Encrypted: i=1; AFNElJ+IL3fPpTHZFxRsgYG/YB4RCr5F/zBfsuoG8sXwELDe1r8+eN1InO7I8L+GzQR9F13QFgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtfy7LkZn5B8xbM+L90FmdedcM3A859LgSe2PgD3jiM8gti13F
	UzVTf0Jn9tpc+G/vZEt009zWgtko3Nrz5p9cJOIpmvwUD6xoD1OoT/O4v4UzY1qbCY9IRMLvMb6
	ZpTLuPcv6ZIW+5pPz6bmswjYA9v5cjUfwaQSXlptK
X-Gm-Gg: Acq92OGBqqbQSNKE0d+LpQSComvGq0SB1C0t8abc/xmeDSHa+frtsdxnBT66yM2XFmb
	MCSh1vjcD2G6EDXFE6jHbhK2CuqqPCMFZBkX/gd9wOCud8onByc5nJmSetVbpx2ISE0D7mijQdW
	XoRyyWhlZmE35ktm6mIIXTL0nB/0/bIGWwoy3jexTvTUCKWx9ziL6uJeMomrxPabZx2K6SGBkYF
	TALPGB9XcEbb72IrqkPF2gVuJQkZjGhlVrvhR9T/nsVquvnaTfq4JUTeXDfaqLGzHl0nDCHRF8s
	4BvDHBAPFyFqVAyYd++HT2bF2Y3X8wbXO9AR3mWN7JLzMyTY4sD2HvtTTjZoylh/6RD6E/tuIju
	uE04qz0ZgoqXLjXvfeliUrvCYzZMN8w==
X-Received: by 2002:a05:620a:414c:b0:902:5778:d312 with SMTP id
 af79cd13be357-9161bac73d0mr204971085a.12.1781252538914; Fri, 12 Jun 2026
 01:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jun 2026 01:22:07 -0700
X-Gm-Features: AVVi8CdYqSuoQH3pk2Lv3uigV13KDhOSb_2-LFWlIyooPmjFJdH8rcCzSzQ1a9U
Message-ID: <CANn89iK4Df+F-Q0AS=QR5LQz7JziM-9F1vS+U7YMMvW=FzaOCQ@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: clear sock_ops cb flags before force-closing
 a child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:29=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com> =
wrote:
>
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state(=
)
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me()=
:

...

Reviewed-by: Eric Dumazet <edumazet@google.com>
