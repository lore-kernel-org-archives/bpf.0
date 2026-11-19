Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050992;
	b=Z7i4F0nvVymEQAP+OfdOG2FYz2bxyvvVWSIF53YJW+SE8FSUIHHyfW7+02Q+gUmqTIHs
	 Wbdc8yzoE825iwS8fSXDXO3ROgsJweFWlUOlimC+jGboOeNEViE7oiGPjVn4X9ipAHWJA
	 GwXWV+dAjevQ66GHUrnBUVDVhVUQmKOIGK2tvCwTqNT5YQIupRTvX7PerxIpVWLzAlmb8
	 FNgNMbzXGzWu0KCxLgvK4NhvpnOZFVHauaoPfhFqr+ib7U4VOBtEuzF/6FRQjXtbD3jPQ
	 Pd+uWAm8GrJO7cAyJcQB0b0/YANeV2S8bLK0cuwBVL5OEZUiSlECCC/VYciA8DEbzkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To;
	bh=9GD/UNHBWrOUFrMAE4LOfnoLY5uKQdUtivTrlJSCxsA=;
	b=PtK927Uj1dPnfptWRQZr4zSXbbox4pZjdRJOxY/hVyLuSjm2U1qxez/q0D9RVsFK1oJc
	 5/54Ccl4K2LtlsCX5VW+5XtbijwI0GHEXNi0uXx73xU9sdi9om6LboswXMCXrhpbL9G+7
	 Be5BE5n3nK78dtwvOQraGhj0zVaiRpA7t7+Llc+6j0RAAyen+oHkiC3ZVQwQUvjWP6gqw
	 Ydm5iknv7Pob5zXepIyCtCSWUKniqNebypjngx79yLMqe6jNlxyISQMFMtsbKdetxGpBY
	 y7wicY0qccIbmx2iiZ8qalqozHuT7XwW6F7SVbFem1kaMKcYcCITMqdYh5mIKe8GLhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1PmIEFf;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86197606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86197606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1PmIEFf
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3bf3bef9aso1601942a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795050991; x=1795655791; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9GD/UNHBWrOUFrMAE4LOfnoLY5uKQdUtivTrlJSCxsA=;
        b=h1PmIEFfgFgvcdYCELklSygeCh82nQRnbcx+1KUk+Opo6Szk33dVhS8DgC7XRBJnof
         95YBBBMJ5G1hu7vny2tbV31PKak3z/3lQISPHaN+61fjoia76dmC8a2cLEMDoldl0ZNH
         NCCXFtHYKK31vSdyHqIV7gMDnESt+ICH+WW3FwzY7fCn34aaKWgF+awXuBPxf/8Ot4CW
         Z/ZskErk8cYOUBuyZBZ/Ezy9fJ8+4wM54aoutREyvRWX76Dfx+DCEPWCuNts1ZlyO7KQ
         6KRDzVJ/rw/sxsl+3G7yqv1MsvIhKW92O2EY19BC19GDWgf/RKEO7uNINNu2Dy3K4zR5
         PZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795050991; x=1795655791;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9GD/UNHBWrOUFrMAE4LOfnoLY5uKQdUtivTrlJSCxsA=;
        b=KGLsB2JjoIBQU9Pvn8xNLluKpBn3ryCwF+lNM9zKa5WeAKz1JFmeS1R4iAU5to8AX1
         bSHU+VV6e2c+E4Lv0ElBgqC0tQfoJorqN6MCTCvf/e4QghZI4vIpmTqscY7O/vX3k4L1
         4q6gxgSVWF+SWNY3H5WXOfcTVzoMAwP8+1Wvjato2z2wNYJugStssyJOhK3M62XGKmZf
         b28MuwE4YS8QtjBjnNMTBAnuw17jBEw0xiqHA9iQRK2hbf9wO8Pl9g+QsbSyok+f0R9B
         UgFA90hXnd4/RigxPeQ+qBo+aOqQia38c3/wb+D/xH+DaWAkmtqr528GTR5jlxSrI6sj
         8BwA==
X-Gm-Message-State: APuU4Z/Y+ZX2YEuR+6SmB4hRtEANhBVFotQNSnSox5oAFGJYKvcWhlqS
	Lt/IqY+tNCw0OAejtYvYK/IAWGBpIAPirj8A/wQk7sbuQpyDa6TxrI7i
X-Gm-Gg: AZFdTZcbqY6Ha5vsENRH6JP/ztrpEHJEYA7wRAyZZkdi2VqWfeNxgL4x73c6d+1R3Md
	X7EccRNYj5BL70SsXX1migbMkPG4rHzOEeq0LZf8DAc0a/ofIDpIV4I2HlUhKUoRYTrI/FSQW2Z
	AgFwee0oaLxgWhNrihAfdaH3bXX9TGNO/wfBj260UbwiXxGZvLjTpZuiSP6putYUq/Hjr+P9bwi
	dRAtaXK1oC1B9pH7ydMRfvvv1bG4nB/nJQetnXXBfXovk8j35XV8ObQj0DGQ+ZdS+m1C3t3zzV1
	eMcyMpG1NeHgbDmyv+HWo/40Q96ozVErD9IljKBR331Xcgpk36s2ryGGPr70H5RYHfjJ3OmoiD+
	tIw5mq5IUvDd8PfoEY9m5vw18kZM3+7xbs92T4y4GoswrfrOVssaW5Hz4CCKy/ANphsO4HYG94A
	135vi0zcG/WqbmZaOuWbxNgMpRw7lsx1SQv+R3+P0CaaRePhGyoOrVAyskhtLSAdeC1aAB1lPSZ
	Hpgzns2LUKaJTtrEuocxvQBhic6JkJ9UWxTnIMoGtg3klFqNxPmkRfx9w6jmADWqNLYLNLPkrIL
	RhmZSjt0BlFLVCuWTrNEdSG3ryk+Ijzyh5HnQzU/hBpMy5aUPECwuz5eX+rORe6BcthN0PtyIwX
	3bZ+uYkP2YYBzl45jxcLn8CkRvBhhKR+34z/uS8qZTpjjaLVCrqYqavE=
X-Received: by 2002:a17:90b:4488:b0:3b1:96fe:f5d2 with SMTP id 98e67ed59e1d1-3b3d082c2admr4689543a91.65.1795050990735;
        Wed, 18 Nov 2026 17:16:30 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fe0b6fcfsm641546a91.12.2026.11.18.17.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:16:30 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:16:30 +0000
Message-Id: <DMYSGWL8247Y.DQAGO9I6EPK3@gmail.com>
Subject: Re: [PATCH v2] net: sock_reuseport: check program type on the
 migration path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, <netdev@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, <edumazet@kernel.org>, <kuniyu@google.com>,
 <pabeni@redhat.com>, <willemb@google.com>, <davem@davemloft.net>,
 <kuba@kernel.org>, <horms@kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261118153541.172499-1-shlomojune6@gmail.com>
In-Reply-To: <20261118153541.172499-1-shlomojune6@gmail.com>

On Wed Nov 18, 2026 at 3:35 PM UTC, Shihuang Liu wrote:
> A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
> expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
> attached to a SO_REUSEPORT TCP group.  Closing a listener that still
> has queued children then runs it with a struct sk_reuseport_kern
> context even though it was verified against struct sk_buff, which
> KASAN reports as a stack-out-of-bounds in ___bpf_prog_run().
> Reaching this without CAP_BPF requires
> kernel.unprivileged_bpf_disabled=3D0; with
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=3Dy, the Kconfig default, the sysctl
> starts at 2.
>
> reuseport_migrate_sock() decides from prog->expected_attach_type
> alone, a field user space sets that does not identify the program
> type.  Require BPF_PROG_TYPE_SK_REUSEPORT there and in
> reuseport_stop_listen_sock(); socket filters still work as
> selectors, so the selection path is unchanged.
>
> Fixes: d5e4ddaeb6ab ("bpf: Support socket migration by eBPF.")
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
> Changes in v2:
> - Fix the author identity in From: and Signed-off-by:.
> - Mention the kernel.unprivileged_bpf_disabled dependency.
>
> v1: https://lore.kernel.org/all/20261115152408.48205-1-shlomojune6@gmail.=
com/
>
>  net/core/sock_reuseport.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index fccbdd0430b059..9ab76697a794fc 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -460,6 +460,18 @@ void reuseport_detach_sock(struct sock *sk)
>  }
>  EXPORT_SYMBOL(reuseport_detach_sock);
> =20
> +/*
> + * Only a BPF_PROG_TYPE_SK_REUSEPORT program is verified against
> + * struct sk_reuseport_kern, which is the context bpf_run_sk_reuseport()
> + * passes to it.  expected_attach_type is set by user space and does not
> + * identify the program type.
> + */
> +static bool reuseport_is_migration_prog(const struct bpf_prog *prog)
> +{
> +	return prog && prog->type =3D=3D BPF_PROG_TYPE_SK_REUSEPORT &&
> +	       prog->expected_attach_type =3D=3D BPF_SK_REUSEPORT_SELECT_OR_MIG=
RATE;
> +}
> +
>  void reuseport_stop_listen_sock(struct sock *sk)
>  {
>  	if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
> @@ -474,7 +486,7 @@ void reuseport_stop_listen_sock(struct sock *sk)
>  						 lockdep_is_held(&reuseport_lock));
> =20
>  		if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_migrate_req) ||
> -		    (prog && prog->expected_attach_type =3D=3D BPF_SK_REUSEPORT_SELECT=
_OR_MIGRATE)) {
> +		    reuseport_is_migration_prog(prog)) {
>  			/* Migration capable, move sk from the listening section
>  			 * to the closed section.
>  			 */
> @@ -644,7 +656,7 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
> =20
>  	hash =3D migrating_sk->sk_hash;
>  	prog =3D rcu_dereference(reuse->prog);
> -	if (!prog || prog->expected_attach_type !=3D BPF_SK_REUSEPORT_SELECT_OR=
_MIGRATE) {
> +	if (!reuseport_is_migration_prog(prog)) {

Looks fine.
Which tree should it go to?

netdev folks, opinion?
I'm fine whichever way.

